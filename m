Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267965AbTAMGnA>; Mon, 13 Jan 2003 01:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTAMGnA>; Mon, 13 Jan 2003 01:43:00 -0500
Received: from dp.samba.org ([66.70.73.150]:5088 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267965AbTAMGm6>;
	Mon, 13 Jan 2003 01:42:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT. 
In-reply-to: Your message of "Sun, 12 Jan 2003 21:29:23 -0800."
             <Pine.LNX.4.44.0301122127130.1310-100000@home.transmeta.com> 
Date: Mon, 13 Jan 2003 17:51:15 +1100
Message-Id: <20030113065148.A685A2C07D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301122127130.1310-100000@home.transmeta.com> you wri
te:
> 
> On Mon, 13 Jan 2003, Rusty Russell wrote:
> >
> > Linus, please apply if you agree.
> 
> I don't like this, it doesn't make much sense to me to special-case this 
> with some "module .sanity thing".
> 
> Instead, why don't you make _every_ object file just contain some magic
> section (link-once), and then at module load time you compare the contents
> of the section with the kernel magic section.
> 
> That magic section can then be arbitrary, with no strange bitmap 
> limitations etc. 

Ok.  Not every object, but every object file which includes module.h.

I've only updated the x86 linker script, since the other archs'
compile will break as soon as they set CONFIG_MODULES=y (there are 40
linker scripts in the tree, and I don't want to patch them all again).

You now get:
ext2: version magic 'non-SMP,preempt,gcc-2.95' != kernel 'SMP,preempt,gcc-2.95'

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Sanity Check
Author: Rusty Russell
Status: Tested on 2.5.56

D: Stores a section in each object, for SMP, PREEMPT and compiler
D: version (spinlocks change size on UP with gcc major, at least).
D: This was Linus' suggestion.  Also printks on modules with common
D: section (becoming an FAQ for third-party modules).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/arch/i386/vmlinux.lds.S working-2.5-bk-sanityII/arch/i386/vmlinux.lds.S
--- linux-2.5-bk/arch/i386/vmlinux.lds.S	Mon Jan 13 16:56:21 2003
+++ working-2.5-bk-sanityII/arch/i386/vmlinux.lds.S	Mon Jan 13 17:36:39 2003
@@ -39,6 +39,9 @@ SECTIONS
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
 
+  __vermagic = . ;		/* Version magic to match against modules. */
+  .gnu.linkonce.vermagic : { *(.gnu.linkonce.vermagic) }
+
   /* writeable */
   .data : {			/* Data */
 	*(.data)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-sanityII/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	Mon Jan 13 16:56:29 2003
+++ working-2.5-bk-sanityII/include/linux/module.h	Mon Jan 13 17:27:41 2003
@@ -134,6 +134,25 @@ struct exception_table
 
 
 #ifdef CONFIG_MODULES
+/* Simply sanity version stamp to place in each object. */
+#ifdef CONFIG_SMP
+#define MODULE_VERMAGIC_SMP "SMP,"
+#else
+#define MODULE_VERMAGIC_SMP "non-SMP,"
+#endif
+#ifdef CONFIG_PREEMPT
+#define MODULE_VERMAGIC_PREEMPT "preempt,"
+#else
+#define MODULE_VERMAGIC_PREEMPT "non-preempt,"
+#endif
+#ifndef MODULE_ARCH_VERMAGIC
+#define MODULE_ARCH_VERMAGIC ""
+#endif
+
+char __vermagic[] __attribute__((section(".gnu.linkonce.vermagic"))) = 
+	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT MODULE_ARCH_VERMAGIC 
+	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__);
+
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-sanityII/kernel/module.c
--- linux-2.5-bk/kernel/module.c	Mon Jan 13 16:56:30 2003
+++ working-2.5-bk-sanityII/kernel/module.c	Mon Jan 13 17:43:59 2003
@@ -846,6 +846,8 @@ static int simplify_symbols(Elf_Shdr *se
 			/* We compiled with -fno-common.  These are not
 			   supposed to happen.  */
 			DEBUGP("Common symbol: %s\n", strtab + sym[i].st_name);
+			printk("%s: probably not compiled with -fno-common\n",
+			       mod->name);
 			return -ENOEXEC;
 
 		case SHN_ABS:
@@ -976,6 +978,9 @@ static void set_license(struct module *m
 	}
 }
 
+/* Created bu the linker script */
+extern char __vermagic[];
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void *umod,
@@ -986,7 +991,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex, licenseindex, gplindex;
+		modindex, obsparmindex, licenseindex, gplindex, vmagindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1025,7 +1030,7 @@ static struct module *load_module(void *
 	exportindex = setupindex = obsparmindex = gplindex = licenseindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modindex = 0;
+	symindex = strindex = exindex = modindex = vmagindex = 0;
 
 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1075,6 +1080,11 @@ static struct module *load_module(void *
 			/* EXPORT_SYMBOL_GPL() */
 			DEBUGP("GPL symbols found in section %u\n", i);
 			gplindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  ".gnu.linkonce.vermagic") == 0) {
+			/* Version magic. */
+			DEBUGP("Version magic found in section %u\n", i);
+			vmagindex = i;
 		}
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
@@ -1094,6 +1104,16 @@ static struct module *load_module(void *
 		goto free_hdr;
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
+
+	if (!vmagindex
+	    || strcmp((char *)sechdrs[vmagindex].sh_addr, __vermagic) != 0) {
+		printk(KERN_WARNING "%s: version magic '%s' != kernel '%s'\n",
+		       mod->name,
+		       vmagindex ? (char*)sechdrs[vmagindex].sh_addr : "NONE",
+		       __vermagic);
+		err = -ENOEXEC;
+		goto free_hdr;
+	}
 
 	/* Now copy in args */
 	arglen = strlen_user(uargs);
