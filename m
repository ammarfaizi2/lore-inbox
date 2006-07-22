Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWGVPh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGVPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWGVPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:37:28 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:33410 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750803AbWGVPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:28 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] drm: remove local copies of pci bus/slot/func (01/07)
Date: Sun, 23 Jul 2006 01:38:27 +1000
Message-Id: <11535827133352-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827134076-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drm keeps a local copy of these for little use.

Signed-off-by: Dave Airlie <airlied@linux.ie>
(cherry picked from ed13f8ab3c841ebe5395dc6e10cb5f9aeb6fd627 commit)
---
 drivers/char/drm/drmP.h      |    3 ---
 drivers/char/drm/drm_ioctl.c |    9 ++++++---
 drivers/char/drm/drm_irq.c   |    4 ++--
 drivers/char/drm/drm_stub.c  |    3 ---
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
index d2a5618..5c8f245 100644
--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -712,9 +712,6 @@ typedef struct drm_device {
 
 	struct pci_dev *pdev;		/**< PCI device structure */
 	int pci_domain;			/**< PCI bus domain number */
-	int pci_bus;			/**< PCI bus number */
-	int pci_slot;			/**< PCI slot number */
-	int pci_func;			/**< PCI function number */
 #ifdef __alpha__
 	struct pci_controller *hose;
 #endif
diff --git a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
index 555f323..5c020b8 100644
--- a/drivers/char/drm/drm_ioctl.c
+++ b/drivers/char/drm/drm_ioctl.c
@@ -128,8 +128,9 @@ int drm_setunique(struct inode *inode, s
 	bus &= 0xff;
 
 	if ((domain != dev->pci_domain) ||
-	    (bus != dev->pci_bus) ||
-	    (slot != dev->pci_slot) || (func != dev->pci_func))
+	    (bus != dev->pdev->bus->number) ||
+	    (slot != PCI_SLOT(dev->pdev->devfn)) ||
+	    (func != PCI_FUNC(dev->pdev->devfn)))
 		return -EINVAL;
 
 	return 0;
@@ -148,7 +149,9 @@ static int drm_set_busid(drm_device_t * 
 		return ENOMEM;
 
 	len = snprintf(dev->unique, dev->unique_len, "pci:%04x:%02x:%02x.%d",
-		 dev->pci_domain, dev->pci_bus, dev->pci_slot, dev->pci_func);
+		       dev->pci_domain, dev->pdev->bus->number,
+		       PCI_SLOT(dev->pdev->devfn),
+		       PCI_FUNC(dev->pdev->devfn));
 
 	if (len > dev->unique_len)
 		DRM_ERROR("Unique buffer overflowed\n");
diff --git a/drivers/char/drm/drm_irq.c b/drivers/char/drm/drm_irq.c
index ebdb718..ee4b183 100644
--- a/drivers/char/drm/drm_irq.c
+++ b/drivers/char/drm/drm_irq.c
@@ -65,8 +65,8 @@ int drm_irq_by_busid(struct inode *inode
 		return -EFAULT;
 
 	if ((p.busnum >> 8) != dev->pci_domain ||
-	    (p.busnum & 0xff) != dev->pci_bus ||
-	    p.devnum != dev->pci_slot || p.funcnum != dev->pci_func)
+	    (p.busnum & 0xff) != dev->pdev->bus->number ||
+	    p.devnum != PCI_SLOT(dev->pdev->devfn) || p.funcnum != PCI_FUNC(dev->pdev->devfn))
 		return -EINVAL;
 
 	p.irq = dev->irq;
diff --git a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
index 9a842a3..96449d5 100644
--- a/drivers/char/drm/drm_stub.c
+++ b/drivers/char/drm/drm_stub.c
@@ -72,9 +72,6 @@ #ifdef __alpha__
 #else
 	dev->pci_domain = 0;
 #endif
-	dev->pci_bus = pdev->bus->number;
-	dev->pci_slot = PCI_SLOT(pdev->devfn);
-	dev->pci_func = PCI_FUNC(pdev->devfn);
 	dev->irq = pdev->irq;
 
 	dev->maplist = drm_calloc(1, sizeof(*dev->maplist), DRM_MEM_MAPS);
-- 
1.4.1.ga3e6

