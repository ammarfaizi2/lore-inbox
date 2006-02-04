Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWBDWuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWBDWuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWBDWuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:50:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7431 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932519AbWBDWuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:50:39 -0500
Date: Sat, 4 Feb 2006 23:50:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Check for references to discarded sections during build time
Message-ID: <20060204225025.GA21292@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith.

While doing some other modpost.c changes I thought about the
possibility to do the reference_init check during the modpost stage - so
it is done early and author can catch warning when he made the error.
Attached is first cut.

It does a much more lousy job than reference_init because it identifies
the module and not the .o file. I hope to later identify the function
where the illegal reference hapens.

I have only run it on a subset of the kernel and it found a few
warnings in ide-core.o + one warning in net/drivers/drgs.o.
I have not investigated if this is false positives yet.

make allmodconfig running in background - will check the result when I
wake up again.

	Sam

 modpost.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 modpost.h |    6 ++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d901095..b41ae4f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -451,6 +451,96 @@ static char *get_modinfo(void *modinfo, 
 	return NULL;
 }
 
+/**
+ * Is this section a true init section?
+ **/
+static int is_init_section(const char *name)
+{
+	if (strcmp(name, ".init") == 0)
+		return 1;
+	if (strncmp(name, ".init.", strlen(".init.")) == 0)
+		return 1;
+	return 0;
+}
+
+/**
+ * Check name - identify sections which is discarded by vmlinux
+ * after module is loaded. Here we are fine referencing __init.
+ **/
+static int is_ref_init_ok(const char *name)
+{
+	const char **s;
+	/* Absolute section names */
+	const char *namelist1[] = {
+		".init",
+		".stab",
+		".rodata",
+		".text.lock",
+		".pci_fixup_header",
+		".pci_fixup_final",
+		".pdr",
+		"__param",
+		NULL
+	};
+	/* Start of section names */
+	const char *namelist2[] = {
+		".init.",
+		".altinstructions",
+		".eh_frame",
+		".debug",
+		NULL
+	};
+	
+	for (s = namelist1; *s; s++)
+		if (strcmp(*s, name) == 0)
+			return 1;
+	for (s = namelist2; *s; s++)	
+		if (strncmp(*s, name, strlen(*s)) == 0)
+			return 1;
+	return 0;
+}
+
+/**
+ * Walk through all sections.
+ * All sections with references to a section identified as "init"
+ * needs to be int too - otherwise we have a reference to code marked
+ * __init and which is discarded by vmlinux
+ **/
+static void handle_checkinitref(struct module *mod, const char *modname, struct elf_info *elf)
+{
+	int i;
+	Elf_Sym  *sym;
+	Elf_Ehdr *hdr = elf->hdr;
+	Elf_Shdr *sechdrs = elf->sechdrs;
+	const char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+		
+	/* Walk through all sections */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		const char *name = secstrings + sechdrs[i].sh_name + strlen(".rela");
+		/* We want to process only relocation sections and not .init */
+		if (is_ref_init_ok(name) || (sechdrs[i].sh_type != SHT_RELA))
+			continue;
+		Elf_Rela *rela;
+		Elf_Rela *start = (void *)hdr + sechdrs[i].sh_offset;
+		Elf_Rela *stop  = (void*)start + sechdrs[i].sh_size;
+		for (rela = start; rela < stop; rela++) {
+			Elf_Rela r;
+			const char *symname;
+			r.r_offset = TO_NATIVE(rela->r_offset);
+			r.r_info   = TO_NATIVE(rela->r_info);
+			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+			symname = secstrings + sechdrs[sym->st_shndx].sh_name;
+
+			if (is_init_section(symname)) {
+				warn("%s: Reference to %s section from "
+				     "offset 0x%lx within section %s\n",
+				     modname, secstrings + sechdrs[sym->st_shndx].sh_name,
+				     (long)r.r_offset, name);
+			}
+		}
+	}
+}
+
 static void read_symbols(char *modname)
 {
 	const char *symname;
@@ -476,6 +566,7 @@ static void read_symbols(char *modname)
 		handle_modversions(mod, &info, sym, symname);
 		handle_moddevtable(mod, &info, sym, symname);
 	}
+	handle_checkinitref(mod, modname, &info);
 
 	version = get_modinfo(info.modinfo, info.modinfo_len, "version");
 	if (version)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index c0de7b9..f7126c1 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -19,6 +19,9 @@
 #define ELF_ST_BIND ELF32_ST_BIND
 #define ELF_ST_TYPE ELF32_ST_TYPE
 
+#define Elf_Rela    Elf32_Rela
+#define ELF_R_SYM   ELF32_R_SYM
+#define ELF_R_TYPE  ELF32_R_TYPE
 #else
 
 #define Elf_Ehdr    Elf64_Ehdr 
@@ -27,6 +30,9 @@
 #define ELF_ST_BIND ELF64_ST_BIND
 #define ELF_ST_TYPE ELF64_ST_TYPE
 
+#define Elf_Rela    Elf64_Rela
+#define ELF_R_SYM   ELF64_R_SYM
+#define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
 #if KERNEL_ELFDATA != HOST_ELFDATA
