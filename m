Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRHOKWh>; Wed, 15 Aug 2001 06:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271131AbRHOKWQ>; Wed, 15 Aug 2001 06:22:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24192 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271129AbRHOKWN>;
	Wed, 15 Aug 2001 06:22:13 -0400
Date: Wed, 15 Aug 2001 03:22:18 -0700 (PDT)
Message-Id: <20010815.032218.55508716.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815112621.F545@suse.de>
In-Reply-To: <20010815095018.B545@suse.de>
	<20010815.021133.71088933.davem@redhat.com>
	<20010815112621.F545@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 15 Aug 2001 11:26:21 +0200
   
   Ok, here's an updated version. Maybe modulo the struct scatterlist
   changes, I'd like to see this included in 2.4.x soonish. Or at least the
   interface we agree on -- it'll make my life easier at least. And finally
   provide driver authors with something not quite as stupid as struct
   scatterlist.

Jens, have a look at the patch I have below.  What do you
think about it?  Specifically the set of interfaces.

Andrea, I am very much interested in your input as well.

I would like to kill two birds with one stone here if
we can.   The x86 versions of the asm/pci.h and
asm/scatterlist.h bits are pretty mindless and left as
an exercise to the reader :-)

--- drivers/pci/pci.c.~1~	Mon Aug 13 22:05:39 2001
+++ drivers/pci/pci.c	Wed Aug 15 02:55:37 2001
@@ -832,7 +832,7 @@
 }
 
 int
-pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
+pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
     if(! pci_dma_supported(dev, mask))
         return -EIO;
@@ -842,6 +842,12 @@
     return 0;
 }
     
+void
+pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off)
+{
+	dev->dma_flags |= on;
+	dev->dma_flags &= ~off;
+}
 
 /*
  * Translate the low bits of the PCI base
--- include/asm-sparc64/pci.h.~1~	Tue Aug 14 21:31:07 2001
+++ include/asm-sparc64/pci.h	Wed Aug 15 03:18:33 2001
@@ -28,6 +28,13 @@
 /* Dynamic DMA mapping stuff.
  */
 
+/* PCI 64-bit addressing works for all slots on all controller
+ * types on sparc64.  However, it requires that the device
+ * can drive enough of the 64 bits.
+ */
+#define pci_dac_cycles_ok(pci_dev) \
+	(((pci_dev)->dma_mask & PCI64_ADDR_BASE) == PCI64_ADDR_BASE)
+
 #include <asm/scatterlist.h>
 
 struct pci_dev;
@@ -64,6 +71,20 @@
  */
 extern void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr, size_t size, int direction);
 
+/* No highmem on sparc64, plus we have an IOMMU, so mapping pages is easy. */
+#define pci_map_page(dev, page, off, size, dir) \
+	pci_map_single(dev, (page_address(page) + (off)), size, dir)
+#define pci_unmap_page(dev,addr,sz,dir) pci_unmap_single(dev,addr,sz,dir)
+
+/* The 64-bit cases might have to do something interesting if
+ * PCI_DMA_FLAG_HUGE_MAPS is set in hwdev->dma_flags.
+ */
+extern dma64_addr_t pci64_map_page(struct pci_dev *hwdev,
+				   struct page *page, unsigned long offset,
+				   size_t size, int direction);
+extern void pci64_unmap_page(struct pci_dev *hwdev, dma64_addr_t dma_addr,
+			     size_t size, int direction);
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -79,13 +100,19 @@
  * Device ownership issues as mentioned above for pci_map_single are
  * the same here.
  */
-extern int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nents, int direction);
+extern int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		      int nents, int direction);
+extern int pci64_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			int nents, int direction);
 
 /* Unmap a set of streaming mode DMA translations.
  * Again, cpu read rules concerning calls here are the same as for
  * pci_unmap_single() above.
  */
-extern void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nhwents, int direction);
+extern void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			 int nhwents, int direction);
+extern void pci64_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			   int nhwents, int direction);
 
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
@@ -96,7 +123,10 @@
  * next point you give the PCI dma address back to the card, the
  * device again owns the buffer.
  */
-extern void pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle, size_t size, int direction);
+extern void pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
+				size_t size, int direction);
+extern void pci64_dma_sync_single(struct pci_dev *hwdev, dma64_addr_t dma_handle,
+				  size_t size, int direction);
 
 /* Make physical memory consistent for a set of streaming
  * mode DMA translations after a transfer.
@@ -105,13 +135,14 @@
  * same rules and usage.
  */
 extern void pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nelems, int direction);
+extern void pci64_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nelems, int direction);
 
 /* Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask);
+extern int pci_dma_supported(struct pci_dev *hwdev, u64 mask);
 
 /* Return the index of the PCI controller for device PDEV. */
 
--- include/asm-sparc64/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ include/asm-sparc64/scatterlist.h	Wed Aug 15 03:10:44 2001
@@ -5,17 +5,26 @@
 #include <asm/page.h>
 
 struct scatterlist {
-    char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
-    unsigned int length;
+	char *address;
+	char *alt_address;
 
-    __u32 dvma_address; /* A place to hang host-specific addresses at. */
-    __u32 dvma_length;
+	struct page *page;
+	unsigned int offset;
+	unsigned int length;
+
+	/* A place to hang host-specific addresses at. */
+	union {
+		dma_addr_t   dma32_address;
+		dma64_addr_t dma64_address;
+	} dma_u;
+#define dvma_address		dma_u.dma32_address
+
+	__u32 dvma_length;
 };
 
-#define sg_dma_address(sg) ((sg)->dvma_address)
-#define sg_dma_len(sg)     ((sg)->dvma_length)
+#define sg_dma_address(sg)	((sg)->dma_u.dma32_address)
+#define sg_dma64_address(sg)	((sg)->dma_u.dma64_address)
+#define sg_dma_len(sg)     	((sg)->dvma_length)
 
 #define ISA_DMA_THRESHOLD	(~0UL)
 
--- include/asm-sparc64/types.h.~1~	Tue Nov 28 08:33:08 2000
+++ include/asm-sparc64/types.h	Wed Aug 15 02:13:44 2001
@@ -45,9 +45,10 @@
 
 #define BITS_PER_LONG 64
 
-/* Dma addresses are 32-bits wide for now.  */
+/* Dma addresses come in 32-bit and 64-bit flavours.  */
 
 typedef u32 dma_addr_t;
+typedef u64 dma64_addr_t;
 
 #endif /* __KERNEL__ */
 
--- include/linux/pci.h.~1~	Tue Aug 14 21:31:11 2001
+++ include/linux/pci.h	Wed Aug 15 03:17:30 2001
@@ -314,6 +314,12 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+/* These are the boolean attributes stored in pci_dev->dma_flags. */
+#define PCI_DMA_FLAG_HUGE_MAPS	0x00000001 /* Device may hold an enormous number
+					    * of mappings at once?
+					    */
+#define PCI_DMA_FLAG_ARCHMASK	0xf0000000 /* Reserved for arch-specific flags */
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
@@ -353,11 +359,12 @@
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	void		*driver_data;	/* data private to the driver */
-	dma_addr_t	dma_mask;	/* Mask of the bits of bus address this
+	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
+	unsigned int	dma_flags;	/* See PCI_DMA_FLAG_* above */
 
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
@@ -559,7 +566,8 @@
 int pci_enable_device(struct pci_dev *dev);
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
-int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask);
+int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
+void pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* Power management related routines */
@@ -641,7 +649,8 @@
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
-static inline int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask) { return -EIO; }
+static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
+static inline void pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off) { }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
