Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWISLUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWISLUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 07:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWISLUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 07:20:13 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43829 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030192AbWISLUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 07:20:08 -0400
Date: Tue, 19 Sep 2006 13:20:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mingo@elte.hu, paulus@samba.org
Subject: [patch 3/3] Directed yield: direct yield of spinlocks for s390.
Message-ID: <20060919112004.GE21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 3/3] Directed yield: direct yield of spinlocks for s390.

Use the new diagnose 0x9c in the spinlock implementation for s390.
It yields the remaining timeslice of the virtual cpu that tries to
acquire a lock to the virtual cpu that is the current holder of the
lock.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S         |   11 ++++++
 arch/s390/kernel/head64.S         |   11 ++++++
 arch/s390/lib/spinlock.c          |   62 +++++++++++++++++++++++---------------
 include/asm-s390/setup.h          |    1 
 include/asm-s390/spinlock.h       |   31 +++++++++++++------
 include/asm-s390/spinlock_types.h |    6 +--
 6 files changed, 87 insertions(+), 35 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-09-19 12:59:13.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-09-19 12:59:36.000000000 +0200
@@ -254,6 +254,16 @@ startup_continue:
 	oi	3(%r12),0x80		# set IDTE flag
 .Lchkidte:
 
+#
+# find out if the diag 0x9c is available
+#
+	mvc	__LC_PGM_NEW_PSW(8),.Lpcdiag9c-.LPG1(%r13)
+	stap   __LC_CPUID+4		# store cpu address
+	lh     %r1,__LC_CPUID+4
+	diag   %r1,0,0x9c		# test diag 0x9c
+	oi     2(%r12),1		# set diag9c flag
+.Lchkdiag9c:
+
 	lpsw  .Lentry-.LPG1(13)		# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	8
@@ -281,6 +291,7 @@ startup_continue:
 .Lpccsp:.long	0x00080000,0x80000000 + .Lchkcsp
 .Lpcmvpg:.long	0x00080000,0x80000000 + .Lchkmvpg
 .Lpcidte:.long	0x00080000,0x80000000 + .Lchkidte
+.Lpcdiag9c:.long 0x00080000,0x80000000 + .Lchkdiag9c
 .Lmemsize:.long memory_size
 .Lmchunk:.long	memory_chunk
 .Lmflags:.long	machine_flags
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-09-19 12:59:27.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-09-19 12:59:36.000000000 +0200
@@ -251,6 +251,17 @@ startup_continue:
 0:
 
 #
+# find out if the diag 0x9c is available
+#
+	la     %r1,0f-.LPG1(%r13)	# set program check address
+	stg    %r1,__LC_PGM_NEW_PSW+8
+	stap   __LC_CPUID+4		# store cpu address
+	lh     %r1,__LC_CPUID+4
+	diag   %r1,0,0x9c		# test diag 0x9c
+	oi     6(%r12),1		# set diag9c flag
+0:
+
+#
 # find out if we have the MVCOS instruction
 #
 	la	%r1,0f-.LPG1(%r13)	# set program check address
diff -urpN linux-2.6/arch/s390/lib/spinlock.c linux-2.6-patched/arch/s390/lib/spinlock.c
--- linux-2.6/arch/s390/lib/spinlock.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/spinlock.c	2006-09-19 12:59:36.000000000 +0200
@@ -24,57 +24,76 @@ static int __init spin_retry_setup(char 
 }
 __setup("spin_retry=", spin_retry_setup);
 
-static inline void
-_diag44(void)
+static inline void _raw_yield(void)
 {
-#ifdef CONFIG_64BIT
 	if (MACHINE_HAS_DIAG44)
-#endif
 		asm volatile("diag 0,0,0x44");
 }
 
-void
-_raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc)
+static inline void _raw_yield_cpu(int cpu)
+{
+	if (MACHINE_HAS_DIAG9C)
+		asm volatile("diag %0,0,0x9c"
+			     : : "d" (__cpu_logical_map[cpu]));
+	else
+		_raw_yield();
+}
+
+void _raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc)
 {
 	int count = spin_retry;
+	unsigned int cpu = ~smp_processor_id();
 
 	while (1) {
 		if (count-- <= 0) {
-			_diag44();
+			unsigned int owner = lp->owner_cpu;
+			if (owner != 0)
+				_raw_yield_cpu(~owner);
 			count = spin_retry;
 		}
 		if (__raw_spin_is_locked(lp))
 			continue;
-		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
+		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0) {
+			lp->owner_pc = pc;
 			return;
+		}
 	}
 }
 EXPORT_SYMBOL(_raw_spin_lock_wait);
 
-int
-_raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc)
+int _raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc)
 {
-	int count = spin_retry;
+	unsigned int cpu = ~smp_processor_id();
+	int count;
 
-	while (count-- > 0) {
+	for (count = spin_retry; count > 0; count--) {
 		if (__raw_spin_is_locked(lp))
 			continue;
-		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
+		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0) {
+			lp->owner_pc = pc;
 			return 1;
+		}
 	}
 	return 0;
 }
 EXPORT_SYMBOL(_raw_spin_trylock_retry);
 
-void
-_raw_read_lock_wait(raw_rwlock_t *rw)
+void _raw_spin_relax(raw_spinlock_t *lock)
+{
+	unsigned int cpu = lock->owner_cpu;
+	if (cpu != 0)
+		_raw_yield_cpu(~cpu);
+}
+EXPORT_SYMBOL(_raw_spin_relax);
+
+void _raw_read_lock_wait(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	int count = spin_retry;
 
 	while (1) {
 		if (count-- <= 0) {
-			_diag44();
+			_raw_yield();
 			count = spin_retry;
 		}
 		if (!__raw_read_can_lock(rw))
@@ -86,8 +105,7 @@ _raw_read_lock_wait(raw_rwlock_t *rw)
 }
 EXPORT_SYMBOL(_raw_read_lock_wait);
 
-int
-_raw_read_trylock_retry(raw_rwlock_t *rw)
+int _raw_read_trylock_retry(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	int count = spin_retry;
@@ -103,14 +121,13 @@ _raw_read_trylock_retry(raw_rwlock_t *rw
 }
 EXPORT_SYMBOL(_raw_read_trylock_retry);
 
-void
-_raw_write_lock_wait(raw_rwlock_t *rw)
+void _raw_write_lock_wait(raw_rwlock_t *rw)
 {
 	int count = spin_retry;
 
 	while (1) {
 		if (count-- <= 0) {
-			_diag44();
+			_raw_yield();
 			count = spin_retry;
 		}
 		if (!__raw_write_can_lock(rw))
@@ -121,8 +138,7 @@ _raw_write_lock_wait(raw_rwlock_t *rw)
 }
 EXPORT_SYMBOL(_raw_write_lock_wait);
 
-int
-_raw_write_trylock_retry(raw_rwlock_t *rw)
+int _raw_write_trylock_retry(raw_rwlock_t *rw)
 {
 	int count = spin_retry;
 
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-09-19 12:59:27.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-09-19 12:59:36.000000000 +0200
@@ -39,6 +39,7 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
+#define MACHINE_HAS_DIAG9C	(machine_flags & 256)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2006-09-19 12:59:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2006-09-19 12:59:36.000000000 +0200
@@ -11,6 +11,8 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <linux/smp.h>
+
 static inline int
 _raw_compare_and_swap(volatile unsigned int *lock,
 		      unsigned int old, unsigned int new)
@@ -31,34 +33,46 @@ _raw_compare_and_swap(volatile unsigned 
  * (the type definitions are in asm/spinlock_types.h)
  */
 
-#define __raw_spin_is_locked(x) ((x)->lock != 0)
+#define __raw_spin_is_locked(x) ((x)->owner_cpu != 0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 #define __raw_spin_unlock_wait(lock) \
-	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
+	do { while (__raw_spin_is_locked(lock)) \
+		 _raw_spin_relax(lock); } while (0)
 
-extern void _raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc);
-extern int _raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc);
+extern void _raw_spin_lock_wait(raw_spinlock_t *, unsigned int pc);
+extern int _raw_spin_trylock_retry(raw_spinlock_t *, unsigned int pc);
+extern void _raw_spin_relax(raw_spinlock_t *lock);
 
 static inline void __raw_spin_lock(raw_spinlock_t *lp)
 {
 	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
+	int old;
 
-	if (unlikely(_raw_compare_and_swap(&lp->lock, 0, pc) != 0))
-		_raw_spin_lock_wait(lp, pc);
+	old = _raw_compare_and_swap(&lp->owner_cpu, 0, ~smp_processor_id());
+	if (likely(old == 0)) {
+		lp->owner_pc = pc;
+		return;
+	}
+	_raw_spin_lock_wait(lp, pc);
 }
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lp)
 {
 	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
+	int old;
 
-	if (likely(_raw_compare_and_swap(&lp->lock, 0, pc) == 0))
+	old = _raw_compare_and_swap(&lp->owner_cpu, 0, ~smp_processor_id());
+	if (likely(old == 0)) {
+		lp->owner_pc = pc;
 		return 1;
+	}
 	return _raw_spin_trylock_retry(lp, pc);
 }
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lp)
 {
-	_raw_compare_and_swap(&lp->lock, lp->lock, 0);
+	lp->owner_pc = 0;
+	_raw_compare_and_swap(&lp->owner_cpu, lp->owner_cpu, 0);
 }
 		
 /*
@@ -135,7 +149,6 @@ static inline int __raw_write_trylock(ra
 	return _raw_write_trylock_retry(rw);
 }
 
-#define _raw_spin_relax(lock)	cpu_relax()
 #define _raw_read_relax(lock)	cpu_relax()
 #define _raw_write_relax(lock)	cpu_relax()
 
diff -urpN linux-2.6/include/asm-s390/spinlock_types.h linux-2.6-patched/include/asm-s390/spinlock_types.h
--- linux-2.6/include/asm-s390/spinlock_types.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock_types.h	2006-09-19 12:59:36.000000000 +0200
@@ -6,16 +6,16 @@
 #endif
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned int owner_cpu;
+	volatile unsigned int owner_pc;
 } __attribute__ ((aligned (4))) raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
 
 typedef struct {
 	volatile unsigned int lock;
-	volatile unsigned int owner_pc;
 } raw_rwlock_t;
 
-#define __RAW_RW_LOCK_UNLOCKED		{ 0, 0 }
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
 
 #endif
