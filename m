Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWGHPZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWGHPZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWGHPZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:25:52 -0400
Received: from havoc.gtf.org ([69.61.125.42]:19401 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964866AbWGHPZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:25:50 -0400
Date: Sat, 8 Jul 2006 11:25:49 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata: various alloc/free cleanups
Message-ID: <20060708152549.GA16985@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just checked this into libata-dev.git#iomap ...

 drivers/scsi/ahci.c        |   12 +-
 drivers/scsi/libata-core.c |  226 ++++++++++++++++++++++-----------------------
 include/linux/libata.h     |    2 
 3 files changed, 120 insertions(+), 120 deletions(-)

commit 64699e30b9bdd3c4b32fdd61d65adbb8891d8e82
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 11:22:52 2006 -0400

    [libata] Kill ata_scsi_release(), use ata_host_set_free() in ahci
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 297e88a5d7b7a02a55d8771c79e60e764862de12
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 11:02:53 2006 -0400

    [libata] Move port alloc from ata_port_add() to ata_host_set_alloc()
    
    Continue separating allocation code from registration code.
    
    Also, update ata_host_set_alloc() to return struct ata_host_set*
    rather than int.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 94e4824fbce2546e87b34ff0a9d4c787919a1702
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 10:52:06 2006 -0400

    [libata] Kill 'count' var in ata_device_add()
    
    Eliminate redundant loop variable 'count'
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit eef6d8a82efa933bbd03db0f65826ec4525739b7
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 10:47:23 2006 -0400

    [libata] Call ata_port_free() from ata_host_set_free()
    
    To make allocation management more sane, call ata_port_free()
    from ata_host_set_free(), so that the container and contents are freed
    at the same time.
    
    Call ata_host_set_free() during ata_device_add() error handling,
    and fix bugs in error handling path.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit a0a341a99af13fd05576516a4a294faf48050482
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 10:10:20 2006 -0400

    [libata] call ata_port_free() where appropriate
    
    Basically s/scsi_host_put/ata_port_free/
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 2ad961dac0bd74c03cfd5ad9536e6d2ee688fdf9
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 10:06:41 2006 -0400

    [libata] manually inline ata_host_remove()
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit a66b87de99c03601ad04633d590e56c8ac2b2777
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 09:59:51 2006 -0400

    [libata] break code out into ata_port_{alloc,free}
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 2e32589afe216c84d630423b2330cf277c415729
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 09:48:00 2006 -0400

    [libata] some function renaming
    
    s/ata_host_add/ata_port_add/
    s/ata_host_init/ata_port_init/
    
    libata naming got stuck in the middle of a Great Renaming:
    
    	ata_host -> ata_port
    	ata_host_set -> ata_host
    
    To eliminate confusion, let's just give up for now, and simply ensure
    that things are internally consistent.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 971bbe9b2c809b058143e1cb973f9ca4a778a3fa
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 09:44:00 2006 -0400

    [libata] Split out code into new helper ata_host_set_alloc()
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 396109fef236a18274e5bd89896496eddac40898
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Jul 8 09:31:34 2006 -0400

    [libata] Add helper ata_host_set_free()
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 77e7202..32135f6 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1432,6 +1432,11 @@ static void ahci_remove_one (struct pci_
 	unsigned int i;
 	int have_msi;
 
+	/*
+	 * FIXME: fix code to allow a call to ata_host_set_remove(),
+	 * rather than duplicating much of its code here.
+	 */
+
 	for (i = 0; i < host_set->n_ports; i++)
 		ata_port_detach(host_set->ports[i]);
 
@@ -1440,14 +1445,13 @@ static void ahci_remove_one (struct pci_
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
-
-		ata_scsi_release(ap->host);
-		scsi_host_put(ap->host);
+		ata_port_disable(ap);
+		ahci_port_stop(ap);
 	}
 
 	kfree(hpriv);
 	pci_iounmap(pdev, host_set->mmio_base);
-	kfree(host_set);
+	ata_host_set_free(host_set);
 
 	if (have_msi)
 		pci_disable_msi(pdev);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..70897a1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5185,28 +5185,6 @@ void ata_host_stop (struct ata_host_set 
 		iounmap(host_set->mmio_base);
 }
 
-
-/**
- *	ata_host_remove - Unregister SCSI host structure with upper layers
- *	@ap: Port to unregister
- *	@do_unregister: 1 if we fully unregister, 0 to just stop the port
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_host_remove(struct ata_port *ap, unsigned int do_unregister)
-{
-	struct Scsi_Host *sh = ap->host;
-
-	DPRINTK("ENTER\n");
-
-	if (do_unregister)
-		scsi_remove_host(sh);
-
-	ap->ops->port_stop(ap);
-}
-
 /**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
@@ -5240,7 +5218,7 @@ void ata_dev_init(struct ata_device *dev
 }
 
 /**
- *	ata_host_init - Initialize an ata_port structure
+ *	ata_port_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: associated SCSI mid-layer structure
  *	@host_set: Collection of hosts to which @ap belongs
@@ -5253,7 +5231,7 @@ void ata_dev_init(struct ata_device *dev
  *	LOCKING:
  *	Inherited from caller.
  */
-static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
+static void ata_port_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
 {
@@ -5319,11 +5297,39 @@ #endif
 	memcpy(&ap->ioaddr, &ent->port[port_no], sizeof(struct ata_ioports));
 }
 
+static struct ata_port * ata_port_alloc(const struct ata_probe_ent *ent,
+				        struct ata_host_set *host_set,
+				        unsigned int port_no)
+{
+	struct Scsi_Host *host;
+	struct ata_port *ap;
+
+	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
+	if (!host)
+		return NULL;
+
+	host->transportt = &ata_scsi_transport_template;
+
+	ap = ata_shost_to_port(host);
+
+	ata_port_init(ap, host, host_set, ent, port_no);
+
+	return ap;
+}
+
+static void ata_port_free(struct ata_port *ap)
+{
+	/* free(NULL) is supported */
+	if (!ap)
+		return;
+
+	scsi_host_put(ap->host);
+}
+
 /**
- *	ata_host_add - Attach low-level ATA driver to system
+ *	ata_port_add - Attach low-level ATA driver to system
  *	@ent: Information provided by low-level driver
- *	@host_set: Collections of ports to which we add
- *	@port_no: Port number associated with this host
+ *	@ap: ATA port to be attached
  *
  *	Attach low-level ATA driver to system.
  *
@@ -5334,41 +5340,56 @@ #endif
  *	New ata_port on success, for NULL on error.
  */
 
-static struct ata_port * ata_host_add(const struct ata_probe_ent *ent,
-				      struct ata_host_set *host_set,
-				      unsigned int port_no)
+static int ata_port_add(const struct ata_probe_ent *ent, struct ata_port *ap)
 {
-	struct Scsi_Host *host;
-	struct ata_port *ap;
-	int rc;
-
 	DPRINTK("ENTER\n");
 
 	if (!ent->port_ops->error_handler &&
 	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
 		printk(KERN_ERR "ata%u: no reset mechanism available\n",
-		       port_no);
-		return NULL;
+		       ap->port_no);
+		return -EINVAL;
 	}
 
-	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
-	if (!host)
+	return ap->ops->port_start(ap);
+}
+
+static struct ata_host_set *ata_host_set_alloc(const struct ata_probe_ent *ent)
+{
+	struct ata_host_set *host_set;
+	unsigned int i;
+
+	/* alloc a container for our list of ATA ports (buses) */
+	host_set = kzalloc(sizeof(struct ata_host_set) +
+			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
+	if (!host_set)
 		return NULL;
 
-	host->transportt = &ata_scsi_transport_template;
+	spin_lock_init(&host_set->lock);
 
-	ap = ata_shost_to_port(host);
+	host_set->dev = ent->dev;
+	host_set->n_ports = ent->n_ports;
+	host_set->irq = ent->irq;
+	host_set->mmio_base = ent->mmio_base;
+	host_set->private_data = ent->private_data;
+	host_set->ops = ent->port_ops;
+	host_set->flags = ent->host_set_flags;
 
-	ata_host_init(ap, host, host_set, ent, port_no);
+	/* allocate each port bound to this device */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
 
-	rc = ap->ops->port_start(ap);
-	if (rc)
-		goto err_out;
+		ap = ata_port_alloc(ent, host_set, i);
+		if (!ap)
+			goto err_out;
 
-	return ap;
+		host_set->ports[i] = ap;
+	}
+
+	return host_set;
 
 err_out:
-	scsi_host_put(host);
+	ata_host_set_free(host_set);
 	return NULL;
 }
 
@@ -5392,37 +5413,25 @@ err_out:
  */
 int ata_device_add(const struct ata_probe_ent *ent)
 {
-	unsigned int count = 0, i;
+	unsigned int i;
 	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 	int rc;
 
 	DPRINTK("ENTER\n");
-	/* alloc a container for our list of ATA ports (buses) */
-	host_set = kzalloc(sizeof(struct ata_host_set) +
-			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
+	host_set = ata_host_set_alloc(ent);
 	if (!host_set)
 		return 0;
-	spin_lock_init(&host_set->lock);
-
-	host_set->dev = dev;
-	host_set->n_ports = ent->n_ports;
-	host_set->irq = ent->irq;
-	host_set->mmio_base = ent->mmio_base;
-	host_set->private_data = ent->private_data;
-	host_set->ops = ent->port_ops;
-	host_set->flags = ent->host_set_flags;
 
 	/* register each port bound to this device */
-	for (i = 0; i < ent->n_ports; i++) {
-		struct ata_port *ap;
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 		unsigned long xfer_mode_mask;
 
-		ap = ata_host_add(ent, host_set, i);
-		if (!ap)
+		rc = ata_port_add(ent, ap);
+		if (rc)
 			goto err_out;
 
-		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
@@ -5440,12 +5449,8 @@ int ata_device_add(const struct ata_prob
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
 		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
-		count++;
 	}
 
-	if (!count)
-		goto err_free_ret;
-
 	/* obtain irq, that is shared between channels */
 	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			 DRV_NAME, host_set);
@@ -5457,13 +5462,11 @@ int ata_device_add(const struct ata_prob
 
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
-	for (i = 0; i < count; i++) {
-		struct ata_port *ap;
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 		u32 scontrol;
 		int rc;
 
-		ap = host_set->ports[i];
-
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
@@ -5519,7 +5522,7 @@ int ata_device_add(const struct ata_prob
 
 	/* probes are done, now scan each port's disk(s) */
 	DPRINTK("host probe begin\n");
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_scan_host(ap);
@@ -5531,12 +5534,13 @@ int ata_device_add(const struct ata_prob
 	return ent->n_ports; /* success */
 
 err_out:
-	for (i = 0; i < count; i++) {
-		ata_host_remove(host_set->ports[i], 1);
-		scsi_host_put(host_set->ports[i]->host);
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		if (ap)
+			ap->ops->port_stop(ap);
 	}
-err_free_ret:
-	kfree(host_set);
+
+	ata_host_set_free(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
 }
@@ -5599,11 +5603,30 @@ void ata_port_detach(struct ata_port *ap
 }
 
 /**
- *	ata_host_set_remove - PCI layer callback for device removal
+ *	ata_host_set_free - Release a host_set
+ *	@host_set: ATA host set to be freed
+ *
+ *	Free all objects associated with this host set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+
+void ata_host_set_free(struct ata_host_set *host_set)
+{
+	unsigned int i;
+
+	for (i = 0; i < host_set->n_ports; i++)
+		ata_port_free(host_set->ports[i]);
+
+	kfree(host_set);
+}
+
+/**
+ *	ata_host_set_remove - Unregister a host_set from the system
  *	@host_set: ATA host set that was removed
  *
- *	Unregister all objects associated with this host set. Free those
- *	objects.
+ *	Unregister all objects associated with this host set.
  *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
@@ -5621,7 +5644,8 @@ void ata_host_set_remove(struct ata_host
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
-		ata_scsi_release(ap->host);
+		ap->ops->port_disable(ap);
+		ap->ops->port_stop(ap);
 
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -5631,41 +5655,10 @@ void ata_host_set_remove(struct ata_host
 			else if (ioaddr->cmd_addr == 0x170)
 				release_region(0x170, 8);
 		}
-
-		scsi_host_put(ap->host);
 	}
 
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
-
-	kfree(host_set);
-}
-
-/**
- *	ata_scsi_release - SCSI layer callback hook for host unload
- *	@host: libata host to be unloaded
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
-int ata_scsi_release(struct Scsi_Host *host)
-{
-	struct ata_port *ap = ata_shost_to_port(host);
-
-	DPRINTK("ENTER\n");
-
-	ap->ops->port_disable(ap);
-	ata_host_remove(ap, 0);
-
-	DPRINTK("EXIT\n");
-	return 1;
 }
 
 /**
@@ -5725,8 +5718,11 @@ void ata_pci_remove_one (struct pci_dev 
 	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
-	if (host_set2)
+	ata_host_set_free(host_set);
+	if (host_set2) {
 		ata_host_set_remove(host_set2);
+		ata_host_set_free(host_set2);
+	}
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -5929,6 +5925,7 @@ EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_port_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
+EXPORT_SYMBOL_GPL(ata_host_set_free);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_hsm_move);
@@ -5987,7 +5984,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6cc497a..925aeca 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -683,10 +683,10 @@ #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_port_detach(struct ata_port *ap);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
+extern void ata_host_set_free(struct ata_host_set *host_set);
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int sata_scr_valid(struct ata_port *ap);
 extern int sata_scr_read(struct ata_port *ap, int reg, u32 *val);
