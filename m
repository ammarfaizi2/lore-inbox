Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271120AbRHOJj3>; Wed, 15 Aug 2001 05:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271119AbRHOJjV>; Wed, 15 Aug 2001 05:39:21 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:19723 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S271121AbRHOJjI>; Wed, 15 Aug 2001 05:39:08 -0400
Date: Wed, 15 Aug 2001 11:26:21 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010815112621.F545@suse.de>
In-Reply-To: <20010815095018.B545@suse.de> <20010815.021133.71088933.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <20010815.021133.71088933.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 09:50:18 +0200
>    
>    Dave, comments on that?
> 
> I think the new-style sg_list is slightly overkill, too much
> stuff.  You need much less, in fact, especially on x86.
> 
> Take include/linux/skbuff.h:skb_frag_struct, rename it to
> sg_list and add a dma_addr_t.  You should need nothing else.
> The bounce page, for example, is superfluous.

Ok, here's an updated version. Maybe modulo the struct scatterlist
changes, I'd like to see this included in 2.4.x soonish. Or at least the
interface we agree on -- it'll make my life easier at least. And finally
provide driver authors with something not quite as stupid as struct
scatterlist.

-- 
Jens Axboe


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=pci-dma-high-2

--- /opt/kernel/linux-2.4.9-pre4/include/asm-i386/pci.h	Wed Aug 15 09:19:05 2001
+++ linux/include/asm-i386/pci.h	Wed Aug 15 11:19:02 2001
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
@@ -102,8 +124,26 @@
 static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 			     int nents, int direction)
 {
+	int i;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
+
+	/*
+	 * temporary 2.4 hack
+	 */
+	for (i = 0; i < nents; i++ ) {
+		if (sg[i].address && sg[i].page)
+			BUG();
+		else if (!sg[i].address && !sg[i].page)
+			BUG();
+
+		if (sg[i].page)
+			sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+		else
+			sg[i].dma_address = virt_to_bus(sg[i].address);
+	}
+
 	return nents;
 }
 
@@ -119,6 +159,32 @@
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
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
  *
@@ -173,10 +239,9 @@
 /* These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
  * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
+ * returns.
  */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
+#define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 /* Return the index of the PCI controller for device. */
--- /opt/kernel/linux-2.4.9-pre4/include/asm-i386/scatterlist.h	Mon Dec 30 12:01:10 1996
+++ linux/include/asm-i386/scatterlist.h	Wed Aug 15 11:18:29 2001
@@ -1,12 +1,52 @@
 #ifndef _I386_SCATTERLIST_H
 #define _I386_SCATTERLIST_H
 
+/*
+ * temporary measure, include a page and offset.
+ */
 struct scatterlist {
-    char *  address;    /* Location data is to be transferred to */
+    struct page * page; /* Location for highmem page, if any */
+    char *  address;    /* Location data is to be transferred to, NULL for
+			 * highmem page */
     char * alt_address; /* Location of actual if address is a 
 			 * dma indirect buffer.  NULL otherwise */
+    dma_addr_t dma_address;
     unsigned int length;
+    unsigned int offset;/* for highmem, page offset */
 };
+
+/*
+ * new style scatter gather list -- move to this completely?
+ */
+struct sg_list {
+	/*
+	 * input
+	 */
+	struct page *page;
+	__u16 length;
+	__u16 offset;
+
+	/*
+	 * output -- mapped address. either directly mapped from ->page
+	 * above, or possibly a bounce address
+	 */
+	dma_addr_t dma_address;
+};
+
+extern inline void set_bh_sg(struct scatterlist *sg, struct buffer_head *bh)
+{
+	if (PageHighMem(bh->b_page)) {
+		sg->page = bh->b_page;
+		sg->offset = bh_offset(bh);
+		sg->address = NULL;
+	} else {
+		sg->page = NULL;
+		sg->offset = 0;
+		sg->address = bh->b_data;
+	}
+
+	sg->length = bh->b_size;
+}
 
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
--- /opt/kernel/linux-2.4.9-pre4/include/linux/pci.h	Fri Jul 20 21:52:38 2001
+++ linux/include/linux/pci.h	Wed Aug 15 11:19:10 2001
@@ -314,6 +314,8 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define PCI_MAX_DMA32		(0xffffffff)
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2

--C1iGAkRnbeBonpVg--
