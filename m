Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWGKQCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWGKQCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWGKQCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:02:07 -0400
Received: from havoc.gtf.org ([69.61.125.42]:53436 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751075AbWGKQCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:02:05 -0400
Date: Tue, 11 Jul 2006 12:02:02 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, albertcc@tw.ibm.com,
       greg@kroah.com
Subject: [PATCH v1] ata_piix: attempt to fix
Message-ID: <20060711160202.GA2503@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to address problems on ata_piix that people have
been reporting:  long boot delay, ghost devices, and ICH8 brokenness.

Testing feedback is requested as soon as possible, so that we can
potentially stick this into 2.6.18-rc2.

I'm booting up several boxes locally here, mainly ICH5 and ICH8, as well.


 drivers/scsi/ata_piix.c |  151 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 45 deletions(-)


commit aeff1cdc5e86f0ce6267c1ae76d150064e05faf6
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jul 11 11:57:44 2006 -0400

    [libata] ata_piix: attempt to fix ICH8 support
    
    Take into account the fact that ICH8 changed the register layout of
    the MAP and PCS register bits.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 15dcf5b9868382026c268529d2bb922db676cf63
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jul 11 11:48:50 2006 -0400

    [libata] ata_piix: Consolidate PCS register writing
    
    Prior to this patch, the driver would do this for each port:
    	read 8-bit PCS
    	write 8-bit PCS
    	read 8-bit PCS
    	write 8-bit PCS
    
    In the field, flaky behavior has been observed related to this register.
    In particular, these overzealous register writes can cause misdetection
    problems.
    
    Update to do the following once (not once per port) at boot:
    	read 16-bit PCS
    	if needs changing,
    		write 16-bit PCS
    
    And thereafter, we only perform a 'read 16-bit PCS' per port.
    
    This should eliminate all PCS writes in many cases, and be more friendly
    in the cases where we do need to enable ports.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit 38c7dbfd2883dccfdeaaa22cd809561000577908
Author: Tejun Heo <htejun@gmail.com>
Date:   Thu Jun 29 01:58:28 2006 +0900

    [PATCH] ata_piix: add host_set private structure
    
    Add host_set private structure piix_host_priv.  Currently the only
    field is ->map which used to be stored directly at
    host_set->private_data.  This change allows more host_set private
    fields to be added.
    
    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>



diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 94b1261..a960bb7 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -126,6 +126,7 @@ enum {
 	ich6_sata		= 4,
 	ich6_sata_ahci		= 5,
 	ich6m_sata_ahci		= 6,
+	ich8_sata_ahci		= 7,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -141,11 +142,19 @@ enum {
 
 struct piix_map_db {
 	const u32 mask;
+	const u32 port_enable;
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
+static void piix_host_stop(struct ata_host_set *host_set);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void piix_pata_error_handler(struct ata_port *ap);
@@ -186,11 +195,11 @@ #endif
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
@@ -254,7 +263,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -284,11 +293,13 @@ static const struct ata_port_operations 
 
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
@@ -302,8 +313,10 @@ static struct piix_map_db ich5_map_db = 
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
@@ -313,8 +326,10 @@ static struct piix_map_db ich6_map_db = 
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
@@ -324,6 +339,28 @@ static struct piix_map_db ich6m_map_db =
 	},
 };
 
+static const struct piix_map_db ich8_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x3,
+	.present_shift = 8,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  RV,  P1,  RV }, /* 00b (hardwired) */
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
@@ -362,7 +399,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* i6300esb_sata */
@@ -374,7 +410,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich5_map_db,
 	},
 
 	/* ich6_sata */
@@ -386,7 +421,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6_sata_ahci */
@@ -399,7 +433,6 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6_map_db,
 	},
 
 	/* ich6m_sata_ahci */
@@ -412,7 +445,18 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
-		.private_data	= &ich6m_map_db,
+	},
+
+	/* ich8_sata_ahci */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
 	},
 };
 
@@ -508,46 +552,29 @@ static void piix_pata_error_handler(stru
 static int piix_sata_prereset(struct ata_port *ap)
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
 
-	if (!present_mask) {
+	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
@@ -761,10 +788,27 @@ static int __devinit piix_check_450nx_er
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
@@ -805,8 +849,8 @@ static void __devinit piix_init_sata_map
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "invalid MAP value %u\n", map_value);
 
-	pinfo[0].private_data = (void *)map;
-	pinfo[1].private_data = (void *)map;
+	hpriv->map = map;
+	hpriv->map_db = map_db;
 }
 
 /**
@@ -829,6 +873,7 @@ static int piix_init_one (struct pci_dev
 	static int printed_version;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+	struct piix_host_priv *hpriv;
 	unsigned long host_flags;
 
 	if (!printed_version++)
@@ -839,8 +884,14 @@ static int piix_init_one (struct pci_dev
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
 
@@ -855,8 +906,11 @@ static int piix_init_one (struct pci_dev
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
@@ -879,6 +933,13 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
+static void piix_host_stop(struct ata_host_set *host_set)
+{
+	if (host_set->next == NULL)
+		kfree(host_set->private_data);
+	ata_host_stop(host_set);
+}
+
 static int __init piix_init(void)
 {
 	int rc;
