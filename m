Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756350AbWKWRZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbWKWRZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757441AbWKWRZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:25:20 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:17313 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1756350AbWKWRZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:25:17 -0500
Date: Thu, 23 Nov 2006 17:24:51 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Add struct dev pointer to dma_is_consistent()
Message-ID: <20061123172451.GA5679@linux-mips.org>
References: <20061123150312.GA32406@linux-mips.org> <1164297574.2829.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164297574.2829.9.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So here's take 2 integrating James' suggestions.

Add struct dev pointer to dma_is_consistent()

dma_is_consistent() is ill-designed in that it does not have a struct
device pointer argument which makes proper support for systems that consist
of a mix of coherent and non-coherent DMA devices hard.  Change
dma_is_consistent to take a struct device pointer as first argument and fix
the sole caller to pass it.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 Documentation/DMA-API.txt         |    6 +++---
 arch/mips/mm/dma-coherent.c       |    2 +-
 arch/mips/mm/dma-ip27.c           |    2 +-
 arch/mips/mm/dma-ip32.c           |    2 +-
 arch/mips/mm/dma-noncoherent.c    |    2 +-
 drivers/scsi/53c700.c             |    2 +-
 include/asm-alpha/dma-mapping.h   |    2 +-
 include/asm-arm/dma-mapping.h     |    2 +-
 include/asm-avr32/dma-mapping.h   |    2 +-
 include/asm-cris/dma-mapping.h    |    2 +-
 include/asm-frv/dma-mapping.h     |    2 +-
 include/asm-generic/dma-mapping.h |    2 +-
 include/asm-i386/dma-mapping.h    |    2 +-
 include/asm-ia64/dma-mapping.h    |    2 +-
 include/asm-m68k/dma-mapping.h    |    2 +-
 include/asm-mips/dma-mapping.h    |    2 +-
 include/asm-parisc/dma-mapping.h  |    2 +-
 include/asm-powerpc/dma-mapping.h |    4 ++--
 include/asm-sparc64/dma-mapping.h |    2 +-
 include/asm-um/dma-mapping.h      |    2 +-
 include/asm-x86_64/dma-mapping.h  |    2 +-
 include/asm-xtensa/dma-mapping.h  |    2 +-
 22 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 2ffb0d6..6e826f4 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -431,10 +431,10 @@ be identical to those passed in (and ret
 dma_alloc_noncoherent()).
 
 int
-dma_is_consistent(dma_addr_t dma_handle)
+dma_is_consistent(struct device *dev, dma_addr_t dma_handle)
 
-returns true if the memory pointed to by the dma_handle is actually
-consistent.
+returns true if the device dev is performing consistent DMA on the memory
+area pointed to by the dma_handle.
 
 int
 dma_get_cache_alignment(void)
diff --git a/arch/mips/mm/dma-coherent.c b/arch/mips/mm/dma-coherent.c
index 7fa5fd1..18bc83e 100644
--- a/arch/mips/mm/dma-coherent.c
+++ b/arch/mips/mm/dma-coherent.c
@@ -190,7 +190,7 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
+int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 1;
 }
diff --git a/arch/mips/mm/dma-ip27.c b/arch/mips/mm/dma-ip27.c
index 8da19fd..8e9a5a8 100644
--- a/arch/mips/mm/dma-ip27.c
+++ b/arch/mips/mm/dma-ip27.c
@@ -197,7 +197,7 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
+int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 1;
 }
diff --git a/arch/mips/mm/dma-ip32.c b/arch/mips/mm/dma-ip32.c
index ec54ed0..08720a4 100644
--- a/arch/mips/mm/dma-ip32.c
+++ b/arch/mips/mm/dma-ip32.c
@@ -363,7 +363,7 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
+int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 1;
 }
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 2eeffe5..4a3efc6 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -299,7 +299,7 @@ int dma_supported(struct device *dev, u6
 
 EXPORT_SYMBOL(dma_supported);
 
-int dma_is_consistent(dma_addr_t dma_addr)
+int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 1;
 }
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 562432d..3741f92 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -313,7 +313,7 @@ NCR_700_detect(struct scsi_host_template
 	hostdata->status = memory + STATUS_OFFSET;
 	/* all of these offsets are L1_CACHE_BYTES separated.  It is fatal
 	 * if this isn't sufficient separation to avoid dma flushing issues */
-	BUG_ON(!dma_is_consistent(pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
+	BUG_ON(!dma_is_consistent(hostdata->dev, pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
 	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
 	hostdata->dev = dev;
 
diff --git a/include/asm-alpha/dma-mapping.h b/include/asm-alpha/dma-mapping.h
index b9ff4d8..b274bf6 100644
--- a/include/asm-alpha/dma-mapping.h
+++ b/include/asm-alpha/dma-mapping.h
@@ -51,7 +51,7 @@ #endif	/* !CONFIG_PCI */
 
 #define dma_alloc_noncoherent(d, s, h, f)	dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h)	dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(dev)			(1)
+#define dma_is_consistent(d, h)			(1)
 
 int dma_set_mask(struct device *dev, u64 mask);
 
diff --git a/include/asm-arm/dma-mapping.h b/include/asm-arm/dma-mapping.h
index 55eb4dc..f3e0327 100644
--- a/include/asm-arm/dma-mapping.h
+++ b/include/asm-arm/dma-mapping.h
@@ -44,7 +44,7 @@ static inline int dma_get_cache_alignmen
 	return 32;
 }
 
-static inline int dma_is_consistent(dma_addr_t handle)
+static inline int dma_is_consistent(struct device *dev, dma_addr_t handle)
 {
 	return !!arch_is_coherent();
 }
diff --git a/include/asm-avr32/dma-mapping.h b/include/asm-avr32/dma-mapping.h
index 4c40cb4..44630be 100644
--- a/include/asm-avr32/dma-mapping.h
+++ b/include/asm-avr32/dma-mapping.h
@@ -307,7 +307,7 @@ dma_sync_sg_for_device(struct device *de
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
-static inline int dma_is_consistent(dma_addr_t dma_addr)
+static inline int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 1;
 }
diff --git a/include/asm-cris/dma-mapping.h b/include/asm-cris/dma-mapping.h
index cbf1a98..af704fd 100644
--- a/include/asm-cris/dma-mapping.h
+++ b/include/asm-cris/dma-mapping.h
@@ -156,7 +156,7 @@ dma_get_cache_alignment(void)
 	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
diff --git a/include/asm-frv/dma-mapping.h b/include/asm-frv/dma-mapping.h
index e9fc1d4..7b97fc7 100644
--- a/include/asm-frv/dma-mapping.h
+++ b/include/asm-frv/dma-mapping.h
@@ -172,7 +172,7 @@ int dma_get_cache_alignment(void)
 	return 1 << L1_CACHE_SHIFT;
 }
 
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline
 void dma_cache_sync(void *vaddr, size_t size,
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index b541e48..b9be3fc 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -266,7 +266,7 @@ #endif
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
index 81999a3..7da64c9 100644
--- a/include/asm-i386/dma-mapping.h
+++ b/include/asm-i386/dma-mapping.h
@@ -156,7 +156,7 @@ dma_get_cache_alignment(void)
 	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
diff --git a/include/asm-ia64/dma-mapping.h b/include/asm-ia64/dma-mapping.h
index 99a8f8e..4b075bc 100644
--- a/include/asm-ia64/dma-mapping.h
+++ b/include/asm-ia64/dma-mapping.h
@@ -59,6 +59,6 @@ dma_cache_sync (void *vaddr, size_t size
 	mb();
 }
 
-#define dma_is_consistent(dma_handle)	(1)	/* all we do is coherent memory... */
+#define dma_is_consistent(d, h)	(1)	/* all we do is coherent memory... */
 
 #endif /* _ASM_IA64_DMA_MAPPING_H */
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index d90d841..efc89c1 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -21,7 +21,7 @@ static inline int dma_get_cache_alignmen
 	return 1 << L1_CACHE_SHIFT;
 }
 
-static inline int dma_is_consistent(dma_addr_t dma_addr)
+static inline int dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return 0;
 }
diff --git a/include/asm-mips/dma-mapping.h b/include/asm-mips/dma-mapping.h
index 4328863..e17f70d 100644
--- a/include/asm-mips/dma-mapping.h
+++ b/include/asm-mips/dma-mapping.h
@@ -63,7 +63,7 @@ dma_get_cache_alignment(void)
 	return 128;
 }
 
-extern int dma_is_consistent(dma_addr_t dma_addr);
+extern int dma_is_consistent(struct device *dev, dma_addr_t dma_addr);
 
 extern void dma_cache_sync(void *vaddr, size_t size,
 	       enum dma_data_direction direction);
diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-mapping.h
index 1e387e1..c40d48a 100644
--- a/include/asm-parisc/dma-mapping.h
+++ b/include/asm-parisc/dma-mapping.h
@@ -191,7 +191,7 @@ dma_get_cache_alignment(void)
 }
 
 static inline int
-dma_is_consistent(dma_addr_t dma_addr)
+dma_is_consistent(struct device *dev, dma_addr_t dma_addr)
 {
 	return (hppa_dma_ops->dma_sync_single_for_cpu == NULL);
 }
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 2ab9baf..3487a4b 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -218,9 +218,9 @@ #endif
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #ifdef CONFIG_NOT_COHERENT_CACHE
-#define dma_is_consistent(d)	(0)
+#define dma_is_consistent(d, h)	(0)
 #else
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 #endif
 
 static inline int dma_get_cache_alignment(void)
diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index 27c46fb..5fe0072 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -181,7 +181,7 @@ #endif /* PCI */
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-um/dma-mapping.h b/include/asm-um/dma-mapping.h
index babd298..defb5b8 100644
--- a/include/asm-um/dma-mapping.h
+++ b/include/asm-um/dma-mapping.h
@@ -94,7 +94,7 @@ dma_sync_sg(struct device *dev, struct s
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d) (1)
+#define dma_is_consistent(d, h) (1)
 
 static inline int
 dma_get_cache_alignment(void)
diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
index 10174b1..c8cc488 100644
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -180,7 +180,7 @@ static inline int dma_get_cache_alignmen
 	return boot_cpu_data.x86_clflush_size;
 }
 
-#define dma_is_consistent(h) 1
+#define dma_is_consistent(d, h) 1
 
 extern int dma_set_mask(struct device *dev, u64 mask);
 
diff --git a/include/asm-xtensa/dma-mapping.h b/include/asm-xtensa/dma-mapping.h
index c39c91d..827d1df 100644
--- a/include/asm-xtensa/dma-mapping.h
+++ b/include/asm-xtensa/dma-mapping.h
@@ -170,7 +170,7 @@ dma_get_cache_alignment(void)
 	return L1_CACHE_BYTES;
 }
 
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d, h)	(1)
 
 static inline void
 dma_cache_sync(void *vaddr, size_t size,
