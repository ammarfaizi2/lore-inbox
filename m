Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSKLRSw>; Tue, 12 Nov 2002 12:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKLRRj>; Tue, 12 Nov 2002 12:17:39 -0500
Received: from dp.samba.org ([66.70.73.150]:10976 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266628AbSKLRRd>;
	Tue, 12 Nov 2002 12:17:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: bheilbrun@paypal.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [2.5-bk] Module loader compile bug 
In-reply-to: Your message of "Mon, 11 Nov 2002 21:03:19 -0800."
             <20021112050319.GA3651@paypal.com> 
Date: Wed, 13 Nov 2002 04:23:26 +1100
Message-Id: <20021112172423.818182C2A0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021112050319.GA3651@paypal.com> you write:
> I realize you're still working on this, but current bk is broken if
> you turn off module unload support. In include/linux/module.h we get:
> 
> 	#else /*!CONFIG_MODULE_UNLOAD*/
> <snip>
> 	#define symbol_put_addr(p) do { } while(0)
> 	
> 	#endif /* CONFIG_MODULE_UNLOAD */
> 	
> Which upsets this line in kernel/module.c 
> 
> 	  void symbol_put_addr(void *addr)
> 
> After the preprocessor gets a hold of it all, gcc doesn't know what to
> make of "void do { } while(0)".

Yep, symbol_put_addr() in module.c should be moved under __symbol_put.

Patch is fairly trivial, does this work for you?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

--- working-2.5.47-module-alias/kernel/module.c.~1~	2002-11-12 22:10:43.000000000 +1100
+++ working-2.5.47-module-alias/kernel/module.c	2002-11-13 04:22:47.000000000 +1100
@@ -492,6 +492,28 @@ void __symbol_put(const char *symbol)
 }
 EXPORT_SYMBOL(__symbol_put);
 
+void symbol_put_addr(void *addr)
+{
+	struct kernel_symbol_group *ks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	list_for_each_entry(ks, &symbols, list) {
+ 		unsigned int i;
+
+		for (i = 0; i < ks->num_syms; i++) {
+			if (ks->syms[i].value == (unsigned long)addr) {
+				module_put(ks->owner);
+				spin_unlock_irqrestore(&modlist_lock, flags);
+				return;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	BUG();
+}
+EXPORT_SYMBOL_GPL(symbol_put_addr);
+
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
@@ -716,28 +738,6 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
-void symbol_put_addr(void *addr)
-{
-	struct kernel_symbol_group *ks;
-	unsigned long flags;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
-
-		for (i = 0; i < ks->num_syms; i++) {
-			if (ks->syms[i].value == (unsigned long)addr) {
-				module_put(ks->owner);
-				spin_unlock_irqrestore(&modlist_lock, flags);
-				return;
-			}
-		}
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	BUG();
-}
-EXPORT_SYMBOL_GPL(symbol_put_addr);
-
 /* Transfer one ELF section to the correct (init or core) area. */
 static void *copy_section(const char *name,
 			  void *base,
