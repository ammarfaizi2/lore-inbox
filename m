Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSKNRDU>; Thu, 14 Nov 2002 12:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbSKNRBn>; Thu, 14 Nov 2002 12:01:43 -0500
Received: from dp.samba.org ([66.70.73.150]:37573 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265012AbSKNQ75>;
	Thu, 14 Nov 2002 11:59:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Anders Gustafsson <andersg@0x63.nu>,
       Steve Lord <lord@sgi.com>
Subject: [PATCH] Fix clash from XFS vs module.h
Date: Fri, 15 Nov 2002 04:56:23 +1100
Message-Id: <20021114170651.947382C2DE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't include elf.h until it's neccessary (for files doing module
loading).

Based on Anders Gustaffson's patch, compiles here on ppc and x86.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: moduleloader.h
Author: Anders Gustafsson
Status: Experimental
Depends: Module/module-i386.patch.gz

D: Separates the module loading function prototypes (and elf.h) into
D: moduleloader.h.  AT_GID in elf.h clashes with xfs.h, but this also
D: makes module.h less cluttered.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/i386/kernel/module.c working-2.5-bk-noelf/arch/i386/kernel/module.c
--- linux-2.5-bk/arch/i386/kernel/module.c	2002-11-14 15:08:19.000000000 +1100
+++ working-2.5-bk-noelf/arch/i386/kernel/module.c	2002-11-14 16:30:13.000000000 +1100
@@ -15,7 +15,7 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc/kernel/module.c working-2.5-bk-noelf/arch/sparc/kernel/module.c
--- linux-2.5-bk/arch/sparc/kernel/module.c	2002-11-14 15:08:20.000000000 +1100
+++ working-2.5-bk-noelf/arch/sparc/kernel/module.c	2002-11-14 16:30:55.000000000 +1100
@@ -4,7 +4,7 @@
  * Copyright (C) 2002 David S. Miller.
  */
 
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/kernel.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc64/kernel/module.c working-2.5-bk-noelf/arch/sparc64/kernel/module.c
--- linux-2.5-bk/arch/sparc64/kernel/module.c	2002-11-14 15:08:21.000000000 +1100
+++ working-2.5-bk-noelf/arch/sparc64/kernel/module.c	2002-11-14 16:31:02.000000000 +1100
@@ -4,7 +4,7 @@
  * Copyright (C) 2002 David S. Miller.
  */
 
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/kernel.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-noelf/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	2002-11-14 15:08:25.000000000 +1100
+++ working-2.5-bk-noelf/include/linux/module.h	2002-11-14 16:28:51.000000000 +1100
@@ -10,7 +10,6 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/elf.h>
 #include <linux/stat.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
@@ -143,53 +142,6 @@ struct module
 	char args[0];
 };
 
-/* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
-
-/* These must be implemented by the specific architecture */
-
-/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
-void *module_core_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* vmalloc and zero (if any) for sections to be freed after init.
-   Return ERR_PTR() on error. */
-void *module_init_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* Apply the given relocation to the (simplified) ELF.  Return -error
-   or 0. */
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *mod);
-
-/* Apply the given add relocation to the (simplified) ELF.  Return
-   -error or 0 */
-int apply_relocate_add(Elf_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *mod);
-
-/* Any final processing of module before access.  Return -error or 0. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *mod);
-
-/* Free memory returned from module_core_alloc/module_init_alloc */
-void module_free(struct module *mod, void *module_region);
-
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/moduleloader.h working-2.5-bk-noelf/include/linux/moduleloader.h
--- linux-2.5-bk/include/linux/moduleloader.h	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5-bk-noelf/include/linux/moduleloader.h	2002-11-14 16:29:33.000000000 +1100
@@ -0,0 +1,55 @@
+#ifndef _LINUX_MODULELOADER_H
+#define _LINUX_MODULELOADER_H
+/* The stuff needed for archs to support modules. */
+
+#include <linux/module.h>
+#include <linux/elf.h>
+
+/* Helper function for arch-specific module loaders */
+unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
+				   unsigned int symindex,
+				   const char *strtab,
+				   const char *name,
+				   struct module *mod,
+				   struct kernel_symbol_group **group);
+
+/* These must be implemented by the specific architecture */
+
+/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
+void *module_core_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* vmalloc and zero (if any) for sections to be freed after init.
+   Return ERR_PTR() on error. */
+void *module_init_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* Free memory returned from module_core_alloc/module_init_alloc */
+void module_free(struct module *mod, void *module_region);
+
+/* Apply the given relocation to the (simplified) ELF.  Return -error
+   or 0. */
+int apply_relocate(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *mod);
+
+/* Apply the given add relocation to the (simplified) ELF.  Return
+   -error or 0 */
+int apply_relocate_add(Elf_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *mod);
+
+/* Any final processing of module before access.  Return -error or 0. */
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *mod);
+
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-noelf/kernel/module.c
--- linux-2.5-bk/kernel/module.c	2002-11-14 15:08:25.000000000 +1100
+++ working-2.5-bk-noelf/kernel/module.c	2002-11-14 16:28:04.000000000 +1100
@@ -17,6 +17,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
