Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRHJHZU>; Fri, 10 Aug 2001 03:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRHJHZL>; Fri, 10 Aug 2001 03:25:11 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:33293 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S264244AbRHJHZG>;
	Fri, 10 Aug 2001 03:25:06 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: struct page to 36 (or 64) bit bus address?
Date: 10 Aug 2001 07:00:39 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9n71kn.28q.kraxel@bytesex.org>
In-Reply-To: <20010809151022.C1575@sventech.com> <E15UvLO-0007tH-00@the-village.bc.nu> <15218.61869.424038.30544@pizda.ninka.net> <20010809163531.D1575@sventech.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 997426839 2891 127.0.0.1 (10 Aug 2001 07:00:39 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note, if you use the "bttv method" (ie. virt_to_bus) your driver will
> > then fail to compile on several platforms.
>  
>  So noted. I already have a PCI DMA API version, but I wanted to code up
>  a "i have an i386 and gigs of memory" version as well.

Forgot about virt_to_bus() then, it doesn't work for highmem.

bttv devel versions (0.8.x -> http://bytesex.org/bttv/) use the pci dma
mapping interface.  It can handle DMA highmem pages too, but that
requires a patched kernel as the current 2.4.x simply has no interfaces
to do that.  I'm using the patch below (pulled out of Jens Axboe's bio
patches, i386 only).

  Gerd

---------------------------- cut here ------------------------
--- 2.4.7-pre6/include/asm-i386/page.h.high	Thu Jan  4 23:50:46 2001
+++ 2.4.7-pre6/include/asm-i386/page.h	Wed Jul 18 12:21:48 2001
@@ -116,6 +116,8 @@
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#define page_to_phys(page)	(((page) - mem_map) * PAGE_SIZE)
+#define page_to_bus(page)	page_to_phys((page))
 
 
 #endif /* __KERNEL__ */
--- 2.4.7-pre6/include/asm-i386/pci.h.high	Tue Jul 10 10:57:22 2001
+++ 2.4.7-pre6/include/asm-i386/pci.h	Wed Jul 18 12:22:28 2001
@@ -28,6 +28,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
@@ -84,6 +85,27 @@
 	/* Nothing to do */
 }
 
+/*
+ * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
+ * to pci_map_single, but takes a struct page instead of a virtual address
+ */
+extern inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
+				      size_t size, int offset, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	return (page - mem_map) * PAGE_SIZE + offset;
+}
+
+extern inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+				  size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -119,6 +141,33 @@
 	/* Nothing to do */
 }
 
+/*
+ * meant to replace the pci_map_sg api, new drivers should use this
+ * interface
+ */
+extern inline int pci_map_sgl(struct pci_dev *hwdev, struct sg_list *sg,
+			      int nents, int direction)
+{
+	int i;
+
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	for (i = 0; i < nents; i++)
+		sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+
+	return nents;
+}
+
+extern inline void pci_unmap_sgl(struct pci_dev *hwdev, struct sg_list *sg,
+				 int nents, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
+
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
  *
@@ -178,6 +227,9 @@
  */
 #define sg_dma_address(sg)	(virt_to_bus((sg)->address))
 #define sg_dma_len(sg)		((sg)->length)
+
+#define sgl_dma_address(sg)	((sg)->dma_address)
+#define sgl_dma_len(sg)		((sg)->length)
 
 /* Return the index of the PCI controller for device. */
 static inline int pci_controller_num(struct pci_dev *dev)
--- 2.4.7-pre6/include/asm-i386/scatterlist.h.high	Mon Dec 30 12:01:10 1996
+++ 2.4.7-pre6/include/asm-i386/scatterlist.h	Wed Jul 18 12:18:53 2001
@@ -8,6 +8,29 @@
     unsigned int length;
 };
 
+/*
+ * new style scatter gather list -- move to this completely?
+ */
+#define HAVE_SG_LIST 1
+struct sg_list {
+	/*
+	 * input
+	 */
+	struct page *page;	/* page to do I/O to */
+	unsigned int length;	/* length of I/O */
+	unsigned int offset;	/* offset into page */
+
+	/*
+	 * original page, if bounced
+	 */
+	struct page *bounce_page;
+
+	/*
+	 * output
+	 */
+	dma_addr_t dma_address;	/* mapped address */
+};
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif /* !(_I386_SCATTERLIST_H) */
