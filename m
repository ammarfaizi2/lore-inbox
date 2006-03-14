Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWCNAWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWCNAWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWCNAWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:22:30 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:21655 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751405AbWCNAW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:22:29 -0500
Date: Tue, 14 Mar 2006 01:22:16 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk>
Message-ID: <Pine.LNX.4.44L0.0603140037000.1291-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Mar 2006, Esben Nielsen wrote:

> On Sun, 12 Mar 2006, Ingo Molnar wrote:
>
> > i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from
> > the usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> >
> > again, lots of changes all over the map:
> >
> > - firstly, the -rt tree has been rebased to 2.6.16-rc6, which was a more
> >   complex operation than usual, due to the many changes in 2.6.16 (in
> >   particular the mutex code).
> >
> > - the PI code got reworked again, this time by Thomas Gleixner. The
> >   priority boosting chain is now instantaneous again (and not
> >   wakeup/scheduling based) - but the previous list-walking hell has been
> >   avoided via the clever use of plists. Plus many other changes and
> >   lots of cleanups to the rt-mutex proper.
>
> Hi,
>  I briefly looked at the PI code. Looks fine. I will try it on my
> rt-mutex testbed soonish.
>

Well, I got my TestRTMutex compiled and it was successfull: It found bugs.

1) Boosting nested locks simply doesn't work:

threads:   3            2            1
         lock 1         +            +
test:     +             +            +
test:    prio 3      prio 2       prio 1
test:  lockcount 1  lockcount 0  lockcount 0

          +          lock 2          +
test:     +             +            +
test:    prio 3      prio 2       prio 1
test:  lockcount 1  lockcount 1  lockcount 0

         lock 2         +            +
test:     -             +            +
test:    prio 3      prio 2       prio 1
test:  lockcount 1  lockcount 1  lockcount 0

           +            +          lock1
test:     -             +            -
test:    prio 1      prio 1       prio 1
test:  lockcount 1  lockcount 1  lockcount 0

Task 2 (2. column) doesn't get boosted to priority 1. Only task 1 gets
boosted.

This is easily fixed by
--- linux-2.6-rt/kernel/rtmutex.c.orig  2006-03-14 00:03:47.000000000 +0100
+++ linux-2.6-rt/kernel/rtmutex.c       2006-03-14 00:41:27.000000000 +0100
@@ -222,6 +222,7 @@ static int adjust_prio_chain(int enqueue
                         */
                        waiter = rt_mutex_first_waiter(lock);
                        plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
+                       waiter->pi_list_entry.prio = waiter->task->prio;
                        plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
                        adjust_prio(owner);
                }


2) There is a  spinlock deadlock when doing the following test on SMP:

threads:   1            2
         lock 1         +
          +          lock 2
test:   lockcount 1   lockcount 1

         lock 2      lock 1            <- spin deadlocks here
          -             -
test:   lockcount 1   lockcount 1

This happens because both tasks tries to lock both tasks's pi_lock but
in opposit order.  I don't have fix for that one yet.

Esben



