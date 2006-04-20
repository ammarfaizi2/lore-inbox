Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWDTXwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWDTXwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWDTXvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:10 -0400
Received: from mga05.intel.com ([192.55.52.89]:445 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932146AbWDTXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:03 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26631676:sNHT19042499"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831819:sNHT25667348"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26631645:sNHT33399835"
Message-Id: <20060420233912.223913083@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:25:01 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 5/7] Notify page fault call chain for sparc64
Content-Disposition: inline; filename=notify_page_fault_sparc64.patch
X-OriginalArrivalTime: 20 Apr 2006 23:51:00.0114 (UTC) FILETIME=[468DAF20:01C664D5]
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
 arch/sparc64/mm/fault.c      |   36 +++++++++++++++++++++++++++++++++++-
 include/asm-sparc64/kdebug.h |    2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/sparc64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/sparc64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/sparc64/mm/fault.c
@@ -31,6 +31,40 @@
 #include <asm/kdebug.h>
 #include <asm/mmu_context.h>
 
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
  * To debug kernel to catch accesses to certain virtual/physical addresses.
  * Mode = 0 selects physical watchpoints, mode = 1 selects virtual watchpoints.
@@ -263,7 +297,7 @@ asmlinkage void __kprobes do_sparc64_fau
 
 	fault_code = get_thread_fault_code();
 
-	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page_fault", regs,
 		       fault_code, 0, SIGSEGV) == NOTIFY_STOP)
 		return;
 
Index: linux-2.6.17-rc1-mm3/include/asm-sparc64/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-sparc64/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-sparc64/kdebug.h
@@ -17,6 +17,8 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head sparc64die_chain;
 
 extern void bad_trap(struct pt_regs *, long);

--
