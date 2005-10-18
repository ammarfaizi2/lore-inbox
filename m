Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbVJRXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbVJRXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVJRXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:22:08 -0400
Received: from serv01.siteground.net ([70.85.91.68]:52186 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751477AbVJRXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:22:07 -0400
Date: Tue, 18 Oct 2005 16:22:03 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018232203.GB4535@localhost.localdomain>
References: <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain> <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org> <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org> <20051018195423.GA6351@localhost.localdomain> <1129670907.17545.20.camel@lts1.fc.hp.com> <20051018215351.GA3982@localhost.localdomain> <1129673040.17545.32.camel@lts1.fc.hp.com> <1129675023.17545.41.camel@lts1.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129675023.17545.41.camel@lts1.fc.hp.com>
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

On Tue, Oct 18, 2005 at 04:37:03PM -0600, Alex Williamson wrote:
> On Tue, 2005-10-18 at 16:04 -0600, Alex Williamson wrote:
> 
>    Nope, it breaks with a current git-2.6.14.  Here's what my extra
> printk says:
> 
> Node 0: 0xe000074104e67200
> Node 1: 0xe000082080722000
> Node 2: 0xe000000101532000
> Placing software IO TLB between 0x74108e68000 - 0x7410ce68000
> 

Hope the following works.   Using __alloc_bootmem_node now with a hard coded
goal to avoid 16MB DMA zone.  It is ugly :( and hope it works this time
<fingers crossed>. 

--

Patch to ensure low32 mem allocation for x86_64 swiotlb

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-18 14:14:12.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-18 16:09:51.000000000 -0700
@@ -106,6 +106,8 @@
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+#define IS_LOWPAGES(paddr, size) ((paddr < 0xffffffff) && ((paddr+size) < 0xffffffff))
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the PCI DMA API.
@@ -114,17 +116,46 @@
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
+		/* Ugly, hate it.  To be gone post 2.6.14 */
+		io_tlb_start = __alloc_bootmem_node(NODE_DATA(node), 
+						    iotlbsz, PAGE_SIZE, 
+						    0x1000000);
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
