Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUFCMNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUFCMNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUFCMNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:13:09 -0400
Received: from ozlabs.org ([203.10.76.45]:41111 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263301AbUFCMNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:13:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.5688.698371.260931@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 22:14:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Fix preemptible check
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben H added a check in a couple of places to make sure that we had
preemption disabled when we call enable_kernel_{fp,altivec}.
Unfortunately the check he used trips in the case when
CONFIG_PREEMPT=n.  This patch fixes it by defining a preemptible()
macro (which reduces to 0 when CONFIG_PREEMPT=n) and doing
WARN_ON(preemptible()).

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/process.c pmac-2.5/arch/ppc/kernel/process.c
--- linux-2.5/arch/ppc/kernel/process.c	2004-05-11 07:53:04.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/process.c	2004-06-03 12:13:02.000000000 +1000
@@ -163,7 +163,7 @@
 void
 enable_kernel_altivec(void)
 {
-	WARN_ON(current_thread_info()->preempt_count == 0 && !irqs_disabled());
+	WARN_ON(preemptible());
 
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
@@ -180,7 +180,7 @@
 void
 enable_kernel_fp(void)
 {
-	WARN_ON(current_thread_info()->preempt_count == 0 && !irqs_disabled());
+	WARN_ON(preemptible());
 
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
diff -urN linux-2.5/include/asm-ppc/hardirq.h pmac-2.5/include/asm-ppc/hardirq.h
--- linux-2.5/include/asm-ppc/hardirq.h	2003-09-24 10:56:02.000000000 +1000
+++ pmac-2.5/include/asm-ppc/hardirq.h	2004-06-03 21:36:45.938019448 +1000
@@ -83,11 +83,15 @@
 
 #ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
+
 #else
 # define in_atomic()	(preempt_count() != 0)
+# define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
