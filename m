Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbWF0BYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbWF0BYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWF0BYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:24:10 -0400
Received: from havoc.gtf.org ([69.61.125.42]:8401 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030593AbWF0BYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:24:07 -0400
Date: Mon, 26 Jun 2006 21:24:05 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata update
Message-ID: <20060627012405.GA2666@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bug fixes, better suspend/resume prep, bump versions.

Also, a drivers/ide patch that Andrew queued for me.  This is an
exception, rather than a rule...  I'm not interested in patching
drivers/ide in general, and don't want other patches to start coming
my way.


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/ide/pci/amd74xx.c  |    7 +-
 drivers/scsi/Kconfig       |    2 
 drivers/scsi/ahci.c        |    2 
 drivers/scsi/ata_piix.c    |    2 
 drivers/scsi/libata-core.c |  151 ++++++++++++++++++++++++++++-----------------
 drivers/scsi/libata-eh.c   |   63 +++++++++++-------
 drivers/scsi/libata.h      |    4 -
 drivers/scsi/sata_nv.c     |    2 
 drivers/scsi/sata_sil.c    |   31 +++++++--
 drivers/scsi/sata_sil24.c  |    2 
 drivers/scsi/sata_svw.c    |    2 
 drivers/scsi/sata_uli.c    |    2 
 drivers/scsi/sata_via.c    |    2 
 drivers/scsi/sata_vsc.c    |   12 +--
 include/linux/libata.h     |   15 ++++
 include/linux/pci_ids.h    |    2 
 16 files changed, 191 insertions(+), 110 deletions(-)

Andrew Morton:
      libata.h needs scatterlist.h
      libata reduce timeouts

Auke Kok:
      ata_piix: add ICH6/7/8 to Kconfig

Jeff Garzik:
      [libata] Bump versions
      [libata] sata_vsc: partially revert a PCI ID-related commit

Randy Dunlap:
      ata: add some NVIDIA chipset IDs

Tejun Heo:
      libata: move ata_eh_clear_action() upward
      libata: implement and use ata_deh_dev_action()
      libata: clear EH action on device detach
      libata: move ata_do_simple_cmd() below ata_exec_internal()
      libata: update ata_do_simple_cmd()
      libata: make two functions global
      libata: implement ata_port_max_devices()
      libata: cosmetic updates
      sata_sil: disable hotplug interrupts on two ATI IXPs

diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
index 6e9dbf4..85007cb 100644
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -75,6 +75,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
 	{ 0 }
 };
@@ -490,7 +491,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
 	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61"),
-	/* 18 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP65"),
+	/* 19 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -528,7 +530,8 @@ #endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index c84b02a..96a81cd 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -501,7 +501,7 @@ config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for ICH5 Serial ATA.
+	  This option enables support for ICH5/6/7/8 Serial ATA.
 	  If PATA support was enabled previously, this enables
 	  support for select Intel PIIX/ICH PATA host controllers.
 
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4bb77f6..f059467 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -48,7 +48,7 @@ #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.3"
+#define DRV_VERSION	"2.0"
 
 
 enum {
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 521b718..94b1261 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -93,7 +93,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"1.10"
+#define DRV_VERSION	"2.00"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6c66877..47fff7b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -88,6 +88,10 @@ int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
 
+static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
+module_param(ata_probe_timeout, int, 0444);
+MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -777,11 +781,9 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	if (ata_msg_probe(ap)) {
+	if (ata_msg_probe(ap))
 		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
-				"device %u, wait %u\n",
-				ap->id, device, wait);
-	}
+				"device %u, wait %u\n", ap->id, device, wait);
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -950,7 +952,8 @@ void ata_port_flush_task(struct ata_port
 	 */
 	if (!cancel_delayed_work(&ap->port_task)) {
 		if (ata_msg_ctl(ap))
-			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n", __FUNCTION__);
+			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n",
+					__FUNCTION__);
 		flush_workqueue(ata_wq);
 	}
 
@@ -1059,7 +1062,7 @@ unsigned ata_exec_internal(struct ata_de
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	rc = wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL);
+	rc = wait_for_completion_timeout(&wait, ata_probe_timeout);
 
 	ata_port_flush_task(ap);
 
@@ -1081,7 +1084,7 @@ unsigned ata_exec_internal(struct ata_de
 
 			if (ata_msg_warn(ap))
 				ata_dev_printk(dev, KERN_WARNING,
-				       "qc timeout (cmd 0x%x)\n", command);
+					"qc timeout (cmd 0x%x)\n", command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);
@@ -1093,9 +1096,9 @@ unsigned ata_exec_internal(struct ata_de
 
 	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
 		if (ata_msg_warn(ap))
-			ata_dev_printk(dev, KERN_WARNING, 
+			ata_dev_printk(dev, KERN_WARNING,
 				"zero err_mask for failed "
-			       "internal command, assuming AC_ERR_OTHER\n");
+				"internal command, assuming AC_ERR_OTHER\n");
 		qc->err_mask |= AC_ERR_OTHER;
 	}
 
@@ -1132,6 +1135,33 @@ unsigned ata_exec_internal(struct ata_de
 }
 
 /**
+ *	ata_do_simple_cmd - execute simple internal command
+ *	@dev: Device to which the command is sent
+ *	@cmd: Opcode to execute
+ *
+ *	Execute a 'simple' command, that only consists of the opcode
+ *	'cmd' itself, without filling any other registers
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+{
+	struct ata_taskfile tf;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = cmd;
+	tf.flags |= ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+}
+
+/**
  *	ata_pio_need_iordy	-	check if iordy needed
  *	@adev: ATA device
  *
@@ -1193,8 +1223,8 @@ int ata_dev_read_id(struct ata_device *d
 	int rc;
 
 	if (ata_msg_ctl(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
-				__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+			       __FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
@@ -1263,9 +1293,9 @@ int ata_dev_read_id(struct ata_device *d
 	return 0;
 
  err_out:
-	if (ata_msg_warn(ap)) 
+	if (ata_msg_warn(ap))
 		ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
-		       "(%s, err_mask=0x%x)\n", reason, err_mask);
+			       "(%s, err_mask=0x%x)\n", reason, err_mask);
 	return rc;
 }
 
@@ -1318,19 +1348,21 @@ int ata_dev_configure(struct ata_device 
 	int i, rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_INFO,
+			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
+			       __FUNCTION__, ap->id, dev->devno);
 		return 0;
 	}
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
-			__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+			       __FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: cfg 49:%04x 82:%04x 83:%04x "
-			       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+		ata_dev_printk(dev, KERN_DEBUG,
+			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
+			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
 			       __FUNCTION__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
@@ -1402,14 +1434,16 @@ int ata_dev_configure(struct ata_device 
 					ata_id_major_version(id),
 					ata_mode_string(xfer_mask),
 					(unsigned long long)dev->n_sectors,
-					dev->cylinders, dev->heads, dev->sectors);
+					dev->cylinders, dev->heads,
+					dev->sectors);
 		}
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
 			if (ata_msg_info(ap))
-				ata_dev_printk(dev, KERN_INFO, "ata%u: dev %u multi count %u\n",
-				ap->id, dev->devno, dev->multi_count);
+				ata_dev_printk(dev, KERN_INFO,
+					"ata%u: dev %u multi count %u\n",
+					ap->id, dev->devno, dev->multi_count);
 		}
 
 		dev->cdb_len = 16;
@@ -1422,8 +1456,8 @@ int ata_dev_configure(struct ata_device 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
 			if (ata_msg_warn(ap))
-				ata_dev_printk(dev, KERN_WARNING, 
-					"unsupported CDB len\n");
+				ata_dev_printk(dev, KERN_WARNING,
+					       "unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1466,8 +1500,8 @@ int ata_dev_configure(struct ata_device 
 
 err_out_nosup:
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, 
-				"%s: EXIT, err\n", __FUNCTION__);
+		ata_dev_printk(dev, KERN_DEBUG,
+			       "%s: EXIT, err\n", __FUNCTION__);
 	return rc;
 }
 
@@ -3527,7 +3561,7 @@ #endif /* __BIG_ENDIAN */
  *	Inherited from caller.
  */
 
-void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf, 
+void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->ap;
@@ -3573,7 +3607,7 @@ void ata_mmio_data_xfer(struct ata_devic
  *	Inherited from caller.
  */
 
-void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf, 
+void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf,
 		       unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->ap;
@@ -3607,7 +3641,7 @@ void ata_pio_data_xfer(struct ata_device
  *	@buflen: buffer length
  *	@write_data: read/write
  *
- *	Transfer data from/to the device data register by PIO. Do the 
+ *	Transfer data from/to the device data register by PIO. Do the
  *	transfer with interrupts disabled.
  *
  *	LOCKING:
@@ -4946,31 +4980,9 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
-/*
- * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
- * without filling any other registers
- */
-static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
-{
-	struct ata_taskfile tf;
-	int err;
-
-	ata_tf_init(dev, &tf);
-
-	tf.command = cmd;
-	tf.flags |= ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_NODATA;
-
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
-			       __FUNCTION__, err);
-
-	return err;
-}
-
-static int ata_flush_cache(struct ata_device *dev)
+int ata_flush_cache(struct ata_device *dev)
 {
+	unsigned int err_mask;
 	u8 cmd;
 
 	if (!ata_try_flush_cache(dev))
@@ -4981,17 +4993,41 @@ static int ata_flush_cache(struct ata_de
 	else
 		cmd = ATA_CMD_FLUSH;
 
-	return ata_do_simple_cmd(dev, cmd);
+	err_mask = ata_do_simple_cmd(dev, cmd);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int ata_standby_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+	unsigned int err_mask;
+
+	err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to standby drive "
+			       "(err_mask=0x%x)\n", err_mask);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int ata_start_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+	unsigned int err_mask;
+
+	err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to start drive "
+			       "(err_mask=0x%x)\n", err_mask);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /**
@@ -5212,7 +5248,7 @@ #if defined(ATA_VERBOSE_DEBUG)
 	ap->msg_enable = 0x00FF;
 #elif defined(ATA_DEBUG)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
-#else 
+#else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
@@ -5709,6 +5745,7 @@ #endif /* CONFIG_PCI */
 
 static int __init ata_init(void)
 {
+	ata_probe_timeout *= HZ;
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
 		return -ENOMEM;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 8233859..bf5a72a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -93,6 +93,38 @@ static int ata_ering_map(struct ata_erin
 	return rc;
 }
 
+static unsigned int ata_eh_dev_action(struct ata_device *dev)
+{
+	struct ata_eh_context *ehc = &dev->ap->eh_context;
+
+	return ehc->i.action | ehc->i.dev_action[dev->devno];
+}
+
+static void ata_eh_clear_action(struct ata_device *dev,
+				struct ata_eh_info *ehi, unsigned int action)
+{
+	int i;
+
+	if (!dev) {
+		ehi->action &= ~action;
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			ehi->dev_action[i] &= ~action;
+	} else {
+		/* doesn't make sense for port-wide EH actions */
+		WARN_ON(!(action & ATA_EH_PERDEV_MASK));
+
+		/* break ehi->action into ehi->dev_action */
+		if (ehi->action & action) {
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
+				ehi->dev_action[i] |= ehi->action & action;
+			ehi->action &= ~action;
+		}
+
+		/* turn off the specified per-dev action */
+		ehi->dev_action[dev->devno] &= ~action;
+	}
+}
+
 /**
  *	ata_scsi_timed_out - SCSI layer time out callback
  *	@cmd: timed out SCSI command
@@ -702,32 +734,11 @@ static void ata_eh_detach_dev(struct ata
 		ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
 	}
 
-	spin_unlock_irqrestore(ap->lock, flags);
-}
-
-static void ata_eh_clear_action(struct ata_device *dev,
-				struct ata_eh_info *ehi, unsigned int action)
-{
-	int i;
+	/* clear per-dev EH actions */
+	ata_eh_clear_action(dev, &ap->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &ap->eh_context.i, ATA_EH_PERDEV_MASK);
 
-	if (!dev) {
-		ehi->action &= ~action;
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ehi->dev_action[i] &= ~action;
-	} else {
-		/* doesn't make sense for port-wide EH actions */
-		WARN_ON(!(action & ATA_EH_PERDEV_MASK));
-
-		/* break ehi->action into ehi->dev_action */
-		if (ehi->action & action) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
-				ehi->dev_action[i] |= ehi->action & action;
-			ehi->action &= ~action;
-		}
-
-		/* turn off the specified per-dev action */
-		ehi->dev_action[dev->devno] &= ~action;
-	}
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 
 /**
@@ -1592,7 +1603,7 @@ static int ata_eh_revalidate_and_attach(
 		unsigned int action;
 
 		dev = &ap->device[i];
-		action = ehc->i.action | ehc->i.dev_action[dev->devno];
+		action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_enabled(dev)) {
 			if (ata_port_offline(ap)) {
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bdd4888..c325679 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -29,7 +29,7 @@ #ifndef __LIBATA_H__
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.30"	/* must be exactly four chars */
+#define DRV_VERSION	"2.00"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	struct ata_device	*dev;
@@ -50,6 +50,7 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
@@ -64,6 +65,7 @@ extern int ata_check_atapi_dma(struct at
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index d18e7e0..5cc42c6 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -44,7 +44,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.9"
+#define DRV_VERSION			"2.0"
 
 enum {
 	NV_PORTS			= 2,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..51d86d7 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -46,12 +46,13 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"2.0"
 
 enum {
 	/*
 	 * host flags
 	 */
+	SIL_FLAG_NO_SATA_IRQ	= (1 << 28),
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
@@ -62,8 +63,9 @@ enum {
 	 * Controller IDs
 	 */
 	sil_3112		= 0,
-	sil_3512		= 1,
-	sil_3114		= 2,
+	sil_3112_no_sata_irq	= 1,
+	sil_3512		= 2,
+	sil_3114		= 3,
 
 	/*
 	 * Register offsets
@@ -123,8 +125,8 @@ static const struct pci_device_id sil_pc
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
 	{ }	/* terminate list */
 };
 
@@ -217,6 +219,16 @@ static const struct ata_port_info sil_po
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
+	/* sil_3112_no_sata_irq */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_MOD15WRITE |
+				  SIL_FLAG_NO_SATA_IRQ,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
+	},
 	/* sil_3512 */
 	{
 		.sht		= &sil_sht,
@@ -437,6 +449,10 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
+		/* turn off SATA_IRQ if not supported */
+		if (ap->flags & SIL_FLAG_NO_SATA_IRQ)
+			bmdma2 &= ~SIL_DMA_SATA_IRQ;
+
 		if (bmdma2 == 0xffffffff ||
 		    !(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
@@ -474,8 +490,9 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ata_bmdma_irq_clear(ap);
 
-	/* turn on SATA IRQ */
-	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+	/* turn on SATA IRQ if supported */
+	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
+		writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
 
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c8b477c..b5f8fa9 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -31,7 +31,7 @@ #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.24"
+#define DRV_VERSION	"0.3"
 
 /*
  * Port request block (PRB) 32 bytes
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index c94b870..7566c2c 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -54,7 +54,7 @@ #include <asm/pci-bridge.h>
 #endif /* CONFIG_PPC_OF */
 
 #define DRV_NAME	"sata_svw"
-#define DRV_VERSION	"1.8"
+#define DRV_VERSION	"2.0"
 
 enum {
 	/* Taskfile registers offsets */
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index f668c99..64f3c1a 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -37,7 +37,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_uli"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"1.0"
 
 enum {
 	uli_5289		= 0,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 322890b..67c3d29 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -47,7 +47,7 @@ #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"1.2"
+#define DRV_VERSION	"2.0"
 
 enum board_ids_enum {
 	vt6420,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 6d0c4f1..616fd96 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -47,7 +47,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_vsc"
-#define DRV_VERSION	"1.2"
+#define DRV_VERSION	"2.0"
 
 enum {
 	/* Interrupt register offsets (from chip base address) */
@@ -443,16 +443,12 @@ err_out:
 }
 
 
-/*
- * Intel 31244 is supposed to be identical.
- * Compatibility is untested as of yet.
- */
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174,
+	{ PCI_VENDOR_ID_VITESSE, 0x7174,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244,
+	{ PCI_VENDOR_ID_INTEL, 0x3200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ }
+	{ }	/* terminate list */
 };
 
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 20b1cf5..f4284bf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -30,6 +30,7 @@ #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
+#include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
@@ -887,6 +888,9 @@ static inline unsigned int ata_tag_inter
 	return tag == ATA_MAX_QUEUE - 1;
 }
 
+/*
+ * device helpers
+ */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
 	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
@@ -917,6 +921,17 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+/*
+ * port helpers
+ */
+static inline int ata_port_max_devices(const struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+		return 2;
+	return 1;
+}
+
+
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c2fd2d1..9ae6b1a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1202,6 +1202,7 @@ #define PCI_DEVICE_ID_NVIDIA_NVENET_18  
 #define PCI_DEVICE_ID_NVIDIA_NVENET_19              0x03EF
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2     0x03F6
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3     0x03F7
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE	    0x0448
 #define PCI_DEVICE_ID_NVIDIA_NVENET_20              0x0450
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
@@ -2170,7 +2171,6 @@ #define PCI_DEVICE_ID_INTEL_ICH8_3	0x281
 #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
 #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
-#define PCI_DEVICE_ID_INTEL_GD31244	0x3200
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
