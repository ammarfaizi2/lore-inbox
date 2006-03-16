Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752365AbWCPK5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbWCPK5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbWCPK5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:57:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:39390 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752364AbWCPK5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:57:36 -0500
Date: Thu, 16 Mar 2006 16:28:00 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [5/5 PATCH] Kprobes-fix-broken-fault-handling-for-sparc64
Message-ID: <20060316105800.GF16392@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060316105236.GB16392@in.ibm.com> <20060316105404.GC16392@in.ibm.com> <20060316105509.GD16392@in.ibm.com> <20060316105617.GE16392@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316105617.GE16392@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the broken kprobes fault handling similar
to i386 architecture. I could not test this patch for sparc64.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/sparc64/kernel/kprobes.c |   66 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 60 insertions(+), 6 deletions(-)

diff -puN arch/sparc64/kernel/kprobes.c~kprobes-sparc64-pagefault-handling arch/sparc64/kernel/kprobes.c
--- linux-2.6.16-rc6-mm1/arch/sparc64/kernel/kprobes.c~kprobes-sparc64-pagefault-handling	2006-03-16 16:12:05.000000000 +0530
+++ linux-2.6.16-rc6-mm1-prasanna/arch/sparc64/kernel/kprobes.c	2006-03-16 16:12:05.000000000 +0530
@@ -6,9 +6,11 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 #include <asm/kdebug.h>
 #include <asm/signal.h>
 #include <asm/cacheflush.h>
+#include <asm/uaccess.h>
 
 /* We do not have hardware single-stepping on sparc64.
  * So we implement software single-stepping with breakpoint
@@ -302,16 +304,68 @@ static inline int kprobe_fault_handler(s
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	const struct exception_table_entry *entry;
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
+	switch(kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the tpc points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->tpc = (unsigned long) curr->addr;
+		regs->tnpc = kcb->kprobe_orig_tnpc;
+		regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
+				kcb->kprobe_orig_tstate_pil);
+		if (kcb->kprobe_status == KPROBE_REENTER)
+			restore_previous_kprobe(kcb);
+		else
+			reset_current_kprobe();
+		preempt_enable_no_resched();
+		break;
+	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SSDONE:
+		/*
+		 * We increment the nmissed count for accounting,
+		 * we can also use npre/npostfault count for accouting
+		 * these specific fault cases.
+		 */
+		kprobes_inc_nmissed_count(cur);
 
-	if (kcb->kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(cur, regs, kcb);
+		/*
+		 * We come here because instructions in the pre/post
+		 * handler caused the page_fault, this could happen
+		 * if handler tries to access user space by
+		 * copy_from_user(), get_user() etc. Let the
+		 * user-specified handler try to fix it first.
+		 */
+		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+			return 1;
 
-		reset_current_kprobe();
-		preempt_enable_no_resched();
+		/*
+		 * In case the user-specified fault handler returned
+		 * zero, try to fix up.
+		 */
+
+		entry = search_exception_tables(regs->tpc);
+		if (entry) {
+			regs->tpc = entry->fixup;
+			regs->tnpc = regs->tpc + 4;
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
+
 	return 0;
 }
 

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
