Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946424AbWKACNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946424AbWKACNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946421AbWKACNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:13:06 -0500
Received: from havoc.gtf.org ([69.61.125.42]:61881 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1946420AbWKACNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:13:02 -0500
Date: Tue, 31 Oct 2006 21:13:01 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061101021301.GA21568@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ata_piix.c    |   38 ++++++--------------------------------
 drivers/ata/libata-core.c |    1 -
 drivers/ata/libata.h      |    1 +
 drivers/ata/sata_sis.c    |   21 ++++++++++-----------
 include/linux/libata.h    |    1 -
 5 files changed, 17 insertions(+), 45 deletions(-)

Jens Axboe:
      Add 0x7110 piix to ata_piix.c

Tejun Heo:
      sata_sis: fix flags handling for the secondary port
      libata: unexport ata_dev_revalidate()
      ata_piix: allow 01b MAP for both ICH6M and ICH7M

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 5250187..8385387 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -126,8 +126,7 @@ enum {
 	ich6_sata		= 7,
 	ich6_sata_ahci		= 8,
 	ich6m_sata_ahci		= 9,
-	ich7m_sata_ahci		= 10,
-	ich8_sata_ahci		= 11,
+	ich8_sata_ahci		= 10,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -169,6 +168,7 @@ static const struct pci_device_id piix_p
 #ifdef ATA_ENABLE_PATA
 	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
 	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
+	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
 	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
@@ -227,7 +227,7 @@ #endif
 	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7m_sata_ahci },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
 	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
@@ -399,23 +399,10 @@ static const struct piix_map_db ich6m_ma
 	.mask = 0x3,
 	.port_enable = 0x5,
 	.present_shift = 4,
-	.map = {
-		/* PM   PS   SM   SS       MAP */
-		{  P0,  P2,  RV,  RV }, /* 00b */
-		{  RV,  RV,  RV,  RV },
-		{  P0,  P2, IDE, IDE }, /* 10b */
-		{  RV,  RV,  RV,  RV },
-	},
-};
-
-static const struct piix_map_db ich7m_map_db = {
-	.mask = 0x3,
-	.port_enable = 0x5,
-	.present_shift = 4,
 
 	/* Map 01b isn't specified in the doc but some notebooks use
-	 * it anyway.  ATM, the only case spotted carries subsystem ID
-	 * 1025:0107.  This is the only difference from ich6m.
+	 * it anyway.  MAP 01b have been spotted on both ICH6M and
+	 * ICH7M.
 	 */
 	.map = {
 		/* PM   PS   SM   SS       MAP */
@@ -445,7 +432,6 @@ static const struct piix_map_db *piix_ma
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
-	[ich7m_sata_ahci]	= &ich7m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
 };
 
@@ -556,19 +542,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich7m_sata_ahci: 10 */
-	{
-		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &piix_sata_ops,
-	},
-
-	/* ich8_sata_ahci: 11 */
+	/* ich8_sata_ahci: 10 */
 	{
 		.sht		= &piix_sht,
 		.flags		= ATA_FLAG_SATA |
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 83728a9..a8fd0c3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6122,7 +6122,6 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..0ed263b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -53,6 +53,7 @@ extern unsigned ata_exec_internal(struct
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
+extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 0738f52..9d1235b 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -240,7 +240,7 @@ static int sis_init_one (struct pci_dev 
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi[2];
+	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
@@ -265,27 +265,20 @@ static int sis_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi[0] = ppi[1] = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
-	if ((!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) &&
+	if ((!(pi.flags & SIS_FLAG_CFGSCR)) &&
 	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
 	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
 		genctl &= ~GENCTL_IOMAPPED_SCR;
 		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -306,6 +299,12 @@ static int sis_init_one (struct pci_dev 
 		port2_start = 0x20;
 	}
 
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
 	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b03d5a3..abd2deb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -702,7 +702,6 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
