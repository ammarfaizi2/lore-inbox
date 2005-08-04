Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVHDOqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVHDOqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVHDOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:44:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27582 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262574AbVHDOmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:42:49 -0400
Date: Thu, 4 Aug 2005 16:42:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: wakeup race checking for RT
Message-ID: <20050804144244.GB15447@elte.hu>
References: <1122932189.4623.25.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122932189.4623.25.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.701, required 5.9,
	BAYES_00 -4.90, DOMAIN_BODY 2.20
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> In the interest of CC'ing everyone here's another patch .
> 
> This checks for wake_up_process() calls inside was preempt off 
> sections. So if it was a spinlock , and you call wake_up_process() it 
> will trigger a warning.. These are problematic cause in RT the 
> wake_up_process() (if it's an RT task) will cause a context switch 
> immediately , but with out RT you don't context switch till you unlock 
> the last spinlock ..

this certainly makes sense, a 'naked' wakeup is almost certainly a bug.  

I've applied your patch, and have released the -52-13 PREEMPT_RT 
patchset. [ But please be more careful with the coding style next time, 
see below the number of fixups i had to do relative to your patch 
(whitespaces, line length, code structure format, etc.). ]

> There is also some checking on lock_depth , includes all types of 
> locks that are not rt_mutex types. I noticed that my test system went 
> to lock depth ~17 !

i've further upped the lock depth from 20 to 25 - if 17 happens then 20 
is most likely not enough.

	Ingo

--- linux/kernel/rt.c.orig
+++ linux/kernel/rt.c
@@ -251,11 +251,11 @@ void zap_rt_locks(void)
 #ifdef CONFIG_DEBUG_PREEMPT
 int check_locking_preempt_off(struct task_struct *p)
 {
-	int i = 0;
+	int i;
 	
-	for (;i < p->lock_count; i++) {
-		if (p->owned_lock[i]->was_preempt_off) return 1;
-	}
+	for (i = 0; i < p->lock_count; i++)
+		if (p->owned_lock[i]->was_preempt_off)
+			return 1;
 	return 0;
 }
 
@@ -264,17 +264,18 @@ void check_preempt_wakeup(struct task_st
 	/*
 	 * Possible PREEMPT_RT race scenario when
 	 * wake_up_proces() is usually called with
-	 * preemption off , but PREEMPT_RT enables
+	 * preemption off, but PREEMPT_RT enables
 	 * it. If the task is dependent on preventing
 	 * context switches either with spinlocks
-	 * or rcu locks , then this could result in
+	 * or rcu locks, then this could result in
 	 * hangs and race conditions.
 	 */
-	if (!preempt_count() && 
+	if (!preempt_count() &&
 		p->prio < current->prio &&
 		rt_task(p) &&
 		(current->rcu_read_lock_nesting != 0 ||
-		check_locking_preempt_off(current)) ) {
+				check_locking_preempt_off(current))) {
+
 			printk("BUG: %s/%d, possible wake_up race on %s/%d\n",
 				current->comm, current->pid, p->comm, p->pid);
 			dump_stack();
@@ -917,10 +918,12 @@ void set_new_owner(struct rt_mutex *lock
 	lock->acquire_eip = eip;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
-	if (new_owner->task->lock_count < 0 || new_owner->task->lock_count >= MAX_LOCK_STACK) {
+	if (new_owner->task->lock_count < 0 ||
+			new_owner->task->lock_count >= MAX_LOCK_STACK) {
 		TRACE_OFF();
-		printk("BUG: %s/%d: lock count of %lu\n", 
-			new_owner->task->comm, new_owner->task->pid, new_owner->task->lock_count);
+		printk("BUG: %s/%d: lock count of %lu\n",
+			new_owner->task->comm, new_owner->task->pid,
+			new_owner->task->lock_count);
 		dump_stack();
 	}
 	new_owner->task->owned_lock[new_owner->task->lock_count] = lock;
@@ -1055,7 +1058,7 @@ static int __grab_lock(struct rt_mutex *
 #ifdef CONFIG_DEBUG_PREEMPT
 	if (owner->lock_count < 0 || owner->lock_count >= MAX_LOCK_STACK) {
 		TRACE_OFF();
-		printk("BUG: %s/%d: lock count of %lu\n", 
+		printk("BUG: %s/%d: lock count of %lu\n",
 			owner->comm, owner->pid, owner->lock_count);
 		dump_stack();
 	}
@@ -1370,7 +1373,7 @@ ____up_mutex(struct rt_mutex *lock, int 
 #ifdef CONFIG_DEBUG_PREEMPT
 	if (current->lock_count < 0 || current->lock_count >= MAX_LOCK_STACK) {
 		TRACE_OFF();
-		printk("BUG: %s/%d: lock count of %lu\n", 
+		printk("BUG: %s/%d: lock count of %lu\n",
 			current->comm, current->pid, current->lock_count);
 		dump_stack();
 	}
--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -1567,6 +1567,7 @@ EXPORT_SYMBOL(wake_up_process);
 int fastcall wake_up_process_sync(task_t * p)
 {
 	int ret; 
+
 	check_preempt_wakeup(p);
 	ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				 TASK_RUNNING_MUTEX | TASK_INTERRUPTIBLE |
--- linux/include/linux/init_task.h.orig
+++ linux/include/linux/init_task.h
@@ -63,12 +63,6 @@
 
 extern struct group_info init_groups;
 
-#ifdef CONFIG_DEBUG_PREEMPT
-# define INIT_LOCK_COUNT(x)	.lock_count	= x,
-#else
-# define INIT_LOCK_COUNT(x)
-#endif
-
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -80,7 +74,6 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
-	INIT_LOCK_COUNT(0)						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.normal_prio	= MAX_PRIO-20,					\
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -58,8 +58,8 @@ extern int debug_direct_keyboard;
 extern int check_locking_preempt_off(struct task_struct *p);
 extern void check_preempt_wakeup(struct task_struct * p);
 #else
-#define check_locking_preempt_off(x)	(0)
-#define check_preempt_wakeup(p)	do { } while(0)
+#define check_locking_preempt_off(x)		0
+#define check_preempt_wakeup(p)			do { } while (0)
 #endif
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -898,7 +898,7 @@ struct task_struct {
 /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
 	spinlock_t proc_lock;
 
-#define MAX_PREEMPT_TRACE 20
+#define MAX_PREEMPT_TRACE 25
 
 #ifdef CONFIG_PREEMPT_TRACE
 	unsigned long preempt_trace_eip[MAX_PREEMPT_TRACE];
--- linux/include/linux/rt_lock.h.orig
+++ linux/include/linux/rt_lock.h
@@ -102,7 +102,7 @@ struct rt_mutex_waiter {
 #ifdef CONFIG_DEBUG_PREEMPT
 # define __WAS_PREEMPT_OFF(x)	, .was_preempt_off = x
 #else
-# define __WAS_PREEMPT_OFF(x)	, .was_preempt_off = x
+# define __WAS_PREEMPT_OFF(x)
 #endif
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -133,7 +133,7 @@ struct rt_mutex_waiter {
 #define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED \
 	__PLIST_INIT(lockname) \
-	__WAS_PREEMPT_OFF(0)	\
+	__WAS_PREEMPT_OFF(0) \
 	__RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER }
 
@@ -165,7 +165,7 @@ typedef struct {
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED, .save_state = 1 \
 	__PLIST_INIT((lockname).lock.lock) \
 	, .file = __FILE__, .line = __LINE__ \
-	__WAS_PREEMPT_OFF(1)	\
+	__WAS_PREEMPT_OFF(1) \
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER
 #  define _RW_LOCK_UNLOCKED(lockname) \
 	(rwlock_t) { { { __RW_LOCK_UNLOCKED(lockname), .name = #lockname } } }
@@ -199,7 +199,7 @@ typedef struct {
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED \
 	__PLIST_INIT(((lockname).lock)) \
 	, .save_state = 1, .file = __FILE__, .line = __LINE__ \
-	__WAS_PREEMPT_OFF(1)	\
+	__WAS_PREEMPT_OFF(1) \
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER
 # define _SPIN_LOCK_UNLOCKED(lockname) \
 	(spinlock_t) { { __SPIN_LOCK_UNLOCKED(lockname), .name = #lockname } }
