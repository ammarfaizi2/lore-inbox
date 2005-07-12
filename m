Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVGLNnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGLNnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVGLNmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:42:04 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:31558 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261438AbVGLNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:41:56 -0400
Date: Tue, 12 Jul 2005 15:41:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Carsten Otte <cotte@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: mm/filemap_xip.c compilation failure
Message-ID: <Pine.LNX.4.62.0507121418001.11361@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Carsten,

While cross-compiling a kernel for m68k, I stumbled across this
compilation error:

| mm/filemap_xip.c: In function `__xip_unmap':
| mm/filemap_xip.c:194: request for member `pte' in something not a structure or union

Apparently pte_pfn() takes a pte_t, not a pointer to a pte_t. From
looking at asm/page.h, it seems to be the same on ia32 or ppc (iff
STRICT_MM_TYPECHECKS is enabled, which is disabled by default on ppc).

Disclaimer: the patch below is untested, except for a compile test.

--- linux-2.6.13-rc2/mm/filemap_xip.c.orig	2005-06-29 22:15:45.000000000 +0200
+++ linux-2.6.13-rc2/mm/filemap_xip.c	2005-07-12 15:36:11.000000000 +0200
@@ -191,7 +191,7 @@ __xip_unmap (struct address_space * mapp
 					 address);
 		if (!IS_ERR(pte)) {
 			/* Nuke the page table entry. */
-			flush_cache_page(vma, address, pte_pfn(pte));
+			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap(pte);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
