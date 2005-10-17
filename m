Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVJQUoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVJQUoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVJQUoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:44:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932266AbVJQUon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:44:43 -0400
Date: Mon, 17 Oct 2005 13:44:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: kiran@scalex86.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       tglx@linutronix.de, torvalds@osdl.org, shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-Id: <20051017134401.3b0d861d.akpm@osdl.org>
In-Reply-To: <200510171743.47926.ak@suse.de>
References: <20051017093654.GA7652@localhost.localdomain>
	<200510171153.56063.ak@suse.de>
	<20051017153020.GB7652@localhost.localdomain>
	<200510171743.47926.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Monday 17 October 2005 17:30, Ravikiran G Thirumalai wrote:
> 
> > Yes, I just saw Yasunori-san's patch.  Would that be merged for 2.6.14?
> 
> I think both are too risky at this point.
> 

Maybe.

There seem to be a lot of proposed solutions floating about and I fear that
different people will try to fix this in different ways.  Do we all agree
that this patch is the correct solution to this problem, or is something
more needed?



From: Yasunori Goto <y-goto@jp.fujitsu.com>

This is a patch to guarantee that alloc_bootmem_low() allocate DMA area.

Current alloc_bootmem_low() is just specify "goal=0".  And it is used for
__alloc_bootmem_core() to decide which address is better.  However, there
is no guarantee that __alloc_bootmem_core() allocate DMA area when goal=0
is specified.  Even if there is no DMA'ble area in searching node, it
allocates higher address than MAX_DMA_ADDRESS.

__alloc_bootmem_core() is called by order of for_each_pgdat() in
__alloc_bootmem().  So, if first node (node_id = 0) has DMA'ble area, no
trouble will occur.  However, our new Itanium2 server can change which node
has lower address.  And panic really occurred on it.  The message was
"bounce buffer is not DMA'ble" in swiothl_map_single().

To avoid this panic, following patch confirms allocated area, and retry if
it is not in DMA.  I tested this patch on my Tiger 4 and our new server.

Signed-off-by Yasunori Goto <y-goto@jp.fujitsu.com>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/bootmem.h |   16 ++++++++++++----
 mm/bootmem.c            |   43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 8 deletions(-)

diff -puN include/linux/bootmem.h~guarantee-dma-area-for-alloc_bootmem_low include/linux/bootmem.h
--- devel/include/linux/bootmem.h~guarantee-dma-area-for-alloc_bootmem_low	2005-10-11 00:34:32.000000000 -0700
+++ devel-akpm/include/linux/bootmem.h	2005-10-11 00:34:32.000000000 -0700
@@ -40,6 +40,14 @@ typedef struct bootmem_data {
 					 * up searching */
 } bootmem_data_t;
 
+static inline unsigned long max_dma_physaddr(void)
+{
+
+	if (MAX_DMA_ADDRESS == ~0UL)
+		return MAX_DMA_ADDRESS;
+	return __pa(MAX_DMA_ADDRESS);
+}
+
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
@@ -47,11 +55,11 @@ extern void * __init __alloc_bootmem (un
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
-	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem((x), SMP_CACHE_BYTES, max_dma_physaddr())
 #define alloc_bootmem_low(x) \
 	__alloc_bootmem((x), SMP_CACHE_BYTES, 0)
 #define alloc_bootmem_pages(x) \
-	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem((x), PAGE_SIZE, max_dma_physaddr())
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
@@ -64,9 +72,9 @@ extern unsigned long __init free_all_boo
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, max_dma_physaddr())
 #define alloc_bootmem_pages_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, max_dma_physaddr())
 #define alloc_bootmem_low_pages_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
diff -puN mm/bootmem.c~guarantee-dma-area-for-alloc_bootmem_low mm/bootmem.c
--- devel/mm/bootmem.c~guarantee-dma-area-for-alloc_bootmem_low	2005-10-11 00:34:32.000000000 -0700
+++ devel-akpm/mm/bootmem.c	2005-10-11 00:34:32.000000000 -0700
@@ -382,19 +382,54 @@ unsigned long __init free_all_bootmem (v
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
+static int __init is_dma_required(unsigned long goal)
+{
+	return goal < max_dma_physaddr() ? 1 : 0;
+}
+
+static int __init unmatch_dma_required(void *ptr, unsigned long goal)
+{
+
+	if(is_dma_required(goal) && (unsigned long)ptr >= MAX_DMA_ADDRESS)
+		return 1;
+
+	return 0;
+}
+
 void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
+	int retried = 0;
+
+retry:
+	for_each_pgdat(pgdat){
 
-	for_each_pgdat(pgdat)
-		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
-						align, goal)))
-			return(ptr);
+		ptr = __alloc_bootmem_core(pgdat->bdata, size,
+					   align, goal);
+		if (!ptr)
+			continue;
+
+		if (unmatch_dma_required(ptr, goal) && !retried){
+			/* DMA is required, but normal area is allocated.
+			   Other node might have DMA, should try it. */
+			free_bootmem_core(pgdat->bdata, virt_to_phys(ptr), size);
+			continue;
+		}
+
+		return ptr;
+	}
 
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
+	if (is_dma_required(goal) && !retried){
+		printk(KERN_WARNING "bootmem alloc DMA of %lu bytes failed, retry normal area!\n", size);
+		dump_stack();
+		retried++;
+		goto retry;
+	}
+
 	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
 	panic("Out of memory");
 	return NULL;
_

