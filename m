Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbULMLH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbULMLH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbULMLH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:07:29 -0500
Received: from sd291.sivit.org ([194.146.225.122]:51883 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262220AbULMLHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:07:05 -0500
Date: Mon, 13 Dec 2004 12:07:54 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] enable meye even when CONFIG_HIGHMEM64G=y
Message-ID: <20041213110753.GB3646@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The meye hardware needs to access the main memory for DMA using
32 bit addresses. The previous version of the meye driver used
dma_addr_t types to build those addresses and ensured that 
sizeof(dma_addr_t) = 4 by disabling HIGHMEM64G in Kconfig.

However, this way of doing it also makes meye unavailable on
some kernel configurations. As Arjan said previously, future Fedora
kernels will have HIGHMEM64G activated by default. Other distributions
may do the same and this will require meye users to recompile the
whole kernel.

The attached patch makes the meye driver use dma_addr_t addresses 
internally, but converts them to u32 before giving them to the
hardware.

Linus, Andrew, please apply.

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 Kconfig |    2 +-
 meye.c  |   29 +++++++++++++++++------------
 meye.h  |    4 ++--
 3 files changed, 20 insertions(+), 15 deletions(-)

===================================================================

===== drivers/media/video/Kconfig 1.31 vs edited =====
--- 1.31/drivers/media/video/Kconfig	2004-11-11 09:36:54 +01:00
+++ edited/drivers/media/video/Kconfig	2004-12-10 17:18:10 +01:00
@@ -220,7 +220,7 @@
 
 config VIDEO_MEYE
 	tristate "Sony Vaio Picturebook Motion Eye Video For Linux"
-	depends on VIDEO_DEV && PCI && SONYPI && !HIGHMEM64G
+	depends on VIDEO_DEV && PCI && SONYPI
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in
===== drivers/media/video/meye.h 1.22 vs edited =====
--- 1.22/drivers/media/video/meye.h	2004-11-19 14:52:58 +01:00
+++ edited/drivers/media/video/meye.h	2004-12-10 17:18:28 +01:00
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	 1
-#define MEYE_DRIVER_MINORVERSION	12
+#define MEYE_DRIVER_MINORVERSION	13
 
 #define MEYE_DRIVER_VERSION __stringify(MEYE_DRIVER_MAJORVERSION) "." \
 			    __stringify(MEYE_DRIVER_MINORVERSION)
@@ -294,7 +294,7 @@
 	u8 mchip_fnum;			/* current mchip frame number */
 	unsigned char __iomem *mchip_mmregs;/* mchip: memory mapped registers */
 	u8 *mchip_ptable[MCHIP_NB_PAGES];/* mchip: ptable */
-	dma_addr_t *mchip_ptable_toc;	/* mchip: ptable toc */
+	void *mchip_ptable_toc;		/* mchip: ptable toc */
 	dma_addr_t mchip_dmahandle;	/* mchip: dma handle to ptable toc */
 	unsigned char *grab_fbuffer;	/* capture framebuffer */
 	unsigned char *grab_temp;	/* temporary buffer */
===== drivers/media/video/meye.c 1.37 vs edited =====
--- 1.37/drivers/media/video/meye.c	2004-11-19 08:03:14 +01:00
+++ edited/drivers/media/video/meye.c	2004-12-13 12:04:09 +01:00
@@ -110,19 +110,20 @@
 /*
  * return a page table pointing to N pages of locked memory
  *
- * NOTE: The meye device expects dma_addr_t size to be 32 bits
- * (the toc must be exactly 1024 entries each of them being 4 bytes
- * in size, the whole result being 4096 bytes). We're using here
- * dma_addr_t for correctness but the compilation of this driver is
- * disabled for HIGHMEM64G=y, where sizeof(dma_addr_t) != 4
+ * NOTE: The meye device expects DMA addresses on 32 bits, we build
+ * a table of 1024 entries = 4 bytes * 1024 = 4096 bytes.
  */
 static int ptable_alloc(void)
 {
-	dma_addr_t *pt;
+	u32 *pt;
 	int i;
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 
+	/* give only 32 bit DMA addresses */
+	if (!dma_set_mask(&meye.mchip_dev->dev, 0xffffffff))
+		return -1;
+
 	meye.mchip_ptable_toc = dma_alloc_coherent(&meye.mchip_dev->dev,
 						   PAGE_SIZE,
 						   &meye.mchip_dmahandle,
@@ -134,17 +135,19 @@
 
 	pt = meye.mchip_ptable_toc;
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
+		dma_addr_t dma;
 		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev,
 							  PAGE_SIZE,
-							  pt,
+							  &dma,
 							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
 			pt = meye.mchip_ptable_toc;
 			for (j = 0; j < i; ++j) {
+				dma = (dma_addr_t) *pt;
 				dma_free_coherent(&meye.mchip_dev->dev,
 						  PAGE_SIZE,
-						  meye.mchip_ptable[j], *pt);
+						  meye.mchip_ptable[j], dma);
 				pt++;
 			}
 			dma_free_coherent(&meye.mchip_dev->dev,
@@ -155,6 +158,7 @@
 			meye.mchip_dmahandle = 0;
 			return -1;
 		}
+		*pt = (u32) dma;
 		pt++;
 	}
 	return 0;
@@ -162,15 +166,16 @@
 
 static void ptable_free(void)
 {
-	dma_addr_t *pt;
+	u32 *pt;
 	int i;
 
 	pt = meye.mchip_ptable_toc;
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
+		dma_addr_t dma = (dma_addr_t) *pt;
 		if (meye.mchip_ptable[i])
 			dma_free_coherent(&meye.mchip_dev->dev,
 					  PAGE_SIZE,
-					  meye.mchip_ptable[i], *pt);
+					  meye.mchip_ptable[i], dma);
 		pt++;
 	}
 
@@ -520,11 +525,11 @@
 }
 
 /* sets the DMA parameters into the chip */
-static void mchip_dma_setup(u32 dma_addr)
+static void mchip_dma_setup(dma_addr_t dma_addr)
 {
 	int i;
 
-	mchip_set(MCHIP_MM_PT_ADDR, dma_addr);
+	mchip_set(MCHIP_MM_PT_ADDR, (u32)dma_addr);
 	for (i = 0; i < 4; i++)
 		mchip_set(MCHIP_MM_FIR(i), 0);
 	meye.mchip_fnum = 0;
-- 
Stelian Pop <stelian@popies.net>    
