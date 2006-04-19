Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWDSWeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWDSWeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWDSWcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:32:13 -0400
Received: from mga06.intel.com ([134.134.136.21]:21341 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751290AbWDSWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:31:47 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25199666:sNHT76902833"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25987172:sNHT49833217"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25987145:sNHT60025868"
Message-Id: <20060419221948.339390407@csdlinux-2.jf.intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 15:14:24 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(resend)patch 5/7] Notify page fault call chain for sparc64
Content-Disposition: inline; filename=notify_page_fault_sparc64.patch
X-OriginalArrivalTime: 19 Apr 2006 22:31:43.0295 (UTC) FILETIME=[08DAF4F0:01C66401]
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

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
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
