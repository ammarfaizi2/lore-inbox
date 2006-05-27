Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWE0Fzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWE0Fzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWE0Fzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 01:55:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:53421 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751416AbWE0Fze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 01:55:34 -0400
Date: Sat, 27 May 2006 01:55:33 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata resume improvements
Message-ID: <20060527055533.GA5159@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an example of how one might make sure the ATA bus reaches
bus-idle, before attempting to talk to it.

It compiles, but is completely untested...

Other resume improvements should work at the pci_driver::resume level as
this does, _not_ the SCSI->ATA->resume device level.


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 6dc8814..949d496 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -201,7 +201,7 @@ static struct pci_driver piix_pci_driver
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
 	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
+	.resume			= pata_pci_device_resume,
 };
 
 static struct scsi_host_template piix_sht = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..fe42a75 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4852,6 +4852,28 @@ int ata_pci_device_resume(struct pci_dev
 	pci_set_master(pdev);
 	return 0;
 }
+
+int pata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_port *ap;
+	int i;
+
+	ata_pci_device_resume(pdev);
+
+	msleep(400);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT))
+			printk(KERN_ERR "ata%u: failed to resume\n", ap->id);
+	}
+
+	return 0;
+}
+
 #endif /* CONFIG_PCI */
 
 
@@ -4970,6 +4992,7 @@ EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
+EXPORT_SYMBOL_GPL(pata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b80d2e7..cad531a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -516,6 +516,7 @@ extern int ata_pci_init_one (struct pci_
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
+extern int pata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
