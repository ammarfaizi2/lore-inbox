Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUDSQjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDSQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:39:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:38314 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261440AbUDSQjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:39:31 -0400
Date: Mon, 19 Apr 2004 18:39:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68k)
In-Reply-To: <20040419173046.E29446@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.58.0404191835140.3430@waterleaf.sonytel.be>
References: <20040418231720.C12222@flint.arm.linux.org.uk>
 <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk>
 <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>
 <20040419173046.E29446@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Russell King wrote:
> On Mon, Apr 19, 2004 at 06:18:41PM +0200, Geert Uytterhoeven wrote:
> > Do you really need <asm/pgalloc.h> in include/asm-generic/tlb.h?
>
> Yes it does - tlb.h uses check_pgt_cache().  Also, architecture code
> makes use of __pmd_free_tlb and __pte_free_tlb, both of which make
> use of code from asm/pgalloc.h.
>
> Not including asm/pgalloc.h into asm/tlb.h or asm-generic/tlb.h means
> that all the generic files have to know that asm/tlb.h needs asm/pgalloc.h,
> and they also then need to know that asm/pgalloc.h needs asm/pgtable.h,
> and asm/pgtable.h needs ...
>
> Is there a reason why:
>
> static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *page)
> {
>         tlb_remove_page(tlb, page);
> }
>
> can't be like x86 and others in their pgalloc.h:

(because we more like static inline functions than macros?)

> #define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
>
> (for consistency sake if nothing else) ?

Ah, I didn't look at ia32. That solution is fine for me!
Here's the additional patch:

--- linux-m68k-2.6.6-rc1-rmk/include/asm-m68k/sun3_pgalloc.h	2004-04-04 11:08:37.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/include/asm-m68k/sun3_pgalloc.h	2004-04-19 18:37:37.000000000 +0200
@@ -31,10 +31,7 @@
         __free_page(page);
 }

-static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *page)
-{
-	tlb_remove_page(tlb, page);
-}
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))

 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
