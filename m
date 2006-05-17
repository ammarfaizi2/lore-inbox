Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWEQQTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWEQQTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWEQQTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:19:01 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:42732 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750801AbWEQQTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:19:00 -0400
Date: Thu, 18 May 2006 01:19:44 +0900 (JST)
Message-Id: <20060518.011944.127197703.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org, ralf@linux-mips.org
Subject: [PATCH 1/2] kbuild: check SHT_REL sections
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that modpost can not detect section mismatch on mips and i386.
On mips64, the modpost (with r_info layout fix) can detect it.  The
current modpst only checks SHT_RELA section but I suppose SHT_REL
section should be checked also.  This patch does not contain r_info
layout fix.  I'll post an updated r_info layout fix on next mail.


Check SHT_REL sections as like as SHT_RELA sections to detect section
mismatch.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6d04504..1aa52a8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -697,29 +697,56 @@ static void check_sec_ref(struct module 
 
 	/* Walk through all sections */
 	for (i = 0; i < hdr->e_shnum; i++) {
-		Elf_Rela *rela;
-		Elf_Rela *start = (void *)hdr + sechdrs[i].sh_offset;
-		Elf_Rela *stop  = (void*)start + sechdrs[i].sh_size;
-		const char *name = secstrings + sechdrs[i].sh_name +
-						strlen(".rela");
+		const char *name = secstrings + sechdrs[i].sh_name;
+		const char *secname;
+		Elf_Rela r;
 		/* We want to process only relocation sections and not .init */
-		if (section_ref_ok(name) || (sechdrs[i].sh_type != SHT_RELA))
-			continue;
+		if (sechdrs[i].sh_type == SHT_RELA) {
+			Elf_Rela *rela;
+			Elf_Rela *start = (void *)hdr + sechdrs[i].sh_offset;
+			Elf_Rela *stop  = (void*)start + sechdrs[i].sh_size;
+			name += strlen(".rela");
+			if (section_ref_ok(name))
+				continue;
 
-		for (rela = start; rela < stop; rela++) {
-			Elf_Rela r;
-			const char *secname;
-			r.r_offset = TO_NATIVE(rela->r_offset);
-			r.r_info   = TO_NATIVE(rela->r_info);
-			r.r_addend = TO_NATIVE(rela->r_addend);
-			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
-			/* Skip special sections */
-			if (sym->st_shndx >= SHN_LORESERVE)
+			for (rela = start; rela < stop; rela++) {
+				r.r_offset = TO_NATIVE(rela->r_offset);
+				r.r_info   = TO_NATIVE(rela->r_info);
+				r.r_addend = TO_NATIVE(rela->r_addend);
+				sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+				/* Skip special sections */
+				if (sym->st_shndx >= SHN_LORESERVE)
+					continue;
+
+				secname = secstrings +
+					sechdrs[sym->st_shndx].sh_name;
+				if (section(secname))
+					warn_sec_mismatch(modname, name,
+							  elf, sym, r);
+			}
+		} else if (sechdrs[i].sh_type == SHT_REL) {
+			Elf_Rel *rel;
+			Elf_Rel *start = (void *)hdr + sechdrs[i].sh_offset;
+			Elf_Rel *stop  = (void*)start + sechdrs[i].sh_size;
+			name += strlen(".rel");
+			if (section_ref_ok(name))
 				continue;
 
-			secname = secstrings + sechdrs[sym->st_shndx].sh_name;
-			if (section(secname))
-				warn_sec_mismatch(modname, name, elf, sym, r);
+			for (rel = start; rel < stop; rel++) {
+				r.r_offset = TO_NATIVE(rel->r_offset);
+				r.r_info   = TO_NATIVE(rel->r_info);
+				r.r_addend = 0;
+				sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+				/* Skip special sections */
+				if (sym->st_shndx >= SHN_LORESERVE)
+					continue;
+
+				secname = secstrings +
+					sechdrs[sym->st_shndx].sh_name;
+				if (section(secname))
+					warn_sec_mismatch(modname, name,
+							  elf, sym, r);
+			}
 		}
 	}
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index b14255c..086fa46 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -21,6 +21,7 @@
 #define ELF_ST_BIND ELF32_ST_BIND
 #define ELF_ST_TYPE ELF32_ST_TYPE
 
+#define Elf_Rel     Elf32_Rel
 #define Elf_Rela    Elf32_Rela
 #define ELF_R_SYM   ELF32_R_SYM
 #define ELF_R_TYPE  ELF32_R_TYPE
@@ -34,6 +35,7 @@
 #define ELF_ST_BIND ELF64_ST_BIND
 #define ELF_ST_TYPE ELF64_ST_TYPE
 
+#define Elf_Rel     Elf64_Rel
 #define Elf_Rela    Elf64_Rela
 #define ELF_R_SYM   ELF64_R_SYM
 #define ELF_R_TYPE  ELF64_R_TYPE
