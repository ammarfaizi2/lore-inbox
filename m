Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752359AbWCPKz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbWCPKz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbWCPKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:55:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9446 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752358AbWCPKz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:55:58 -0500
Date: Thu, 16 Mar 2006 16:26:17 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [4/5 PATCH] Kprobes-fix-broken-fault-handling-for-ia64
Message-ID: <20060316105617.GE16392@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060316105236.GB16392@in.ibm.com> <20060316105404.GC16392@in.ibm.com> <20060316105509.GD16392@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316105509.GD16392@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the broken kprobes fault handling similar
to i386 architecture.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Acked-by: Anil S Keshavamurthy<anil.s.keshavamurthy@intel.com>


 arch/ia64/kernel/kprobes.c |   48 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff -puN arch/ia64/kernel/kprobes.c~kprobes-ia64-pagefault-handling arch/ia64/kernel/kprobes.c
--- linux-2.6.16-rc6-mm1/arch/ia64/kernel/kprobes.c~kprobes-ia64-pagefault-handling	2006-03-16 16:13:38.000000000 +0530
+++ linux-2.6.16-rc6-mm1-prasanna/arch/ia64/kernel/kprobes.c	2006-03-16 16:13:38.000000000 +0530
@@ -34,6 +34,7 @@
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 #include <asm/sections.h>
+#include <asm/uaccess.h>
 
 extern void jprobe_inst_return(void);
 
@@ -722,13 +723,50 @@ static int __kprobes kprobes_fault_handl
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
 
-	if (kcb->kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(cur, regs);
-		reset_current_kprobe();
+	switch(kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the instruction pointer points back to
+		 * the probe address and allow the page fault handler
+		 * to continue as a normal page fault.
+		 */
+		regs->cr_iip = ((unsigned long)cur->addr) & ~0xFULL;
+		ia64_psr(regs)->ri = ((unsigned long)cur->addr) & 0xf;
+		if (kcb->kprobe_status == KPROBE_REENTER)
+			restore_previous_kprobe(kcb);
+		else
+			reset_current_kprobe();
 		preempt_enable_no_resched();
+		break;
+	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SSDONE:
+		/*
+		 * We increment the nmissed count for accounting,
+		 * we can also use npre/npostfault count for accouting
+		 * these specific fault cases.
+		 */
+		kprobes_inc_nmissed_count(cur);
+
+		/*
+		 * We come here because instructions in the pre/post
+		 * handler caused the page_fault, this could happen
+		 * if handler tries to access user space by
+		 * copy_from_user(), get_user() etc. Let the
+		 * user-specified handler try to fix it first.
+		 */
+		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+			return 1;
+
+		/*
+		 * Let ia64_do_page_fault() fix it.
+		 */
+		break;
+	default:
+		break;
 	}
 
 	return 0;

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
