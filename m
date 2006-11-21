Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031432AbWKUU7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031432AbWKUU7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031367AbWKUU7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:59:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:52660 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1031368AbWKUU7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:59:45 -0500
Date: Tue, 21 Nov 2006 21:57:21 +0100 (MET)
Message-Id: <200611212057.kALKvL8n009798@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2.6.19-rc6] sata_promise updates
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the sata_promise driver as follows:
- Correct typo in definition of PDC_TBG_MODE: it's at 0x41C not 0x41
  in first-generation chips. This error caused PCI access alignment
  exceptions on SPARC64, and on all platforms it disabled the expected
  initialisation of TBG mode.
- Prevent TBG mode and SLEW rate initialisation in second-generation chips.
  These two registers have moved, TBG mode has been redefined, and
  Promise's ulsata2 driver no longer attempts to initialise them.
- Correct PCI device table so devices 0x3570, 0x3571, and 0x3d73 are
  marked as 2057x (2nd gen) not 2037x (1st gen).
- Correct PCI device table so device 0x3d17 is marked as 40518
  (2nd gen 4 ports) not 20319 (1st gen 4 ports).
- Correct pdc_ata_init_one() to treat 20771 as a second-generation chip.
  (The 20771 classification is redundant as it is equivalent to 2057x.)

Tested on 0x3d75 (2nd gen), 0x3d73 (2nd gen), and 0x3373 (1st gen) chips.
The information comes from the newly uploaded Promise SATA HW specs,
Promise's ultra and ulsata2 drivers, and debugging on 3d75/3d73/3373 chips.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.6.19-rc6/drivers/ata/sata_promise.c linux-2.6.19-rc6.sata_promise-mikpe1/drivers/ata/sata_promise.c
--- linux-2.6.19-rc6/drivers/ata/sata_promise.c	2006-11-21 21:14:22.000000000 +0100
+++ linux-2.6.19-rc6.sata_promise-mikpe1/drivers/ata/sata_promise.c	2006-11-21 21:19:38.000000000 +0100
@@ -52,14 +52,14 @@
 enum {
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
-	PDC_TBG_MODE		= 0x41,	/* TBG mode */
 	PDC_FLASH_CTL		= 0x44, /* Flash control register */
 	PDC_PCI_CTL		= 0x48, /* PCI control and status register */
 	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
 	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
-	PDC_SLEW_CTL		= 0x470, /* slew rate control reg */
+	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
+	PDC_SLEW_CTL		= 0x470, /* slew rate control reg (not SATAII) */
 
 	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
 				  (1<<8) | (1<<9) | (1<<10),
@@ -88,6 +88,7 @@ struct pdc_port_priv {
 
 struct pdc_host_priv {
 	int			hotplug_offset;
+	int			no_tbg_slew_init;
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -235,20 +236,20 @@ static const struct ata_port_info pdc_po
 
 static const struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3371), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3570), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3571), board_2037x },
 	{ PCI_VDEVICE(PROMISE, 0x3373), board_2037x },
 	{ PCI_VDEVICE(PROMISE, 0x3375), board_2037x },
 	{ PCI_VDEVICE(PROMISE, 0x3376), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3570), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3571), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2057x },
 	{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2037x },
 
 	{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
 	{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
 	{ PCI_VDEVICE(PROMISE, 0x3515), board_20319 },
 	{ PCI_VDEVICE(PROMISE, 0x3519), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3d17), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3d17), board_40518 },
 	{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },
 
 	{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },
@@ -653,6 +654,9 @@ static void pdc_host_init(unsigned int c
 	tmp = readl(mmio + hotplug_offset);
 	writel(tmp | 0xff0000, mmio + hotplug_offset);
 
+	if (hp->no_tbg_slew_init)
+		return;
+
 	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);
 	tmp &= ~0x30000; /* clear bit 17, 16*/
@@ -746,6 +750,8 @@ static int pdc_ata_init_one (struct pci_
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_40518:
+		/* TBG/SLEW have changed and don't need init */
+		hp->no_tbg_slew_init = 1;
 		/* Override hotplug offset for SATAII150 */
 		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
@@ -759,15 +765,15 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2057x:
+	case board_20771:
+		/* TBG/SLEW have changed and don't need init */
+		hp->no_tbg_slew_init = 1;
 		/* Override hotplug offset for SATAII150 */
 		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
 		/* Fall through */
 	case board_2037x:
 		probe_ent->n_ports = 2;
 		break;
-	case board_20771:
-		probe_ent->n_ports = 2;
-		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
 
