Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSKLRle>; Tue, 12 Nov 2002 12:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbSKLRlE>; Tue, 12 Nov 2002 12:41:04 -0500
Received: from dp.samba.org ([66.70.73.150]:20202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266677AbSKLRkv>;
	Tue, 12 Nov 2002 12:40:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 bk current] Compile error in module.c 
In-reply-to: Your message of "12 Nov 2002 10:00:12 MDT."
             <1037116812.10626.6.camel@plars> 
Date: Wed, 13 Nov 2002 04:44:01 +1100
Message-Id: <20021112174741.75B162C2BC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1037116812.10626.6.camel@plars> you write:
> 
> --=-zCH6+R6ao/F8Ph/vicXT
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> The ltp nightly run last night failed to compile with the following
> errors:

Yep.  How does this go for you?

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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.47-module-alias/crypto/api.c working-2.5.47-modname/crypto/api.c
--- working-2.5.47-module-alias/crypto/api.c	2002-11-11 20:00:55.000000000 +1100
+++ working-2.5.47-modname/crypto/api.c	2002-11-13 04:30:48.000000000 +1100
@@ -263,8 +263,7 @@ static int c_show(struct seq_file *m, vo
 	struct crypto_alg *alg = (struct crypto_alg *)p;
 	
 	seq_printf(m, "name         : %s\n", alg->cra_name);
-	seq_printf(m, "module       : %s\n", alg->cra_module ?
-					alg->cra_module->name : "[static]");
+	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
 	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 	
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.47-module-alias/include/linux/module.h working-2.5.47-modname/include/linux/module.h
--- working-2.5.47-module-alias/include/linux/module.h	2002-11-12 22:43:55.000000000 +1100
+++ working-2.5.47-modname/include/linux/module.h	2002-11-13 04:41:29.000000000 +1100
@@ -288,11 +288,18 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 }
-#define symbol_put(x) do { } while(0)
+#define __symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static inline char *module_name(struct module *module)
+{
+	if (module)
+		return module->name;
+	return "[built-in]";
+}
+
 #define __unsafe(mod)							     \
 do {									     \
 	if (mod && !(mod)->unsafe) {					     \
@@ -315,6 +322,10 @@ do {									     \
 #define try_module_get(module) 1
 #define module_put(module) do { } while(0)
 
+static inline char *module_name(struct module *module)
+{
+	return "[built-in]";
+}
 #define __unsafe(mod)
 #endif /* CONFIG_MODULES */
 
