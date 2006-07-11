Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWGKWLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWGKWLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWGKWLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:11:05 -0400
Received: from havoc.gtf.org ([69.61.125.42]:17108 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932191AbWGKWLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:11:00 -0400
Date: Tue, 11 Jul 2006 18:09:49 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.17 v2] ata_piix device probe fixes
Message-ID: <20060711220949.GA21434@havoc.gtf.org>
References: <20060711214923.GA20652@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711214923.GA20652@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a bugfixed version of the previous patch, that fixes a bug
introduced at unload time.

diff -ur linux-2.6.17/drivers/scsi/ata_piix.c linux-2.6.17.piix/drivers/scsi/ata_piix.c
--- linux-2.6.17/drivers/scsi/ata_piix.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17.piix/drivers/scsi/ata_piix.c	2006-07-11 18:08:12.000000000 -0400
@@ -105,9 +105,6 @@
 	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
-	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
-	/* ICH6/7 use different scheme for map value */
-	PIIX_FLAG_COMBINED_ICH6	= PIIX_FLAG_COMBINED | (1 << 30),
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
@@ -126,6 +123,7 @@
 	ich6_sata		= 4,
 	ich6_sata_ahci		= 5,
 	ich6m_sata_ahci		= 6,
+	ich8_sata_ahci		= 7,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -141,14 +139,22 @@
 
 struct piix_map_db {
 	const u32 mask;
+	const u16 port_enable;
+	const int present_shift;
 	const int map[][4];
 };
 
+struct piix_host_priv {
+	const int *map;
+	const struct piix_map_db *map_db;
+};
+
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 
 static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
+static void piix_host_stop(struct ata_host_set *host_set);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
@@ -186,11 +192,11 @@
 	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
-	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller 2 IDE (ICH8, ditto) */
-	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* Mobile SATA Controller IDE (ICH8M, ditto) */
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -250,7 +256,7 @@
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -278,11 +284,13 @@
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
-static struct piix_map_db ich5_map_db = {
+static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
+	.port_enable = 0x3,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP  */
 		{  P0,  NA,  P1,  NA }, /* 000b */
@@ -296,8 +304,10 @@
 	},
 };
 
-static struct piix_map_db ich6_map_db = {
+static const struct piix_map_db ich6_map_db = {
 	.mask = 0x3,
+	.port_enable = 0xf,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b */
@@ -307,8 +317,10 @@
 	},
 };
 
-static struct piix_map_db ich6m_map_db = {
+static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
+	.port_enable = 0x5,
+	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  RV,  RV }, /* 00b */
@@ -318,6 +330,28 @@
 	},
 };
 
+static const struct piix_map_db ich8_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x3,
+	.present_shift = 8,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  NA,  P1,  NA }, /* 00b (hardwired) */
+		{  RV,  RV,  RV,  RV },
+		{  RV,  RV,  RV,  RV }, /* 10b (never) */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
+static const struct piix_map_db *piix_map_db_table[] = {
+	[ich5_sata]		= &ich5_map_db,
+	[esb_sata]		= &ich5_map_db,
+	[ich6_sata]		= &ich6_map_db,
+	[ich6_sata_ahci]	= &ich6_map_db,
+	[ich6m_sata_ahci]	= &ich6m_map_db,
+	[ich8_sata_ahci]	= &ich8_map_db,
+};
+
 static struct ata_port_info piix_port_info[] = {
 	/* piix4_pata */
 	{
@@ -350,63 +384,69 @@
 	/* ich5_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* i6300esb_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
+		.host_flags	= ATA_FLAG_SATA |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6m_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
+	/* ich8_sata_ahci */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6m_map_db,
 	},
 };
 
@@ -505,51 +545,34 @@
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	Mask of avaliable devices on the port.
+ *	Non-zero if device(s) present, zero if port unoccupied.
  */
 static unsigned int piix_sata_probe (struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	const unsigned int *map = ap->host_set->private_data;
+	struct piix_host_priv *hpriv = ap->host_set->private_data;
+	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
-	unsigned int present_mask = 0;
+	unsigned int present = 0;
 	int port, i;
-	u8 pcs;
+	u16 pcs;
 
-	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
 	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
-	/* enable all ports on this ap and wait for them to settle */
-	for (i = 0; i < 2; i++) {
-		port = map[base + i];
-		if (port >= 0)
-			pcs |= 1 << port;
-	}
-
-	pci_write_config_byte(pdev, ICH5_PCS, pcs);
-	msleep(100);
-
-	/* let's see which devices are present */
-	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
-
 	for (i = 0; i < 2; i++) {
 		port = map[base + i];
 		if (port < 0)
 			continue;
-		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
-			present_mask |= 1 << i;
-		else
-			pcs &= ~(1 << port);
+		if ((ap->flags & PIIX_FLAG_IGNORE_PCS) ||
+		    (pcs & 1 << (hpriv->map_db->present_shift + port)))
+			present = 1;
 	}
 
-	/* disable offline ports on non-AHCI controllers */
-	if (!(ap->flags & PIIX_FLAG_AHCI))
-		pci_write_config_byte(pdev, ICH5_PCS, pcs);
-
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
-	return present_mask;
+	return present;
 }
 
 /**
@@ -760,23 +783,40 @@
 		pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
 		pci_read_config_word(pdev, 0x41, &cfg);
 		/* Only on the original revision: IDE DMA can hang */
-		if(rev == 0x00)
+		if (rev == 0x00)
 			no_piix_dma = 1;
 		/* On all revisions below 5 PXB bus lock must be disabled for IDE */
-		else if(cfg & (1<<14) && rev < 5)
+		else if (cfg & (1<<14) && rev < 5)
 			no_piix_dma = 2;
 	}
-	if(no_piix_dma)
+	if (no_piix_dma)
 		dev_printk(KERN_WARNING, &ata_dev->dev, "450NX errata present, disabling IDE DMA.\n");
-	if(no_piix_dma == 2)
+	if (no_piix_dma == 2)
 		dev_printk(KERN_WARNING, &ata_dev->dev, "A BIOS update may resolve this.\n");
 	return no_piix_dma;
 }
 
+static void __devinit piix_init_pcs(struct pci_dev *pdev,
+				    const struct piix_map_db *map_db)
+{
+	u16 pcs, new_pcs;
+
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+
+	new_pcs = pcs | map_db->port_enable;
+
+	if (new_pcs != pcs) {
+		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
+		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
+		msleep(150);
+	}
+}
+
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
-					 struct ata_port_info *pinfo)
+					 struct ata_port_info *pinfo,
+					 const struct piix_map_db *map_db)
 {
-	struct piix_map_db *map_db = pinfo[0].private_data;
+	struct piix_host_priv *hpriv = pinfo[0].private_data;
 	const unsigned int *map;
 	int i, invalid_map = 0;
 	u8 map_value;
@@ -817,8 +857,8 @@
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "invalid MAP value %u\n", map_value);
 
-	pinfo[0].private_data = (void *)map;
-	pinfo[1].private_data = (void *)map;
+	hpriv->map = map;
+	hpriv->map_db = map_db;
 }
 
 /**
@@ -841,6 +881,7 @@
 	static int printed_version;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+	struct piix_host_priv *hpriv;
 	unsigned long host_flags;
 
 	if (!printed_version++)
@@ -851,8 +892,14 @@
 	if (!in_module_init)
 		return -ENODEV;
 
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];
+	port_info[0].private_data = hpriv;
+	port_info[1].private_data = hpriv;
 
 	host_flags = port_info[0].host_flags;
 
@@ -867,8 +914,11 @@
 	}
 
 	/* Initialize SATA map */
-	if (host_flags & ATA_FLAG_SATA)
-		piix_init_sata_map(pdev, port_info);
+	if (host_flags & ATA_FLAG_SATA) {
+		piix_init_sata_map(pdev, port_info,
+				   piix_map_db_table[ent->driver_data]);
+		piix_init_pcs(pdev, piix_map_db_table[ent->driver_data]);
+	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -891,6 +941,13 @@
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
+static void piix_host_stop(struct ata_host_set *host_set)
+{
+	if (host_set->ports[0]->hard_port_no == 0)
+		kfree(host_set->private_data);
+	ata_host_stop(host_set);
+}
+
 static int __init piix_init(void)
 {
 	int rc;
