Return-Path: <linux-kernel-owner+w=401wt.eu-S964993AbWLMQTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWLMQTz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWLMQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:19:55 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38933 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965003AbWLMQTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:19:52 -0500
X-Greylist: delayed 2185 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:19:51 EST
Message-ID: <45801FA4.8040403@bull.net>
Date: Wed, 13 Dec 2006 16:43:32 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
Subject: [PATCH 2.6.19-rt12][RFC] - futex_requeue_pi implementation (requeue
 from futex1 to PI-futex2)
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/12/2006 16:50:57,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/12/2006 16:50:58,
	Serialize complete at 13/12/2006 16:50:58
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the introduction of the PI-futex (used for the PI-pthread_mutex in
the glibc), the current futex_requeue optimization (*) can not be used
any more if the pthread_mutex used with the pthread-condvar is a PI-mutex.

(*) this optimization is used in pthread_cond_broadcast.

To use this optimization with PI-mutex, we need a function that
re-queues some threads from a normal futex  to a PI-futex (see why in
this discussion:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115020355126851&w=2 )

Here is a proposal of an implementation of futex_requeue_pi.
(Only the 32-bits version has been implemented for now)

To use or test this patch with pthreads, you will need to patch the
glibc. The glibc patch is available here:
http://www.bullopensource.org/posix/pi-futex/glibc_requeue_pi.diff
(Only available for ix86 architecture)
or use the generic pthread_cond_broadcast.c file
(patch here:
http://www.bullopensource.org/posix/pi-futex/glibc_pth_broadcast_c_file.diff
)

I'll send some explanations in a separate mail.

The code has been tested and seems to work fine but is probably, heu,
"perfectible" ...
So, comments, suggestions, feedbacks are welcome.

---

  include/linux/futex.h   |    8
  kernel/futex.c          |  583 ++++++++++++++++++++++++++++++++++++++++++------
  kernel/futex_compat.c   |    3
  kernel/rtmutex.c        |   43 ---
  kernel/rtmutex_common.h |   36 ++
  5 files changed, 575 insertions(+), 98 deletions(-)

---

Signed-off-by: Pierre Peiffer <pierre.peiffer@bull.net>
---

Index: linux-2.6/include/linux/futex.h
===================================================================
--- linux-2.6.orig/include/linux/futex.h	2006-12-12 16:38:00.000000000 +0100
+++ linux-2.6/include/linux/futex.h	2006-12-12 16:43:53.000000000 +0100
@@ -15,6 +15,7 @@
  #define FUTEX_LOCK_PI		6
  #define FUTEX_UNLOCK_PI		7
  #define FUTEX_TRYLOCK_PI	8
+#define FUTEX_CMP_REQUEUE_PI	9

  /*
   * Support for robust futexes: the kernel cleans up held futexes at
@@ -83,9 +84,14 @@ struct robust_list_head {
  #define FUTEX_OWNER_DIED	0x40000000

  /*
+ * Some processes have been requeued on this PI-futex
+ */
+#define FUTEX_WAITER_REQUEUED	0x20000000
+
+/*
   * The rest of the robust-futex field is for the TID:
   */
-#define FUTEX_TID_MASK		0x3fffffff
+#define FUTEX_TID_MASK		0x1fffffff

  /*
   * This limit protects against a deliberately circular list.
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c	2006-12-12 16:38:00.000000000 +0100
+++ linux-2.6/kernel/futex.c	2006-12-13 13:41:29.000000000 +0100
@@ -53,6 +53,12 @@

  #include "rtmutex_common.h"

+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# include "rtmutex-debug.h"
+#else
+# include "rtmutex.h"
+#endif
+
  #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)

  /*
@@ -128,6 +134,10 @@ struct futex_q {
  	/* Optional priority inheritance state: */
  	struct futex_pi_state *pi_state;
  	struct task_struct *task;
+
+	/* This waiter is used in case of requeue from a
+	   normal futex to a PI-futex */
+	struct rt_mutex_waiter waiter;
  };

  /*
@@ -249,6 +259,24 @@ static int get_futex_key(void *uaddr, un
  }

  /*
+ * Retrieve the original address used to compute this key
+ */
+static void *get_futex_address(union futex_key *key)
+{
+	void *uaddr;
+
+	if (key->both.offset & 1)
+		/* shared mapping */
+		uaddr = (void*)((key->shared.pgoff << PAGE_SHIFT)
+				+ key->shared.offset - 1);
+	else
+		/* private mapping */
+		uaddr = (void*)(key->private.address + key->private.offset);
+
+	return uaddr;
+}
+
+/*
   * Take a reference to the resource addressed by a key.
   * Can be called while holding spinlocks.
   *
@@ -463,7 +491,8 @@ void exit_pi_state_list(struct task_stru
  }

  static int
-lookup_pi_state(u32 uval, struct futex_hash_bucket *hb, struct futex_q *me)
+lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
+		union futex_key *key, struct futex_pi_state **ps)
  {
  	struct futex_pi_state *pi_state = NULL;
  	struct futex_q *this, *next;
@@ -474,7 +503,7 @@ lookup_pi_state(u32 uval, struct futex_h
  	head = &hb->chain;

  	plist_for_each_entry_safe(this, next, head, list) {
-		if (match_futex(&this->key, &me->key)) {
+		if (match_futex(&this->key, key)) {
  			/*
  			 * Another waiter already exists - bump up
  			 * the refcount and return its pi_state:
@@ -489,7 +518,7 @@ lookup_pi_state(u32 uval, struct futex_h
  			WARN_ON(!atomic_read(&pi_state->refcount));

  			atomic_inc(&pi_state->refcount);
-			me->pi_state = pi_state;
+			*ps = pi_state;

  			return 0;
  		}
@@ -516,7 +545,7 @@ lookup_pi_state(u32 uval, struct futex_h
  	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);

  	/* Store the key for possible exit cleanups: */
-	pi_state->key = me->key;
+	pi_state->key = *key;

  	spin_lock_irq(&p->pi_lock);
  	WARN_ON(!list_empty(&pi_state->list));
@@ -526,7 +555,7 @@ lookup_pi_state(u32 uval, struct futex_h

  	put_task_struct(p);

-	me->pi_state = pi_state;
+	*ps = pi_state;

  	return 0;
  }
@@ -563,11 +592,12 @@ static int wake_futex_pi(u32 __user *uad
  	struct task_struct *new_owner;
  	struct futex_pi_state *pi_state = this->pi_state;
  	u32 curval, newval;
+	unsigned long flags;

  	if (!pi_state)
  		return -EINVAL;

-	spin_lock(&pi_state->pi_mutex.wait_lock);
+	spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
  	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);

  	/*
@@ -586,28 +616,40 @@ static int wake_futex_pi(u32 __user *uad
  	 */
  	if (!(uval & FUTEX_OWNER_DIED)) {
  		newval = FUTEX_WAITERS | new_owner->pid;
+		/* Keep the FUTEX_WAITER_REQUEUED flag if it was set */
+		newval |= (uval & FUTEX_WAITER_REQUEUED);

  		inc_preempt_count();
  		curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
  		dec_preempt_count();
-		if (curval == -EFAULT)
+		if (curval == -EFAULT) {
+			spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock,
+					       flags);
  			return -EFAULT;
-		if (curval != uval)
+		}
+		if (curval != uval) {
+			spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock,
+					       flags);
  			return -EINVAL;
+		}
+
+		if (uval & FUTEX_WAITER_REQUEUED)
+			rt_mutex_deadlock_account_lock(&pi_state->pi_mutex,
+						       new_owner);
  	}

-	spin_lock_irq(&pi_state->owner->pi_lock);
+	spin_lock(&pi_state->owner->pi_lock);
  	WARN_ON(list_empty(&pi_state->list));
  	list_del_init(&pi_state->list);
-	spin_unlock_irq(&pi_state->owner->pi_lock);
+	spin_unlock(&pi_state->owner->pi_lock);

-	spin_lock_irq(&new_owner->pi_lock);
+	spin_lock(&new_owner->pi_lock);
  	WARN_ON(!list_empty(&pi_state->list));
  	list_add(&pi_state->list, &new_owner->pi_state_list);
  	pi_state->owner = new_owner;
-	spin_unlock_irq(&new_owner->pi_lock);
+	spin_unlock(&new_owner->pi_lock);
+	spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);

-	spin_unlock(&pi_state->pi_mutex.wait_lock);
  	rt_mutex_unlock(&pi_state->pi_mutex);

  	return 0;
@@ -650,6 +692,253 @@ double_lock_hb(struct futex_hash_bucket
  }

  /*
+ * Called from futex_requeue_pi.
+ * Set FUTEX_WAITERS and FUTEX_WAITER_REQUEUED flags on the
+ * PI-futex value; search its associated pi_state if an owner exist
+ * or create a new one without owner.
+ */
+static inline int lookup_pi_state_for_requeue(u32 __user *uaddr,
+					      struct futex_hash_bucket *hb,
+					      union futex_key *key,
+					      struct futex_pi_state **pi_state)
+
+{
+	u32 curval, uval, newval;
+
+retry:
+	/*
+	 * We can't handle a fault cleanly because we can't
+	 * release the locks here. Simply return the fault.
+	 */
+	if (get_futex_value_locked(&curval, uaddr))
+		return -EFAULT;
+
+	/* set the flags FUTEX_WAITERS and FUTEX_WAITER_REQUEUED */
+	if ((curval & (FUTEX_WAITERS | FUTEX_WAITER_REQUEUED))
+	    != (FUTEX_WAITERS | FUTEX_WAITER_REQUEUED)) {
+		/*
+		 * No waiters yet, we prepare the futex to have some waiters.
+		 */
+
+		uval = curval;
+		newval = uval | FUTEX_WAITERS | FUTEX_WAITER_REQUEUED;
+
+		inc_preempt_count();
+		curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
+		dec_preempt_count();
+
+		if (unlikely(curval == -EFAULT))
+			return -EFAULT;
+		if (unlikely(curval != uval))
+			goto retry;
+	}
+
+	if (!(curval & FUTEX_TID_MASK)
+	    || lookup_pi_state(curval, hb, key, pi_state)) {
+		/* the futex has no owner (yet) or the lookup failed:
+		   allocate one pi_state without owner */
+
+		*pi_state = alloc_pi_state();
+
+		/* Already stores the key: */
+		(*pi_state)->key = *key;
+
+		/* init the mutex without owner */
+		__rt_mutex_init(&(*pi_state)->pi_mutex, NULL);
+	}
+
+	return 0;
+}
+
+/*
+ * Keep the first nr_wake waiter from futex1, wake up one,
+ * and requeue the next nr_requeue waiters following hashed on
+ * one physical page to another physical page (PI-futex uaddr2)
+ */
+static int futex_requeue_pi(u32 __user *uaddr1, u32 __user *uaddr2,
+			    int nr_wake, int nr_requeue, u32 *cmpval)
+{
+	union futex_key key1, key2;
+	struct futex_hash_bucket *hb1, *hb2;
+	struct plist_head *head1;
+	struct futex_q *this, *next;
+	struct futex_pi_state *pi_state2 = NULL;
+	struct rt_mutex_waiter *waiter, *top_waiter = NULL;
+	struct rt_mutex *lock2 = NULL;
+	int ret, drop_count = 0;
+	unsigned long flags = 0;
+
+	if (refill_pi_state_cache())
+		return -ENOMEM;
+
+retry:
+	/*
+	 * First take all the futex related locks:
+	 */
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr1, &key1);
+	if (unlikely(ret != 0))
+		goto out;
+	ret = get_futex_key(uaddr2, &key2);
+	if (unlikely(ret != 0))
+		goto out;
+
+	hb1 = hash_futex(&key1);
+	hb2 = hash_futex(&key2);
+
+	double_lock_hb(hb1, hb2);
+
+	if (likely(cmpval != NULL)) {
+		u32 curval;
+
+		ret = get_futex_value_locked(&curval, uaddr1);
+
+		if (unlikely(ret)) {
+			spin_unlock(&hb1->lock);
+			if (hb1 != hb2)
+				spin_unlock(&hb2->lock);
+
+			/*
+			 * If we would have faulted, release mmap_sem, fault
+			 * it in and start all over again.
+			 */
+			up_read(&current->mm->mmap_sem);
+
+			ret = get_user(curval, uaddr1);
+
+			if (!ret)
+				goto retry;
+
+			return ret;
+		}
+		if (curval != *cmpval) {
+			ret = -EAGAIN;
+			goto out_unlock;
+		}
+	}
+
+	head1 = &hb1->chain;
+	plist_for_each_entry_safe(this, next, head1, list) {
+		if (!match_futex (&this->key, &key1))
+			continue;
+		if (++ret <= nr_wake) {
+			wake_futex(this);
+		} else {
+			/*
+			 * FIRST: get and set the pi_state
+			 */
+			if (!pi_state2) {
+				int s;
+				/* do this only the first time we requeue someone */
+				s = lookup_pi_state_for_requeue(uaddr2, hb2,
+								&key2, &pi_state2);
+				if (s) {
+					ret = s;
+					goto out_unlock;
+				}
+
+				lock2 = &pi_state2->pi_mutex;
+				spin_lock_irqsave(&lock2->wait_lock, flags);
+
+				/* Save the top waiter of the wait_list */
+				if (rt_mutex_has_waiters(lock2))
+					top_waiter = rt_mutex_top_waiter(lock2);
+			} else
+				atomic_inc(&pi_state2->refcount);
+
+
+			this->pi_state = pi_state2;
+
+			/*
+			 * SECOND: requeue futex_q to the correct hashbucket
+			 */
+
+			/*
+			 * If key1 and key2 hash to the same bucket, no need to
+			 * requeue.
+			 */
+			if (likely(head1 != &hb2->chain)) {
+				plist_del(&this->list, &hb1->chain);
+				plist_add(&this->list, &hb2->chain);
+				this->lock_ptr = &hb2->lock;
+			}
+			this->key = key2;
+			get_key_refs(&key2);
+			drop_count++;
+
+
+			/*
+			 * THIRD: queue it to lock2
+			 */
+			spin_lock(&this->task->pi_lock);
+			waiter = &this->waiter;
+			waiter->task = this->task;
+			waiter->lock = lock2;
+			plist_node_init(&waiter->list_entry, this->task->prio);
+			plist_node_init(&waiter->pi_list_entry, this->task->prio);
+			plist_add(&waiter->list_entry, &lock2->wait_list);
+			this->task->pi_blocked_on = waiter;
+			spin_unlock(&this->task->pi_lock);
+
+			if (ret - nr_wake >= nr_requeue)
+				break;
+		}
+	}
+
+	/* If we've requeued some tasks and the top_waiter of the rt_mutex
+	   has changed, we must adjust the priority of the owner, if any */
+	if (drop_count) {
+		struct task_struct *owner = rt_mutex_owner(lock2);
+		if (owner &&
+		    (top_waiter != (waiter = rt_mutex_top_waiter(lock2)))) {
+			int chain_walk = 0;
+
+			spin_lock(&owner->pi_lock);
+			if (top_waiter)
+				plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
+			else
+				/*
+				 * There was no waiters before the requeue,
+				 * the flag must be updated
+				 */
+				mark_rt_mutex_waiters(lock2);
+
+			plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+			__rt_mutex_adjust_prio(owner);
+			if (owner->pi_blocked_on) {
+				chain_walk = 1;
+				get_task_struct(owner);
+			}
+
+			spin_unlock(&owner->pi_lock);
+			spin_unlock_irqrestore(&lock2->wait_lock, flags);
+
+			if (chain_walk)
+				rt_mutex_adjust_prio_chain(owner, 0, lock2, NULL,
+							   current);
+		} else {
+			/* No owner or the top_waiter does not change */
+			mark_rt_mutex_waiters(lock2);
+			spin_unlock_irqrestore(&lock2->wait_lock, flags);
+		}
+	}
+
+out_unlock:
+	spin_unlock(&hb1->lock);
+	if (hb1 != hb2)
+		spin_unlock(&hb2->lock);
+
+	/* drop_key_refs() must be called outside the spinlocks. */
+	while (--drop_count >= 0)
+		drop_key_refs(&key1);
+
+out:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+/*
   * Wake up all waiters hashed on the physical page that is mapped
   * to this virtual address:
   */
@@ -990,9 +1279,10 @@ static int unqueue_me(struct futex_q *q)

  /*
   * PI futexes can not be requeued and must remove themself from the
- * hash bucket. The hash bucket lock is held on entry and dropped here.
+ * hash bucket. The hash bucket lock (i.e. lock_ptr) is held on entry
+ * and dropped here.
   */
-static void unqueue_me_pi(struct futex_q *q, struct futex_hash_bucket *hb)
+static void unqueue_me_pi(struct futex_q *q)
  {
  	WARN_ON(plist_node_empty(&q->list));
  	plist_del(&q->list, &q->list.plist);
@@ -1001,11 +1291,65 @@ static void unqueue_me_pi(struct futex_q
  	free_pi_state(q->pi_state);
  	q->pi_state = NULL;

-	spin_unlock(&hb->lock);
+	spin_unlock(q->lock_ptr);

  	drop_key_refs(&q->key);
  }

+/*
+ * Fixup the pi_state owner with current.
+ *
+ * The cur->mm semaphore must be  held, it is released at return of this
+ * function.
+ */
+static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
+				struct futex_hash_bucket *hb,
+				struct task_struct *curr)
+{
+	u32 newtid = curr->pid | FUTEX_WAITERS;
+	struct futex_pi_state *pi_state = q->pi_state;
+	u32 uval, curval, newval;
+	int ret;
+
+	/* Owner died? */
+	if (pi_state->owner != NULL) {
+		spin_lock_irq(&pi_state->owner->pi_lock);
+		WARN_ON(list_empty(&pi_state->list));
+		list_del_init(&pi_state->list);
+		spin_unlock_irq(&pi_state->owner->pi_lock);
+	} else
+		newtid |= FUTEX_OWNER_DIED;
+
+	pi_state->owner = curr;
+
+	spin_lock_irq(&curr->pi_lock);
+	WARN_ON(!list_empty(&pi_state->list));
+	list_add(&pi_state->list, &curr->pi_state_list);
+	spin_unlock_irq(&curr->pi_lock);
+
+	/* Unqueue and drop the lock */
+	unqueue_me_pi(q);
+	up_read(&curr->mm->mmap_sem);
+	/*
+	 * We own it, so we have to replace the pending owner
+	 * TID. This must be atomic as we have preserve the
+	 * owner died bit here.
+	 */
+	ret = get_user(uval, uaddr);
+	while (!ret) {
+		newval = (uval & FUTEX_OWNER_DIED) | newtid;
+		newval |= (uval & FUTEX_WAITER_REQUEUED);
+		curval = futex_atomic_cmpxchg_inatomic(uaddr,
+						       uval, newval);
+		if (curval == -EFAULT)
+ 			ret = -EFAULT;
+		if (curval == uval)
+			break;
+		uval = curval;
+	}
+	return ret;
+}
+
  static int futex_wait(u32 __user *uaddr, u32 val, struct timespec *time)
  {
  	struct task_struct *curr = current;
@@ -1014,7 +1358,7 @@ static int futex_wait(u32 __user *uaddr,
  	struct futex_q q;
  	u32 uval;
  	int ret;
-	struct hrtimer_sleeper t;
+	struct hrtimer_sleeper t, *to = NULL;
  	int rem = 0;

  	q.pi_state = NULL;
@@ -1068,6 +1412,14 @@ static int futex_wait(u32 __user *uaddr,
  	if (uval != val)
  		goto out_unlock_release_sem;

+	/*
+	 * This rt_mutex_waiter structure is prepared here and will
+	 * be used only if this task is requeued from a normal futex to
+	 * a PI-futex with futex_requeue_pi.
+	 */
+	debug_rt_mutex_init_waiter(&q.waiter);
+	q.waiter.task = NULL;
+
  	/* Only actually queue if *uaddr contained val.  */
  	__queue_me(&q, hb);

@@ -1101,7 +1453,7 @@ static int futex_wait(u32 __user *uaddr,
  		if (time->tv_sec == 0 && time->tv_nsec == 0)
  			schedule();
  		else {
-
+			to = &t;
  			hrtimer_init(&t.timer, CLOCK_MONOTONIC,
  				     HRTIMER_MODE_REL);
  			hrtimer_init_sleeper(&t, current);
@@ -1133,6 +1485,67 @@ static int futex_wait(u32 __user *uaddr,
  	 * we are the only user of it.
  	 */

+	if (q.pi_state) {
+		/*
+		 * We were woken but have been requeued on a PI-futex.
+		 * We have to complete the lock acquisition by taking
+		 * the rtmutex.
+		 */
+
+		struct rt_mutex *lock = &q.pi_state->pi_mutex;
+		unsigned long flags;
+
+		spin_lock_irqsave(&lock->wait_lock, flags);
+		if (unlikely(q.waiter.task)) {
+			remove_waiter(lock, &q.waiter, flags);
+		}
+		spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+		if (rem)
+			ret = -ETIMEDOUT;
+		else
+			ret = rt_mutex_timed_lock(lock, to, 1);
+
+		down_read(&curr->mm->mmap_sem);
+		spin_lock(q.lock_ptr);
+
+		/*
+		 * Got the lock. We might not be the anticipated owner if we
+		 * did a lock-steal - fix up the PI-state in that case.
+		 */
+		if (!ret && q.pi_state->owner != curr) {
+			/*
+			 * We MUST play with the futex we were requeued on,
+			 * NOT the current futex.
+			 * We can retrieve it from the key of the pi_state
+			 */
+			uaddr = get_futex_address(&q.pi_state->key);
+
+			/* mmap_sem and hash_bucket lock are unlocked at
+			   return of this function */
+			ret = fixup_pi_state_owner(uaddr, &q, hb, curr);
+		} else {
+			/*
+			 * Catch the rare case, where the lock was released
+			 * when we were on the way back before we locked
+			 * the hash bucket.
+			 */
+			if (ret && q.pi_state->owner == curr) {
+				if (rt_mutex_trylock(&q.pi_state->pi_mutex))
+					ret = 0;
+			}
+			/* Unqueue and drop the lock */
+			unqueue_me_pi(&q);
+			up_read(&curr->mm->mmap_sem);
+		}
+
+		debug_rt_mutex_free_waiter(&q.waiter);
+
+		return ret;
+	}
+
+	debug_rt_mutex_free_waiter(&q.waiter);
+
  	/* If we were woken (and unqueued), we succeeded, whatever. */
  	if (!unqueue_me(&q))
  		return 0;
@@ -1152,6 +1565,52 @@ static int futex_wait(u32 __user *uaddr,
  	return ret;
  }

+static void set_pi_futex_owner(struct futex_hash_bucket *hb,
+			       union futex_key *key, struct task_struct *p)
+{
+	struct plist_head *head;
+	struct futex_q *this, *next;
+	struct futex_pi_state *pi_state = NULL;
+	struct rt_mutex *lock;
+	unsigned long flags;
+
+	/* Search a waiter that should already exists */
+
+	head = &hb->chain;
+
+	plist_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, key)) {
+			pi_state = this->pi_state;
+			break;
+		}
+	}
+
+	BUG_ON(!pi_state);
+
+	/* set p as pi_state's owner */
+	atomic_inc(&pi_state->refcount);
+
+	lock = &pi_state->pi_mutex;
+
+	spin_lock_irqsave(&lock->wait_lock, flags);
+	spin_lock(&p->pi_lock);
+
+	list_add(&pi_state->list, &p->pi_state_list);
+	pi_state->owner = p;
+
+	debug_rt_mutex_proxy_lock(lock, p);
+	WARN_ON(rt_mutex_owner(lock));
+	rt_mutex_set_owner(lock, p, 0);
+	rt_mutex_deadlock_account_lock(lock, p);
+
+	plist_add(&rt_mutex_top_waiter(lock)->pi_list_entry,
+		  &p->pi_waiters);
+	__rt_mutex_adjust_prio(p);
+
+	spin_unlock(&p->pi_lock);
+	spin_unlock_irqrestore(&lock->wait_lock, flags);
+}
+
  /*
   * Userspace tried a 0 -> TID atomic transition of the futex value
   * and failed. The kernel side here does the whole locking operation:
@@ -1166,7 +1625,7 @@ static int futex_lock_pi(u32 __user *uad
  	struct futex_hash_bucket *hb;
  	u32 uval, newval, curval;
  	struct futex_q q;
-	int ret, attempt = 0;
+	int ret, lock_held, attempt = 0;

  	if (refill_pi_state_cache())
  		return -ENOMEM;
@@ -1189,6 +1648,8 @@ static int futex_lock_pi(u32 __user *uad
  	hb = queue_lock(&q, -1, NULL);

   retry_locked:
+	lock_held = 0;
+
  	/*
  	 * To avoid races, we attempt to take the lock here again
  	 * (by doing a 0 -> TID atomic cmpxchg), while holding all
@@ -1207,7 +1668,16 @@ static int futex_lock_pi(u32 __user *uad
  	if (unlikely((curval & FUTEX_TID_MASK) == current->pid)) {
  		if (!detect && 0)
  			force_sig(SIGKILL, current);
-		ret = -EDEADLK;
+		/*
+		 * Normally, this check is done in user space.
+		 * In case of requeue, the owner may attempt to lock this futex,
+		 * even if the ownership has already been given by the previous
+		 * waker.
+		 * In the usual case, this is a case of deadlock, but not in case
+		 * of REQUEUE_PI.
+		 */
+		if (!(curval & FUTEX_WAITER_REQUEUED))
+			ret = -EDEADLK;
  		goto out_unlock_release_sem;
  	}

@@ -1219,7 +1689,18 @@ static int futex_lock_pi(u32 __user *uad
  		goto out_unlock_release_sem;

  	uval = curval;
-	newval = uval | FUTEX_WAITERS;
+	/*
+	 * In case of a requeue, check if there already is an owner
+	 * If not, just take the futex.
+	 */
+	if ((curval & FUTEX_WAITER_REQUEUED) && !(curval & FUTEX_TID_MASK)) {
+		/* set current as futex owner */
+		newval = curval | current->pid;
+		lock_held = 1;
+	} else
+		/* Set the WAITERS flag, so the owner will know it has someone
+		   to wake at next unlock */
+		newval = curval | FUTEX_WAITERS;

  	inc_preempt_count();
  	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
@@ -1230,11 +1711,16 @@ static int futex_lock_pi(u32 __user *uad
  	if (unlikely(curval != uval))
  		goto retry_locked;

+	if (lock_held) {
+		set_pi_futex_owner(hb, &q.key, curr);
+		goto out_unlock_release_sem;
+	}
+
  	/*
  	 * We dont have the lock. Look up the PI state (or create it if
  	 * we are the first waiter):
  	 */
-	ret = lookup_pi_state(uval, hb, &q);
+	ret = lookup_pi_state(uval, hb, &q.key, &q.pi_state);

  	if (unlikely(ret)) {
  		/*
@@ -1297,45 +1783,10 @@ static int futex_lock_pi(u32 __user *uad
  	 * Got the lock. We might not be the anticipated owner if we
  	 * did a lock-steal - fix up the PI-state in that case.
  	 */
-	if (!ret && q.pi_state->owner != curr) {
-		u32 newtid = current->pid | FUTEX_WAITERS;
-
-		/* Owner died? */
-		if (q.pi_state->owner != NULL) {
-			spin_lock_irq(&q.pi_state->owner->pi_lock);
-			WARN_ON(list_empty(&q.pi_state->list));
-			list_del_init(&q.pi_state->list);
-			spin_unlock_irq(&q.pi_state->owner->pi_lock);
-		} else
-			newtid |= FUTEX_OWNER_DIED;
-
-		q.pi_state->owner = current;
-
-		spin_lock_irq(&current->pi_lock);
-		WARN_ON(!list_empty(&q.pi_state->list));
-		list_add(&q.pi_state->list, &current->pi_state_list);
-		spin_unlock_irq(&current->pi_lock);
-
-		/* Unqueue and drop the lock */
-		unqueue_me_pi(&q, hb);
-		up_read(&curr->mm->mmap_sem);
-		/*
-		 * We own it, so we have to replace the pending owner
-		 * TID. This must be atomic as we have preserve the
-		 * owner died bit here.
-		 */
-		ret = get_user(uval, uaddr);
-		while (!ret) {
-			newval = (uval & FUTEX_OWNER_DIED) | newtid;
-			curval = futex_atomic_cmpxchg_inatomic(uaddr,
-							       uval, newval);
-			if (curval == -EFAULT)
-				ret = -EFAULT;
-			if (curval == uval)
-				break;
-			uval = curval;
-		}
-	} else {
+	if (!ret && q.pi_state->owner != curr)
+		/* mmap_sem is unlocked at return of this function */
+		ret = fixup_pi_state_owner(uaddr, &q, hb, curr);
+	else {
  		/*
  		 * Catch the rare case, where the lock was released
  		 * when we were on the way back before we locked
@@ -1346,7 +1797,7 @@ static int futex_lock_pi(u32 __user *uad
  				ret = 0;
  		}
  		/* Unqueue and drop the lock */
-		unqueue_me_pi(&q, hb);
+		unqueue_me_pi(&q);
  		up_read(&curr->mm->mmap_sem);
  	}

@@ -1715,6 +2166,8 @@ retry:
  		 * userspace.
  		 */
  		mval = (uval & FUTEX_WAITERS) | FUTEX_OWNER_DIED;
+		/* Also keep the FUTEX_WAITER_REQUEUED flag if set */
+		mval |= (uval & FUTEX_WAITER_REQUEUED);
  		nval = futex_atomic_cmpxchg_inatomic(uaddr, uval, mval);

  		if (nval == -EFAULT)
@@ -1845,6 +2298,9 @@ long do_futex(u32 __user *uaddr, int op,
  	case FUTEX_TRYLOCK_PI:
  		ret = futex_lock_pi(uaddr, 0, timeout, 1);
  		break;
+	case FUTEX_CMP_REQUEUE_PI:
+		ret = futex_requeue_pi(uaddr, uaddr2, val, val2, &val3);
+		break;
  	default:
  		ret = -ENOSYS;
  	}
@@ -2745,7 +3201,8 @@ asmlinkage long sys_futex(u32 __user *ua
  	/*
  	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
  	 */
-	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE
+	    || op == FUTEX_CMP_REQUEUE_PI)
  		val2 = (u32) (unsigned long) utime;

  	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
Index: linux-2.6/kernel/rtmutex.c
===================================================================
--- linux-2.6.orig/kernel/rtmutex.c	2006-12-12 16:38:00.000000000 +0100
+++ linux-2.6/kernel/rtmutex.c	2006-12-12 16:44:17.000000000 +0100
@@ -56,7 +56,7 @@
   * state.
   */

-static void
+void
  rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
  		   unsigned long mask)
  {
@@ -80,29 +80,6 @@ static void fixup_rt_mutex_waiters(struc
  		clear_rt_mutex_waiters(lock);
  }

-/*
- * We can speed up the acquire/release, if the architecture
- * supports cmpxchg and if there's no debugging state to be set up
- */
-#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
-# define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	unsigned long owner, *p = (unsigned long *) &lock->owner;
-
-	do {
-		owner = *p;
-		cpu_relax();
-	} while (cmpxchg(p, owner, owner | RT_MUTEX_HAS_WAITERS) != owner);
-}
-#else
-# define rt_mutex_cmpxchg(l,c,n)	(0)
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	lock->owner = (struct task_struct *)
-			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
-}
-#endif

  int pi_initialized;

@@ -140,7 +117,7 @@ int rt_mutex_getprio(struct task_struct
   *
   * This can be both boosting and unboosting. task->pi_lock must be held.
   */
-static void __rt_mutex_adjust_prio(struct task_struct *task)
+void __rt_mutex_adjust_prio(struct task_struct *task)
  {
  	int prio = rt_mutex_getprio(task);

@@ -176,11 +153,11 @@ int max_lock_depth = 1024;
   * Decreases task's usage by one - may thus free the task.
   * Returns 0 or -EDEADLK.
   */
-static int rt_mutex_adjust_prio_chain(struct task_struct *task,
-				      int deadlock_detect,
-				      struct rt_mutex *orig_lock,
-				      struct rt_mutex_waiter *orig_waiter,
-				      struct task_struct *top_task)
+int rt_mutex_adjust_prio_chain(struct task_struct *task,
+			       int deadlock_detect,
+			       struct rt_mutex *orig_lock,
+			       struct rt_mutex_waiter *orig_waiter,
+			       struct task_struct *top_task)
  {
  	struct rt_mutex *lock;
  	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
@@ -541,9 +518,9 @@ static void wakeup_next_waiter(struct rt
   *
   * Must be called with lock->wait_lock held
   */
-static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter,
-			  unsigned long flags)
+void remove_waiter(struct rt_mutex *lock,
+		   struct rt_mutex_waiter *waiter,
+		   unsigned long flags)
  {
  	int first = (waiter == rt_mutex_top_waiter(lock));
  	struct task_struct *owner = rt_mutex_owner(lock);
Index: linux-2.6/kernel/rtmutex_common.h
===================================================================
--- linux-2.6.orig/kernel/rtmutex_common.h	2006-12-12 16:38:00.000000000 +0100
+++ linux-2.6/kernel/rtmutex_common.h	2006-12-12 16:43:54.000000000 +0100
@@ -113,6 +113,30 @@ static inline unsigned long rt_mutex_own
  }

  /*
+ * We can speed up the acquire/release, if the architecture
+ * supports cmpxchg and if there's no debugging state to be set up
+ */
+#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
+# define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	unsigned long owner, *p = (unsigned long *) &lock->owner;
+
+	do {
+		owner = *p;
+		cpu_relax();
+	} while (cmpxchg(p, owner, owner | RT_MUTEX_HAS_WAITERS) != owner);
+}
+#else
+# define rt_mutex_cmpxchg(l,c,n)	(0)
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	lock->owner = (struct task_struct *)
+			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
+}
+#endif
+
+/*
   * PI-futex support (proxy locking functions, etc.):
   */
  extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
@@ -120,4 +144,16 @@ extern void rt_mutex_init_proxy_locked(s
  				       struct task_struct *proxy_owner);
  extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
  				  struct task_struct *proxy_owner);
+
+extern void rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
+			       unsigned long mask);
+extern void __rt_mutex_adjust_prio(struct task_struct *task);
+extern int rt_mutex_adjust_prio_chain(struct task_struct *task,
+				      int deadlock_detect,
+				      struct rt_mutex *orig_lock,
+				      struct rt_mutex_waiter *orig_waiter,
+				      struct task_struct *top_task);
+extern void remove_waiter(struct rt_mutex *lock,
+			  struct rt_mutex_waiter *waiter,
+			  unsigned long flags);
  #endif
Index: linux-2.6/kernel/futex_compat.c
===================================================================
--- linux-2.6.orig/kernel/futex_compat.c	2006-12-12 16:38:00.000000000 +0100
+++ linux-2.6/kernel/futex_compat.c	2006-12-12 16:43:54.000000000 +0100
@@ -150,7 +150,8 @@ asmlinkage long compat_sys_futex(u32 __u
  		if (!timespec_valid(&t))
  			return -EINVAL;
  	}
-	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE
+	    || op == FUTEX_CMP_REQUEUE_PI)
  		val2 = (int) (unsigned long) utime;

  	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);


Thanks,

-- 
Pierre Peiffer



