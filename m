Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTD3Cwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTD3Cwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:52:44 -0400
Received: from dp.samba.org ([66.70.73.150]:36530 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261971AbTD3Cwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:52:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] __module_get
Date: Wed, 30 Apr 2003 12:26:03 +1000
Message-Id: <20030430030502.9B1952C0A3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit.  Linus, please apply.  Replaces ugly opencoding in
filesystems.c (mount refcounting is wrong IMHO, but it's easier than
arguing with Viro about it).

Name: __module_get
Author: Rusty Russell
Status: Trivial

D: Introduces __module_get for places where we know we already hold
D: a reference and ignoring the fact that the module is being "rmmod --wait"ed
D: is simpler.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5001-linux-2.5.67-bk5/fs/filesystems.c .5001-linux-2.5.67-bk5.updated/fs/filesystems.c
--- .5001-linux-2.5.67-bk5/fs/filesystems.c	2003-04-14 13:45:44.000000000 +1000
+++ .5001-linux-2.5.67-bk5.updated/fs/filesystems.c	2003-04-14 15:44:36.000000000 +1000
@@ -32,17 +32,7 @@ static rwlock_t file_systems_lock = RW_L
 /* WARNING: This can be used only if we _already_ own a reference */
 void get_filesystem(struct file_system_type *fs)
 {
-	if (!try_module_get(fs->owner)) {
-#ifdef CONFIG_MODULE_UNLOAD
-		unsigned int cpu = get_cpu();
-		local_inc(&fs->owner->ref[cpu].count);
-		put_cpu();
-#else
-		/* Getting filesystem while it's starting up?  We're
-                   already supposed to have a reference. */
-		BUG();
-#endif
-	}
+	__module_get(fs->owner);
 }
 
 void put_filesystem(struct file_system_type *fs)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5001-linux-2.5.67-bk5/include/linux/module.h .5001-linux-2.5.67-bk5.updated/include/linux/module.h
--- .5001-linux-2.5.67-bk5/include/linux/module.h	2003-04-08 11:15:01.000000000 +1000
+++ .5001-linux-2.5.67-bk5.updated/include/linux/module.h	2003-04-14 15:45:15.000000000 +1000
@@ -255,6 +255,7 @@ struct module *module_text_address(unsig
 
 #ifdef CONFIG_MODULE_UNLOAD
 
+unsigned int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
 #define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
 void symbol_put_addr(void *addr);
@@ -265,6 +266,17 @@ void symbol_put_addr(void *addr);
 #define local_dec(x) atomic_dec(x)
 #endif
 
+/* Sometimes we know we already have a refcount, and it's easier not
+   to handle the error case (which only happens with rmmod --wait). */
+static inline void __module_get(struct module *module)
+{
+	if (module) {
+		BUG_ON(module_refcount(module) == 0);
+		local_inc(&module->ref[get_cpu()].count);
+		put_cpu();
+	}
+}
+
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
@@ -300,6 +317,9 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 }
+static inline void __module_get(struct module *module)
+{
+}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
@@ -357,6 +377,10 @@ static inline struct module *module_text
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 
+static inline void __module_get(struct module *module)
+{
+}
+
 static inline int try_module_get(struct module *module)
 {
 	return 1;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5001-linux-2.5.67-bk5/kernel/module.c .5001-linux-2.5.67-bk5.updated/kernel/module.c
--- .5001-linux-2.5.67-bk5/kernel/module.c	2003-04-14 13:45:46.000000000 +1000
+++ .5001-linux-2.5.67-bk5.updated/kernel/module.c	2003-04-14 15:44:36.000000000 +1000
@@ -431,7 +431,7 @@ static inline void restart_refcounts(voi
 }
 #endif
 
-static unsigned int module_refcount(struct module *mod)
+unsigned int module_refcount(struct module *mod)
 {
 	unsigned int i, total = 0;
 
@@ -439,6 +439,7 @@ static unsigned int module_refcount(stru
 		total += atomic_read(&mod->ref[i].count);
 	return total;
 }
+EXPORT_SYMBOL(module_refcount);
 
 /* This exists whether we can unload or not */
 static void free_module(struct module *mod);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
