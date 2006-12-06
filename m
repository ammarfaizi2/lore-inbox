Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760330AbWLFIzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760330AbWLFIzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760333AbWLFIzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:55:53 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63662 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760326AbWLFIzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:55:52 -0500
Date: Wed, 6 Dec 2006 09:55:43 +0100 (MET)
Message-Id: <200612060855.kB68th9a024699@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.19] sata_promise: cleanups, take 2
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch performs two simple cleanups of sata_promise.

* Remove board_20771 and map device id 0x3577 to board_2057x.
  After the recent corrections for SATAII chips, board_20771 and
  board_2057x were equivalent in the driver.

* Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
  to compute hotplug_offset in pdc_host_init(). hp->hotplug_offset
  was used to distinguish 1st and 2nd generation chips in one
  particular case, but now we have that information in a more
  general form in hp->flags, so hp->hotplug_offset is redundant.

Changes since previous submission: rebased on libata-dev #upstream,
cleaned up hotplug_offset computation based on Tejun's comments,
expanded hotplug_offset removal rationale.

This patch does not depend on the pending new EH conversion patch.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.19/drivers/ata/sata_promise.c.~1~	2006-12-05 18:06:41.000000000 +0100
+++ linux-2.6.19/drivers/ata/sata_promise.c	2006-12-05 20:21:59.000000000 +0100
@@ -66,9 +66,8 @@ enum {
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
-	board_20771		= 3,	/* FastTrak TX2300 */
-	board_2057x		= 4,	/* SATAII150 Tx2plus */
-	board_40518		= 5,	/* SATAII150 Tx4 */
+	board_2057x		= 3,	/* SATAII150 Tx2plus */
+	board_40518		= 4,	/* SATAII150 Tx4 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
@@ -90,7 +89,6 @@ struct pdc_port_priv {
 
 struct pdc_host_priv {
 	unsigned long		flags;
-	int			hotplug_offset;
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -205,16 +203,6 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_pata_ops,
 	},
 
-	/* board_20771 */
-	{
-		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
-	},
-
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
@@ -244,6 +232,7 @@ static const struct pci_device_id pdc_at
 	{ PCI_VDEVICE(PROMISE, 0x3570), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3571), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3577), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },
 
@@ -256,15 +245,6 @@ static const struct pci_device_id pdc_at
 
 	{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },
 
-/* TODO: remove all associated board_20771 code, as it completely
- * duplicates board_2037x code, unless reason for separation can be
- * divined.
- */
-#if 0
-	{ PCI_VDEVICE(PROMISE, 0x3570), board_20771 },
-#endif
-	{ PCI_VDEVICE(PROMISE, 0x3577), board_20771 },
-
 	{ }	/* terminate list */
 };
 
@@ -645,9 +625,14 @@ static void pdc_host_init(unsigned int c
 {
 	void __iomem *mmio = pe->mmio_base;
 	struct pdc_host_priv *hp = pe->private_data;
-	int hotplug_offset = hp->hotplug_offset;
+	int hotplug_offset;
 	u32 tmp;
 
+	if (hp->flags & PDC_FLAG_GEN_II)
+		hotplug_offset = PDC2_SATA_PLUG_CSR;
+	else
+		hotplug_offset = PDC_SATA_PLUG_CSR;
+
 	/*
 	 * Except for the hotplug stuff, this is voodoo from the
 	 * Promise driver.  Label this entire section
@@ -742,8 +727,6 @@ static int pdc_ata_init_one (struct pci_
 		goto err_out_free_ent;
 	}
 
-	/* Set default hotplug offset */
-	hp->hotplug_offset = PDC_SATA_PLUG_CSR;
 	probe_ent->private_data = hp;
 
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
@@ -767,8 +750,6 @@ static int pdc_ata_init_one (struct pci_
 	switch (board_idx) {
 	case board_40518:
 		hp->flags |= PDC_FLAG_GEN_II;
-		/* Override hotplug offset for SATAII150 */
-		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_20319:
        		probe_ent->n_ports = 4;
@@ -780,10 +761,7 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2057x:
-	case board_20771:
 		hp->flags |= PDC_FLAG_GEN_II;
-		/* Override hotplug offset for SATAII150 */
-		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_2037x:
 		probe_ent->n_ports = 2;
