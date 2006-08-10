Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWHJTnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWHJTnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWHJThc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:4076 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932666AbWHJThJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:09 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [109/145] x86_64: Convert modlist_lock to be a raw spinlock
Message-Id: <20060810193707.9DE2013C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:07 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This is a preparationary patch for converting stacktrace over to the
new dwarf2 unwinder. lockdep uses stacktrace and the new unwinder
takes the modlist_lock so using a normal spinlock would cause a deadlock.
Use a raw lock instead.

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 kernel/module.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -59,7 +59,7 @@
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
 /* Protects module list */
-static DEFINE_SPINLOCK(modlist_lock);
+static raw_spinlock_t modlist_lock = __RAW_SPIN_LOCK_UNLOCKED;
 
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DEFINE_MUTEX(module_mutex);
@@ -751,11 +751,13 @@ void __symbol_put(const char *symbol)
 	unsigned long flags;
 	const unsigned long *crc;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	raw_local_save_flags(flags);
+	__raw_spin_lock(&modlist_lock);
 	if (!__find_symbol(symbol, &owner, &crc, 1))
 		BUG();
 	module_put(owner);
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	__raw_spin_unlock(&modlist_lock);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__symbol_put);
 
@@ -1134,11 +1136,13 @@ void *__symbol_get(const char *symbol)
 	unsigned long value, flags;
 	const unsigned long *crc;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	raw_local_save_flags(flags);
+	__raw_spin_lock(&modlist_lock);
 	value = __find_symbol(symbol, &owner, &crc, 1);
 	if (value && !strong_try_module_get(owner))
 		value = 0;
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	__raw_spin_unlock(&modlist_lock);
+	raw_local_irq_restore(flags);
 
 	return (void *)value;
 }
@@ -2141,7 +2145,8 @@ const struct exception_table_entry *sear
 	const struct exception_table_entry *e = NULL;
 	struct module *mod;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	raw_local_save_flags(flags);
+	__raw_spin_lock(&modlist_lock);
 	list_for_each_entry(mod, &modules, list) {
 		if (mod->num_exentries == 0)
 			continue;
@@ -2152,7 +2157,8 @@ const struct exception_table_entry *sear
 		if (e)
 			break;
 	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	__raw_spin_unlock(&modlist_lock);
+	raw_local_irq_restore(flags);
 
 	/* Now, if we found one, we are running inside it now, hence
            we cannot unload the module, hence no refcnt needed. */
@@ -2166,19 +2172,20 @@ int is_module_address(unsigned long addr
 {
 	unsigned long flags;
 	struct module *mod;
+	int ret = 0;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-
+	raw_local_save_flags(flags);
+	__raw_spin_lock(&modlist_lock);
 	list_for_each_entry(mod, &modules, list) {
 		if (within(addr, mod->module_core, mod->core_size)) {
-			spin_unlock_irqrestore(&modlist_lock, flags);
-			return 1;
+			ret = 1;
+			break;
 		}
 	}
+	__raw_spin_unlock(&modlist_lock);
+	raw_local_irq_restore(flags);
 
-	spin_unlock_irqrestore(&modlist_lock, flags);
-
-	return 0;
+	return ret;
 }
 
 
@@ -2199,9 +2206,12 @@ struct module *module_text_address(unsig
 	struct module *mod;
 	unsigned long flags;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	/* This is called from lockdep */
+	raw_local_save_flags(flags);
+	__raw_spin_lock(&modlist_lock);
 	mod = __module_text_address(addr);
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	__raw_spin_unlock(&modlist_lock);
+	raw_local_irq_restore(flags);
 
 	return mod;
 }
