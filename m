Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUH3Elh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUH3Elh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUH3ElZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:41:25 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:55793 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266281AbUH3EjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:39:21 -0400
Date: Mon, 30 Aug 2004 00:43:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][2/3] Completely out of line spinlocks / i386
Message-ID: <Pine.LNX.4.58.0408300025460.24991@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

 arch/i386/kernel/time.c              |   13 ++++++++++
 arch/i386/kernel/vmlinux.lds.S       |    1
 arch/i386/lib/Makefile               |    1
 arch/i386/lib/spinlock.c             |   42 +++++++++++++++++++++++++++++++++++
 arch/i386/oprofile/op_model_athlon.c |    2 -
 arch/i386/oprofile/op_model_p4.c     |    2 -
 arch/i386/oprofile/op_model_ppro.c   |    2 -
 include/asm-i386/ptrace.h            |    4 +++
 include/asm-i386/spinlock.h          |   42 +++++------------------------------
 9 files changed, 71 insertions(+), 38 deletions(-)

Index: linux-2.6.9-rc1-mm1/include/asm-i386/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-i386/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1/include/asm-i386/ptrace.h	26 Aug 2004 13:13:13 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/include/asm-i386/ptrace.h	28 Aug 2004 20:00:47 -0000
@@ -57,7 +57,11 @@ struct pt_regs {
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
+#endif

 #endif
Index: linux-2.6.9-rc1-mm1/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-mm1/include/asm-i386/spinlock.h	26 Aug 2004 13:13:13 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/include/asm-i386/spinlock.h	28 Aug 2004 20:00:47 -0000
@@ -43,34 +43,10 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

-#define spin_lock_string \
-	"\n1:\t" \
-	"lock ; decb %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"rep;nop\n\t" \
-	"cmpb $0,%0\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
-
-#define spin_lock_string_flags \
-	"\n1:\t" \
-	"lock ; decb %0\n\t" \
-	"js 2f\n\t" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"testl $0x200, %1\n\t" \
-	"jz 3f\n\t" \
-	"sti\n\t" \
-	"3:\t" \
-	"rep;nop\n\t" \
-	"cmpb $0, %0\n\t" \
-	"jle 3b\n\t" \
-	"cli\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
+void fastcall __spin_lock_loop(spinlock_t *);
+void fastcall __spin_lock_loop_flags(spinlock_t *, unsigned long);
+extern unsigned long __spinlock_text_start;
+extern unsigned long __spinlock_text_end;

 /*
  * This works. Despite all the confusion.
@@ -137,12 +113,10 @@ here:
 		BUG();
 	}
 #endif
-	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+	__spin_lock_loop(lock);
 }

-static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
+static inline void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	__label__ here;
@@ -152,9 +126,7 @@ here:
 		BUG();
 	}
 #endif
-	__asm__ __volatile__(
-		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+	__spin_lock_loop_flags(lock, flags);
 }

 /*
Index: linux-2.6.9-rc1-mm1/arch/i386/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1/arch/i386/kernel/time.c	26 Aug 2004 13:12:51 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/kernel/time.c	28 Aug 2004 20:00:47 -0000
@@ -200,6 +200,19 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__spinlock_text_start &&
+	    pc <= (unsigned long)&__spinlock_text_end)
+		return *(unsigned long *)regs->esp;
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 /*
  * timer_interrupt() needs to keep up the real-time clock,
Index: linux-2.6.9-rc1-mm1/arch/i386/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1/arch/i386/kernel/vmlinux.lds.S	26 Aug 2004 13:12:51 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/kernel/vmlinux.lds.S	28 Aug 2004 20:00:47 -0000
@@ -18,6 +18,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	SPINLOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: linux-2.6.9-rc1-mm1/arch/i386/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.9-rc1-mm1/arch/i386/lib/Makefile	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/lib/Makefile	28 Aug 2004 20:00:47 -0000
@@ -6,6 +6,7 @@
 lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
 	bitops.o

+lib-$(CONFIG_SMP) += spinlock.o
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
Index: linux-2.6.9-rc1-mm1/arch/i386/lib/spinlock.c
===================================================================
RCS file: linux-2.6.9-rc1-mm1/arch/i386/lib/spinlock.c
diff -N linux-2.6.9-rc1-mm1/arch/i386/lib/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.9-rc1-mm1/arch/i386/lib/spinlock.c	28 Aug 2004 20:00:47 -0000
@@ -0,0 +1,42 @@
+/*
+ *	arch/i386/lib/spinlock.c
+ *	Copyright (C) 2004 Linus Torvalds
+ *
+ *	Author: Zwane Mwaikambo <zwane@fsmlabs.com>
+ */
+#include <linux/spinlock.h>
+#include <linux/module.h>
+
+#define __lockfunc fastcall __attribute__((section(".spinlock.text")))
+void __lockfunc __spin_lock_loop_flags(spinlock_t *lock, unsigned long flags)
+{
+	__asm__ __volatile__ (	"1: lock; decb (%0)\n\t"
+				"js 2f\n\t"
+				"jmp 4f\n\t"
+				"2: testl $0x200, %1\n\t"
+				"jz 3f\n\t"
+				"sti\n\t"
+				"3: rep; nop\n\t"
+				"cmpb $0, (%0)\n\t"
+				"jle 3b\n\t"
+				"cli\n\t"
+				"jmp 1b\n\t"
+				"4: nop\n\t"
+				: : "r"(&lock->lock), "r"(flags) : "memory");
+}
+EXPORT_SYMBOL(__spin_lock_loop_flags);
+
+void __lockfunc __spin_lock_loop(spinlock_t *lock)
+{
+	__asm__ __volatile__ (	"1: lock; decb (%0)\n\t"
+				"js 2f\n\t"
+				"jmp 3f\n\t"
+				"2: rep; nop\n\t"
+				"cmpb $0, (%0)\n\t"
+				"jle 2b\n\t"
+				"jmp 1b\n\t"
+				"3: nop\n\t"
+				: : "r"(&lock->lock) : "memory");
+}
+EXPORT_SYMBOL(__spin_lock_loop);
+
Index: linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_athlon.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_athlon.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_athlon.c
--- linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_athlon.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_athlon.c	28 Aug 2004 20:00:47 -0000
@@ -96,7 +96,7 @@ static int athlon_check_ctrs(unsigned in
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
Index: linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_p4.c
--- linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_p4.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_p4.c	28 Aug 2004 20:00:47 -0000
@@ -595,7 +595,7 @@ static int p4_check_ctrs(unsigned int co
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	stag = get_stagger();
Index: linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_ppro.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_ppro.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_ppro.c
--- linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_ppro.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_ppro.c	28 Aug 2004 20:00:47 -0000
@@ -91,7 +91,7 @@ static int ppro_check_ctrs(unsigned int
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
