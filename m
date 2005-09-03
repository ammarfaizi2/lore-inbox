Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbVICHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbVICHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbVICHS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 03:18:59 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:13645 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1161178AbVICHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 03:18:58 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13] libata: use common pci remove in ahci
Message-Id: <20050903071852.95A10271C2@lns1058.lss.emc.com>
Date: Sat,  3 Sep 2005 03:18:52 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.2.45
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

This looked prime to cut since ahci_remove_one() was a functionally
identical to ata_pci_remove_one() except for the interrupt disable
(have_msi) bits, which fit nicely into ahci_host_stop().  However,

1) Will it work?

2) Isn't it wrong for the IRQ disable at the chip to occur *after*
free_irq() is called to disconnect the handler (independent of
question 1...since this is the case currently)?  Granted, all of the
ports have gone through scsi_remove_host() but theoretically there
still is a possibility the chip could interrupt.

If I'm wrong on both counts I'll blame it on need for sleep... :-)
BR

This patch depends on the PCI INTx patch (but will probably work w/o):
http://lkml.org/lkml/2005/8/15/165


Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.13/drivers/scsi/ahci.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/ahci.c
+++ linux-2.6.13/drivers/scsi/ahci.c
@@ -187,7 +187,6 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
-static void ahci_remove_one (struct pci_dev *pdev);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -277,7 +276,7 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ahci_remove_one,
+	.remove			= ata_pci_remove_one,
 };
 
 
@@ -294,6 +293,13 @@ static inline void *ahci_port_base (void
 static void ahci_host_stop(struct ata_host_set *host_set)
 {
 	struct ahci_host_priv *hpriv = host_set->private_data;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+
+	if (hpriv->flags & AHCI_FLAG_MSI)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
+
 	kfree(hpriv);
 
 	ata_host_stop(host_set);
@@ -1036,43 +1042,6 @@ err_out:
 	return rc;
 }
 
-static void ahci_remove_one (struct pci_dev *pdev)
-{
-	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = host_set->private_data;
-	struct ata_port *ap;
-	unsigned int i;
-	int have_msi;
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-
-		scsi_remove_host(ap->host);
-	}
-
-	have_msi = hpriv->flags & AHCI_FLAG_MSI;
-	free_irq(host_set->irq, host_set);
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		ap = host_set->ports[i];
-
-		ata_scsi_release(ap->host);
-		scsi_host_put(ap->host);
-	}
-
-	host_set->ops->host_stop(host_set);
-	kfree(host_set);
-
-	if (have_msi)
-		pci_disable_msi(pdev);
-	else
-		pci_intx(pdev, 0);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
-}
-
 static int __init ahci_init(void)
 {
 	return pci_module_init(&ahci_pci_driver);
