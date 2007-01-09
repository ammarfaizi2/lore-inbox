Return-Path: <linux-kernel-owner+w=401wt.eu-S1751247AbXAIJux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbXAIJux (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXAIJuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:50:52 -0500
Received: from aun.it.uu.se ([130.238.12.36]:61695 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbXAIJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:50:39 -0500
Date: Tue, 9 Jan 2007 10:50:27 +0100 (MET)
Message-Id: <200701090950.l099oRPU011573@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.20-rc4 1/2] sata_promise: TX2plus PATA support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a simple way of setting up per-port
flags on the SATA+PATA Promise TX2plus chips, which is a
prerequisite for supporting the PATA port on those chips.

It is based on the observation that ap->flags isn't really
used until after ->port_start() has been invoked. So it
places the "exceptional" per-port flags array in the driver's
private host structure, and uses it in ->port_start() to
finalise the port's flags.

This patch obsoletes the #promise-sata-pata branch included
in the #all branch.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

Changes since the RFC version:
- check cable type not ATA_FLAG_SLAVE_POSS in ->scr_read and ->scr_write

diff -rupN linux-2.6.20-rc4/drivers/ata/sata_promise.c linux-2.6.20-rc4.sata_promise-pata-20x7x-v3/drivers/ata/sata_promise.c
--- linux-2.6.20-rc4/drivers/ata/sata_promise.c	2007-01-08 20:42:55.000000000 +0100
+++ linux-2.6.20-rc4.sata_promise-pata-20x7x-v3/drivers/ata/sata_promise.c	2007-01-09 09:35:25.000000000 +0100
@@ -92,6 +92,7 @@ struct pdc_port_priv {
 
 struct pdc_host_priv {
 	unsigned long		flags;
+	unsigned long		port_flags[ATA_MAX_PORTS];
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -183,7 +184,7 @@ static const struct ata_port_info pdc_po
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -213,7 +214,7 @@ static const struct ata_port_info pdc_po
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -271,6 +272,11 @@ static int pdc_port_start(struct ata_por
 	struct pdc_port_priv *pp;
 	int rc;
 
+	/* fix up port flags and cable type for SATA+PATA chips */
+	ap->flags |= hp->port_flags[ap->port_no];
+	if (ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
 	rc = ata_port_start(ap);
 	if (rc)
 		return rc;
@@ -377,7 +383,7 @@ static void pdc_pata_phy_reset(struct at
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	if (sc_reg > SCR_CONTROL)
+	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
 		return 0xffffffffU;
 	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
 			       u32 val)
 {
-	if (sc_reg > SCR_CONTROL)
+	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
 		return;
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -740,6 +746,7 @@ static int pdc_ata_init_one (struct pci_
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -820,7 +827,17 @@ static int pdc_ata_init_one (struct pci_
 		hp->flags |= PDC_FLAG_GEN_II;
 		/* Fall through */
 	case board_2037x:
-		probe_ent->n_ports = 2;
+		/* TX2plus boards also have a PATA port */
+		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80)) {
+			probe_ent->n_ports = 3;
+			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+			hp->port_flags[2] = ATA_FLAG_SLAVE_POSS;
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		} else
+			probe_ent->n_ports = 2;
+		hp->port_flags[0] = ATA_FLAG_SATA;
+		hp->port_flags[1] = ATA_FLAG_SATA;
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
