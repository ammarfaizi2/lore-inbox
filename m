Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJ0B5K>; Sat, 26 Oct 2002 21:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJ0B5K>; Sat, 26 Oct 2002 21:57:10 -0400
Received: from mail502.nifty.com ([202.248.37.210]:10437 "EHLO
	mail502.nifty.com") by vger.kernel.org with ESMTP
	id <S262230AbSJ0B5C>; Sat, 26 Oct 2002 21:57:02 -0400
Date: Sun, 27 Oct 2002 11:02:17 +0900
From: Henry Andersen <HQA2330@nifty.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]  2.5.44 update axnet_cs.c to support AX88790 chipset
Message-Id: <20021027110217.1ea4aa53.HQA2330@nifty.ne.jp>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I update the axnet_cs.c to support Asix AX88790 chipset.
This code comes from the stand-alone pcmcia-cs axnet_cs.c ver1.26.

>eth0: Asix AX88790: io 0x300, irq 5, hw_addr 00:40:26:xx:xx:xx
>eth0: found link beat
>eth0: autonegotiation complete: 100baseT-FD selected



--- drivers/net/pcmcia/axnet_cs.c.orig	Sat Oct 19 13:01:57 2002
+++ drivers/net/pcmcia/axnet_cs.c	Sat Oct 26 21:22:16 2002
@@ -11,7 +11,7 @@
 
     Copyright (C) 2001 David A. Hinds -- dahinds@users.sourceforge.net
 
-    axnet_cs.c 1.11 2001/06/12 12:42:40
+    axnet_cs.c 1.26 2002/02/17 23:30:21
     
     The network driver code is based on Donald Becker's NE2000 code:
 
@@ -20,7 +20,7 @@
     Director, National Security Agency.  This software may be used and
     distributed according to the terms of the GNU General Public License,
     incorporated herein by reference.
-    Donald Becker may be reached at becker@cesdis1.gsfc.nasa.gov
+    Donald Becker may be reached at becker@scyld.com
 
 ======================================================================*/
 
@@ -33,14 +33,13 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/delay.h>
-#include <linux/ethtool.h>
-#include <asm/uaccess.h>
+#include <linux/spinlock.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
 #include <linux/netdevice.h>
-#include "ax8390.h"
+#include "../8390.h"
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -53,34 +52,25 @@
 #define AXNET_CMD	0x00
 #define AXNET_DATAPORT	0x10	/* NatSemi-defined port window offset. */
 #define AXNET_RESET	0x1f	/* Issue a read to reset, a write to clear. */
-#define AXNET_MISC	0x18	/* For IBM CCAE and Socket EA cards */
 #define AXNET_MII_EEP	0x14	/* Offset of MII access port */
+#define AXNET_TEST	0x15	/* Offset of TEST Register port */
+#define AXNET_GPIO	0x17	/* Offset of General Purpose Register Port */
 
 #define AXNET_START_PG	0x40	/* First page of TX buffer */
 #define AXNET_STOP_PG	0x80	/* Last page +1 of RX ring */
 
 #define AXNET_RDC_TIMEOUT 0x02	/* Max wait in jiffies for Tx RDC */
 
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
-"axnet_cs.c 1.11 2001/06/12 12:42:40 (David Hinds)";
-#else
-#define DEBUG(n, args...)
-#endif
-
-#define DEV_KFREE_SKB(skb) dev_kfree_skb(skb);
-#define skb_tx_check(dev, skb)
-#define add_rx_bytes(stats, n) (stats)->rx_bytes += n;
-#define add_tx_bytes(stats, n) (stats)->tx_bytes += n;
-#define netif_mark_up(dev)	do { } while (0)
-#define netif_mark_down(dev)	do { } while (0)
+#define IS_AX88190	0x0001
+#define IS_AX88790	0x0002
 
 /*====================================================================*/
 
-/* Parameters that can be set with 'insmod' */
+/* Module parameters */
+
+MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
+MODULE_DESCRIPTION("Asix AX88190 PCMCIA ethernet driver");
+MODULE_LICENSE("GPL");
 
 #define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
 
@@ -89,9 +79,14 @@
 static int irq_list[4] = { -1 };
 MODULE_PARM(irq_list, "1-4i");
 
-/* Ugh!  Let the user hardwire the hardware address for queer cards */
-static int hw_addr[6] = { 0, /* ... */ };
-MODULE_PARM(hw_addr, "6i");
+#ifdef PCMCIA_DEBUG
+INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
+static char *version =
+"axnet_cs.c 1.26 2002/02/17 23:30:21 (David Hinds)";
+#else
+#define DEBUG(n, args...)
+#endif
 
 /*====================================================================*/
 
@@ -122,6 +117,12 @@
 static dev_info_t dev_info = "axnet_cs";
 static dev_link_t *dev_list;
 
+static int axdev_init(struct net_device *dev);
+static void AX88190_init(struct net_device *dev, int startp);
+static int ax_open(struct net_device *dev);
+static int ax_close(struct net_device *dev);
+static void ax_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
 /*====================================================================*/
 
 typedef struct axnet_dev_t {
@@ -134,6 +135,7 @@
     u_short		link_status;
     u_char		duplex_flag;
     int			phy_id;
+    int			flags;
 } axnet_dev_t;
 
 /*======================================================================
@@ -212,7 +214,7 @@
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.IntType = INT_MEMORY_AND_IO;
 
-    ethdev_init(dev);
+    axdev_init(dev);
     dev->init = &axnet_init;
     dev->open = &axnet_open;
     dev->stop = &axnet_close;
@@ -304,7 +306,7 @@
 	{0x00,	EN0_RCNTHI},
 	{0x00,	EN0_IMR},	/* Mask completion irq. */
 	{0xFF,	EN0_ISR},
-	{E8390_RXOFF, EN0_RXCR},	/* 0x20  Set to monitor */
+	{E8390_RXOFF|0x40, EN0_RXCR},	/* 0x60  Set to monitor */
 	{E8390_TXOFF, EN0_TXCR},	/* 0x02  and loopback mode. */
 	{0x10,	EN0_RCNTLO},
 	{0x00,	EN0_RCNTHI},
@@ -333,30 +335,6 @@
 
 /*======================================================================
 
-    This should be totally unnecessary... but when we can't figure
-    out the hardware address any other way, we'll let the user hard
-    wire it when the module is initialized.
-
-======================================================================*/
-
-static int get_hwired(dev_link_t *link)
-{
-    struct net_device *dev = link->priv;
-    int i;
-
-    for (i = 0; i < 6; i++)
-	if (hw_addr[i] != 0) break;
-    if (i == 6)
-	return 0;
-
-    for (i = 0; i < 6; i++)
-	dev->dev_addr[i] = hw_addr[i];
-
-    return 1;
-} /* get_hwired */
-
-/*======================================================================
-
     axnet_config() is scheduled to run after a CARD_INSERTION event
     is received, to configure the PCMCIA socket, and to make the
     ethernet device available to the system.
@@ -421,7 +399,8 @@
     CS_CHECK(GetTupleData, handle, &tuple);
     CS_CHECK(ParseTuple, handle, &tuple, &parse);
     link->conf.ConfigBase = parse.config.base;
-    link->conf.Present = parse.config.rmask[0];
+    /* don't trust the CIS on this; Linksys got it wrong */
+    link->conf.Present = 0x63;
 
     /* Configure card */
     link->state |= DEV_CONFIG;
@@ -442,7 +421,7 @@
 	if ((cfg->index == 0) || (cfg->io.nwin == 0))
 	    goto next_entry;
 	
-	link->conf.ConfigIndex = cfg->index;
+	link->conf.ConfigIndex = 0x05;
 	/* For multifunction cards, by convention, we configure the
 	   network function with window 0, and serial with window 1 */
 	if (io->nwin > 1) {
@@ -482,9 +461,9 @@
 	goto failed;
     }
 
-    if (!get_prom(link) && !get_hwired(link)) {
-	printk(KERN_NOTICE "axnet_cs: unable to read hardware net"
-	       " address for io base %#3lx\n", dev->base_addr);
+    if (!get_prom(link)) {
+	printk(KERN_NOTICE "axnet_cs: this is not an AX88190 card!\n");
+	printk(KERN_NOTICE "axnet_cs: use pcnet_cs instead.\n");
 	unregister_netdev(dev);
 	goto failed;
     }
@@ -503,15 +482,37 @@
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
 
-    printk(KERN_INFO "%s: Asix AX88190: io %#3lx, irq %d, hw_addr ",
-	   dev->name, dev->base_addr, dev->irq);
+    if (inb(dev->base_addr + AXNET_TEST) != 0)
+	info->flags |= IS_AX88790;
+    else
+	info->flags |= IS_AX88190;
+
+    printk(KERN_INFO "%s: Asix AX88%d90: io %#3lx, irq %d, hw_addr ",
+		dev->name, ((info->flags & IS_AX88790) ? 7 : 1),
+		dev->base_addr, dev->irq);
     for (i = 0; i < 6; i++)
 	printk("%02X%s", dev->dev_addr[i], ((i<5) ? ":" : "\n"));
 
+    if (info->flags & IS_AX88790)
+	outb(0x10, dev->base_addr + AXNET_GPIO);  /* select Internal PHY */
+
     for (i = 0; i < 32; i++) {
 	j = mdio_read(dev->base_addr + AXNET_MII_EEP, i, 1);
 	if ((j != 0) && (j != 0xffff)) break;
     }
+
+
+    /* Maybe PHY is in power down mode. (PPD_SET = 1) 
+       Bit 2 of CCSR is active low. */ 
+    if (i == 32) {
+	conf_reg_t reg = { 0, CS_WRITE, CISREG_CCSR, 0x04 };
+ 	CardServices(AccessConfigurationRegister, link->handle, &reg);
+	for (i = 0; i < 32; i++) {
+	    j = mdio_read(dev->base_addr + AXNET_MII_EEP, i, 1);
+	    if ((j != 0) && (j != 0xffff)) break;
+	}
+    }
+
     info->phy_id = (i < 32) ? i : -1;
     if (i < 32) {
 	DEBUG(0, "  MII transceiver at index %d, status %x.\n", i, j);
@@ -544,7 +545,7 @@
 
     if (link->open) {
 	DEBUG(1, "axnet_cs: release postponed, '%s' still open\n",
-	      info->node.dev_name);
+	      ((axnet_dev_t *)(link->priv))->node.dev_name);
 	link->state |= DEV_STALE_CONFIG;
 	return;
     }
@@ -604,7 +605,7 @@
 	    CardServices(RequestConfiguration, link->handle, &link->conf);
 	    if (link->open) {
 		axnet_reset_8390(&info->dev);
-		NS8390_init(&info->dev, 1);
+		AX88190_init(&info->dev, 1);
 		netif_device_attach(&info->dev);
 	    }
 	}
@@ -694,7 +695,7 @@
     info->watchdog.expires = jiffies + HZ;
     add_timer(&info->watchdog);
 
-    return ei_open(dev);
+    return ax_open(dev);
 } /* axnet_open */
 
 /*====================================================================*/
@@ -706,11 +707,11 @@
 
     DEBUG(2, "axnet_close('%s')\n", dev->name);
 
+    ax_close(dev);
     free_irq(dev->irq, dev);
     
     link->open--;
     netif_stop_queue(dev);
-    netif_mark_down(dev);
     del_timer(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
@@ -757,7 +758,7 @@
 {
     axnet_dev_t *info = dev_id;
     info->stale = 0;
-    ei_interrupt(irq, dev_id, regs);
+    ax_interrupt(irq, dev_id, regs);
 }
 
 static void ei_watchdog(u_long arg)
@@ -809,7 +810,7 @@
 	    else
 		printk(KERN_INFO "%s: link partner did not autonegotiate\n",
 		       dev->name);
-	    NS8390_init(dev, 1);
+	    AX88190_init(dev, 1);
 	}
 	info->link_status = link;
     }
@@ -819,27 +820,6 @@
     add_timer(&info->watchdog);
 }
 
-static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
-{
-    u32 ethcmd;
-
-    if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
-	return -EFAULT;
-
-    switch (ethcmd) {
-    case ETHTOOL_GDRVINFO: {
-	struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
-
-	strncpy(info.driver, "axnet_cs", sizeof(info.driver)-1);
-	if (copy_to_user(useraddr, &info, sizeof(info)))
-	    return -EFAULT;
-	return 0;
-    }
-    }
-
-    return -EOPNOTSUPP;
-}
-
 /*====================================================================*/
 
 static int axnet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
@@ -848,8 +828,6 @@
     u16 *data = (u16 *)&rq->ifr_data;
     ioaddr_t mii_addr = dev->base_addr + AXNET_MII_EEP;
     switch (cmd) {
-    case SIOCETHTOOL:
-	return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
     case SIOCDEVPRIVATE:
 	data[0] = info->phy_id;
     case SIOCDEVPRIVATE+1:
@@ -940,7 +918,7 @@
     if (serv.Revision != CS_RELEASE_CODE) {
 	printk(KERN_NOTICE "axnet_cs: Card Services release "
 	       "does not match!\n");
-	return -1;
+	return -EINVAL;
     }
     register_pccard_driver(&dev_info, &axnet_attach, &axnet_detach);
     return 0;
@@ -969,10 +947,11 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
-  
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
   This is the chip-specific code for many 8390-based ethernet adaptors.
   This is not a complete driver, it must be combined with board-specific
   code such as ne.c, wd.c, 3c503.c, etc.
@@ -982,7 +961,6 @@
   a simple innocent change. Please contact me or Donald if you think
   you have found something that needs changing. -- PG
 
-
   Changelog:
 
   Paul Gortmaker	: remove set_bit lock, other cleanups.
@@ -1006,8 +984,8 @@
 
   */
 
-static const char *version =
-    "8390.c:v1.10cvs 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+static const char *version_8390 =
+    "8390.c:v1.10cvs 9/23/94 Donald Becker (becker@scyld.com)\n";
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -1087,25 +1065,23 @@
  *	them.
  */
  
-
-
 /**
- * ei_open - Open/initialize the board.
+ * ax_open - Open/initialize the board.
  * @dev: network device to initialize
  *
  * This routine goes all-out, setting everything
  * up anew at each open, even though many of these registers should only
  * need to be set once at boot.
  */
-static int ei_open(struct net_device *dev)
+static int ax_open(struct net_device *dev)
 {
 	unsigned long flags;
 	struct ei_device *ei_local = (struct ei_device *) dev->priv;
 
-	/* This can't happen unless somebody forgot to call ethdev_init(). */
+	/* This can't happen unless somebody forgot to call axdev_init(). */
 	if (ei_local == NULL) 
 	{
-		printk(KERN_EMERG "%s: ei_open passed a non-existent device!\n", dev->name);
+		printk(KERN_EMERG "%s: ax_open passed a non-existent device!\n", dev->name);
 		return -ENXIO;
 	}
 
@@ -1124,35 +1100,36 @@
 	 */
       
       	spin_lock_irqsave(&ei_local->page_lock, flags);
-	NS8390_init(dev, 1);
+	AX88190_init(dev, 1);
 	/* Set the flag before we drop the lock, That way the IRQ arrives
 	   after its set and we get no silly warnings */
-	netif_mark_up(dev);
 	netif_start_queue(dev);
       	spin_unlock_irqrestore(&ei_local->page_lock, flags);
 	ei_local->irqlock = 0;
 	return 0;
 }
 
+#define dev_lock(dev) (((struct ei_device *)(dev)->priv)->page_lock)
+
 /**
- * ei_close - shut down network device
+ * ax_close - shut down network device
  * @dev: network device to close
  *
- * Opposite of ei_open(). Only used when "ifconfig <devname> down" is done.
+ * Opposite of ax_open(). Only used when "ifconfig <devname> down" is done.
  */
-static int ei_close(struct net_device *dev)
+int ax_close(struct net_device *dev)
 {
-	unsigned long flags;
+        unsigned long flags;
 
-	/*
-	 *	Hold the page lock during close
-	 */
-
-	spin_lock_irqsave(&((struct ei_device *)dev->priv)->page_lock, flags);
-	NS8390_init(dev, 0);
-	spin_unlock_irqrestore(&((struct ei_device *)dev->priv)->page_lock, flags);
-	netif_stop_queue(dev);
-	return 0;
+        /*
+         *      Hold the page lock during close
+         */
+
+	spin_lock_irqsave(&dev_lock(dev), flags);
+        AX88190_init(dev, 0);
+	spin_unlock_irqrestore(&dev_lock(dev), flags);
+        netif_stop_queue(dev);
+        return 0;
 }
 
 /**
@@ -1194,7 +1171,7 @@
 		
 	/* Try to restart the card.  Perhaps the user has fixed something. */
 	ei_reset_8390(dev);
-	NS8390_init(dev, 1);
+	AX88190_init(dev, 1);
 		
 	spin_unlock(&ei_local->page_lock);
 	enable_irq(dev->irq);
@@ -1217,7 +1194,6 @@
 	unsigned long flags;
 
 	netif_stop_queue(dev);
-	skb_tx_check(dev, skb);
 
 	length = skb->len;
 
@@ -1230,7 +1206,6 @@
 	outb_p(0x00, e8390_base + EN0_IMR);
 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
 	
-	
 	/*
 	 *	Slow phase with lock held.
 	 */
@@ -1243,8 +1218,6 @@
 
 	send_length = ETH_ZLEN < length ? length : ETH_ZLEN;
     
-#ifdef EI_PINGPONG
-
 	/*
 	 * We have two Tx slots available for use. Find the first free
 	 * slot, and then perform some sanity checks. With two Tx bufs,
@@ -1313,22 +1286,6 @@
 	else
 		netif_start_queue(dev);
 
-#else	/* EI_PINGPONG */
-
-	/*
-	 * Only one Tx buffer in use. You need two Tx bufs to come close to
-	 * back-to-back transmits. Expect a 20 -> 25% performance hit on
-	 * reasonable hardware if you only use one Tx buffer.
-	 */
-
-	ei_block_output(dev, length, skb->data, ei_local->tx_start_page);
-	ei_local->txing = 1;
-	NS8390_trigger_send(dev, send_length, ei_local->tx_start_page);
-	dev->trans_start = jiffies;
-	netif_stop_queue(dev);
-
-#endif	/* EI_PINGPONG */
-
 	/* Turn 8390 interrupts back on. */
 	ei_local->irqlock = 0;
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
@@ -1336,14 +1293,14 @@
 	spin_unlock(&ei_local->page_lock);
 	enable_irq(dev->irq);
 
-	DEV_KFREE_SKB (skb);
-	add_tx_bytes(&ei_local->stat, send_length);
+	dev_kfree_skb (skb);
+	ei_local->stat.tx_bytes += send_length;
     
 	return 0;
 }
 
 /**
- * ei_interrupt - handle the interrupts from an 8390
+ * ax_interrupt - handle the interrupts from an 8390
  * @irq: interrupt number
  * @dev_id: a pointer to the net_device
  * @regs: unused
@@ -1355,7 +1312,7 @@
  * needed.
  */
 
-static void ei_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+static void ax_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct net_device *dev = dev_id;
 	long e8390_base;
@@ -1522,8 +1479,6 @@
 	struct ei_device *ei_local = (struct ei_device *) dev->priv;
 	int status = inb(e8390_base + EN0_TSR);
     
-#ifdef EI_PINGPONG
-
 	/*
 	 * There are two Tx buffers, see which one finished, and trigger
 	 * the send of another one if it exists.
@@ -1566,13 +1521,6 @@
 //	else printk(KERN_WARNING "%s: unexpected TX-done interrupt, lasttx=%d.\n",
 //			dev->name, ei_local->lasttx);
 
-#else	/* EI_PINGPONG */
-	/*
-	 *  Single Tx buffer: mark it free so another packet can be loaded.
-	 */
-	ei_local->txing = 0;
-#endif
-
 	/* Minimize Tx latency: update the statistics after we restart TXing. */
 	if (status & ENTSR_COL)
 		ei_local->stat.collisions++;
@@ -1680,7 +1628,7 @@
 				netif_rx(skb);
 				dev->last_rx = jiffies;
 				ei_local->stat.rx_packets++;
-				add_rx_bytes(&ei_local->stat, pkt_len);
+				ei_local->stat.rx_bytes += pkt_len;
 				if (pkt_stat & ENRSR_PHY)
 					ei_local->stat.multicast++;
 			}
@@ -1826,11 +1774,11 @@
 	long e8390_base = dev->base_addr;
 
   	if(dev->flags&IFF_PROMISC)
-  		outb_p(E8390_RXCONFIG | 0x18, e8390_base + EN0_RXCR);
+  		outb_p(E8390_RXCONFIG | 0x58, e8390_base + EN0_RXCR);
 	else if(dev->flags&IFF_ALLMULTI || dev->mc_list)
-  		outb_p(E8390_RXCONFIG | 0x08, e8390_base + EN0_RXCR);
+  		outb_p(E8390_RXCONFIG | 0x48, e8390_base + EN0_RXCR);
   	else
-  		outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR);
+  		outb_p(E8390_RXCONFIG | 0x40, e8390_base + EN0_RXCR);
 }
 
 /*
@@ -1838,28 +1786,28 @@
  *	be parallel to just about everything else. Its also fairly quick and
  *	not called too often. Must protect against both bh and irq users
  */
- 
+
 static void set_multicast_list(struct net_device *dev)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&((struct ei_device *)dev->priv)->page_lock, flags);
+	spin_lock_irqsave(&dev_lock(dev), flags);
 	do_set_multicast_list(dev);
-	spin_unlock_irqrestore(&((struct ei_device *)dev->priv)->page_lock, flags);
+	spin_unlock_irqrestore(&dev_lock(dev), flags);
 }	
 
 /**
- * ethdev_init - init rest of 8390 device struct
+ * axdev_init - init rest of 8390 device struct
  * @dev: network device structure to init
  *
  * Initialize the rest of the 8390 device structure.  Do NOT __init
  * this, as it is used by 8390 based modular drivers too.
  */
 
-static int ethdev_init(struct net_device *dev)
+static int axdev_init(struct net_device *dev)
 {
 	if (ei_debug > 1)
-		printk(version);
+		printk(version_8390);
     
 	if (dev->priv == NULL) 
 	{
@@ -1882,20 +1830,18 @@
 	return 0;
 }
 
-
-
 /* This page of functions should be 8390 generic */
 /* Follow National Semi's recommendations for initializing the "NIC". */
 
 /**
- * NS8390_init - initialize 8390 hardware
+ * AX88190_init - initialize 8390 hardware
  * @dev: network device to initialize
  * @startp: boolean.  non-zero value to initiate chip processing
  *
  *	Must be called with lock held.
  */
 
-static void NS8390_init(struct net_device *dev, int startp)
+static void AX88190_init(struct net_device *dev, int startp)
 {
 	axnet_dev_t *info = (axnet_dev_t *)dev;
 	long e8390_base = dev->base_addr;
@@ -1912,7 +1858,7 @@
 	outb_p(0x00,  e8390_base + EN0_RCNTLO);
 	outb_p(0x00,  e8390_base + EN0_RCNTHI);
 	/* Set to monitor and loopback mode -- this is vital!. */
-	outb_p(E8390_RXOFF, e8390_base + EN0_RXCR); /* 0x20 */
+	outb_p(E8390_RXOFF|0x40, e8390_base + EN0_RXCR); /* 0x60 */
 	outb_p(E8390_TXOFF, e8390_base + EN0_TXCR); /* 0x02 */
 	/* Set the transmit page and receive ring. */
 	outb_p(ei_local->tx_start_page, e8390_base + EN0_TPSR);
@@ -1956,7 +1902,7 @@
 		outb_p(E8390_TXCONFIG | info->duplex_flag,
 		       e8390_base + EN0_TXCR); /* xmit on. */
 		/* 3c503 TechMan says rxconfig only after the NIC is started. */
-		outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR); /* rx on,  */
+		outb_p(E8390_RXCONFIG | 0x40, e8390_base + EN0_RXCR); /* rx on, */
 		do_set_multicast_list(dev);	/* (re)load the mcast table */
 	}
 }
