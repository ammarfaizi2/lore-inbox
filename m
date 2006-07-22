Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWGVPha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWGVPha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWGVPh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:37:29 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:32898 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750810AbWGVPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:28 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] drm: remove pci domain local copy (02/07)
Date: Sun, 23 Jul 2006 01:38:28 +1000
Message-Id: <11535827131612-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827133352-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just call a function to retrieve the pci domain, this isn't exactly
hotpath code.

Signed-off-by: Dave Airlie <airlied@linux.ie>
(cherry picked from 01852d755753bbfcd5434c55d4d7375580f8338f commit)
---
 drivers/char/drm/drmP.h      |   10 +++++++++-
 drivers/char/drm/drm_ioctl.c |    4 ++--
 drivers/char/drm/drm_irq.c   |    2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
index 5c8f245..4dd28e1 100644
--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -711,7 +711,6 @@ typedef struct drm_device {
 	drm_agp_head_t *agp;	/**< AGP data */
 
 	struct pci_dev *pdev;		/**< PCI device structure */
-	int pci_domain;			/**< PCI bus domain number */
 #ifdef __alpha__
 	struct pci_controller *hose;
 #endif
@@ -733,6 +732,15 @@ static __inline__ int drm_core_check_fea
 	return ((dev->driver->driver_features & feature) ? 1 : 0);
 }
 
+static inline int drm_get_pci_domain(struct drm_device *dev)
+{
+#ifdef __alpha__
+	return dev->hose->bus->number;
+#else
+	return 0;
+#endif
+}
+
 #if __OS_HAS_AGP
 static inline int drm_core_has_AGP(struct drm_device *dev)
 {
diff --git a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
index 5c020b8..9d9f988 100644
--- a/drivers/char/drm/drm_ioctl.c
+++ b/drivers/char/drm/drm_ioctl.c
@@ -127,7 +127,7 @@ int drm_setunique(struct inode *inode, s
 	domain = bus >> 8;
 	bus &= 0xff;
 
-	if ((domain != dev->pci_domain) ||
+	if ((domain != drm_get_pci_domain(dev)) ||
 	    (bus != dev->pdev->bus->number) ||
 	    (slot != PCI_SLOT(dev->pdev->devfn)) ||
 	    (func != PCI_FUNC(dev->pdev->devfn)))
@@ -149,7 +149,7 @@ static int drm_set_busid(drm_device_t * 
 		return ENOMEM;
 
 	len = snprintf(dev->unique, dev->unique_len, "pci:%04x:%02x:%02x.%d",
-		       dev->pci_domain, dev->pdev->bus->number,
+		       drm_get_pci_domain(dev), dev->pdev->bus->number,
 		       PCI_SLOT(dev->pdev->devfn),
 		       PCI_FUNC(dev->pdev->devfn));
 
diff --git a/drivers/char/drm/drm_irq.c b/drivers/char/drm/drm_irq.c
index ee4b183..f93d8cd 100644
--- a/drivers/char/drm/drm_irq.c
+++ b/drivers/char/drm/drm_irq.c
@@ -64,7 +64,7 @@ int drm_irq_by_busid(struct inode *inode
 	if (copy_from_user(&p, argp, sizeof(p)))
 		return -EFAULT;
 
-	if ((p.busnum >> 8) != dev->pci_domain ||
+	if ((p.busnum >> 8) != drm_get_pci_domain(dev) ||
 	    (p.busnum & 0xff) != dev->pdev->bus->number ||
 	    p.devnum != PCI_SLOT(dev->pdev->devfn) || p.funcnum != PCI_FUNC(dev->pdev->devfn))
 		return -EINVAL;
-- 
1.4.1.ga3e6

