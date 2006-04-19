Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWDSTOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWDSTOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWDSTOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:14:04 -0400
Received: from mga06.intel.com ([134.134.136.21]:22134 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751179AbWDSTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:35 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113906:sNHT34990718"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113898:sNHT39960025"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113854:sNHT36467536"
Message-Id: <20060419190135.435255448@csdlinux-2.jf.intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:01:04 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: [patch 5/6] Notify page fault call chain for sparc64
Content-Disposition: inline; filename=notify_page_fault_sparc64.patch
X-OriginalArrivalTime: 19 Apr 2006 19:10:24.0555 (UTC) FILETIME=[E95D7FB0:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/sparc64/kernel/traps.c  |   11 +++++++++++
 arch/sparc64/mm/fault.c      |    2 +-
 include/asm-sparc64/kdebug.h |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/sparc64/kernel/traps.c
+++ linux-2.6.17-rc1-mm3/arch/sparc64/kernel/traps.c
@@ -44,6 +44,7 @@
 #endif
 
 ATOMIC_NOTIFIER_HEAD(sparc64die_chain);
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -57,6 +58,16 @@ int unregister_die_notifier(struct notif
 }
 EXPORT_SYMBOL(unregister_die_notifier);
 
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
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
  * code logs the trap state registers at every level in the trap
  * stack.  It is found at (pt_regs + sizeof(pt_regs)) and the layout
Index: linux-2.6.17-rc1-mm3/arch/sparc64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/sparc64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/sparc64/mm/fault.c
@@ -263,7 +263,7 @@ asmlinkage void __kprobes do_sparc64_fau
 
 	fault_code = get_thread_fault_code();
 
-	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page_fault", regs,
 		       fault_code, 0, SIGSEGV) == NOTIFY_STOP)
 		return;
 
Index: linux-2.6.17-rc1-mm3/include/asm-sparc64/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-sparc64/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-sparc64/kdebug.h
@@ -17,7 +17,10 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head sparc64die_chain;
+extern struct atomic_notifier_head notify_page_fault_chain;
 
 extern void bad_trap(struct pt_regs *, long);
 
@@ -46,4 +49,17 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&sparc64die_chain, val, &args);
 }
 
+static inline int notify_page_fault(enum die_val val,char *str, struct pt_regs *regs,
+			     long err, int trap, int sig)
+{
+	struct die_args args = { .regs		= regs,
+				 .str		= str,
+				 .err		= err,
+				 .trapnr	= trap,
+				 .signr		= sig };
+
+	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+}
+
+
 #endif

--
