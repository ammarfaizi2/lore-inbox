Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVCRMKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVCRMKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCRMKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 07:10:43 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34497 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261562AbVCRMK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 07:10:27 -0500
Date: Fri, 18 Mar 2005 07:10:12 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove lame schedule in journal inverted_lock (was: Re:
 [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks)
In-Reply-To: <20050318030731.224aa95f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503180657500.21994@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
 <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org>
 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org> <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
 <20050316131521.48b1354e.akpm@osdl.org> <Pine.LNX.4.58.0503170406500.17019@localhost.localdomain>
 <Pine.LNX.4.58.0503180415370.21994@localhost.localdomain>
 <20050318013251.330e4d78.akpm@osdl.org> <Pine.LNX.4.58.0503180531580.21994@localhost.localdomain>
 <20050318030731.224aa95f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Mar 2005, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  I wanted to keep the wait logic out when it wasn't a problem. Basically,
> >  the problem only occurs when bit_spin_trylock is defined as an actual
> >  trylock. So I put in a define there to enable the wait queues.  I didn't
> >  want to waste cycles checking the wait queue in jbd_unlock_bh_state when
> >  there would never be anything on it.  Heck, I figured why even have the
> >  wait queue wasting memory if it wasn't needed.  So that added the
> >  ifdeffery complexity.
>
> No, that code's just a problem.  For ranking reasons it's essentially doing
> this:
>
> repeat:
> 	cond_resched();
> 	spin_lock(j_list_lock);
> 	....
> 	if (!bit_spin_trylock(bh)) {
> 		spin_unlock(j_list_lock);
> 		schedule();
> 		goto repeat;
> 	}
>

Yep, that I understand.

> Now imagine that some other CPU holds the bit_spin_lock and is spinning,
> trying to get the spin_lock().  The above code assumes that the schedule()
> and cond_resched() will take "long enough" for the other CPU to get the
> spinlock, do its business then release the locks.
>
> So all the schedule() is really doing is "blow a few cycles so the other
> CPU can get in and grab the spinlock".  That'll work OK on normal SMP but I
> suspect that on NUMA setups with really big latencies we could end up
> starving the other CPU: this CPU would keep on grabbing the lock.  It
> depends on how the interconnect cache and all that goop works.
>
> So what to do?
>
> One approach would be to spin on the bit_spin_trylock after having dropped
> j_list_lock.  That'll tell us when the other CPU has moved on.
>

This is probably the best for mainline, since, as you mentioned, the
abover code is just bad.

> Another approach would be to sleep on a waitqueue somewhere.  But that
> means that jbd_unlock_bh_state() needs to do wakeups all the time - costly.
>

That's the approach that my patch made.

> Another approach would be to simply whack an msleep(1) in there.  That
> might be OK - it should be very rare.
>

This approach is not much better than the current implementation.

> Probably the first approach would be the one to use.  That's for mainline.
> I don't know what the super-duper-RT fix would be.  Why did we start
> discussing this anyway?
>
> Oh, SCHED_FIFO.  kjournald doesn't run SCHED_FIFO, but someone may decide
> to make it do so.  But even then I don't see a problem for the mainline
> kernel, because this CPU's SCHED_FIFO doesn't stop the other CPU from
> running.
>

So this comes down to just a problem with Ingo's PREEPMT_RT.  This means
that the latency of kjournald, even without SCHED_FIFO will be large. If
it preempts a process that has one of these bit spinlocks, (Ingo's RT
kernel takes out the preempt_disable in them), then the kjournal thread
will spin till its quota is free, causing problems for other processes.
Even a process with a higher priority than kjournal if it blocks on one of
the other locks that kjournal can have while attempting to get the bit
locks.

I know Ingo wants to get his patch eventually into the mainline without
too much drag. But this problem needs to be solved in the mainline to
accomplish this.

What do you recommend?

-- Steve

