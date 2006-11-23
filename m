Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933657AbWKWPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657AbWKWPDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933723AbWKWPDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:03:24 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:57473 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S933657AbWKWPDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:03:23 -0500
Date: Thu, 23 Nov 2006 15:03:12 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Kill dma_is_consistent()
Message-ID: <20061123150312.GA32406@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dma_is_consistent() is ill-designed in that it does not have a struct device
argument which makes proper support for systems that consist of a mix of
coherent and non-coherent DMA devices hard.  There also is just a single
user, a BUG_ON() call in the 53c700.c SCSI driver so removing instead of
fixing it up seems to be the thing to do.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 Documentation/DMA-API.txt         |    6 ------
 arch/mips/mm/dma-coherent.c       |    7 -------
 arch/mips/mm/dma-ip27.c           |    7 -------
 arch/mips/mm/dma-ip32.c           |    7 -------
 arch/mips/mm/dma-noncoherent.c    |    7 -------
 drivers/scsi/53c700.c             |    3 ---
 include/asm-alpha/dma-mapping.h   |    1 -
 include/asm-arm/dma-mapping.h     |    5 -----
 include/asm-avr32/dma-mapping.h   |    5 -----
 include/asm-cris/dma-mapping.h    |    2 --
 include/asm-frv/dma-mapping.h     |    2 --
 include/asm-generic/dma-mapping.h |    1 -
 include/asm-i386/dma-mapping.h    |    2 --
 include/asm-ia64/dma-mapping.h    |    2 --
 include/asm-m68k/dma-mapping.h    |    5 -----
 include/asm-mips/dma-mapping.h    |    2 --
 include/asm-parisc/dma-mapping.h  |    6 ------
 include/asm-powerpc/dma-mapping.h |    5 -----
 include/asm-sparc64/dma-mapping.h |    1 -
 include/asm-um/dma-mapping.h      |    1 -
 include/asm-x86_64/dma-mapping.h  |    2 --
 include/asm-xtensa/dma-mapping.h  |    2 --
 22 files changed, 0 insertions(+), 81 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 2ffb0d6..9c68a03 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -431,12 +431,6 @@ be identical to those passed in (and ret
 dma_alloc_noncoherent()).
 
 int
-dma_is_consistent(dma_addr_t dma_handle)
-
-returns true if the memory pointed to by the dma_handle is actually
-consistent.
-
-int
 dma_get_cache_alignment(void)
 
 returns the processor cache alignment.  This is the absolute minimum
diff --git a/arch/mips/mm/dma-coherent.c b/arch/mips/mm/dma-coherent.c
index 7fa5fd1..e67c840 100644
--- a/arch/mips/mm/dma-coherent.c
+++ b/arch/mips/mm/dma-coherent.c
@@ -190,13 +190,6 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-EXPORT_SYMBOL(dma_is_consistent);
-
 void dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
diff --git a/arch/mips/mm/dma-ip27.c b/arch/mips/mm/dma-ip27.c
index 8da19fd..9347068 100644
--- a/arch/mips/mm/dma-ip27.c
+++ b/arch/mips/mm/dma-ip27.c
@@ -197,13 +197,6 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-EXPORT_SYMBOL(dma_is_consistent);
-
 void dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
diff --git a/arch/mips/mm/dma-ip32.c b/arch/mips/mm/dma-ip32.c
index ec54ed0..5884e26 100644
--- a/arch/mips/mm/dma-ip32.c
+++ b/arch/mips/mm/dma-ip32.c
@@ -363,13 +363,6 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-EXPORT_SYMBOL(dma_is_consistent);
-
 void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 2eeffe5..e6f4779 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -299,13 +299,6 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-EXPORT_SYMBOL(dma_is_consistent);
-
 void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 562432d..ad799b2 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -311,9 +311,6 @@ NCR_700_detect(struct scsi_host_template
 	hostdata->msgin = memory + MSGIN_OFFSET;
 	hostdata->msgout = memory + MSGOUT_OFFSET;
 	hostdata->status = memory + STATUS_OFFSET;
-	/* all of these offsets are L1_CACHE_BYTES separated.  It is fatal
-	 * if this isn't sufficient separation to avoid dma flushing issues */
-	BUG_ON(!dma_is_consistent(pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
 	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
 	hostdata->dev = dev;
 
diff --git a/include/asm-alpha/dma-mapping.h b/include/asm-alpha/dma-mapping.h
index b9ff4d8..2e02d64 100644
--- a/include/asm-alpha/dma-mapping.h
+++ b/include/asm-alpha/dma-mapping.h
@@ -51,7 +51,6 @@ #endif	/* !CONFIG_PCI */
 
 #define dma_alloc_noncoherent(d, s, h, f)	dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h)	dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(dev)			(1)
 
 int dma_set_mask(struct device *dev, u64 mask);
 
diff --git a/include/asm-arm/dma-mapping.h b/include/asm-arm/dma-mapping.h
index 55eb4dc..1bca4e3 100644
--- a/include/asm-arm/dma-mapping.h
+++ b/include/asm-arm/dma-mapping.h
@@ -44,11 +44,6 @@ static inline int dma_get_cache_alignmen
 	return 32;
 }
 
-static inline int dma_is_consistent(dma_addr_t handle)
-{
-	return !!arch_is_coherent();
-}
-
 /*
  * DMA errors are defined by all-bits-set in the DMA address.
  */
diff --git a/include/asm-avr32/dma-mapping.h b/include/asm-avr32/dma-mapping.h
index 4c40cb4..11b8bcb 100644
--- a/include/asm-avr32/dma-mapping.h
+++ b/include/asm-avr32/dma-mapping.h
@@ -307,11 +307,6 @@ dma_sync_sg_for_device(struct device *de
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
-static inline int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 1;
-}
-
 static inline int dma_get_cache_alignment(void)
 {
 	return boot_cpu_data.dcache.linesz;
diff --git a/include/asm-cris/dma-mapping.h b/include/asm-cris/dma-mapping.h
index cbf1a98..71be55d 100644
--- a/include/asm-cris/dma-mapping.h
+++ b/include/asm-cris/dma-mapping.h
@@ -156,8 +156,6 @@ dma_get_cache_alignment(void)
 	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
-#define dma_is_consistent(d)	(1)
-
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
diff --git a/include/asm-frv/dma-mapping.h b/include/asm-frv/dma-mapping.h
index e9fc1d4..d791019 100644
--- a/include/asm-frv/dma-mapping.h
+++ b/include/asm-frv/dma-mapping.h
@@ -172,8 +172,6 @@ int dma_get_cache_alignment(void)
 	return 1 << L1_CACHE_SHIFT;
 }
 
-#define dma_is_consistent(d)	(1)
-
 static inline
 void dma_cache_sync(void *vaddr, size_t size,
 		    enum dma_data_direction direction)
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index b541e48..7534c47 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -266,7 +266,6 @@ #endif
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d)	(1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
index 81999a3..15741f4 100644
--- a/include/asm-i386/dma-mapping.h
+++ b/include/asm-i386/dma-mapping.h
@@ -156,8 +156,6 @@ dma_get_cache_alignment(void)
 	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
-#define dma_is_consistent(d)	(1)
-
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
diff --git a/include/asm-ia64/dma-mapping.h b/include/asm-ia64/dma-mapping.h
index 99a8f8e..b6ebad9 100644
--- a/include/asm-ia64/dma-mapping.h
+++ b/include/asm-ia64/dma-mapping.h
@@ -59,6 +59,4 @@ dma_cache_sync (void *vaddr, size_t size
 	mb();
 }
 
-#define dma_is_consistent(dma_handle)	(1)	/* all we do is coherent memory... */
-
 #endif /* _ASM_IA64_DMA_MAPPING_H */
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index d90d841..8722b5a 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -21,11 +21,6 @@ static inline int dma_get_cache_alignmen
 	return 1 << L1_CACHE_SHIFT;
 }
 
-static inline int dma_is_consistent(dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 extern void *dma_alloc_coherent(struct device *, size_t,
 				dma_addr_t *, gfp_t);
 extern void dma_free_coherent(struct device *, size_t,
diff --git a/include/asm-mips/dma-mapping.h b/include/asm-mips/dma-mapping.h
index 4328863..531563b 100644
--- a/include/asm-mips/dma-mapping.h
+++ b/include/asm-mips/dma-mapping.h
@@ -63,8 +63,6 @@ dma_get_cache_alignment(void)
 	return 128;
 }
 
-extern int dma_is_consistent(dma_addr_t dma_addr);
-
 extern void dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-mapping.h
index 1e387e1..9e196bc 100644
--- a/include/asm-parisc/dma-mapping.h
+++ b/include/asm-parisc/dma-mapping.h
@@ -190,12 +190,6 @@ dma_get_cache_alignment(void)
 	return dcache_stride;
 }
 
-static inline int
-dma_is_consistent(dma_addr_t dma_addr)
-{
-	return (hppa_dma_ops->dma_sync_single_for_cpu == NULL);
-}
-
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 2ab9baf..e9e3ddd 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -217,11 +217,6 @@ #endif
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#ifdef CONFIG_NOT_COHERENT_CACHE
-#define dma_is_consistent(d)	(0)
-#else
-#define dma_is_consistent(d)	(1)
-#endif
 
 static inline int dma_get_cache_alignment(void)
 {
diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index 27c46fb..0b3cc27 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -181,7 +181,6 @@ #endif /* PCI */
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d)	(1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-um/dma-mapping.h b/include/asm-um/dma-mapping.h
index babd298..f472e6f 100644
--- a/include/asm-um/dma-mapping.h
+++ b/include/asm-um/dma-mapping.h
@@ -94,7 +94,6 @@ dma_sync_sg(struct device *dev, struct s
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d) (1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
index 10174b1..77ff135 100644
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -180,8 +180,6 @@ static inline int dma_get_cache_alignmen
 	return boot_cpu_data.x86_clflush_size;
 }
 
-#define dma_is_consistent(h) 1
-
 extern int dma_set_mask(struct device *dev, u64 mask);
 
 static inline void
diff --git a/include/asm-xtensa/dma-mapping.h b/include/asm-xtensa/dma-mapping.h
index c39c91d..cdd75af 100644
--- a/include/asm-xtensa/dma-mapping.h
+++ b/include/asm-xtensa/dma-mapping.h
@@ -170,8 +170,6 @@ dma_get_cache_alignment(void)
 	return L1_CACHE_BYTES;
 }
 
-#define dma_is_consistent(d)	(1)
-
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction)
