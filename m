Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262188AbSJFVGo>; Sun, 6 Oct 2002 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbSJFVGo>; Sun, 6 Oct 2002 17:06:44 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:58262
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262188AbSJFVGl>; Sun, 6 Oct 2002 17:06:41 -0400
Date: Sun, 6 Oct 2002 17:00:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][RFT] 3c509.c extra ethtool features
Message-ID: <Pine.LNX.4.44.0210061618140.20917-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	If anyone has a 3c509 could they try;

ethtool eth0
ethtool -s eth0 port tp, bnc etc..
ethtool eth0

and see if all the returned stuff looks sane.

Thanks,
	Zwane
-- 
function.linuxpower.ca

Index: linux-2.5.40/drivers/net/3c509.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.40/drivers/net/3c509.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 3c509.c
--- linux-2.5.40/drivers/net/3c509.c	1 Oct 2002 12:27:46 -0000	1.1.1.1
+++ linux-2.5.40/drivers/net/3c509.c	6 Oct 2002 20:59:36 -0000
@@ -49,11 +49,13 @@
 			- Power Management support
 		v1.18c 1Mar2002 David Ruggiero <jdr@farfalle.com>
 			- Full duplex support
+		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
+			- Additional ethtool features
 */
 
 #define DRV_NAME	"3c509"
-#define DRV_VERSION	"1.18c"
-#define DRV_RELDATE	"1Mar2002"
+#define DRV_VERSION	"1.19"
+#define DRV_RELDATE	"16Oct2002"
 
 /* A few values that may be tweaked. */
 
@@ -140,9 +142,11 @@
 #define TX_STATUS 	0x0B
 #define TX_FREE		0x0C		/* Remaining free bytes in Tx buffer. */
 
+#define WN0_CONF_CTRL	0x04		/* Window 0: Configuration control register */
+#define WN0_ADDR_CONF	0x06		/* Window 0: Address configuration register */
 #define WN0_IRQ		0x08		/* Window 0: Set IRQ line in bits 12-15. */
 #define WN4_MEDIA	0x0A		/* Window 4: Various transcvr/media bits. */
-#define  MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
+#define	MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
 #define WN4_NETDIAG	0x06		/* Window 4: Net diagnostic */
 #define FD_ENABLE	0x8000		/* Enable full-duplex ("external loopback") */  
 
@@ -981,6 +985,112 @@
 	return 0;
 }
 
+static int el3_link_ok(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+	u16 tmp;
+
+	EL3WINDOW(4);
+	tmp = inw(ioaddr + WN4_MEDIA);
+	return tmp & (1<<11);
+}
+
+static int el3_netdev_get_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	u16 tmp;
+	int ioaddr = dev->base_addr;
+	
+	EL3WINDOW(0);
+	/* obtain current tranceiver via WN4_MEDIA? */	
+	tmp = inw(ioaddr + WN0_ADDR_CONF);
+	ecmd->transceiver = XCVR_INTERNAL;
+	switch (tmp >> 14) {
+	case 0:
+		ecmd->port = PORT_TP;
+		break;
+	case 1:
+		ecmd->port = PORT_AUI;
+		ecmd->transceiver = XCVR_EXTERNAL;
+		break;
+	case 3:
+		ecmd->port = PORT_BNC;
+	default:
+		break;
+	}
+
+	ecmd->duplex = DUPLEX_HALF;
+	ecmd->supported = 0;
+	tmp = inw(ioaddr + WN0_CONF_CTRL);
+	if (tmp & (1<<13))
+		ecmd->supported |= SUPPORTED_AUI;
+	if (tmp & (1<<12))
+		ecmd->supported |= SUPPORTED_BNC;
+	if (tmp & (1<<9)) {
+		ecmd->supported |= SUPPORTED_TP | SUPPORTED_10baseT_Half |
+				SUPPORTED_10baseT_Full;	/* hmm... */
+		EL3WINDOW(4);
+		tmp = inw(ioaddr + WN4_NETDIAG);
+		if (tmp & FD_ENABLE)
+			ecmd->duplex = DUPLEX_FULL;
+	}
+		
+	ecmd->speed = SPEED_10;
+	return 0;
+}
+
+static int el3_netdev_set_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	u16 tmp;
+	int ioaddr = dev->base_addr;
+
+	if (ecmd->speed != SPEED_10)
+		return -EINVAL;
+	if ((ecmd->duplex != DUPLEX_HALF) || (ecmd->duplex != DUPLEX_FULL))
+		return -EINVAL;
+	if ((ecmd->transceiver != XCVR_INTERNAL) || (ecmd->transceiver != XCVR_EXTERNAL))
+		return -EINVAL;
+
+	/* change XCVR type */
+	EL3WINDOW(0);
+	tmp = inw(ioaddr + WN0_ADDR_CONF);
+	switch (ecmd->port) {
+	case PORT_TP:
+		tmp &= ~(3<<14);
+		dev->if_port = 0;
+		break;
+	case PORT_AUI:
+		tmp |= (1<<14);
+		dev->if_port = 1;
+		break;
+	case PORT_BNC:
+		tmp |= (3<<14);
+		dev->if_port = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	outw(tmp, ioaddr + WN0_ADDR_CONF);
+	if (dev->if_port == 3) {
+		tmp = inw(ioaddr + WN0_ADDR_CONF);
+		if (tmp & (1<<11)) {
+			outw(StartCoax, ioaddr + EL3_CMD);
+			udelay(800);
+		} else
+			return -EIO;
+	}
+
+	EL3WINDOW(4);
+	tmp = inw(ioaddr + WN4_NETDIAG);
+	if (ecmd->duplex == DUPLEX_FULL)
+		tmp |= FD_ENABLE;
+	else
+		tmp &= ~FD_ENABLE;
+	outw(tmp, ioaddr + WN4_NETDIAG);
+
+	return 0;
+}
+
 /**
  * netdev_ethtool_ioctl: Handle network interface SIOCETHTOOL ioctls
  * @dev: network interface on which out-of-band action is to be performed
@@ -992,6 +1102,7 @@
 static int netdev_ethtool_ioctl (struct net_device *dev, void *useraddr)
 {
 	u32 ethcmd;
+	struct el3_private *lp = dev->priv;
 
 	/* dev_ioctl() in ../../net/core/dev.c has already checked
 	   capable(CAP_NET_ADMIN), so don't bother with that here.  */
@@ -1010,6 +1121,41 @@
 		return 0;
 	}
 
+	/* get settings */
+	case ETHTOOL_GSET: {
+		int ret;
+		struct ethtool_cmd ecmd = { ETHTOOL_GSET };
+		spin_lock_irq(&lp->lock);
+		ret = el3_netdev_get_ecmd(dev, &ecmd);
+		spin_unlock_irq(&lp->lock);
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return ret;
+	}
+
+	/* set settings */
+	case ETHTOOL_SSET: {
+		int ret;
+		struct ethtool_cmd ecmd;
+		if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
+			return -EFAULT;
+		spin_lock_irq(&lp->lock);
+		ret = el3_netdev_set_ecmd(dev, &ecmd);
+		spin_unlock_irq(&lp->lock);
+		return ret;
+	}
+
+	/* get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = { ETHTOOL_GLINK };
+		spin_lock_irq(&lp->lock);
+		edata.data = el3_link_ok(dev);
+		spin_unlock_irq(&lp->lock);
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
 	/* get message-level */
 	case ETHTOOL_GMSGLVL: {
 		struct ethtool_value edata = {ETHTOOL_GMSGLVL};
@@ -1077,7 +1223,7 @@
 		/* Turn off thinnet power.  Green! */
 		outw(StopCoax, ioaddr + EL3_CMD);
 	else if (dev->if_port == 0) {
-		/* Disable link beat and jabber, if_port may change ere next open(). */
+		/* Disable link beat and jabber, if_port may change here next open(). */
 		EL3WINDOW(4);
 		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
 	}

