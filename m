Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSK2DzI>; Thu, 28 Nov 2002 22:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbSK2DyE>; Thu, 28 Nov 2002 22:54:04 -0500
Received: from dp.samba.org ([66.70.73.150]:49545 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266955AbSK2Dx5>;
	Thu, 28 Nov 2002 22:53:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RELEASE] module-init-tools 0.8 
In-reply-to: Your message of "Thu, 28 Nov 2002 17:16:24 BST."
             <200211281616.gASGGOE6012229@bytesex.org> 
Date: Fri, 29 Nov 2002 13:38:10 +1100
Message-Id: <20021129040120.6965E2C256@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211281616.gASGGOE6012229@bytesex.org> you write:
> >  Please report any bugs to rusty@rustcorp.com.au.
> 
> System (SuSE 8.1) still doesn't boot up cleanly.  After logging in as
> root I can see a number of modprobe processes hanging around in the
> process table:
> 
> bogomips root ~# ps -ax | grep modprobe
>   621 ?        S      0:00 /sbin/modprobe -- char-major-6
>   622 ?        D      0:00 /sbin/modprobe -- parport_lowlevel
>   805 ?        D      0:00 /sbin/modprobe -- autofs
>   809 ?        D      0:00 /sbin/modprobe -- autofs
>   867 ?        D      0:00 /sbin/modprobe -- autofs
>   872 ?        D      0:00 /sbin/modprobe -- net-pf-17
>  1184 ttyS0    S      0:00 grep modprobe

I suspect one of these modules is trying to load other modules in its
init routine.  I wondered if anyone did this, I guess they do 8(.

Hmm, looks like parport.  I'll send a patch to drop the module lock
around module->init().  It's a good idea *anyway*: if a module oopses
in its init routine it's nice to be able to still use modules.

> Module debugging is next to impossible right now.  The apm.o module
> oopses for me in 2.5.50.  ksymoops isn't able to translate any symbol
> located in modules.  The in-kernel symbol decoder (CONFIG_KALLSYMS)
> doesn't work too.

Please try (previously posted) patch below,
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
