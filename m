Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbVJRTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVJRTyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVJRTyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:54:32 -0400
Received: from serv01.siteground.net ([70.85.91.68]:46298 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751484AbVJRTyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:54:31 -0400
Date: Tue, 18 Oct 2005 12:54:23 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, alex.williamson@hp.com, y-goto@jp.fujitsu.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018195423.GA6351@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <20051017153020.GB7652@localhost.localdomain> <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain> <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org> <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 08:50:18AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Oct 2005, Linus Torvalds wrote:
> > 
> > I vote for this one, assuming everybody who can test is happy.
> 
> Of course, just after sending the patch I noticed that there was a new 
> version, even simpler. Can people test that one?
> 

This version should work for everyone.  It falls back to the old 2.6.13
behaviour when it does not find suitable memory from any of the nodes.

Yasunori-san, Alex, can you confirm.  (Please use stock 2.6.14)

Thanks,
Kiran

--

Patch to ensure low32 mem allocation for x86_64 swiotlb

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-17 22:48:25.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-18 12:44:17.000000000 -0700
@@ -106,6 +106,8 @@
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+#define IS_LOWPAGES(paddr, size) ((paddr < 0xffffffff) && ((paddr+size) < 0xffffffff))
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the PCI DMA API.
@@ -114,17 +116,43 @@
 swiotlb_init_with_default_size (size_t default_size)
 {
 	unsigned long i;
+	unsigned long iotlbsz;
+	int node;
 
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 	}
 
+	iotlbsz = io_tlb_nslabs * (1 << IO_TLB_SHIFT);	
+
 	/*
-	 * Get IO TLB memory from the low pages
+	 * Get IO TLB memory from the 0-4G range
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
-					       (1 << IO_TLB_SHIFT));
+	
+	for_each_online_node(node) {
+		io_tlb_start = alloc_bootmem_node(NODE_DATA(node), iotlbsz);
+		if (io_tlb_start) {
+			if (IS_LOWPAGES(virt_to_phys(io_tlb_start), iotlbsz))
+				break;
+			free_bootmem_node(NODE_DATA(node), 
+					  virt_to_phys(io_tlb_start), iotlbsz);
+			io_tlb_start = NULL;
+		}
+	}
+
+	/* 
+	 * FIXME: This should go away when the bootmem allocator is fixed to
+	 * guarantee lowmem32 allocations somehow, and the swiotlb mess is 
+	 * cleaned.  The alloc_bootmem_low_pages fall back is to ensure 
+         * boxes like amd64  which donot use swiotlb but still have 
+	 * swiotlb compiled in, falls back to the 2.6.13 behaviour instead
+	 * of panicking, when proper low32 pages are not available
+	 */
+	if (!io_tlb_start)
+		io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
+							(1 << IO_TLB_SHIFT));
+
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
