Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUBENho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUBENho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:37:44 -0500
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:33740 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S265228AbUBENhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:37:38 -0500
Date: Thu, 5 Feb 2004 14:37:26 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] meye: correct printk of dma_addr_t
Message-ID: <20040205133726.GF13492@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040203153606.76442b9c.rddunlap@osdl.org> <20040203155752.17a8e274.akpm@osdl.org> <20040203162822.64ee18e1.rddunlap@osdl.org> <20040204084437.GA13455@deep-space-9.dsnet> <20040204080515.63eb4b96.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204080515.63eb4b96.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 08:05:15AM -0800, Randy.Dunlap wrote:

> | Which one do you prefer ?
> 
> 
> Well, both.  :)
> 
> The toc of dma_addr_t's should be in its own array/structure.
> 
> Adding some comments or help text about the highmem limitation
> would also be good.

I had a feeling you would say that :)

Here it is. It compiles and works just fine, please apply.

Stelian.

===== drivers/media/video/meye.h 1.11 vs edited =====
--- 1.11/drivers/media/video/meye.h	Fri Oct 24 23:14:38 2003
+++ edited/drivers/media/video/meye.h	Thu Feb  5 11:43:55 2004
@@ -298,7 +298,8 @@
 	u8 mchip_fnum;			/* current mchip frame number */
 
 	unsigned char *mchip_mmregs;	/* mchip: memory mapped registers */
-	u8 *mchip_ptable[MCHIP_NB_PAGES+1];/* mchip: ptable + ptable toc */
+	u8 *mchip_ptable[MCHIP_NB_PAGES];/* mchip: ptable */
+	dma_addr_t *mchip_ptable_toc;	/* mchip: ptable toc */
 	dma_addr_t mchip_dmahandle;	/* mchip: dma handle to ptable toc */
 
 	unsigned char *grab_fbuffer;	/* capture framebuffer */
===== drivers/media/video/meye.c 1.19 vs edited =====
--- 1.19/drivers/media/video/meye.c	Wed Aug 27 13:24:51 2003
+++ edited/drivers/media/video/meye.c	Thu Feb  5 10:46:29 2004
@@ -160,23 +160,29 @@
 	}
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
 
-	meye.mchip_ptable[MCHIP_NB_PAGES] = dma_alloc_coherent(&meye.mchip_dev->dev, 
-							       PAGE_SIZE, 
-							       &meye.mchip_dmahandle,
-							       GFP_KERNEL);
-	if (!meye.mchip_ptable[MCHIP_NB_PAGES]) {
+	meye.mchip_ptable_toc = dma_alloc_coherent(&meye.mchip_dev->dev, 
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
 		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev, 
 							  PAGE_SIZE,
@@ -184,13 +190,18 @@
 							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
-			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+			pt = meye.mchip_ptable_toc;
 			for (j = 0; j < i; ++j) {
 				dma_free_coherent(&meye.mchip_dev->dev,
 						  PAGE_SIZE,
 						  meye.mchip_ptable[j], *pt);
 				pt++;
 			}
+			dma_free_coherent(&meye.mchip_dev->dev, 
+					  PAGE_SIZE, 
+					  meye.mchip_ptable_toc,
+					  meye.mchip_dmahandle);
+			meye.mchip_ptable_toc = 0;
 			meye.mchip_dmahandle = 0;
 			return -1;
 		}
@@ -200,10 +211,10 @@
 }
 
 static void ptable_free(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = meye.mchip_ptable_toc;
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
 			dma_free_coherent(&meye.mchip_dev->dev, 
@@ -212,13 +223,14 @@
 		pt++;
 	}
 
-	if (meye.mchip_ptable[MCHIP_NB_PAGES])
+	if (meye.mchip_ptable_toc)
 		dma_free_coherent(&meye.mchip_dev->dev, 
 				  PAGE_SIZE, 
-				  meye.mchip_ptable[MCHIP_NB_PAGES],
+				  meye.mchip_ptable_toc,
 				  meye.mchip_dmahandle);
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
+	meye.mchip_ptable_toc = 0;
 	meye.mchip_dmahandle = 0;
 }
 
===== drivers/media/video/Kconfig 1.17 vs edited =====
--- 1.17/drivers/media/video/Kconfig	Tue Jan 20 00:20:19 2004
+++ edited/drivers/media/video/Kconfig	Thu Feb  5 11:12:49 2004
@@ -205,7 +205,7 @@
 
 config VIDEO_MEYE
 	tristate "Sony Vaio Picturebook Motion Eye Video For Linux (EXPERIMENTAL)"
-	depends on VIDEO_DEV && SONYPI
+	depends on VIDEO_DEV && SONYPI && !HIGHMEM64G
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in

-- 
Stelian Pop <stelian@popies.net>
