Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSLSUt3>; Thu, 19 Dec 2002 15:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSLSUt2>; Thu, 19 Dec 2002 15:49:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:8923 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266115AbSLSUtZ>; Thu, 19 Dec 2002 15:49:25 -0500
Message-ID: <3E0241C3.4060206@hannes-reinecke.de>
Date: Thu, 19 Dec 2002 23:01:39 +0100
From: Hannes Reinecke <mail@hannes-reinecke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.52: compilation fixes for alpha
Content-Type: multipart/mixed;
 boundary="------------070504060104020905060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070504060104020905060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

attached are some compilation fixes needed to get the alpha port up and 
running. Note: These fixes are on top of patch-2.5.52-bk3 in the 
2.5/testing directory, which contain some neccessary fixes regarding 
exception handling.

Note that this is gross hackery. I'm reasonably sure that the patch to 
vmlinux.lds is correct (+/- alignment); the modules stuff is just copied 
straight from Rusty Russels patch (THX !).

Anyway: It works for me (tm), which is more than I could have said from 
the previous 51 kernels of the 2.5 series.
I would be _very_ glad if someone in the know (rth ? davem ? Ivan K.?) 
could have a look at it, make the appropriate corrections and forward it 
in the appropriate channels, just to make sure the next kernels will 
actually _run_ on an alpha.

Cheers,

Hannes
P.S.: Please CC to me directly, I'm not on this list.

--------------070504060104020905060909
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

--------------070504060104020905060909--

