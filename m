Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTBPVON>; Sun, 16 Feb 2003 16:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTBPVON>; Sun, 16 Feb 2003 16:14:13 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:45277 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267594AbTBPVOK>; Sun, 16 Feb 2003 16:14:10 -0500
Message-ID: <3E50016B.1080908@quark.didntduck.org>
Date: Sun, 16 Feb 2003 16:23:55 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kai@tp1.ruhr-uni-bochum.de, Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move __this_module to xxx.mod.c
Content-Type: multipart/mixed;
 boundary="------------020306020100010403050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306020100010403050909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves the module structure to the generated .mod.c file, 
instead of compiling it into each object and relying on the linker to 
include it only once.

--
				Brian Gerst

--------------020306020100010403050909
Content-Type: text/plain;
 name="this_module-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="this_module-1"

diff -urN linux-2.5.61-bk1/arch/v850/Makefile linux/arch/v850/Makefile
--- linux-2.5.61-bk1/arch/v850/Makefile	2003-02-10 14:22:14.000000000 -0500
+++ linux/arch/v850/Makefile	2003-02-16 14:00:47.000000000 -0500
@@ -22,11 +22,6 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
-# This prevents the linker from consolidating the .gnu.linkonce.this_module
-# section into .text (which the v850 default linker script for -r does for
-# some reason)
-LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
-
 LDFLAGS_BLOB := -b binary --oformat elf32-little
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
diff -urN linux-2.5.61-bk1/include/linux/module.h linux/include/linux/module.h
--- linux-2.5.61-bk1/include/linux/module.h	2003-02-16 10:06:35.000000000 -0500
+++ linux/include/linux/module.h	2003-02-16 13:01:25.000000000 -0500
@@ -406,19 +406,6 @@
 
 #ifdef MODULE
 extern struct module __this_module;
-#ifdef KBUILD_MODNAME
-/* We make the linker do some of the work. */
-struct module __this_module
-__attribute__((section(".gnu.linkonce.this_module"))) = {
-	.name = __stringify(KBUILD_MODNAME),
-	.symbols = { .owner = &__this_module },
-	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
-	.init = init_module,
-#ifdef CONFIG_MODULE_UNLOAD
-	.exit = cleanup_module,
-#endif
-};
-#endif /* KBUILD_MODNAME */
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff -urN linux-2.5.61-bk1/kernel/module.c linux/kernel/module.c
--- linux-2.5.61-bk1/kernel/module.c	2003-02-16 10:06:35.000000000 -0500
+++ linux/kernel/module.c	2003-02-16 14:10:29.000000000 -0500
@@ -1125,7 +1125,7 @@
 			strindex = sechdrs[i].sh_link;
 			DEBUGP("String table found in section %u\n", strindex);
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  ".gnu.linkonce.this_module") == 0) {
+				  "___this_module") == 0) {
 			/* The module struct */
 			DEBUGP("Module in section %u\n", i);
 			modindex = i;
diff -urN linux-2.5.61-bk1/scripts/modpost.c linux/scripts/modpost.c
--- linux-2.5.61-bk1/scripts/modpost.c	2003-02-16 10:06:35.000000000 -0500
+++ linux/scripts/modpost.c	2003-02-16 14:10:19.000000000 -0500
@@ -287,6 +287,10 @@
 		/* undefined symbol */
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
 			break;
+
+		/* ignore __this_module */
+		if (!strcmp(symname, "__this_module"))
+			break;
 		
 		s = alloc_symbol(symname);
 		/* add to list */
@@ -378,7 +382,7 @@
 /* Header for the generated file */
 
 void
-add_header(struct buffer *b)
+add_header(struct buffer *b, struct module *mod)
 {
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
@@ -386,6 +390,17 @@
 	buf_printf(b, "const char vermagic[]\n");
 	buf_printf(b, "__attribute__((section(\"__vermagic\"))) =\n");
 	buf_printf(b, "VERMAGIC_STRING;\n");
+	buf_printf(b, "\n");
+	buf_printf(b, "struct module __this_module\n");
+	buf_printf(b, "__attribute__((section(\"___this_module\"))) = {\n");
+	buf_printf(b, "\t.name = \"%s\",\n", strrchr(mod->name, '/') + 1);
+	buf_printf(b, "\t.symbols = { .owner = &__this_module },\n");
+	buf_printf(b, "\t.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },\n");
+	buf_printf(b, "\t.init = init_module,\n");
+	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
+	buf_printf(b, "\t.exit = cleanup_module,\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "};\n");
 }
 
 /* Record CRCs for unresolved symbols */
@@ -526,7 +541,7 @@
 
 		buf.pos = 0;
 
-		add_header(&buf);
+		add_header(&buf, mod);
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);

--------------020306020100010403050909--

