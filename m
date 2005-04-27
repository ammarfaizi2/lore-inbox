Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVD0ElG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVD0ElG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVD0ElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:41:05 -0400
Received: from [203.2.177.22] ([203.2.177.22]:64517 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261910AbVD0Ejn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:39:43 -0400
Subject: [PATCH] 2.6.11.7  X.25 : x25tap
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1114576764.4789.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 14:39:24 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2005 04:38:37.0125 (UTC) FILETIME=[FA3C5750:01C54AE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds an x25tap module, like ethertap for X.25.

This allows X.25 to be done in userspace, and in particular 
X.25 over TCP (XOT RFC1613) when used with a userspace 
XOT daemon.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.11.7-vanilla/drivers/net/Kconfig linux-2.6.11.7/drivers/net/Kconfig
--- linux-2.6.11.7-vanilla/drivers/net/Kconfig	2005-04-08 04:58:17.000000000 +1000
+++ linux-2.6.11.7/drivers/net/Kconfig	2005-04-15 12:32:42.000000000 +1000
@@ -128,6 +128,24 @@ config ETHERTAP
 
 	  If you don't know what to use this for, you don't need it.
 
+config X25TAP
+	tristate "X.25 network tap"
+	depends on NETDEVICES && EXPERIMENTAL && NETLINK_DEV && X25
+	---help---
+	  This is a very simple X.25 driver. It bounces X.25 level2 frames
+	  to user space and expects X.25 frames to be written back to it.
+
+	  Connection state handling is left to the user pluged into the tap
+	  as explained in Documentation/networking/x25-iface.txt
+
+	  As this is an X.25 level 2 device you can use it for user level
+	  drivers and for building bridging tunnels (XOT).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called x25tap.
+
+	  If your using xotd or similar program say N.
+
 config NET_SB1000
 	tristate "General Instruments Surfboard 1000"
 	depends on NETDEVICES && PNP
diff -uprN -X dontdiff linux-2.6.11.7-vanilla/drivers/net/Makefile linux-2.6.11.7/drivers/net/Makefile
--- linux-2.6.11.7-vanilla/drivers/net/Makefile	2005-04-08 04:57:27.000000000 +1000
+++ linux-2.6.11.7/drivers/net/Makefile	2005-04-15 12:33:04.000000000 +1000
@@ -69,6 +69,7 @@ obj-$(CONFIG_HAMACHI) += hamachi.o
 obj-$(CONFIG_NET) += Space.o loopback.o
 obj-$(CONFIG_SEEQ8005) += seeq8005.o
 obj-$(CONFIG_ETHERTAP) += ethertap.o
+obj-$(CONFIG_X25TAP) += x25tap.o
 obj-$(CONFIG_NET_SB1000) += sb1000.o
 obj-$(CONFIG_MAC8390) += mac8390.o 8390.o
 obj-$(CONFIG_APNE) += apne.o 8390.o
diff -uprN -X dontdiff linux-2.6.11.7-vanilla/drivers/net/x25tap.c linux-2.6.11.7/drivers/net/x25tap.c
--- linux-2.6.11.7-vanilla/drivers/net/x25tap.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.11.7/drivers/net/x25tap.c	2005-04-15 12:33:34.000000000 +1000
@@ -0,0 +1,331 @@
+/*
+ *	X.25: A network device for bouncing x.25 frames via user space
+ *
+ *	X.25tap is cloned from ethertap.
+ *
+ *	This is a very simple X.25 driver. It bounces X.25 frames
+ *	to user space on x25tapX and expects X.25 frames to be written
+ *	back to it.
+ *
+ *	As this is an X.25 level 2 device you can use it for user level drivers
+ *	even for building bridging tunnels (XOT).
+ *
+ *	Original version, August 1998 sfillod@charybde.gyptis.frmug.org
+ *	2.6 version, October 2004 ahendry@tusc.com.au
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+
+#include <net/sock.h>
+#include <linux/netlink.h>
+#include <linux/if_arp.h>
+
+/*
+ *	Index to functions.
+ */
+
+static int  x25tap_open(struct net_device *dev);
+static int  x25tap_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static int  x25tap_close(struct net_device *dev);
+static struct net_device_stats *x25tap_get_stats(struct net_device *dev);
+static void x25tap_rx(struct sock *sk, int len);
+
+static int x25tap_debug = 0;
+
+static int max_taps = 1;
+module_param(max_taps, int, 0);
+MODULE_PARM_DESC(max_taps,"Max number of x25 tap devices");
+
+static struct net_device **tap_map;	/* Returns the tap device for a given netlink */
+
+/*
+ *	Board-specific info in dev->priv.
+ */
+
+struct net_local
+{
+	struct sock	*nl;
+	struct net_device_stats stats;
+};
+
+/*
+ *	To call this a probe is a bit misleading, however for real
+ *	hardware it would have to check what was present.
+ */
+static int  __init x25tap_probe(int unit)
+{
+	struct net_device *dev;
+	int err = -ENOMEM;
+
+	dev = alloc_etherdev(sizeof(struct net_local));
+
+	if (!dev)
+		goto out;
+
+	SET_MODULE_OWNER(dev);
+
+	sprintf(dev->name, "x25tap%d", unit);
+	dev->base_addr = unit + NETLINK_TAPBASE;
+
+	netdev_boot_setup_check(dev);
+
+	memcpy(dev->dev_addr, "\xFE\xFD\x00\x00\x00\x00", 6);
+	if (dev->mem_start & 0xf)
+		x25tap_debug = dev->mem_start & 0x7;
+
+	/*
+	 *	The tap specific entries in the device structure.
+	 */
+
+	dev->open = x25tap_open;
+	dev->hard_start_xmit = x25tap_start_xmit;
+	dev->stop = x25tap_close;
+	dev->get_stats = x25tap_get_stats;
+
+	dev->flags|=IFF_NOARP;
+	dev->mtu = 1024;
+	dev->hard_header_len = 1;
+	dev->addr_len = 0;
+	dev->type = ARPHRD_X25;
+	dev->tx_queue_len = 10;
+
+	err = register_netdev(dev);
+	if (err)
+		goto out_free;
+
+	tap_map[unit]=dev;
+	return 0;
+out_free:
+	free_netdev(dev);
+out:
+	return err;
+}
+
+/*
+ *	Open/initialize the board.
+ */
+
+static int x25tap_open(struct net_device *dev)
+{
+	struct net_local *lp = netdev_priv(dev);
+
+	if (x25tap_debug > 2)
+		printk(KERN_DEBUG "%s: Doing x25tap_open()...\n", dev->name);
+
+	lp->nl = netlink_kernel_create(dev->base_addr, x25tap_rx);
+	if (lp->nl == NULL)
+		return -ENOBUFS;
+
+	netif_start_queue(dev);
+	return 0;
+}
+
+/*
+ *	We transmit by throwing the packet at netlink. We have to clone
+ *	it for 2.0 so that we dev_kfree_skb() the locked original.
+ */
+
+static int x25tap_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct net_local *lp = netdev_priv(dev);
+
+	/* Make the same thing, which loopback does. */
+	if (skb_shared(skb)) {
+	  	struct sk_buff *skb2 = skb;
+	  	skb = skb_clone(skb, GFP_ATOMIC);	/* Clone the buffer */
+	  	if (skb==NULL) {
+			dev_kfree_skb(skb2);
+			lp->stats.tx_dropped++;
+			return 0;
+		}
+	  	dev_kfree_skb(skb2);
+	}
+	switch (skb->data[0])
+	{
+		case 0x00:	/* Data request */
+			lp->stats.tx_bytes+=skb->len -1;
+			lp->stats.tx_packets++;
+			break;
+		case 0x01:	/* Connection request, do nothing */
+			if (x25tap_debug > 1)
+				printk(KERN_DEBUG "x25tap_start_xmit: "
+					"Connection request\n");
+			break;
+		case 0x02:	/* Disconnect request */
+			if (x25tap_debug > 1)
+				printk(KERN_DEBUG "x25tap_start_xmit: "
+					"Disconnect request\n");
+			break;
+		case 0x03:	/* changing lapb parameters requested */
+			printk(KERN_DEBUG "x25tap_start_xmit: setting of "
+				"options not supported\n");
+			break;
+		default:
+			printk(KERN_DEBUG "x25tap_start_xmit: "
+				"unknown firstbyte\n");
+			lp->stats.tx_dropped++;
+			kfree_skb(skb);
+			return -1;
+			break;
+	}
+
+	netlink_broadcast(lp->nl, skb, 0, ~0, GFP_ATOMIC);
+
+	return 0;
+}
+
+static __inline__ int x25tap_rx_skb(struct sk_buff *skb, struct net_device *dev)
+{
+	struct net_local *lp = netdev_priv(dev);
+	int len = skb->len;
+
+
+	if (len < 1) {
+		printk(KERN_DEBUG "%s : rx len = %d\n", dev->name, len);
+		kfree_skb(skb);
+		lp->stats.rx_errors++;
+		return -EINVAL;
+	}
+	if (NETLINK_CREDS(skb)->uid) {
+		printk(KERN_INFO "%s : user %d\n", dev->name, NETLINK_CREDS(skb)->uid);
+		kfree_skb(skb);
+		return -EPERM;
+	}
+
+	if (skb_shared(skb)) {
+	  	struct sk_buff *skb2 = skb;
+	  	skb = skb_clone(skb, GFP_KERNEL);	/* Clone the buffer */
+	  	if (skb==NULL) {
+			kfree_skb(skb2);
+			lp->stats.rx_dropped++;
+			return -ENOBUFS;
+		}
+	  	kfree_skb(skb2);
+	} else
+		skb_orphan(skb);
+
+	skb->dev = dev;
+	skb->protocol=htons(ETH_P_X25);
+	skb->mac.raw = skb->data;
+	skb->pkt_type = PACKET_HOST;
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	if (skb->data[0] == 0) {
+		lp->stats.rx_packets++;
+		lp->stats.rx_bytes+=len;
+	}
+
+	netif_rx(skb);
+	dev->last_rx = jiffies;
+	return len;
+}
+
+/*
+ *	The typical workload of the driver:
+ *	Handle the ether interface interrupts.
+ *
+ *	(In this case handle the packets posted from user space..)
+ */
+
+static void x25tap_rx(struct sock *sk, int len)
+{
+	unsigned unit = sk->sk_protocol - NETLINK_TAPBASE;
+	struct net_device *dev;
+	struct sk_buff *skb;
+
+	if (unit >= max_taps || (dev = tap_map[unit]) == NULL) {
+		printk(KERN_CRIT "x25tap: bad unit %u!\n", unit);
+		skb_queue_purge(&sk->sk_receive_queue);
+		return;
+	}
+
+	if (x25tap_debug > 3)
+		printk(KERN_DEBUG "%s: x25tap_rx() %d\n", dev->name, len);
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
+		x25tap_rx_skb(skb, dev);
+}
+
+static int x25tap_close(struct net_device *dev)
+{
+	struct net_local *lp = netdev_priv(dev);
+	struct sock *sk = lp->nl;
+
+	if (x25tap_debug > 2)
+		printk(KERN_DEBUG "%s: Shutting down.\n", dev->name);
+
+	netif_stop_queue(dev);
+
+	if (sk) {
+		lp->nl = NULL;
+		sock_release(sk->sk_socket);
+	}
+
+	return 0;
+}
+
+static struct net_device_stats *x25tap_get_stats(struct net_device *dev)
+{
+	struct net_local *lp = netdev_priv(dev);
+	return &lp->stats;
+}
+
+
+int __init x25tap_init(void)
+{
+	int i, err = 0;
+
+	/* netlink can only hande 16 entries unless modified */
+	if (max_taps > MAX_LINKS - NETLINK_TAPBASE)
+		return -E2BIG;
+
+	tap_map = kmalloc(sizeof(struct net_device *)*max_taps, GFP_KERNEL);
+	if (!tap_map)
+		return -ENOMEM;
+
+	for (i = 0; i < max_taps; i++) {
+		err = x25tap_probe(i);
+		if (err) {
+			while (--i > 0) {
+				unregister_netdev(tap_map[i]);
+				free_netdev(tap_map[i]);
+			}
+			break;
+		}
+	}
+	if (err)
+		kfree(tap_map);
+	return err;
+}
+module_init(x25tap_init);
+
+void __exit x25tap_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < max_taps; i++) {
+		struct net_device *dev = tap_map[i];
+		if (dev) {
+			tap_map[i] = NULL;
+			unregister_netdev(dev);
+			free_netdev(dev);
+		}
+	}
+	kfree(tap_map);
+}
+module_exit(x25tap_cleanup);
+
+MODULE_LICENSE("GPL");


