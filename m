Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRGKOBP>; Wed, 11 Jul 2001 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbRGKOBG>; Wed, 11 Jul 2001 10:01:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:23793 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266696AbRGKOAs>; Wed, 11 Jul 2001 10:00:48 -0400
To: ralf@gnu.ai.mit.edu
Cc: linux-mips@fnet.fr, linux-kernel@vger.kernel.org
Subject: optimised rw-semaphores for MIPS/MIPS64
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <2502.994859927.0@warthog.cambridge.redhat.com>
Date: Wed, 11 Jul 2001 15:00:47 +0100
Message-ID: <2508.994860047@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2502.994859927.1@warthog.cambridge.redhat.com>

Hello Ralf,

I've produced an inline-assembly optimised Read/Write Semaphore patch for MIPS
against linux-2.4.7-pre6 (rwsem.diff). David Woodhouse has tested it.

I've also included a patch to the MIPS64 arch to supply that with optimised
rwsems (rwsem64.diff), but that is untested.

Finally, I've included a patch to fix lib/rwsem.c (lib-rwsem.diff) if you want
to try the patch on MIPS64 against anything earlier than 2.4.7-pre6.

David


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem.diff"; charset="us-ascii"
Content-ID: <2502.994859927.2@warthog.cambridge.redhat.com>
Content-Description: MIPS optimised rwsem patch

diff -uNr -x CVS -x TAGS linux-2.4-mips/arch/mips/config.in linux-mips-rwsem/arch/mips/config.in
--- linux-2.4-mips/arch/mips/config.in	Thu Jun 28 13:58:46 2001
+++ linux-mips-rwsem/arch/mips/config.in	Wed Jul 11 14:38:19 2001
@@ -68,8 +68,8 @@
    fi
 bool 'Support for Alchemy Semi PB1000 board' CONFIG_MIPS_PB1000
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
+define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 #
 # Select some configuration options automatically for certain systems.
diff -uNr -x CVS -x TAGS linux-2.4-mips/include/asm-mips/rwsem.h linux-mips-rwsem/include/asm-mips/rwsem.h
--- linux-2.4-mips/include/asm-mips/rwsem.h	Thu Jan  1 01:00:00 1970
+++ linux-mips-rwsem/include/asm-mips/rwsem.h	Wed Jul 11 14:35:09 2001
@@ -0,0 +1,206 @@
+/* rwsem.h: R/W semaphores implemented using MIPS32 LL/SC
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ *
+ * Derived from:
+ * - asm-i386/rwsem.h: written by David Howells (dhowells@redhat.com).
+ * - asm-alpha/rwsem.h: written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
+ */
+#ifndef _ASM_RWSEM_H
+#define _ASM_RWSEM_H
+
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#endif
+
+#ifdef __KERNEL__
+
+#include <asm/compiler.h>
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
+	signed long			count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000L
+#define RWSEM_ACTIVE_BIAS		0x00000001L
+#define RWSEM_ACTIVE_MASK		0x0000ffffL
+#define RWSEM_WAITING_BIAS		(-0x00010000L)
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
+	"	.set	noreorder\n"
+	"1:	ll	%0,%1\n"
+	"	addiu	%2,%0,%3\n"
+	"	sc	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "I"(RWSEM_ACTIVE_READ_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	ll	%0,%1\n"
+	"	addu	%2,%0,%3\n"
+	"	sc	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "r" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	ll	%0,%1\n"
+	"	addiu	%2,%0,%3\n"	/* no dsubiu */
+	"	sc	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "I" (-RWSEM_ACTIVE_READ_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	ll	%0,%1\n"
+	"	subu	%2,%0,%3\n"
+	"	sc	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 dsubu	%0,%3,%0\n"
+	"	sync	\n"
+	"	.set	reorder"
+	: "=&r" (count), "=m" (sem->count), "=&r" (temp)
+	: "I" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count)
+	: "memory");
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
+	"1:	ll	%0,%1\n"
+	"	addu	%0,%2,%0\n"
+	"	sc	%0,%1\n"
+	"	beq	%0,0,1b\n"
+	"	 nop	\n"
+	:"=&r" (temp), "=m" (sem->count)
+	:"r" (val), "m" (sem->count));
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
+	"1:	ll	%0,%1\n"
+	"	addu 	%2,%0,%3\n"
+	"	sc	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 addu	%0,%3,%0\n"
+	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (val), "m" (sem->count));
+
+	return ret;
+#endif
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_RWSEM_H */

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem64.diff"; charset="us-ascii"
Content-ID: <2502.994859927.3@warthog.cambridge.redhat.com>
Content-Description: MIPS64 optimised rwsem patch

diff -uNr -x CVS -x TAGS linux-2.4-mips/arch/mips64/config.in linux-mips-rwsem/arch/mips64/config.in
--- linux-2.4-mips/arch/mips64/config.in	Thu Jun 28 13:59:11 2001
+++ linux-mips-rwsem/arch/mips64/config.in	Wed Jul 11 14:38:25 2001
@@ -27,8 +27,8 @@
 fi
 endmenu
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
+define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 #
 # Select some configuration options automatically based on user selections
diff -uNr -x CVS -x TAGS linux-2.4-mips/include/asm-mips64/rwsem.h linux-mips-rwsem/include/asm-mips64/rwsem.h
--- linux-2.4-mips/include/asm-mips64/rwsem.h	Thu Jan  1 01:00:00 1970
+++ linux-mips-rwsem/include/asm-mips64/rwsem.h	Wed Jul 11 14:35:48 2001
@@ -0,0 +1,206 @@
+/* rwsem.h: R/W semaphores implemented using MIPS64 LLD/SCD
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ *
+ * Derived from:
+ * - asm-i386/rwsem.h: written by David Howells (dhowells@redhat.com).
+ * - asm-alpha/rwsem.h: written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
+ */
+#ifndef _ASM_RWSEM_H
+#define _ASM_RWSEM_H
+
+#ifndef _LINUX_RWSEM_H
+#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
+#endif
+
+#ifdef __KERNEL__
+
+#include <asm/compiler.h>
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
+	signed long			count;
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
+	"	.set	noreorder\n"
+	"1:	lld	%0,%1\n"
+	"	daddiu	%2,%0,%3\n"
+	"	scd	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "I"(RWSEM_ACTIVE_READ_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	lld	%0,%1\n"
+	"	daddu	%2,%0,%3\n"
+	"	scd	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "r" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	lld	%0,%1\n"
+	"	daddiu	%2,%0,%3\n"	/* no dsubiu */
+	"	scd	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 sync	\n"
+	"	.set	reorder"
+	: "=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
+	: "I" (-RWSEM_ACTIVE_READ_BIAS), "m" (sem->count)
+	: "memory");
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
+	"	.set	noreorder\n"
+	"1:	lld	%0,%1\n"
+	"	dsubu	%2,%0,%3\n"
+	"	scd	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 dsubu	%0,%3,%0\n"
+	"	sync	\n"
+	"	.set	reorder"
+	: "=&r" (count), "=m" (sem->count), "=&r" (temp)
+	: "I" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count)
+	: "memory");
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
+	"1:	lld	%0,%1\n"
+	"	daddu	%0,%2,%0\n"
+	"	scd	%0,%1\n"
+	"	beq	%0,0,1b\n"
+	"	 nop	\n"
+	:"=&r" (temp), "=m" (sem->count)
+	:"r" (val), "m" (sem->count));
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
+	"1:	lld	%0,%1\n"
+	"	daddu 	%2,%0,%3\n"
+	"	scd	%2,%1\n"
+	"	beq	%2,0,1b\n"
+	"	 daddu	%0,%3,%0\n"
+	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
+	:"Ir" (val), "m" (sem->count));
+
+	return ret;
+#endif
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_RWSEM_H */

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="lib-rwsem.diff"; charset="us-ascii"
Content-ID: <2502.994859927.4@warthog.cambridge.redhat.com>
Content-Description: 64-bit rwsem fix for older kernels

diff -uNr -x CVS -x TAGS linux-2.4-mips/lib/rwsem.c linux-mips-rwsem/lib/rwsem.c
--- linux-2.4-mips/lib/rwsem.c	Mon Apr 30 09:55:41 2001
+++ linux-mips-rwsem/lib/rwsem.c	Wed Jul 11 14:04:02 2001
@@ -112,7 +112,7 @@
  */
 static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
 								 struct rwsem_waiter *waiter,
-								 __s32 adjustment)
+								 signed long adjustment)
 {
 	struct task_struct *tsk = current;
 	signed long count;

------- =_aaaaaaaaaa0--
