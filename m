Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUBTNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUBTMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:51:35 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:15708 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261195AbUBTMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:35 -0500
Date: Fri, 20 Feb 2004 13:48:20 +0100
Message-Id: <200402201248.i1KCmKqP004287@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 408] M68k module loader
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing relocation support to module loader (from Matthias Urlichs)

--- linux-2.6.3/arch/m68k/kernel/module.c	2003-07-29 18:18:35.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/module.c	2003-11-25 13:01:33.000000000 +0100
@@ -82,9 +82,38 @@
 		       unsigned int relsec,
 		       struct module *me)
 {
-	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
-	       me->name);
-	return -ENOEXEC;
+	unsigned int i;
+	Elf32_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	Elf32_Sym *sym;
+	uint32_t *location;
+
+	DEBUGP("Applying relocate_add section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
+			+ ELF32_R_SYM(rel[i].r_info);
+
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_68K_32:
+			/* We add the value into the location given */
+			*location = rel[i].r_addend + sym->st_value;
+			break;
+		case R_68K_PC32:
+			/* Add the value, subtract its postition */
+			*location = rel[i].r_addend + sym->st_value - (uint32_t)location;
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+			       me->name, ELF32_R_TYPE(rel[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
 }
 
 int module_finalize(const Elf_Ehdr *hdr,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
