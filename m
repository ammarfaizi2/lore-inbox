Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUBENjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUBENjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:39:45 -0500
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:35532 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S265251AbUBENje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:39:34 -0500
Date: Thu, 5 Feb 2004 14:39:33 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] Fix meye compilation when HIGHMEM64G is set.
Message-ID: <20040205133932.GG13492@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch is the 2.4 version of the 2.6 patch I've just send, which corrects
the use of dma_addr_t in the meye driver and disables its compilation when
64 bit DMA addresses are used (which is impossible for this device or for the
laptop it is part of).

Please apply.

Thanks,

Stelian.


===== drivers/media/video/meye.h 1.10 vs edited =====
--- 1.10/drivers/media/video/meye.h	Sun Oct 26 16:32:45 2003
+++ edited/drivers/media/video/meye.h	Thu Feb  5 11:58:53 2004
@@ -298,7 +298,8 @@
 	u8 mchip_fnum;			/* current mchip frame number */
 
 	unsigned char *mchip_mmregs;	/* mchip: memory mapped registers */
-	u8 *mchip_ptable[MCHIP_NB_PAGES+1];/* mchip: ptable + ptable toc */
+	u8 *mchip_ptable[MCHIP_NB_PAGES];/* mchip: ptable */
+	dma_addr_t *mchip_ptable_toc;	/* mchip: ptable toc */
 	dma_addr_t mchip_dmahandle;	/* mchip: dma handle to ptable toc */
 
 	unsigned char *grab_fbuffer;	/* capture framebuffer */
===== drivers/media/video/meye.c 1.17 vs edited =====
--- 1.17/drivers/media/video/meye.c	Sun Oct 26 17:21:57 2003
+++ edited/drivers/media/video/meye.c	Thu Feb  5 12:07:11 2004
@@ -188,23 +188,29 @@
         free_pages((unsigned long)vaddr, get_order(size));
 }
 
-/* return a page table pointing to N pages of locked memory */
+/* return a page table pointing to N pages of locked memory
+ *
+ * NOTE: The meye device expects dma_addr_t size to be 32 bits
+ * (the toc must be exactly 1024 entries each of them being 4 bytes
+ * in size, the whole result being 4096 bytes). We're using here
+ * dma_addr_t for corectness but the compilation of this driver is
+ * disabled for HIGHMEM64G=y, where sizeof(dma_addr_t) != 4 */
 static int ptable_alloc(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 
-	meye.mchip_ptable[MCHIP_NB_PAGES] = dma_alloc_coherent(meye.mchip_dev, 
-							       PAGE_SIZE, 
-							       &meye.mchip_dmahandle,
-							       GFP_KERNEL);
-	if (!meye.mchip_ptable[MCHIP_NB_PAGES]) {
+	meye.mchip_ptable_toc = dma_alloc_coherent(meye.mchip_dev, 
+						   PAGE_SIZE, 
+						   &meye.mchip_dmahandle,
+						   GFP_KERNEL);
+	if (!meye.mchip_ptable_toc) {
 		meye.mchip_dmahandle = 0;
 		return -1;
 	}
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = meye.mchip_ptable_toc;
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		meye.mchip_ptable[i] = dma_alloc_coherent(meye.mchip_dev, 
 							  PAGE_SIZE,
@@ -212,13 +218,18 @@
 							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
-			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+			pt = meye.mchip_ptable_toc;
 			for (j = 0; j < i; ++j) {
 				dma_free_coherent(meye.mchip_dev,
 						  PAGE_SIZE,
 						  meye.mchip_ptable[j], *pt);
 				pt++;
 			}
+			dma_free_coherent(meye.mchip_dev,
+					  PAGE_SIZE,
+					  meye.mchip_ptable_toc,
+					  meye.mchip_dmahandle);
+			meye.mchip_ptable_toc = 0;
 			meye.mchip_dmahandle = 0;
 			return -1;
 		}
@@ -228,10 +239,10 @@
 }
 
 static void ptable_free(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = meye.mchip_ptable_toc;
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
 			dma_free_coherent(meye.mchip_dev, 
@@ -240,13 +251,14 @@
 		pt++;
 	}
 
-	if (meye.mchip_ptable[MCHIP_NB_PAGES])
+	if (meye.mchip_ptable_toc)
 		dma_free_coherent(meye.mchip_dev, 
 				  PAGE_SIZE, 
-				  meye.mchip_ptable[MCHIP_NB_PAGES],
+				  meye.mchip_ptable_toc,
 				  meye.mchip_dmahandle);
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
+	meye.mchip_ptable_toc = 0;
 	meye.mchip_dmahandle = 0;
 }
 
===== drivers/media/video/Config.in 1.9 vs edited =====
--- 1.9/drivers/media/video/Config.in	Fri Oct 31 16:58:31 2003
+++ edited/drivers/media/video/Config.in	Thu Feb  5 12:03:53 2004
@@ -49,7 +49,7 @@
 dep_tristate '  Miro DC10(+) support' CONFIG_VIDEO_ZORAN_DC10 $CONFIG_VIDEO_ZORAN $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C
 dep_tristate '  Linux Media Labs LML33 support' CONFIG_VIDEO_ZORAN_LML33 $CONFIG_VIDEO_ZORAN $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C
 dep_tristate '  Zoran ZR36120/36125 Video For Linux' CONFIG_VIDEO_ZR36120 $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_HIGHMEM64G" != "y" ]; then
   dep_tristate '  Sony Vaio Picturebook Motion Eye Video For Linux (EXPERIMENTAL)' CONFIG_VIDEO_MEYE $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_SONYPI
 fi
 
-- 
Stelian Pop <stelian@popies.net>
