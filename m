Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSKNAbK>; Wed, 13 Nov 2002 19:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSKNAbJ>; Wed, 13 Nov 2002 19:31:09 -0500
Received: from dp.samba.org ([66.70.73.150]:24797 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264729AbSKNAbI>;
	Wed, 13 Nov 2002 19:31:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, jamesm@intercode.com.au,
       laforge@gnumonks.org
Subject: [PATCH] module_name macro
Date: Thu, 14 Nov 2002 12:36:40 +1100
Message-Id: <20021114003801.3CAD82C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice abstraction to remove some #ifdef CONFIG_MODULEs.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Fixes II: module_name
Author: Rusty Russell
Status: Trivial
Depends: Module/module.patch.gz

D: Fixes crypto so it compiles with !CONFIG_MODULES, and cleans up two
D: other cases which did #ifdef CONFIG_MODULES.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/crypto/api.c working-2.5-bk-modname/crypto/api.c
--- linux-2.5-bk/crypto/api.c	2002-11-11 20:00:55.000000000 +1100
+++ working-2.5-bk-modname/crypto/api.c	2002-11-13 20:49:52.000000000 +1100
@@ -263,8 +263,7 @@ static int c_show(struct seq_file *m, vo
 	struct crypto_alg *alg = (struct crypto_alg *)p;
 	
 	seq_printf(m, "name         : %s\n", alg->cra_name);
-	seq_printf(m, "module       : %s\n", alg->cra_module ?
-					alg->cra_module->name : "[static]");
+	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
 	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 	
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-modname/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	2002-11-13 18:54:55.000000000 +1100
+++ working-2.5-bk-modname/include/linux/module.h	2002-11-13 20:56:51.000000000 +1100
@@ -242,6 +242,13 @@ static inline void module_put(struct mod
 
 #endif /* CONFIG_MODULE_UNLOAD */
 
+/* This is a #define so the string doesn't get put in every .o file */
+#define module_name(mod)			\
+({						\
+	struct module *__mod = (mod);		\
+	__mod ? __mod->name : "kernel";		\
+})
+
 #define __unsafe(mod)							     \
 do {									     \
 	if (mod && !(mod)->unsafe) {					     \
@@ -265,6 +272,8 @@ do {									     \
 #define try_module_get(module) 1
 #define module_put(module) do { } while(0)
 
+#define module_name(mod) "kernel"
+
 #define __unsafe(mod)
 #endif /* CONFIG_MODULES */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/exec_domain.c working-2.5-bk-modname/kernel/exec_domain.c
--- linux-2.5-bk/kernel/exec_domain.c	2002-11-13 18:54:56.000000000 +1100
+++ working-2.5-bk-modname/kernel/exec_domain.c	2002-11-13 20:57:19.000000000 +1100
@@ -210,13 +210,8 @@ get_exec_domain_list(char *page)
 	read_lock(&exec_domains_lock);
 	for (ep = exec_domains; ep && len < PAGE_SIZE - 80; ep = ep->next)
 		len += sprintf(page + len, "%d-%d\t%-16s\t[%s]\n",
-			ep->pers_low, ep->pers_high, ep->name,
-#ifdef CONFIG_MODULES
-			ep->module ? ep->module->name : "kernel"
-#else
-			"kernel"
-#endif
-			);
+			       ep->pers_low, ep->pers_high, ep->name,
+			       module_name(ep->module));
 	read_unlock(&exec_domains_lock);
 	return (len);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/ipv4/netfilter/ip_nat_helper.c working-2.5-bk-modname/net/ipv4/netfilter/ip_nat_helper.c
--- linux-2.5-bk/net/ipv4/netfilter/ip_nat_helper.c	2002-11-13 18:54:56.000000000 +1100
+++ working-2.5-bk-modname/net/ipv4/netfilter/ip_nat_helper.c	2002-11-13 20:59:30.000000000 +1100
@@ -361,8 +361,6 @@ helper_cmp(const struct ip_nat_helper *h
 	return ip_ct_tuple_mask_cmp(tuple, &helper->tuple, &helper->mask);
 }
 
-#define MODULE_MAX_NAMELEN		32
-
 int ip_nat_helper_register(struct ip_nat_helper *me)
 {
 	int ret = 0;
@@ -374,14 +372,13 @@ int ip_nat_helper_register(struct ip_nat
 		    && ct_helper->me) {
 			__MOD_INC_USE_COUNT(ct_helper->me);
 		} else {
-#ifdef CONFIG_MODULES
 			/* We are a NAT helper for protocol X.  If we need
 			 * respective conntrack helper for protoccol X, compute
 			 * conntrack helper name and try to load module */
-			char name[MODULE_MAX_NAMELEN];
-			const char *tmp = me->me->name;
+			char name[MODULE_NAME_LEN];
+			const char *tmp = module_name(me->me);
 			
-			if (strlen(tmp) + 6 > MODULE_MAX_NAMELEN) {
+			if (strlen(tmp) + 6 > MODULE_NAME_LEN) {
 				printk("%s: unable to "
 				       "compute conntrack helper name "
 				       "from %s\n", __FUNCTION__, tmp);
@@ -404,7 +401,6 @@ int ip_nat_helper_register(struct ip_nat
 			       "module loader support\n", name);
 			return -EBUSY;
 #endif
-#endif
 		}
 	}
 	WRITE_LOCK(&ip_nat_lock);
