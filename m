Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269849AbRHDKpJ>; Sat, 4 Aug 2001 06:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269850AbRHDKpA>; Sat, 4 Aug 2001 06:45:00 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:18842 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S269849AbRHDKov>;
	Sat, 4 Aug 2001 06:44:51 -0400
Date: Sat, 4 Aug 2001 19:44:55 +0900 (JST)
Message-Id: <200108041044.f74Ait720405@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The interface of flush_cache_page
In-Reply-To: <15211.50386.927163.766367@pizda.ninka.net>
In-Reply-To: <200108040610.f746AlJ19336@mule.m17n.org>
	<15211.50386.927163.766367@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, 

Attached is a patch to move the call of flush_cache_page before
clearing PTE in vmscan.c:try_to_swap_out.

Here, we want to flush cache entries written from user space.
But for some archtecture, we need valid PTE to flush, so, we need to
call flush_cache_page before ptep_get_and_clear.

At least, we need this for SuperH (which has virtually indexed
physically tagged cache).

--- v2.4.8-pre4/mm/vmscan.c	Sat Aug  4 15:37:55 2001
+++ linux/mm/vmscan.c	Sat Aug  4 19:27:07 2001
@@ -65,6 +65,7 @@ static void try_to_swap_out(struct mm_st
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
+	flush_cache_page(vma, address);
 	pte = ptep_get_and_clear(page_table);
 	flush_tlb_page(vma, address);
 
@@ -102,7 +103,6 @@ drop_pte:
 	 * Basically, this just makes it possible for us to do
 	 * some real work in the future in "refill_inactive()".
 	 */
-	flush_cache_page(vma, address);
 	if (!pte_dirty(pte))
 		goto drop_pte;
 
--------
 
David S. Miller wrote:
 > NIIBE Yutaka writes:
 >  > When it is called from vmscan.c:try_to_swap_out, as the PTE is cleared
 >  > to be zero, we have no way to know what phisical address to match.
 > 
 > That is really an error, and it is only because the last time the
 > logic try_to_swap_out() logic got rearranges the cache flush got moved
 > lower down.
 > 
 > In fact, several architectures will take a fatal trap due to
 > this sequence.  On these systems the tlb must be able to translate the
 > virtual address given to it for the flush, and that translation must
 > be valid.
 > 
 > Thus, the code there should be:
 > 
 > 	flush_cache_page(vma, address);
 > 	pte = ptep_get_and_clear(page_table);
 > 	flush_tlb_page(vma, address);
 > 
 > And the flush_cache_page() further down in that function then can be
 > removed.
 > 
 > Feel free to send this fix to Linus.  It is probably causing
 > HyperSparc sparc32 to fail to work at all once a swap happens,
 > if platforms using that chip work at all.
-- 
