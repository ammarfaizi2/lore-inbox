Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWFWSo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWFWSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFWSml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19151 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751923AbWFWSmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:02 -0400
Message-Id: <20060623183910.637335000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:01 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/21] Add the generic dma API functions
Content-Disposition: inline; filename=0005-M68K-Add-the-generic-dma-API-functions.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/apollo/Makefile      |    2 -
 arch/m68k/kernel/Makefile      |    4 +
 arch/m68k/kernel/dma.c         |  129 ++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sun3x_esp.c       |    8 +-
 include/asm-m68k/dma-mapping.h |   62 ++++++++++++++++++-
 include/asm-m68k/scatterlist.h |    9 +--
 6 files changed, 197 insertions(+), 17 deletions(-)
 create mode 100644 arch/m68k/kernel/dma.c

dd943413f9dbf0b60111fae8dfd37fbd2b71d80d
diff --git a/arch/m68k/apollo/Makefile b/arch/m68k/apollo/Makefile
index 39264f3..76a0579 100644
--- a/arch/m68k/apollo/Makefile
+++ b/arch/m68k/apollo/Makefile
@@ -2,4 +2,4 @@ #
 # Makefile for Linux arch/m68k/amiga source directory
 #
 
-obj-y		:= config.o dn_ints.o dma.o
+obj-y		:= config.o dn_ints.o
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index 458925c..dae6097 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -9,8 +9,8 @@ else
 endif
 extra-y	+= vmlinux.lds
 
-obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
-			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
+obj-y	:= entry.o process.o traps.o ints.o dma.o signal.o ptrace.o \
+	   sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
 
 obj-$(CONFIG_PCI)	+= bios32.o
 obj-$(CONFIG_MODULES)	+= module.o
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
new file mode 100644
index 0000000..fc449f8
--- /dev/null
+++ b/arch/m68k/kernel/dma.c
@@ -0,0 +1,129 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#undef DEBUG
+
+#include <linux/dma-mapping.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+
+#include <asm/pgalloc.h>
+#include <asm/scatterlist.h>
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *handle, int flag)
+{
+	struct page *page, **map;
+	pgprot_t pgprot;
+	void *addr;
+	int i, order;
+
+	pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	page = alloc_pages(flag, order);
+	if (!page)
+		return NULL;
+
+	*handle = page_to_phys(page);
+	map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
+	if (!map) {
+		__free_pages(page, order);
+		return NULL;
+	}
+	split_page(page, order);
+
+	order = 1 << order;
+	size >>= PAGE_SHIFT;
+	map[0] = page;
+	for (i = 1; i < size; i++)
+		map[i] = page + i;
+	for (; i < order; i++)
+		__free_page(page + i);
+	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
+	if (CPU_IS_040_OR_060)
+		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
+	else
+		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
+	addr = vmap(map, size, flag, pgprot);
+	kfree(map);
+
+	return addr;
+}
+EXPORT_SYMBOL(dma_alloc_coherent);
+
+void dma_free_coherent(struct device *dev, size_t size,
+		       void *addr, dma_addr_t handle)
+{
+	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
+	vfree(addr);
+}
+EXPORT_SYMBOL(dma_free_coherent);
+
+inline void dma_sync_single_for_device(struct device *dev, dma_addr_t handle, size_t size,
+				       enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		cache_push(handle, size);
+		break;
+	case DMA_FROM_DEVICE:
+		cache_clear(handle, size);
+		break;
+	default:
+		if (printk_ratelimit())
+			printk("dma_sync_single_for_device: unsupported dir %u\n", dir);
+		break;
+	}
+}
+EXPORT_SYMBOL(dma_sync_single_for_device);
+
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
+			    enum dma_data_direction dir)
+{
+	int i;
+
+	for (i = 0; i < nents; sg++, i++)
+		dma_sync_single_for_device(dev, sg->dma_address, sg->length, dir);
+}
+EXPORT_SYMBOL(dma_sync_sg_for_device);
+
+dma_addr_t dma_map_single(struct device *dev, void *addr, size_t size,
+			  enum dma_data_direction dir)
+{
+	dma_addr_t handle = virt_to_bus(addr);
+
+	dma_sync_single_for_device(dev, handle, size, dir);
+	return handle;
+}
+EXPORT_SYMBOL(dma_map_single);
+
+dma_addr_t dma_map_page(struct device *dev, struct page *page,
+			unsigned long offset, size_t size,
+			enum dma_data_direction dir)
+{
+	dma_addr_t handle = page_to_phys(page) + offset;
+
+	dma_sync_single_for_device(dev, handle, size, dir);
+	return handle;
+}
+EXPORT_SYMBOL(dma_map_page);
+
+int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	       enum dma_data_direction dir)
+{
+	int i;
+
+	for (i = 0; i < nents; sg++, i++) {
+		sg->dma_address = page_to_phys(sg->page) + sg->offset;
+		dma_sync_single_for_device(dev, sg->dma_address, sg->length, dir);
+	}
+	return nents;
+}
+EXPORT_SYMBOL(dma_map_sg);
diff --git a/drivers/scsi/sun3x_esp.c b/drivers/scsi/sun3x_esp.c
index cc990be..2e2c1eb 100644
--- a/drivers/scsi/sun3x_esp.c
+++ b/drivers/scsi/sun3x_esp.c
@@ -332,11 +332,11 @@ static void dma_mmu_get_scsi_sgl (struct
     struct scatterlist *sg = sp->SCp.buffer;
 
     while (sz >= 0) {
-	    sg[sz].dvma_address = dvma_map((unsigned long)page_address(sg[sz].page) +
+	    sg[sz].dma_address = dvma_map((unsigned long)page_address(sg[sz].page) +
 					   sg[sz].offset, sg[sz].length);
 	    sz--;
     }
-    sp->SCp.ptr=(char *)((unsigned long)sp->SCp.buffer->dvma_address);
+    sp->SCp.ptr=(char *)((unsigned long)sp->SCp.buffer->dma_address);
 }
 
 static void dma_mmu_release_scsi_one (struct NCR_ESP *esp, Scsi_Cmnd *sp)
@@ -350,14 +350,14 @@ static void dma_mmu_release_scsi_sgl (st
     struct scatterlist *sg = (struct scatterlist *)sp->buffer;
                         
     while(sz >= 0) {
-        dvma_unmap((char *)sg[sz].dvma_address);
+        dvma_unmap((char *)sg[sz].dma_address);
         sz--;
     }
 }
 
 static void dma_advance_sg (Scsi_Cmnd *sp)
 {
-    sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
+    sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dma_address);
 }
 
 static int sun3x_esp_release(struct Scsi_Host *instance)
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index dffd59c..4f8575e 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -1,11 +1,63 @@
 #ifndef _M68K_DMA_MAPPING_H
 #define _M68K_DMA_MAPPING_H
 
+struct scatterlist;
 
-#ifdef CONFIG_PCI
-#include <asm-generic/dma-mapping.h>
-#else
-#include <asm-generic/dma-mapping-broken.h>
-#endif
+static inline int dma_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+static inline int dma_set_mask(struct device *dev, u64 mask)
+{
+	return 0;
+}
+
+extern void *dma_alloc_coherent(struct device *, size_t,
+				dma_addr_t *, int);
+extern void dma_free_coherent(struct device *, size_t,
+			      void *, dma_addr_t);
+
+extern dma_addr_t dma_map_single(struct device *, void *, size_t,
+				 enum dma_data_direction);
+static inline void dma_unmap_single(struct device *dev, dma_addr_t addr,
+				    size_t size, enum dma_data_direction dir)
+{
+}
+
+extern dma_addr_t dma_map_page(struct device *, struct page *,
+			       unsigned long, size_t size,
+			       enum dma_data_direction);
+static inline void dma_unmap_page(struct device *dev, dma_addr_t address,
+				  size_t size, enum dma_data_direction dir)
+{
+}
+
+extern int dma_map_sg(struct device *, struct scatterlist *, int,
+		      enum dma_data_direction);
+static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nhwentries, enum dma_data_direction dir)
+{
+}
+
+extern void dma_sync_single_for_device(struct device *, dma_addr_t, size_t,
+				       enum dma_data_direction);
+extern void dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
+				   enum dma_data_direction);
+
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+					   size_t size, enum dma_data_direction dir)
+{
+}
+
+static inline void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+				       int nents, enum dma_data_direction dir)
+{
+}
+
+static inline int dma_mapping_error(dma_addr_t handle)
+{
+	return 0;
+}
 
 #endif  /* _M68K_DMA_MAPPING_H */
diff --git a/include/asm-m68k/scatterlist.h b/include/asm-m68k/scatterlist.h
index d7c9b5c..8e61226 100644
--- a/include/asm-m68k/scatterlist.h
+++ b/include/asm-m68k/scatterlist.h
@@ -2,18 +2,17 @@ #ifndef _M68K_SCATTERLIST_H
 #define _M68K_SCATTERLIST_H
 
 struct scatterlist {
-	/* These two are only valid if ADDRESS member of this
-	 * struct is NULL.
-	 */
 	struct page *page;
 	unsigned int offset;
-
 	unsigned int length;
 
-	__u32 dvma_address; /* A place to hang host-specific addresses at. */
+	__u32 dma_address;	/* A place to hang host-specific addresses at. */
 };
 
 /* This is bogus and should go away. */
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->length)
+
 #endif /* !(_M68K_SCATTERLIST_H) */
-- 
1.3.3

--

