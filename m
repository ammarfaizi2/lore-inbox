Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136254AbREGQIG>; Mon, 7 May 2001 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136253AbREGQH5>; Mon, 7 May 2001 12:07:57 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:8197 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S136247AbREGQHt>; Mon, 7 May 2001 12:07:49 -0400
Date: Mon, 7 May 2001 20:02:07 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] alpha rw semaphores (try #2)
Message-ID: <20010507200207.A1634@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- 'count' is 64-bit now;
- __builtin_expect used;
- fast non-atomic UP version;
- some silly bits from previous patch dropped.

Ivan.


--- 2.4.5p1/lib/rwsem.c	Sat Apr 28 00:58:28 2001
+++ linux/lib/rwsem.c	Mon May  7 16:10:54 2001
@@ -112,7 +112,7 @@ static inline struct rw_semaphore *__rws
  */
 static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
 								 struct rwsem_waiter *waiter,
-								 __s32 adjustment)
+								 signed long adjustment)
 {
 	struct task_struct *tsk = current;
 	signed long count;
--- 2.4.5p1/include/asm-alpha/rwsem.h	Sun Feb  7 06:28:16 2106
+++ linux/include/asm-alpha/rwsem.h	Mon May  7 16:07:29 2001
@@ -0,0 +1,207 @@
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
+	long			count;
+#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
+#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
+#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
+#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
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
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
+
+#define DECLARE_RWSEM(name) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->count = RWSEM_UNLOCKED_VALUE;
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+}
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	long oldcount;
+#ifndef	CONFIG_SMP
+	oldcount = sem->count;
+	sem->count += RWSEM_ACTIVE_READ_BIAS;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"1:	ldq_l	%0,%1\n"
+	"	addq	%0,%3,%2\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	"	mb\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
+#endif
+	if (__builtin_expect(oldcount < 0, 0))
+		rwsem_down_read_failed(sem);
+}
+
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	long oldcount;
+#ifndef	CONFIG_SMP
+	oldcount = sem->count;
+	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"1:	ldq_l	%0,%1\n"
+	"	addq	%0,%3,%2\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	"	mb\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
+#endif
+	if (__builtin_expect(oldcount, 0))
+		rwsem_down_write_failed(sem);
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	long oldcount;
+#ifndef	CONFIG_SMP
+	oldcount = sem->count;
+	sem->count -= RWSEM_ACTIVE_READ_BIAS;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"	mb\n"
+	"1:	ldq_l	%0,%1\n"
+	"	subq	%0,%3,%2\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
+#endif
+	if (__builtin_expect(oldcount < 0, 0)) 
+		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
+			rwsem_wake(sem);
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	long count;
+#ifndef	CONFIG_SMP
+	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
+	count = sem->count;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"	mb\n"
+	"1:	ldq_l	%0,%1\n"
+	"	subq	%0,%3,%2\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	"	subq	%0,%3,%0\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
+#endif
+	if (__builtin_expect(count, 0))
+		if ((int)count == 0)
+			rwsem_wake(sem);
+}
+
+static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
+{
+#ifndef	CONFIG_SMP
+	sem->count += val;
+#else
+	long temp;
+	__asm__ __volatile__(
+	"1:	ldq_l	%0,%1\n"
+	"	addq	%0,%2,%0\n"
+	"	stq_c	%0,%1\n"
+	"	beq	%0,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (temp), "=m" (sem->count)
+	:"Ir" (val), "m" (sem->count));
+#endif
+}
+
+static inline long rwsem_atomic_update(long val, struct rw_semaphore *sem)
+{
+#ifndef	CONFIG_SMP
+	sem->count += val;
+	return sem->count;
+#else
+	long ret, temp;
+	__asm__ __volatile__(
+	"1:	ldq_l	%0,%1\n"
+	"	addq 	%0,%3,%2\n"
+	"	addq	%0,%3,%0\n"
+	"	stq_c	%2,%1\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (val), "m" (sem->count));
+
+	return ret;
+#endif
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ALPHA_RWSEM_H */
--- 2.4.5p1/arch/alpha/kernel/alpha_ksyms.c	Sat Apr 21 05:26:15 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Mon May  7 15:06:06 2001
@@ -173,10 +173,6 @@ EXPORT_SYMBOL(down);
 EXPORT_SYMBOL(down_interruptible);
 EXPORT_SYMBOL(down_trylock);
 EXPORT_SYMBOL(up);
-EXPORT_SYMBOL(down_read);
-EXPORT_SYMBOL(down_write);
-EXPORT_SYMBOL(up_read);
-EXPORT_SYMBOL(up_write);
 
 /* 
  * SMP-specific symbols.
--- 2.4.5p1/arch/alpha/config.in	Wed Apr 18 04:19:24 2001
+++ linux/arch/alpha/config.in	Mon May  7 15:05:07 2001
@@ -5,8 +5,8 @@
 
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
+define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 
