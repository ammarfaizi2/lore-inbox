Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVI2Wm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVI2Wm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVI2Wm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:42:27 -0400
Received: from fmr24.intel.com ([143.183.121.16]:30131 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932311AbVI2Wm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:42:27 -0400
Date: Thu, 29 Sep 2005 15:42:02 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, Asit.K.Mallick@intel.com, gregkh@suse.de
Subject: Re: [patch 2.6.14-rc2 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050929224202.GA15263@agluck-lia64.sc.intel.com>
References: <12c511ca050926194784b63e5@mail.gmail.com> <09282005175047.10096@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09282005175047.10096@bilbo.tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 05:50:47PM -0400, John W. Linville wrote:
> This set does NOT include the PCI excision that Tony Luck started after the
> last round of discussion.

Here's my attempt at part 7of6 to complete the removal of references
to PCI.  This time I fixed all the comments and printk() messages.
I even checked that it compiles on x86_64/em64t.

There will be some small amount of fuzz in this patch as I started
applying from a base that included a patch from Alex Williamson.


Andi: earlier you had made positive noises about moving
swiotlb.c up to lib/ ... now we have a specific implementation
can you confirm that you are still OK with this.  If you are,
then I'll put this whole series into my test tree so it will
get into the next -mm release.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -17,17 +17,17 @@
  */
 
 #include <linux/cache.h>
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
 
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/dma.h>
+#include <asm/scatterlist.h>
 
 #include <linux/init.h>
 #include <linux/bootmem.h>
@@ -127,7 +127,7 @@ __setup("swiotlb=", setup_io_tlb_npages)
 
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
- * structures for the software IO TLB used to implement the PCI DMA API.
+ * structures for the software IO TLB used to implement the DMA API.
  */
 void
 swiotlb_init_with_default_size (size_t default_size)
@@ -502,24 +502,24 @@ swiotlb_full(struct device *dev, size_t 
 	/*
 	 * Ran out of IOMMU space for this operation. This is very bad.
 	 * Unfortunately the drivers cannot handle this operation properly.
-	 * unless they check for pci_dma_mapping_error (most don't)
+	 * unless they check for dma_mapping_error (most don't)
 	 * When the mapping is small enough return a static buffer to limit
 	 * the damage, or panic when the transfer is too big.
 	 */
-	printk(KERN_ERR "PCI-DMA: Out of SW-IOMMU space for %lu bytes at "
+	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %lu bytes at "
 	       "device %s\n", size, dev ? dev->bus_id : "?");
 
 	if (size > io_tlb_overflow && do_panic) {
-		if (dir == PCI_DMA_FROMDEVICE || dir == PCI_DMA_BIDIRECTIONAL)
-			panic("PCI-DMA: Memory would be corrupted\n");
-		if (dir == PCI_DMA_TODEVICE || dir == PCI_DMA_BIDIRECTIONAL)
-			panic("PCI-DMA: Random memory would be DMAed\n");
+		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+			panic("DMA: Memory would be corrupted\n");
+		if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+			panic("DMA: Random memory would be DMAed\n");
 	}
 }
 
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.  The
- * PCI address to use is returned.
+ * physical address to use is returned.
  *
  * Once the device is given the dma address, the device owns this memory until
  * either swiotlb_unmap_single or swiotlb_dma_sync_single is performed.
@@ -606,8 +606,8 @@ swiotlb_unmap_single(struct device *hwde
  * after a transfer.
  *
  * If you perform a swiotlb_map_single() but wish to interrogate the buffer
- * using the cpu, yet do not wish to teardown the PCI dma mapping, you must
- * call this function before doing so.  At the next point you give the PCI dma
+ * using the cpu, yet do not wish to teardown the dma mapping, you must
+ * call this function before doing so.  At the next point you give the dma
  * address back to the card, you must first perform a
  * swiotlb_dma_sync_for_device, and then the device again owns the buffer
  */
@@ -783,9 +783,9 @@ swiotlb_dma_mapping_error(dma_addr_t dma
 }
 
 /*
- * Return whether the given PCI device DMA address mask can be supported
+ * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
- * during PCI bus mastering, then you would pass 0x00ffffff as the mask to
+ * during bus mastering, then you would pass 0x00ffffff as the mask to
  * this function.
  */
 int
