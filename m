Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSLTNds>; Fri, 20 Dec 2002 08:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSLTNds>; Fri, 20 Dec 2002 08:33:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:4339 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261978AbSLTNdo>; Fri, 20 Dec 2002 08:33:44 -0500
Message-ID: <3E032D25.6050900@hannes-reinecke.de>
Date: Fri, 20 Dec 2002 15:45:57 +0100
From: Hannes Reinecke <mail@hannes-reinecke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.52: compilation fixes for alpha
References: <Pine.LNX.4.44.0212200839320.11457-100000@gfrw1044.bocc.de>
In-Reply-To: <Pine.LNX.4.44.0212200839320.11457-100000@gfrw1044.bocc.de>
Content-Type: multipart/mixed;
 boundary="------------060409030402030203000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409030402030203000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jochen Friedrich wrote:
> Hi Hannes,
> 
> 
>>attached are some compilation fixes needed to get the alpha port up and
>>running. Note: These fixes are on top of patch-2.5.52-bk3 in the
>>2.5/testing directory, which contain some neccessary fixes regarding
>>exception handling.
> 
> 
> Is there an additional patch missing?
> 
> arch/alpha/mm/extable.c: In function `search_exception_table':
> arch/alpha/mm/extable.c:48: `module_list' undeclared (first use in this
> function)
> 
Shit. I forgot that one (I knew there was something missing).
Try the attached patch instead; it's identical to the previous one, I 
just appended the patch for arch/alpha/mm/extable.c

Let me know whether it works.

Note: Module loading is still likely to be buggered, since it 
appearantly relies on newer modutils (I'm a bit out of touch with 
current events). But at least it compiles and runs, even with modules 
enabled. I see what I can dig out re. modules.

> This is -bk3 from v2.5/snapshots +your patch (-bk4 +your patch fails to
> compile with the same message).
>
Small wonder. Alpha fixes always tend to be a bit uncared-for.

> It looks like i386 replaced the loop through module_list by a walk through
> extables which is not yet in alpha code.
> 
Indeed. Alternatively you can copy the code from i386, which is quite 
generic (and that's what I did anyway).

> Thanks,
Nae bother.

Cheers,

Hannes

--------------060409030402030203000604
Content-Type: text/plain;
 name="bk3-alpha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk3-alpha.patch"

--- arch/alpha/kernel/Makefile.orig	Thu Dec 19 17:44:23 2002
+++ arch/alpha/kernel/Makefile	Thu Dec 19 17:44:30 2002
@@ -26,6 +26,7 @@
 obj-$(CONFIG_SMP)    += smp.o
 obj-$(CONFIG_PCI)    += pci.o pci_iommu.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
+obj-$(CONFIG_MODULES)	+= module.o
 
 ifdef CONFIG_ALPHA_GENERIC
 
--- arch/alpha/vmlinux.lds.S.orig	Thu Dec 19 17:55:58 2002
+++ arch/alpha/vmlinux.lds.S	Thu Dec 19 17:57:35 2002
@@ -55,6 +55,12 @@
 	__setup_end = .;
   }
 
+  __param ALIGN(16): {
+	__start___param = .;
+	*(__param); 
+	__stop___param = .;
+  }
+
   .initcall.init ALIGN(8): {
 	__initcall_start = .;
 	*(.initcall1.init) 
--- include/asm-alpha/module.h.orig	Thu Dec 19 13:26:01 2002
+++ include/asm-alpha/module.h	Thu Dec 19 13:34:11 2002
@@ -1,6 +1,11 @@
 #ifndef _ASM_ALPHA_MODULE_H
 #define _ASM_ALPHA_MODULE_H
 
-/* Module rewrite still in progress.  */
+struct mod_arch_specific
+{
+};
 
+#define Elf_Shdr Elf64_Shdr
+#define Elf_Sym Elf64_Sym
+#define Elf_Ehdr Elf64_Ehdr
 #endif /* _ASM_ALPHA_MODULE_H */
--- /dev/null	Tue Oct 22 14:39:45 2002
+++ arch/alpha/kernel/module.c	Thu Dec 19 17:48:41 2002
@@ -0,0 +1,135 @@
+/* Kernel module help for Alpha.
+   Copyright (C) 2002  Richard Henderson.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation, Inc.,
+   59 Temple Place, Suite 330, Boston, MA  02111-1307  USA  */
+
+#include <linux/moduleloader.h>
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
+       if (size == 0)
+               return NULL;
+       return vmalloc(size);
+}
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+        vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+/* We don't need anything special. */
+long module_core_size(const Elf64_Ehdr *hdr,
+		      const Elf64_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	return module->core_size;
+}
+
+long module_init_size(const Elf64_Ehdr *hdr,
+		      const Elf64_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
+{
+	return module->init_size;
+}
+
+int apply_relocate(Elf64_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+       return -ENOEXEC;
+}
+
+int apply_relocate_add(Elf64_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *me)
+{
+	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_offset;
+	Elf64_Sym *sym;
+	char *location;
+	unsigned long i;
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
+                unsigned long r_type = ELF64_R_TYPE(rela[i].r_info);
+                unsigned long value = 0;
+
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			+ rela[i].r_offset;
+
+                if (r_type == R_ALPHA_RELATIVE) {
+                        /* Binutils before 2.12 or so are borken.  We should
+                           have the RELATIVE offset as the addend of the 
+                           relocation.  If it's not present, fall back to the
+                           value at the relocation address.  */
+                        u64 addend = rela[i].r_addend;
+                        if (addend == 0)
+                                addend = *(u64 *)location;
+
+                        *(u64 *)location = (u64)me->module_core + addend;
+                        continue;
+                }
+
+                /* This is the symbol it is referring to.  */
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_offset
+		    + ELF64_R_SYM(rela[i].r_info);
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+                value += rela[i].r_addend;
+
+                switch (r_type) {
+                case R_ALPHA_GLOB_DAT:
+                case R_ALPHA_JMP_SLOT:
+                case R_ALPHA_REFQUAD:
+                        *(u64 *)location = value;
+                        break;
+                default:
+                        printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
+                               me->name, r_type);
+                        return -ENOEXEC;
+                }
+        }
+
+        return 0;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+       return 0;
+}
--- arch/alpha/mm/extable.c.orig	Thu Dec 19 13:23:51 2002
+++ arch/alpha/mm/extable.c	Thu Dec 19 13:30:34 2002
@@ -33,23 +33,24 @@
 unsigned
 search_exception_table(unsigned long addr)
 {
-	unsigned ret;
+	unsigned ret = 0;
 
 #ifndef CONFIG_MODULES
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 #else
 	extern spinlock_t modlist_lock;
 	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
-	struct module *mp;
+	struct list_head *i;
 
-	ret = 0;
+	/* The kernel is the last "module" -- no need to treat it special.  */
 	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
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

--------------060409030402030203000604--

