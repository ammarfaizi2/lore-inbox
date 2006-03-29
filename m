Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWC2H7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWC2H7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWC2H7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:59:39 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:11410 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751144AbWC2H7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:59:38 -0500
Date: Wed, 29 Mar 2006 08:59:30 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <20060329071456.GA20187@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603290851320.12114-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > > well, another possibility is that the task got blocked again, and we'll
> > > continue boosting _the wrong chain_. I.e. we'll add extra priority to
> > > task(s) that might not deserve it at all (it doesnt own the lock we are
> > > interested in anymore).
> >
> > This can't happen. We are always looking at the first waiter on
> > task->pi_waiter task->pi_lock held when doing the boosting. If task
> > has released the lock the entry task->pi_waiter is gone and no
> > boosting will take place!
>
> no, the task got blocked _again_, as part of a _new_ blocking chain, and
> there's a _new_ PI waiter! How does the two-lock preemptible boosting
> algorithm ensure that if we are in the middle of boosting a
> blocking-dependency chain:
>
>    T1 -> T2 -> ... -> TI -> TI+1 -> ... TN-1 -> TN
>
> we are at TI, and we [the task doing the boosting] now get preempted.
>
> What prevents TI from being part of a _totally new_ blocking-chain,
> where the only similarity between the two chains is that TI is in the
> middle of it:
>
>    T1' -> T2' -> ... -> TI -> TI+1' -> ... TM-1 -> TM'
>
> the only match between the two chains is 'TI'. Now the algorithm will
> happily walk the wrong boosting chain, and will boost the wrong tasks.
>

The point is: It does not matter that is another chain!

It will _not_ boost any task which doesn't need boosting, because it is
not boosting according to current->prio but always task->pi_waiters. So
all it does is to fix the priorities on some tasks. There is
absolutely nothing wrong with that. But these task will already have the
right priorities, because the new outermost locker (T1') will have
traversed the list and done the boosting. So current will stop boosting
and break out of the loop (unless it is doing deadlock detection).

But what about the original chain? Well, as the tasks aren't blocked
anymore, they doesn't need boosting anymore, so no boosting missed either.
Or if they are blocked on something else, the those locking operations
have or will take care of it.

Esben



> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

