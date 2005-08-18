Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVHRVsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVHRVsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVHRVsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:48:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52185 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932478AbVHRVsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:48:23 -0400
Message-ID: <4305021F.6010700@pobox.com>
Date: Thu, 18 Aug 2005 17:48:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------020803030800070909070307"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020803030800070909070307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the fixes described in the attached diffstat/changelog/patch.


--------------020803030800070909070307
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"

 drivers/net/8139cp.c   |    7 ++++++
 drivers/net/dm9000.c   |   52 ++++++++++++++++++++++++-------------------------
 drivers/net/ioc3-eth.c |    8 +++----
 3 files changed, 37 insertions(+), 30 deletions(-)


commit 2ae2d77cfa424587014cb34a89eed0ff2149fd5c
Author: Ben Dooks <ben-netdev@fluff.org>
Date:   Sat Jul 23 17:29:38 2005 +0100

    [PATCH] DM9000 - incorrect ioctl() handling
    
    The DM9000 driver is responding to ioctl() calls it should not be. This
    can cause problems with the wireless tools incorrectly indentifying the
    device as wireless capable, and crashing under certain operations.
    
    This patch also moves the version printk() to the init call, so that
    you only get it once for multiple devices, and to show it is loaded
    if there are no defined dm9000s
    
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 9ef9ac51cc5fa5f5811230b5fb242536b636ff47
Author: Ben Dooks <ben-netdev@fluff.org>
Date:   Sat Jul 23 17:25:18 2005 +0100

    [PATCH] DM9000 - spinlock fixes
    
    Fix DM9000 driver usage of spinlocks, which mainly came to light
    when running a kernel with spinlock debugging. These come down to:
    
    1) Un-initialised spin lock
    
    2) Several cases of using  spin_xxx(lock) and not spin_xxx(&lock)
    
    3) move the locking around the phy reg for read/write to only
       keep the lock when actually reading or writing to the phy.
    
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit a4cf0761493495681d72dcc0b34efb86e94a5527
Author: Pierre Ossman <drzeus-list@drzeus.cx>
Date:   Mon Jul 4 00:22:53 2005 +0200

    [PATCH] 8139cp - redetect link after suspend
    
    After suspend the driver needs to retest link status in case the cable
    has been inserted or removed during the suspend.
    
    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 852ea22ab24df4c64c0211c3b6d6358eb0e759f9
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Aug 2 11:01:27 2005 +0100

    [PATCH] IOC3 fixes
    
     - Using the right register clearly improves chances of getting the MII
       code and thus the driver working at all.
     - On startup check the media type before setting up duplex or we might
       spend the first 1.2s with a wrong duplex setting.
     - Get rid of whitespace lines.
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1897,6 +1897,7 @@ static int cp_resume (struct pci_dev *pd
 {
 	struct net_device *dev;
 	struct cp_private *cp;
+	unsigned long flags;
 
 	dev = pci_get_drvdata (pdev);
 	cp  = netdev_priv(dev);
@@ -1910,6 +1911,12 @@ static int cp_resume (struct pci_dev *pd
 	
 	cp_init_hw (cp);
 	netif_start_queue (dev);
+
+	spin_lock_irqsave (&cp->lock, flags);
+
+	mii_check_media(&cp->mii_if, netif_msg_link(cp), FALSE);
+
+	spin_unlock_irqrestore (&cp->lock, flags);
 	
 	return 0;
 }
diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -48,6 +48,10 @@
  *                        net_device_stats
  *                      * introduced tx_timeout function
  *                      * reworked locking
+ *
+ *	  01-Jul-2005   Ben Dooks <ben@simtec.co.uk>
+ *			* fixed spinlock call without pointer
+ *			* ensure spinlock is initialised
  */
 
 #include <linux/module.h>
@@ -148,7 +152,6 @@ static int dm9000_probe(struct device *)
 static int dm9000_open(struct net_device *);
 static int dm9000_start_xmit(struct sk_buff *, struct net_device *);
 static int dm9000_stop(struct net_device *);
-static int dm9000_do_ioctl(struct net_device *, struct ifreq *, int);
 
 
 static void dm9000_timer(unsigned long);
@@ -322,7 +325,7 @@ static void dm9000_timeout(struct net_de
 
 	/* Save previous register address */
 	reg_save = readb(db->io_addr);
-	spin_lock_irqsave(db->lock,flags);
+	spin_lock_irqsave(&db->lock,flags);
 
 	netif_stop_queue(dev);
 	dm9000_reset(db);
@@ -333,7 +336,7 @@ static void dm9000_timeout(struct net_de
 
 	/* Restore previous register address */
 	writeb(reg_save, db->io_addr);
-	spin_unlock_irqrestore(db->lock,flags);
+	spin_unlock_irqrestore(&db->lock,flags);
 }
 
 
@@ -387,8 +390,6 @@ dm9000_probe(struct device *dev)
 	int i;
 	u32 id_val;
 
-	printk(KERN_INFO "%s Ethernet Driver\n", CARDNAME);
-
 	/* Init network device */
 	ndev = alloc_etherdev(sizeof (struct board_info));
 	if (!ndev) {
@@ -405,6 +406,8 @@ dm9000_probe(struct device *dev)
 	db = (struct board_info *) ndev->priv;
 	memset(db, 0, sizeof (*db));
 
+	spin_lock_init(&db->lock);
+
 	if (pdev->num_resources < 2) {
 		ret = -ENODEV;
 		goto out;
@@ -541,7 +544,6 @@ dm9000_probe(struct device *dev)
 	ndev->stop		 = &dm9000_stop;
 	ndev->get_stats		 = &dm9000_get_stats;
 	ndev->set_multicast_list = &dm9000_hash_table;
-	ndev->do_ioctl		 = &dm9000_do_ioctl;
 
 #ifdef DM9000_PROGRAM_EEPROM
 	program_eeprom(db);
@@ -612,7 +614,7 @@ dm9000_open(struct net_device *dev)
 
 	/* set and active a timer process */
 	init_timer(&db->timer);
-	db->timer.expires  = DM9000_TIMER_WUT * 2;
+	db->timer.expires  = DM9000_TIMER_WUT;
 	db->timer.data     = (unsigned long) dev;
 	db->timer.function = &dm9000_timer;
 	add_timer(&db->timer);
@@ -845,15 +847,6 @@ dm9000_get_stats(struct net_device *dev)
 	return &db->stats;
 }
 
-/*
- *  Process the upper socket ioctl command
- */
-static int
-dm9000_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	PRINTK1("entering %s\n",__FUNCTION__);
-	return 0;
-}
 
 /*
  *  A periodic timer routine
@@ -864,21 +857,11 @@ dm9000_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *) data;
 	board_info_t *db = (board_info_t *) dev->priv;
-	u8 reg_save;
-	unsigned long flags;
 
 	PRINTK3("dm9000_timer()\n");
 
-	spin_lock_irqsave(db->lock,flags);
-	/* Save previous register address */
-	reg_save = readb(db->io_addr);
-
 	mii_check_media(&db->mii, netif_msg_link(db), 0);
 
-	/* Restore previous register address */
-	writeb(reg_save, db->io_addr);
-	spin_unlock_irqrestore(db->lock,flags);
-
 	/* Set timer again */
 	db->timer.expires = DM9000_TIMER_WUT;
 	add_timer(&db->timer);
@@ -1098,9 +1081,14 @@ dm9000_phy_read(struct net_device *dev, 
 {
 	board_info_t *db = (board_info_t *) dev->priv;
 	unsigned long flags;
+	unsigned int reg_save;
 	int ret;
 
 	spin_lock_irqsave(&db->lock,flags);
+
+	/* Save previous register address */
+	reg_save = readb(db->io_addr);
+
 	/* Fill the phyxcer register into REG_0C */
 	iow(db, DM9000_EPAR, DM9000_PHY | reg);
 
@@ -1111,6 +1099,9 @@ dm9000_phy_read(struct net_device *dev, 
 	/* The read data keeps on REG_0D & REG_0E */
 	ret = (ior(db, DM9000_EPDRH) << 8) | ior(db, DM9000_EPDRL);
 
+	/* restore the previous address */
+	writeb(reg_save, db->io_addr);
+
 	spin_unlock_irqrestore(&db->lock,flags);
 
 	return ret;
@@ -1124,9 +1115,13 @@ dm9000_phy_write(struct net_device *dev,
 {
 	board_info_t *db = (board_info_t *) dev->priv;
 	unsigned long flags;
+	unsigned long reg_save;
 
 	spin_lock_irqsave(&db->lock,flags);
 
+	/* Save previous register address */
+	reg_save = readb(db->io_addr);
+
 	/* Fill the phyxcer register into REG_0C */
 	iow(db, DM9000_EPAR, DM9000_PHY | reg);
 
@@ -1138,6 +1133,9 @@ dm9000_phy_write(struct net_device *dev,
 	udelay(500);		/* Wait write complete */
 	iow(db, DM9000_EPCR, 0x0);	/* Clear phyxcer write command */
 
+	/* restore the previous address */
+	writeb(reg_save, db->io_addr);
+
 	spin_unlock_irqrestore(&db->lock,flags);
 }
 
@@ -1202,6 +1200,8 @@ static struct device_driver dm9000_drive
 static int __init
 dm9000_init(void)
 {
+	printk(KERN_INFO "%s Ethernet Driver\n", CARDNAME);
+
 	return driver_register(&dm9000_driver);	/* search board and register */
 }
 
diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -499,7 +499,7 @@ static int ioc3_mdio_read(struct net_dev
 	ioc3_w_micr((phy << MICR_PHYADDR_SHIFT) | reg | MICR_READTRIG);
 	while (ioc3_r_micr() & MICR_BUSY);
 
-	return ioc3_r_micr() & MIDR_DATA_MASK;
+	return ioc3_r_midr_r() & MIDR_DATA_MASK;
 }
 
 static void ioc3_mdio_write(struct net_device *dev, int phy, int reg, int data)
@@ -1291,7 +1291,6 @@ static int ioc3_probe(struct pci_dev *pd
 	dev->features		= NETIF_F_IP_CSUM;
 #endif
 
-	ioc3_setup_duplex(ip);
 	sw_physid1 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID1);
 	sw_physid2 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID2);
 
@@ -1300,6 +1299,7 @@ static int ioc3_probe(struct pci_dev *pd
 		goto out_stop;
 
 	mii_check_media(&ip->mii, 1, 1);
+	ioc3_setup_duplex(ip);
 
 	vendor = (sw_physid1 << 12) | (sw_physid2 >> 4);
 	model  = (sw_physid2 >> 4) & 0x3f;
@@ -1524,7 +1524,7 @@ static void ioc3_get_drvinfo (struct net
 	struct ethtool_drvinfo *info)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
-                                                                                
+
         strcpy (info->driver, IOC3_NAME);
         strcpy (info->version, IOC3_VERSION);
         strcpy (info->bus_info, pci_name(ip->pdev));
@@ -1550,7 +1550,7 @@ static int ioc3_set_settings(struct net_
 	spin_lock_irq(&ip->ioc3_lock);
 	rc = mii_ethtool_sset(&ip->mii, cmd);
 	spin_unlock_irq(&ip->ioc3_lock);
-                                                                        
+
 	return rc;
 }
 

--------------020803030800070909070307--
