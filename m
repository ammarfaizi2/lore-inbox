Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSKEArl>; Mon, 4 Nov 2002 19:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSKEAqE>; Mon, 4 Nov 2002 19:46:04 -0500
Received: from dp.samba.org ([66.70.73.150]:28095 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265609AbSKEApi>;
	Mon, 4 Nov 2002 19:45:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module loader against 2.5.46: 3/9 
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:29:22 +1100
Message-Id: <20021105005213.F1DFA2C128@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Make x86 compile, and their modules work.

Rusty.

Name: New Module Loader Base: x86 support
Author: Rusty Russell
Status: Tested on 2.5.45
Depends: Module/module.patch.gz

D: This patch provides basic x86 support for modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/kernel/Makefile .9540-2.5.45-module-i386/arch/i386/kernel/Makefile
--- .9540-2.5.45-module-i386.pre/arch/i386/kernel/Makefile	2002-10-19 17:47:49.000000000 +1000
+++ .9540-2.5.45-module-i386/arch/i386/kernel/Makefile	2002-11-01 11:15:05.000000000 +1100
@@ -29,6 +29,7 @@ obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspen
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
+obj-$(CONFIG_MODULES)		+= module.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/kernel/entry.S .9540-2.5.45-module-i386/arch/i386/kernel/entry.S
--- .9540-2.5.45-module-i386.pre/arch/i386/kernel/entry.S	2002-10-31 12:36:19.000000000 +1100
+++ .9540-2.5.45-module-i386/arch/i386/kernel/entry.S	2002-11-01 11:15:05.000000000 +1100
@@ -610,10 +610,10 @@ ENTRY(sys_call_table)
 	.long sys_adjtimex
 	.long sys_mprotect	/* 125 */
 	.long sys_sigprocmask
-	.long sys_create_module
+	.long sys_ni_syscall	/* old "create_module" */ 
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
@@ -650,7 +650,7 @@ ENTRY(sys_call_table)
 	.long sys_setresuid16
 	.long sys_getresuid16	/* 165 */
 	.long sys_vm86
-	.long sys_query_module
+	.long sys_ni_syscall	/* Old sys_query_module */
 	.long sys_poll
 	.long sys_nfsservctl
 	.long sys_setresgid16	/* 170 */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/kernel/module.c .9540-2.5.45-module-i386/arch/i386/kernel/module.c
--- .9540-2.5.45-module-i386.pre/arch/i386/kernel/module.c	1970-01-01 10:00:00.000000000 +1000
+++ .9540-2.5.45-module-i386/arch/i386/kernel/module.c	2002-11-01 11:15:05.000000000 +1100
@@ -0,0 +1,130 @@
+/*  Kernel module help for i386.
+    Copyright (C) 2001 Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+#include <linux/module.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , ...)
+#endif
+
+static void *alloc_and_zero(unsigned long size)
+{
+	void *ret;
+
+	/* We handle the zero case fine, unlike vmalloc */
+	if (size == 0)
+		return NULL;
+
+	ret = vmalloc(size);
+	if (!ret) ret = ERR_PTR(-ENOMEM);
+	else memset(ret, 0, size);
+
+	return ret;
+}
+
+/* Free memory returned from module_core_alloc/module_init_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+void *module_core_alloc(const Elf32_Ehdr *hdr,
+			const Elf32_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *module)
+{
+	return alloc_and_zero(module->core_size);
+}
+
+void *module_init_alloc(const Elf32_Ehdr *hdr,
+			const Elf32_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *module)
+{
+	return alloc_and_zero(module->init_size);
+}
+
+int apply_relocate(Elf32_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	unsigned int i;
+	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Sym *sym;
+	uint32_t *location;
+
+	DEBUGP("Applying relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+			+ ELF32_R_SYM(rel[i].r_info);
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_386_32:
+			/* We add the value into the location given */
+			*location += sym->st_value;
+			break;
+		case R_386_PC32:
+			/* Add the value, subtract its postition */
+			*location += sym->st_value - (uint32_t)location;
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+			       me->name, ELF32_R_TYPE(rel[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
+
+int apply_relocate_add(Elf32_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *me)
+{
+	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
+	       me->name);
+	return -ENOEXEC;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	return 0;
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/kernel/traps.c .9540-2.5.45-module-i386/arch/i386/kernel/traps.c
--- .9540-2.5.45-module-i386.pre/arch/i386/kernel/traps.c	2002-10-16 15:01:12.000000000 +1000
+++ .9540-2.5.45-module-i386/arch/i386/kernel/traps.c	2002-11-01 11:15:05.000000000 +1100
@@ -95,7 +95,8 @@ static int kstack_depth_to_print = 24;
 
 #ifdef CONFIG_MODULES
 
-extern struct module kernel_module;
+/* FIXME: Accessed without a lock --RR */
+extern struct list_head modules;
 
 static inline int kernel_text_address(unsigned long addr)
 {
@@ -106,11 +107,11 @@ static inline int kernel_text_address(un
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
+		if (mod_bound((void *)addr, 0, mod)) {
 			retval = 1;
 			break;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/mm/extable.c .9540-2.5.45-module-i386/arch/i386/mm/extable.c
--- .9540-2.5.45-module-i386.pre/arch/i386/mm/extable.c	2001-09-18 06:16:30.000000000 +1000
+++ .9540-2.5.45-module-i386/arch/i386/mm/extable.c	2002-11-01 11:15:05.000000000 +1100
@@ -44,15 +44,17 @@ search_exception_table(unsigned long add
 	return ret;
 #else
 	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	struct module *mp;
+	struct list_head *i;
 
+	/* The kernel is the last "module" -- no need to treat it special.  */
 	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	list_for_each(i, &extables) {
+		struct exception_table *ex
+			= list_entry(i, struct exception_table, list);
+		if (ex->num_entries == 0)
 			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr);
+		ret = search_one_table(ex->entry,
+				       ex->entry + ex->num_entries - 1, addr);
 		if (ret)
 			break;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/arch/i386/vmlinux.lds.S .9540-2.5.45-module-i386/arch/i386/vmlinux.lds.S
--- .9540-2.5.45-module-i386.pre/arch/i386/vmlinux.lds.S	2002-10-19 17:47:49.000000000 +1000
+++ .9540-2.5.45-module-i386/arch/i386/vmlinux.lds.S	2002-11-01 11:15:05.000000000 +1100
@@ -26,6 +26,7 @@ SECTIONS
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
 
+  . = ALIGN(64);
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9540-2.5.45-module-i386.pre/include/asm-i386/module.h .9540-2.5.45-module-i386/include/asm-i386/module.h
--- .9540-2.5.45-module-i386.pre/include/asm-i386/module.h	2001-09-14 09:33:03.000000000 +1000
+++ .9540-2.5.45-module-i386/include/asm-i386/module.h	2002-11-01 11:15:05.000000000 +1100
@@ -1,12 +1,11 @@
 #ifndef _ASM_I386_MODULE_H
 #define _ASM_I386_MODULE_H
-/*
- * This file contains the i386 architecture specific module code.
- */
-
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
+/* x86 is simple */
+struct mod_arch_specific
+{
+};
 
+#define Elf_Shdr Elf32_Shdr
+#define Elf_Sym Elf32_Sym
+#define Elf_Ehdr Elf32_Ehdr
 #endif /* _ASM_I386_MODULE_H */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
