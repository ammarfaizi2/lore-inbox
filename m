Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269406AbUICAHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269406AbUICAHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269375AbUICAHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:07:11 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33780 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269410AbUIBX6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:32 -0400
Date: Thu, 2 Sep 2004 20:02:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH][6/8] Arch agnostic completely out of line locks / arm
Message-ID: <Pine.LNX.4.58.0409021237000.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/arm/kernel/time.c              |   12 ++++++++++++
 arch/arm/kernel/vmlinux.lds.S       |    1 +
 arch/arm/oprofile/op_model_xscale.c |    4 ++--
 include/asm-arm/ptrace.h            |    5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/arm/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	2 Sep 2004 15:51:37 -0000
@@ -52,6 +52,18 @@ EXPORT_SYMBOL(rtc_lock);
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return regs->ARM_lr;
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 /*
  * hook for setting the RTC's idea of the current time.
Index: linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/arm/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/vmlinux.lds.S	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/vmlinux.lds.S	2 Sep 2004 13:08:12 -0000
@@ -71,6 +71,7 @@ SECTIONS
 		_text = .;		/* Text and read-only data	*/
 			*(.text)
 			SCHED_TEXT
+			LOCK_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 			*(.rodata)
Index: linux-2.6.9-rc1-mm1-stage/arch/arm/oprofile/op_model_xscale.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/arm/oprofile/op_model_xscale.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_xscale.c
--- linux-2.6.9-rc1-mm1-stage/arch/arm/oprofile/op_model_xscale.c	26 Aug 2004 13:13:05 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/arm/oprofile/op_model_xscale.c	2 Sep 2004 15:52:39 -0000
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

Index: linux-2.6.9-rc1-mm1-stage/include/asm-arm/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-arm/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-arm/ptrace.h	26 Aug 2004 13:13:12 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-arm/ptrace.h	2 Sep 2004 13:08:15 -0000
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
