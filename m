Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDSTNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDSTNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWDSTNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:13:35 -0400
Received: from mga06.intel.com ([134.134.136.21]:60840 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751052AbWDSTNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:33 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113887:sNHT39520544"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113855:sNHT46096918"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25902691:sNHT18391632"
Message-Id: <20060419190134.688167602@csdlinux-2.jf.intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:01:00 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: [patch 1/6] Notify page fault call chain for i386
Content-Disposition: inline; filename=notify_page_fault_i386.patch
X-OriginalArrivalTime: 19 Apr 2006 19:10:22.0618 (UTC) FILETIME=[E835EFA0:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/i386/kernel/traps.c  |   12 ++++++++++++
 arch/i386/mm/fault.c      |    4 ++--
 include/asm-i386/kdebug.h |   15 +++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm3/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/i386/kernel/traps.c
+++ linux-2.6.17-rc1-mm3/arch/i386/kernel/traps.c
@@ -93,6 +93,7 @@ asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
 ATOMIC_NOTIFIER_HEAD(i386die_chain);
+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -107,6 +108,17 @@ int unregister_die_notifier(struct notif
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
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
 	return	p > (void *)tinfo &&
Index: linux-2.6.17-rc1-mm3/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/arch/i386/mm/fault.c
+++ linux-2.6.17-rc1-mm3/arch/i386/mm/fault.c
@@ -321,7 +321,7 @@ fastcall void __kprobes do_page_fault(st
 	if (unlikely(address >= TASK_SIZE)) {
 		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
 			return;
-		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
 			return;
 		/*
@@ -331,7 +331,7 @@ fastcall void __kprobes do_page_fault(st
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
@@ -19,7 +19,10 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
+extern int register_page_fault_notifier(struct notifier_block *);
+extern int unregister_page_fault_notifier(struct notifier_block *);
 extern struct atomic_notifier_head i386die_chain;
+extern struct atomic_notifier_head notify_page_fault_chain;
 
 
 /* Grossly misnamed. */
@@ -53,4 +56,16 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&i386die_chain, val, &args);
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
 #endif

--
