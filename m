Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbULNWbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbULNWbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULNW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:29:08 -0500
Received: from motgate8.mot.com ([129.188.136.8]:29903 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261716AbULNW0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:26:19 -0500
Date: Tue, 14 Dec 2004 16:26:06 -0600 (CST)
From: Kumar Gala <galak@linen.sps.mot.com>
To: linus@osdl.org
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix SPE state corruption on e500
Message-ID: <Pine.LNX.4.61.0412141602320.17357@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Unfortunately the restoring of SPE state was causing data corruption since 
we were restoring based on the size of the altivec context and not 
the SPE context.  Also, fixed setting of last_task_used_spe on 
start_thread, flush_thread, and exit_thread.

Patch should go in for 2.6.10.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
--- a/arch/ppc/kernel/process.c	2004-12-14 15:59:07 -06:00
+++ b/arch/ppc/kernel/process.c	2004-12-14 15:59:07 -06:00
@@ -321,7 +321,7 @@
 	trap = TRAP(regs);
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar, regs->dsisr);
-	printk("TASK = %p[%d] '%s' THREAD: %p",
+	printk("TASK = %p[%d] '%s' THREAD: %p\n",
 	       current, current->pid, current->comm, current->thread_info);
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
@@ -370,6 +370,10 @@
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+#ifdef CONFIG_SPE
+	if (last_task_used_spe == current)
+		last_task_used_spe = NULL;
+#endif
 }
 
 void flush_thread(void)
@@ -378,6 +382,10 @@
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+#ifdef CONFIG_SPE
+	if (last_task_used_spe == current)
+		last_task_used_spe = NULL;
+#endif
 }
 
 void
@@ -480,6 +488,10 @@
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+#ifdef CONFIG_SPE
+	if (last_task_used_spe == current)
+		last_task_used_spe = NULL;
+#endif
 	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
 	current->thread.fpscr = 0;
 #ifdef CONFIG_ALTIVEC
diff -Nru a/arch/ppc/kernel/signal.c b/arch/ppc/kernel/signal.c
--- a/arch/ppc/kernel/signal.c	2004-12-14 15:59:07 -06:00
+++ b/arch/ppc/kernel/signal.c	2004-12-14 15:59:07 -06:00
@@ -319,7 +319,7 @@
 	if (!__get_user(msr, &sr->mc_gregs[PT_MSR]) && (msr & MSR_SPE) != 0) {
 		/* restore spe registers from the stack */
 		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
-				     sizeof(sr->mc_vregs)))
+				     ELF_NEVRREG * sizeof(u32)))
 			return 1;
 	} else if (current->thread.used_spe)
 		memset(&current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
