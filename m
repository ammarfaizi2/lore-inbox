Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWDSTN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWDSTN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWDSTNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:13:39 -0400
Received: from mga06.intel.com ([134.134.136.21]:60840 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751026AbWDSTNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:34 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113902:sNHT33413653"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113876:sNHT52605168"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25902692:sNHT19270846"
Message-Id: <20060419190134.862282078@csdlinux-2.jf.intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:01:01 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: [patch 2/6] Notify page fault call chain for x86_64
Content-Disposition: inline; filename=notify_page_fault_x86_64.patch
X-OriginalArrivalTime: 19 Apr 2006 19:10:23.0524 (UTC) FILETIME=[E8C02E40:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/x86_64/kernel/traps.c  |   12 ++++++++++++
 arch/x86_64/mm/fault.c      |    4 ++--
 include/asm-x86_64/kdebug.h |   16 ++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm3/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.17-rc1-mm3/arch/x86_64/kernel/traps.c
@@ -71,6 +71,7 @@ asmlinkage void machine_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 
 ATOMIC_NOTIFIER_HEAD(die_chain);
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -85,6 +86,17 @@ int unregister_die_notifier(struct notif
 }
 EXPORT_SYMBOL(unregister_die_notifier);
 
+int register_page_fault_notifier(struct notifier_block *nb)
+{
+	vmalloc_sync_all();
+	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
+}
+
+int unregister_page_fault_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
+}
+
 static inline void conditional_sti(struct pt_regs *regs)
 {
 	if (regs->eflags & X86_EFLAGS_IF)
Index: linux-2.6.17-rc1-mm3/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/x86_64/mm/fault.c
@@ -348,7 +348,7 @@ asmlinkage void __kprobes do_page_fault(
 			if (vmalloc_fault(address) >= 0)
 				return;
 		}
-		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
 			return;
 		/*
@@ -358,7 +358,7 @@ asmlinkage void __kprobes do_page_fault(
 		goto bad_area_nosemaphore;
 	}
 
-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 					SIGSEGV) == NOTIFY_STOP)
 		return;
 
Index: linux-2.6.17-rc1-mm3/include/asm-x86_64/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-x86_64/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-x86_64/kdebug.h
@@ -15,7 +15,10 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head die_chain;
+extern struct atomic_notifier_head notify_page_fault_chain;
 
 /* Grossly misnamed. */
 enum die_val {
@@ -47,6 +50,19 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&die_chain, val, &args);
 } 
 
+static inline int notify_page_fault(enum die_val val, const char *str,
+			struct pt_regs *regs, long err, int trap, int sig)
+{
+	struct die_args args = {
+		.regs = regs,
+		.str = str,
+		.err = err,
+		.trapnr = trap,
+		.signr = sig
+	};
+	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+}
+
 extern int printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);
 extern void __die(const char *,struct pt_regs *,long);

--
