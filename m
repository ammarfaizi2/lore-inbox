Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVIWXLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVIWXLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVIWXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:11:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:11436 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750848AbVIWXLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:11:07 -0400
Date: Fri, 23 Sep 2005 19:11:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20050923231106.GA3272@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following changes.

The main fix is the change to include/linux/pci_ids.h, the rest is minor
stuff.  The description "Add NVIDIA device ID" is incorrect -- my
mistake.  It adds a device id, but also fixes another.


 drivers/scsi/ata_piix.c    |    1 
 drivers/scsi/libata-core.c |   81 +++++++++++++++++++++++++++------------------
 drivers/scsi/sata_nv.c     |    2 +
 include/linux/libata.h     |    1 
 include/linux/pci_ids.h    |    3 +
 5 files changed, 54 insertions(+), 34 deletions(-)


Alan Cox:
  PATCH: silly in piix driver
  PATCH: remove function for non-PCI as requested

Andy Currid:
  Add NVIDIA device ID in sata_nv


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -442,7 +442,6 @@ static void piix_sata_phy_reset(struct a
  *	piix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
- *	@pio: PIO mode, 0 - 4
  *
  *	Set PIO mode for device, in host controller PCI config space.
  *
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4132,6 +4132,53 @@ err_out:
 }
 
 /**
+ *	ata_host_set_remove - PCI layer callback for device removal
+ *	@host_set: ATA host set that was removed
+ *
+ *	Unregister all objects associated with this host set. Free those 
+ *	objects.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+
+
+void ata_host_set_remove(struct ata_host_set *host_set)
+{
+	struct ata_port *ap;
+	unsigned int i;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		scsi_remove_host(ap->host);
+	}
+
+	free_irq(host_set->irq, host_set);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		ata_scsi_release(ap->host);
+
+		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+			struct ata_ioports *ioaddr = &ap->ioaddr;
+
+			if (ioaddr->cmd_addr == 0x1f0)
+				release_region(0x1f0, 8);
+			else if (ioaddr->cmd_addr == 0x170)
+				release_region(0x170, 8);
+		}
+
+		scsi_host_put(ap->host);
+	}
+
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
+
+	kfree(host_set);
+}
+
+/**
  *	ata_scsi_release - SCSI layer callback hook for host unload
  *	@host: libata host to be unloaded
  *
@@ -4471,39 +4518,8 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ata_port *ap;
-	unsigned int i;
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-
-		scsi_remove_host(ap->host);
-	}
-
-	free_irq(host_set->irq, host_set);
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-
-		ata_scsi_release(ap->host);
-
-		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
-			struct ata_ioports *ioaddr = &ap->ioaddr;
-
-			if (ioaddr->cmd_addr == 0x1f0)
-				release_region(0x1f0, 8);
-			else if (ioaddr->cmd_addr == 0x170)
-				release_region(0x170, 8);
-		}
-
-		scsi_host_put(ap->host);
-	}
-
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-
-	kfree(host_set);
 
+	ata_host_set_remove(host_set);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
@@ -4573,6 +4589,7 @@ module_exit(ata_exit);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
+EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -158,6 +158,8 @@ static struct pci_device_id nv_pci_tbl[]
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -393,6 +393,7 @@ extern int ata_pci_init_one (struct pci_
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
+extern void ata_host_set_remove(struct ata_host_set *host_set);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1268,7 +1268,8 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
-#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x036F
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x037E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2	0x037F
 #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
 #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B
