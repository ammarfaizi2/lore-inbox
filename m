Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbTGAEo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbTGAEo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:44:58 -0400
Received: from dp.samba.org ([66.70.73.150]:58860 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265938AbTGAEoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:44:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem 
In-reply-to: Your message of "30 Jun 2003 21:24:35 EST."
             <1057026277.2069.80.camel@mulgrave> 
Date: Tue, 01 Jul 2003 14:58:21 +1000
Message-Id: <20030701045917.CED532C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1057026277.2069.80.camel@mulgrave> you write:
> OK, how about the attached.  I think it solves the module_text_address()
> problem too.

Excellent: tested on bk8.  Linus, please apply (subsumes previous
patch: if you get a couple of rej's ignore them).

James: I changed the names to s/code/text/ since that's more expected
for toolchain-type people.  I frobbed the NOTE: comment a bit, and
moved the m == 0 tests outside the section loop.

Thanks!
Rusty.

================
Name: Identify Code Section Of Modules for kallsyms
Author: James Bottomley
Status: Tested on 2.5.73-bk8

D: Remember the size of the SHF_EXECINSTR sections, which are conveniently
D: at the start of the modules, and use that to more reliably implement
D: module_text_address().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5304-linux-2.5.73-bk8/include/linux/module.h .5304-linux-2.5.73-bk8.updated/include/linux/module.h
--- .5304-linux-2.5.73-bk8/include/linux/module.h	2003-06-15 11:30:08.000000000 +1000
+++ .5304-linux-2.5.73-bk8.updated/include/linux/module.h	2003-07-01 14:15:16.000000000 +1000
@@ -217,6 +217,9 @@ struct module
 	/* Here are the sizes of the init and core sections */
 	unsigned long init_size, core_size;
 
+	/* The size of the executable code in each section.  */
+	unsigned long init_text_size, core_text_size;
+
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5304-linux-2.5.73-bk8/kernel/module.c .5304-linux-2.5.73-bk8.updated/kernel/module.c
--- .5304-linux-2.5.73-bk8/kernel/module.c	2003-06-15 11:30:11.000000000 +1000
+++ .5304-linux-2.5.73-bk8.updated/kernel/module.c	2003-07-01 14:37:18.000000000 +1000
@@ -1176,6 +1176,9 @@ static void layout_sections(struct modul
 			    const char *secstrings)
 {
 	static unsigned long const masks[][2] = {
+		/* NOTE: all executable code must be the first section
+		 * in this array; otherwise modify the text_size
+		 * finder in the two loops below */
 		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
 		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
@@ -1199,6 +1202,8 @@ static void layout_sections(struct modul
 			s->sh_entsize = get_offset(&mod->core_size, s);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
 		}
+		if (m == 0)
+			mod->core_text_size = mod->core_size;
 	}
 
 	DEBUGP("Init section allocation order:\n");
@@ -1215,6 +1220,8 @@ static void layout_sections(struct modul
 					 | INIT_OFFSET_MASK);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
 		}
+		if (m == 0)
+			mod->init_text_size = mod->init_size;
 	}
 }
 
@@ -1726,6 +1733,7 @@ sys_init_module(void __user *umod,
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
+	mod->init_text_size = 0;
 	up(&module_mutex);
 
 	return 0;
@@ -1747,9 +1755,9 @@ static const char *get_ksymbol(struct mo
 
 	/* At worse, next value is at end of module */
 	if (within(addr, mod->module_init, mod->init_size))
-		nextval = (unsigned long)mod->module_init + mod->init_size;
+		nextval = (unsigned long)mod->module_init+mod->init_text_size;
 	else 
-		nextval = (unsigned long)mod->module_core + mod->core_size;
+		nextval = (unsigned long)mod->module_core+mod->core_text_size;
 
 	/* Scan for closest preceeding symbol, and next symbol. (ELF
            starts real symbols at 1). */
@@ -1757,11 +1765,15 @@ static const char *get_ksymbol(struct mo
 		if (mod->symtab[i].st_shndx == SHN_UNDEF)
 			continue;
 
+		/* We ignore unnamed symbols: they're uninformative
+		 * and inserted at a whim. */
 		if (mod->symtab[i].st_value <= addr
-		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
+		    && mod->symtab[i].st_value > mod->symtab[best].st_value
+		    && *(mod->strtab + mod->symtab[i].st_name) != '\0' )
 			best = i;
 		if (mod->symtab[i].st_value > addr
-		    && mod->symtab[i].st_value < nextval)
+		    && mod->symtab[i].st_value < nextval
+		    && *(mod->strtab + mod->symtab[i].st_name) != '\0')
 			nextval = mod->symtab[i].st_value;
 	}
 
@@ -1910,8 +1924,8 @@ struct module *module_text_address(unsig
 	struct module *mod;
 
 	list_for_each_entry(mod, &modules, list)
-		if (within(addr, mod->module_init, mod->init_size)
-		    || within(addr, mod->module_core, mod->core_size))
+		if (within(addr, mod->module_init, mod->init_text_size)
+		    || within(addr, mod->module_core, mod->core_text_size))
 			return mod;
 	return NULL;
 }
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
