Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRLHN65>; Sat, 8 Dec 2001 08:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLHN6o>; Sat, 8 Dec 2001 08:58:44 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:17805 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280686AbRLHN6L>; Sat, 8 Dec 2001 08:58:11 -0500
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time. (2 Part)
Date: Sat, 8 Dec 2001 14:59:23 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZU210N515T24YDTHHI6I"
Message-ID: <16ChzE-1wAN60C@fwd01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZU210N515T24YDTHHI6I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

This is the 2nd Part of my patch. It is a simple elf-object loader
inserting modules wich are loaded at boot time into the kernel.

It depends on the 1st part, but if you don't like the multiboot thing 
this could be easily made to work with old style boot-loaders 
(If you add aditionaly features to the boot-loader).

Mfg, Christian Koenig. (and sorry for my poor English).






--------------Boundary-00=_ZU210N515T24YDTHHI6I
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="bootmodules.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bootmodules.diff"

diff -Nurb linux.orig/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux.orig/arch/i386/kernel/Makefile	Tue Sep 18 08:03:09 2001
+++ linux/arch/i386/kernel/Makefile	Wed Dec  5 22:12:44 2001
@@ -18,7 +18,8 @@

 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
+		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
+		obj_i386.o


 ifdef CONFIG_PCI
diff -Nurb linux.orig/arch/i386/kernel/obj_i386.c linux/arch/i386/kernel/obj_i386.c
--- linux.orig/arch/i386/kernel/obj_i386.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/i386/kernel/obj_i386.c	Sat Dec  8 14:16:06 2001
@@ -0,0 +1,237 @@
+/* i386 specific support for Elf loading and relocation.
+   Copyright 1996, 1997 Linux International.
+
+   Contributed by Richard Henderson <rth@tamu.edu>
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+#ident "$Id: obj_i386.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
+
+#include <linux/slab.h>
+#include <linux/obj_load.h>
+
+
+/*======================================================================*/
+
+struct i386_got_entry
+{
+  int offset;
+  unsigned offset_done : 1;
+  unsigned reloc_done : 1;
+};
+
+struct i386_file
+{
+  struct obj_file root;
+  struct obj_section *got;
+};
+
+struct i386_symbol
+{
+  struct obj_symbol root;
+  struct i386_got_entry gotent;
+};
+
+
+/*======================================================================*/
+
+struct obj_file *
+arch_new_file (void)
+{
+  struct i386_file *f;
+  f = kmalloc(sizeof(*f), GFP_KERNEL);
+  f->got = NULL;
+  return &f->root;
+}
+
+struct obj_section *
+arch_new_section (void)
+{
+  return kmalloc(sizeof(struct obj_section), GFP_KERNEL);
+}
+
+struct obj_symbol *
+arch_new_symbol (void)
+{
+  struct i386_symbol *sym;
+  sym = kmalloc(sizeof(*sym), GFP_KERNEL);
+  memset(&sym->gotent, 0, sizeof(sym->gotent));
+  return &sym->root;
+}
+
+int
+arch_load_proc_section(struct obj_section *sec, int fp)
+{
+    /* Assume it's just a debugging section that we can safely
+       ignore ...  */
+    sec->contents = NULL;
+
+    return 0;
+}
+
+enum obj_reloc
+arch_apply_relocation (struct obj_file *f,
+		       struct obj_section *targsec,
+		       struct obj_section *symsec,
+		       struct obj_symbol *sym,
+		       Elf32_Rel *rel,
+		       Elf32_Addr v)
+{
+  struct i386_file *ifile = (struct i386_file *)f;
+  struct i386_symbol *isym  = (struct i386_symbol *)sym;
+
+  Elf32_Addr *loc = (Elf32_Addr *)(targsec->contents + rel->r_offset);
+  Elf32_Addr dot = targsec->header.sh_addr + rel->r_offset;
+  Elf32_Addr got = ifile->got ? ifile->got->header.sh_addr : 0;
+
+  enum obj_reloc ret = obj_reloc_ok;
+
+  switch (ELF32_R_TYPE(rel->r_info))
+    {
+    case R_386_NONE:
+      break;
+
+    case R_386_32:
+      *loc += v;
+      break;
+
+    case R_386_PLT32:
+    case R_386_PC32:
+      *loc += v - dot;
+      break;
+
+    case R_386_GLOB_DAT:
+    case R_386_JMP_SLOT:
+      *loc = v;
+      break;
+
+    case R_386_RELATIVE:
+      *loc += f->baseaddr;
+      break;
+
+    case R_386_GOTPC:
+//      assert(got != 0);
+      *loc += got - dot;
+      break;
+
+    case R_386_GOT32:
+//      assert(isym != NULL);
+      if (!isym->gotent.reloc_done)
+	{
+	  isym->gotent.reloc_done = 1;
+	  *(Elf32_Addr *)(ifile->got->contents + isym->gotent.offset) = v;
+	}
+      *loc += isym->gotent.offset;
+      break;
+
+    case R_386_GOTOFF:
+//      assert(got != 0);
+      *loc += v - got;
+      break;
+
+    default:
+      ret = obj_reloc_unhandled;
+      break;
+    }
+
+  return ret;
+}
+
+int
+arch_create_got (struct obj_file *f)
+{
+  struct i386_file *ifile = (struct i386_file *)f;
+  int i, n, offset = 0, gotneeded = 0;
+
+  n = ifile->root.header.e_shnum;
+  for (i = 0; i < n; ++i)
+    {
+      struct obj_section *relsec, *symsec, *strsec;
+      Elf32_Rel *rel, *relend;
+      Elf32_Sym *symtab;
+      const char *strtab;
+
+      relsec = ifile->root.sections[i];
+      if (relsec->header.sh_type != SHT_REL)
+	continue;
+
+      symsec = ifile->root.sections[relsec->header.sh_link];
+      strsec = ifile->root.sections[symsec->header.sh_link];
+
+      rel = (Elf32_Rel *)relsec->contents;
+      relend = rel + (relsec->header.sh_size / sizeof(Elf32_Rel));
+      symtab = (Elf32_Sym *)symsec->contents;
+      strtab = (const char *)strsec->contents;
+
+      for (; rel < relend; ++rel)
+	{
+	  struct i386_symbol *intsym;
+
+	  switch (ELF32_R_TYPE(rel->r_info))
+	    {
+	    case R_386_GOTPC:
+	    case R_386_GOTOFF:
+	      gotneeded = 1;
+	    default:
+	      continue;
+
+	    case R_386_GOT32:
+	      break;
+	    }
+
+	  obj_find_relsym(intsym, f, &ifile->root, rel, symtab, strtab);
+
+	  if (!intsym->gotent.offset_done)
+	    {
+	      intsym->gotent.offset_done = 1;
+	      intsym->gotent.offset = offset;
+	      offset += 4;
+	    }
+	}
+    }
+
+  if (offset > 0 || gotneeded)
+    ifile->got = obj_create_alloced_section(&ifile->root, ".got", 4, offset,
+					    SHF_WRITE);
+
+  return 1;
+}
+
+int
+arch_init_module (struct obj_file *f, struct module *mod)
+{
+  return 1;
+}
+
+int
+arch_finalize_section_address(struct obj_file *f, Elf32_Addr base)
+{
+  int  i, n = f->header.e_shnum;
+
+  f->baseaddr = base;
+  for (i = 0; i < n; ++i)
+    f->sections[i]->header.sh_addr += base;
+  return 1;
+}
+
+int
+arch_archdata (struct obj_file *fin, struct obj_section *sec)
+{
+  return 0;
+}
diff -Nurb linux.orig/include/linux/obj_load.h linux/include/linux/obj_load.h
--- linux.orig/include/linux/obj_load.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/obj_load.h	Sat Dec  8 14:16:39 2001
@@ -0,0 +1,299 @@
+/* Elf object file loading and relocation routines.
+   Copyright 1996, 1997 Linux International.
+
+   Contributed by Richard Henderson <rth@tamu.edu>
+   obj_free() added by Björn Ekwall <bj0rn@blox.se> March 1999
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+
+#ifndef MODUTILS_OBJ_H
+#define MODUTILS_OBJ_H 1
+
+#ident "$Id: obj.h 1.7 Tue, 02 Oct 2001 11:22:51 +1000 kaos $"
+
+/* The relocatable object is manipulated using elfin types.  */
+
+#include <linux/types.h>
+#include <linux/elf.h>
+
+//#ifndef ElfW
+//# if ELF_CLASS == ELFCLASS32
+#  define ElfW(x)  Elf32_ ## x
+#  define ELFW(x)  ELF32_ ## x
+//# else
+//#  define ElfW(x)  Elf64_ ## x
+//#  define ELFW(x)  ELF64_ ## x
+//# endif
+//#endif
+
+#if defined(COMMON_3264) && defined(ONLY_32)
+#  define ObjW(x)  obj32_ ## x
+#else
+#  if defined(COMMON_3264) && defined(ONLY_64)
+#    define ObjW(x)  obj64_ ## x
+#  else
+#    define ObjW(x)    obj_ ## x
+#  endif
+#endif
+
+/* For some reason this is missing from lib5.  */
+#ifndef ELF32_ST_INFO
+# define ELF32_ST_INFO(bind, type)       (((bind) << 4) + ((type) & 0xf))
+#endif
+
+#ifndef ELF64_ST_INFO
+# define ELF64_ST_INFO(bind, type)       (((bind) << 4) + ((type) & 0xf))
+#endif
+
+struct obj_string_patch_struct;
+struct obj_symbol_patch_struct;
+
+struct obj_section
+{
+  ElfW(Shdr) header;
+  const char *name;
+  char *contents;
+  struct obj_section *load_next;
+  int idx;
+};
+
+struct obj_symbol
+{
+  struct obj_symbol *next;	/* hash table link */
+  const char *name;
+  unsigned long value;
+  unsigned long size;
+  int secidx;			/* the defining section index/module */
+  int info;
+  int ksymidx;			/* for export to the kernel symtab */
+  int r_type;			/* relocation type */
+};
+
+/* Hardcode the hash table size.  We shouldn't be needing so many
+   symbols that we begin to degrade performance, and we get a big win
+   by giving the compiler a constant divisor.  */
+
+#define HASH_BUCKETS  521
+
+struct obj_file
+{
+  ElfW(Ehdr) header;
+  ElfW(Addr) baseaddr;
+  struct obj_section **sections;
+  struct obj_section *load_order;
+  struct obj_section **load_order_search_start;
+  struct obj_string_patch_struct *string_patches;
+  struct obj_symbol_patch_struct *symbol_patches;
+  int (*symbol_cmp)(const char *, const char *);
+  unsigned long (*symbol_hash)(const char *);
+  unsigned long local_symtab_size;
+  struct obj_symbol **local_symtab;
+  struct obj_symbol *symtab[HASH_BUCKETS];
+  const char *filename;
+  char *persist;
+};
+
+enum obj_reloc
+{
+  obj_reloc_ok,
+  obj_reloc_overflow,
+  obj_reloc_dangerous,
+  obj_reloc_unhandled,
+  obj_reloc_constant_gp
+};
+
+struct obj_string_patch_struct
+{
+  struct obj_string_patch_struct *next;
+  int reloc_secidx;
+  ElfW(Addr) reloc_offset;
+  ElfW(Addr) string_offset;
+};
+
+struct obj_symbol_patch_struct
+{
+  struct obj_symbol_patch_struct *next;
+  int reloc_secidx;
+  ElfW(Addr) reloc_offset;
+  struct obj_symbol *sym;
+};
+
+
+/* Generic object manipulation routines.  */
+
+#define obj_elf_hash			ObjW(elf_hash)
+#define obj_elf_hash_n			ObjW(elf_hash_n)
+#define obj_add_symbol			ObjW(add_symbol)
+#define obj_find_symbol			ObjW(find_symbol)
+#define obj_symbol_final_value		ObjW(symbol_final_value)
+#define obj_set_symbol_compare		ObjW(set_symbol_compare)
+#define obj_find_section		ObjW(find_section)
+#define obj_insert_section_load_order	ObjW(insert_section_load_order)
+#define obj_create_alloced_section	ObjW(create_alloced_section)
+#define obj_create_alloced_section_first \
+					ObjW(create_alloced_section_first)
+#define obj_extend_section		ObjW(extend_section)
+#define obj_string_patch		ObjW(string_patch)
+#define obj_symbol_patch		ObjW(symbol_patch)
+#define obj_check_undefineds		ObjW(check_undefineds)
+#define obj_clear_undefineds		ObjW(clear_undefineds)
+#define obj_allocate_commons		ObjW(allocate_commons)
+#define obj_load_size			ObjW(load_size)
+#define obj_relocate			ObjW(relocate)
+#define obj_load			ObjW(load)
+#define obj_free			ObjW(free)
+#define obj_create_image		ObjW(create_image)
+#define obj_addr_to_native_ptr		ObjW(addr_to_native_ptr)
+#define obj_native_ptr_to_addr		ObjW(native_ptr_to_addr)
+#define obj_kallsyms			ObjW(kallsyms)
+#define arch_new_file			ObjW(arch_new_file)
+#define arch_new_section		ObjW(arch_new_section)
+#define arch_new_symbol			ObjW(arch_new_symbol)
+#define arch_apply_relocation		ObjW(arch_apply_relocation)
+#define arch_create_got			ObjW(arch_create_got)
+#define arch_init_module		ObjW(arch_init_module)
+#define arch_load_proc_section		ObjW(arch_load_proc_section)
+#define arch_finalize_section_address	ObjW(arch_finalize_section_address)
+#define arch_archdata			ObjW(arch_archdata)
+
+unsigned long obj_elf_hash (const char *);
+
+unsigned long obj_elf_hash_n (const char *, unsigned long len);
+
+struct obj_symbol *obj_add_symbol (struct obj_file *f, const char *name,
+				   unsigned long symidx, int info, int secidx,
+				   ElfW(Addr) value, unsigned long size);
+
+struct obj_symbol *obj_find_symbol (struct obj_file *f,
+					 const char *name);
+
+ElfW(Addr) obj_symbol_final_value (struct obj_file *f,
+				  struct obj_symbol *sym);
+
+void obj_set_symbol_compare (struct obj_file *f,
+			    int (*cmp)(const char *, const char *),
+			    unsigned long (*hash)(const char *));
+
+struct obj_section *obj_find_section (struct obj_file *f,
+					   const char *name);
+
+void obj_insert_section_load_order (struct obj_file *f,
+				    struct obj_section *sec);
+
+struct obj_section *obj_create_alloced_section (struct obj_file *f,
+						const char *name,
+						unsigned long align,
+						unsigned long size,
+						unsigned long flags);
+
+struct obj_section *obj_create_alloced_section_first (struct obj_file *f,
+						      const char *name,
+						      unsigned long align,
+						      unsigned long size);
+
+void *obj_extend_section (struct obj_section *sec, unsigned long more);
+
+int obj_string_patch (struct obj_file *f, int secidx, ElfW(Addr) offset,
+		     const char *string);
+
+int obj_symbol_patch (struct obj_file *f, int secidx, ElfW(Addr) offset,
+		     struct obj_symbol *sym);
+
+int obj_check_undefineds (struct obj_file *f, int quiet);
+
+void obj_clear_undefineds (struct obj_file *f);
+
+void obj_allocate_commons (struct obj_file *f);
+
+unsigned long obj_load_size (struct obj_file *f);
+
+int obj_relocate (struct obj_file *f, ElfW(Addr) base);
+
+struct obj_file *
+obj_load (void *modmem, unsigned int modsize, Elf32_Half e_type, const char *filename);
+
+void obj_free (struct obj_file *f);
+
+int obj_create_image (struct obj_file *f, char *image);
+
+int obj_kallsyms (struct obj_file *fin, struct obj_file **fout);
+
+/* Architecture specific manipulation routines.  */
+
+struct obj_file *arch_new_file (void);
+
+struct obj_section *arch_new_section (void);
+
+struct obj_symbol *arch_new_symbol (void);
+
+enum obj_reloc arch_apply_relocation (struct obj_file *f,
+				      struct obj_section *targsec,
+				      struct obj_section *symsec,
+				      struct obj_symbol *sym,
+				      ElfW(Rel) *rel, ElfW(Addr) value);
+
+int arch_create_got (struct obj_file *f);
+
+struct module;
+int arch_init_module (struct obj_file *f, struct module *);
+
+int arch_load_proc_section (struct obj_section *sec, int fp);
+
+int arch_finalize_section_address (struct obj_file *f, ElfW(Addr) base);
+
+int arch_archdata (struct obj_file *fin, struct obj_section *sec);
+
+#define ARCHDATA_SEC_NAME "__archdata"
+
+/* Pointers in objects can be 32 or 64 bit */
+union obj_ptr_4 {
+	Elf32_Word addr;
+	void *ptr;
+};
+union obj_ptr_8 {
+	u_int64_t addr;	/* Should be Elf64_Xword but not all users have this yet */
+	void *ptr;
+};
+
+void *obj_addr_to_native_ptr(ElfW(Addr));
+
+ElfW(Addr) obj_native_ptr_to_addr(void *);
+
+/* Standard method of finding relocation symbols, sets isym */
+#define obj_find_relsym(isym, f, find, rel, symtab, strtab) \
+	{ \
+		unsigned long symndx = ELFW(R_SYM)((rel)->r_info); \
+		ElfW(Sym) *extsym = (symtab)+symndx; \
+		if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL) { \
+			isym = (typeof(isym)) (f)->local_symtab[symndx]; \
+		} \
+		else { \
+			const char *name; \
+			if (extsym->st_name) \
+				name = (strtab) + extsym->st_name; \
+			else \
+				name = (f)->sections[extsym->st_shndx]->name; \
+			isym = (typeof(isym)) obj_find_symbol((find), name); \
+		} \
+	}
+
+int obj_gpl_license(struct obj_file *, const char **);
+
+#endif /* obj.h */
diff -Nurb linux.orig/init/main.c linux/init/main.c
--- linux.orig/init/main.c	Fri Oct 12 19:17:15 2001
+++ linux/init/main.c	Tue Dec  4 02:13:42 2001
@@ -94,6 +94,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern int init_pcmcia_ds(void);
+extern void init_boot_modules(void);

 extern void free_initmem(void);

@@ -736,6 +737,7 @@
 #ifdef CONFIG_PCMCIA
 	init_pcmcia_ds();		/* Do this last */
 #endif
+	init_boot_modules();
 }

 extern void rd_load(void);
diff -Nurb linux.orig/kernel/Makefile linux/kernel/Makefile
--- linux.orig/kernel/Makefile	Mon Sep 17 06:22:40 2001
+++ linux/kernel/Makefile	Wed Dec  5 22:28:24 2001
@@ -14,7 +14,8 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o boot_modules.o \
+	    obj_common.o obj_reloc.o obj_gpl_license.o obj_load.o

 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nurb linux.orig/kernel/boot_modules.c linux/kernel/boot_modules.c
--- linux.orig/kernel/boot_modules.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/boot_modules.c	Thu Dec  6 15:11:02 2001
@@ -0,0 +1,413 @@
+/*
+ *  linux/kernel/boot_modules.c
+ *
+ *  Copyright (C) 2001 Christian König
+ *
+ *  Ervery thing here is GPL'ed.
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+
+#ifndef __i386__ //this file should'n be arch dependent, but I'am lazy
+
+void init_boot_modules(void) {}
+
+#else
+
+#include <asm/multiboot.h>
+#include <linux/obj_load.h>
+#include <linux/version.h>
+#include <linux/module.h>
+
+#define STRVERSIONLEN	32
+
+/*
+ * Conditionally add the symbols from the given symbol set
+ * to the new module.
+ */
+static int add_symbols_from(struct obj_file *f, int idx,
+			    struct module_symbol *syms, size_t nsyms, int gpl)
+{
+	struct module_symbol *s;
+	size_t i;
+	int used = 0;
+
+	for (i = 0, s = syms; i < nsyms; ++i, ++s) {
+		/*
+		 * Only add symbols that are already marked external.
+		 * If we override locals we may cause problems for
+		 * argument initialization.
+		 * We will also create a false dependency on the module.
+		 */
+		struct obj_symbol *sym;
+
+		/* GPL licensed modules can use symbols exported with
+		 * EXPORT_SYMBOL_GPL, so ignore any GPLONLY_ prefix on the
+		 * exported names.  Non-GPL modules never see any GPLONLY_
+		 * symbols so they cannot fudge it by adding the prefix on
+		 * their references.
+		 */
+		if (strncmp((char *)s->name, "GPLONLY_", 8) == 0) {
+			if (gpl)
+				((char *)s->name) += 8;
+			else
+				continue;
+		}
+
+		sym = obj_find_symbol(f, (char *) s->name);
+		if (sym && ELFW(ST_BIND) (sym->info) != STB_LOCAL) {
+			sym = obj_add_symbol(f, (char *) s->name, -1,
+				  ELFW(ST_INFO) (STB_GLOBAL, STT_NOTYPE),
+					     idx, s->value, 0);
+			/*
+			 * Did our symbol just get installed?
+			 * If so, mark the module as "used".
+			 */
+			if (sym->secidx == idx)
+				used = 1;
+		}
+	}
+
+	return used;
+}
+
+static void add_kernel_symbols(struct obj_file *f, int gpl)
+{
+	struct module *mod;
+	size_t i;
+
+	/* Add module symbols first.  */
+	for (mod=module_list, i = 0; mod; mod=mod->next, i++)
+		if (mod->nsyms)
+			add_symbols_from(f, SHN_HIRESERVE + 2 + i, mod->syms, mod->nsyms, gpl);
+}
+
+static int create_this_module(struct obj_file *f, const char *m_name)
+{
+	struct obj_section *sec;
+
+	sec = obj_create_alloced_section_first(f, ".this", sizeof(long),
+					       sizeof(struct module));
+	memset(sec->contents, 0, sizeof(struct module));
+
+	obj_add_symbol(f, "__this_module", -1, ELFW(ST_INFO) (STB_LOCAL, STT_OBJECT),
+		       sec->idx, 0, sizeof(struct module));
+
+	obj_string_patch(f, sec->idx, offsetof(struct module, name), m_name);
+
+	return 1;
+}
+
+static void hide_special_symbols(struct obj_file *f)
+{
+	struct obj_symbol *sym;
+	const char *const *p;
+	static const char *const specials[] =
+	{
+		"cleanup_module",
+		"init_module",
+		"kernel_version",
+		NULL
+	};
+
+	for (p = specials; *p; ++p)
+		if ((sym = obj_find_symbol(f, *p)) != NULL)
+			sym->info = ELFW(ST_INFO) (STB_LOCAL, ELFW(ST_TYPE) (sym->info));
+}
+
+static int create_module_ksymtab(struct obj_file *f)
+{
+	struct obj_section *sec;
+	int i;
+
+	/* We must always add the module references.  */
+
+/*	if (n_ext_modules_used) {
+		struct module_ref *dep;
+		struct obj_symbol *tm;
+
+		sec = obj_create_alloced_section(f, ".kmodtab",
+			tgt_sizeof_void_p,
+			sizeof(struct module_ref) * n_ext_modules_used, 0);
+		if (!sec)
+			return 0;
+
+		tm = obj_find_symbol(f, "__this_module");
+		dep = (struct module_ref *) sec->contents;
+		for (i = 0; i < n_module_stat; ++i)
+			if (module_stat[i].status ) {
+				dep->dep = module_stat[i].addr;
+				obj_symbol_patch(f, sec->idx, (char *) &dep->ref - sec->contents, tm);
+				dep->next_ref = 0;
+				++dep;
+			}
+	}*/
+/*	if (!obj_find_section(f, "__ksymtab")) {
+		int *loaded;
+
+		 We don't want to export symbols residing in sections that
+		   aren't loaded.  There are a number of these created so that
+		   we make sure certain module options don't appear twice.
+
+		loaded = alloca(sizeof(int) * (i = f->header.e_shnum));
+		while (--i >= 0)
+			loaded[i] = (f->sections[i]->header.sh_flags & SHF_ALLOC) != 0;
+
+		for (i = 0; i < HASH_BUCKETS; ++i) {
+			struct obj_symbol *sym;
+			for (sym = f->symtab[i]; sym; sym = sym->next) {
+				if (ELFW(ST_BIND) (sym->info) != STB_LOCAL
+				    && sym->secidx <= SHN_HIRESERVE
+				    && (sym->secidx >= SHN_LORESERVE
+					|| loaded[sym->secidx])) {
+					add_ksymtab(f, sym);
+				}
+			}
+		}
+	}*/
+	return 1;
+}
+
+extern asmlinkage unsigned long sys_create_module(const char *name_user, size_t size);
+extern asmlinkage long sys_delete_module(const char *name_user);
+extern asmlinkage long sys_init_module(const char *name_user, struct module *mod_user);
+
+static int init_module(const char *m_name, struct obj_file *f,
+		       unsigned long m_size)
+{
+	struct module *module;
+	struct obj_section *sec;
+	void *image;
+	int ret = 0;
+	long m_addr;
+
+	sec = obj_find_section(f, ".this");
+	module = (struct module *) sec->contents;
+	m_addr = sec->header.sh_addr;
+
+	module->size_of_struct = sizeof(*module);
+	module->size = m_size;
+	module->flags = 0; //flag_autoclean ? NEW_MOD_AUTOCLEAN : 0;
+
+	sec = obj_find_section(f, "__ksymtab");
+	if (sec && sec->header.sh_size) {
+		module->syms = sec->header.sh_addr;
+		module->nsyms = sec->header.sh_size / (2 * sizeof(char *));
+	}
+/*	if (n_ext_modules_used) {
+		sec = obj_find_section(f, ".kmodtab");
+		module->deps = sec->header.sh_addr;
+		module->ndeps = n_ext_modules_used;
+	}*/
+	module->init = obj_symbol_final_value(f, obj_find_symbol(f, "init_module"));
+	module->cleanup = obj_symbol_final_value(f,
+		obj_find_symbol(f, "cleanup_module"));
+
+	sec = obj_find_section(f, "__ex_table");
+	if (sec) {
+		module->ex_table_start = sec->header.sh_addr;
+		module->ex_table_end = sec->header.sh_addr + sec->header.sh_size;
+	}
+	sec = obj_find_section(f, ".text.init");
+	if (sec) {
+		module->runsize = sec->header.sh_addr - m_addr;
+	}
+	sec = obj_find_section(f, ".data.init");
+	if (sec) {
+		if (!module->runsize ||
+		    module->runsize > sec->header.sh_addr - m_addr)
+			module->runsize = sec->header.sh_addr - m_addr;
+	}
+/*	sec = obj_find_section(f, ARCHDATA_SEC_NAME);
+	if (sec && sec->header.sh_size) {
+		module->archdata_start = sec->header.sh_addr;
+		module->archdata_end = module->archdata_start + sec->header.sh_size;
+	}
+	sec = obj_find_section(f, KALLSYMS_SEC_NAME);
+	if (sec && sec->header.sh_size) {
+		module->kallsyms_start = sec->header.sh_addr;
+		module->kallsyms_end = module->kallsyms_start + sec->header.sh_size;
+	}
+	if (!arch_init_module(f, module))
+		return 0;
+*/
+	/*
+	 * Whew!  All of the initialization is complete.
+	 * Collect the final module image and give it to the kernel.
+	 */
+	image = kmalloc(m_size, GFP_KERNEL);
+	obj_create_image(f, image);
+
+	if (ret == 0) {
+//		fflush(stdout);		/* Flush any debugging output */
+		ret = sys_init_module(m_name, (struct module *) image);
+		if (ret) {
+			printk(KERN_INFO "init_module: %m\n");
+			printk(KERN_INFO "Hint: insmod errors can be caused by incorrect module parameters, "
+				"including invalid IO or IRQ parameters\n");
+		}
+	}
+
+	kfree(image);
+
+	return ret == 0;
+}
+
+static int insert_module(struct obj_file *f, const char *m_name, int argc, char **argv)
+{
+	int gpl;
+	unsigned long m_size;
+	unsigned long m_addr;
+
+/*	int k_crcs;
+	int m_version;
+	char m_strversion[STRVERSIONLEN];
+	int m_crcs;
+
+	m_version = get_module_version(f, m_strversion);
+	if (m_version == -1) {
+		printk(KERN_INFO "couldn't find the kernel version the module was compiled for");
+		return 0;
+	}
+
+	k_crcs = is_kernel_checksummed();
+	m_crcs = is_module_checksummed(f);
+	if ((m_crcs == 0 || k_crcs == 0) &&
+	    strncmp(m_strversion, UTS_RELEASE, STRVERSIONLEN) != 0) {
+		printk(KERN_INFO "kernel-module version mismatch\n"
+		      "\t%s was compiled for kernel version %s\n"
+		      "\twhile this kernel is version %s.",
+		      filename, m_strversion, UTS_RELEASE);
+		return 0;
+	}
+	if (m_crcs != k_crcs)
+		obj_set_symbol_compare(f, ncv_strcmp, ncv_symbol_hash);*/
+
+	// We don't care about Versions for now
+
+	/* Let the module know about the kernel symbols.  */
+	gpl = obj_gpl_license(f, NULL) == 0;
+	add_kernel_symbols(f, gpl);
+
+	/* Allocate common symbols, symbol tables, and string tables.
+	 *
+	 * The calls marked DEPMOD indicate the bits of code that depmod
+	 * uses to do a pseudo relocation, ignoring undefined symbols.
+	 * Any changes made to the relocation sequence here should be
+	 * checked against depmod.
+	 */
+	if (!create_this_module(f, m_name))
+		return 0;
+
+	arch_create_got(f);     /* DEPMOD */
+	if (!obj_check_undefineds(f, 0)) {	/* DEPMOD, obj_clear_undefineds */
+		if (!gpl)
+			printk(KERN_INFO "Note: modules without a GPL compatible license cannot use GPLONLY_ symbols\n");
+		return 0;
+	}
+	obj_allocate_commons(f);	/* DEPMOD */
+
+//	check_module_parameters(f, &persist_parms);
+//	check_tainted_module(f, noload);
+
+/*	if (argc) {
+		if (!process_module_arguments(f, argc, argv, 1))
+			return 0;
+	}*/
+	hide_special_symbols(f);
+
+/*	if (flag_ksymoops)
+		add_ksymoops_symbols(f, filename, m_name);*/
+
+//	if (k_new_syscalls)
+	create_module_ksymtab(f);
+
+	/* archdata based on relocatable addresses */
+//	if (add_archdata(f, &archdata))
+//		return 0;
+
+	/* kallsyms based on relocatable addresses */
+//	if (add_kallsyms(f, &kallsyms, force_kallsyms))
+//		return 0;
+	/**** No symbols or sections to be changed after kallsyms above ***/
+
+//	if (errors)
+//		return 0;
+
+	/* Module has now finished growing; find its size and install it.  */
+	m_size = obj_load_size(f);	/* DEPMOD */
+
+//	errno = 0;
+	m_addr = sys_create_module(m_name, m_size);
+
+	switch (-m_addr) {
+	case 0:
+		break;
+	case EEXIST:
+		printk(KERN_INFO "a module named %s already exists\n", m_name);
+		return 0;
+	case ENOMEM:
+		printk(KERN_INFO "can't allocate kernel memory for module; needed %lu bytes\n",
+		      m_size);
+		return 0;
+	default:
+		if(m_addr > 127)
+			break;
+		printk(KERN_INFO "create_module: %m\n");
+		return 0;
+	}
+
+	printk(KERN_INFO "Trying to relocate module @ 0x%x\n",m_addr);
+	if (!obj_relocate(f, m_addr)) {	/* DEPMOD */
+		sys_delete_module(m_name);
+		return 0;
+	}
+
+	/* Do archdata again, this time we have the final addresses */
+//	if (add_archdata(f, &archdata))
+//		return 0;
+
+	/* Do kallsyms again, this time we have the final addresses */
+//	if (add_kallsyms(f, &kallsyms, force_kallsyms))
+//		return 0;
+
+	init_module(m_name, f, m_size);
+/*	if (errors) {
+		delete_module(m_name);
+		return 0;
+	}*/
+	return 1;
+}
+
+void init_boot_modules(void)
+{
+	int i;
+	struct obj_file *f;
+
+	if(!mbootinfo)
+		return;
+	if(!(mbootinfo->flags & 8))
+		return;
+
+	for(i=0;i<mbootinfo->mods_count;i++) {
+		char *m_name;
+		struct multiboot_module *mod = &mbootinfo->mods_addr[i];
+
+		for(m_name = mod->string;
+		    (*m_name != 0) && (*m_name != ' ') && (strncmp(m_name,".o",2) != 0);
+		    m_name++);
+		*m_name = 0;
+		for(;(m_name > mod->string) && (*m_name != '/');m_name--);
+		m_name++;
+
+		printk(KERN_INFO "Ok Starting to load Module %s from addr 0x%x - 0x%x\n", m_name, mod->mod_start, mod->mod_end);
+		f = obj_load ((void *)mod->mod_start, mod->mod_end - mod->mod_start, ET_REL, mod->string);
+		if (!f) continue;
+
+		insert_module(f,m_name,0,0);
+		obj_free(f);
+	}
+}
+
+#endif
diff -Nurb linux.orig/kernel/obj_common.c linux/kernel/obj_common.c
--- linux.orig/kernel/obj_common.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/obj_common.c	Wed Dec  5 23:24:38 2001
@@ -0,0 +1,424 @@
+/* Elf file, section, and symbol manipulation routines.
+   Copyright 1996, 1997 Linux International.
+
+   Contributed by Richard Henderson <rth@tamu.edu>
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+#ident "$Id: obj_common.c 1.4 Wed, 26 Sep 2001 11:58:34 +1000 kaos $"
+
+#include <linux/slab.h>
+
+#include <linux/obj_load.h>
+
+/*======================================================================*/
+
+/* Standard ELF hash function.  */
+inline unsigned long
+obj_elf_hash_n(const char *name, unsigned long n)
+{
+  unsigned long h = 0;
+  unsigned long g;
+  unsigned char ch;
+
+  while (n > 0)
+    {
+      ch = *name++;
+      h = (h << 4) + ch;
+      if ((g = (h & 0xf0000000)) != 0)
+	{
+	  h ^= g >> 24;
+	  h &= ~g;
+	}
+      n--;
+    }
+  return h;
+}
+
+unsigned long
+obj_elf_hash (const char *name)
+{
+  return obj_elf_hash_n(name, strlen(name));
+}
+
+void
+obj_set_symbol_compare (struct obj_file *f,
+			int (*cmp)(const char *, const char *),
+			unsigned long (*hash)(const char *))
+{
+  if (cmp)
+    f->symbol_cmp = cmp;
+  if (hash)
+    {
+      struct obj_symbol *tmptab[HASH_BUCKETS], *sym, *next;
+      int i;
+
+      f->symbol_hash = hash;
+
+      memcpy(tmptab, f->symtab, sizeof(tmptab));
+      memset(f->symtab, 0, sizeof(f->symtab));
+
+      for (i = 0; i < HASH_BUCKETS; ++i)
+	for (sym = tmptab[i]; sym ; sym = next)
+	  {
+	    unsigned long h = hash(sym->name) % HASH_BUCKETS;
+	    next = sym->next;
+	    sym->next = f->symtab[h];
+	    f->symtab[h] = sym;
+	  }
+    }
+}
+
+struct obj_symbol *
+obj_add_symbol (struct obj_file *f, const char *name, unsigned long symidx,
+		int info, int secidx, ElfW(Addr) value, unsigned long size)
+{
+  struct obj_symbol *sym;
+  unsigned long hash = f->symbol_hash(name) % HASH_BUCKETS;
+  int n_type = ELFW(ST_TYPE)(info);
+  int n_binding = ELFW(ST_BIND)(info);
+
+  for (sym = f->symtab[hash]; sym; sym = sym->next)
+    if (f->symbol_cmp(sym->name, name) == 0)
+      {
+	int o_secidx = sym->secidx;
+	int o_info = sym->info;
+	int o_type = ELFW(ST_TYPE)(o_info);
+	int o_binding = ELFW(ST_BIND)(o_info);
+
+	/* A redefinition!  Is it legal?  */
+
+	if (secidx == SHN_UNDEF)
+	  return sym;
+	else if (o_secidx == SHN_UNDEF)
+	  goto found;
+	else if (n_binding == STB_GLOBAL && o_binding == STB_LOCAL)
+	  {
+	    /* Cope with local and global symbols of the same name
+	       in the same object file, as might have been created
+	       by ld -r.  The only reason locals are now seen at this
+	       level at all is so that we can do semi-sensible things
+	       with parameters.  */
+
+	    struct obj_symbol *nsym, **p;
+
+	    nsym = arch_new_symbol();
+	    nsym->next = sym->next;
+	    nsym->ksymidx = -1;
+
+	    /* Excise the old (local) symbol from the hash chain.  */
+	    for (p = &f->symtab[hash]; *p != sym; p = &(*p)->next)
+	      continue;
+	    *p = sym = nsym;
+	    goto found;
+	  }
+	else if (n_binding == STB_LOCAL)
+	  {
+	    /* Another symbol of the same name has already been defined.
+	       Just add this to the local table.  */
+	    sym = arch_new_symbol();
+	    sym->next = NULL;
+	    sym->ksymidx = -1;
+	    f->local_symtab[symidx] = sym;
+	    goto found;
+	  }
+	else if (n_binding == STB_WEAK)
+	  return sym;
+	else if (o_binding == STB_WEAK)
+	  goto found;
+	/* Don't unify COMMON symbols with object types the programmer
+	   doesn't expect.  */
+	else if (secidx == SHN_COMMON
+		 && (o_type == STT_NOTYPE || o_type == STT_OBJECT))
+	  return sym;
+	else if (o_secidx == SHN_COMMON
+		 && (n_type == STT_NOTYPE || n_type == STT_OBJECT))
+	  goto found;
+	else
+	  {
+	    /* Don't report an error if the symbol is coming from
+	       the kernel or some external module.  */
+	    if (secidx <= SHN_HIRESERVE)
+	      printk(KERN_INFO "%s multiply defined", name);
+	    return sym;
+	  }
+      }
+
+  /* Completely new symbol.  */
+  sym = arch_new_symbol();
+  sym->next = f->symtab[hash];
+  f->symtab[hash] = sym;
+  sym->ksymidx = -1;
+
+  if (ELFW(ST_BIND)(info) == STB_LOCAL && symidx != -1) {
+    if (symidx >= f->local_symtab_size)
+      printk(KERN_INFO "local symbol %s with index %ld exceeds local_symtab_size %ld",
+        name, (long) symidx, (long) f->local_symtab_size);
+    else
+      f->local_symtab[symidx] = sym;
+  }
+
+found:
+  sym->name = name;
+  sym->value = value;
+  sym->size = size;
+  sym->secidx = secidx;
+  sym->info = info;
+  sym->r_type = 0;	/* should be R_arch_NONE for all arch */
+
+  return sym;
+}
+
+struct obj_symbol *
+obj_find_symbol (struct obj_file *f, const char *name)
+{
+  struct obj_symbol *sym;
+  unsigned long hash = f->symbol_hash(name) % HASH_BUCKETS;
+
+  for (sym = f->symtab[hash]; sym; sym = sym->next)
+    if (f->symbol_cmp(sym->name, name) == 0)
+      return sym;
+
+  return NULL;
+}
+
+ElfW(Addr)
+obj_symbol_final_value (struct obj_file *f, struct obj_symbol *sym)
+{
+  if (sym)
+    {
+      if (sym->secidx >= SHN_LORESERVE)
+	return sym->value;
+
+      return sym->value + f->sections[sym->secidx]->header.sh_addr;
+    }
+  else
+    {
+      /* As a special case, a NULL sym has value zero.  */
+      return 0;
+    }
+}
+
+struct obj_section *
+obj_find_section (struct obj_file *f, const char *name)
+{
+  int i, n = f->header.e_shnum;
+
+  for (i = 0; i < n; ++i)
+    if (strcmp(f->sections[i]->name, name) == 0)
+      return f->sections[i];
+
+  return NULL;
+}
+
+#if defined (ARCH_alpha)
+#define ARCH_SHF_SHORT	SHF_ALPHA_GPREL
+#elif defined (ARCH_ia64)
+#define ARCH_SHF_SHORT	SHF_IA_64_SHORT
+#else
+#define ARCH_SHF_SHORT	0
+#endif
+
+static int
+obj_load_order_prio(struct obj_section *a)
+{
+  unsigned long af, ac;
+
+  af = a->header.sh_flags;
+
+  ac = 0;
+  if (a->name[0] != '.'
+      || strlen(a->name) != 10
+      || strcmp(a->name + 5, ".init"))
+    ac |= 64;
+  if (af & SHF_ALLOC) ac |= 32;
+  if (af & SHF_EXECINSTR) ac |= 16;
+  if (!(af & SHF_WRITE)) ac |= 8;
+  if (a->header.sh_type != SHT_NOBITS) ac |= 4;
+  /* Desired order is
+		P S  AC & 7
+	.data	1 0  4
+	.got	1 1  3
+	.sdata  1 1  1
+	.sbss   0 1  1
+	.bss    0 0  0  */
+  if (strcmp (a->name, ".got") == 0) ac |= 2;
+  if (af & ARCH_SHF_SHORT)
+    ac = (ac & ~4) | 1;
+
+  return ac;
+}
+
+void
+obj_insert_section_load_order (struct obj_file *f, struct obj_section *sec)
+{
+  struct obj_section **p;
+  int prio = obj_load_order_prio(sec);
+  for (p = f->load_order_search_start; *p ; p = &(*p)->load_next)
+    if (obj_load_order_prio(*p) < prio)
+      break;
+  sec->load_next = *p;
+  *p = sec;
+}
+
+static void *realloc(void *ptr, unsigned int size, unsigned int oldsize)
+{
+	void *new;
+	new = kmalloc(size, GFP_KERNEL);
+	memcpy(new, ptr, oldsize);
+	kfree(ptr);
+	return new;
+}
+
+struct obj_section *
+obj_create_alloced_section (struct obj_file *f, const char *name,
+			    unsigned long align, unsigned long size,
+			    unsigned long flags)
+{
+  int newidx = f->header.e_shnum++;
+  struct obj_section *sec;
+
+  f->sections = realloc(f->sections, (newidx+1) * sizeof(sec), newidx * sizeof(sec));
+  f->sections[newidx] = sec = arch_new_section();
+
+  memset(sec, 0, sizeof(*sec));
+  sec->header.sh_type = SHT_PROGBITS;
+  sec->header.sh_flags = flags | SHF_ALLOC;
+  sec->header.sh_size = size;
+  sec->header.sh_addralign = align;
+  sec->name = name;
+  sec->idx = newidx;
+  if (size)
+    sec->contents = kmalloc(size, GFP_KERNEL);
+
+  obj_insert_section_load_order(f, sec);
+
+  return sec;
+}
+
+struct obj_section *
+obj_create_alloced_section_first (struct obj_file *f, const char *name,
+				  unsigned long align, unsigned long size)
+{
+  int newidx = f->header.e_shnum++;
+  struct obj_section *sec;
+
+  f->sections = realloc(f->sections, (newidx+1) * sizeof(sec), newidx * sizeof(sec));
+  f->sections[newidx] = sec = arch_new_section();
+
+  memset(sec, 0, sizeof(*sec));
+  sec->header.sh_type = SHT_PROGBITS;
+  sec->header.sh_flags = SHF_WRITE|SHF_ALLOC;
+  sec->header.sh_size = size;
+  sec->header.sh_addralign = align;
+  sec->name = name;
+  sec->idx = newidx;
+  if (size)
+    sec->contents = kmalloc(size, GFP_KERNEL);
+
+  sec->load_next = f->load_order;
+  f->load_order = sec;
+  if (f->load_order_search_start == &f->load_order)
+    f->load_order_search_start = &sec->load_next;
+
+  return sec;
+}
+
+void *
+obj_extend_section (struct obj_section *sec, unsigned long more)
+{
+  unsigned long oldsize = sec->header.sh_size;
+  sec->contents = realloc(sec->contents, sec->header.sh_size += more, oldsize);
+  return sec->contents + oldsize;
+}
+
+/* Convert an object pointer (address) to a native pointer and vice versa.
+ * It gets interesting when the object has 64 bit pointers but modutils
+ * is running 32 bit.  This is nasty code but it stops the compiler giving
+ * spurious warning messages.  "I know what I am doing" ...
+ */
+
+void *
+obj_addr_to_native_ptr (ElfW(Addr) addr)
+{
+	unsigned int convert = (sizeof(void *) << 8) + sizeof(addr);	/* to, from */
+	union obj_ptr_4 p4;
+	union obj_ptr_8 p8;
+	switch (convert) {
+	case 0x0404:
+		p4.addr = addr;
+		return(p4.ptr);
+		break;
+	case 0x0408:
+		p4.addr = addr;
+		if (p4.addr != addr) {
+			printk(KERN_INFO "obj_addr_to_native_ptr truncation %lx",
+				(unsigned long) addr);
+			return NULL;
+		}
+		return(p4.ptr);
+		break;
+	case 0x0804:
+		p8.addr = addr;
+		return(p8.ptr);
+		break;
+	case 0x0808:
+		p8.addr = addr;
+		return(p8.ptr);
+		break;
+	default:
+		printk(KERN_INFO "obj_addr_to_native_ptr unknown conversion 0x%04x", convert);
+		return NULL;
+	}
+}
+
+ElfW(Addr)
+obj_native_ptr_to_addr (void *ptr)
+{
+	unsigned int convert = (sizeof(ElfW(Addr)) << 8) + sizeof(ptr);	/* to, from */
+	union obj_ptr_4 p4;
+	union obj_ptr_8 p8;
+	switch (convert) {
+	case 0x0404:
+		p4.ptr = ptr;
+		return(p4.addr);
+		break;
+	case 0x0408:
+		p8.ptr = ptr;
+		p4.addr = p8.addr;
+		if (p4.addr != p8.addr) {
+			printk(KERN_INFO "obj_native_ptr_to_addr truncation %x",
+				p8.addr);
+			return 0;
+		}
+		return(p4.addr);
+		break;
+	case 0x0804:
+		p4.ptr = ptr;
+		return(p4.addr);	/* compiler expands to 8 */
+		break;
+	case 0x0808:
+		p8.ptr = ptr;
+		return(p8.addr);
+		break;
+	default:
+		printk(KERN_INFO "obj_native_ptr_to_addr unknown conversion 0x%04x", convert);
+		return 0;
+	}
+}
diff -Nurb linux.orig/kernel/obj_gpl_license.c linux/kernel/obj_gpl_license.c
--- linux.orig/kernel/obj_gpl_license.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/obj_gpl_license.c	Sat Dec  8 14:15:16 2001
@@ -0,0 +1,65 @@
+/* Return the type of license for a module.  0 for GPL, 1 for no license, 2 for
+   non-GPL.  The license parameter is set to the license string or NULL.
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+
+#include <linux/obj_load.h>
+
+/* This list must match *exactly* the list of allowable licenses in
+ * linux/include/linux/module.h.  Checking for leading "GPL" will not
+ * work, somebody will use "GPL sucks, this is proprietary".
+ */
+static const char *gpl_licenses[] = {
+	"GPL",
+	"GPL and additional rights",
+	"Dual BSD/GPL",
+	"Dual MPL/GPL",
+};
+
+int obj_gpl_license(struct obj_file *f, const char **license)
+{
+	struct obj_section *sec;
+	if ((sec = obj_find_section(f, ".modinfo"))) {
+		const char *value, *ptr, *endptr;
+		ptr = sec->contents;
+		endptr = ptr + sec->header.sh_size;
+		while (ptr < endptr) {
+			if ((value = strchr(ptr, '=')) && strncmp(ptr, "license", value-ptr) == 0) {
+				int i;
+				if (license)
+					*license = value+1;
+				for (i = 0; i < sizeof(gpl_licenses)/sizeof(gpl_licenses[0]); ++i) {
+					if (strcmp(value+1, gpl_licenses[i]) == 0)
+						return(0);
+				}
+				return(2);
+			}
+			if (strchr(ptr, '\0'))
+				ptr = strchr(ptr, '\0') + 1;
+			else
+				ptr = endptr;
+		}
+	}
+	return(1);
+}
diff -Nurb linux.orig/kernel/obj_load.c linux/kernel/obj_load.c
--- linux.orig/kernel/obj_load.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/obj_load.c	Wed Dec  5 23:24:53 2001
@@ -0,0 +1,366 @@
+/* Elf file reader.
+   Copyright 1996, 1997 Linux International.
+
+   Contributed by Richard Henderson <rth@tamu.edu>
+   obj_free() added by Björn Ekwall <bj0rn@blox.se> March 1999
+   Support for kallsyms Keith Owens <kaos@ocs.com.au> April 2000
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+#ident "$Id: obj_load.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
+
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+
+#include <linux/obj_load.h>
+//#include "util.h"
+
+/*======================================================================*/
+
+int memcpy_chk(void *src, unsigned int size, int index, void *dst, int dstsize)
+{
+	if((size-index) < dstsize)
+		return 0;
+	memcpy(dst, src + index, dstsize);
+	return dstsize;
+}
+
+struct obj_file *
+obj_load (void *modmem, unsigned int modsize, Elf32_Half e_type, const char *filename)
+{
+  struct obj_file *f;
+  ElfW(Shdr) *section_headers;
+  int shnum, i;
+  char *shstrtab;
+
+  /* Read the file header.  */
+
+  f = arch_new_file();
+  memset(f, 0, sizeof(*f));
+  f->symbol_cmp = strcmp;
+  f->symbol_hash = obj_elf_hash;
+  f->load_order_search_start = &f->load_order;
+
+  if (memcpy_chk(modmem, modsize, 0, &f->header, sizeof(f->header)) != sizeof(f->header))
+    {
+      printk(KERN_INFO "cannot read ELF header from %s\n", filename);
+      obj_free(f);
+      return NULL;
+    }
+
+  if (f->header.e_ident[EI_MAG0] != ELFMAG0
+      || f->header.e_ident[EI_MAG1] != ELFMAG1
+      || f->header.e_ident[EI_MAG2] != ELFMAG2
+      || f->header.e_ident[EI_MAG3] != ELFMAG3)
+    {
+      printk(KERN_INFO "%s is not an ELF file\n", filename);
+      obj_free(f);
+      return NULL;
+    }
+  if (f->header.e_ident[EI_CLASS] != ELF_CLASS
+      || f->header.e_ident[EI_DATA] != ELF_DATA
+      || f->header.e_ident[EI_VERSION] != EV_CURRENT
+      || f->header.e_machine != ELF_ARCH)
+    {
+      printk(KERN_INFO "ELF file %s not for this architecture\n", filename);
+      obj_free(f);
+      return NULL;
+    }
+  if (f->header.e_type != e_type && e_type != ET_NONE)
+    {
+      switch (e_type) {
+      case ET_REL:
+	printk(KERN_INFO "ELF file %s not a relocatable object\n", filename);
+	break;
+      case ET_EXEC:
+	printk(KERN_INFO "ELF file %s not an executable object\n", filename);
+	break;
+      default:
+	printk(KERN_INFO "ELF file %s has wrong type, expecting %d got %d\n",
+		filename, e_type, f->header.e_type);
+	break;
+      }
+      obj_free(f);
+      return NULL;
+    }
+
+  /* Read the section headers.  */
+
+  if (f->header.e_shentsize != sizeof(ElfW(Shdr)))
+    {
+      printk(KERN_INFO "section header size mismatch %s: %lu != %lu\n",
+	    filename,
+	    (unsigned long)f->header.e_shentsize,
+	    (unsigned long)sizeof(ElfW(Shdr)));
+      obj_free(f);
+      return NULL;
+    }
+
+  shnum = f->header.e_shnum;
+  f->sections = kmalloc(sizeof(struct obj_section *) * shnum, GFP_KERNEL);
+  memset(f->sections, 0, sizeof(struct obj_section *) * shnum);
+
+  section_headers = kmalloc(sizeof(ElfW(Shdr)) * shnum, GFP_KERNEL);
+  if (memcpy_chk(modmem, modsize, f->header.e_shoff, section_headers, sizeof(ElfW(Shdr))*shnum) != sizeof(ElfW(Shdr))*shnum)
+    {
+      printk(KERN_INFO "reading ELF section headers %s: %m\n", filename);
+      obj_free(f);
+      return NULL;
+    }
+
+  /* Read the section data.  */
+
+  for (i = 0; i < shnum; ++i)
+    {
+      struct obj_section *sec;
+
+      f->sections[i] = sec = arch_new_section();
+      memset(sec, 0, sizeof(*sec));
+
+      sec->header = section_headers[i];
+      sec->idx = i;
+
+      switch (sec->header.sh_type)
+	{
+	case SHT_NULL:
+	case SHT_NOTE:
+	case SHT_NOBITS:
+	  /* ignore */
+	  break;
+
+	case SHT_PROGBITS:
+	case SHT_SYMTAB:
+	case SHT_STRTAB:
+	case SHT_REL:
+	case SHT_RELA:
+	  if (sec->header.sh_size > 0)
+	    {
+	      sec->contents = kmalloc(sec->header.sh_size, GFP_KERNEL);
+	      if (memcpy_chk(modmem, modsize, sec->header.sh_offset, sec->contents, sec->header.sh_size) != sec->header.sh_size)
+		{
+		  printk(KERN_INFO "reading ELF section data %s: %m\n", filename);
+		  obj_free(f);
+		  return NULL;
+		}
+	    }
+	  else
+	    sec->contents = NULL;
+	  break;
+
+/*#if SHT_RELM == SHT_REL
+	case SHT_RELA:
+	  if (sec->header.sh_size) {
+	    printk(KERN_INFO "RELA relocations not supported on this architecture %s", filename);
+	    obj_free(f);
+	    return NULL;
+	  }
+	  break;
+#else
+	case SHT_REL:
+	  if (sec->header.sh_size) {
+	    printk(KERN_INFO "REL relocations not supported on this architecture %s", filename);
+	    obj_free(f);
+	    return NULL;
+	  }
+	  break;
+#endif*/
+
+	default:
+/*	  if (sec->header.sh_type >= SHT_LOPROC)
+	    {
+	      if (arch_load_proc_section(sec, fp) < 0)
+		return NULL;
+	      break;
+	    }*/
+
+	  printk(KERN_INFO "can't handle sections of type %ld %s %d\n",
+		(long)sec->header.sh_type, filename,i);
+	  obj_free(f);
+	  return NULL;
+	}
+    }
+
+  /* Do what sort of interpretation as needed by each section.  */
+
+  shstrtab = f->sections[f->header.e_shstrndx]->contents;
+
+  for (i = 0; i < shnum; ++i)
+    {
+      struct obj_section *sec = f->sections[i];
+      sec->name = shstrtab + sec->header.sh_name;
+    }
+
+  for (i = 0; i < shnum; ++i)
+    {
+      struct obj_section *sec = f->sections[i];
+
+      /* .modinfo and .modstring should be contents only but gcc has no
+       *  attribute for that.  The kernel may have marked these sections as
+       *  ALLOC, ignore the allocate bit.
+       */
+      if (strcmp(sec->name, ".modinfo") == 0 ||
+	  strcmp(sec->name, ".modstring") == 0)
+	sec->header.sh_flags &= ~SHF_ALLOC;
+
+      if (sec->header.sh_flags & SHF_ALLOC)
+	obj_insert_section_load_order(f, sec);
+
+      switch (sec->header.sh_type)
+	{
+	case SHT_SYMTAB:
+	  {
+	    unsigned long nsym, j;
+	    char *strtab;
+	    ElfW(Sym) *sym;
+
+	    if (sec->header.sh_entsize != sizeof(ElfW(Sym)))
+	      {
+		printk(KERN_INFO "symbol size mismatch %s: %lu != %lu\n",
+		      filename,
+		      (unsigned long)sec->header.sh_entsize,
+		      (unsigned long)sizeof(ElfW(Sym)));
+		obj_free(f);
+		return NULL;
+	      }
+
+	    nsym = sec->header.sh_size / sizeof(ElfW(Sym));
+	    strtab = f->sections[sec->header.sh_link]->contents;
+	    sym = (ElfW(Sym) *) sec->contents;
+
+	    /* Allocate space for a table of local symbols.  */
+	    j = f->local_symtab_size = sec->header.sh_info;
+	    f->local_symtab = kmalloc(j *= sizeof(struct obj_symbol *), GFP_KERNEL);
+	    memset(f->local_symtab, 0, j);
+
+	    /* Insert all symbols into the hash table.  */
+	    for (j = 1, ++sym; j < nsym; ++j, ++sym)
+	      {
+		const char *name;
+		if (sym->st_name)
+		  name = strtab+sym->st_name;
+		else
+		  name = f->sections[sym->st_shndx]->name;
+
+		obj_add_symbol(f, name, j, sym->st_info, sym->st_shndx,
+			       sym->st_value, sym->st_size);
+
+	      }
+	  }
+	break;
+	}
+    }
+
+  /* second pass to add relocation data to symbols */
+  for (i = 0; i < shnum; ++i)
+    {
+      struct obj_section *sec = f->sections[i];
+      switch (sec->header.sh_type)
+	{
+	case SHT_REL:
+	case SHT_RELA:
+	  {
+	    unsigned long nrel, j, nsyms;
+	    ElfW(Rel) *rel;
+	    struct obj_section *symtab;
+	    char *strtab;
+	    if (sec->header.sh_entsize != sizeof(ElfW(Rel)))
+	      {
+		printk(KERN_INFO "relocation entry size mismatch %s: %lu != %lu\n",
+		      filename,
+		      (unsigned long)sec->header.sh_entsize,
+		      (unsigned long)sizeof(ElfW(Rel)));
+		obj_free(f);
+		return NULL;
+	      }
+
+	    nrel = sec->header.sh_size / sizeof(ElfW(Rel));
+	    rel = (ElfW(Rel) *) sec->contents;
+	    symtab = f->sections[sec->header.sh_link];
+	    nsyms = symtab->header.sh_size / symtab->header.sh_entsize;
+	    strtab = f->sections[symtab->header.sh_link]->contents;
+
+	    /* Save the relocate type in each symbol entry.  */
+	    for (j = 0; j < nrel; ++j, ++rel)
+	      {
+		struct obj_symbol *intsym;
+		unsigned long symndx;
+		symndx = ELFW(R_SYM)(rel->r_info);
+		if (symndx)
+		  {
+		    if (symndx >= nsyms)
+		      {
+			printk(KERN_INFO "%s: Bad symbol index: %08lx >= %08lx\n",
+			      filename, symndx, nsyms);
+			continue;
+		      }
+
+		    obj_find_relsym(intsym, f, f, rel, (ElfW(Sym) *)(symtab->contents), strtab);
+		    intsym->r_type = ELFW(R_TYPE)(rel->r_info);
+		  }
+	      }
+	  }
+	  break;
+	}
+    }
+
+  f->filename = kmalloc(strlen(filename), GFP_KERNEL);
+  strcpy((char *)f->filename,filename);
+
+  return f;
+}
+
+void obj_free(struct obj_file *f)
+{
+	struct obj_section *sec;
+	struct obj_symbol *sym;
+	struct obj_symbol *next;
+	int i;
+	int n;
+
+	if (f->sections) {
+		n = f->header.e_shnum;
+		for (i = 0; i < n; ++i) {
+			if ((sec = f->sections[i]) != NULL) {
+				if (sec->contents)
+					kfree(sec->contents);
+				kfree(sec);
+			}
+		}
+		kfree(f->sections);
+	}
+
+	for (i = 0; i < HASH_BUCKETS; ++i) {
+		for (sym = f->symtab[i]; sym; sym = next) {
+			next = sym->next;
+			kfree(sym);
+		}
+	}
+
+	if (f->local_symtab)
+		kfree(f->local_symtab);
+
+	if (f->filename)
+		kfree((char *)(f->filename));
+
+	if (f->persist)
+		kfree((char *)(f->persist));
+
+	kfree(f);
+}
diff -Nurb linux.orig/kernel/obj_reloc.c linux/kernel/obj_reloc.c
--- linux.orig/kernel/obj_reloc.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/obj_reloc.c	Sat Dec  8 14:15:27 2001
@@ -0,0 +1,425 @@
+/* Elf relocation routines.
+   Copyright 1996, 1997 Linux International.
+
+   Contributed by Richard Henderson <rth@tamu.edu>
+
+   This file is part of the Linux modutils.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+
+   Modified by Christian König (ChristianK.@t-online.de) to work inside the kernel*/
+
+#ident "$Id: obj_reloc.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
+
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
+
+#include <linux/obj_load.h>
+
+/*======================================================================*/
+
+int
+obj_string_patch(struct obj_file *f, int secidx, ElfW(Addr) offset,
+		 const char *string)
+{
+  struct obj_string_patch_struct *p;
+  struct obj_section *strsec;
+  size_t len = strlen(string)+1;
+  char *loc;
+
+  p = kmalloc(sizeof(*p), GFP_KERNEL);
+  p->next = f->string_patches;
+  p->reloc_secidx = secidx;
+  p->reloc_offset = offset;
+  f->string_patches = p;
+
+  strsec = obj_find_section(f, ".kstrtab");
+  if (strsec == NULL)
+    {
+      strsec = obj_create_alloced_section(f, ".kstrtab", 1, len, 0);
+      p->string_offset = 0;
+      loc = strsec->contents;
+    }
+  else
+    {
+      p->string_offset = strsec->header.sh_size;
+      loc = obj_extend_section(strsec, len);
+    }
+  memcpy(loc, string, len);
+
+  return 1;
+}
+
+int
+obj_symbol_patch(struct obj_file *f, int secidx, ElfW(Addr) offset,
+		 struct obj_symbol *sym)
+{
+  struct obj_symbol_patch_struct *p;
+
+  p = kmalloc(sizeof(*p), GFP_KERNEL);
+  p->next = f->symbol_patches;
+  p->reloc_secidx = secidx;
+  p->reloc_offset = offset;
+  p->sym = sym;
+  f->symbol_patches = p;
+
+  return 1;
+}
+
+int
+obj_check_undefineds(struct obj_file *f, int quiet)
+{
+  unsigned long i;
+  int ret = 1;
+
+  for (i = 0; i < HASH_BUCKETS; ++i)
+    {
+      struct obj_symbol *sym;
+      for (sym = f->symtab[i]; sym ; sym = sym->next)
+	if (sym->secidx == SHN_UNDEF)
+	  {
+	    if (ELFW(ST_BIND)(sym->info) == STB_WEAK)
+	      {
+		sym->secidx = SHN_ABS;
+		sym->value = 0;
+	      }
+	    else if (sym->r_type) /* assumes R_arch_NONE is 0 on all arch */
+	      {
+		if (!quiet)
+			printk(KERN_INFO "unresolved symbol %s", sym->name);
+		ret = 0;
+	      }
+	  }
+    }
+
+  return ret;
+}
+
+void
+obj_clear_undefineds(struct obj_file *f)
+{
+  unsigned long i;
+  struct obj_symbol *sym;
+  for (i = 0; i < HASH_BUCKETS; ++i)
+    {
+      for (sym = f->symtab[i]; sym ; sym = sym->next)
+	if (sym->secidx == SHN_UNDEF)
+	  {
+	    sym->secidx = SHN_ABS;
+	    sym->value = 0;
+	  }
+    }
+}
+
+static void *realloc(void *ptr, unsigned int size, unsigned int oldsize)
+{
+	void *new;
+	new = kmalloc(size, GFP_KERNEL);
+	memcpy(new, ptr, oldsize);
+	kfree(ptr);
+	return new;
+}
+
+void
+obj_allocate_commons(struct obj_file *f)
+{
+  struct common_entry
+  {
+    struct common_entry *next;
+    struct obj_symbol *sym;
+  } *common_head = NULL;
+
+  unsigned long i;
+
+  for (i = 0; i < HASH_BUCKETS; ++i)
+    {
+      struct obj_symbol *sym;
+      for (sym = f->symtab[i]; sym ; sym = sym->next)
+	if (sym->secidx == SHN_COMMON)
+	  {
+	    /* Collect all COMMON symbols and sort them by size so as to
+	       minimize space wasted by alignment requirements.  */
+	    {
+	      struct common_entry **p, *n;
+	      for (p = &common_head; *p ; p = &(*p)->next)
+		if (sym->size <= (*p)->sym->size)
+		  break;
+
+	      n = alloca(sizeof(*n));
+	      n->next = *p;
+	      n->sym = sym;
+	      *p = n;
+	    }
+	  }
+    }
+
+  for (i = 1; i < f->local_symtab_size; ++i)
+    {
+      struct obj_symbol *sym = f->local_symtab[i];
+      if (sym && sym->secidx == SHN_COMMON)
+	{
+	  struct common_entry **p, *n;
+	  for (p = &common_head; *p ; p = &(*p)->next)
+	    if (sym == (*p)->sym)
+	      break;
+	    else if (sym->size < (*p)->sym->size)
+	      {
+		n = alloca(sizeof(*n));
+		n->next = *p;
+		n->sym = sym;
+		*p = n;
+		break;
+	      }
+	}
+    }
+
+  if (common_head)
+    {
+      /* Find the bss section.  */
+      for (i = 0; i < f->header.e_shnum; ++i)
+	if (f->sections[i]->header.sh_type == SHT_NOBITS)
+	  break;
+
+      /* If for some reason there hadn't been one, create one.  */
+      if (i == f->header.e_shnum)
+	{
+	  struct obj_section *sec;
+
+	  f->sections = realloc(f->sections, (i+1) * sizeof(sec), i * sizeof(sec));
+	  f->sections[i] = sec = arch_new_section();
+	  f->header.e_shnum = i+1;
+
+	  memset(sec, 0, sizeof(*sec));
+	  sec->header.sh_type = SHT_PROGBITS;
+	  sec->header.sh_flags = SHF_WRITE|SHF_ALLOC;
+	  sec->name = ".bss";
+	  sec->idx = i;
+	}
+
+      /* Allocate the COMMONS.  */
+      {
+	ElfW(Addr) bss_size = f->sections[i]->header.sh_size;
+	ElfW(Addr) max_align = f->sections[i]->header.sh_addralign;
+	struct common_entry *c;
+
+	for (c = common_head; c ; c = c->next)
+	  {
+	    ElfW(Addr) align = c->sym->value;
+
+	    if (align > max_align)
+	      max_align = align;
+	    if (bss_size & (align - 1))
+	      bss_size = (bss_size | (align - 1)) + 1;
+
+	    c->sym->secidx = i;
+	    c->sym->value = bss_size;
+
+	    bss_size += c->sym->size;
+	  }
+
+	f->sections[i]->header.sh_size = bss_size;
+	f->sections[i]->header.sh_addralign = max_align;
+      }
+    }
+
+  /* For the sake of patch relocation and parameter initialization,
+     allocate zeroed data for NOBITS sections now.  Note that after
+     this we cannot assume NOBITS are really empty.  */
+  for (i = 0; i < f->header.e_shnum; ++i)
+    {
+      struct obj_section *s = f->sections[i];
+      if (s->header.sh_type == SHT_NOBITS)
+	{
+	  if (s->header.sh_size)
+	    s->contents = memset(kmalloc(s->header.sh_size, GFP_KERNEL),
+				 0, s->header.sh_size);
+	  else
+	    s->contents = NULL;
+	  s->header.sh_type = SHT_PROGBITS;
+	}
+    }
+}
+
+unsigned long
+obj_load_size (struct obj_file *f)
+{
+  unsigned long dot = 0;
+  struct obj_section *sec;
+
+  /* Finalize the positions of the sections relative to one another.  */
+
+  for (sec = f->load_order; sec ; sec = sec->load_next)
+    {
+      ElfW(Addr) align;
+
+      align = sec->header.sh_addralign;
+      if (align && (dot & (align - 1)))
+	dot = (dot | (align - 1)) + 1;
+
+      sec->header.sh_addr = dot;
+      dot += sec->header.sh_size;
+    }
+
+  return dot;
+}
+
+int
+obj_relocate (struct obj_file *f, ElfW(Addr) base)
+{
+  int i, n = f->header.e_shnum;
+  int ret = 1;
+
+  /* Finalize the addresses of the sections.  */
+
+  arch_finalize_section_address(f, base);
+
+  /* And iterate over all of the relocations.  */
+
+  for (i = 0; i < n; ++i)
+    {
+      struct obj_section *relsec, *symsec, *targsec, *strsec;
+      ElfW(Rel) *rel, *relend;
+      ElfW(Sym) *symtab;
+      const char *strtab;
+      unsigned long nsyms;
+
+      relsec = f->sections[i];
+      if (relsec->header.sh_type != SHT_REL)
+	continue;
+
+      symsec = f->sections[relsec->header.sh_link];
+      targsec = f->sections[relsec->header.sh_info];
+      strsec = f->sections[symsec->header.sh_link];
+
+      if (!(targsec->header.sh_flags & SHF_ALLOC))
+	continue;
+
+      rel = (ElfW(Rel) *)relsec->contents;
+      relend = rel + (relsec->header.sh_size / sizeof(ElfW(Rel)));
+      symtab = (ElfW(Sym) *)symsec->contents;
+      nsyms = symsec->header.sh_size / symsec->header.sh_entsize;
+      strtab = (const char *)strsec->contents;
+
+      for (; rel < relend; ++rel)
+	{
+	  ElfW(Addr) value = 0;
+	  struct obj_symbol *intsym = NULL;
+	  unsigned long symndx;
+	  const char *errmsg;
+
+	  /* Attempt to find a value to use for this relocation.  */
+
+	  symndx = ELFW(R_SYM)(rel->r_info);
+	  if (symndx)
+	    {
+	      /* Note we've already checked for undefined symbols.  */
+
+	      if (symndx >= nsyms)
+		{
+		  printk(KERN_INFO "Bad symbol index: %08lx >= %08lx",
+			symndx, nsyms);
+		  continue;
+		}
+
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
+	      value = obj_symbol_final_value(f, intsym);
+	    }
+
+#if SHT_RELM == SHT_RELA
+	  value += rel->r_addend;
+#endif
+
+	  /* Do it! */
+	  switch (arch_apply_relocation(f,targsec,symsec,intsym,rel,value))
+	    {
+	    case obj_reloc_ok:
+	      break;
+
+	    case obj_reloc_overflow:
+	      errmsg = "Relocation overflow";
+	      goto bad_reloc;
+	    case obj_reloc_dangerous:
+	      errmsg = "Dangerous relocation";
+	      goto bad_reloc;
+	    case obj_reloc_unhandled:
+	      errmsg = "Unhandled relocation";
+	      goto bad_reloc;
+	    case obj_reloc_constant_gp:
+	      errmsg = "Modules compiled with -mconstant-gp cannot be loaded";
+	      goto bad_reloc;
+	    bad_reloc:
+	      printk(KERN_INFO "%s of type %ld for %s", errmsg,
+		    (long)ELFW(R_TYPE)(rel->r_info), intsym->name);
+	      ret = 0;
+	      break;
+	    }
+	}
+    }
+
+  /* Finally, take care of the patches.  */
+
+  if (f->string_patches)
+    {
+      struct obj_string_patch_struct *p;
+      struct obj_section *strsec;
+      ElfW(Addr) strsec_base;
+      strsec = obj_find_section(f, ".kstrtab");
+      strsec_base = strsec->header.sh_addr;
+
+      for (p = f->string_patches; p ; p = p->next)
+	{
+	  struct obj_section *targsec = f->sections[p->reloc_secidx];
+	  *(ElfW(Addr) *)(targsec->contents + p->reloc_offset)
+	    = strsec_base + p->string_offset;
+	}
+    }
+
+  if (f->symbol_patches)
+    {
+      struct obj_symbol_patch_struct *p;
+
+      for (p = f->symbol_patches; p; p = p->next)
+	{
+	  struct obj_section *targsec = f->sections[p->reloc_secidx];
+	  *(ElfW(Addr) *)(targsec->contents + p->reloc_offset)
+	    = obj_symbol_final_value(f, p->sym);
+	}
+    }
+
+  return ret;
+}
+
+int
+obj_create_image (struct obj_file *f, char *image)
+{
+  struct obj_section *sec;
+  ElfW(Addr) base = f->baseaddr;
+
+  for (sec = f->load_order; sec ; sec = sec->load_next)
+    {
+      char *secimg;
+
+      if (sec->contents == 0)
+	continue;
+
+      secimg = image + (sec->header.sh_addr - base);
+
+      /* Note that we allocated data for NOBITS sections earlier.  */
+      memcpy(secimg, sec->contents, sec->header.sh_size);
+    }
+
+  return 1;
+}

--------------Boundary-00=_ZU210N515T24YDTHHI6I--
