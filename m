Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSHHVjt>; Thu, 8 Aug 2002 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSHHVjt>; Thu, 8 Aug 2002 17:39:49 -0400
Received: from ppp-217-133-219-100.dialup.tiscali.it ([217.133.219.100]:36766
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317073AbSHHVjl>; Thu, 8 Aug 2002 17:39:41 -0400
Subject: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-bbncF8O0xj+mSFIdTMc2"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 23:43:15 +0200
Message-Id: <1028842995.1669.70.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bbncF8O0xj+mSFIdTMc2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch provides an atomic.h implementation without any knowledge of
the CPU instruction set.
On UP, it disables interrupts around atomic ops with the exception of
non-testing ops on m68k.
On SMP it uses a global spinlock cache taken from parisc.

As a side effect, it fixes cris, mips/ISA-level-1 and sh that were
broken due to the local_irq* renaming.

It also fixes the lack of some primitives that many of the changed archs
suffered from (e.g. atomic_{add,sub}_return) and reduces the total
amount of code.


diffstat:
 include/asm-generic/atomic.h |  159 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-cris/atomic.h    |  149 ----------------------------------------
 include/asm-arm/atomic.h     |  114 ------------------------------
 include/asm-parisc/atomic.h  |  104 ----------------------------
 include/asm-sh/atomic.h      |  103 ---------------------------
 include/asm-mips/atomic.h    |   83 ++--------------------
 include/asm-m68k/atomic.h    |   50 +------------
 arch/parisc/lib/bitops.c     |    6 -
 init/main.c                  |    1 
 9 files changed, 178 insertions(+), 591 deletions(-)


diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
--- a/arch/parisc/lib/bitops.c	2002-07-20 21:11:07.000000000 +0200
+++ b/arch/parisc/lib/bitops.c	2002-08-08 20:50:34.000000000 +0200
@@ -9,12 +9,6 @@
 #include <asm/system.h>
 #include <asm/atomic.h>
 
-#ifdef CONFIG_SMP
-spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
-	[0 ... (ATOMIC_HASH_SIZE-1)]  = SPIN_LOCK_UNLOCKED
-};
-#endif
-
 spinlock_t __atomic_lock = SPIN_LOCK_UNLOCKED;
 
 #ifndef __LP64__
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-arm/atomic.h b/include/asm-arm/atomic.h
--- a/include/asm-arm/atomic.h	2002-08-02 01:19:14.000000000 +0200
+++ b/include/asm-arm/atomic.h	2002-08-08 16:51:30.000000000 +0200
@@ -1,113 +1 @@
-/*
- *  linux/include/asm-arm/atomic.h
- *
- *  Copyright (c) 1996 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Changelog:
- *   27-06-1996	RMK	Created
- *   13-04-1997	RMK	Made functions atomic!
- *   07-12-1997	RMK	Upgraded for v2.1.
- *   26-08-1998	PJB	Added #ifdef __KERNEL__
- */
-#ifndef __ASM_ARM_ATOMIC_H
-#define __ASM_ARM_ATOMIC_H
-
-#include <linux/config.h>
-
-#ifdef CONFIG_SMP
-#error SMP not supported
-#endif
-
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-#ifdef __KERNEL__
-#include <asm/proc/system.h>
-
-#define atomic_read(v)	((v)->counter)
-#define atomic_set(v,i)	(((v)->counter) = (i))
-
-static inline void atomic_add(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	v->counter += i;
-	local_irq_restore(flags);
-}
-
-static inline void atomic_sub(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	v->counter -= i;
-	local_irq_restore(flags);
-}
-
-static inline void atomic_inc(volatile atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	v->counter += 1;
-	local_irq_restore(flags);
-}
-
-static inline void atomic_dec(volatile atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	v->counter -= 1;
-	local_irq_restore(flags);
-}
-
-static inline int atomic_dec_and_test(volatile atomic_t *v)
-{
-	unsigned long flags;
-	int val;
-
-	local_irq_save(flags);
-	val = v->counter;
-	v->counter = val -= 1;
-	local_irq_restore(flags);
-
-	return val == 0;
-}
-
-static inline int atomic_add_negative(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-	int val;
-
-	local_irq_save(flags);
-	val = v->counter;
-	v->counter = val += i;
-	local_irq_restore(flags);
-
-	return val < 0;
-}
-
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*addr &= ~mask;
-	local_irq_restore(flags);
-}
-
-/* Atomic operations are already serializing on ARM */
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
-
-#endif
-#endif
+#include <asm-generic/atomic.h>
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-cris/atomic.h b/include/asm-cris/atomic.h
--- a/include/asm-cris/atomic.h	2002-07-20 21:11:23.000000000 +0200
+++ b/include/asm-cris/atomic.h	2002-08-08 16:52:05.000000000 +0200
@@ -1,148 +1 @@
-/* $Id: atomic.h,v 1.3 2001/07/25 16:15:19 bjornw Exp $ */
-
-#ifndef __ASM_CRIS_ATOMIC__
-#define __ASM_CRIS_ATOMIC__
-
-#include <asm/system.h>
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-/*
- * Make sure gcc doesn't try to be clever and move things around
- * on us. We need to use _exactly_ the address the user gave us,
- * not some alias that contains the same information.
- */
-
-#define __atomic_fool_gcc(x) (*(struct { int a[100]; } *)x)
-
-typedef struct { int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)  { (i) }
-
-#define atomic_read(v) ((v)->counter)
-#define atomic_set(v,i) (((v)->counter) = (i))
-
-/* These should be written in asm but we do it in C for now. */
-
-static __inline__ void atomic_add(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	v->counter += i;
-	restore_flags(flags);
-}
-
-static __inline__ void atomic_sub(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	v->counter -= i;
-	restore_flags(flags);
-}
-
-static __inline__ int atomic_add_return(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-	int retval;
-	save_flags(flags);
-	cli();
-	retval = (v->counter += i);
-	restore_flags(flags);
-	return retval;
-}
-
-static __inline__ int atomic_sub_return(int i, volatile atomic_t *v)
-{
-	unsigned long flags;
-	int retval;
-	save_flags(flags);
-	cli();
-	retval = (v->counter -= i);
-	restore_flags(flags);
-	return retval;
-}
-
-static __inline__ int atomic_sub_and_test(int i, volatile atomic_t *v)
-{
-	int retval;
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	retval = (v->counter -= i) == 0;
-	restore_flags(flags);
-	return retval;
-}
-
-static __inline__ void atomic_inc(volatile atomic_t *v)
-{
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	(v->counter)++;
-	restore_flags(flags);
-}
-
-static __inline__ void atomic_dec(volatile atomic_t *v)
-{
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	(v->counter)--;
-	restore_flags(flags);
-}
-
-static __inline__ int atomic_inc_return(volatile atomic_t *v)
-{
-	unsigned long flags;
-	int retval;
-	save_flags(flags);
-	cli();
-	retval = (v->counter)++;
-	restore_flags(flags);
-	return retval;
-}
-
-static __inline__ int atomic_dec_return(volatile atomic_t *v)
-{
-	unsigned long flags;
-	int retval;
-	save_flags(flags);
-	cli();
-	retval = (v->counter)--;
-	restore_flags(flags);
-	return retval;
-}
-static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
-{
-	int retval;
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	retval = --(v->counter) == 0;
-	restore_flags(flags);
-	return retval;
-}
-
-static __inline__ int atomic_inc_and_test(volatile atomic_t *v)
-{
-	int retval;
-	unsigned long flags;
-	save_flags(flags);
-	cli();
-	retval = ++(v->counter) == 0;
-	restore_flags(flags);
-	return retval;
-}
-
-/* Atomic operations are already serializing */
-#define smp_mb__before_atomic_dec()    barrier()
-#define smp_mb__after_atomic_dec()     barrier()
-#define smp_mb__before_atomic_inc()    barrier()
-#define smp_mb__after_atomic_inc()     barrier()
-
-#endif
+#include <asm-generic/atomic.h>
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
--- a/include/asm-generic/atomic.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-generic/atomic.h	2002-08-08 22:31:17.000000000 +0200
@@ -0,0 +1,160 @@
+/*
+ *  linux/include/asm-generic/atomic.h
+ *
+ *  Copyright (c) 2002 Luca Barbieri.
+ *  Portions Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_GENERIC_ATOMIC_H
+#define __ASM_GENERIC_ATOMIC_H
+
+#include <linux/config.h>
+
+typedef struct {
+	volatile int counter;
+} atomic_t;
+
+#ifdef __KERNEL__
+#define ATOMIC_INIT(i)	{ (i) }
+
+#define atomic_read(v)	((v)->counter)
+#define atomic_set(v, i)	(((v)->counter) = (i))
+
+#ifndef CONFIG_SMP
+#include <asm/system.h>
+
+#define atomic_lock_complex(v) 	do {unsigned long flags; local_irq_save(flags);
+#define atomic_unlock_complex(v) local_irq_restore(flags);} while(0)
+
+#ifdef __ARCH_ATOMIC_HAVE_MEMORY_OPERANDS
+#define atomic_lock_simple(v) do {
+#define atomic_unlock_simple(v) } while(0)
+#else
+#define atomic_lock_simple(v) atomic_lock_complex(v)
+#define atomic_unlock_simple(v) atomic_unlock_complex(v)
+#endif
+
+#else
+
+#include <linux/spinlock.h>
+
+#ifndef atomic_to_spinlock
+/* we have an array of spinlocks for our atomic_ts, and a hash function
+ * to get the right index */
+/* NOTE: unless there are really a lot of CPUs ATOMIC_HASH_SIZE = 1 is
+         probably the fastest
+*/
+#ifndef ATOMIC_HASH_SIZE
+#define ATOMIC_HASH_SIZE 1
+#endif
+#ifdef __INIT_GLOBAL__
+spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
+	[0 ... (ATOMIC_HASH_SIZE-1)]  = SPIN_LOCK_UNLOCKED
+};
+#else
+extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
+#endif
+/* Improve! */
+#if ATOMIC_HASH_SIZE > 1
+/* This can probably be greatly improved. */
+#include <linux/cache.h>
+#define atomic_to_spinlock(v) (&__atomic_hash[(((unsigned long)v / sizeof(struct atomic_t)) + ((unsigned long)v / L1_CACHE_BYTES)) % ATOMIC_HASH_SIZE])
+#else
+#define atomic_to_spinlock(v) (&__atomic_hash[0])
+#endif
+#endif
+
+#define atomic_lock_complex(v) do {unsigned long flags; spin_lock_irqsave(atomic_to_spinlock(v), flags)
+#define atomic_unlock_complex(v) spin_unlock_irqrestore(atomic_to_spinlock(v), flags); } while(0)
+
+#define atomic_lock_simple(v) atomic_lock_complex(v)
+#define atomic_unlock_simple(v) atomic_unlock_complex(v)
+#endif /* CONFIG_SMP */
+
+static inline void atomic_add(int i, atomic_t *v)
+{
+	atomic_lock_simple(v);
+	v->counter += i;
+	atomic_unlock_simple(v);
+}
+
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	int new;
+
+	atomic_lock_complex(v);
+	new = (v->counter += i);
+	atomic_unlock_complex(v);
+
+	return new;
+}
+
+static inline void atomic_sub(int i, atomic_t *v)
+{
+	atomic_lock_simple(v);
+	v->counter -= i;
+	atomic_unlock_simple(v);
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	int new;
+
+	atomic_lock_complex(v);
+	new = (v->counter -= i);
+	atomic_unlock_complex(v);
+
+	return new;
+}
+
+#ifndef CONFIG_SMP
+#define atomic_lock_mask(v) atomic_lock_simple(0)
+#define atomic_unlock_mask(v) atomic_unlock_simple(0)
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr &= ~mask;
+	atomic_unlock_mask(addr);
+}
+
+static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr |= mask;
+	atomic_unlock_mask(addr);
+}
+
+static inline void atomic_change_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr ^= mask;
+	atomic_unlock_mask(addr);
+}
+#endif
+
+#define atomic_dec_return(v) atomic_sub_return(1, (v))
+#define atomic_inc_return(v) atomic_add_return(1, (v))
+
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
+#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
+#define atomic_dec_and_test(v) (atomic_dec_return((v)) == 0)
+#define atomic_inc_and_test(v) (atomic_inc_return((v)) == 0)
+
+#define atomic_inc(v) atomic_add(1, (v))
+#define atomic_dec(v) atomic_sub(1, (v))
+
+#define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
+#define atomic_sub_negative(i,v) (atomic_sub_return(i, v) < 0)
+
+#define smp_mb__before_atomic_dec()	barrier()
+#define smp_mb__after_atomic_dec()	barrier()
+#define smp_mb__before_atomic_inc()	barrier()
+#define smp_mb__after_atomic_inc()	barrier()
+
+#endif
+#endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-m68k/atomic.h b/include/asm-m68k/atomic.h
--- a/include/asm-m68k/atomic.h	2002-07-20 21:11:06.000000000 +0200
+++ b/include/asm-m68k/atomic.h	2002-08-08 22:25:19.000000000 +0200
@@ -1,40 +1,11 @@
 #ifndef __ARCH_M68K_ATOMIC__
 #define __ARCH_M68K_ATOMIC__
 
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-/*
- * We do not have SMP m68k systems, so we don't have to deal with that.
- */
-
-typedef struct { int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
-
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v, i)	(((v)->counter) = i)
-
-static __inline__ void atomic_add(int i, atomic_t *v)
-{
-	__asm__ __volatile__("addl %1,%0" : "=m" (*v) : "id" (i), "0" (*v));
-}
-
-static __inline__ void atomic_sub(int i, atomic_t *v)
-{
-	__asm__ __volatile__("subl %1,%0" : "=m" (*v) : "id" (i), "0" (*v));
-}
-
-static __inline__ void atomic_inc(volatile atomic_t *v)
-{
-	__asm__ __volatile__("addql #1,%0" : "=m" (*v): "0" (*v));
-}
+#define __ARCH_ATOMIC_HAVE_MEMORY_OPERANDS
+#include <asm-generic/atomic.h>
 
-static __inline__ void atomic_dec(volatile atomic_t *v)
-{
-	__asm__ __volatile__("subql #1,%0" : "=m" (*v): "0" (*v));
-}
+#ifndef CONFIG_SMP
+#undef atomic_dec_and_test
 
 static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
 {
@@ -42,17 +13,6 @@
 	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "=m" (*v): "1" (*v));
 	return c != 0;
 }
-
-#define atomic_clear_mask(mask, v) \
-	__asm__ __volatile__("andl %1,%0" : "=m" (*v) : "id" (~(mask)),"0"(*v))
-
-#define atomic_set_mask(mask, v) \
-	__asm__ __volatile__("orl %1,%0" : "=m" (*v) : "id" (mask),"0"(*v))
-
-/* Atomic operations are already serializing */
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
+#endif
 
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
--- a/include/asm-mips/atomic.h	2002-07-20 21:11:04.000000000 +0200
+++ b/include/asm-mips/atomic.h	2002-08-08 17:08:50.000000000 +0200
@@ -16,9 +16,15 @@
 
 #include <linux/config.h>
 
+#ifdef __KERNEL__
+#ifndef CONFIG_CPU_HAS_LLSC
+
+#include <asm-generic/atomic.h>
+
+#else
+
 typedef struct { volatile int counter; } atomic_t;
 
-#ifdef __KERNEL__
 #define ATOMIC_INIT(i)    { (i) }
 
 /*
@@ -40,78 +46,6 @@
  */
 #define atomic_set(v,i)	((v)->counter = (i))
 
-#ifndef CONFIG_CPU_HAS_LLSC
-
-#include <asm/system.h>
-
-/*
- * The MIPS I implementation is only atomic with respect to
- * interrupts.  R3000 based multiprocessor machines are rare anyway ...
- *
- * atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
- */
-extern __inline__ void atomic_add(int i, atomic_t * v)
-{
-	int	flags;
-
-	save_flags(flags);
-	cli();
-	v->counter += i;
-	restore_flags(flags);
-}
-
-/*
- * atomic_sub - subtract the atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
- */
-extern __inline__ void atomic_sub(int i, atomic_t * v)
-{
-	int	flags;
-
-	save_flags(flags);
-	cli();
-	v->counter -= i;
-	restore_flags(flags);
-}
-
-extern __inline__ int atomic_add_return(int i, atomic_t * v)
-{
-	int	temp, flags;
-
-	save_flags(flags);
-	cli();
-	temp = v->counter;
-	temp += i;
-	v->counter = temp;
-	restore_flags(flags);
-
-	return temp;
-}
-
-extern __inline__ int atomic_sub_return(int i, atomic_t * v)
-{
-	int	temp, flags;
-
-	save_flags(flags);
-	cli();
-	temp = v->counter;
-	temp -= i;
-	v->counter = temp;
-	restore_flags(flags);
-
-	return temp;
-}
-
-#else
 
 /*
  * ... while for MIPS II and better we can use ll/sc instruction.  This
@@ -202,7 +136,6 @@
 
 	return result;
 }
-#endif
 
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
@@ -278,6 +211,8 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#endif
+
 #endif /* defined(__KERNEL__) */
 
 #endif /* __ASM_ATOMIC_H */
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-parisc/atomic.h b/include/asm-parisc/atomic.h
--- a/include/asm-parisc/atomic.h	2002-07-20 21:11:13.000000000 +0200
+++ b/include/asm-parisc/atomic.h	2002-08-08 20:52:49.000000000 +0200
@@ -1,103 +1 @@
-#ifndef _ASM_PARISC_ATOMIC_H_
-#define _ASM_PARISC_ATOMIC_H_
-
-#include <linux/config.h>
-#include <asm/system.h>
-
-/* Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.  */
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- *
- * And probably incredibly slow on parisc.  OTOH, we don't
- * have to write any serious assembly.   prumpf
- */
-
-#ifdef CONFIG_SMP
-/* we have an array of spinlocks for our atomic_ts, and a hash function
- * to get the right index */
-#  define ATOMIC_HASH_SIZE 1
-#  define ATOMIC_HASH(a) (&__atomic_hash[0])
-
-extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
-/* copied from <asm/spinlock.h> and modified */
-#  define SPIN_LOCK(x) \
-	do { while(__ldcw(&(x)->lock) == 0); } while(0)
-	
-#  define SPIN_UNLOCK(x) \
-	do { (x)->lock = 1; } while(0)
-#else
-#  define ATOMIC_HASH_SIZE 1
-#  define ATOMIC_HASH(a)	(0)
-
-/* copied from <linux/spinlock.h> and modified */
-#  define SPIN_LOCK(x) (void)(x)
-	
-#  define SPIN_UNLOCK(x) do { } while(0)
-#endif
-
-/* copied from <linux/spinlock.h> and modified */
-#define SPIN_LOCK_IRQSAVE(lock, flags)		do { local_irq_save(flags);       SPIN_LOCK(lock); } while (0)
-#define SPIN_UNLOCK_IRQRESTORE(lock, flags)	do { SPIN_UNLOCK(lock);  local_irq_restore(flags); } while (0)
-
-/* Note that we need not lock read accesses - aligned word writes/reads
- * are atomic, so a reader never sees unconsistent values.
- *
- * Cache-line alignment would conflict with, for example, linux/module.h */
-
-typedef struct {
-	volatile int counter;
-} atomic_t;
-
-/* It's possible to reduce all atomic operations to either
- * __atomic_add_return, __atomic_set and __atomic_ret (the latter
- * is there only for consistency). */
-
-static __inline__ int __atomic_add_return(int i, atomic_t *v)
-{
-	int ret;
-	unsigned long flags;
-	SPIN_LOCK_IRQSAVE(ATOMIC_HASH(v), flags);
-
-	ret = (v->counter += i);
-
-	SPIN_UNLOCK_IRQRESTORE(ATOMIC_HASH(v), flags);
-	return ret;
-}
-
-static __inline__ void __atomic_set(atomic_t *v, int i) 
-{
-	unsigned long flags;
-	SPIN_LOCK_IRQSAVE(ATOMIC_HASH(v), flags);
-
-	v->counter = i;
-
-	SPIN_UNLOCK_IRQRESTORE(ATOMIC_HASH(v), flags);
-}
-	
-static __inline__ int __atomic_read(atomic_t *v)
-{
-	return v->counter;
-}
-
-/* exported interface */
-
-#define atomic_add(i,v)		((void)(__atomic_add_return( (i),(v))))
-#define atomic_sub(i,v)		((void)(__atomic_add_return(-(i),(v))))
-#define atomic_inc(v)		((void)(__atomic_add_return(   1,(v))))
-#define atomic_dec(v)		((void)(__atomic_add_return(  -1,(v))))
-
-#define atomic_add_return(i,v)	(__atomic_add_return( (i),(v)))
-#define atomic_sub_return(i,v)	(__atomic_add_return(-(i),(v)))
-#define atomic_inc_return(v)	(__atomic_add_return(   1,(v)))
-#define atomic_dec_return(v)	(__atomic_add_return(  -1,(v)))
-
-#define atomic_dec_and_test(v)	(atomic_dec_return(v) == 0)
-
-#define atomic_set(v,i)		(__atomic_set((v),i))
-#define atomic_read(v)		(__atomic_read(v))
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-#endif
+#include <asm-generic/atomic.h>
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/include/asm-sh/atomic.h b/include/asm-sh/atomic.h
--- a/include/asm-sh/atomic.h	2002-07-20 21:11:11.000000000 +0200
+++ b/include/asm-sh/atomic.h	2002-08-08 16:55:54.000000000 +0200
@@ -1,102 +1 @@
-#ifndef __ASM_SH_ATOMIC_H
-#define __ASM_SH_ATOMIC_H
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- *
- */
-
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
-
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v,i)		((v)->counter = (i))
-
-#include <asm/system.h>
-
-/*
- * To get proper branch prediction for the main line, we must branch
- * forward to code at the end of this object's .text section, then
- * branch back to restart the operation.
- */
-
-static __inline__ void atomic_add(int i, atomic_t * v)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	*(long *)v += i;
-	restore_flags(flags);
-}
-
-static __inline__ void atomic_sub(int i, atomic_t *v)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	*(long *)v -= i;
-	restore_flags(flags);
-}
-
-static __inline__ int atomic_add_return(int i, atomic_t * v)
-{
-	unsigned long temp, flags;
-
-	save_and_cli(flags);
-	temp = *(long *)v;
-	temp += i;
-	*(long *)v = temp;
-	restore_flags(flags);
-
-	return temp;
-}
-
-static __inline__ int atomic_sub_return(int i, atomic_t * v)
-{
-	unsigned long temp, flags;
-
-	save_and_cli(flags);
-	temp = *(long *)v;
-	temp -= i;
-	*(long *)v = temp;
-	restore_flags(flags);
-
-	return temp;
-}
-
-#define atomic_dec_return(v) atomic_sub_return(1,(v))
-#define atomic_inc_return(v) atomic_add_return(1,(v))
-
-#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
-#define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
-
-#define atomic_inc(v) atomic_add(1,(v))
-#define atomic_dec(v) atomic_sub(1,(v))
-
-static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	*(long *)v &= ~mask;
-	restore_flags(flags);
-}
-
-static __inline__ void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	*(long *)v |= mask;
-	restore_flags(flags);
-}
-
-/* Atomic operations are already serializing on SH */
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
-
-#endif /* __ASM_SH_ATOMIC_H */
+#include <asm-generic/atomic.h>
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-i386 a/init/main.c b/init/main.c
--- a/init/main.c	2002-08-02 01:19:14.000000000 +0200
+++ b/init/main.c	2002-08-08 20:47:25.000000000 +0200
@@ -10,6 +10,7 @@
  */
 
 #define __KERNEL_SYSCALLS__
+#define __INIT_GLOBAL__
 
 #include <linux/config.h>
 #include <linux/proc_fs.h>


--=-bbncF8O0xj+mSFIdTMc2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UuXydjkty3ft5+cRAp11AJ97BZSGATin3a//MZSxOGl5ORUf2gCgr30V
oqJwcrPxkp/xC8bDmxPB2Xw=
=FnrH
-----END PGP SIGNATURE-----

--=-bbncF8O0xj+mSFIdTMc2--
