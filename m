Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270001AbUIDAgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270001AbUIDAgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUIDAgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:36:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:21700 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270001AbUIDAf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:26 -0400
Date: Fri, 3 Sep 2004 20:39:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][1/8] updated arch agnostic completely out of line locks /
 generic
Message-ID: <Pine.LNX.4.58.0409032020590.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/oprofile/timer_int.c      |    2
 include/asm-generic/vmlinux.lds.h |    5
 include/linux/spinlock.h          |  251 +++++++++++++++++++++++-------------
 kernel/Makefile                   |    2
 kernel/spinlock.c                 |  258 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 425 insertions(+), 93 deletions(-)

Status: Tested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/kernel/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/kernel/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.9-rc1-bk9-sparc64/kernel/Makefile	3 Sep 2004 01:30:46 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/kernel/Makefile	3 Sep 2004 23:55:27 -0000
@@ -11,7 +11,7 @@ obj-y     = sched.o fork.o exec_domain.o

 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o
+obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
Index: linux-2.6.9-rc1-bk9-sparc64/kernel/spinlock.c
===================================================================
RCS file: linux-2.6.9-rc1-bk9-sparc64/kernel/spinlock.c
diff -N linux-2.6.9-rc1-bk9-sparc64/kernel/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.9-rc1-bk9-sparc64/kernel/spinlock.c	3 Sep 2004 23:55:27 -0000
@@ -0,0 +1,258 @@
+/*
+ * Copyright (2004) Linus Torvalds
+ *
+ * Author: Zwane Mwaikambo <zwane@fsmlabs.com>
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+int __lockfunc _spin_trylock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_spin_trylock(lock))
+		return 1;
+
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_spin_trylock);
+
+int __lockfunc _write_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_write_trylock(lock))
+		return 1;
+
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_write_trylock);
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+void __lockfunc _spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_raw_spin_trylock(lock)))
+		__preempt_spin_lock(lock);
+}
+
+void __lockfunc _write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_raw_write_trylock(lock)))
+		__preempt_write_lock(lock);
+}
+#else
+void __lockfunc _spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+
+void __lockfunc _write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+#endif
+EXPORT_SYMBOL(_spin_lock);
+EXPORT_SYMBOL(_write_lock);
+
+void __lockfunc _read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(_read_lock);
+
+void __lockfunc _spin_unlock(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock);
+
+void __lockfunc _write_unlock(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock);
+
+void __lockfunc _read_unlock(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock);
+
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_raw_spin_lock_flags(lock, flags);
+	return flags;
+}
+EXPORT_SYMBOL(_spin_lock_irqsave);
+
+void __lockfunc _spin_lock_irq(spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+EXPORT_SYMBOL(_spin_lock_irq);
+
+void __lockfunc _spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+EXPORT_SYMBOL(_spin_lock_bh);
+
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_raw_read_lock(lock);
+	return flags;
+}
+EXPORT_SYMBOL(_read_lock_irqsave);
+
+void __lockfunc _read_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(_read_lock_irq);
+
+void __lockfunc _read_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+EXPORT_SYMBOL(_read_lock_bh);
+
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_raw_write_lock(lock);
+	return flags;
+}
+EXPORT_SYMBOL(_write_lock_irqsave);
+
+void __lockfunc _write_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(_write_lock_irq);
+
+void __lockfunc _write_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_write_lock(lock);
+}
+EXPORT_SYMBOL(_write_lock_bh);
+
+void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+{
+	_raw_spin_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_irqrestore);
+
+void __lockfunc _spin_unlock_irq(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_irq);
+
+void __lockfunc _spin_unlock_bh(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_bh);
+
+void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+{
+	_raw_read_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock_irqrestore);
+
+void __lockfunc _read_unlock_irq(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock_irq);
+
+void __lockfunc _read_unlock_bh(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_read_unlock_bh);
+
+void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+{
+	_raw_write_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock_irqrestore);
+
+void __lockfunc _write_unlock_irq(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock_irq);
+
+void __lockfunc _write_unlock_bh(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_write_unlock_bh);
+
+int __lockfunc _spin_trylock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	if (_raw_spin_trylock(lock))
+		return 1;
+
+	preempt_enable();
+	local_bh_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_spin_trylock_bh);
Index: linux-2.6.9-rc1-bk9-sparc64/drivers/oprofile/timer_int.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/drivers/oprofile/timer_int.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 timer_int.c
--- linux-2.6.9-rc1-bk9-sparc64/drivers/oprofile/timer_int.c	3 Sep 2004 01:30:32 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/drivers/oprofile/timer_int.c	3 Sep 2004 23:55:27 -0000
@@ -19,7 +19,7 @@ static int timer_notify(struct notifier_
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);

 	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
Index: linux-2.6.9-rc1-bk9-sparc64/include/linux/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/linux/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-bk9-sparc64/include/linux/spinlock.h	3 Sep 2004 01:30:44 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/linux/spinlock.h	3 Sep 2004 23:55:27 -0000
@@ -19,18 +19,18 @@
 /*
  * Must define these before including other files, inline functions need them
  */
-#define LOCK_SECTION_NAME			\
-	".text.lock." __stringify(KBUILD_BASENAME)
+#define LOCK_SECTION_NAME                       \
+        ".text.lock." __stringify(KBUILD_BASENAME)

-#define LOCK_SECTION_START(extra)		\
-	".subsection 1\n\t"			\
-	extra					\
-	".ifndef " LOCK_SECTION_NAME "\n\t"	\
-	LOCK_SECTION_NAME ":\n\t"		\
-	".endif\n\t"
+#define LOCK_SECTION_START(extra)               \
+        ".subsection 1\n\t"                     \
+        extra                                   \
+        ".ifndef " LOCK_SECTION_NAME "\n\t"     \
+        LOCK_SECTION_NAME ":\n\t"               \
+        ".endif\n\t"

-#define LOCK_SECTION_END			\
-	".previous\n\t"
+#define LOCK_SECTION_END                        \
+        ".previous\n\t"

 /*
  * If CONFIG_SMP is set, pull in the _raw_* definitions
@@ -38,9 +38,40 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>

-#else
+#define __lockfunc fastcall __attribute__((section(".spinlock.text")))
+
+int __lockfunc _spin_trylock(spinlock_t *lock);
+int __lockfunc _write_trylock(rwlock_t *lock);
+void __lockfunc _spin_lock(spinlock_t *lock);
+void __lockfunc _write_lock(rwlock_t *lock);
+void __lockfunc _spin_lock(spinlock_t *lock);
+void __lockfunc _read_lock(rwlock_t *lock);
+void __lockfunc _spin_unlock(spinlock_t *lock);
+void __lockfunc _write_unlock(rwlock_t *lock);
+void __lockfunc _read_unlock(rwlock_t *lock);
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock);
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock);
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock);
+void __lockfunc _spin_lock_irq(spinlock_t *lock);
+void __lockfunc _spin_lock_bh(spinlock_t *lock);
+void __lockfunc _read_lock_irq(rwlock_t *lock);
+void __lockfunc _read_lock_bh(rwlock_t *lock);
+void __lockfunc _write_lock_irq(rwlock_t *lock);
+void __lockfunc _write_lock_bh(rwlock_t *lock);
+void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags);
+void __lockfunc _spin_unlock_irq(spinlock_t *lock);
+void __lockfunc _spin_unlock_bh(spinlock_t *lock);
+void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
+void __lockfunc _read_unlock_irq(rwlock_t *lock);
+void __lockfunc _read_unlock_bh(rwlock_t *lock);
+void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
+void __lockfunc _write_unlock_irq(rwlock_t *lock);
+void __lockfunc _write_unlock_bh(rwlock_t *lock);
+int __lockfunc _spin_trylock_bh(spinlock_t *lock);

-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+extern unsigned long __lock_text_start;
+extern unsigned long __lock_text_end;
+#else

 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
@@ -162,9 +193,9 @@ typedef struct {
 #define spin_lock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
 #define spin_is_locked(lock)	((void)(lock), 0)
-#define _raw_spin_trylock(lock)	((void)(lock), 1)
-#define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
+#define _raw_spin_trylock(lock)	(((void)(lock), 1))
+#define spin_unlock_wait(lock)	(void)(lock);
+#define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */

 /* RW spinlocks: No debug version */
@@ -184,141 +215,116 @@ typedef struct {
 #define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_trylock(lock) ({ (void)(lock); (1); })

-#endif /* !SMP */
-
-/*
- * Define the various spin_lock and rw_lock methods.  Note we define these
- * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
- * methods are defined as nops in the case they are not required.
- */
-#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
+#define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})

-#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
+#define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})

-/* Where's read_trylock? */
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-void __preempt_spin_lock(spinlock_t *lock);
-void __preempt_write_lock(rwlock_t *lock);
-
-#define spin_lock(lock) \
-do { \
-	preempt_disable(); \
-	if (unlikely(!_raw_spin_trylock(lock))) \
-		__preempt_spin_lock(lock); \
-} while (0)
-
-#define write_lock(lock) \
-do { \
-	preempt_disable(); \
-	if (unlikely(!_raw_write_trylock(lock))) \
-		__preempt_write_lock(lock); \
-} while (0)
+#define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
+				_raw_spin_trylock(lock) ? \
+				1 : ({preempt_enable(); local_bh_enable(); 0;});})

-#else
-#define spin_lock(lock)	\
+#define _spin_lock(lock)	\
 do { \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while(0)

-#define write_lock(lock) \
+#define _write_lock(lock) \
 do { \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while(0)
-#endif
-
-#define read_lock(lock)	\
+
+#define _read_lock(lock)	\
 do { \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while(0)

-#define spin_unlock(lock) \
+#define _spin_unlock(lock) \
 do { \
 	_raw_spin_unlock(lock); \
 	preempt_enable(); \
 } while (0)

-#define write_unlock(lock) \
+#define _write_unlock(lock) \
 do { \
 	_raw_write_unlock(lock); \
 	preempt_enable(); \
 } while(0)

-#define read_unlock(lock) \
+#define _read_unlock(lock) \
 do { \
 	_raw_read_unlock(lock); \
 	preempt_enable(); \
 } while(0)

-#define spin_lock_irqsave(lock, flags) \
-do { \
+#define _spin_lock_irqsave(lock, flags) \
+do {	\
 	local_irq_save(flags); \
 	preempt_disable(); \
-	_raw_spin_lock_flags(lock, flags); \
+	_raw_spin_lock(lock); \
 } while (0)

-#define spin_lock_irq(lock) \
+#define _spin_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while (0)

-#define spin_lock_bh(lock) \
+#define _spin_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while (0)

-#define read_lock_irqsave(lock, flags) \
-do { \
+#define _read_lock_irqsave(lock, flags) \
+do {	\
 	local_irq_save(flags); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while (0)

-#define read_lock_irq(lock) \
+#define _read_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while (0)

-#define read_lock_bh(lock) \
+#define _read_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while (0)

-#define write_lock_irqsave(lock, flags) \
-do { \
+#define _write_lock_irqsave(lock, flags) \
+do {	\
 	local_irq_save(flags); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while (0)

-#define write_lock_irq(lock) \
+#define _write_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while (0)

-#define write_lock_bh(lock) \
+#define _write_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while (0)

-#define spin_unlock_irqrestore(lock, flags) \
+#define _spin_unlock_irqrestore(lock, flags) \
 do { \
 	_raw_spin_unlock(lock); \
 	local_irq_restore(flags); \
@@ -331,65 +337,128 @@ do { \
 	local_irq_restore(flags); \
 } while (0)

-#define spin_unlock_irq(lock) \
+#define _spin_unlock_irq(lock) \
 do { \
 	_raw_spin_unlock(lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)

-#define spin_unlock_bh(lock) \
+#define _spin_unlock_bh(lock) \
 do { \
 	_raw_spin_unlock(lock); \
 	preempt_enable(); \
 	local_bh_enable(); \
 } while (0)

-#define read_unlock_irqrestore(lock, flags) \
+#define _write_unlock_bh(lock) \
 do { \
-	_raw_read_unlock(lock); \
-	local_irq_restore(flags); \
+	_raw_write_unlock(lock); \
 	preempt_enable(); \
+	local_bh_enable(); \
 } while (0)

-#define read_unlock_irq(lock) \
+#define _read_unlock_irqrestore(lock, flags) \
 do { \
 	_raw_read_unlock(lock); \
-	local_irq_enable(); \
+	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)

-#define read_unlock_bh(lock) \
+#define _write_unlock_irqrestore(lock, flags) \
 do { \
-	_raw_read_unlock(lock); \
+	_raw_write_unlock(lock); \
+	local_irq_restore(flags); \
 	preempt_enable(); \
-	local_bh_enable(); \
 } while (0)

-#define write_unlock_irqrestore(lock, flags) \
+#define _read_unlock_irq(lock)	\
 do { \
-	_raw_write_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
+	_raw_read_unlock(lock);	\
+	local_irq_enable();	\
+	preempt_enable();	\
 } while (0)

-#define write_unlock_irq(lock) \
+#define _read_unlock_bh(lock)	\
 do { \
-	_raw_write_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
+	_raw_read_unlock(lock);	\
+	local_bh_enable();	\
+	preempt_enable();	\
 } while (0)

-#define write_unlock_bh(lock) \
+#define _write_unlock_irq(lock)	\
 do { \
-	_raw_write_unlock(lock); \
-	preempt_enable(); \
-	local_bh_enable(); \
+	_raw_write_unlock(lock);	\
+	local_irq_enable();	\
+	preempt_enable();	\
 } while (0)

-#define spin_trylock_bh(lock)	({ local_bh_disable(); preempt_disable(); \
-				_raw_spin_trylock(lock) ? 1 : \
-				({preempt_enable(); local_bh_enable(); 0;});})
+#endif /* !SMP */
+
+/*
+ * Define the various spin_lock and rw_lock methods.  Note we define these
+ * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
+ * methods are defined as nops in the case they are not required.
+ */
+#define spin_trylock(lock)	_spin_trylock(lock)
+#define write_trylock(lock)	_write_trylock(lock)
+
+/* Where's read_trylock? */
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+void __preempt_spin_lock(spinlock_t *lock);
+void __preempt_write_lock(rwlock_t *lock);
+#endif
+
+#define spin_lock(lock)		_spin_lock(lock)
+#define write_lock(lock)	_write_lock(lock)
+#define read_lock(lock)		_read_lock(lock)
+#define spin_unlock(lock)	_spin_unlock(lock)
+#define write_unlock(lock)	_write_unlock(lock)
+#define read_unlock(lock)	_read_unlock(lock)
+
+#ifdef CONFIG_SMP
+#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
+#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
+#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#else
+#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
+#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
+#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#endif
+
+#define spin_lock_irq(lock)		_spin_lock_irq(lock)
+#define spin_lock_bh(lock)		_spin_lock_bh(lock)
+
+#define read_lock_irq(lock)		_read_lock_irq(lock)
+#define read_lock_bh(lock)		_read_lock_bh(lock)
+
+#define write_lock_irq(lock)		_write_lock_irq(lock)
+#define write_lock_bh(lock)		_write_lock_bh(lock)
+#define spin_unlock_irqrestore(lock, flags)	_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
+#define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
+
+#define read_unlock_irqrestore(lock, flags)	_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irq(lock)			_read_unlock_irq(lock)
+#define read_unlock_bh(lock)			_read_unlock_bh(lock)
+
+#define write_unlock_irqrestore(lock, flags)	_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irq(lock)			_write_unlock_irq(lock)
+#define write_unlock_bh(lock)			_write_unlock_bh(lock)
+
+#define spin_trylock_bh(lock)			_spin_trylock_bh(lock)
+
+#ifdef CONFIG_LOCKMETER
+extern void _metered_spin_lock   (spinlock_t *lock);
+extern void _metered_spin_unlock (spinlock_t *lock);
+extern int  _metered_spin_trylock(spinlock_t *lock);
+extern void _metered_read_lock    (rwlock_t *lock);
+extern void _metered_read_unlock  (rwlock_t *lock);
+extern void _metered_write_lock   (rwlock_t *lock);
+extern void _metered_write_unlock (rwlock_t *lock);
+extern int  _metered_write_trylock(rwlock_t *lock);
+#endif

 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-generic/vmlinux.lds.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-generic/vmlinux.lds.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-generic/vmlinux.lds.h	3 Sep 2004 01:30:41 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-generic/vmlinux.lds.h	3 Sep 2004 23:55:27 -0000
@@ -77,3 +77,8 @@
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
+
+#define LOCK_TEXT							\
+		VMLINUX_SYMBOL(__lock_text_start) = .;			\
+		*(.lock.text)						\
+		VMLINUX_SYMBOL(__lock_text_end) = .;
