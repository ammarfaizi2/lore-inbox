Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbTCTPFQ>; Thu, 20 Mar 2003 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbTCTPFE>; Thu, 20 Mar 2003 10:05:04 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42962 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261459AbTCTPEm>;
	Thu, 20 Mar 2003 10:04:42 -0500
Date: Thu, 20 Mar 2003 17:15:36 +0200 (IST)
From: Shmulik Hen <hshmulik@intel.com>
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
To: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] (2/8) Add 802.3ad support to bonding
Message-ID: <Pine.LNX.4.44.0303201613570.10351-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch complements the latest drop of bonding from source-forge 
(2.4.20-20030317) by incorporating the changes to bond_release_all() too.
It also fixes a hang when releasing a slave while outgoing traffic is 
running, that looks like a deadlock between the BR_NETPROTO_LOCK, 
dev->xmit_lock and the bond lock (happens on quad processor machines, 
but KDB back trace wasn't clear enough).

This patch is against bonding 2.4.20-20030317.

diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding.c	2003-03-18 17:03:24.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding.c	2003-03-18 17:03:24.000000000 +0200
@@ -286,6 +286,15 @@
  *	  checking slave and slave->dev (which only worked by accident).
  *	- Misc code cleanup: get arp_send() prototype from header file,
  *	  add max_bonds to bonding.txt.
+ *
+ * 2003/03/18 - Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *		Shmulik Hen <shmulik.hen at intel dot com>
+ *	- Make sure only bond_attach_slave() and bond_detach_slave() can
+ *	  manipulate the slave list, including slave_cnt, even when in
+ *	  bond_release_all().
+ *	- Fixed hang in bond_release() while traffic is running.		
+ *	  netdev_set_master() must not be called from within the bond lock.
+ *
  */
 
 #include <linux/config.h>
@@ -326,8 +335,8 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 
-#define DRV_VERSION		"2.4.20-20030207"
-#define DRV_RELDATE		"February 7, 2003"
+#define DRV_VERSION		"2.4.20-20030317"
+#define DRV_RELDATE		"March 17, 2003"
 #define DRV_NAME		"bonding"
 #define DRV_DESCRIPTION		"Ethernet Channel Bonding Driver"
 
@@ -1469,16 +1478,14 @@ static int bond_release(struct net_devic
 
 	bond = (struct bonding *) master->priv;
 
-	write_lock_irqsave(&bond->lock, flags);
-
 	/* master already enslaved, or slave not enslaved,
 	   or no slave for this master */
 	if ((master->flags & IFF_SLAVE) || !(slave->flags & IFF_SLAVE)) {
 		printk (KERN_DEBUG "%s: cannot release %s.\n", master->name, slave->name);
-		write_unlock_irqrestore(&bond->lock, flags);
 		return -EINVAL;
 	}
 
+	write_lock_irqsave(&bond->lock, flags);
 	bond->current_arp_slave = NULL;
 	our_slave = (slave_t *)bond;
 	old_current = bond->current_slave;
@@ -1497,38 +1504,7 @@ static int bond_release(struct net_devic
 			} else {
 				printk(".\n");
 			}
-
-			/* release the slave from its bond */
-
-			if (multicast_mode == BOND_MULTICAST_ALL) {
-				/* flush master's mc_list from slave */ 
-				bond_mc_list_flush (slave, master); 
-				
-				/* unset promiscuity level from slave */
-				if (master->flags & IFF_PROMISC) 
-					dev_set_promiscuity(slave, -1); 
-       
-				/* unset allmulti level from slave */ 
-				if (master->flags & IFF_ALLMULTI)
-					dev_set_allmulti(slave, -1); 
-			}
-
-			netdev_set_master(slave, NULL);
-
-			/* only restore its RUNNING flag if monitoring set it down */
-			if (slave->flags & IFF_UP) {
-				slave->flags |= IFF_RUNNING;
-			}
-
-			if (slave->flags & IFF_NOARP || 
-				bond->current_slave != NULL) {
-					dev_close(slave);
-					our_slave->original_flags &= ~IFF_UP;
-			}
-
-			bond_restore_slave_flags(our_slave);
-			kfree(our_slave);
-
+			
 			if (bond->current_slave == NULL) {
 				printk(KERN_INFO
 					"%s: now running without any active interface !\n",
@@ -1539,16 +1515,51 @@ static int bond_release(struct net_devic
 				bond->primary_slave = NULL;
 			}
 
-			write_unlock_irqrestore(&bond->lock, flags);
-			return 0;  /* deletion OK */
+			break;
 		}
-	}
 
-	/* if we get here, it's because the device was not found */
+	}
 	write_unlock_irqrestore(&bond->lock, flags);
+	
+	if (our_slave == (slave_t *)bond) {
+		/* if we get here, it's because the device was not found */
+		printk (KERN_INFO "%s: %s not enslaved\n", master->name, slave->name);
+		return -EINVAL;
+	}
+
+	/* undo settings and restore original values */
+	
+	if (multicast_mode == BOND_MULTICAST_ALL) {
+		/* flush master's mc_list from slave */ 
+		bond_mc_list_flush (slave, master); 
 
-	printk (KERN_INFO "%s: %s not enslaved\n", master->name, slave->name);
-	return -EINVAL;
+		/* unset promiscuity level from slave */
+		if (master->flags & IFF_PROMISC) 
+			dev_set_promiscuity(slave, -1); 
+
+		/* unset allmulti level from slave */ 
+		if (master->flags & IFF_ALLMULTI)
+			dev_set_allmulti(slave, -1); 
+	}
+
+	netdev_set_master(slave, NULL);
+
+	/* only restore its RUNNING flag if monitoring set it down */
+	if (slave->flags & IFF_UP) {
+		slave->flags |= IFF_RUNNING;
+	}
+
+	if (slave->flags & IFF_NOARP || 
+		bond->current_slave != NULL) {
+			dev_close(slave);
+			our_slave->original_flags &= ~IFF_UP;
+	}
+
+	bond_restore_slave_flags(our_slave);
+	
+	kfree(our_slave);
+
+	return 0;  /* deletion OK */
 }
 
 /* 
@@ -1571,10 +1582,12 @@ static int bond_release_all(struct net_d
 
 	bond = (struct bonding *) master->priv;
 	bond->current_arp_slave = NULL;
+	bond->current_slave = NULL;
+	bond->primary_slave = NULL;
 
 	while ((our_slave = bond->prev) != (slave_t *)bond) {
 		slave_dev = our_slave->dev;
-		bond->prev = our_slave->prev;
+		bond_detach_slave(bond, our_slave);
 
 		if (multicast_mode == BOND_MULTICAST_ALL 
 		    || (multicast_mode == BOND_MULTICAST_ACTIVE 
@@ -1604,10 +1617,6 @@ static int bond_release_all(struct net_d
 			dev_close(slave_dev);
 	}
 
-	bond->current_slave = NULL;
-	bond->next = (slave_t *)bond;
-	bond->slave_cnt = 0;
-	bond->primary_slave = NULL;
 	printk (KERN_INFO "%s: released all slaves\n", master->name);
 
 	return 0;

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |
|                                                |
| Anti-Spam: shmulik dot hen at intel dot com    |




