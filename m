Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWDCWr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWDCWr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWDCWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:47:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:33517 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964888AbWDCWr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:47:28 -0400
Subject: patch dma-doc-updates.patch added to gregkh-2.6 tree
To: david-b@pacbell.net, dbrownell@users.sourceforge.net, greg@kroah.com,
       gregkh@suse.de, linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Mon, 03 Apr 2006 15:45:29 -0700
In-Reply-To: <200604011021.53162.david-b@pacbell.net>
Message-ID: <1FQXnd-8QP-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: dma doc updates

to my gregkh-2.6 tree.  Its filename is

     dma-doc-updates.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From david-b@pacbell.net Sat Apr  1 10:43:27 2006
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: dma doc updates
Date: Sat, 1 Apr 2006 10:21:52 -0800
Cc: Greg KH <greg@kroah.com>
Message-Id: <200604011021.53162.david-b@pacbell.net>

This updates the DMA API documentation to address a few issues:

 - The dma_map_sg() call results are used like pci_map_sg() results:
   using sg_dma_address() and sg_dma_len().  That's not wholly obvious
   to folk reading _only_ the "new" DMA-API.txt writeup.

 - Buffers allocated by dma_alloc_coherent() may not be completely
   free of coherency concerns ... some CPUs also have write buffers
   that may need to be flushed.

 - Cacheline coherence issues are now mentioned as being among issues
   which affect dma buffers, and complicate/prevent using of static and
   (especially) stack based buffers with the DMA calls.

I don't think many drivers currently need to worry about flushing write
buffers, but I did hit it with one SOC using external SDRAM for DMA
descriptors:  without explicit writebuffer flushing, the on-chip DMA
controller accessed descriptors before the CPU completed the writes.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/DMA-API.txt     |   49 ++++++++++++++++++++++++++++++------------
 Documentation/DMA-mapping.txt |   22 ++++++++++++++----
 2 files changed, 53 insertions(+), 18 deletions(-)

--- gregkh-2.6.orig/Documentation/DMA-API.txt
+++ gregkh-2.6/Documentation/DMA-API.txt
@@ -33,7 +33,9 @@ pci_alloc_consistent(struct pci_dev *dev
 
 Consistent memory is memory for which a write by either the device or
 the processor can immediately be read by the processor or device
-without having to worry about caching effects.
+without having to worry about caching effects.  (You may however need
+to make sure to flush the processor's write buffers before telling
+devices to read that memory.)
 
 This routine allocates a region of <size> bytes of consistent memory.
 it also returns a <dma_handle> which may be cast to an unsigned
@@ -304,12 +306,12 @@ dma address with dma_mapping_error(). A 
 could not be created and the driver should take appropriate action (eg
 reduce current DMA mapping usage or delay and try again later).
 
-int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
-int
-pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-	   int nents, int direction)
+	int
+	dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+	int
+	pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nents, int direction)
 
 Maps a scatter gather list from the block layer.
 
@@ -327,12 +329,33 @@ critical that the driver do something, i
 aborting the request or even oopsing is better than doing nothing and
 corrupting the filesystem.
 
-void
-dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
-void
-pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-	     int nents, int direction)
+With scatterlists, you use the resulting mapping like this:
+
+	int i, count = dma_map_sg(dev, sglist, nents, direction);
+	struct scatterlist *sg;
+
+	for (i = 0, sg = sglist; i < count; i++, sg++) {
+		hw_address[i] = sg_dma_address(sg);
+		hw_len[i] = sg_dma_len(sg);
+	}
+
+where nents is the number of entries in the sglist.
+
+The implementation is free to merge several consecutive sglist entries
+into one (e.g. with an IOMMU, or if several pages just happen to be
+physically contiguous) and returns the actual number of sg entries it
+mapped them to. On failure 0, is returned.
+
+Then you should loop count times (note: this can be less than nents times)
+and use sg_dma_address() and sg_dma_len() macros where you previously
+accessed sg->address and sg->length as shown above.
+
+	void
+	dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nhwentries, enum dma_data_direction direction)
+	void
+	pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nents, int direction)
 
 unmap the previously mapped scatter/gather list.  All the parameters
 must be the same as those and passed in to the scatter/gather mapping
--- gregkh-2.6.orig/Documentation/DMA-mapping.txt
+++ gregkh-2.6/Documentation/DMA-mapping.txt
@@ -58,11 +58,15 @@ translating each of those pages back to 
 something like __va().  [ EDIT: Update this when we integrate
 Gerd Knorr's generic code which does this. ]
 
-This rule also means that you may not use kernel image addresses
-(ie. items in the kernel's data/text/bss segment, or your driver's)
-nor may you use kernel stack addresses for DMA.  Both of these items
-might be mapped somewhere entirely different than the rest of physical
-memory.
+This rule also means that you may use neither kernel image addresses
+(items in data/text/bss segments), nor module image addresses, nor
+stack addresses for DMA.  These could all be mapped somewhere entirely
+different than the rest of physical memory.  Even if those classes of
+memory could physically work with DMA, you'd need to ensure the I/O
+buffers were cacheline-aligned.  Without that, you'd see cacheline
+sharing problems (data corruption) on CPUs with DMA-incoherent caches.
+(The CPU could write to one word, DMA would write to a different one
+in the same cache line, and one of them could be overwritten.)
 
 Also, this means that you cannot take the return of a kmap()
 call and DMA to/from that.  This is similar to vmalloc().
@@ -284,6 +288,11 @@ There are two types of DMA mappings:
 
              in order to get correct behavior on all platforms.
 
+	     Also, on some platforms your driver may need to flush CPU write
+	     buffers in much the same way as it needs to flush write buffers
+	     found in PCI bridges (such as by reading a register's value
+	     after writing it).
+
 - Streaming DMA mappings which are usually mapped for one DMA transfer,
   unmapped right after it (unless you use pci_dma_sync_* below) and for which
   hardware can optimize for sequential accesses.
@@ -303,6 +312,9 @@ There are two types of DMA mappings:
 
 Neither type of DMA mapping has alignment restrictions that come
 from PCI, although some devices may have such restrictions.
+Also, systems with caches that aren't DMA-coherent will work better
+when the underlying buffers don't share cache lines with other data.
+
 
 		 Using Consistent DMA mappings.
 


Patches currently in gregkh-2.6 which might be from david-b@pacbell.net are

driver/spi-add-pxa2xx-ssp-spi-driver.patch
driver/spi-per-transfer-overrides-for-wordsize-and-clocking.patch
pci/dma-doc-updates.patch
