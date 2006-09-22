Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWIVVWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWIVVWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWIVVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:22:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31115 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932182AbWIVVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:22:08 -0400
Date: Fri, 22 Sep 2006 14:21:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
In-Reply-To: <200609221414.00667.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221421170.9495@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <200609221341.44354.jesse.barnes@intel.com> <Pine.LNX.4.64.0609221400230.9370@schroedinger.engr.sgi.com>
 <200609221414.00667.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> I was suggesting something like:
> 
> 	high = dev ? dev->coherent_dma_mask : 16*1024*1024;
> 
> instead.  May as well combine your NULL check and your assignment.  It'll 
> also do the right thing for 64 bit devices so we don't put unnecessary 
> pressure on the 32 bit range.  Or am I spacing out and reading the code 
> wrong?

Ahh.. Yes something like this will save a lot of lines:

Index: linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/i386/kernel/pci-dma.c	2006-09-22 15:37:41.000000000 -0500
+++ linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c	2006-09-22 16:20:49.849799156 -0500
@@ -26,8 +26,6 @@ void *dma_alloc_coherent(struct device *
 			   dma_addr_t *dma_handle, gfp_t gfp)
 {
 	void *ret;
-	unsigned long low = 0L;
-	unsigned long high = 0xffffffff;
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 	/* ignore region specifiers */
@@ -46,14 +44,9 @@ void *dma_alloc_coherent(struct device *
 			return NULL;
 	}
 
-	if (dev == NULL)
-		/* Apply safe ISA LIMITS */
-		high = 16*1024*1024L;
-	else
-	if (dev->coherent_dma_mask < 0xffffffff)
-		high = dev->coherent_dma_mask;
-
-	ret = page_address(alloc_pages_range(low, high, gfp, order));
+	ret = page_address(alloc_pages_range(0L,
+		dev ? dev->coherent_dma_mask : 16*1024*1024,
+		gfp, order));
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
