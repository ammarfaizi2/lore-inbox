Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUBJRdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUBJRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:30:28 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:28420 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266013AbUBJR1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:27:43 -0500
Date: Tue, 10 Feb 2004 18:31:40 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [Patch] dma_sync_to_device
Message-ID: <Pine.LNX.4.44.0402101815550.2349-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

last fall we agreed there is a dma call missing to sync streaming out dma 
mappings before giving the buffer back to the device. I've sent you a 
patch which you liked IIRC. However, I wasn't repeatedly polling you for 
actually inclusion due to the 2.6 stabilization period.

Anyway, I see now other related stuff (like dma_pool patches) getting in
so I'm wondering whether it might be the right moment now - right after 
2.6.3-final I'd suggest. So let me resend and ask for application. I've 
just retested with 2.6.3-rc2 and verified the old patch still applies 
cleanly and works as expected.

The patch does:
* provide generic dma_sync_to_device_{single|sg} api
* add i386 pci implementation
* related Documentation/DMA-mapping update

Thanks,
Martin

-----------------------

--- linux-2.6.0-test8/include/asm-i386/dma-mapping.h	Wed Oct  8 21:24:53 2003
+++ v2.6.0-test8-md/include/asm-i386/dma-mapping.h	Tue Oct 21 10:56:45 2003
@@ -92,6 +92,20 @@
 	flush_write_buffers();
 }
 
+static inline void
+dma_sync_to_device_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
+static inline void
+dma_sync_to_device_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		 enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
--- linux-2.6.0-test8/include/asm-generic/pci-dma-compat.h	Wed Oct  8 21:24:02 2003
+++ v2.6.0-test8-md/include/asm-generic/pci-dma-compat.h	Tue Oct 21 10:55:09 2003
@@ -84,4 +84,18 @@
 	dma_sync_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
 }
 
+static inline void
+pci_dma_sync_to_device_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		    size_t size, int direction)
+{
+	dma_sync_to_device_single(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_to_device_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nelems, int direction)
+{
+	dma_sync_to_device_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+}
+
 #endif
--- linux-2.6.0-test8/Documentation/DMA-mapping.txt	Wed Oct  8 21:24:06 2003
+++ v2.6.0-test8-md/Documentation/DMA-mapping.txt	Tue Oct 21 11:27:17 2003
@@ -543,8 +543,11 @@
 all bus addresses.
 
 If you need to use the same streaming DMA region multiple times and touch
-the data in between the DMA transfers, just map it with
-pci_map_{single,sg}, and after each DMA transfer call either:
+the data in between the DMA transfers, the buffer needs to be synced
+depending on the transfer direction.
+
+When reading from the device, just map it with pci_map_{single,sg},
+and after each DMA transfer call either:
 
 	pci_dma_sync_single(dev, dma_handle, size, direction);
 
@@ -553,6 +556,20 @@
 	pci_dma_sync_sg(dev, sglist, nents, direction);
 
 as appropriate.
+
+When writing to the mapped the buffer, prepare the data and
+then before giving the buffer to the hardware call either:
+
+	pci_dma_sync_to_device_single(dev, dma_handle, size, direction);
+
+or:
+
+	pci_dma_sync_to_device_sg(dev, sglist, nents, direction);
+
+as appropriate.
+
+For bidirectional mappings the corresponding calls are required before and
+after passing ownership between cpu and hardware.
 
 After the last DMA transfer call one of the DMA unmap routines
 pci_unmap_{single,sg}. If you don't touch the data from the first pci_map_*

