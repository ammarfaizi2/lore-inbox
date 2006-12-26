Return-Path: <linux-kernel-owner+w=401wt.eu-S932672AbWLZPV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWLZPV7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWLZPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:21:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59065 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbWLZPSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=U2z/F9M7Nkn9heGKjrV6K33xK1/Svu2DLIz3k2q6YHuTC3mI+K8zTHrj+E8OdmHHaQT8JxYOzf+xsMS17WIKy3JTaK6+cak7/TLvt1KjoGHfkw2FM4F28WWCSJgGtQ4F8/R7gaOXjdcPtxx9TgLqwYHjHfqT0Q9Tmh6qqhvs3/c=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/12] libata: update libata core layer to use devres
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-Id: <116714631418-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update libata core layer to use devres.

* ata_device_add() acquires all resources in managed mode.

* ata_host is allocated as devres associated with ata_host_release.

* Port attached status is handled as devres associated with
  ata_host_attach_release().

* Initialization failure and host removal is handedl by releasing
  devres group.

* Except for ata_scsi_release() removal, LLD interface remains the
  same.  Some functions use hacky is_managed test to support both
  managed and unmanaged devices.  These will go away once all LLDs are
  updated to use devres.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   22 +-----
 drivers/ata/libata-core.c |  176 ++++++++++++++++++++-------------------------
 drivers/ata/libata-scsi.c |    3 +-
 drivers/ata/libata-sff.c  |   47 ++++++-------
 include/linux/libata.h    |    9 +--
 5 files changed, 109 insertions(+), 148 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0656334..76bf3e6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1763,38 +1763,24 @@ err_out:
 	return rc;
 }
 
-static void ahci_remove_one (struct pci_dev *pdev)
+static void ahci_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	unsigned int i;
-	int have_msi;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_remove(host);
 
-	have_msi = hpriv->flags & AHCI_FLAG_MSI;
-	free_irq(host->irq, host);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_scsi_release(ap->scsi_host);
-		scsi_host_put(ap->scsi_host);
-	}
-
-	kfree(hpriv);
 	pci_iounmap(pdev, host->mmio_base);
-	kfree(host);
 
-	if (have_msi)
+	if (hpriv->flags & AHCI_FLAG_MSI)
 		pci_disable_msi(pdev);
 	else
 		pci_intx(pdev, 0);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
+	kfree(hpriv);
 }
 
 static int __init ahci_init(void)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5fdf37f..3af7994 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5511,28 +5511,25 @@ void ata_host_resume(struct ata_host *host)
  *	LOCKING:
  *	Inherited from caller.
  */
-
-int ata_port_start (struct ata_port *ap)
+int ata_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->dev;
 	int rc;
 
-	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
+	ap->prd = dmam_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma,
+				      GFP_KERNEL);
 	if (!ap->prd)
 		return -ENOMEM;
 
 	rc = ata_pad_alloc(ap, dev);
-	if (rc) {
-		dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	if (rc)
 		return rc;
-	}
-
-	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
 
+	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd,
+		(unsigned long long)ap->prd_dma);
 	return 0;
 }
 
-
 /**
  *	ata_port_stop - Undo ata_port_start()
  *	@ap: Port to shut down
@@ -5544,12 +5541,11 @@ int ata_port_start (struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-
 void ata_port_stop (struct ata_port *ap)
 {
 	struct device *dev = ap->dev;
 
-	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	dmam_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 	ata_pad_free(ap, dev);
 }
 
@@ -5732,6 +5728,27 @@ static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
 	return ap;
 }
 
+static void ata_host_release(struct device *gendev, void *res)
+{
+	struct ata_host *host = dev_get_drvdata(gendev);
+	int i;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (!ap)
+			continue;
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+
+		scsi_host_put(ap->scsi_host);
+	}
+
+	if (host->ops->host_stop)
+		host->ops->host_stop(host);
+}
+
 /**
  *	ata_sas_host_init - Initialize a host struct
  *	@host:	host to initialize
@@ -5784,11 +5801,17 @@ int ata_device_add(const struct ata_probe_ent *ent)
 		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
 		return 0;
 	}
+
+	if (!devres_open_group(dev, ata_device_add, GFP_KERNEL))
+		return 0;
+
 	/* alloc a container for our list of ATA ports (buses) */
-	host = kzalloc(sizeof(struct ata_host) +
-		       (ent->n_ports * sizeof(void *)), GFP_KERNEL);
+	host = devres_alloc(ata_host_release, sizeof(struct ata_host) +
+			    (ent->n_ports * sizeof(void *)), GFP_KERNEL);
 	if (!host)
-		return 0;
+		goto err_out;
+	devres_add(dev, host);
+	dev_set_drvdata(dev, host);
 
 	ata_host_init(host, dev, ent->_host_flags, ent->port_ops);
 	host->n_ports = ent->n_ports;
@@ -5846,8 +5869,8 @@ int ata_device_add(const struct ata_probe_ent *ent)
 	}
 
 	/* obtain irq, that may be shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
+	rc = devm_request_irq(dev, ent->irq, ent->port_ops->irq_handler,
+			      ent->irq_flags, DRV_NAME, host);
 	if (rc) {
 		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 			   ent->irq, rc);
@@ -5860,15 +5883,19 @@ int ata_device_add(const struct ata_probe_ent *ent)
 		   so trap it now */
 		BUG_ON(ent->irq == ent->irq2);
 
-		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
+		rc = devm_request_irq(dev, ent->irq2,
+				ent->port_ops->irq_handler, ent->irq_flags,
+				DRV_NAME, host);
 		if (rc) {
 			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 				   ent->irq2, rc);
-			goto err_out_free_irq;
+			goto err_out;
 		}
 	}
 
+	/* resource acquisition complete */
+	devres_close_group(dev, ata_device_add);
+
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
 	for (i = 0; i < host->n_ports; i++) {
@@ -5937,24 +5964,13 @@ int ata_device_add(const struct ata_probe_ent *ent)
 		ata_scsi_scan_host(ap);
 	}
 
-	dev_set_drvdata(dev, host);
-
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
 
-err_out_free_irq:
-	free_irq(ent->irq, host);
-err_out:
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-		if (ap) {
-			ap->ops->port_stop(ap);
-			scsi_host_put(ap->scsi_host);
-		}
-	}
-
-	kfree(host);
-	VPRINTK("EXIT, returning 0\n");
+ err_out:
+	devres_release_group(dev, ata_device_add);
+	dev_set_drvdata(dev, NULL);
+	VPRINTK("EXIT, returning %d\n", rc);
 	return 0;
 }
 
@@ -6026,7 +6042,6 @@ void ata_port_detach(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-
 void ata_host_remove(struct ata_host *host)
 {
 	unsigned int i;
@@ -6034,59 +6049,7 @@ void ata_host_remove(struct ata_host *host)
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
 
-	free_irq(host->irq, host);
-	if (host->irq2)
-		free_irq(host->irq2, host);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_scsi_release(ap->scsi_host);
-
-		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
-			struct ata_ioports *ioaddr = &ap->ioaddr;
-
-			/* FIXME: Add -ac IDE pci mods to remove these special cases */
-			if (ioaddr->cmd_addr == ATA_PRIMARY_CMD)
-				release_region(ATA_PRIMARY_CMD, 8);
-			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
-				release_region(ATA_SECONDARY_CMD, 8);
-		}
-
-		scsi_host_put(ap->scsi_host);
-	}
-
-	if (host->ops->host_stop)
-		host->ops->host_stop(host);
-
-	kfree(host);
-}
-
-/**
- *	ata_scsi_release - SCSI layer callback hook for host unload
- *	@shost: libata host to be unloaded
- *
- *	Performs all duties necessary to shut down a libata port...
- *	Kill port kthread, disable port, and release resources.
- *
- *	LOCKING:
- *	Inherited from SCSI layer.
- *
- *	RETURNS:
- *	One.
- */
-
-int ata_scsi_release(struct Scsi_Host *shost)
-{
-	struct ata_port *ap = ata_shost_to_port(shost);
-
-	DPRINTK("ENTER\n");
-
-	ap->ops->port_disable(ap);
-	ap->ops->port_stop(ap);
-
-	DPRINTK("EXIT\n");
-	return 1;
+	devres_release_group(host->dev, ata_device_add);
 }
 
 struct ata_probe_ent *
@@ -6094,7 +6057,11 @@ ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
+	/* XXX - the following if can go away once all LLDs are managed */
+	if (!list_empty(&dev->devres_head))
+		probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	else
+		probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
@@ -6148,7 +6115,11 @@ void ata_pci_host_stop (struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 
-	pci_iounmap(pdev, host->mmio_base);
+	/* XXX - the following if can go away once all LLDs are managed */
+	if (!list_empty(&host->dev->devres_head))
+		pcim_iounmap(pdev, host->mmio_base);
+	else
+		pci_iounmap(pdev, host->mmio_base);
 }
 
 /**
@@ -6164,17 +6135,23 @@ void ata_pci_host_stop (struct ata_host *host)
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
  */
-
-void ata_pci_remove_one (struct pci_dev *pdev)
+void ata_pci_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host *host = dev_get_drvdata(dev);
 
-	ata_host_remove(host);
+	/* XXX - the following if can go away once all LLDs are managed */
+	if (!list_empty(&host->dev->devres_head)) {
+		ata_host_remove(host);
+		pci_release_regions(pdev);
+		pci_disable_device(pdev);
+		dev_set_drvdata(dev, NULL);
+	} else {
+		int i;
 
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
+		for (i = 0; i < host->n_ports; i++)
+			ata_port_detach(host->ports[i]);
+	}
 }
 
 /* move to PCI subsystem */
@@ -6228,7 +6205,11 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
-	rc = pci_enable_device(pdev);
+	/* XXX - the following if can go away once all LLDs are managed */
+	if (!list_empty(&pdev->dev.devres_head))
+		rc = pcim_enable_device(pdev);
+	else
+		rc = pci_enable_device(pdev);
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "failed to enable device after resume (%d)\n", rc);
@@ -6467,7 +6448,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 836947d..9db2d07 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3226,7 +3226,8 @@ EXPORT_SYMBOL_GPL(ata_sas_port_init);
 
 void ata_sas_port_destroy(struct ata_port *ap)
 {
-	ap->ops->port_stop(ap);
+	if (ap->ops->port_stop)
+		ap->ops->port_stop(ap);
 	kfree(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10ee22a..be9a0db 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -979,15 +979,18 @@ static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
+	struct device *dev = &pdev->dev;
 	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_port_info *port[2];
 	u8 mask;
 	unsigned int legacy_mode = 0;
-	int disable_dev_on_err = 1;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	BUG_ON(n_ports < 1 || n_ports > 2);
 
 	port[0] = port_info[0];
@@ -1004,9 +1007,9 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 	   boot for the primary video which is BIOS enabled
          */
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
-		return rc;
+		goto err_out;
 
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		u8 tmp8;
@@ -1022,19 +1025,20 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		   left a device in compatibility mode */
 		if (legacy_mode) {
 			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
-			return -EOPNOTSUPP;
+			rc = -EOPNOTSUPP;
+			goto err_out;
 		}
 #endif
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		disable_dev_on_err = 0;
+		pcim_pin_device(pdev);
 		goto err_out;
 	}
 
 	if (legacy_mode) {
-		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
+		if (!devm_request_region(dev, ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_PRIMARY_CMD;
 			res.end = ATA_PRIMARY_CMD + 8 - 1;
@@ -1044,7 +1048,7 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= ATA_PORT_PRIMARY;
 			else {
-				disable_dev_on_err = 0;
+				pcim_pin_device(pdev);
 				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n" \
 						    "ata: conflict with %s\n",
 						    ATA_PRIMARY_CMD,
@@ -1053,7 +1057,7 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		} else
 			legacy_mode |= ATA_PORT_PRIMARY;
 
-		if (!request_region(ATA_SECONDARY_CMD, 8, "libata")) {
+		if (!devm_request_region(dev, ATA_SECONDARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_SECONDARY_CMD;
 			res.end = ATA_SECONDARY_CMD + 8 - 1;
@@ -1063,7 +1067,7 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= ATA_PORT_SECONDARY;
 			else {
-				disable_dev_on_err = 0;
+				pcim_pin_device(pdev);
 				printk(KERN_WARNING "ata: 0x%X IDE port busy\n" \
 						    "ata: conflict with %s\n",
 						    ATA_SECONDARY_CMD,
@@ -1076,16 +1080,16 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 	/* we have legacy mode, but all ports are unavailable */
 	if (legacy_mode == (1 << 3)) {
 		rc = -EBUSY;
-		goto err_out_regions;
+		goto err_out;
 	}
 
 	/* TODO: If we get no DMA mask we should fall back to PIO */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		goto err_out;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		goto err_out;
 
 	if (legacy_mode) {
 		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
@@ -1097,31 +1101,22 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 	}
 	if (!probe_ent) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out;
 	}
 
 	pci_set_master(pdev);
 
 	if (!ata_device_add(probe_ent)) {
 		rc = -ENODEV;
-		goto err_out_ent;
+		goto err_out;
 	}
 
-	kfree(probe_ent);
-
+	devm_kfree(dev, probe_ent);
+	devres_remove_group(dev, NULL);
 	return 0;
 
-err_out_ent:
-	kfree(probe_ent);
-err_out_regions:
-	if (legacy_mode & ATA_PORT_PRIMARY)
-		release_region(ATA_PRIMARY_CMD, 8);
-	if (legacy_mode & ATA_PORT_SECONDARY)
-		release_region(ATA_SECONDARY_CMD, 8);
-	pci_release_regions(pdev);
 err_out:
-	if (disable_dev_on_err)
-		pci_disable_device(pdev);
+	devres_release_group(dev, NULL);
 	return rc;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8028a57..293d80b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -31,7 +31,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <asm/scatterlist.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
@@ -732,7 +732,6 @@ extern void ata_host_remove(struct ata_host *host);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_release(struct Scsi_Host *host);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
@@ -1229,14 +1228,14 @@ static inline unsigned int __ac_err_mask(u8 status)
 static inline int ata_pad_alloc(struct ata_port *ap, struct device *dev)
 {
 	ap->pad_dma = 0;
-	ap->pad = dma_alloc_coherent(dev, ATA_DMA_PAD_BUF_SZ,
-				     &ap->pad_dma, GFP_KERNEL);
+	ap->pad = dmam_alloc_coherent(dev, ATA_DMA_PAD_BUF_SZ,
+				      &ap->pad_dma, GFP_KERNEL);
 	return (ap->pad == NULL) ? -ENOMEM : 0;
 }
 
 static inline void ata_pad_free(struct ata_port *ap, struct device *dev)
 {
-	dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
+	dmam_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
 }
 
 static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
-- 
1.4.4.2


