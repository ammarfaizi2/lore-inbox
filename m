Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTAIJjb>; Thu, 9 Jan 2003 04:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAIJiW>; Thu, 9 Jan 2003 04:38:22 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:25302 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262418AbTAIJiI>; Thu, 9 Jan 2003 04:38:08 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Update v850 module support for 2.5.55
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094642.9FB83374C@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:46:42 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.55-moo.orig/include/asm-v850/module.h linux-2.5.55-moo/include/asm-v850/module.h
--- linux-2.5.55-moo.orig/include/asm-v850/module.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.5.55-moo/include/asm-v850/module.h	2003-01-09 15:31:06.000000000 +0900
@@ -1,9 +1,9 @@
 /*
  * include/asm-v850/module.h -- Architecture-specific module hooks
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
- *  Copyright (C) 2001  Rusty Russell
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,03  Rusty Russell
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -27,16 +27,28 @@
 
 struct mod_arch_specific
 {
-	/* How much of the core is actually taken up with core (then
-           we know the rest is for the PLT).  */
-	unsigned int core_plt_offset;
-
-	/* Same for init.  */
-	unsigned int init_plt_offset;
+	/* Indices of PLT sections within module. */
+	unsigned int core_plt_section, init_plt_section;
 };
 
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
 
+/* Make empty sections for module_frob_arch_sections to expand. */
+#ifdef MODULE
+asm(".section .plt,\"ax\",@nobits; .align 3; .previous");
+asm(".section .init.plt,\"ax\",@nobits; .align 3; .previous");
+#endif
+
+/* We don't do exception tables.  */
+struct exception_table_entry;
+static inline const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
+{
+	return 0;
+}
+
 #endif /* __V850_MODULE_H__ */
diff -ruN -X../cludes linux-2.5.55-moo.orig/arch/v850/kernel/module.c linux-2.5.55-moo/arch/v850/kernel/module.c
--- linux-2.5.55-moo.orig/arch/v850/kernel/module.c	2003-01-06 10:50:58.000000000 +0900
+++ linux-2.5.55-moo/arch/v850/kernel/module.c	2003-01-09 14:42:47.000000000 +0900
@@ -1,9 +1,9 @@
 /*
  * arch/v850/kernel/module.c -- Architecture-specific module functions
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
- *  Copyright (C) 2001  Rusty Russell
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,03  Rusty Russell
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -100,18 +100,31 @@
 	return ret;
 }
 
-long module_core_size (const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
-		       const char *secstrings, struct module *mod)
+int module_frob_arch_sections(Elf32_Ehdr *hdr,
+			      Elf32_Shdr *sechdrs,
+			      char *secstrings,
+			      struct module *me)
 {
-	mod->arch.core_plt_offset = (mod->core_size + 3) & ~3;
-	return mod->core_size + get_plt_size (hdr, sechdrs, secstrings, 1);
-}
+	unsigned int i;
 
-long module_init_size (const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
-		       const char *secstrings, struct module *mod)
-{
-	mod->arch.init_plt_offset = (mod->init_size + 3) & ~3;
-	return mod->init_size + get_plt_size (hdr, sechdrs, secstrings, 1);
+	/* Find .plt and .pltinit sections */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings + sechdrs[i].sh_name, ".init.plt") == 0)
+			me->arch.init_plt_section = i;
+		else if (strcmp(secstrings + sechdrs[i].sh_name, ".plt") == 0)
+			me->arch.core_plt_section = i;
+	}
+	if (!me->arch.core_plt_section || !me->arch.init_plt_section) {
+		printk("Module doesn't contain .plt or .plt.init sections.\n");
+		return -ENOEXEC;
+	}
+
+	/* Override their sizes */
+	sechdrs[me->arch.core_plt_section].sh_size
+		= get_plt_size(hdr, sechdrs, secstrings, 0);
+	sechdrs[me->arch.init_plt_section].sh_size
+		= get_plt_size(hdr, sechdrs, secstrings, 1);
+	return 0;
 }
 
 int apply_relocate (Elf32_Shdr *sechdrs, const char *strtab,
@@ -123,7 +136,8 @@
 }
 
 /* Set up a trampoline in the PLT to bounce us to the distant function */
-static uint32_t do_plt_call(void *location, Elf32_Addr val, struct module *mod)
+static uint32_t do_plt_call (void *location, Elf32_Addr val,
+			     Elf32_Shdr *sechdrs, struct module *mod)
 {
 	struct v850_plt_entry *entry;
 	/* Instructions used to do the indirect jump.  */
@@ -137,10 +151,10 @@
 
 	/* Init, or core PLT? */
 	if (location >= mod->module_core
-	    && location < mod->module_core + mod->arch.core_plt_offset)
-		entry = mod->module_core + mod->arch.core_plt_offset;
+	    && location < mod->module_core + mod->core_size)
+		entry = (void *)sechdrs[mod->arch.core_plt_section].sh_addr;
 	else
-		entry = mod->module_init + mod->arch.init_plt_offset;
+		entry = (void *)sechdrs[mod->arch.init_plt_section].sh_addr;
 
 	/* Find this entry, or if that fails, the next avail. entry */
 	while (entry->tramp[0])
@@ -199,7 +213,7 @@
 			/* Maybe jump indirectly via a PLT table entry.  */
 			if ((int32_t)(val - (uint32_t)loc) > 0x1fffff
 			    || (int32_t)(val - (uint32_t)loc) < -0x200000)
-				val = do_plt_call (loc, val, mod);
+				val = do_plt_call (loc, val, sechdrs, mod);
 
 			val -= (uint32_t)loc;
 
