Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760199AbWLDBiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760199AbWLDBiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760202AbWLDBiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:38:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:58754 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1760199AbWLDBiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:38:15 -0500
Date: Sun, 3 Dec 2006 20:38:00 -0500
From: Jeff Garzik <jeff@garzik.org>
To: airlied@linux.ie, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] DRM: handle pci_enable_device failure
Message-ID: <20061204013800.GA6788@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
index 7b1d4e8..35e5ff6 100644
--- a/drivers/char/drm/drm_stub.c
+++ b/drivers/char/drm/drm_stub.c
@@ -209,14 +209,16 @@ int drm_get_dev(struct pci_dev *pdev, co
 	if (!dev)
 		return -ENOMEM;
 
-	pci_enable_device(pdev);
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto err_g1;
 
 	if ((ret = drm_fill_in_dev(dev, pdev, ent, driver))) {
 		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
-		goto err_g1;
+		goto err_g2;
 	}
 	if ((ret = drm_get_head(dev, &dev->primary)))
-		goto err_g1;
+		goto err_g2;
 	
 	DRM_INFO("Initialized %s %d.%d.%d %s on minor %d\n",
 		 driver->name, driver->major, driver->minor, driver->patchlevel,
@@ -224,7 +226,9 @@ int drm_get_dev(struct pci_dev *pdev, co
 
 	return 0;
 
-      err_g1:
+err_g2:
+	pci_disable_device(pdev);
+err_g1:
 	drm_free(dev, sizeof(*dev), DRM_MEM_STUB);
 	return ret;
 }

