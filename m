Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVHaTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVHaTxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHaTxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:53:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27089 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932528AbVHaTxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:53:33 -0400
Date: Wed, 31 Aug 2005 12:53:18 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: "Lynch, Rusty" <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] remove die_notifiers if CONFIG_DEBUG_KERNEL not set
Message-ID: <Pine.LNX.4.62.0508311247130.28674@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use of die_notifiers is a debugging feature that is only used if 
CONFIG_DEBUG_KERNEL is set. For a kernel without debugging there is no 
need of die notifiers. This will generate no code for notify_die if 
debugging is not on. Seems that there is an expectation that future distro 
releases will have CONFIG_KPROBES on. They will therefore also have 
CONFIG_DEBUG_KERNEL set and thus the die notifiers will work and the 
notifier will be enabled in do_ia64_page_fault.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.13/include/asm-ia64/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-ia64/kdebug.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/include/asm-ia64/kdebug.h	2005-08-31 12:35:17.000000000 -0700
@@ -35,14 +35,15 @@ struct die_args {
 	int signr;
 };
 
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *ia64die_chain;
-
 enum die_val {
 	DIE_BREAK = 1,
 	DIE_SS,
 	DIE_PAGE_FAULT,
 };
+#ifdef CONFIG_DEBUG_KERNEL
+extern struct notifier_block *ia64die_chain;
+
+int register_die_notifier(struct notifier_block *nb);
 
 static inline int notify_die(enum die_val val, char *str, struct pt_regs *regs,
 			     long err, int trap, int sig)
@@ -57,5 +58,11 @@ static inline int notify_die(enum die_va
 
 	return notifier_call_chain(&ia64die_chain, val, &args);
 }
+#else
+
+#define notify_die(val, str, regs, err, trap, sig) 0
+#define register_die_notifier(nb) do { } while (0)
+
+#endif
 
 #endif
Index: linux-2.6.13/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/traps.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/arch/ia64/kernel/traps.c	2005-08-31 12:35:17.000000000 -0700
@@ -28,6 +28,7 @@ extern spinlock_t timerlist_lock;
 fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
 
+#ifdef CONFIG_DEBUG_KERNEL
 struct notifier_block *ia64die_chain;
 static DEFINE_SPINLOCK(die_notifier_lock);
 
@@ -40,6 +41,7 @@ int register_die_notifier(struct notifie
 	spin_unlock_irqrestore(&die_notifier_lock, flags);
 	return err;
 }
+#endif
 
 void __init
 trap_init (void)
