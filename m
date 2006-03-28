Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWC1VRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWC1VRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWC1VRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:17:31 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:40654 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751256AbWC1VRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:17:30 -0500
Date: Tue, 28 Mar 2006 22:17:20 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <20060328205533.GC1217@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603282202250.22822-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > > we are observing a non-time-coherent snapshot of the locking graph.
> > > There is no guarantee that due to timeouts or signals the chain we
> > > observe isnt artificially long - while if a time-coherent snapshot is
> > > taken it is always fine. E.g. lets take dentry locks as an example:
> > > their locking is ordered by the dentry (kernel-pointer) address. We
> > > could in theory have a 'chain' of subsequent locking dependencies
> > > related to 10,000 dentries, which are nicely ordered and create a
> > > 10,000-entry 'chain' if looked at in a non-time-coherent form. I.e. your
> > > code could detect a deadlock where there's none. The more CPUs there
> > > are, the larger the likelyhood is that other CPUs 'lure us' into a long
> > > chain.
> >
> > I don't quite understand you examble: Are all 10,000 held at once?
>
> no.
>
> > If no, how are they all going to suddenly put into the lock chain due
> > to signals or timeouts? Those things unlocks locks and therefore
> > breaks the chain.
>
> the core problem with your approach is that for each step in the
> 'boosting chain' (which can be quite long in theory), all that we are
> holding is a task reference get get_task_struct(), to a task that was
> blocked before. We then make ourselves preemptible - and once get get
> back and continue the boosting chain, there is no guarantee that the
> boosting makes any sense! Normally that task will probably still be
> blocked, and we continue with our boosting. But the task could have
> gotten unblocked, it could have gotten re-blocked, and we'd continue
> doing the boosting.
>
> in short: wow do you ensure that the boosting is still part of the same
> dependency chain where it started off?
>

I don't insure that. But does it matter?!?
If the task is still blocked on a lock and the owner of that lock might
need boosting. The boosting operation itself will always be _correct_ as the
pi_lock is held when it is done. But the task doing the boosting might have
preempted for so long that there is nothing left to do - and then it
simply stops unless deadlock detection is on.

I think we talk about the situation

                        B locks 1            C locks 2       D locks 3
                        B locks 2, boosts C and block
      A locks 2
      A is boost B
      A drop it's spinlocks and is preempted
                                             C unlocks 2 and auto unboosts
                        B is running
                        B locks 3, boosts C and blocks
      A gets a CPU again
      A boosts B
      A boosts D

Is there anything wrong with that?
And in the case where A==D there indeed is a deadlock which will be
detected.

Esben



> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

