Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVEIVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVEIVao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEIVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:30:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29433 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261529AbVEIVaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:30:05 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1115666506.15027.3.camel@localhost.localdomain>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
	 <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu>
	 <427F1A99.58BCCB88@tv-sign.ru>  <20050509091133.GA25959@elte.hu>
	 <1115662430.16016.4.camel@dhcp153.mvista.com>
	 <1115666506.15027.3.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1115674190.16017.32.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2005 14:29:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 12:21, Steven Rostedt wrote:
> On Mon, 2005-05-09 at 11:13 -0700, Daniel Walker wrote:
> > On Mon, 2005-05-09 at 02:11, Ingo Molnar wrote:
> > 
> > > What would be nice to achieve are [low-cost] reductions of the size of 
> > > struct rt_mutex (in include/linux/rt_lock.h), upon which all other 
> > > PI-aware locking objects are based. Right now it's 9 words, of which 
> > > struct plist is 5 words. Would be nice to trim this to 8 words - which 
> > > would give a nice round size of 32 bytes on 32-bit.
> > 
> > Why not make rt_mutex->wait_lock a pointer ? Set it to NULL and handle
> > it in rt.c .
> 
> That may make the rt_mutex structure smaller but this increases the size
> of the kernel by the size of that pointer (times every rt_mutex in the
> kernel!). You still need to allocate the size of the raw spin lock,
> although now you just point to it. Is rounding worth that much overhead?


It's a typo , I mean rt_mutex->wait_list . Sorry .. The list part is a
list head , which is two pointers. We could condense that to one
pointer, and it eliminates the overhead of the structure we use .. Below
seems to work, but consider it an rfc patch..

Daniel


Index: linux-2.6.11/include/linux/rt_lock.h
===================================================================
--- linux-2.6.11.orig/include/linux/rt_lock.h	2005-05-09 17:49:26.000000000 +0000
+++ linux-2.6.11/include/linux/rt_lock.h	2005-05-09 19:29:05.000000000 +0000
@@ -58,7 +58,7 @@ typedef struct {
  */
 struct rt_mutex {
 	raw_spinlock_t		wait_lock;
-	struct plist		wait_list;
+	struct plist		*wait_list;
 	struct task_struct	*owner;
 	int			owner_prio;
 # ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -86,12 +86,11 @@ struct rt_mutex_waiter {
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	.wait_list = PLIST_INIT((lockname).wait_list, MAX_PRIO),  \
 	.name = #lockname, .file = __FILE__, .line = __LINE__ }
 #else
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	PLIST_INIT((lockname).wait_list, MAX_PRIO) }
+	 }
 #endif
 /*
  * RW-semaphores are an RT mutex plus a reader-depth count.
Index: linux-2.6.11/kernel/rt.c
===================================================================
--- linux-2.6.11.orig/kernel/rt.c	2005-05-09 18:14:31.000000000 +0000
+++ linux-2.6.11/kernel/rt.c	2005-05-09 19:30:37.000000000 +0000
@@ -640,10 +640,11 @@ static void pi_setprio(struct rt_mutex *
 			plist_init(&w->pi_list, prio);
 			plist_add(&w->pi_list, &lock->owner->pi_waiters);
 
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
-
+			if (!plist_empty(lock->wait_list)) {
+				plist_del(&w->list, lock->wait_list);
+				plist_init(&w->list, prio);
+				plist_add(&w->list, lock->wait_list);
+			}
 		}
 		/*
 		 * If the task is blocked on a lock, and we just restored
@@ -656,10 +657,11 @@ static void pi_setprio(struct rt_mutex *
 		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON(!was_rt);
 			plist_del(&w->pi_list, &lock->owner->pi_waiters);
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &lock->wait_list);
-
+			if (!plist_empty(lock->wait_list)) {
+				plist_del(&w->list, lock->wait_list);
+				plist_init(&w->list, prio);
+				plist_add(&w->list, lock->wait_list);
+			}
 		}
 
 		pi_walk++;
@@ -694,16 +696,23 @@ task_blocks_on_lock(struct rt_mutex_wait
 	 */
 #ifndef ALL_TASKS_PI
 	if (!rt_task(task)) {
-		plist_add(&waiter->list, &lock->wait_list);
+		if (lock->wait_list)
+			plist_add(&waiter->list, lock->wait_list);
+		else
+			lock->wait_list = &waiter->list;
 		return;
 	}
 #endif
 	spin_lock(&pi_lock);
 	plist_add(&waiter->pi_list, &lock->owner->pi_waiters);
+
 	/*
 	 * Add RT tasks to the head:
 	 */
-	plist_add(&waiter->list, &lock->wait_list);
+	if (lock->wait_list)
+		plist_add(&waiter->list, lock->wait_list);
+	else
+		lock->wait_list = &waiter->list;
 	/*
 	 * If the waiter has higher priority than the owner
 	 * then temporarily boost the owner:
@@ -721,7 +730,7 @@ static void __init_rt_mutex(struct rt_mu
 {
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
-	plist_init(&lock->wait_list, MAX_PRIO);
+	lock->wait_list = NULL;
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	lock->save_state = save_state;
 	INIT_LIST_HEAD(&lock->held_list);
@@ -771,7 +780,7 @@ static inline struct task_struct * pick_
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	waiter = plist_entry(lock->wait_list, struct rt_mutex_waiter, list);
 
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
@@ -779,7 +788,11 @@ static inline struct task_struct * pick_
 	check_pi_list_present(lock, waiter, old_owner);
 #endif
 	new_owner = waiter->task;
-	plist_del_init(&waiter->list, &lock->wait_list);
+	if (plist_empty(lock->wait_list)) {
+		plist_del_init(&waiter->list, lock->wait_list);
+		lock->wait_list = NULL;
+	} else
+		plist_del_init(&waiter->list, lock->wait_list);
 
 	plist_del(&waiter->pi_list, &old_owner->pi_waiters);
 	plist_init(&waiter->pi_list, waiter->task->prio);
@@ -796,9 +809,6 @@ static inline struct task_struct * pick_
 
 static inline void init_lists(struct rt_mutex *lock)
 {
-	// we have to do this until the static initializers get fixed:
-	if (!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next)
-		plist_init(&lock->wait_list, MAX_PRIO);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	if (!lock->held_list.prev && !lock->held_list.next)
 		INIT_LIST_HEAD(&lock->held_list);
@@ -927,7 +937,7 @@ static void __sched __down(struct rt_mut
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(lock->wait_list && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1024,7 +1034,7 @@ static void __sched __down_mutex(struct 
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(lock->wait_list && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1164,7 +1174,7 @@ static int __sched __down_interruptible(
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(lock->wait_list && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1201,7 +1211,11 @@ wait_again:
 			trace_lock_irq(&trace_lock);
 			spin_lock(&lock->wait_lock);
 			if (waiter.task) {
-				plist_del_init(&waiter.list, &lock->wait_list);
+				if (plist_empty(lock->wait_list)) {
+					plist_del_init(&waiter.list, lock->wait_list);
+					lock->wait_list = NULL;
+				} else
+					plist_del_init(&waiter.list, lock->wait_list);
 				/*
 				 * Just remove ourselves from the PI list.
 				 * (No big problem if our PI effect lingers
@@ -1257,7 +1271,7 @@ static int __down_trylock(struct rt_mute
 	if (grab_lock(lock,task)) {
 		/* granted */
 		struct task_struct *old_owner = lock->owner;
-		TRACE_WARN_ON(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON(lock->wait_list && !old_owner);
 		spin_lock(&pi_lock);
 		set_new_owner(lock, old_owner, task, eip);
 		spin_unlock(&pi_lock);
@@ -1324,7 +1338,6 @@ static void __up_mutex(struct rt_mutex *
 	trace_lock_irqsave(&trace_lock, flags);
 	TRACE_BUG_ON(!irqs_disabled());
 	spin_lock(&lock->wait_lock);
-	TRACE_BUG_ON(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	TRACE_WARN_ON(list_empty(&lock->held_list));
@@ -1334,12 +1347,12 @@ static void __up_mutex(struct rt_mutex *
 
 	old_owner = lock->owner;
 #ifdef ALL_TASKS_PI
-	if (plist_empty(&lock->wait_list))
+	if (lock->wait_list)
 		check_pi_list_empty(lock, old_owner);
 #endif
 	lock->owner = NULL;
 	new_owner = NULL;
-	if (!plist_empty(&lock->wait_list))
+	if (lock->wait_list)
 		new_owner = pick_new_owner(lock, old_owner, save_state, eip);
 
 	/*



