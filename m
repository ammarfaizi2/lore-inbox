Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSFEUOs>; Wed, 5 Jun 2002 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFEUOr>; Wed, 5 Jun 2002 16:14:47 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:63883 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S316204AbSFEUOp>;
	Wed, 5 Jun 2002 16:14:45 -0400
Date: Wed, 5 Jun 2002 13:12:31 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "linux-kernel@vger.kernel.org"@ayrnetworks.com
Cc: "linux-mips@oss.sgi.com"@ayrnetworks.com, davem@redhat.com
Subject: Deprecate pci_dma_sync_{single,sg}()?
Message-ID: <20020605131231.B10773@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While introducing the pci_dma_prep_{single,sg}() interface, it occured
to me that there are some subtle problems with the old interface and its
implementation on non-cache-coherent systems. For example, a PCI driver
might do the following on a buffer:

pci_map_single(..., FROM_DEVICE)
<perform DMA into buffer>
pci_dma_sync_single(..., FROM_DEVICE)
<read out of buffer>
<put buffer back on queue and give bus address back to device -
 no explicit call to "return" the buffer to the device>
<perform DMA again>
pci_unmap_single(..., FROM_DEVICE)

This happens in certain network drivers (tulip, pcnet32...) when
determining whether the packet is small enough to make a copy (and leave
the buffer on the RX ring).

In the current linux-mips implementation, this has some subtle problems:
pci_unmap_{single,sg}() is essentially a no-op. Thus, in the above
example, a driver would break (stale cachelines from a previous
pci_dma_sync_*/read would not be invalidated). One might argue that a
cache invalidate should happen in the pci_unmap_single(). But then the
other case (where a driver does a pci_map, DMAs, does a pci_unmap, and
sends it up the stack) would require an additional cache
flush/invalidate that is not needed at all. In fact, when using
pci_dma_sync_{single,sg}() on a non-cache-coherent system, a cache
flush/invalidate happens needlessly as the buffer had already been
flushed in pci_map_{single,sg}(). These extra flushes do have
significant performance hits, even if not noticeable through typical
light use.

As such, it seems that it makes sense to do cache flushes only in
pci_map_{single,sg}() and pci_dma_prep_{single,sg}() (see Message-ID:
<20020526000933.A8719@ayrnetworks.com>, [PATCH] DMA-mapping.txt) and
mandate that pci_dma_prep_{single,sg}() be called when returning a
"touched" buffer to the device for another DMA (between pci_map_* and
pci_unmap_*). The cache flush in pci_dma_sync_{single,sg}() would be
removed.

The problem with this is that it will break some existing drivers that
don't yet call pci_dma_prep_*() (e.g., tulip). Would it be possible to
keep (but deprecate) pci_dma_sync_*() and make a similar call
"pci_dma_release_{single,sg}()" which does the same thing as
pci_dma_sync_*() while omitting the cache flushes? Thus, the above
example would become:

pci_map_single(..., FROM_DEVICE)                   [cache invalidate]
<perform DMA into buffer>
pci_dma_release_single(..., FROM_DEVICE)           [no cache invalidate,
						    but might perform PCI
						    controller-specific
						    operations to allow
						    the CPU to view
						    DMAed data]
<read out of buffer>                               
pci_dma_prep_single(..., FROM_DEVICE)              [cache invalidate]
<put buffer back on queue and give bus address back to device>
<perform DMA again>
pci_unmap_single(..., FROM_DEVICE)                 [no need for cache
						    invalidate]

This interface allows for:

1) A clean abstraction of what (the device or the driver) "owns" the
   buffer and can touch it. pci_map_* and pci_dma_prep_* "give" the
   buffer to the device, pci_unmap_* and pci_dma_release_* "take"
   the buffer from the device. Adds an entry point into
   platform-specific code for each of these transitions.

2) More optimal behavior in non-cache-coherent I/O situations; a buffer
   is never needlessly flushed/invalidated in the cache when the buffer
   is "owned" by the device.

3) Ability to re-use a buffer for PCI_DMA_TODEVICE operations without
   having to unmap/map between DMA transfers. The usage of the calls are
   the same, regardless of DMA direction.

4) The old interface (using pci_dma_sync_*()) will still remain for the
   time being, allowing for gradual migration to the new interface.

Changes to Documentation/DMA-mapping.txt in vger are attached.

Thanks,
William

---
Index: Documentation/DMA-mapping.txt
===================================================================
RCS file: /vger/linux/Documentation/DMA-mapping.txt,v
retrieving revision 1.17.2.2
diff -u -r1.17.2.2 DMA-mapping.txt
--- Documentation/DMA-mapping.txt	5 Mar 2002 12:40:36 -0000	1.17.2.2
+++ Documentation/DMA-mapping.txt	5 Jun 2002 20:07:43 -0000
@@ -239,9 +239,9 @@
 
              in order to get correct behavior on all platforms.
 
-- Streaming DMA mappings which are usually mapped for one DMA transfer,
-  unmapped right after it (unless you use pci_dma_sync below) and for which
-  hardware can optimize for sequential accesses.
+- Streaming DMA mappings which are usually mapped for one DMA
+  transfer, unmapped right after it (unless you use pci_dma_release
+  below) and for which hardware can optimize for sequential accesses.
 
   This of "streaming" as "asynchronous" or "outside the coherency
   domain".
@@ -508,21 +508,46 @@
 the data in between the DMA transfers, just map it with
 pci_map_{single,sg}, and after each DMA transfer call either:
 
-	pci_dma_sync_single(dev, dma_handle, size, direction);
+	pci_dma_release_single(dev, dma_handle, size, direction);
 
 or:
 
-	pci_dma_sync_sg(dev, sglist, nents, direction);
+	pci_dma_release_sg(dev, sglist, nents, direction);
 
 as appropriate.
 
+Once you have touched the region (after having called pci_dma_release_*()),
+and need to give it back to the device for another DMA transfer, call:
+
+	pci_dma_prep_single(dev, dma_handle, size, direction);
+
+or:
+
+	pci_dma_prep_sg(dev, sglist, nents, direction);
+
+This will prepare the buffer for another DMA transfer and synchronize any
+CPU writes to it with the device's view if direction is set to
+PCI_DMA_TODEVICE or PCI_DMA_BIDIRECTIONAL.
+
+Note: Prior to the introduction of pci_dma_prep_*, drivers accessing a
+DMAed region after a pci_dma_sync_* (now obsolete) implicitly returned
+"ownership" of the region to the device without having to expressly call a
+routine to do so.  In these cases, data is only read from the buffer, and
+the CPU "view" of the region is synchronized again on the next call to
+pci_dma_sync_*. For repeated DMA transfers to a device, pci_dma_prep_*() is
+used to synchronize any changes in the region (made by the driver) with the
+device. New drivers should use pci_dma_release_* in place of pci_dma_sync_*
+and use pci_dma_prep_* when returning the buffer back to the device,
+regardless of the DMA direction. Eventually, all calls to pci_dma_sync_*
+will be eliminated.
+
 After the last DMA transfer call one of the DMA unmap routines
 pci_unmap_{single,sg}. If you don't touch the data from the first pci_map_*
-call till pci_unmap_*, then you don't have to call the pci_dma_sync_*
-routines at all.
+call till pci_unmap_*, then you don't have to call the pci_dma_release_* or
+pci_dma_prep_* routines at all.
 
 Here is pseudo code which shows a situation in which you would need
-to use the pci_dma_sync_*() interfaces.
+to use the pci_dma_release_*() and pci_dma_prep_*() interfaces.
 
 	my_card_setup_receive_buffer(struct my_card *cp, char *buffer, int len)
 	{
@@ -552,7 +577,7 @@
 			 * the DMA transfer with the CPU first
 			 * so that we see updated contents.
 			 */
-			pci_dma_sync_single(cp->pdev, cp->rx_dma, cp->rx_len,
+			pci_dma_release_single(cp->pdev, cp->rx_dma, cp->rx_len,
 					    PCI_DMA_FROMDEVICE);
 
 			/* Now it is safe to examine the buffer. */
@@ -563,7 +588,11 @@
 				pass_to_upper_layers(cp->rx_buf);
 				make_and_setup_new_rx_buf(cp);
 			} else {
-				/* Just give the buffer back to the card. */
+				/* Prepare the buffer for another DMA transfer,
+				 * then give the buffer back to the card.
+				 */
+				pci_dma_prep_single(cp->pdev, cp->rx_dma,
+				                    cp->rx_len, PCI_DMA_FROMDEVICE);
 				give_rx_buf_to_card(cp);
 			}
 		}
@@ -671,12 +700,20 @@
 
 When the DMA transfer is complete, invoke:
 
-	void pci_dac_dma_sync_single(struct pci_dev *pdev,
+	void pci_dac_dma_release_single(struct pci_dev *pdev,
 				     dma64_addr_t dma_addr,
 				     size_t len, int direction);
 
 This must be done before the CPU looks at the buffer again.
-This interface behaves identically to pci_dma_sync_{single,sg}().
+
+After calling pci_dac_dma_release_{single,sg}, and before returning the
+buffer to the device for another DMA operation, invoke:
+
+	void pci_dac_dma_prep_single(struct pci_dev *pdev, dma64_addr_t
+	                             dma_addr, size_t len, int direction);
+
+These two interfaces behave identically to pci_dma_release_{single,sg}()
+and pci_dma_prep_{single,sg}(), respectively.
 
 If you need to get back to the PAGE/OFFSET tuple from a dma64_addr_t
 the following interfaces are provided:
