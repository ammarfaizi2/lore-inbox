Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUIWFbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUIWFbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIWFbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:31:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12440 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268289AbUIWF33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:29:29 -0400
Date: Thu, 23 Sep 2004 11:00:29 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, Tom Rini <trini@kernel.crashing.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: [Patch] kprobes exception notifier fix 2.6.9-rc2
Message-ID: <20040923053029.GB1291@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In order to make other debuggers use exception notifiers, kprobes 
notifier return values are required to be modified. This patch modifies the
return values of kprobes notifier return values in a clean way.

Please let me know your comments.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-exceptions-notifier-fix.patch"


This patch modifies the return value of kprobes exceptions notify handler.
The kprobes exception notifier returns NOTIFY_STOP on handling notification.
This patch helps other debuggers to co-exists with the Kprobes. Other debuggers 
registered for exceptions notification must return NOTIFY_STOP on handling 
the notification.

Signed-off by : Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.9-rc2-prasanna/arch/i386/kernel/kprobes.c |   10 +++++-----
 linux-2.6.9-rc2-prasanna/arch/i386/kernel/traps.c   |   18 +++++++++---------
 linux-2.6.9-rc2-prasanna/arch/i386/mm/fault.c       |    2 +-
 linux-2.6.9-rc2-prasanna/include/linux/notifier.h   |    4 ++++
 linux-2.6.9-rc2-prasanna/kernel/kprobes.c           |    3 +++
 5 files changed, 22 insertions(+), 15 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-exceptions-nofitier-fix arch/i386/kernel/kprobes.c
--- linux-2.6.9-rc2/arch/i386/kernel/kprobes.c~kprobes-exceptions-nofitier-fix	2004-09-21 15:06:22.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/kernel/kprobes.c	2004-09-21 15:06:22.000000000 +0530
@@ -267,26 +267,26 @@ int kprobe_exceptions_notify(struct noti
 	switch (val) {
 	case DIE_INT3:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_DEBUG:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_GPF:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_PAGE_FAULT:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	default:
 		break;
 	}
-	return NOTIFY_BAD;
+	return NOTIFY_DONE;
 }
 
 int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
diff -puN arch/i386/kernel/traps.c~kprobes-exceptions-nofitier-fix arch/i386/kernel/traps.c
--- linux-2.6.9-rc2/arch/i386/kernel/traps.c~kprobes-exceptions-nofitier-fix	2004-09-21 15:06:22.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/kernel/traps.c	2004-09-21 15:06:22.000000000 +0530
@@ -422,7 +422,7 @@ static inline void do_trap(int trapnr, i
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
@@ -436,7 +436,7 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_BAD) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
 }
@@ -445,7 +445,7 @@ asmlinkage void do_##name(struct pt_regs
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
 }
@@ -459,7 +459,7 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
 }
@@ -498,7 +498,7 @@ gp_in_vm86:
 gp_in_kernel:
 	if (!fixup_exception(regs)) {
 		if (notify_die(DIE_GPF, "general protection fault", regs,
-				error_code, 13, SIGSEGV) == NOTIFY_OK);
+				error_code, 13, SIGSEGV) == NOTIFY_STOP);
 			return;
 		die("general protection fault", regs, error_code);
 	}
@@ -572,7 +572,7 @@ static void default_do_nmi(struct pt_reg
  
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
-							== NOTIFY_BAD)
+							== NOTIFY_STOP)
 			return;
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
@@ -587,7 +587,7 @@ static void default_do_nmi(struct pt_reg
 		unknown_nmi_error(reason, regs);
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
 		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
@@ -636,7 +636,7 @@ void unset_nmi_callback(void)
 asmlinkage int do_int3(struct pt_regs *regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
-			== NOTIFY_OK)
+			== NOTIFY_STOP)
 		return 1;
 	/* This is an interrupt gate, because kprobes wants interrupts
 	disabled.  Normal trap handlers don't. */
@@ -677,7 +677,7 @@ asmlinkage void do_debug(struct pt_regs 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
-					SIGTRAP) == NOTIFY_OK)
+					SIGTRAP) == NOTIFY_STOP)
 		return;
 	/* It's safe to allow irq's after DR6 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
diff -puN arch/i386/mm/fault.c~kprobes-exceptions-nofitier-fix arch/i386/mm/fault.c
--- linux-2.6.9-rc2/arch/i386/mm/fault.c~kprobes-exceptions-nofitier-fix	2004-09-21 15:06:22.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/mm/fault.c	2004-09-21 15:06:22.000000000 +0530
@@ -227,7 +227,7 @@ asmlinkage void do_page_fault(struct pt_
 	__asm__("movl %%cr2,%0":"=r" (address));
 
 	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_OK)
+					SIGSEGV) == NOTIFY_STOP)
 		return;
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
diff -puN kernel/kprobes.c~kprobes-exceptions-nofitier-fix kernel/kprobes.c
--- linux-2.6.9-rc2/kernel/kprobes.c~kprobes-exceptions-nofitier-fix	2004-09-21 15:06:22.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/kernel/kprobes.c	2004-09-21 15:06:22.000000000 +0530
@@ -25,6 +25,8 @@
  *		hlists and exceptions notifier as suggested by Andi Kleen.
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
+ *		exceptions notifier to be first on the priority list.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -108,6 +110,7 @@ void unregister_kprobe(struct kprobe *p)
 
 static struct notifier_block kprobe_exceptions_nb = {
 	.notifier_call = kprobe_exceptions_notify,
+	.priority = 0x7fffffff /* we need to notified first */
 };
 
 int register_jprobe(struct jprobe *jp)
diff -puN include/linux/notifier.h~kprobes-exceptions-nofitier-fix include/linux/notifier.h
--- linux-2.6.9-rc2/include/linux/notifier.h~kprobes-exceptions-nofitier-fix	2004-09-21 15:06:22.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/include/linux/notifier.h	2004-09-21 15:07:21.000000000 +0530
@@ -29,6 +29,10 @@ extern int notifier_call_chain(struct no
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
 #define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)	/* Bad/Veto action	*/
+/*
+ * Clean way to return from the notifier and stop further calls.
+ */
+#define NOTIFY_STOP		(NOTIFY_OK|NOTIFY_STOP_MASK)
 
 /*
  *	Declared notifiers so far. I can imagine quite a few more chains

_

--J/dobhs11T7y2rNN--
