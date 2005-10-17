Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVJQJhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVJQJhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVJQJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:37:10 -0400
Received: from serv01.siteground.net ([70.85.91.68]:63710 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932228AbVJQJhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:37:09 -0400
Date: Mon, 17 Oct 2005 02:36:54 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Linus Torvalds <torvalds@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017093654.GA7652@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 NUMA boxes, the revert
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6e3254c4e2927c117044a02acf5f5b56e1373053
meant that swiotlb gets the IOTLB
memory from pages over 4G (if mem > 4G), which basically renders swiotlb useless, causing
breakage with devices not capable of DMA beyond 4G.  2.6.13 was (kinda) not
broken, although the patch titled "Reverse order of bootmem lists" was
not in 2.6.13, The reason is commit
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6142891a0c0209c91aa4a98f725de0d6e2ed4918
was not in 2.6.13, PCI_DMA_BUS_IS_PHYS was 1 when no mmu was present, and the block layer did 
the bouncing, never using swiotlb.  I guess the right fix is to make sure
swiotlb gets the right memory.  Here is a patch doing that.  Tested on IBM
x460.  I hope the patch is ok for ia64s too.  I do not have access to ia64
boxen.

Thanks,
Kiran

Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
 
Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-14 00:06:21.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-17 00:05:22.000000000 -0700
@@ -123,7 +123,7 @@
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
+	io_tlb_start = alloc_bootmem_node(NODE_DATA(0), io_tlb_nslabs *
 					       (1 << IO_TLB_SHIFT));
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
