Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSEZHLI>; Sun, 26 May 2002 03:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSEZHLH>; Sun, 26 May 2002 03:11:07 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:49800 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S315754AbSEZHLG>;
	Sun, 26 May 2002 03:11:06 -0400
Date: Sun, 26 May 2002 00:09:33 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DMA-mapping.txt (was Re: [PATCH] Functions to complement pci_dma_sync_{single,sg}().)
Message-ID: <20020526000933.A8719@ayrnetworks.com>
In-Reply-To: <20020524104345.J7205@ayrnetworks.com> <20020524.104209.31440798.davem@redhat.com> <20020524204130.A17401@ayrnetworks.com> <20020525.160458.74166421.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 04:04:58PM -0700, David S. Miller wrote:
> 
> Where are the documentation updates?  That is the most important part
> of the patch.

Indeed. My apologies.

William

---
Index: Documentation/DMA-mapping.txt
===================================================================
RCS file: /vger/linux/Documentation/DMA-mapping.txt,v
retrieving revision 1.17.2.2
diff -u -r1.17.2.2 DMA-mapping.txt
--- Documentation/DMA-mapping.txt	5 Mar 2002 12:40:36 -0000	1.17.2.2
+++ Documentation/DMA-mapping.txt	26 May 2002 07:12:25 -0000
@@ -516,13 +516,35 @@
 
 as appropriate.
 
+Once you have touched the region (after having called pci_dma_sync_*()),
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
+Note: Prior to the introduction of pci_dma_prep_*, drivers transferring
+data from a device after a pci_dma_sync_* implicitly returned "ownership"
+of the region to the device without having to expressly call a routine to
+do so.  In these cases, data is only read from the buffer, and the CPU
+"view" of the region is synchronized again on the next call to
+pci_dma_sync_*.  However, for drivers which may need to make repeated DMA
+transfers to a device from a given region, this call is necessary to make
+any data written by the CPU visible to the device.
+
 After the last DMA transfer call one of the DMA unmap routines
 pci_unmap_{single,sg}. If you don't touch the data from the first pci_map_*
-call till pci_unmap_*, then you don't have to call the pci_dma_sync_*
-routines at all.
+call till pci_unmap_*, then you don't have to call the pci_dma_sync_* or
+pci_dma_prep_* routines at all.
 
 Here is pseudo code which shows a situation in which you would need
-to use the pci_dma_sync_*() interfaces.
+to use the pci_dma_sync_*() and pci_dma_prep_*() interfaces.
 
 	my_card_setup_receive_buffer(struct my_card *cp, char *buffer, int len)
 	{
@@ -563,7 +585,11 @@
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
@@ -676,7 +702,15 @@
 				     size_t len, int direction);
 
 This must be done before the CPU looks at the buffer again.
-This interface behaves identically to pci_dma_sync_{single,sg}().
+
+After calling pci_dac_dma_sync_{single,sg}, and before returning the buffer
+to the device for another DMA operation, invoke:
+
+	void pci_dac_dma_prep_single(struct pci_dev *pdev, dma64_addr_t
+	                             dma_addr, size_t len, int direction);
+
+These two interfaces behave identically to pci_dma_sync_{single,sg}() and
+pci_dma_prep_{single,sg}(), respectively.
 
 If you need to get back to the PAGE/OFFSET tuple from a dma64_addr_t
 the following interfaces are provided:
