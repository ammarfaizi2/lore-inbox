Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbRBZObC>; Mon, 26 Feb 2001 09:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130254AbRBZO3T>; Mon, 26 Feb 2001 09:29:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130215AbRBZO2o>;
	Mon, 26 Feb 2001 09:28:44 -0500
Message-ID: <3A9A5804.34BAD390@uow.edu.au>
Date: Tue, 27 Feb 2001 00:20:04 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ion Badulescu <ionut@cs.columbia.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Lazarus Long <lazarus@workspot.net>, Petr Baudis <pasky@pasky.ji.cz>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [patch] fix ether= kernel parameter
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few people have reported that 3c509.c is incorrectly selecting
the BNC connector when used non-modularly.

This is due to 2.2-vs-2.4 incompatibility in the handling
of the `ether=' kernel option.  The `ether=' option takes
up to five args.  If any are omitted, they default to zero
in kernel 2.2 and to -1 in kernel 2.4.  This will break
a lot more drivers than just 3c509 - five or six, including
natsemi.c and hamachi.c.

This patch restores the 2.2 behaviour.

Notes:

- The `netdev=' and `ether=' kernel options are identical.
  So `ether_setup()' is removed, and the `ether=' option
  calls netdev_boot_setup() instead.  We can re-fork the
  implementation later if these options become different.

- drivers/net/net_init.c:ether_config() isn't used 
  anywhere.  It has been removed.

- In 3c59x.c and starfire.c: remove the recently-added
  workarounds for dev->mem_start == -1.

Patch is against 2.4.2-ac4.  It also applies to 2.4.2 (ignore
the rejects).



--- linux-2.4.2-ac4/include/linux/netdevice.h	Mon Feb 26 23:18:02 2001
+++ lk/include/linux/netdevice.h	Mon Feb 26 23:36:39 2001
@@ -630,7 +630,6 @@
 extern void		tr_setup(struct net_device *dev);
 extern void		fc_setup(struct net_device *dev);
 extern void		fc_freedev(struct net_device *dev);
-extern int		ether_config(struct net_device *dev, struct ifmap *map);
 /* Support for loadable net-drivers */
 extern int		register_netdev(struct net_device *dev);
 extern void		unregister_netdev(struct net_device *dev);
--- linux-2.4.2-ac4/drivers/net/net_init.c	Sun Feb 25 17:37:06 2001
+++ lk/drivers/net/net_init.c	Mon Feb 26 23:36:34 2001
@@ -390,23 +390,6 @@
 
 #endif /* CONFIG_ATALK || CONFIG_ATALK_MODULE */
 
-int ether_config(struct net_device *dev, struct ifmap *map)
-{
-	if (map->mem_start != (u_long)(-1))
-		dev->mem_start = map->mem_start;
-	if (map->mem_end != (u_long)(-1))
-		dev->mem_end = map->mem_end;
-	if (map->base_addr != (u_short)(-1))
-		dev->base_addr = map->base_addr;
-	if (map->irq != (u_char)(-1))
-		dev->irq = map->irq;
-	if (map->dma != (u_char)(-1))
-		dev->dma = map->dma;
-	if (map->port != (u_char)(-1))
-		dev->if_port = map->port;
-	return 0;
-}
-
 int register_netdev(struct net_device *dev)
 {
 	int err;
--- linux-2.4.2-ac4/drivers/net/3c59x.c	Mon Feb 26 23:17:41 2001
+++ lk/drivers/net/3c59x.c	Mon Feb 26 23:36:34 2001
@@ -1003,7 +1003,7 @@
 		pdev->driver_data = dev;
 
 	/* The lower four bits are the media type. */
-	if (dev->mem_start && dev->mem_start != ~0UL) {
+	if (dev->mem_start) {
 		/*
 		 * AKPM: ewww..  The 'options' param is passed in as the third arg to the
 		 * LILO 'ether=' argument for non-modular use
--- linux-2.4.2-ac4/drivers/net/starfire.c	Mon Feb 26 23:17:44 2001
+++ lk/drivers/net/starfire.c	Mon Feb 26 23:36:34 2001
@@ -836,7 +836,7 @@
 	np->pci_dev = pdev;
 	drv_flags = netdrv_tbl[chip_idx].drv_flags;
 
-	if (dev->mem_start && dev->mem_start != ~0UL)
+	if (dev->mem_start)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
--- linux-2.4.2-ac4/net/ethernet/eth.c	Wed Aug 23 01:59:00 2000
+++ lk/net/ethernet/eth.c	Mon Feb 26 23:58:09 2001
@@ -30,6 +30,7 @@
  *		Alan Cox	: Protect against forwarding explosions with
  *				  older network drivers and IFF_ALLMULTI.
  *	Christer Weinigel	: Better rebuild header message.
+ *             Andrew Morton    : 26Feb01: kill ether_setup() - use netdev_boot_setup().
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -60,31 +61,9 @@
 #include <asm/system.h>
 #include <asm/checksum.h>
 
-static int __init eth_setup(char *str)
-{
-	int ints[5];
-	struct ifmap map;
+extern int __init netdev_boot_setup(char *str);
 
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (!str || !*str)
-		return 0;
-
- 	/* Save settings */
- 	memset(&map, -1, sizeof(map));
-	if (ints[0] > 0)
-		map.irq = ints[1];
-	if (ints[0] > 1)
-		map.base_addr = ints[2];
-	if (ints[0] > 2)
-		map.mem_start = ints[3];
-	if (ints[0] > 3)
-		map.mem_end = ints[4];
-
-	/* Add new entry to the list */
-	return netdev_boot_setup_add(str, &map);
-}
-
-__setup("ether=", eth_setup);
+__setup("ether=", netdev_boot_setup);
 
 /*
  *	 Create the Ethernet MAC header for an arbitrary protocol layer 
--- linux-2.4.2-ac4/Documentation/kernel-parameters.txt	Sun Dec 31 06:23:13 2000
+++ lk/Documentation/kernel-parameters.txt	Mon Feb 26 23:55:41 2001
@@ -188,8 +188,10 @@
 
 	es1371=		[HW,SOUND]
  
-	ether=		[HW,NET] Ethernet cards parameters (iomem, irq,
-			dev_name).
+	ether=		[HW,NET] Ethernet cards parameters (irq,
+			base_io_addr, mem_start, mem_end, name.
+			(mem_start is often overloaded to mean something
+			different and driver-specific).
 
 	fd_mcs=		[HW,SCSI]
 
@@ -328,7 +330,11 @@
 
 	ncr53c8xx=	[HW,SCSI]
 
-	netdev=		[NET]
+	netdev=		[NET] Ethernet cards parameters (irq,
+			base_io_addr, mem_start, mem_end, name.
+			(mem_start is often overloaded to mean something
+			different and driver-specific).
+			(cf: ether=)
  
 	nfsaddrs=	[NFS]
 
--- linux-2.4.2-ac4/net/core/dev.c	Mon Feb 26 23:18:06 2001
+++ lk/net/core/dev.c	Mon Feb 26 23:56:30 2001
@@ -351,7 +351,7 @@
 /*
  * Saves at boot time configured settings for any netdevice.
  */
-static int __init netdev_boot_setup(char *str)
+int __init netdev_boot_setup(char *str)
 {
 	int ints[5];
 	struct ifmap map;
@@ -361,7 +361,7 @@
 		return 0;
 
 	/* Save settings */
-	memset(&map, -1, sizeof(map));
+	memset(&map, 0, sizeof(map));
 	if (ints[0] > 0)
 		map.irq = ints[1];
 	if (ints[0] > 1)

-
