Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVJRGNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVJRGNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVJRGNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:13:36 -0400
Received: from serv01.siteground.net ([70.85.91.68]:31667 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932408AbVJRGNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:13:35 -0400
Date: Mon, 17 Oct 2005 23:13:25 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018061325.GB3692@localhost.localdomain>
References: <20051018101604.6795.Y-GOTO@jp.fujitsu.com> <20051018032025.GA3692@localhost.localdomain> <20051018125342.6799.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018125342.6799.Y-GOTO@jp.fujitsu.com>
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

On Tue, Oct 18, 2005 at 01:28:20PM +0900, Yasunori Goto wrote:
> > > So, just "use NODE(0)" is not enough hack for our machine.
> > > If "use NODE(0)" is selected, kernel must sort pgdat link and
> > > node id by memory address. I think that hot add code will be a 
> > > bit messy instead.
> > 
> > Yasunori-san,
> > Does this patch work on your boxes instead? (For 2.6.14)
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=112959469914681&w=2
> 
> Not yet. But could you change this line at least?
> 
> +	
> +	for_each_node(node) {
> +		io_tlb_start = alloc_bootmem_node(NODE_DATA(node), iotlbsz);
> 
> for_each_node() loop walks around node_possible_map which includes
> "offlined" node. 
> Please use for_each_online_node() instead. Then, I'll check it. :-)

Since swiotlb is is allocated even before APs are brought up, I thought,
if the node containing lowmem32 was not the boot node, it would not be
online.   But on closer look, my assumption was wrong.  Here is the patch
which iterates through online nodes to allocate lowmem32 bootmem for
swiotlb.

--

Patch to ensure low32 mem allocation for x86_64 swiotlb 

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-17 13:27:35.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-17 16:00:44.000000000 -0700
@@ -106,6 +106,8 @@
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+#define IS_LOWPAGES(paddr, size) ((paddr < 0xffffffff) && ((paddr+size) < 0xffffffff))
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the PCI DMA API.
@@ -114,17 +116,32 @@
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
+	
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
