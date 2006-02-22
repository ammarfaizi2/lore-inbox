Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWBVQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWBVQvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWBVQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:51:17 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:38826 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1030243AbWBVQvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:51:16 -0500
Date: Wed, 22 Feb 2006 17:50:53 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
In-Reply-To: <20060221155548.GA30146@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0602221621110.13737-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Feb 2006, Ingo Molnar wrote:

> i have released the 2.6.15-rt17 tree, which can be downloaded from the
> usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> lots of changes all across the map. There are several bigger changes:
>
> the biggest change is the new PI code from Esben Nielsen, Thomas
> Gleixner and Steven Rostedt. This big rework simplifies and streamlines
> the PI code, and fixes a couple of bugs and races:
>
I didn't know anyone looked at my patch! I am ofcourse happy about it :-)

I switftly looked at 2.6.15-rt17 to see how it turned out. I found one
problem in get_blocked_on(task):

First the task->pi_lock is locked, lock = task->blocked_on->lock, then
task->pi_lock is unlocked. Now lock is used. This is not safe.
Once task->pi_lock is unlocked we can be preempted and wait for a long
while the lock can be freed (if forinstance a driver is unloaded). You
either have to hold task->pi_lock or lock->wait_lock while refering to
lock. Otherwise the lock can be deallocated behind your bag. I assume that
nobody deallocate a lock with waiters.

That was why I had _reversed_ the lock ordering relative to normal in the
original patch: First lock task->pi_lock. Assign lock. Lock
lock->wait_lock. Then unlock task->pi_lock. Now it is safe to refer to
lock. To avoid deadlocks I used _raw_spin_trylock() when locking the 2.
lock.

To make a long story short:

--- linux-2.6.15-rt17/kernel/rt.c.orig  2006-02-22 16:53:44.000000000
+0100
+++ linux-2.6.15-rt17/kernel/rt.c       2006-02-22 16:56:21.000000000
+0100
@@ -873,10 +873,17 @@
        }

        lock = task->blocked_on->lock;
+
+       /* Now we have to take lock->wait_lock _before_ releasing
+          task->pi_lock. Otherwise lock can be deallocated while we are
+          refering to it as the subsystem has no way of knowing about us
+          hanging around in here. */
+       if (!_raw_spin_trylock(&lock->wait_lock)) {
+               _raw_spin_unlock(&task->pi_lock);
+               goto try_again;
+        }
        _raw_spin_unlock(&task->pi_lock);

-       if (!_raw_spin_trylock(&lock->wait_lock))
-               goto try_again;

        owner = lock_owner(lock);
        if (owner)

It compiles, but I have not tested it. I can't see why it shouldn't work.

Esben

