Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSI3T22>; Mon, 30 Sep 2002 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSI3T21>; Mon, 30 Sep 2002 15:28:27 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:19667 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261242AbSI3T2Y>; Mon, 30 Sep 2002 15:28:24 -0400
Date: Mon, 30 Sep 2002 14:31:30 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: linux-kernel@vger.kernel.org
cc: tsbogend@alpha.franken.de, <jgarzik@mandrakesoft.com>
Subject: [PATCH] pcnet32 cable status check
Message-ID: <Pine.LNX.4.44.0209301421100.13906-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

Name: PCnet32 cable status patch
Author: Kent Yoder
Status: Tested on 2.4.20-pre8

D: A patch for the pcnet32 driver to check the status of the 
D: cable via a watchdog timer as the e100/e1000 drivers do.

Comments and criticism are welcome, as I've gotten no response from the 
maintainer. 

Thanks,
Kent


--- linux-2.4.19.vanilla/drivers/net/pcnet32.c	Fri Aug  2 19:39:44 2002
+++ linux-2.4.19/drivers/net/pcnet32.c	Mon Sep 30 10:59:27 2002
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.27a"
-#define DRV_RELDATE	"10.02.2002"
+#define DRV_VERSION	"1.27b"
+#define DRV_RELDATE	"30.09.2002"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -212,6 +212,8 @@
  *	   fix pci probe not increment cards_found
  *	   FD auto negotiate error workaround for xSeries250
  *	   clean up and using new mii module
+ * v1.27b  Sep 30 2002 Kent Yoder <yoder1@us.ibm.com>
+ * 	   Added timer for cable connection state changes.
  */
 
 
@@ -316,9 +318,11 @@
     int	shared_irq:1,			/* shared irq possible */
 	ltint:1,			/* enable TxDone-intr inhibitor */
 	dxsuflo:1,			/* disable transmit stop on uflo */
-	mii:1;				/* mii port available */
+	mii:1,				/* mii port available */
+	link:1;				/* cable link up/down */
     struct net_device	*next;
     struct mii_if_info mii_if;
+    struct timer_list	watchdog_timer;
 };
 
 static void pcnet32_probe_vlbus(void);
@@ -334,6 +338,7 @@
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
 static void pcnet32_set_multicast_list(struct net_device *);
 static int  pcnet32_ioctl(struct net_device *, struct ifreq *, int);
+static void pcnet32_watchdog(struct net_device *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
 static void mdio_write(struct net_device *dev, int phy_id, int reg_num, int val);
 
@@ -778,6 +783,13 @@
 	}
     }
 
+    /* Set the mii phy_id so that we can query the link state */
+    if (lp->mii)
+	lp->mii_if.phy_id = ((lp->a.read_bcr (ioaddr, 33)) >> 5) & 0x1f;
+
+    init_timer(&lp->watchdog_timer);
+    lp->watchdog_timer.data = (unsigned long) dev;
+    lp->watchdog_timer.function = (void *) &pcnet32_watchdog;
     
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
@@ -902,6 +914,19 @@
 
     netif_start_queue(dev);
 
+    /* If we have mii, print the link status and start the watchdog */
+    if (lp->mii) {
+	if(mii_link_ok (&lp->mii_if)) {
+	    printk (KERN_INFO PFX "%s: Cable link is up.\n", dev->name);
+	    lp->link = 1;
+	} else {
+	    printk (KERN_INFO PFX "%s: Cable not connected.\n", dev->name);
+	    lp->link = 0;
+	}
+
+        mod_timer(&(lp->watchdog_timer), jiffies + (2 * HZ));
+    }
+    
     i = 0;
     while (i++ < 100)
 	if (lp->a.read_csr (ioaddr, 0) & 0x0100)
@@ -1372,6 +1397,8 @@
     struct pcnet32_private *lp = dev->priv;
     int i;
 
+    del_timer_sync(&lp->watchdog_timer);
+
     netif_stop_queue(dev);
 
     lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
@@ -1650,6 +1677,22 @@
 	}
     }
     return -EOPNOTSUPP;
+}
+
+static void pcnet32_watchdog(struct net_device *dev)
+{
+    struct pcnet32_private *lp = dev->priv;
+
+    if(!netif_running(dev))
+	return;
+
+    if(mii_link_ok(&lp->mii_if) != (lp->link & 1)) {
+	printk(KERN_INFO PFX "%s: Cable link is %s.\n", 
+		dev->name, (lp->link ? "down" : "up"));
+	lp->link ^= 1;
+    }
+    
+    mod_timer(&(lp->watchdog_timer), jiffies + (2 * HZ));
 }
 
 static struct pci_driver pcnet32_driver = {


