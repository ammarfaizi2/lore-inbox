Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbSKSWtp>; Tue, 19 Nov 2002 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSKSWto>; Tue, 19 Nov 2002 17:49:44 -0500
Received: from dp.samba.org ([66.70.73.150]:65463 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267546AbSKSWth>;
	Tue, 19 Nov 2002 17:49:37 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15834.49563.24632.413897@argo.ozlabs.ibm.com>
Date: Wed, 20 Nov 2002 09:56:27 +1100
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: ARM kernel module loader.
In-Reply-To: <20021119203128.E5535@flint.arm.linux.org.uk>
References: <20021119203128.E5535@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Ok, here's the problem I'm currently facing.
> 
> KAO's insmod used to do various fixups (trampolines of 8 bytes in length)
> before inserting modules into the kernel on ARM to make sure the PC24
> branch relocations were able to reach the kernel binary image in memory.
> PC24 relocations have a maximum range of +/- 32MB, and the kernel may be
> (on current architectures) up to 256MB to 512MB away.

Sounds exactly the same as the situation we face on ppc and ppc64.

> With Rusty's in-kernel module linker, there's a catch-22 situation here.
> The module linker has callouts to architecture code to ask for the size
> of various sections before allocating an area.
> 
> This is perfect in this situation, since all you need to do is calculate
> how many trampolines you'd need to reach the main kernel binary, and add
> that onto the core module size.
> 
> However, to know how many trampolines you'd need, you need to scan the
> relocations and symbols, counting the number of symbols that need
> trampolines.  The problem here is that we haven't read any of the module
> into kernel space, so this information isn't available.

The last statement is incorrect: look in load_module() in
kernel/module.c.  We read in the entire ELF file (i.e. copy it from
userspace) at line 828 and call module_init_size and module_core_size
further on (lines 946 and 951).

Have you looked at Rusty's patch to implement in-kernel module linking
on PPC?  It's on his web page on kernel.org.  Unfortunately it appears
to be for an older version of his modules code.  I have updated it and
I'll be pushing it to Linus shortly.  The updated patch is below.

> Ideally, I'd like to be able to allocate a trampoline table for one
> module and re-use trampoline entries for many modules to minimise the
> cache impacts.

Hmmm, interesting idea. :)  It would only work if the modules landed
close enough to each other in the kernel virtual space, of course.
One idea that I have been considering is to steal a bit of the user
address space immediately below KERNELBASE, say 16MB or so, and use
that area for modules.  That would mean we wouldn't need trampolines
at all.

Regards,
Paul.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.907   -> 1.908  
#	include/asm-ppc/module.h	1.4     -> 1.5    
#	arch/ppc/kernel/Makefile	1.28    -> 1.29   
#	arch/ppc/kernel/misc.S	1.31    -> 1.32   
#	arch/ppc/mm/extable.c	1.3     -> 1.4    
#	               (new)	        -> 1.1     arch/ppc/kernel/module.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/20	rusty@rustcorp.com.au	1.908
# PPC32: In-kernel module linker for PPC.
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Wed Nov 20 09:52:38 2002
+++ b/arch/ppc/kernel/Makefile	Wed Nov 20 09:52:38 2002
@@ -25,7 +25,7 @@
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o ppc6xx_idle.o
 obj-$(CONFIG_ALL_PPC)		+= ppc6xx_idle.o
-obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
+obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_PCI)		+= pci.o 
 ifneq ($(CONFIG_PPC_ISERIES),y)
 obj-$(CONFIG_PCI)		+= pci-dma.o
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	Wed Nov 20 09:52:38 2002
+++ b/arch/ppc/kernel/misc.S	Wed Nov 20 09:52:38 2002
@@ -1182,10 +1182,10 @@
 	.long sys_adjtimex
 	.long sys_mprotect	/* 125 */
 	.long sys_sigprocmask
-	.long sys_create_module
+	.long sys_ni_syscall	/* old sys_create_module */
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* old sys_get_kernel_syms */	/* 130 */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
@@ -1221,7 +1221,7 @@
 	.long sys_mremap
 	.long sys_setresuid
 	.long sys_getresuid	/* 165 */
-	.long sys_query_module
+	.long sys_ni_syscall		/* old sys_query_module */
 	.long sys_poll
 	.long sys_nfsservctl
 	.long sys_setresgid
diff -Nru a/arch/ppc/kernel/module.c b/arch/ppc/kernel/module.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/module.c	Wed Nov 20 09:52:38 2002
@@ -0,0 +1,260 @@
+/*  Kernel module help for PPC.
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
+/* Count how many different relocations (different symbol, different
+   addend) */
+static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
+{
+	unsigned int i, j, ret = 0;
+
+	/* Sure, this is order(n^2), but it's usually short, and not
+           time critical */
+	for (i = 0; i < num; i++) {
+		for (j = 0; j < i; j++) {
+			/* If this addend appeared before, it's
+                           already been counted */
+			if (ELF32_R_SYM(rela[i].r_info)
+			    == ELF32_R_SYM(rela[j].r_info)
+			    && rela[i].r_addend == rela[j].r_addend)
+				break;
+		}
+		if (j == i) ret++;
+	}
+	return ret;
+}
+
+/* Get the potential trampolines size required of the init and
+   non-init sections */
+static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
+				  const Elf32_Shdr *sechdrs,
+				  const char *secstrings,
+				  int is_init)
+{
+	unsigned long ret = 0;
+	unsigned i;
+
+	/* Everything marked ALLOC (this includes the exported
+           symbols) */
+	for (i = 1; i < hdr->e_shnum; i++) {
+		/* If it's called *.init*, and we're not init, we're
+                   not interested */
+		if ((strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
+		    != is_init)
+			continue;
+
+		if (sechdrs[i].sh_type == SHT_RELA) {
+			DEBUGP("Found relocations in section %u\n", i);
+			DEBUGP("Ptr: %p.  Number: %u\n",
+			       (void *)hdr + sechdrs[i].sh_offset,
+			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
+			ret += count_relocs((void *)hdr
+					     + sechdrs[i].sh_offset,
+					     sechdrs[i].sh_size
+					     / sizeof(Elf32_Rela))
+				* sizeof(struct ppc_plt_entry);
+		}
+	}
+
+	return ret;
+}
+
+long module_core_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	module->arch.core_plt_offset = module->core_size;
+	return module->core_size + get_plt_size(hdr, sechdrs, secstrings, 0);
+}
+
+long module_init_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	module->arch.init_plt_offset = module->init_size;
+	return module->init_size + get_plt_size(hdr, sechdrs, secstrings, 1);
+}
+
+int apply_relocate(Elf32_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *module)
+{
+	printk(KERN_ERR "%s: Non-ADD RELOCATION unsupported\n",
+	       module->name);
+	return -ENOEXEC;
+}
+
+static inline int entry_matches(struct ppc_plt_entry *entry, Elf32_Addr val)
+{
+	if (entry->jump[0] == 0x3d600000 + ((val + 0x8000) >> 16)
+	    && entry->jump[1] == 0x396b0000 + (val & 0xffff))
+		return 1;
+	return 0;
+}
+
+/* Set up a trampoline in the PLT to bounce us to the distant function */
+static uint32_t do_plt_call(void *location, Elf32_Addr val, struct module *mod)
+{
+	struct ppc_plt_entry *entry;
+
+	DEBUGP("Doing plt for %u\n", (unsigned int)location);
+	/* Init, or core PLT? */
+	if (location >= mod->module_core
+	    && location < mod->module_core + mod->arch.core_plt_offset)
+		entry = mod->module_core + mod->arch.core_plt_offset;
+	else
+		entry = mod->module_init + mod->arch.init_plt_offset;
+
+	/* Find this entry, or if that fails, the next avail. entry */
+	while (entry->jump[0]) {
+		if (entry_matches(entry, val)) return (uint32_t)entry;
+		entry++;
+	}
+
+	/* Stolen from Paul Mackerras as well... */
+	entry->jump[0] = 0x3d600000+((val+0x8000)>>16);	/* lis r11,sym@ha */
+	entry->jump[1] = 0x396b0000 + (val&0xffff);	/* addi r11,r11,sym@l*/
+	entry->jump[2] = 0x7d6903a6;			/* mtctr r11 */
+	entry->jump[3] = 0x4e800420;			/* bctr */
+
+	return (uint32_t)entry;
+}
+
+int apply_relocate_add(Elf32_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *module)
+{
+	unsigned int i;
+	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Sym *sym;
+	uint32_t *location;
+	uint32_t value;
+
+	DEBUGP("Applying ADD relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			+ rela[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+			+ ELF32_R_SYM(rela[i].r_info);
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       module->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+		/* `Everything is relative'. */
+		value = sym->st_value + rela[i].r_addend;
+
+		switch (ELF32_R_TYPE(rela[i].r_info)) {
+		case R_PPC_ADDR32:
+			/* Simply set it */
+			*(uint32_t *)location = value;
+			break;
+
+		case R_PPC_ADDR16_LO:
+			/* Low half of the symbol */
+			*(uint16_t *)location = value;
+			break;
+			
+		case R_PPC_ADDR16_HA:
+			/* Sign-adjusted lower 16 bits: PPC ELF ABI says:
+			   (((x >> 16) + ((x & 0x8000) ? 1 : 0))) & 0xFFFF.
+			   This is the same, only sane.
+			 */
+			*(uint16_t *)location = (value + 0x8000) >> 16;
+			break;
+
+		case R_PPC_REL24:
+			if ((int)(value - (uint32_t)location) < -0x02000000
+			    || (int)(value - (uint32_t)location) >= 0x02000000)
+				value = do_plt_call(location, value, module);
+
+			/* Only replace bits 2 through 26 */
+			DEBUGP("REL24 value = %08X. location = %08X\n",
+			       value, (uint32_t)location);
+			DEBUGP("Location before: %08X.\n",
+			       *(uint32_t *)location);
+			*(uint32_t *)location 
+				= (*(uint32_t *)location & ~0x03fffffc)
+				| ((value - (uint32_t)location)
+				   & 0x03fffffc);
+			DEBUGP("Location after: %08X.\n",
+			       *(uint32_t *)location);
+			DEBUGP("ie. jump to %08X+%08X = %08X\n",
+			       *(uint32_t *)location & 0x03fffffc,
+			       (uint32_t)location,
+			       (*(uint32_t *)location & 0x03fffffc)
+			       + (uint32_t)location);
+			break;
+
+		case R_PPC_REL32:
+			/* 32-bit relative jump. */
+			*(uint32_t *)location = value - (uint32_t)location;
+			break;
+
+		default:
+			printk("%s: unknown ADD relocation: %u\n",
+			       module->name,
+			       ELF32_R_TYPE(rela[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
+
+/* FIXME: Sort exception table --RR */
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	return 0;
+}
diff -Nru a/arch/ppc/mm/extable.c b/arch/ppc/mm/extable.c
--- a/arch/ppc/mm/extable.c	Wed Nov 20 09:52:38 2002
+++ b/arch/ppc/mm/extable.c	Wed Nov 20 09:52:38 2002
@@ -70,24 +70,29 @@
 unsigned long
 search_exception_table(unsigned long addr)
 {
-	unsigned long ret;
+	unsigned long ret = 0;
 
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	if (ret) return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL)
+	unsigned long flags;
+	struct list_head *i;
+
+	/* The kernel is the last "module" -- no need to treat it special. */
+	spin_lock_irqsave(&modlist_lock, flags);
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
-			return ret;
+			break;
 	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
 #endif
 
-	return 0;
+	return ret;
 }
diff -Nru a/include/asm-ppc/module.h b/include/asm-ppc/module.h
--- a/include/asm-ppc/module.h	Wed Nov 20 09:52:38 2002
+++ b/include/asm-ppc/module.h	Wed Nov 20 09:52:38 2002
@@ -1,12 +1,33 @@
 #ifndef _ASM_PPC_MODULE_H
 #define _ASM_PPC_MODULE_H
-/*
- * This file contains the PPC architecture specific module code.
- */
-
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
+/* Module stuff for PPC.  (C) 2001 Rusty Russell */
+
+/* Thanks to Paul M for explaining this.
+
+   PPC can only do rel jumps += 32MB, and often the kernel and other
+   modules are furthur away than this.  So, we jump to a table of
+   trampolines attached to the module (the Procedure Linkage Table)
+   whenever that happens.
+*/
+
+struct ppc_plt_entry
+{
+	/* 16 byte jump instruction sequence (4 instructions) */
+	unsigned int jump[4];
+};
+
+struct mod_arch_specific
+{
+	/* How much of the core is actually taken up with core (then
+           we know the rest is for the PLT */
+	unsigned int core_plt_offset;
+
+	/* Same for init */
+	unsigned int init_plt_offset;
+};
+
+#define Elf_Shdr Elf32_Shdr
+#define Elf_Sym Elf32_Sym
+#define Elf_Ehdr Elf32_Ehdr
 
 #endif /* _ASM_PPC_MODULE_H */
