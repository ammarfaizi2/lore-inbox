Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbSKTH2P>; Wed, 20 Nov 2002 02:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKTHUH>; Wed, 20 Nov 2002 02:20:07 -0500
Received: from dp.samba.org ([66.70.73.150]:51411 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267633AbSKTHTs>;
	Wed, 20 Nov 2002 02:19:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: mbm@tinc.org.uk, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.48: BUG() at kernel/module.c:1000 
In-reply-to: Your message of "Tue, 19 Nov 2002 12:54:44 BST."
             <20021119115444.GA2011@vana> 
Date: Wed, 20 Nov 2002 17:54:23 +1100
Message-Id: <20021120072653.EF7592C06B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119115444.GA2011@vana> you write:
> On Tue, Nov 19, 2002 at 10:50:42AM +1100, Rusty Russell wrote:
> > In message <200211182239.gAIMdBL04074@mort.demon.co.uk> you write:
> > > The code (get_sizes) that calculates the amount of space required
> > > by the sections assumes that the first one is loaded at address
> > > zero (or large alignment) when performing subsequent alignments.
> > 
> > Please test this patch (Petr, contains fix for you too).
> 
> Hi Rusty,
>   I was getting oopses with your patch (due to uninitialized common_length).
> With this one (against clean 2.5.48) it works fine (both parport
> and vmmon can be insmodded/rmmoded (parport only until it is used by lp,
> but that's another story)).
> 
>   I also modified copy_sections code to verify that we are not
> overrunning allocated regions. So now you should get -ENOEXEC instead
> of BUG() + corrupted kernel.

Hmm, OK.  It *really* shouldn't happen unless there's a bug though.

Anyway, I made a tiny cleanup (I prefer not to do assignments inside
function parameters, it's icky).

Linus, please apply: fixes miscalculation of required module size due
to alignment issues, and also doesn't think that no init section is an
allocation failure.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module length calculation fix and module with no init fix
Author: Rusty Russell and Petr Vandrovec
Status: Tested on 2.5.48
Depends: Module/module.patch.gz

D: Fixes miscalculation of required module size due to alignment
D: issues of first section after common, and also doesn't think that
D: no init section is an allocation failure.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-spacefix/kernel/module.c
--- linux-2.5-bk/kernel/module.c	2002-11-20 05:58:00.000000000 +1100
+++ working-2.5-bk-spacefix/kernel/module.c	2002-11-20 17:47:45.000000000 +1100
@@ -592,14 +592,17 @@ static void *copy_section(const char *na
 {
 	void *dest;
 	unsigned long *use;
+	unsigned long max;
 
 	/* Only copy to init section if there is one */
 	if (strstr(name, ".init") && mod->module_init) {
 		dest = mod->module_init;
 		use = &used->init_size;
+		max = mod->init_size;
 	} else {
 		dest = mod->module_core;
 		use = &used->core_size;
+		max = mod->core_size;
 	}
 
 	/* Align up */
@@ -607,6 +610,9 @@ static void *copy_section(const char *na
 	dest += *use;
 	*use += sechdr->sh_size;
 
+	if (*use > max)
+		return ERR_PTR(-ENOEXEC);
+
 	/* May not actually be in the file (eg. bss). */
 	if (sechdr->sh_type != SHT_NOBITS)
 		memcpy(dest, base + sechdr->sh_offset, sechdr->sh_size);
@@ -773,9 +779,10 @@ static void simplify_symbols(Elf_Shdr *s
 /* Get the total allocation size of the init and non-init sections */
 static struct sizes get_sizes(const Elf_Ehdr *hdr,
 			      const Elf_Shdr *sechdrs,
-			      const char *secstrings)
+			      const char *secstrings,
+			      unsigned long common_length)
 {
-	struct sizes ret = { 0, 0 };
+	struct sizes ret = { 0, common_length };
 	unsigned i;
 
 	/* Everything marked ALLOC (this includes the exported
@@ -933,10 +940,9 @@ static struct module *load_module(void *
 	mod->live = 0;
 	module_unload_init(mod);
 
-	/* How much space will we need?  (Common area in core) */
-	sizes = get_sizes(hdr, sechdrs, secstrings);
+	/* How much space will we need?  (Common area in first) */
 	common_length = read_commons(hdr, &sechdrs[symindex]);
-	sizes.core_size += common_length;
+	sizes = get_sizes(hdr, sechdrs, secstrings, common_length);
 
 	/* Set these up, and allow archs to manipulate them. */
 	mod->core_size = sizes.core_size;
@@ -963,7 +969,7 @@ static struct module *load_module(void *
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
-	if (!ptr) {
+	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
 	}
