Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSK1Guy>; Thu, 28 Nov 2002 01:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSK1Gux>; Thu, 28 Nov 2002 01:50:53 -0500
Received: from dp.samba.org ([66.70.73.150]:11460 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265222AbSK1Guw>;
	Thu, 28 Nov 2002 01:50:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Kallsyms in modules fix
Date: Thu, 28 Nov 2002 17:57:25 +1100
Message-Id: <20021128065813.93AFD2C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous version was referencing freed memory, and usually got symbol
sizes wrong.

Linus, please apply.

Thanks to Ricky Beam for the excellent bug report,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Kallsyms inside module fix
Author: Rusty Russell
Status: Tested on 2.5.50

D: Two fixes.  Firstly, set ALLOC on the right section so we actually
D: keep the symbol names and don't deref a freed section, and secondly
D: get the symbol size (more) correct.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.50/kernel/module.c working-2.5.50-ksymoops/kernel/module.c
--- linux-2.5.50/kernel/module.c	Mon Nov 25 08:44:19 2002
+++ working-2.5.50-ksymoops/kernel/module.c	Thu Nov 28 16:22:56 2002
@@ -892,7 +892,7 @@ static struct module *load_module(void *
 		}
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
-		if (sechdrs[i].sh_type == SHT_SYMTAB || i == hdr->e_shstrndx)
+		if (sechdrs[i].sh_type == SHT_SYMTAB || i == strindex)
 			sechdrs[i].sh_flags |= SHF_ALLOC;
 #endif
 #ifndef CONFIG_MODULE_UNLOAD
@@ -1165,7 +1165,14 @@ static const char *get_ksymbol(struct mo
 			       unsigned long *size,
 			       unsigned long *offset)
 {
-	unsigned int i, next = 0, best = 0;
+	unsigned int i, best = 0;
+	unsigned long nextval;
+
+	/* At worse, next value is at end of module */
+	if (inside_core(mod, addr))
+		nextval = (unsigned long)mod->module_core+mod->core_size;
+	else 
+		nextval = (unsigned long)mod->module_init+mod->init_size;
 
 	/* Scan for closest preceeding symbol, and next symbol. (ELF
            starts real symbols at 1). */
@@ -1177,22 +1186,14 @@ static const char *get_ksymbol(struct mo
 		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
 			best = i;
 		if (mod->symtab[i].st_value > addr
-		    && mod->symtab[i].st_value < mod->symtab[next].st_value)
-			next = i;
+		    && mod->symtab[i].st_value < nextval)
+			nextval = mod->symtab[i].st_value;
 	}
 
 	if (!best)
 		return NULL;
 
-	if (!next) {
-		/* Last symbol?  It ends at the end of the module then. */
-		if (inside_core(mod, addr))
-			*size = mod->module_core+mod->core_size - (void*)addr;
-		else
-			*size = mod->module_init+mod->init_size - (void*)addr;
-	} else
-		*size = mod->symtab[next].st_value - addr;
-
+	*size = nextval - mod->symtab[best].st_value;
 	*offset = addr - mod->symtab[best].st_value;
 	return mod->strtab + mod->symtab[best].st_name;
 }
