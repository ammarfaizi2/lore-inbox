Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVGLMuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVGLMuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGLMuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:50:19 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:61091 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261391AbVGLMtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:49:35 -0400
X-ORBL: [69.107.32.110]
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.13-rc2-git] Documentation/DMA-API.txt
Date: Tue, 12 Jul 2005 05:49:32 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dx70CCgkvn+6IT3"
Message-Id: <200507120549.33048.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dx70CCgkvn+6IT3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Imagine my surprise when I noticed that the reason someone didn't
know about using the sg_dma_len() and sg_dma_address() with the
dma_map_sg() calls was that they weren't documented except as
part of the old PCI-specific pci_map_sg() API.  Bleech!

So, this patch fixes that little problem, mostly by cut/paste.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--Boundary-00=_dx70CCgkvn+6IT3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dma-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dma-doc.patch"

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -304,12 +304,12 @@ dma address with dma_mapping_error(). A 
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
 
@@ -327,12 +327,36 @@ critical that the driver do something, i
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
+into one (e.g. if DMA mapping is done with PAGE_SIZE granularity, any
+consecutive sglist entries can be merged into one provided the first one
+ends and the second one starts on a page boundary - in fact this is a huge
+advantage for cards which either cannot do scatter-gather or have very
+limited number of scatter-gather entries) and returns the actual number
+of sg entries it mapped them to. On failure 0 is returned.
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

--Boundary-00=_dx70CCgkvn+6IT3--
