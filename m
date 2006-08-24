Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWHXINm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWHXINm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWHXINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:13:42 -0400
Received: from havoc.gtf.org ([69.61.125.42]:27833 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750830AbWHXINl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:13:41 -0400
Date: Thu, 24 Aug 2006 04:13:36 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060824081336.GA15502@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-greg' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg

to receive the following updates:

 drivers/scsi/ata_piix.c    |   84 +++++++++++++++++++++++++-------
 drivers/scsi/libata-core.c |    2 
 drivers/scsi/pdc_adma.c    |    3 -
 drivers/scsi/sata_via.c    |  117 +++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 180 insertions(+), 26 deletions(-)

Albert Lee:
      libata: Use ATA_FLAG_PIO_POLLING for pdc_adma

Martin Hicks:
      libata: PHY reset requires writing 0x4 to SControl

Tejun Heo:
      ata_piix: fix ghost device probing by honoring PCS present bits
      ata_piix: ignore PCS on ICH5
      ata_piix: implement force_pcs module parameter
      sata_via: use old SCR access pattern on vt6420

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 5e8afc8..2d20caf 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -390,7 +390,8 @@ #endif
 	/* ich5_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
+				  PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -467,6 +468,11 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int force_pcs = 0;
+module_param(force_pcs, int, 0444);
+MODULE_PARM_DESC(force_pcs, "force honoring or ignoring PCS to work around "
+		 "device mis-detection (0=default, 1=ignore PCS, 2=honor PCS)");
+
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -531,27 +537,25 @@ static void piix_pata_error_handler(stru
 }
 
 /**
- *	piix_sata_prereset - prereset for SATA host controller
+ *	piix_sata_present_mask - determine present mask for SATA host controller
  *	@ap: Target port
  *
- *	Reads and configures SATA PCI device's PCI config register
- *	Port Configuration and Status (PCS) to determine port and
- *	device availability.  Return -ENODEV to skip reset if no
- *	device is present.
+ *	Reads SATA PCI device's PCI config register Port Configuration
+ *	and Status (PCS) to determine port and device availability.
  *
  *	LOCKING:
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	0 if device is present, -ENODEV otherwise.
+ *	determined present_mask
  */
-static int piix_sata_prereset(struct ata_port *ap)
+static unsigned int piix_sata_present_mask(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct piix_host_priv *hpriv = ap->host_set->private_data;
 	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
-	unsigned int present = 0;
+	unsigned int present_mask = 0;
 	int port, i;
 	u16 pcs;
 
@@ -564,24 +568,52 @@ static int piix_sata_prereset(struct ata
 			continue;
 		if ((ap->flags & PIIX_FLAG_IGNORE_PCS) ||
 		    (pcs & 1 << (hpriv->map_db->present_shift + port)))
-			present = 1;
+			present_mask |= 1 << i;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
-		ap->id, pcs, present);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+		ap->id, pcs, present_mask);
 
-	if (!present) {
-		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
+	return present_mask;
+}
+
+/**
+ *	piix_sata_softreset - reset SATA host port via ATA SRST
+ *	@ap: port to reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset SATA host port via ATA SRST.  On controllers with
+ *	reliable PCS present bits, the bits are used to determine
+ *	device presence.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
+{
+	unsigned int present_mask;
+	int i, rc;
+
+	present_mask = piix_sata_present_mask(ap);
+
+	rc = ata_std_softreset(ap, classes);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		if (!(present_mask & (1 << i)))
+			classes[i] = ATA_DEV_NONE;
 	}
 
-	return ata_std_prereset(ap);
+	return 0;
 }
 
 static void piix_sata_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, piix_sata_prereset, ata_std_softreset, NULL,
+	ata_bmdma_drive_eh(ap, ata_std_prereset, piix_sata_softreset, NULL,
 			   ata_std_postreset);
 }
 
@@ -785,6 +817,7 @@ static int __devinit piix_check_450nx_er
 }
 
 static void __devinit piix_init_pcs(struct pci_dev *pdev,
+				    struct ata_port_info *pinfo,
 				    const struct piix_map_db *map_db)
 {
 	u16 pcs, new_pcs;
@@ -798,6 +831,18 @@ static void __devinit piix_init_pcs(stru
 		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
 		msleep(150);
 	}
+
+	if (force_pcs == 1) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "force ignoring PCS (0x%x)\n", new_pcs);
+		pinfo[0].host_flags |= PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags |= PIIX_FLAG_IGNORE_PCS;
+	} else if (force_pcs == 2) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "force honoring PCS (0x%x)\n", new_pcs);
+		pinfo[0].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+	}
 }
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
@@ -906,7 +951,8 @@ static int piix_init_one (struct pci_dev
 	if (host_flags & ATA_FLAG_SATA) {
 		piix_init_sata_map(pdev, port_info,
 				   piix_map_db_table[ent->driver_data]);
-		piix_init_pcs(pdev, piix_map_db_table[ent->driver_data]);
+		piix_init_pcs(pdev, port_info,
+			      piix_map_db_table[ent->driver_data]);
 	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 16fc2dd..73dd6c8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2746,7 +2746,7 @@ int sata_std_hardreset(struct ata_port *
 		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
 			return rc;
 
-		scontrol = (scontrol & 0x0f0) | 0x302;
+		scontrol = (scontrol & 0x0f0) | 0x304;
 
 		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
 			return rc;
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index d1f38c3..efc8fff 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -183,7 +183,8 @@ static struct ata_port_info adma_port_in
 	{
 		.sht		= &adma_ata_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..01d4036 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -74,6 +74,7 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
@@ -107,7 +108,38 @@ static struct scsi_host_template svia_sh
 	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations svia_sata_ops = {
+static const struct ata_port_operations vt6420_sata_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= vt6420_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+static const struct ata_port_operations vt6421_sata_ops = {
 	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load,
@@ -141,13 +173,13 @@ static const struct ata_port_operations 
 	.host_stop		= ata_host_stop,
 };
 
-static struct ata_port_info svia_port_info = {
+static struct ata_port_info vt6420_port_info = {
 	.sht		= &svia_sht,
 	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
-	.port_ops	= &svia_sata_ops,
+	.port_ops	= &vt6420_sata_ops,
 };
 
 MODULE_AUTHOR("Jeff Garzik");
@@ -170,6 +202,81 @@ static void svia_scr_write (struct ata_p
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+/**
+ *	vt6420_prereset - prereset for vt6420
+ *	@ap: target ATA port
+ *
+ *	SCR registers on vt6420 are pieces of shit and may hang the
+ *	whole machine completely if accessed with the wrong timing.
+ *	To avoid such catastrophe, vt6420 doesn't provide generic SCR
+ *	access operations, but uses SStatus and SControl only during
+ *	boot probing in controlled way.
+ *
+ *	As the old (pre EH update) probing code is proven to work, we
+ *	strictly follow the access pattern.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int vt6420_prereset(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus, scontrol;
+	int online;
+
+	/* don't do any SCR stuff if we're not loading */
+	if (!ATA_PFLAG_LOADING)
+		goto skip_scr;
+
+	/* Resume phy.  This is the old resume sequence from
+	 * __sata_phy_reset().
+	 */
+	svia_scr_write(ap, SCR_CONTROL, 0x300);
+	svia_scr_read(ap, SCR_CONTROL); /* flush */
+
+	/* wait for phy to become ready, if necessary */
+	do {
+		msleep(200);
+		if ((svia_scr_read(ap, SCR_STATUS) & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* open code sata_print_link_status() */
+	sstatus = svia_scr_read(ap, SCR_STATUS);
+	scontrol = svia_scr_read(ap, SCR_CONTROL);
+
+	online = (sstatus & 0xf) == 0x3;
+
+	ata_port_printk(ap, KERN_INFO,
+			"SATA link %s 1.5 Gbps (SStatus %X SControl %X)\n",
+			online ? "up" : "down", sstatus, scontrol);
+
+	/* SStatus is read one more time */
+	svia_scr_read(ap, SCR_STATUS);
+
+	if (!online) {
+		/* tell EH to bail */
+		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		return 0;
+	}
+
+ skip_scr:
+	/* wait for !BSY */
+	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+
+	return 0;
+}
+
+static void vt6420_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
+				  NULL, ata_std_postreset);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -210,7 +317,7 @@ static void vt6421_init_addrs(struct ata
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi = &svia_port_info;
+	struct ata_port_info *ppi = &vt6420_port_info;
 
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
@@ -239,7 +346,7 @@ static struct ata_probe_ent *vt6421_init
 
 	probe_ent->sht		= &svia_sht;
 	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops	= &svia_sata_ops;
+	probe_ent->port_ops	= &vt6421_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
 	probe_ent->irq_flags	= IRQF_SHARED;
