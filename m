Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWC3WBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWC3WBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWC3WBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:01:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:62685 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751019AbWC3WBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:01:06 -0500
Date: Thu, 30 Mar 2006 17:01:03 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20060330220103.GA12024@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 Documentation/DocBook/libata.tmpl |   47 +++++++++-
 drivers/scsi/libata-bmdma.c       |   26 ++++-
 drivers/scsi/libata-core.c        |  168 ++++++++++++++------------------------
 drivers/scsi/sata_mv.c            |   42 +++++----
 include/linux/libata.h            |   10 ++
 5 files changed, 164 insertions(+), 129 deletions(-)

Alan Cox:
      libata: BMDMA handling updates
      libata: Add ->set_mode hook for odd drivers
      libata - ATA is both ATA and CFA
      libata: Simplex and other mode filtering logic
      libata: Fix interesting use of "extern" and also some bracketing

Albert Lee:
      libata: ata_dev_init_params() fixes

Mark Lord:
      sata_mv: three bug fixes

Tejun Heo:
      libata: kill E.D.D.
      libata: cosmetic changes in ata_bus_softreset()
      libata: add FIXME above ata_dev_xfermask()
      libata: kill trailing whitespace

diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
index d260d92..5bcbb6e 100644
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -120,14 +120,27 @@ void (*dev_config) (struct ata_port *, s
 	<programlisting>
 void (*set_piomode) (struct ata_port *, struct ata_device *);
 void (*set_dmamode) (struct ata_port *, struct ata_device *);
-void (*post_set_mode) (struct ata_port *ap);
+void (*post_set_mode) (struct ata_port *);
+unsigned int (*mode_filter) (struct ata_port *, struct ata_device *, unsigned int);
 	</programlisting>
 
 	<para>
 	Hooks called prior to the issue of SET FEATURES - XFER MODE
-	command.  dev->pio_mode is guaranteed to be valid when
-	->set_piomode() is called, and dev->dma_mode is guaranteed to be
-	valid when ->set_dmamode() is called.  ->post_set_mode() is
+	command.  The optional ->mode_filter() hook is called when libata
+	has built a mask of the possible modes. This is passed to the 
+	->mode_filter() function which should return a mask of valid modes
+	after filtering those unsuitable due to hardware limits. It is not
+	valid to use this interface to add modes.
+	</para>
+	<para>
+	dev->pio_mode and dev->dma_mode are guaranteed to be valid when
+	->set_piomode() and when ->set_dmamode() is called. The timings for
+	any other drive sharing the cable will also be valid at this point.
+	That is the library records the decisions for the modes of each
+	drive on a channel before it attempts to set any of them.
+	</para>
+	<para>
+	->post_set_mode() is
 	called unconditionally, after the SET FEATURES - XFER MODE
 	command completes successfully.
 	</para>
@@ -230,6 +243,32 @@ void (*dev_select)(struct ata_port *ap, 
 
 	</sect2>
 
+	<sect2><title>Private tuning method</title>
+	<programlisting>
+void (*set_mode) (struct ata_port *ap);
+	</programlisting>
+
+	<para>
+	By default libata performs drive and controller tuning in
+	accordance with the ATA timing rules and also applies blacklists
+	and cable limits. Some controllers need special handling and have
+	custom tuning rules, typically raid controllers that use ATA
+	commands but do not actually do drive timing.
+	</para>
+
+	<warning>
+	<para>
+	This hook should not be used to replace the standard controller
+	tuning logic when a controller has quirks. Replacing the default
+	tuning logic in that case would bypass handling for drive and
+	bridge quirks that may be important to data reliability. If a
+	controller needs to filter the mode selection it should use the
+	mode_filter hook instead.
+	</para>
+	</warning>
+
+	</sect2>
+
 	<sect2><title>Reset ATA bus</title>
 	<programlisting>
 void (*phy_reset) (struct ata_port *ap);
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 95d81d8..835dff0 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -703,6 +703,7 @@ ata_pci_init_native_mode(struct pci_dev 
 	struct ata_probe_ent *probe_ent =
 		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	int p = 0;
+	unsigned long bmdma;
 
 	if (!probe_ent)
 		return NULL;
@@ -716,7 +717,12 @@ ata_pci_init_native_mode(struct pci_dev 
 		probe_ent->port[p].altstatus_addr =
 		probe_ent->port[p].ctl_addr =
 			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4);
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			if (inb(bmdma + 2) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+			probe_ent->port[p].bmdma_addr = bmdma;
+		}
 		ata_std_ports(&probe_ent->port[p]);
 		p++;
 	}
@@ -726,7 +732,13 @@ ata_pci_init_native_mode(struct pci_dev 
 		probe_ent->port[p].altstatus_addr =
 		probe_ent->port[p].ctl_addr =
 			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			bmdma += 8;
+			if(inb(bmdma + 2) & 0x80)
+			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+			probe_ent->port[p].bmdma_addr = bmdma;
+		}
 		ata_std_ports(&probe_ent->port[p]);
 		p++;
 	}
@@ -740,6 +752,7 @@ static struct ata_probe_ent *ata_pci_ini
 				struct ata_port_info *port, int port_num)
 {
 	struct ata_probe_ent *probe_ent;
+	unsigned long bmdma;
 
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
@@ -766,8 +779,13 @@ static struct ata_probe_ent *ata_pci_ini
 			break;
 	}
 
-	probe_ent->port[0].bmdma_addr =
-		pci_resource_start(pdev, 4) + 8 * port_num;
+	bmdma = pci_resource_start(pdev, 4);
+	if (bmdma != 0) {
+		bmdma += 8 * port_num;
+		probe_ent->port[0].bmdma_addr = bmdma;
+		if (inb(bmdma + 2) & 0x80)
+			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	}
 	ata_std_ports(&probe_ent->port[0]);
 
 	return probe_ent;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d279666..21b0ed5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -62,7 +62,9 @@
 #include "libata.h"
 
 static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev);
+					struct ata_device *dev,
+					u16 heads,
+					u16 sectors);
 static void ata_set_mode(struct ata_port *ap);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
@@ -1081,9 +1083,8 @@ unsigned int ata_pio_need_iordy(const st
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
  *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
- *	devices.  This function also takes care of EDD signature
- *	misreporting (to be removed once EDD support is gone) and
- *	issues ATA_CMD_INIT_DEV_PARAMS for pre-ATA4 drives.
+ *	devices.  This function also issues ATA_CMD_INIT_DEV_PARAMS
+ *	for pre-ATA4 drives.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -1095,7 +1096,6 @@ static int ata_dev_read_id(struct ata_po
 			   unsigned int *p_class, int post_reset, u16 **p_id)
 {
 	unsigned int class = *p_class;
-	unsigned int using_edd;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
 	u16 *id;
@@ -1104,12 +1104,6 @@ static int ata_dev_read_id(struct ata_po
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
-	if (ap->ops->probe_reset ||
-	    ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
-		using_edd = 0;
-	else
-		using_edd = 1;
-
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
 	id = kmalloc(sizeof(id[0]) * ATA_ID_WORDS, GFP_KERNEL);
@@ -1139,39 +1133,16 @@ static int ata_dev_read_id(struct ata_po
 
 	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
-
 	if (err_mask) {
 		rc = -EIO;
 		reason = "I/O error";
-
-		if (err_mask & ~AC_ERR_DEV)
-			goto err_out;
-
-		/*
-		 * arg!  EDD works for all test cases, but seems to return
-		 * the ATA signature for some ATAPI devices.  Until the
-		 * reason for this is found and fixed, we fix up the mess
-		 * here.  If IDENTIFY DEVICE returns command aborted
-		 * (as ATAPI devices do), then we issue an
-		 * IDENTIFY PACKET DEVICE.
-		 *
-		 * ATA software reset (SRST, the default) does not appear
-		 * to have this problem.
-		 */
-		if ((using_edd) && (class == ATA_DEV_ATA)) {
-			u8 err = tf.feature;
-			if (err & ATA_ABORTED) {
-				class = ATA_DEV_ATAPI;
-				goto retry;
-			}
-		}
 		goto err_out;
 	}
 
 	swap_buf_le16(id, ATA_ID_WORDS);
 
 	/* sanity check */
-	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
+	if ((class == ATA_DEV_ATA) != (ata_id_is_ata(id) | ata_id_is_cfa(id))) {
 		rc = -EINVAL;
 		reason = "device reports illegal type";
 		goto err_out;
@@ -1187,7 +1158,7 @@ static int ata_dev_read_id(struct ata_po
 		 * Some drives were very specific about that exact sequence.
 		 */
 		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
-			err_mask = ata_dev_init_params(ap, dev);
+			err_mask = ata_dev_init_params(ap, dev, id[3], id[6]);
 			if (err_mask) {
 				rc = -EIO;
 				reason = "INIT_DEV_PARAMS failed";
@@ -1440,7 +1411,11 @@ static int ata_bus_probe(struct ata_port
 	if (!found)
 		goto err_out_disable;
 
-	ata_set_mode(ap);
+	if (ap->ops->set_mode)
+		ap->ops->set_mode(ap);
+	else
+		ata_set_mode(ap);
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
@@ -1845,7 +1820,7 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	int i, rc;
+	int i, rc, used_dma = 0;
 
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1863,6 +1838,9 @@ static void ata_set_mode(struct ata_port
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
+
+		if (dev->dma_mode)
+			used_dma = 1;
 	}
 
 	/* step 2: always set host PIO timings */
@@ -1884,6 +1862,17 @@ static void ata_set_mode(struct ata_port
 			goto err_out;
 	}
 
+	/*
+	 *	Record simplex status. If we selected DMA then the other
+	 *	host channels are not permitted to do so.
+	 */
+
+	if (used_dma && (ap->host_set->flags & ATA_HOST_SIMPLEX))
+		ap->host_set->simplex_claimed = 1;
+
+	/*
+	 *	Chip specific finalisation
+	 */
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
@@ -2005,45 +1994,6 @@ static void ata_bus_post_reset(struct at
 		ap->ops->dev_select(ap, 0);
 }
 
-/**
- *	ata_bus_edd - Issue EXECUTE DEVICE DIAGNOSTIC command.
- *	@ap: Port to reset and probe
- *
- *	Use the EXECUTE DEVICE DIAGNOSTIC command to reset and
- *	probe the bus.  Not often used these days.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *	Obtains host_set lock.
- *
- */
-
-static unsigned int ata_bus_edd(struct ata_port *ap)
-{
-	struct ata_taskfile tf;
-	unsigned long flags;
-
-	/* set up execute-device-diag (bus reset) taskfile */
-	/* also, take interrupts to a known state (disabled) */
-	DPRINTK("execute-device-diag\n");
-	ata_tf_init(ap, &tf, 0);
-	tf.ctl |= ATA_NIEN;
-	tf.command = ATA_CMD_EDD;
-	tf.protocol = ATA_PROT_NODATA;
-
-	/* do bus reset */
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ata_tf_to_host(ap, &tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	/* spec says at least 2ms.  but who knows with those
-	 * crazy ATAPI devices...
-	 */
-	msleep(150);
-
-	return ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
-}
-
 static unsigned int ata_bus_softreset(struct ata_port *ap,
 				      unsigned int devmask)
 {
@@ -2078,13 +2028,12 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
-
 	/* Before we perform post reset processing we want to see if
-	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
-	   resistor */
-
+	 * the bus shows 0xFF because the odd clown forgets the D7
+	 * pulldown resistor.
+	 */
 	if (ata_check_status(ap) == 0xFF)
-		return 1;	/* Positive is failure for some reason */
+		return AC_ERR_OTHER;
 
 	ata_bus_post_reset(ap, devmask);
 
@@ -2116,7 +2065,7 @@ void ata_bus_reset(struct ata_port *ap)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
-	unsigned int dev0, dev1 = 0, rc = 0, devmask = 0;
+	unsigned int dev0, dev1 = 0, devmask = 0;
 
 	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
 
@@ -2139,18 +2088,8 @@ void ata_bus_reset(struct ata_port *ap)
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST)
-		rc = ata_bus_softreset(ap, devmask);
-	else if ((ap->flags & ATA_FLAG_SATA_RESET) == 0) {
-		/* set up device control */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
-		rc = ata_bus_edd(ap);
-	}
-
-	if (rc)
-		goto err_out;
+		if (ata_bus_softreset(ap, devmask))
+			goto err_out;
 
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
@@ -2223,9 +2162,9 @@ static int sata_phy_resume(struct ata_po
  *	so makes reset sequence different from the original
  *	->phy_reset implementation and Jeff nervous.  :-P
  */
-extern void ata_std_probeinit(struct ata_port *ap)
+void ata_std_probeinit(struct ata_port *ap)
 {
-	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read) {
+	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
 		sata_phy_resume(ap);
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
@@ -2714,18 +2653,23 @@ static int ata_dma_blacklisted(const str
  *	known limits including host controller limits, device
  *	blacklist, etc...
  *
+ *	FIXME: The current implementation limits all transfer modes to
+ *	the fastest of the lowested device on the port.  This is not
+ *	required on most controllers.
+ *
  *	LOCKING:
  *	None.
  */
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
 {
+	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
 	int i;
 
 	xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
 				      ap->udma_mask);
 
-	/* use port-wide xfermask for now */
+	/* FIXME: Use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
@@ -2735,12 +2679,23 @@ static void ata_dev_xfermask(struct ata_
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		/* Apply cable rule here. Don't apply it early because when
+		   we handle hot plug the cable type can itself change */
+		if (ap->cbl == ATA_CBL_PATA40)
+			xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 	}
 
 	if (ata_dma_blacklisted(dev))
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
+	if (hs->flags & ATA_HOST_SIMPLEX) {
+		if (hs->simplex_claimed)
+			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	}
+	if (ap->ops->mode_filter)
+		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
+
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 }
@@ -2795,16 +2750,16 @@ static unsigned int ata_dev_set_xfermode
  */
 
 static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev)
+					struct ata_device *dev,
+					u16 heads,
+					u16 sectors)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	u16 sectors = dev->id[6];
-	u16 heads   = dev->id[3];
 
 	/* Number of sectors per track 1-255. Number of heads 1-16 */
 	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
-		return 0;
+		return AC_ERR_INVALID;
 
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");
@@ -4536,6 +4491,14 @@ static struct ata_port * ata_host_add(co
 	int rc;
 
 	DPRINTK("ENTER\n");
+
+	if (!ent->port_ops->probe_reset &&
+	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
+		printk(KERN_ERR "ata%u: no reset mechanism available\n",
+		       port_no);
+		return NULL;
+	}
+
 	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
 	if (!host)
 		return NULL;
@@ -4596,6 +4559,7 @@ int ata_device_add(const struct ata_prob
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
 	host_set->ops = ent->port_ops;
+	host_set->flags = ent->host_set_flags;
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 275ed9b..fa901fd 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1010,7 +1010,7 @@ static void mv_fill_sg(struct ata_queued
 
 			pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
 			pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
+			pp->sg_tbl[i].flags_size = cpu_to_le32(len & 0xffff);
 
 			sg_len -= len;
 			addr += len;
@@ -1350,7 +1350,6 @@ static void mv_host_intr(struct ata_host
 {
 	void __iomem *mmio = host_set->mmio_base;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
-	struct ata_port *ap;
 	struct ata_queued_cmd *qc;
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
@@ -1373,25 +1372,32 @@ static void mv_host_intr(struct ata_host
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
 		u8 ata_status = 0;
-		ap = host_set->ports[port];
+		struct ata_port *ap = host_set->ports[port];
+		struct mv_port_priv *pp = ap->private_data;
+
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
 
-		if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
-			/* new CRPB on the queue; just one at a time until NCQ
-			 */
-			ata_status = mv_get_crpb_status(ap);
-			handled++;
-		} else if ((DEV_IRQ << hard_port) & hc_irq_cause) {
-			/* received ATA IRQ; read the status reg to clear INTRQ
-			 */
-			ata_status = readb((void __iomem *)
+		/* Note that DEV_IRQ might happen spuriously during EDMA,
+		 * and should be ignored in such cases.  We could mask it,
+		 * but it's pretty rare and may not be worth the overhead.
+		 */ 
+		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+			/* EDMA: check for response queue interrupt */
+			if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
+				ata_status = mv_get_crpb_status(ap);
+				handled = 1;
+			}
+		} else {
+			/* PIO: check for device (drive) interrupt */
+			if ((DEV_IRQ << hard_port) & hc_irq_cause) {
+				ata_status = readb((void __iomem *)
 					   ap->ioaddr.status_addr);
-			handled++;
+				handled = 1;
+			}
 		}
 
-		if (ap &&
-		    (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)))
+		if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))
 			continue;
 
 		err_mask = ac_err_mask(ata_status);
@@ -1403,12 +1409,12 @@ static void mv_host_intr(struct ata_host
 		if ((PORT0_ERR << shift) & relevant) {
 			mv_err_intr(ap);
 			err_mask |= AC_ERR_OTHER;
-			handled++;
+			handled = 1;
 		}
 
-		if (handled && ap) {
+		if (handled) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (NULL != qc) {
+			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0471922..0d61357 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -160,8 +160,10 @@ enum {
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
 
+	/* host set flags */
+	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
+	
 	/* various lengths of time */
-	ATA_TMOUT_EDD		= 5 * HZ,	/* heuristic */
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
@@ -279,6 +281,7 @@ struct ata_probe_ent {
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		host_set_flags;
 	void __iomem		*mmio_base;
 	void			*private_data;
 };
@@ -291,6 +294,9 @@ struct ata_host_set {
 	unsigned int		n_ports;
 	void			*private_data;
 	const struct ata_port_operations *ops;
+	unsigned long		flags;
+	int			simplex_claimed;	/* Keep seperate in case we
+							   ever need to do this locked */
 	struct ata_port *	ports[0];
 };
 
@@ -420,6 +426,7 @@ struct ata_port_operations {
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *);
 	void (*set_dmamode) (struct ata_port *, struct ata_device *);
+	unsigned long (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned long);
 
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -430,6 +437,7 @@ struct ata_port_operations {
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+	void (*set_mode) (struct ata_port *ap);
 	int (*probe_reset) (struct ata_port *ap, unsigned int *classes);
 
 	void (*post_set_mode) (struct ata_port *ap);
