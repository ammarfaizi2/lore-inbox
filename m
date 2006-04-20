Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWDTWhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWDTWhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDTWhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:37:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16847 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932104AbWDTWg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:36:59 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] export symbol report: export-type enhancement to modpost.c
Cc: akpm@osdl.org, arjan@infradead.org, bunk@stusta.de, greg@kroah.com,
       hch@infradead.org, linuxram@us.ibm.com, mathur@us.ibm.com
Message-Id: <20060420223654.55AF9470032@localhost>
Date: Thu, 20 Apr 2006 15:36:54 -0700 (PDT)
From: linuxram@us.ibm.com (Ram Pai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This optional patch, provide the ability to identify the export-type of each
exported symbols.

NOTE: this patch updates the Module.symvers file with the additional
information as shown below.

0x0f8b92af      platform_device_add_resources   vmlinux EXPORT_GPL_ONLY
0xcf7efb2a      ethtool_op_set_tx_csum          vmlinux EXPORT_ALL


Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Avantika Mathur <mathur@us.ibm.com>

Index: 2617rc1/scripts/mod/modpost.c
===================================================================
--- 2617rc1.orig/scripts/mod/modpost.c	2006-04-02 20:22:10.000000000 -0700
+++ 2617rc1/scripts/mod/modpost.c	2006-04-18 16:15:15.000000000 -0700
@@ -18,6 +18,10 @@
 int modversions = 0;
 /* Warn about undefined symbols? (do so if we have vmlinux) */
 int have_vmlinux = 0;
+
+/* number of the section corresponding to gpl symbols */
+int ksymtab_gpl = -1;
+
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static int all_versions = 0;
 /* If we are modposting external module set to 1 */
@@ -118,6 +122,7 @@
 	unsigned int kernel:1;     /* 1 if symbol is from kernel
 				    *  (only for external modules) **/
 	unsigned int preloaded:1;  /* 1 if symbol from Module.symvers */
+	int export_type;
 	char name[0];
 };
 
@@ -153,7 +158,8 @@
 }
 
 /* For the hash of exported symbols */
-static struct symbol *new_symbol(const char *name, struct module *module)
+static struct symbol *new_symbol(const char *name, struct module *module,
+					int export_type)
 {
 	unsigned int hash;
 	struct symbol *new;
@@ -161,6 +167,7 @@
 	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
 	new = symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
 	new->module = module;
+	new->export_type = export_type;
 	return new;
 }
 
@@ -183,12 +190,13 @@
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
  **/
-static struct symbol *sym_add_exported(const char *name, struct module *mod)
+static struct symbol *sym_add_exported(const char *name, struct module *mod,
+				int export_type)
 {
 	struct symbol *s = find_symbol(name);
 
 	if (!s) {
-		s = new_symbol(name, mod);
+		s = new_symbol(name, mod, export_type);
 	} else {
 		if (!s->preloaded) {
 			warn("%s: '%s' exported twice. Previous export "
@@ -204,12 +212,12 @@
 }
 
 static void sym_update_crc(const char *name, struct module *mod,
-			   unsigned int crc)
+			   unsigned int crc, int export_type)
 {
 	struct symbol *s = find_symbol(name);
 
 	if (!s)
-		s = new_symbol(name, mod);
+		s = new_symbol(name, mod, export_type);
 	s->crc = crc;
 	s->crc_valid = 1;
 }
@@ -305,17 +313,23 @@
 		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
 		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
 	}
+
+	ksymtab_gpl = -1;
 	/* Find symbol table. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *secstrings
 			= (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+		const char *secname;
 
 		if (sechdrs[i].sh_offset > info->size)
 			goto truncated;
-		if (strcmp(secstrings+sechdrs[i].sh_name, ".modinfo") == 0) {
+		secname = secstrings+sechdrs[i].sh_name;
+		if (strcmp(secname, ".modinfo") == 0) {
 			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
 			info->modinfo_len = sechdrs[i].sh_size;
-		}
+		} else if (strcmp(secname, "__ksymtab_gpl") == 0)
+			ksymtab_gpl = i;
+
 		if (sechdrs[i].sh_type != SHT_SYMTAB)
 			continue;
 
@@ -348,11 +362,15 @@
 
 #define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
 #define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
+#define EXPORT_GPL_ONLY 1
+#define EXPORT_ALL      0
 
 static void handle_modversions(struct module *mod, struct elf_info *info,
 			       Elf_Sym *sym, const char *symname)
 {
 	unsigned int crc;
+	unsigned int export_type = (sym->st_shndx == ksymtab_gpl ?
+					EXPORT_GPL_ONLY : EXPORT_ALL);
 
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
@@ -362,7 +380,8 @@
 		/* CRC'd symbol */
 		if (memcmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
 			crc = (unsigned int) sym->st_value;
-			sym_update_crc(symname + strlen(CRC_PFX), mod, crc);
+			sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
+					export_type);
 		}
 		break;
 	case SHN_UNDEF:
@@ -406,7 +425,8 @@
 	default:
 		/* All exported symbols */
 		if (memcmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
-			sym_add_exported(symname + strlen(KSYMTAB_PFX), mod);
+			sym_add_exported(symname + strlen(KSYMTAB_PFX), mod,
+					export_type);
 		}
 		if (strcmp(symname, MODULE_SYMBOL_PREFIX "init_module") == 0)
 			mod->has_init = 1;
@@ -1098,10 +1118,11 @@
 		return;
 
 	while ((line = get_next_line(&pos, file, size))) {
-		char *symname, *modname, *d;
+		char *symname, *modname, *d, *export;
 		unsigned int crc;
 		struct module *mod;
 		struct symbol *s;
+		unsigned int export_type = 0;
 
 		if (!(symname = strchr(line, '\t')))
 			goto fail;
@@ -1109,12 +1130,19 @@
 		if (!(modname = strchr(symname, '\t')))
 			goto fail;
 		*modname++ = '\0';
-		if (strchr(modname, '\t'))
+		if (!(export = strchr(modname, '\t')))
+			goto fail;
+		*export++ = '\0';
+		if (strchr(export, '\t'))
 			goto fail;
 		crc = strtoul(line, &d, 16);
-		if (*symname == '\0' || *modname == '\0' || *d != '\0')
+		if (*symname == '\0' || *modname == '\0' || *export == '\0' || 
+					*d != '\0')
 			goto fail;
 
+		if (!(strcmp(export, "EXPORT_GPL_ONLY")))
+			export_type = 1;
+	
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {
 				have_vmlinux = 1;
@@ -1122,10 +1150,10 @@
 			mod = new_module(NOFAIL(strdup(modname)));
 			mod->skip = 1;
 		}
-		s = sym_add_exported(symname, mod);
+		s = sym_add_exported(symname, mod, export_type);
 		s->kernel    = kernel;
 		s->preloaded = 1;
-		sym_update_crc(symname, mod, crc);
+		sym_update_crc(symname, mod, crc, export_type);
 	}
 	return;
 fail:
@@ -1155,9 +1183,11 @@
 		symbol = symbolhash[n];
 		while (symbol) {
 			if (dump_sym(symbol))
-				buf_printf(&buf, "0x%08x\t%s\t%s\n",
+				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\n", 
 					symbol->crc, symbol->name,
-					symbol->module->name);
+					symbol->module->name,
+					(symbol->export_type? 
+					"EXPORT_GPL_ONLY" : "EXPORT_ALL"));
 			symbol = symbol->next;
 		}
 	}
