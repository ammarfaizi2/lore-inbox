Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTACFQj>; Fri, 3 Jan 2003 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTACFQj>; Fri, 3 Jan 2003 00:16:39 -0500
Received: from dp.samba.org ([66.70.73.150]:24742 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267395AbTACFQi>;
	Fri, 3 Jan 2003 00:16:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au, ak@suse.de
Date: Fri, 03 Jan 2003 16:24:51 +1100
Message-Id: <20030103052508.379BE2C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: sh_link 
In-reply-to: Your message of "Thu, 02 Jan 2003 20:40:23 -0800."
             <20030102204023.A24347@twiddle.net> 

In message <20030102204023.A24347@twiddle.net> you write:
> On Fri, Jan 03, 2003 at 03:26:31PM +1100, Rusty Russell wrote:
> > F... bugger.  Hmm... sh_entsize?  or sh_addralign?
> 
> *shrug* Prolly nothing uses sh_entsize, and you don't have
> the ordering issues you'd have with addralgin.

Ack.  Linus, please apply (sh_link is a 32-bit field on 64 bit archs,
so a bad choice to store offsets, and also INIT_OFFSET_MASK is out of
range).

Andi, you'll want this most.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-sh_entsize/kernel/module.c
--- linux-2.5-bk/kernel/module.c	2003-01-02 14:48:01.000000000 +1100
+++ working-2.5-bk-sh_entsize/kernel/module.c	2003-01-03 16:21:14.000000000 +1100
@@ -880,7 +880,7 @@ static long get_offset(unsigned long *si
 
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
-   sizes, and place the offsets into sh_link fields: high bit means it
+   sizes, and place the offsets into sh_entsize fields: high bit means it
    belongs in init. */
 static void layout_sections(struct module *mod,
 			    const Elf_Ehdr *hdr,
@@ -896,7 +896,7 @@ static void layout_sections(struct modul
 	unsigned int m, i;
 
 	for (i = 0; i < hdr->e_shnum; i++)
-		sechdrs[i].sh_link = ~0UL;
+		sechdrs[i].sh_entsize = ~0UL;
 
 	DEBUGP("Core section allocation order:\n");
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
@@ -905,10 +905,10 @@ static void layout_sections(struct modul
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
-			    || s->sh_link != ~0UL
+			    || s->sh_entsize != ~0UL
 			    || strstr(secstrings + s->sh_name, ".init"))
 				continue;
-			s->sh_link = get_offset(&mod->core_size, s);
+			s->sh_entsize = get_offset(&mod->core_size, s);
 			DEBUGP("\t%s\n", name);
 		}
 	}
@@ -920,11 +920,11 @@ static void layout_sections(struct modul
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
-			    || s->sh_link != ~0UL
+			    || s->sh_entsize != ~0UL
 			    || !strstr(secstrings + s->sh_name, ".init"))
 				continue;
-			s->sh_link = (get_offset(&mod->init_size, s)
-				      | INIT_OFFSET_MASK);
+			s->sh_entsize = (get_offset(&mod->init_size, s)
+					 | INIT_OFFSET_MASK);
 			DEBUGP("\t%s\n", name);
 		}
 	}
@@ -1066,7 +1066,7 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto free_mod;
 
-	/* Determine total sizes, and put offsets in sh_link.  For now
+	/* Determine total sizes, and put offsets in sh_entsize.  For now
 	   this is done generically; there doesn't appear to be any
 	   special cases for the architectures. */
 	layout_sections(mod, hdr, sechdrs, secstrings);
@@ -1095,11 +1095,11 @@ static struct module *load_module(void *
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
-		if (sechdrs[i].sh_link & INIT_OFFSET_MASK)
+		if (sechdrs[i].sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->module_init
-				+ (sechdrs[i].sh_link & ~INIT_OFFSET_MASK);
+				+ (sechdrs[i].sh_entsize & ~INIT_OFFSET_MASK);
 		else
-			dest = mod->module_core + sechdrs[i].sh_link;
+			dest = mod->module_core + sechdrs[i].sh_entsize;
 
 		if (sechdrs[i].sh_type != SHT_NOBITS)
 			memcpy(dest, (void *)sechdrs[i].sh_addr,
