Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbSLRGcL>; Wed, 18 Dec 2002 01:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbSLRGcL>; Wed, 18 Dec 2002 01:32:11 -0500
Received: from holomorphy.com ([66.224.33.161]:19131 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267197AbSLRGcJ>;
	Wed, 18 Dec 2002 01:32:09 -0500
Date: Tue, 17 Dec 2002 22:39:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: vm86 IRQ bugfix
Message-ID: <20021218063940.GF12812@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vm86 does broken tasklist scanning for matching task_struct pointers,
which is oopsable. This registers a notifier for it to GC vm86 IRQ's in
release_thread() and removes the broken tasklist scanning.

This bugfix is in 2.4.x and has been in 2.5.x-dj for an extended period
of time.

 arch/i386/kernel/process.c |    3 +++
 arch/i386/kernel/vm86.c    |   30 ------------------------------
 include/asm-i386/irq.h     |    1 +
 3 files changed, 4 insertions(+), 30 deletions(-)


diff -urpN wli-2.5.51-bk1-5/arch/i386/kernel/process.c wli-2.5.51-bk1-6/arch/i386/kernel/process.c
--- wli-2.5.51-bk1-5/arch/i386/kernel/process.c	2002-12-09 18:45:39.000000000 -0800
+++ wli-2.5.51-bk1-6/arch/i386/kernel/process.c	2002-12-11 18:33:21.000000000 -0800
@@ -44,6 +44,7 @@
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
+#include <asm/irq.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
@@ -269,6 +270,8 @@ void release_thread(struct task_struct *
 			BUG();
 		}
 	}
+
+	release_x86_irqs(dead_task);
 }
 
 /*
diff -urpN wli-2.5.51-bk1-5/arch/i386/kernel/vm86.c wli-2.5.51-bk1-6/arch/i386/kernel/vm86.c
--- wli-2.5.51-bk1-5/arch/i386/kernel/vm86.c	2002-12-09 18:45:43.000000000 -0800
+++ wli-2.5.51-bk1-6/arch/i386/kernel/vm86.c	2002-12-11 18:33:21.000000000 -0800
@@ -708,23 +708,6 @@ static inline void free_vm86_irq(int irq
 	spin_unlock_irqrestore(&irqbits_lock, flags);	
 }
 
-static inline int task_valid(struct task_struct *tsk)
-{
-	struct task_struct *g, *p;
-	int ret = 0;
-
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p)
-		if ((p == tsk) && (p->sig)) {
-			ret = 1;
-			goto out;
-		}
-	while_each_thread(g, p);
-out:
-	read_unlock(&tasklist_lock);
-	return ret;
-}
-
 void release_x86_irqs(struct task_struct *task)
 {
 	int i;
@@ -733,17 +716,6 @@ void release_x86_irqs(struct task_struct
 		free_vm86_irq(i);
 }
 
-static inline void handle_irq_zombies(void)
-{
-	int i;
-	for (i=3; i<16; i++) {
-		if (vm86_irqs[i].tsk) {
-			if (task_valid(vm86_irqs[i].tsk)) continue;
-			free_vm86_irq(i);
-		}
-	}
-}
-
 static inline int get_and_reset_irq(int irqnumber)
 {
 	int bit;
@@ -772,7 +744,6 @@ static int do_vm86_irq_handling(int subf
 		case VM86_REQUEST_IRQ: {
 			int sig = irqnumber >> 8;
 			int irq = irqnumber & 255;
-			handle_irq_zombies();
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
 			if ( (irq<3) || (irq>15) ) return -EPERM;
@@ -784,7 +755,6 @@ static int do_vm86_irq_handling(int subf
 			return irq;
 		}
 		case  VM86_FREE_IRQ: {
-			handle_irq_zombies();
 			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
 			if (!vm86_irqs[irqnumber].tsk) return 0;
 			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
diff -urpN wli-2.5.51-bk1-5/include/asm-i386/irq.h wli-2.5.51-bk1-6/include/asm-i386/irq.h
--- wli-2.5.51-bk1-5/include/asm-i386/irq.h	2002-12-09 18:45:44.000000000 -0800
+++ wli-2.5.51-bk1-6/include/asm-i386/irq.h	2002-12-11 18:33:21.000000000 -0800
@@ -23,6 +23,7 @@ static __inline__ int irq_cannonicalize(
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
+extern void release_x86_irqs(struct task_struct *);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
