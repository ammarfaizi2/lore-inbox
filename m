Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWDTXvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWDTXvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDTXvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:06 -0400
Received: from mga06.intel.com ([134.134.136.21]:48206 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932141AbWDTXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:02 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813696:sNHT16687874"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831799:sNHT18140101"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813664:sNHT20889064"
Message-Id: <20060420233912.045800746@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:25:00 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 4/7] Notify page fault call chain for powerpc
Content-Disposition: inline; filename=notify_page_fault_powerpc.patch
X-OriginalArrivalTime: 20 Apr 2006 23:51:00.0036 (UTC) FILETIME=[4681C840:01C664D5]
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
 arch/powerpc/mm/fault.c      |   36 +++++++++++++++++++++++++++++++++++-
 include/asm-powerpc/kdebug.h |    2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/powerpc/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/powerpc/mm/fault.c
@@ -40,6 +40,40 @@
 #include <asm/kdebug.h>
 #include <asm/siginfo.h>
 
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
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
@@ -142,7 +176,7 @@ int __kprobes do_page_fault(struct pt_re
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
-	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs, error_code,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page_fault", regs, error_code,
 				11, SIGSEGV) == NOTIFY_STOP)
 		return 0;
 
Index: linux-2.6.17-rc1-mm3/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-powerpc/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-powerpc/kdebug.h
@@ -18,6 +18,8 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head powerpc_die_chain;
 
 /* Grossly misnamed. */

--
