Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUEJALh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUEJALh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUEJALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:11:37 -0400
Received: from ozlabs.org ([203.10.76.45]:29402 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261661AbUEJALN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:11:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16542.51381.215308.485006@cargo.ozlabs.ibm.com>
Date: Mon, 10 May 2004 10:11:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Un-inline spinlocks on ppc64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The patch below moves the ppc64 spinlocks and rwlocks out of line and
into arch/ppc64/lib/locks.c, and implements _raw_spin_lock_flags for
ppc64.

Part of the motivation for moving the spinlocks and rwlocks out of
line was that I needed to add code to the slow paths to yield the
processor to the hypervisor on systems with shared processors.  On
these systems, a cpu as seen by the kernel is a virtual processor that
is not necessarily running full-time on a real physical cpu.  If we
are spinning on a lock which is held by another virtual processor
which is not running at the moment, we are just wasting time.  In such
a situation it is better to do a hypervisor call to ask it to give the
rest of our time slice to the lock holder so that forward progress can
be made.

The one problem with out-of-line spinlock routines is that lock
contention will show up in profiles in the spin_lock etc. routines
rather than in the callers, as it does with inline spinlocks.  I have
added a CONFIG_INLINE_SPINLOCKS config option for people that want to
do profiling.  In the longer term, Anton is talking about teaching the
profiling code to attribute samples in the spin lock routines to the
routine's caller.

This patch reduces the kernel by about 80kB on my G5.  With inline
spinlocks selected, the kernel gets about 4kB bigger than without the
patch, because _raw_spin_lock_flags is slightly bigger than
_raw_spin_lock.

This patch depends on the patch from Keith Owens to add
_raw_spin_lock_flags.  If you decide to drop that patch, let me know
and I can do a new version without _raw_spin_lock_flags.  In either
case, I would like to see this patch go in once 2.6.6 is out because
we need the yield-to-lock-holder capability on the new POWER5 machines
that are coming out.

Thanks,
Paul.

diff -urN 2.6.6-rc3-mm2-g5-orig/arch/ppc64/kernel/pacaData.c 2.6.6-rc3-mm2-g5/arch/ppc64/kernel/pacaData.c
--- 2.6.6-rc3-mm2-g5-orig/arch/ppc64/kernel/pacaData.c	2004-05-06 18:29:16.000000000 +1000
+++ 2.6.6-rc3-mm2-g5/arch/ppc64/kernel/pacaData.c	2004-05-06 19:55:52.000000000 +1000
@@ -36,6 +36,7 @@
 {									    \
 	.xLpPacaPtr = &paca[number].xLpPaca,				    \
 	.xLpRegSavePtr = &paca[number].xRegSav,				    \
+	.lock_token = 0x8000,						    \
 	.xPacaIndex = (number),		/* Paca Index */		    \
 	.default_decr = 0x00ff0000,	/* Initial Decr */		    \
 	.xStab_data = {							    \
diff -urN 2.6.6-rc3-mm2-g5-orig/arch/ppc64/lib/Makefile 2.6.6-rc3-mm2-g5/arch/ppc64/lib/Makefile
--- 2.6.6-rc3-mm2-g5-orig/arch/ppc64/lib/Makefile	2004-05-06 18:27:15.000000000 +1000
+++ 2.6.6-rc3-mm2-g5/arch/ppc64/lib/Makefile	2004-05-06 19:55:52.000000000 +1000
@@ -3,4 +3,4 @@
 #
 
 lib-y := checksum.o dec_and_lock.o string.o strcase.o
-lib-y += copypage.o memcpy.o copyuser.o
+lib-y += copypage.o memcpy.o copyuser.o locks.o
diff -urN 2.6.6-rc3-mm2-g5-orig/arch/ppc64/lib/locks.c 2.6.6-rc3-mm2-g5/arch/ppc64/lib/locks.c
--- 2.6.6-rc3-mm2-g5-orig/arch/ppc64/lib/locks.c	Thu Jan 01 10:00:00 1970
+++ 2.6.6-rc3-mm2-g5/arch/ppc64/lib/locks.c	Thu May 06 22:05:43 2004
@@ -0,0 +1,285 @@
+/*
+ * Spin and read/write lock operations.
+ *
+ * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
+ * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2002 Dave Engebretsen <engebret@us.ibm.com>, IBM
+ *   Rework to support virtual processors
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/hvcall.h>
+#include <asm/iSeries/HvCall.h>
+
+#ifndef CONFIG_INLINE_SPINLOCKS
+
+/*
+ * On a system with shared processors (that is, where a physical
+ * processor is multiplexed between several virtual processors),
+ * there is no point spinning on a lock if the holder of the lock
+ * isn't currently scheduled on a physical processor.  Instead
+ * we detect this situation and ask the hypervisor to give the
+ * rest of our timeslice to the lock holder.
+ *
+ * So that we can tell which virtual processor is holding a lock,
+ * we put 0x80000000 | smp_processor_id() in the lock when it is
+ * held.  Conveniently, we have a word in the paca that holds this
+ * value.
+ */
+
+/* waiting for a spinlock... */
+#if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
+void __spin_yield(spinlock_t *lock)
+{
+	unsigned int lock_value, holder_cpu, yield_count;
+	struct paca_struct *holder_paca;
+
+	lock_value = lock->lock;
+	if (lock_value == 0)
+		return;
+	holder_cpu = lock_value & 0xffff;
+	BUG_ON(holder_cpu >= NR_CPUS);
+	holder_paca = &paca[holder_cpu];
+	yield_count = holder_paca->xLpPaca.xYieldCount;
+	if ((yield_count & 1) == 0)
+		return;		/* virtual cpu is currently running */
+	rmb();
+	if (lock->lock != lock_value)
+		return;		/* something has changed */
+#ifdef CONFIG_PPC_ISERIES
+	HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
+		((u64)holder_cpu << 32) | yield_count);
+#else
+	plpar_hcall_norets(H_CONFER, holder_cpu, yield_count);
+#endif
+}
+
+#else /* SPLPAR || ISERIES */
+#define __spin_yield(x)	barrier()
+#endif
+
+/*
+ * This returns the old value in the lock, so we succeeded
+ * in getting the lock if the return value is 0.
+ */
+static __inline__ unsigned long __spin_trylock(spinlock_t *lock)
+{
+	unsigned long tmp, tmp2;
+
+	__asm__ __volatile__(
+"	lwz		%1,24(13)		# __spin_trylock\n\
+1:	lwarx		%0,0,%2\n\
+	cmpwi		0,%0,0\n\
+	bne-		2f\n\
+	stwcx.		%1,0,%2\n\
+	bne-		1b\n\
+	isync\n\
+2:"	: "=&r" (tmp), "=&r" (tmp2)
+	: "r" (&lock->lock)
+	: "cr0", "memory");
+
+	return tmp;
+}
+
+int _raw_spin_trylock(spinlock_t *lock)
+{
+	return __spin_trylock(lock) == 0;
+}
+
+EXPORT_SYMBOL(_raw_spin_trylock);
+
+void _raw_spin_lock(spinlock_t *lock)
+{
+	while (1) {
+		if (likely(__spin_trylock(lock) == 0))
+			break;
+		do {
+			HMT_low();
+			__spin_yield(lock);
+		} while (likely(lock->lock != 0));
+		HMT_medium();
+	}
+}
+
+EXPORT_SYMBOL(_raw_spin_lock);
+
+void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
+{
+	unsigned long flags_dis;
+
+	while (1) {
+		if (likely(__spin_trylock(lock) == 0))
+			break;
+		local_save_flags(flags_dis);
+		local_irq_restore(flags);
+		do {
+			HMT_low();
+			__spin_yield(lock);
+		} while (likely(lock->lock != 0));
+		HMT_medium();
+		local_irq_restore(flags_dis);
+	}
+}
+
+EXPORT_SYMBOL(_raw_spin_lock_flags);
+
+void spin_unlock_wait(spinlock_t *lock)
+{
+	while (lock->lock)
+		__spin_yield(lock);
+}
+
+EXPORT_SYMBOL(spin_unlock_wait);
+
+/*
+ * Waiting for a read lock or a write lock on a rwlock...
+ * This turns out to be the same for read and write locks, since
+ * we only know the holder if it is write-locked.
+ */
+#if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
+void __rw_yield(rwlock_t *rw)
+{
+	int lock_value;
+	unsigned int holder_cpu, yield_count;
+	struct paca_struct *holder_paca;
+
+	lock_value = rw->lock;
+	if (lock_value >= 0)
+		return;		/* no write lock at present */
+	holder_cpu = lock_value & 0xffff;
+	BUG_ON(holder_cpu >= NR_CPUS);
+	holder_paca = &paca[holder_cpu];
+	yield_count = holder_paca->xLpPaca.xYieldCount;
+	if ((yield_count & 1) == 0)
+		return;		/* virtual cpu is currently running */
+	rmb();
+	if (rw->lock != lock_value)
+		return;		/* something has changed */
+#ifdef CONFIG_PPC_ISERIES
+	HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
+		((u64)holder_cpu << 32) | yield_count);
+#else
+	plpar_hcall_norets(H_CONFER, holder_cpu, yield_count);
+#endif
+}
+
+#else /* SPLPAR || ISERIES */
+#define __rw_yield(x)	barrier()
+#endif
+
+/*
+ * This returns the old value in the lock + 1,
+ * so we got a read lock if the return value is > 0.
+ */
+static __inline__ long __read_trylock(rwlock_t *rw)
+{
+	long tmp;
+
+	__asm__ __volatile__(
+"1:	lwarx		%0,0,%1		# read_trylock\n\
+	extsw		%0,%0\n\
+	addic.		%0,%0,1\n\
+	ble-		2f\n\
+	stwcx.		%0,0,%1\n\
+	bne-		1b\n\
+	isync\n\
+2:"	: "=&r" (tmp)
+	: "r" (&rw->lock)
+	: "cr0", "xer", "memory");
+
+	return tmp;
+}
+
+int _raw_read_trylock(rwlock_t *rw)
+{
+	return __read_trylock(rw) > 0;
+}
+
+EXPORT_SYMBOL(_raw_read_trylock);
+
+void _raw_read_lock(rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__read_trylock(rw) > 0))
+			break;
+		do {
+			HMT_low();
+			__rw_yield(rw);
+		} while (likely(rw->lock < 0));
+		HMT_medium();
+	}
+}
+
+EXPORT_SYMBOL(_raw_read_lock);
+
+void _raw_read_unlock(rwlock_t *rw)
+{
+	long tmp;
+
+	__asm__ __volatile__(
+	"eieio				# read_unlock\n\
+1:	lwarx		%0,0,%1\n\
+	addic		%0,%0,-1\n\
+	stwcx.		%0,0,%1\n\
+	bne-		1b"
+	: "=&r"(tmp)
+	: "r"(&rw->lock)
+	: "cr0", "memory");
+}
+
+EXPORT_SYMBOL(_raw_read_unlock);
+
+/*
+ * This returns the old value in the lock,
+ * so we got the write lock if the return value is 0.
+ */
+static __inline__ long __write_trylock(rwlock_t *rw)
+{
+	long tmp, tmp2;
+
+	__asm__ __volatile__(
+"	lwz		%1,24(13)		# write_trylock\n\
+1:	lwarx		%0,0,%2\n\
+	cmpwi		0,%0,0\n\
+	bne-		2f\n\
+	stwcx.		%1,0,%2\n\
+	bne-		1b\n\
+	isync\n\
+2:"	: "=&r" (tmp), "=&r" (tmp2)
+	: "r" (&rw->lock)
+	: "cr0", "memory");
+
+	return tmp;
+}
+
+int _raw_write_trylock(rwlock_t *rw)
+{
+	return __write_trylock(rw) == 0;
+}
+
+EXPORT_SYMBOL(_raw_write_trylock);
+
+void _raw_write_lock(rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__write_trylock(rw) == 0))
+			break;
+		do {
+			HMT_low();
+			__rw_yield(rw);
+		} while (likely(rw->lock != 0));
+		HMT_medium();
+	}
+}
+
+EXPORT_SYMBOL(_raw_write_lock);
+
+#endif /* CONFIG_INLINE_SPINLOCKS */
diff -urN 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/offsets.h 2.6.6-rc3-mm2-g5/include/asm-ppc64/offsets.h
--- 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/offsets.h	2004-05-06 21:03:23.473877648 +1000
+++ 2.6.6-rc3-mm2-g5/include/asm-ppc64/offsets.h	2004-05-06 20:37:07.000000000 +1000
@@ -31,7 +31,7 @@
 #define SLBSIZE 72 /* offsetof(struct naca_struct, slb_size) */
 #define PLATFORM 24 /* offsetof(struct systemcfg, platform) */
 #define PACA_SIZE 8192 /* sizeof(struct paca_struct) */
-#define PACAPACAINDEX 24 /* offsetof(struct paca_struct, xPacaIndex) */
+#define PACAPACAINDEX 26 /* offsetof(struct paca_struct, xPacaIndex) */
 #define PACAPROCSTART 256 /* offsetof(struct paca_struct, xProcStart) */
 #define PACAKSAVE 32 /* offsetof(struct paca_struct, xKsave) */
 #define PACACURRENT 16 /* offsetof(struct paca_struct, xCurrent) */
diff -urN 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/paca.h 2.6.6-rc3-mm2-g5/include/asm-ppc64/paca.h
--- 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/paca.h	2004-05-06 18:28:24.000000000 +1000
+++ 2.6.6-rc3-mm2-g5/include/asm-ppc64/paca.h	2004-05-06 19:55:52.000000000 +1000
@@ -60,8 +60,11 @@
 	struct ItLpPaca *xLpPacaPtr;	/* Pointer to LpPaca for PLIC		0x00 */
 	struct ItLpRegSave *xLpRegSavePtr; /* Pointer to LpRegSave for PLIC	0x08 */
 	u64 xCurrent;  		        /* Pointer to current			0x10 */
-	u16 xPacaIndex;			/* Logical processor number		0x18 */
-        u16 xHwProcNum;                 /* Physical processor number            0x1A */
+	/* Note: the spinlock functions in arch/ppc64/lib/locks.c load lock_token and
+	   xPacaIndex with a single lwz instruction, using the constant offset 24.
+	   If you move either field, fix the spinlocks and rwlocks. */
+	u16 lock_token;			/* Constant 0x8000, used in spinlocks	0x18 */
+	u16 xPacaIndex;			/* Logical processor number		0x1A */
 	u32 default_decr;		/* Default decrementer value		0x1c */	
 	u64 xKsave;			/* Saved Kernel stack addr or zero	0x20 */
 	struct ItLpQueue *lpQueuePtr;	/* LpQueue handled by this processor    0x28 */
@@ -70,7 +73,8 @@
 	u8 *exception_sp;		/*                                      0x50 */
 	u8 xProcEnabled;		/*                                      0x58 */
 	u8 prof_enabled;		/* 1=iSeries profiling enabled          0x59 */
-	u8 resv1[38];			/*					0x5a-0x7f*/
+	u16 xHwProcNum;			/* Physical processor number		0x5a */
+	u8 resv1[36];			/*					0x5c */
 
 /*=====================================================================================
  * CACHE_LINE_2 0x0080 - 0x00FF
diff -urN 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/spinlock.h 2.6.6-rc3-mm2-g5/include/asm-ppc64/spinlock.h
--- 2.6.6-rc3-mm2-g5-orig/include/asm-ppc64/spinlock.h	2004-05-06 18:34:13.000000000 +1000
+++ 2.6.6-rc3-mm2-g5/include/asm-ppc64/spinlock.h	2004-05-06 21:26:33.000000000 +1000
@@ -4,7 +4,7 @@
 /*
  * Simple spin lock operations.  
  *
- * Copyright (C) 2001 Paul Mackerras <paulus@au.ibm.com>, IBM
+ * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
  * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
  *
  * Type of int is used as a full 64b word is not necessary.
@@ -14,6 +14,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <linux/config.h>
+
 typedef struct {
 	volatile unsigned int lock;
 } spinlock_t;
@@ -22,26 +24,48 @@
 #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
 
 #define spin_is_locked(x)	((x)->lock != 0)
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+static __inline__ void _raw_spin_unlock(spinlock_t *lock)
+{
+	__asm__ __volatile__("eieio	# spin_unlock": : :"memory");
+	lock->lock = 0;
+}
+
+/*
+ * Normally we use the spinlock functions in arch/ppc64/lib/locks.c.
+ * For special applications such as profiling, we can have the
+ * spinlock functions inline by defining CONFIG_INLINE_SPINLOCKS.
+ * This is not recommended on partitioned systems with shared
+ * processors, since the inline spinlock functions don't include
+ * the code for yielding the CPU to the lock holder.
+ */
+
+#ifndef CONFIG_INLINE_SPINLOCKS
+extern int _raw_spin_trylock(spinlock_t *lock);
+extern void _raw_spin_lock(spinlock_t *lock);
+extern void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags);
+extern void spin_unlock_wait(spinlock_t *lock);
+
+#else
 
 static __inline__ int _raw_spin_trylock(spinlock_t *lock)
 {
-	unsigned int tmp;
+	unsigned int tmp, tmp2;
 
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1		# spin_trylock\n\
+"1:	lwarx		%0,0,%2		# spin_trylock\n\
 	cmpwi		0,%0,0\n\
-	li		%0,0\n\
 	bne-		2f\n\
-	li		%0,1\n\
-	stwcx.		%0,0,%1\n\
+	lwz		%1,24(13)\n\
+	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
 	isync\n\
-2:"	: "=&r"(tmp)
+2:"	: "=&r"(tmp), "=&r"(tmp2)
 	: "r"(&lock->lock)
 	: "cr0", "memory");
 
-	return tmp;
+	return tmp != 0;
 }
 
 static __inline__ void _raw_spin_lock(spinlock_t *lock)
@@ -59,20 +83,51 @@
 "2:	lwarx		%0,0,%1\n\
 	cmpwi		0,%0,0\n\
 	bne-		1b\n\
-	stwcx.		%2,0,%1\n\
+	lwz		%0,24(13)\n\
+	stwcx.		%0,0,%1\n\
 	bne-		2b\n\
 	isync"
 	: "=&r"(tmp)
-	: "r"(&lock->lock), "r"(1)
+	: "r"(&lock->lock)
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_spin_unlock(spinlock_t *lock)
+/*
+ * Note: if we ever want to inline the spinlocks on iSeries,
+ * we will have to change the irq enable/disable stuff in here.
+ */
+static __inline__ void _raw_spin_lock_flags(spinlock_t *lock,
+					    unsigned long flags)
 {
-	__asm__ __volatile__("eieio	# spin_unlock": : :"memory");
-	lock->lock = 0;
+	unsigned int tmp;
+	unsigned long tmp2;
+
+	__asm__ __volatile__(
+	"b		2f		# spin_lock\n\
+1:	mfmsr		%1\n\
+	mtmsrd		%3,1\n\
+2:"	HMT_LOW
+"	lwzx		%0,0,%2\n\
+	cmpwi		0,%0,0\n\
+	bne+		2b\n"
+	HMT_MEDIUM
+"	mtmsrd		%1,1\n\
+3:	lwarx		%0,0,%2\n\
+	cmpwi		0,%0,0\n\
+	bne-		1b\n\
+	lwz		%1,24(13)\n\
+	stwcx.		%1,0,%2\n\
+	bne-		3b\n\
+	isync"
+	: "=&r"(tmp), "=&r"(tmp2)
+	: "r"(&lock->lock), "r"(flags)
+	: "cr0", "memory");
 }
 
+#define spin_unlock_wait(x)	do { cpu_relax(); } while (spin_is_locked(x))
+
+#endif /* CONFIG_INLINE_SPINLOCKS */
+
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -89,6 +144,34 @@
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x)	((x)->lock)
+
+static __inline__ int is_read_locked(rwlock_t *rw)
+{
+	return rw->lock > 0;
+}
+
+static __inline__ int is_write_locked(rwlock_t *rw)
+{
+	return rw->lock < 0;
+}
+
+static __inline__ void _raw_write_unlock(rwlock_t *rw)
+{
+	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
+	rw->lock = 0;
+}
+
+#ifndef CONFIG_INLINE_SPINLOCKS
+extern int _raw_read_trylock(rwlock_t *rw);
+extern void _raw_read_lock(rwlock_t *rw);
+extern void _raw_read_unlock(rwlock_t *rw);
+extern int _raw_write_trylock(rwlock_t *rw);
+extern void _raw_write_lock(rwlock_t *rw);
+extern void _raw_write_unlock(rwlock_t *rw);
+
+#else
 static __inline__ int _raw_read_trylock(rwlock_t *rw)
 {
 	unsigned int tmp;
@@ -193,29 +276,7 @@
 	: "r"(&rw->lock), "r"(-1)
 	: "cr0", "memory");
 }
-
-static __inline__ void _raw_write_unlock(rwlock_t *rw)
-{
-	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
-	rw->lock = 0;
-}
-
-static __inline__ int is_read_locked(rwlock_t *rw)
-{
-	return rw->lock > 0;
-}
-
-static __inline__ int is_write_locked(rwlock_t *rw)
-{
-	return rw->lock < 0;
-}
-
-#define spin_lock_init(x)      do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_unlock_wait(x)    do { cpu_relax(); } while(spin_is_locked(x))
-
-#define rwlock_init(x)         do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-#define rwlock_is_locked(x)	((x)->lock)
+#endif /* CONFIG_INLINE_SPINLOCKS */
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */

