Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUDSQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUDSQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:30:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12305 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261422AbUDSQau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:30:50 -0400
Date: Mon, 19 Apr 2004 17:30:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68k)
Message-ID: <20040419173046.E29446@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk> <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>; from geert@linux-m68k.org on Mon, Apr 19, 2004 at 06:18:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:18:41PM +0200, Geert Uytterhoeven wrote:
> The patch below fixes all compile-issues on m68k, except when compiling for
> Sun-3.
> 
> include/asm-generic/tlb.h now includes <asm/pgalloc.h>, which includes
> <asm/sun3_pgalloc.h>. But the last file needs tlb_remove_page(), which is
> defined in include/asm-generic/tlb.h

Nice.

> Do you really need <asm/pgalloc.h> in include/asm-generic/tlb.h?

Yes it does - tlb.h uses check_pgt_cache().  Also, architecture code
makes use of __pmd_free_tlb and __pte_free_tlb, both of which make
use of code from asm/pgalloc.h.

Not including asm/pgalloc.h into asm/tlb.h or asm-generic/tlb.h means
that all the generic files have to know that asm/tlb.h needs asm/pgalloc.h,
and they also then need to know that asm/pgalloc.h needs asm/pgtable.h,
and asm/pgtable.h needs ...

Is there a reason why:

static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *page)
{
        tlb_remove_page(tlb, page);
}

can't be like x86 and others in their pgalloc.h:

#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))

(for consistency sake if nothing else) ?

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
