Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbRFLSlo>; Tue, 12 Jun 2001 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbRFLSlf>; Tue, 12 Jun 2001 14:41:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15762 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263012AbRFLSlS>;
	Tue, 12 Jun 2001 14:41:18 -0400
Message-ID: <3B26622A.BD0852FE@mandrakesoft.com>
Date: Tue, 12 Jun 2001 14:40:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: PATCH: ethtool MII helpers (vers 2)
In-Reply-To: <Pine.LNX.4.33.0106121835340.22227-100000@kenzo.iwr.uni-heidelberg.de> <3B265416.58941C3C@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------75A73EB022F069CDE8124CDE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------75A73EB022F069CDE8124CDE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is an updated version of the ethtool generic MII patch.  It fixes a
few bugs, and adds the capability to restart autonegotiation by passing
AUTONEG_RESTART constant into the existing ETHTOOL_SSET.  Note this
isn't implemented in the code, just added to the ethtool header.

Do not apply, still just for comment and testing.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------75A73EB022F069CDE8124CDE
Content-Type: text/plain; charset=us-ascii;
 name="mii.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mii.patch"

Index: linux_2_4/include/linux/mii.h
diff -u linux_2_4/include/linux/mii.h:1.1.1.1 linux_2_4/include/linux/mii.h:1.1.1.1.52.1
--- linux_2_4/include/linux/mii.h:1.1.1.1	Fri May 11 16:54:44 2001
+++ linux_2_4/include/linux/mii.h	Sun Jun 10 10:26:44 2001
@@ -126,6 +126,33 @@
 #define CSCONFIG_RESV4          0x4000  /* Unused...                   */
 #define CSCONFIG_NDISABLE       0x8000  /* Disable NRZI                */
 
+
+
+struct ethtool_mii_info {
+	struct net_device *dev;	/* our net interface			*/
+	void *useraddr;		/* userspace addr to which we put data	*/
+	
+	int phy_id;		/* PHY we are addressing		*/
+
+	int bmcr;		/* cached MII register values.		*/
+	int bmsr;		/* -1 means 'undefined', which usually	*/
+	int advertising;	/* means the implementation should read	*/
+	int lpa;		/* the values from hardware instead.	*/
+
+	int autoneg;		/* 0 (disabled), 1 (enabled), -1 (ask hw) */
+	unsigned int ignore;	/* mask of medias we never support,	*/
+				/* such as 100baseT4			*/
+	int speed;		/* 10, 100, 1000 or -1 (ask hw)		*/
+	int full_duplex;	/* 0 (no), 1 (yes), -1 (ask hw)		*/
+	unsigned int port;	/* PORT_xxx from linux/ethtool.h	*/
+	
+	int (*mdio_read) (struct net_device *dev, int phy_id, int location);
+	void (*mdio_write) (struct net_device *dev, int phy_id, int location, int val);
+};
+
+int mii_ethtool_gset (struct ethtool_mii_info *mii);
+int mii_ethtool_sset (struct ethtool_mii_info *mii);
+
 /**
  * mii_nway_result
  * @negotiated: value of MII ANAR and'd with ANLPAR
Index: linux_2_4/include/linux/ethtool.h
diff -u linux_2_4/include/linux/ethtool.h:1.1.1.4 linux_2_4/include/linux/ethtool.h:1.1.1.4.84.2
--- linux_2_4/include/linux/ethtool.h:1.1.1.4	Thu Apr 19 17:55:36 2001
+++ linux_2_4/include/linux/ethtool.h	Sun Jun 10 10:56:26 2001
@@ -1,4 +1,4 @@
-/* $Id: ethtool.h,v 1.1.1.4 2001/04/20 00:55:36 jgarzik Exp $
+/* $Id: ethtool.h,v 1.1.1.4.84.2 2001/06/10 17:56:26 jgarzik Exp $
  * ethtool.h: Defines for Linux ethtool.
  *
  * Copyright (C) 1998 David S. Miller (davem@redhat.com)
@@ -34,13 +34,15 @@
 	char	bus_info[32];	/* Bus info for this interface.  For PCI
 				 * devices, use pci_dev->slot_name. */
 	char	reserved1[32];
-	char	reserved2[32];
+	char	reserved2[28];
+	u32	regdump_len;	/* Amount of data from ETHTOOL_GREGS */
 };
 
 /* CMDs currently supported */
 #define ETHTOOL_GSET		0x00000001 /* Get settings. */
 #define ETHTOOL_SSET		0x00000002 /* Set settings, privileged. */
 #define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
+#define ETHTOOL_GREGS		0x00000004 /* Get NIC registers, privileged. */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
@@ -106,5 +108,6 @@
  */
 #define AUTONEG_DISABLE		0x00
 #define AUTONEG_ENABLE		0x01
+#define AUTONEG_RESTART		0x02	/* implies AUTONEG_ENABLE */
 
 #endif /* _LINUX_ETHTOOL_H */
Index: linux_2_4/drivers/net/mii.c
diff -u /dev/null linux_2_4/drivers/net/mii.c:1.1.2.4
--- /dev/null	Tue Jun 12 11:03:26 2001
+++ linux_2_4/drivers/net/mii.c	Sun Jun 10 12:19:43 2001
@@ -0,0 +1,228 @@
+/*
+ *	linux/drivers/net/mii.c
+ *	Copyright 2001 Jeff Garzik <jgarzik@mandrakesoft.com>
+ *
+ *	This software may be used and distributed according to the terms
+ *	of the GNU General Public License, incorporated herein by reference.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <asm/uaccess.h>
+
+
+static int mii_fill_ethtool_cmd (struct net_device *dev,
+				  struct ethtool_mii_info *mii,
+				  struct ethtool_cmd *ecmd)
+{
+	unsigned int bmsr, bmcr, v, autoneg, advertising, lpa;
+	unsigned int negotiated, full_duplex, speed;
+
+	memset(ecmd, 0, sizeof(*ecmd));
+	
+	ecmd->cmd = ETHTOOL_GSET;
+
+	if (mii->bmcr < 0)
+		bmcr = mii->bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+	else	bmcr = mii->bmcr;
+	if (bmcr == 0xffff)
+		return -EIO;
+
+	if (mii->bmsr < 0)
+		bmsr = mii->bmsr = mii->mdio_read(dev, mii->phy_id, MII_BMSR);
+	else	bmsr = mii->bmsr;
+	if (bmsr == 0xffff)
+		return -EIO;
+
+	if (mii->advertising < 0)
+		advertising = mii->advertising =
+			mii->mdio_read(dev, mii->phy_id, MII_ADVERTISE);
+	else	advertising = mii->advertising;
+	if (advertising == 0xffff)
+		return -EIO;
+
+	if (mii->lpa < 0)
+		lpa = mii->lpa = mii->mdio_read(dev, mii->phy_id, MII_LPA);
+	else	lpa = mii->lpa;
+	if (lpa == 0xffff)
+		return -EIO;
+
+	negotiated = advertising & lpa;
+
+	if (mii->autoneg < 0)
+		autoneg = mii->autoneg = (bmcr & BMCR_ANENABLE) ? 1 : 0;
+	else	autoneg = mii->autoneg;
+		
+	if (mii->full_duplex < 0)
+		full_duplex = mii->full_duplex =
+			(mii_nway_result(negotiated) & LPA_DUPLEX) ? 1 : 0;
+	else	full_duplex = mii->full_duplex;
+		
+	if (mii->speed < 0) {
+		if (negotiated & LPA_100)
+			speed = mii->speed = 100;
+		else
+			speed = mii->speed = 10;
+	} else
+		speed = mii->speed;
+	
+	ecmd->supported = SUPPORTED_MII;
+	v = bmsr & ~mii->ignore;
+	if (v & BMSR_10HALF)
+		ecmd->supported |= SUPPORTED_10baseT_Half;
+	if (v & BMSR_10FULL)
+		ecmd->supported |= SUPPORTED_10baseT_Full;
+	if (v & BMSR_100HALF)
+		ecmd->supported |= SUPPORTED_100baseT_Half;
+	if (v & BMSR_100FULL)
+		ecmd->supported |= SUPPORTED_100baseT_Full;
+	if (bmsr & BMSR_ANEGCAPABLE)
+		ecmd->supported |= SUPPORTED_Autoneg;
+	else
+		autoneg = mii->autoneg = 0;
+
+	ecmd->advertising = ADVERTISED_MII;
+	v = advertising & ~mii->ignore;
+	if (v & ADVERTISE_10HALF)
+		ecmd->advertising |= ADVERTISED_10baseT_Half;
+	if (v & ADVERTISE_10FULL)
+		ecmd->advertising |= ADVERTISED_10baseT_Full;
+	if (v & ADVERTISE_100HALF)
+		ecmd->advertising |= ADVERTISED_100baseT_Half;
+	if (v & ADVERTISE_100FULL)
+		ecmd->advertising |= ADVERTISED_100baseT_Full;
+	if (autoneg) {
+		ecmd->advertising |= ADVERTISED_Autoneg;
+		ecmd->autoneg = AUTONEG_ENABLE;
+	} else
+		ecmd->autoneg = AUTONEG_DISABLE;
+
+	ecmd->speed = speed == 100 ? SPEED_100 : SPEED_10;
+	ecmd->duplex = full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
+	ecmd->port = PORT_MII;
+	ecmd->phy_address = mii->phy_id;
+	ecmd->transceiver = XCVR_INTERNAL;
+
+	return 0;
+}
+
+int mii_ethtool_gset (struct ethtool_mii_info *mii)
+{
+	struct ethtool_cmd ecmd;
+	int rc;
+	
+	if (mii->port != PORT_MII)
+		return -EOPNOTSUPP;
+
+	rc = mii_fill_ethtool_cmd(mii->dev, mii, &ecmd);
+	if (rc)
+		return rc;
+
+	if (copy_to_user(mii->useraddr, &ecmd, sizeof(ecmd)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int mii_ethtool_sset (struct ethtool_mii_info *mii)
+{
+	struct net_device *dev = mii->dev;
+	struct ethtool_cmd in, out;
+	unsigned int advert, bmcr;
+	int rc;
+
+	if (copy_from_user (&in, mii->useraddr, sizeof (in)))
+		return -EFAULT;
+	rc = mii_fill_ethtool_cmd (dev, mii, &out);
+	if (rc)
+		return rc;
+	
+	if (in.port != out.port) {
+		if (copy_to_user(mii->useraddr, &in, sizeof(in)))
+			return -EFAULT;
+		mii->port = in.port;
+		return 0;
+	}
+	
+	/* we don't support changing phy address, tranceiver,
+	 * or the interrupt mitigation stuff.
+	 */
+	if ((in.phy_address != out.phy_address) ||
+	    (in.transceiver != XCVR_INTERNAL) ||
+	    (in.maxtxpkt != out.maxtxpkt) ||
+	    (in.maxrxpkt != out.maxrxpkt))
+		return -EOPNOTSUPP;
+
+	advert = mii->advertising & ~ADVERTISE_ALL;
+
+	/* NWAY autonegotiation enabled */
+	if (in.autoneg == AUTONEG_ENABLE) {
+		bmcr = mii->bmcr | BMCR_ANENABLE;
+
+		if (in.advertising & ADVERTISED_10baseT_Half)
+			advert |= ADVERTISE_10HALF;
+		if (in.advertising & ADVERTISED_10baseT_Full)
+			advert |= ADVERTISE_10FULL;
+		if (in.advertising & ADVERTISED_100baseT_Half)
+			advert |= ADVERTISE_100HALF;
+		if (in.advertising & ADVERTISED_100baseT_Full)
+			advert |= ADVERTISE_100FULL;
+		if (advert == (mii->advertising & ~ADVERTISE_ALL))
+			return -EINVAL;
+	}
+
+	/* NWAY autonegotiation disabled */
+	else {
+		bmcr = mii->bmcr & ~BMCR_ANENABLE;
+		
+		if (in.speed == SPEED_100)
+			bmcr |= BMCR_SPEED100;
+		else	bmcr &= ~BMCR_SPEED100;
+
+		if (in.duplex == DUPLEX_FULL)
+			bmcr |= BMCR_FULLDPLX;
+		else	bmcr &= ~BMCR_FULLDPLX;
+
+		if (mii->bmsr & BMSR_10HALF)
+			advert |= ADVERTISE_10HALF;
+		if (mii->bmsr & BMSR_10FULL)
+			advert |= ADVERTISE_10FULL;
+		if (mii->bmsr & BMSR_100HALF)
+			advert |= ADVERTISE_100HALF;
+		if (mii->bmsr & BMSR_100FULL)
+			advert |= ADVERTISE_100FULL;
+	}
+
+	if (advert != mii->advertising) {
+		bmcr |= BMCR_ANRESTART;
+		mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, advert);
+		mii->advertising = advert;
+	}
+
+	/* some phys need autoneg dis/enabled separately from other settings */
+	if ((bmcr & BMCR_ANENABLE) && (!(mii->bmcr & BMCR_ANENABLE))) {
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR,
+				mii->bmcr | BMCR_ANENABLE | BMCR_ANRESTART);
+		bmcr &= ~BMCR_ANRESTART;
+	} else if ((!(bmcr & BMCR_ANENABLE)) && (mii->bmcr & BMCR_ANENABLE)) {
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR,
+				mii->bmcr & ~BMCR_ANENABLE);
+	}
+
+	if (bmcr != mii->bmcr) {
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR, bmcr);
+		bmcr &= ~BMCR_ANRESTART;
+		mii->bmcr = bmcr;
+	}
+	
+	if (copy_to_user(mii->useraddr, &out, sizeof(out)))
+		return -EFAULT;
+
+	return 0;
+}
+
+EXPORT_SYMBOL(mii_ethtool_gset);
+EXPORT_SYMBOL(mii_ethtool_sset);
Index: linux_2_4/drivers/net/epic100.c
diff -u linux_2_4/drivers/net/epic100.c:1.1.1.35 linux_2_4/drivers/net/epic100.c:1.1.1.35.42.4
--- linux_2_4/drivers/net/epic100.c:1.1.1.35	Sat May 19 18:56:00 2001
+++ linux_2_4/drivers/net/epic100.c	Sun Jun 10 12:42:37 2001
@@ -45,13 +45,16 @@
 	* { fill me in }
 
 	LK1.1.8:
-	* ethtool support (jgarzik)
+	* ethtool driver info support (jgarzik)
 
+	LK1.1.9:
+	* ethtool media get/set support (jgarzik)
+
 */
 
 #define DRV_NAME	"epic100"
-#define DRV_VERSION	"1.11+LK1.1.8"
-#define DRV_RELDATE	"May 18, 2001"
+#define DRV_VERSION	"1.11+LK1.1.9"
+#define DRV_RELDATE	"June 10, 2001"
 
 
 /* The user-configurable values.
@@ -116,6 +119,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
+#include <linux/mii.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -135,6 +139,11 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(debug, "EPIC/100 debug level (0-5)");
+MODULE_PARM_DESC(max_interrupt_work, "EPIC/100 maximum events handled per interrupt");
+MODULE_PARM_DESC(options, "EPIC/100: Bits 0-3: media type, bit 4: full duplex");
+MODULE_PARM_DESC(rx_copybreak, "EPIC/100 copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(full_duplex, "EPIC/100 full duplex setting(s) (1)");
 
 /*
 				Theory of Operation
@@ -1169,7 +1178,7 @@
 			if (pkt_len > PKT_BUF_SZ - 4) {
 				printk(KERN_ERR "%s: Oversized Ethernet frame, status %x "
 					   "%d bytes.\n",
-					   dev->name, pkt_len, status);
+					   dev->name, status, pkt_len);
 				pkt_len = 1514;
 			}
 			/* Check if the packet is long enough to accept without copying
@@ -1344,27 +1353,64 @@
 	return;
 }
 
-static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+static int netdev_ethtool_ioctl (struct net_device *dev, void *useraddr)
 {
 	struct epic_private *np = dev->priv;
 	u32 ethcmd;
-		
-	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+
+	if (copy_from_user (&ethcmd, useraddr, sizeof (ethcmd)))
 		return -EFAULT;
+
+	switch (ethcmd) {
+	case ETHTOOL_GDRVINFO:
+		{
+			struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+			strcpy (info.driver, DRV_NAME);
+			strcpy (info.version, DRV_VERSION);
+			strcpy (info.bus_info, np->pci_dev->slot_name);
+			if (copy_to_user (useraddr, &info, sizeof (info)))
+				return -EFAULT;
+			return 0;
+		}
+
+	case ETHTOOL_GSET:
+	case ETHTOOL_SSET:
+		{
+			struct ethtool_mii_info info = {
+				dev:		dev,
+				useraddr:	useraddr,
+				phy_id:		np->phys[0],
+				bmcr:		-1,
+				bmsr:		-1,
+				lpa:		-1,
+				advertising:	np->advertising,
+				autoneg:	-1,
+				ignore:		ADVERTISE_100BASE4,
+				speed:		-1,
+				full_duplex:	np->full_duplex,
+				port:		PORT_MII,
+				mdio_read:	mdio_read,
+				mdio_write:	mdio_write,
+			};
+			int rc;
+
+			if (ethcmd == ETHTOOL_GSET)
+				rc = mii_ethtool_gset (&info);
+			else
+				rc = mii_ethtool_sset (&info);
 
-        switch (ethcmd) {
-        case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
-		strcpy(info.driver, DRV_NAME);
-		strcpy(info.version, DRV_VERSION);
-		strcpy(info.bus_info, np->pci_dev->slot_name);
-		if (copy_to_user(useraddr, &info, sizeof(info)))
-			return -EFAULT;
-		return 0;
+			np->advertising = info.advertising;
+			np->full_duplex = info.full_duplex;
+
+			check_media (dev);
+
+			return rc;
+		}
+
+	default:
+		break;
 	}
 
-        }
-	
 	return -EOPNOTSUPP;
 }
 

--------------75A73EB022F069CDE8124CDE--

