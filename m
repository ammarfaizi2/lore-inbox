Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWHJUQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHJUQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWHJUQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:16:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932523AbWHJTft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:49 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [34/145] i386: Account spinlocks to the caller during profiling for !FP kernels
Message-Id: <20060810193547.F02F513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:47 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This ports the algorithm from x86-64 (with improvements) to i386. 
Previously this only worked for frame pointer enabled kernels.
But spinlocks have a very simple stack frame that can be manually
analyzed. Do this.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/time.c   |   23 +++++++++++++++++++----
 include/asm-i386/ptrace.h |    4 ----
 kernel/spinlock.c         |    5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c
+++ linux/arch/i386/kernel/time.c
@@ -130,18 +130,33 @@ static int set_rtc_mmss(unsigned long no
 
 int timer_ack;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (!user_mode_vm(regs) && in_lock_functions(pc))
+#ifdef CONFIG_SMP
+	if (!user_mode_vm(regs) && in_lock_functions(pc)) {
+#ifdef CONFIG_FRAME_POINTER
 		return *(unsigned long *)(regs->ebp + 4);
-
+#else
+		unsigned long *sp;
+		if ((regs->xcs & 3) == 0)
+			sp = (unsigned long *)&regs->esp;
+		else
+			sp = (unsigned long *)regs->esp;
+		/* Return address is either directly at stack pointer
+		   or above a saved eflags. Eflags has bits 22-31 zero,
+		   kernel addresses don't. */
+ 		if (sp[0] >> 22)
+			return sp[0];
+		if (sp[1] >> 22)
+			return sp[1];
+#endif
+	}
+#endif
 	return pc;
 }
 EXPORT_SYMBOL(profile_pc);
-#endif
 
 /*
  * This is the same as the above, except we _also_ save the current
Index: linux/include/asm-i386/ptrace.h
===================================================================
--- linux.orig/include/asm-i386/ptrace.h
+++ linux/include/asm-i386/ptrace.h
@@ -80,11 +80,7 @@ static inline int user_mode_vm(struct pt
 	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
 }
 #define instruction_pointer(regs) ((regs)->eip)
-#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
-#else
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
 #endif /* __KERNEL__ */
 
 #endif
Index: linux/kernel/spinlock.c
===================================================================
--- linux.orig/kernel/spinlock.c
+++ linux/kernel/spinlock.c
@@ -7,6 +7,11 @@
  *
  * This file contains the spinlock/rwlock implementations for the
  * SMP and the DEBUG_SPINLOCK cases. (UP-nondebug inlines them)
+ *
+ * Note that some architectures have special knowledge about the
+ * stack frames of these functions in their profile_pc. If you
+ * change anything significant here that could change the stack
+ * frame contact the architecture maintainers.
  */
 
 #include <linux/linkage.h>
