Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTBSTSF>; Wed, 19 Feb 2003 14:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTBSTSF>; Wed, 19 Feb 2003 14:18:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:29636 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263215AbTBSTSC>; Wed, 19 Feb 2003 14:18:02 -0500
Date: Wed, 19 Feb 2003 13:26:58 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Miles Bader <miles@gnu.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Enhance script/modpost to handle "_" prefixed symbols
In-Reply-To: <20030218064443.CA5BB3728@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0302191324510.24975-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Miles Bader wrote:

> The decision to do so is made by having mk_elfconfig look at the elf
> machine-type.  It would be better to actually examine a known symbol,
> but that seems quite a bit more complicated.

Hmmh, the reason for mk_elfconfig existance was to avoid bit/endianness
independent parsing, not to put it in there. I put in the following
patch now, which is much simpler, yet should work just fine (untested);

--Kai


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.992   -> 1.993  
#	   scripts/modpost.c	1.7     -> 1.8    
#	    scripts/Makefile	1.31    -> 1.32   
#	scripts/mk_elfconfig.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/19	kai@tp1.ruhr-uni-bochum.de	1.993
# kbuild: Handle MODULE_SYMBOL_PREFIX in module postprocessing
# 
# Loosely based on a patch by Miles Bader, have modpost deal with
# weird archs (v850) which prefix their symbols with '_'.
# 
# Modpost does not yet handle ppc64 "prefix function symbols with '.'"
# correctly, btw.
# --------------------------------------------
#
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Wed Feb 19 13:24:48 2003
+++ b/scripts/Makefile	Wed Feb 19 13:24:48 2003
@@ -25,7 +25,7 @@
 $(obj)/modpost.o $(obj)/file2alias.o: $(obj)/elfconfig.h
 
 quiet_cmd_elfconfig = MKELF   $@
-      cmd_elfconfig = $(obj)/mk_elfconfig < $< > $@
+      cmd_elfconfig = $(obj)/mk_elfconfig $(ARCH) < $< > $@
 
 $(obj)/elfconfig.h: $(obj)/empty.o $(obj)/mk_elfconfig FORCE
 	$(call if_changed,elfconfig)
diff -Nru a/scripts/mk_elfconfig.c b/scripts/mk_elfconfig.c
--- a/scripts/mk_elfconfig.c	Wed Feb 19 13:24:48 2003
+++ b/scripts/mk_elfconfig.c	Wed Feb 19 13:24:48 2003
@@ -9,6 +9,9 @@
 	unsigned char ei[EI_NIDENT];	
 	union { short s; char c[2]; } endian_test;
 
+	if (argc != 2) {
+		fprintf(stderr, "Error: no arch\n");
+	}
 	if (fread(ei, 1, EI_NIDENT, stdin) != EI_NIDENT) {
 		fprintf(stderr, "Error: input truncated\n");
 		return 1;
@@ -51,6 +54,11 @@
 		printf("#define HOST_ELFDATA ELFDATA2LSB\n");
 	else
 		abort();
+
+	if (strcmp(argv[1], "v850") == 0)
+		printf("#define MODULE_SYMBOL_PREFIX \"_\"\n");
+	else 
+		printf("#define MODULE_SYMBOL_PREFIX \"\"\n");
 
 	return 0;
 }
diff -Nru a/scripts/modpost.c b/scripts/modpost.c
--- a/scripts/modpost.c	Wed Feb 19 13:24:48 2003
+++ b/scripts/modpost.c	Wed Feb 19 13:24:48 2003
@@ -265,6 +265,9 @@
 	munmap(info->hdr, info->size);
 }
 
+#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
+#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
+
 void
 handle_modversions(struct module *mod, struct elf_info *info,
 		   Elf_Sym *sym, const char *symname)
@@ -279,9 +282,10 @@
 		break;
 	case SHN_ABS:
 		/* CRC'd symbol */
-		if (memcmp(symname, "__crc_", 6) == 0) {
+		if (memcmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
 			crc = (unsigned int) sym->st_value;
-			add_exported_symbol(symname+6, mod, &crc);
+			add_exported_symbol(symname + strlen(CRC_PFX),
+					    mod, &crc);
 			modversions = 1;
 		}
 		break;
@@ -290,15 +294,20 @@
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
 			break;
 		
-		s = alloc_symbol(symname);
-		/* add to list */
-		s->next = mod->unres;
-		mod->unres = s;
+		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
+			   strlen(MODULE_SYMBOL_PREFIX)) == 0) {
+			s = alloc_symbol(symname + 
+					 strlen(MODULE_SYMBOL_PREFIX));
+			/* add to list */
+			s->next = mod->unres;
+			mod->unres = s;
+		}
 		break;
 	default:
 		/* All exported symbols */
-		if (memcmp(symname, "__ksymtab_", 10) == 0) {
-			add_exported_symbol(symname+10, mod, NULL);
+		if (memcmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
+			add_exported_symbol(symname + strlen(KSYMTAB_PFX),
+					    mod, NULL);
 		}
 		break;
 	}

