Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSKRT3z>; Mon, 18 Nov 2002 14:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264823AbSKRT2e>; Mon, 18 Nov 2002 14:28:34 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:20695 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264729AbSKRTYx> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (5/16): module loader.
Date: Mon, 18 Nov 2002 20:18:30 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182018.30975.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.48/arch/s390/kernel/Makefile linux-2.5.48-s390/arch/s390/kernel/Makefile
--- linux-2.5.48/arch/s390/kernel/Makefile	Mon Nov 18 05:29:56 2002
+++ linux-2.5.48-s390/arch/s390/kernel/Makefile	Mon Nov 18 20:11:24 2002
@@ -10,7 +10,7 @@
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
             semaphore.o reipl.o s390_ext.o debug.o
 
-obj-$(CONFIG_MODULES)		+= s390_ksyms.o
+obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
 
 #
diff -urN linux-2.5.48/arch/s390/kernel/entry.S linux-2.5.48-s390/arch/s390/kernel/entry.S
--- linux-2.5.48/arch/s390/kernel/entry.S	Mon Nov 18 20:11:15 2002
+++ linux-2.5.48-s390/arch/s390/kernel/entry.S	Mon Nov 18 20:11:24 2002
@@ -474,10 +474,10 @@
         .long  sys_adjtimex
         .long  sys_mprotect              /* 125 */
         .long  sys_sigprocmask
-        .long  sys_create_module
+        .long  sys_ni_syscall		 /* old "create module" */
         .long  sys_init_module
         .long  sys_delete_module
-        .long  sys_get_kernel_syms       /* 130 */
+        .long  sys_ni_syscall		 /* 130: old get_kernel_syms */
         .long  sys_quotactl
         .long  sys_getpgid
         .long  sys_fchdir
@@ -514,7 +514,7 @@
         .long  sys_setresuid16
         .long  sys_getresuid16           /* 165 */
         .long  sys_ni_syscall            /* for vm86 */
-        .long  sys_query_module
+        .long  sys_ni_syscall		 /* old sys_query_module */
         .long  sys_poll
         .long  sys_nfsservctl
         .long  sys_setresgid16           /* 170 */
diff -urN linux-2.5.48/arch/s390/kernel/module.c linux-2.5.48-s390/arch/s390/kernel/module.c
--- linux-2.5.48/arch/s390/kernel/module.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/arch/s390/kernel/module.c	Mon Nov 18 20:11:24 2002
@@ -0,0 +1,174 @@
+/*
+ *  arch/s390x/kernel/module.c - Kernel module help for s390x.
+ *
+ *  S390 version
+ *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
+ *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ *  based on i386 version
+ *    Copyright (C) 2001 Rusty Russell.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
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
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+	return vmalloc(size);
+}
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+/* s390/s390x needs additional memory for GOT/PLT sections. */
+long module_core_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	// FIXME: add space needed for GOT/PLT
+	return module->core_size;
+}
+
+long module_init_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	return module->init_size;
+}
+
+
+
+int apply_relocate(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	unsigned int i;
+	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_offset;
+	ElfW(Sym) *sym;
+	ElfW(Addr) *location;
+
+	DEBUGP("Applying relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (ElfW(Sym) *)sechdrs[symindex].sh_offset
+			+ ELFW(R_SYM)(rel[i].r_info);
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		switch (ELF_R_TYPE(rel[i].r_info)) {
+		case R_390_8:		/* Direct 8 bit.   */
+			*(u8*) location += sym->st_value;
+			break;
+		case R_390_12:		/* Direct 12 bit.  */
+			*(u16*) location = (*(u16*) location & 0xf000) | 
+				(sym->st_value & 0xfff);
+			break;
+		case R_390_16:		/* Direct 16 bit.  */
+			*(u16*) location += sym->st_value;
+			break;
+		case R_390_32:		/* Direct 32 bit.  */
+			*(u32*) location += sym->st_value;
+			break;
+		case R_390_PC16:	/* PC relative 16 bit.  */
+			*(u16*) location += sym->st_value
+					    - (unsigned long )location;
+
+		case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
+			*(u16*) location += (sym->st_value
+					     - (unsigned long )location) >> 1;
+		case R_390_PC32:	/* PC relative 32 bit.  */
+			*(u32*) location += sym->st_value
+					    - (unsigned long )location;
+			break;
+		case R_390_GOT12:	/* 12 bit GOT offset.  */
+		case R_390_GOT16:	/* 16 bit GOT offset.  */
+		case R_390_GOT32:	/* 32 bit GOT offset.  */
+			// FIXME: TODO
+			break;
+
+		case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+		case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+			// FIXME: TODO
+			break;
+		case R_390_GLOB_DAT:	/* Create GOT entry.  */
+		case R_390_JMP_SLOT:	/* Create PLT entry.  */
+			*location = sym->st_value;
+			break;
+		case R_390_RELATIVE:	/* Adjust by program base.  */
+			// FIXME: TODO
+			break;
+		case R_390_GOTOFF:	/* 32 bit offset to GOT.  */
+			// FIXME: TODO
+			break;
+		case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
+			// FIXME: TODO
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
+			       me->name,
+			       (unsigned long)ELF_R_TYPE(rel[i].r_info));
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
diff -urN linux-2.5.48/arch/s390/kernel/traps.c linux-2.5.48-s390/arch/s390/kernel/traps.c
--- linux-2.5.48/arch/s390/kernel/traps.c	Mon Nov 18 05:29:31 2002
+++ linux-2.5.48-s390/arch/s390/kernel/traps.c	Mon Nov 18 20:11:24 2002
@@ -72,8 +72,8 @@
 
 #ifdef CONFIG_MODULES
 
-extern struct module *module_list;
-extern struct module kernel_module;
+/* FIXME: Accessed without a lock --RR */
+extern struct list_head modules;
 
 static inline int kernel_text_address(unsigned long addr)
 {
@@ -84,11 +84,11 @@
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
+		if (mod_bound((void*)addr, 0, mod)) {
 			retval = 1;
 			break;
 		}
diff -urN linux-2.5.48/arch/s390/mm/extable.c linux-2.5.48-s390/arch/s390/mm/extable.c
--- linux-2.5.48/arch/s390/mm/extable.c	Mon Nov 18 05:29:50 2002
+++ linux-2.5.48-s390/arch/s390/mm/extable.c	Mon Nov 18 20:11:24 2002
@@ -42,6 +42,7 @@
 unsigned long
 search_exception_table(unsigned long addr)
 {
+	struct list_head *i;
 	unsigned long ret = 0;
 
 #ifndef CONFIG_MODULES
@@ -52,16 +53,17 @@
 	return ret;
 #else
 	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	struct module *mp;
         addr &= 0x7fffffff;  /* remove amode bit from address */
 
+	/* The kernel is the last "module" -- no need to treat it special. */
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
 		if (ret) {
 			ret = ret | PSW_ADDR_AMODE31;
 			break;
diff -urN linux-2.5.48/arch/s390x/kernel/Makefile linux-2.5.48-s390/arch/s390x/kernel/Makefile
--- linux-2.5.48/arch/s390x/kernel/Makefile	Mon Nov 18 05:29:31 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/Makefile	Mon Nov 18 20:11:24 2002
@@ -12,7 +12,7 @@
 		   setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 		   semaphore.o reipl.o s390_ext.o debug.o
 
-obj-$(CONFIG_MODULES)		+= s390_ksyms.o
+obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
 
 #
diff -urN linux-2.5.48/arch/s390x/kernel/entry.S linux-2.5.48-s390/arch/s390x/kernel/entry.S
--- linux-2.5.48/arch/s390x/kernel/entry.S	Mon Nov 18 20:11:15 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/entry.S	Mon Nov 18 20:11:24 2002
@@ -503,10 +503,10 @@
         .long  SYSCALL(sys_adjtimex,sys32_adjtimex_wrapper)
         .long  SYSCALL(sys_mprotect,sys32_mprotect_wrapper) /* 125 */
         .long  SYSCALL(sys_sigprocmask,sys32_sigprocmask_wrapper)
-        .long  SYSCALL(sys_create_module,sys32_create_module_wrapper)
+        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old "create module" */
         .long  SYSCALL(sys_init_module,sys32_init_module_wrapper)
         .long  SYSCALL(sys_delete_module,sys32_delete_module_wrapper)
-        .long  SYSCALL(sys_get_kernel_syms,sys32_get_kernel_syms_wrapper) /* 130 */
+        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* 130: old get_kernel_syms */
         .long  SYSCALL(sys_quotactl,sys32_quotactl_wrapper)
         .long  SYSCALL(sys_getpgid,sys32_getpgid_wrapper)
         .long  SYSCALL(sys_fchdir,sys32_fchdir_wrapper)
@@ -543,7 +543,7 @@
         .long  SYSCALL(sys_ni_syscall,sys32_setresuid16_wrapper) /* old setresuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys32_getresuid16_wrapper) /* old getresuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* for vm86 */
-        .long  SYSCALL(sys_query_module,sys32_query_module_wrapper)
+        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old sys_query_module */
         .long  SYSCALL(sys_poll,sys32_poll_wrapper)
         .long  SYSCALL(sys_nfsservctl,sys32_nfsservctl_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setresgid16_wrapper) /* old setresgid16 syscall */
diff -urN linux-2.5.48/arch/s390x/kernel/linux32.c linux-2.5.48-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.48/arch/s390x/kernel/linux32.c	Mon Nov 18 05:29:51 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/linux32.c	Mon Nov 18 20:11:24 2002
@@ -3136,13 +3136,6 @@
 
 #ifdef CONFIG_MODULES
 
-extern asmlinkage unsigned long sys_create_module(const char *name_user, size_t size);
-
-asmlinkage unsigned long sys32_create_module(const char *name_user, __kernel_size_t32 size)
-{
-	return sys_create_module(name_user, (size_t)size);
-}
-
 extern asmlinkage int sys_init_module(const char *name_user, struct module *mod_user);
 
 /* Hey, when you're trying to init module, take time and prepare us a nice 64bit
@@ -3421,103 +3414,13 @@
 	return error;
 }
 
-asmlinkage int sys32_query_module(char *name_user, int which, char *buf, __kernel_size_t32 bufsize, u32 ret)
-{
-	struct module *mod;
-	int err;
-
-	lock_kernel();
-	if (name_user == 0) {
-		/* This finds "kernel_module" which is not exported. */
-		for(mod = module_list; mod->next != NULL; mod = mod->next)
-			;
-	} else {
-		long namelen;
-		char *name;
-
-		if ((namelen = get_mod_name(name_user, &name)) < 0) {
-			err = namelen;
-			goto out;
-		}
-		err = -ENOENT;
-		if (namelen == 0) {
-			/* This finds "kernel_module" which is not exported. */
-			for(mod = module_list; mod->next != NULL; mod = mod->next)
-				;
-		} else if ((mod = find_module(name)) == NULL) {
-			put_mod_name(name);
-			goto out;
-		}
-		put_mod_name(name);
-	}
-
-	switch (which)
-	{
-	case 0:
-		err = 0;
-		break;
-	case QM_MODULES:
-		err = qm_modules(buf, bufsize, (__kernel_size_t32 *)AA(ret));
-		break;
-	case QM_DEPS:
-		err = qm_deps(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
-		break;
-	case QM_REFS:
-		err = qm_refs(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
-		break;
-	case QM_SYMBOLS:
-		err = qm_symbols(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
-		break;
-	case QM_INFO:
-		err = qm_info(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-out:
-	unlock_kernel();
-	return err;
-}
-
 struct kernel_sym32 {
 	u32 value;
 	char name[60];
 };
-		 
-extern asmlinkage int sys_get_kernel_syms(struct kernel_sym *table);
-
-asmlinkage int sys32_get_kernel_syms(struct kernel_sym32 *table)
-{
-	int len, i;
-	struct kernel_sym *tbl;
-	mm_segment_t old_fs;
-	
-	len = sys_get_kernel_syms(NULL);
-	if (!table) return len;
-	tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
-	if (!tbl) return -ENOMEM;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	sys_get_kernel_syms(tbl);
-	set_fs (old_fs);
-	for (i = 0; i < len; i++, table += sizeof (struct kernel_sym32)) {
-		if (put_user (tbl[i].value, &table->value) ||
-		    copy_to_user (table->name, tbl[i].name, 60))
-			break;
-	}
-	kfree (tbl);
-	return i;
-}
 
 #else /* CONFIG_MODULES */
 
-asmlinkage unsigned long
-sys32_create_module(const char *name_user, size_t size)
-{
-	return -ENOSYS;
-}
-
 asmlinkage int
 sys32_init_module(const char *name_user, struct module *mod_user)
 {
@@ -3529,24 +3432,6 @@
 {
 	return -ENOSYS;
 }
-
-asmlinkage int
-sys32_query_module(const char *name_user, int which, char *buf, size_t bufsize,
-		 size_t *ret)
-{
-	/* Let the program know about the new interface.  Not that
-	   it'll do them much good.  */
-	if (which == 0)
-		return 0;
-
-	return -ENOSYS;
-}
-
-asmlinkage int
-sys32_get_kernel_syms(struct kernel_sym *table)
-{
-	return -ENOSYS;
-}
 
 #endif  /* CONFIG_MODULES */
 
diff -urN linux-2.5.48/arch/s390x/kernel/module.c linux-2.5.48-s390/arch/s390x/kernel/module.c
--- linux-2.5.48/arch/s390x/kernel/module.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/arch/s390x/kernel/module.c	Mon Nov 18 20:11:24 2002
@@ -0,0 +1,190 @@
+/*
+ *  arch/s390x/kernel/module.c - Kernel module help for s390x.
+ *
+ *  S390 version
+ *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
+ *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ *  based on i386 version
+ *    Copyright (C) 2001 Rusty Russell.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
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
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+	return vmalloc(size);
+}
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+/* s390/s390x needs additional memory for GOT/PLT sections. */
+long module_core_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	// FIXME: add space needed for GOT/PLT
+	return module->core_size;
+}
+
+long module_init_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	return module->init_size;
+}
+
+
+
+int apply_relocate(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	unsigned int i;
+	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_offset;
+	ElfW(Sym) *sym;
+	ElfW(Addr) *location;
+
+	DEBUGP("Applying relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (ElfW(Sym) *)sechdrs[symindex].sh_offset
+			+ ELFW(R_SYM)(rel[i].r_info);
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		switch (ELF_R_TYPE(rel[i].r_info)) {
+		case R_390_8:		/* Direct 8 bit.   */
+			*(u8*) location += sym->st_value;
+			break;
+		case R_390_12:		/* Direct 12 bit.  */
+			*(u16*) location = (*(u16*) location & 0xf000) | 
+				(sym->st_value & 0xfff);
+			break;
+		case R_390_16:		/* Direct 16 bit.  */
+			*(u16*) location += sym->st_value;
+			break;
+		case R_390_32:		/* Direct 32 bit.  */
+			*(u32*) location += sym->st_value;
+			break;
+		case R_390_64:		/* Direct 64 bit.  */
+			*(u64*) location += sym->st_value;
+			break;
+		case R_390_PC16:	/* PC relative 16 bit.  */
+			*(u16*) location += sym->st_value
+					    - (unsigned long )location;
+
+		case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
+			*(u16*) location += (sym->st_value
+					     - (unsigned long )location) >> 1;
+		case R_390_PC32:	/* PC relative 32 bit.  */
+			*(u32*) location += sym->st_value
+					    - (unsigned long )location;
+			break;
+		case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+			*(u32*) location += (sym->st_value
+					     - (unsigned long )location) >> 1;
+			break;
+		case R_390_PC64:	/* PC relative 64 bit.  */
+			*(u64*) location += sym->st_value
+					    - (unsigned long )location;
+			break;
+		case R_390_GOT12:	/* 12 bit GOT offset.  */
+		case R_390_GOT16:	/* 16 bit GOT offset.  */
+		case R_390_GOT32:	/* 32 bit GOT offset.  */
+		case R_390_GOT64:	/* 64 bit GOT offset.  */
+		case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry >> 1. */
+			// FIXME: TODO
+			break;
+
+		case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+		case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+		case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
+		case R_390_PLT64:	/* 64 bit PC relative PLT address.   */
+			// FIXME: TODO
+			break;
+		case R_390_GLOB_DAT:	/* Create GOT entry.  */
+		case R_390_JMP_SLOT:	/* Create PLT entry.  */
+			*location = sym->st_value;
+			break;
+		case R_390_RELATIVE:	/* Adjust by program base.  */
+			// FIXME: TODO
+			break;
+		case R_390_GOTOFF:	/* 32 bit offset to GOT.  */
+			// FIXME: TODO
+			break;
+		case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
+		case R_390_GOTPCDBL:	/* 32 bit PC rel. GOT shifted by 1.  */
+			// FIXME: TODO
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
+			       me->name,
+			       (unsigned long)ELF_R_TYPE(rel[i].r_info));
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
diff -urN linux-2.5.48/arch/s390x/kernel/traps.c linux-2.5.48-s390/arch/s390x/kernel/traps.c
--- linux-2.5.48/arch/s390x/kernel/traps.c	Mon Nov 18 05:29:51 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/traps.c	Mon Nov 18 20:11:24 2002
@@ -74,8 +74,8 @@
 
 #ifdef CONFIG_MODULES
 
-extern struct module *module_list;
-extern struct module kernel_module;
+/* FIXME: Accessed without a lock --RR */
+extern struct list_head modules;
 
 static inline int kernel_text_address(unsigned long addr)
 {
@@ -86,11 +86,11 @@
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
+		if (mod_bound((void*)addr, 0, mod)) {
 			retval = 1;
 			break;
 		}
diff -urN linux-2.5.48/arch/s390x/kernel/wrapper32.S linux-2.5.48-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.48/arch/s390x/kernel/wrapper32.S	Mon Nov 18 05:29:57 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/wrapper32.S	Mon Nov 18 20:11:24 2002
@@ -564,12 +564,6 @@
 	llgtr	%r4,%r4			# old_sigset_emu31 *
 	jg	sys32_sigprocmask		# branch to system call
 
-	.globl  sys32_create_module_wrapper 
-sys32_create_module_wrapper:
-	llgtr	%r2,%r2			# const char *
-	llgfr	%r3,%r3			# size_t
-	jg	sys32_create_module	# branch to system call
-
 	.globl  sys32_init_module_wrapper 
 sys32_init_module_wrapper:
 	llgtr	%r2,%r2			# const char *
@@ -581,11 +575,6 @@
 	llgtr	%r2,%r2			# const char *
 	jg	sys32_delete_module	# branch to system call
 
-	.globl  sys32_get_kernel_syms_wrapper 
-sys32_get_kernel_syms_wrapper:
-	llgtr	%r2,%r2			# struct kernel_sym_emu31 *
-	jg	sys32_get_kernel_syms	# branch to system call
-
 	.globl  sys32_quotactl_wrapper 
 sys32_quotactl_wrapper:
 	lgfr	%r2,%r2			# int
@@ -786,15 +775,6 @@
 	llgtr	%r4,%r4			# __kernel_old_uid_emu31_t *
 	jg	sys32_getresuid16	# branch to system call
 
-	.globl  sys32_query_module_wrapper 
-sys32_query_module_wrapper:
-	llgtr	%r2,%r2			# const char * 
-	lgfr	%r3,%r3			# int 
-	llgtr	%r4,%r4			# char * 
-	llgfr	%r5,%r5			# size_t 
-	llgtr	%r6,%r6			# size_t * 
-	jg	sys32_query_module	# branch to system call
-
 	.globl  sys32_poll_wrapper 
 sys32_poll_wrapper:
 	llgtr	%r2,%r2			# struct pollfd * 
diff -urN linux-2.5.48/arch/s390x/mm/extable.c linux-2.5.48-s390/arch/s390x/mm/extable.c
--- linux-2.5.48/arch/s390x/mm/extable.c	Mon Nov 18 05:29:30 2002
+++ linux-2.5.48-s390/arch/s390x/mm/extable.c	Mon Nov 18 20:11:24 2002
@@ -2,10 +2,8 @@
  *  arch/s390/mm/extable.c
  *
  *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Hartmut Penner (hp@de.ibm.com)
  *
- *  Derived from "arch/i386/mm/extable.c"
+ *  identical to arch/i386/mm/extable.c
  */
 
 #include <linux/config.h>
@@ -42,24 +40,27 @@
 unsigned long
 search_exception_table(unsigned long addr)
 {
+	struct list_head *i;
 	unsigned long ret = 0;
-
+	
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
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
-		if (ret) 
+		ret = search_one_table(ex->entry,
+				       ex->entry + ex->num_entries - 1, addr);
+		if (ret)
 			break;
 	}
 	spin_unlock_irqrestore(&modlist_lock, flags);
diff -urN linux-2.5.48/include/asm-s390/module.h linux-2.5.48-s390/include/asm-s390/module.h
--- linux-2.5.48/include/asm-s390/module.h	Mon Nov 18 05:29:20 2002
+++ linux-2.5.48-s390/include/asm-s390/module.h	Mon Nov 18 20:11:24 2002
@@ -4,9 +4,22 @@
  * This file contains the s390 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
+struct mod_arch_specific
+{
+	void *module_got, *module_plt;
+	unsigned long got_size, plt_size;
+};
 
+#ifdef CONFIG_ARCH_S390X
+#define ElfW(x) Elf64_ ## x
+#define ELFW(x) ELF64_ ## x
+#else
+#define ElfW(x) Elf32_ ## x
+#define ELFW(x) ELF32_ ## x
+#endif
+
+#define Elf_Shdr ElfW(Shdr)
+#define Elf_Sym ElfW(Sym)
+#define Elf_Ehdr ElfW(Ehdr)
+#define ELF_R_TYPE ELFW(R_TYPE)
 #endif /* _ASM_S390_MODULE_H */
diff -urN linux-2.5.48/include/asm-s390x/module.h linux-2.5.48-s390/include/asm-s390x/module.h
--- linux-2.5.48/include/asm-s390x/module.h	Mon Nov 18 05:29:20 2002
+++ linux-2.5.48-s390/include/asm-s390x/module.h	Mon Nov 18 20:11:24 2002
@@ -4,9 +4,22 @@
  * This file contains the s390 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
+struct mod_arch_specific
+{
+	void *module_got, *module_plt;
+	unsigned long got_size, plt_size;
+};
 
+#ifdef CONFIG_ARCH_S390X
+#define ElfW(x) Elf64_ ## x
+#define ELFW(x) ELF64_ ## x
+#else
+#define ElfW(x) Elf32_ ## x
+#define ELFW(x) ELF64_ ## x
+#endif
+
+#define Elf_Shdr ElfW(Shdr)
+#define Elf_Sym ElfW(Sym)
+#define Elf_Ehdr ElfW(Ehdr)
+#define ELF_R_TYPE ELFW(R_TYPE)
 #endif /* _ASM_S390_MODULE_H */
diff -urN linux-2.5.48/include/linux/elf.h linux-2.5.48-s390/include/linux/elf.h
--- linux-2.5.48/include/linux/elf.h	Mon Nov 18 05:29:25 2002
+++ linux-2.5.48-s390/include/linux/elf.h	Mon Nov 18 20:11:24 2002
@@ -413,6 +413,37 @@
 /* Keep this the last entry.  */
 #define R_PPC_NUM		37
 
+/* s390 relocations defined by the ABIs */
+#define R_390_NONE	0	       /* No reloc.  */
+#define R_390_8		1	       /* Direct 8 bit.	 */
+#define R_390_12	2	       /* Direct 12 bit.  */
+#define R_390_16	3	       /* Direct 16 bit.  */
+#define R_390_32	4	       /* Direct 32 bit.  */
+#define R_390_PC32	5	       /* PC relative 32 bit.  */
+#define R_390_GOT12	6	       /* 12 bit GOT offset.  */
+#define R_390_GOT32	7	       /* 32 bit GOT offset.  */
+#define R_390_PLT32	8	       /* 32 bit PC relative PLT address.  */
+#define R_390_COPY	9	       /* Copy symbol at runtime.  */
+#define R_390_GLOB_DAT	10	       /* Create GOT entry.  */
+#define R_390_JMP_SLOT	11	       /* Create PLT entry.  */
+#define R_390_RELATIVE	12	       /* Adjust by program base.  */
+#define R_390_GOTOFF	13	       /* 32 bit offset to GOT.	 */
+#define R_390_GOTPC	14	       /* 32 bit PC relative offset to GOT.  */
+#define R_390_GOT16	15	       /* 16 bit GOT offset.  */
+#define R_390_PC16	16	       /* PC relative 16 bit.  */
+#define R_390_PC16DBL	17	       /* PC relative 16 bit shifted by 1.  */
+#define R_390_PLT16DBL	18	       /* 16 bit PC rel. PLT shifted by 1.  */
+#define R_390_PC32DBL	19	       /* PC relative 32 bit shifted by 1.  */
+#define R_390_PLT32DBL	20	       /* 32 bit PC rel. PLT shifted by 1.  */
+#define R_390_GOTPCDBL	21	       /* 32 bit PC rel. GOT shifted by 1.  */
+#define R_390_64	22	       /* Direct 64 bit.  */
+#define R_390_PC64	23	       /* PC relative 64 bit.  */
+#define R_390_GOT64	24	       /* 64 bit GOT offset.  */
+#define R_390_PLT64	25	       /* 64 bit PC relative PLT address.  */
+#define R_390_GOTENT	26	       /* 32 bit PC rel. to GOT entry >> 1. */
+/* Keep this the last entry.  */
+#define R_390_NUM	27
+
 /* Legal values for e_flags field of Elf64_Ehdr.  */
 
 #define EF_ALPHA_32BIT		1	/* All addresses are below 2GB */

