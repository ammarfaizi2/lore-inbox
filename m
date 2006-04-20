Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDTXvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDTXvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDTXvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:17 -0400
Received: from mga07.intel.com ([143.182.124.22]:18308 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932149AbWDTXvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:04 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831832:sNHT1058184309"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813680:sNHT17970253"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813662:sNHT23227386"
Message-Id: <20060420233911.873960514@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:24:59 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 3/7] Notify page fault call chain for ia64
Content-Disposition: inline; filename=notify_page_fault_ia64.patch
X-OriginalArrivalTime: 20 Apr 2006 23:50:59.0239 (UTC) FILETIME=[46082B70:01C664D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overloading of page fault notification with the
notify_die() has performance issues(since the
only interested components for page fault is
kprobes and/or kdb) and hence this patch introduces
the new notifier call chain exclusively for page
fault notifications their by avoiding notifying
unnecessary components in the do_page_fault() code
path.

Changes since previous version:
1) Moved the implementaion of register/unregister_page_fault_notifier()
call to arch/xxx/mm/fault.c
2) Added #ifdef CONFIG_KPROBES around this register/unregister calls
as currently kprobes is the only potential user.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

---
 arch/ia64/mm/fault.c      |   36 +++++++++++++++++++++++++++++++++++-
 include/asm-ia64/kdebug.h |    2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/ia64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
@@ -19,6 +19,40 @@
 
 extern void die (char *, struct pt_regs *, long);
 
+#ifdef CONFIG_KPROBES
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
+
+/* Hook to register for page fault notifications */
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
+#else
+static inline int notify_page_fault(enum die_val val, const char *str,
+			struct pt_regs *regs, long err, int trap, int sig)
+{
+	return NOTIFY_DONE;
+}
+#endif
+
 /*
  * Return TRUE if ADDRESS points at a page in the kernel's mapped segment
  * (inside region 5, on ia64) and that page is present.
@@ -84,7 +118,7 @@ ia64_do_page_fault (unsigned long addres
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
@@ -40,6 +40,8 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head ia64die_chain;
 
 enum die_val {

--
