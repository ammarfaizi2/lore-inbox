Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSLBBZd>; Sun, 1 Dec 2002 20:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLBBYG>; Sun, 1 Dec 2002 20:24:06 -0500
Received: from dp.samba.org ([66.70.73.150]:16531 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263246AbSLBBXg>;
	Sun, 1 Dec 2002 20:23:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Table fix for module-init-tools
Date: Mon, 02 Dec 2002 12:25:20 +1100
Message-Id: <20021202013103.23DAB2C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply,

	This patch allows the new depmod to generate the USB & PCI
hotplug tables.  Greg Banks and I are (slowly) working on a better
solution, but allows the old-style "modules.pcimap" etc. to be
generated in the short term.

Rusty.

Name: Module Table Support for module-init-tools depmod
Author: Rusty Russell
Status: Tested on 2.5.50

D: This patch adds a "__mod_XXX_table" symbol which is an alias to the
D: module table, rather than a pointer.  This makes it relatively
D: trivial to extract the table.  Previously, it required a pointer
D: dereference, which means the relocations must be applied, which is
D: why the old depmod needs so much of modutils (ie. it basically
D: links the whole module in order to find the table).
D:
D: The old depmod can still be invoked using "-F System.map" to
D: generate the tables (there'll be lots of other warnings, and it
D: will generate a completely bogus modules.dep, but the tables should
D: be OK.)

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.50/include/linux/module.h working-2.5.50-table/include/linux/module.h
--- linux-2.5.50/include/linux/module.h	Mon Nov 25 08:44:18 2002
+++ working-2.5.50-table/include/linux/module.h	Thu Nov 28 10:59:39 2002
@@ -14,6 +14,7 @@
 #include <linux/cache.h>
 #include <linux/kmod.h>
 #include <linux/elf.h>
+#include <linux/stringify.h>
 
 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
@@ -40,11 +40,14 @@ struct kernel_symbol
 
 #ifdef MODULE
 
-#define MODULE_GENERIC_TABLE(gtype,name)	\
-static const unsigned long __module_##gtype##_size \
-  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
-static const struct gtype##_id * __module_##gtype##_table \
-  __attribute__ ((unused)) = name
+/* For replacement modutils, use an alias not a pointer. */
+#define MODULE_GENERIC_TABLE(gtype,name)			\
+static const unsigned long __module_##gtype##_size		\
+  __attribute__ ((unused)) = sizeof(struct gtype##_id);		\
+static const struct gtype##_id * __module_##gtype##_table	\
+  __attribute__ ((unused)) = name;				\
+extern const struct gtype##_id __mod_##gtype##_table		\
+  __attribute__ ((unused, alias(__stringify(name))))
 
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
