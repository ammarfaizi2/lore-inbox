Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWDSWcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWDSWcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDSWcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:32:18 -0400
Received: from mga06.intel.com ([134.134.136.21]:21341 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751152AbWDSWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:31:47 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25199665:sNHT57046934"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25987165:sNHT76754293"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25223857:sNHT58513049"
Message-Id: <20060419221948.208154242@csdlinux-2.jf.intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 15:14:23 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(resend)patch 4/7] Notify page fault call chain for powerpc
Content-Disposition: inline; filename=notify_page_fault_powerpc.patch
X-OriginalArrivalTime: 19 Apr 2006 22:31:42.0780 (UTC) FILETIME=[088C5FC0:01C66401]
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
 arch/powerpc/kernel/traps.c  |   11 +++++++++++
 arch/powerpc/mm/fault.c      |    2 +-
 include/asm-powerpc/kdebug.h |    9 +++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6.17-rc1-mm3/arch/powerpc/kernel/traps.c
@@ -75,6 +75,7 @@ EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
 ATOMIC_NOTIFIER_HEAD(powerpc_die_chain);
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -88,6 +89,16 @@ int unregister_die_notifier(struct notif
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
 /*
  * Trap & Exception support
  */
Index: linux-2.6.17-rc1-mm3/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/powerpc/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/powerpc/mm/fault.c
@@ -142,7 +142,7 @@ int __kprobes do_page_fault(struct pt_re
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
@@ -18,7 +18,10 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head powerpc_die_chain;
+extern struct atomic_notifier_head notify_page_fault_chain;
 
 /* Grossly misnamed. */
 enum die_val {
@@ -36,5 +39,11 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&powerpc_die_chain, val, &args);
 }
 
+static inline int notify_page_fault(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
+	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KDEBUG_H */

--
