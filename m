Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752339AbWCPKwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbWCPKwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbWCPKwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:52:18 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:5779 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752325AbWCPKwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:52:17 -0500
Date: Thu, 16 Mar 2006 16:22:36 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: [1/5 PATCH] Kprobes-fix-broken-fault-handling-for-i386
Message-ID: <20060316105236.GB16392@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch provides proper kprobes fault handling, if a user-specified
pre/post handlers tries to access user address space, through
copy_from_user(), get_user() etc. The user-specified fault handler
gets called only if the fault occurs while executing user-specified
handlers. In such a case user-specified handler is allowed to fix it
first, later if the user-specifed fault handler does not fix it, we
try to fix it by calling fix_exception(). The user-specified handler
will not be called if the fault happens when single stepping the
original instruction, instead we reset the current probe and allow the
system page fault handler to fix it up.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/i386/kernel/kprobes.c |   57 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 50 insertions(+), 7 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-i386-pagefault-handling arch/i386/kernel/kprobes.c
--- linux-2.6.16-rc6-mm1/arch/i386/kernel/kprobes.c~kprobes-i386-pagefault-handling	2006-03-16 15:57:57.000000000 +0530
+++ linux-2.6.16-rc6-mm1-prasanna/arch/i386/kernel/kprobes.c	2006-03-16 15:57:57.000000000 +0530
@@ -35,6 +35,7 @@
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/desc.h>
+#include <asm/uaccess.h>
 
 void jprobe_return_end(void);
 
@@ -544,15 +545,57 @@ static inline int kprobe_fault_handler(s
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
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
+		 * kprobe and the eip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->eip = (unsigned long)cur->addr;
 		regs->eflags |= kcb->kprobe_old_eflags;
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
+		if (fixup_exception(regs))
+			return 1;
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
