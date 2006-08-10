Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWHJTsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWHJTsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWHJTro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:47:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:29329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932652AbWHJThY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:24 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [124/145] i386: make fault notifier unconditional and export it
Message-Id: <20060810193723.912C613B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:23 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

It's needed for external debuggers and overhead is very small.

Also make the actual notifier chain they use static

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/mm/fault.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

Index: linux/arch/i386/mm/fault.c
===================================================================
--- linux.orig/arch/i386/mm/fault.c
+++ linux/arch/i386/mm/fault.c
@@ -30,18 +30,20 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
-#ifdef CONFIG_KPROBES
-ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
+static ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
+
 int register_page_fault_notifier(struct notifier_block *nb)
 {
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
@@ -55,14 +57,6 @@ static inline int notify_page_fault(enum
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
-
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
