Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNLwn>; Wed, 14 Feb 2001 06:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbRBNLwe>; Wed, 14 Feb 2001 06:52:34 -0500
Received: from colorfullife.com ([216.156.138.34]:51209 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129470AbRBNLwV>;
	Wed, 14 Feb 2001 06:52:21 -0500
Message-ID: <3A8A7159.AF0E6180@colorfullife.com>
Date: Wed, 14 Feb 2001 12:51:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------DE4BA4286BBA633BB9BE0DB3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DE4BA4286BBA633BB9BE0DB3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found 2 bugs in several network drivers:

* dev->mem_start: NULL means "not command line configuration" 0xffffffff
means "default".
several drivers only check for NULL, not for 0xffffffff.

* incorrect bounds checks for phy_idx: 2 entries in the structure, but
up to 4 are initialized.

* something is wrong in the vortex initialization: I don't have such a
card, but the driver didn't return an error message on insmod. I'm not
sure if
my fix is correct.

Patch attached, against 2.4.1-ac12.

--
	Manfred
--------------DE4BA4286BBA633BB9BE0DB3
Content-Type: text/plain; charset=us-ascii;
 name="patch-donald"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-donald"

diff -ur 2.4/drivers/net/3c59x.c build-2.4/drivers/net/3c59x.c
--- 2.4/drivers/net/3c59x.c	Wed Feb 14 10:50:50 2001
+++ build-2.4/drivers/net/3c59x.c	Wed Feb 14 12:32:56 2001
@@ -967,7 +967,7 @@
 		pdev->driver_data = dev;
 
 	/* The lower four bits are the media type. */
-	if (dev->mem_start) {
+	if (dev->mem_start && dev->mem_start != 0xffffffff) {
 		/*
 		 * AKPM: ewww..  The 'options' param is passed in as the third arg to the
 		 * LILO 'ether=' argument for non-modular use
@@ -2661,9 +2661,12 @@
 	
 	rc = pci_module_init(&vortex_driver);
 	if (rc < 0) {
-		rc = vortex_eisa_init();
-		if (rc > 0)
+		int rc2;
+		rc2 = vortex_eisa_init();
+		if (rc2 > 0) {
 			vortex_have_eisa = 1;
+			rc = 0;
+		}
 	} else {
 		vortex_have_pci = 1;
 	}
diff -ur 2.4/drivers/net/eepro100.c build-2.4/drivers/net/eepro100.c
--- 2.4/drivers/net/eepro100.c	Wed Feb 14 10:50:54 2001
+++ build-2.4/drivers/net/eepro100.c	Wed Feb 14 11:23:22 2001
@@ -643,7 +643,7 @@
 		return -1;
 	}
 
-	if (dev->mem_start > 0)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 	else if (card_idx >= 0  &&  options[card_idx] >= 0)
 		option = options[card_idx];
diff -ur 2.4/drivers/net/epic100.c build-2.4/drivers/net/epic100.c
--- 2.4/drivers/net/epic100.c	Wed Feb 14 10:50:54 2001
+++ build-2.4/drivers/net/epic100.c	Wed Feb 14 11:17:37 2001
@@ -412,7 +412,7 @@
 	ep->rx_ring = (struct epic_rx_desc *)ring_space;
 	ep->rx_ring_dma = ring_dma;
 
-	if (dev->mem_start) {
+	if (dev->mem_start && dev->mem_start != 0xffffffff) {
 		option = dev->mem_start;
 		duplex = (dev->mem_start & 16) ? 1 : 0;
 	} else if (card_idx >= 0  &&  card_idx < MAX_UNITS) {
diff -ur 2.4/drivers/net/hamachi.c build-2.4/drivers/net/hamachi.c
--- 2.4/drivers/net/hamachi.c	Wed Feb 14 10:50:54 2001
+++ build-2.4/drivers/net/hamachi.c	Wed Feb 14 11:26:54 2001
@@ -477,6 +477,7 @@
 };
 
 #define PRIV_ALIGN   15    				/* Required alignment mask */
+#define MII_CNT		4
 struct hamachi_private {
 	/* Descriptor rings first for alignment.  Tx requires a second descriptor
 	   for status. */
@@ -503,7 +504,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;								/* MII device addresses. */
 	u16 advertising;							/* NWay media advertisement */
-	unsigned char phys[2];					/* MII device addresses. */
+	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 	u_int32_t rx_int_var, tx_int_var;	/* interrupt control variables */
 	u_int32_t option;							/* Hold on to a copy of the options */
 	u_int8_t pad[16];							/* Used for 32-byte alignment */
@@ -621,7 +622,7 @@
 
 	/* Check for options being passed in */
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* If the bus size is misidentified, do the following. */
@@ -705,7 +706,7 @@
 
 	if (chip_tbl[hmp->chip_id].flags & CanHaveMII) {
 		int phy, phy_idx = 0;
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(ioaddr, phy, 1);
 			if (mii_status != 0xffff  &&
 				mii_status != 0x0000) {
diff -ur 2.4/drivers/net/natsemi.c build-2.4/drivers/net/natsemi.c
--- 2.4/drivers/net/natsemi.c	Wed Feb 14 10:50:56 2001
+++ build-2.4/drivers/net/natsemi.c	Wed Feb 14 11:17:52 2001
@@ -446,7 +446,7 @@
 	np->iosize = iosize;
 	spin_lock_init(&np->lock);
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
diff -ur 2.4/drivers/net/starfire.c build-2.4/drivers/net/starfire.c
--- 2.4/drivers/net/starfire.c	Wed Feb 14 10:51:00 2001
+++ build-2.4/drivers/net/starfire.c	Wed Feb 14 11:26:07 2001
@@ -329,6 +329,7 @@
 	dma_addr_t mapping;
 };
 
+#define MII_CNT		4
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct starfire_rx_desc *rx_ring;
@@ -365,7 +366,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
+	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 };
 
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
@@ -467,7 +468,7 @@
 	np->pci_dev = pdev;
 	drv_flags = netdrv_tbl[chip_idx].drv_flags;
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
@@ -499,7 +500,7 @@
 
 	if (drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
diff -ur 2.4/drivers/net/sundance.c build-2.4/drivers/net/sundance.c
--- 2.4/drivers/net/sundance.c	Wed Feb 14 10:51:00 2001
+++ build-2.4/drivers/net/sundance.c	Wed Feb 14 11:25:14 2001
@@ -314,6 +314,7 @@
 #define PRIV_ALIGN	15 	/* Required alignment mask */
 /* Use  __attribute__((aligned (L1_CACHE_BYTES)))  to maintain alignment
    within the structure. */
+#define MII_CNT		4
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct netdev_desc rx_ring[RX_RING_SIZE];
@@ -346,7 +347,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
+	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used. */
 };
 
 /* The station address location in the EEPROM. */
@@ -425,7 +426,7 @@
 	np->drv_flags = pci_id_tbl[chip_idx].drv_flags;
 	spin_lock_init(&np->lock);
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
@@ -458,7 +459,7 @@
 	if (1) {
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Default setting */
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
diff -ur 2.4/drivers/net/tulip/tulip_core.c build-2.4/drivers/net/tulip/tulip_core.c
--- 2.4/drivers/net/tulip/tulip_core.c	Wed Feb 14 10:51:02 2001
+++ build-2.4/drivers/net/tulip/tulip_core.c	Wed Feb 14 12:35:12 2001
@@ -1294,9 +1294,11 @@
 		if (mtu[board_idx] > 0)
 			dev->mtu = mtu[board_idx];
 	}
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		tp->default_port = dev->mem_start;
 	if (tp->default_port) {
+		printk("%s: forced to media type %s (%d).\n",
+			dev->name, medianame[tp->default_port], tp->default_port);
 		tp->medialock = 1;
 		if (tulip_media_cap[tp->default_port] & MediaAlwaysFD)
 			tp->full_duplex = 1;
diff -ur 2.4/drivers/net/via-rhine.c build-2.4/drivers/net/via-rhine.c
--- 2.4/drivers/net/via-rhine.c	Wed Feb 14 10:51:02 2001
+++ build-2.4/drivers/net/via-rhine.c	Wed Feb 14 11:18:15 2001
@@ -571,7 +571,7 @@
 	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
 	np->pdev = pdev;
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
diff -ur 2.4/drivers/net/winbond-840.c build-2.4/drivers/net/winbond-840.c
--- 2.4/drivers/net/winbond-840.c	Wed Feb 14 10:51:04 2001
+++ build-2.4/drivers/net/winbond-840.c	Wed Feb 14 11:21:08 2001
@@ -313,6 +313,7 @@
 };
 
 #define PRIV_ALIGN	15 	/* Required alignment mask */
+#define MII_CNT		4
 struct netdev_private {
 	struct w840_rx_desc *rx_ring;
 	dma_addr_t	rx_addr[RX_RING_SIZE];
@@ -344,7 +345,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
+	unsigned char phys[MII_CNT];		/* MII device addresses, but only the first is used */
 };
 
 static int  eeprom_read(long ioaddr, int location);
@@ -436,7 +437,7 @@
 	
 	pdev->driver_data = dev;
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
@@ -465,7 +466,7 @@
 
 	if (np->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
-		for (phy = 1; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
diff -ur 2.4/drivers/net/yellowfin.c build-2.4/drivers/net/yellowfin.c
--- 2.4/drivers/net/yellowfin.c	Wed Feb 14 10:51:04 2001
+++ build-2.4/drivers/net/yellowfin.c	Wed Feb 14 11:22:47 2001
@@ -328,6 +328,7 @@
 	IntrEarlyRx=0x100, IntrWakeup=0x200, };
 
 #define PRIV_ALIGN	31 	/* Required alignment mask */
+#define MII_CNT		4
 struct yellowfin_private {
 	/* Descriptor rings first for alignment.
 	   Tx requires a second descriptor for status. */
@@ -357,7 +358,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;						/* MII device addresses. */
 	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
+	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used */
 	spinlock_t lock;
 };
 
@@ -453,7 +454,7 @@
 	np->chip_id = chip_idx;
 	np->drv_flags = drv_flags;
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != 0xffffffff)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
@@ -485,7 +486,7 @@
 
 	if (np->drv_flags & HasMII) {
 		int phy, phy_idx = 0;
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
 			int mii_status = mdio_read(ioaddr, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;


--------------DE4BA4286BBA633BB9BE0DB3--

