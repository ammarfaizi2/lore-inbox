Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWBVWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWBVWNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBVWMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:12:39 -0500
Received: from fmr20.intel.com ([134.134.136.19]:47238 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751517AbWBVWMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:12:35 -0500
Date: Wed, 22 Feb 2006 14:06:08 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com,
       james.bottomley@steeleye.com
Subject: [PATCH 12/13] ATA ACPI: use scsi_bus_shutdown for SATA/PATA
Message-Id: <20060222140608.2de3fa24.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ability for SCSI drivers to invoke a shutdown method.
This allows drivers to make drives safe for shutdown/poweroff,
for example.  Some drives need this to prevent possible problems.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/ahci.c        |    1 +
 drivers/scsi/ata_piix.c    |    1 +
 drivers/scsi/libata-core.c |   23 +++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |    8 ++++++++
 drivers/scsi/scsi_sysfs.c  |   16 ++++++++++++++++
 include/linux/libata.h     |    2 ++
 include/scsi/scsi_host.h   |    1 +
 7 files changed, 52 insertions(+)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-scsi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-scsi.c
@@ -412,6 +412,14 @@ int ata_scsi_device_suspend(struct scsi_
 	return ata_device_suspend(ap, dev);
 }
 
+int ata_scsi_device_shutdown(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	return ata_device_shutdown(ap, dev);
+}
+
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@id: ATA device number
--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
@@ -4334,6 +4334,27 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_device_shutdown - send Standby Immediate command to drive
+ *	@ap: target ata_port
+ *	@dev: target device on the ata_port
+ *
+ *	This command makes it safe to power-off a drive.
+ *	Otherwise the heads may be flying at the wrong place
+ *	when the power is removed.
+ */
+int ata_device_shutdown(struct ata_port *ap, struct ata_device *dev)
+{
+
+	if (!ata_dev_present(dev))
+		return 0;
+
+	ata_standby_drive(ap, dev);
+	ap->flags |= ATA_FLAG_SUSPENDED;
+
+	return 0;
+}
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -5230,5 +5251,7 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume)
 
 EXPORT_SYMBOL_GPL(ata_device_suspend);
 EXPORT_SYMBOL_GPL(ata_device_resume);
+EXPORT_SYMBOL_GPL(ata_device_shutdown);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
+EXPORT_SYMBOL_GPL(ata_scsi_device_shutdown);
--- linux-2616-rc4-ata.orig/include/linux/libata.h
+++ linux-2616-rc4-ata/include/linux/libata.h
@@ -501,8 +501,10 @@ extern int ata_scsi_release(struct Scsi_
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *);
+extern int ata_scsi_device_shutdown(struct scsi_device *);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
+extern int ata_device_shutdown(struct ata_port *, struct ata_device *);
 extern int ata_ratelimit(void);
 
 /*
--- linux-2616-rc4-ata.orig/drivers/scsi/scsi_sysfs.c
+++ linux-2616-rc4-ata/drivers/scsi/scsi_sysfs.c
@@ -302,11 +302,27 @@ static int scsi_bus_resume(struct device
 	return err;
 }
 
+static void scsi_bus_shutdown(struct device * dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_host_template *sht = sdev->host->hostt;
+	int err;
+
+	err = scsi_device_quiesce(sdev);
+	if (err)
+		printk(KERN_DEBUG "%s: error (0x%x) during shutdown\n",
+			__FUNCTION__, err);
+
+	if (sht->shutdown)
+		sht->shutdown(sdev);
+}
+
 struct bus_type scsi_bus_type = {
         .name		= "scsi",
         .match		= scsi_bus_match,
 	.suspend	= scsi_bus_suspend,
 	.resume		= scsi_bus_resume,
+	.shutdown	= scsi_bus_shutdown,
 };
 
 int scsi_sysfs_register(void)
--- linux-2616-rc4-ata.orig/include/scsi/scsi_host.h
+++ linux-2616-rc4-ata/include/scsi/scsi_host.h
@@ -301,6 +301,7 @@ struct scsi_host_template {
 	 */
 	int (*resume)(struct scsi_device *);
 	int (*suspend)(struct scsi_device *);
+	int (*shutdown)(struct scsi_device *);
 
 	/*
 	 * Name of proc directory
--- linux-2616-rc4-ata.orig/drivers/scsi/ahci.c
+++ linux-2616-rc4-ata/drivers/scsi/ahci.c
@@ -214,6 +214,7 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.shutdown		= ata_scsi_device_shutdown,
 };
 
 static const struct ata_port_operations ahci_ops = {
--- linux-2616-rc4-ata.orig/drivers/scsi/ata_piix.c
+++ linux-2616-rc4-ata/drivers/scsi/ata_piix.c
@@ -192,6 +192,7 @@ static struct scsi_host_template piix_sh
 	.bios_param		= ata_std_bios_param,
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+	.shutdown		= ata_scsi_device_shutdown,
 };
 
 static const struct ata_port_operations piix_pata_ops = {
