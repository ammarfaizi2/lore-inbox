Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSJAQbQ>; Tue, 1 Oct 2002 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJAQbQ>; Tue, 1 Oct 2002 12:31:16 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64161 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261744AbSJAQbL>; Tue, 1 Oct 2002 12:31:11 -0400
Date: Tue, 1 Oct 2002 11:34:20 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] pcnet32 cable status check
In-Reply-To: <3D98B25E.2010408@pobox.com>
Message-ID: <Pine.LNX.4.44.0210011129330.14607-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  Here's the updated version, now dependent on Jeff's new mii code.  This is 
a bit more modular as well and new functionality can be added inside the 
watchdog function without anything depending on mii.

Thanks,
Kent

--- linux-2.5.39.vanilla/drivers/net/pcnet32.c	Sat Sep 21 23:25:05 2002
+++ linux-2.5.39/drivers/net/pcnet32.c	Tue Oct  1 11:21:13 2002
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.27a"
-#define DRV_RELDATE	"10.02.2002"
+#define DRV_VERSION	"1.27b"
+#define DRV_RELDATE	"01.10.2002"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -96,6 +96,8 @@
 
 #define PCNET32_DMA_MASK 0xffffffff
 
+#define PCNET32_WATCHDOG_TIMEOUT (jiffies + (2 * HZ))
+
 /*
  * table to translate option values from tulip
  * to internal options
@@ -211,6 +213,8 @@
  *	   fix pci probe not increment cards_found
  *	   FD auto negotiate error workaround for xSeries250
  *	   clean up and using new mii module
+ * v1.27b  Sep 30 2002 Kent Yoder <yoder1@us.ibm.com>
+ * 	   Added timer for cable connection state changes.
  */
 
 
@@ -318,6 +322,7 @@
 	mii:1;				/* mii port available */
     struct net_device	*next;
     struct mii_if_info mii_if;
+    struct timer_list	watchdog_timer;
 };
 
 static void pcnet32_probe_vlbus(void);
@@ -333,6 +338,7 @@
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
 static void pcnet32_set_multicast_list(struct net_device *);
 static int  pcnet32_ioctl(struct net_device *, struct ifreq *, int);
+static void pcnet32_watchdog(struct net_device *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
 static void mdio_write(struct net_device *dev, int phy_id, int reg_num, int val);
 
@@ -777,6 +783,13 @@
 	}
     }
 
+    /* Set the mii phy_id so that we can query the link state */
+    if (lp->mii)
+	lp->mii_if.phy_id = ((lp->a.read_bcr (ioaddr, 33)) >> 5) & 0x1f;
+
+    init_timer (&lp->watchdog_timer);
+    lp->watchdog_timer.data = (unsigned long) dev;
+    lp->watchdog_timer.function = (void *) &pcnet32_watchdog;
     
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
@@ -901,6 +914,12 @@
 
     netif_start_queue(dev);
 
+    /* If we have mii, print the link status and start the watchdog */
+    if (lp->mii) {
+	mii_check_media (&lp->mii_if, 1, 1);
+	mod_timer (&(lp->watchdog_timer), PCNET32_WATCHDOG_TIMEOUT);
+    }
+    
     i = 0;
     while (i++ < 100)
 	if (lp->a.read_csr (ioaddr, 0) & 0x0100)
@@ -1371,6 +1390,8 @@
     struct pcnet32_private *lp = dev->priv;
     int i;
 
+    del_timer_sync(&lp->watchdog_timer);
+
     netif_stop_queue(dev);
 
     lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
@@ -1651,6 +1672,17 @@
     return -EOPNOTSUPP;
 }
 
+static void pcnet32_watchdog(struct net_device *dev)
+{
+    struct pcnet32_private *lp = dev->priv;
+
+    /* Print the link status if it has changed */
+    if (lp->mii)
+	mii_check_media (&lp->mii_if, 1, 0);
+
+    mod_timer (&(lp->watchdog_timer), PCNET32_WATCHDOG_TIMEOUT);
+}
+
 static struct pci_driver pcnet32_driver = {
     name:	DRV_NAME,
     probe:	pcnet32_probe_pci,

