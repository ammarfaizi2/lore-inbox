Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVJTCTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVJTCTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 22:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJTCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 22:19:14 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:9909 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751028AbVJTCTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 22:19:13 -0400
Date: Thu, 20 Oct 2005 03:18:59 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix MGA DRM regression before 2.6.14
Message-ID: <Pine.LNX.4.58.0510200313410.24156@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

I've gotten a report on lkml, of a possible regression in the MGA DRM in
2.6.14-rc4 (since -rc1), I haven't been able to reproduce it here, but
I've figured out some possible issues in the mga code that were definitely
wrong, some of these are from DRM CVS, the main fix is the agp enable bit
on the old code path still used by everyone.....

They should all be in 2.6.14.

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff --git a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c
+++ b/drivers/char/drm/mga_dma.c
@@ -437,7 +437,7 @@ static int mga_do_agp_dma_bootstrap(drm_
 				    drm_mga_dma_bootstrap_t * dma_bs)
 {
 	drm_mga_private_t * const dev_priv = (drm_mga_private_t *) dev->dev_private;
-	const unsigned int warp_size = mga_warp_microcode_size(dev_priv);
+	unsigned int warp_size = mga_warp_microcode_size(dev_priv);
 	int err;
 	unsigned  offset;
 	const unsigned secondary_size = dma_bs->secondary_bin_count
@@ -499,6 +499,12 @@ static int mga_do_agp_dma_bootstrap(drm_
 		return err;
 	}

+	/* Make drm_addbufs happy by not trying to create a mapping for less
+	 * than a page.
+	 */
+	if (warp_size < PAGE_SIZE)
+		warp_size = PAGE_SIZE;
+
 	offset = 0;
 	err = drm_addmap( dev, offset, warp_size,
 			  _DRM_AGP, _DRM_READ_ONLY, & dev_priv->warp );
@@ -587,7 +593,7 @@ static int mga_do_pci_dma_bootstrap(drm_
 				    drm_mga_dma_bootstrap_t * dma_bs)
 {
 	drm_mga_private_t * const dev_priv = (drm_mga_private_t *) dev->dev_private;
-	const unsigned int warp_size = mga_warp_microcode_size(dev_priv);
+	unsigned int warp_size = mga_warp_microcode_size(dev_priv);
 	unsigned int primary_size;
 	unsigned int bin_count;
 	int err;
@@ -598,6 +604,12 @@ static int mga_do_pci_dma_bootstrap(drm_
 		DRM_ERROR("dev->dma is NULL\n");
 		return DRM_ERR(EFAULT);
 	}
+
+	/* Make drm_addbufs happy by not trying to create a mapping for less
+	 * than a page.
+	 */
+	if (warp_size < PAGE_SIZE)
+		warp_size = PAGE_SIZE;

 	/* The proper alignment is 0x100 for this mapping */
 	err = drm_addmap(dev, 0, warp_size, _DRM_CONSISTENT,
@@ -812,6 +824,9 @@ static int mga_do_init_dma( drm_device_t
 	}

 	if (! dev_priv->used_new_dma_init) {
+
+		dev_priv->wagp_enable = MGA_WAGP_ENABLE;
+
 		dev_priv->status = drm_core_findmap(dev, init->status_offset);
 		if (!dev_priv->status) {
 			DRM_ERROR("failed to find status page!\n");
@@ -928,7 +943,7 @@ static int mga_do_cleanup_dma( drm_devic
 		drm_mga_private_t *dev_priv = dev->dev_private;

 		if ((dev_priv->warp != NULL)
-		    && (dev_priv->mmio->type != _DRM_CONSISTENT))
+		    && (dev_priv->warp->type != _DRM_CONSISTENT))
 			drm_core_ioremapfree(dev_priv->warp, dev);

 		if ((dev_priv->primary != NULL)
