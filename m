Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270009AbUIDAtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbUIDAtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270016AbUIDApz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:45:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:27844 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270009AbUIDAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:56 -0400
Date: Fri, 3 Sep 2004 20:40:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH][2/8] updated arch agnostic completely out of line locks /
 arm
Message-ID: <Pine.LNX.4.58.0409032018290.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/arm/kernel/time.c              |   17 ++++++++++++++++-
 arch/arm/kernel/vmlinux.lds.S       |    1 +
 arch/arm/oprofile/op_model_xscale.c |    4 ++--
 include/asm-arm/ptrace.h            |    5 +++++
 4 files changed, 24 insertions(+), 3 deletions(-)

Status: Untested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/arm/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/time.c	3 Sep 2004 01:30:18 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/time.c	3 Sep 2004 23:55:27 -0000
@@ -33,7 +33,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/leds.h>
-
+#include <asm/thread_info.h>
 #include <asm/mach/time.h>

 u64 jiffies_64 = INITIAL_JIFFIES;
@@ -52,6 +52,21 @@ EXPORT_SYMBOL(rtc_lock);
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long fp, pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end) {
+		fp = thread_saved_fp(current);
+		pc = pc_pointer(((unsigned long *)fp)[-1]);
+	}
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 /*
  * hook for setting the RTC's idea of the current time.
Index: linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/arm/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/vmlinux.lds.S	3 Sep 2004 01:30:18 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/arm/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -71,6 +71,7 @@ SECTIONS
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
 			SCHED_TEXT
+			LOCK_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: linux-2.6.9-rc1-bk9-sparc64/arch/arm/oprofile/op_model_xscale.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/arm/oprofile/op_model_xscale.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_xscale.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/arm/oprofile/op_model_xscale.c	3 Sep 2004 01:30:18 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/arm/oprofile/op_model_xscale.c	3 Sep 2004 23:55:27 -0000
@@ -343,7 +343,7 @@ static void inline __xsc2_check_ctrs(voi

 static irqreturn_t xscale_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long pc = profile_pc(regs);
 	int i, is_kernel = !user_mode(regs);
 	u32 pmnc;

@@ -357,7 +357,7 @@ static irqreturn_t xscale_pmu_interrupt(
 			continue;

 		write_counter(i, -(u32)results[i].reset_counter);
-		oprofile_add_sample(eip, is_kernel, i, smp_processor_id());
+		oprofile_add_sample(pc, is_kernel, i, smp_processor_id());
 		results[i].ovf--;
 	}

Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-arm/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-arm/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-arm/ptrace.h	3 Sep 2004 01:30:39 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-arm/ptrace.h	3 Sep 2004 23:55:27 -0000
@@ -130,7 +130,12 @@ static inline int valid_user_regs(struct

 #define instruction_pointer(regs) \
 	(pc_pointer((regs)->ARM_pc))
+
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif

 #ifdef __KERNEL__
 extern void show_regs(struct pt_regs *);
