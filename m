Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDYUIH>; Wed, 25 Apr 2001 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRDYUH7>; Wed, 25 Apr 2001 16:07:59 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:2795 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S131508AbRDYUHp>;
	Wed, 25 Apr 2001 16:07:45 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_2J6DAVAKJABQ8AXX8XYK"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: torvalds@transmeta.com
Subject: [PATCH] rw_semaphores, optimisations try #4
Date: Wed, 25 Apr 2001 21:06:38 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, andrea@suse.de
MIME-Version: 1.0
Message-Id: <01042521063800.02040@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2J6DAVAKJABQ8AXX8XYK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch (made against linux-2.4.4-pre6 + rwsem-opt3) somewhat improves 
performance on the i386 XADD optimised implementation:

A patch against -pre6 can be obtained too:

	ftp://infradead.org/pub/people/dwh/rwsem-pre6-opt4.diff

Here's some benchmarks (take with a pinch of salt of course):

TEST		NUM READERS	NUM WRITERS	CONTENTION	DURATION
===============	===============	===============	===============	========
rwsem-r1	1		0		no		10s
rwsem-r2	2		0		no		10s
rwsem-ro	4		0		no		10s
rwsem-w1	0		1		no		10s
rwsem-wo	0		4		w-w only	10s
rwsem-rw	4		2		r-w & w-w	10s
rwsem-worm	30		1		r-w & w-w	10s
rwsem-xx	30		15		r-w & w-w	50s

			rwsem-opt4 (mine)		00_rwsem-9 (Andrea's)
		-------------------------------	-------------------------------
TEST		READERS		WRITERS		READERS		WRITERS
===============	===============	===============	===============	
===============
rwsem-r1	30347096	n/a		30130004	n/a
		30362972	n/a		30127882	n/a
rwsem-r2	11031268	n/a		11035072	n/a
		11038232	n/a		11030787	n/a
rwsem-ro	12641408	n/a		12722192	n/a
		12636058	n/a		12729404	n/a
rwsem-w1	n/a		28607326	n/a		28505470
		n/a		28609208	n/a		28508206
rwsem-wo	n/a		1607789		n/a		1783876
		n/a		1608603		n/a		1800982
rwsem-rw	1111545		557071		1106763		554698
		1109773		555901		1103090		552567
rwsem-worm	5229696		54807		1585755		52438
		5219531		54528		1588428		52222
rwsem-xx	5396096		2786619		5361894		2768893
		5398443		2787613		5400716		2788801

I've compared my patch to Andrea's 00_rwsem-9, both built on top of 
linux-2.4.4-pre6.

David

--------------Boundary-00=_2J6DAVAKJABQ8AXX8XYK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rwsem-opt4.diff"
Content-Transfer-Encoding: 8bit
Content-Description: rw-semaphore, further optimisations #4
Content-Disposition: attachment; filename="rwsem-opt4.diff"

diff -uNr linux-2.4.4-pre6-opt3/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
--- linux-2.4.4-pre6-opt3/include/asm-i386/rwsem.h	Wed Apr 25 00:12:14 2001
+++ linux/include/asm-i386/rwsem.h	Wed Apr 25 20:21:31 2001
@@ -3,6 +3,30 @@
  * Written by David Howells (dhowells@redhat.com).
  *
  * Derived from asm-i386/semaphore.h
+ *
+ *
+ * The MSW of the count is the negated number of active writers and waiting
+ * lockers, and the LSW is the total number of active locks
+ *
+ * The lock count is initialized to 0 (no active and no waiting lockers).
+ *
+ * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
+ * uncontended lock. This can be determined because XADD returns the old value.
+ * Readers increment by 1 and see a positive value when uncontended, negative
+ * if there are writers (and maybe) readers waiting (in which case it goes to
+ * sleep).
+ *
+ * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
+ * be extended to 65534 by manually checking the whole MSW rather than relying
+ * on the S flag.
+ *
+ * The value of ACTIVE_BIAS supports up to 65535 active processes.
+ *
+ * This should be totally fair - if anything is waiting, a process that wants a
+ * lock will go to the back of the queue. When the currently active lock is
+ * released, if there's a writer at the front of the queue, then that and only
+ * that will be woken up; if there's a bunch of consequtive readers at the
+ * front, then they'll all be woken up, but no other readers will be.
  */
 
 #ifndef _I386_RWSEM_H
@@ -19,6 +43,10 @@
 
 struct rwsem_waiter;
 
+extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
+
 /*
  * the semaphore definition
  */
@@ -31,8 +59,7 @@
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 	spinlock_t		wait_lock;
-	struct rwsem_waiter	*wait_front;
-	struct rwsem_waiter	**wait_back;
+	struct list_head	wait_list;
 #if RWSEM_DEBUG
 	int			debug;
 #endif
@@ -48,7 +75,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
 	__RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
@@ -58,8 +85,7 @@
 {
 	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->wait_lock);
-	sem->wait_front = NULL;
-	sem->wait_back = &sem->wait_front;
+	INIT_LIST_HEAD(&sem->wait_list);
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
@@ -85,9 +111,9 @@
 		"  jmp       1b\n"
 		".previous"
 		"# ending down_read\n\t"
-		: "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
-		: "memory");
+		: "+m"(sem->count)
+		: "a"(sem)
+		: "memory", "cc");
 }
 
 /*
@@ -112,9 +138,9 @@
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending down_write"
-		: "+d"(tmp), "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
-		: "memory");
+		: "+d"(tmp), "+m"(sem->count)
+		: "a"(sem)
+		: "memory", "cc");
 }
 
 /*
@@ -122,23 +148,25 @@
  */
 static inline void __up_read(struct rw_semaphore *sem)
 {
+	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%eax,(%%edx)\n\t" /* subtracts 1, returns the old value */
+LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  decl      %%eax\n\t" /* xadd gave us the old count */
-		"  testl     %3,%%eax\n\t" /* do nothing if still outstanding active readers */
+		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
-		"  call      rwsem_up_read_wake\n\t"
+		"  pushl     %%ecx\n\t"
+		"  call      rwsem_wake\n\t"
+		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_read\n"
-		: "=m"(sem->count)
-		: "d"(sem), "a"(-RWSEM_ACTIVE_READ_BIAS), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count)
-		: "memory", "ecx");
+		: "+m"(sem->count), "+d"(tmp)
+		: "a"(sem)
+		: "memory", "cc");
 }
 
 /*
@@ -148,18 +176,23 @@
 {
 	__asm__ __volatile__(
 		"# beginning __up_write\n\t"
-LOCK_PREFIX	"  cmpxchgl  %%ecx,(%%edx)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
+		"  movl      %2,%%edx\n\t"
+LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      rwsem_up_write_wake\n\t"
+		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
+		"  jnz       1b\n\t" /* jump back if not */
+		"  pushl     %%ecx\n\t"
+		"  call      rwsem_wake\n\t"
+		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_write\n"
-		: "=m"(sem->count)
-		: "d"(sem), "a"(RWSEM_ACTIVE_WRITE_BIAS), "c"(0), "m"(sem->count)
-		: "memory");
+		: "+m"(sem->count)
+		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
+		: "memory", "cc", "edx");
 }
 
 /*
@@ -187,38 +220,6 @@
 		: "memory");
 
 	return tmp+delta;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count LSW
- */
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
-{
-	__u16 tmp = old;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"cmpxchgw %w2,%3"
-		: "=a"(tmp), "=m"(sem->count)
-		: "r"(new), "m1"(sem->count), "a"(tmp)
-		: "memory");
-
-	return tmp;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count
- */
-static inline signed long rwsem_cmpxchg(struct rw_semaphore *sem, signed long old, signed long new)
-{
-	signed long tmp = old;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"cmpxchgl %2,%3"
-		: "=a"(tmp), "=m"(sem->count)
-		: "r"(new), "m1"(sem->count), "a"(tmp)
-		: "memory");
-
-	return tmp;
 }
 
 #endif /* __KERNEL__ */
diff -uNr linux-2.4.4-pre6-opt3/include/linux/rwsem.h linux/include/linux/rwsem.h
--- linux-2.4.4-pre6-opt3/include/linux/rwsem.h	Wed Apr 25 00:12:14 2001
+++ linux/include/linux/rwsem.h	Wed Apr 25 20:44:59 2001
@@ -2,30 +2,6 @@
  *
  * Written by David Howells (dhowells@redhat.com).
  * Derived from asm-i386/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
  */
 
 #ifndef _LINUX_RWSEM_H
@@ -42,17 +18,6 @@
 #include <asm/atomic.h>
 
 struct rw_semaphore;
-
-/* defined contention handler functions for the generic case
- * - these are also used for the exchange-and-add based algorithm
- */
-#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
-/* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern void FASTCALL(rwsem_up_read_wake(signed long, struct rw_semaphore *));
-extern void FASTCALL(rwsem_up_write_wake(signed long, struct rw_semaphore *));
-#endif
 
 #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
 #include <linux/rwsem-spinlock.h> /* use a generic implementation */
diff -uNr linux-2.4.4-pre6-opt3/lib/rwsem.c linux/lib/rwsem.c
--- linux-2.4.4-pre6-opt3/lib/rwsem.c	Wed Apr 25 00:12:13 2001
+++ linux/lib/rwsem.c	Wed Apr 25 20:21:10 2001
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct rwsem_waiter	*next;
+	struct list_head	list;
 	struct task_struct	*task;
 	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
@@ -16,8 +16,11 @@
 };
 
 #if RWSEM_DEBUG
+#undef rwsemtrace
 void rwsemtrace(struct rw_semaphore *sem, const char *str)
 {
+	printk("sem=%p\n",sem);
+	printk("(sem)=%08lx\n",sem->count);
 	if (sem->debug)
 		printk("[%d] %s({%08lx})\n",current->pid,str,sem->count);
 }
@@ -25,121 +28,117 @@
 
 /*
  * handle the lock being released whilst there are processes blocked on it that can now run
- * - the caller can specify an adjustment that will need to be made to the semaphore count to
- *   help reduce the number of atomic operations invoked
  * - if we come here, then:
  *   - the 'active part' of the count (&0x0000ffff) reached zero but has been re-incremented
  *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ *   - there must be someone on the queue
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
  */
-static inline struct rw_semaphore *__rwsem_do_wake(int adjustment, struct rw_semaphore *sem)
+static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
 {
-	struct rwsem_waiter *waiter, *next;
+	struct rwsem_waiter *waiter;
+	struct list_head *next;
+	signed long oldcount;
 	int woken, loop;
 
 	rwsemtrace(sem,"Entering __rwsem_do_wake");
 
-	waiter = sem->wait_front;
-
-	if (!waiter)
-	  goto list_unexpectedly_empty;
+	/* only wake someone up if we can transition the active part of the count from 0 -> 1 */
+ try_again:
+	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS,sem) - RWSEM_ACTIVE_BIAS;
+	if (oldcount & RWSEM_ACTIVE_MASK)
+		goto undo;
 
-	next = NULL;
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
 
 	/* try to grant a single write lock if there's a writer at the front of the queue
 	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
 	 *   incremented by 0x00010000
 	 */
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
-		if (adjustment)
-			rwsem_atomic_add(adjustment,sem);
-		next = waiter->next;
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-		goto discard_woken_processes;
-	}
+	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
+		goto readers_only;
+
+	list_del(&waiter->list);
+	waiter->flags = 0;
+	wake_up_process(waiter->task);
+	goto out;
 
 	/* grant an infinite number of read locks to the readers at the front of the queue
 	 * - note we increment the 'active part' of the count by the number of readers (less one
 	 *   for the activity decrement we've already done) before waking any processes up
 	 */
+ readers_only:
 	woken = 0;
 	do {
 		woken++;
-		waiter = waiter->next;
-	} while (waiter && waiter->flags&RWSEM_WAITING_FOR_READ);
+
+		if (waiter->list.next==&sem->wait_list)
+			break;
+
+		waiter = list_entry(waiter->list.next,struct rwsem_waiter,list);
+
+	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
 
 	loop = woken;
 	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
 	woken -= RWSEM_ACTIVE_BIAS;
-	woken += adjustment;
 	rwsem_atomic_add(woken,sem);
 
-	waiter = sem->wait_front;
+	next = sem->wait_list.next;
 	for (; loop>0; loop--) {
-		next = waiter->next;
+		waiter = list_entry(next,struct rwsem_waiter,list);
+		next = waiter->list.next;
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
-		waiter = next;
 	}
 
- discard_woken_processes:
-	sem->wait_front = next;
-	if (!next) sem->wait_back = &sem->wait_front;
+	sem->wait_list.next = next;
+	next->prev = &sem->wait_list;
 
  out:
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
 
- list_unexpectedly_empty:
-	printk("__rwsem_do_wake(): wait_list unexpectedly empty\n");
-	printk("[%d] %p = { %08lx })\n",current->pid,sem,sem->count);
-	BUG();
-	goto out;
+	/* undo the change to count, but check for a transition 1->0 */
+ undo:
+	if (rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem)!=0)
+		goto out;
+	goto try_again;
 }
 
 /*
- * wait for the read lock to be granted
- * - need to repeal the increment made inline by the caller
- * - need to throw a write-lock style spanner into the works (sub 0x00010000 from count)
+ * wait for a lock to be granted
  */
-struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
+static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
+								 struct rwsem_waiter *waiter,
+								 __s32 adjustment)
 {
-	struct rwsem_waiter waiter;
 	struct task_struct *tsk = current;
 	signed long count;
 
-	rwsemtrace(sem,"Entering rwsem_down_read_failed");
-
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	waiter.next = NULL;
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-
 	spin_lock(&sem->wait_lock);
+	waiter->task = tsk;
 
-	*sem->wait_back = &waiter; /* add to back of queue */
-	sem->wait_back = &waiter.next;
+	list_add_tail(&waiter->list,&sem->wait_list);
 
 	/* note that we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,sem);
+	count = rwsem_atomic_update(adjustment,sem);
 
 	/* if there are no longer active locks, wake the front queued process(es) up
 	 * - it might even be this process, since the waker takes a more active part
-	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
-			__rwsem_do_wake(0,sem);
+		sem = __rwsem_do_wake(sem);
 
 	spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
-		if (!waiter.flags)
+		if (!waiter->flags)
 			break;
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
@@ -147,119 +146,65 @@
 
 	tsk->state = TASK_RUNNING;
 
-	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
 	return sem;
 }
 
 /*
- * wait for the write lock to be granted
+ * wait for the read lock to be granted
  */
-struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
+struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
-	struct task_struct *tsk = current;
-	signed long count;
-
-	rwsemtrace(sem,"Entering rwsem_down_write_failed");
-
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.next = NULL;
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-
-	spin_lock(&sem->wait_lock);
-
-	*sem->wait_back = &waiter; /* add to back of queue */
-	sem->wait_back = &waiter.next;
-
-	/* note that we're waiting on the lock, but no longer actively locking */
-	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
-
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
-			__rwsem_do_wake(0,sem);
-
-	spin_unlock(&sem->wait_lock);
 
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
+	rwsemtrace(sem,"Entering rwsem_down_read_failed");
 
-	tsk->state = TASK_RUNNING;
+	waiter.flags = RWSEM_WAITING_FOR_READ;
+	rwsem_down_failed_common(sem,&waiter,RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS);
 
-	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
+	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
 	return sem;
 }
 
 /*
- * handle up_read() finding a waiter on the semaphore
- * - up_read has decremented the active part of the count if we come here
+ * wait for the write lock to be granted
  */
-void rwsem_up_read_wake(signed long count, struct rw_semaphore *sem)
+struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering rwsem_up_read_wake");
-
-	spin_lock(&sem->wait_lock);
+	struct rwsem_waiter waiter;
 
-	/* need to wake up a waiter unless the semaphore has gone active again
-	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
-	 */
-	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
-		sem = __rwsem_do_wake(0,sem);
+	rwsemtrace(sem,"Entering rwsem_down_write_failed");
 
-	spin_unlock(&sem->wait_lock);
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+	rwsem_down_failed_common(sem,&waiter,-RWSEM_ACTIVE_BIAS);
 
-	rwsemtrace(sem,"Leaving rwsem_up_read_wake");
+	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
+	return sem;
 }
 
 /*
- * handle up_write() finding a waiter on the semaphore
- * - up_write has not modified the count if we come here
+ * handle waking up a waiter on the semaphore
+ * - up_read has decremented the active part of the count if we come here
  */
-void rwsem_up_write_wake(signed long count, struct rw_semaphore *sem)
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
-	signed long new;
-
-	rwsemtrace(sem,"Entering rwsem_up_write_wake");
+	rwsemtrace(sem,"Entering rwsem_wake");
 
 	spin_lock(&sem->wait_lock);
 
- try_again:
-	/* if the active part of the count is 1, we should perform a wake-up, else we should
-	 * decrement the count and return
-	 */
-	if ((count&RWSEM_ACTIVE_MASK)==RWSEM_ACTIVE_BIAS) {
-		sem = __rwsem_do_wake(-RWSEM_WAITING_BIAS,sem);
-	}
-	else {
-		/* tricky - we mustn't return the active part of the count to 0 */
-		new = count - RWSEM_ACTIVE_WRITE_BIAS;
-		new = rwsem_cmpxchg(sem,count,new);
-		if (count!=new) {
-			count = new;
-			goto try_again;
-		}
-	}
+	/* do nothing if list empty */
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem);
 
 	spin_unlock(&sem->wait_lock);
 
-	rwsemtrace(sem,"Leaving rwsem_up_write_wake");
+	rwsemtrace(sem,"Leaving rwsem_wake");
+
+	return sem;
 }
 
 EXPORT_SYMBOL(rwsem_down_read_failed);
 EXPORT_SYMBOL(rwsem_down_write_failed);
-EXPORT_SYMBOL(rwsem_up_read_wake);
-EXPORT_SYMBOL(rwsem_up_write_wake);
+EXPORT_SYMBOL(rwsem_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif

--------------Boundary-00=_2J6DAVAKJABQ8AXX8XYK--
