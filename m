Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271001AbRIBPH7>; Sun, 2 Sep 2001 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271628AbRIBPHu>; Sun, 2 Sep 2001 11:07:50 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:44963 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271001AbRIBPHl>; Sun, 2 Sep 2001 11:07:41 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 2 Sep 2001 08:08:00 -0700
Message-Id: <200109021508.IAA29875@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: pci_alloc_consistent for small allocations?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In looking at the ieee1394 OHCI driver, I noticed that it
appears to make 104 calls to pci_alloc_consistent for data structures
that are 16 or 64 bytes.  Currently, on x86, pci_alloc_consistent
allocates at least one full page per call, so it looks like the
ohci1394 driver allocates 416kB per controller as a result of these
data structures.

	It is easy enough to change the ohci driver to just
do a few pci_alloc_consistent calls, but, in grepping through the
kernel, I see that there are lots of calls to pci_alloc_consistent
calls requesting small amounts of memory.  So, I think it might reduce
kernel memory consumption to have pci_alloc_consistent do something
slightly smarter for allocations of less than a page.  Two pretty
simple approaches come to mind:

	1. If it is the case that a side effect of the slab memory allocator
is that allocations of less than a page (or a certain size) never cross
page boundaries, then the x86 version of pci_alloc_consistent can just
use kmalloc/kfree when the size is below a certain amount.  Could someone
tell me if this is the case?

	2. Assuming that is not the case, I have written, but not yet tested,
a change to pci_alloc_consistent for x86 where sub-page allocations can share
a single page.  The first four bytes of a shared page are used as a
reference counter.  This would be two bytes were it not for alignment
considerations.  This change can only aggregate small allocations when
they occur in succession.  I have attached the patch for illustration, but,
it could use some better variable naming and, I repeat, I have not tested
it at all yet.  In the middle of working on it, I thought of option #1 and
figured I should ask on linux-kernel before investing more time in this idea.


Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.4.10-pre3/arch/i386/kernel/pci-dma.c	Mon Feb 14 15:34:21 2000
+++ linux/arch/i386/kernel/pci-dma.c	Sun Sep  2 07:50:33 2001
@@ -13,15 +13,40 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
+static void *reg_partial;	/* = NULL */
+static void *dma_partial;	/* = NULL */
+
 void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 			   dma_addr_t *dma_handle)
 {
 	void *ret;
 	int gfp = GFP_ATOMIC;
+	void **partial;
+	int avail;
 
 	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
 		gfp |= GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
+
+	partial = (gfp & GFP_DMA) ? &dma_partial : &reg_partial;
+
+	/* if *partial is NULL or has been incremented to the beginning
+	   of a new page, avail will be zero, and *partial will not be
+	   used.  */
+	avail = (-((unsigned long)*partial)) & PAGE_MASK;
+
+	if (avail >= size) {
+		ret = *partial;
+		*(int*)(((unsigned long)*partial) & ~PAGE_MASK) += 1;
+		(*partial) += size;
+	} else {
+		ret = (void *)__get_free_pages(gfp, get_order(size));
+
+		if (ret != NULL && (avail + size + sizeof(int) < PAGE_SIZE)) {
+			*(int*)ret = 1;
+			ret += sizeof(int);
+			*partial = ret + size;
+		}
+	}
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
@@ -33,5 +58,9 @@
 void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
+	if (((unsigned long)vaddr & PAGE_MASK) != 0) {
+		if (--*(int*)(((unsigned long)vaddr) & ~PAGE_MASK) != 0)
+			return;	/* shared page */
+	}
 	free_pages((unsigned long)vaddr, get_order(size));
 }

