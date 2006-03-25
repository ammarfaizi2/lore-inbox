Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWCYStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWCYStt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWCYStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62881 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932240AbWCYSth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:49:37 -0500
Date: Sat, 25 Mar 2006 19:46:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 10/10] PI-futex: FUTEX_LOCK_PI/FUTEX_UNLOCK_PI support
Message-ID: <20060325184654.GK16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

this adds the actual pi-futex implementation, based on rt-mutexes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/futex.h |    6 
 include/linux/sched.h |    3 
 kernel/exit.c         |    8 
 kernel/fork.c         |    3 
 kernel/futex.c        |  696 +++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/futex_compat.c |   11 
 6 files changed, 686 insertions(+), 41 deletions(-)

Index: linux-pi-futex.mm.q/include/linux/futex.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/futex.h
+++ linux-pi-futex.mm.q/include/linux/futex.h
@@ -12,6 +12,8 @@
 #define FUTEX_REQUEUE		3
 #define FUTEX_CMP_REQUEUE	4
 #define FUTEX_WAKE_OP		5
+#define FUTEX_LOCK_PI		6
+#define FUTEX_UNLOCK_PI		7
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
@@ -97,10 +99,14 @@ extern int handle_futex_death(u32 __user
 
 #ifdef CONFIG_FUTEX
 extern void exit_robust_list(struct task_struct *curr);
+extern void exit_pi_state_list(struct task_struct *curr);
 #else
 static inline void exit_robust_list(struct task_struct *curr)
 {
 }
+static inline void exit_pi_state_list(struct task_struct *curr)
+{
+}
 #endif
 
 #define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
Index: linux-pi-futex.mm.q/include/linux/sched.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sched.h
+++ linux-pi-futex.mm.q/include/linux/sched.h
@@ -705,6 +705,7 @@ static inline void prefetch_stack(struct
 
 struct audit_context;		/* See audit.c */
 struct mempolicy;
+struct futex_pi_state;
 
 enum sleep_type {
 	SLEEP_NORMAL,
@@ -917,6 +918,8 @@ struct task_struct {
 #ifdef CONFIG_COMPAT
 	struct compat_robust_list_head __user *compat_robust_list;
 #endif
+	struct list_head pi_state_list;
+	struct futex_pi_state *pi_state_cache;
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
Index: linux-pi-futex.mm.q/kernel/exit.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/exit.c
+++ linux-pi-futex.mm.q/kernel/exit.c
@@ -928,6 +928,14 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->mempolicy = NULL;
 #endif
 	/*
+	 * This must happen late, after the PID is not
+	 * hashed anymore:
+	 */
+	if (unlikely(!list_empty(&tsk->pi_state_list)))
+		exit_pi_state_list(tsk);
+	if (unlikely(current->pi_state_cache))
+		kfree(current->pi_state_cache);
+	/*
 	 * If DEBUG_MUTEXES is on, make sure we are holding no locks:
 	 */
 	mutex_debug_check_no_locks_held(tsk);
Index: linux-pi-futex.mm.q/kernel/fork.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/fork.c
+++ linux-pi-futex.mm.q/kernel/fork.c
@@ -1087,6 +1087,9 @@ static task_t *copy_process(unsigned lon
 #ifdef CONFIG_COMPAT
 	p->compat_robust_list = NULL;
 #endif
+	INIT_LIST_HEAD(&p->pi_state_list);
+	p->pi_state_cache = NULL;
+
 	/*
 	 * sigaltstack should be cleared when sharing the same VM
 	 */
Index: linux-pi-futex.mm.q/kernel/futex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/futex.c
+++ linux-pi-futex.mm.q/kernel/futex.c
@@ -12,6 +12,10 @@
  *  (C) Copyright 2006 Red Hat Inc, All Rights Reserved
  *  Thanks to Thomas Gleixner for suggestions, analysis and fixes.
  *
+ *  PI-futex support started by Ingo Molnar and Thomas Gleixner
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -44,6 +48,7 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/rtmutex_internal.h>
 #include <asm/futex.h>
 
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
@@ -75,6 +80,27 @@ union futex_key {
 };
 
 /*
+ * Priority Inheritance state:
+ */
+struct futex_pi_state {
+	/*
+	 * list of 'owned' pi_state instances - these have to be
+	 * cleaned up in do_exit() if the task exits prematurely:
+	 */
+	struct list_head list;
+
+	/*
+	 * The PI object:
+	 */
+	struct rt_mutex pi_mutex;
+
+	struct task_struct *owner;
+	atomic_t refcount;
+
+	union futex_key key;
+};
+
+/*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
  * we can wake only the relevant ones (hashed queues may be shared).
  *
@@ -96,6 +122,10 @@ struct futex_q {
 	/* For fd, sigio sent using these: */
 	int fd;
 	struct file *filp;
+
+	/* Optional priority inheritance state: */
+	struct futex_pi_state *pi_state;
+	struct task_struct *task;
 };
 
 /*
@@ -260,6 +290,228 @@ static inline int get_futex_value_locked
 }
 
 /*
+ * Fault handling. Called with current->mm->mmap_sem held.
+ */
+static int futex_handle_fault(unsigned long address, int attempt)
+{
+	struct vm_area_struct * vma;
+	struct mm_struct *mm = current->mm;
+
+	if (attempt >= 2 || !(vma = find_vma(mm, address)) ||
+	    vma->vm_start > address || !(vma->vm_flags & VM_WRITE))
+		return -EFAULT;
+
+	switch (handle_mm_fault(mm, vma, address, 1)) {
+	case VM_FAULT_MINOR:
+		current->min_flt++;
+		break;
+	case VM_FAULT_MAJOR:
+		current->maj_flt++;
+		break;
+	default:
+		return -EFAULT;
+	}
+	return 0;
+}
+
+/*
+ * PI code:
+ */
+static int refill_pi_state_cache(void)
+{
+	struct futex_pi_state *pi_state;
+
+	if (likely(current->pi_state_cache))
+		return 0;
+
+	pi_state = kmalloc(sizeof(*pi_state), GFP_KERNEL);
+
+	if (!pi_state)
+		return -ENOMEM;
+
+	memset(pi_state, 0, sizeof(*pi_state));
+	INIT_LIST_HEAD(&pi_state->list);
+	/* pi_mutex gets initialized later */
+	pi_state->owner = NULL;
+	atomic_set(&pi_state->refcount, 1);
+
+	current->pi_state_cache = pi_state;
+
+	return 0;
+}
+
+static struct futex_pi_state * alloc_pi_state(void)
+{
+	struct futex_pi_state *pi_state = current->pi_state_cache;
+
+	WARN_ON(!pi_state);
+	current->pi_state_cache = NULL;
+
+	return pi_state;
+}
+
+static void free_pi_state(struct futex_pi_state *pi_state)
+{
+	if (!atomic_dec_and_test(&pi_state->refcount))
+		return;
+
+	WARN_ON(!pi_state->owner);
+	WARN_ON(!rt_mutex_is_locked(&pi_state->pi_mutex));
+
+	spin_lock(&pi_state->owner->pi_lock);
+	list_del_init(&pi_state->list);
+	spin_unlock(&pi_state->owner->pi_lock);
+
+	rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+
+	if (current->pi_state_cache)
+		kfree(pi_state);
+	else {
+		/*
+		 * pi_state->list is already empty.
+		 * clear pi_state->owner.
+		 * refcount is at 0 - put it back to 1.
+		 */
+		pi_state->owner = NULL;
+		atomic_set(&pi_state->refcount, 1);
+		current->pi_state_cache = pi_state;
+	}
+}
+
+/*
+ * Look up the task based on what TID userspace gave us.
+ * We dont trust it.
+ */
+static struct task_struct * futex_find_get_task(pid_t pid)
+{
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+	if ((current->euid != p->euid) && (current->euid != p->uid)) {
+		p = NULL;
+		goto out_unlock;
+	}
+	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE) {
+		p = NULL;
+		goto out_unlock;
+	}
+	get_task_struct(p);
+out_unlock:
+	read_unlock(&tasklist_lock);
+
+	return p;
+}
+
+/*
+ * This task is holding PI mutexes at exit time => bad.
+ * Kernel cleans up PI-state, but userspace is likely hosed.
+ * (Robust-futex cleanup is separate and might save the day for userspace.)
+ */
+void exit_pi_state_list(struct task_struct *curr)
+{
+	struct futex_hash_bucket *hb;
+	struct list_head *next, *head = &curr->pi_state_list;
+	struct futex_pi_state *pi_state;
+	union futex_key key;
+
+	/*
+	 * We are a ZOMBIE and nobody can enqueue itself on
+	 * pi_state_list anymore, but we have to be careful
+	 * versus waiters unqueueing themselfs
+	 */
+	spin_lock(&curr->pi_lock);
+	while (!list_empty(head)) {
+		
+		next = head->next;
+		pi_state = list_entry(next, struct futex_pi_state, list);
+		key = pi_state->key;
+		spin_unlock(&curr->pi_lock);
+
+		hb = hash_futex(&key);
+		spin_lock(&hb->lock);
+
+		spin_lock(&curr->pi_lock);
+		if (head->next != next) {
+			spin_unlock(&hb->lock);
+			continue;
+		}
+		
+		list_del_init(&pi_state->list);
+
+		WARN_ON(pi_state->owner != curr);
+
+		pi_state->owner = NULL;
+		spin_unlock(&curr->pi_lock);
+
+		rt_mutex_unlock(&pi_state->pi_mutex);
+
+		spin_unlock(&hb->lock);
+
+		spin_lock(&curr->pi_lock);
+	}
+	spin_unlock(&curr->pi_lock);
+}
+
+static int
+lookup_pi_state(u32 uval, struct futex_hash_bucket *hb, struct futex_q *me)
+{
+	struct futex_pi_state *pi_state = NULL;
+	struct futex_q *this, *next;
+	struct list_head *head;
+	struct task_struct *p;
+	pid_t pid;
+
+	head = &hb->chain;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &me->key)) {
+			/*
+			 * Another waiter already exists - bump up
+			 * the refcount and return its pi_state:
+			 */
+			pi_state = this->pi_state;
+			atomic_inc(&pi_state->refcount);
+			me->pi_state = pi_state;
+
+			return 0;
+		}
+	}
+	/*
+	 * We are the first waiter - try to look up the real owner and
+	 * attach the new pi_state to it:
+	 */
+	pid = uval & FUTEX_TID_MASK;
+	p = futex_find_get_task(pid);
+	if (!p)
+		return -ESRCH;
+
+	pi_state = alloc_pi_state();
+
+	/*
+	 * Initialize the pi_mutex in locked state and make 'p'
+	 * the owner of it:
+	 */
+	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
+
+	/* Store the key for possible exit cleanups: */
+	pi_state->key = me->key;
+
+	spin_lock(&p->pi_lock);
+	list_add(&pi_state->list, &p->pi_state_list);
+	pi_state->owner = p;
+	spin_unlock(&p->pi_lock);
+
+	put_task_struct(p);
+
+	me->pi_state = pi_state;
+
+	return 0;
+}
+
+/*
  * The hash bucket lock must be held when this is called.
  * Afterwards, the futex_q must not be accessed.
  */
@@ -286,6 +538,70 @@ static void wake_futex(struct futex_q *q
 	q->lock_ptr = NULL;
 }
 
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this)
+{
+	struct task_struct *new_owner;
+	struct futex_pi_state *pi_state = this->pi_state;
+	u32 curval, newval;
+
+	if (!pi_state)
+		return -EINVAL;
+
+	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
+
+	/*
+	 * This happens when we have stolen the lock and the original
+	 * pending owner did not enqueue itself back on the rt_mutex.
+	 * Thats not a tragedy. We know that way, that a lock waiter
+	 * is on the fly. We make the futex_q waiter the pending owner.
+	 */
+	if (!new_owner)
+		new_owner = this->task;
+
+	/*
+	 * We pass it to the next owner. (The WAITERS bit is always
+	 * kept enabled while there is PI state around. We must also
+	 * preserve the owner died bit.)
+	 */
+	newval = (uval & FUTEX_OWNER_DIED) | FUTEX_WAITERS | new_owner->pid;
+
+	inc_preempt_count();
+	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
+	dec_preempt_count();
+
+	if (curval == -EFAULT)
+		return -EFAULT;
+	if (curval != uval)
+		return -EINVAL;
+
+	list_del_init(&pi_state->owner->pi_state_list);
+	list_add(&pi_state->list, &new_owner->pi_state_list);
+	pi_state->owner = new_owner;
+	rt_mutex_unlock(&pi_state->pi_mutex);
+
+	return 0;
+}
+
+static int unlock_futex_pi(u32 __user *uaddr, u32 uval)
+{
+	u32 oldval;
+
+	/*
+	 * There is no waiter, so we unlock the futex. The owner died
+	 * bit has not to be preserved here. We are the owner:
+	 */
+	inc_preempt_count();
+	oldval = futex_atomic_cmpxchg_inatomic(uaddr, uval, 0);
+	dec_preempt_count();
+
+	if (oldval == -EFAULT)
+		return oldval;
+	if (oldval != uval)
+		return -EAGAIN;
+
+	return 0;
+}
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
@@ -310,6 +626,8 @@ static int futex_wake(u32 __user *uaddr,
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
+			if (this->pi_state)
+				return -EINVAL;
 			wake_futex(this);
 			if (++ret >= nr_wake)
 				break;
@@ -386,27 +704,9 @@ retry:
 		 * still holding the mmap_sem.
 		 */
 		if (attempt++) {
-			struct vm_area_struct * vma;
-			struct mm_struct *mm = current->mm;
-			unsigned long address = (unsigned long)uaddr2;
-
-			ret = -EFAULT;
-			if (attempt >= 2 ||
-			    !(vma = find_vma(mm, address)) ||
-			    vma->vm_start > address ||
-			    !(vma->vm_flags & VM_WRITE))
+			if (futex_handle_fault((unsigned long)uaddr2,
+					       attempt))
 				goto out;
-
-			switch (handle_mm_fault(mm, vma, address, 1)) {
-			case VM_FAULT_MINOR:
-				current->min_flt++;
-				break;
-			case VM_FAULT_MAJOR:
-				current->maj_flt++;
-				break;
-			default:
-				goto out;
-			}
 			goto retry;
 		}
 
@@ -573,6 +873,7 @@ queue_lock(struct futex_q *q, int fd, st
 static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	list_add_tail(&q->list, &hb->chain);
+	q->task = current;
 	spin_unlock(&hb->lock);
 }
 
@@ -627,6 +928,11 @@ static int unqueue_me(struct futex_q *q)
 		}
 		WARN_ON(list_empty(&q->list));
 		list_del(&q->list);
+
+		if (q->pi_state)
+			free_pi_state(q->pi_state);
+		q->pi_state = NULL;
+
 		spin_unlock(lock_ptr);
 		ret = 1;
 	}
@@ -637,14 +943,16 @@ static int unqueue_me(struct futex_q *q)
 
 static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	struct task_struct *curr = current;
+	DECLARE_WAITQUEUE(wait, curr);
 	struct futex_hash_bucket *hb;
 	struct futex_q q;
 	u32 uval;
 	int ret;
 
+	q.pi_state = NULL;
  retry:
-	down_read(&current->mm->mmap_sem);
+	down_read(&curr->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr, &q.key);
 	if (unlikely(ret != 0))
@@ -681,7 +989,7 @@ static int futex_wait(u32 __user *uaddr,
 		 * If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
 		 */
-		up_read(&current->mm->mmap_sem);
+		up_read(&curr->mm->mmap_sem);
 
 		ret = get_user(uval, uaddr);
 
@@ -689,11 +997,9 @@ static int futex_wait(u32 __user *uaddr,
 			goto retry;
 		return ret;
 	}
-	if (uval != val) {
-		ret = -EWOULDBLOCK;
-		queue_unlock(&q, hb);
-		goto out_release_sem;
-	}
+	ret = -EWOULDBLOCK;
+	if (uval != val)
+		goto out_unlock_release_sem;
 
 	/* Only actually queue if *uaddr contained val.  */
 	__queue_me(&q, hb);
@@ -701,8 +1007,8 @@ static int futex_wait(u32 __user *uaddr,
 	/*
 	 * Now the futex is queued and we have checked the data, we
 	 * don't want to hold mmap_sem while we sleep.
-	 */	
-	up_read(&current->mm->mmap_sem);
+	 */
+	up_read(&curr->mm->mmap_sem);
 
 	/*
 	 * There might have been scheduling since the queue_me(), as we
@@ -740,8 +1046,306 @@ static int futex_wait(u32 __user *uaddr,
 	 */
 	return -EINTR;
 
+ out_unlock_release_sem:
+	queue_unlock(&q, hb);
+
+ out_release_sem:
+	up_read(&curr->mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * Userspace tried a 0 -> TID atomic transition of the futex value
+ * and failed. The kernel side here does the whole locking operation:
+ * if there are waiters then it will block, it does PI, etc. (Due to
+ * races the kernel might see a 0 value of the futex too.)
+ */
+static int futex_lock_pi(u32 __user *uaddr, int detect,
+			 unsigned long sec, long nsec)
+{
+	struct task_struct *curr = current;
+	struct futex_hash_bucket *hb;
+	u32 uval, newval, curval;
+	struct futex_q q;
+	struct hrtimer_sleeper timeout, *to = NULL;
+	int ret, attempt = 0;
+
+	if (refill_pi_state_cache())
+		return -ENOMEM;
+
+	if (sec != MAX_SCHEDULE_TIMEOUT) {
+		to = &timeout;
+		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
+		hrtimer_init_sleeper(to, current);
+		to->timer.expires = ktime_set(sec, nsec);
+	}
+
+	q.pi_state = NULL;
+ retry:
+	down_read(&curr->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &q.key);
+	if (unlikely(ret != 0))
+		goto out_release_sem;
+
+	hb = queue_lock(&q, -1, NULL);
+
+ retry_locked:
+	/*
+	 * To avoid races, we attempt to take the lock here again
+	 * (by doing a 0 -> TID atomic cmpxchg), while holding all
+	 * the locks. It will most likely not succeed.
+	 */
+	newval = current->pid;
+
+	inc_preempt_count();
+	curval = futex_atomic_cmpxchg_inatomic(uaddr, 0, newval);
+	dec_preempt_count();
+
+	if (unlikely(curval == -EFAULT))
+		goto uaddr_faulted;
+
+	/* We own the lock already */
+	if (unlikely((curval & FUTEX_TID_MASK) == current->pid)) {
+		if (!detect && 0)
+			force_sig(SIGKILL, current);
+		ret = -EDEADLK;
+		goto out_unlock_release_sem;
+	}
+
+	/*
+	 * Surprise - we got the lock. Just return
+	 * to userspace:
+	 */
+	if (unlikely(!curval))
+		goto out_unlock_release_sem;
+
+	uval = curval;
+	newval = uval | FUTEX_WAITERS;
+
+	inc_preempt_count();
+	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
+	dec_preempt_count();
+
+	if (unlikely(curval == -EFAULT))
+		goto uaddr_faulted;
+	if (unlikely(curval != uval))
+		goto retry_locked;
+
+	/*
+	 * We dont have the lock. Look up the PI state (or create it if
+	 * we are the first waiter):
+	 */
+	ret = lookup_pi_state(uval, hb, &q);
+	if (unlikely(ret))
+		goto out_unlock_release_sem;
+
+	/*
+	 * Only actually queue now that the atomic ops are done:
+	 */
+	__queue_me(&q, hb);
+
+	/*
+	 * Now the futex is queued and we have checked the data, we
+	 * don't want to hold mmap_sem while we sleep.
+	 */
+	up_read(&curr->mm->mmap_sem);
+
+	WARN_ON(!q.pi_state);
+	/*
+	 * Block on the PI mutex:
+	 */
+	ret = rt_mutex_timed_lock(&q.pi_state->pi_mutex, to, 1);
+
+	/*
+	 * Got the lock. We might not be the anticipated owner if we
+	 * did a lock-steal - fix up the PI-state in that case.
+	 */
+	if (!ret && q.pi_state->owner != curr) {
+		u32 newtid = current->pid | FUTEX_WAITERS;
+
+		down_read(&curr->mm->mmap_sem);
+		hb = queue_lock(&q, -1, NULL);
+
+		/* Owner died? */
+		if (q.pi_state->owner != NULL) {
+			spin_lock(&q.pi_state->owner->pi_lock);
+			list_del_init(&q.pi_state->list);
+			spin_unlock(&q.pi_state->owner->pi_lock);
+		} else
+			newtid |= FUTEX_OWNER_DIED;
+
+		q.pi_state->owner = current;
+
+		spin_lock(&current->pi_lock);
+		list_add(&q.pi_state->list, &current->pi_state_list);
+		spin_unlock(&current->pi_lock);
+
+		queue_unlock(&q, hb);
+		up_read(&curr->mm->mmap_sem);
+		/*
+		 * We own it, so we have to replace the pending owner
+		 * TID. This must be atomic as we have preserve the
+		 * owner died bit here.
+		 */
+		ret = get_user(uval, uaddr);
+		while (!ret) {
+			newval = (uval & FUTEX_OWNER_DIED) | newtid;
+			curval = futex_atomic_cmpxchg_inatomic(uaddr,
+							       uval, newval);
+			if (curval == -EFAULT)
+				ret = -EFAULT;
+			if (curval == uval)
+				break;
+			uval = curval;
+		}
+	}
+
+	unqueue_me(&q);
+
+	if (!detect && ret == -EDEADLK && 0)
+		force_sig(SIGKILL, current);
+
+	return ret;
+
+ out_unlock_release_sem:
+	queue_unlock(&q, hb);
+
  out_release_sem:
+	up_read(&curr->mm->mmap_sem);
+	return ret;
+
+ uaddr_faulted:
+	/*
+	 * We have to r/w  *(int __user *)uaddr, but we can't modify it
+	 * non-atomically.  Therefore, if get_user below is not
+	 * enough, we need to handle the fault ourselves, while
+	 * still holding the mmap_sem.
+	 */
+	if (attempt++) {
+		if (futex_handle_fault((unsigned long)uaddr, attempt))
+			goto out_unlock_release_sem;
+
+		goto retry_locked;
+	}
+
+	queue_unlock(&q, hb);
+	up_read(&curr->mm->mmap_sem);
+
+	ret = get_user(uval, uaddr);
+	if (!ret && (uval != -EFAULT))
+		goto retry;
+
+	return ret;
+}
+
+/*
+ * Userspace attempted a TID -> 0 atomic transition, and failed.
+ * This is the in-kernel slowpath: we look up the PI state (if any),
+ * and do the rt-mutex unlock.
+ */
+static int futex_unlock_pi(u32 __user *uaddr)
+{
+	struct futex_hash_bucket *hb;
+	struct futex_q *this, *next;
+	u32 uval;
+	struct list_head *head;
+	union futex_key key;
+	int ret, attempt = 0;
+
+retry:
+	if (get_user(uval, uaddr))
+		return -EFAULT;
+	/*
+	 * We release only a lock we actually own:
+	 */
+	if ((uval & FUTEX_TID_MASK) != current->pid)
+		return -EPERM;
+	/*
+	 * First take all the futex related locks:
+	 */
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &key);
+	if (unlikely(ret != 0))
+		goto out;
+
+	hb = hash_futex(&key);
+	spin_lock(&hb->lock);
+
+retry_locked:
+	/*
+	 * To avoid races, try to do the TID -> 0 atomic transition
+	 * again. If it succeeds then we can return without waking
+	 * anyone else up:
+	 */
+	inc_preempt_count();
+	uval = futex_atomic_cmpxchg_inatomic(uaddr, current->pid, 0);
+	dec_preempt_count();
+
+	if (unlikely(uval == -EFAULT))
+		goto pi_faulted;
+	/*
+	 * Rare case: we managed to release the lock atomically,
+	 * no need to wake anyone else up:
+	 */
+	if (unlikely(uval == current->pid))
+		goto out_unlock;
+
+	/*
+	 * Ok, other tasks may need to be woken up - check waiters
+	 * and do the wakeup if necessary:
+	 */
+	head = &hb->chain;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (!match_futex (&this->key, &key))
+			continue;
+		ret = wake_futex_pi(uaddr, uval, this);
+		/*
+		 * The atomic access to the futex value
+		 * generated a pagefault, so retry the
+		 * user-access and the wakeup:
+		 */
+		if (ret == -EFAULT)
+			goto pi_faulted;
+		goto out_unlock;
+	}
+	/*
+	 * No waiters - kernel unlocks the futex:
+	 */
+	ret = unlock_futex_pi(uaddr, uval);
+	if (ret == -EFAULT)
+		goto pi_faulted;
+
+out_unlock:
+	spin_unlock(&hb->lock);
+out:
 	up_read(&current->mm->mmap_sem);
+
+	return ret;
+
+pi_faulted:
+	/*
+	 * We have to r/w  *(int __user *)uaddr, but we can't modify it
+	 * non-atomically.  Therefore, if get_user below is not
+	 * enough, we need to handle the fault ourselves, while
+	 * still holding the mmap_sem.
+	 */
+	if (attempt++) {
+		if (futex_handle_fault((unsigned long)uaddr, attempt))
+			goto out_unlock;
+
+		goto retry_locked;
+	}
+
+	spin_unlock(&hb->lock);
+	up_read(&current->mm->mmap_sem);
+
+	ret = get_user(uval, uaddr);
+	if (!ret && (uval != -EFAULT))
+		goto retry;
+
 	return ret;
 }
 
@@ -820,6 +1424,7 @@ static int futex_fd(u32 __user *uaddr, i
 		err = -ENOMEM;
 		goto error;
 	}
+	q->pi_state = NULL;
 
 	down_read(&current->mm->mmap_sem);
 	err = get_futex_key(uaddr, &q->key);
@@ -857,7 +1462,7 @@ error:
  * Implementation: user-space maintains a per-thread list of locks it
  * is holding. Upon do_exit(), the kernel carefully walks this list,
  * and marks all locks that are owned by this thread with the
- * FUTEX_OWNER_DEAD bit, and wakes up a waiter (if any). The list is
+ * FUTEX_OWNER_DIED bit, and wakes up a waiter (if any). The list is
  * always manipulated with the lock held, so the list is private and
  * per-thread. Userspace also maintains a per-thread 'list_op_pending'
  * field, to allow the kernel to clean up if the thread dies after
@@ -932,7 +1537,7 @@ err_unlock:
  */
 int handle_futex_death(u32 __user *uaddr, struct task_struct *curr)
 {
-	u32 uval;
+	u32 uval, nval;
 
 retry:
 	if (get_user(uval, uaddr))
@@ -949,8 +1554,12 @@ retry:
 		 * thread-death.) The rest of the cleanup is done in
 		 * userspace.
 		 */
-		if (futex_atomic_cmpxchg_inatomic(uaddr, uval,
-					 uval | FUTEX_OWNER_DIED) != uval)
+		nval = futex_atomic_cmpxchg_inatomic(uaddr, uval,
+						     uval | FUTEX_OWNER_DIED);
+		if (nval == -EFAULT)
+			return -1;
+
+		if (nval != uval)
 			goto retry;
 
 		if (uval & FUTEX_WAITERS)
@@ -995,7 +1604,7 @@ void exit_robust_list(struct task_struct
 	while (entry != &head->list) {
 		/*
 		 * A pending lock might already be on the list, so
-		 * dont process it twice:
+		 * don't process it twice:
 		 */
 		if (entry != pending)
 			if (handle_futex_death((void *)entry + futex_offset,
@@ -1041,6 +1650,12 @@ long do_futex(u32 __user *uaddr, int op,
 	case FUTEX_WAKE_OP:
 		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
 		break;
+	case FUTEX_LOCK_PI:
+		ret = futex_lock_pi(uaddr, val, timeout, val2);
+		break;
+	case FUTEX_UNLOCK_PI:
+		ret = futex_unlock_pi(uaddr);
+		break;
 	default:
 		ret = -ENOSYS;
 	}
@@ -1056,17 +1671,22 @@ asmlinkage long sys_futex(u32 __user *ua
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	u32 val2 = 0;
 
-	if (utime && (op == FUTEX_WAIT)) {
+	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
 		if (copy_from_user(&t, utime, sizeof(t)) != 0)
 			return -EFAULT;
 		if (!timespec_valid(&t))
 			return -EINVAL;
-		timeout = timespec_to_jiffies(&t) + 1;
+		if (op == FUTEX_WAIT)
+			timeout = timespec_to_jiffies(&t) + 1;
+		else {
+			timeout = t.tv_sec;
+			val2 = t.tv_nsec;
+		}
 	}
 	/*
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
 	 */
-	if (op >= FUTEX_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
 		val2 = (u32) (unsigned long) utime;
 
 	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
Index: linux-pi-futex.mm.q/kernel/futex_compat.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/futex_compat.c
+++ linux-pi-futex.mm.q/kernel/futex_compat.c
@@ -129,14 +129,19 @@ asmlinkage long compat_sys_futex(u32 __u
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	int val2 = 0;
 
-	if (utime && (op == FUTEX_WAIT)) {
+	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
 		if (get_compat_timespec(&t, utime))
 			return -EFAULT;
 		if (!timespec_valid(&t))
 			return -EINVAL;
-		timeout = timespec_to_jiffies(&t) + 1;
+		if (op == FUTEX_WAIT)
+			timeout = timespec_to_jiffies(&t) + 1;
+		else {
+			timeout = t.tv_sec;
+			val2 = t.tv_nsec;
+		}
 	}
-	if (op >= FUTEX_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
 		val2 = (int) (unsigned long) utime;
 
 	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
