Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWBQVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWBQVtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWBQVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:49:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1299 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750883AbWBQVtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:49:05 -0500
Date: Fri, 17 Feb 2006 22:48:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@mars.ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: kbuild: 
Message-ID: <20060217214855.GA5563@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have moved the functionality of reference_init + reference_discarded
to modpost to secure a much wider use of this check.
Patch is included below.
Advantage is that the check is runn for each and every kernel build.

The check may still pont at false positive - I will let time decide.
So far the warnings I have chased was all positives so I am pretty
confident that keeping the checks in modpost is good.

Compared to the perl scripts more issues are catched since
single file modules are checked too.

This is tested only on x86_64 - I expect a few suprises when tried on
other architectures but hopefully -mm exposure will soon fix those.

In a follow-up mail I will post the result of a run with this patch.

Note - patch not yet pushed to the kbuild tree - will see any feedback
first.

	Sam


diff-tree 5b07cab879c1f94f0217ec0f69bc88c8a42c5943 (from 275074573ca9ebffed3ce16817782279afbcfe08)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Fri Feb 17 22:42:02 2006 +0100

    kbuild: check for section mismatch during modpost stage
    
    Section mismatch is identified as references to .init*
    sections from non .init sections. And likewise references
    to .exit.* sections outside .exit sections.
    
    .init.* sections are discarded after a module is initialized
    and references to .init.* sections are oops candidates.
    .exit.* sections are discarded when a module is built-in and
    thus references to .exit are also oops candidates.
    
    The checks were possible to do using 'make buildcheck' which
    called the two perl scripts: reference_discarded.pl and
    reference_init.pl. This patch just moves the same functionality
    inside modpost and the scripts are then obsoleted.
    They will though be kept for a while so users can do double
    checks - but note that some .o files are skipped by the perl scripts
    so result is not 1:1.
    All credit for the concept goes to Keith Owens who implemented
    the original perl scrips - this patch just moves it to modpost.
    
    Compared to the perl script the implmentation in modpost will be run
    for each kernel build - thus catching the error much sooner, but
    the downside is that the individual .o file are not always identified.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d901095..a7360c3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -449,10 +449,266 @@ static char *get_modinfo(void *modinfo, 
 			return p + taglen + 1;
 	}
 	return NULL;
 }
 
+/*
+ * Find symbols before or equal addr and after addr - in the section sec
+ **/
+static void find_symbols_between(struct elf_info *elf, Elf_Addr addr,
+				 const char *sec,
+			         Elf_Sym **before, Elf_Sym **after)
+{
+	Elf_Sym *sym;
+	Elf_Ehdr *hdr = elf->hdr;
+	Elf_Addr beforediff = ~0;
+	Elf_Addr afterdiff = ~0;
+	const char *secstrings = (void *)hdr +
+				 elf->sechdrs[hdr->e_shstrndx].sh_offset;
+	
+	*before = NULL;
+	*after = NULL;
+
+	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		const char *symsec;
+
+		if (sym->st_shndx >= SHN_LORESERVE)
+			continue;
+		symsec = secstrings + elf->sechdrs[sym->st_shndx].sh_name;
+		if (strcmp(symsec, sec) != 0)
+			continue;
+		if (sym->st_value <= addr) {
+			if ((addr - sym->st_value) < beforediff) {
+				beforediff = addr - sym->st_value;
+				*before = sym;
+			}
+		}
+		else
+		{
+			if ((sym->st_value - addr) < afterdiff) {
+				afterdiff = sym->st_value - addr;
+				*after = sym;
+			}
+		}
+	}
+}
+
+/**
+ * Print a warning about a section mismatch.
+ * Try to find symbols near it so user can find it.
+ **/
+static void warn_sec_mismatch(const char *modname, const char *fromsec,
+			      struct elf_info *elf, Elf_Sym *sym, Elf_Rela r)
+{
+	Elf_Sym *before;
+	Elf_Sym *after;
+	Elf_Ehdr *hdr = elf->hdr;
+	Elf_Shdr *sechdrs = elf->sechdrs;
+	const char *secstrings = (void *)hdr +
+				 sechdrs[hdr->e_shstrndx].sh_offset;
+	const char *secname = secstrings + sechdrs[sym->st_shndx].sh_name;
+	
+	find_symbols_between(elf, r.r_offset, fromsec, &before, &after);
+
+	if (before && after) {
+		warn("%s - Section mismatch: reference to %s from %s "
+		     "between '%s' (at offset 0x%lx) and '%s'\n",
+		     modname, secname, fromsec,
+		     elf->strtab + before->st_name,
+		     (long)(r.r_offset - before->st_value),
+		     elf->strtab + after->st_name);
+	} else if (before) {
+		warn("%s - Section mismatch: reference to %s from %s "
+		     "after '%s' (at offset 0x%lx)\n",
+		     modname, secname, fromsec, 
+		     elf->strtab + before->st_name,
+		     (long)(r.r_offset - before->st_value));
+	} else if (after) {
+		warn("%s - Section mismatch: reference to %s from %s "
+		     "before '%s' (at offset -0x%lx)\n",
+		     modname, secname, fromsec, 
+		     elf->strtab + before->st_name,
+		     (long)(before->st_value - r.r_offset));
+	} else {
+		warn("%s - Section mismatch: reference to %s from %s "
+		     "(offset 0x%lx)\n",
+		     modname, secname, fromsec, (long)r.r_offset);
+	}
+}
+
+/**
+ * A module includes a number of sections that are discarded
+ * either when loaded or when used as built-in.
+ * For loaded modules all functions marked __init and all data
+ * marked __initdata will be discarded when the module has been intialized.
+ * Likewise for modules used built-in the sections marked __exit
+ * are discarded because __exit marked function are supposed to be called
+ * only when a moduel is unloaded which never happes for built-in modules.
+ * The check_sec_ref() function traverses all relocation records
+ * to find all references to a section that reference a section that will
+ * be discarded and warns about it.
+ **/
+static void check_sec_ref(struct module *mod, const char *modname,
+			  struct elf_info *elf,
+			  int section(const char*),
+			  int section_ref_ok(const char *))
+{
+	int i;
+	Elf_Sym  *sym;
+	Elf_Ehdr *hdr = elf->hdr;
+	Elf_Shdr *sechdrs = elf->sechdrs;
+	const char *secstrings = (void *)hdr +
+				 sechdrs[hdr->e_shstrndx].sh_offset;
+		
+	/* Walk through all sections */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		const char *name = secstrings + sechdrs[i].sh_name +
+						strlen(".rela");
+		/* We want to process only relocation sections and not .init */
+		if (section_ref_ok(name) || (sechdrs[i].sh_type != SHT_RELA))
+			continue;
+		Elf_Rela *rela;
+		Elf_Rela *start = (void *)hdr + sechdrs[i].sh_offset;
+		Elf_Rela *stop  = (void*)start + sechdrs[i].sh_size;
+
+		for (rela = start; rela < stop; rela++) {
+			Elf_Rela r;
+			const char *secname;
+			r.r_offset = TO_NATIVE(rela->r_offset);
+			r.r_info   = TO_NATIVE(rela->r_info);
+			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+			secname = secstrings + sechdrs[sym->st_shndx].sh_name;
+			/* Skip special sections */
+			if (sym->st_shndx >= SHN_LORESERVE)
+				continue;
+
+			if (section(secname))
+				warn_sec_mismatch(modname, name, elf, sym, r);
+		}
+	}
+}
+
+/**
+ * Functions used only during module init is marked __init and is stored in
+ * a .init.text section. Likewise data is marked __initdata and stored in
+ * a .init.data section.
+ * If this section is one of these sections return 1
+ * See include/linux/init.h for the details
+ **/
+static int init_section(const char *name)
+{
+	if (strcmp(name, ".init") == 0)
+		return 1;
+	if (strncmp(name, ".init.", strlen(".init.")) == 0)
+		return 1;
+	return 0;
+}
+
+/**
+ * Identify sections from which references to a .init section is OK.
+ * 
+ * Unfortunately references to read only data that referenced .init
+ * sections had to be excluded. Almost all of these are false
+ * positives, they are created by gcc. The downside of excluding rodata
+ * is that there really are some user references from rodata to
+ * init code, e.g. drivers/video/vgacon.c:
+ * 
+ * const struct consw vga_con = {
+ *        con_startup:            vgacon_startup,
+ *
+ * where vgacon_startup is __init.  If you want to wade through the false
+ * positives, take out the check for rodata.
+ **/
+static int init_section_ref_ok(const char *name)
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
+/*
+ * Functions used only during module exit is marked __exit and is stored in
+ * a .exit.text section. Likewise data is marked __exitdata and stored in
+ * a .exit.data section.
+ * If this section is one of these sections return 1
+ * See include/linux/init.h for the details
+ **/
+static int exit_section(const char *name)
+{
+	if (strcmp(name, ".exit.text") == 0)
+		return 1;
+	if (strcmp(name, ".exit.data") == 0)
+		return 1;
+	return 0;
+	
+}
+
+/*
+ * Identify sections from which references to a .exit section is OK.
+ * 
+ * [OPD] Keith Ownes <kaos@sgi.com> commented:
+ * For our future {in}sanity, add a comment that this is the ppc .opd
+ * section, not the ia64 .opd section.
+ * ia64 .opd should not point to discarded sections.
+ **/
+static int exit_section_ref_ok(const char *name)
+{
+	const char **s;
+	/* Absolute section names */
+	const char *namelist1[] = {
+		".exit.text",
+		".exit.data",
+		".init.text",
+		".opd", /* See comment [OPD] */
+		".altinstructions",
+		".pdr",
+		".exitcall.exit",
+		".eh_frame",
+		".stab",
+		NULL
+	};
+	/* Start of section names */
+	const char *namelist2[] = {
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
 static void read_symbols(char *modname)
 {
 	const char *symname;
 	char *version;
 	struct module *mod;
@@ -474,10 +730,12 @@ static void read_symbols(char *modname)
 		symname = info.strtab + sym->st_name;
 
 		handle_modversions(mod, &info, sym, symname);
 		handle_moddevtable(mod, &info, sym, symname);
 	}
+	check_sec_ref(mod, modname, &info, init_section, init_section_ref_ok);
+	check_sec_ref(mod, modname, &info, exit_section, exit_section_ref_ok);
 
 	version = get_modinfo(info.modinfo, info.modinfo_len, "version");
 	if (version)
 		maybe_frob_rcs_version(modname, version, info.modinfo,
 				       version - (char *)info.hdr);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index c0de7b9..3b5319d 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -14,21 +14,31 @@
 #if KERNEL_ELFCLASS == ELFCLASS32
 
 #define Elf_Ehdr    Elf32_Ehdr 
 #define Elf_Shdr    Elf32_Shdr 
 #define Elf_Sym     Elf32_Sym
+#define Elf_Addr    Elf32_Addr
+#define Elf_Section Elf32_Section
 #define ELF_ST_BIND ELF32_ST_BIND
 #define ELF_ST_TYPE ELF32_ST_TYPE
 
+#define Elf_Rela    Elf32_Rela
+#define ELF_R_SYM   ELF32_R_SYM
+#define ELF_R_TYPE  ELF32_R_TYPE
 #else
 
 #define Elf_Ehdr    Elf64_Ehdr 
 #define Elf_Shdr    Elf64_Shdr 
 #define Elf_Sym     Elf64_Sym
+#define Elf_Addr    Elf64_Addr
+#define Elf_Section Elf64_Section
 #define ELF_ST_BIND ELF64_ST_BIND
 #define ELF_ST_TYPE ELF64_ST_TYPE
 
+#define Elf_Rela    Elf64_Rela
+#define ELF_R_SYM   ELF64_R_SYM
+#define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
