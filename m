Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWEQQUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEQQUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWEQQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:20:05 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:45306 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750806AbWEQQUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:20:03 -0400
Date: Thu, 18 May 2006 01:20:48 +0900 (JST)
Message-Id: <20060518.012048.107255562.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org, ralf@linux-mips.org
Subject: [PATCH 2/2] kbuild: fix modpost segfault for 64bit mipsel kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated r_info layout fix.  Please apply "check SHT_REL
sections" patch before this.


64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff -u linux/scripts/mod/modpost.c linux-mips/scripts/mod/modpost.c
--- linux/scripts/mod/modpost.c	2006-05-18 00:27:05.439421552 +0900
+++ linux-mips/scripts/mod/modpost.c	2006-05-18 01:01:43.584495480 +0900
@@ -700,6 +700,7 @@
 		const char *name = secstrings + sechdrs[i].sh_name;
 		const char *secname;
 		Elf_Rela r;
+		unsigned int r_sym;
 		/* We want to process only relocation sections and not .init */
 		if (sechdrs[i].sh_type == SHT_RELA) {
 			Elf_Rela *rela;
@@ -711,9 +712,20 @@
 
 			for (rela = start; rela < stop; rela++) {
 				r.r_offset = TO_NATIVE(rela->r_offset);
-				r.r_info   = TO_NATIVE(rela->r_info);
+#if KERNEL_ELFCLASS == ELFCLASS64
+				if (hdr->e_machine == EM_MIPS) {
+					r_sym = ELF64_MIPS_R_SYM(rela->r_info);
+					r_sym = TO_NATIVE(r_sym);
+				} else {
+					r.r_info = TO_NATIVE(rela->r_info);
+					r_sym = ELF_R_SYM(r.r_info);
+				}
+#else
+				r.r_info = TO_NATIVE(rela->r_info);
+				r_sym = ELF_R_SYM(r.r_info);
+#endif
 				r.r_addend = TO_NATIVE(rela->r_addend);
-				sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+				sym = elf->symtab_start + r_sym;
 				/* Skip special sections */
 				if (sym->st_shndx >= SHN_LORESERVE)
 					continue;
@@ -734,9 +746,20 @@
 
 			for (rel = start; rel < stop; rel++) {
 				r.r_offset = TO_NATIVE(rel->r_offset);
-				r.r_info   = TO_NATIVE(rel->r_info);
+#if KERNEL_ELFCLASS == ELFCLASS64
+				if (hdr->e_machine == EM_MIPS) {
+					r_sym = ELF64_MIPS_R_SYM(rel->r_info);
+					r_sym = TO_NATIVE(r_sym);
+				} else {
+					r.r_info = TO_NATIVE(rel->r_info);
+					r_sym = ELF_R_SYM(r.r_info);
+				}
+#else
+				r.r_info = TO_NATIVE(rel->r_info);
+				r_sym = ELF_R_SYM(r.r_info);
+#endif
 				r.r_addend = 0;
-				sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+				sym = elf->symtab_start + r_sym;
 				/* Skip special sections */
 				if (sym->st_shndx >= SHN_LORESERVE)
 					continue;
diff -u linux/scripts/mod/modpost.h linux-mips/scripts/mod/modpost.h
--- linux/scripts/mod/modpost.h	2006-05-18 00:18:14.222178848 +0900
+++ linux-mips/scripts/mod/modpost.h	2006-05-17 23:47:21.581822992 +0900
@@ -41,6 +41,25 @@
 #define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
+/* The 64-bit MIPS ELF ABI uses an unusual reloc format. */
+typedef struct
+{
+  Elf32_Word    r_sym;		/* Symbol index */
+  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
+  unsigned char r_type3;	/* 3rd relocation type */
+  unsigned char r_type2;	/* 2nd relocation type */
+  unsigned char r_type1;	/* 1st relocation type */
+} _Elf64_Mips_R_Info;
+
+typedef union
+{
+  Elf64_Xword	r_info_number;
+  _Elf64_Mips_R_Info r_info_fields;
+} _Elf64_Mips_R_Info_union;
+
+#define ELF64_MIPS_R_SYM(i) \
+  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
+
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
