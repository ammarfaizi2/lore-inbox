Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUHVOGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUHVOGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUHVOGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:06:52 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:34012 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S267212AbUHVOGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:06:41 -0400
Subject: [PATCH] lockmeter for x86_64
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093183598.806.9.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 16:06:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a cut and paste from i386 code.
At some places however some unresolved addresses at places
like [0x1000211eb38] shows up, which is a bit weird. I'm hoping
for a comment from any of the SGI guys, as the code is so similar
to i386 I don't know if problem lies below or in the generic code.

Against 2.6.8.1-mm2, but should apply against just about any -mm

--- linux-2.6.7/arch/x86_64/lib/dec_and_lock.c_orig	2004-08-20 11:52:46.000000000 +0200
+++ linux-2.6.7/arch/x86_64/lib/dec_and_lock.c	2004-08-20 11:54:34.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
+#ifndef ATOMIC_DEC_AND_LOCK
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -38,3 +39,4 @@ slow_path:
 	spin_unlock(lock);
 	return 0;
 }
+#endif
--- /dev/null	2004-07-29 01:26:32.000000000 +0200
+++ linux-2.6.7/include/asm-x86_64/lockmeter.h	2004-08-20 18:17:17.000000000 +0200
@@ -0,0 +1,102 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Ray Bryant (raybry@us.ibm.com)
+ *  Changes Copyright (C) 2000 IBM, Inc.
+ *  Added save of index in spinlock_t to improve efficiency
+ *  of "hold" time reporting for spinlocks.
+ *  Added support for hold time statistics for read and write
+ *  locks.
+ *  Moved machine dependent code here from include/lockmeter.h.
+ *
+ */
+
+#ifndef _X8664_LOCKMETER_H
+#define _X8664_LOCKMETER_H
+
+#include <asm/spinlock.h>
+#include <asm/rwlock.h>
+
+#include <linux/version.h>
+
+#ifdef __KERNEL__
+extern unsigned int cpu_khz;
+#define CPU_CYCLE_FREQUENCY	(cpu_khz * 1000)
+#else
+#define CPU_CYCLE_FREQUENCY	450000000
+#endif
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+/*
+ * macros to cache and retrieve an index value inside of a spin lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.  Not normally a problem!!
+ * we also assume that the hash table has less than 65535 entries.
+ */
+/*
+ * instrumented spinlock structure -- never used to allocate storage
+ * only used in macros below to overlay a spinlock_t
+ */
+typedef struct inst_spinlock_s {
+	/* remember, Intel is little endian */
+	unsigned short lock;
+	unsigned short index;
+} inst_spinlock_t;
+#define PUT_INDEX(lock_ptr,indexv) ((inst_spinlock_t *)(lock_ptr))->index = indexv
+#define GET_INDEX(lock_ptr)        ((inst_spinlock_t *)(lock_ptr))->index
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int lock;
+	unsigned short index;
+	unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)   rwlock_readers(rwlock_ptr)
+
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	int tmp = (int) rwlock_ptr->lock;
+	/* read and write lock attempts may cause the lock value to temporarily */
+	/* be negative.  Until it is >= 0 we know nothing (i. e. can't tell if  */
+	/* is -1 because it was write locked and somebody tried to read lock it */
+	/* or if it is -1 because it was read locked and somebody tried to write*/
+	/* lock it. ........................................................... */
+	do {
+		tmp = (int) rwlock_ptr->lock;
+	} while (tmp < 0);
+	if (tmp == 0) return(0);
+	else return(RW_LOCK_BIAS-tmp);
+}
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((rwlock_ptr)->lock <= 0)
+#define IABS(x) ((x) > 0 ? (x) : -(x))
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((IABS((rwlock_ptr)->lock) % RW_LOCK_BIAS) != 0)
+
+#define get_cycles64()	get_cycles()
+				   
+#endif /* _X8664_LOCKMETER_H */
--- linux-2.6.7/arch/x86_64/Kconfig.debug_orig	2004-08-20 11:49:21.000000000 +0200
+++ linux-2.6.7/arch/x86_64/Kconfig.debug	2004-08-20 12:04:58.000000000 +0200
@@ -62,6 +62,13 @@ config IOMMU_LEAK
          Add a simple leak tracer to the IOMMU code. This is useful when you
 	 are debugging a buggy device driver that leaks IOMMU mappings.
 
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on SMP
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
 source "arch/x86_64/Kconfig.kgdb"
 
 endmenu
--- linux-2.6.7/include/asm-x86_64/spinlock.h_orig	2004-08-20 11:58:19.000000000 +0200
+++ linux-2.6.7/include/asm-x86_64/spinlock.h	2004-08-20 16:42:45.000000000 +0200
@@ -168,6 +168,11 @@ here:
  */
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* and we need this storage for CPU and lock INDEX        */
+	unsigned lockmeter_magic;
+#endif
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -175,11 +180,19 @@ typedef struct {
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
+#ifdef CONFIG_LOCKMETER
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_MAGIC_INIT	, 0, RWLOCK_MAGIC
+#else
+#define RWLOCK_MAGIC_INIT	, 0
+#endif
+#else /* !CONFIG_LOCKMETER */
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
 #endif
+#endif /* !CONFIG_LOCKMETER */
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
@@ -226,4 +239,60 @@ static inline int _raw_write_trylock(rwl
 	return 0;
 }
 
+#ifdef CONFIG_LOCKMETER
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+/* FIXME -- replace with assembler */
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (count->counter > 0)
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_LOCKMETER) && defined(CONFIG_HAVE_DEC_LOCK)
+extern void _metered_spin_lock  (spinlock_t *lock);
+extern void _metered_spin_unlock(spinlock_t *lock);
+
+/*
+ *  Matches what is in arch/x86_64/lib/dec_and_lock.c, except this one is
+ *  "static inline" so that the spin_lock(), if actually invoked, is charged
+ *  against the real caller, not against the catch-all atomic_dec_and_lock
+ */
+static inline int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	int counter;
+	int newcount;
+
+repeat:
+	counter = atomic_read(atomic);
+	newcount = counter-1;
+
+	if (!newcount)
+		goto slow_path;
+
+	asm volatile("lock; cmpxchgl %1,%2"
+		:"=a" (newcount)
+		:"r" (newcount), "m" (atomic->counter), "0" (counter));
+
+	/* If the above failed, "eax" will have changed */
+	if (newcount != counter)
+		goto repeat;
+	return 0;
+
+slow_path:
+	preempt_disable();
+	_metered_spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	_metered_spin_unlock(lock);
+	preempt_enable();
+	return 0;
+}
+
+#define ATOMIC_DEC_AND_LOCK
+#endif
+
 #endif /* __ASM_SPINLOCK_H */


