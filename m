Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVEaPqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVEaPqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEaPqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:46:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63104 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261913AbVEaPpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:45:52 -0400
Message-ID: <429C86AD.4050605@pobox.com>
Date: Tue, 31 May 2005 11:45:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
References: <20050531124659.GB1530@suse.de>
In-Reply-To: <20050531124659.GB1530@suse.de>
Content-Type: multipart/mixed;
 boundary="------------080500000406030103020804"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500000406030103020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

BTW, does the AHCI PCI MSI patch work for you?

I still haven't gotten any acks back from anybody yet, and PCI MSI 
support should make the driver even more efficient.

	Jeff




--------------080500000406030103020804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -152,6 +152,7 @@ struct ahci_sg {
 
 struct ahci_host_priv {
 	unsigned long		flags;
+	unsigned int		have_msi; /* is PCI MSI enabled? */
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
 };
@@ -182,6 +183,7 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void ahci_remove_one (struct pci_dev *pdev);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -271,7 +273,7 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= ahci_remove_one,
 };
 
 
@@ -876,15 +878,19 @@ static int ahci_host_init(struct ata_pro
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
+static void pci_intx(struct pci_dev *pdev, int enable)
 {
-	u16 pci_command;
+	u16 pci_command, new;
 
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
 }
 
 static void ahci_print_info(struct ata_probe_ent *probe_ent)
@@ -966,7 +972,7 @@ static int ahci_init_one (struct pci_dev
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
+	int have_msi, pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -984,12 +990,17 @@ static int ahci_init_one (struct pci_dev
 		goto err_out;
 	}
 
-	pci_enable_intx(pdev);
+	if (pci_enable_msi(pdev) == 0)
+		have_msi = 1;
+	else {
+		pci_intx(pdev, 1);
+		have_msi = 0;
+	}
 
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out_msi;
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
@@ -1022,6 +1033,8 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
+	hpriv->have_msi = have_msi;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
@@ -1041,7 +1054,11 @@ err_out_iounmap:
 	iounmap(mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
-err_out_regions:
+err_out_msi:
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
 	pci_release_regions(pdev);
 err_out:
 	if (!pci_dev_busy)
@@ -1049,6 +1066,42 @@ err_out:
 	return rc;
 }
 
+static void ahci_remove_one (struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	struct ata_port *ap;
+	unsigned int i;
+	int have_msi;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		scsi_remove_host(ap->host);
+	}
+
+	have_msi = hpriv->have_msi;
+	free_irq(host_set->irq, host_set);
+	host_set->ops->host_stop(host_set);
+	iounmap(host_set->mmio_base);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		ata_scsi_release(ap->host);
+		scsi_host_put(ap->host);
+	}
+
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
+	pci_release_regions(pdev);
+	kfree(host_set);
+	pci_disable_device(pdev);
+	dev_set_drvdata(dev, NULL);
+}
 
 static int __init ahci_init(void)
 {

--------------080500000406030103020804--
