Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWFAN2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWFAN2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWFAN2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:28:11 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:4992 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S965109AbWFAN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:28:09 -0400
Subject: Re: deadlock in epoll (found by lockdep)
From: Arjan van de Ven <arjan@linux.intel.com>
To: davidel@xmailserver.org
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1149151538.3115.29.camel@laptopd505.fenrus.org>
References: <1149151538.3115.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 15:27:42 +0200
Message-Id: <1149168467.3115.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 10:45 +0200, Arjan van de Ven wrote:

proposed fix below; it's not as pretty as I'd like, after fixing the
first obvious bug, a second one showed up: epoll calls wake_up() from
inside a wake_up() handler; as a result I had to introduce a
wake_up_nested() (urg!) and for that a nested spinlock_irqsave..

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 fs/eventpoll.c                   |   20 ++++++++++++--------
 include/linux/spinlock.h         |    2 ++
 include/linux/spinlock_api_smp.h |    2 ++
 include/linux/spinlock_api_up.h  |    1 +
 include/linux/wait.h             |    2 ++
 kernel/sched.c                   |   28 ++++++++++++++++++++++++++++
 kernel/spinlock.c                |   22 ++++++++++++++++++++++
 7 files changed, 69 insertions(+), 8 deletions(-)

Index: linux-2.6.17-rc5-mm1.5/fs/eventpoll.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/fs/eventpoll.c
+++ linux-2.6.17-rc5-mm1.5/fs/eventpoll.c
@@ -1260,7 +1260,7 @@ is_linked:
 	 * wait list.
 	 */
 	if (waitqueue_active(&ep->wq))
-		wake_up(&ep->wq);
+		wake_up_nested(&ep->wq);
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
 
@@ -1506,7 +1506,9 @@ static int ep_poll(struct eventpoll *ep,
 		MAX_SCHEDULE_TIMEOUT : (timeout * HZ + 999) / 1000;
 
 retry:
-	write_lock_irqsave(&ep->lock, flags);
+	init_waitqueue_entry(&wait, current);
+	spin_lock_irqsave(&ep->wq.lock, flags);
+	write_lock(&ep->lock);
 
 	res = 0;
 	if (list_empty(&ep->rdllist)) {
@@ -1515,8 +1517,7 @@ retry:
 		 * We need to sleep here, and we will be wake up by
 		 * ep_poll_callback() when events will become available.
 		 */
-		init_waitqueue_entry(&wait, current);
-		add_wait_queue(&ep->wq, &wait);
+		__add_wait_queue(&ep->wq, &wait);
 
 		for (;;) {
 			/*
@@ -1532,11 +1533,13 @@ retry:
 				break;
 			}
 
-			write_unlock_irqrestore(&ep->lock, flags);
+			write_unlock(&ep->lock);
+			spin_unlock_irqrestore(&ep->wq.lock, flags);
 			jtimeout = schedule_timeout(jtimeout);
-			write_lock_irqsave(&ep->lock, flags);
+			spin_lock_irqsave(&ep->wq.lock, flags);
+			write_lock(&ep->lock);
 		}
-		remove_wait_queue(&ep->wq, &wait);
+		__remove_wait_queue(&ep->wq, &wait);
 
 		set_current_state(TASK_RUNNING);
 	}
@@ -1544,7 +1547,8 @@ retry:
 	/* Is it worth to try to dig for events ? */
 	eavail = !list_empty(&ep->rdllist);
 
-	write_unlock_irqrestore(&ep->lock, flags);
+	write_unlock(&ep->lock);
+	spin_unlock_irqrestore(&ep->wq.lock, flags);
 
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
Index: linux-2.6.17-rc5-mm1.5/include/linux/spinlock.h
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/include/linux/spinlock.h
+++ linux-2.6.17-rc5-mm1.5/include/linux/spinlock.h
@@ -215,6 +215,8 @@ do {								\
 #define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
 #endif
 
+#define spin_lock_irqsave_nested(lock, flags, type)	flags = _spin_lock_irqsave_nested(lock, type)
+
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
 
Index: linux-2.6.17-rc5-mm1.5/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6.17-rc5-mm1.5/include/linux/spinlock_api_smp.h
@@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(spinlock_t);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int type)
+							__acquires(spinlock_t);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(rwlock_t);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
Index: linux-2.6.17-rc5-mm1.5/include/linux/spinlock_api_up.h
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/include/linux/spinlock_api_up.h
+++ linux-2.6.17-rc5-mm1.5/include/linux/spinlock_api_up.h
@@ -59,6 +59,7 @@
 #define _read_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _write_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _spin_lock_irqsave_nested(lock, flags, type) __LOCK_IRQSAVE(lock, flags, type)
 #define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
 #define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _spin_trylock(lock)			({ __LOCK(lock); 1; })
Index: linux-2.6.17-rc5-mm1.5/include/linux/wait.h
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/include/linux/wait.h
+++ linux-2.6.17-rc5-mm1.5/include/linux/wait.h
@@ -144,6 +144,7 @@ static inline void __remove_wait_queue(w
 }
 
 void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key));
+void FASTCALL(__wake_up_nested(wait_queue_head_t *q, unsigned int mode, int nr, void *key));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 void FASTCALL(__wake_up_bit(wait_queue_head_t *, void *, int));
@@ -162,6 +163,7 @@ wait_queue_head_t *FASTCALL(bit_waitqueu
 #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
 #define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#define wake_up_nested(x)		__wake_up_nested(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 
 #define __wait_event(wq, condition) 					\
 do {									\
Index: linux-2.6.17-rc5-mm1.5/kernel/sched.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/kernel/sched.c
+++ linux-2.6.17-rc5-mm1.5/kernel/sched.c
@@ -54,6 +54,7 @@
 #include <linux/acct.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/lockdep.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -3504,6 +3505,33 @@ void fastcall __wake_up(wait_queue_head_
 
 EXPORT_SYMBOL(__wake_up);
 
+/**
+ * __wake_up_nested - wake up threads blocked on a waitqueue.
+ * @q: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ * @key: is directly passed to the wakeup function
+ *
+ * This function is exclusively for use inside a wake handler.
+ * It is the callers responsibility to guarantee that the
+ * @q waitqueue is a "subordinate" of the queue that woke the
+ * handler in the first place,
+ *
+ * This is a very evil thing to do, and extreme care needs to
+ * be taken (see fs/eventpoll.c:ep_poll_safewake) and as such
+ * this should be considered a highly internal function, and
+ * I would strongly suggest to not export this to modules at all.
+ */
+void fastcall __wake_up_nested(wait_queue_head_t *q, unsigned int mode,
+			int nr_exclusive, void *key)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave_nested(&q->lock, flags, SINGLE_DEPTH_NESTING);
+	__wake_up_common(q, mode, nr_exclusive, 0, key);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
Index: linux-2.6.17-rc5-mm1.5/kernel/spinlock.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/kernel/spinlock.c
+++ linux-2.6.17-rc5-mm1.5/kernel/spinlock.c
@@ -338,6 +338,28 @@ void __lockfunc _spin_lock_nested(spinlo
 
 EXPORT_SYMBOL(_spin_lock_nested);
 
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subtype)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	spin_acquire(&lock->dep_map, subtype, 0, _RET_IP_);
+	/*
+	 * On lockdep we dont want the hand-coded irq-enable of
+	 * _raw_spin_lock_flags() code, because lockdep assumes
+	 * that interrupts are not re-enabled during lock-acquire:
+	 */
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	_raw_spin_lock(lock);
+#else
+	_raw_spin_lock_flags(lock, &flags);
+#endif
+	return flags;
+}
+EXPORT_SYMBOL(_spin_lock_irqsave_nested);
+
+
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);

