Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262321AbSI1UYQ>; Sat, 28 Sep 2002 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSI1UYQ>; Sat, 28 Sep 2002 16:24:16 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:37136 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262321AbSI1UYL>; Sat, 28 Sep 2002 16:24:11 -0400
Date: Sat, 28 Sep 2002 16:28:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.5.39 smc91c92 ethtool support
Message-ID: <Pine.LNX.4.44.0209281513400.24805-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	On 2.4.18 and 2.5.39 if you remove the UTP cable from the TP port 
of this card, it switches over to the AUI tranceiver thus leaving you dead 
in the water seeing as the link status code can't detect link beat even if 
you plug the cable back in. I presume this code has worked for some 
network cards as i tried a number of things including using the interrupt 
driven method of checking link status. All didn't work. So i added ethtool 
support to the driver so that you can change interfaces during runtime (I 
dont kernel module support). The datasheets i referenced where the 91c94 
and 91c100fd, the code was tested on a 91c94 on a 10/100 hub. 

Cheers,
	Zwane

-- 
function.linuxpower.ca

Index: linux-2.5.39/drivers/net/pcmcia/smc91c92_cs.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.39/drivers/net/pcmcia/smc91c92_cs.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smc91c92_cs.c
--- linux-2.5.39/drivers/net/pcmcia/smc91c92_cs.c	28 Sep 2002 05:09:07 -0000	1.1.1.1
+++ linux-2.5.39/drivers/net/pcmcia/smc91c92_cs.c	28 Sep 2002 20:03:09 -0000
@@ -8,7 +8,7 @@
 
     Copyright (C) 1999 David A. Hinds -- dahinds@users.sourceforge.net
 
-    smc91c92_cs.c 1.113 2001/10/13 00:08:53
+    smc91c92_cs.c 1.2 2002/09/28 15:00:00
     
     This driver contains code written by Donald Becker
     (becker@scyld.com), Rowan Hughes (x-csrdh@jcu.edu.au),
@@ -43,6 +43,8 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 #include <linux/ioport.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -88,6 +90,9 @@
 #define DEBUG(n, args...)
 #endif
 
+#define DRV_NAME	"smc91c92_cs"
+#define DRV_VERSION	"1.2"
+
 /*====================================================================*/
 
 /* Operational parameter that usually are not changed. */
@@ -109,6 +114,7 @@
 struct smc_private {
     dev_link_t			link;
     struct net_device		dev;
+    spinlock_t			lock;
     u_short			manfid;
     u_short			cardid;
     struct net_device_stats	stats;
@@ -292,9 +298,11 @@
 static void smc_set_xcvr(struct net_device *dev, int if_port);
 static void smc_reset(struct net_device *dev);
 static void media_check(u_long arg);
-static void mdio_sync(ioaddr_t addr);
-static int mdio_read(ioaddr_t addr, int phy_id, int loc);
-static void mdio_write(ioaddr_t addr, int phy_id, int loc, int value);
+static void smc_mdio_sync(ioaddr_t addr);
+static int smc_mdio_read(ioaddr_t addr, int phy_id, int loc);
+static void smc_mdio_write(ioaddr_t addr, int phy_id, int loc, int value);
+static int smc_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static int smc_link_ok(struct net_device *dev);
 
 /*======================================================================
 
@@ -346,7 +354,7 @@
     if (!smc) return NULL;
     memset(smc, 0, sizeof(struct smc_private));
     link = &smc->link; dev = &smc->dev;
-
+    spin_lock_init(&smc->lock);
     link->release.function = &smc91c92_release;
     link->release.data = (u_long)link;
     link->io.NumPorts1 = 16;
@@ -369,6 +377,7 @@
     dev->get_stats = &smc91c92_get_stats;
     dev->set_config = &s9k_config;
     dev->set_multicast_list = &set_rx_mode;
+    dev->do_ioctl = &smc_ioctl;
     ether_setup(dev);
     dev->open = &smc91c92_open;
     dev->stop = &smc91c92_close;
@@ -1044,7 +1053,7 @@
 	SMC_SELECT_BANK(3);
 
 	for (i = 0; i < 32; i++) {
-	    j = mdio_read(dev->base_addr + MGMT, i, 1);
+	    j = smc_mdio_read(dev->base_addr + MGMT, i, 1);
 	    if ((j != 0) && (j != 0xffff)) break;
 	}
 	smc->phy_id = (i < 32) ? i : -1;
@@ -1190,7 +1199,7 @@
 #define MDIO_DATA_WRITE1	(MDIO_DIR_WRITE | MDIO_DATA_OUT)
 #define MDIO_DATA_READ		0x02
 
-static void mdio_sync(ioaddr_t addr)
+static void smc_mdio_sync(ioaddr_t addr)
 {
     int bits;
     for (bits = 0; bits < 32; bits++) {
@@ -1199,12 +1208,12 @@
     }
 }
 
-static int mdio_read(ioaddr_t addr, int phy_id, int loc)
+static int smc_mdio_read(ioaddr_t addr, int phy_id, int loc)
 {
     u_int cmd = (0x06<<10)|(phy_id<<5)|loc;
     int i, retval = 0;
 
-    mdio_sync(addr);
+    smc_mdio_sync(addr);
     for (i = 13; i >= 0; i--) {
 	int dat = (cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
 	outb(dat, addr);
@@ -1218,12 +1227,12 @@
     return (retval>>1) & 0xffff;
 }
 
-static void mdio_write(ioaddr_t addr, int phy_id, int loc, int value)
+static void smc_mdio_write(ioaddr_t addr, int phy_id, int loc, int value)
 {
     u_int cmd = (0x05<<28)|(phy_id<<23)|(loc<<18)|(1<<17)|value;
     int i;
 
-    mdio_sync(addr);
+    smc_mdio_sync(addr);
     for (i = 31; i >= 0; i--) {
 	int dat = (cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
 	outb(dat, addr);
@@ -1777,6 +1786,7 @@
 static void set_rx_mode(struct net_device *dev)
 {
     ioaddr_t ioaddr = dev->base_addr;
+    struct smc_private *smc = dev->priv;
     u_int multicast_table[ 2 ] = { 0, };
     unsigned long flags;
     u_short rx_cfg_setting;
@@ -1795,16 +1805,15 @@
     }
     
     /* Load MC table and Rx setting into the chip without interrupts. */
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&smc->lock, flags);
     SMC_SELECT_BANK(3);
     outl(multicast_table[0], ioaddr + MULTICAST0);
     outl(multicast_table[1], ioaddr + MULTICAST4);
     SMC_SELECT_BANK(0);
     outw(rx_cfg_setting, ioaddr + RCR);
     SMC_SELECT_BANK(2);
-    restore_flags(flags);
-    
+    spin_unlock_irqrestore(&smc->lock, flags);
+ 
     return;
 }
 
@@ -1917,11 +1926,11 @@
 	SMC_SELECT_BANK(3);
 
 	/* Reset MII */
-	mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x8000);
+	smc_mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x8000);
 
 	/* Restart MII autonegotiation */
-	mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x0000);
-	mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x1200);
+	smc_mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x0000);
+	smc_mdio_write(ioaddr + MGMT, smc->phy_id, 0, 0x1200);
     }
 
     /* Enable interrupts. */
@@ -1978,7 +1987,7 @@
 	    goto reschedule;
 
 	SMC_SELECT_BANK(3);
-	link = mdio_read(mii_addr, smc->phy_id, 1);
+	link = smc_mdio_read(mii_addr, smc->phy_id, 1);
 	if (!link || (link == 0xffff)) {
   	    printk(KERN_INFO "%s: MII is missing!\n", dev->name);
 	    smc->phy_id = -1;
@@ -1987,7 +1996,7 @@
 
 	link &= 0x0004;
 	if (link != smc->link_status) {
-	    u_short p = mdio_read(mii_addr, smc->phy_id, 5);
+	    u_short p = smc_mdio_read(mii_addr, smc->phy_id, 5);
 	    printk(KERN_INFO "%s: %s link beat\n", dev->name,
 		(link) ? "found" : "lost");
 	    if (link) {
@@ -2042,6 +2051,178 @@
     add_timer(&smc->media);
     SMC_SELECT_BANK(saved_bank);
 }
+
+static int smc_link_ok(struct net_device *dev)
+{
+    ioaddr_t ioaddr = dev->base_addr;
+    
+    SMC_SELECT_BANK(0);
+    return inw(ioaddr + EPH) & EPH_LINK_OK;
+}
+
+static int smc_netdev_get_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	u16 tmp;
+	ioaddr_t ioaddr = dev->base_addr;
+
+	ecmd->supported = (SUPPORTED_TP | SUPPORTED_AUI |
+		SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full);
+		
+	SMC_SELECT_BANK(1);
+	tmp = inw(dev->base_addr + CONFIG);
+	ecmd->port = (tmp & CFG_AUI_SELECT) ? PORT_AUI : PORT_TP;
+	ecmd->transceiver = XCVR_INTERNAL;
+	ecmd->speed = SPEED_10;
+	ecmd->phy_address = dev->base_addr + MGMT;
+
+	SMC_SELECT_BANK(0);
+	tmp = inw(dev->base_addr + TCR);
+	ecmd->duplex = (tmp & TCR_FDUPLX) ? DUPLEX_FULL : DUPLEX_HALF;
+
+	return 0;
+}
+
+static int smc_netdev_set_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	u16 tmp;
+	ioaddr_t ioaddr = dev->base_addr;
+
+	if (ecmd->speed != SPEED_10)
+		return -EINVAL;
+	if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
+		return -EINVAL;
+	if (ecmd->port != PORT_TP && ecmd->port != PORT_AUI)
+		return -EINVAL;
+	if (ecmd->transceiver != XCVR_INTERNAL)
+		return -EINVAL;
+
+	if (ecmd->port == PORT_AUI)
+		smc_set_xcvr(dev, 1);
+	else
+		smc_set_xcvr(dev, 0);
+
+	SMC_SELECT_BANK(0);
+	tmp = inw(dev->base_addr + TCR);
+	if (ecmd->duplex == DUPLEX_FULL)
+		tmp |= TCR_FDUPLX;
+	else
+		tmp &= ~TCR_FDUPLX;
+	outw(dev->base_addr + TCR, tmp);
+	
+	return 0;
+}
+
+static int smc_ethtool_ioctl (struct net_device *dev, void *useraddr)
+{
+	u32 ethcmd;
+	struct smc_private *smc = dev->priv;
+
+	if (get_user(ethcmd, (u32 *)useraddr))
+		return -EFAULT;
+
+	switch (ethcmd) {
+
+	case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+		strcpy(info.driver, DRV_NAME);
+		strcpy(info.version, DRV_VERSION);
+		if (copy_to_user(useraddr, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* get settings */
+	case ETHTOOL_GSET: {
+		int ret;
+		struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+		spin_lock_irq(&smc->lock);
+		ret = smc_netdev_get_ecmd(dev, &ecmd);
+		spin_unlock_irq(&smc->lock);
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return ret;
+	}
+	/* set settings */
+	case ETHTOOL_SSET: {
+		int ret;
+		struct ethtool_cmd ecmd;
+		if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
+			return -EFAULT;
+		spin_lock_irq(&smc->lock);
+		ret = smc_netdev_set_ecmd(dev, &ecmd);
+		spin_unlock_irq(&smc->lock);
+		return ret;
+	}
+
+	/* get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = { ETHTOOL_GLINK };
+		spin_lock_irq(&smc->lock);
+		edata.data = smc_link_ok(dev);	/* yucky foo */
+		spin_unlock_irq(&smc->lock);
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
+#ifdef PCMCIA_DEBUG
+	/* get message-level */
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value edata = { ETHTOOL_GMSGLVL };
+		edata.data = pc_debug;
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	/* set message-level */
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value edata;
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		pc_debug = edata.data;
+		return 0;
+	}
+#endif
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int smc_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct smc_private *smc = dev->priv;
+	struct mii_ioctl_data *mii;
+	int rc = 0;
+
+	mii = (struct mii_ioctl_data *) &rq->ifr_data;
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (cmd != SIOCETHTOOL) 
+		mii->reg_num &= 0x1f;
+	
+	switch (cmd) {
+	case SIOCETHTOOL:
+		return smc_ethtool_ioctl(dev, (void *) rq->ifr_data);
+		
+ 	case SIOCGMIIPHY:	/* Get the address of the PHY in use. */
+		mii->phy_id = smc->phy_id;
+		/* Fall Through */
+
+	case SIOCGMIIREG:	/* Read the specified MII register. */
+		mii->val_out = smc_mdio_read (dev->base_addr + MGMT, mii->phy_id, mii->reg_num);
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
 
 /*====================================================================*/
 

