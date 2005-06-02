Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFBOn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFBOn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFBOn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:43:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15063 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261155AbVFBOkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:40:46 -0400
Date: Thu, 2 Jun 2005 16:40:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: [rfc] [patch] consolidate/clean up spinlock.h files
Message-ID: <20050602144004.GA31807@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (written by me and also containing many suggestions 
of Arjan van de Ven) does a major cleanup of the spinlock code. It does 
the following things:

 - consolidates and enhances the spinlock/rwlock debugging code

 - simplifies the asm/spinlock.h files

 - encapsulates the raw spinlock types and moves generic spinlock
   features (such as ->break_lock) into the generic code.

 - cleans up the spinlock code hierarchy to get rid of spaghetti.

most notably there's now only a single variant of the debugging code, 
located in lib/spinlock_debug.c. (previously we had one SMP debugging 
variant per architecture, plus a separate generic one for UP builds)

also, i've enhanced the rwlock debugging facility, it will now track 
write-owners. There is new spinlock-owner/CPU-tracking on SMP builds 
too.

the arch-level include files now only contain the minimally necessary 
subset of the spinlock code - all the rest that can be generalized now 
lives in the generic headers:

 include/asm-i386/spinlock.h             |  116 +----
 include/asm-i386/spinlock_types.h       |   16
 include/asm-x86_64/spinlock.h           |  146 +------
 include/asm-x86_64/spinlock_types.h     |   16

i've also split up the various spinlock variants into separate files, 
making it easier to see which does what. The new layout is:

 ***********
 * here's the role of the various spinlock/rwlock related include files:
 *
 * on SMP builds:
 *
 *  asm/spinlock_type.h:  contains the raw_spinlock_t/raw_rwlock_t and the
 *                        UNLOCKED initializers
 *
 *  asm/spinlock.h:       contains the __raw_spin_*()/etc. lowlevel
 *                        implementations, mostly inline assembly code
 *
 *   (also included on UP-debug builds:)
 *
 *  linux/spinlock_smp.h: contains the prototypes for the _spin_*() APIs.
 *
 *  linux/spinlock.h:     builds the final spin_*() APIs.
 *
 * on UP builds:
 *
 *  asm-generic/spinlock_type_up.h:
 *                        contains the generic, simplified UP spinlock type.
 *                        (which is an empty structure on non-debug builds)
 *
 *  asm-generic/spinlock_up.h:
 *                        contains the __raw_spin_*()/etc. version of UP
 *                        builds. (which are NOPs on non-debug, non-preempt
 *                        builds)
 *
 *   (included on UP-non-debug builds:)
 *
 *  linux/spinlock_up.h:  builds the _spin_*() APIs.
 *
 *  linux/spinlock.h:     builds the final spin_*() APIs.
 ***********

i've converted x86 and x64 for the time being (and have build/boot 
tested all spinlock variants on them), but if there's rough agreement 
about the details i'll convert every SMP architecture. (all UP 
architectures should work fine already)

there's a source-code size increase for now, mostly due to the extra 
debugging functionality and due to extra comments. Once every SMP 
architecture is converted there should be a net minus of a couple of 
hundred lines of code.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjanv@infradead.org>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -1329,6 +1329,10 @@ static inline void finish_task_switch(ta
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
 	prev_task_flags = prev->flags;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	/* this is a valid case when another task releases the spinlock */
+	rq->lock.owner_pid = current->pid;
+#endif
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
--- linux/kernel/Makefile.orig
+++ linux/kernel/Makefile
@@ -12,6 +12,7 @@ obj-y     = sched.o fork.o exec_domain.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
+obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
--- linux/kernel/spinlock.c.orig
+++ linux/kernel/spinlock.c
@@ -3,7 +3,10 @@
  *
  * Author: Zwane Mwaikambo <zwane@fsmlabs.com>
  *
- * Copyright (2004) Ingo Molnar
+ * Copyright (2004, 2005) Ingo Molnar
+ *
+ * This file contains the spinlock/rwlock implementations for the
+ * SMP and the DEBUG_SPINLOCK cases. (UP-nondebug inlines them)
  */
 
 #include <linux/config.h>
@@ -57,7 +60,7 @@ int __lockfunc _write_trylock(rwlock_t *
 }
 EXPORT_SYMBOL(_write_trylock);
 
-#ifndef CONFIG_PREEMPT
+#if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
@@ -72,7 +75,7 @@ unsigned long __lockfunc _spin_lock_irqs
 
 	local_irq_save(flags);
 	preempt_disable();
-	_raw_spin_lock_flags(lock, flags);
+	_raw_spin_lock_flags(lock, &flags);
 	return flags;
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
--- linux/include/asm-generic/spinlock_types_up.h.orig
+++ linux/include/asm-generic/spinlock_types_up.h
@@ -0,0 +1,29 @@
+#ifndef __ASM_GENERIC_SPINLOCK_TYPES_UP_H
+#define __ASM_GENERIC_SPINLOCK_TYPES_UP_H
+
+/*
+ * include/linux/spinlock_types_up.h - spinlock type definitions for UP:
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+typedef struct {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	volatile unsigned int slock;
+#endif
+} raw_spinlock_t;
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define __RAW_SPIN_LOCK_UNLOCKED { 1 }
+#else
+# define __RAW_SPIN_LOCK_UNLOCKED { }
+#endif
+
+typedef struct {
+	/* no debug version on UP */
+} raw_rwlock_t;
+
+#define __RAW_RWLOCK_UNLOCKED { }
+
+#endif
--- linux/include/asm-generic/spinlock_up.h.orig
+++ linux/include/asm-generic/spinlock_up.h
@@ -0,0 +1,68 @@
+#ifndef __ASM_GENERIC_SPINLOCK_UP_H
+#define __ASM_GENERIC_SPINLOCK_UP_H
+
+/*
+ * include/linux/spinlock_up.h - UP-debug version of spinlocks.
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ *
+ * 1 means unlocked, 0 means locked. (the values are inverted, to catch
+ * initialization bugs)
+ *
+ * No atomicity anywhere, we are on UP.
+ */
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+#define __raw_spin_is_locked(x)		((x)->slock == 0)
+
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+{
+	char oldval = lock->slock;
+
+	lock->slock = 0;
+
+	return oldval > 0;
+}
+
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
+{
+	lock->slock = 0;
+}
+
+static inline void
+__raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
+{
+	local_irq_save(flags);
+	lock->slock = 0;
+}
+
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
+{
+	lock->slock = 1;
+}
+
+#else
+# define __raw_spin_is_locked(lock)	((void)(lock), 0)
+# define __raw_spin_lock(lock)		do { (void)(lock); } while (0)
+# define __raw_spin_lock_flags(lock, flags) \
+				do { (void)(lock), (void)(flags); } while (0)
+# define __raw_spin_unlock(lock)	do { (void)(lock); } while (0)
+# define __raw_spin_trylock(lock)	({ (void)(lock); (1); })
+#endif
+
+/*
+ * Read-write spinlocks. No debug version.
+ */
+#define __RAW_RW_LOCK_UNLOCKED		{ }
+#define __raw_read_lock(lock)		do { (void)(lock); } while(0)
+#define __raw_read_unlock(lock)		do { (void)(lock); } while(0)
+#define __raw_write_lock(lock)		do { (void)(lock); } while(0)
+#define __raw_write_unlock(lock)	do { (void)(lock); } while(0)
+#define __raw_read_can_lock(lock)	(((void)(lock), 1))
+#define __raw_write_can_lock(lock)	(((void)(lock), 1))
+#define __raw_read_trylock(lock)	({ (void)(lock); (1); })
+#define __raw_write_trylock(lock)	({ (void)(lock); (1); })
+
+#endif /* __ASM_GENERIC_SPINLOCK_UP_H */
--- linux/include/linux/jbd.h.orig
+++ linux/include/linux/jbd.h
@@ -29,6 +29,7 @@
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
 #include <asm/semaphore.h>
+#include <linux/bit_spinlock.h>
 #endif
 
 #define journal_oom_retry 1
--- linux/include/linux/spinlock_smp.h.orig
+++ linux/include/linux/spinlock_smp.h
@@ -0,0 +1,51 @@
+#ifndef __LINUX_SPINLOCK_SMP_H
+#define __LINUX_SPINLOCK_SMP_H
+
+/*
+ * include/linux/spinlock_smp.h - SMP (and UP-debug) version of spinlocks.
+ * (the functions are implemented in kernel/spinlock.c)
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+#define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
+
+int __lockfunc _spin_trylock(spinlock_t *lock);
+int __lockfunc _read_trylock(rwlock_t *lock);
+int __lockfunc _write_trylock(rwlock_t *lock);
+
+void __lockfunc _spin_lock(spinlock_t *lock)	__acquires(spinlock_t);
+void __lockfunc _read_lock(rwlock_t *lock)	__acquires(rwlock_t);
+void __lockfunc _write_lock(rwlock_t *lock)	__acquires(rwlock_t);
+
+void __lockfunc _spin_unlock(spinlock_t *lock)	__releases(spinlock_t);
+void __lockfunc _read_unlock(rwlock_t *lock)	__releases(rwlock_t);
+void __lockfunc _write_unlock(rwlock_t *lock)	__releases(rwlock_t);
+
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)	__acquires(spinlock_t);
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
+
+void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(spinlock_t);
+void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
+void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
+
+void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)	__releases(spinlock_t);
+void __lockfunc _spin_unlock_irq(spinlock_t *lock)				__releases(spinlock_t);
+void __lockfunc _spin_unlock_bh(spinlock_t *lock)				__releases(spinlock_t);
+void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
+void __lockfunc _read_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
+void __lockfunc _read_unlock_bh(rwlock_t *lock)					__releases(rwlock_t);
+void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
+void __lockfunc _write_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
+void __lockfunc _write_unlock_bh(rwlock_t *lock)				__releases(rwlock_t);
+
+int __lockfunc _spin_trylock_bh(spinlock_t *lock);
+int __lockfunc generic_raw_read_trylock(rwlock_t *lock);
+int in_lock_functions(unsigned long addr);
+
+#endif /* __LINUX_SPINLOCK_SMP_H */
--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -2,7 +2,40 @@
 #define __LINUX_SPINLOCK_H
 
 /*
- * include/linux/spinlock.h - generic locking declarations
+ * include/linux/spinlock.h - generic spinlock/rwlock declarations
+ *
+ * here's the role of the various spinlock/rwlock related include files:
+ *
+ * on SMP builds:
+ *
+ *  asm/spinlock_type.h:  contains the raw_spinlock_t/raw_rwlock_t and the
+ *                        UNLOCKED initializers
+ *
+ *  asm/spinlock.h:       contains the __raw_spin_*()/etc. lowlevel
+ *                        implementations, mostly inline assembly code
+ *
+ *   (also included on UP-debug builds:)
+ *
+ *  linux/spinlock_smp.h: contains the prototypes for the _spin_*() APIs.
+ *
+ *  linux/spinlock.h:     builds the final spin_*() APIs.
+ *
+ * on UP builds:
+ *
+ *  asm-generic/spinlock_type_up.h:
+ *                        contains the generic, simplified UP spinlock type.
+ *                        (which is an empty structure on non-debug builds)
+ *
+ *  asm-generic/spinlock_up.h:
+ *                        contains the __raw_spin_*()/etc. version of UP
+ *                        builds. (which are NOPs on non-debug, non-preempt
+ *                        builds)
+ *
+ *   (included on UP-non-debug builds:)
+ *
+ *  linux/spinlock_up.h:  builds the _spin_*() APIs.
+ *
+ *  linux/spinlock.h:     builds the final spin_*() APIs.
  */
 
 #include <linux/config.h>
@@ -13,7 +46,6 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
-#include <asm/processor.h>	/* for cpu relax */
 #include <asm/system.h>
 
 /*
@@ -35,423 +67,123 @@
 #define __lockfunc fastcall __attribute__((section(".spinlock.text")))
 
 /*
- * If CONFIG_SMP is set, pull in the _raw_* definitions
+ * Pull the raw_spinlock_t and raw_rwlock_t definitions:
  */
-#ifdef CONFIG_SMP
-
-#define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
-#include <asm/spinlock.h>
-
-int __lockfunc _spin_trylock(spinlock_t *lock);
-int __lockfunc _read_trylock(rwlock_t *lock);
-int __lockfunc _write_trylock(rwlock_t *lock);
-
-void __lockfunc _spin_lock(spinlock_t *lock)	__acquires(spinlock_t);
-void __lockfunc _read_lock(rwlock_t *lock)	__acquires(rwlock_t);
-void __lockfunc _write_lock(rwlock_t *lock)	__acquires(rwlock_t);
-
-void __lockfunc _spin_unlock(spinlock_t *lock)	__releases(spinlock_t);
-void __lockfunc _read_unlock(rwlock_t *lock)	__releases(rwlock_t);
-void __lockfunc _write_unlock(rwlock_t *lock)	__releases(rwlock_t);
-
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)	__acquires(spinlock_t);
-unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
-unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
-
-void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(spinlock_t);
-void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
-void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-
-void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)	__releases(spinlock_t);
-void __lockfunc _spin_unlock_irq(spinlock_t *lock)				__releases(spinlock_t);
-void __lockfunc _spin_unlock_bh(spinlock_t *lock)				__releases(spinlock_t);
-void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
-void __lockfunc _read_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
-void __lockfunc _read_unlock_bh(rwlock_t *lock)					__releases(rwlock_t);
-void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
-void __lockfunc _write_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
-void __lockfunc _write_unlock_bh(rwlock_t *lock)				__releases(rwlock_t);
-
-int __lockfunc _spin_trylock_bh(spinlock_t *lock);
-int __lockfunc generic_raw_read_trylock(rwlock_t *lock);
-int in_lock_functions(unsigned long addr);
-
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
 #else
-
-#define in_lock_functions(ADDR) 0
-
-#if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
-# define _atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
-# define ATOMIC_DEC_AND_LOCK
+# include <asm-generic/spinlock_types_up.h>
 #endif
 
-#ifdef CONFIG_DEBUG_SPINLOCK
- 
-#define SPINLOCK_MAGIC	0x1D244B3C
 typedef struct {
-	unsigned long magic;
-	volatile unsigned long lock;
-	volatile unsigned int babble;
-	const char *module;
-	char *owner;
-	int oline;
+	raw_spinlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_pid, owner_cpu;
+#endif
 } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
 
-#define spin_lock_init(x) \
-	do { \
-		(x)->magic = SPINLOCK_MAGIC; \
-		(x)->lock = 0; \
-		(x)->babble = 5; \
-		(x)->module = __FILE__; \
-		(x)->owner = NULL; \
-		(x)->oline = 0; \
-	} while (0)
-
-#define CHECK_LOCK(x) \
-	do { \
-	 	if ((x)->magic != SPINLOCK_MAGIC) { \
-			printk(KERN_ERR "%s:%d: spin_is_locked on uninitialized spinlock %p.\n", \
-					__FILE__, __LINE__, (x)); \
-		} \
-	} while(0)
-
-#define _raw_spin_lock(x)		\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-	} while (0)
-
-/* without debugging, spin_is_locked on UP always says
- * FALSE. --> printk if already locked. */
-#define spin_is_locked(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		0; \
-	})
-
-/* with debugging, assert_spin_locked() on UP does check
- * the lock value properly */
-#define assert_spin_locked(x) \
-	({ \
-		CHECK_LOCK(x); \
-		BUG_ON(!(x)->lock); \
-	})
-
-/* without debugging, spin_trylock on UP always says
- * TRUE. --> printk if already locked. */
-#define _raw_spin_trylock(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-		1; \
-	})
-
-#define spin_unlock_wait(x)	\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, (x), \
-					(x)->owner, (x)->oline); \
-		}\
-	} while (0)
-
-#define _raw_spin_unlock(x) \
-	do { \
-	 	CHECK_LOCK(x); \
-		if (!(x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
-					__FILE__,__LINE__, (x)->module, (x));\
-		} \
-		(x)->lock = 0; \
-	} while (0)
-#else
-/*
- * gcc versions before ~2.95 have a nasty bug with empty initializers.
- */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#define SPINLOCK_MAGIC  0xdead4ead
+
+typedef struct {
+	raw_rwlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_pid, owner_cpu;
 #endif
+} rwlock_t;
+
+#define RWLOCK_MAGIC	0xdeaf1eed
 
 /*
- * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
+ * Pull the __raw*() functions/declarations (UP-nondebug doesnt need them):
  */
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
-#define spin_is_locked(lock)	((void)(lock), 0)
-#define assert_spin_locked(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_trylock(lock)	(((void)(lock), 1))
-#define spin_unlock_wait(lock)	(void)(lock)
-#define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-/* RW spinlocks: No debug version */
-
-#if (__GNUC__ > 2)
-  typedef struct { } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
+#if defined(CONFIG_SMP)
+# include <asm/spinlock.h>
 #else
-  typedef struct { int gcc_is_buggy; } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+# include <asm-generic/spinlock_up.h>
 #endif
 
-#define rwlock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_read_lock(lock)	do { (void)(lock); } while(0)
-#define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
-#define _raw_write_lock(lock)	do { (void)(lock); } while(0)
-#define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
-#define read_can_lock(lock)	(((void)(lock), 1))
-#define write_can_lock(lock)	(((void)(lock), 1))
-#define _raw_read_trylock(lock) ({ (void)(lock); (1); })
-#define _raw_write_trylock(lock) ({ (void)(lock); (1); })
-
-#define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
-				_raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable_no_resched(); local_bh_enable(); 0;});})
-
-#define _spin_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while(0)
-
-#define _write_lock(lock) \
-do { \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while(0)
- 
-#define _read_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while(0)
-
-#define _spin_unlock(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while(0)
-
-#define _read_unlock(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while(0)
-
-#define _spin_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define SPIN_LOCK_UNLOCKED						\
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
+				.magic = SPINLOCK_MAGIC,		\
+				.owner_pid = -1,			\
+				.owner_cpu = -1 }
+#define RW_LOCK_UNLOCKED						\
+	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
+				.magic = RWLOCK_MAGIC,			\
+				.owner_pid = -1,			\
+				.owner_cpu = -1 }
+#else
+# define SPIN_LOCK_UNLOCKED \
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED }
+#define RW_LOCK_UNLOCKED \
+	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED }
+#endif
 
-#define _read_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)
 
-#define _read_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _read_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
+#define spin_is_locked(x)	__raw_spin_is_locked(&(x)->raw_lock)
+#define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
 
-#define _write_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
+/*
+ * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+# include <linux/spinlock_smp.h>
+#else
+# include <linux/spinlock_up.h>
+#endif
 
-#define _write_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _write_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _spin_unlock_irq(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _spin_unlock_bh(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable_no_resched(); \
-	local_bh_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_bh(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable_no_resched(); \
-	local_bh_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_read_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_write_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_irq(lock)	\
-do { \
-	_raw_read_unlock(lock);	\
-	local_irq_enable();	\
-	preempt_enable();	\
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_bh(lock)	\
-do { \
-	_raw_read_unlock(lock);	\
-	preempt_enable_no_resched();	\
-	local_bh_enable();	\
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_irq(lock)	\
-do { \
-	_raw_write_unlock(lock);	\
-	local_irq_enable();	\
-	preempt_enable();	\
-	__release(lock); \
-} while (0)
+#ifdef CONFIG_DEBUG_SPINLOCK
+ extern void _raw_spin_lock(spinlock_t *lock);
+ extern void _raw_spin_lock_flags(spinlock_t *lock, unsigned long *flags);
+ extern int _raw_spin_trylock(spinlock_t *lock);
+ extern void _raw_spin_unlock(spinlock_t *lock);
+
+ extern void _raw_read_lock(rwlock_t *lock);
+ extern int _raw_read_trylock(rwlock_t *lock);
+ extern void _raw_read_unlock(rwlock_t *lock);
+ extern void _raw_write_lock(rwlock_t *lock);
+ extern int _raw_write_trylock(rwlock_t *lock);
+ extern void _raw_write_unlock(rwlock_t *lock);
+#else
+# define _raw_spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
+# define _raw_spin_trylock(lock)	__raw_spin_trylock(&(lock)->raw_lock)
+# define _raw_spin_lock(lock)		__raw_spin_lock(&(lock)->raw_lock)
+# define _raw_spin_lock_flags(lock, flags) \
+		__raw_spin_lock_flags(&(lock)->raw_lock, *(flags))
+# define _raw_read_lock(rwlock)		__raw_read_lock(&(rwlock)->raw_lock)
+# define _raw_write_lock(rwlock)	__raw_write_lock(&(rwlock)->raw_lock)
+# define _raw_read_unlock(rwlock)	__raw_read_unlock(&(rwlock)->raw_lock)
+# define _raw_write_unlock(rwlock)	__raw_write_unlock(&(rwlock)->raw_lock)
+# define _raw_read_trylock(rwlock)	__raw_read_trylock(&(rwlock)->raw_lock)
+# define _raw_write_trylock(rwlock)	__raw_write_trylock(&(rwlock)->raw_lock)
+#endif
 
-#endif /* !SMP */
+#define read_can_lock(rwlock)		__raw_read_can_lock(&(rwlock)->raw_lock)
+#define write_can_lock(rwlock)		__raw_write_can_lock(&(rwlock)->raw_lock)
 
 /*
  * Define the various spin_lock and rw_lock methods.  Note we define these
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define spin_trylock(lock)	__cond_lock(_spin_trylock(lock))
-#define read_trylock(lock)	__cond_lock(_read_trylock(lock))
-#define write_trylock(lock)	__cond_lock(_write_trylock(lock))
-
-#define spin_lock(lock)		_spin_lock(lock)
-#define write_lock(lock)	_write_lock(lock)
-#define read_lock(lock)		_read_lock(lock)
+#define spin_trylock(lock)		__cond_lock(_spin_trylock(lock))
+#define read_trylock(lock)		__cond_lock(_read_trylock(lock))
+#define write_trylock(lock)		__cond_lock(_write_trylock(lock))
+
+#define spin_lock(lock)			_spin_lock(lock)
+#define write_lock(lock)		_write_lock(lock)
+#define read_lock(lock)			_read_lock(lock)
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
@@ -470,23 +202,26 @@ do { \
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
 
-#define spin_unlock(lock)	_spin_unlock(lock)
-#define write_unlock(lock)	_write_unlock(lock)
-#define read_unlock(lock)	_read_unlock(lock)
+#define spin_unlock(lock)		_spin_unlock(lock)
+#define write_unlock(lock)		_write_unlock(lock)
+#define read_unlock(lock)		_read_unlock(lock)
 
-#define spin_unlock_irqrestore(lock, flags)	_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags) \
+					_spin_unlock_irqrestore(lock, flags)
 #define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
-#define read_unlock_irqrestore(lock, flags)	_read_unlock_irqrestore(lock, flags)
-#define read_unlock_irq(lock)			_read_unlock_irq(lock)
-#define read_unlock_bh(lock)			_read_unlock_bh(lock)
-
-#define write_unlock_irqrestore(lock, flags)	_write_unlock_irqrestore(lock, flags)
-#define write_unlock_irq(lock)			_write_unlock_irq(lock)
-#define write_unlock_bh(lock)			_write_unlock_bh(lock)
+#define read_unlock_irqrestore(lock, flags) \
+					_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define read_unlock_bh(lock)		_read_unlock_bh(lock)
+
+#define write_unlock_irqrestore(lock, flags) \
+					_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
+#define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
-#define spin_trylock_bh(lock)			__cond_lock(_spin_trylock_bh(lock))
+#define spin_trylock_bh(lock)		__cond_lock(_spin_trylock_bh(lock))
 
 #define spin_trylock_irq(lock) \
 ({ \
@@ -502,100 +237,18 @@ do { \
 	1 : ({local_irq_restore(flags); 0;}); \
 })
 
-#ifdef CONFIG_LOCKMETER
-extern void _metered_spin_lock   (spinlock_t *lock);
-extern void _metered_spin_unlock (spinlock_t *lock);
-extern int  _metered_spin_trylock(spinlock_t *lock);
-extern void _metered_read_lock    (rwlock_t *lock);
-extern void _metered_read_unlock  (rwlock_t *lock);
-extern void _metered_write_lock   (rwlock_t *lock);
-extern void _metered_write_unlock (rwlock_t *lock);
-extern int  _metered_read_trylock (rwlock_t *lock);
-extern int  _metered_write_trylock(rwlock_t *lock);
-#endif
-
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>
 extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #endif
 
-#define atomic_dec_and_lock(atomic,lock) __cond_lock(_atomic_dec_and_lock(atomic,lock))
-
-/*
- *  bit-based spin_lock()
- *
- * Don't use this unless you really need to: spin_lock() and spin_unlock()
- * are significantly faster.
- */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (test_and_set_bit(bitnum, addr)) {
-		while (test_bit(bitnum, addr)) {
-			preempt_enable();
-			cpu_relax();
-			preempt_disable();
-		}
-	}
-#endif
-	__acquire(bitlock);
-}
-
-/*
- * Return true if it was acquired
- */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
-{
-	preempt_disable();	
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	if (test_and_set_bit(bitnum, addr)) {
-		preempt_enable();
-		return 0;
-	}
-#endif
-	__acquire(bitlock);
-	return 1;
-}
-
-/*
- *  bit-based spin_unlock()
- */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
-#endif
-	preempt_enable();
-	__release(bitlock);
-}
+#define atomic_dec_and_lock(atomic,lock) \
+				__cond_lock(_atomic_dec_and_lock(atomic,lock))
 
-/*
- * Return true if the lock is held.
- */
-static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT
-	return preempt_count();
-#else
-	return 1;
-#endif
-}
 
-#define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
-#define DEFINE_RWLOCK(x) rwlock_t x = RW_LOCK_UNLOCKED
+#define DEFINE_SPINLOCK(x)		spinlock_t x = SPIN_LOCK_UNLOCKED
+#define DEFINE_RWLOCK(x)		rwlock_t x = RW_LOCK_UNLOCKED
 
 /**
  * spin_can_lock - would spin_trylock() succeed?
--- linux/include/linux/bit_spinlock.h.orig
+++ linux/include/linux/bit_spinlock.h
@@ -0,0 +1,77 @@
+#ifndef __LINUX_BIT_SPINLOCK_H
+#define __LINUX_BIT_SPINLOCK_H
+
+/*
+ *  bit-based spin_lock()
+ *
+ * Don't use this unless you really need to: spin_lock() and spin_unlock()
+ * are significantly faster.
+ */
+static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	while (test_and_set_bit(bitnum, addr)) {
+		while (test_bit(bitnum, addr)) {
+			preempt_enable();
+			cpu_relax();
+			preempt_disable();
+		}
+	}
+#endif
+	__acquire(bitlock);
+}
+
+/*
+ * Return true if it was acquired
+ */
+static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+{
+	preempt_disable();	
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	if (test_and_set_bit(bitnum, addr)) {
+		preempt_enable();
+		return 0;
+	}
+#endif
+	__acquire(bitlock);
+	return 1;
+}
+
+/*
+ *  bit-based spin_unlock()
+ */
+static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	BUG_ON(!test_bit(bitnum, addr));
+	smp_mb__before_clear_bit();
+	clear_bit(bitnum, addr);
+#endif
+	preempt_enable();
+	__release(bitlock);
+}
+
+/*
+ * Return true if the lock is held.
+ */
+static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	return test_bit(bitnum, addr);
+#elif defined CONFIG_PREEMPT
+	return preempt_count();
+#else
+	return 1;
+#endif
+}
+
+#endif /* __LINUX_BIT_SPINLOCK_H */
+
--- linux/include/linux/spinlock_up.h.orig
+++ linux/include/linux/spinlock_up.h
@@ -0,0 +1,220 @@
+#ifndef __LINUX_SPINLOCK_UP_H
+#define __LINUX_SPINLOCK_UP_H
+
+/*
+ * include/linux/spinlock_up.h - spinlock declarations for UP-nondebug:
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+#define in_lock_functions(ADDR) 0
+
+#if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
+# define _atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
+# define ATOMIC_DEC_AND_LOCK
+#endif
+
+#define assert_spin_locked(lock)	do { (void)(lock); } while(0)
+
+
+#define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
+
+#define _read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
+
+#define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
+
+#define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
+				_raw_spin_trylock(lock) ? \
+				1 : ({preempt_enable_no_resched(); local_bh_enable(); 0;});})
+
+#define _spin_lock(lock)	\
+do { \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _write_lock(lock) \
+do { \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+	__acquire(lock); \
+} while (0)
+ 
+#define _read_lock(lock)	\
+do { \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _spin_unlock(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _write_unlock(lock) \
+do { \
+	_raw_write_unlock(lock); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _read_unlock(lock) \
+do { \
+	_raw_read_unlock(lock); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _spin_lock_irqsave(lock, flags) \
+do {	\
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _spin_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _spin_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _read_lock_irqsave(lock, flags) \
+do {	\
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _read_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _read_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_read_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _write_lock_irqsave(lock, flags) \
+do {	\
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _write_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _write_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_raw_write_lock(lock); \
+	__acquire(lock); \
+} while (0)
+
+#define _spin_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_spin_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _spin_unlock_irq(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	local_irq_enable(); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _spin_unlock_bh(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	preempt_enable_no_resched(); \
+	local_bh_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _write_unlock_bh(lock) \
+do { \
+	_raw_write_unlock(lock); \
+	preempt_enable_no_resched(); \
+	local_bh_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _read_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_read_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _write_unlock_irqrestore(lock, flags) \
+do { \
+	_raw_write_unlock(lock); \
+	local_irq_restore(flags); \
+	preempt_enable(); \
+	__release(lock); \
+} while (0)
+
+#define _read_unlock_irq(lock)	\
+do { \
+	_raw_read_unlock(lock);	\
+	local_irq_enable();	\
+	preempt_enable();	\
+	__release(lock); \
+} while (0)
+
+#define _read_unlock_bh(lock)	\
+do { \
+	_raw_read_unlock(lock);	\
+	preempt_enable_no_resched();	\
+	local_bh_enable();	\
+	__release(lock); \
+} while (0)
+
+#define _write_unlock_irq(lock)	\
+do { \
+	_raw_write_unlock(lock);	\
+	local_irq_enable();	\
+	preempt_enable();	\
+	__release(lock); \
+} while (0)
+
+#endif /* __LINUX_SPINLOCK_UP_H */
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -7,44 +7,19 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 
-asmlinkage int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int slock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-/*
+ *
+ * (the type definitions are in asm/spinlock_types.h)
+ *
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define __raw_spin_is_locked(x) \
+		(*(volatile signed char *)(&(x)->slock) <= 0)
 
 #define spin_lock_string \
 	"\n1:\t" \
@@ -86,12 +61,8 @@ typedef struct {
 		:"=m" (lock->slock) : : "memory"
 
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
-#endif
 	__asm__ __volatile__(
 		spin_unlock_string
 	);
@@ -104,13 +75,10 @@ static inline void _raw_spin_unlock(spin
 		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	char oldval = 1;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
-#endif
+
 	__asm__ __volatile__(
 		spin_unlock_string
 	);
@@ -118,7 +86,7 @@ static inline void _raw_spin_unlock(spin
 
 #endif
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	char oldval;
 	__asm__ __volatile__(
@@ -128,27 +96,15 @@ static inline int _raw_spin_trylock(spin
 	return oldval > 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
 	__asm__ __volatile__(
 		spin_lock_string
 		:"=m" (lock->slock) : : "memory");
 }
 
-static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
+static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
 		:"=m" (lock->slock) : "r" (flags) : "memory");
@@ -164,39 +120,18 @@ static inline void _raw_spin_lock_flags 
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 /**
  * read_can_lock - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_can_lock(x) ((int)(x)->lock > 0)
+#define __raw_read_can_lock(x)		((int)(x)->lock > 0)
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+#define __raw_write_can_lock(x)		((x)->lock == RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
@@ -209,26 +144,27 @@ typedef struct {
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+}
+
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" (rw->lock) : : "memory");
+}
 
-static inline int _raw_read_trylock(rwlock_t *lock)
+static inline int __raw_read_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
@@ -238,7 +174,7 @@ static inline int _raw_read_trylock(rwlo
 	return 0;
 }
 
-static inline int _raw_write_trylock(rwlock_t *lock)
+static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
--- linux/include/asm-i386/spinlock_types.h.orig
+++ linux/include/asm-i386/spinlock_types.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
+
+#endif
--- linux/include/asm-x86_64/spinlock.h.orig
+++ linux/include/asm-x86_64/spinlock.h
@@ -6,45 +6,19 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
-extern int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-/*
+ *
+ * (the type definitions are in asm/raw_spinlock_types.h)
+ *
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_is_locked(x) \
+		(*(volatile signed char *)(&(x)->slock) <= 0)
 
 #define spin_lock_string \
 	"\n1:\t" \
@@ -58,75 +32,37 @@ typedef struct {
 	"jmp 1b\n" \
 	LOCK_SECTION_END
 
-/*
- * This works. Despite all the confusion.
- * (except on PPro SMP or if we are using OOSTORE)
- * (PPro errata 66, 92)
- */
- 
-#if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
-
 #define spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
+		:"=m" (lock->slock) : : "memory"
 
-
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	assert_spin_locked(lock);
-#endif
 	__asm__ __volatile__(
-		spin_unlock_string
-	);
-}
-
-#else
-
-#define spin_unlock_string \
-	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
-		:"0" (oldval) : "memory"
-
-static inline void _raw_spin_unlock(spinlock_t *lock)
-{
-	char oldval = 1;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	assert_spin_locked(lock);
-#endif
-	__asm__ __volatile__(
-		spin_unlock_string
-	);
+		spin_lock_string
+		:"=m" (lock->slock) : : "memory");
 }
 
-#endif
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	char oldval;
+
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
+		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
+
 	return oldval > 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
 	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		spin_unlock_string
+	);
 }
 
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -137,30 +73,11 @@ static inline void _raw_spin_lock(spinlo
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
+#define __raw_read_can_lock(x)		((int)(x)->lock > 0)
+#define __raw_write_can_lock(x)		((x)->lock == RW_LOCK_BIAS)
 
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-#define read_can_lock(x)	((int)(x)->lock > 0)
-#define write_can_lock(x)	((x)->lock == RW_LOCK_BIAS)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
@@ -173,26 +90,27 @@ typedef struct {
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+}
+
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" (rw->lock) : : "memory");
+}
 
-static inline int _raw_read_trylock(rwlock_t *lock)
+static inline int __raw_read_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
@@ -202,7 +120,7 @@ static inline int _raw_read_trylock(rwlo
 	return 0;
 }
 
-static inline int _raw_write_trylock(rwlock_t *lock)
+static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
--- linux/include/asm-x86_64/spinlock_types.h.orig
+++ linux/include/asm-x86_64/spinlock_types.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
+
+#endif
--- linux/lib/Makefile.orig
+++ linux/lib/Makefile
@@ -15,6 +15,7 @@ CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
 endif
 
+obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
--- linux/lib/spinlock_debug.c.orig
+++ linux/lib/spinlock_debug.c
@@ -0,0 +1,197 @@
+/*
+ * Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ *
+ * This file contains the spinlock/rwlock implementations for
+ * DEBUG_SPINLOCK.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+static void
+spin_bug(spinlock_t *lock, const char *file, const int line, const char *msg)
+{
+	static long print_once = 1;
+
+	if (xchg(&print_once, 0) || 1) {
+		printk("spinlock BUG: %s, at %s:%d! lock: %p\n",
+			msg, file, line, lock);
+#ifdef CONFIG_SMP
+		/*
+		 * We cannot continue on SMP:
+		 */
+		BUG();
+#else
+		dump_stack();
+#endif
+	}
+}
+
+#define SPIN_BUG_ON(cond, lock, msg) \
+		if (unlikely(cond)) spin_bug(lock, __FILE__, __LINE__, msg)
+
+static inline void debug_spin_lock_before(spinlock_t *lock)
+{
+	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(lock->owner_pid == current->pid, lock, "recursion");
+	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+							lock, "irq recursion");
+}
+
+static inline void debug_spin_lock_after(spinlock_t *lock)
+{
+	lock->owner_cpu = raw_smp_processor_id();
+	lock->owner_pid = current->pid;
+}
+
+static inline void debug_spin_unlock(spinlock_t *lock)
+{
+	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(!spin_is_locked(lock), lock, "already unlocked");
+	SPIN_BUG_ON(lock->owner_pid != current->pid, lock, "wrong owner");
+	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
+							lock, "wrong CPU");
+	lock->owner_pid = -1;
+	lock->owner_cpu = -1;
+}
+
+void _raw_spin_lock(spinlock_t *lock)
+{
+	debug_spin_lock_before(lock);
+	__raw_spin_lock(&lock->raw_lock);
+	debug_spin_lock_after(lock);
+}
+
+void _raw_spin_lock_flags(spinlock_t *lock, unsigned long *flags)
+{
+	debug_spin_lock_before(lock);
+	__raw_spin_lock_flags(&lock->raw_lock, *flags);
+	debug_spin_lock_after(lock);
+}
+
+int _raw_spin_trylock(spinlock_t *lock)
+{
+	int ret = __raw_spin_trylock(&lock->raw_lock);
+
+	if (ret)
+		debug_spin_lock_after(lock);
+#ifndef CONFIG_SMP
+	else
+		/*
+		 * Must not happen on UP:
+		 */
+		SPIN_BUG_ON(1, lock, "trylock failure on UP");
+#endif
+
+	return ret;
+}
+
+void _raw_spin_unlock(spinlock_t *lock)
+{
+	debug_spin_unlock(lock);
+	__raw_spin_unlock(&lock->raw_lock);
+}
+
+static void
+rwlock_bug(rwlock_t *lock, const char *file, const int line, const char *msg)
+{
+	static long print_once = 1;
+
+	if (xchg(&print_once, 0)) {
+		printk("rwlock BUG: %s, at %s:%d! lock: %p\n",
+			msg, file, line, lock);
+#ifdef CONFIG_SMP
+		/*
+		 * We cannot continue on SMP:
+		 */
+		BUG();
+#else
+		dump_stack();
+#endif
+	}
+}
+
+#define RWLOCK_BUG_ON(cond, lock, msg) \
+		if (unlikely(cond)) rwlock_bug(lock, __FILE__, __LINE__, msg)
+
+void _raw_read_lock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	__raw_read_lock(&lock->raw_lock);
+}
+
+int _raw_read_trylock(rwlock_t *lock)
+{
+	int ret = __raw_read_trylock(&lock->raw_lock);
+
+#ifndef CONFIG_SMP
+	/*
+	 * Must not happen on UP:
+	 */
+	RWLOCK_BUG_ON(!ret, lock, "trylock failure on UP");
+#endif
+
+	return ret;
+}
+
+void _raw_read_unlock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	__raw_read_unlock(&lock->raw_lock);
+}
+
+static inline void debug_write_lock_before(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	RWLOCK_BUG_ON(lock->owner_pid == current->pid, lock, "recursion");
+	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+							lock, "irq recursion");
+}
+
+static inline void debug_write_lock_after(rwlock_t *lock)
+{
+	lock->owner_cpu = raw_smp_processor_id();
+	lock->owner_pid = current->pid;
+}
+
+static inline void debug_write_unlock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	RWLOCK_BUG_ON(lock->owner_pid != current->pid, lock, "wrong owner");
+	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
+							lock, "wrong CPU");
+	lock->owner_pid = -1;
+	lock->owner_cpu = -1;
+}
+
+void _raw_write_lock(rwlock_t *lock)
+{
+	debug_write_lock_before(lock);
+	__raw_write_lock(&lock->raw_lock);
+	debug_write_lock_after(lock);
+}
+
+int _raw_write_trylock(rwlock_t *lock)
+{
+	int ret = __raw_write_trylock(&lock->raw_lock);
+
+	if (ret)
+		debug_write_lock_after(lock);
+#ifndef CONFIG_SMP
+	else
+		/*
+		 * Must not happen on UP:
+		 */
+		SPIN_BUG_ON(1, lock, "trylock failure on UP");
+#endif
+
+	return ret;
+}
+
+void _raw_write_unlock(rwlock_t *lock)
+{
+	debug_write_unlock(lock);
+	__raw_write_unlock(&lock->raw_lock);
+}

