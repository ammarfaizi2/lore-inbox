Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbTCTPGg>; Thu, 20 Mar 2003 10:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbTCTPGb>; Thu, 20 Mar 2003 10:06:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:46547 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261513AbTCTPFd>;
	Thu, 20 Mar 2003 10:05:33 -0500
Date: Thu, 20 Mar 2003 17:16:25 +0200 (IST)
From: Shmulik Hen <hshmulik@intel.com>
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
To: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] (4/8) Add 802.3ad support to bonding
Message-ID: <Pine.LNX.4.44.0303201635460.10351-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for getting slave's speed and duplex via ethtool 
(Needed for 802.3ad and other future modes).

This patch is against bonding 2.4.20-20030317.

diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding.c	2003-03-18 17:03:26.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c	2003-03-18 17:03:27.000000000 +0200
@@ -299,6 +299,10 @@
  *		Shmulik Hen <shmulik.hen at intel dot com>
  *	- Fixed hang in bond_enslave(): netdev_set_master() must not be
  *	  called from within the bond lock while traffic is running.
+ *
+ * 2003/03/18 - Amir Noam <amir.noam at intel dot com>
+ *	- Added support for getting slave's speed and duplex via ethtool.
+ *	  Needed for 802.3ad and other future modes.
  */
 
 #include <linux/config.h>
@@ -649,6 +653,59 @@ bond_attach_slave(struct bonding *bond, 
 	set_fs(fs);			\
 	ret; })
 
+/*
+ * Get link speed and duplex from the slave's base driver
+ * using ethtool. If for some reason the call fails or the
+ * values are invalid, fake speed and duplex to 100/Full
+ * and return error.
+ */
+static int bond_update_speed_duplex(struct slave *slave)
+{
+	struct net_device *dev = slave->dev;
+	static int (* ioctl)(struct net_device *, struct ifreq *, int);
+	struct ifreq ifr;
+	struct ethtool_cmd etool;
+
+	ioctl = dev->do_ioctl;
+	if (ioctl) {
+		etool.cmd = ETHTOOL_GSET;
+		ifr.ifr_data = (char*)&etool;
+		if (IOCTL(dev, &ifr, SIOCETHTOOL) == 0) {
+			slave->speed = etool.speed;
+			slave->duplex = etool.duplex;
+		} else {
+			goto err_out;
+		}
+	} else {
+		goto err_out;
+	}
+
+	switch (slave->speed) {
+		case SPEED_10:
+		case SPEED_100:
+		case SPEED_1000:
+			break;
+		default:
+			goto err_out;
+	}
+	
+	switch (slave->duplex) {
+		case DUPLEX_FULL:
+		case DUPLEX_HALF:
+			break;
+		default:
+			goto err_out;
+	}
+	
+	return 0;
+	
+err_out:
+	//Fake speed and duplex
+	slave->speed = SPEED_100;
+	slave->duplex = DUPLEX_FULL;
+	return -1;
+}
+
 /* 
  * if <dev> supports MII link status reporting, check its link status.
  *
@@ -1173,6 +1230,13 @@ static int bond_enslave(struct net_devic
 		new_slave->link  = BOND_LINK_DOWN;
 	}
 
+	if (bond_update_speed_duplex(new_slave) && (new_slave->link == BOND_LINK_UP) ) {
+		printk(KERN_WARNING
+		       "bond_enslave(): failed to get speed/duplex from %s, "
+		       "speed forced to 100Mbps, duplex forced to Full.\n",
+		       new_slave->dev->name);
+	}
+	
 	/* if we're in active-backup mode, we need one and only one active
 	 * interface. The backup interfaces will have their NOARP flag set
 	 * because we need them to be completely deaf and not to respond to
@@ -1821,6 +1885,9 @@ static void bond_mii_monitor(struct net_
 			}
 			break;
 		} /* end of switch */
+		
+		bond_update_speed_duplex(slave);
+		
 	} /* end of while */
 
 	/* 
diff -Nuarp linux-2.4.20-bonding-20030317/include/linux/if_bonding.h linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h
--- linux-2.4.20-bonding-20030317/include/linux/if_bonding.h	2003-03-18 17:03:26.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h	2003-03-18 17:03:27.000000000 +0200
@@ -11,6 +11,9 @@
  *	This software may be used and distributed according to the terms
  *	of the GNU Public License, incorporated herein by reference.
  * 
+ * 2003/03/18 - Amir Noam <amir.noam at intel dot com>
+ *	- Added support for getting slave's speed and duplex via ethtool.
+ *	  Needed for 802.3ad and other future modes.
  */
 
 #ifndef _LINUX_IF_BONDING_H
@@ -89,6 +92,8 @@ typedef struct slave {
 	char   state;   /* one of BOND_STATE_XXXX */
 	unsigned short original_flags;
 	u32 link_failure_count;
+	u16    speed;
+	u8     duplex;
 } slave_t;
 
 /*

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |
|                                                |
| Anti-Spam: shmulik dot hen at intel dot com    |



