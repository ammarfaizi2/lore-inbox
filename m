Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbVIBWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVIBWyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVIBWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:54:19 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:642 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161096AbVIBWyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:54:18 -0400
Subject: Re: [PATCH] RT: Invert some TRACE_BUG_ON_LOCKED tests
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: mingo@elte.hu, dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <1125700852.5601.16.camel@localhost.localdomain>
References: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050902200856.GY3966@smtp.west.cox.net>
	 <1125700852.5601.16.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 02 Sep 2005 18:53:56 -0400
Message-Id: <1125701636.5601.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 18:40 -0400, Steven Rostedt wrote:
> On Fri, 2005-09-02 at 13:08 -0700, Tom Rini wrote:
> > With 2.6.13-rt4 I had to do the following in order to get my paired down
> > config booting on my x86 whitebox (defconfig works fine, after I enable
> > enet/8250_console/nfsroot).  Daniel Walker helped me trace this down.
> 

> 
> Ingo, I guess we need a TRACE_BUG_ON_LOCKED_SMP() macro.


Tom,

try this patch instead.  It removes the tests of the spin_is_locked on
UP.

-- Steve

Signed-off-by: Steven Rostedt  <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 315)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -215,6 +215,16 @@
 		TRACE_BUG_LOCKED();		\
 } while (0)
 
+#ifdef CONFIG_SMP
+# define TRACE_BUG_ON_LOCKED_SMP(c)		\
+do {						\
+	if (unlikely(c))			\
+		TRACE_BUG_LOCKED();		\
+} while (0)
+#else
+# define TRACE_BUG_ON_LOCKED_SMP(c)		do { } while (0)
+#endif
+
 # define trace_local_irq_disable(ti)		raw_local_irq_disable()
 # define trace_local_irq_enable(ti)		raw_local_irq_enable()
 # define trace_local_irq_restore(flags, ti)	raw_local_irq_restore(flags)
@@ -237,6 +247,7 @@
 # define TRACE_WARN_ON_LOCKED(c)		do { } while (0)
 # define TRACE_OFF()				do { } while (0)
 # define TRACE_BUG_ON_LOCKED(c)			do { } while (0)
+# define TRACE_BUG_ON_LOCKED_SMP(c)		do { } while (0)
 
 #endif /* CONFIG_RT_DEADLOCK_DETECT */
 
@@ -736,8 +747,8 @@
 	if (old_owner == new_owner)
 		return;
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&old_owner->task->pi_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&new_owner->task->pi_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&old_owner->task->pi_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&new_owner->task->pi_lock));
 	plist_for_each_safe(curr1, next1, &old_owner->task->pi_waiters) {
 		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
 		if (w->lock == lock) {
@@ -770,8 +781,8 @@
 		return;
 	}
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&p->pi_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&p->pi_lock));
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	pi_prio++;
 	if (p->policy != SCHED_NORMAL && prio > normal_prio(p)) {
@@ -967,8 +978,8 @@
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&task->pi_lock));
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&task->pi_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&lock->wait_lock));
 #if !ALL_TASKS_PI
 	if (!rt_task(task)) {
 		plist_add(&waiter->list, &lock->wait_list);
@@ -1070,7 +1081,7 @@
 	struct rt_mutex_waiter *waiter = NULL;
 	struct thread_info *new_owner;
 
-	TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));
+	TRACE_BUG_ON_LOCKED_SMP(!spin_is_locked(&lock->wait_lock));
 	/*
 	 * Get the highest prio one:
 	 *


