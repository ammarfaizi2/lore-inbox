Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264563AbTCZDC2>; Tue, 25 Mar 2003 22:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbTCZDC1>; Tue, 25 Mar 2003 22:02:27 -0500
Received: from dp.samba.org ([66.70.73.150]:11490 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264563AbTCZDCY>;
	Tue, 25 Mar 2003 22:02:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: Max Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] __try_module_get()
Date: Wed, 26 Mar 2003 14:13:19 +1100
Message-Id: <20030326031336.419962C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	This is the "I have a reference count already, and I know the
admin has done rmmod --wait and so *really* wants to remove the
module, but I don't care" interface 8)

	There are several places where handling the try_module_get()
failure is not worth it: fs/filesystems.c is the first.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __try_module_get
Author: Rusty Russell
Status: Trivial

D: Introduces __try_module_get for places where we know we already hold
D: a reference and ignoring the fact that the module is being "rmmod --wait"ed
D: is simpler.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22116-2.5.66-bk1-module_dup.pre/fs/filesystems.c .22116-2.5.66-bk1-module_dup/fs/filesystems.c
--- .22116-2.5.66-bk1-module_dup.pre/fs/filesystems.c	2003-03-18 12:21:38.000000000 +1100
+++ .22116-2.5.66-bk1-module_dup/fs/filesystems.c	2003-03-26 14:11:23.000000000 +1100
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
+	__try_module_get(fs->owner);
 }
 
 void put_filesystem(struct file_system_type *fs)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22116-2.5.66-bk1-module_dup.pre/include/linux/module.h .22116-2.5.66-bk1-module_dup/include/linux/module.h
--- .22116-2.5.66-bk1-module_dup.pre/include/linux/module.h	2003-03-25 12:17:31.000000000 +1100
+++ .22116-2.5.66-bk1-module_dup/include/linux/module.h	2003-03-26 14:11:23.000000000 +1100
@@ -272,6 +272,7 @@ int module_text_address(unsigned long ad
 
 #ifdef CONFIG_MODULE_UNLOAD
 
+unsigned int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
 #define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
 void symbol_put_addr(void *addr);
@@ -282,6 +283,17 @@ void symbol_put_addr(void *addr);
 #define local_dec(x) atomic_dec(x)
 #endif
 
+/* Sometimes we know we already have a refcount, and it's easier not
+   to handle the error case (which only happens with rmmod --wait). */
+static inline void __try_module_get(struct module *module)
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
@@ -317,6 +329,9 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 }
+static inline void __try_module_get(struct module *module)
+{
+}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
@@ -371,6 +386,10 @@ static inline int module_text_address(un
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 
+static inline void __try_module_get(struct module *module)
+{
+}
+
 static inline int try_module_get(struct module *module)
 {
 	return 1;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22116-2.5.66-bk1-module_dup.pre/kernel/module.c .22116-2.5.66-bk1-module_dup/kernel/module.c
--- .22116-2.5.66-bk1-module_dup.pre/kernel/module.c	2003-03-18 05:01:52.000000000 +1100
+++ .22116-2.5.66-bk1-module_dup/kernel/module.c	2003-03-26 14:11:23.000000000 +1100
@@ -374,7 +374,7 @@ static inline void restart_refcounts(voi
 }
 #endif
 
-static unsigned int module_refcount(struct module *mod)
+unsigned int module_refcount(struct module *mod)
 {
 	unsigned int i, total = 0;
 
