Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSKUU21>; Thu, 21 Nov 2002 15:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKUU21>; Thu, 21 Nov 2002 15:28:27 -0500
Received: from host194.steeleye.com ([66.206.164.34]:36101 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264723AbSKUU2U>; Thu, 21 Nov 2002 15:28:20 -0500
Message-Id: <200211212035.gALKZB405335@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com,
       Project MCA Team <mcalinux@acc.umu.se>,
       David Weinehall <tao@acc.umu.se>
Subject: [PATCH] MCA sysfs part III - moving dma_mask
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-11858096660"
Date: Thu, 21 Nov 2002 14:35:11 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-11858096660
Content-Type: text/plain; charset=us-ascii

This is really a repriese of the the dma_mask move patch posted a while ago, 
tidied up with everyones's feedback.  The patch also removes the struct 
pci_dev in the Scsi_Host.

The second patch below it adds using the dma_mask to drivers/mca

All of the patches are also available in the bitkeeper tree at:

http://linux-voyager.bkbits.net/mca-sysfs-2.5

James


--==_Exmh_-11858096660
Content-Type: text/plain ; name="dma_mask.diff"; charset=us-ascii
Content-Description: dma_mask.diff
Content-Disposition: attachment; filename="dma_mask.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.844   -> 1.845  
#	drivers/scsi/hosts.h	1.38    -> 1.39   
#	   drivers/scsi/st.c	1.44    -> 1.45   
#	 drivers/pci/probe.c	1.18    -> 1.19   
#	drivers/scsi/scsi_scan.c	1.37    -> 1.38   
#	include/linux/device.h	1.60    -> 1.61   
#	drivers/scsi/scsi_ioctl.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/21	jejb@mulgrave.(none)	1.845
# move dma_mask into struct device
# 
# Attached is a patch which moves dma_mask into struct device and cleans up the 
# scsi mid-layer to use it (instead of using struct pci_dev).  The advantage to 
# doing this is probably most apparent on non-pci bus architectures where 
# currently you have to construct a fake pci_dev just so you can get the bounce 
# buffers to work correctly.
# 
# The patch tries to perturb the minimum amount of code, so dma_mask in struct 
# device is simply a pointer to the one in pci_dev.  However, it will make it 
# easy for me now to add generic device to MCA without having to go the fake pci 
# route.
# 
# This patch completely removes knowledge of pci devices from the SCSI mid-layer.
# 
# I have compiled and tested this, but obviously, since I have an MCA machine, 
# it's not of much value to the pci code changes, so if someone with a PCI 
# machine could check those out, I'd be grateful.
# 
# The main problem SCSI has with this is the scsi_ioctl_get_pci which is used to 
# get the pci slot name.  Although, this can be fixed up afterwards with Matthew 
# Wilcox's name change patch.
# 
# I'd like to see this as the beginning of a move away from bus specific code to 
# using generic device code (where possible).  Comments and feedback welcome.
# --------------------------------------------
#
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Nov 21 14:33:31 2002
+++ b/drivers/pci/probe.c	Thu Nov 21 14:33:31 2002
@@ -448,6 +448,7 @@
 
 	/* now put in global tree */
 	strcpy(dev->dev.bus_id,dev->slot_name);
+	dev->dev.dma_mask = &dev->dma_mask;
 
 	device_register(&dev->dev);
 	return dev;
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Thu Nov 21 14:33:31 2002
+++ b/drivers/scsi/hosts.h	Thu Nov 21 14:33:31 2002
@@ -467,12 +467,6 @@
      */
     unsigned int max_host_blocked;
 
-    /*
-     * For SCSI hosts which are PCI devices, set pci_dev so that
-     * we can do BIOS EDD 3.0 mappings
-     */
-    struct pci_dev *pci_dev;
-
     /* 
      * Support for driverfs filesystem
      */
@@ -517,11 +511,16 @@
 	shost->host_lock = lock;
 }
 
+static inline void scsi_set_device(struct Scsi_Host *shost,
+                                   struct device *dev)
+{
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
 
 
diff -Nru a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c	Thu Nov 21 14:33:31 2002
+++ b/drivers/scsi/scsi_ioctl.c	Thu Nov 21 14:33:31 2002
@@ -393,12 +393,13 @@
  *          any copy_to_user() error on failure there
  */
 static int
-scsi_ioctl_get_pci(Scsi_Device * dev, void *arg)
+scsi_ioctl_get_pci(Scsi_Device * sdev, void *arg)
 {
+	struct device *dev = sdev->host->host_driverfs_dev.parent;
 
-        if (!dev->host->pci_dev) return -ENXIO;
-        return copy_to_user(arg, dev->host->pci_dev->slot_name,
-                            sizeof(dev->host->pci_dev->slot_name));
+        if (!dev) return -ENXIO;
+        return copy_to_user(arg, dev->bus_id,
+                            sizeof(dev->bus_id));
 }
 
 
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Thu Nov 21 14:33:31 2002
+++ b/drivers/scsi/scsi_scan.c	Thu Nov 21 14:33:31 2002
@@ -433,11 +433,12 @@
 {
 	request_queue_t *q = &sd->request_queue;
 	struct Scsi_Host *sh = sd->host;
+	struct device *dev = sh->host_driverfs_dev.parent;
 	u64 bounce_limit;
 
 	if (sh->highmem_io) {
-		if (sh->pci_dev && PCI_DMA_BUS_IS_PHYS) {
-			bounce_limit = sh->pci_dev->dma_mask;
+		if (dev && dev->dma_mask && PCI_DMA_BUS_IS_PHYS) {
+			bounce_limit = *dev->dma_mask;
 		} else {
 			/*
 			 * Platforms with virtual-DMA translation
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Thu Nov 21 14:33:31 2002
+++ b/drivers/scsi/st.c	Thu Nov 21 14:33:31 2002
@@ -3780,13 +3780,14 @@
 	tpnt->try_dio = try_direct_io && !SDp->host->unchecked_isa_dma;
 	bounce_limit = BLK_BOUNCE_HIGH; /* Borrowed from scsi_merge.c */
 	if (SDp->host->highmem_io) {
+		struct device *dev = SDp->host->host_driverfs_dev.parent;
 		if (!PCI_DMA_BUS_IS_PHYS)
 			/* Platforms with virtual-DMA translation
 			 * hardware have no practical limit.
 			 */
 			bounce_limit = BLK_BOUNCE_ANY;
-		else if (SDp->host->pci_dev)
-			bounce_limit = SDp->host->pci_dev->dma_mask;
+		else if (dev && dev->dma_mask)
+			bounce_limit = *dev->dma_mask;
 	} else if (SDp->host->unchecked_isa_dma)
 		bounce_limit = BLK_BOUNCE_ISA;
 	bounce_limit >>= PAGE_SHIFT;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Nov 21 14:33:31 2002
+++ b/include/linux/device.h	Thu Nov 21 14:33:31 2002
@@ -303,6 +303,7 @@
 					   being off. */
 
 	unsigned char *saved_state;	/* saved device state */
+	u64		*dma_mask;	/* dma mask (if dma'able device) */
 
 	void	(*release)(struct device * dev);
 };

--==_Exmh_-11858096660
Content-Type: text/plain ; name="mca-sysfs-III.diff"; charset=us-ascii
Content-Description: mca-sysfs-III.diff
Content-Disposition: attachment; filename="mca-sysfs-III.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.845   -> 1.846  
#	drivers/mca/mca-bus.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/21	jejb@mulgrave.(none)	1.846
# make mca-bus.c use generic device dma_mask
# --------------------------------------------
#
diff -Nru a/drivers/mca/mca-bus.c b/drivers/mca/mca-bus.c
--- a/drivers/mca/mca-bus.c	Thu Nov 21 14:33:46 2002
+++ b/drivers/mca/mca-bus.c	Thu Nov 21 14:33:46 2002
@@ -143,9 +143,7 @@
 	mca_dev->dev.bus = &mca_bus_type;
 	sprintf (mca_dev->dev.bus_id, "%02d:%02X", bus, mca_dev->slot);
 	mca_dev->dma_mask = mca_bus->default_dma_mask;
-	/* FIXME: uncomment this when we get a global idea of where
-	 * dma_mask goes */
-	//mca_dev->dev.dma_mask = &mca_dev->dma_mask;
+	mca_dev->dev.dma_mask = &mca_dev->dma_mask;
 
 	if (device_register(&mca_dev->dev))
 		return 0;

--==_Exmh_-11858096660--


