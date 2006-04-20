Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWDTXvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWDTXvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDTXvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:04 -0400
Received: from mga07.intel.com ([143.182.124.22]:18308 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932139AbWDTXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:02 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831823:sNHT18103232"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813668:sNHT18074546"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26631643:sNHT19995332"
Message-Id: <20060420233911.517917046@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:24:57 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 1/7] Notify page fault call chain for x86_64
Content-Disposition: inline; filename=notify_page_fault_x86_64.patch
X-OriginalArrivalTime: 20 Apr 2006 23:50:57.0833 (UTC) FILETIME=[4531A190:01C664D5]
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
 arch/x86_64/mm/fault.c      |   39 +++++++++++++++++++++++++++++++++++++--
 include/asm-x86_64/kdebug.h |    2 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm3/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/x86_64/mm/fault.c
@@ -41,6 +41,41 @@
 #define PF_RSVD	(1<<3)
 #define PF_INSTR	(1<<4)
 
+#ifdef CONFIG_KPROBES
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
+
+/* Hook to register for page fault notifications */
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
 void bust_spinlocks(int yes)
 {
 	int loglevel_save = console_loglevel;
@@ -348,7 +383,7 @@ asmlinkage void __kprobes do_page_fault(
 			if (vmalloc_fault(address) >= 0)
 				return;
 		}
-		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
 			return;
 		/*
@@ -358,7 +393,7 @@ asmlinkage void __kprobes do_page_fault(
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
@@ -15,6 +15,8 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head die_chain;
 
 /* Grossly misnamed. */

--
