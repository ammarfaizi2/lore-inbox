Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWH2Rcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWH2Rcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWH2Rcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:32:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965168AbWH2Rcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:32:53 -0400
Date: Tue, 29 Aug 2006 10:26:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/18] 2.6.17.9 perfmon2 patch for review: new system
 calls support
Message-Id: <20060829102627.1fee475b.akpm@osdl.org>
In-Reply-To: <20060829165957.GN22011@frankl.hpl.hp.com>
References: <200608230805.k7N85tfm000384@frankl.hpl.hp.com>
	<20060823151439.a44aa13f.akpm@osdl.org>
	<20060829165957.GN22011@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 09:59:57 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> > > +
> > > +		PFM_DBG("going wait_inactive for [%d] state=%ld flags=0x%lx",
> > > +			task->pid,
> > > +			task->state,
> > > +			local_flags);
> > > +
> > > +		spin_unlock_irqrestore(&ctx->lock, local_flags);
> > > +
> > > +		wait_task_inactive(task);
> > > +
> > > +		spin_lock_irqsave(&ctx->lock, new_flags);
> > 
> > This sort of thing..
> 
> We need to wait until the task is effectively off the CPU, i.e., with its
> machine state (incl PMU) saved. When we come back we re-run the series of tests.
> This applies only to per-thread, therefore it is not affected by smp_processor_id().
> 

Generally, if a reviewer asks a question and the developer answers that
question, this is a sign that a code comment is needed.  Because others are
likely to ask themselves the same question ;)

> 
> ..
>
> > 
> > When copying a struct from kernel to userspace we must beware of
> > compiler-inserted padding.  Because that can cause the kernel to leak
> > a few bytes of uninitialised kernel memory.
> 
> We are copying out exactly the same amount of data that was passed in.
> 
> Are you suggesting that copy_from/copy_to may copy more data?

No, that's OK.  I was pointing out the problem in situations like this:

struct foo {
	u32 a;
	u64 b;
};

{
	struct foo f;

	f.a = 0;
	f.b = 0;
	copy_to_user(p, &f, sizeof(f));
}

which exposes kernel memory.  As you appear to be confident that the
perfmon code can't do this, all is OK.


