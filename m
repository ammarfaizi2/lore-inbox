Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBMBqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBMBqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMBqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:46:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49108 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751128AbWBMBqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:46:05 -0500
Date: Sun, 12 Feb 2006 19:49:08 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH 2/2] standardize the dma direction data type
Message-ID: <20060213014904.GB7798@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the DMA mapping call's dma direction uniform across
all archs as an "int".  This is in response to the rejection of Muli's
patch to make them uniform as "enum dma_data_direction"
(http://lkml.org/lkml/2006/1/24/262).

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 2fa13972604f Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	Wed Feb  8 17:58:27 2006
+++ b/Documentation/DMA-API.txt	Sun Feb 12 15:13:35 2006
@@ -182,7 +182,7 @@
 
 dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 dma_addr_t
 pci_map_single(struct device *dev, void *cpu_addr, size_t size,
 		      int direction)
@@ -263,7 +263,7 @@
 
 void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 void
 pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 		 size_t size, int direction)
@@ -275,13 +275,13 @@
 dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 		    unsigned long offset, size_t size,
-		    enum dma_data_direction direction)
+		    int direction)
 dma_addr_t
 pci_map_page(struct pci_dev *hwdev, struct page *page,
 		    unsigned long offset, size_t size, int direction)
 void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 void
 pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	       size_t size, int direction)
@@ -306,7 +306,7 @@
 
 int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
@@ -329,7 +329,7 @@
 
 void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 void
 pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	     int nents, int direction)
@@ -343,13 +343,13 @@
 
 void
 dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 void
 pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
 			   size_t size, int direction)
 void
 dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
-			  enum dma_data_direction direction)
+			  int direction)
 void
 pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 		       int nelems, int direction)
@@ -428,7 +428,7 @@
 void
 dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 
 does a partial sync.  starting at offset and continuing for size.  You
 must be careful to observe the cache alignment and width when doing
@@ -437,7 +437,7 @@
 
 void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 
 Do a partial sync of memory that was allocated by
 dma_alloc_noncoherent(), starting at virtual address vaddr and
diff -r 2fa13972604f arch/alpha/kernel/pci-noop.c
--- a/arch/alpha/kernel/pci-noop.c	Wed Feb  8 17:58:27 2006
+++ b/arch/alpha/kernel/pci-noop.c	Sun Feb 12 15:13:35 2006
@@ -173,7 +173,7 @@
 
 int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	int i;
 
diff -r 2fa13972604f arch/arm/common/dmabounce.c
--- a/arch/arm/common/dmabounce.c	Wed Feb  8 17:58:27 2006
+++ b/arch/arm/common/dmabounce.c	Sun Feb 12 15:13:35 2006
@@ -111,7 +111,7 @@
 /* allocate a 'safe' buffer and keep track of it */
 static inline struct safe_buffer *
 alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
-		  size_t size, enum dma_data_direction dir)
+		  size_t size, int dir)
 {
 	struct safe_buffer *buf;
 	struct dmabounce_pool *pool;
@@ -210,7 +210,7 @@
 
 static inline dma_addr_t
 map_single(struct device *dev, void *ptr, size_t size,
-		enum dma_data_direction dir)
+		int dir)
 {
 	struct dmabounce_device_info *device_info = find_dmabounce_dev(dev);
 	dma_addr_t dma_addr;
@@ -271,7 +271,7 @@
 
 static inline void
 unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir)
+		int dir)
 {
 	struct dmabounce_device_info *device_info = find_dmabounce_dev(dev);
 	struct safe_buffer *buf = NULL;
@@ -322,7 +322,7 @@
 
 static inline void
 sync_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir)
+		int dir)
 {
 	struct dmabounce_device_info *device_info = find_dmabounce_dev(dev);
 	struct safe_buffer *buf = NULL;
@@ -394,7 +394,7 @@
  */
 dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-		enum dma_data_direction dir)
+		int dir)
 {
 	unsigned long flags;
 	dma_addr_t dma_addr;
@@ -422,7 +422,7 @@
 
 void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-			enum dma_data_direction dir)
+			int dir)
 {
 	unsigned long flags;
 
@@ -440,7 +440,7 @@
 
 int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+		int dir)
 {
 	unsigned long flags;
 	int i;
@@ -469,7 +469,7 @@
 
 void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+		int dir)
 {
 	unsigned long flags;
 	int i;
@@ -493,7 +493,7 @@
 
 void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr, size_t size,
-				enum dma_data_direction dir)
+				int dir)
 {
 	unsigned long flags;
 
@@ -509,7 +509,7 @@
 
 void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_addr, size_t size,
-				enum dma_data_direction dir)
+				int dir)
 {
 	unsigned long flags;
 
@@ -525,7 +525,7 @@
 
 void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir)
+			int dir)
 {
 	unsigned long flags;
 	int i;
@@ -549,7 +549,7 @@
 
 void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir)
+			int dir)
 {
 	unsigned long flags;
 	int i;
diff -r 2fa13972604f arch/arm/kernel/dma-isa.c
--- a/arch/arm/kernel/dma-isa.c	Wed Feb  8 17:58:27 2006
+++ b/arch/arm/kernel/dma-isa.c	Sun Feb 12 15:13:35 2006
@@ -66,7 +66,7 @@
 	if (dma->invalid) {
 		unsigned long address, length;
 		unsigned int mode;
-		enum dma_data_direction direction;
+		int direction;
 
 		mode = channel & 3;
 		switch (dma->dma_mode & DMA_MODE_MASK) {
diff -r 2fa13972604f arch/frv/mb93090-mb00/pci-dma-nommu.c
--- a/arch/frv/mb93090-mb00/pci-dma-nommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/frv/mb93090-mb00/pci-dma-nommu.c	Sun Feb 12 15:13:35 2006
@@ -114,7 +114,7 @@
  * until either pci_unmap_single or pci_dma_sync_single is performed.
  */
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-			  enum dma_data_direction direction)
+			  int direction)
 {
 	if (direction == DMA_NONE)
                 BUG();
@@ -143,7 +143,7 @@
  * the same here.
  */
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	int i;
 
diff -r 2fa13972604f arch/frv/mb93090-mb00/pci-dma.c
--- a/arch/frv/mb93090-mb00/pci-dma.c	Wed Feb  8 17:58:27 2006
+++ b/arch/frv/mb93090-mb00/pci-dma.c	Sun Feb 12 15:13:35 2006
@@ -45,7 +45,7 @@
  * until either pci_unmap_single or pci_dma_sync_single is performed.
  */
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-			  enum dma_data_direction direction)
+			  int direction)
 {
 	if (direction == DMA_NONE)
                 BUG();
@@ -74,7 +74,7 @@
  * the same here.
  */
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	unsigned long dampr2;
 	void *vaddr;
@@ -105,7 +105,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-			size_t size, enum dma_data_direction direction)
+			size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	flush_dcache_page(page);
diff -r 2fa13972604f arch/mips/mm/dma-coherent.c
--- a/arch/mips/mm/dma-coherent.c	Wed Feb  8 17:58:27 2006
+++ b/arch/mips/mm/dma-coherent.c	Sun Feb 12 15:13:35 2006
@@ -60,7 +60,7 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -70,7 +70,7 @@
 EXPORT_SYMBOL(dma_map_single);
 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -78,7 +78,7 @@
 EXPORT_SYMBOL(dma_unmap_single);
 
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -94,7 +94,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -104,7 +104,7 @@
 EXPORT_SYMBOL(dma_map_page);
 
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -112,7 +112,7 @@
 EXPORT_SYMBOL(dma_unmap_page);
 
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -120,7 +120,7 @@
 EXPORT_SYMBOL(dma_unmap_sg);
 
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -128,7 +128,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_cpu);
 
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -137,7 +137,7 @@
 
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -146,7 +146,7 @@
 
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -154,7 +154,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_device);
 
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -162,7 +162,7 @@
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
 
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -199,7 +199,7 @@
 EXPORT_SYMBOL(dma_is_consistent);
 
 void dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
diff -r 2fa13972604f arch/mips/mm/dma-ip27.c
--- a/arch/mips/mm/dma-ip27.c	Wed Feb  8 17:58:27 2006
+++ b/arch/mips/mm/dma-ip27.c	Sun Feb 12 15:13:35 2006
@@ -65,7 +65,7 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -75,7 +75,7 @@
 EXPORT_SYMBOL(dma_map_single);
 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -83,7 +83,7 @@
 EXPORT_SYMBOL(dma_unmap_single);
 
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -100,7 +100,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -110,7 +110,7 @@
 EXPORT_SYMBOL(dma_map_page);
 
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -118,7 +118,7 @@
 EXPORT_SYMBOL(dma_unmap_page);
 
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -126,7 +126,7 @@
 EXPORT_SYMBOL(dma_unmap_sg);
 
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -134,7 +134,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_cpu);
 
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -143,7 +143,7 @@
 
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -152,7 +152,7 @@
 
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -160,7 +160,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_device);
 
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -168,7 +168,7 @@
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
 
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -205,7 +205,7 @@
 EXPORT_SYMBOL(dma_is_consistent);
 
 void dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
diff -r 2fa13972604f arch/mips/mm/dma-ip32.c
--- a/arch/mips/mm/dma-ip32.c	Wed Feb  8 17:58:27 2006
+++ b/arch/mips/mm/dma-ip32.c	Sun Feb 12 15:13:35 2006
@@ -96,7 +96,7 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 static inline void __dma_sync(unsigned long addr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -117,7 +117,7 @@
 }
 
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	unsigned long addr = (unsigned long) ptr;
 
@@ -147,7 +147,7 @@
 EXPORT_SYMBOL(dma_map_single);
 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -167,7 +167,7 @@
 EXPORT_SYMBOL(dma_unmap_single);
 
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -191,7 +191,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -209,7 +209,7 @@
 EXPORT_SYMBOL(dma_map_page);
 
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -227,7 +227,7 @@
 EXPORT_SYMBOL(dma_unmap_page);
 
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	enum dma_data_direction direction)
+	int direction)
 {
 	unsigned long addr;
 	int i;
@@ -248,7 +248,7 @@
 EXPORT_SYMBOL(dma_unmap_sg);
 
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -264,7 +264,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_cpu);
 
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -280,7 +280,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_device);
 
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -296,7 +296,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
 
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -312,7 +312,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_device);
 
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -327,7 +327,7 @@
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
 
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -370,7 +370,7 @@
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
+void dma_cache_sync(void *vaddr, size_t size, int direction)
 {
 	if (direction == DMA_NONE)
 		return;
diff -r 2fa13972604f arch/mips/mm/dma-noncoherent.c
--- a/arch/mips/mm/dma-noncoherent.c	Wed Feb  8 17:58:27 2006
+++ b/arch/mips/mm/dma-noncoherent.c	Sun Feb 12 15:13:35 2006
@@ -80,7 +80,7 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 static inline void __dma_sync(unsigned long addr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -101,7 +101,7 @@
 }
 
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	unsigned long addr = (unsigned long) ptr;
 
@@ -113,7 +113,7 @@
 EXPORT_SYMBOL(dma_map_single);
 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	unsigned long addr;
 	addr = dma_addr + PAGE_OFFSET;
@@ -124,7 +124,7 @@
 EXPORT_SYMBOL(dma_unmap_single);
 
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -147,7 +147,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -162,7 +162,7 @@
 EXPORT_SYMBOL(dma_map_page);
 
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	enum dma_data_direction direction)
+	int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -177,7 +177,7 @@
 EXPORT_SYMBOL(dma_unmap_page);
 
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	enum dma_data_direction direction)
+	int direction)
 {
 	unsigned long addr;
 	int i;
@@ -197,7 +197,7 @@
 EXPORT_SYMBOL(dma_unmap_sg);
 
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -210,7 +210,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_cpu);
 
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+	size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -223,7 +223,7 @@
 EXPORT_SYMBOL(dma_sync_single_for_device);
 
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -236,7 +236,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
 
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+	unsigned long offset, size_t size, int direction)
 {
 	unsigned long addr;
 
@@ -249,7 +249,7 @@
 EXPORT_SYMBOL(dma_sync_single_range_for_device);
 
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -264,7 +264,7 @@
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
 
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+	int direction)
 {
 	int i;
 
@@ -307,7 +307,7 @@
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
+void dma_cache_sync(void *vaddr, size_t size, int direction)
 {
 	if (direction == DMA_NONE)
 		return;
diff -r 2fa13972604f arch/parisc/kernel/pci-dma.c
--- a/arch/parisc/kernel/pci-dma.c	Wed Feb  8 17:58:27 2006
+++ b/arch/parisc/kernel/pci-dma.c	Sun Feb 12 15:13:35 2006
@@ -396,7 +396,7 @@
 	free_pages((unsigned long)__va(dma_handle), order);
 }
 
-static dma_addr_t pa11_dma_map_single(struct device *dev, void *addr, size_t size, enum dma_data_direction direction)
+static dma_addr_t pa11_dma_map_single(struct device *dev, void *addr, size_t size, int direction)
 {
 	if (direction == DMA_NONE) {
 		printk(KERN_ERR "pa11_dma_map_single(PCI_DMA_NONE) called by %p\n", __builtin_return_address(0));
@@ -407,7 +407,7 @@
 	return virt_to_phys(addr);
 }
 
-static void pa11_dma_unmap_single(struct device *dev, dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
+static void pa11_dma_unmap_single(struct device *dev, dma_addr_t dma_handle, size_t size, int direction)
 {
 	if (direction == DMA_NONE) {
 		printk(KERN_ERR "pa11_dma_unmap_single(PCI_DMA_NONE) called by %p\n", __builtin_return_address(0));
@@ -427,7 +427,7 @@
 	return;
 }
 
-static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
+static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents, int direction)
 {
 	int i;
 
@@ -443,7 +443,7 @@
 	return nents;
 }
 
-static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
+static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, int direction)
 {
 	int i;
 
@@ -460,7 +460,7 @@
 	return;
 }
 
-static void pa11_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, unsigned long offset, size_t size, enum dma_data_direction direction)
+static void pa11_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, unsigned long offset, size_t size, int direction)
 {
 	if (direction == DMA_NONE)
 	    BUG();
@@ -468,7 +468,7 @@
 	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle) + offset, size);
 }
 
-static void pa11_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, unsigned long offset, size_t size, enum dma_data_direction direction)
+static void pa11_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, unsigned long offset, size_t size, int direction)
 {
 	if (direction == DMA_NONE)
 	    BUG();
@@ -476,7 +476,7 @@
 	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle) + offset, size);
 }
 
-static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
+static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nents, int direction)
 {
 	int i;
 
@@ -486,7 +486,7 @@
 		flush_kernel_dcache_range(sg_virt_addr(sglist), sglist->length);
 }
 
-static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
+static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, int direction)
 {
 	int i;
 
diff -r 2fa13972604f arch/powerpc/kernel/dma_64.c
--- a/arch/powerpc/kernel/dma_64.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/dma_64.c	Sun Feb 12 15:13:35 2006
@@ -86,7 +86,7 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 dma_addr_t dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
@@ -98,7 +98,7 @@
 EXPORT_SYMBOL(dma_map_single);
 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
@@ -111,7 +111,7 @@
 
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
@@ -124,7 +124,7 @@
 EXPORT_SYMBOL(dma_map_page);
 
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
@@ -136,7 +136,7 @@
 EXPORT_SYMBOL(dma_unmap_page);
 
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
@@ -148,7 +148,7 @@
 EXPORT_SYMBOL(dma_map_sg);
 
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-		enum dma_data_direction direction)
+		int direction)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
diff -r 2fa13972604f arch/powerpc/kernel/ibmebus.c
--- a/arch/powerpc/kernel/ibmebus.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/ibmebus.c	Sun Feb 12 15:13:35 2006
@@ -72,7 +72,7 @@
 static dma_addr_t ibmebus_map_single(struct device *dev,
 				     void *ptr,
 				     size_t size,
-				     enum dma_data_direction direction)
+				     int direction)
 {
 	return (dma_addr_t)(ptr);
 }
@@ -80,14 +80,14 @@
 static void ibmebus_unmap_single(struct device *dev,
 				 dma_addr_t dma_addr,
 				 size_t size, 
-				 enum dma_data_direction direction)
+				 int direction)
 {
 	return;
 }
 
 static int ibmebus_map_sg(struct device *dev,
 			  struct scatterlist *sg,
-			  int nents, enum dma_data_direction direction)
+			  int nents, int direction)
 {
 	int i;
 	
@@ -102,7 +102,7 @@
 
 static void ibmebus_unmap_sg(struct device *dev,
 			     struct scatterlist *sg,
-			     int nents, enum dma_data_direction direction)
+			     int nents, int direction)
 {
 	return;
 }
diff -r 2fa13972604f arch/powerpc/kernel/iommu.c
--- a/arch/powerpc/kernel/iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/iommu.c	Sun Feb 12 15:13:35 2006
@@ -150,7 +150,7 @@
 }
 
 static dma_addr_t iommu_alloc(struct iommu_table *tbl, void *page,
-		       unsigned int npages, enum dma_data_direction direction,
+		       unsigned int npages, int direction,
 		       unsigned int align_order)
 {
 	unsigned long entry, flags;
@@ -237,7 +237,7 @@
 
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction direction)
+		int direction)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
@@ -369,7 +369,7 @@
 
 
 void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, int direction)
 {
 	unsigned long flags;
 
@@ -480,7 +480,7 @@
  * byte within the page as vaddr.
  */
 dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
 	unsigned long uaddr;
@@ -508,7 +508,7 @@
 }
 
 void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
diff -r 2fa13972604f arch/powerpc/kernel/pci_direct_iommu.c
--- a/arch/powerpc/kernel/pci_direct_iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/pci_direct_iommu.c	Sun Feb 12 15:13:35 2006
@@ -49,18 +49,18 @@
 }
 
 static dma_addr_t pci_direct_map_single(struct device *hwdev, void *ptr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	return virt_to_abs(ptr);
 }
 
 static void pci_direct_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 }
 
 static int pci_direct_map_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
+		int nents, int direction)
 {
 	int i;
 
@@ -73,7 +73,7 @@
 }
 
 static void pci_direct_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
+		int nents, int direction)
 {
 }
 
diff -r 2fa13972604f arch/powerpc/kernel/pci_iommu.c
--- a/arch/powerpc/kernel/pci_iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/pci_iommu.c	Sun Feb 12 15:13:35 2006
@@ -84,28 +84,28 @@
  * byte within the page as vaddr.
  */
 static dma_addr_t pci_iommu_map_single(struct device *hwdev, void *vaddr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	return iommu_map_single(devnode_table(hwdev), vaddr, size, direction);
 }
 
 
 static void pci_iommu_unmap_single(struct device *hwdev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	iommu_unmap_single(devnode_table(hwdev), dma_handle, size, direction);
 }
 
 
 static int pci_iommu_map_sg(struct device *pdev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, int direction)
 {
 	return iommu_map_sg(pdev, devnode_table(pdev), sglist,
 			nelems, direction);
 }
 
 static void pci_iommu_unmap_sg(struct device *pdev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, int direction)
 {
 	iommu_unmap_sg(devnode_table(pdev), sglist, nelems, direction);
 }
diff -r 2fa13972604f arch/powerpc/kernel/vio.c
--- a/arch/powerpc/kernel/vio.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/kernel/vio.c	Sun Feb 12 15:13:35 2006
@@ -199,28 +199,28 @@
 EXPORT_SYMBOL(vio_unregister_device);
 
 static dma_addr_t vio_map_single(struct device *dev, void *vaddr,
-			  size_t size, enum dma_data_direction direction)
+			  size_t size, int direction)
 {
 	return iommu_map_single(to_vio_dev(dev)->iommu_table, vaddr, size,
 			direction);
 }
 
 static void vio_unmap_single(struct device *dev, dma_addr_t dma_handle,
-		      size_t size, enum dma_data_direction direction)
+		      size_t size, int direction)
 {
 	iommu_unmap_single(to_vio_dev(dev)->iommu_table, dma_handle, size,
 			direction);
 }
 
 static int vio_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, int direction)
 {
 	return iommu_map_sg(dev, to_vio_dev(dev)->iommu_table, sglist,
 			nelems, direction);
 }
 
 static void vio_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, int direction)
 {
 	iommu_unmap_sg(to_vio_dev(dev)->iommu_table, sglist, nelems, direction);
 }
diff -r 2fa13972604f arch/powerpc/platforms/cell/iommu.c
--- a/arch/powerpc/platforms/cell/iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/platforms/cell/iommu.c	Sun Feb 12 15:13:35 2006
@@ -439,18 +439,18 @@
 }
 
 static dma_addr_t cell_map_single(struct device *hwdev, void *ptr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 	return virt_to_abs(ptr) | CELL_DMA_VALID;
 }
 
 static void cell_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, int direction)
 {
 }
 
 static int cell_map_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
+		int nents, int direction)
 {
 	int i;
 
@@ -464,7 +464,7 @@
 }
 
 static void cell_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
+		int nents, int direction)
 {
 }
 
diff -r 2fa13972604f arch/powerpc/platforms/iseries/iommu.c
--- a/arch/powerpc/platforms/iseries/iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/platforms/iseries/iommu.c	Sun Feb 12 15:13:35 2006
@@ -40,7 +40,7 @@
 
 
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
-		unsigned long uaddr, enum dma_data_direction direction)
+		unsigned long uaddr, int direction)
 {
 	u64 rc;
 	union tce_entry tce;
diff -r 2fa13972604f arch/powerpc/platforms/pseries/iommu.c
--- a/arch/powerpc/platforms/pseries/iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/platforms/pseries/iommu.c	Sun Feb 12 15:13:35 2006
@@ -53,7 +53,7 @@
 
 static void tce_build_pSeries(struct iommu_table *tbl, long index, 
 			      long npages, unsigned long uaddr, 
-			      enum dma_data_direction direction)
+			      int direction)
 {
 	union tce_entry t;
 	union tce_entry *tp;
@@ -102,7 +102,7 @@
 
 static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
-				enum dma_data_direction direction)
+				int direction)
 {
 	u64 rc;
 	union tce_entry tce;
@@ -138,7 +138,7 @@
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
-				     enum dma_data_direction direction)
+				     int direction)
 {
 	u64 rc;
 	union tce_entry tce, *tcep;
diff -r 2fa13972604f arch/powerpc/sysdev/dart_iommu.c
--- a/arch/powerpc/sysdev/dart_iommu.c	Wed Feb  8 17:58:27 2006
+++ b/arch/powerpc/sysdev/dart_iommu.c	Sun Feb 12 15:13:35 2006
@@ -119,7 +119,7 @@
 
 static void dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
-		       enum dma_data_direction direction)
+		       int direction)
 {
 	unsigned int *dp;
 	unsigned int rpn;
diff -r 2fa13972604f drivers/char/drm/via_dmablit.h
--- a/drivers/char/drm/via_dmablit.h	Wed Feb  8 17:58:27 2006
+++ b/drivers/char/drm/via_dmablit.h	Sun Feb 12 15:13:35 2006
@@ -43,7 +43,7 @@
 	struct _drm_via_descriptor **desc_pages;
 	int num_desc_pages;
 	int num_desc;
-	enum dma_data_direction direction;
+	int direction;
 	unsigned char *bounce_buffer;
         dma_addr_t chain_start;
 	uint32_t free_on_sequence;
diff -r 2fa13972604f drivers/ieee1394/sbp2.c
--- a/drivers/ieee1394/sbp2.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/ieee1394/sbp2.c	Sun Feb 12 15:13:35 2006
@@ -1670,7 +1670,7 @@
 				     unsigned int scsi_use_sg,
 				     struct scatterlist *sgpnt,
 				     u32 orb_direction,
-				     enum dma_data_direction dma_dir)
+				     int dma_dir)
 {
 	command->dma_dir = dma_dir;
 	orb->data_descriptor_hi = ORB_SET_NODE_ID(hi->host->node_id);
@@ -1754,7 +1754,7 @@
 					u32 orb_direction,
 					unsigned int scsi_request_bufflen,
 					void *scsi_request_buffer,
-					enum dma_data_direction dma_dir)
+					int dma_dir)
 {
 	command->dma_dir = dma_dir;
 	command->dma_size = scsi_request_bufflen;
@@ -1836,7 +1836,7 @@
 				    unsigned int scsi_use_sg,
 				    unsigned int scsi_request_bufflen,
 				    void *scsi_request_buffer,
-				    enum dma_data_direction dma_dir)
+				    int dma_dir)
 {
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
 	struct scatterlist *sgpnt = (struct scatterlist *)scsi_request_buffer;
diff -r 2fa13972604f drivers/infiniband/ulp/srp/ib_srp.c
--- a/drivers/infiniband/ulp/srp/ib_srp.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/infiniband/ulp/srp/ib_srp.c	Sun Feb 12 15:13:35 2006
@@ -93,7 +93,7 @@
 
 static struct srp_iu *srp_alloc_iu(struct srp_host *host, size_t size,
 				   gfp_t gfp_mask,
-				   enum dma_data_direction direction)
+				   int direction)
 {
 	struct srp_iu *iu;
 
diff -r 2fa13972604f drivers/infiniband/ulp/srp/ib_srp.h
--- a/drivers/infiniband/ulp/srp/ib_srp.h	Wed Feb  8 17:58:27 2006
+++ b/drivers/infiniband/ulp/srp/ib_srp.h	Sun Feb 12 15:13:35 2006
@@ -144,7 +144,7 @@
 	dma_addr_t		dma;
 	void		       *buf;
 	size_t			size;
-	enum dma_data_direction	direction;
+	int	direction;
 };
 
 #endif /* IB_SRP_H */
diff -r 2fa13972604f drivers/message/i2o/i2o_block.c
--- a/drivers/message/i2o/i2o_block.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/message/i2o/i2o_block.c	Sun Feb 12 15:13:35 2006
@@ -336,7 +336,7 @@
 					 u32 ** mptr)
 {
 	int nents;
-	enum dma_data_direction direction;
+	int direction;
 
 	ireq->dev = &c->pdev->dev;
 	nents = blk_rq_map_sg(ireq->req->q, ireq->req, ireq->sg_table);
@@ -359,7 +359,7 @@
  */
 static inline void i2o_block_sglist_free(struct i2o_block_request *ireq)
 {
-	enum dma_data_direction direction;
+	int direction;
 
 	if (rq_data_dir(ireq->req) == READ)
 		direction = PCI_DMA_FROMDEVICE;
diff -r 2fa13972604f drivers/net/b44.c
--- a/drivers/net/b44.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/net/b44.c	Sun Feb 12 15:13:35 2006
@@ -114,7 +114,7 @@
 static inline void b44_sync_dma_desc_for_device(struct pci_dev *pdev,
                                                 dma_addr_t dma_base,
                                                 unsigned long offset,
-                                                enum dma_data_direction dir)
+                                                int dir)
 {
 	dma_sync_single_range_for_device(&pdev->dev, dma_base,
 	                                 offset & dma_desc_align_mask,
@@ -124,7 +124,7 @@
 static inline void b44_sync_dma_desc_for_cpu(struct pci_dev *pdev,
                                              dma_addr_t dma_base,
                                              unsigned long offset,
-                                             enum dma_data_direction dir)
+                                             int dir)
 {
 	dma_sync_single_range_for_cpu(&pdev->dev, dma_base,
 	                              offset & dma_desc_align_mask,
diff -r 2fa13972604f drivers/parisc/ccio-dma.c
--- a/drivers/parisc/ccio-dma.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/parisc/ccio-dma.c	Sun Feb 12 15:13:35 2006
@@ -731,7 +731,7 @@
  */
 static dma_addr_t 
 ccio_map_single(struct device *dev, void *addr, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	int idx;
 	struct ioc *ioc;
@@ -799,7 +799,7 @@
  */
 static void 
 ccio_unmap_single(struct device *dev, dma_addr_t iova, size_t size, 
-		  enum dma_data_direction direction)
+		  int direction)
 {
 	struct ioc *ioc;
 	unsigned long flags; 
@@ -899,7 +899,7 @@
  */
 static int
 ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents, 
-	    enum dma_data_direction direction)
+	    int direction)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -976,7 +976,7 @@
  */
 static void 
 ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, 
-	      enum dma_data_direction direction)
+	      int direction)
 {
 	struct ioc *ioc;
 
diff -r 2fa13972604f drivers/parisc/sba_iommu.c
--- a/drivers/parisc/sba_iommu.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/parisc/sba_iommu.c	Sun Feb 12 15:13:35 2006
@@ -870,7 +870,7 @@
  */
 static dma_addr_t
 sba_map_single(struct device *dev, void *addr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	struct ioc *ioc;
 	unsigned long flags; 
@@ -949,7 +949,7 @@
  */
 static void
 sba_unmap_single(struct device *dev, dma_addr_t iova, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	struct ioc *ioc;
 #if DELAYED_RESOURCE_CNT > 0
@@ -1091,7 +1091,7 @@
  */
 static int
 sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -1175,7 +1175,7 @@
  */
 static void 
 sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	struct ioc *ioc;
 #ifdef ASSERT_PDIR_SANITY
diff -r 2fa13972604f drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/scsi/53c700.c	Sun Feb 12 15:13:35 2006
@@ -1753,7 +1753,7 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
 	__u32 move_ins;
-	enum dma_data_direction direction;
+	int direction;
 	struct NCR_700_command_slot *slot;
 
 	if(hostdata->command_slot_count >= NCR_700_COMMAND_SLOTS_PER_HOST) {
diff -r 2fa13972604f drivers/scsi/ch.c
--- a/drivers/scsi/ch.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/scsi/ch.c	Sun Feb 12 15:13:35 2006
@@ -204,7 +204,7 @@
 static int
 ch_do_scsi(scsi_changer *ch, unsigned char *cmd,
 	   void *buffer, unsigned buflength,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	int errno, retries = 0, timeout, result;
 	struct scsi_sense_hdr sshdr;
diff -r 2fa13972604f drivers/scsi/dc395x.c
--- a/drivers/scsi/dc395x.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/scsi/dc395x.c	Sun Feb 12 15:13:35 2006
@@ -992,7 +992,7 @@
 static void build_srb(struct scsi_cmnd *cmd, struct DeviceCtlBlk *dcb,
 		struct ScsiReqBlk *srb)
 {
-	enum dma_data_direction dir = cmd->sc_data_direction;
+	int dir = cmd->sc_data_direction;
 	dprintkdbg(DBG_0, "build_srb: (pid#%li) <%02i-%i>\n",
 		cmd->pid, dcb->target_id, dcb->target_lun);
 
@@ -3279,7 +3279,7 @@
 static void pci_unmap_srb(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb)
 {
 	struct scsi_cmnd *cmd = srb->cmd;
-	enum dma_data_direction dir = cmd->sc_data_direction;
+	int dir = cmd->sc_data_direction;
 	if (cmd->use_sg && dir != PCI_DMA_NONE) {
 		/* unmap DC395x SG list */
 		dprintkdbg(DBG_SG, "pci_unmap_srb: list=%08x(%05x)\n",
@@ -3333,7 +3333,7 @@
 	u8 tempcnt, status;
 	struct scsi_cmnd *cmd = srb->cmd;
 	struct ScsiInqData *ptr;
-	enum dma_data_direction dir = cmd->sc_data_direction;
+	int dir = cmd->sc_data_direction;
 
 	if (cmd->use_sg) {
 		struct scatterlist* sg = (struct scatterlist *)cmd->request_buffer;
@@ -3550,7 +3550,7 @@
 		struct scsi_cmnd *p;
 
 		list_for_each_entry_safe(srb, tmp, &dcb->srb_going_list, list) {
-			enum dma_data_direction dir;
+			int dir;
 			int result;
 
 			p = srb->cmd;
diff -r 2fa13972604f drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/scsi/libata-scsi.c	Sun Feb 12 15:13:35 2006
@@ -149,7 +149,7 @@
 	u8 args[4], *argbuf = NULL;
 	int argsize = 0;
 	struct scsi_sense_hdr sshdr;
-	enum dma_data_direction data_dir;
+	int data_dir;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
diff -r 2fa13972604f drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c	Wed Feb  8 17:58:27 2006
+++ b/drivers/scsi/scsi_transport_spi.c	Sun Feb 12 15:13:35 2006
@@ -106,7 +106,7 @@
 }
 
 static int spi_execute(struct scsi_device *sdev, const void *cmd,
-		       enum dma_data_direction dir,
+		       int dir,
 		       void *buffer, unsigned bufflen,
 		       struct scsi_sense_hdr *sshdr)
 {
diff -r 2fa13972604f include/asm-alpha/dma-mapping.h
--- a/include/asm-alpha/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-alpha/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -34,7 +34,7 @@
 void *dma_alloc_coherent(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t gfp);
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	       enum dma_data_direction direction);
+	       int direction);
 
 #define dma_free_coherent(dev, size, va, addr)		\
 		free_pages((unsigned long)va, get_order(size))
diff -r 2fa13972604f include/asm-arm/dma-mapping.h
--- a/include/asm-arm/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-arm/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -143,13 +143,13 @@
 #ifndef CONFIG_DMABOUNCE
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction dir)
+	       int dir)
 {
 	consistent_sync(cpu_addr, size, dir);
 	return virt_to_dma(dev, (unsigned long)cpu_addr);
 }
 #else
-extern dma_addr_t dma_map_single(struct device *,void *, size_t, enum dma_data_direction);
+extern dma_addr_t dma_map_single(struct device *,void *, size_t, int);
 #endif
 
 /**
@@ -170,7 +170,7 @@
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
-	     enum dma_data_direction dir)
+	     int dir)
 {
 	return dma_map_single(dev, page_address(page) + offset, size, (int)dir);
 }
@@ -192,12 +192,12 @@
 #ifndef CONFIG_DMABOUNCE
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t handle, size_t size,
-		 enum dma_data_direction dir)
+		 int dir)
 {
 	/* nothing to do */
 }
 #else
-extern void dma_unmap_single(struct device *, dma_addr_t, size_t, enum dma_data_direction);
+extern void dma_unmap_single(struct device *, dma_addr_t, size_t, int);
 #endif
 
 /**
@@ -216,7 +216,7 @@
  */
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-	       enum dma_data_direction dir)
+	       int dir)
 {
 	dma_unmap_single(dev, handle, size, (int)dir);
 }
@@ -246,7 +246,7 @@
 #ifndef CONFIG_DMABOUNCE
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction dir)
+	   int dir)
 {
 	int i;
 
@@ -261,7 +261,7 @@
 	return nents;
 }
 #else
-extern int dma_map_sg(struct device *, struct scatterlist *, int, enum dma_data_direction);
+extern int dma_map_sg(struct device *, struct scatterlist *, int, int);
 #endif
 
 /**
@@ -278,13 +278,13 @@
 #ifndef CONFIG_DMABOUNCE
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-	     enum dma_data_direction dir)
+	     int dir)
 {
 
 	/* nothing to do */
 }
 #else
-extern void dma_unmap_sg(struct device *, struct scatterlist *, int, enum dma_data_direction);
+extern void dma_unmap_sg(struct device *, struct scatterlist *, int, int);
 #endif
 
 
@@ -308,20 +308,20 @@
 #ifndef CONFIG_DMABOUNCE
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle, size_t size,
-			enum dma_data_direction dir)
+			int dir)
 {
 	consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t handle, size_t size,
-			   enum dma_data_direction dir)
+			   int dir)
 {
 	consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
 }
 #else
-extern void dma_sync_single_for_cpu(struct device*, dma_addr_t, size_t, enum dma_data_direction);
-extern void dma_sync_single_for_device(struct device*, dma_addr_t, size_t, enum dma_data_direction);
+extern void dma_sync_single_for_cpu(struct device*, dma_addr_t, size_t, int);
+extern void dma_sync_single_for_device(struct device*, dma_addr_t, size_t, int);
 #endif
 
 
@@ -341,7 +341,7 @@
 #ifndef CONFIG_DMABOUNCE
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
-		    enum dma_data_direction dir)
+		    int dir)
 {
 	int i;
 
@@ -353,7 +353,7 @@
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
-		       enum dma_data_direction dir)
+		       int dir)
 {
 	int i;
 
@@ -363,8 +363,8 @@
 	}
 }
 #else
-extern void dma_sync_sg_for_cpu(struct device*, struct scatterlist*, int, enum dma_data_direction);
-extern void dma_sync_sg_for_device(struct device*, struct scatterlist*, int, enum dma_data_direction);
+extern void dma_sync_sg_for_cpu(struct device*, struct scatterlist*, int, int);
+extern void dma_sync_sg_for_device(struct device*, struct scatterlist*, int, int);
 #endif
 
 #ifdef CONFIG_DMABOUNCE
diff -r 2fa13972604f include/asm-cris/dma-mapping.h
--- a/include/asm-cris/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-cris/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -37,7 +37,7 @@
 #endif
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	return virt_to_phys(ptr);
@@ -45,14 +45,14 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	printk("Map sg\n");
 	return nents;
@@ -60,7 +60,7 @@
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-	     size_t size, enum dma_data_direction direction)
+	     size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	return page_to_phys(page) + offset;
@@ -68,7 +68,7 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -76,46 +76,46 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 }
 
 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
+			      int direction)
 {
 }
 
 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
+				 int direction)
 {
 }
 
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 }
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 }
 
@@ -160,7 +160,7 @@
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 }
 
diff -r 2fa13972604f include/asm-frv/dma-mapping.h
--- a/include/asm-frv/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-frv/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -34,7 +34,7 @@
  * until either pci_unmap_single or pci_dma_sync_single is performed.
  */
 extern dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-				 enum dma_data_direction direction);
+				 int direction);
 
 /*
  * Unmap a single streaming mode DMA translation.  The dma_addr and size
@@ -46,7 +46,7 @@
  */
 static inline
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -68,7 +68,7 @@
  * the same here.
  */
 extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction direction);
+		      int direction);
 
 /*
  * Unmap a set of streaming mode DMA translations.
@@ -77,18 +77,18 @@
  */
 static inline
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 extern
 dma_addr_t dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-			size_t size, enum dma_data_direction direction);
+			size_t size, int direction);
 
 static inline
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -96,13 +96,13 @@
 
 static inline
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			     enum dma_data_direction direction)
+			     int direction)
 {
 }
 
 static inline
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-				enum dma_data_direction direction)
+				int direction)
 {
 	flush_write_buffers();
 }
@@ -110,27 +110,27 @@
 static inline
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 				   unsigned long offset, size_t size,
-				   enum dma_data_direction direction)
+				   int direction)
 {
 }
 
 static inline
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 				      unsigned long offset, size_t size,
-				      enum dma_data_direction direction)
+				      int direction)
 {
 	flush_write_buffers();
 }
 
 static inline
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-			 enum dma_data_direction direction)
+			 int direction)
 {
 }
 
 static inline
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-			    enum dma_data_direction direction)
+			    int direction)
 {
 	flush_write_buffers();
 }
@@ -176,7 +176,7 @@
 
 static inline
 void dma_cache_sync(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 	flush_write_buffers();
 }
diff -r 2fa13972604f include/asm-generic/dma-mapping.h
--- a/include/asm-generic/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-generic/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -53,7 +53,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -62,7 +62,7 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -72,7 +72,7 @@
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -81,7 +81,7 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -90,7 +90,7 @@
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -99,7 +99,7 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -108,7 +108,7 @@
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -118,7 +118,7 @@
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			   enum dma_data_direction direction)
+			   int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -128,7 +128,7 @@
 
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -137,7 +137,7 @@
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction direction)
+		       int direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
@@ -183,7 +183,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG();
 	return 0;
@@ -191,7 +191,7 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG();
 }
@@ -199,7 +199,7 @@
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG();
 	return 0;
@@ -207,14 +207,14 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG();
 }
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	BUG();
 	return 0;
@@ -222,35 +222,35 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			   enum dma_data_direction direction)
+			   int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction direction)
+		       int direction)
 {
 	BUG();
 }
@@ -280,7 +280,7 @@
 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
+			      int direction)
 {
 	/* just sync everything, that's all the pci API can do */
 	dma_sync_single_for_cpu(dev, dma_handle, offset+size, direction);
@@ -289,7 +289,7 @@
 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
+				 int direction)
 {
 	/* just sync everything, that's all the pci API can do */
 	dma_sync_single_for_device(dev, dma_handle, offset+size, direction);
@@ -297,7 +297,7 @@
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	/* could define this in terms of the dma_cache ... operations,
 	 * but if you get this on a platform, you should convert the platform
diff -r 2fa13972604f include/asm-generic/pci-dma-compat.h
--- a/include/asm-generic/pci-dma-compat.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-generic/pci-dma-compat.h	Sun Feb 12 15:13:35 2006
@@ -32,70 +32,70 @@
 static inline dma_addr_t
 pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
 {
-	return dma_map_single(hwdev == NULL ? NULL : &hwdev->dev, ptr, size, (enum dma_data_direction)direction);
+	return dma_map_single(hwdev == NULL ? NULL : &hwdev->dev, ptr, size, direction);
 }
 
 static inline void
 pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 		 size_t size, int direction)
 {
-	dma_unmap_single(hwdev == NULL ? NULL : &hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
+	dma_unmap_single(hwdev == NULL ? NULL : &hwdev->dev, dma_addr, size, direction);
 }
 
 static inline dma_addr_t
 pci_map_page(struct pci_dev *hwdev, struct page *page,
 	     unsigned long offset, size_t size, int direction)
 {
-	return dma_map_page(hwdev == NULL ? NULL : &hwdev->dev, page, offset, size, (enum dma_data_direction)direction);
+	return dma_map_page(hwdev == NULL ? NULL : &hwdev->dev, page, offset, size, direction);
 }
 
 static inline void
 pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	       size_t size, int direction)
 {
-	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, direction);
 }
 
 static inline int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
 {
-	return dma_map_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+	return dma_map_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, direction);
 }
 
 static inline void
 pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	     int nents, int direction)
 {
-	dma_unmap_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+	dma_unmap_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, direction);
 }
 
 static inline void
 pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t dma_handle,
 		    size_t size, int direction)
 {
-	dma_sync_single_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+	dma_sync_single_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, direction);
 }
 
 static inline void
 pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
 		    size_t size, int direction)
 {
-	dma_sync_single_for_device(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+	dma_sync_single_for_device(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, direction);
 }
 
 static inline void
 pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
 		int nelems, int direction)
 {
-	dma_sync_sg_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+	dma_sync_sg_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, direction);
 }
 
 static inline void
 pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
 		int nelems, int direction)
 {
-	dma_sync_sg_for_device(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+	dma_sync_sg_for_device(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, direction);
 }
 
 static inline int
diff -r 2fa13972604f include/asm-i386/dma-mapping.h
--- a/include/asm-i386/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-i386/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -19,7 +19,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	if (direction == DMA_NONE)
 		BUG();
@@ -30,7 +30,7 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	if (direction == DMA_NONE)
 		BUG();
@@ -38,7 +38,7 @@
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	int i;
 
@@ -58,7 +58,7 @@
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-	     size_t size, enum dma_data_direction direction)
+	     size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	return page_to_phys(page) + offset;
@@ -66,7 +66,7 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -74,20 +74,20 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+			int direction)
 {
 	flush_write_buffers();
 }
@@ -95,27 +95,27 @@
 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
+			      int direction)
 {
 }
 
 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
+				 int direction)
 {
 	flush_write_buffers();
 }
 
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 }
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+		    int direction)
 {
 	flush_write_buffers();
 }
@@ -163,7 +163,7 @@
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	flush_write_buffers();
 }
diff -r 2fa13972604f include/asm-ia64/dma-mapping.h
--- a/include/asm-ia64/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-ia64/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -51,7 +51,7 @@
 extern int dma_get_cache_alignment(void);
 
 static inline void
-dma_cache_sync (void *vaddr, size_t size, enum dma_data_direction dir)
+dma_cache_sync (void *vaddr, size_t size, int dir)
 {
 	/*
 	 * IA-64 is cache-coherent, so this is mostly a no-op.  However, we do need to
diff -r 2fa13972604f include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-ia64/machvec.h	Sun Feb 12 15:13:35 2006
@@ -12,6 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <asm-generic/swiotlb.h>
 
 /* forward declarations: */
 struct device;
diff -r 2fa13972604f include/asm-mips/dma-mapping.h
--- a/include/asm-mips/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-mips/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -17,31 +17,31 @@
 			 void *vaddr, dma_addr_t dma_handle);
 
 extern dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction);
+	int direction);
 extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction);
+	size_t size, int direction);
 extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction);
+	int direction);
 extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction);
+	unsigned long offset, size_t size, int direction);
 extern void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-	size_t size, enum dma_data_direction direction);
+	size_t size, int direction);
 extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-	int nhwentries, enum dma_data_direction direction);
+	int nhwentries, int direction);
 extern void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction);
+	size_t size, int direction);
 extern void dma_sync_single_for_device(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction);
+	dma_addr_t dma_handle, size_t size, int direction);
 extern void dma_sync_single_range_for_cpu(struct device *dev,
 	dma_addr_t dma_handle, unsigned long offset, size_t size,
-	enum dma_data_direction direction);
+	int direction);
 extern void dma_sync_single_range_for_device(struct device *dev,
 	dma_addr_t dma_handle, unsigned long offset, size_t size,
-	enum dma_data_direction direction);
+	int direction);
 extern void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-	int nelems, enum dma_data_direction direction);
+	int nelems, int direction);
 extern void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-	int nelems, enum dma_data_direction direction);
+	int nelems, int direction);
 extern int dma_mapping_error(dma_addr_t dma_addr);
 extern int dma_supported(struct device *dev, u64 mask);
 
@@ -66,7 +66,7 @@
 extern int dma_is_consistent(dma_addr_t dma_addr);
 
 extern void dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction);
+	       int direction);
 
 #define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
 
diff -r 2fa13972604f include/asm-parisc/dma-mapping.h
--- a/include/asm-parisc/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-parisc/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -12,14 +12,14 @@
 	void *(*alloc_consistent)(struct device *dev, size_t size, dma_addr_t *iova, gfp_t flag);
 	void *(*alloc_noncoherent)(struct device *dev, size_t size, dma_addr_t *iova, gfp_t flag);
 	void (*free_consistent)(struct device *dev, size_t size, void *vaddr, dma_addr_t iova);
-	dma_addr_t (*map_single)(struct device *dev, void *addr, size_t size, enum dma_data_direction direction);
-	void (*unmap_single)(struct device *dev, dma_addr_t iova, size_t size, enum dma_data_direction direction);
-	int  (*map_sg)(struct device *dev, struct scatterlist *sg, int nents, enum dma_data_direction direction);
-	void (*unmap_sg)(struct device *dev, struct scatterlist *sg, int nhwents, enum dma_data_direction direction);
-	void (*dma_sync_single_for_cpu)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, enum dma_data_direction direction);
-	void (*dma_sync_single_for_device)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, enum dma_data_direction direction);
-	void (*dma_sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
-	void (*dma_sync_sg_for_device)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
+	dma_addr_t (*map_single)(struct device *dev, void *addr, size_t size, int direction);
+	void (*unmap_single)(struct device *dev, dma_addr_t iova, size_t size, int direction);
+	int  (*map_sg)(struct device *dev, struct scatterlist *sg, int nents, int direction);
+	void (*unmap_sg)(struct device *dev, struct scatterlist *sg, int nhwents, int direction);
+	void (*dma_sync_single_for_cpu)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, int direction);
+	void (*dma_sync_single_for_device)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, int direction);
+	void (*dma_sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg, int nelems, int direction);
+	void (*dma_sync_sg_for_device)(struct device *dev, struct scatterlist *sg, int nelems, int direction);
 };
 
 /*
@@ -77,42 +77,42 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	return hppa_dma_ops->map_single(dev, ptr, size, direction);
 }
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	hppa_dma_ops->unmap_single(dev, dma_addr, size, direction);
 }
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	return hppa_dma_ops->map_sg(dev, sg, nents, direction);
 }
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	hppa_dma_ops->unmap_sg(dev, sg, nhwentries, direction);
 }
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-	     size_t size, enum dma_data_direction direction)
+	     size_t size, int direction)
 {
 	return dma_map_single(dev, (page_address(page) + (offset)), size, direction);
 }
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	dma_unmap_single(dev, dma_address, size, direction);
 }
@@ -120,7 +120,7 @@
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_cpu)
 		hppa_dma_ops->dma_sync_single_for_cpu(dev, dma_handle, 0, size, direction);
@@ -128,7 +128,7 @@
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_device)
 		hppa_dma_ops->dma_sync_single_for_device(dev, dma_handle, 0, size, direction);
@@ -137,7 +137,7 @@
 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_cpu)
 		hppa_dma_ops->dma_sync_single_for_cpu(dev, dma_handle, offset, size, direction);
@@ -146,7 +146,7 @@
 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_device)
 		hppa_dma_ops->dma_sync_single_for_device(dev, dma_handle, offset, size, direction);
@@ -154,7 +154,7 @@
 
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	if(hppa_dma_ops->dma_sync_sg_for_cpu)
 		hppa_dma_ops->dma_sync_sg_for_cpu(dev, sg, nelems, direction);
@@ -162,7 +162,7 @@
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	if(hppa_dma_ops->dma_sync_sg_for_device)
 		hppa_dma_ops->dma_sync_sg_for_device(dev, sg, nelems, direction);
@@ -199,7 +199,7 @@
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_cpu)
 		flush_kernel_dcache_range((unsigned long)vaddr, size);
diff -r 2fa13972604f include/asm-powerpc/dma-mapping.h
--- a/include/asm-powerpc/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-powerpc/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -53,18 +53,18 @@
 extern void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_handle);
 extern dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
-		size_t size, enum dma_data_direction direction);
+		size_t size, int direction);
 extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction);
+		size_t size, int direction);
 extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction);
+		int direction);
 extern void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-		size_t size, enum dma_data_direction direction);
+		size_t size, int direction);
 extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction direction);
+		int direction);
 extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nhwentries, enum dma_data_direction direction);
+		int nhwentries, int direction);
 
 #else /* CONFIG_PPC64 */
 
@@ -118,7 +118,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -133,7 +133,7 @@
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -147,7 +147,7 @@
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	int i;
 
@@ -169,7 +169,7 @@
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	__dma_sync(bus_to_virt(dma_handle), size, direction);
@@ -177,7 +177,7 @@
 
 static inline void dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	__dma_sync(bus_to_virt(dma_handle), size, direction);
@@ -185,7 +185,7 @@
 
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sg, int nents,
-		enum dma_data_direction direction)
+		int direction)
 {
 	int i;
 
@@ -197,7 +197,7 @@
 
 static inline void dma_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sg, int nents,
-		enum dma_data_direction direction)
+		int direction)
 {
 	int i;
 
@@ -241,7 +241,7 @@
 
 static inline void dma_sync_single_range_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	/* just sync everything for now */
 	dma_sync_single_for_cpu(dev, dma_handle, offset + size, direction);
@@ -249,14 +249,14 @@
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
 		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	/* just sync everything for now */
 	dma_sync_single_for_device(dev, dma_handle, offset + size, direction);
 }
 
 static inline void dma_cache_sync(void *vaddr, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	__dma_sync(vaddr, size, (int)direction);
@@ -271,13 +271,13 @@
 	void		(*free_coherent)(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
-				size_t size, enum dma_data_direction direction);
+				size_t size, int direction);
 	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction direction);
+				size_t size, int direction);
 	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
+				int nents, int direction);
 	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
+				int nents, int direction);
 	int		(*dma_supported)(struct device *dev, u64 mask);
 	int		(*dac_dma_supported)(struct device *dev, u64 mask);
 };
diff -r 2fa13972604f include/asm-powerpc/iommu.h
--- a/include/asm-powerpc/iommu.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-powerpc/iommu.h	Sun Feb 12 15:13:35 2006
@@ -71,18 +71,18 @@
 
 extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction direction);
+		int direction);
 extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction);
+		int nelems, int direction);
 
 extern void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
 		dma_addr_t *dma_handle, gfp_t flag);
 extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		void *vaddr, dma_addr_t dma_handle);
 extern dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
-		size_t size, enum dma_data_direction direction);
+		size_t size, int direction);
 extern void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction);
+		size_t size, int direction);
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
diff -r 2fa13972604f include/asm-powerpc/machdep.h
--- a/include/asm-powerpc/machdep.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-powerpc/machdep.h	Sun Feb 12 15:13:35 2006
@@ -77,7 +77,7 @@
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
-				     enum dma_data_direction direction);
+				     int direction);
 	void		(*tce_free)(struct iommu_table *tbl,
 				    long index,
 				    long npages);
diff -r 2fa13972604f include/asm-sh/dma-mapping.h
--- a/include/asm-sh/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-sh/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -55,14 +55,14 @@
 }
 
 static inline void dma_cache_sync(void *vaddr, size_t size,
-				  enum dma_data_direction dir)
+				  int dir)
 {
 	consistent_sync(vaddr, size, (int)dir);
 }
 
 static inline dma_addr_t dma_map_single(struct device *dev,
 					void *ptr, size_t size,
-					enum dma_data_direction dir)
+					int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -76,7 +76,7 @@
 #define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
 
 static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+			     int nents, int dir)
 {
 	int i;
 
@@ -95,19 +95,19 @@
 
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
-				      enum dma_data_direction dir)
+				      int dir)
 {
 	return dma_map_single(dev, page_address(page) + offset, size, dir);
 }
 
 static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-				  size_t size, enum dma_data_direction dir)
+				  size_t size, int dir)
 {
 	dma_unmap_single(dev, dma_address, size, dir);
 }
 
 static inline void dma_sync_single(struct device *dev, dma_addr_t dma_handle,
-				   size_t size, enum dma_data_direction dir)
+				   size_t size, int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -119,7 +119,7 @@
 static inline void dma_sync_single_range(struct device *dev,
 					 dma_addr_t dma_handle,
 					 unsigned long offset, size_t size,
-					 enum dma_data_direction dir)
+					 int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -129,7 +129,7 @@
 }
 
 static inline void dma_sync_sg(struct device *dev, struct scatterlist *sg,
-			       int nelems, enum dma_data_direction dir)
+			       int nelems, int dir)
 {
 	int i;
 
@@ -144,22 +144,22 @@
 
 static void dma_sync_single_for_cpu(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
-				    enum dma_data_direction dir)
+				    int dir)
 	__attribute__ ((alias("dma_sync_single")));
 
 static void dma_sync_single_for_device(struct device *dev,
 				       dma_addr_t dma_handle, size_t size,
-				       enum dma_data_direction dir)
+				       int dir)
 	__attribute__ ((alias("dma_sync_single")));
 
 static void dma_sync_sg_for_cpu(struct device *dev,
 				struct scatterlist *sg, int nelems,
-				enum dma_data_direction dir)
+				int dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
 static void dma_sync_sg_for_device(struct device *dev,
 				   struct scatterlist *sg, int nelems,
-				   enum dma_data_direction dir)
+				   int dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
 static inline int dma_get_cache_alignment(void)
diff -r 2fa13972604f include/asm-sh64/dma-mapping.h
--- a/include/asm-sh64/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-sh64/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -37,14 +37,14 @@
 }
 
 static inline void dma_cache_sync(void *vaddr, size_t size,
-				  enum dma_data_direction dir)
+				  int dir)
 {
 	dma_cache_wback_inv((unsigned long)vaddr, size);
 }
 
 static inline dma_addr_t dma_map_single(struct device *dev,
 					void *ptr, size_t size,
-					enum dma_data_direction dir)
+					int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -58,7 +58,7 @@
 #define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
 
 static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+			     int nents, int dir)
 {
 	int i;
 
@@ -77,19 +77,19 @@
 
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
-				      enum dma_data_direction dir)
+				      int dir)
 {
 	return dma_map_single(dev, page_address(page) + offset, size, dir);
 }
 
 static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-				  size_t size, enum dma_data_direction dir)
+				  size_t size, int dir)
 {
 	dma_unmap_single(dev, dma_address, size, dir);
 }
 
 static inline void dma_sync_single(struct device *dev, dma_addr_t dma_handle,
-				   size_t size, enum dma_data_direction dir)
+				   size_t size, int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -101,7 +101,7 @@
 static inline void dma_sync_single_range(struct device *dev,
 					 dma_addr_t dma_handle,
 					 unsigned long offset, size_t size,
-					 enum dma_data_direction dir)
+					 int dir)
 {
 #if defined(CONFIG_PCI) && !defined(CONFIG_SH_PCIDMA_NONCOHERENT)
 	if (dev->bus == &pci_bus_type)
@@ -111,7 +111,7 @@
 }
 
 static inline void dma_sync_sg(struct device *dev, struct scatterlist *sg,
-			       int nelems, enum dma_data_direction dir)
+			       int nelems, int dir)
 {
 	int i;
 
@@ -126,22 +126,22 @@
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
 					   dma_addr_t dma_handle, size_t size,
-					   enum dma_data_direction dir)
+					   int dir)
 	__attribute__ ((alias("dma_sync_single")));
 
 static inline void dma_sync_single_for_device(struct device *dev,
 					   dma_addr_t dma_handle, size_t size,
-					   enum dma_data_direction dir)
+					   int dir)
 	__attribute__ ((alias("dma_sync_single")));
 
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 				       struct scatterlist *sg, int nelems,
-				       enum dma_data_direction dir)
+				       int dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
 static inline void dma_sync_sg_for_device(struct device *dev,
 				       struct scatterlist *sg, int nelems,
-				       enum dma_data_direction dir)
+				       int dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
 static inline int dma_get_cache_alignment(void)
diff -r 2fa13972604f include/asm-um/dma-mapping.h
--- a/include/asm-um/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-um/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -34,7 +34,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG();
 	return(0);
@@ -42,7 +42,7 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG();
 }
@@ -50,7 +50,7 @@
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG();
 	return(0);
@@ -58,14 +58,14 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG();
 }
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	BUG();
 	return(0);
@@ -73,21 +73,21 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
-	    enum dma_data_direction direction)
+	    int direction)
 {
 	BUG();
 }
@@ -106,14 +106,14 @@
 static inline void
 dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 	BUG();
 }
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG();
 }
diff -r 2fa13972604f include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-x86_64/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -176,7 +176,7 @@
 extern int dma_set_mask(struct device *dev, u64 mask);
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction dir)
+dma_cache_sync(void *vaddr, size_t size, int dir)
 {
 	flush_write_buffers();
 }
diff -r 2fa13972604f include/asm-xtensa/dma-mapping.h
--- a/include/asm-xtensa/dma-mapping.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-xtensa/dma-mapping.h	Sun Feb 12 15:13:35 2006
@@ -35,7 +35,7 @@
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	consistent_sync(ptr, size, direction);
@@ -44,14 +44,14 @@
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+		 int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+	   int direction)
 {
 	int i;
 
@@ -70,7 +70,7 @@
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-	     size_t size, enum dma_data_direction direction)
+	     size_t size, int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 	return (dma_addr_t)(page_to_pfn(page)) * PAGE_SIZE + offset;
@@ -78,7 +78,7 @@
 
 static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
@@ -86,21 +86,21 @@
 
 static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+	     int direction)
 {
 	BUG_ON(direction == DMA_NONE);
 }
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	consistent_sync((void *)bus_to_virt(dma_handle), size, direction);
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		int direction)
 {
 	consistent_sync((void *)bus_to_virt(dma_handle), size, direction);
 }
@@ -108,7 +108,7 @@
 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 
 	consistent_sync((void *)bus_to_virt(dma_handle)+offset,size,direction);
@@ -117,14 +117,14 @@
 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 		      unsigned long offset, size_t size,
-		      enum dma_data_direction direction)
+		      int direction)
 {
 
 	consistent_sync((void *)bus_to_virt(dma_handle)+offset,size,direction);
 }
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction dir)
+		 int dir)
 {
 	int i;
 	for (i = 0; i < nelems; i++, sg++)
@@ -134,7 +134,7 @@
 
 static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction dir)
+		 int dir)
 {
 	int i;
 	for (i = 0; i < nelems; i++, sg++)
@@ -174,7 +174,7 @@
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+	       int direction)
 {
 	consistent_sync(vaddr, size, direction);
 }
diff -r 2fa13972604f include/linux/i2o.h
--- a/include/linux/i2o.h	Wed Feb  8 17:58:27 2006
+++ b/include/linux/i2o.h	Sun Feb 12 15:13:35 2006
@@ -744,7 +744,7 @@
  */
 static inline dma_addr_t i2o_dma_map_single(struct i2o_controller *c, void *ptr,
 					    size_t size,
-					    enum dma_data_direction direction,
+					    int direction,
 					    u32 ** sg_ptr)
 {
 	u32 sg_flags;
@@ -799,7 +799,7 @@
  */
 static inline int i2o_dma_map_sg(struct i2o_controller *c,
 				 struct scatterlist *sg, int sg_count,
-				 enum dma_data_direction direction,
+				 int direction,
 				 u32 ** sg_ptr)
 {
 	u32 sg_flags;
diff -r 2fa13972604f include/scsi/scsi_cmnd.h
--- a/include/scsi/scsi_cmnd.h	Wed Feb  8 17:58:27 2006
+++ b/include/scsi/scsi_cmnd.h	Sun Feb 12 15:13:35 2006
@@ -65,8 +65,8 @@
 
 	unsigned char cmd_len;
 	unsigned char old_cmd_len;
-	enum dma_data_direction sc_data_direction;
-	enum dma_data_direction sc_old_data_direction;
+	int sc_data_direction;
+	int sc_old_data_direction;
 
 	/* These elements define the operation we are about to perform */
 #define MAX_COMMAND_SIZE	16
diff -r 2fa13972604f include/scsi/scsi_request.h
--- a/include/scsi/scsi_request.h	Wed Feb  8 17:58:27 2006
+++ b/include/scsi/scsi_request.h	Sun Feb 12 15:13:35 2006
@@ -32,7 +32,7 @@
 	unsigned sr_bufflen;	/* Size of data buffer */
 	void *sr_buffer;		/* Data buffer */
 	int sr_allowed;
-	enum dma_data_direction sr_data_direction;
+	int sr_data_direction;
 	unsigned char sr_cmd_len;
 	unsigned char sr_cmnd[MAX_COMMAND_SIZE];
 	void (*sr_done) (struct scsi_cmnd *);	/* Mid-level done function */
