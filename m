Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266610AbUF3J54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUF3J54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUF3J54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:57:56 -0400
Received: from everest.2mbit.com ([24.123.221.2]:5285 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266610AbUF3J4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:56:31 -0400
Message-ID: <40E28E42.3030408@greatcn.org>
Date: Wed, 30 Jun 2004 17:56:18 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <40E03F71.8010902@greatcn.org> <20040628175325.B9214@flint.arm.linux.org.uk> <40E148EE.1090207@greatcn.org> <20040629115830.A24951@flint.arm.linux.org.uk>
In-Reply-To: <20040629115830.A24951@flint.arm.linux.org.uk>
X-Scan-Signature: ae3a71d84f7ecfd023b4d21030ba9300
X-SA-Exim-Connect-IP: 218.24.174.116
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [BUG FIX] [ARM/ARM26] find_memend_and_nodes bug fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.174.116 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Tue, Jun 29, 2004 at 06:48:14PM +0800, Coywolf Qi Hunt wrote:
>  
>
>>Russell King wrote:
>>Actually there's physical DRAM offset: PHY_OFFSET, defined on ARM only. 
>>max_low_pfn happens to be the same as `num_lowpages'.
>>These assignments seems illogical in naming. But just happen to let this 
>>patch work.  Other platforms may still break.
>>    
>>
>
>That may be a bug actually.  Looking at ll_rw_blk.c:
>
>        unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
>        if (bounce_pfn < blk_max_low_pfn) {
>
>        blk_max_low_pfn = max_low_pfn;
>
>dma_addr are physical addresses, so bounce_pfn is referenced to a PFN0
>equal to physical address 0.  This implies that blk_max_low_pfn is
>likewise, as is max_low_pfn.
>
>  
>
>>[coywolf@everest ~/linux-2.6.7/arch]$ grep max_low_pfn arm* -rn
>>arm/mm/init.c:235:      max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
>>    
>>
>
>However, here, max_low_pfn of zero corresponds with the PFN of
>PHYS_OFFSET.  We have something with two different origins being
>compared, which is nonsense.  So something is wrong somewhere,
>and my money is on max_low_pfn.
>
>  
>
The bug may get into panic when there's still enough memory for block i/o.
Here's the patch with also a BUG_ON improvement.


=======================================================================

diff -Nrup linux-2.6.7/arch/arm/mm/init.c linux-2.6.7-cy2/arch/arm/mm/init.c
--- linux-2.6.7/arch/arm/mm/init.c	2004-06-29 23:03:30.000000000 -0500
+++ linux-2.6.7-cy2/arch/arm/mm/init.c	2004-06-30 04:32:42.215999091 -0500
@@ -231,9 +231,10 @@ find_memend_and_nodes(struct meminfo *mi
 	 * This doesn't seem to be used by the Linux memory
 	 * manager any more.  If we can get rid of it, we
 	 * also get rid of some of the stuff above as well.
+	 *
+	 * blk_max_low_pfn depends on this. -- coywolf
 	 */
-	max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
-	max_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
+	max_low_pfn = max_pfn = memend_pfn;
 
 	return bootmem_pages;
 }
diff -Nrup linux-2.6.7/arch/arm26/mm/init.c linux-2.6.7-cy2/arch/arm26/mm/init.c
--- linux-2.6.7/arch/arm26/mm/init.c	2004-05-09 21:33:20.000000000 -0500
+++ linux-2.6.7-cy2/arch/arm26/mm/init.c	2004-06-30 03:59:51.000000000 -0500
@@ -160,9 +160,7 @@ find_memend_and_nodes(struct meminfo *mi
 
 	np->bootmap_pages = 0;
 
-	if (mi->bank->size == 0) {
-		BUG();
-	}
+	BUG_ON(mi->bank->size == 0)
 
 	/*
 	 * Get the start and end pfns for this bank
@@ -183,9 +181,10 @@ find_memend_and_nodes(struct meminfo *mi
 	 * This doesn't seem to be used by the Linux memory
 	 * manager any more.  If we can get rid of it, we
 	 * also get rid of some of the stuff above as well.
+	 *
+	 * blk_max_low_pfn depends on this. -- coywolf
 	 */
-	max_low_pfn = memend_pfn - PFN_DOWN(PHYS_OFFSET);
-	max_pfn = memend_pfn - PFN_DOWN(PHYS_OFFSET);
+	max_low_pfn = max_pfn = memend_pfn;
 	mi->end = memend_pfn << PAGE_SHIFT;
 
 }

-- 

Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

