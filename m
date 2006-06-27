Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030645AbWF0D5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWF0D5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWF0D5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:57:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:46805 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030645AbWF0D5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:57:33 -0400
Date: Mon, 26 Jun 2006 23:57:32 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060627035732.GA7501@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/3c59x.c             |   79 +++++++++++++++----------------
 drivers/net/dl2k.h              |   12 +---
 drivers/net/dm9000.c            |   34 +++++++------
 drivers/net/eepro100.c          |    5 --
 drivers/net/epic100.c           |   20 +-------
 drivers/net/fealnx.c            |   10 ----
 drivers/net/hamradio/dmascc.c   |    2 
 drivers/net/natsemi.c           |  100 +++++++++++++++++++---------------------
 drivers/net/pcnet32.c           |    6 --
 drivers/net/phy/lxt.c           |    8 +--
 drivers/net/tulip/winbond-840.c |   26 ++--------
 drivers/net/wan/c101.c          |    2 
 drivers/net/wan/n2.c            |    2 
 drivers/net/wan/pci200syn.c     |    2 
 drivers/net/yellowfin.c         |   24 ++-------
 15 files changed, 133 insertions(+), 199 deletions(-)

Adrian Bunk:
      drivers/net/hamradio/dmascc.c: fix section mismatch

Ben Dooks:
      DM9000 - better checks for platform resources
      DM9000 - check for MAC left in by bootloader
      DM9000 - do no re-init spin lock
      DM9000 - minor code cleanups

Jeff Garzik:
      [netdrvr] natsemi: Separate out media initialization code
      [netdrvr] natsemi: minor cleanups
      [netdrvr] Remove long-unused bits from Becker template drivers

Krzysztof Halasa:
      WAN: update info page for a bunch of my drivers

Uwe Zeisberger:
      Fix phy id for LXT971A/LXT972A

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index e277789..b467c38 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -375,8 +375,7 @@ limit of 4K.
    of the drivers, and will likely be provided by some future kernel.
 */
 enum pci_flags_bit {
-	PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-	PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
+	PCI_USES_MASTER=4,
 };
 
 enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_CYCLONE=4, IS_TORNADO=8,
@@ -446,95 +445,95 @@ static struct vortex_chip_info {
 	int io_size;
 } vortex_info_tbl[] __devinitdata = {
 	{"3c590 Vortex 10Mbps",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 	{"3c592 EISA 10Mbps Demon/Vortex",					/* AKPM: from Don's 3c59x_cb.c 0.49H */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 	{"3c597 EISA Fast Demon/Vortex",					/* AKPM: from Don's 3c59x_cb.c 0.49H */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 	{"3c595 Vortex 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 	{"3c595 Vortex 100baseT4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 
 	{"3c595 Vortex 100base-MII",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_VORTEX, 32, },
+	 PCI_USES_MASTER, IS_VORTEX, 32, },
 	{"3c900 Boomerang 10baseT",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|EEPROM_RESET, 64, },
+	 PCI_USES_MASTER, IS_BOOMERANG|EEPROM_RESET, 64, },
 	{"3c900 Boomerang 10Mbps Combo",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|EEPROM_RESET, 64, },
+	 PCI_USES_MASTER, IS_BOOMERANG|EEPROM_RESET, 64, },
 	{"3c900 Cyclone 10Mbps TPO",						/* AKPM: from Don's 0.99M */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c900 Cyclone 10Mbps Combo",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
 	{"3c900 Cyclone 10Mbps TPC",						/* AKPM: from Don's 0.99M */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c900B-FL Cyclone 10base-FL",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905 Boomerang 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
+	 PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905 Boomerang 100baseT4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
+	 PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905B Cyclone 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 
 	{"3c905B Cyclone 10/100/BNC",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c905B-FX Cyclone 100baseFx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905C Tornado",
-	PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM (ATI Radeon 9100 IGP)",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_MII|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_MII|HAS_HWCKSM, 128, },
 	{"3c980 Cyclone",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
 	{"3c980C Python-T",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3cSOHO100-TX Hurricane",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c555 Laptop Hurricane",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|EEPROM_8BIT|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|EEPROM_8BIT|HAS_HWCKSM, 128, },
 	{"3c556 Laptop Tornado",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_8BIT|HAS_CB_FNS|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_8BIT|HAS_CB_FNS|INVERT_MII_PWR|
 									HAS_HWCKSM, 128, },
 	{"3c556B Laptop Hurricane",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_OFFSET|HAS_CB_FNS|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|EEPROM_OFFSET|HAS_CB_FNS|INVERT_MII_PWR|
 	                                WNO_XCVR_PWR|HAS_HWCKSM, 128, },
 
 	{"3c575 [Megahertz] 10/100 LAN 	CardBus",
-	PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
+	PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
 	{"3c575 Boomerang CardBus",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
+	 PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_8BIT, 128, },
 	{"3CCFE575BT Cyclone CardBus",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|
 									INVERT_LED_PWR|HAS_HWCKSM, 128, },
 	{"3CCFE575CT Tornado CardBus",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									MAX_COLLISION_RESET|HAS_HWCKSM, 128, },
 	{"3CCFE656 Cyclone CardBus",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									INVERT_LED_PWR|HAS_HWCKSM, 128, },
 
 	{"3CCFEM656B Cyclone+Winmodem CardBus",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									INVERT_LED_PWR|HAS_HWCKSM, 128, },
 	{"3CXFEM656C Tornado+Winmodem CardBus",			/* From pcmcia-cs-3.1.5 */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_CB_FNS|EEPROM_8BIT|INVERT_MII_PWR|
 									MAX_COLLISION_RESET|HAS_HWCKSM, 128, },
 	{"3c450 HomePNA Tornado",						/* AKPM: from Don's 0.99Q */
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c920 Tornado",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c982 Hydra Dual Port A",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
 
 	{"3c982 Hydra Dual Port B",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
 	{"3c905B-T4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	 PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM Tornado",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 
 	{NULL,}, /* NULL terminated list. */
 };
diff --git a/drivers/net/dl2k.h b/drivers/net/dl2k.h
index 6e75482..5344920 100644
--- a/drivers/net/dl2k.h
+++ b/drivers/net/dl2k.h
@@ -683,11 +683,6 @@ struct netdev_private {
 };
 
 /* The station address location in the EEPROM. */
-#ifdef MEM_MAPPING
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)
-#else
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_IO  | PCI_ADDR0)
-#endif
 /* The struct pci_device_id consist of:
         vendor, device          Vendor and device ID to match (or PCI_ANY_ID)
         subvendor, subdevice    Subsystem vendor and device ID to match (or PCI_ANY_ID)
@@ -695,9 +690,10 @@ #endif
         class_mask              of the class are honored during the comparison.
         driver_data             Data private to the driver.
 */
-static struct pci_device_id rio_pci_tbl[] = {
-	{0x1186, 0x4000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{0,}
+
+static const struct pci_device_id rio_pci_tbl[] = {
+	{0x1186, 0x4000, PCI_ANY_ID, PCI_ANY_ID, },
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, rio_pci_tbl);
 #define TX_TIMEOUT  (4*HZ)
diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index 24996da..7965a9b 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -410,10 +410,7 @@ dm9000_probe(struct platform_device *pde
 	if (pdev->num_resources < 2) {
 		ret = -ENODEV;
 		goto out;
-	}
-
-	switch (pdev->num_resources) {
-	case 2:
+	} else if (pdev->num_resources == 2) {
 		base = pdev->resource[0].start;
 
 		if (!request_mem_region(base, 4, ndev->name)) {
@@ -423,17 +420,16 @@ dm9000_probe(struct platform_device *pde
 
 		ndev->base_addr = base;
 		ndev->irq = pdev->resource[1].start;
-		db->io_addr = (void *)base;
-		db->io_data = (void *)(base + 4);
-
-		break;
+		db->io_addr = (void __iomem *)base;
+		db->io_data = (void __iomem *)(base + 4);
 
-	case 3:
+	} else {
 		db->addr_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		db->data_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		db->irq_res  = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
-		if (db->addr_res == NULL || db->data_res == NULL) {
+		if (db->addr_res == NULL || db->data_res == NULL ||
+		    db->irq_res == NULL) {
 			printk(KERN_ERR PFX "insufficient resources\n");
 			ret = -ENOENT;
 			goto out;
@@ -482,7 +478,6 @@ dm9000_probe(struct platform_device *pde
 
 		/* ensure at least we have a default set of IO routines */
 		dm9000_set_io(db, iosize);
-
 	}
 
 	/* check to see if anything is being over-ridden */
@@ -564,6 +559,13 @@ #endif
 	for (i = 0; i < 6; i++)
 		ndev->dev_addr[i] = db->srom[i];
 
+	if (!is_valid_ether_addr(ndev->dev_addr)) {
+		/* try reading from mac */
+
+		for (i = 0; i < 6; i++)
+			ndev->dev_addr[i] = ior(db, i+DM9000_PAR);
+	}
+
 	if (!is_valid_ether_addr(ndev->dev_addr))
 		printk("%s: Invalid ethernet MAC address.  Please "
 		       "set using ifconfig\n", ndev->name);
@@ -663,7 +665,6 @@ dm9000_init_dm9000(struct net_device *de
 	db->tx_pkt_cnt = 0;
 	db->queue_pkt_len = 0;
 	dev->trans_start = 0;
-	spin_lock_init(&db->lock);
 }
 
 /*
@@ -767,7 +768,7 @@ dm9000_stop(struct net_device *ndev)
  * receive the packet to upper layer, free the transmitted packet
  */
 
-void
+static void
 dm9000_tx_done(struct net_device *dev, board_info_t * db)
 {
 	int tx_status = ior(db, DM9000_NSR);	/* Got TX status */
@@ -1187,13 +1188,14 @@ dm9000_drv_remove(struct platform_device
 }
 
 static struct platform_driver dm9000_driver = {
+	.driver	= {
+		.name    = "dm9000",
+		.owner	 = THIS_MODULE,
+	},
 	.probe   = dm9000_probe,
 	.remove  = dm9000_drv_remove,
 	.suspend = dm9000_drv_suspend,
 	.resume  = dm9000_drv_resume,
-	.driver	= {
-		.name	= "dm9000",
-	},
 };
 
 static int __init
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index 467fc86..ecf5ad8 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -278,11 +278,6 @@ having to sign an Intel NDA when I'm hel
 
 static int speedo_found1(struct pci_dev *pdev, void __iomem *ioaddr, int fnd_cnt, int acpi_idle_state);
 
-enum pci_flags_bit {
-	PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-	PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
-};
-
 /* Offsets to the various registers.
    All accesses need not be longword aligned. */
 enum speedo_offsets {
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index 724d7dc..ee34a16 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -191,23 +191,10 @@ IVc. Errata
 */
 
 
-enum pci_id_flags_bits {
-        /* Set PCI command register bits before calling probe1(). */
-        PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-        /* Read and map the single following PCI BAR. */
-        PCI_ADDR0=0<<4, PCI_ADDR1=1<<4, PCI_ADDR2=2<<4, PCI_ADDR3=3<<4,
-        PCI_ADDR_64BITS=0x100, PCI_NO_ACPI_WAKE=0x200, PCI_NO_MIN_LATENCY=0x400,
-};
-
 enum chip_capability_flags { MII_PWRDWN=1, TYPE2_INTR=2, NO_MII=4 };
 
 #define EPIC_TOTAL_SIZE 0x100
 #define USE_IO_OPS 1
-#ifdef USE_IO_OPS
-#define EPIC_IOTYPE PCI_USES_MASTER|PCI_USES_IO|PCI_ADDR0
-#else
-#define EPIC_IOTYPE PCI_USES_MASTER|PCI_USES_MEM|PCI_ADDR1
-#endif
 
 typedef enum {
 	SMSC_83C170_0,
@@ -218,7 +205,6 @@ typedef enum {
 
 struct epic_chip_info {
 	const char *name;
-	enum pci_id_flags_bits pci_flags;
         int io_size;                            /* Needed for I/O region check or ioremap(). */
         int drv_flags;                          /* Driver use, intended as capability flags. */
 };
@@ -227,11 +213,11 @@ struct epic_chip_info {
 /* indexed by chip_t */
 static const struct epic_chip_info pci_id_tbl[] = {
 	{ "SMSC EPIC/100 83c170",
-	 EPIC_IOTYPE, EPIC_TOTAL_SIZE, TYPE2_INTR | NO_MII | MII_PWRDWN },
+	  EPIC_TOTAL_SIZE, TYPE2_INTR | NO_MII | MII_PWRDWN },
 	{ "SMSC EPIC/100 83c170",
-	 EPIC_IOTYPE, EPIC_TOTAL_SIZE, TYPE2_INTR },
+	  EPIC_TOTAL_SIZE, TYPE2_INTR },
 	{ "SMSC EPIC/C 83c175",
-	 EPIC_IOTYPE, EPIC_TOTAL_SIZE, TYPE2_INTR | MII_PWRDWN },
+	  EPIC_TOTAL_SIZE, TYPE2_INTR | MII_PWRDWN },
 };
 
 
diff --git a/drivers/net/fealnx.c b/drivers/net/fealnx.c
index a844926..13eca7e 100644
--- a/drivers/net/fealnx.c
+++ b/drivers/net/fealnx.c
@@ -126,16 +126,6 @@ MODULE_PARM_DESC(full_duplex, "fealnx fu
 
 #define MIN_REGION_SIZE 136
 
-enum pci_flags_bit {
-	PCI_USES_IO = 1,
-	PCI_USES_MEM = 2,
-	PCI_USES_MASTER = 4,
-	PCI_ADDR0 = 0x10 << 0,
-	PCI_ADDR1 = 0x10 << 1,
-	PCI_ADDR2 = 0x10 << 2,
-	PCI_ADDR3 = 0x10 << 3,
-};
-
 /* A chip capabilities table, matching the entries in pci_tbl[] above. */
 enum chip_capability_flags {
 	HAS_MII_XCVR,
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index 0d5fccc..c9a46b8 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -436,7 +436,7 @@ static int __init dmascc_init(void)
 module_init(dmascc_init);
 module_exit(dmascc_exit);
 
-static void dev_setup(struct net_device *dev)
+static void __init dev_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_AX25;
 	dev->hard_header_len = AX25_MAX_HEADER_LEN;
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index 2e4eced..5657049 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -226,7 +226,6 @@ #define NATSEMI_NREGS		(NATSEMI_PG0_NREG
 				 NATSEMI_PG1_NREGS)
 #define NATSEMI_REGS_VER	1 /* v1 added RFDR registers */
 #define NATSEMI_REGS_SIZE	(NATSEMI_NREGS * sizeof(u32))
-#define NATSEMI_DEF_EEPROM_SIZE	24 /* 12 16-bit values */
 
 /* Buffer sizes:
  * The nic writes 32-bit values, even if the upper bytes of
@@ -344,18 +343,6 @@ None characterised.
 
 
 
-enum pcistuff {
-	PCI_USES_IO = 0x01,
-	PCI_USES_MEM = 0x02,
-	PCI_USES_MASTER = 0x04,
-	PCI_ADDR0 = 0x08,
-	PCI_ADDR1 = 0x10,
-};
-
-/* MMIO operations required */
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)
-
-
 /*
  * Support for fibre connections on Am79C874:
  * This phy needs a special setup when connected to a fibre cable.
@@ -363,22 +350,25 @@ #define PCI_IOTYPE (PCI_USES_MASTER | PC
  */
 #define PHYID_AM79C874	0x0022561b
 
-#define MII_MCTRL	0x15	/* mode control register */
-#define MII_FX_SEL	0x0001	/* 100BASE-FX (fiber) */
-#define MII_EN_SCRM	0x0004	/* enable scrambler (tp) */
+enum {
+	MII_MCTRL	= 0x15,		/* mode control register */
+	MII_FX_SEL	= 0x0001,	/* 100BASE-FX (fiber) */
+	MII_EN_SCRM	= 0x0004,	/* enable scrambler (tp) */
+};
 
  
 /* array of board data directly indexed by pci_tbl[x].driver_data */
 static const struct {
 	const char *name;
 	unsigned long flags;
+	unsigned int eeprom_size;
 } natsemi_pci_info[] __devinitdata = {
-	{ "NatSemi DP8381[56]", PCI_IOTYPE },
+	{ "NatSemi DP8381[56]", 0, 24 },
 };
 
-static struct pci_device_id natsemi_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, },
+static const struct pci_device_id natsemi_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_NS, 0x0020, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, natsemi_pci_tbl);
 
@@ -813,6 +803,42 @@ static void move_int_phy(struct net_devi
 	udelay(1);
 }
 
+static void __devinit natsemi_init_media (struct net_device *dev)
+{
+	struct netdev_private *np = netdev_priv(dev);
+	u32 tmp;
+
+	netif_carrier_off(dev);
+
+	/* get the initial settings from hardware */
+	tmp            = mdio_read(dev, MII_BMCR);
+	np->speed      = (tmp & BMCR_SPEED100)? SPEED_100     : SPEED_10;
+	np->duplex     = (tmp & BMCR_FULLDPLX)? DUPLEX_FULL   : DUPLEX_HALF;
+	np->autoneg    = (tmp & BMCR_ANENABLE)? AUTONEG_ENABLE: AUTONEG_DISABLE;
+	np->advertising= mdio_read(dev, MII_ADVERTISE);
+
+	if ((np->advertising & ADVERTISE_ALL) != ADVERTISE_ALL
+	 && netif_msg_probe(np)) {
+		printk(KERN_INFO "natsemi %s: Transceiver default autonegotiation %s "
+			"10%s %s duplex.\n",
+			pci_name(np->pci_dev),
+			(mdio_read(dev, MII_BMCR) & BMCR_ANENABLE)?
+			  "enabled, advertise" : "disabled, force",
+			(np->advertising &
+			  (ADVERTISE_100FULL|ADVERTISE_100HALF))?
+			    "0" : "",
+			(np->advertising &
+			  (ADVERTISE_100FULL|ADVERTISE_10FULL))?
+			    "full" : "half");
+	}
+	if (netif_msg_probe(np))
+		printk(KERN_INFO
+			"natsemi %s: Transceiver status %#04x advertising %#04x.\n",
+			pci_name(np->pci_dev), mdio_read(dev, MII_BMSR),
+			np->advertising);
+
+}
+
 static int __devinit natsemi_probe1 (struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
@@ -852,8 +878,7 @@ #endif
 	iosize = pci_resource_len(pdev, pcibar);
 	irq = pdev->irq;
 
-	if (natsemi_pci_info[chip_idx].flags & PCI_USES_MASTER)
-		pci_set_master(pdev);
+	pci_set_master(pdev);
 
 	dev = alloc_etherdev(sizeof (struct netdev_private));
 	if (!dev)
@@ -892,7 +917,7 @@ #endif
 	np->msg_enable = (debug >= 0) ? (1<<debug)-1 : NATSEMI_DEF_MSG;
 	np->hands_off = 0;
 	np->intr_status = 0;
-	np->eeprom_size = NATSEMI_DEF_EEPROM_SIZE;
+	np->eeprom_size = natsemi_pci_info[chip_idx].eeprom_size;
 
 	/* Initial port:
 	 * - If the nic was configured to use an external phy and if find_mii
@@ -957,34 +982,7 @@ #endif
 	if (mtu)
 		dev->mtu = mtu;
 
-	netif_carrier_off(dev);
-
-	/* get the initial settings from hardware */
-	tmp            = mdio_read(dev, MII_BMCR);
-	np->speed      = (tmp & BMCR_SPEED100)? SPEED_100     : SPEED_10;
-	np->duplex     = (tmp & BMCR_FULLDPLX)? DUPLEX_FULL   : DUPLEX_HALF;
-	np->autoneg    = (tmp & BMCR_ANENABLE)? AUTONEG_ENABLE: AUTONEG_DISABLE;
-	np->advertising= mdio_read(dev, MII_ADVERTISE);
-
-	if ((np->advertising & ADVERTISE_ALL) != ADVERTISE_ALL
-	 && netif_msg_probe(np)) {
-		printk(KERN_INFO "natsemi %s: Transceiver default autonegotiation %s "
-			"10%s %s duplex.\n",
-			pci_name(np->pci_dev),
-			(mdio_read(dev, MII_BMCR) & BMCR_ANENABLE)?
-			  "enabled, advertise" : "disabled, force",
-			(np->advertising &
-			  (ADVERTISE_100FULL|ADVERTISE_100HALF))?
-			    "0" : "",
-			(np->advertising &
-			  (ADVERTISE_100FULL|ADVERTISE_10FULL))?
-			    "full" : "half");
-	}
-	if (netif_msg_probe(np))
-		printk(KERN_INFO
-			"natsemi %s: Transceiver status %#04x advertising %#04x.\n",
-			pci_name(np->pci_dev), mdio_read(dev, MII_BMSR),
-			np->advertising);
+	natsemi_init_media(dev);
 
 	/* save the silicon revision for later querying */
 	np->srr = readl(ioaddr + SiliconRev);
diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index fc08c4a..0e01c75 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -309,12 +309,6 @@ static int pcnet32_alloc_ring(struct net
 static void pcnet32_free_ring(struct net_device *dev);
 static void pcnet32_check_media(struct net_device *dev, int verbose);
 
-enum pci_flags_bit {
-	PCI_USES_IO = 1, PCI_USES_MEM = 2, PCI_USES_MASTER = 4,
-	PCI_ADDR0 = 0x10 << 0, PCI_ADDR1 = 0x10 << 1, PCI_ADDR2 =
-	    0x10 << 2, PCI_ADDR3 = 0x10 << 3,
-};
-
 static u16 pcnet32_wio_read_csr(unsigned long addr, int index)
 {
 	outw(index, addr + PCNET32_WIO_RAP);
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index bef79e4..3f702c5 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -123,9 +123,9 @@ static int lxt971_config_intr(struct phy
 }
 
 static struct phy_driver lxt970_driver = {
-	.phy_id		= 0x07810000,
+	.phy_id		= 0x78100000,
 	.name		= "LXT970",
-	.phy_id_mask	= 0x0fffffff,
+	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= lxt970_config_init,
@@ -137,9 +137,9 @@ static struct phy_driver lxt970_driver =
 };
 
 static struct phy_driver lxt971_driver = {
-	.phy_id		= 0x0001378e,
+	.phy_id		= 0x001378e0,
 	.name		= "LXT971",
-	.phy_id_mask	= 0x0fffffff,
+	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_aneg	= genphy_config_aneg,
diff --git a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
index 8fea2aa..602a6e5 100644
--- a/drivers/net/tulip/winbond-840.c
+++ b/drivers/net/tulip/winbond-840.c
@@ -212,26 +212,15 @@ Test with 'ping -s 10000' on a fast comp
 /*
   PCI probe table.
 */
-enum pci_id_flags_bits {
-        /* Set PCI command register bits before calling probe1(). */
-        PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-        /* Read and map the single following PCI BAR. */
-        PCI_ADDR0=0<<4, PCI_ADDR1=1<<4, PCI_ADDR2=2<<4, PCI_ADDR3=3<<4,
-        PCI_ADDR_64BITS=0x100, PCI_NO_ACPI_WAKE=0x200, PCI_NO_MIN_LATENCY=0x400,
-};
 enum chip_capability_flags {
-	CanHaveMII=1, HasBrokenTx=2, AlwaysFDX=4, FDXOnNoMII=8,};
-#ifdef USE_IO_OPS
-#define W840_FLAGS (PCI_USES_IO | PCI_ADDR0 | PCI_USES_MASTER)
-#else
-#define W840_FLAGS (PCI_USES_MEM | PCI_ADDR1 | PCI_USES_MASTER)
-#endif
+	CanHaveMII=1, HasBrokenTx=2, AlwaysFDX=4, FDXOnNoMII=8,
+};
 
-static struct pci_device_id w840_pci_tbl[] = {
+static const struct pci_device_id w840_pci_tbl[] = {
 	{ 0x1050, 0x0840, PCI_ANY_ID, 0x8153,     0, 0, 0 },
 	{ 0x1050, 0x0840, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
 	{ 0x11f6, 0x2011, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, w840_pci_tbl);
 
@@ -241,18 +230,17 @@ struct pci_id_info {
                 int     pci, pci_mask, subsystem, subsystem_mask;
                 int revision, revision_mask;                            /* Only 8 bits. */
         } id;
-        enum pci_id_flags_bits pci_flags;
         int io_size;                            /* Needed for I/O region check or ioremap(). */
         int drv_flags;                          /* Driver use, intended as capability flags. */
 };
 static struct pci_id_info pci_id_tbl[] = {
 	{"Winbond W89c840",			/* Sometime a Level-One switch card. */
 	 { 0x08401050, 0xffffffff, 0x81530000, 0xffff0000 },
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx | FDXOnNoMII},
+	   128, CanHaveMII | HasBrokenTx | FDXOnNoMII},
 	{"Winbond W89c840", { 0x08401050, 0xffffffff, },
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx},
+	   128, CanHaveMII | HasBrokenTx},
 	{"Compex RL100-ATX", { 0x201111F6, 0xffffffff,},
-	 W840_FLAGS, 128, CanHaveMII | HasBrokenTx},
+	   128, CanHaveMII | HasBrokenTx},
 	{NULL,},					/* 0 terminated list. */
 };
 
diff --git a/drivers/net/wan/c101.c b/drivers/net/wan/c101.c
index b60ef02..c92ac9f 100644
--- a/drivers/net/wan/c101.c
+++ b/drivers/net/wan/c101.c
@@ -7,7 +7,7 @@
  * under the terms of version 2 of the GNU General Public License
  * as published by the Free Software Foundation.
  *
- * For information see http://hq.pm.waw.pl/hdlc/
+ * For information see <http://www.kernel.org/pub/linux/utils/net/hdlc/>
  *
  * Sources of information:
  *    Hitachi HD64570 SCA User's Manual
diff --git a/drivers/net/wan/n2.c b/drivers/net/wan/n2.c
index b7d88db..e013b81 100644
--- a/drivers/net/wan/n2.c
+++ b/drivers/net/wan/n2.c
@@ -7,7 +7,7 @@
  * under the terms of version 2 of the GNU General Public License
  * as published by the Free Software Foundation.
  *
- * For information see http://hq.pm.waw.pl/hdlc/
+ * For information see <http://www.kernel.org/pub/linux/utils/net/hdlc/>
  *
  * Note: integrated CSU/DSU/DDS are not supported by this driver
  *
diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index 670e8bd..24c3c57 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -7,7 +7,7 @@
  * under the terms of version 2 of the GNU General Public License
  * as published by the Free Software Foundation.
  *
- * For information see http://hq.pm.waw.pl/hdlc/
+ * For information see <http://www.kernel.org/pub/linux/utils/net/hdlc/>
  *
  * Sources of information:
  *    Hitachi HD64572 SCA-II User's Manual
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index ecec8e5..569305f 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -234,14 +234,6 @@ See Packet Engines confidential appendix
 
 
 
-enum pci_id_flags_bits {
-	/* Set PCI command register bits before calling probe1(). */
-	PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-	/* Read and map the single following PCI BAR. */
-	PCI_ADDR0=0<<4, PCI_ADDR1=1<<4, PCI_ADDR2=2<<4, PCI_ADDR3=3<<4,
-	PCI_ADDR_64BITS=0x100, PCI_NO_ACPI_WAKE=0x200, PCI_NO_MIN_LATENCY=0x400,
-	PCI_UNUSED_IRQ=0x800,
-};
 enum capability_flags {
 	HasMII=1, FullTxStatus=2, IsGigabit=4, HasMulticastBug=8, FullRxStatus=16,
 	HasMACAddrBug=32, /* Only on early revs.  */
@@ -249,11 +241,6 @@ enum capability_flags {
 };
 /* The PCI I/O space extent. */
 #define YELLOWFIN_SIZE 0x100
-#ifdef USE_IO_OPS
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_IO  | PCI_ADDR0)
-#else
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)
-#endif
 
 struct pci_id_info {
         const char *name;
@@ -261,24 +248,23 @@ struct pci_id_info {
                 int     pci, pci_mask, subsystem, subsystem_mask;
                 int revision, revision_mask;                            /* Only 8 bits. */
         } id;
-        enum pci_id_flags_bits pci_flags;
         int io_size;                            /* Needed for I/O region check or ioremap(). */
         int drv_flags;                          /* Driver use, intended as capability flags. */
 };
 
 static const struct pci_id_info pci_id_tbl[] = {
 	{"Yellowfin G-NIC Gigabit Ethernet", { 0x07021000, 0xffffffff},
-	 PCI_IOTYPE, YELLOWFIN_SIZE,
+	 YELLOWFIN_SIZE,
 	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug | DontUseEeprom},
 	{"Symbios SYM83C885", { 0x07011000, 0xffffffff},
-	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII | DontUseEeprom },
-	{NULL,},
+	 YELLOWFIN_SIZE, HasMII | DontUseEeprom },
+	{ }
 };
 
-static struct pci_device_id yellowfin_pci_tbl[] = {
+static const struct pci_device_id yellowfin_pci_tbl[] = {
 	{ 0x1000, 0x0702, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1000, 0x0701, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, yellowfin_pci_tbl);
 
