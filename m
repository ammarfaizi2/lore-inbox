Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbTC0EAh>; Wed, 26 Mar 2003 23:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTC0EAh>; Wed, 26 Mar 2003 23:00:37 -0500
Received: from dp.samba.org ([66.70.73.150]:54721 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262791AbTC0EAe>;
	Wed, 26 Mar 2003 23:00:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor module cleanup 1/3
Date: Thu, 27 Mar 2003 15:10:48 +1100
Message-Id: <20030327041148.032A62C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Nobody uses symbol_put_addr yet, but it's
significantly neater to use module_text_addr which does the same "is
this in a module" search.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: module_text_address returns the module
Author: Rusty Russell
Status: Trivial

D: By making module_text_address return the module it found, we
D: simplify symbol_put_addr significantly.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19470-linux-2.5.66-bk2/include/linux/module.h .19470-linux-2.5.66-bk2.updated/include/linux/module.h
--- .19470-linux-2.5.66-bk2/include/linux/module.h	2003-03-25 12:17:31.000000000 +1100
+++ .19470-linux-2.5.66-bk2.updated/include/linux/module.h	2003-03-27 15:08:54.000000000 +1100
@@ -268,7 +268,7 @@ static inline int module_is_live(struct 
 }
 
 /* Is this address in a module? */
-int module_text_address(unsigned long addr);
+struct module *module_text_address(unsigned long addr);
 
 #ifdef CONFIG_MODULE_UNLOAD
 
@@ -361,9 +361,9 @@ search_module_extables(unsigned long add
 }
 
 /* Is this address in a module? */
-static inline int module_text_address(unsigned long addr)
+static inline struct module *module_text_address(unsigned long addr)
 {
-	return 0;
+	return NULL;
 }
 
 /* Get/put a kernel symbol (calls should be symmetric) */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19470-linux-2.5.66-bk2/kernel/extable.c .19470-linux-2.5.66-bk2.updated/kernel/extable.c
--- .19470-linux-2.5.66-bk2/kernel/extable.c	2003-02-07 19:20:44.000000000 +1100
+++ .19470-linux-2.5.66-bk2.updated/kernel/extable.c	2003-03-27 15:08:54.000000000 +1100
@@ -38,5 +38,5 @@ int kernel_text_address(unsigned long ad
 	    addr <= (unsigned long)_etext)
 		return 1;
 
-	return module_text_address(addr);
+	return module_text_address(addr) != NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19470-linux-2.5.66-bk2/kernel/module.c .19470-linux-2.5.66-bk2.updated/kernel/module.c
--- .19470-linux-2.5.66-bk2/kernel/module.c	2003-03-18 05:01:52.000000000 +1100
+++ .19470-linux-2.5.66-bk2.updated/kernel/module.c	2003-03-27 15:09:34.000000000 +1100
@@ -552,23 +552,14 @@ EXPORT_SYMBOL(__symbol_put);
 
 void symbol_put_addr(void *addr)
 {
-	struct kernel_symbol_group *ks;
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
+	if (!kernel_text_address((unsigned long)addr))
+		BUG();
 
-		for (i = 0; i < ks->num_syms; i++) {
-			if (ks->syms[i].value == (unsigned long)addr) {
-				module_put(ks->owner);
-				spin_unlock_irqrestore(&modlist_lock, flags);
-				return;
-			}
-		}
-	}
+	module_put(module_text_address((unsigned long)addr));
 	spin_unlock_irqrestore(&modlist_lock, flags);
-	BUG();
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
@@ -1545,15 +1536,15 @@ const struct exception_table_entry *sear
 }
 
 /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
-int module_text_address(unsigned long addr)
+struct module *module_text_address(unsigned long addr)
 {
 	struct module *mod;
 
 	list_for_each_entry(mod, &modules, list)
 		if (within(addr, mod->module_init, mod->init_size)
 		    || within(addr, mod->module_core, mod->core_size))
-			return 1;
-	return 0;
+			return mod;
+	return NULL;
 }
 
 /* Provided by the linker */
