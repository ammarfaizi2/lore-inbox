Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSKRXpU>; Mon, 18 Nov 2002 18:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSKRXpU>; Mon, 18 Nov 2002 18:45:20 -0500
Received: from dp.samba.org ([66.70.73.150]:13787 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267028AbSKRXpS>;
	Mon, 18 Nov 2002 18:45:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mbm@tinc.org.uk
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: 2.5.48: BUG() at kernel/module.c:1000 
In-reply-to: Your message of "Mon, 18 Nov 2002 22:39:11 -0000."
             <200211182239.gAIMdBL04074@mort.demon.co.uk> 
Date: Tue, 19 Nov 2002 10:50:42 +1100
Message-Id: <20021118235221.4B9A92C237@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211182239.gAIMdBL04074@mort.demon.co.uk> you write:
> The code (get_sizes) that calculates the amount of space required
> by the sections assumes that the first one is loaded at address
> zero (or large alignment) when performing subsequent alignments.

Please test this patch (Petr, contains fix for you too).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.48/kernel/module.c working-2.5.48-fixes/kernel/module.c
--- linux-2.5.48/kernel/module.c	2002-11-19 09:58:52.000000000 +1100
+++ working-2.5.48-fixes/kernel/module.c	2002-11-19 10:33:48.000000000 +1100
@@ -788,9 +788,10 @@ static void simplify_symbols(Elf_Shdr *s
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
@@ -943,10 +944,9 @@ static struct module *load_module(void *
 	mod->live = 0;
 	module_unload_init(mod);
 
-	/* How much space will we need?  (Common area in core) */
-	sizes = get_sizes(hdr, sechdrs, secstrings);
-	common_length = read_commons(hdr, &sechdrs[symindex]);
-	sizes.core_size += common_length;
+	/* How much space will we need?  (Common area in first) */
+	sizes = get_sizes(hdr, sechdrs, secstrings,
+			  read_commons(hdr, &sechdrs[symindex]));
 
 	/* Set these up, and allow archs to manipulate them. */
 	mod->core_size = sizes.core_size;
@@ -973,7 +973,7 @@ static struct module *load_module(void *
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
-	if (!ptr) {
+	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
 	}
