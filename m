Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWDTXwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDTXwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDTXvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:15 -0400
Received: from mga07.intel.com ([143.182.124.22]:60687 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932147AbWDTXvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:04 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831834:sNHT884321613"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813678:sNHT20405749"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26631644:sNHT19777422"
Message-Id: <20060420233911.695671967@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:24:58 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 2/7] Notify page fault call chain for i386
Content-Disposition: inline; filename=notify_page_fault_i386.patch
X-OriginalArrivalTime: 20 Apr 2006 23:50:59.0255 (UTC) FILETIME=[460A9C70:01C664D5]
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
 arch/i386/mm/fault.c      |   38 ++++++++++++++++++++++++++++++++++++--
 include/asm-i386/kdebug.h |    2 ++
 2 files changed, 38 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm3/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/i386/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/i386/mm/fault.c
@@ -30,6 +30,40 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
+#ifdef CONFIG_KPROBES
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
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
+
 /*
  * Unlock any spinlocks which will prevent us from getting the
  * message out 
@@ -321,7 +355,7 @@ fastcall void __kprobes do_page_fault(st
 	if (unlikely(address >= TASK_SIZE)) {
 		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
 			return;
-		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
 			return;
 		/*
@@ -331,7 +365,7 @@ fastcall void __kprobes do_page_fault(st
 		goto bad_area_nosemaphore;
 	}
 
-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 					SIGSEGV) == NOTIFY_STOP)
 		return;
 
Index: linux-2.6.17-rc1-mm3/include/asm-i386/kdebug.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-i386/kdebug.h
+++ linux-2.6.17-rc1-mm3/include/asm-i386/kdebug.h
@@ -19,6 +19,8 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head i386die_chain;
 
 

--
