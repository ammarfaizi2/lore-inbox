Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbUJ0GVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUJ0GVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbUJ0GTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:19:03 -0400
Received: from ozlabs.org ([203.10.76.45]:46028 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262298AbUJ0GPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:15:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16767.15609.66891.537673@cargo.ozlabs.ibm.com>
Date: Wed, 27 Oct 2004 16:15:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC/PPC64: Fix FP state corruption on UP
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately the patch Ben sent last week to fix a bug in the saving
and restoring of floating-point and altivec context across signal
handlers introduced another bug, which tends to corrupt the FP and
altivec contexts of other tasks.  This patch fixes the problem for
both ppc32 and ppc64.  Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/signal.c test/arch/ppc/kernel/signal.c
--- linux-2.5/arch/ppc/kernel/signal.c	2004-10-20 08:16:36.000000000 +1000
+++ test/arch/ppc/kernel/signal.c	2004-10-27 14:29:48.494955208 +1000
@@ -290,7 +290,7 @@
 
 	/* force the process to reload the FP registers from
 	   current->thread when it next does FP instructions */
-	regs->msr &= ~MSR_FP;
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
 	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
 			     sizeof(sr->mc_fregs)))
 		return 1;
@@ -330,9 +330,14 @@
 #endif /* CONFIG_SPE */
 
 #ifndef CONFIG_SMP
-	last_task_used_math = NULL;
-	last_task_used_altivec = NULL;
-	last_task_used_spe = NULL;
+	preempt_disable();
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+	if (last_task_used_altivec == current)
+		last_task_used_altivec = NULL;
+	if (last_task_used_spe == current)
+		last_task_used_spe = NULL;
+	preempt_enable();
 #endif
 	return 0;
 }
diff -urN linux-2.5/arch/ppc64/kernel/signal.c test/arch/ppc64/kernel/signal.c
--- linux-2.5/arch/ppc64/kernel/signal.c	2004-10-20 08:16:36.000000000 +1000
+++ test/arch/ppc64/kernel/signal.c	2004-10-27 14:31:57.301942136 +1000
@@ -224,8 +224,12 @@
 #endif /* CONFIG_ALTIVEC */
 
 #ifndef CONFIG_SMP
-	last_task_used_math = NULL;
-	last_task_used_altivec = NULL;
+	preempt_disable();
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+	if (last_task_used_altivec == current)
+		last_task_used_altivec = NULL;
+	preempt_enable();
 #endif
 	/* Force reload of FP/VEC */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC);
diff -urN linux-2.5/arch/ppc64/kernel/signal32.c test/arch/ppc64/kernel/signal32.c
--- linux-2.5/arch/ppc64/kernel/signal32.c	2004-10-20 08:16:36.000000000 +1000
+++ test/arch/ppc64/kernel/signal32.c	2004-10-27 14:32:45.086999136 +1000
@@ -235,8 +235,12 @@
 #endif /* CONFIG_ALTIVEC */
 
 #ifndef CONFIG_SMP
-	last_task_used_math = NULL;
-	last_task_used_altivec = NULL;
+	preempt_disable();
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+	if (last_task_used_altivec == current)
+		last_task_used_altivec = NULL;
+	preempt_enable();
 #endif
 	return 0;
 }
