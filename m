Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVIESmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVIESmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIESmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:42:40 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:58060 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932397AbVIESmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:42:39 -0400
Date: Mon, 5 Sep 2005 14:42:36 -0400 (EDT)
From: Chaskiel Grundman <cg2v@andrew.cmu.edu>
X-X-Sender: cg2v@endicott.pit.dementia.org
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: (alpha) process_reloc_for_got confuses r_offset and r_addend
In-Reply-To: <9a874849050905113369bae774@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0509051439040.10147@endicott.pit.dementia.org>
References: <Pine.LNX.4.63.0509051334440.8784@localhost>
 <9a874849050905113369bae774@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, Jesper Juhl wrote:
> Why not post the patch you made for review as well?

In part because if the analysis is wrong, then the patch surely is.

but mostly because I didn't want to post my message with the bland subject 
that the faq recommends for patches.

--- linux-2.6.12.5/arch/alpha/kernel/module.c      2005-08-14 20:20:18.000000000 -0400
+++ linux/arch/alpha/kernel/module.c   2005-09-05 12:38:43.000000000 -0400
@@ -47,7 +47,7 @@

  struct got_entry {
         struct got_entry *next;
-       Elf64_Addr r_offset;
+       Elf64_Sxword r_addend;
         int got_offset;
  };

@@ -57,14 +57,14 @@
  {
         unsigned long r_sym = ELF64_R_SYM (rela->r_info);
         unsigned long r_type = ELF64_R_TYPE (rela->r_info);
-       Elf64_Addr r_offset = rela->r_offset;
+       Elf64_Sxword r_addend = rela->r_addend;
         struct got_entry *g;

         if (r_type != R_ALPHA_LITERAL)
                 return;

         for (g = chains + r_sym; g ; g = g->next)
-               if (g->r_offset == r_offset) {
+               if (g->r_addend == r_addend) {
                         if (g->got_offset == 0) {
                                 g->got_offset = *poffset;
                                 *poffset += 8;
@@ -74,7 +74,7 @@

         g = kmalloc (sizeof (*g), GFP_KERNEL);
         g->next = chains[r_sym].next;
-       g->r_offset = r_offset;
+       g->r_addend = r_addend;
         g->got_offset = *poffset;
         *poffset += 8;
         chains[r_sym].next = g;
