Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbRDKVmd>; Wed, 11 Apr 2001 17:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRDKVmQ>; Wed, 11 Apr 2001 17:42:16 -0400
Received: from t2.redhat.com ([199.183.24.243]:20977 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S133006AbRDKVlp>; Wed, 11 Apr 2001 17:41:45 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4th try: i386 rw_semaphores fix 
In-Reply-To: Your message of "Wed, 11 Apr 2001 17:37:10 BST."
             <17213.987007030@warthog.cambridge.redhat.com> 
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <17787.987025165.0@warthog.cambridge.redhat.com>
Date: Wed, 11 Apr 2001 22:41:39 +0100
Message-ID: <17794.987025299@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17787.987025165.1@warthog.cambridge.redhat.com>

Here's the RW semaphore patch attempt #4. This fixes the bugs that Andrew
Morton's test cases showed up.

It simplifies the __wake_up_ctx_common() function and adds an iterative clause
to the end of rwsem_wake().

David

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem4.diff"; charset="us-ascii"
Content-ID: <17787.987025165.2@warthog.cambridge.redhat.com>
Content-Description: rw-semaphore patch, attempt #4

diff -uNr linux-2.4.3/arch/i386/config.in linux-rwsem/arch/i386/config.in
--- linux-2.4.3/arch/i386/config.in	Thu Apr  5 14:44:04 2001
+++ linux-rwsem/arch/i386/config.in	Wed Apr 11 08:38:04 2001
@@ -47,11 +47,13 @@
 
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
+   define_bool CONFIG_X86_XADD n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
    define_bool CONFIG_X86_CMPXCHG y
+   define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
 fi
diff -uNr linux-2.4.3/arch/i386/kernel/semaphore.c linux-rwsem/arch/i386/kernel/semaphore.c
--- linux-2.4.3/arch/i386/kernel/semaphore.c	Thu Apr  5 14:38:34 2001
+++ linux-rwsem/arch/i386/kernel/semaphore.c	Wed Apr 11 22:30:59 2001
@@ -14,7 +14,6 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
-
 #include <asm/semaphore.h>
 
 /*
@@ -179,6 +178,7 @@
  * value..
  */
 asm(
+".text\n"
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
@@ -193,6 +193,7 @@
 );
 
 asm(
+".text\n"
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
@@ -205,6 +206,7 @@
 );
 
 asm(
+".text\n"
 ".align 4\n"
 ".globl __down_failed_trylock\n"
 "__down_failed_trylock:\n\t"
@@ -217,6 +219,7 @@
 );
 
 asm(
+".text\n"
 ".align 4\n"
 ".globl __up_wakeup\n"
 "__up_wakeup:\n\t"
@@ -232,197 +235,292 @@
 
 asm(
 "
+.text
 .align 4
 .globl __down_read_failed
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
 
 asm(
 "
+.text
 .align 4
 .globl __down_write_failed
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
+.text
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
+/*
+ * implement exchange and add functionality
+ */
+static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
 {
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-
-	add_wait_queue(&sem->wait, &wait);	/* put ourselves at the head of the list */
+	int tmp = delta;
 
-	for (;;) {
-		if (sem->read_bias_granted && xchg(&sem->read_bias_granted, 0))
-			break;
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (!sem->read_bias_granted)
-			schedule();
-	}
-
-	remove_wait_queue(&sem->wait, &wait);
-	tsk->state = TASK_RUNNING;
+#ifndef CONFIG_USING_SPINLOCK_BASED_RWSEM
+	__asm__ __volatile__(
+		LOCK_PREFIX "xadd %0,(%1)"
+		: "+r"(tmp)
+		: "r"(sem)
+		: "memory");
+
+#else
+
+	__asm__ __volatile__(
+		"# beginning rwsem_atomic_update\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  xchgl     %0,(%1)\n\t" /* retrieve the old value */
+		"  addl      %0,(%1)\n\t" /* add 0xffff0001, result in memory */
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t" /* release the spinlock */
+#endif
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		".previous\n"
+		"# ending rwsem_atomic_update\n\t"
+		: "+r"(tmp)
+		: "r"(sem)
+		: "memory");
 
-	return sem;
+#endif
+	return tmp+delta;
 }
 
-struct rw_semaphore *down_write_failed_biased(struct rw_semaphore *sem)
+/*
+ * implement compare and exchange functionality on the rw-semaphore count LSW
+ */
+static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
 {
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+#ifndef CONFIG_USING_SPINLOCK_BASED_RWSEM
+	return cmpxchg((__u16*)&sem->count.counter,0,RWSEM_ACTIVE_BIAS);
 
-	add_wait_queue_exclusive(&sem->write_bias_wait, &wait);	/* put ourselves at the end of the list */
+#else
+	__u16 prev;
 
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
-
-	/* if the lock is currently unbiased, awaken the sleepers
-	 * FIXME: this wakes up the readers early in a bit of a
-	 * stampede -> bad!
-	 */
-	if (atomic_read(&sem->count) >= 0)
-		wake_up(&sem->wait);
+	__asm__ __volatile__(
+		"# beginning rwsem_cmpxchgw\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  cmpw      %w1,(%3)\n\t"
+		"  jne       4f\n\t" /* jump if old doesn't match sem->count LSW */
+		"  movw      %w2,(%3)\n\t" /* replace sem->count LSW with the new value */
+		"2:\n\t"
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t" /* release the spinlock */
+#endif
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		"4:\n\t"
+		"  movw      (%3),%w0\n" /* we'll want to return the current value */
+		"  jmp       2b\n"
+		".previous\n"
+		"# ending rwsem_cmpxchgw\n\t"
+		: "=r"(prev)
+		: "r0"(old), "r"(new), "r"(sem)
+		: "memory");
 
-	return sem;
+	return prev;
+#endif
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
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're now waiting on the lock, but no longer actively read-locking */
+	count = rwsem_atomic_update(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,sem);
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
+		if (!test_bit(RWSEM_WAITING_FOR_READ,&wait.flags))
 			break;
 		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
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
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
-	while (atomic_read(&sem->count) < 0) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
-			break;	/* we must attempt to acquire or bias the lock */
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're waiting on the lock, but no longer actively locking */
+	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
+	rwsemdebug("[%d] updated(%08x)\n",current->pid,count);
+
+	/* if there are no longer active locks, wake the front queued process(es) up
+	 * - it might even be this process, since the waker takes a more active part
+	 */
+	if (!(count & RWSEM_ACTIVE_MASK))
+		rwsem_wake(sem);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!test_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags))
+			break;
 		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
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
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
+ *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ */
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+{
+	int woken, count;
 
-	jz	1f
-	call	rwsem_wake_readers
-	jmp	2f
+	rwsemdebug("[%d] Entering rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
 
-1:	call	rwsem_wake_writer
+ try_again:
+	/* try to grab an 'activity' marker
+	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
+	 *   simultaneously
+	 * - be horribly naughty, and only deal with the LSW of the atomic counter
+	 */
+	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0) {
+		rwsemdebug("[%d] rwsem_wake: abort wakeup due to renewed activity\n",current->pid);
+		goto out;
+	}
 
-2:	popl	%ecx
-	popl	%edx
-	ret
-"
-);
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
+	 *   incremented by 0x00010000
+	 */
+	if (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)==1)
+		goto out;
 
-/* Called when someone has done an up that transitioned from
- * negative to non-negative, meaning that the lock has been
- * granted to whomever owned the bias.
- */
-struct rw_semaphore *rwsem_wake_readers(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->read_bias_granted, 1))
-		BUG();
-	wake_up(&sem->wait);
-	return sem;
-}
+	/* grant an infinite number of read locks to the readers at the front of the queue
+	 * - note we increment the 'active part' of the count by the number of readers just woken,
+	 *   less one for the activity decrement we've already done
+	 */
+	woken = wake_up_ctx(&sem->wait,65535,-RWSEM_WAITING_FOR_READ);
+	if (woken<=0)
+		goto counter_correction;
+
+	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
+	woken -= RWSEM_ACTIVE_BIAS;
+	rwsem_atomic_update(woken,sem);
 
-struct rw_semaphore *rwsem_wake_writer(struct rw_semaphore *sem)
-{
-	if (xchg(&sem->write_bias_granted, 1))
-		BUG();
-	wake_up(&sem->write_bias_wait);
+ out:
+	rwsemdebug("[%d] Leaving rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
 	return sem;
+
+	/* come here if we need to correct the counter for odd SMP-isms */
+ counter_correction:
+	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
+	rwsemdebug("[%d] corrected(%08x)\n",current->pid,count);
+	if (!(count & RWSEM_ACTIVE_MASK))
+		goto try_again;
+	goto out;
 }
 
+/*
+ * rw spinlock fallbacks
+ */
 #if defined(CONFIG_SMP)
 asm(
 "
@@ -451,4 +549,3 @@
 "
 );
 #endif
-
diff -uNr linux-2.4.3/include/asm-i386/rwsem-spin.h linux-rwsem/include/asm-i386/rwsem-spin.h
--- linux-2.4.3/include/asm-i386/rwsem-spin.h	Thu Jan  1 01:00:00 1970
+++ linux-rwsem/include/asm-i386/rwsem-spin.h	Wed Apr 11 22:28:32 2001
@@ -0,0 +1,239 @@
+/* rwsem.h: R/W semaphores based on spinlocks
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ *
+ * Derived from asm-i386/semaphore.h and asm-i386/spinlock.h
+ */
+
+#ifndef _I386_RWSEM_SPIN_H
+#define _I386_RWSEM_SPIN_H
+
+#ifdef __KERNEL__
+
+#define CONFIG_USING_SPINLOCK_BASED_RWSEM 1
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	atomic_t		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		lock;
+#define RWSEM_SPINLOCK_OFFSET_STR	"4" /* byte offset of spinlock */
+	wait_queue_head_t	wait;
+#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
+#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+#if RWSEM_DEBUG_MAGIC
+	long			__magic;
+	atomic_t		readers;
+	atomic_t		writers;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+#if RWSEM_DEBUG_MAGIC
+#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
+#else
+#define __RWSEM_DEBUG_MINIT(name)	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name,count) \
+{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), SPIN_LOCK_UNLOCKED, \
+	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
+
+#define __DECLARE_RWSEM_GENERIC(name,count) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
+
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	atomic_set(&sem->count, RWSEM_UNLOCKED_VALUE);
+	spin_lock_init(&sem->lock);
+	init_waitqueue_head(&sem->wait);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+#if RWSEM_DEBUG_MAGIC
+	sem->__magic = (long)&sem->__magic;
+	atomic_set(&sem->readers, 0);
+	atomic_set(&sem->writers, 0);
+#endif
+}
+
+/*
+ * lock for reading
+ */
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+		"# beginning down_read\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
+#endif
+		"  js        4f\n\t" /* jump if we weren't granted the lock */
+		"2:\n"
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		"4:\n\t"
+		"  call      __down_read_failed\n\t"
+		"  jmp       2b\n"
+		".previous"
+		"# ending __down_read\n\t"
+		: "=m"(sem->count), "=m"(sem->lock)
+		: "a"(sem), "m"(sem->count), "m"(sem->lock)
+		: "memory");
+}
+
+/*
+ * lock for writing
+ */
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = RWSEM_ACTIVE_WRITE_BIAS;
+	__asm__ __volatile__(
+		"# beginning down_write\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
+		"  add       %0,(%%eax)\n\t" /* add 0xffff0001, result in memory */
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
+#endif
+		"  testl     %0,%0\n\t" /* was the count 0 before? */
+		"  jnz       4f\n\t" /* jump if we weren't granted the lock */
+		"2:\n\t"
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		"4:\n\t"
+		"  call     __down_write_failed\n\t"
+		"  jmp      2b\n"
+		".previous\n"
+		"# ending down_write"
+		: "+r"(tmp), "=m"(sem->count), "=m"(sem->lock)
+		: "a"(sem), "m"(sem->count), "m"(sem->lock)
+		: "memory");
+}
+
+/*
+ * unlock after reading
+ */
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = -RWSEM_ACTIVE_READ_BIAS;
+	__asm__ __volatile__(
+		"# beginning __up_read\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
+		"  addl      %0,(%%eax)\n\t" /* subtract 1, result in memory */
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
+#endif
+		"  js        4f\n\t" /* jump if the lock is being waited upon */
+		"2:\n\t"
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		"4:\n\t"
+		"  decl      %0\n\t" /* xchg gave us the old count */
+		"  testl     %4,%0\n\t" /* do nothing if still outstanding active readers */
+		"  jnz       2b\n\t"
+		"  call      __rwsem_wake\n\t"
+		"  jmp       2b\n"
+		".previous\n"
+		"# ending __up_read\n"
+		: "+r"(tmp), "=m"(sem->count), "=m"(sem->lock)
+		: "a"(sem), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count), "m"(sem->lock)
+		: "memory");
+}
+
+/*
+ * unlock after writing
+ */
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+		"# beginning __up_write\n\t"
+#ifdef CONFIG_SMP
+LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
+		"  js        3f\n" /* jump if failed */
+		"1:\n\t"
+#endif
+		"  addl      %3,(%%eax)\n\t" /* adds 0x00010001 */
+#ifdef CONFIG_SMP
+		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
+#endif
+		"  js        4f\n\t" /* jump if the lock is being waited upon */
+		"2:\n\t"
+		".section .text.lock,\"ax\"\n"
+#ifdef CONFIG_SMP
+		"3:\n\t" /* spin on the spinlock till we get it */
+		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
+		"  rep;nop   \n\t"
+		"  jle       3b\n\t"
+		"  jmp       1b\n"
+#endif
+		"4:\n\t"
+		"  call     __rwsem_wake\n\t"
+		"  jmp      2b\n"
+		".previous\n"
+		"# ending __up_write\n"
+		: "=m"(sem->count), "=m"(sem->lock)
+		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count), "m"(sem->lock)
+		: "memory");
+}
+
+#endif /* __KERNEL__ */
+#endif /* _I386_RWSEM_SPIN_H */
diff -uNr linux-2.4.3/include/asm-i386/rwsem-xadd.h linux-rwsem/include/asm-i386/rwsem-xadd.h
--- linux-2.4.3/include/asm-i386/rwsem-xadd.h	Thu Jan  1 01:00:00 1970
+++ linux-rwsem/include/asm-i386/rwsem-xadd.h	Wed Apr 11 22:28:30 2001
@@ -0,0 +1,194 @@
+/* rwsem-xadd.h: R/W semaphores implemented using XADD/CMPXCHG
+ *
+ * Written by David Howells (dhowells@redhat.com), 2001.
+ * Derived from asm-i386/semaphore.h
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
+ */
+
+#ifndef _I386_RWSEM_XADD_H
+#define _I386_RWSEM_XADD_H
+
+#ifdef __KERNEL__
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	atomic_t		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	wait_queue_head_t	wait;
+#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
+#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+#if RWSEM_DEBUG_MAGIC
+	long			__magic;
+	atomic_t		readers;
+	atomic_t		writers;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+#if RWSEM_DEBUG_MAGIC
+#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
+#else
+#define __RWSEM_DEBUG_MINIT(name)	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name,count) \
+{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
+
+#define __DECLARE_RWSEM_GENERIC(name,count) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
+
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	atomic_set(&sem->count, RWSEM_UNLOCKED_VALUE);
+	init_waitqueue_head(&sem->wait);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+#if RWSEM_DEBUG_MAGIC
+	sem->__magic = (long)&sem->__magic;
+	atomic_set(&sem->readers, 0);
+	atomic_set(&sem->writers, 0);
+#endif
+}
+
+/*
+ * lock for reading
+ */
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+		"# beginning down_read\n\t"
+LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
+		"  js        2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  call      __down_read_failed\n\t"
+		"  jmp       1b\n"
+		".previous"
+		"# ending down_read\n\t"
+		: "=m"(sem->count)
+		: "a"(sem), "m"(sem->count)
+		: "memory");
+}
+
+/*
+ * lock for writing
+ */
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = RWSEM_ACTIVE_WRITE_BIAS;
+	__asm__ __volatile__(
+		"# beginning down_write\n\t"
+LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x00010001, returns the old value */
+		"  testl     %0,%0\n\t" /* was the count 0 before? */
+		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  call      __down_write_failed\n\t"
+		"  jmp       1b\n"
+		".previous\n"
+		"# ending down_write"
+		: "+r"(tmp), "=m"(sem->count)
+		: "a"(sem), "m"(sem->count)
+		: "memory");
+}
+
+/*
+ * unlock after reading
+ */
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = -RWSEM_ACTIVE_READ_BIAS;
+	__asm__ __volatile__(
+		"# beginning __up_read\n\t"
+LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtracts 1, returns the old value */
+		"  js        2f\n\t" /* jump if the lock is being waited upon */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  decl      %0\n\t" /* xadd gave us the old count */
+		"  testl     %3,%0\n\t" /* do nothing if still outstanding active readers */
+		"  jnz       1b\n\t"
+		"  call      __rwsem_wake\n\t"
+		"  jmp       1b\n"
+		".previous\n"
+		"# ending __up_read\n"
+		: "+r"(tmp), "=m"(sem->count)
+		: "a"(sem), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count)
+		: "memory");
+}
+
+/*
+ * unlock after writing
+ */
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+		"# beginning __up_write\n\t"
+LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* adds 0x0000ffff */
+		"  js        2f\n\t" /* jump if the lock is being waited upon */
+		"1:\n\t"
+		".section .text.lock,\"ax\"\n"
+		"2:\n\t"
+		"  call      __rwsem_wake\n\t"
+		"  jmp       1b\n"
+		".previous\n"
+		"# ending __up_write\n"
+		: "=m"(sem->count)
+		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count)
+		: "memory");
+}
+
+#endif /* __KERNEL__ */
+#endif /* _I386_RWSEM_XADD_H */
diff -uNr linux-2.4.3/include/asm-i386/rwsem.h linux-rwsem/include/asm-i386/rwsem.h
--- linux-2.4.3/include/asm-i386/rwsem.h	Thu Jan  1 01:00:00 1970
+++ linux-rwsem/include/asm-i386/rwsem.h	Wed Apr 11 22:28:27 2001
@@ -0,0 +1,133 @@
+/* rwsem.h: R/W semaphores based on spinlocks
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ *
+ * Derived from asm-i386/semaphore.h
+ */
+
+#ifndef _I386_RWSEM_H
+#define _I386_RWSEM_H
+
+#include <linux/linkage.h>
+
+#define RWSEM_DEBUG 0
+#define RWSEM_DEBUG_MAGIC 0
+
+#ifdef __KERNEL__
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/spinlock.h>
+#include <linux/wait.h>
+
+#if RWSEM_DEBUG
+#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); } while(0)
+#else
+#define rwsemdebug(FMT,...)
+#endif
+
+/* old gcc */
+#if RWSEM_DEBUG
+//#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); } while(0)
+#else
+//#define rwsemdebug(FMT, ARGS...)
+#endif
+
+#ifdef CONFIG_X86_XADD
+#include <asm/rwsem-xadd.h> /* use XADD based semaphores if possible */
+#else
+#include <asm/rwsem-spin.h> /* use spinlock based semaphores otherwise */
+#endif
+
+/* we use FASTCALL convention for the helpers */
+extern struct rw_semaphore *FASTCALL(__down_read_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(__down_write_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
+
+/*
+ * lock for reading
+ */
+static inline void down_read(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering down_read(count=%08x)\n",atomic_read(&sem->count));
+
+#if RWSEM_DEBUG_MAGIC
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+
+	__down_read(sem);
+
+#if RWSEM_DEBUG_MAGIC
+	if (atomic_read(&sem->writers))
+		BUG();
+	atomic_inc(&sem->readers);
+#endif
+
+	rwsemdebug("Leaving down_read(count=%08x)\n",atomic_read(&sem->count));
+}
+
+/*
+ * lock for writing
+ */
+static inline void down_write(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering down_write(count=%08x)\n",atomic_read(&sem->count));
+
+#if RWSEM_DEBUG_MAGIC
+	if (sem->__magic != (long)&sem->__magic)
+		BUG();
+#endif
+
+	__down_write(sem);
+
+#if RWSEM_DEBUG_MAGIC
+	if (atomic_read(&sem->writers))
+		BUG();
+	if (atomic_read(&sem->readers))
+		BUG();
+	atomic_inc(&sem->writers);
+#endif
+
+	rwsemdebug("Leaving down_write(count=%08x)\n",atomic_read(&sem->count));
+}
+
+/*
+ * release a read lock
+ */
+static inline void up_read(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering up_read(count=%08x)\n",atomic_read(&sem->count));
+
+#if RWSEM_DEBUG_MAGIC
+	if (atomic_read(&sem->writers))
+		BUG();
+	atomic_dec(&sem->readers);
+#endif
+	__up_read(sem);
+
+	rwsemdebug("Leaving up_read(count=%08x)\n",atomic_read(&sem->count));
+}
+
+/*
+ * release a write lock
+ */
+static inline void up_write(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering up_write(count=%08x)\n",atomic_read(&sem->count));
+
+#if RWSEM_DEBUG_MAGIC
+	if (atomic_read(&sem->readers))
+		BUG();
+	if (atomic_read(&sem->writers) != 1)
+		BUG();
+	atomic_dec(&sem->writers);
+#endif
+	__up_write(sem);
+
+	rwsemdebug("Leaving up_write(count=%08x)\n",atomic_read(&sem->count));
+}
+
+
+#endif /* __KERNEL__ */
+#endif /* _I386_RWSEM_H */
diff -uNr linux-2.4.3/include/asm-i386/semaphore.h linux-rwsem/include/asm-i386/semaphore.h
--- linux-2.4.3/include/asm-i386/semaphore.h	Thu Apr  5 14:50:36 2001
+++ linux-rwsem/include/asm-i386/semaphore.h	Wed Apr 11 13:29:12 2001
@@ -38,8 +38,8 @@
 
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/rwlock.h>
 #include <linux/wait.h>
+#include <asm/rwsem.h>
 
 struct semaphore {
 	atomic_t count;
@@ -202,184 +202,6 @@
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
-}
-
-/* rw mutexes (should that be mutices? =) -- throw rw
- * spinlocks and semaphores together, and this is what we
- * end up with...
- *
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
- *
- *		-ben
- */
-struct rw_semaphore {
-	atomic_t		count;
-	volatile unsigned char	write_bias_granted;
-	volatile unsigned char	read_bias_granted;
-	volatile unsigned char	pad1;
-	volatile unsigned char	pad2;
-	wait_queue_head_t	wait;
-	wait_queue_head_t	write_bias_wait;
-#if WAITQUEUE_DEBUG
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-#define __RWSEM_DEBUG_INIT	, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, 0, 0, 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait), \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).write_bias_wait) \
-	__SEM_DEBUG_INIT(name) __RWSEM_DEBUG_INIT }
-
-#define __DECLARE_RWSEM_GENERIC(name,count) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
-
-#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
-#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
-#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	atomic_set(&sem->count, RW_LOCK_BIAS);
-	sem->read_bias_granted = 0;
-	sem->write_bias_granted = 0;
-	init_waitqueue_head(&sem->wait);
-	init_waitqueue_head(&sem->write_bias_wait);
-#if WAITQUEUE_DEBUG
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
-}
-
-/* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(__down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
-
-static inline void down_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_read_lock(sem, "__down_read_failed");
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_inc(&sem->readers);
-#endif
-}
-
-static inline void down_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-	__build_write_lock(sem, "__down_write_failed");
-#if WAITQUEUE_DEBUG
-	if (atomic_read(&sem->writers))
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	atomic_inc(&sem->writers);
-#endif
-}
-
-/* When a reader does a release, the only significant
- * case is when there was a writer waiting, and we've
- * bumped the count to 0: we must wake the writer up.
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_read\n\t"
-		LOCK "incl %0\n\t"
-		"jz 2f\n"			/* only do the wake if result == 0 (ie, a writer) */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-/* releasing the writer is easy -- just release it and
- * wake up any sleepers.
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# up_write\n\t"
-		LOCK "addl $" RW_LOCK_BIAS_STR ",%0\n"
-		"jc 2f\n"			/* only do the wake if the result was -'ve to 0/+'ve */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\tcall __rwsem_wake\n\t"
-		"jmp 1b\n"
-		".previous"
-		:"=m" (sem->count)
-		:"a" (sem)
-		:"memory"
-		);
-}
-
-static inline void up_read(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_dec(&sem->readers);
-#endif
-	__up_read(sem);
-}
-
-static inline void up_write(struct rw_semaphore *sem)
-{
-#if WAITQUEUE_DEBUG
-	if (sem->read_bias_granted)
-		BUG();
-	if (sem->write_bias_granted)
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (atomic_read(&sem->writers) != 1)
-		BUG();
-	atomic_dec(&sem->writers);
-#endif
-	__up_write(sem);
 }
 
 #endif
diff -uNr linux-2.4.3/include/linux/sched.h linux-rwsem/include/linux/sched.h
--- linux-2.4.3/include/linux/sched.h	Thu Apr  5 14:50:36 2001
+++ linux-rwsem/include/linux/sched.h	Wed Apr 11 13:29:12 2001
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
diff -uNr linux-2.4.3/include/linux/wait.h linux-rwsem/include/linux/wait.h
--- linux-2.4.3/include/linux/wait.h	Thu Apr  5 14:50:36 2001
+++ linux-rwsem/include/linux/wait.h	Wed Apr 11 13:25:44 2001
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
diff -uNr linux-2.4.3/kernel/fork.c linux-rwsem/kernel/fork.c
--- linux-2.4.3/kernel/fork.c	Thu Apr  5 14:44:17 2001
+++ linux-rwsem/kernel/fork.c	Tue Apr 10 09:19:47 2001
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
diff -uNr linux-2.4.3/kernel/sched.c linux-rwsem/kernel/sched.c
--- linux-2.4.3/kernel/sched.c	Thu Apr  5 14:44:17 2001
+++ linux-rwsem/kernel/sched.c	Wed Apr 11 22:30:11 2001
@@ -739,7 +739,7 @@
 		state = p->state;
 		if (state & mode) {
 			WQ_NOTE_WAKER(curr);
-			if (try_to_wake_up(p, sync) && curr->flags && !--nr_exclusive)
+			if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 				break;
 		}
 	}
@@ -763,6 +763,75 @@
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
+static inline int __wake_up_ctx_common (wait_queue_head_t *q,
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
+                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
+
+		tmp = tmp->next;
+		CHECK_MAGIC(curr->__magic);
+		p = curr->task;
+		if (!test_and_clear_bit(bit,&curr->flags)) {
+			if (stop)
+				break;
+			continue;
+		}
+
+		WQ_NOTE_WAKER(curr);
+		try_to_wake_up(p,sync);
+
+		woken++;
+		if (woken>=count)
+			break;
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
+		woken = __wake_up_ctx_common(q, count, bit, 0);
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
+		woken = __wake_up_ctx_common(q, count, bit, 1);
+		wq_read_unlock_irqrestore(&q->lock, flags);
+	}
+	return woken;
 }
 
 #define	SLEEP_ON_VAR				\

------- =_aaaaaaaaaa0--
