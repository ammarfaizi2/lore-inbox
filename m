Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbUCZCXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUCZCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:23:16 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:13553 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S263848AbUCZCXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:23:06 -0500
Message-ID: <406393FC.2090306@quark.didntduck.org>
Date: Thu, 25 Mar 2004 21:22:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Move __this_module to modpost
Content-Type: multipart/mixed;
 boundary="------------030505090706030008000508"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
X-Charter-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030505090706030008000508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Move the __this_module structure to the modpost code where it really 
belongs.  Also change the section to __module, which module-init-tools 
already knows about.

--
				Brian Gerst

--------------030505090706030008000508
Content-Type: text/plain;
 name="this_module-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="this_module-1"

diff -urN linux-bk/arch/v850/Makefile linux/arch/v850/Makefile
--- linux-bk/arch/v850/Makefile	2003-12-17 22:00:01.000000000 -0500
+++ linux/arch/v850/Makefile	2004-03-25 16:21:12.000000000 -0500
@@ -22,11 +22,6 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
-# This prevents the linker from consolidating the .gnu.linkonce.this_module
-# section into .text (which the v850 default linker script for -r does for
-# some reason)
-LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
-
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
 
diff -urN linux-bk/include/linux/module.h linux/include/linux/module.h
--- linux-bk/include/linux/module.h	2004-03-10 22:49:45.000000000 -0500
+++ linux/include/linux/module.h	2004-03-25 16:21:12.000000000 -0500
@@ -70,6 +70,7 @@
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
+extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
 
 #else  /* !MODULE */
@@ -481,21 +482,6 @@
 
 #endif /* CONFIG_MODULES */
 
-#ifdef MODULE
-extern struct module __this_module;
-#ifdef KBUILD_MODNAME
-/* We make the linker do some of the work. */
-struct module __this_module
-__attribute__((section(".gnu.linkonce.this_module"))) = {
-	.name = __stringify(KBUILD_MODNAME),
-	.init = init_module,
-#ifdef CONFIG_MODULE_UNLOAD
-	.exit = cleanup_module,
-#endif
-};
-#endif /* KBUILD_MODNAME */
-#endif /* MODULE */
-
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
diff -urN linux-bk/kernel/module.c linux/kernel/module.c
--- linux-bk/kernel/module.c	2004-03-25 13:54:27.000000000 -0500
+++ linux/kernel/module.c	2004-03-25 16:25:06.000000000 -0500
@@ -1328,8 +1328,10 @@
 #endif
 	}
 
-	modindex = find_sec(hdr, sechdrs, secstrings,
-			    ".gnu.linkonce.this_module");
+	modindex = find_sec(hdr, sechdrs, secstrings, "__module");
+	if (!modindex) /* To be removed in 2.7.x */
+		modindex = find_sec(hdr, sechdrs, secstrings,
+				    ".gnu.linkonce.this_module");
 	if (!modindex) {
 		printk(KERN_WARNING "No module found in object\n");
 		err = -ENOEXEC;
diff -urN linux-bk/scripts/Makefile.modpost linux/scripts/Makefile.modpost
--- linux-bk/scripts/Makefile.modpost	2004-03-10 22:49:49.000000000 -0500
+++ linux/scripts/Makefile.modpost	2004-03-25 16:21:12.000000000 -0500
@@ -35,6 +35,8 @@
 
 # Compile version info for unresolved symbols
 
+modname = $(*F)
+
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
 		   -c -o $@ $<
diff -urN linux-bk/scripts/modpost.c linux/scripts/modpost.c
--- linux-bk/scripts/modpost.c	2004-03-25 13:54:28.000000000 -0500
+++ linux/scripts/modpost.c	2004-03-25 21:16:24.024332688 -0500
@@ -355,6 +355,9 @@
 		/* ignore global offset table */
 		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
 			break;
+		/* ignore __this_module, it will be resolved shortly */
+		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
+			break;
 #ifdef STT_REGISTER
 		if (info->hdr->e_machine == EM_SPARC ||
 		    info->hdr->e_machine == EM_SPARCV9) {
@@ -480,6 +483,15 @@
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
+	buf_printf(b, "\n");
+	buf_printf(b, "struct module __this_module\n");
+	buf_printf(b, "__attribute__((section(\"__module\"))) = {\n");
+	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
+	buf_printf(b, " .init = init_module,\n");
+	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
+	buf_printf(b, " .exit = cleanup_module,\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "};\n");
 }
 
 /* Record CRCs for unresolved symbols */

--------------030505090706030008000508--
