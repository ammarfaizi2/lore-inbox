Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVH3XJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVH3XJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVH3XJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:09:29 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34303 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932272AbVH3XJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:09:29 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1125417156.6355.13.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
	 <1125414039.5675.42.camel@localhost.localdomain>
	 <1125417156.6355.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 30 Aug 2005 19:08:23 -0400
Message-Id: <1125443303.6422.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

This patch contains my previous change as well as an update to fix the
race conditions that the BKL may hold.  It is against -rt2. 

The first part of the patch will stop the pi_setprio loop if the process
has a lock_depth greater than or equal to zero.  Since that would mean
that the process either is running, or is about to release the BKL.

I still kept the change from rt1 to rt2 but changed the comment.

I added the lock release logic in the __up code incase the BKL is
causing loops in the pi chain.

I'm currently runnig -rt2 with these changes as I type.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 310)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -800,7 +800,24 @@
 #endif
 
 		mutex_setprio(p, prio);
-		if (!w)
+
+		/*
+		 * The BKL can really be a pain. It can happen where the
+		 * BKL is being held by one task that is just about to
+		 * block on another task that is waiting for the BKL.
+		 * This isn't a deadlock, since the BKL is released
+		 * when the task goes to sleep.  This also means that
+		 * all holders of the BKL are not blocked, or are just
+		 * about to be blocked.
+		 *
+		 * Another side-effect of this is that there's a small
+		 * window where the spinlocks are not held, and the blocked
+		 * process hasn't released the BKL.  So if we are going
+		 * to boost the owner of the BKL, stop after that,
+		 * since that owner is either running, or about to sleep
+		 * but don't go any further or we are in a loop.
+		 */
+		if (!w || unlikely(p->lock_depth >= 0))
 			break;
 		/*
 		 * If the task is blocked on a lock, and we just made
@@ -817,10 +834,9 @@
 		TRACE_BUG_ON_LOCKED(!lock);
 
 		/*
-		 * The BKL can really be a pain.  It can happen that the lock
-		 * we are blocked on is owned by a task that is waiting for
-		 * the BKL, and we own it.  So, if this is the BKL and we own
-		 * it, then end the loop here.
+		 * The current task that is blocking can also the one
+		 * holding the BKL, and blocking on a task that wants 
+		 * it.  So if it were to get this far, we would deadlock.
 		 */
 		if (unlikely(l == &kernel_sem.lock) && lock_owner(l) == current_thread_info()) {
 			/*
@@ -1089,11 +1105,21 @@
 		__raw_spin_unlock(&new_owner->task->pi_lock);
 		goto try_again;
 	}
+	/*
+	 * Once again the BKL comes to play.  Since the BKL can be grabbed and released
+	 * out of the normal P1->L1->P2 order, there's a chance that someone has the
+	 * BKL owner's lock and is waiting on the new owner lock.
+	 */
+	if (unlikely(lock == &kernel_sem.lock)) {
+		if (!__raw_spin_trylock(&old_owner->task->pi_lock)) {
+			__raw_spin_unlock(&new_owner->task->pi_lock);
+			goto try_again;
+		}
+	} else
 #endif
+		__raw_spin_lock(&old_owner->task->pi_lock);
+
 	plist_del_init(&waiter->list, &lock->wait_list);
-
-	__raw_spin_lock(&old_owner->task->pi_lock);
-
 	plist_del(&waiter->pi_list, &old_owner->task->pi_waiters);
 	plist_init(&waiter->pi_list, waiter->ti->task->prio);
 


