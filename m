Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSKOU1a>; Fri, 15 Nov 2002 15:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSKOU1a>; Fri, 15 Nov 2002 15:27:30 -0500
Received: from host194.steeleye.com ([66.206.164.34]:5130 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266686AbSKOU1Z>; Fri, 15 Nov 2002 15:27:25 -0500
Message-Id: <200211152034.gAFKYC404219@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: grundler@dsl2.external.hp.com, willy@debian.org
Subject: [RFC][PATCH] move dma_mask into struct device
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-17523764410"
Date: Fri, 15 Nov 2002 15:34:12 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-17523764410
Content-Type: text/plain; charset=us-ascii

Attached is a patch which moves dma_mask into struct device and cleans up the 
scsi mid-layer to use it (instead of using struct pci_dev).  The advantage to 
doing this is probably most apparent on non-pci bus architectures where 
currently you have to construct a fake pci_dev just so you can get the bounce 
buffers to work correctly.

The patch tries to perturb the minimum amount of code, so dma_mask in struct 
device is simply a pointer to the one in pci_dev.  However, it will make it 
easy for me now to add generic device to MCA without having to go the fake pci 
route.

This patch completely removes knowledge of pci devices from the SCSI mid-layer.

I have compiled and tested this, but obviously, since I have an MCA machine, 
it's not of much value to the pci code changes, so if someone with a PCI 
machine could check those out, I'd be grateful.

The main problem SCSI has with this is the scsi_ioctl_get_pci which is used to 
get the pci slot name.  Although, this can be fixed up afterwards with Matthew 
Wilcox's name change patch.

I'd like to see this as the beginning of a move away from bus specific code to 
using generic device code (where possible).  Comments and feedback welcome.

James


--==_Exmh_-17523764410
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== drivers/pci/probe.c 1.17 vs edited =====
--- 1.17/drivers/pci/probe.c	Fri Nov  1 12:33:02 2002
+++ edited/drivers/pci/probe.c	Fri Nov 15 14:00:46 2002
@@ -449,6 +449,7 @@
 	/* now put in global tree */
 	strcpy(dev->dev.name,dev->name);
 	strcpy(dev->dev.bus_id,dev->slot_name);
+	dev->dev->dma_mask = &dev->dma_mask;
 
 	device_register(&dev->dev);
 	return dev;
===== drivers/scsi/hosts.h 1.36 vs edited =====
--- 1.36/drivers/scsi/hosts.h	Thu Nov 14 13:07:27 2002
+++ edited/drivers/scsi/hosts.h	Fri Nov 15 14:43:59 2002
@@ -468,10 +468,10 @@
     unsigned int max_host_blocked;
 
     /*
-     * For SCSI hosts which are PCI devices, set pci_dev so that
-     * we can do BIOS EDD 3.0 mappings
+     * This is a pointer to the generic device for this host (i.e. the
+     * device on the bus);
      */
-    struct pci_dev *pci_dev;
+    struct device *dev;
 
     /* 
      * Support for driverfs filesystem
@@ -521,11 +521,17 @@
 	shost->host_lock = lock;
 }
 
+static inline void scsi_set_device(struct Scsi_Host *shost,
+                                   struct device *dev)
+{
+        shost->dev = dev;
+        shost->host_driverfs_dev.parent = dev;
+}
+
 static inline void scsi_set_pci_device(struct Scsi_Host *shost,
                                        struct pci_dev *pdev)
 {
-	shost->pci_dev = pdev;
-	shost->host_driverfs_dev.parent=&pdev->dev;
+        scsi_set_device(shost, &pdev->dev);
 }
 
 
===== drivers/scsi/scsi_ioctl.c 1.12 vs edited =====
--- 1.12/drivers/scsi/scsi_ioctl.c	Thu Oct 17 13:52:39 2002
+++ edited/drivers/scsi/scsi_ioctl.c	Fri Nov 15 14:08:19 2002
@@ -396,9 +396,9 @@
 scsi_ioctl_get_pci(Scsi_Device * dev, void *arg)
 {
 
-        if (!dev->host->pci_dev) return -ENXIO;
-        return copy_to_user(arg, dev->host->pci_dev->slot_name,
-                            sizeof(dev->host->pci_dev->slot_name));
+        if (!dev->host->dev) return -ENXIO;
+        return copy_to_user(arg, dev->host->dev->name,
+                            sizeof(dev->host->dev->name));
 }
 
 
===== drivers/scsi/scsi_scan.c 1.35 vs edited =====
--- 1.35/drivers/scsi/scsi_scan.c	Thu Nov 14 12:34:35 2002
+++ edited/drivers/scsi/scsi_scan.c	Fri Nov 15 14:25:41 2002
@@ -436,8 +436,8 @@
 	u64 bounce_limit;
 
 	if (sh->highmem_io) {
-		if (sh->pci_dev && PCI_DMA_BUS_IS_PHYS) {
-			bounce_limit = sh->pci_dev->dma_mask;
+		if (sh->dev && sh->dev->dma_mask && PCI_DMA_BUS_IS_PHYS) {
+			bounce_limit = *sh->dev->dma_mask;
 		} else {
 			/*
 			 * Platforms with virtual-DMA translation
===== drivers/scsi/st.c 1.42 vs edited =====
--- 1.42/drivers/scsi/st.c	Mon Nov 11 03:32:34 2002
+++ edited/drivers/scsi/st.c	Fri Nov 15 14:25:58 2002
@@ -3786,8 +3786,8 @@
 			 * hardware have no practical limit.
 			 */
 			bounce_limit = BLK_BOUNCE_ANY;
-		else if (SDp->host->pci_dev)
-			bounce_limit = SDp->host->pci_dev->dma_mask;
+		else if (SDp->host->dev && SDp->host->dev->dma_mask)
+			bounce_limit = *SDp->host->dev->dma_mask;
 	} else if (SDp->host->unchecked_isa_dma)
 		bounce_limit = BLK_BOUNCE_ISA;
 	bounce_limit >>= PAGE_SHIFT;
===== include/linux/device.h 1.58 vs edited =====
--- 1.58/include/linux/device.h	Thu Oct 31 15:25:58 2002
+++ edited/include/linux/device.h	Fri Nov 15 13:52:55 2002
@@ -300,6 +300,7 @@
 					   being off. */
 
 	unsigned char *saved_state;	/* saved device state */
+	u64		*dma_mask;	/* dma mask (if dma'able device) */
 
 	void	(*release)(struct device * dev);
 };

--==_Exmh_-17523764410--


