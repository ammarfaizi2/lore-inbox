Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUHPPMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUHPPMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHPPMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:12:47 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:46688 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267686AbUHPPJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:09:42 -0400
Subject: [PATCH] 2.6.8 synclinkmp.c replace syncppp with genhdlc
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092668978.2012.8.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Aug 2004 10:09:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace syncppp interface with generic HDLC interface.
Generic HDLC provides superset of syncppp function.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

 
--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.8/drivers/char/synclinkmp.c	2004-08-11 15:28:14.000000000 -0500
+++ linux-2.6.8-mg1/drivers/char/synclinkmp.c	2004-08-12 09:04:36.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.22 2004/06/03 14:50:10 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.26 2004/08/11 19:30:02 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -67,13 +67,10 @@
 #include <asm/types.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
+#include <linux/hdlc.h>
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP_MODULE
-#define CONFIG_SYNCLINK_SYNCPPP 1
-#endif
-
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-#include <net/syncppp.h>
+#ifdef CONFIG_HDLC_MODULE
+#define CONFIG_HDLC 1
 #endif
 
 #define GET_USER(error,value,addr) error = get_user(value,addr)
@@ -284,12 +281,11 @@
 	int netcount;
 	int dosyncppp;
 	spinlock_t netlock;
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-	struct ppp_device pppdev;
-	char netname[10];
+
+#ifdef CONFIG_HDLC
 	struct net_device *netdev;
-	struct net_device_stats netstats;
 #endif
+
 } SLMP_INFO;
 
 #define MGSL_MAGIC 0x5401
@@ -361,12 +357,7 @@
 #define TMCS	0x64
 #define TEPR	0x65
 
-/*
- *  FIXME: DAR here clashed with asm-ppc/reg.h and asm-sh/.../dma.h
- */
-#undef DAR
 /* DMA Controller Register macros */
-#define DAR	0x80
 #define DARL	0x80
 #define DARH	0x81
 #define DARB	0x82
@@ -498,7 +489,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.22 $";
+static char *driver_version = "$Revision: 4.26 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -553,20 +544,12 @@
 static void unthrottle(struct tty_struct * tty);
 static void set_break(struct tty_struct *tty, int break_state);
 
-/* sppp support and callbacks */
-
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-static void sppp_init(SLMP_INFO *info);
-static void sppp_delete(SLMP_INFO *info);
-static void sppp_rx_done(SLMP_INFO *info, char *buf, int size);
-static void sppp_tx_done(SLMP_INFO *info);
-
-static int  sppp_cb_open(struct net_device *d);
-static int  sppp_cb_close(struct net_device *d);
-static int  sppp_cb_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
-static int  sppp_cb_tx(struct sk_buff *skb, struct net_device *dev);
-static void sppp_cb_tx_timeout(struct net_device *dev);
-static struct net_device_stats *sppp_cb_net_stats(struct net_device *dev);
+#ifdef CONFIG_HDLC
+#define dev_to_port(D) (dev_to_hdlc(D)->priv)
+static void hdlcdev_tx_done(SLMP_INFO *info);
+static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size);
+static int  hdlcdev_init(SLMP_INFO *info);
+static void hdlcdev_exit(SLMP_INFO *info);
 #endif
 
 /* ioctl handlers */
@@ -800,7 +783,7 @@
 cleanup:
 	if (retval) {
 		if (tty->count == 1)
-			info->tty = NULL;/* tty layer will release tty struct */
+			info->tty = NULL; /* tty layer will release tty struct */
 		if(info->count)
 			info->count--;
 	}
@@ -1627,79 +1610,125 @@
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-
-/* syncppp support and callbacks */
-
-static void cb_setup(struct net_device *dev)
-{
-	dev->open = sppp_cb_open;
-	dev->stop = sppp_cb_close;
-	dev->hard_start_xmit = sppp_cb_tx;
-	dev->do_ioctl = sppp_cb_ioctl;
-	dev->get_stats = sppp_cb_net_stats;
-	dev->tx_timeout = sppp_cb_tx_timeout;
-	dev->watchdog_timeo = 10*HZ;
-}
+#ifdef CONFIG_HDLC
 
-static void sppp_init(SLMP_INFO *info)
+/**
+ * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
+ * set encoding and frame check sequence (FCS) options
+ *
+ * dev       pointer to network device structure
+ * encoding  serial encoding setting
+ * parity    FCS setting
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
+			  unsigned short parity)
 {
-	struct net_device *d;
+	SLMP_INFO *info = dev_to_port(dev);
+	unsigned char  new_encoding;
+	unsigned short new_crctype;
 
-	sprintf(info->netname,"mgslm%dp%d",info->adapter_num,info->port_num);
+	/* return error if TTY interface open */
+	if (info->count)
+		return -EBUSY;
 
-	d = alloc_netdev(0, info->netname, cb_setup);
-	if (!d) {
-		printk(KERN_WARNING "%s: alloc_netdev failed.\n",
-						info->netname);
-		return;
+	switch (encoding)
+	{
+	case ENCODING_NRZ:        new_encoding = HDLC_ENCODING_NRZ; break;
+	case ENCODING_NRZI:       new_encoding = HDLC_ENCODING_NRZI_SPACE; break;
+	case ENCODING_FM_MARK:    new_encoding = HDLC_ENCODING_BIPHASE_MARK; break;
+	case ENCODING_FM_SPACE:   new_encoding = HDLC_ENCODING_BIPHASE_SPACE; break;
+	case ENCODING_MANCHESTER: new_encoding = HDLC_ENCODING_BIPHASE_LEVEL; break;
+	default: return -EINVAL;
 	}
 
-	info->if_ptr = &info->pppdev;
-	info->netdev = info->pppdev.dev = d;
-
-	d->irq = info->irq_level;
-	d->priv = info;
+	switch (parity)
+	{
+	case PARITY_NONE:            new_crctype = HDLC_CRC_NONE; break;
+	case PARITY_CRC16_PR1_CCITT: new_crctype = HDLC_CRC_16_CCITT; break;
+	case PARITY_CRC32_PR1_CCITT: new_crctype = HDLC_CRC_32_CCITT; break;
+	default: return -EINVAL;
+	}
 
-	sppp_attach(&info->pppdev);
-	cb_setup(d);
+	info->params.encoding = new_encoding;
+	info->params.crc_type = new_crctype;;
 
-	if (register_netdev(d)) {
-		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
-		sppp_detach(info->netdev);
-		info->netdev = NULL;
-		info->pppdev.dev = NULL;
-		free_netdev(d);
-		return;
-	}
+	/* if network interface up, reprogram hardware */
+	if (info->netcount)
+		program_hw(info);
 
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_init(%s)\n",info->netname);
+	return 0;
 }
 
-static void sppp_delete(SLMP_INFO *info)
+/**
+ * called by generic HDLC layer to send frame
+ *
+ * skb  socket buffer containing HDLC frame
+ * dev  pointer to network device structure
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	SLMP_INFO *info = dev_to_port(dev);
+	struct net_device_stats *stats = hdlc_stats(dev);
+	unsigned long flags;
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_delete(%s)\n",info->netname);
-	unregister_netdev(info->netdev);
-	sppp_detach(info->netdev);
-	free_netdev(info->netdev);
-	info->netdev = NULL;
-	info->pppdev.dev = NULL;
+		printk(KERN_INFO "%s:hdlc_xmit(%s)\n",__FILE__,dev->name);	
+
+	/* stop sending until this frame completes */
+	netif_stop_queue(dev);
+
+	/* copy data to device buffers */
+	info->tx_count = skb->len;
+	tx_load_dma_buffer(info, skb->data, skb->len);
+
+	/* update network statistics */
+	stats->tx_packets++;
+	stats->tx_bytes += skb->len;
+
+	/* done with socket buffer, so free it */
+	dev_kfree_skb(skb);
+
+	/* save start time for transmit timeout detection */
+	dev->trans_start = jiffies;
+
+	/* start hardware transmitter if necessary */
+	spin_lock_irqsave(&info->lock,flags);
+	if (!info->tx_active)
+	 	tx_start(info);
+	spin_unlock_irqrestore(&info->lock,flags);
+
+	return 0;
 }
 
-static int sppp_cb_open(struct net_device *d)
+/**
+ * called by network layer when interface enabled
+ * claim resources and initialize hardware
+ *
+ * dev  pointer to network device structure
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_open(struct net_device *dev)
 {
-	SLMP_INFO *info = d->priv;
-	int err;
+	SLMP_INFO *info = dev_to_port(dev);
+	int rc;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_cb_open(%s)\n",info->netname);
+		printk("%s:hdlcdev_open(%s)\n",__FILE__,dev->name);
+
+	/* generic HDLC layer open processing */
+	if ((rc = hdlc_open(dev)))
+		return rc;
 
+	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->count != 0 || info->netcount != 0) {
-		printk(KERN_WARNING "%s: sppp_cb_open returning busy\n", info->netname);
+		printk(KERN_WARNING "%s: hdlc_open returning busy\n", dev->name);
 		spin_unlock_irqrestore(&info->netlock, flags);
 		return -EBUSY;
 	}
@@ -1707,141 +1736,300 @@
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
-	if ((err = startup(info)) != 0)
-		goto open_fail;
-
-	/* allow syncppp module to do open processing */
-	if ((err = sppp_open(d)) != 0) {
-		shutdown(info);
-		goto open_fail;
+	if ((rc = startup(info)) != 0) {
+		spin_lock_irqsave(&info->netlock, flags);
+		info->netcount=0;
+		spin_unlock_irqrestore(&info->netlock, flags);
+		return rc;
 	}
 
+	/* assert DTR and RTS, apply hardware settings */
 	info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
 	program_hw(info);
 
-	d->trans_start = jiffies;
-	netif_start_queue(d);
-	return 0;
+	/* enable network layer transmit */
+	dev->trans_start = jiffies;
+	netif_start_queue(dev);
 
-open_fail:
-	spin_lock_irqsave(&info->netlock, flags);
-	info->netcount=0;
-	spin_unlock_irqrestore(&info->netlock, flags);
-	return err;
+	/* inform generic HDLC layer of current DCD status */
+	spin_lock_irqsave(&info->lock, flags);
+	get_signals(info);
+	spin_unlock_irqrestore(&info->lock, flags);
+	hdlc_set_carrier(info->serial_signals & SerialSignal_DCD, dev);
+
+	return 0;
 }
 
-static void sppp_cb_tx_timeout(struct net_device *dev)
+/**
+ * called by network layer when interface is disabled
+ * shutdown hardware and release resources
+ *
+ * dev  pointer to network device structure
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_close(struct net_device *dev)
 {
-	SLMP_INFO *info = dev->priv;
+	SLMP_INFO *info = dev_to_port(dev);
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_tx_timeout(%s)\n",info->netname);
+		printk("%s:hdlcdev_close(%s)\n",__FILE__,dev->name);
 
-	info->netstats.tx_errors++;
-	info->netstats.tx_aborted_errors++;
+	netif_stop_queue(dev);
 
-	spin_lock_irqsave(&info->lock,flags);
-	tx_stop(info);
-	spin_unlock_irqrestore(&info->lock,flags);
+	/* shutdown adapter and release resources */
+	shutdown(info);
 
-	netif_wake_queue(dev);
+	hdlc_close(dev);
+
+	spin_lock_irqsave(&info->netlock, flags);
+	info->netcount=0;
+	spin_unlock_irqrestore(&info->netlock, flags);
+
+	return 0;
 }
 
-static int sppp_cb_tx(struct sk_buff *skb, struct net_device *dev)
+/**
+ * called by network layer to process IOCTL call to network device
+ *
+ * dev  pointer to network device structure
+ * ifr  pointer to network interface request structure
+ * cmd  IOCTL command code
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	SLMP_INFO *info = dev->priv;
-	unsigned long flags;
+	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings new_line;
+	sync_serial_settings __user *line = ifr->ifr_settings.ifs_ifsu.sync;
+	SLMP_INFO *info = dev_to_port(dev);
+	unsigned int flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_tx(%s)\n",info->netname);
+		printk("%s:hdlcdev_ioctl(%s)\n",__FILE__,dev->name);
 
-	netif_stop_queue(dev);
+	/* return error if TTY interface open */
+	if (info->count)
+		return -EBUSY;
 
-	info->tx_count = skb->len;
-	tx_load_dma_buffer(info, skb->data, skb->len);
-	info->netstats.tx_packets++;
-	info->netstats.tx_bytes += skb->len;
-	dev_kfree_skb(skb);
+	if (cmd != SIOCWANDEV)
+		return hdlc_ioctl(dev, ifr, cmd);
 
-	dev->trans_start = jiffies;
+	switch(ifr->ifr_settings.type) {
+	case IF_GET_IFACE: /* return current sync_serial_settings */
 
-	spin_lock_irqsave(&info->lock,flags);
-	if (!info->tx_active)
-	 	tx_start(info);
-	spin_unlock_irqrestore(&info->lock,flags);
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
 
-	return 0;
+		flags = info->params.flags & (HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_RXC_DPLL |
+					      HDLC_FLAG_RXC_BRG    | HDLC_FLAG_RXC_TXCPIN |
+					      HDLC_FLAG_TXC_TXCPIN | HDLC_FLAG_TXC_DPLL |
+					      HDLC_FLAG_TXC_BRG    | HDLC_FLAG_TXC_RXCPIN);
+
+		switch (flags){
+		case (HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_TXCPIN): new_line.clock_type = CLOCK_EXT; break;
+		case (HDLC_FLAG_RXC_BRG    | HDLC_FLAG_TXC_BRG):    new_line.clock_type = CLOCK_INT; break;
+		case (HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_BRG):    new_line.clock_type = CLOCK_TXINT; break;
+		case (HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_RXCPIN): new_line.clock_type = CLOCK_TXFROMRX; break;
+		default: new_line.clock_type = CLOCK_DEFAULT;
+		}
+
+		new_line.clock_rate = info->params.clock_speed;
+		new_line.loopback   = info->params.loopback ? 1:0;
+
+		if (copy_to_user(line, &new_line, size))
+			return -EFAULT;
+		return 0;
+
+	case IF_IFACE_SYNC_SERIAL: /* set sync_serial_settings */
+
+		if(!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (copy_from_user(&new_line, line, size))
+			return -EFAULT;
+
+		switch (new_line.clock_type)
+		{
+		case CLOCK_EXT:      flags = HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_TXCPIN; break;
+		case CLOCK_TXFROMRX: flags = HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_RXCPIN; break;
+		case CLOCK_INT:      flags = HDLC_FLAG_RXC_BRG    | HDLC_FLAG_TXC_BRG;    break;
+		case CLOCK_TXINT:    flags = HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_TXC_BRG;    break;
+		case CLOCK_DEFAULT:  flags = info->params.flags &
+					     (HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_RXC_DPLL |
+					      HDLC_FLAG_RXC_BRG    | HDLC_FLAG_RXC_TXCPIN |
+					      HDLC_FLAG_TXC_TXCPIN | HDLC_FLAG_TXC_DPLL |
+					      HDLC_FLAG_TXC_BRG    | HDLC_FLAG_TXC_RXCPIN); break;
+		default: return -EINVAL;
+		}
+
+		if (new_line.loopback != 0 && new_line.loopback != 1)
+			return -EINVAL;
+
+		info->params.flags &= ~(HDLC_FLAG_RXC_RXCPIN | HDLC_FLAG_RXC_DPLL |
+					HDLC_FLAG_RXC_BRG    | HDLC_FLAG_RXC_TXCPIN |
+					HDLC_FLAG_TXC_TXCPIN | HDLC_FLAG_TXC_DPLL |
+					HDLC_FLAG_TXC_BRG    | HDLC_FLAG_TXC_RXCPIN);
+		info->params.flags |= flags;
+
+		info->params.loopback = new_line.loopback;
+
+		if (flags & (HDLC_FLAG_RXC_BRG | HDLC_FLAG_TXC_BRG))
+			info->params.clock_speed = new_line.clock_rate;
+		else
+			info->params.clock_speed = 0;
+
+		/* if network interface up, reprogram hardware */
+		if (info->netcount)
+			program_hw(info);
+		return 0;
+
+	default:
+		return hdlc_ioctl(dev, ifr, cmd);
+	}
 }
 
-static int sppp_cb_close(struct net_device *d)
+/**
+ * called by network layer when transmit timeout is detected
+ *
+ * dev  pointer to network device structure
+ */
+static void hdlcdev_tx_timeout(struct net_device *dev)
 {
-	SLMP_INFO *info = d->priv;
+	SLMP_INFO *info = dev_to_port(dev);
+	struct net_device_stats *stats = hdlc_stats(dev);
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_cb_close(%s)\n",info->netname);
+		printk("hdlcdev_tx_timeout(%s)\n",dev->name);	
 
-	/* shutdown adapter and release resources */
-	shutdown(info);
+	stats->tx_errors++;
+	stats->tx_aborted_errors++;
 
-	/* allow syncppp to do close processing */
-	sppp_close(d);
-	netif_stop_queue(d);
+	spin_lock_irqsave(&info->lock,flags);
+	tx_stop(info);
+	spin_unlock_irqrestore(&info->lock,flags);
 
-	spin_lock_irqsave(&info->netlock, flags);
-	info->netcount=0;
-	spin_unlock_irqrestore(&info->netlock, flags);
-	return 0;
+	netif_wake_queue(dev);
 }
 
-static void sppp_rx_done(SLMP_INFO *info, char *buf, int size)
+/**
+ * called by device driver when transmit completes
+ * reenable network layer transmit if stopped
+ *
+ * info  pointer to device instance information
+ */
+static void hdlcdev_tx_done(SLMP_INFO *info)
+{
+	if (netif_queue_stopped(info->netdev))
+		netif_wake_queue(info->netdev);
+}
+
+/**
+ * called by device driver when frame received
+ * pass frame to network layer
+ *
+ * info  pointer to device instance information
+ * buf   pointer to buffer contianing frame data
+ * size  count of data bytes in buf
+ */
+static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size)
 {
 	struct sk_buff *skb = dev_alloc_skb(size);
+	struct net_device *dev = info->netdev;
+	struct net_device_stats *stats = hdlc_stats(dev);
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("sppp_rx_done(%s)\n",info->netname);
+		printk("hdlcdev_rx(%s)\n",dev->name);
+
 	if (skb == NULL) {
-		printk(KERN_NOTICE "%s: can't alloc skb, dropping packet\n",
-			info->netname);
-		info->netstats.rx_dropped++;
+		printk(KERN_NOTICE "%s: can't alloc skb, dropping packet\n", dev->name);
+		stats->rx_dropped++;
 		return;
 	}
 
 	memcpy(skb_put(skb, size),buf,size);
 
-	skb->protocol = htons(ETH_P_WAN_PPP);
-	skb->dev = info->netdev;
-	skb->mac.raw = skb->data;
-	info->netstats.rx_packets++;
-	info->netstats.rx_bytes += size;
+	skb->dev      = info->netdev;
+	skb->mac.raw  = skb->data;
+	skb->protocol = hdlc_type_trans(skb, skb->dev);
+
+	stats->rx_packets++;
+	stats->rx_bytes += size;
+
 	netif_rx(skb);
-	info->netdev->trans_start = jiffies;
-}
 
-static void sppp_tx_done(SLMP_INFO *info)
-{
-	if (netif_queue_stopped(info->netdev))
-	    netif_wake_queue(info->netdev);
+	info->netdev->last_rx = jiffies;
 }
 
-static struct net_device_stats *sppp_cb_net_stats(struct net_device *dev)
+/**
+ * called by device driver when adding device instance
+ * do generic HDLC initialization
+ *
+ * info  pointer to device instance information
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_init(SLMP_INFO *info)
 {
-	SLMP_INFO *info = dev->priv;
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("net_stats(%s)\n",info->netname);
-	return &info->netstats;
+	int rc;
+	struct net_device *dev;
+	hdlc_device *hdlc;
+
+	/* allocate and initialize network and HDLC layer objects */
+
+	if (!(dev = alloc_hdlcdev(info))) {
+		printk(KERN_ERR "%s:hdlc device allocation failure\n",__FILE__);
+		return -ENOMEM;
+	}
+
+	/* for network layer reporting purposes only */
+	dev->mem_start = info->phys_sca_base;
+	dev->mem_end   = info->phys_sca_base + SCA_BASE_SIZE - 1;
+	dev->irq       = info->irq_level;
+
+	/* network layer callbacks and settings */
+	dev->do_ioctl       = hdlcdev_ioctl;
+	dev->open           = hdlcdev_open;
+	dev->stop           = hdlcdev_close;
+	dev->tx_timeout     = hdlcdev_tx_timeout;
+	dev->watchdog_timeo = 10*HZ;
+	dev->tx_queue_len   = 50;
+
+	/* generic HDLC layer callbacks and settings */
+	hdlc         = dev_to_hdlc(dev);
+	hdlc->attach = hdlcdev_attach;
+	hdlc->xmit   = hdlcdev_xmit;
+
+	/* register objects with HDLC layer */
+	if ((rc = register_hdlc_device(dev))) {
+		printk(KERN_WARNING "%s:unable to register hdlc device\n",__FILE__);
+		free_netdev(dev);
+		return rc;
+	}
+
+	info->netdev = dev;
+	return 0;
 }
 
-static int sppp_cb_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+/**
+ * called by device driver when removing device instance
+ * do generic HDLC cleanup
+ *
+ * info  pointer to device instance information
+ */
+static void hdlcdev_exit(SLMP_INFO *info)
 {
-	SLMP_INFO *info = dev->priv;
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):ioctl %s cmd=%08X\n", __FILE__,__LINE__,
-			info->netname, cmd );
-	return sppp_do_ioctl(dev, ifr, cmd);
+	unregister_hdlc_device(info->netdev);
+	free_netdev(info->netdev);
+	info->netdev = NULL;
 }
 
-#endif /* ifdef CONFIG_SYNCLINK_SYNCPPP */
+#endif /* CONFIG_HDLC */
 
 
 /* Return next bottom half action to perform.
@@ -2168,9 +2356,9 @@
 			set_signals(info);
 		}
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
+#ifdef CONFIG_HDLC
 		if (info->netcount)
-			sppp_tx_done(info);
+			hdlcdev_tx_done(info);
 		else
 #endif
 		{
@@ -2358,12 +2546,12 @@
 			icount->dcd++;
 			if (status & SerialSignal_DCD) {
 				info->input_signal_events.dcd_up++;
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-				if (info->netcount)
-					sppp_reopen(info->netdev);
-#endif
 			} else
 				info->input_signal_events.dcd_down++;
+#ifdef CONFIG_HDLC	
+			if (info->netcount)
+				hdlc_set_carrier(status & SerialSignal_DCD, info->netdev);
+#endif
 		}
 		if (status & MISCSTATUS_CTS_LATCHED)
 		{
@@ -3616,9 +3804,8 @@
 		info->irq_level,
 		info->max_frame_size );
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-	if (info->dosyncppp)
-		sppp_init(info);
+#ifdef CONFIG_HDLC
+	hdlcdev_init(info);
 #endif
 }
 
@@ -3804,9 +3991,8 @@
 
 	info = synclinkmp_device_list;
 	while(info) {
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-		if (info->dosyncppp)
-			sppp_delete(info);
+#ifdef CONFIG_HDLC
+		hdlcdev_exit(info);
 #endif
 		reset_port(info);
 		if ( info->port_num == 0 ) {
@@ -4823,10 +5009,12 @@
 			info->icount.rxcrc++;
 
 		framesize = 0;
-
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-		info->netstats.rx_errors++;
-		info->netstats.rx_frame_errors++;
+#ifdef CONFIG_HDLC
+		{
+			struct net_device_stats *stats = hdlc_stats(info->netdev);
+			stats->rx_errors++;
+			stats->rx_frame_errors++;
+		}
 #endif
 	}
 
@@ -4862,11 +5050,9 @@
 					index = 0;
 			}
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-			if (info->netcount) {
-				/* pass frame to syncppp device */
-				sppp_rx_done(info,info->tmp_rx_buf,framesize);
-			}
+#ifdef CONFIG_HDLC
+			if (info->netcount)
+				hdlcdev_rx(info,info->tmp_rx_buf,framesize);
 			else
 #endif
 			{
@@ -5384,9 +5570,9 @@
 
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
+#ifdef CONFIG_HDLC
 	if (info->netcount)
-		sppp_tx_done(info);
+		hdlcdev_tx_done(info);
 	else
 #endif
 		bh_transmit(info);



