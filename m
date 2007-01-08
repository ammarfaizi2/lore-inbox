Return-Path: <linux-kernel-owner+w=401wt.eu-S1161282AbXAHN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbXAHN3q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbXAHN3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:29:46 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25670
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161282AbXAHN3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:29:45 -0500
Message-Id: <45A255AF.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 08 Jan 2007 13:31:11 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <patches@x86-64.org>
Subject: [PATCH] x86: simplify notify_page_fault()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all parameters from this function that aren't really variable.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc4/arch/i386/mm/fault.c	2007-01-08 09:57:20.000000000 +0100
+++ 2.6.20-rc4-x86-simplify-notify_page_fault/arch/i386/mm/fault.c	2007-01-08 10:32:45.000000000 +0100
@@ -46,17 +46,17 @@ int unregister_page_fault_notifier(struc
 }
 EXPORT_SYMBOL_GPL(unregister_page_fault_notifier);
 
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
+static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
 	struct die_args args = {
 		.regs = regs,
-		.str = str,
+		.str = "page fault",
 		.err = err,
-		.trapnr = trap,
-		.signr = sig
+		.trapnr = 14,
+		.signr = SIGSEGV
 	};
-	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+	return atomic_notifier_call_chain(&notify_page_fault_chain,
+	                                  DIE_PAGE_FAULT, &args);
 }
 
 /*
@@ -353,8 +353,7 @@ fastcall void __kprobes do_page_fault(st
 	if (unlikely(address >= TASK_SIZE)) {
 		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
 			return;
-		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-						SIGSEGV) == NOTIFY_STOP)
+		if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
 			return;
 		/*
 		 * Don't take the mm semaphore here. If we fixup a prefetch
@@ -363,8 +362,7 @@ fastcall void __kprobes do_page_fault(st
 		goto bad_area_nosemaphore;
 	}
 
-	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
 		return;
 
 	/* It's safe to allow irq's after cr2 has been saved and the vmalloc
--- linux-2.6.20-rc4/arch/x86_64/mm/fault.c	2007-01-08 09:57:27.000000000 +0100
+++ 2.6.20-rc4-x86-simplify-notify_page_fault/arch/x86_64/mm/fault.c	2007-01-08 10:33:11.000000000 +0100
@@ -56,17 +56,17 @@ int unregister_page_fault_notifier(struc
 }
 EXPORT_SYMBOL_GPL(unregister_page_fault_notifier);
 
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
+static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
 	struct die_args args = {
 		.regs = regs,
-		.str = str,
+		.str = "page fault",
 		.err = err,
-		.trapnr = trap,
-		.signr = sig
+		.trapnr = 14,
+		.signr = SIGSEGV
 	};
-	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+	return atomic_notifier_call_chain(&notify_page_fault_chain,
+	                                  DIE_PAGE_FAULT, &args);
 }
 
 void bust_spinlocks(int yes)
@@ -376,8 +376,7 @@ asmlinkage void __kprobes do_page_fault(
 			if (vmalloc_fault(address) >= 0)
 				return;
 		}
-		if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-						SIGSEGV) == NOTIFY_STOP)
+		if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
 			return;
 		/*
 		 * Don't take the mm semaphore here. If we fixup a prefetch
@@ -386,8 +385,7 @@ asmlinkage void __kprobes do_page_fault(
 		goto bad_area_nosemaphore;
 	}
 
-	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
 		return;
 
 	if (likely(regs->eflags & X86_EFLAGS_IF))


