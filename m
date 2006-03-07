Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWCGQGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWCGQGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWCGQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:06:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:42413 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751088AbWCGQGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:06:21 -0500
From: Andi Kleen <ak@suse.de>
To: Zou Nan hai <nanhai.zou@intel.com>
Subject: Re: [Patch] Move swiotlb_init early on X86_64
Date: Tue, 7 Mar 2006 09:39:02 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <1141175458.2642.78.camel@linux-znh>
In-Reply-To: <1141175458.2642.78.camel@linux-znh>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070939.03368.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 02:10, Zou Nan hai wrote:
> on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.
> 
> On platforms with huge physical memory, 
> large memmap and vfs cache may eat up all usable system memory 
> under 4G.
> 
> Move swiotlb_init early before memmap is allocated can
> solve this issue.
> 
> Signed-off-by: Zou Nan hai <Nanhai.zou@intel.com>


I came up with a simpler change now that should fix the problem too.
It just try to move the memmap to the end of the node. I don't have a system
big enough to test the original problem though.

It should be fairly safe because if the allocation fails we just fallback
to the normal old way of allocating it near the beginning.

Try to allocate node memmap near the end of node

This fixes problems with very large nodes (over 128GB) filling up all of 
the first 4GB with their mem_map and not leaving enough
space for the swiotlb.


Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/mm/numa.c   |   12 +++++++++++-
 include/linux/bootmem.h |    3 +++
 mm/bootmem.c            |    2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c
+++ linux/arch/x86_64/mm/numa.c
@@ -172,7 +172,7 @@ void __init setup_node_bootmem(int nodei
 /* Initialize final allocator for a zone */
 void __init setup_node_zones(int nodeid)
 { 
-	unsigned long start_pfn, end_pfn; 
+	unsigned long start_pfn, end_pfn, memmapsize, limit;
 	unsigned long zones[MAX_NR_ZONES];
 	unsigned long holes[MAX_NR_ZONES];
 
@@ -182,6 +182,16 @@ void __init setup_node_zones(int nodeid)
 	Dprintk(KERN_INFO "Setting up node %d %lx-%lx\n",
 		nodeid, start_pfn, end_pfn);
 
+	/* Try to allocate mem_map at end to not fill up precious <4GB
+	   memory. */
+	memmapsize = sizeof(struct page) * (end_pfn-start_pfn);
+	limit = end_pfn << PAGE_SHIFT;
+	NODE_DATA(nodeid)->node_mem_map = 
+		__alloc_bootmem_core(NODE_DATA(nodeid)->bdata, 
+				memmapsize, SMP_CACHE_BYTES, 
+				limit, 
+				round_down(limit - memmapsize, PAGE_SIZE));
+
 	size_zones(zones, holes, start_pfn, end_pfn);
 	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
 			    start_pfn, holes);
Index: linux/include/linux/bootmem.h
===================================================================
--- linux.orig/include/linux/bootmem.h
+++ linux/include/linux/bootmem.h
@@ -52,6 +52,9 @@ extern void * __init __alloc_bootmem_low
 					      unsigned long size,
 					      unsigned long align,
 					      unsigned long goal);
+extern void * __init __alloc_bootmem_core(struct bootmem_data *bdata,
+		unsigned long size, unsigned long align, unsigned long goal,
+		unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
Index: linux/mm/bootmem.c
===================================================================
--- linux.orig/mm/bootmem.c
+++ linux/mm/bootmem.c
@@ -152,7 +152,7 @@ static void __init free_bootmem_core(boo
  *
  * NOTE:  This function is _not_ reentrant.
  */
-static void * __init
+void * __init
 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
 	      unsigned long align, unsigned long goal, unsigned long limit)
 {


