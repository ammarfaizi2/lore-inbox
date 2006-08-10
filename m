Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWHJTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWHJTsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWHJTrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:47:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:28049 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932676AbWHJThX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:23 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [123/145] i386: make fault notifier unconditional and export it
Message-Id: <20060810193722.8082B13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:22 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

It's needed for external debuggers and overhead is very small.

Also make the actual notifier chain they use static

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/mm/fault.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -40,8 +40,7 @@
 #define PF_RSVD	(1<<3)
 #define PF_INSTR	(1<<4)
 
-#ifdef CONFIG_KPROBES
-ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
+static ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 /* Hook to register for page fault notifications */
 int register_page_fault_notifier(struct notifier_block *nb)
@@ -49,11 +48,13 @@ int register_page_fault_notifier(struct 
 	vmalloc_sync_all();
 	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
 }
+EXPORT_SYMBOL_GPL(register_page_fault_notifier);
 
 int unregister_page_fault_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
 }
+EXPORT_SYMBOL_GPL(unregister_page_fault_notifier);
 
 static inline int notify_page_fault(enum die_val val, const char *str,
 			struct pt_regs *regs, long err, int trap, int sig)
@@ -67,13 +68,6 @@ static inline int notify_page_fault(enum
 	};
 	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
 }
-#else
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
-{
-	return NOTIFY_DONE;
-}
-#endif
 
 void bust_spinlocks(int yes)
 {
