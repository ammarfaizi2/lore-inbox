Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129578AbRB0GLr>; Tue, 27 Feb 2001 01:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRB0GLh>; Tue, 27 Feb 2001 01:11:37 -0500
Received: from cs.columbia.edu ([128.59.16.20]:61151 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129578AbRB0GLU>;
	Tue, 27 Feb 2001 01:11:20 -0500
Date: Mon, 26 Feb 2001 22:11:18 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire.c update for 2.2.19pre
Message-ID: <Pine.LNX.4.30.0102262206130.15118-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch, against 2.2.19pre15, makes the compatibility functions static
so they don't pollute the namespace, and marks some of them as __init. It
has a few other small fixes from the 2.4 driver.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------------------
--- /mnt/3/linux-2.2.19pre/drivers/net/starfire.c	Mon Feb 26 21:56:30 2001
+++ linux-2.2.18/drivers/net/starfire.c	Mon Feb 26 21:51:06 2001
@@ -49,6 +49,16 @@
 	LK1.2.4 (Ion Badulescu)
 	- More 2.2.x initialization fixes
 
+	LK1.2.5 (Ion Badulescu)
+	- Several fixes from Manfred Spraul
+
+	LK1.2.6 (Ion Badulescu)
+	- Fixed ifup/ifdown/ifup problem in 2.4.x
+
+	LK1.2.7 (Ion Badulescu)
+	- Removed unused code
+	- Made more functions static and __init
+
 TODO:
 	- implement tx_timeout() properly
 	- support ethtool
@@ -61,7 +71,7 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";
 
 static const char version3[] =
-" (unofficial 2.2.x kernel port, version 1.2.4, February 11, 2001)\n";
+" (unofficial 2.2.x kernel port, version 1.2.7, February 26, 2001)\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -330,7 +340,7 @@
 #define pci_resource_flags(dev, i) \
   ((dev->base_address[i] & IORESOURCE_IO) ? IORESOURCE_IO : IORESOURCE_MEM)
 
-void * pci_get_drvdata (struct pci_dev *dev)
+static void * pci_get_drvdata (struct pci_dev *dev)
 {
 	int i;
 
@@ -341,7 +351,7 @@
 	return NULL;
 }
 
-void pci_set_drvdata (struct pci_dev *dev, void *driver_data)
+static void pci_set_drvdata (struct pci_dev *dev, void *driver_data)
 {
 	int i;
 
@@ -352,7 +362,7 @@
 		}
 }
 
-const struct pci_device_id *
+static const struct pci_device_id * __init
 pci_compat_match_device(const struct pci_device_id *ids, struct pci_dev *dev)
 {
 	u16 subsystem_vendor, subsystem_device;
@@ -372,7 +382,7 @@
 	return NULL;
 }
 
-static int
+static int __init
 pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
 {
 	const struct pci_device_id *id;
@@ -405,7 +415,7 @@
 	return 0;
 }
 
-int
+static int __init
 pci_register_driver(struct pci_driver *drv)
 {
 	struct pci_dev *dev;
@@ -424,7 +434,7 @@
 	return count;
 }
 
-void
+static void
 pci_unregister_driver(struct pci_driver *drv)
 {
 	struct pci_dev *dev;
@@ -447,14 +457,6 @@
 #endif
 }
 
-void *compat_request_region (unsigned long start, unsigned long n, const char *name)
-{
-	if (check_region (start, n) != 0)
-		return NULL;
-	request_region (start, n, name);
-	return (void *) 1;
-}
-
 static inline int pci_module_init(struct pci_driver *drv)
 {
 	if (pci_register_driver(drv))
@@ -483,6 +485,9 @@
 			func(dev); \
 	}
 
+#define netif_start_if(dev)	dev->start = 1
+#define netif_stop_if(dev)	dev->start = 0
+
 #else  /* LINUX_VERSION_CODE > 0x20300 */
 
 #define COMPAT_MOD_INC_USE_COUNT
@@ -493,6 +498,8 @@
 	dev->watchdog_timeo = timeout;
 #define kick_tx_timer(dev, func, timeout)
 
+#define netif_start_if(dev)
+#define netif_stop_if(dev)
 
 #endif /* LINUX_VERSION_CODE > 0x20300 */
 /* end of compatibility code */
@@ -658,7 +665,6 @@
 #endif
 };
 
-#define PRIV_ALIGN	15	/* Required alignment mask */
 struct rx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
@@ -668,6 +674,7 @@
 	dma_addr_t first_mapping;
 };
 
+#define MII_CNT		2
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct starfire_rx_desc *rx_ring;
@@ -704,7 +711,7 @@
 	/* MII transceiver section. */
 	int mii_cnt;			/* MII device addresses. */
 	u16 advertising;		/* NWay media advertisement */
-	unsigned char phys[2];		/* MII device addresses. */
+	unsigned char phys[MII_CNT];	/* MII device addresses. */
 };
 
 static int	mdio_read(struct net_device *dev, int phy_id, int location);
@@ -856,7 +863,7 @@
 	if (drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
 		int mii_status;
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
 			mdio_write(dev, phy, 0, 0x8000);
 			udelay(500);
 			boguscnt = 1000;
@@ -1038,6 +1045,7 @@
 	if (dev->if_port == 0)
 		dev->if_port = np->default_port;
 
+	netif_start_if(dev);
 	netif_start_queue(dev);
 
 	if (debug > 1)
@@ -1709,7 +1717,8 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	netif_device_detach(dev);
+	netif_stop_queue(dev);
+	netif_start_if(dev);
 
 	del_timer_sync(&np->timer);
 

