Return-Path: <linux-kernel-owner+w=401wt.eu-S932657AbWLZPWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWLZPWm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWLZPWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:22:42 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:15384 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbWLZPSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=YtiDzbEwCnOMhM/5y7WLP2lVRagYDVkxNS5+zulaAF9IrAIFAPSxJrTChmd/x/eqTYawxgcO5zCF+6XjAuzELE71sFpXfkIdyznRZG6Ypg0Pg+ogyCLSv91+F9e6Nr2Bm8IVerY0kXCNAjKCWMxgkk41osFbfhjjZ2rbxkJN/f4=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/12] devres: implement managed PCI interface
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-Id: <11671463142754-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed PCI interface - pcim_enable_device(),
pcim_pin_device() and pci_is_managed().  pcim_enable_device() is
equivalent to pci_enable_device() except that it makes the PCI device
managed.  After pcim_enable_device(), PCI resources such as
enabledness, msi/msix/intx status and BAR regions become managed.

pcim_pin_device() is used by device drivers to ask PCI devres not to
disable the device on driver detach.  This function is to handle cases
where a driver finds out that a device is otherwise busy and thus
shouldn't be disabled on probe failure or driver detach.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/pci/pci.c   |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |    9 ++++
 2 files changed, 135 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6bfb942..2ab2f8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -744,6 +744,104 @@ int pci_enable_device(struct pci_dev *dev)
 	return result;
 }
 
+/*
+ * Managed PCI resources.  This manages device on/off, intx/msi/msix
+ * on/off and BAR regions.  pci_dev itself records msi/msix status, so
+ * there's no need to track it separately.  pci_devres is initialized
+ * when a device is enabled using managed PCI device enable interface.
+ */
+struct pci_devres {
+	unsigned int disable:1;
+	unsigned int orig_intx:1;
+	unsigned int restore_intx:1;
+	u32 region_mask;
+};
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pci_devres *this = res;
+	int i;
+
+	if (dev->msi_enabled)
+		pci_disable_msi(dev);
+	if (dev->msix_enabled)
+		pci_disable_msix(dev);
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if (this->region_mask & (1 << i))
+			pci_release_region(dev, i);
+
+	if (this->restore_intx)
+		pci_intx(dev, this->orig_intx);
+
+	if (this->disable)
+		pci_disable_device(dev);
+}
+
+static struct pci_devres * get_pci_dr(struct pci_dev *pdev)
+{
+	struct pci_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	if (dr)
+		return dr;
+
+	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+}
+
+static struct pci_devres * find_pci_dr(struct pci_dev *pdev)
+{
+	if (pci_is_managed(pdev))
+		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	return NULL;
+}
+
+/**
+ * pcim_enable_device - Managed pci_enable_device()
+ * @pdev: PCI device to be initialized
+ *
+ * Managed pci_enable_device().
+ */
+int pcim_enable_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+	int rc;
+
+	dr = get_pci_dr(pdev);
+	if (unlikely(!dr))
+		return -ENOMEM;
+	WARN_ON(!!dr->disable);
+
+	rc = pci_enable_device(pdev);
+	if (!rc) {
+		pdev->is_managed = 1;
+		dr->disable = 1;
+	}
+	return rc;
+}
+
+/**
+ * pcim_pin_device - Pin managed PCI device
+ * @pdev: PCI device to pin
+ *
+ * Pin managed PCI device @pdev.  Pinned device won't be disabled on
+ * driver detach.  @pdev must have been enabled with
+ * pcim_enable_device().
+ */
+void pcim_pin_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(pdev);
+	WARN_ON(!dr || !dr->disable);
+	if (dr)
+		dr->disable = 0;
+}
+
 /**
  * pcibios_disable_device - disable arch specific PCI resources for device dev
  * @dev: the PCI device to disable
@@ -767,8 +865,13 @@ void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
 void
 pci_disable_device(struct pci_dev *dev)
 {
+	struct pci_devres *dr;
 	u16 pci_command;
 
+	dr = find_pci_dr(dev);
+	if (dr)
+		dr->disable = 0;
+
 	if (atomic_sub_return(1, &dev->enable_cnt) != 0)
 		return;
 
@@ -867,6 +970,8 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
+	struct pci_devres *dr;
+
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
@@ -875,6 +980,10 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
+
+	dr = find_pci_dr(pdev);
+	if (dr)
+		dr->region_mask &= ~(1 << bar);
 }
 
 /**
@@ -893,6 +1002,8 @@ void pci_release_region(struct pci_dev *pdev, int bar)
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
+	struct pci_devres *dr;
+
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
 		
@@ -906,7 +1017,11 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 				        pci_resource_len(pdev, bar), res_name))
 			goto err_out;
 	}
-	
+
+	dr = find_pci_dr(pdev);
+	if (dr)
+		dr->region_mask |= 1 << bar;
+
 	return 0;
 
 err_out:
@@ -1117,7 +1232,15 @@ pci_intx(struct pci_dev *pdev, int enable)
 	}
 
 	if (new != pci_command) {
+		struct pci_devres *dr;
+
 		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+		dr = find_pci_dr(pdev);
+		if (dr && !dr->restore_intx) {
+			dr->restore_intx = 1;
+			dr->orig_intx = !enable;
+		}
 	}
 }
 
@@ -1189,6 +1312,8 @@ EXPORT_SYMBOL(isa_bridge);
 EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
+EXPORT_SYMBOL(pcim_enable_device);
+EXPORT_SYMBOL(pcim_pin_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
 EXPORT_SYMBOL(pci_bus_find_capability);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3c617e..1f82eb9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -167,6 +167,7 @@ struct pci_dev {
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int 	msi_enabled:1;
 	unsigned int	msix_enabled:1;
+	unsigned int	is_managed:1;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
@@ -521,6 +522,14 @@ static inline int pci_write_config_dword(struct pci_dev *dev, int where, u32 val
 
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
+int __must_check pcim_enable_device(struct pci_dev *pdev);
+void pcim_pin_device(struct pci_dev *pdev);
+
+static inline int pci_is_managed(struct pci_dev *pdev)
+{
+	return pdev->is_managed;
+}
+
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
-- 
1.4.4.2


