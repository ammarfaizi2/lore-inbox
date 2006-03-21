Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWCUQYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWCUQYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWCUQV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30988 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932437AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 19/46] kbuild: include symbol names in section mismatch warnings
In-Reply-To: <11429580551265-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <1142958055125-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to look up the symbol that is referenced. Include the symbol
name in the warning message.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |   64 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 17 deletions(-)

93684d3b8062d1cebdeaed398ec6d1f354cb41a9
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index eeaf574..844f84b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -451,6 +451,29 @@ static char *get_modinfo(void *modinfo, 
 	return NULL;
 }
 
+/**
+ * Find symbol based on relocation record info.
+ * In some cases the symbol supplied is a valid symbol so
+ * return refsym. If st_name != 0 we assume this is a valid symbol.
+ * In other cases the symbol needs to be looked up in the symbol table
+ * based on section and address.
+ *  **/
+static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf_Addr addr,
+				Elf_Sym *relsym)
+{
+	Elf_Sym *sym;
+
+	if (relsym->st_name != 0)
+		return relsym;
+	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		if (sym->st_shndx != relsym->st_shndx)
+			continue;
+		if (sym->st_value == addr)
+			return sym;
+	}
+	return NULL;
+}
+
 /*
  * Find symbols before or equal addr and after addr - in the section sec
  **/
@@ -499,8 +522,9 @@ static void find_symbols_between(struct 
 static void warn_sec_mismatch(const char *modname, const char *fromsec,
 			      struct elf_info *elf, Elf_Sym *sym, Elf_Rela r)
 {
-	Elf_Sym *before;
-	Elf_Sym *after;
+	const char *refsymname = "";
+	Elf_Sym *before, *after;
+	Elf_Sym *refsym;
 	Elf_Ehdr *hdr = elf->hdr;
 	Elf_Shdr *sechdrs = elf->sechdrs;
 	const char *secstrings = (void *)hdr +
@@ -509,29 +533,34 @@ static void warn_sec_mismatch(const char
 	
 	find_symbols_between(elf, r.r_offset, fromsec, &before, &after);
 
+	refsym = find_elf_symbol(elf, r.r_addend, sym);
+	if (refsym && strlen(elf->strtab + refsym->st_name))
+		refsymname = elf->strtab + refsym->st_name;
+	
 	if (before && after) {
-		warn("%s - Section mismatch: reference to %s from %s "
-		     "between '%s' (at offset 0x%lx) and '%s'\n",
-		     modname, secname, fromsec,
+		warn("%s - Section mismatch: reference to %s:%s from %s "
+		     "between '%s' (at offset 0x%llx) and '%s'\n",
+		     modname, secname, refsymname, fromsec,
 		     elf->strtab + before->st_name,
-		     (long)(r.r_offset - before->st_value),
+		     (long long)r.r_offset,
 		     elf->strtab + after->st_name);
 	} else if (before) {
-		warn("%s - Section mismatch: reference to %s from %s "
-		     "after '%s' (at offset 0x%lx)\n",
-		     modname, secname, fromsec, 
+		warn("%s - Section mismatch: reference to %s:%s from %s "
+		     "after '%s' (at offset 0x%llx)\n",
+		     modname, secname, refsymname, fromsec, 
 		     elf->strtab + before->st_name,
-		     (long)(r.r_offset - before->st_value));
+		     (long long)r.r_offset);
 	} else if (after) {
-		warn("%s - Section mismatch: reference to %s from %s "
-		     "before '%s' (at offset -0x%lx)\n",
-		     modname, secname, fromsec, 
+		warn("%s - Section mismatch: reference to %s:%s from %s "
+		     "before '%s' (at offset -0x%llx)\n",
+		     modname, secname, refsymname, fromsec, 
 		     elf->strtab + before->st_name,
-		     (long)(before->st_value - r.r_offset));
+		     (long long)r.r_offset);
 	} else {
-		warn("%s - Section mismatch: reference to %s from %s "
-		     "(offset 0x%lx)\n",
-		     modname, secname, fromsec, (long)r.r_offset);
+		warn("%s - Section mismatch: reference to %s:%s from %s "
+		     "(offset 0x%llx)\n",
+		     modname, secname, fromsec, refsymname,
+		     (long long)r.r_offset);
 	}
 }
 
@@ -575,6 +604,7 @@ static void check_sec_ref(struct module 
 			const char *secname;
 			r.r_offset = TO_NATIVE(rela->r_offset);
 			r.r_info   = TO_NATIVE(rela->r_info);
+			r.r_addend = TO_NATIVE(rela->r_addend);
 			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
 			/* Skip special sections */
 			if (sym->st_shndx >= SHN_LORESERVE)
-- 
1.0.GIT


