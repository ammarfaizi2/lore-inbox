Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVIAQZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVIAQZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVIAQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:25:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15060 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030226AbVIAQZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:25:03 -0400
Subject: Re: 2.6.13-rt3
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 01 Sep 2005 12:24:53 -0400
Message-Id: <1125591893.7842.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's a patch to fix some of the problems when defining ALL_TASKS_PI.
The pi_setprio logic is currently incorrect.  This should fix that. I
converted ALL_TASKS_PI to a constant number, so that it can be used in
if statements.

-- Steve

Note: I compiled this, but I haven't run it yet. I'll run it right after
I send this note and respond how it worked.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 314)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -104,7 +104,7 @@
  * in the system fall under PI handling. Normally only SCHED_FIFO/RR
  * tasks are PI-handled:
  */
-#define ALL_TASKS_PI
+#define ALL_TASKS_PI 1
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __EIP_DECL__ , unsigned long eip
@@ -663,7 +663,7 @@
 
 #endif
 
-#if defined(ALL_TASKS_PI) && defined(CONFIG_RT_DEADLOCK_DETECT)
+#if ALL_TASKS_PI && defined(CONFIG_RT_DEADLOCK_DETECT)
 
 static void
 check_pi_list_present(struct rt_mutex *lock, struct rt_mutex_waiter *waiter,
@@ -674,7 +674,6 @@
 
 	__raw_spin_lock(&old_owner->task->pi_lock);
 	TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
-	TRACE_WARN_ON_LOCKED(lock_owner(lock));
 
 	plist_for_each(curr1, &old_owner->task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
@@ -851,7 +850,7 @@
 			__raw_spin_lock(&l->wait_lock);
 
 		TRACE_BUG_ON_LOCKED(!lock_owner(l));
-		if (rt_task(p) && plist_empty(&w->pi_list)) {
+		if ((ALL_TASKS_PI || rt_task(p)) && plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON_LOCKED(was_rt);
 			plist_init(&w->pi_list, prio);
 			plist_add(&w->pi_list, &lock_owner(l)->task->pi_waiters);
@@ -868,7 +867,7 @@
 		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
 		 *        get PI handled.)
 		 */
-		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
+		if (!ALL_TASKS_PI && !rt_task(p) && !plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON_LOCKED(!was_rt);
 			plist_del(&w->pi_list, &lock_owner(l)->task->pi_waiters);
 			plist_del(&w->list, &l->wait_list);
@@ -970,7 +969,7 @@
 	 */
 	TRACE_BUG_ON_LOCKED(!spin_is_locked(&task->pi_lock));
 	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
-#ifndef ALL_TASKS_PI
+#if !ALL_TASKS_PI
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
 		set_lock_owner_pending(lock);
@@ -1083,7 +1082,7 @@
 #endif
 	trace_special_pid(waiter->ti->task->pid, waiter->ti->task->prio, 0);
 
-#ifdef ALL_TASKS_PI
+#if ALL_TASKS_PI
 	check_pi_list_present(lock, waiter, old_owner);
 #endif
 	new_owner = waiter->ti;
@@ -1543,7 +1542,7 @@
 	list_del_init(&lock->held_list);
 #endif
 
-#ifdef ALL_TASKS_PI
+#if ALL_TASKS_PI
 	if (plist_empty(&lock->wait_list))
 		check_pi_list_empty(lock, lock_owner(lock));
 #endif


