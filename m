Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271282AbUJVMgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271282AbUJVMgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbUJVMf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:35:58 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49810 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S271260AbUJVMZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:20 -0400
Date: Fri, 22 Oct 2004 14:25:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/6] s390: sacf local root exploit (CAN-2004-0887).
Message-ID: <20041022122509.GB3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/6] s390: sacf local root exploit (CAN-2004-0887).

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Force user process back to home space mode in space switch event
   exception handler.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/traps.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletion(-)

diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2004-10-22 13:51:45.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2004-10-22 13:52:04.000000000 +0200
@@ -633,6 +633,21 @@
 	}
 }
 
+asmlinkage void space_switch_exception(struct pt_regs * regs, long int_code)
+{
+        siginfo_t info;
+
+	/* Set user psw back to home space mode. */
+	if (regs->psw.mask & PSW_MASK_PSTATE)
+		regs->psw.mask |= PSW_ASC_HOME;
+	/* Send SIGILL. */
+        info.si_signo = SIGILL;
+        info.si_errno = 0;
+        info.si_code = ILL_PRVOPC;
+        info.si_addr = get_check_address(regs);
+        do_trap(int_code, SIGILL, "space switch event", regs, &info);
+}
+
 asmlinkage void kernel_stack_overflow(struct pt_regs * regs)
 {
 	die("Kernel stack overflow", regs, 0);
@@ -676,7 +691,7 @@
         pgm_check_table[0x3B] = &do_dat_exception;
 #endif /* CONFIG_ARCH_S390X */
         pgm_check_table[0x15] = &operand_exception;
-        pgm_check_table[0x1C] = &privileged_op;
+        pgm_check_table[0x1C] = &space_switch_exception;
         pgm_check_table[0x1D] = &hfp_sqrt_exception;
 	pgm_check_table[0x40] = &do_monitor_call;
 
