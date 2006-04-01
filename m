Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWDASn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDASn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWDASn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:43:26 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:39511 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932154AbWDASnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:43:25 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.16-git] dma doc updates
Date: Sat, 1 Apr 2006 10:21:52 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BTsLE1M7sAYTwtf"
Message-Id: <200604011021.53162.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BTsLE1M7sAYTwtf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This updates docs to clarify some points:

 - dma_*map_sg() usage, mostly cloning text from the pci-specific writeup

 - mention cpu (and pci bridge) write buffers as cases where having memory
   mapped as dma-coherent isn't sufficient for correctness;

 - mention cacheline coherence issues for systems with dma-unaware caches.

Please merge ...

--Boundary-00=_BTsLE1M7sAYTwtf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dma-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dma-doc.patch"

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

Index: g26/Documentation/DMA-API.txt
===================================================================
--- g26.orig/Documentation/DMA-API.txt	2006-03-31 22:24:55.000000000 -0800
+++ g26/Documentation/DMA-API.txt	2006-03-31 22:42:37.000000000 -0800
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
Index: g26/Documentation/DMA-mapping.txt
===================================================================
--- g26.orig/Documentation/DMA-mapping.txt	2006-03-31 22:35:29.000000000 -0800
+++ g26/Documentation/DMA-mapping.txt	2006-03-31 22:44:51.000000000 -0800
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
 

--Boundary-00=_BTsLE1M7sAYTwtf--
