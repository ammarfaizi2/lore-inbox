Return-Path: <linux-kernel-owner+w=401wt.eu-S1422853AbWLUIZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWLUIZF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWLUIZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:25:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48305 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422853AbWLUIZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:25:03 -0500
Date: Thu, 21 Dec 2006 00:17:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: <linux-aio@kvack.org>, "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] aio: fix buggy put_ioctx call in aio_complete
Message-Id: <20061221001756.84c8fa7f.akpm@osdl.org>
In-Reply-To: <000001c724d5$d708ca60$1b80030a@amr.corp.intel.com>
References: <20061220200535.211a3dda.akpm@osdl.org>
	<000001c724d5$d708ca60$1b80030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 23:58:43 -0800
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Andrew Morton wrote on Wednesday, December 20, 2006 8:06 PM
> > On Tue, 19 Dec 2006 13:49:18 -0800
> > "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> > > Regarding to a bug report on:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2
> > > 
> > > flush_workqueue() is not allowed to be called in the softirq context.
> > > However, aio_complete() called from I/O interrupt can potentially call
> > > put_ioctx with last ref count on ioctx and trigger a bug warning.  It
> > > is simply incorrect to perform ioctx freeing from aio_complete.
> > > 
> > > This patch removes all duplicate ref counting for each kiocb as
> > > reqs_active already used as a request ref count for each active ioctx.
> > > This also ensures that buggy call to flush_workqueue() in softirq
> > > context is eliminated. wait_for_all_aios currently will wait on last
> > > active kiocb.  However, it is racy.  This patch also tighten it up
> > > by utilizing rcu synchronization mechanism to ensure no further
> > > reference to ioctx before put_ioctx function is run.
> > 
> > hrm, maybe.  Does this count as "abuse of the RCU interfaces".  Or "reuse"?
> 
> Yeah, it's abuse.

Alas, your above description doesn't really tell us what the bug is, so I'm
at a bit of a loss here.

<finds http://marc.theaimsgroup.com/?l=linux-aio&m=116616463009218&w=2>

So that's a refcounting bug.  But it's really a locking bug, because
refcounting needs locking too.

> Problem is in wait_for_all_aios(), it is checking wait status without
> properly holding an ioctx lock. Perhaps, this patch is walking on thin
> ice.  It abuses rcu over a buggy code. OTOH, I really don't want to hold
> ctx_lock over the entire wakeup call at the end of aio_complete:
> 
>         if (waitqueue_active(&ctx->wait))
>                 wake_up(&ctx->wait);
> 
> I'm worried about longer lock hold time in aio_complete and potentially 
> increase lock contention for concurrent I/O completion.

There is a potential problem where we deliver a storm of wakeups at the
waitqueue, and until the waked-up process actually ges going and removes
itself from the waitqueue, those wake_up()s do lots of work waking up an
already-runnable task.

If we were using DEFINE_WAIT/prepare_to_wait/finish_wait in there then the
*first* wake_up() would do some work, but all the following ones are
practically free.

So if you're going to get in there and run the numbers on this, try both
approaches.

>  A quick look
> at lockmeter data I had on a 4 socket system (with dual core + HT), it
> already showing signs of substantial lock contention in aio_complete.
> I'm afraid putting the above call inside ioctx_lock will make things
> worse.

It beats oopsing.

> And synchronize_rcu fits the bill perfectly: aio_complete sets wakeup
> status, drop ioctx_lock, do the wakeup call all protected inside rcu
> lock.  Then wait_for_all_aios will just wait for all that sequence to
> complete before it proceed with __put_ioctx().  All nice and easy.

Possibly it would be less abusive to use preempt_disable()/enable (with
suitable comments) and synchronize_kernel().  To at least remove the rcu
signals from in there.

