Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRECPsb>; Thu, 3 May 2001 11:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRECPsW>; Thu, 3 May 2001 11:48:22 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1028 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132057AbRECPsL>; Thu, 3 May 2001 11:48:11 -0400
Date: Thu, 3 May 2001 19:47:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010503194747.A552@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initially I tried to use __builtin_expect in the rwsem.h, but found
that it doesn't help at all in the small inline functions - it works
as expected only in a reasonably large block of code. Converting these
functions into the macros won't help, as callers are inline
functions also.
On the other hand, gcc 3.0 generates quite a good code for
conditional branches (comparisons like value < 0, value == 0
predicted as false etc.). In the cases where expected value is 0,
we can use cmpeq instruction.
Other changes:
 - added atomic_add_return_prev() for __down_write()
 - removed some mb's for non-SMP
 - removed non-inline up()/down_xx() when semaphore/waitqueue debugging
   isn't enabled.

Ivan.

--- 2.4.4/include/asm-alpha/rwsem.h	Sun Feb  7 06:28:16 2106
+++ linux/include/asm-alpha/rwsem.h	Thu May  3 13:01:34 2001
@@ -0,0 +1,105 @@
+#ifndef _ALPHA_RWSEM_H
+#define _ALPHA_RWSEM_H
+
+/*
+ * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
+ * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
+ */
+
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#endif
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct rwsem_waiter;
+
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
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
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), SPIN_LOCK_UNLOCKED, \
+	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->count.counter = RWSEM_UNLOCKED_VALUE;
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+}
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	long count;
+	count = atomic_inc_return(&sem->count);
+	if (count < 0)
+		rwsem_down_read_failed(sem);
+}
+
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	long prev, cmp;
+	prev = atomic_add_return_prev(RWSEM_ACTIVE_WRITE_BIAS, &sem->count);
+	__asm__ __volatile__("cmpeq	%1,0,%0\n" : "=r" (cmp) : "r" (prev));
+	if (!cmp)
+		rwsem_down_write_failed(sem);
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	long count;
+	count = atomic_dec_return(&sem->count);
+	if (count < 0)
+		if ((count & RWSEM_ACTIVE_MASK) == 0)
+			rwsem_wake(sem);
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	long count, cmp;
+	count = atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS, &sem->count);
+	__asm__ __volatile__("cmpeq	%1,0,%0\n" : "=r" (cmp) : "r" (count));
+	if (!cmp)
+		if ((count & RWSEM_ACTIVE_MASK) == 0)
+			rwsem_wake(sem);
+}
+
+#define rwsem_atomic_add(val, sem)	atomic_add(val, &(sem)->count)
+#define rwsem_atomic_update(val, sem)	atomic_add_return(val, &(sem)->count)
+
+#endif /* __KERNEL__ */
+#endif /* _ALPHA_RWSEM_H */
--- 2.4.4/include/asm-alpha/atomic.h	Fri Apr 27 20:33:29 2001
+++ linux/include/asm-alpha/atomic.h	Fri Apr 27 20:33:41 2001
@@ -70,7 +70,9 @@ static __inline__ long atomic_add_return
 	"	addl %0,%3,%0\n"
 	"	stl_c %0,%1\n"
 	"	beq %0,2f\n"
+#ifdef CONFIG_SMP
 	"	mb\n"
+#endif
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
@@ -88,11 +90,35 @@ static __inline__ long atomic_sub_return
 	"	subl %0,%3,%0\n"
 	"	stl_c %0,%1\n"
 	"	beq %0,2f\n"
+#ifdef CONFIG_SMP
 	"	mb\n"
+#endif
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)
+	:"Ir" (i), "m" (v->counter) : "memory");
+	return result;
+}
+
+/*
+ * Same as above, but return the previous value
+ */
+static __inline__ long atomic_add_return_prev(int i, atomic_t * v)
+{
+	long temp, result;
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%1\n"
+	"	addl %0,%3,%2\n"
+	"	stl_c %2,%1\n"
+	"	beq %2,2f\n"
+#ifdef CONFIG_SMP
+	"	mb\n"
+#endif
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	:"=&r" (result), "=m" (v->counter), "=&r" (temp)
 	:"Ir" (i), "m" (v->counter) : "memory");
 	return result;
 }
--- 2.4.4/include/asm-alpha/semaphore.h	Fri Apr 27 20:33:29 2001
+++ linux/include/asm-alpha/semaphore.h	Thu May  3 13:04:47 2001
@@ -11,7 +11,6 @@
 #include <asm/current.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <linux/compiler.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
@@ -92,14 +91,14 @@ extern void __up_wakeup(struct semaphore
 static inline void __down(struct semaphore *sem)
 {
 	long count = atomic_dec_return(&sem->count);
-	if (__builtin_expect(count < 0, 0))
+	if (count < 0)
 		__down_failed(sem);
 }
 
 static inline int __down_interruptible(struct semaphore *sem)
 {
 	long count = atomic_dec_return(&sem->count);
-	if (__builtin_expect(count < 0, 0))
+	if (count < 0)
 		return __down_failed_interruptible(sem);
 	return 0;
 }
@@ -201,7 +200,7 @@ static inline void __up(struct semaphore
 		: "m"(*sem), "r"(0x0000000100000000)
 		: "memory");
 
-	if (__builtin_expect(ret <= 0, 0))
+	if (ret <= 0)
 		__up_wakeup(sem);
 }
 
--- 2.4.4/arch/alpha/kernel/alpha_ksyms.c	Fri Apr 27 20:33:29 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Thu May  3 12:32:29 2001
@@ -169,14 +169,12 @@ EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__up_wakeup);
+#if WAITQUEUE_DEBUG || DEBUG_SEMAPHORE
 EXPORT_SYMBOL(down);
 EXPORT_SYMBOL(down_interruptible);
 EXPORT_SYMBOL(down_trylock);
 EXPORT_SYMBOL(up);
-EXPORT_SYMBOL(down_read);
-EXPORT_SYMBOL(down_write);
-EXPORT_SYMBOL(up_read);
-EXPORT_SYMBOL(up_write);
+#endif
 
 /* 
  * SMP-specific symbols.
--- 2.4.4/arch/alpha/kernel/semaphore.c	Wed Apr 18 04:19:24 2001
+++ linux/arch/alpha/kernel/semaphore.c	Thu May  3 14:41:29 2001
@@ -201,6 +201,8 @@ __up_wakeup(struct semaphore *sem)
 	wake_up(&sem->wait);
 }
 
+#if WAITQUEUE_DEBUG || DEBUG_SEMAPHORE
+
 void
 down(struct semaphore *sem)
 {
@@ -263,3 +265,5 @@ up(struct semaphore *sem)
 #endif
 	__up(sem);
 }
+
+#endif
--- 2.4.4/arch/alpha/config.in	Fri Apr 27 20:33:29 2001
+++ linux/arch/alpha/config.in	Fri Apr 27 20:33:41 2001
@@ -5,8 +5,8 @@
 
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
+define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 
