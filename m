Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132405AbRDUBMn>; Fri, 20 Apr 2001 21:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132407AbRDUBM0>; Fri, 20 Apr 2001 21:12:26 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:60846 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S132400AbRDUBMH>;
	Fri, 20 Apr 2001 21:12:07 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_M9B4UYK0T7DOAVAKJABQ"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: torvalds@transmeta.com
Subject: [PATCH] i386 rw_semaphore improvements
Date: Sat, 21 Apr 2001 02:10:34 +0100
X-Mailer: KMail [version 1.2]
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, andrea@suse.de
MIME-Version: 1.0
Message-Id: <01042102103400.08839@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M9B4UYK0T7DOAVAKJABQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch (made against linux-2.4.4-pre5) makes several changes to the rwsem 
implementation:

 (1) It fixes the bug found by Andrea by changing how processes that are
     waiting on the semaphore are managed.

 (2) As a result of (1), the wake_up_ctx() stuff is no longer used and has
     been removed.

 (3) Contention handling in this rwsem implementation is now faster as a
     result of (1). The increase from slightly to a fair amount depending on
     the situation.

 (4) The asm-i386/rwsem-spin.h implementation is now gone. i386 CPUs will use
     the generic implementation instead.

 (5) The asm-i386/rwsem-xadd.h has been subsumed by asm-i386/rwsem.h since
     there's now only one i386-arch optimised version.

 (6) Some alpha-arch fixes have been applied.

 (7) The sparc64-arch optimised implementation has been updated to fall in
     line with (1).

 (8) The generic implementation now has a single spinlock which it uses both
     for waiting process management and for guarding access to the counter.

I'll have a look tomorrow at making the generic spinlock implementation 
non-inline.

David
--------------Boundary-00=_M9B4UYK0T7DOAVAKJABQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rwsem-x.diff"
Content-Transfer-Encoding: 8bit
Content-Description: rw-semaphore fixes
Content-Disposition: attachment; filename="rwsem-x.diff"

diff -uNr linux-2.4.4-pre5/arch/alpha/kernel/alpha_ksyms.c linux/arch/alpha/kernel/alpha_ksyms.c
--- linux-2.4.4-pre5/arch/alpha/kernel/alpha_ksyms.c	Fri Apr 20 20:59:41 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Sat Apr 21 01:15:40 2001
@@ -173,13 +173,6 @@
 EXPORT_SYMBOL(down_interruptible);
 EXPORT_SYMBOL(down_trylock);
 EXPORT_SYMBOL(up);
-EXPORT_SYMBOL(__down_read_failed);
-EXPORT_SYMBOL(__down_write_failed);
-EXPORT_SYMBOL(__rwsem_wake);
-EXPORT_SYMBOL(down_read);
-EXPORT_SYMBOL(down_write);
-EXPORT_SYMBOL(up_read);
-EXPORT_SYMBOL(up_write);
 
 /* 
  * SMP-specific symbols.
diff -uNr linux-2.4.4-pre5/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.4-pre5/arch/i386/config.in	Fri Apr 20 20:59:41 2001
+++ linux/arch/i386/config.in	Sat Apr 21 01:29:01 2001
@@ -9,8 +9,6 @@
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
@@ -52,6 +50,8 @@
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
+   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -59,6 +59,8 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
+   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
+   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -uNr linux-2.4.4-pre5/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.4-pre5/arch/i386/kernel/i386_ksyms.c	Fri Apr 20 20:59:41 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Sat Apr 21 01:16:37 2001
@@ -80,9 +80,11 @@
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 EXPORT_SYMBOL_NOVERS(__rwsem_down_write_failed);
 EXPORT_SYMBOL_NOVERS(__rwsem_down_read_failed);
 EXPORT_SYMBOL_NOVERS(__rwsem_wake);
+#endif
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
diff -uNr linux-2.4.4-pre5/include/asm-i386/rwsem-spin.h linux/include/asm-i386/rwsem-spin.h
--- linux-2.4.4-pre5/include/asm-i386/rwsem-spin.h	Fri Apr 20 20:59:47 2001
+++ linux/include/asm-i386/rwsem-spin.h	Thu Jan  1 01:00:00 1970
@@ -1,318 +0,0 @@
-/* rwsem.h: R/W semaphores based on spinlocks
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-i386/semaphore.h and asm-i386/spinlock.h
- */
-
-#ifndef _I386_RWSEM_SPIN_H
-#define _I386_RWSEM_SPIN_H
-
-#include <linux/config.h>
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem-spin.h directly, use linux/rwsem.h instead
-#endif
-
-#include <linux/spinlock.h>
-
-#ifdef __KERNEL__
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		lock;
-#define RWSEM_SPINLOCK_OFFSET_STR	"4" /* byte offset of spinlock */
-	wait_queue_head_t	wait;
-#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
-#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-#if RWSEM_DEBUG_MAGIC
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-#if RWSEM_DEBUG_MAGIC
-#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_MINIT(name)	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->lock);
-	init_waitqueue_head(&sem->wait);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-#if RWSEM_DEBUG_MAGIC
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
-#endif
-		"  js        4f\n\t" /* jump if we weren't granted the lock */
-		"2:\n"
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		"4:\n\t"
-		"  call      __rwsem_down_read_failed\n\t"
-		"  jmp       2b\n"
-		".previous"
-		"# ending __down_read\n\t"
-		: "=m"(sem->count), "=m"(sem->lock)
-		: "a"(sem), "m"(sem->count), "m"(sem->lock)
-		: "memory");
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
-		"  add       %0,(%%eax)\n\t" /* add 0xffff0001, result in memory */
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
-#endif
-		"  testl     %0,%0\n\t" /* was the count 0 before? */
-		"  jnz       4f\n\t" /* jump if we weren't granted the lock */
-		"2:\n\t"
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		"4:\n\t"
-		"  call     __rwsem_down_write_failed\n\t"
-		"  jmp      2b\n"
-		".previous\n"
-		"# ending down_write"
-		: "+r"(tmp), "=m"(sem->count), "=m"(sem->lock)
-		: "a"(sem), "m"(sem->count), "m"(sem->lock)
-		: "memory");
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  xchg      %0,(%%eax)\n\t" /* retrieve the old value */
-		"  addl      %0,(%%eax)\n\t" /* subtract 1, result in memory */
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
-#endif
-		"  js        4f\n\t" /* jump if the lock is being waited upon */
-		"2:\n\t"
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		"4:\n\t"
-		"  decl      %0\n\t" /* xchg gave us the old count */
-		"  testl     %4,%0\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       2b\n\t"
-		"  call      __rwsem_wake\n\t"
-		"  jmp       2b\n"
-		".previous\n"
-		"# ending __up_read\n"
-		: "+r"(tmp), "=m"(sem->count), "=m"(sem->lock)
-		: "a"(sem), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count), "m"(sem->lock)
-		: "memory");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-#ifdef CONFIG_SMP
-LOCK_PREFIX	"  decb      "RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* try to grab the spinlock */
-		"  js        3f\n" /* jump if failed */
-		"1:\n\t"
-#endif
-		"  addl      %3,(%%eax)\n\t" /* adds 0x00010001 */
-#ifdef CONFIG_SMP
-		"  movb      $1,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t" /* release the spinlock */
-#endif
-		"  js        4f\n\t" /* jump if the lock is being waited upon */
-		"2:\n\t"
-		".section .text.lock,\"ax\"\n"
-#ifdef CONFIG_SMP
-		"3:\n\t" /* spin on the spinlock till we get it */
-		"  cmpb      $0,"RWSEM_SPINLOCK_OFFSET_STR"(%%eax)\n\t"
-		"  rep;nop   \n\t"
-		"  jle       3b\n\t"
-		"  jmp       1b\n"
-#endif
-		"4:\n\t"
-		"  call     __rwsem_wake\n\t"
-		"  jmp      2b\n"
-		".previous\n"
-		"# ending __up_write\n"
-		: "=m"(sem->count), "=m"(sem->lock)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count), "m"(sem->lock)
-		: "memory");
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
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
-	return tmp+delta;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count LSW
- */
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
-{
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
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_SPIN_H */
diff -uNr linux-2.4.4-pre5/include/asm-i386/rwsem-xadd.h linux/include/asm-i386/rwsem-xadd.h
--- linux-2.4.4-pre5/include/asm-i386/rwsem-xadd.h	Fri Apr 20 20:59:47 2001
+++ linux/include/asm-i386/rwsem-xadd.h	Thu Jan  1 01:00:00 1970
@@ -1,194 +0,0 @@
-/* rwsem-xadd.h: R/W semaphores implemented using XADD/CMPXCHG
- *
- * Written by David Howells (dhowells@redhat.com), 2001.
- * Derived from asm-i386/semaphore.h
- */
-
-#ifndef _I386_RWSEM_XADD_H
-#define _I386_RWSEM_XADD_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem-xadd.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	wait_queue_head_t	wait;
-#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
-#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-#if RWSEM_DEBUG_MAGIC
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-#if RWSEM_DEBUG_MAGIC
-#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_MINIT(name)	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	init_waitqueue_head(&sem->wait);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-#if RWSEM_DEBUG_MAGIC
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  js        2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  call      __rwsem_down_read_failed\n\t"
-		"  jmp       1b\n"
-		".previous"
-		"# ending down_read\n\t"
-		: "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
-		: "memory");
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x00010001, returns the old value */
-		"  testl     %0,%0\n\t" /* was the count 0 before? */
-		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  call      __rwsem_down_write_failed\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending down_write"
-		: "+r"(tmp), "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
-		: "memory");
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decl      %0\n\t" /* xadd gave us the old count */
-		"  testl     %3,%0\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       1b\n\t"
-		"  call      __rwsem_wake\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_read\n"
-		: "+r"(tmp), "=m"(sem->count)
-		: "a"(sem), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count)
-		: "memory");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* adds 0x0000ffff */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  call      __rwsem_wake\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_write\n"
-		: "=m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count)
-		: "memory");
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-		LOCK_PREFIX "xadd %0,(%1)"
-		: "+r"(tmp)
-		: "r"(sem)
-		: "memory");
-
-	return tmp+delta;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count LSW
- */
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
-{
-	return cmpxchg((__u16*)&sem->count,0,RWSEM_ACTIVE_BIAS);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_XADD_H */
diff -uNr linux-2.4.4-pre5/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
--- linux-2.4.4-pre5/include/asm-i386/rwsem.h	Fri Apr 20 20:59:47 2001
+++ linux/include/asm-i386/rwsem.h	Sat Apr 21 01:50:21 2001
@@ -1,4 +1,4 @@
-/* rwsem.h: R/W semaphores optimised using i386 assembly
+/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
  *
  * Written by David Howells (dhowells@redhat.com).
  *
@@ -14,16 +14,194 @@
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_X86_XADD
-#include <asm/rwsem-xadd.h> /* use XADD based semaphores if possible */
-#else
-#include <asm/rwsem-spin.h> /* use optimised spinlock based semaphores otherwise */
-#endif
+#include <linux/list.h>
+#include <linux/spinlock.h>
 
 /* we use FASTCALL convention for the helpers */
 extern struct rw_semaphore *FASTCALL(__rwsem_down_read_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(__rwsem_down_write_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
+
+struct rwsem_waiter;
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	signed long		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct rwsem_waiter	*wait_front;
+	struct rwsem_waiter	**wait_back;
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
+#define __RWSEM_INITIALIZER(name) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front \
+	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->count = RWSEM_UNLOCKED_VALUE;
+	spin_lock_init(&sem->wait_lock);
+	sem->wait_front = NULL;
+	sem->wait_back = &sem->wait_front;
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
+		"  call      __rwsem_down_read_failed\n\t"
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
+		"  call      __rwsem_down_write_failed\n\t"
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
+}
 
 #endif /* __KERNEL__ */
 #endif /* _I386_RWSEM_H */
diff -uNr linux-2.4.4-pre5/include/asm-sparc64/rwsem.h linux/include/asm-sparc64/rwsem.h
--- linux-2.4.4-pre5/include/asm-sparc64/rwsem.h	Fri Apr 20 20:59:47 2001
+++ linux/include/asm-sparc64/rwsem.h	Sat Apr 21 01:52:51 2001
@@ -13,6 +13,8 @@
 
 #ifdef __KERNEL__
 
+struct rwsem_waiter;
+
 struct rw_semaphore {
 	signed int count;
 #define RWSEM_UNLOCKED_VALUE		0x00000000
@@ -21,13 +23,13 @@
 #define RWSEM_WAITING_BIAS		0xffff0000
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	wait_queue_head_t wait;
-#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
-#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
+	spinlock_t		wait_lock;
+	struct rwsem_waiter	*wait_front;
+	struct rwsem_waiter	**wait_back;
 };
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
diff -uNr linux-2.4.4-pre5/include/linux/rwsem-spinlock.h linux/include/linux/rwsem-spinlock.h
--- linux-2.4.4-pre5/include/linux/rwsem-spinlock.h	Fri Apr 20 20:59:47 2001
+++ linux/include/linux/rwsem-spinlock.h	Sat Apr 21 01:50:15 2001
@@ -14,22 +14,22 @@
 
 #ifdef __KERNEL__
 
+struct rwsem_waiter;
+
 /*
  * the semaphore definition
  */
 struct rw_semaphore {
-	signed long			count;
+	signed long		count;
 #define RWSEM_UNLOCKED_VALUE		0x00000000
 #define RWSEM_ACTIVE_BIAS		0x00000001
 #define RWSEM_ACTIVE_MASK		0x0000ffff
 #define RWSEM_WAITING_BIAS		(-0x00010000)
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		lock;
-#define RWSEM_SPINLOCK_OFFSET_STR	"4" /* byte offset of spinlock */
-	wait_queue_head_t	wait;
-#define RWSEM_WAITING_FOR_READ	WQ_FLAG_CONTEXT_0	/* bits to use in wait_queue_t.flags */
-#define RWSEM_WAITING_FOR_WRITE	WQ_FLAG_CONTEXT_1
+	spinlock_t		wait_lock;
+	struct rwsem_waiter	*wait_front;
+	struct rwsem_waiter	**wait_back;
 #if RWSEM_DEBUG
 	int			debug;
 #endif
@@ -55,8 +55,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front \
 	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
 
 #define DECLARE_RWSEM(name) \
@@ -65,8 +64,9 @@
 static inline void init_rwsem(struct rw_semaphore *sem)
 {
 	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->lock);
-	init_waitqueue_head(&sem->wait);
+	spin_lock_init(&sem->wait_lock);
+	sem->wait_front = NULL;
+	sem->wait_back = &sem->wait_front;
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
@@ -83,10 +83,10 @@
 static inline void __down_read(struct rw_semaphore *sem)
 {
 	int count;
-	spin_lock(&sem->lock);
+	spin_lock(&sem->wait_lock);
 	sem->count += RWSEM_ACTIVE_READ_BIAS;
 	count = sem->count;
-	spin_unlock(&sem->lock);
+	spin_unlock(&sem->wait_lock);
 	if (count<0)
 		rwsem_down_read_failed(sem);
 }
@@ -97,10 +97,10 @@
 static inline void __down_write(struct rw_semaphore *sem)
 {
 	int count;
-	spin_lock(&sem->lock);
+	spin_lock(&sem->wait_lock);
 	count = sem->count;
 	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
-	spin_unlock(&sem->lock);
+	spin_unlock(&sem->wait_lock);
 	if (count)
 		rwsem_down_write_failed(sem);
 }
@@ -111,10 +111,10 @@
 static inline void __up_read(struct rw_semaphore *sem)
 {
 	int count;
-	spin_lock(&sem->lock);
+	spin_lock(&sem->wait_lock);
 	count = sem->count;
 	sem->count -= RWSEM_ACTIVE_READ_BIAS;
-	spin_unlock(&sem->lock);
+	spin_unlock(&sem->wait_lock);
 	if (count<0 && !((count-RWSEM_ACTIVE_READ_BIAS)&RWSEM_ACTIVE_MASK))
 		rwsem_wake(sem);
 }
@@ -125,41 +125,39 @@
 static inline void __up_write(struct rw_semaphore *sem)
 {
 	int count;
-	spin_lock(&sem->lock);
+	spin_lock(&sem->wait_lock);
 	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
 	count = sem->count;
-	spin_unlock(&sem->lock);
+	spin_unlock(&sem->wait_lock);
 	if (count<0)
 		rwsem_wake(sem);
 }
 
 /*
  * implement exchange and add functionality
+ * - only called when spinlock is already held
  */
 static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
 {
 	int count;
 
-	spin_lock(&sem->lock);
 	sem->count += delta;
 	count = sem->count;
-	spin_unlock(&sem->lock);
 
 	return count;
 }
 
 /*
  * implement compare and exchange functionality on the rw-semaphore count LSW
+ * - only called by __rwsem_do_wake(), so spinlock is already held when called
  */
 static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
 {
 	__u16 prev;
 
-	spin_lock(&sem->lock);
 	prev = sem->count & RWSEM_ACTIVE_MASK;
 	if (prev==old)
 		sem->count = (sem->count & ~RWSEM_ACTIVE_MASK) | new;
-	spin_unlock(&sem->lock);
 
 	return prev;
 }
diff -uNr linux-2.4.4-pre5/include/linux/rwsem.h linux/include/linux/rwsem.h
--- linux-2.4.4-pre5/include/linux/rwsem.h	Fri Apr 20 20:59:47 2001
+++ linux/include/linux/rwsem.h	Sat Apr 21 01:32:42 2001
@@ -38,9 +38,11 @@
 
 #ifdef __KERNEL__
 
+#include <linux/types.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <linux/wait.h>
+
+struct rw_semaphore;
 
 /* defined contention handler functions for the generic case
  * - these are also used for the exchange-and-add based algorithm
@@ -60,8 +62,7 @@
 
 #ifndef rwsemtrace
 #if RWSEM_DEBUG
-#include <asm/current.h>
-#define rwsemtrace(SEM,FMT) do { if ((SEM)->debug) printk("[%d] "FMT"(count=%08lx)\n",current->pid,(SEM)->count); } while(0)
+extern void FASTCALL(rwsemtrace(struct rw_semaphore *sem, const char *str));
 #else
 #define rwsemtrace(SEM,FMT)
 #endif
diff -uNr linux-2.4.4-pre5/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.4-pre5/include/linux/sched.h	Fri Apr 20 20:59:47 2001
+++ linux/include/linux/sched.h	Sat Apr 21 01:47:09 2001
@@ -548,8 +548,6 @@
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
-extern int FASTCALL(__wake_up_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit));
-extern int FASTCALL(__wake_up_sync_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -568,8 +566,6 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
-#define wake_up_ctx(x,count,bit)	__wake_up_ctx((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,count,bit)
-#define wake_up_sync_ctx(x,count,bit)	__wake_up_ctx((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,count,bit)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
diff -uNr linux-2.4.4-pre5/include/linux/wait.h linux/include/linux/wait.h
--- linux-2.4.4-pre5/include/linux/wait.h	Fri Apr 20 20:59:47 2001
+++ linux/include/linux/wait.h	Sat Apr 21 01:40:42 2001
@@ -26,14 +26,6 @@
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
-#define WQ_FLAG_CONTEXT_0	8	/* context specific flag bit numbers */
-#define WQ_FLAG_CONTEXT_1	9
-#define WQ_FLAG_CONTEXT_2	10
-#define WQ_FLAG_CONTEXT_3	11
-#define WQ_FLAG_CONTEXT_4	12
-#define WQ_FLAG_CONTEXT_5	13
-#define WQ_FLAG_CONTEXT_6	14
-#define WQ_FLAG_CONTEXT_7	15
 	struct task_struct * task;
 	struct list_head task_list;
 #if WAITQUEUE_DEBUG
diff -uNr linux-2.4.4-pre5/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.4-pre5/kernel/sched.c	Fri Apr 20 20:59:47 2001
+++ linux/kernel/sched.c	Sat Apr 21 01:41:10 2001
@@ -765,75 +765,6 @@
 	}
 }
 
-/*
- * wake up processes in the wait queue depending on the state of a context bit in the flags
- * - wakes up a process if the specified bit is set in the flags member
- * - the context bit is cleared if the process is woken up
- * - if the bit number is negative, then the loop stops at the first unset context bit encountered
- * - returns the number of processes woken
- */
-static inline int __wake_up_ctx_common (wait_queue_head_t *q,
-					int count, int bit, const int sync)
-{
-	struct list_head *tmp, *head;
-	struct task_struct *p;
-	int stop, woken;
-
-	woken = 0;
-	stop = bit<0;
-	if (bit<0) bit = -bit;
-
-	CHECK_MAGIC_WQHEAD(q);
-	head = &q->task_list;
-	WQ_CHECK_LIST_HEAD(head);
-	tmp = head->next;
-	while (tmp != head) {
-                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
-
-		tmp = tmp->next;
-		CHECK_MAGIC(curr->__magic);
-		p = curr->task;
-		if (!test_and_clear_bit(bit,&curr->flags)) {
-			if (stop)
-				break;
-			continue;
-		}
-
-		WQ_NOTE_WAKER(curr);
-		try_to_wake_up(p,sync);
-
-		woken++;
-		if (woken>=count)
-			break;
-	}
-
-	return woken;
-}
-
-int __wake_up_ctx(wait_queue_head_t *q, unsigned int mode, int count, int bit)
-{
-	int woken = 0;
-	if (q && count) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		woken = __wake_up_ctx_common(q, count, bit, 0);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
-	return woken;
-}
-
-int __wake_up_ctx_sync(wait_queue_head_t *q, unsigned int mode, int count, int bit)
-{
-	int woken = 0;
-	if (q && count) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		woken = __wake_up_ctx_common(q, count, bit, 1);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
-	return woken;
-}
-
 #define	SLEEP_ON_VAR				\
 	unsigned long flags;			\
 	wait_queue_t wait;			\
diff -uNr linux-2.4.4-pre5/lib/rwsem.c linux/lib/rwsem.c
--- linux-2.4.4-pre5/lib/rwsem.c	Fri Apr 20 20:59:47 2001
+++ linux/lib/rwsem.c	Sat Apr 21 00:59:17 2001
@@ -7,6 +7,110 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 
+struct rwsem_waiter {
+	struct rwsem_waiter	*next;
+	struct task_struct	*task;
+	unsigned int		flags;
+#define RWSEM_WAITING_FOR_READ	0x00000001
+#define RWSEM_WAITING_FOR_WRITE	0x00000002
+};
+#define RWSEM_WAITER_MAGIC 0x52575345
+
+static struct rw_semaphore *FASTCALL(__rwsem_do_wake(struct rw_semaphore *sem));
+
+#if RWSEM_DEBUG
+void rwsemtrace(struct rw_semaphore *sem, const char *str)
+{
+	if (sem->debug)
+		printk("[%d] %s(count=%08lx)\n",current->pid,str,sem->count);
+}
+#endif
+
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
+ *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ *   - the spinlock must be held before entry
+ *   - woken process blocks are discarded from the list after having flags zeroised
+ */
+static struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter *waiter, *next;
+	int woken, loop;
+
+	rwsemtrace(sem,"Entering __rwsem_do_wake");
+
+	/* try to grab an 'activity' marker
+	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
+	 *   simultaneously
+	 * - be horribly naughty, and only deal with the LSW of the atomic counter
+	 */
+	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0) {
+		rwsemtrace(sem,"__rwsem_do_wake: abort wakeup due to renewed activity");
+		goto out;
+	}
+
+	/* check the wait queue is populated */
+	waiter = sem->wait_front;
+
+	if (__builtin_expect(!waiter,0)) {
+		printk("__rwsem_do_wake(): wait_list unexpectedly empty\n");
+		BUG();
+		goto out;
+	}
+
+	if (__builtin_expect(!waiter->flags,0)) {
+		printk("__rwsem_do_wake(): wait_list front apparently not waiting\n");
+		BUG();
+		goto out;
+	}
+
+	next = NULL;
+
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
+	 *   incremented by 0x00010000
+	 */
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
+		next = waiter->next;
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		goto discard_woken_processes;
+	}
+
+	/* grant an infinite number of read locks to the readers at the front of the queue
+	 * - note we increment the 'active part' of the count by the number of readers (less one
+	 *   for the activity decrement we've already done) before waking any processes up
+	 */
+	woken = 0;
+	do {
+		woken++;
+		waiter = waiter->next;
+	} while (waiter && waiter->flags&RWSEM_WAITING_FOR_READ);
+
+	loop = woken;
+	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
+	woken -= RWSEM_ACTIVE_BIAS;
+	rwsem_atomic_update(woken,sem);
+
+	waiter = sem->wait_front;
+	for (; loop>0; loop--) {
+		next = waiter->next;
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		waiter = next;
+	}
+
+ discard_woken_processes:
+	sem->wait_front = next;
+	if (!next) sem->wait_back = &sem->wait_front;
+
+ out:
+	rwsemtrace(sem,"Leaving __rwsem_do_wake");
+	return sem;
+}
+
 /*
  * wait for the read lock to be granted
  * - need to repeal the increment made inline by the caller
@@ -14,17 +118,23 @@
  */
 struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
+	struct rwsem_waiter waiter;
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait,tsk);
 	signed long count;
 
 	rwsemtrace(sem,"Entering rwsem_down_read_failed");
+	
+	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
-	/* this waitqueue context flag will be cleared when we are granted the lock */
-	__set_bit(RWSEM_WAITING_FOR_READ,&wait.flags);
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	/* set up my own style of waitqueue */
+	waiter.next = NULL;
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_READ;
 
-	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+	spin_lock(&sem->wait_lock);
+
+	*sem->wait_back = &waiter; /* add to back of queue */
+	sem->wait_back = &waiter.next;
 
 	/* note that we're now waiting on the lock, but no longer actively read-locking */
 	count = rwsem_atomic_update(RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS,sem);
@@ -33,17 +143,18 @@
 	 * - it might even be this process, since the waker takes a more active part
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		rwsem_wake(sem);
+		__rwsem_do_wake(sem);
+
+	spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
-		if (!test_bit(RWSEM_WAITING_FOR_READ,&wait.flags))
+		if (!waiter.flags)
 			break;
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 
-	remove_wait_queue(&sem->wait,&wait);
 	tsk->state = TASK_RUNNING;
 
 	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
@@ -55,17 +166,23 @@
  */
 struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
+	struct rwsem_waiter waiter;
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait,tsk);
 	signed long count;
 
 	rwsemtrace(sem,"Entering rwsem_down_write_failed");
 
-	/* this waitqueue context flag will be cleared when we are granted the lock */
-	__set_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags);
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
-	add_wait_queue_exclusive(&sem->wait, &wait); /* FIFO */
+	/* set up my own style of waitqueue */
+	waiter.next = NULL;
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+
+	spin_lock(&sem->wait_lock);
+
+	*sem->wait_back = &waiter; /* add to back of queue */
+	sem->wait_back = &waiter.next;
 
 	/* note that we're waiting on the lock, but no longer actively locking */
 	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
@@ -74,17 +191,18 @@
 	 * - it might even be this process, since the waker takes a more active part
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		rwsem_wake(sem);
+		__rwsem_do_wake(sem);
+
+	spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
-		if (!test_bit(RWSEM_WAITING_FOR_WRITE,&wait.flags))
+		if (!waiter.flags)
 			break;
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 
-	remove_wait_queue(&sem->wait,&wait);
 	tsk->state = TASK_RUNNING;
 
 	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
@@ -92,61 +210,25 @@
 }
 
 /*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
- *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
+ * spinlock grabbing wrapper for __rwsem_do_wake()
  */
 struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
-	signed long count;
-	int woken;
-
 	rwsemtrace(sem,"Entering rwsem_wake");
 
- try_again:
-	/* try to grab an 'activity' marker
-	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
-	 *   simultaneously
-	 * - be horribly naughty, and only deal with the LSW of the atomic counter
-	 */
-	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0) {
-		rwsemtrace(sem,"rwsem_wake: abort wakeup due to renewed activity");
-		goto out;
-	}
+	spin_lock(&sem->wait_lock);
 
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
-	 *   incremented by 0x00010000
-	 */
-	if (wake_up_ctx(&sem->wait,1,-RWSEM_WAITING_FOR_WRITE)==1)
-		goto out;
+	sem = __rwsem_do_wake(sem);
 
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
+	spin_unlock(&sem->wait_lock);
 
- out:
 	rwsemtrace(sem,"Leaving rwsem_wake");
 	return sem;
-
-	/* come here if we need to correct the counter for odd SMP-isms */
- counter_correction:
-	count = rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem);
-	rwsemtrace(sem,"corrected count");
-	if (!(count & RWSEM_ACTIVE_MASK))
-		goto try_again;
-	goto out;
 }
 
 EXPORT_SYMBOL(rwsem_down_read_failed);
 EXPORT_SYMBOL(rwsem_down_write_failed);
 EXPORT_SYMBOL(rwsem_wake);
+#if RWSEM_DEBUG
+EXPORT_SYMBOL(rwsemtrace);
+#endif

--------------Boundary-00=_M9B4UYK0T7DOAVAKJABQ--
