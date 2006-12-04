Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937348AbWLDTrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937348AbWLDTrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937338AbWLDTru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:47:50 -0500
Received: from codepoet.org ([166.70.99.138]:38950 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966222AbWLDTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:47:38 -0500
Date: Mon, 4 Dec 2006 12:47:37 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] make sata_promise PATA ports work
Message-ID: <20061204194737.GA24311@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
	alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch vs 2.6.19, based on the not-actually-working-for-me
code lurking in libata-dev.git#promise-sata-pata, makes the PATA
ports on my promise sata card actually work.  Since the plan as
checked into git, is to drive the PATA ports as if they were
SATA, we have to teach sata_scr_read() to lie for the PATA ports
which don't to that, lest the various places that call
ata_port_offline() and ata_port_online() should fail and leave
the ports offline and inaccessible.

This patch gets both SATA and PATA working for me with the
sata_promise driver on a PDC20375.  Performace seems to be about
what I would expect, so this (or something very much like it)
should be applied upstream.

Signed-off-by: Erik Andersen <andersen@codepoet.org>

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..d0ab733 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5298,13 +5298,13 @@ void ata_port_init(struct ata_port *ap, 
 		ap->pio_mask = ent->pinfo2->pio_mask;
 		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
 		ap->udma_mask = ent->pinfo2->udma_mask;
-		ap->flags |= ent->pinfo2->flags;
+		ap->flags |= ent->pinfo2->flags | ent->_port_flags[port_no];
 		ap->ops = ent->pinfo2->port_ops;
 	} else {
 		ap->pio_mask = ent->pio_mask;
 		ap->mwdma_mask = ent->mwdma_mask;
 		ap->udma_mask = ent->udma_mask;
-		ap->flags |= ent->port_flags;
+		ap->flags |= ent->port_flags | ent->_port_flags[port_no];
 		ap->ops = ent->port_ops;
 	}
 	ap->hw_sata_spd_limit = UINT_MAX;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 72eda51..543e6a4 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -175,7 +175,7 @@ static const struct ata_port_info pdc_po
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -355,23 +355,27 @@ static void pdc_reset_port(struct ata_po
 static void pdc_sata_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
-	sata_phy_reset(ap);
+	if (ap->flags & ATA_FLAG_SATA)
+		sata_phy_reset(ap);
+	else
+		pdc_pata_phy_reset(ap);
 }
 
 static void pdc_pata_cbl_detect(struct ata_port *ap)
 {
 	u8 tmp;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+	void __iomem *mmio =
+		(void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
 	tmp = readb(mmio);
-
+	
 	if (tmp & 0x01) {
 		ap->cbl = ATA_CBL_PATA40;
 		ap->udma_mask &= ATA_UDMA_MASK_40C;
 	} else
 		ap->cbl = ATA_CBL_PATA80;
 }
-
+		
 static void pdc_pata_phy_reset(struct ata_port *ap)
 {
 	pdc_pata_cbl_detect(ap);
@@ -384,6 +388,20 @@ static u32 pdc_sata_scr_read (struct ata
 {
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+	{
+		switch (sc_reg) {
+			case SCR_STATUS:
+				return 0x113;
+			case SCR_CONTROL:
+				return 0x300;
+			case SCR_ERROR:
+			case SCR_ACTIVE:
+			default:
+				return 0xffffffffU;
+		}
+	}
+
 	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
@@ -391,7 +409,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
 			       u32 val)
 {
-	if (sc_reg > SCR_CONTROL)
+	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
 		return;
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -679,6 +697,7 @@ static int pdc_ata_init_one (struct pci_
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -743,6 +762,9 @@ static int pdc_ata_init_one (struct pci_
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
+	probe_ent->_port_flags[0] = ATA_FLAG_SATA;
+	probe_ent->_port_flags[1] = ATA_FLAG_SATA;
+	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_40518:
@@ -757,13 +779,27 @@ static int pdc_ata_init_one (struct pci_
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
+	
+		probe_ent->_port_flags[2] = ATA_FLAG_SATA;
+		probe_ent->_port_flags[3] = ATA_FLAG_SATA;
 		break;
 	case board_2057x:
 		/* Override hotplug offset for SATAII150 */
 		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_2037x:
+		/* Some boards have also PATA port */
 		probe_ent->n_ports = 2;
+		probe_ent->_port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->_port_flags[1] = ATA_FLAG_SATA;
+		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80))
+		{
+			probe_ent->n_ports = 3;
+			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+			probe_ent->_port_flags[2] = ATA_FLAG_SLAVE_POSS;
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		}
 		break;
 	case board_20771:
 		probe_ent->n_ports = 2;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..aa8c822 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -377,6 +377,7 @@ struct ata_probe_ent {
 	unsigned int		irq_flags;
 	unsigned long		port_flags;
 	unsigned long		_host_flags;
+	unsigned long		_port_flags[ATA_MAX_PORTS];
 	void __iomem		*mmio_base;
 	void			*private_data;
 
