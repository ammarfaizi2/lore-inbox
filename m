Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWDSTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWDSTNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDSTNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:13:37 -0400
Received: from mga06.intel.com ([134.134.136.21]:22134 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751057AbWDSTNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:34 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113900:sNHT36192492"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113865:sNHT33163627"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25141599:sNHT21352443"
Message-Id: <20060419190135.031934727@csdlinux-2.jf.intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:01:02 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: [patch 3/6] Notify page fault call chain for ia64
Content-Disposition: inline; filename=notify_page_fault_ia64.patch
X-OriginalArrivalTime: 19 Apr 2006 19:10:23.0118 (UTC) FILETIME=[E8823AE0:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/ia64/kernel/traps.c  |   11 +++++++++++
 arch/ia64/mm/fault.c      |    2 +-
 include/asm-ia64/kdebug.h |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/ia64/kernel/traps.c
+++ linux-2.6.17-rc1-mm3/arch/ia64/kernel/traps.c
@@ -31,6 +31,7 @@ fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
 
 ATOMIC_NOTIFIER_HEAD(ia64die_chain);
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 int
 register_die_notifier(struct notifier_block *nb)
@@ -46,6 +47,16 @@ unregister_die_notifier(struct notifier_
 }
 EXPORT_SYMBOL_GPL(unregister_die_notifier);
 
+int register_page_fault_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
+}
+
+int unregister_page_fault_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
+}
+
 void __init
 trap_init (void)
 {
Index: linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/ia64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
@@ -84,7 +84,7 @@ ia64_do_page_fault (unsigned long addres
 	/*
 	 * This is to handle the kprobes on user space access instructions
 	 */
-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
 					SIGSEGV) == NOTIFY_STOP)
 		return;
 
Index: linux-2.6.17-rc1-mm3/include/asm-ia64/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-ia64/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-ia64/kdebug.h
@@ -40,7 +40,10 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head ia64die_chain;
+extern struct atomic_notifier_head notify_page_fault_chain;
 
 enum die_val {
 	DIE_BREAK = 1,
@@ -86,4 +89,17 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&ia64die_chain, val, &args);
 }
 
+static inline int notify_page_fault(enum die_val val, char *str, struct pt_regs *regs,
+			     long err, int trap, int sig)
+{
+	struct die_args args = {
+		.regs   = regs,
+		.str    = str,
+		.err    = err,
+		.trapnr = trap,
+		.signr  = sig
+	};
+
+	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+}
 #endif

--
