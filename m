Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbTCMWbn>; Thu, 13 Mar 2003 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbTCMWbZ>; Thu, 13 Mar 2003 17:31:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262576AbTCMW3k>;
	Thu, 13 Mar 2003 17:29:40 -0500
Subject: [PATCH] (5/5) Remove brlock code
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595224.3139.108.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:40:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All code that uses brlock is gone, so remove header and code.

No changes from earlier version of the patch.

diff -urN -X dontdiff linux-2.5.64/include/linux/brlock.h linux-2.5-nobrlock/include/linux/brlock.h
--- linux-2.5.64/include/linux/brlock.h	2003-03-11 09:08:00.000000000 -0800
+++ linux-2.5-nobrlock/include/linux/brlock.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,222 +0,0 @@
-#ifndef __LINUX_BRLOCK_H
-#define __LINUX_BRLOCK_H
-
-/*
- * 'Big Reader' read-write spinlocks.
- *
- * super-fast read/write locks, with write-side penalty. The point
- * is to have a per-CPU read/write lock. Readers lock their CPU-local
- * readlock, writers must lock all locks to get write access. These
- * CPU-read-write locks are semantically identical to normal rwlocks.
- * Memory usage is higher as well. (NR_CPUS*L1_CACHE_BYTES bytes)
- *
- * The most important feature is that these spinlocks do not cause
- * cacheline ping-pong in the 'most readonly data' case.
- *
- * Copyright 2000, Ingo Molnar <mingo@redhat.com>
- *
- * Registry idea and naming [ crutial! :-) ] by:
- *
- *                 David S. Miller <davem@redhat.com>
- *
- * David has an implementation that doesn't use atomic operations in
- * the read branch via memory ordering tricks - i guess we need to
- * split this up into a per-arch thing? The atomicity issue is a
- * secondary item in profiles, at least on x86 platforms.
- *
- * The atomic op version overhead is indeed a big deal on
- * load-locked/store-conditional cpus (ALPHA/MIPS/PPC) and
- * compare-and-swap cpus (Sparc64).  So we control which
- * implementation to use with a __BRLOCK_USE_ATOMICS define. -DaveM
- *
- */
-
-/* Register bigreader lock indices here. */
-enum brlock_indices {
-	BR_NETPROTO_LOCK,
-	__BR_END
-};
-
-#include <linux/config.h>
-
-#ifdef CONFIG_SMP
-
-#include <linux/cache.h>
-#include <linux/spinlock.h>
-
-#if defined(__i386__) || defined(__ia64__) || defined(__x86_64__)
-#define __BRLOCK_USE_ATOMICS
-#else
-#undef __BRLOCK_USE_ATOMICS
-#endif
-
-#ifdef __BRLOCK_USE_ATOMICS
-typedef rwlock_t	brlock_read_lock_t;
-#else
-typedef unsigned int	brlock_read_lock_t;
-#endif
-
-/*
- * align last allocated index to the next cacheline:
- */
-#define __BR_IDX_MAX \
-	(((sizeof(brlock_read_lock_t)*__BR_END + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1)) / sizeof(brlock_read_lock_t))
-
-extern brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX];
-
-#ifndef __BRLOCK_USE_ATOMICS
-struct br_wrlock {
-	spinlock_t lock;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
-
-extern struct br_wrlock __br_write_locks[__BR_IDX_MAX];
-#endif
-
-extern void __br_lock_usage_bug (void);
-
-#ifdef __BRLOCK_USE_ATOMICS
-
-static inline void br_read_lock (enum brlock_indices idx)
-{
-	/*
-	 * This causes a link-time bug message if an
-	 * invalid index is used:
-	 */
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-
-	preempt_disable();
-	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
-}
-
-static inline void br_read_unlock (enum brlock_indices idx)
-{
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-
-	read_unlock(&__brlock_array[smp_processor_id()][idx]);
-}
-
-#else /* ! __BRLOCK_USE_ATOMICS */
-static inline void br_read_lock (enum brlock_indices idx)
-{
-	unsigned int *ctr;
-	spinlock_t *lock;
-
-	/*
-	 * This causes a link-time bug message if an
-	 * invalid index is used:
-	 */
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-
-	preempt_disable();
-	ctr = &__brlock_array[smp_processor_id()][idx];
-	lock = &__br_write_locks[idx].lock;
-again:
-	(*ctr)++;
-	mb();
-	if (spin_is_locked(lock)) {
-		(*ctr)--;
-		wmb(); /*
-			* The release of the ctr must become visible
-			* to the other cpus eventually thus wmb(),
-			* we don't care if spin_is_locked is reordered
-			* before the releasing of the ctr.
-			* However IMHO this wmb() is superflous even in theory.
-			* It would not be superflous only if on the
-			* other CPUs doing a ldl_l instead of an ldl
-			* would make a difference and I don't think this is
-			* the case.
-			* I'd like to clarify this issue further
-			* but for now this is a slow path so adding the
-			* wmb() will keep us on the safe side.
-			*/
-		while (spin_is_locked(lock))
-			barrier();
-		goto again;
-	}
-}
-
-static inline void br_read_unlock (enum brlock_indices idx)
-{
-	unsigned int *ctr;
-
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-
-	ctr = &__brlock_array[smp_processor_id()][idx];
-
-	wmb();
-	(*ctr)--;
-	preempt_enable();
-}
-#endif /* __BRLOCK_USE_ATOMICS */
-
-/* write path not inlined - it's rare and larger */
-
-extern void FASTCALL(__br_write_lock (enum brlock_indices idx));
-extern void FASTCALL(__br_write_unlock (enum brlock_indices idx));
-
-static inline void br_write_lock (enum brlock_indices idx)
-{
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-	__br_write_lock(idx);
-}
-
-static inline void br_write_unlock (enum brlock_indices idx)
-{
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-	__br_write_unlock(idx);
-}
-
-#else
-# define br_read_lock(idx)	({ (void)(idx); preempt_disable(); })
-# define br_read_unlock(idx)	({ (void)(idx); preempt_enable(); })
-# define br_write_lock(idx)	({ (void)(idx); preempt_disable(); })
-# define br_write_unlock(idx)	({ (void)(idx); preempt_enable(); })
-#endif	/* CONFIG_SMP */
-
-/*
- * Now enumerate all of the possible sw/hw IRQ protected
- * versions of the interfaces.
- */
-#define br_read_lock_irqsave(idx, flags) \
-	do { local_irq_save(flags); br_read_lock(idx); } while (0)
-
-#define br_read_lock_irq(idx) \
-	do { local_irq_disable(); br_read_lock(idx); } while (0)
-
-#define br_read_lock_bh(idx) \
-	do { local_bh_disable(); br_read_lock(idx); } while (0)
-
-#define br_write_lock_irqsave(idx, flags) \
-	do { local_irq_save(flags); br_write_lock(idx); } while (0)
-
-#define br_write_lock_irq(idx) \
-	do { local_irq_disable(); br_write_lock(idx); } while (0)
-
-#define br_write_lock_bh(idx) \
-	do { local_bh_disable(); br_write_lock(idx); } while (0)
-
-#define br_read_unlock_irqrestore(idx, flags) \
-	do { br_read_unlock(irx); local_irq_restore(flags); } while (0)
-
-#define br_read_unlock_irq(idx) \
-	do { br_read_unlock(idx); local_irq_enable(); } while (0)
-
-#define br_read_unlock_bh(idx) \
-	do { br_read_unlock(idx); local_bh_enable(); } while (0)
-
-#define br_write_unlock_irqrestore(idx, flags) \
-	do { br_write_unlock(irx); local_irq_restore(flags); } while (0)
-
-#define br_write_unlock_irq(idx) \
-	do { br_write_unlock(idx); local_irq_enable(); } while (0)
-
-#define br_write_unlock_bh(idx) \
-	do { br_write_unlock(idx); local_bh_enable(); } while (0)
-
-#endif /* __LINUX_BRLOCK_H */
diff -urN -X dontdiff linux-2.5.64/kernel/ksyms.c linux-2.5-nobrlock/kernel/ksyms.c
--- linux-2.5.64/kernel/ksyms.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/kernel/ksyms.c	2003-03-12 14:52:35.000000000 -0800
@@ -40,7 +40,6 @@
 #include <linux/mm.h>
 #include <linux/capability.h>
 #include <linux/highuid.h>
-#include <linux/brlock.h>
 #include <linux/fs.h>
 #include <linux/uio.h>
 #include <linux/tty.h>
@@ -433,17 +432,6 @@
 #endif
 EXPORT_SYMBOL(mod_timer);
 
-#ifdef CONFIG_SMP
-
-/* Big-Reader lock implementation */
-EXPORT_SYMBOL(__brlock_array);
-#ifndef __BRLOCK_USE_ATOMICS
-EXPORT_SYMBOL(__br_write_locks);
-#endif
-EXPORT_SYMBOL(__br_write_lock);
-EXPORT_SYMBOL(__br_write_unlock);
-#endif
-
 #ifdef HAVE_DISABLE_HLT
 EXPORT_SYMBOL(disable_hlt);
 EXPORT_SYMBOL(enable_hlt);
diff -urN -X dontdiff linux-2.5.64/lib/brlock.c linux-2.5-nobrlock/lib/brlock.c
--- linux-2.5.64/lib/brlock.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/lib/brlock.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,72 +0,0 @@
-/*
- *
- * linux/lib/brlock.c
- *
- * 'Big Reader' read-write spinlocks.  See linux/brlock.h for details.
- *
- * Copyright 2000, Ingo Molnar <mingo@redhat.com>
- * Copyright 2000, David S. Miller <davem@redhat.com>
- */
-
-#include <linux/config.h>
-
-#ifdef CONFIG_SMP
-
-#include <linux/sched.h>
-#include <linux/brlock.h>
-
-#ifdef __BRLOCK_USE_ATOMICS
-
-brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
-   { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = RW_LOCK_UNLOCKED } };
-
-void __br_write_lock (enum brlock_indices idx)
-{
-	int i;
-
-	preempt_disable();
-	for (i = 0; i < NR_CPUS; i++)
-		_raw_write_lock(&__brlock_array[i][idx]);
-}
-
-void __br_write_unlock (enum brlock_indices idx)
-{
-	int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		_raw_write_unlock(&__brlock_array[i][idx]);
-	preempt_enable();
-}
-
-#else /* ! __BRLOCK_USE_ATOMICS */
-
-brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
-   { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = 0 } };
-
-struct br_wrlock __br_write_locks[__BR_IDX_MAX] =
-   { [0 ... __BR_IDX_MAX-1] = { SPIN_LOCK_UNLOCKED } };
-
-void __br_write_lock (enum brlock_indices idx)
-{
-	int i;
-
-	preempt_disable();
-again:
-	_raw_spin_lock(&__br_write_locks[idx].lock);
-	for (i = 0; i < NR_CPUS; i++)
-		if (__brlock_array[i][idx] != 0) {
-			_raw_spin_unlock(&__br_write_locks[idx].lock);
-			barrier();
-			cpu_relax();
-			goto again;
-		}
-}
-
-void __br_write_unlock (enum brlock_indices idx)
-{
-	spin_unlock(&__br_write_locks[idx].lock);
-}
-
-#endif /* __BRLOCK_USE_ATOMICS */
-
-#endif /* CONFIG_SMP */
diff -urN -X dontdiff linux-2.5.64/lib/Makefile linux-2.5-nobrlock/lib/Makefile
--- linux-2.5.64/lib/Makefile	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/lib/Makefile	2003-03-12 14:52:37.000000000 -0800
@@ -8,7 +8,7 @@
 
 L_TARGET := lib.a
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
+obj-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o idr.o
 



