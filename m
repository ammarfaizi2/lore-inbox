Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135196AbRDLPH1>; Thu, 12 Apr 2001 11:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135198AbRDLPHK>; Thu, 12 Apr 2001 11:07:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:9977 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S135196AbRDLPGv>; Thu, 12 Apr 2001 11:06:51 -0400
To: Anton Blanchard <anton@samba.org>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 rw_semaphores, general abstraction patch
In-Reply-To: Message from Anton Blanchard <anton@samba.org> 
   of "Wed, 11 Apr 2001 16:00:43 PDT." <20010411160043.A4304@va.samba.org> 
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <22011.987087919.0@warthog.cambridge.redhat.com>
Date: Thu, 12 Apr 2001 16:06:40 +0100
Message-ID: <22014.987088000@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22011.987087919.1@warthog.cambridge.redhat.com>

This patch (made against linux-2.4.4-pre2) takes Anton Blanchard's suggestions
and abstracts out the rwsem implementation somewhat. This makes the following
general files:

	include/linux/rwsem.h		- general RW semaphore wrapper
	include/linux/rwsem-spinlock.h	- rwsem inlines implemented in C
	include/asm-xxx/rwsem.h		- arch specific rwsem details
	lib/rwsem.c			- contention handlers for rwsems

The asm/rwsem.h file is responsible for specifying whether the general
default implementation should be used, or supplying an alternative optimised
implementation if not.

For the i386 arch, I've supplied the following:

	include/asm-i386/rwsem.h	- i386 specific rwsem details
	include/asm-i386/rwsem-xadd.h	- i386 XADD optimised rwsems
	include/asm-i386/rwsem-spin.h	- i386 optimised spinlocked rwsems
	arch/i386/lib/rwsem.S		- i386 call wrapper stubs

I haven't changed any of the other arch's, but until their semaphore.h's refer
to linux/rwsem.h, they'll continue to use whatever method they currently
happen to use. Note that the contention handling functions have been renamed
to prevent name clashes with the old contention functions.

David


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem-a.diff"; charset="us-ascii"
Content-ID: <22011.987087919.2@warthog.cambridge.redhat.com>
Content-Description: rw-semaphore general abstraction patch

diff -uNr linux-2.4.4-pre2/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.4-pre2/arch/i386/kernel/i386_ksyms.c	Thu Apr 12 08:57:23 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Apr 12 15:55:35 2001
@@ -80,8 +80,8 @@
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
-EXPORT_SYMBOL_NOVERS(__down_write_failed);
-EXPORT_SYMBOL_NOVERS(__down_read_failed);
+EXPORT_SYMBOL_NOVERS(__rwsem_down_write_failed);
+EXPORT_SYMBOL_NOVERS(__rwsem_down_read_failed);
 EXPORT_SYMBOL_NOVERS(__rwsem_wake);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
diff -uNr linux-2.4.4-pre2/arch/i386/kernel/semaphore.c linux/arch/i386/kernel/semaphore.c
--- linux-2.4.4-pre2/arch/i386/kernel/semaphore.c	Thu Apr 12 08:57:23 2001
+++ linux/arch/i386/kernel/semaphore.c	Thu Apr 12 10:10:34 2001
@@ -233,291 +233,6 @@
 	"ret"
 );
 
-asm(
-"
-.text
-.align 4
-.globl __down_read_failed
-__down_read_failed:
-	pushl	%edx
-	pushl	%ecx
-	call	down_read_failed
-	popl	%ecx
-	popl	%edx
-	ret
-"
-);
-
-asm(
-"
-.text
-.align 4
-.globl __down_write_failed
-__down_write_failed:
-	pushl	%edx
-	pushl	%ecx
-	call	down_write_failed
-	popl	%ecx
-	popl	%edx
-	ret
-"
-);
-
-asm(
-"
-.text
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-	call	rwsem_wake
-	popl	%ecx
-	popl	%edx
-	ret
-"
-);
-
-struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_read_failed(struct rw_semaphore *sem));
-struct rw_semaphore *FASTCALL(down_write_failed(struct rw_semaphore *sem));
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-#ifndef CONFIG_USING_SPINLOCK_BASED_RWSEM
-	__asm__ __volatile__(
-		LOCK_PREFIX "xadd %0,(%1)"
-		: "+r"(tmp)
-		: "r"(sem)
-		: "memory");
-
-#else
-
-	__asm__ __volatile__(
-		"# beginning rwsem_atomic_update\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  xchgl     %0,(%1)\n\t" /* retrieve the old value */
-		"  addl      %0,(%1)\n\t" /* add 0xffff0001, result in memory */
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t" /* release the spinlock */
-#endif
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%1)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		".previous\n"
-		"# ending rwsem_atomic_update\n\t"
-		: "+r"(tmp)
-		: "r"(sem)
-		: "memory");
-
-#endif
-	return tmp+delta;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count LSW
- */
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
-{
-#ifndef CONFIG_USING_SPINLOCK_BASED_RWSEM
-	return cmpxchg((__u16*)&sem->count.counter,0,RWSEM_ACTIVE_BIAS);
-
-#else
-	__u16 prev;
-
-	__asm__ __volatile__(
-		"# beginning rwsem_cmpxchgw\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  cmpw      %w1,(%3)\n\t"
-		"  jne       4f\n\t" /* jump if old doesn't match sem->count LSW */
-		"  movw      %w2,(%3)\n\t" /* replace sem->count LSW with the new value */
-		"2:\n\t"
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t" /* release the spinlock */
-#endif
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%3)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		"4:\n\t"
-		"  movw      (%3),%w0\n" /* we'll want to return the current value */
-		"  jmp       2b\n"
-		".previous\n"
-		"# ending rwsem_cmpxchgw\n\t"
-		: "=r"(prev)
-		: "r0"(old), "r"(new), "r"(sem)
-		: "memory");
-
-	return prev;
-#endif
-}
-
-/*
- * wait for the read lock to be granted
- * - need to repeal the increment made inline by the caller
- * - need to throw a write-lock style spanner into the works (sub 0x00010000 from count)
- */
-struct rw_semaphore *down_read_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait,tsk);
-	int count;
-
-	rwsemdebug("[%d] Entering down_read_failed(%08x)\n",current->pid,atomic_read(&sem->count));
-
-	/* this waitqueue context flag will be cleared when we are granted the lock */
-	__set_bit(RWSEM_WAITING_FOR_READ,&wait.flags);
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
-
-	/* note that we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,sem);
-	rwsemdebug("X(%08x)\n",count);
-
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		rwsem_wake(sem);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!test_bit(RWSEM_WAITING_FOR_READ,&wait.flags))
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	remove_wait_queue(&sem->wait,&wait);
-	tsk->state = TASK_RUNNING;
-
-	rwsemdebug("[%d] Leaving down_read_failed(%08x)\n",current->pid,atomic_read(&sem->count));
-
-	return sem;
-}
-
-/*
- * wait for the write lock to be granted
- */
-struct rw_semaphore *down_write_failed(struct rw_semaphore *sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait,tsk);
-	int count;
-
-	rwsemdebug("[%d] Entering down_write_failed(%08x)\n",
-		   current->pid,atomic_read(&sem->count));
-
-	/* this waitqueue context flag will be cleared when we are granted the lock */
-	__set_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags);
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-
-	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
-
-	/* note that we're waiting on the lock, but no longer actively locking */
-	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
-	rwsemdebug("[%d] updated(%08x)\n",current->pid,count);
-
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		rwsem_wake(sem);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!test_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags))
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	remove_wait_queue(&sem->wait,&wait);
-	tsk->state = TASK_RUNNING;
-
-	rwsemdebug("[%d] Leaving down_write_failed(%08x)\n",current->pid,atomic_read(&sem->count));
-
-	return sem;
-}
-
-/*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
- *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
- */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
-{
-	int woken, count;
-
-	rwsemdebug("[%d] Entering rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
-
- try_again:
-	/* try to grab an 'activity' marker
-	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
-	 *   simultaneously
-	 * - be horribly naughty, and only deal with the LSW of the atomic counter
-	 */
-	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0) {
-		rwsemdebug("[%d] rwsem_wake: abort wakeup due to renewed activity\n",current->pid);
-		goto out;
-	}
-
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
-	 *   incremented by 0x00010000
-	 */
-	if (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)==1)
-		goto out;
-
-	/* grant an infinite number of read locks to the readers at the front of the queue
-	 * - note we increment the 'active part' of the count by the number of readers just woken,
-	 *   less one for the activity decrement we've already done
-	 */
-	woken = wake_up_ctx(&sem->wait,65535,-RWSEM_WAITING_FOR_READ);
-	if (woken<=0)
-		goto counter_correction;
-
-	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
-	woken -= RWSEM_ACTIVE_BIAS;
-	rwsem_atomic_update(woken,sem);
-
- out:
-	rwsemdebug("[%d] Leaving rwsem_wake(%08x)\n",current->pid,atomic_read(&sem->count));
-	return sem;
-
-	/* come here if we need to correct the counter for odd SMP-isms */
- counter_correction:
-	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
-	rwsemdebug("[%d] corrected(%08x)\n",current->pid,count);
-	if (!(count & RWSEM_ACTIVE_MASK))
-		goto try_again;
-	goto out;
-}
-
 /*
  * rw spinlock fallbacks
  */
diff -uNr linux-2.4.4-pre2/arch/i386/lib/Makefile linux/arch/i386/lib/Makefile
--- linux-2.4.4-pre2/arch/i386/lib/Makefile	Thu Apr 12 08:57:23 2001
+++ linux/arch/i386/lib/Makefile	Thu Apr 12 10:07:33 2001
@@ -9,7 +9,7 @@
 
 obj-y = checksum.o old-checksum.o delay.o \
 	usercopy.o getuser.o putuser.o \
-	memcpy.o strstr.o
+	memcpy.o strstr.o rwsem.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -uNr linux-2.4.4-pre2/arch/i386/lib/rwsem.S linux/arch/i386/lib/rwsem.S
--- linux-2.4.4-pre2/arch/i386/lib/rwsem.S	Thu Jan  1 01:00:00 1970
+++ linux/arch/i386/lib/rwsem.S	Thu Apr 12 15:49:25 2001
@@ -0,0 +1,36 @@
+/* rwsem.S: R/W semaphores, register saving wrapper function stubs
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ * Derived from arch/i386/kernel/semaphore.c
+ */
+
+.text
+.align 4
+.globl __rwsem_down_read_failed
+__rwsem_down_read_failed:
+	pushl	%edx
+	pushl	%ecx
+	call	rwsem_down_read_failed
+	popl	%ecx
+	popl	%edx
+	ret
+
+.align 4
+.globl __rwsem_down_write_failed
+__rwsem_down_write_failed:
+	pushl	%edx
+	pushl	%ecx
+	call	rwsem_down_write_failed
+	popl	%ecx
+	popl	%edx
+	ret
+
+.align 4
+.globl __rwsem_wake
+__rwsem_wake:
+	pushl	%edx
+	pushl	%ecx
+	call	rwsem_wake
+	popl	%ecx
+	popl	%edx
+	ret
diff -uNr linux-2.4.4-pre2/include/asm-i386/rwsem-spin.h linux/include/asm-i386/rwsem-spin.h
--- linux-2.4.4-pre2/include/asm-i386/rwsem-spin.h	Thu Apr 12 08:57:28 2001
+++ linux/include/asm-i386/rwsem-spin.h	Thu Apr 12 15:52:13 2001
@@ -8,6 +8,12 @@
 #ifndef _I386_RWSEM_SPIN_H
 #define _I386_RWSEM_SPIN_H
 
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem-spin.h directly, use linux/rwsem.h instead
+#endif
+
+#include <linux/spinlock.h>
+
 #ifdef __KERNEL__
 
 #define CONFIG_USING_SPINLOCK_BASED_RWSEM 1
@@ -16,7 +22,7 @@
  * the semaphore definition
  */
 struct rw_semaphore {
-	atomic_t		count;
+	signed long		count;
 #define RWSEM_UNLOCKED_VALUE		0x00000000
 #define RWSEM_ACTIVE_BIAS		0x00000001
 #define RWSEM_ACTIVE_MASK		0x0000ffff
@@ -53,7 +59,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), SPIN_LOCK_UNLOCKED, \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
 	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
 	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
 
@@ -66,7 +72,7 @@
 
 static inline void init_rwsem(struct rw_semaphore *sem)
 {
-	atomic_set(&sem->count, RWSEM_UNLOCKED_VALUE);
+	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->lock);
 	init_waitqueue_head(&sem->wait);
 #if RWSEM_DEBUG
@@ -106,7 +112,7 @@
 		"  jmp       1b\n"
 #endif
 		"4:\n\t"
-		"  call      __down_read_failed\n\t"
+		"  call      __rwsem_down_read_failed\n\t"
 		"  jmp       2b\n"
 		".previous"
 		"# ending __down_read\n\t"
@@ -147,7 +153,7 @@
 		"  jmp       1b\n"
 #endif
 		"4:\n\t"
-		"  call     __down_write_failed\n\t"
+		"  call     __rwsem_down_write_failed\n\t"
 		"  jmp      2b\n"
 		".previous\n"
 		"# ending down_write"
@@ -233,6 +239,83 @@
 		: "=m"(sem->count), "=m"(sem->lock)
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count), "m"(sem->lock)
 		: "memory");
+}
+
+/*
+ * implement exchange and add functionality
+ */
+static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
+{
+	int tmp = delta;
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
+
+	return tmp+delta;
+}
+
+/*
+ * implement compare and exchange functionality on the rw-semaphore count LSW
+ */
+static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
+{
+	__u16 prev;
+
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
+
+	return prev;
 }
 
 #endif /* __KERNEL__ */
diff -uNr linux-2.4.4-pre2/include/asm-i386/rwsem-xadd.h linux/include/asm-i386/rwsem-xadd.h
--- linux-2.4.4-pre2/include/asm-i386/rwsem-xadd.h	Thu Apr 12 08:57:28 2001
+++ linux/include/asm-i386/rwsem-xadd.h	Thu Apr 12 15:47:55 2001
@@ -2,42 +2,22 @@
  *
  * Written by David Howells (dhowells@redhat.com), 2001.
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
 
 #ifndef _I386_RWSEM_XADD_H
 #define _I386_RWSEM_XADD_H
 
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem-xadd.h directly, use linux/rwsem.h instead
+#endif
+
 #ifdef __KERNEL__
 
 /*
  * the semaphore definition
  */
 struct rw_semaphore {
-	atomic_t		count;
+	signed long		count;
 #define RWSEM_UNLOCKED_VALUE		0x00000000
 #define RWSEM_ACTIVE_BIAS		0x00000001
 #define RWSEM_ACTIVE_MASK		0x0000ffff
@@ -72,7 +52,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name,count) \
-{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+{ RWSEM_UNLOCKED_VALUE, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
 	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
 
 #define __DECLARE_RWSEM_GENERIC(name,count) \
@@ -84,7 +64,7 @@
 
 static inline void init_rwsem(struct rw_semaphore *sem)
 {
-	atomic_set(&sem->count, RWSEM_UNLOCKED_VALUE);
+	sem->count = RWSEM_UNLOCKED_VALUE;
 	init_waitqueue_head(&sem->wait);
 #if RWSEM_DEBUG
 	sem->debug = 0;
@@ -108,7 +88,7 @@
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      __down_read_failed\n\t"
+		"  call      __rwsem_down_read_failed\n\t"
 		"  jmp       1b\n"
 		".previous"
 		"# ending down_read\n\t"
@@ -133,7 +113,7 @@
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      __down_write_failed\n\t"
+		"  call      __rwsem_down_write_failed\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending down_write"
@@ -188,6 +168,30 @@
 		: "=m"(sem->count)
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count)
 		: "memory");
+}
+
+/*
+ * implement exchange and add functionality
+ */
+static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
+{
+	int tmp = delta;
+
+	__asm__ __volatile__(
+		LOCK_PREFIX "xadd %0,(%1)"
+		: "+r"(tmp)
+		: "r"(sem)
+		: "memory");
+
+	return tmp+delta;
+}
+
+/*
+ * implement compare and exchange functionality on the rw-semaphore count LSW
+ */
+static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
+{
+	return cmpxchg((__u16*)&sem->count,0,RWSEM_ACTIVE_BIAS);
 }
 
 #endif /* __KERNEL__ */
diff -uNr linux-2.4.4-pre2/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
--- linux-2.4.4-pre2/include/asm-i386/rwsem.h	Thu Apr 12 08:57:28 2001
+++ linux/include/asm-i386/rwsem.h	Thu Apr 12 15:52:13 2001
@@ -8,126 +8,23 @@
 #ifndef _I386_RWSEM_H
 #define _I386_RWSEM_H
 
-#include <linux/linkage.h>
-
-#define RWSEM_DEBUG 0
-#define RWSEM_DEBUG_MAGIC 0
-
-#ifdef __KERNEL__
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/spinlock.h>
-#include <linux/wait.h>
-
-#if RWSEM_DEBUG
-#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); } while(0)
-#else
-#define rwsemdebug(FMT,...)
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
 #endif
 
-/* old gcc */
-#if RWSEM_DEBUG
-//#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); } while(0)
-#else
-//#define rwsemdebug(FMT, ARGS...)
-#endif
+#ifdef __KERNEL__
 
+#define __HAVE_ARCH_SPECIFIC_RWSEM_IMPLEMENTATION 1
 #ifdef CONFIG_X86_XADD
 #include <asm/rwsem-xadd.h> /* use XADD based semaphores if possible */
 #else
-#include <asm/rwsem-spin.h> /* use spinlock based semaphores otherwise */
+#include <asm/rwsem-spin.h> /* use optimised spinlock based semaphores otherwise */
 #endif
 
 /* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(__down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__down_write_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(__rwsem_down_read_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(__rwsem_down_write_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
-
-/*
- * lock for reading
- */
-static inline void down_read(struct rw_semaphore *sem)
-{
-	rwsemdebug("Entering down_read(count=%08x)\n",atomic_read(&sem->count));
-
-#if RWSEM_DEBUG_MAGIC
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-
-	__down_read(sem);
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_inc(&sem->readers);
-#endif
-
-	rwsemdebug("Leaving down_read(count=%08x)\n",atomic_read(&sem->count));
-}
-
-/*
- * lock for writing
- */
-static inline void down_write(struct rw_semaphore *sem)
-{
-	rwsemdebug("Entering down_write(count=%08x)\n",atomic_read(&sem->count));
-
-#if RWSEM_DEBUG_MAGIC
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-
-	__down_write(sem);
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	atomic_inc(&sem->writers);
-#endif
-
-	rwsemdebug("Leaving down_write(count=%08x)\n",atomic_read(&sem->count));
-}
-
-/*
- * release a read lock
- */
-static inline void up_read(struct rw_semaphore *sem)
-{
-	rwsemdebug("Entering up_read(count=%08x)\n",atomic_read(&sem->count));
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_dec(&sem->readers);
-#endif
-	__up_read(sem);
-
-	rwsemdebug("Leaving up_read(count=%08x)\n",atomic_read(&sem->count));
-}
-
-/*
- * release a write lock
- */
-static inline void up_write(struct rw_semaphore *sem)
-{
-	rwsemdebug("Entering up_write(count=%08x)\n",atomic_read(&sem->count));
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (atomic_read(&sem->writers) != 1)
-		BUG();
-	atomic_dec(&sem->writers);
-#endif
-	__up_write(sem);
-
-	rwsemdebug("Leaving up_write(count=%08x)\n",atomic_read(&sem->count));
-}
-
 
 #endif /* __KERNEL__ */
 #endif /* _I386_RWSEM_H */
diff -uNr linux-2.4.4-pre2/include/asm-i386/semaphore.h linux/include/asm-i386/semaphore.h
--- linux-2.4.4-pre2/include/asm-i386/semaphore.h	Thu Apr 12 08:57:28 2001
+++ linux/include/asm-i386/semaphore.h	Thu Apr 12 15:52:13 2001
@@ -39,7 +39,7 @@
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <linux/wait.h>
-#include <asm/rwsem.h>
+#include <linux/rwsem.h>
 
 struct semaphore {
 	atomic_t count;
diff -uNr linux-2.4.4-pre2/include/linux/rwsem-spinlock.h linux/include/linux/rwsem-spinlock.h
--- linux-2.4.4-pre2/include/linux/rwsem-spinlock.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/rwsem-spinlock.h	Thu Apr 12 15:52:13 2001
@@ -0,0 +1,174 @@
+/* rwsem-spinlock.h: fallback C implementation
+ *
+ * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ */
+
+#ifndef _LINUX_RWSEM_SPINLOCK_H
+#define _LINUX_RWSEM_SPINLOCK_H
+
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem-spinlock.h directly, use linux/rwsem.h instead
+#endif
+
+#include <linux/spinlock.h>
+
+#ifdef __KERNEL__
+
+#define CONFIG_USING_SPINLOCK_BASED_RWSEM 1
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	signed long			count;
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
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
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
+	sem->count = RWSEM_UNLOCKED_VALUE;
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
+	int count;
+	spin_lock(&sem->lock);
+	sem->count += RWSEM_ACTIVE_READ_BIAS;
+	count = sem->count;
+	spin_unlock(&sem->lock);
+	if (count<0)
+		rwsem_down_read_failed(sem);
+}
+
+/*
+ * lock for writing
+ */
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	int count;
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
+	spin_unlock(&sem->lock);
+	if (count)
+		rwsem_down_write_failed(sem);
+}
+
+/*
+ * unlock after reading
+ */
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	int count;
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count -= RWSEM_ACTIVE_READ_BIAS;
+	spin_unlock(&sem->lock);
+	if (count<0 && !((count-RWSEM_ACTIVE_READ_BIAS)&RWSEM_ACTIVE_MASK))
+		rwsem_wake(sem);
+}
+
+/*
+ * unlock after writing
+ */
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	int count;
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
+	count = sem->count;
+	spin_unlock(&sem->lock);
+	if (count<0)
+		rwsem_wake(sem);
+}
+
+/*
+ * implement exchange and add functionality
+ */
+static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
+{
+	int count;
+
+	spin_lock(&sem->lock);
+	sem->count += delta;
+	count = sem->count;
+	spin_unlock(&sem->lock);
+
+	return count;
+}
+
+/*
+ * implement compare and exchange functionality on the rw-semaphore count LSW
+ */
+static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
+{
+	__u16 prev;
+
+	spin_lock(&sem->lock);
+	prev = sem->count & RWSEM_ACTIVE_MASK;
+	if (prev==old)
+		sem->count = (sem->count & ~RWSEM_ACTIVE_MASK) | new;
+	spin_unlock(&sem->lock);
+
+	return prev;
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -uNr linux-2.4.4-pre2/include/linux/rwsem.h linux/include/linux/rwsem.h
--- linux-2.4.4-pre2/include/linux/rwsem.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/rwsem.h	Thu Apr 12 15:52:13 2001
@@ -0,0 +1,155 @@
+/* rwsem.h: R/W semaphores, public interface
+ *
+ * Written by David Howells (dhowells@redhat.com).
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
+#ifndef _LINUX_RWSEM_H
+#define _LINUX_RWSEM_H
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
+/* we use FASTCALL convention for the helpers */
+extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *sem));
+
+#include <asm/rwsem.h> /* find the arch specific bits */
+
+#ifndef __HAVE_ARCH_SPECIFIC_RWSEM_IMPLEMENTATION
+#include <linux/rwsem-spinlock.h>
+#endif
+
+/*
+ * lock for reading
+ */
+static inline void down_read(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering down_read(count=%08lx)\n",sem->count);
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
+	rwsemdebug("Leaving down_read(count=%08lx)\n",sem->count);
+}
+
+/*
+ * lock for writing
+ */
+static inline void down_write(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering down_write(count=%08lx)\n",sem->count);
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
+	rwsemdebug("Leaving down_write(count=%08lx)\n",sem->count);
+}
+
+/*
+ * release a read lock
+ */
+static inline void up_read(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering up_read(count=%08lx)\n",sem->count);
+
+#if RWSEM_DEBUG_MAGIC
+	if (atomic_read(&sem->writers))
+		BUG();
+	atomic_dec(&sem->readers);
+#endif
+	__up_read(sem);
+
+	rwsemdebug("Leaving up_read(count=%08lx)\n",sem->count);
+}
+
+/*
+ * release a write lock
+ */
+static inline void up_write(struct rw_semaphore *sem)
+{
+	rwsemdebug("Entering up_write(count=%08lx)\n",sem->count);
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
+	rwsemdebug("Leaving up_write(count=%08lx)\n",sem->count);
+}
+
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_RWSEM_H */
diff -uNr linux-2.4.4-pre2/lib/Makefile linux/lib/Makefile
--- linux-2.4.4-pre2/lib/Makefile	Thu Apr 12 08:55:39 2001
+++ linux/lib/Makefile	Thu Apr 12 10:27:31 2001
@@ -8,9 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o
+export-objs := cmdline.o rwsem.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
diff -uNr linux-2.4.4-pre2/lib/rwsem.c linux/lib/rwsem.c
--- linux-2.4.4-pre2/lib/rwsem.c	Thu Jan  1 01:00:00 1970
+++ linux/lib/rwsem.c	Thu Apr 12 15:53:14 2001
@@ -0,0 +1,156 @@
+/* rwsem.c: R/W semaphores: contention handling functions
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ * Derived from arch/i386/kernel/semaphore.c
+ */
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+/*
+ * wait for the read lock to be granted
+ * - need to repeal the increment made inline by the caller
+ * - need to throw a write-lock style spanner into the works (sub 0x00010000 from count)
+ */
+struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait,tsk);
+	signed long count;
+
+	rwsemdebug("[%d] Entering rwsem_down_read_failed(%08lx)\n",current->pid,sem->count);
+
+	/* this waitqueue context flag will be cleared when we are granted the lock */
+	__set_bit(RWSEM_WAITING_FOR_READ,&wait.flags);
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're now waiting on the lock, but no longer actively read-locking */
+	count = rwsem_atomic_update(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,sem);
+	rwsemdebug("X(%08lx)\n",count);
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
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	remove_wait_queue(&sem->wait,&wait);
+	tsk->state = TASK_RUNNING;
+
+	rwsemdebug("[%d] Leaving rwsem_down_read_failed(%08lx)\n",current->pid,sem->count);
+
+	return sem;
+}
+
+/*
+ * wait for the write lock to be granted
+ */
+struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait,tsk);
+	signed long count;
+
+	rwsemdebug("[%d] Entering rwsem_down_write_failed(%08lx)\n",current->pid,sem->count);
+
+	/* this waitqueue context flag will be cleared when we are granted the lock */
+	__set_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags);
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+
+	/* note that we're waiting on the lock, but no longer actively locking */
+	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
+	rwsemdebug("[%d] updated(%08lx)\n",current->pid,count);
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
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	remove_wait_queue(&sem->wait,&wait);
+	tsk->state = TASK_RUNNING;
+
+	rwsemdebug("[%d] Leaving rwsem_down_write_failed(%08lx)\n",current->pid,sem->count);
+
+	return sem;
+}
+
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
+ *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ */
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+{
+	signed long count;
+	int woken;
+
+	rwsemdebug("[%d] Entering rwsem_wake(%08lx)\n",current->pid,sem->count);
+
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
+
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
+	 *   incremented by 0x00010000
+	 */
+	if (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)==1)
+		goto out;
+
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
+
+ out:
+	rwsemdebug("[%d] Leaving rwsem_wake(%08lx)\n",current->pid,sem->count);
+	return sem;
+
+	/* come here if we need to correct the counter for odd SMP-isms */
+ counter_correction:
+	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
+	rwsemdebug("[%d] corrected(%08lx)\n",current->pid,count);
+	if (!(count & RWSEM_ACTIVE_MASK))
+		goto try_again;
+	goto out;
+}
+
+EXPORT_SYMBOL(rwsem_down_read_failed);
+EXPORT_SYMBOL(rwsem_down_write_failed);
+EXPORT_SYMBOL(rwsem_wake);

------- =_aaaaaaaaaa0--
