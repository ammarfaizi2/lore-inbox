Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUH3En0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUH3En0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUH3En0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:43:26 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57073 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266366AbUH3EjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:39:25 -0400
Date: Mon, 30 Aug 2004 00:43:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][3/3] Completely out of line spinlocks / x86_64
Message-ID: <Pine.LNX.4.58.0408300031200.24991@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/x86_64/kernel/time.c        |   14 +++++++++++++
 arch/x86_64/kernel/vmlinux.lds.S |    1
 arch/x86_64/lib/Makefile         |    1
 arch/x86_64/lib/spinlock.c       |   42 +++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/ptrace.h      |    4 +++
 include/asm-x86_64/spinlock.h    |   42 +++++++--------------------------------
 6 files changed, 70 insertions(+), 34 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1/include/asm-x86_64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-x86_64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1/include/asm-x86_64/ptrace.h	26 Aug 2004 13:13:07 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/include/asm-x86_64/ptrace.h	30 Aug 2004 01:59:35 -0000
@@ -83,7 +83,11 @@ struct pt_regs {
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define instruction_pointer(regs) ((regs)->rip)
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);

 enum {
Index: linux-2.6.9-rc1-mm1/include/asm-x86_64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-x86_64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-mm1/include/asm-x86_64/spinlock.h	26 Aug 2004 13:13:07 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/include/asm-x86_64/spinlock.h	30 Aug 2004 02:09:26 -0000
@@ -42,34 +42,10 @@ typedef struct {
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
-	"test $0x200, %1\n\t" \
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
@@ -132,13 +108,12 @@ static inline void _raw_spin_lock(spinlo
 	__label__ here;
 here:
 	if (lock->magic != SPINLOCK_MAGIC) {
-printk("eip: %p\n", &&here);
+		printk("eip: %p\n", &&here);
 		BUG();
 	}
 #endif
-	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+
+	__spin_lock_loop(lock);
 }

 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -151,8 +126,7 @@ here:
 		BUG();
 	}
 #endif
-	__asm__ __volatile__(spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+	__spin_lock_loop_flags(lock, flags);
 }


Index: linux-2.6.9-rc1-mm1/arch/x86_64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/x86_64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1/arch/x86_64/kernel/time.c	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/x86_64/kernel/time.c	30 Aug 2004 02:08:08 -0000
@@ -26,6 +26,7 @@
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
+#include <linux/spinlock.h>
 #include <asm/8253pit.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
@@ -296,6 +297,19 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__spinlock_text_start &&
+	    pc <= (unsigned long)&__spinlock_text_end)
+		return *(unsigned long *)regs->rsp;
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
Index: linux-2.6.9-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S	28 Aug 2004 20:00:47 -0000
@@ -16,6 +16,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	SPINLOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: linux-2.6.9-rc1-mm1/arch/x86_64/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/x86_64/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.9-rc1-mm1/arch/x86_64/lib/Makefile	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/arch/x86_64/lib/Makefile	28 Aug 2004 20:00:47 -0000
@@ -13,3 +13,4 @@ lib-y += memcpy.o memmove.o memset.o cop

 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
+lib-$(CONFIG_SMP) += spinlock.o
Index: linux-2.6.9-rc1-mm1/arch/x86_64/lib/spinlock.c
===================================================================
RCS file: linux-2.6.9-rc1-mm1/arch/x86_64/lib/spinlock.c
diff -N linux-2.6.9-rc1-mm1/arch/x86_64/lib/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.9-rc1-mm1/arch/x86_64/lib/spinlock.c	28 Aug 2004 20:00:47 -0000
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
+				"2: test $0x200, %1\n\t"
+				"jz 3f\n\t"
+				"sti\n\t"
+				"3: rep; nop\n\t"
+				"cmpb $0, (%0)\n\t"
+				"jle 3b\n\t"
+				"cli\n\t"
+				"jmp 1b\n\t"
+				"4: nop\n\t"
+				: : "r"(lock), "r"(flags) : "memory");
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
+				: : "r"(lock) : "memory");
+}
+EXPORT_SYMBOL(__spin_lock_loop);
+
