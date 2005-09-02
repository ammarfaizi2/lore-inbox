Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVIBUJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVIBUJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVIBUJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:09:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61888 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751125AbVIBUJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:09:02 -0400
Date: Fri, 2 Sep 2005 13:08:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: mingo@elte.hu
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: [PATCH] RT: Invert some TRACE_BUG_ON_LOCKED tests
Message-ID: <20050902200856.GY3966@smtp.west.cox.net>
References: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.13-rt4 I had to do the following in order to get my paired down
config booting on my x86 whitebox (defconfig works fine, after I enable
enet/8250_console/nfsroot).  Daniel Walker helped me trace this down.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.13/kernel/rt.c	2005-09-02 12:39:02.000000000 -0700
+++ linux-2.6.13/kernel/rt.c	2005-09-02 12:24:04.000000000 -0700
@@ -736,8 +736,8 @@
 	if (old_owner == new_owner)
 		return;
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&old_owner->task->pi_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&new_owner->task->pi_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&old_owner->task->pi_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&new_owner->task->pi_lock));
 	plist_for_each_safe(curr1, next1, &old_owner->task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
@@ -770,8 +770,8 @@
 		return;
 	}
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&p->pi_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&p->pi_lock));
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	pi_prio++;
 	if (p->policy != SCHED_NORMAL && prio > normal_prio(p)) {
@@ -967,8 +967,8 @@
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&task->pi_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&task->pi_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&lock->wait_lock));
 #if !ALL_TASKS_PI
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
@@ -1070,7 +1070,7 @@
 	struct rt_mutex_waiter *waiter = NULL;
 	struct thread_info *new_owner;
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED(spin_is_locked(&lock->wait_lock));
 	/*
 	 * Get the highest prio one:
 	 *

-- 
Tom Rini
http://gate.crashing.org/~trini/
