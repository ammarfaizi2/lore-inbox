Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbVHZNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbVHZNxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbVHZNxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:53:04 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29144 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751569AbVHZNxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:53:02 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>, dwalker@mvista.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <1125023010.5365.4.camel@localhost.localdomain>
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
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 26 Aug 2005 09:52:14 -0400
Message-Id: <1125064334.5365.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

The following code segment from pick_new_owner:


	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);

 try_again:
	trace_special_pid(waiter->ti->task->pid, waiter->ti->task->prio, 0);

#ifdef ALL_TASKS_PI
	check_pi_list_present(lock, waiter, old_owner);
#endif
	new_owner = waiter->ti;
	/*
	 * The new owner is still blocked on this lock, so we
	 * must release the lock->wait_lock before grabing 
	 * the new_owner lock.
	 */
	__raw_spin_unlock(&lock->wait_lock);
	__raw_spin_lock(&new_owner->task->pi_lock);
	__raw_spin_lock(&lock->wait_lock);
	/*
	 * In this split second of releasing the lock, a high priority 
	 * process could have come along and blocked as well.
	 */
	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
	if (unlikely(waiter->ti != new_owner)) {
		__raw_spin_unlock(&new_owner->task->pi_lock);
		goto try_again;
	}


Is basically a waste on UP. Should the following patch be applied
instead?


--- linux_realtime_ernie/kernel/rt.c.orig	2005-08-26 09:46:34.000000000 -0400
+++ linux_realtime_ernie/kernel/rt.c	2005-08-26 09:48:17.000000000 -0400
@@ -1046,7 +1046,9 @@ pick_new_owner(struct rt_mutex *lock, st
 	 */
 	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 
+#ifdef CONFIG_SMP
  try_again:
+#endif
 	trace_special_pid(waiter->ti->task->pid, waiter->ti->task->prio, 0);
 
 #ifdef ALL_TASKS_PI
@@ -1065,11 +1067,13 @@ pick_new_owner(struct rt_mutex *lock, st
 	 * In this split second of releasing the lock, a high priority 
 	 * process could have come along and blocked as well.
 	 */
+#ifdef CONFIG_SMP
 	waiter = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 	if (unlikely(waiter->ti != new_owner)) {
 		__raw_spin_unlock(&new_owner->task->pi_lock);
 		goto try_again;
 	}
+#endif
 	plist_del_init(&waiter->list, &lock->wait_list);
 
 	__raw_spin_lock(&old_owner->task->pi_lock);



-- Steve


PS.  I notice I have a large CC on this thread.  If anyone wants me to
take them off, just send me a private email, and I'll do that.

