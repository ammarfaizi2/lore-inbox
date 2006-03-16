Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752342AbWCPKyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbWCPKyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbWCPKyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:54:46 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:31952 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752341AbWCPKyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:54:45 -0500
Date: Thu, 16 Mar 2006 16:25:09 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [3/5 PATCH] Kprobes-fix-broken-fault-handling-for-powerpc64
Message-ID: <20060316105509.GD16392@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060316105236.GB16392@in.ibm.com> <20060316105404.GC16392@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316105404.GC16392@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the broken kprobes fault handling similar
to i386 architecture.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/powerpc/kernel/kprobes.c |   61 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 54 insertions(+), 7 deletions(-)

diff -puN arch/powerpc/kernel/kprobes.c~kprobes-powerpc-pagefault-handling arch/powerpc/kernel/kprobes.c
--- linux-2.6.16-rc6-mm1/arch/powerpc/kernel/kprobes.c~kprobes-powerpc-pagefault-handling	2006-03-16 15:58:45.000000000 +0530
+++ linux-2.6.16-rc6-mm1-prasanna/arch/powerpc/kernel/kprobes.c	2006-03-16 15:58:45.000000000 +0530
@@ -30,9 +30,11 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
+#include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/sstep.h>
+#include <asm/uaccess.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -372,17 +374,62 @@ static inline int kprobe_fault_handler(s
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	const struct exception_table_entry *entry;
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
-
-	if (kcb->kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(cur, regs);
+	switch(kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the nip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->nip = (unsigned long)cur->addr;
 		regs->msr &= ~MSR_SE;
 		regs->msr |= kcb->kprobe_saved_msr;
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
+		if ((entry = search_exception_tables(regs->nip)) != NULL) {
+			regs->nip = entry->fixup;
+			return 1;
+		}
+
+		/*
+		 * fixup_exception() could not handle it,
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
