Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDWUhK>; Mon, 23 Apr 2001 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDWUhC>; Mon, 23 Apr 2001 16:37:02 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:14028 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S131590AbRDWUgx>;
	Mon, 23 Apr 2001 16:36:53 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_AJI9T7DOAVAKJABQ8AXX"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: torvalds@transmeta.com
Subject: [PATCH] rw_semaphores, optimisations try #3
Date: Mon, 23 Apr 2001 21:35:34 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, andrea@suse.de,
        davem@redhat.com
MIME-Version: 1.0
Message-Id: <01042321353400.00801@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_AJI9T7DOAVAKJABQ8AXX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch (made against linux-2.4.4-pre6) makes a number of changes to the
rwsem implementation:

 (1) Everything in try #2

plus

 (2) Changes proposed by Linus for the generic semaphore code.

 (3) Ideas from Andrea and how he implemented his semaphores.

Linus, you suggested that the generic list handling stuff would be faster (2 
unconditional stores) than mine (1 unconditional store and 1 conditional 
store and branch to jump round it). You are both right and wrong. The generic 
code does two stores per _process_ woken up (list_del) mine does the 1 or 2 
stores per _batch_ of processes woken up. So the generic way is better when 
the queue is an even mixture of readers or writers and my way is better when 
there are far greater numbers of waiting readers. However, that said, there 
is not much in it either way, so I've reverted it to the generic list stuff.

David
--------------Boundary-00=_AJI9T7DOAVAKJABQ8AXX
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rwsem-opt3.diff"
Content-Transfer-Encoding: 8bit
Content-Description: rw-semaphores optimisation, try #3
Content-Disposition: attachment; filename="rwsem-opt3.diff"

diff -uNr linux-2.4.4-pre6/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.4-pre6/arch/i386/kernel/i386_ksyms.c	Sat Apr 21 21:24:25 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Sat Apr 21 22:52:50 2001
@@ -80,11 +80,6 @@
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
-#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
-EXPORT_SYMBOL_NOVERS(__rwsem_down_write_failed);
-EXPORT_SYMBOL_NOVERS(__rwsem_down_read_failed);
-EXPORT_SYMBOL_NOVERS(__rwsem_wake);
-#endif
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
diff -uNr linux-2.4.4-pre6/arch/i386/lib/Makefile linux/arch/i386/lib/Makefile
--- linux-2.4.4-pre6/arch/i386/lib/Makefile	Sat Apr 21 21:24:25 2001
+++ linux/arch/i386/lib/Makefile	Sat Apr 21 22:52:50 2001
@@ -9,7 +9,7 @@
 
 obj-y = checksum.o old-checksum.o delay.o \
 	usercopy.o getuser.o putuser.o \
-	memcpy.o strstr.o rwsem.o
+	memcpy.o strstr.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -uNr linux-2.4.4-pre6/arch/i386/lib/rwsem.S linux/arch/i386/lib/rwsem.S
--- linux-2.4.4-pre6/arch/i386/lib/rwsem.S	Sat Apr 21 21:24:25 2001
+++ linux/arch/i386/lib/rwsem.S	Thu Jan  1 01:00:00 1970
@@ -1,36 +0,0 @@
-/* rwsem.S: R/W semaphores, register saving wrapper function stubs
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from arch/i386/kernel/semaphore.c
- */
-
-.text
-.align 4
-.globl __rwsem_down_read_failed
-__rwsem_down_read_failed:
-	pushl	%edx
-	pushl	%ecx
-	call	rwsem_down_read_failed
-	popl	%ecx
-	popl	%edx
-	ret
-
-.align 4
-.globl __rwsem_down_write_failed
-__rwsem_down_write_failed:
-	pushl	%edx
-	pushl	%ecx
-	call	rwsem_down_write_failed
-	popl	%ecx
-	popl	%edx
-	ret
-
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-	call	rwsem_wake
-	popl	%ecx
-	popl	%edx
-	ret
diff -uNr linux-2.4.4-pre6/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
--- linux-2.4.4-pre6/include/asm-i386/rwsem.h	Sat Apr 21 21:24:32 2001
+++ linux/include/asm-i386/rwsem.h	Mon Apr 23 20:37:37 2001
@@ -17,11 +17,6 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
-/* we use FASTCALL convention for the helpers */
-extern struct rw_semaphore *FASTCALL(__rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(__rwsem_wake(struct rw_semaphore *sem));
-
 struct rwsem_waiter;
 
 /*
@@ -41,11 +36,6 @@
 #if RWSEM_DEBUG
 	int			debug;
 #endif
-#if RWSEM_DEBUG_MAGIC
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
 };
 
 /*
@@ -56,15 +46,10 @@
 #else
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
-#if RWSEM_DEBUG_MAGIC
-#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_MINIT(name)	/* */
-#endif
 
 #define __RWSEM_INITIALIZER(name) \
 { RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front \
-	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
+	__RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
@@ -78,11 +63,6 @@
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
-#if RWSEM_DEBUG_MAGIC
-	sem->__magic = (long)&sem->__magic;
-	atomic_set(&sem->readers, 0);
-	atomic_set(&sem->writers, 0);
-#endif
 }
 
 /*
@@ -97,7 +77,11 @@
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      __rwsem_down_read_failed\n\t"
+		"  pushl     %%ecx\n\t"
+		"  pushl     %%edx\n\t"
+		"  call      rwsem_down_read_failed\n\t"
+		"  popl      %%edx\n\t"
+		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
 		".previous"
 		"# ending down_read\n\t"
@@ -116,17 +100,19 @@
 	tmp = RWSEM_ACTIVE_WRITE_BIAS;
 	__asm__ __volatile__(
 		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x00010001, returns the old value */
+LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
 		"  testl     %0,%0\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      __rwsem_down_write_failed\n\t"
+		"  pushl     %%ecx\n\t"
+		"  call      rwsem_down_write_failed\n\t"
+		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending down_write"
-		: "+r"(tmp), "=m"(sem->count)
+		: "+d"(tmp), "=m"(sem->count)
 		: "a"(sem), "m"(sem->count)
 		: "memory");
 }
@@ -136,26 +122,23 @@
  */
 static inline void __up_read(struct rw_semaphore *sem)
 {
-	int tmp;
-
-	tmp = -RWSEM_ACTIVE_READ_BIAS;
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtracts 1, returns the old value */
+LOCK_PREFIX	"  xadd      %%eax,(%%edx)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  decl      %0\n\t" /* xadd gave us the old count */
-		"  testl     %3,%0\n\t" /* do nothing if still outstanding active readers */
+		"  decl      %%eax\n\t" /* xadd gave us the old count */
+		"  testl     %3,%%eax\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
-		"  call      __rwsem_wake\n\t"
+		"  call      rwsem_up_read_wake\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_read\n"
-		: "+r"(tmp), "=m"(sem->count)
-		: "a"(sem), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count)
-		: "memory");
+		: "=m"(sem->count)
+		: "d"(sem), "a"(-RWSEM_ACTIVE_READ_BIAS), "i"(RWSEM_ACTIVE_MASK), "m"(sem->count)
+		: "memory", "ecx");
 }
 
 /*
@@ -165,21 +148,32 @@
 {
 	__asm__ __volatile__(
 		"# beginning __up_write\n\t"
-LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* adds 0x0000ffff */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
+LOCK_PREFIX	"  cmpxchgl  %%ecx,(%%edx)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
+		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".section .text.lock,\"ax\"\n"
 		"2:\n\t"
-		"  call      __rwsem_wake\n\t"
+		"  call      rwsem_up_write_wake\n\t"
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_write\n"
 		: "=m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count)
+		: "d"(sem), "a"(RWSEM_ACTIVE_WRITE_BIAS), "c"(0), "m"(sem->count)
 		: "memory");
 }
 
 /*
+ * implement atomic add functionality
+ */
+static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(
+LOCK_PREFIX	"addl %1,%0"
+		:"=m"(sem->count)
+		:"ir"(delta), "m"(sem->count));
+}
+
+/*
  * implement exchange and add functionality
  */
 static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
@@ -187,9 +181,9 @@
 	int tmp = delta;
 
 	__asm__ __volatile__(
-		LOCK_PREFIX "xadd %0,(%1)"
-		: "+r"(tmp)
-		: "r"(sem)
+LOCK_PREFIX	"xadd %0,(%2)"
+		: "+r"(tmp), "=m"(sem->count)
+		: "r"(sem), "m"(sem->count)
 		: "memory");
 
 	return tmp+delta;
@@ -200,7 +194,31 @@
  */
 static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
 {
-	return cmpxchg((__u16*)&sem->count,0,RWSEM_ACTIVE_BIAS);
+	__u16 tmp = old;
+
+	__asm__ __volatile__(
+LOCK_PREFIX	"cmpxchgw %w2,%3"
+		: "=a"(tmp), "=m"(sem->count)
+		: "r"(new), "m1"(sem->count), "a"(tmp)
+		: "memory");
+
+	return tmp;
+}
+
+/*
+ * implement compare and exchange functionality on the rw-semaphore count
+ */
+static inline signed long rwsem_cmpxchg(struct rw_semaphore *sem, signed long old, signed long new)
+{
+	signed long tmp = old;
+
+	__asm__ __volatile__(
+LOCK_PREFIX	"cmpxchgl %2,%3"
+		: "=a"(tmp), "=m"(sem->count)
+		: "r"(new), "m1"(sem->count), "a"(tmp)
+		: "memory");
+
+	return tmp;
 }
 
 #endif /* __KERNEL__ */
diff -uNr linux-2.4.4-pre6/include/asm-sparc64/rwsem.h linux/include/asm-sparc64/rwsem.h
--- linux-2.4.4-pre6/include/asm-sparc64/rwsem.h	Sat Apr 21 21:24:33 2001
+++ linux/include/asm-sparc64/rwsem.h	Sat Apr 21 23:12:22 2001
@@ -2,7 +2,7 @@
  * rwsem.h: R/W semaphores implemented using CAS
  *
  * Written by David S. Miller (davem@redhat.com), 2001.
- * Derived from asm-i386/rwsem-xadd.h
+ * Derived from asm-i386/rwsem.h
  */
 #ifndef _SPARC64_RWSEM_H
 #define _SPARC64_RWSEM_H
@@ -127,14 +127,15 @@
 		"save		%%sp, -160, %%sp\n\t"
 		"mov		%%g2, %%l2\n\t"
 		"mov		%%g3, %%l3\n\t"
+		" mov		%%g7, %%o0\n\t"
 		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
+		" mov		%%g5, %%o1\n\t"
 		"mov		%%l2, %%g2\n\t"
 		"ba,pt		%%xcc, 2b\n\t"
 		" restore	%%l3, %%g0, %%g3\n\t"
 		".previous\n\t"
 		"! ending __up_read"
-		: : "r" (sem), "i" (rwsem_wake),
+		: : "r" (sem), "i" (rwsem_up_read_wake),
 		    "i" (RWSEM_ACTIVE_MASK)
 		: "g1", "g5", "g7", "memory", "cc");
 }
@@ -145,31 +146,28 @@
 		"! beginning __up_write\n\t"
 		"sethi		%%hi(%2), %%g1\n\t"
 		"or		%%g1, %%lo(%2), %%g1\n"
-		"1:\tlduw	[%0], %%g5\n\t"
-		"sub		%%g5, %%g1, %%g7\n\t"
-		"cas		[%0], %%g5, %%g7\n\t"
-		"cmp		%%g5, %%g7\n\t"
-		"bne,pn		%%icc, 1b\n\t"
-		" sub		%%g7, %%g1, %%g7\n\t"
-		"cmp		%%g7, 0\n\t"
-		"bl,pn		%%icc, 3f\n\t"
+		"sub		%%g5, %%g5, %%g5\n\t"
+		"cas		[%0], %%g1, %%g5\n\t"
+		"cmp		%%g1, %%g5\n\t"
+		"bne,pn		%%icc, 1f\n\t"
 		" membar	#StoreStore\n"
 		"2:\n\t"
 		".subsection 2\n"
-		"3:\tmov	%0, %%g5\n\t"
+		"3:\tmov	%0, %%g1\n\t"
 		"save		%%sp, -160, %%sp\n\t"
 		"mov		%%g2, %%l2\n\t"
 		"mov		%%g3, %%l3\n\t"
+		"mov		%%g1, %%o0\n\t"
 		"call		%1\n\t"
-		" mov		%%g5, %%o0\n\t"
+		" mov		%%g5, %%o1\n\t"
 		"mov		%%l2, %%g2\n\t"
 		"ba,pt		%%xcc, 2b\n\t"
 		" restore	%%l3, %%g0, %%g3\n\t"
 		".previous\n\t"
 		"! ending __up_write"
-		: : "r" (sem), "i" (rwsem_wake),
+		: : "r" (sem), "i" (rwsem_up_write_wake),
 		    "i" (RWSEM_ACTIVE_WRITE_BIAS)
-		: "g1", "g5", "g7", "memory", "cc");
+		: "g1", "g5", "memory", "cc");
 }
 
 static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
@@ -191,6 +189,8 @@
 	return tmp + delta;
 }
 
+#define rwsem_atomic_add rwsem_atomic_update
+
 static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 __old, __u16 __new)
 {
 	u32 old = (sem->count & 0xffff0000) | (u32) __old;
@@ -212,6 +212,11 @@
 		goto again;
 
 	return prev & 0xffff;
+}
+
+static inline signed long rwsem_cmpxchg(struct rw_semaphore *sem, signed long old, signed long new)
+{
+	return cmpxchg(&sem->count,old,new);
 }
 
 #endif /* __KERNEL__ */
diff -uNr linux-2.4.4-pre6/include/linux/rwsem-spinlock.h linux/include/linux/rwsem-spinlock.h
--- linux-2.4.4-pre6/include/linux/rwsem-spinlock.h	Sat Apr 21 21:24:33 2001
+++ linux/include/linux/rwsem-spinlock.h	Mon Apr 23 21:06:42 2001
@@ -1,6 +1,8 @@
 /* rwsem-spinlock.h: fallback C implementation
  *
  * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
+ * - Derived also from comments by Linus
  */
 
 #ifndef _LINUX_RWSEM_SPINLOCK_H
@@ -11,6 +13,7 @@
 #endif
 
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 #ifdef __KERNEL__
 
@@ -19,27 +22,19 @@
 struct rwsem_waiter;
 
 /*
- * the semaphore definition
+ * the rw-semaphore definition
+ * - if activity is 0 then there are no active readers or writers
+ * - if activity is +ve then that is the number of active readers
+ * - if activity is -1 then there is one active writer
+ * - if wait_list is not empty, then there are processes waiting for the semaphore
  */
 struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	__s32			activity;
 	spinlock_t		wait_lock;
-	struct rwsem_waiter	*wait_front;
-	struct rwsem_waiter	**wait_back;
+	struct list_head	wait_list;
 #if RWSEM_DEBUG
 	int			debug;
 #endif
-#if RWSEM_DEBUG_MAGIC
-	long			__magic;
-	atomic_t		readers;
-	atomic_t		writers;
-#endif
 };
 
 /*
@@ -50,119 +45,18 @@
 #else
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
-#if RWSEM_DEBUG_MAGIC
-#define __RWSEM_DEBUG_MINIT(name)	, (int)&(name).__magic, ATOMIC_INIT(0), ATOMIC_INIT(0)
-#else
-#define __RWSEM_DEBUG_MINIT(name)	/* */
-#endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front \
-	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }
+{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	sem->wait_front = NULL;
-	sem->wait_back = &sem->wait_front;
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
-	int count;
-	spin_lock(&sem->wait_lock);
-	sem->count += RWSEM_ACTIVE_READ_BIAS;
-	count = sem->count;
-	spin_unlock(&sem->wait_lock);
-	if (count<0)
-		rwsem_down_read_failed(sem);
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int count;
-	spin_lock(&sem->wait_lock);
-	count = sem->count;
-	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
-	spin_unlock(&sem->wait_lock);
-	if (count)
-		rwsem_down_write_failed(sem);
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int count;
-	spin_lock(&sem->wait_lock);
-	count = sem->count;
-	sem->count -= RWSEM_ACTIVE_READ_BIAS;
-	spin_unlock(&sem->wait_lock);
-	if (count<0 && !((count-RWSEM_ACTIVE_READ_BIAS)&RWSEM_ACTIVE_MASK))
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	int count;
-	spin_lock(&sem->wait_lock);
-	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
-	count = sem->count;
-	spin_unlock(&sem->wait_lock);
-	if (count<0)
-		rwsem_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- * - only called when spinlock is already held
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int count;
-
-	sem->count += delta;
-	count = sem->count;
-
-	return count;
-}
-
-/*
- * implement compare and exchange functionality on the rw-semaphore count LSW
- * - only called by __rwsem_do_wake(), so spinlock is already held when called
- */
-static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)
-{
-	__u16 prev;
-
-	prev = sem->count & RWSEM_ACTIVE_MASK;
-	if (prev==old)
-		sem->count = (sem->count & ~RWSEM_ACTIVE_MASK) | new;
-
-	return prev;
-}
+extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
+extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern void FASTCALL(__up_read(struct rw_semaphore *sem));
+extern void FASTCALL(__up_write(struct rw_semaphore *sem));
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -uNr linux-2.4.4-pre6/include/linux/rwsem.h linux/include/linux/rwsem.h
--- linux-2.4.4-pre6/include/linux/rwsem.h	Sat Apr 21 21:24:33 2001
+++ linux/include/linux/rwsem.h	Mon Apr 23 20:37:37 2001
@@ -34,7 +34,6 @@
 #include <linux/linkage.h>
 
 #define RWSEM_DEBUG 0
-#define RWSEM_DEBUG_MAGIC 0
 
 #ifdef __KERNEL__
 
@@ -47,11 +46,12 @@
 /* defined contention handler functions for the generic case
  * - these are also used for the exchange-and-add based algorithm
  */
-#if defined(CONFIG_RWSEM_GENERIC_SPINLOCK) || defined(CONFIG_RWSEM_XCHGADD_ALGORITHM)
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /* we use FASTCALL convention for the helpers */
 extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *sem));
+extern void FASTCALL(rwsem_up_read_wake(signed long, struct rw_semaphore *));
+extern void FASTCALL(rwsem_up_write_wake(signed long, struct rw_semaphore *));
 #endif
 
 #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
@@ -74,20 +74,7 @@
 static inline void down_read(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering down_read");
-
-#if RWSEM_DEBUG_MAGIC
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-
 	__down_read(sem);
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_inc(&sem->readers);
-#endif
-
 	rwsemtrace(sem,"Leaving down_read");
 }
 
@@ -97,22 +84,7 @@
 static inline void down_write(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering down_write");
-
-#if RWSEM_DEBUG_MAGIC
-	if (sem->__magic != (long)&sem->__magic)
-		BUG();
-#endif
-
 	__down_write(sem);
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	if (atomic_read(&sem->readers))
-		BUG();
-	atomic_inc(&sem->writers);
-#endif
-
 	rwsemtrace(sem,"Leaving down_write");
 }
 
@@ -122,14 +94,7 @@
 static inline void up_read(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering up_read");
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->writers))
-		BUG();
-	atomic_dec(&sem->readers);
-#endif
 	__up_read(sem);
-
 	rwsemtrace(sem,"Leaving up_read");
 }
 
@@ -139,16 +104,7 @@
 static inline void up_write(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering up_write");
-
-#if RWSEM_DEBUG_MAGIC
-	if (atomic_read(&sem->readers))
-		BUG();
-	if (atomic_read(&sem->writers) != 1)
-		BUG();
-	atomic_dec(&sem->writers);
-#endif
 	__up_write(sem);
-
 	rwsemtrace(sem,"Leaving up_write");
 }
 
diff -uNr linux-2.4.4-pre6/lib/Makefile linux/lib/Makefile
--- linux-2.4.4-pre6/lib/Makefile	Sat Apr 21 21:24:33 2001
+++ linux/lib/Makefile	Sun Apr 22 00:07:33 2001
@@ -8,14 +8,12 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o
+export-objs := cmdline.o rwsem-spinlock.o rwsem.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
 
-ifneq ($(CONFIG_RWSEM_GENERIC_SPINLOCK)$(CONFIG_RWSEM_XCHGADD_ALGORITHM),nn)
-export-objs += rwsem.o
-obj-y += rwsem.o
-endif
+obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
+obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
diff -uNr linux-2.4.4-pre6/lib/rwsem-spinlock.c linux/lib/rwsem-spinlock.c
--- linux-2.4.4-pre6/lib/rwsem-spinlock.c	Thu Jan  1 01:00:00 1970
+++ linux/lib/rwsem-spinlock.c	Mon Apr 23 21:06:46 2001
@@ -0,0 +1,239 @@
+/* rwsem-spinlock.c: R/W semaphores: contention handling functions for generic spinlock
+ *                                   implementation
+ *
+ * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
+ * - Derived also from comments by Linus
+ */
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+struct rwsem_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	unsigned int		flags;
+#define RWSEM_WAITING_FOR_READ	0x00000001
+#define RWSEM_WAITING_FOR_WRITE	0x00000002
+};
+
+#if RWSEM_DEBUG
+void rwsemtrace(struct rw_semaphore *sem, const char *str)
+{
+	if (sem->debug)
+		printk("[%d] %s({%d,%d})\n",
+		       current->pid,str,sem->activity,list_empty(&sem->wait_list)?0:1);
+}
+#endif
+
+/*
+ * initialise the semaphore
+ */
+void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->activity = 0;
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+}
+
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active count' _reached_ zero
+ *   - the 'waiting count' is non-zero
+ * - the spinlock must be held by the caller
+ * - woken process blocks are discarded from the list after having flags zeroised
+ */
+static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter *waiter;
+	int woken;
+
+	rwsemtrace(sem,"Entering __rwsem_do_wake");
+
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - we leave the 'waiting count' incremented to signify potential contention
+	 */
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
+		sem->activity = -1;
+		list_del(&waiter->list);
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		goto out;
+	}
+
+	/* grant an infinite number of read locks to the readers at the front of the queue */
+	woken = 0;
+	do {
+		list_del(&waiter->list);
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		woken++;
+		if (list_empty(&sem->wait_list))
+			break;
+		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
+
+	sem->activity += woken;
+
+ out:
+	rwsemtrace(sem,"Leaving __rwsem_do_wake");
+	return sem;
+}
+
+/*
+ * wake a single writer
+ */
+static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter *waiter;
+
+	sem->activity = -1;
+
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	list_del(&waiter->list);
+
+	waiter->flags = 0;
+	wake_up_process(waiter->task);
+	return sem;
+}
+
+/*
+ * get a read lock on the semaphore
+ */
+void __down_read(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	struct task_struct *tsk;
+
+	rwsemtrace(sem,"Entering __down_read");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity++;
+		spin_unlock(&sem->wait_lock);
+		goto out;
+	}
+
+	tsk = current;
+	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_READ;
+
+	list_add_tail(&waiter.list,&sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	spin_unlock(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter.flags)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+ out:
+	rwsemtrace(sem,"Leaving __down_read");
+}
+
+/*
+ * get a write lock on the semaphore
+ * - note that we increment the waiting count anyway to indicate an exclusive lock
+ */
+void __down_write(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	struct task_struct *tsk;
+
+	rwsemtrace(sem,"Entering __down_write");
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity==0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity = -1;
+		spin_unlock(&sem->wait_lock);
+		goto out;
+	}
+
+	tsk = current;
+	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+
+	list_add_tail(&waiter.list,&sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	spin_unlock(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter.flags)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+ out:
+	rwsemtrace(sem,"Leaving __down_write");
+}
+
+/*
+ * release a read lock on the semaphore
+ */
+void __up_read(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering __up_read");
+
+	spin_lock(&sem->wait_lock);
+
+	if (--sem->activity==0 && !list_empty(&sem->wait_list))
+		sem = __rwsem_wake_one_writer(sem);
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __up_read");
+}
+
+/*
+ * release a write lock on the semaphore
+ */
+void __up_write(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering __up_write");
+
+	spin_lock(&sem->wait_lock);
+
+	sem->activity = 0;
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem);
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __up_write");
+}
+
+EXPORT_SYMBOL(init_rwsem);
+EXPORT_SYMBOL(__down_read);
+EXPORT_SYMBOL(__down_write);
+EXPORT_SYMBOL(__up_read);
+EXPORT_SYMBOL(__up_write);
+#if RWSEM_DEBUG
+EXPORT_SYMBOL(rwsemtrace);
+#endif
diff -uNr linux-2.4.4-pre6/lib/rwsem.c linux/lib/rwsem.c
--- linux-2.4.4-pre6/lib/rwsem.c	Sat Apr 21 21:24:33 2001
+++ linux/lib/rwsem.c	Sun Apr 22 14:29:53 2001
@@ -14,57 +14,36 @@
 #define RWSEM_WAITING_FOR_READ	0x00000001
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };
-#define RWSEM_WAITER_MAGIC 0x52575345
-
-static struct rw_semaphore *FASTCALL(__rwsem_do_wake(struct rw_semaphore *sem));
 
 #if RWSEM_DEBUG
 void rwsemtrace(struct rw_semaphore *sem, const char *str)
 {
 	if (sem->debug)
-		printk("[%d] %s(count=%08lx)\n",current->pid,str,sem->count);
+		printk("[%d] %s({%08lx})\n",current->pid,str,sem->count);
 }
 #endif
 
 /*
  * handle the lock being released whilst there are processes blocked on it that can now run
+ * - the caller can specify an adjustment that will need to be made to the semaphore count to
+ *   help reduce the number of atomic operations invoked
  * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero (but may no longer be zero)
+ *   - the 'active part' of the count (&0x0000ffff) reached zero but has been re-incremented
  *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
- *   - the spinlock must be held before entry
- *   - woken process blocks are discarded from the list after having flags zeroised
+ * - the spinlock must be held by the caller
+ * - woken process blocks are discarded from the list after having flags zeroised
  */
-static struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+static inline struct rw_semaphore *__rwsem_do_wake(int adjustment, struct rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter, *next;
 	int woken, loop;
 
 	rwsemtrace(sem,"Entering __rwsem_do_wake");
 
-	/* try to grab an 'activity' marker
-	 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
-	 *   simultaneously
-	 * - be horribly naughty, and only deal with the LSW of the atomic counter
-	 */
-	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0) {
-		rwsemtrace(sem,"__rwsem_do_wake: abort wakeup due to renewed activity");
-		goto out;
-	}
-
-	/* check the wait queue is populated */
 	waiter = sem->wait_front;
 
-	if (__builtin_expect(!waiter,0)) {
-		printk("__rwsem_do_wake(): wait_list unexpectedly empty\n");
-		BUG();
-		goto out;
-	}
-
-	if (__builtin_expect(!waiter->flags,0)) {
-		printk("__rwsem_do_wake(): wait_list front apparently not waiting\n");
-		BUG();
-		goto out;
-	}
+	if (!waiter)
+	  goto list_unexpectedly_empty;
 
 	next = NULL;
 
@@ -73,6 +52,8 @@
 	 *   incremented by 0x00010000
 	 */
 	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
+		if (adjustment)
+			rwsem_atomic_add(adjustment,sem);
 		next = waiter->next;
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
@@ -92,7 +73,8 @@
 	loop = woken;
 	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
 	woken -= RWSEM_ACTIVE_BIAS;
-	rwsem_atomic_update(woken,sem);
+	woken += adjustment;
+	rwsem_atomic_add(woken,sem);
 
 	waiter = sem->wait_front;
 	for (; loop>0; loop--) {
@@ -109,6 +91,12 @@
  out:
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
+
+ list_unexpectedly_empty:
+	printk("__rwsem_do_wake(): wait_list unexpectedly empty\n");
+	printk("[%d] %p = { %08lx })\n",current->pid,sem,sem->count);
+	BUG();
+	goto out;
 }
 
 /*
@@ -123,7 +111,7 @@
 	signed long count;
 
 	rwsemtrace(sem,"Entering rwsem_down_read_failed");
-	
+
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
@@ -141,9 +129,11 @@
 
 	/* if there are no longer active locks, wake the front queued process(es) up
 	 * - it might even be this process, since the waker takes a more active part
+	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		__rwsem_do_wake(sem);
+		if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
+			__rwsem_do_wake(0,sem);
 
 	spin_unlock(&sem->wait_lock);
 
@@ -189,9 +179,11 @@
 
 	/* if there are no longer active locks, wake the front queued process(es) up
 	 * - it might even be this process, since the waker takes a more active part
+	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		__rwsem_do_wake(sem);
+		if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
+			__rwsem_do_wake(0,sem);
 
 	spin_unlock(&sem->wait_lock);
 
@@ -210,25 +202,64 @@
 }
 
 /*
- * spinlock grabbing wrapper for __rwsem_do_wake()
+ * handle up_read() finding a waiter on the semaphore
+ * - up_read has decremented the active part of the count if we come here
  */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+void rwsem_up_read_wake(signed long count, struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering rwsem_wake");
+	rwsemtrace(sem,"Entering rwsem_up_read_wake");
 
 	spin_lock(&sem->wait_lock);
 
-	sem = __rwsem_do_wake(sem);
+	/* need to wake up a waiter unless the semaphore has gone active again
+	 * - should only enter __rwsem_do_wake() only on a transition 0->1 in the LSW
+	 */
+	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)==0)
+		sem = __rwsem_do_wake(0,sem);
 
 	spin_unlock(&sem->wait_lock);
 
-	rwsemtrace(sem,"Leaving rwsem_wake");
-	return sem;
+	rwsemtrace(sem,"Leaving rwsem_up_read_wake");
+}
+
+/*
+ * handle up_write() finding a waiter on the semaphore
+ * - up_write has not modified the count if we come here
+ */
+void rwsem_up_write_wake(signed long count, struct rw_semaphore *sem)
+{
+	signed long new;
+
+	rwsemtrace(sem,"Entering rwsem_up_write_wake");
+
+	spin_lock(&sem->wait_lock);
+
+ try_again:
+	/* if the active part of the count is 1, we should perform a wake-up, else we should
+	 * decrement the count and return
+	 */
+	if ((count&RWSEM_ACTIVE_MASK)==RWSEM_ACTIVE_BIAS) {
+		sem = __rwsem_do_wake(-RWSEM_WAITING_BIAS,sem);
+	}
+	else {
+		/* tricky - we mustn't return the active part of the count to 0 */
+		new = count - RWSEM_ACTIVE_WRITE_BIAS;
+		new = rwsem_cmpxchg(sem,count,new);
+		if (count!=new) {
+			count = new;
+			goto try_again;
+		}
+	}
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving rwsem_up_write_wake");
 }
 
 EXPORT_SYMBOL(rwsem_down_read_failed);
 EXPORT_SYMBOL(rwsem_down_write_failed);
-EXPORT_SYMBOL(rwsem_wake);
+EXPORT_SYMBOL(rwsem_up_read_wake);
+EXPORT_SYMBOL(rwsem_up_write_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif

--------------Boundary-00=_AJI9T7DOAVAKJABQ8AXX--
