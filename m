Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTA2AKc>; Tue, 28 Jan 2003 19:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTA2AKc>; Tue, 28 Jan 2003 19:10:32 -0500
Received: from dp.samba.org ([66.70.73.150]:11913 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262469AbTA2AK1>;
	Tue, 28 Jan 2003 19:10:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] new modversions implementation 
In-reply-to: Your message of "Tue, 28 Jan 2003 08:31:17 -0800."
             <20030128083117.A15637@twiddle.net> 
Date: Wed, 29 Jan 2003 11:15:58 +1100
Message-Id: <20030129001948.4C3192C070@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030128083117.A15637@twiddle.net> you write:
> On Tue, Jan 28, 2003 at 09:38:31PM +1100, Rusty Russell wrote:
> > 	But once again you are relying on link order to keep the crcs
> > section in the same order as the ksymtab section (although the ld
> > documentation says that's correct, I know RTH doesn't like it).
> 
> What gave you that idea?  Link order is a fine thing to rely on.

OK, I stand corrected.  Sorry Kai, I guess this means that struct
kernel_symbol can drop the pointer, too.  I'll dig out the old patch
and resend it.

I also dropped the "ignore vermagic if modversions set": you were
right that that's a bad idea, too.

So, here is my much reduced patch on top of yours.  Please read
carefully since I'm obviously not having a great week 8)

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Tweaks to Module Versions
Author: Rusty Russell
Depends: Module/modversions.patch.gz
Status: Experimental

D: Fix the case where no CRCs are supplied (OK, but taints kernel), and
D: only print one tainted message (otherwise --force gives hundreds of them).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1440-linux-2.5.59/init/Kconfig .1440-linux-2.5.59.updated/init/Kconfig
--- .1440-linux-2.5.59/init/Kconfig	2003-01-29 11:13:07.000000000 +1100
+++ .1440-linux-2.5.59.updated/init/Kconfig	2003-01-29 11:14:00.000000000 +1100
@@ -147,7 +147,6 @@ config OBSOLETE_MODPARM
 config MODVERSIONING
 	bool "Module versioning support (EXPERIMENTAL)"
 	depends on MODULES && EXPERIMENTAL
-	help
 	---help---
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1440-linux-2.5.59/kernel/module.c .1440-linux-2.5.59.updated/kernel/module.c
--- .1440-linux-2.5.59/kernel/module.c	2003-01-29 11:13:07.000000000 +1100
+++ .1440-linux-2.5.59.updated/kernel/module.c	2003-01-29 11:13:43.000000000 +1100
@@ -737,12 +737,9 @@ static int check_version(Elf_Shdr *sechd
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
 
-	if (!ksg->crcs) { 
-		printk("%s: no CRC for \"%s\" [%s] found: kernel tainted.\n",
-		       mod->name, symname, 
-		       ksg->owner ? ksg->owner->name : "kernel");
-		goto taint;
-	}
+	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
+	if (!ksg->crcs)
+		return 1;
 
 	crc = ksg->crcs[symidx];
 
@@ -763,10 +760,11 @@ static int check_version(Elf_Shdr *sechd
 		return 0;
 	}
 	/* Not in module's version table.  OK, but that taints the kernel. */
-	printk("%s: no version for \"%s\" found: kernel tainted.\n",
-	       mod->name, symname);
- taint:
-	tainted |= TAINT_FORCED_MODULE;
+	if (!(tainted & TAINT_FORCED_MODULE)) {
+		printk("%s: no version for \"%s\" found: kernel tainted.\n",
+		       mod->name, symname);
+		tainted |= TAINT_FORCED_MODULE;
+	}
 	return 1;
 }
 #else
@@ -1273,11 +1271,23 @@ static struct module *load_module(void *
 	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	mod->symbols.crcs = (void *)sechdrs[crcindex].sh_addr;
+	if (crcindex)
+		mod->symbols.crcs = (void *)sechdrs[crcindex].sh_addr;
+
 	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
-	mod->gpl_symbols.crcs = (void *)sechdrs[gplcrcindex].sh_addr;
+	if (gplcrcindex)
+		mod->gpl_symbols.crcs = (void *)sechdrs[gplcrcindex].sh_addr;
+
+#ifdef CONFIG_MODVERSIONING
+	if ((mod->symbols.num_syms && !crcindex)
+	    || (mod->gpl_symbols.num_syms && !gplcrcindex))
+		printk(KERN_WARNING "%s: No versions for exported symbols."
+		       " Tainting kernel.\n", mod->name);
+		tainted |= TAINT_FORCED_MODULE;
+	}
+#endif /* CONFIG_MODVERSIONING */
 
 	/* Set up exception table */
 	if (exindex) {
