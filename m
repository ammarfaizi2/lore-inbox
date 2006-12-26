Return-Path: <linux-kernel-owner+w=401wt.eu-S932650AbWLZPWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWLZPWH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWLZPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:22:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbWLZPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=mlN8nsi2Psz4YCTQwEAwvoUq80QnOzV3amvVWpZ1qNEH14wCLqLQgZvgPJrk/mkzlcmJwL6jP6oOxYmxVdGhY0wL10mykd7qwshzHTrsDrFIzQ2zbcdTRZsOpnhwUR9mq2Qk9JLzSHhHQ/yMipMe4V+VsM5R3cK2aLqP9DUnvNY=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata: remove unused functions
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:35 +0900
Message-Id: <11671463153555-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all LLDs are converted to use devres, default stop callbacks
are unused.  Remove them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   91 ++++-----------------------------------------
 include/linux/libata.h    |    4 --
 2 files changed, 8 insertions(+), 87 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3af7994..e4ad6e1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5531,31 +5531,6 @@ int ata_port_start(struct ata_port *ap)
 }
 
 /**
- *	ata_port_stop - Undo ata_port_start()
- *	@ap: Port to shut down
- *
- *	Frees the PRD table.
- *
- *	May be used as the port_stop() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_port_stop (struct ata_port *ap)
-{
-	struct device *dev = ap->dev;
-
-	dmam_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
-	ata_pad_free(ap, dev);
-}
-
-void ata_host_stop (struct ata_host *host)
-{
-	if (host->mmio_base)
-		iounmap(host->mmio_base);
-}
-
-/**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
  *
@@ -5894,7 +5869,7 @@ int ata_device_add(const struct ata_probe_ent *ent)
 	}
 
 	/* resource acquisition complete */
-	devres_close_group(dev, ata_device_add);
+	devres_remove_group(dev, ata_device_add);
 
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
@@ -6032,26 +6007,6 @@ void ata_port_detach(struct ata_port *ap)
 	scsi_remove_host(ap->scsi_host);
 }
 
-/**
- *	ata_host_remove - PCI layer callback for device removal
- *	@host: ATA host set that was removed
- *
- *	Unregister all objects associated with this host set. Free those
- *	objects.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- */
-void ata_host_remove(struct ata_host *host)
-{
-	unsigned int i;
-
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
-
-	devres_release_group(host->dev, ata_device_add);
-}
-
 struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 {
@@ -6111,26 +6066,13 @@ void ata_std_ports(struct ata_ioports *ioaddr)
 
 #ifdef CONFIG_PCI
 
-void ata_pci_host_stop (struct ata_host *host)
-{
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	/* XXX - the following if can go away once all LLDs are managed */
-	if (!list_empty(&host->dev->devres_head))
-		pcim_iounmap(pdev, host->mmio_base);
-	else
-		pci_iounmap(pdev, host->mmio_base);
-}
-
 /**
  *	ata_pci_remove_one - PCI layer callback for device removal
  *	@pdev: PCI device that was removed
  *
- *	PCI layer indicates to libata via this hook that
- *	hot-unplug or module unload event has occurred.
- *	Handle this by unregistering all objects associated
- *	with this PCI device.  Free those objects.  Then finally
- *	release PCI resources and disable device.
+ *	PCI layer indicates to libata via this hook that hot-unplug or
+ *	module unload event has occurred.  Detach all ports.  Resource
+ *	release is handled via devres.
  *
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
@@ -6139,19 +6081,10 @@ void ata_pci_remove_one(struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host *host = dev_get_drvdata(dev);
+	int i;
 
-	/* XXX - the following if can go away once all LLDs are managed */
-	if (!list_empty(&host->dev->devres_head)) {
-		ata_host_remove(host);
-		pci_release_regions(pdev);
-		pci_disable_device(pdev);
-		dev_set_drvdata(dev, NULL);
-	} else {
-		int i;
-
-		for (i = 0; i < host->n_ports; i++)
-			ata_port_detach(host->ports[i]);
-	}
+	for (i = 0; i < host->n_ports; i++)
+		ata_port_detach(host->ports[i]);
 }
 
 /* move to PCI subsystem */
@@ -6205,11 +6138,7 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
-	/* XXX - the following if can go away once all LLDs are managed */
-	if (!list_empty(&pdev->dev.devres_head))
-		rc = pcim_enable_device(pdev);
-	else
-		rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "failed to enable device after resume (%d)\n", rc);
@@ -6389,7 +6318,6 @@ EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_port_detach);
-EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_hsm_move);
@@ -6406,8 +6334,6 @@ EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
-EXPORT_SYMBOL_GPL(ata_port_stop);
-EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
@@ -6468,7 +6394,6 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 293d80b..579db68 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -728,7 +728,6 @@ extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
-extern void ata_host_remove(struct ata_host *host);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
@@ -774,8 +773,6 @@ extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
-extern void ata_port_stop (struct ata_port *ap);
-extern void ata_host_stop (struct ata_host *host);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance);
 extern void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			       unsigned int buflen, int write_data);
@@ -862,7 +859,6 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern void ata_pci_host_stop (struct ata_host *host);
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-- 
1.4.4.2


