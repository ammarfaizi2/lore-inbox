Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJ2Vv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTJ2Vv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:51:27 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:24455 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261686AbTJ2VvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:51:07 -0500
Message-ID: <3FA037AF.8080100@pacbell.net>
Date: Wed, 29 Oct 2003 13:57:03 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [patch 2.6.0-test9] fix "generic dma" implementation bugs
Content-Type: multipart/mixed;
 boundary="------------000706050102090903000908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706050102090903000908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This should fix some arch-specific problems with the "generic DMA"
API implementations of dma_supported() and dma_set_mask():

  - dma_set_mask():
       * Removes pointless clones that were used on arm, i386,
         ia64, mips, and parisc
       * Also removed PCI-specific "asm-generic" version
       * Replaces them with a truly generic implementation that
         doesn't needlessly BUG() with non-PCI devices
       * Adds an ARCH_HAS_* hook to cope with sparc64-only
         restrictions (for ali5451 pci audio hardware);
         sparc64 retains a BUG() for non-pci hardware.
  - dma_supported():
       * Removes broken versions from arm, i386, mips; the
         broken versions never actually compared the two
         masks they were specified to compare:
            + arm only verified there was a device mask
            + i386/mips didn't even do that much
       * Also removed PCI-specific "asm-generic" version
       * Replaces them with a generic implementation that
            + doesn't needlessly BUG() with non-PCI devices
            + actually compares the two masks (bit-wise)
       * Adds an ARCH_HAS_* hook to handle ia64 and parisc,
         which already have their own fancy implementations

Sanity tested on x86/pc and ARM/PXA.

It's unfortunate that the arch-specific BUG() behavior only
started getting reported recently (test7?); and particularly
that the previous dma_supported() was so broken even on i386.
In consequence, it's not quite clear what bugs are being
hidden by the bogus masking.

- Dave


--------------000706050102090903000908
Content-Type: text/plain;
 name="dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma.patch"

--- 1.1/include/linux/dma-mapping.h	Sat Dec 21 20:37:05 2002
+++ edited/include/linux/dma-mapping.h	Tue Oct 28 10:56:19 2003
@@ -12,6 +12,37 @@
 
 #include <asm/dma-mapping.h>
 
+#ifndef	ARCH_HAS_DMA_SUPPORTED
+/*
+ * Returns true iff the device can support those DMA address bits on this
+ * system.  For example: to see if it can do DMA with any 64 bit address
+ * you could pass ~(u64)0 as the mask; to test for 24 bit bus mastering
+ * address support, pass 0x00ffffff as the mask.
+ */
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	return dev && dev->dma_mask && (mask & ~*dev->dma_mask) == 0;
+}
+#endif
+
+#ifndef	ARCH_HAS_DMA_SET_MASK
+/*
+ * Changes a driver's DMA mask; this can sometimes have side-effects.
+ * Only the lowest level of the driver stack may use this call;
+ * virtualized devices (higher in the stack) must never use this,
+ * since they don't directly control the hardware or DMA.
+ */
+static inline int
+dma_set_mask(struct device *dev, u64 mask)
+{
+	if (!dma_supported(dev, mask))
+		return -EIO;
+	*dev->dma_mask = mask;
+	return 0;
+}
+#endif
+
 #endif
 
 
--- 1.7/include/asm-arm/dma-mapping.h	Wed Aug 13 16:46:20 2003
+++ edited/include/asm-arm/dma-mapping.h	Sun Oct 26 11:23:01 2003
@@ -39,27 +39,6 @@
 #define dmadev_is_sa1111(dev)	(0)
 #endif
 
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask
- * to this function.
- */
-static inline int dma_supported(struct device *dev, u64 mask)
-{
-	return dev->dma_mask && *dev->dma_mask != 0;
-}
-
-static inline int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-
-	return 0;
-}
-
 static inline int dma_get_cache_alignment(void)
 {
 	return 32;
--- 1.4/include/asm-generic/dma-mapping.h	Mon Jan 13 14:37:47 2003
+++ edited/include/asm-generic/dma-mapping.h	Sun Oct 26 11:20:02 2003
@@ -13,22 +13,6 @@
 /* need struct page definitions */
 #include <linux/mm.h>
 
-static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_dma_supported(to_pci_dev(dev), mask);
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
-}
-
 static inline void *
 dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		   int flag)
--- 1.2/include/asm-i386/dma-mapping.h	Mon Jan 13 08:28:47 2003
+++ edited/include/asm-i386/dma-mapping.h	Sun Oct 26 11:23:23 2003
@@ -93,31 +93,6 @@
 }
 
 static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-        /*
-         * we fall back to GFP_DMA when the mask isn't all 1s,
-         * so we can't guarantee allocations that must be
-         * within a tighter range than GFP_DMA..
-         */
-        if(mask < 0x00ffffff)
-                return 0;
-
-	return 1;
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 mask)
-{
-	if(!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-
-	return 0;
-}
-
-static inline int
 dma_get_cache_alignment(void)
 {
 	/* no easy way to get cache size on all x86, so return the
--- 1.2/include/asm-ia64/dma-mapping.h	Sat May 10 02:28:47 2003
+++ edited/include/asm-ia64/dma-mapping.h	Sun Oct 26 11:25:01 2003
@@ -31,15 +31,7 @@
 	dma_sync_single(dev, dma_handle, size, dir)
 
 #define dma_supported		platform_dma_supported
-
-static inline int
-dma_set_mask (struct device *dev, u64 mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-	*dev->dma_mask = mask;
-	return 0;
-}
+#define ARCH_HAS_DMA_SUPPORTED
 
 static inline int
 dma_get_cache_alignment (void)
--- 1.2/include/asm-mips/dma-mapping.h	Mon Jul 28 04:57:50 2003
+++ edited/include/asm-mips/dma-mapping.h	Sun Oct 26 11:25:57 2003
@@ -181,31 +181,6 @@
 #endif /* CONFIG_MAPPED_DMA_IO  */
 
 static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < 0x00ffffff)
-		return 0;
-
-	return 1;
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 mask)
-{
-	if(!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-
-	return 0;
-}
-
-static inline int
 dma_get_cache_alignment(void)
 {
 	/* XXX Largest on any MIPS */
--- 1.4/include/asm-parisc/dma-mapping.h	Sat Sep 27 14:43:44 2003
+++ edited/include/asm-parisc/dma-mapping.h	Sun Oct 26 11:26:19 2003
@@ -142,21 +142,11 @@
 		hppa_dma_ops->dma_sync_sg(dev, sg, nelems, direction);
 }
 
+#define ARCH_HAS_DMA_SUPPORTED
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
 	return hppa_dma_ops->dma_supported(dev, mask);
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 mask)
-{
-	if(!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-
-	return 0;
 }
 
 static inline int
--- 1.2/include/asm-sparc64/dma-mapping.h	Wed Jul 23 00:04:55 2003
+++ edited/include/asm-sparc64/dma-mapping.h	Tue Oct 28 11:23:39 2003
@@ -2,4 +2,14 @@
 
 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+
+#define ARCH_HAS_DMA_SET_MASK
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+}
+
 #endif

--------------000706050102090903000908--

