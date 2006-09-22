Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWIVTIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWIVTIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWIVTIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:08:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57566 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932148AbWIVTII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:08:08 -0400
Date: Fri, 22 Sep 2006 12:07:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
In-Reply-To: <200609221206.57701.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221206410.8675@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221139.03250.jesse.barnes@intel.com>
 <Pine.LNX.4.64.0609221139570.8356@schroedinger.engr.sgi.com>
 <200609221206.57701.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> Right, being able to allocate from specific ranges would obviate the need 
> for GFP_DMA and the various zones.  It would come with a cost though since 
> the VM would have to become aware of pressure at various ranges rather 
> than just on zones like we have now.  I think that's where things get 
> tricky.

Here is a hyperthetical use scenario (no code yet to do this in the page 
allocator, fake patch for discussion only):

Index: linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/i386/kernel/pci-dma.c	2006-09-12 20:41:36.000000000 -0500
+++ linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c	2006-09-22 13:59:29.017611573 -0500
@@ -26,6 +26,8 @@ void *dma_alloc_coherent(struct device *
 			   dma_addr_t *dma_handle, gfp_t gfp)
 {
 	void *ret;
+	unsigned long low = 0L;
+	unsigned long high = 0xffffffff;
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 	/* ignore region specifiers */
@@ -44,10 +46,14 @@ void *dma_alloc_coherent(struct device *
 			return NULL;
 	}
 
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
+	if (dev == NULL)
+		/* Apply safe ISA LIMITS */
+		high = 16*1024*1024L;
+	else
+	if (dev->coherent_dma_mask < 0xffffffff)
+		high = dev->coherent_dma_mask;
 
-	ret = (void *)__get_free_pages(gfp, order);
+	ret = page_address(alloc_pages_range(low, high, gfp, order));
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
Index: linux-2.6.18-rc7-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.18-rc7-mm1.orig/include/linux/gfp.h	2006-09-19 09:26:58.000000000 -0500
+++ linux-2.6.18-rc7-mm1/include/linux/gfp.h	2006-09-22 14:02:34.298613635 -0500
@@ -136,6 +136,9 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+extern struct page *alloc_pages_range(unsigned long low, unsigned long high,
+			gfp_t gfp_mask, unsigned int order);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
