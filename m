Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTL3Etl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTL3Etl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:49:41 -0500
Received: from dp.samba.org ([66.70.73.150]:25774 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264459AbTL3Et3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:49:29 -0500
Date: Tue, 30 Dec 2003 14:57:36 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, Nathan Poznick <kraken@drunkmonkey.org>
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha
 (2.6.0-test11)
Message-Id: <20031230145736.4ce0ff59.rusty@rustcorp.com.au>
In-Reply-To: <20031218010203.GA13385@twiddle.net>
References: <20031213003841.GA5213@wang-fu.org>
	<20031217121010.GA11062@twiddle.net>
	<20031217193124.GA4837@wang-fu.org>
	<20031218010203.GA13385@twiddle.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 17:02:03 -0800
Richard Henderson <rth@twiddle.net> wrote:

> On Wed, Dec 17, 2003 at 01:31:24PM -0600, Nathan Poznick wrote:
> > my next question is if this is a known/intended side effect -- enabling
> > CONFIG_DEBUG_INFO means that modules cannot be used?
> 
> No.  This means there's a bug in the generic bits of the module
> loaders, that they're not discarding debugging sections.

Ah, my bad.  We suck in the whole module, then copy SHF_ALLOC sections,
then apply relocations.  We don't skip relocations on sections which
haven't been copied.

This patch works for me: Nathan, does it solve your problem?
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Name: Don't Apply Relocations To Sections We Haven't Copied
Author: Rusty Russell
Status: Tested on 2.6.0-bk1

D: The module code applies every relocation section given.  Obviously, if
D: the section has not been copied into the module, there's no point.
D: In particular, Alpha has relocs which are only used on debug sections,
D: so they don't load with CONFIG_DEBUG_INFO enabled.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2481-linux-2.6.0-bk1/kernel/module.c .2481-linux-2.6.0-bk1.updated/kernel/module.c
--- .2481-linux-2.6.0-bk1/kernel/module.c	2003-11-24 15:42:33.000000000 +1100
+++ .2481-linux-2.6.0-bk1.updated/kernel/module.c	2003-12-30 14:08:40.000000000 +1100
@@ -1618,9 +1618,13 @@ static struct module *load_module(void _
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;
-		if (sechdrs[i].sh_type == SHT_REL)
-			err = apply_relocate(sechdrs, strtab, symindex, i,mod);
-		else if (sechdrs[i].sh_type == SHT_RELA)
+
+		/* Skip relocations on non-allocated (ie. debug) sections */
+		if (sechdrs[i].sh_type == SHT_REL
+		    && (sechdrs[sechdrs[i].sh_info].sh_flags & SHF_ALLOC))
+			err = apply_relocate(sechdrs, strtab, symindex,i, mod);
+		else if (sechdrs[i].sh_type == SHT_RELA
+			 && (sechdrs[sechdrs[i].sh_info].sh_flags & SHF_ALLOC))
 			err = apply_relocate_add(sechdrs, strtab, symindex, i,
 						 mod);
 		if (err < 0)
