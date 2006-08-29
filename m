Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWH2WZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWH2WZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965440AbWH2WZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 18:25:38 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:43753 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S965029AbWH2WZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 18:25:38 -0400
Date: Tue, 29 Aug 2006 15:15:18 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system calls support
Message-ID: <20060829221518.GS22011@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85tfm000384@frankl.hpl.hp.com> <20060823151439.a44aa13f.akpm@osdl.org> <20060829165957.GN22011@frankl.hpl.hp.com> <20060829102627.1fee475b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829102627.1fee475b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 10:26:27AM -0700, Andrew Morton wrote:
> On Tue, 29 Aug 2006 09:59:57 -0700
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > > > +
> > > > +		PFM_DBG("going wait_inactive for [%d] state=%ld flags=0x%lx",
> > > > +			task->pid,
> > > > +			task->state,
> > > > +			local_flags);
> > > > +
> > > > +		spin_unlock_irqrestore(&ctx->lock, local_flags);
> > > > +
> > > > +		wait_task_inactive(task);
> > > > +
> > > > +		spin_lock_irqsave(&ctx->lock, new_flags);
> > > 
> > > This sort of thing..
> > 
> > We need to wait until the task is effectively off the CPU, i.e., with its
> > machine state (incl PMU) saved. When we come back we re-run the series of tests.
> > This applies only to per-thread, therefore it is not affected by smp_processor_id().
> > 
> 
> Generally, if a reviewer asks a question and the developer answers that
> question, this is a sign that a code comment is needed.  Because others are
> likely to ask themselves the same question ;)

Understood. I have added a comment about what is going there.

Now, I don't particularly like what we have to do here. You may have a better
solution to my problem:
	- how inside the kernel, can I make sure a thread is stopped and off any CPU?

	- if the thread is not stopped, how do I go about forcing it to stop and how
	  can I get notified when it is eventually off any CPU?

	- how do I make sure it cannot wake up until I am done with it?

> > > 
> > > When copying a struct from kernel to userspace we must beware of
> > > compiler-inserted padding.  Because that can cause the kernel to leak
> > > a few bytes of uninitialised kernel memory.
> > 
> > We are copying out exactly the same amount of data that was passed in.
> > 
> > Are you suggesting that copy_from/copy_to may copy more data?
> 
> No, that's OK.  I was pointing out the problem in situations like this:
> 
> struct foo {
> 	u32 a;
> 	u64 b;
> };
> 
> {
> 	struct foo f;
> 
> 	f.a = 0;
> 	f.b = 0;
> 	copy_to_user(p, &f, sizeof(f));
> }
> 
> which exposes kernel memory.  As you appear to be confident that the
> perfmon code can't do this, all is OK.

Ok, now I understand. I don't think I have that but I will write a test program
and run on all architectures to ensure this is indeed the case.

> 

-- 

-Stephane
