Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752352AbWCPKxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbWCPKxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbWCPKxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:53:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:56986 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752353AbWCPKxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:53:45 -0500
Date: Thu, 16 Mar 2006 16:24:04 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [2/5 PATCH] Kprobes-fix-broken-fault-handling-for-x86_64
Message-ID: <20060316105404.GC16392@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060316105236.GB16392@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316105236.GB16392@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the broken kprobes fault handling similar
to i386 architecture.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/x86_64/kernel/kprobes.c |   62 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 55 insertions(+), 7 deletions(-)

diff -puN arch/x86_64/kernel/kprobes.c~kprobes-x86_64-pagefault-handling arch/x86_64/kernel/kprobes.c
--- linux-2.6.16-rc6-mm1/arch/x86_64/kernel/kprobes.c~kprobes-x86_64-pagefault-handling	2006-03-16 15:58:14.000000000 +0530
+++ linux-2.6.16-rc6-mm1-prasanna/arch/x86_64/kernel/kprobes.c	2006-03-16 15:58:15.000000000 +0530
@@ -37,10 +37,12 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/preempt.h>
+#include <linux/module.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
+#include <asm/uaccess.h>
 
 void jprobe_return_end(void);
 static void __kprobes arch_copy_kprobe(struct kprobe *p);
@@ -578,16 +580,62 @@ int __kprobes kprobe_fault_handler(struc
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	const struct exception_table_entry *fixup;
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
-
-	if (kcb->kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(cur, regs, kcb);
+	switch(kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the rip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->rip = (unsigned long)cur->addr;
 		regs->eflags |= kcb->kprobe_old_rflags;
-
-		reset_current_kprobe();
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
+		 * In case the user-specified fault handler returned
+		 * zero, try to fix up.
+		 */
+		fixup = search_exception_tables(regs->rip);
+		if (fixup) {
+			regs->rip = fixup->fixup;
+			return 1;
+		}
+
+		/*
+		 * fixup() could not handle it,
+		 * Let do_page_fault() fix it.
+		 */
+		break;
+	default:
+		break;
 	}
 	return 0;
 }

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
