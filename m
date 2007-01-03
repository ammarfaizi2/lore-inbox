Return-Path: <linux-kernel-owner+w=401wt.eu-S1754926AbXACH7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbXACH7r (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbXACH7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:59:47 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:39654 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbXACH7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:59:46 -0500
Date: Tue, 2 Jan 2007 23:59:23 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [rfc] [patch 1/2] spin_lock_irq: Enable interrupts while spinning -- preperatory patch
Message-ID: <20070103075923.GA3789@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be  no good reason for spin_lock_irq to disable interrupts 
while spinning.  Zwane Mwaikambo had an implementation couple of years  ago, 
and the only objection seemed to be concerns about buggy code using
spin_lock_irq whilst interrupts disabled
http://lkml.org/lkml/2004/5/26/87
That shouldn't be a concern anymore. Besides, spin_lock_irqsave now enables
interrupts while spinning.

As to the motivation, on a Sun x4600 8 socket 16 core x86_64 NUMA box, 
we notice softlockups and quite a few lost timer ticks under extreme 
memory pressure.  The reason turned out to be that zone->lru_lock tends 
to get heavily contended, and NUMA nodes try to grab the locks using 
spin_lock_irq.  Instrumentation showed us that interrupt hold offs can
last for a few seconds, and even the main timer interrupts get held off for
long -- which is not good. Enabling interrupts for spinlocks while spinning
made the machine responsive and the softlockups/lost ticks went away.

Although the scenario above was an extreme condition (very high memory
pressure), I guess it still makes sense to enable interrupts while spinning
for a lock.

The following patches do just that. The first patch is preparatory in nature
and the second one changes the  x86_64 implementation of spin_lock_irq.
Patch passed overnight runs of kernbench and dbench on 4 way x86_64 smp.

Comments?

Thanks,
Kiran


Preparatory patch to enable interrupts while spinning with spinlock irqs.
Any arch which needs this feature just has to implement __raw_spin_lock_irq

Signed-off by: Pravin B. Shelar <pravin.shelar@calsoftinc.com>
Signed-off by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.20-rc1/include/asm-alpha/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-alpha/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-alpha/spinlock.h	2006-12-28 17:18:32.132775000 -0800
@@ -13,6 +13,7 @@
  */
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_is_locked(x)	((x)->lock != 0)
 #define __raw_spin_unlock_wait(x) \
 		do { cpu_relax(); } while ((x)->lock)
Index: linux-2.6.20-rc1/include/asm-arm/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-arm/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-arm/spinlock.h	2006-12-28 17:18:32.132775000 -0800
@@ -22,6 +22,7 @@
 	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock, flags) __raw_spin_lock(lock)
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
Index: linux-2.6.20-rc1/include/asm-cris/arch-v32/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-cris/arch-v32/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-cris/arch-v32/spinlock.h	2006-12-29 16:36:27.182954000 -0800
@@ -36,7 +36,7 @@ static inline void _raw_spin_lock_flags 
 {
   _raw_spin_lock(lock);
 }
-
+#define __raw_spin_lock_irq(lock) _raw_spin_lock(lock)
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
Index: linux-2.6.20-rc1/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-i386/spinlock.h	2006-12-21 14:34:33.871573917 -0800
+++ linux-2.6.20-rc1/include/asm-i386/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -82,6 +82,7 @@ static inline void __raw_spin_lock_flags
 	 	  CLI_STI_INPUT_ARGS
 		: "memory" CLI_STI_CLOBBERS);
 }
+# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
Index: linux-2.6.20-rc1/include/asm-ia64/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-ia64/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-ia64/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -87,7 +87,7 @@ __raw_spin_lock_flags (raw_spinlock_t *l
 }
 
 #define __raw_spin_lock(lock) __raw_spin_lock_flags(lock, 0)
-
+# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 /* Unlock by doing an ordered store and releasing the cacheline with nta */
 static inline void __raw_spin_unlock(raw_spinlock_t *x) {
 	barrier();
@@ -96,6 +96,7 @@ static inline void __raw_spin_unlock(raw
 
 #else /* !ASM_SUPPORTED */
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 # define __raw_spin_lock(x)								\
 do {											\
 	__u32 *ia64_spinlock_ptr = (__u32 *) (x);					\
Index: linux-2.6.20-rc1/include/asm-m32r/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-m32r/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-m32r/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -26,6 +26,7 @@
 
 #define __raw_spin_is_locked(x)		(*(volatile int *)(&(x)->slock) <= 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(x) \
 		do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
Index: linux-2.6.20-rc1/include/asm-mips/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-mips/spinlock.h	2006-12-21 14:34:34.641585532 -0800
+++ linux-2.6.20-rc1/include/asm-mips/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -18,6 +18,7 @@
 
 #define __raw_spin_is_locked(x)       ((x)->lock != 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(x) \
 	do { cpu_relax(); } while ((x)->lock)
 
Index: linux-2.6.20-rc1/include/asm-parisc/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-parisc/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-parisc/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -12,6 +12,7 @@ static inline int __raw_spin_is_locked(r
 }
 
 #define __raw_spin_lock(lock) __raw_spin_lock_flags(lock, 0)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(x) \
 		do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
Index: linux-2.6.20-rc1/include/asm-powerpc/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-powerpc/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-powerpc/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -138,6 +138,8 @@ static void __inline__ __raw_spin_lock_f
 	}
 }
 
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
+
 static __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	SYNC_IO;
Index: linux-2.6.20-rc1/include/asm-ppc/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-ppc/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-ppc/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -13,6 +13,7 @@
 #define __raw_spin_unlock_wait(lock) \
 	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
Index: linux-2.6.20-rc1/include/asm-s390/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-s390/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-s390/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -54,6 +54,7 @@ _raw_compare_and_swap(volatile unsigned 
 
 #define __raw_spin_is_locked(x) ((x)->owner_cpu != 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(lock) \
 	do { while (__raw_spin_is_locked(lock)) \
 		 _raw_spin_relax(lock); } while (0)
Index: linux-2.6.20-rc1/include/asm-sh/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-sh/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-sh/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -18,6 +18,7 @@
 
 #define __raw_spin_is_locked(x)	((x)->lock != 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(x) \
 	do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
Index: linux-2.6.20-rc1/include/asm-sparc/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-sparc/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-sparc/spinlock.h	2006-12-28 17:19:24.432775000 -0800
@@ -179,6 +179,7 @@ static inline int __read_trylock(raw_rwl
 #define __raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 
 #define _raw_spin_relax(lock)	cpu_relax()
 #define _raw_read_relax(lock)	cpu_relax()
Index: linux-2.6.20-rc1/include/asm-sparc64/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-sparc64/spinlock.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/include/asm-sparc64/spinlock.h	2006-12-28 17:18:32.142775000 -0800
@@ -103,6 +103,8 @@ static inline void __raw_spin_lock_flags
 	: "memory");
 }
 
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
+
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
 static void inline __read_lock(raw_rwlock_t *lock)
Index: linux-2.6.20-rc1/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-x86_64/spinlock.h	2006-12-21 14:34:36.071607104 -0800
+++ linux-2.6.20-rc1/include/asm-x86_64/spinlock.h	2006-12-29 14:17:37.962954000 -0800
@@ -63,6 +63,7 @@ static inline void __raw_spin_lock_flags
 		"5:\n\t"
 		: "+m" (lock->slock) : "r" ((unsigned)flags) : "memory");
 }
+#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
Index: linux-2.6.20-rc1/include/linux/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/spinlock.h	2006-12-21 14:34:37.241624753 -0800
+++ linux-2.6.20-rc1/include/linux/spinlock.h	2006-12-29 13:54:11.142954000 -0800
@@ -138,6 +138,7 @@ do {								\
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void _raw_spin_lock(spinlock_t *lock);
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define _raw_spin_lock_irq(lock) _raw_spin_lock(lock)
  extern int _raw_spin_trylock(spinlock_t *lock);
  extern void _raw_spin_unlock(spinlock_t *lock);
  extern void _raw_read_lock(rwlock_t *lock);
@@ -148,6 +149,7 @@ do {								\
  extern void _raw_write_unlock(rwlock_t *lock);
 #else
 # define _raw_spin_lock(lock)		__raw_spin_lock(&(lock)->raw_lock)
+# define _raw_spin_lock_irq(lock) 	__raw_spin_lock_irq(&(lock)->raw_lock)
 # define _raw_spin_lock_flags(lock, flags) \
 		__raw_spin_lock_flags(&(lock)->raw_lock, *(flags))
 # define _raw_spin_trylock(lock)	__raw_spin_trylock(&(lock)->raw_lock)
Index: linux-2.6.20-rc1/kernel/spinlock.c
===================================================================
--- linux-2.6.20-rc1.orig/kernel/spinlock.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc1/kernel/spinlock.c	2006-12-28 17:18:32.142775000 -0800
@@ -102,7 +102,11 @@ void __lockfunc _spin_lock_irq(spinlock_
 	local_irq_disable();
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	_raw_spin_lock(lock);
+#ifdef CONFIG_PROVE_LOCKING
+        _raw_spin_lock(lock);
+#else
+        _raw_spin_lock_irq(lock);
+#endif
 }
 EXPORT_SYMBOL(_spin_lock_irq);
 
