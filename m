Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDJSDM>; Tue, 10 Apr 2001 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDJSDE>; Tue, 10 Apr 2001 14:03:04 -0400
Received: from t2.redhat.com ([199.183.24.243]:26097 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S130552AbRDJSCr>; Tue, 10 Apr 2001 14:02:47 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 rw_semaphores fix
In-Reply-To: Your message of "Tue, 10 Apr 2001 08:47:34 BST."
             <8623.986888854@warthog.cambridge.redhat.com> 
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <11838.986925354.0@warthog.cambridge.redhat.com>
Date: Tue, 10 Apr 2001 19:02:42 +0100
Message-ID: <11851.986925762@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11838.986925354.1@warthog.cambridge.redhat.com>

Here's a patch that fixes RW semaphores on the i386 architecture. It is very
simple in the way it works.

The lock counter is dealt with as two semi-independent words: the LSW is the
number of active (granted) locks, and the MSW, if negated, is the number of
active writers (0 or 1) plus the number of waiting lockers of any type.

The fast paths are either two or three instructions long.

This algorithm should also be totally fair! Contentious lockers get put on the
back of the wait queue, and a waker function wakes them starting at the front,
but only wakes either one writer or the first consecutive bundle of readers.

The disadvantage is that the maximum number of active locks is 65535, and the
maximum number of waiting locks is 32766 (this can be extended to 65534 by not
relying on the S flag).

I've included a revised testing module (rwsem.c) that allows read locks to be
obtained as well as write locks and a revised driver program (driver.c) that
can use rwsem.c. Try the following tests:

	driver -200 & driver 200 # fork 200 writers and then 200 readers
	driver 200 & driver -200 # fork 200 readers and then 200 writers

David Howells

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem.diff"; charset="us-ascii"
Content-ID: <11838.986925354.2@warthog.cambridge.redhat.com>
Content-Description: rw-semaphore patch

diff -uNr linux-2.4.3/arch/i386/kernel/semaphore.c linux/arch/i386/kernel/semaphore.c
--- linux-2.4.3/arch/i386/kernel/semaphore.c	Thu Apr  5 14:38:34 2001
+++ linux/arch/i386/kernel/semaphore.c	Tue Apr 10 18:23:55 2001
@@ -14,7 +14,6 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
-
 #include <asm/semaphore.h>
 
 /*
@@ -237,19 +236,10 @@
 __down_read_failed:
 	pushl	%edx
 	pushl	%ecx
-	jnc	2f
-
-3:	call	down_read_failed_biased
-
-1:	popl	%ecx
+	call	down_read_failed
+	popl	%ecx
 	popl	%edx
 	ret
-
-2:	call	down_read_failed
-	" LOCK "subl	$1,(%eax)
-	jns	1b
-	jnc	2b
-	jmp	3b
 "
 );
 
@@ -260,169 +250,204 @@
 __down_write_failed:
 	pushl	%edx
 	pushl	%ecx
-	jnc	2f
-
-3:	call	down_write_failed_biased
-
-1:	popl	%ecx
+	call	down_write_failed
+	popl	%ecx
 	popl	%edx
 	ret
-
-2:	call	down_write_failed
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jz	1b
-	jnc	2b
-	jmp	3b
 "
 );
 
-struct rw_semaphore *FASTCALL(rwsem_wake_readers(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(rwsem_wake_writer(struct rw_semaphore *sem));
+asm(
+"
+.align 4
+.globl __rwsem_wake
+__rwsem_wake:
+	pushl	%edx
+	pushl	%ecx
+	call	rwsem_wake
+	popl	%ecx
+	popl	%edx
+	ret
+"
+);
 
-struct rw_semaphore *FASTCALL(down_read_failed_biased(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed_biased(struct rw_semaphore *sem));
+struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *sem));
 struct rw_semaphore *FASTCALL(down_read_failed(struct rw_semaphore *sem));
 struct rw_semaphore *FASTCALL(down_write_failed(struct rw_semaphore *sem));
 
-struct rw_semaphore *down_read_failed_biased(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
 
-	add_wait_queue(&sem->wait, &wait);	/* put ourselves at the head of the list */
-
-	for (;;) {
-		if (sem->read_bias_granted && xchg(&sem->read_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->read_bias_granted)
-			schedule();
-	}
+static inline int atomic_add_and_read_orig(int delta, atomic_t *v)
+{
+	int oldmem;
 
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
+	__asm__ __volatile__(
+		LOCK_PREFIX "xadd %0,%2"
+		: "=r"(oldmem)
+		: "r0"(delta), "m"(*__xg(v))
+		: "memory");
 
-	return sem;
+	return oldmem;
 }
 
-struct rw_semaphore *down_write_failed_biased(struct rw_semaphore *sem)
+static inline int atomic_add_and_read(int delta, atomic_t *v)
 {
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue_exclusive(&sem->write_bias_wait, &wait);	/* put ourselves at the end of the list */
-
-	for (;;) {
-		if (sem->write_bias_granted && xchg(&sem->write_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->write_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->write_bias_wait, &wait);
-	tsk->state = TASK_RUNNING;
+	return atomic_add_and_read_orig(delta,v)+delta;
+}
 
-	/* if the lock is currently unbiased, awaken the sleepers
-	 * FIXME: this wakes up the readers early in a bit of a
-	 * stampede -> bad!
-	 */
-	if (atomic_read(&sem->count) >= 0)
-		wake_up(&sem->wait);
+static inline int atomic_sub_and_read_orig(int delta, atomic_t *v)
+{
+	return atomic_add_and_read_orig(-delta,v);
+}
 
-	return sem;
+static inline int atomic_sub_and_read(int delta, atomic_t *v)
+{
+	return atomic_add_and_read_orig(-delta,v)-delta;
 }
 
-/* Wait for the lock to become unbiased.  Readers
- * are non-exclusive. =)
+/*
+ * wait for the read lock to be granted
+ * - need to repeal the increment made inline by the caller
+ * - need to throw a write-lock style spanner into the works (sub 0x00010000 from count)
  */
 struct rw_semaphore *down_read_failed(struct rw_semaphore *sem)
 {
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DECLARE_WAITQUEUE(wait,tsk);
+	int count;
 
-	__up_read(sem);	/* this takes care of granting the lock */
+	rwsemdebug("[%d] Entering down_read_failed(%08x)\n",current->pid,atomic_read(&sem->count));
 
-	add_wait_queue(&sem->wait, &wait);
+	/* this waitqueue context flag will be cleared when we are granted the lock */
+	__set_bit(RWSEM_WAITING_FOR_READ,&wait.flags);
 
-	while (atomic_read(&sem->count) < 0) {
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're now waiting on the lock, but no longer actively read-locking */
+	count = atomic_add_and_read(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,&sem->count);
+	rwsemdebug("X(%08x)\n",count);
+
+	/* if there are no longer active locks, wake the front queued process(es) up
+	 * - it might even be this process, since the waker takes a more active part
+	 */
+	if (!(count & RWSEM_ACTIVE_MASK))
+		rwsem_wake(sem);
+
+	/* wait to be given the lock */
+	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
+		if (!test_bit(RWSEM_WAITING_FOR_READ,&wait.flags))
 			break;
 		schedule();
 	}
 
-	remove_wait_queue(&sem->wait, &wait);
+	remove_wait_queue(&sem->wait,&wait);
 	tsk->state = TASK_RUNNING;
 
+	rwsemdebug("[%d] Leaving down_read_failed(%08x)\n",current->pid,atomic_read(&sem->count));
+
 	return sem;
 }
 
-/* Wait for the lock to become unbiased. Since we're
- * a writer, we'll make ourselves exclusive.
+/*
+ * wait for the write lock to be granted
  */
 struct rw_semaphore *down_write_failed(struct rw_semaphore *sem)
 {
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	DECLARE_WAITQUEUE(wait,tsk);
+	int count;
 
-	__up_write(sem);	/* this takes care of granting the lock */
+	rwsemdebug("[%d] Entering down_write_failed(%08x)\n",
+		   current->pid,atomic_read(&sem->count));
 
-	add_wait_queue_exclusive(&sem->wait, &wait);
+	/* this waitqueue context flag will be cleared when we are granted the lock */
+	__set_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags);
 
-	while (atomic_read(&sem->count) < 0) {
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're waiting on the lock, but no longer actively locking */
+	count = atomic_add_and_read(-RWSEM_ACTIVE_BIAS,&sem->count);
+	rwsemdebug("A(%08x)\n",count);
+
+	/* if there are no longer active locks, wake the front queued process(es) up
+	 * - it might even be this process, since the waker takes a more active part
+	 */
+	if (!(count & RWSEM_ACTIVE_MASK))
+		rwsem_wake(sem);
+
+	/* wait to be given the lock */
+	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;	/* we must attempt to acquire or bias the lock */
+		if (!test_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags))
+			break;
 		schedule();
 	}
 
-	remove_wait_queue(&sem->wait, &wait);
+	remove_wait_queue(&sem->wait,&wait);
 	tsk->state = TASK_RUNNING;
 
+	rwsemdebug("[%d] Leaving down_write_failed(%08x)\n",current->pid,atomic_read(&sem->count));
+
 	return sem;
 }
 
-asm(
-"
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-
-	jz	1f
-	call	rwsem_wake_readers
-	jmp	2f
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
+ *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ */
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+{
+	int count, woken;
 
-1:	call	rwsem_wake_writer
+	rwsemdebug("[%d] Entering rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
 
-2:	popl	%ecx
-	popl	%edx
-	ret
-"
-);
+	/* try to grab an 'activity' marker
+	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
+	 *   simultaneously
+	 * - be horribly naughty, and only deal with the LSW of the atomic counter
+	 */
+	if (cmpxchg((__u16*)&sem->count.counter,0,RWSEM_ACTIVE_BIAS)!=0)
+		goto out;
 
-/* Called when someone has done an up that transitioned from
- * negative to non-negative, meaning that the lock has been
- * granted to whomever owned the bias.
- */
-struct rw_semaphore *rwsem_wake_readers(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->read_bias_granted, 1))
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
+	 *   incremented by 0x00010000
+	 */
+	switch (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)) {
+	case 1:
+		goto out;
+	case 0:
+		break;
+	default:
 		BUG();
-	wake_up(&sem->wait);
-	return sem;
-}
+	}
 
-struct rw_semaphore *rwsem_wake_writer(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->write_bias_granted, 1))
+	rwsemdebug("E\n");
+
+	/* grant an infinite number of read locks to the readers at the front of the queue
+	 * - note we increment the 'active part' of the count by the number of readers just woken,
+	 *   less one for the activity decrement we've already done
+	 */
+	woken = wake_up_ctx(&sem->wait,65535,-RWSEM_WAITING_FOR_READ);
+	if (woken>0) {
+		woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
+		woken -= RWSEM_ACTIVE_BIAS;
+		atomic_add(woken,&sem->count);
+	}
+	else {
 		BUG();
-	wake_up(&sem->write_bias_wait);
+	}
+
+ out:
+	rwsemdebug("[%d] Leaving rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
 	return sem;
 }
 
+/*
+ * rw spinlock fallbacks
+ */
 #if defined(CONFIG_SMP)
 asm(
 "
@@ -451,4 +476,3 @@
 "
 );
 #endif
-
diff -uNr linux-2.4.3/include/asm-i386/semaphore.h linux/include/asm-i386/semaphore.h
--- linux-2.4.3/include/asm-i386/semaphore.h	Thu Apr  5 14:50:36 2001
+++ linux/include/asm-i386/semaphore.h	Tue Apr 10 18:37:20 2001
@@ -208,31 +208,42 @@
  * spinlocks and semaphores together, and this is what we
  * end up with...
  *
- * The lock is initialized to BIAS.  This way, a writer
- * subtracts BIAS ands gets 0 for the case of an uncontended
- * lock.  Readers decrement by 1 and see a positive value
- * when uncontended, negative if there are writers waiting
- * (in which case it goes to sleep).
- *
- * The value 0x01000000 supports up to 128 processors and
- * lots of processes.  BIAS must be chosen such that subl'ing
- * BIAS once per CPU will result in the long remaining
- * negative.
- *
- * In terms of fairness, this should result in the lock
- * flopping back and forth between readers and writers
- * under heavy use.
+ * The MSW of the count is the negated number of active writers and waiting
+ * lockers, and the LSW is the total number of active locks
  *
- *		-ben
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
+ * that will be woken up; if there's a bunch of consecutive readers at the
+ * front, then they'll all be woken up, but no other readers will be.
+ *
+ * [dhowells@redhat.com]
  */
 struct rw_semaphore {
 	atomic_t		count;
-	volatile unsigned char	write_bias_granted;
-	volatile unsigned char	read_bias_granted;
-	volatile unsigned char	pad1;
-	volatile unsigned char	pad2;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 	wait_queue_head_t	wait;
-	wait_queue_head_t	write_bias_wait;
+#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
+#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
 #if WAITQUEUE_DEBUG
 	long			__magic;
 	atomic_t		readers;
@@ -240,6 +251,9 @@
 #endif
 };
 
+#define rwsemdebug(FMT,...)
+//#define rwsemdebug printk
+
 #if WAITQUEUE_DEBUG
 #define __RWSEM_DEBUG_INIT	, ATOMIC_INIT(0), ATOMIC_INIT(0)
 #else
@@ -247,8 +261,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, 0, 0, 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait), \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).write_bias_wait) \
+{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait), \
 	__SEM_DEBUG_INIT(name) __RWSEM_DEBUG_INIT }
 
 #define __DECLARE_RWSEM_GENERIC(name,count) \
@@ -260,11 +273,8 @@
 
 static inline void init_rwsem(struct rw_semaphore *sem)
 {
-	atomic_set(&sem->count, RW_LOCK_BIAS);
-	sem->read_bias_granted = 0;
-	sem->write_bias_granted = 0;
+	atomic_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	init_waitqueue_head(&sem->wait);
-	init_waitqueue_head(&sem->write_bias_wait);
 #if WAITQUEUE_DEBUG
 	sem->__magic = (long)&sem->__magic;
 	atomic_set(&sem->readers, 0);
@@ -283,7 +293,23 @@
 	if (sem->__magic != (long)&sem->__magic)
 		BUG();
 #endif
-	__build_read_lock(sem, "__down_read_failed");
+	rwsemdebug("Entering down_read(count=%08x)\n",atomic_read(&sem->count));
+	__asm__ __volatile__(
+		"# beginning down_read\n\t"
+LOCK_PREFIX	"  incl      (%1)\n\t" /* adds 0x00000001, returns the old value */
+		"  js        2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  call     __down_read_failed\n\t"
+		"  jmp      1b\n"
+		".previous"
+		"# ending down_read\n\t"
+		: "=a"(sem)
+		: "a0"(sem)
+		: "memory");
+
+	rwsemdebug("Leaving down_read(count=%08x)\n",atomic_read(&sem->count));
 #if WAITQUEUE_DEBUG
 	if (sem->write_bias_granted)
 		BUG();
@@ -295,11 +321,32 @@
 
 static inline void down_write(struct rw_semaphore *sem)
 {
+	int tmp;
+
 #if WAITQUEUE_DEBUG
 	if (sem->__magic != (long)&sem->__magic)
 		BUG();
 #endif
-	__build_write_lock(sem, "__down_write_failed");
+	rwsemdebug("Entering down_write(count=%08x)\n",atomic_read(&sem->count));
+
+	__asm__ __volatile__(
+		"# beginning down_write\n\t"
+LOCK_PREFIX	"  xadd      %0,(%1)\n\t" /* subtract 0x00010001, returns the old value */
+		"  testl     %0,%0\n\t" /* was the count 0 before? */
+		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  call     __down_write_failed\n\t"
+		"  jmp      1b\n"
+		".previous\n"
+		"# ending down_write"
+		: "=r"(tmp), "=a"(sem)
+		: "r0"(RWSEM_ACTIVE_WRITE_BIAS), "a1"(sem)
+		: "memory");
+
+	rwsemdebug("Leaving down_write(count=%08x)\n",atomic_read(&sem->count));
+
 #if WAITQUEUE_DEBUG
 	if (atomic_read(&sem->writers))
 		BUG();
@@ -319,19 +366,29 @@
  */
 static inline void __up_read(struct rw_semaphore *sem)
 {
+	int tmp;
+
+	rwsemdebug("Entering up_read(count=%08x)\n",atomic_read(&sem->count));
+
 	__asm__ __volatile__(
-		"# up_read\n\t"
-		LOCK "incl %0\n\t"
-		"jz 2f\n"			/* only do the wake if result == 0 (ie, a writer) */
+		"# beginning __up_read\n\t"
+LOCK_PREFIX	"  xadd      %0,(%1)\n\t" /* subtracts 1, returns the old value */
+		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
+		"2:\n\t"
+		"  decl      %0\n\t" /* xadd gave us the old count */
+		"  testl     %4,%0\n\t" /* do nothing if still outstanding active readers */
+		"  jnz       1b\n\t"
+		"  call     __rwsem_wake\n\t"
+		"  jmp      1b\n"
+		".previous\n"
+		"# ending __up_read\n"
+		: "=r"(tmp), "=a"(sem)
+		: "r0"(-RWSEM_ACTIVE_READ_BIAS), "a1"(sem), "i"(RWSEM_ACTIVE_MASK)
+		: "memory");
+
+	rwsemdebug("Leaving up_read(count=%08x)\n",atomic_read(&sem->count));
 }
 
 /* releasing the writer is easy -- just release it and
@@ -339,19 +396,26 @@
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	int eax;
+
+	rwsemdebug("Entering __up_write(count=%08x)\n",atomic_read(&sem->count));
+
 	__asm__ __volatile__(
-		"# up_write\n\t"
-		LOCK "addl $" RW_LOCK_BIAS_STR ",%0\n"
-		"jc 2f\n"			/* only do the wake if the result was -'ve to 0/+'ve */
+		"# beginning __up_write\n\t"
+LOCK_PREFIX	"  addl      %2,(%0)\n\t" /* adds 0x00010001 */
+		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
+		"2:\n\t"
+		"  call     __rwsem_wake\n\t"
+		"  jmp      1b\n"
+		".previous\n"
+		"# ending __up_write\n"
+		: "=a"(eax)
+		: "a0"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
+		: "memory");
+
+	rwsemdebug("Leaving __up_write(count=%08x)\n",atomic_read(&sem->count));
 }
 
 static inline void up_read(struct rw_semaphore *sem)
diff -uNr linux-2.4.3/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.3/include/linux/sched.h	Thu Apr  5 14:50:36 2001
+++ linux/include/linux/sched.h	Tue Apr 10 17:32:38 2001
@@ -548,6 +548,8 @@
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern int FASTCALL(__wake_up_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit));
+extern int FASTCALL(__wake_up_sync_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -566,6 +568,8 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
+#define wake_up_ctx(x,count,bit)	__wake_up_ctx((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,count,bit)
+#define wake_up_sync_ctx(x,count,bit)	__wake_up_ctx((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,count,bit)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
diff -uNr linux-2.4.3/include/linux/wait.h linux/include/linux/wait.h
--- linux-2.4.3/include/linux/wait.h	Thu Apr  5 14:50:36 2001
+++ linux/include/linux/wait.h	Tue Apr 10 10:18:30 2001
@@ -26,6 +26,14 @@
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
+#define WQ_FLAG_CONTEXT_0	8	/* context specific flag bit numbers */
+#define WQ_FLAG_CONTEXT_1	9
+#define WQ_FLAG_CONTEXT_2	10
+#define WQ_FLAG_CONTEXT_3	11
+#define WQ_FLAG_CONTEXT_4	12
+#define WQ_FLAG_CONTEXT_5	13
+#define WQ_FLAG_CONTEXT_6	14
+#define WQ_FLAG_CONTEXT_7	15
 	struct task_struct * task;
 	struct list_head task_list;
 #if WAITQUEUE_DEBUG
diff -uNr linux-2.4.3/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.3/kernel/fork.c	Thu Apr  5 14:44:17 2001
+++ linux/kernel/fork.c	Tue Apr 10 09:19:47 2001
@@ -39,7 +39,7 @@
 	unsigned long flags;
 
 	wq_write_lock_irqsave(&q->lock, flags);
-	wait->flags = 0;
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(q, wait);
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
@@ -49,7 +49,7 @@
 	unsigned long flags;
 
 	wq_write_lock_irqsave(&q->lock, flags);
-	wait->flags = WQ_FLAG_EXCLUSIVE;
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue_tail(q, wait);
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
diff -uNr linux-2.4.3/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.3/kernel/sched.c	Thu Apr  5 14:44:17 2001
+++ linux/kernel/sched.c	Tue Apr 10 15:25:44 2001
@@ -739,7 +739,7 @@
 		state = p->state;
 		if (state & mode) {
 			WQ_NOTE_WAKER(curr);
-			if (try_to_wake_up(p, sync) && curr->flags && !--nr_exclusive)
+			if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 				break;
 		}
 	}
@@ -763,6 +763,80 @@
 		__wake_up_common(q, mode, nr, 1);
 		wq_read_unlock_irqrestore(&q->lock, flags);
 	}
+}
+
+/*
+ * wake up processes in the wait queue depending on the state of a context bit in the flags
+ * - wakes up a process if the specified bit is set in the flags member
+ * - the context bit is cleared if the process is woken up
+ * - if the bit number is negative, then the loop stops at the first unset context bit encountered
+ * - returns the number of processes woken
+ */
+static inline int __wake_up_ctx_common (wait_queue_head_t *q, unsigned int mode,
+					int count, int bit, const int sync)
+{
+	struct list_head *tmp, *head;
+	struct task_struct *p;
+	int stop, woken;
+
+	woken = 0;
+	stop = bit<0;
+	if (bit<0) bit = -bit;
+
+	CHECK_MAGIC_WQHEAD(q);
+	head = &q->task_list;
+	WQ_CHECK_LIST_HEAD(head);
+	tmp = head->next;
+	while (tmp != head) {
+		unsigned int state;
+                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
+
+		tmp = tmp->next;
+		CHECK_MAGIC(curr->__magic);
+		p = curr->task;
+		state = p->state;
+		if (state & mode) {
+			if (!test_and_clear_bit(bit,&curr->flags)) {
+				if (stop)
+					break;
+				continue;
+			}
+
+			WQ_NOTE_WAKER(curr);
+			if (!try_to_wake_up(p, sync) || !(curr->flags&WQ_FLAG_EXCLUSIVE))
+				continue;
+
+			woken++;
+			if (woken>=count)
+				break;
+		}
+	}
+
+	return woken;
+}
+
+int __wake_up_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit)
+{
+	int woken = 0;
+	if (q && count) {
+		unsigned long flags;
+		wq_read_lock_irqsave(&q->lock, flags);
+		woken = __wake_up_ctx_common(q, mode, count, bit, 0);
+		wq_read_unlock_irqrestore(&q->lock, flags);
+	}
+	return woken;
+}
+
+int __wake_up_ctx_sync(wait_queue_head_t *q, unsigned int mode, int count, int bit)
+{
+	int woken = 0;
+	if (q && count) {
+		unsigned long flags;
+		wq_read_lock_irqsave(&q->lock, flags);
+		woken = __wake_up_ctx_common(q, mode, count, bit, 1);
+		wq_read_unlock_irqrestore(&q->lock, flags);
+	}
+	return woken;
 }
 
 #define	SLEEP_ON_VAR				\

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem.c"; charset="us-ascii"
Content-ID: <11838.986925354.3@warthog.cambridge.redhat.com>
Content-Description: rw-semaphore testing module

#define __NO_VERSION__
#include <linux/config.h>
#include <linux/module.h>
#include <linux/poll.h>
#include <linux/proc_fs.h>
#include <linux/stat.h>
#include <linux/init.h>
#include <linux/personality.h>
#include <linux/smp_lock.h>
#include <linux/delay.h>

#define kdebug(FMT,...)
//#define kdebug printk

MODULE_AUTHOR("David Howells");
MODULE_DESCRIPTION("R/W semaphore test demo");


struct proc_dir_entry *rwsem_proc;

struct rw_semaphore rwsem_sem;

static int rwsem_read_proc(char *page, char **start, off_t off,
			   int count, int *eof, void *data)
{
	kdebug("[%d] r-downing: %08x\n",current->pid,rwsem_sem.count.counter);
	down_read(&rwsem_sem);
	kdebug("[%d] r-downed: %08x\n",current->pid,rwsem_sem.count.counter);
	mdelay(2);
	kdebug("[%d] r-upping: %08x\n",current->pid,rwsem_sem.count.counter);
	up_read(&rwsem_sem);
	kdebug("[%d] r-upped: %08x\n",current->pid,rwsem_sem.count.counter);

	return -ENOENT;
}

static int rwsem_write_proc(struct file *file, const char *buffer, unsigned long count, void *data)
{
	kdebug("[%d] w-downing: %08x\n",current->pid,rwsem_sem.count.counter);
	down_write(&rwsem_sem);
	kdebug("[%d] w-downed: %08x\n",current->pid,rwsem_sem.count.counter);
	mdelay(2);
	kdebug("[%d] w-upping: %08x\n",current->pid,rwsem_sem.count.counter);
	up_write(&rwsem_sem);
	kdebug("[%d] w-upped: %08x\n",current->pid,rwsem_sem.count.counter);

	return -ENOENT;
}

static int __init rwsem_init_module(void)
{
	kdebug(KERN_INFO "rwsem loading...\n");

	init_rwsem(&rwsem_sem);

	rwsem_proc = create_proc_entry("rwsem",S_IRUGO|S_IWUGO,NULL);
	if (!rwsem_proc)
		return -EEXIST;

	rwsem_proc->read_proc = &rwsem_read_proc;
	rwsem_proc->write_proc = &rwsem_write_proc;
	return 0;
}

static void __exit rwsem_cleanup_module(void)
{
	kdebug(KERN_INFO "rwsem unloading\n");

	remove_proc_entry("rwsem",NULL);

}

module_init(rwsem_init_module);
module_exit(rwsem_cleanup_module);

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="driver.c"; charset="us-ascii"
Content-ID: <11838.986925354.4@warthog.cambridge.redhat.com>
Content-Description: rw-semaphore testing module driver program

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
	char buf[1];
	int max, loop, fd, tmp, rw;

	fd = open("/proc/rwsem",O_RDWR);
	if (fd<0) {
		perror("open");
		return 1;
	}

	max = (argc>1) ? atoi(argv[1]) : 50;
	rw = max<0;
	max = abs(max);

	for (loop=max; loop>0; loop--) {
		switch (fork()) {
		case -1:
			perror("fork");
			return 1;
		case 0:
			rw ? write(fd," ",1) : read(fd,buf,1);
			exit(1);
		default:
			break;
		}
	}

	for (loop=max; loop>0; loop--) {
		if (wait(&tmp)<0) {
			perror("wait");
			return 1;
		}
	}

	return 0;
}

------- =_aaaaaaaaaa0--
