Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUICDov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUICDov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268857AbUICDoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:44:12 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:24780 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S268415AbUICDkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:40:23 -0400
Message-ID: <4137E792.3040309@quark.didntduck.org>
Date: Thu, 02 Sep 2004 23:40:02 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Remove in-kernel init_module/cleanup_module stubs
Content-Type: multipart/mixed;
 boundary="------------040104090500020209020104"
X-Charter-Information: 
X-Charter-Scan: 
X-Charter-Score: ss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104090500020209020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the default stubs for init_module and cleanup_module, 
and checks for NULL instead.  It changes modpost to only create 
references to those functions if they actually exist.

--
				Brian Gerst

--------------040104090500020209020104
Content-Type: text/plain;
 name="module-no-init-exit-stubs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-no-init-exit-stubs"

diff -urN linux-2.6.9-rc1-bk/kernel/module.c linux/kernel/module.c
--- linux-2.6.9-rc1-bk/kernel/module.c	2004-08-31 19:47:59.000000000 -0400
+++ linux/kernel/module.c	2004-09-02 10:03:53.075599156 -0400
@@ -89,13 +89,6 @@
 	return try_module_get(mod);
 }
 
-/* Stub function for modules which don't have an initfn */
-int init_module(void)
-{
-	return 0;
-}
-EXPORT_SYMBOL(init_module);
-
 /* A thread that wants to hold a reference to a module only while it
  * is running can call ths to safely exit.
  * nfsd and lockd use this.
@@ -529,12 +522,6 @@
 /* This exists whether we can unload or not */
 static void free_module(struct module *mod);
 
-/* Stub function for modules which don't have an exitfn */
-void cleanup_module(void)
-{
-}
-EXPORT_SYMBOL(cleanup_module);
-
 static void wait_for_zero_refcount(struct module *mod)
 {
 	/* Since we might sleep for some time, drop the semaphore first */
@@ -589,7 +576,7 @@
 	}
 
 	/* If it has an init func, it must have an exit func to unload */
-	if ((mod->init != init_module && mod->exit == cleanup_module)
+	if ((mod->init != NULL && mod->exit == NULL)
 	    || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
@@ -610,9 +597,11 @@
 		wait_for_zero_refcount(mod);
 
 	/* Final destruction now noone is using it. */
-	up(&module_mutex);
-	mod->exit();
-	down(&module_mutex);
+	if (mod->exit != NULL) {
+		up(&module_mutex);
+		mod->exit();
+		down(&module_mutex);
+	}
 	free_module(mod);
 
  out:
@@ -639,7 +628,7 @@
 		seq_printf(m, "[unsafe],");
 	}
 
-	if (mod->init != init_module && mod->exit == cleanup_module) {
+	if (mod->init != NULL && mod->exit == NULL) {
 		printed_something = 1;
 		seq_printf(m, "[permanent],");
 	}
@@ -1836,7 +1825,7 @@
 		const char __user *uargs)
 {
 	struct module *mod;
-	int ret;
+	int ret = 0;
 
 	/* Must have permission */
 	if (!capable(CAP_SYS_MODULE))
@@ -1875,7 +1864,8 @@
 	up(&notify_mutex);
 
 	/* Start the module */
-	ret = mod->init();
+	if (mod->init != NULL)
+		ret = mod->init();
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
diff -urN linux-2.6.9-rc1-bk/scripts/mod/modpost.c linux/scripts/mod/modpost.c
--- linux-2.6.9-rc1-bk/scripts/mod/modpost.c	2004-08-25 11:52:04.000000000 -0400
+++ linux/scripts/mod/modpost.c	2004-09-02 10:36:40.174590988 -0400
@@ -376,6 +376,10 @@
 			add_exported_symbol(symname + strlen(KSYMTAB_PFX),
 					    mod, NULL);
 		}
+		if (strcmp(symname, MODULE_SYMBOL_PREFIX "init_module") == 0)
+			mod->has_init = 1;
+		if (strcmp(symname, MODULE_SYMBOL_PREFIX "cleanup_module") == 0)
+			mod->has_cleanup = 1;
 		break;
 	}
 }
@@ -410,9 +414,6 @@
 	if (is_vmlinux(modname)) {
 		unsigned int fake_crc = 0;
 		have_vmlinux = 1;
-		/* May not have this if !CONFIG_MODULE_UNLOAD: fake it.
-		   If it appears, we'll get the real CRC. */
-		add_exported_symbol("cleanup_module", mod, &fake_crc);
 		add_exported_symbol("struct_module", mod, &fake_crc);
 		mod->skip = 1;
 	}
@@ -431,14 +432,8 @@
 	 * never passed as an argument to an exported function, so
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
-	if (modversions) {
+	if (modversions)
 		mod->unres = alloc_symbol("struct_module", mod->unres);
-
-		/* Always version init_module and cleanup_module, in
-		 * case module doesn't have its own. */
-		mod->unres = alloc_symbol("init_module", mod->unres);
-		mod->unres = alloc_symbol("cleanup_module", mod->unres);
-	}
 }
 
 #define SZ 500
@@ -479,7 +474,7 @@
 /* Header for the generated file */
 
 void
-add_header(struct buffer *b)
+add_header(struct buffer *b, struct module *mod)
 {
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
@@ -491,10 +486,12 @@
 	buf_printf(b, "struct module __this_module\n");
 	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
 	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
-	buf_printf(b, " .init = init_module,\n");
-	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
-	buf_printf(b, " .exit = cleanup_module,\n");
-	buf_printf(b, "#endif\n");
+	if (mod->has_init)
+		buf_printf(b, " .init = init_module,\n");
+	if (mod->has_cleanup) 
+		buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n"
+			      " .exit = cleanup_module,\n"
+			      "#endif\n");
 	buf_printf(b, "};\n");
 }
 
@@ -723,7 +720,7 @@
 
 		buf.pos = 0;
 
-		add_header(&buf);
+		add_header(&buf, mod);
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
diff -urN linux-2.6.9-rc1-bk/scripts/mod/modpost.h linux/scripts/mod/modpost.h
--- linux-2.6.9-rc1-bk/scripts/mod/modpost.h	2004-08-24 08:43:18.000000000 -0400
+++ linux/scripts/mod/modpost.h	2004-09-01 10:16:49.000000000 -0400
@@ -74,6 +74,8 @@
 	struct symbol *unres;
 	int seen;
 	int skip;
+	int has_init;
+	int has_cleanup;
 	struct buffer dev_table_buf;
 };
 

--------------040104090500020209020104--
