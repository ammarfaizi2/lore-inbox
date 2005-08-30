Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVH3Pxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVH3Pxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVH3Pxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:53:31 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:32657 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932193AbVH3Pxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:53:30 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>, dwalker@mvista.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <1125414039.5675.42.camel@localhost.localdomain>
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
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 30 Aug 2005 11:52:36 -0400
Message-Id: <1125417156.6355.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 11:00 -0400, Steven Rostedt wrote:
> OK, I'm looking for a second set of eyes (or third or more :-) to see if
> there's a danger of a deadlock here.

Unless someone sees a problem with the patch, here it is.  I noticed
that I unlocked the lock->wait_lock when I should not have.  (scares me
since I'm currently running the kernel with that bug!)

Ingo,  in the pi_setprio, I can stop the loop if the owner of the BKL
has a task lock_depth >= 0 correct?  This means that the owner is either
running, or is going to go to sleep.  If it was blocked on another task,
via a mutex, then this count would be -1.  Correct?  I may need to move
the setting of lock_depth = -1 to inside the protection of the task
pi_lock.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 310)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -1089,11 +1089,21 @@
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
 


