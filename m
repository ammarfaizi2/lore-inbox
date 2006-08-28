Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWH1HjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWH1HjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWH1HjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:39:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26861
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932421AbWH1HjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:39:05 -0400
Date: Mon, 28 Aug 2006 00:39:08 -0700 (PDT)
Message-Id: <20060828.003908.68040612.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060731.224235.19784785.davem@davemloft.net>
References: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
	<20060731.224235.19784785.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I finally figured this one out and reproduced it on my
ultra5.

If, for example, we have a 4MB PTE and we do a write
we'll only update one of the 8KB sub-PTEs of that
mapping.

This is fine until that new mapping gets displaced from
the TLB and someone does a read that ends up hitting one
of the sub-PTEs that didn't get it's write-enable bit
set yet.

At this point we have a problem, because if a write is
made to the original address, the kernel says "the writable
bit is set, nothing to do".  So it won't flush the TLB,
and therefore it won't kick out the TLB mapping brought
in by the read.

So we just get wedged here until something displaces that
TLB entry.  This is why X acts sluggish and since it can
loop like this for quite a while the X server and the
hardware can get plenty confused.

The end result is that we have to make sure any PTE updates
propagate to all sub-PTEs of a large mapping during any
change.  That's really expensive and we'd have to add some
complex code to the set_pte_at() code path just to handle
this.

So the easiest way to fix this, without having to disable
largepage PTE mappings of I/O devices, is the patch below.
I will push this to Linus for 2.6.18 and -stable so that
2.6.17 gets it too.

commit 6ad7d29d2edd8c3d632e71454f619f5c0c6c2703
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Aug 28 00:33:03 2006 -0700

    [SPARC64]: Fix X server hangs due to large pages.
    
    This problem was introduced by changeset
    14778d9072e53d2171f66ffd9657daff41acfaed
    
    Unlike the hugetlb code paths, the normal fault code is not setup to
    propagate PTE changes for large page sizes correctly like the ones we
    make for I/O mappings in io_remap_pfn_range().
    
    It is absolutely necessary to update all sub-ptes of a largepage
    mapping on a fault.  Adding special handling for this would add
    considerably complexity to tlb_batch_add().  So let's just side-step
    the issue and forcefully dirty any writable PTEs created by
    io_remap_pfn_range().
    
    The only other real option would be to disable to large PTE code of
    io_remap_pfn_range() and we really don't want to do that.
    
    Much thanks to Mikael Pettersson for tracking down this problem and
    testing debug patches.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
index 8cb0620..af9d81d 100644
--- a/arch/sparc64/mm/generic.c
+++ b/arch/sparc64/mm/generic.c
@@ -69,6 +69,8 @@ static inline void io_remap_pte_range(st
 		} else
 			offset += PAGE_SIZE;
 
+		if (pte_write(entry))
+			entry = pte_mkdirty(entry);
 		do {
 			BUG_ON(!pte_none(*pte));
 			set_pte_at(mm, address, pte, entry);
