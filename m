Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVI1Mo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVI1Mo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVI1Mo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:44:26 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:21897 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751267AbVI1MoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:44:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=lgLu3kqb0NwBuM20tKRYhO+Yq0ogpskQ+D63KfjM8sByRQW3l2abwwiZwc/mVLxqBENAj6nOsJykOnkoKLM2o2laO1edo3zTJEaAwL/l54WpIrXfSOb9LobuIHPV7baD4Ly1uc2lC/NyMDSLMHnrun7rNqZw1Q8PEmk9NCu+c4Y=
From: Tejun Heo <htejun@gmail.com>
To: ak@suse.de, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050928124148.EBEDFAFE@htj.dyndns.org>
In-Reply-To: <20050928124148.EBEDFAFE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 02/03] i386_and_x86_64: check broken_dac to i386 dma_supported()
Message-ID: <20050928124148.907D946F@htj.dyndns.org>
Date: Wed, 28 Sep 2005 21:44:16 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_i386_and_x86_64_add-broken-dac-check-to-i386.patch

	check for broken_dac in i386 dma_supported() routine.  This
	disables 64-bit DMA for devices hanging off broken bridges.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 arch/i386/kernel/pci-dma.c     |   22 ++++++++++++++++++++++
 include/asm-i386/dma-mapping.h |   14 +-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

Index: linux-work/arch/i386/kernel/pci-dma.c
===================================================================
--- linux-work.orig/arch/i386/kernel/pci-dma.c	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/arch/i386/kernel/pci-dma.c	2005-09-28 21:41:46.000000000 +0900
@@ -72,6 +72,28 @@ void dma_free_coherent(struct device *de
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
+int dma_broken_dac(struct device *dev);	/* arch/i386/kernel/quirks.c */
+
+int dma_supported(struct device *dev, u64 mask)
+{
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+         */
+        if(mask < 0x00ffffff)
+                return 0;
+
+	/*
+	 * Check if there is any bridge with broken DAC support
+	 * between the device and memory.
+	 */
+	if (mask > 0xffffffff && dma_broken_dac(dev))
+		return 0;
+
+	return 1;
+}
+
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
Index: linux-work/include/asm-i386/dma-mapping.h
===================================================================
--- linux-work.orig/include/asm-i386/dma-mapping.h	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/include/asm-i386/dma-mapping.h	2005-09-28 21:41:46.000000000 +0900
@@ -120,19 +120,7 @@ dma_mapping_error(dma_addr_t dma_addr)
 	return 0;
 }
 
-static inline int
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
+int dma_supported(struct device *dev, u64 mask);
 
 static inline int
 dma_set_mask(struct device *dev, u64 mask)

