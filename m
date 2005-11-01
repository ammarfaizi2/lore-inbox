Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVKAWxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVKAWxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKAWxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:53:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:37266 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751379AbVKAWxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:53:20 -0500
Message-ID: <4367F16C.5080003@us.ibm.com>
Date: Tue, 01 Nov 2005 16:51:24 -0600
From: tdgarcia <tdgarcia@us.ibm.com>
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: raybry@mpdtxmail.amd.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
CC: srao@us.ibm.com, wmb@us.ibm.com, tdgarcia@us.ibm.com
Subject: lockmeter port for ppc64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My team and I adapted your lockmeter code to the ppc64 architecture.  I 
am attaching the ppc64 specific code to this email.  This code should 
patch cleanly to the 2.6.13 kernel. 

diff -Narup linux-2.6.13/arch/ppc64/Kconfig.debug 
linux-2.6.13-lockmeter/arch/ppc64/Kconfig.debug
--- linux-2.6.13/arch/ppc64/Kconfig.debug    2005-08-28 
16:41:01.000000000 -0700
+++ linux-2.6.13-lockmeter/arch/ppc64/Kconfig.debug    2005-10-11 
07:40:28.000000000 -0700
@@ -19,6 +19,13 @@ config KPROBES
       for kernel debugging, non-intrusive instrumentation and testing.
       If in doubt, say "N".
 
+config LOCKMETER
+ bool "Kernel lock metering"
+ depends on SMP && !PREEMPT
+ help
+   Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+   but allows you to see various statistics using the lockstat command.
+
 config DEBUG_STACK_USAGE
     bool "Stack utilization instrumentation"
     depends on DEBUG_KERNEL
diff -Narup linux-2.6.13/arch/ppc64/lib/dec_and_lock.c 
linux-2.6.13-lockmeter/arch/ppc64/lib/dec_and_lock.c
--- linux-2.6.13/arch/ppc64/lib/dec_and_lock.c    2005-08-28 
16:41:01.000000000 -0700
+++ linux-2.6.13-lockmeter/arch/ppc64/lib/dec_and_lock.c    2005-10-10 
13:02:47.000000000 -0700
@@ -28,7 +28,13 @@
  */
 
 #ifndef ATOMIC_DEC_AND_LOCK
+
+#ifndef CONFIG_LOCKMETER
+int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+#else
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+#endif /* CONFIG_LOCKMETER */
+
 {
     int counter;
     int newcount;
@@ -51,5 +57,10 @@ int _atomic_dec_and_lock(atomic_t *atomi
     return 0;
 }
 
+#ifndef CONFIG_LOCKMETER
+EXPORT_SYMBOL(atomic_dec_and_lock);
+#else
 EXPORT_SYMBOL(_atomic_dec_and_lock);
+#endif /* CONFIG_LOCKMETER */
+
 #endif /* ATOMIC_DEC_AND_LOCK */
diff -Narup linux-2.6.13/include/asm-ppc64/lockmeter.h 
linux-2.6.13-lockmeter/include/asm-ppc64/lockmeter.h
--- linux-2.6.13/include/asm-ppc64/lockmeter.h    1969-12-31 
16:00:00.000000000 -0800
+++ linux-2.6.13-lockmeter/include/asm-ppc64/lockmeter.h    2005-10-11 
08:48:48.000000000 -0700
@@ -0,0 +1,110 @@
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
+ *  Modified by Tony Garcia (garcia1@us.ibm.com)
+ *  Ported to Power PC 64
+ */
+
+#ifndef _PPC64_LOCKMETER_H
+#define _PPC64_LOCKMETER_H
+
+
+#include <asm/spinlock.h>
+#include <linux/version.h>
+#include <linux/cpufreq.h>
+
+#include <asm/processor.h>   /* definitions for SPRN_TBRL
+                                SPRN_TBRU, mftb()  */
+extern unsigned long ppc_proc_freq;
+
+#define CPU_CYCLE_FREQUENCY ppc_proc_freq
+
+#define THIS_CPU_NUMBER    smp_processor_id()
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
+        volatile unsigned int lock; 
+        unsigned int index;
+} inst_spinlock_t;
+
+#define PUT_INDEX(lock_ptr,indexv) ((inst_spinlock_t 
*)(lock_ptr))->index = indexv
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
+        volatile signed int lock;  
+        unsigned int index;
+        unsigned int cpu;
+} inst_rwlock_t;
+
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t 
*)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t 
*)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t 
*)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)   rwlock_readers(rwlock_ptr)
+
+/* Return number of readers */
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+        signed int tmp = rwlock_ptr->lock;
+
+        if ( tmp > 0 )
+                return tmp;
+        else
+                return 0;
+}
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((signed 
int)(rwlock_ptr)->lock < 0)
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((signed 
int)(rwlock_ptr)->lock > 0 )
+
+/*Written by Carl L. to get the time base counters on ppc,
+  rplaces the Intel only call rtds*/
+static inline long get_cycles64 (void)
+{
+        unsigned long tb;
+
+        /* read the upper and lower 32 bit Time base counter */
+        tb = mfspr(SPRN_TBRU);
+        tb = (tb << 32)  | mfspr(SPRN_TBRL);
+
+        return(tb);
+}
+
+#endif /* _PPC64_LOCKMETER_H */
diff -Narup linux-2.6.13/include/asm-ppc64/spinlock.h 
linux-2.6.13-lockmeter/include/asm-ppc64/spinlock.h
--- linux-2.6.13/include/asm-ppc64/spinlock.h    2005-08-28 
16:41:01.000000000 -0700
+++ linux-2.6.13-lockmeter/include/asm-ppc64/spinlock.h    2005-10-10 
14:04:25.000000000 -0700
@@ -23,6 +23,9 @@
 
 typedef struct {
     volatile unsigned int lock;
+#ifdef CONFIG_LOCKMETER
+  unsigned int lockmeter_magic;
+#endif /* CONFIG_LOCKMETER */
 #ifdef CONFIG_PREEMPT
     unsigned int break_lock;
 #endif
@@ -30,13 +33,20 @@ typedef struct {
 
 typedef struct {
     volatile signed int lock;
+#ifdef CONFIG_LOCKMETER
+ unsigned int index;
+ unsigned int cpu;
+#endif /* CONFIG_LOCKMETER */
 #ifdef CONFIG_PREEMPT
     unsigned int break_lock;
 #endif
 } rwlock_t;
 
-#ifdef __KERNEL__
-#define SPIN_LOCK_UNLOCKED    (spinlock_t) { 0 }
+#ifdef CONFIG_LOCKMETER
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#else
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 , 0}
+#endif /* CONFIG_LOCKMETER */
 
 #define spin_is_locked(x)    ((x)->lock != 0)
 #define spin_lock_init(x)    do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
@@ -144,7 +154,7 @@ static void __inline__ _raw_spin_lock_fl
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 , 0 , 0 }
 
 #define rwlock_init(x)        do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
@@ -157,6 +167,44 @@ static __inline__ void _raw_write_unlock
     rw->lock = 0;
 }
 
+#if defined(CONFIG_LOCKMETER) && defined(CONFIG_HAVE_DEC_LOCK)
+extern void _metered_spin_lock  (spinlock_t *lock, void *caller_pc);
+extern void _metered_spin_unlock(spinlock_t *lock);
+
+/*
+ *  Matches what is in arch/ppc64/lib/dec_and_lock.c, except this one is
+ *  "static inline" so that the spin_lock(), if actually invoked, is 
charged
+ *  against the real caller, not against the catch-all atomic_dec_and_lock
+ */
+static inline int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+        int counter;
+        int newcount;
+
+        for (;;) {
+                counter = atomic_read(atomic);
+                newcount = counter - 1;
+                if (!newcount)
+                        break;    /* do it the slow way */
+
+                newcount = cmpxchg(&atomic->counter, counter, newcount);
+                if (newcount == counter)
+                        return 0;
+        }
+
+        preempt_disable();
+        _metered_spin_lock(lock, __builtin_return_address(0));
+        if (atomic_dec_and_test(atomic))
+                return 1;
+        _metered_spin_unlock(lock);
+        preempt_enable();
+
+        return 0;
+}
+
+#define ATOMIC_DEC_AND_LOCK
+#endif  /* CONFIG_LOCKMETER and CONFIG_HAVE_DEC_LOCK  */
+
 /*
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
@@ -256,5 +304,4 @@ static void __inline__ _raw_write_lock(r
     }
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
