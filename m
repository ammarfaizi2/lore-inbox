Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269448AbUICCdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269448AbUICCdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269446AbUICALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:11:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29940 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269408AbUIBX6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:20 -0400
Date: Thu, 2 Sep 2004 20:02:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ppc64/kernel/time.c        |   14 ++
 arch/ppc64/kernel/vmlinux.lds.S |    1
 arch/ppc64/lib/locks.c          |  216 +-------------------------------
 include/asm-ppc64/ptrace.h      |    5
 include/asm-ppc64/spinlock.h    |  268 ++++++++++++++++++----------------------
 5 files changed, 150 insertions(+), 354 deletions(-)

oprofile needs some eyeballing here, we need to check the program counter
against the locking function bounds.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ppc64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/time.c	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/time.c	2 Sep 2004 13:53:34 -0000
@@ -158,6 +158,20 @@ static __inline__ void timer_sync_xtime(
 	}
 }

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return regs->link;
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
+
 #ifdef CONFIG_PPC_ISERIES

 /*
Index: linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ppc64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/vmlinux.lds.S	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ppc64/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -14,6 +14,7 @@ SECTIONS
   .text : {
 	*(.text .text.*)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	. = ALIGN(4096);
 	_etext = .;
Index: linux-2.6.9-rc1-mm1-stage/arch/ppc64/lib/locks.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ppc64/lib/locks.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 locks.c
--- linux-2.6.9-rc1-mm1-stage/arch/ppc64/lib/locks.c	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ppc64/lib/locks.c	2 Sep 2004 13:08:15 -0000
@@ -22,26 +22,9 @@

 #ifndef CONFIG_SPINLINE

-/*
- * On a system with shared processors (that is, where a physical
- * processor is multiplexed between several virtual processors),
- * there is no point spinning on a lock if the holder of the lock
- * isn't currently scheduled on a physical processor.  Instead
- * we detect this situation and ask the hypervisor to give the
- * rest of our timeslice to the lock holder.
- *
- * So that we can tell which virtual processor is holding a lock,
- * we put 0x80000000 | smp_processor_id() in the lock when it is
- * held.  Conveniently, we have a word in the paca that holds this
- * value.
- */
-
 /* waiting for a spinlock... */
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)

-/* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (get_paca()->lppaca.xSharedProc)
-
 void __spin_yield(spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
@@ -68,96 +51,11 @@ void __spin_yield(spinlock_t *lock)
 #endif
 }

-#else /* SPLPAR || ISERIES */
-#define __spin_yield(x)	barrier()
-#define SHARED_PROCESSOR	0
-#endif
-
-/*
- * This returns the old value in the lock, so we succeeded
- * in getting the lock if the return value is 0.
- */
-static __inline__ unsigned long __spin_trylock(spinlock_t *lock)
-{
-	unsigned long tmp, tmp2;
-
-	__asm__ __volatile__(
-"	lwz		%1,%3(13)		# __spin_trylock\n\
-1:	lwarx		%0,0,%2\n\
-	cmpwi		0,%0,0\n\
-	bne-		2f\n\
-	stwcx.		%1,0,%2\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp), "=&r" (tmp2)
-	: "r" (&lock->lock), "i" (offsetof(struct paca_struct, lock_token))
-	: "cr0", "memory");
-
-	return tmp;
-}
-
-int _raw_spin_trylock(spinlock_t *lock)
-{
-	return __spin_trylock(lock) == 0;
-}
-
-EXPORT_SYMBOL(_raw_spin_trylock);
-
-void _raw_spin_lock(spinlock_t *lock)
-{
-	while (1) {
-		if (likely(__spin_trylock(lock) == 0))
-			break;
-		do {
-			HMT_low();
-			if (SHARED_PROCESSOR)
-				__spin_yield(lock);
-		} while (likely(lock->lock != 0));
-		HMT_medium();
-	}
-}
-
-EXPORT_SYMBOL(_raw_spin_lock);
-
-void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
-{
-	unsigned long flags_dis;
-
-	while (1) {
-		if (likely(__spin_trylock(lock) == 0))
-			break;
-		local_save_flags(flags_dis);
-		local_irq_restore(flags);
-		do {
-			HMT_low();
-			if (SHARED_PROCESSOR)
-				__spin_yield(lock);
-		} while (likely(lock->lock != 0));
-		HMT_medium();
-		local_irq_restore(flags_dis);
-	}
-}
-
-EXPORT_SYMBOL(_raw_spin_lock_flags);
-
-void spin_unlock_wait(spinlock_t *lock)
-{
-	while (lock->lock) {
-		HMT_low();
-		if (SHARED_PROCESSOR)
-			__spin_yield(lock);
-	}
-	HMT_medium();
-}
-
-EXPORT_SYMBOL(spin_unlock_wait);
-
 /*
  * Waiting for a read lock or a write lock on a rwlock...
  * This turns out to be the same for read and write locks, since
  * we only know the holder if it is write-locked.
  */
-#if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 void __rw_yield(rwlock_t *rw)
 {
 	int lock_value;
@@ -184,118 +82,18 @@ void __rw_yield(rwlock_t *rw)
 			   yield_count);
 #endif
 }
-
-#else /* SPLPAR || ISERIES */
-#define __rw_yield(x)	barrier()
 #endif

-/*
- * This returns the old value in the lock + 1,
- * so we got a read lock if the return value is > 0.
- */
-static __inline__ long __read_trylock(rwlock_t *rw)
-{
-	long tmp;
-
-	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1		# read_trylock\n\
-	extsw		%0,%0\n\
-	addic.		%0,%0,1\n\
-	ble-		2f\n\
-	stwcx.		%0,0,%1\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp)
-	: "r" (&rw->lock)
-	: "cr0", "xer", "memory");
-
-	return tmp;
-}
-
-int _raw_read_trylock(rwlock_t *rw)
-{
-	return __read_trylock(rw) > 0;
-}
-
-EXPORT_SYMBOL(_raw_read_trylock);
-
-void _raw_read_lock(rwlock_t *rw)
-{
-	while (1) {
-		if (likely(__read_trylock(rw) > 0))
-			break;
-		do {
-			HMT_low();
-			if (SHARED_PROCESSOR)
-				__rw_yield(rw);
-		} while (likely(rw->lock < 0));
-		HMT_medium();
-	}
-}
-
-EXPORT_SYMBOL(_raw_read_lock);
-
-void _raw_read_unlock(rwlock_t *rw)
-{
-	long tmp;
-
-	__asm__ __volatile__(
-	"eieio				# read_unlock\n\
-1:	lwarx		%0,0,%1\n\
-	addic		%0,%0,-1\n\
-	stwcx.		%0,0,%1\n\
-	bne-		1b"
-	: "=&r"(tmp)
-	: "r"(&rw->lock)
-	: "cr0", "memory");
-}
-
-EXPORT_SYMBOL(_raw_read_unlock);
-
-/*
- * This returns the old value in the lock,
- * so we got the write lock if the return value is 0.
- */
-static __inline__ long __write_trylock(rwlock_t *rw)
-{
-	long tmp, tmp2;
-
-	__asm__ __volatile__(
-"	lwz		%1,%3(13)	# write_trylock\n\
-1:	lwarx		%0,0,%2\n\
-	cmpwi		0,%0,0\n\
-	bne-		2f\n\
-	stwcx.		%1,0,%2\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp), "=&r" (tmp2)
-	: "r" (&rw->lock), "i" (offsetof(struct paca_struct, lock_token))
-	: "cr0", "memory");
-
-	return tmp;
-}
-
-int _raw_write_trylock(rwlock_t *rw)
-{
-	return __write_trylock(rw) == 0;
-}
-
-EXPORT_SYMBOL(_raw_write_trylock);
-
-void _raw_write_lock(rwlock_t *rw)
+void spin_unlock_wait(spinlock_t *lock)
 {
-	while (1) {
-		if (likely(__write_trylock(rw) == 0))
-			break;
-		do {
-			HMT_low();
-			if (SHARED_PROCESSOR)
-				__rw_yield(rw);
-		} while (likely(rw->lock != 0));
-		HMT_medium();
+	while (lock->lock) {
+		HMT_low();
+		if (SHARED_PROCESSOR)
+			__spin_yield(lock);
 	}
+	HMT_medium();
 }

-EXPORT_SYMBOL(_raw_write_lock);
+EXPORT_SYMBOL(spin_unlock_wait);

 #endif /* CONFIG_SPINLINE */
Index: linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-ppc64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/ptrace.h	26 Aug 2004 13:13:09 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/ptrace.h	2 Sep 2004 13:08:16 -0000
@@ -69,7 +69,12 @@ struct pt_regs32 {
 #define __SIGNAL_FRAMESIZE32	64

 #define instruction_pointer(regs) ((regs)->nip)
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
+
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)

 #define force_successful_syscall_return()   \
Index: linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-ppc64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/spinlock.h	26 Aug 2004 13:13:09 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-ppc64/spinlock.h	2 Sep 2004 13:08:16 -0000
@@ -6,6 +6,8 @@
  *
  * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
  * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2002 Dave Engebretsen <engebret@us.ibm.com>, IBM
+ *	Rework to support virtual processors
  *
  * Type of int is used as a full 64b word is not necessary.
  *
@@ -16,6 +18,8 @@
  */
 #include <linux/config.h>
 #include <asm/paca.h>
+#include <asm/hvcall.h>
+#include <asm/iSeries/HvCall.h>

 typedef struct {
 	volatile unsigned int lock;
@@ -34,101 +38,91 @@ static __inline__ void _raw_spin_unlock(
 }

 /*
- * Normally we use the spinlock functions in arch/ppc64/lib/locks.c.
- * For special applications such as profiling, we can have the
- * spinlock functions inline by defining CONFIG_SPINLINE.
- * This is not recommended on partitioned systems with shared
- * processors, since the inline spinlock functions don't include
- * the code for yielding the CPU to the lock holder.
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
  */

-#ifndef CONFIG_SPINLINE
-extern int _raw_spin_trylock(spinlock_t *lock);
-extern void _raw_spin_lock(spinlock_t *lock);
-extern void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags);
+#if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (get_paca()->lppaca.xSharedProc)
+extern void __spin_yield(spinlock_t *lock);
+extern void __rw_yield(spinlock_t *lock);
+#else /* SPLPAR || ISERIES */
+#define __spin_yield(x)	barrier()
+#define __rw_yield(x)	barrier()
+#define SHARED_PROCESSOR	0
+#endif
 extern void spin_unlock_wait(spinlock_t *lock);

-#else
-
-static __inline__ int _raw_spin_trylock(spinlock_t *lock)
+/*
+ * This returns the old value in the lock, so we succeeded
+ * in getting the lock if the return value is 0.
+ */
+static __inline__ unsigned long __spin_trylock(spinlock_t *lock)
 {
-	unsigned int tmp, tmp2;
+	unsigned long tmp, tmp2;

 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2		# spin_trylock\n\
+"	lwz		%1,%3(13)		# __spin_trylock\n\
+1:	lwarx		%0,0,%2\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
-	lwz		%1,%3(13)\n\
 	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
 	isync\n\
-2:"	: "=&r"(tmp), "=&r"(tmp2)
-	: "r"(&lock->lock), "i"(offsetof(struct paca_struct, lock_token))
+2:"	: "=&r" (tmp), "=&r" (tmp2)
+	: "r" (&lock->lock), "i" (offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");

-	return tmp == 0;
+	return tmp;
 }

-static __inline__ void _raw_spin_lock(spinlock_t *lock)
+static int __inline__ _raw_spin_trylock(spinlock_t *lock)
 {
-	unsigned int tmp;
-
-	__asm__ __volatile__(
-	"b		2f		# spin_lock\n\
-1:"
-	HMT_LOW
-"	lwzx		%0,0,%1\n\
-	cmpwi		0,%0,0\n\
-	bne+		1b\n"
-	HMT_MEDIUM
-"2:	lwarx		%0,0,%1\n\
-	cmpwi		0,%0,0\n\
-	bne-		1b\n\
-	lwz		%0,%2(13)\n\
-	stwcx.		%0,0,%1\n\
-	bne-		2b\n\
-	isync"
-	: "=&r"(tmp)
-	: "r"(&lock->lock), "i"(offsetof(struct paca_struct, lock_token))
-	: "cr0", "memory");
+	return __spin_trylock(lock) == 0;
 }

-/*
- * Note: if we ever want to inline the spinlocks on iSeries,
- * we will have to change the irq enable/disable stuff in here.
- */
-static __inline__ void _raw_spin_lock_flags(spinlock_t *lock,
-					    unsigned long flags)
+static void __inline__ _raw_spin_lock(spinlock_t *lock)
 {
-	unsigned int tmp;
-	unsigned long tmp2;
-
-	__asm__ __volatile__(
-	"b		3f		# spin_lock\n\
-1:	mfmsr		%1\n\
-	mtmsrd		%3,1\n\
-2:"	HMT_LOW
-"	lwzx		%0,0,%2\n\
-	cmpwi		0,%0,0\n\
-	bne+		2b\n"
-	HMT_MEDIUM
-"	mtmsrd		%1,1\n\
-3:	lwarx		%0,0,%2\n\
-	cmpwi		0,%0,0\n\
-	bne-		1b\n\
-	lwz		%1,%4(13)\n\
-	stwcx.		%1,0,%2\n\
-	bne-		3b\n\
-	isync"
-	: "=&r"(tmp), "=&r"(tmp2)
-	: "r"(&lock->lock), "r"(flags),
-	  "i" (offsetof(struct paca_struct, lock_token))
-	: "cr0", "memory");
+	while (1) {
+		if (likely(__spin_trylock(lock) == 0))
+			break;
+		do {
+			HMT_low();
+			if (SHARED_PROCESSOR)
+				__spin_yield(lock);
+		} while (likely(lock->lock != 0));
+		HMT_medium();
+	}
 }

-#define spin_unlock_wait(x)	do { cpu_relax(); } while (spin_is_locked(x))
+static void __inline__ _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
+{
+	unsigned long flags_dis;

-#endif /* CONFIG_SPINLINE */
+	while (1) {
+		if (likely(__spin_trylock(lock) == 0))
+			break;
+		local_save_flags(flags_dis);
+		local_irq_restore(flags);
+		do {
+			HMT_low();
+			if (SHARED_PROCESSOR)
+				__spin_yield(lock);
+		} while (likely(lock->lock != 0));
+		HMT_medium();
+		local_irq_restore(flags_dis);
+	}
+}

 /*
  * Read-write spinlocks, allowing multiple readers
@@ -165,67 +159,54 @@ static __inline__ void _raw_write_unlock
 	rw->lock = 0;
 }

-#ifndef CONFIG_SPINLINE
-extern int _raw_read_trylock(rwlock_t *rw);
-extern void _raw_read_lock(rwlock_t *rw);
-extern void _raw_read_unlock(rwlock_t *rw);
-extern int _raw_write_trylock(rwlock_t *rw);
-extern void _raw_write_lock(rwlock_t *rw);
-extern void _raw_write_unlock(rwlock_t *rw);
-
-#else
-static __inline__ int _raw_read_trylock(rwlock_t *rw)
+/*
+ * This returns the old value in the lock + 1,
+ * so we got a read lock if the return value is > 0.
+ */
+static long __inline__ __read_trylock(rwlock_t *rw)
 {
-	unsigned int tmp;
-	unsigned int ret;
+	long tmp;

 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2		# read_trylock\n\
-	li		%1,0\n\
+"1:	lwarx		%0,0,%1		# read_trylock\n\
 	extsw		%0,%0\n\
 	addic.		%0,%0,1\n\
 	ble-		2f\n\
-	stwcx.		%0,0,%2\n\
+	stwcx.		%0,0,%1\n\
 	bne-		1b\n\
-	li		%1,1\n\
 	isync\n\
-2:"	: "=&r"(tmp), "=&r"(ret)
-	: "r"(&rw->lock)
-	: "cr0", "memory");
+2:"	: "=&r" (tmp)
+	: "r" (&rw->lock)
+	: "cr0", "xer", "memory");

-	return ret;
+	return tmp;
 }

-static __inline__ void _raw_read_lock(rwlock_t *rw)
+static int __inline__ _raw_read_trylock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	return __read_trylock(rw) > 0;
+}

-	__asm__ __volatile__(
-	"b		2f		# read_lock\n\
-1:"
-	HMT_LOW
-"	lwax		%0,0,%1\n\
-	cmpwi		0,%0,0\n\
-	blt+		1b\n"
-	HMT_MEDIUM
-"2:	lwarx		%0,0,%1\n\
-	extsw		%0,%0\n\
-	addic.		%0,%0,1\n\
-	ble-		1b\n\
-	stwcx.		%0,0,%1\n\
-	bne-		2b\n\
-	isync"
-	: "=&r"(tmp)
-	: "r"(&rw->lock)
-	: "cr0", "memory");
+static void __inline__ _raw_read_lock(rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__read_trylock(rw) > 0))
+			break;
+		do {
+			HMT_low();
+			if (SHARED_PROCESSOR)
+				__rw_yield(rw);
+		} while (likely(rw->lock < 0));
+		HMT_medium();
+	}
 }

-static __inline__ void _raw_read_unlock(rwlock_t *rw)
+static void __inline__ _raw_read_unlock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	long tmp;

 	__asm__ __volatile__(
-	"lwsync				# read_unlock\n\
+	"eieio				# read_unlock\n\
 1:	lwarx		%0,0,%1\n\
 	addic		%0,%0,-1\n\
 	stwcx.		%0,0,%1\n\
@@ -235,50 +216,47 @@ static __inline__ void _raw_read_unlock(
 	: "cr0", "memory");
 }

-static __inline__ int _raw_write_trylock(rwlock_t *rw)
+/*
+ * This returns the old value in the lock,
+ * so we got the write lock if the return value is 0.
+ */
+static __inline__ long __write_trylock(rwlock_t *rw)
 {
-	unsigned int tmp;
-	unsigned int ret;
+	long tmp, tmp2;

 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2		# write_trylock\n\
+"	lwz		%1,%3(13)	# write_trylock\n\
+1:	lwarx		%0,0,%2\n\
 	cmpwi		0,%0,0\n\
-	li		%1,0\n\
 	bne-		2f\n\
-	stwcx.		%3,0,%2\n\
+	stwcx.		%1,0,%2\n\
 	bne-		1b\n\
-	li		%1,1\n\
 	isync\n\
-2:"	: "=&r"(tmp), "=&r"(ret)
-	: "r"(&rw->lock), "r"(-1)
+2:"	: "=&r" (tmp), "=&r" (tmp2)
+	: "r" (&rw->lock), "i" (offsetof(struct paca_struct, lock_token))
 	: "cr0", "memory");

-	return ret;
+	return tmp;
 }

-static __inline__ void _raw_write_lock(rwlock_t *rw)
+static int __inline__ _raw_write_trylock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	return __write_trylock(rw) == 0;
+}

-	__asm__ __volatile__(
-	"b		2f		# write_lock\n\
-1:"
-	HMT_LOW
-	"lwax		%0,0,%1\n\
-	cmpwi		0,%0,0\n\
-	bne+		1b\n"
-	HMT_MEDIUM
-"2:	lwarx		%0,0,%1\n\
-	cmpwi		0,%0,0\n\
-	bne-		1b\n\
-	stwcx.		%2,0,%1\n\
-	bne-		2b\n\
-	isync"
-	: "=&r"(tmp)
-	: "r"(&rw->lock), "r"(-1)
-	: "cr0", "memory");
+static void __inline__ _raw_write_lock(rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__write_trylock(rw) == 0))
+			break;
+		do {
+			HMT_low();
+			if (SHARED_PROCESSOR)
+				__rw_yield(rw);
+		} while (likely(rw->lock != 0));
+		HMT_medium();
+	}
 }
-#endif /* CONFIG_SPINLINE */

 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
