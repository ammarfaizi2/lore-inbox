Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWH1VSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWH1VSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWH1VSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:18:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50585 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751507AbWH1VSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:18:32 -0400
Date: Mon, 28 Aug 2006 23:18:16 +0200 (MEST)
Message-Id: <200608282118.k7SLIGFh008696@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, mikpe@it.uu.se
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 00:39:08 -0700 (PDT), David Miller wrote:
>Ok, I finally figured this one out and reproduced it on my
>ultra5.
>
>If, for example, we have a 4MB PTE and we do a write
>we'll only update one of the 8KB sub-PTEs of that
>mapping.
>
>This is fine until that new mapping gets displaced from
>the TLB and someone does a read that ends up hitting one
>of the sub-PTEs that didn't get it's write-enable bit
>set yet.
>
>At this point we have a problem, because if a write is
>made to the original address, the kernel says "the writable
>bit is set, nothing to do".  So it won't flush the TLB,
>and therefore it won't kick out the TLB mapping brought
>in by the read.
>
>So we just get wedged here until something displaces that
>TLB entry.  This is why X acts sluggish and since it can
>loop like this for quite a while the X server and the
>hardware can get plenty confused.
>
>The end result is that we have to make sure any PTE updates
>propagate to all sub-PTEs of a large mapping during any
>change.  That's really expensive and we'd have to add some
>complex code to the set_pte_at() code path just to handle
>this.
>
>So the easiest way to fix this, without having to disable
>largepage PTE mappings of I/O devices, is the patch below.
>I will push this to Linus for 2.6.18 and -stable so that
>2.6.17 gets it too.
>
>commit 6ad7d29d2edd8c3d632e71454f619f5c0c6c2703
>Author: David S. Miller <davem@sunset.davemloft.net>
>Date:   Mon Aug 28 00:33:03 2006 -0700
>
>    [SPARC64]: Fix X server hangs due to large pages.
>    
>    This problem was introduced by changeset
>    14778d9072e53d2171f66ffd9657daff41acfaed
>    
>    Unlike the hugetlb code paths, the normal fault code is not setup to
>    propagate PTE changes for large page sizes correctly like the ones we
>    make for I/O mappings in io_remap_pfn_range().
>    
>    It is absolutely necessary to update all sub-ptes of a largepage
>    mapping on a fault.  Adding special handling for this would add
>    considerably complexity to tlb_batch_add().  So let's just side-step
>    the issue and forcefully dirty any writable PTEs created by
>    io_remap_pfn_range().
>    
>    The only other real option would be to disable to large PTE code of
>    io_remap_pfn_range() and we really don't want to do that.
>    
>    Much thanks to Mikael Pettersson for tracking down this problem and
>    testing debug patches.
>    
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
>diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
>index 8cb0620..af9d81d 100644
>--- a/arch/sparc64/mm/generic.c
>+++ b/arch/sparc64/mm/generic.c
>@@ -69,6 +69,8 @@ static inline void io_remap_pte_range(st
> 		} else
> 			offset += PAGE_SIZE;
> 
>+		if (pte_write(entry))
>+			entry = pte_mkdirty(entry);
> 		do {
> 			BUG_ON(!pte_none(*pte));
> 			set_pte_at(mm, address, pte, entry);
> 

Thanks. X works fine on my U5 now with 2.6.18-rc5 + this patch.

/Mikael
