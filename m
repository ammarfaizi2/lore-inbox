Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTGADqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTGADqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:46:44 -0400
Received: from dp.samba.org ([66.70.73.150]:47324 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263777AbTGADqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:46:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem 
In-reply-to: Your message of "30 Jun 2003 09:10:46 EST."
             <1056982249.2069.25.camel@mulgrave> 
Date: Tue, 01 Jul 2003 11:11:24 +1000
Message-Id: <20030701040105.193BA2C221@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1056982249.2069.25.camel@mulgrave> you write:
> On Mon, 2003-06-30 at 01:17, Rusty Russell wrote:
> > Yeah, but I was trying to get you to do more work.  And if the names
> > resulting are useless anyway, why apply the patch?
> 
> I noticed.
> 
> However, not printing empty names makes the trace a lot more useful. 
> Just doing a symbolic trace on modules on x86, I see pretty much the
> correct call trace now.

Right.  *That* is what I wanted to know: whether those were really
part of the backtrace or just noise.  I'll forward to Linus.

> > I think you can do it easily in module_finalize... or if we were
> > ambitious we'd extract only the function symbols rather than keeping
> > the whole strtab and symtab.
> 
> Apart from the dubious writing to a const * pointer, yes I can (it's
> what I'm doing now).  There is some annoyance in that module_finalize
> isn't told where the string or symbol tables are, so I have to find them
> again.

My mistake: add_kallsyms should be above module_finalize, which means
you can just use the mod->symtab and mod->strtab members.

How's this?

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.73-bk7/kernel/module.c tmp/kernel/module.c
--- linux-2.5.73-bk7/kernel/module.c	2003-06-15 11:30:11.000000000 +1000
+++ tmp/kernel/module.c	2003-07-01 11:09:57.000000000 +1000
@@ -1349,7 +1349,15 @@ static void add_kallsyms(struct module *
 		mod->symtab[i].st_info
 			= elf_type(&mod->symtab[i], sechdrs, secstrings, mod);
 }
-#endif
+#else
+static inline void add_kallsyms(struct module *mod,
+				Elf_Shdr *sechdrs,
+				unsigned int symindex,
+				unsigned int strindex,
+				const char *secstrings)
+{
+}
+#endif /* CONFIG_KALLSYMS */
 
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
@@ -1603,14 +1611,12 @@ static struct module *load_module(void _
 	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
 		       sechdrs[pcpuindex].sh_size);
 
+	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
+
 	err = module_finalize(hdr, sechdrs, mod);
 	if (err < 0)
 		goto cleanup;
 
-#ifdef CONFIG_KALLSYMS
-	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
-#endif
-
 	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
