Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUHPPIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUHPPIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUHPPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:08:21 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:35168 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267681AbUHPPHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:07:33 -0400
Subject: [PATCH] 2.6.8 synclink.c replace syncppp with genhdlc
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092668849.2012.5.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Aug 2004 10:07:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace syncppp interface with generic HDLC interface.
Generic HDLC provides superset of syncppp function.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

 
--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.8/drivers/char/synclink.c	2004-08-11 15:28:14.000000000 -0500
+++ linux-2.6.8-mg1/drivers/char/synclink.c	2004-08-12 09:04:30.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.24 2004/06/03 14:50:09 paulkf Exp $
+ * $Id: synclink.c,v 4.28 2004/08/11 19:30:01 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -100,13 +100,10 @@
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
@@ -187,7 +184,6 @@
  */
  
 struct mgsl_struct {
-	void *if_ptr;	/* General purpose pointer (used by SPPP) */
 	int			magic;
 	int			flags;
 	int			count;		/* count of opens */
@@ -318,15 +314,13 @@
 	
 	struct	_input_signal_events	input_signal_events;
 
-	/* SPPP/Cisco HDLC device parts */
+	/* generic HDLC device parts */
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
 };
 
@@ -734,18 +728,12 @@
 
 int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-/* SPPP/HDLC stuff */
-static void mgsl_sppp_init(struct mgsl_struct *info);
-static void mgsl_sppp_delete(struct mgsl_struct *info);
-int mgsl_sppp_open(struct net_device *d);
-int mgsl_sppp_close(struct net_device *d);
-void mgsl_sppp_tx_timeout(struct net_device *d);
-int mgsl_sppp_tx(struct sk_buff *skb, struct net_device *d);
-void mgsl_sppp_rx_done(struct mgsl_struct *info, char *buf, int size);
-void mgsl_sppp_tx_done(struct mgsl_struct *info);
-int mgsl_sppp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
-struct net_device_stats *mgsl_net_stats(struct net_device *dev);
+#ifdef CONFIG_HDLC
+#define dev_to_port(D) (dev_to_hdlc(D)->priv)
+static void hdlcdev_tx_done(struct mgsl_struct *info);
+static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size);
+static int  hdlcdev_init(struct mgsl_struct *info);
+static void hdlcdev_exit(struct mgsl_struct *info);
 #endif
 
 /*
@@ -911,7 +899,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.24 $";
+static char *driver_version = "$Revision: 4.28 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -1289,9 +1277,9 @@
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP	
+#ifdef CONFIG_HDLC
 	if (info->netcount)
-		mgsl_sppp_tx_done(info);
+		hdlcdev_tx_done(info);
 	else 
 #endif
 	{
@@ -1352,12 +1340,12 @@
 			icount->dcd++;
 			if (status & MISCSTATUS_DCD) {
 				info->input_signal_events.dcd_up++;
-#ifdef CONFIG_SYNCLINK_SYNCPPP	
-				if (info->netcount)
-					sppp_reopen(info->netdev);
-#endif
 			} else
 				info->input_signal_events.dcd_down++;
+#ifdef CONFIG_HDLC	
+			if (info->netcount)
+				hdlc_set_carrier(status & MISCSTATUS_DCD, info->netdev);
+#endif
 		}
 		if (status & MISCSTATUS_CTS_LATCHED)
 		{
@@ -3592,7 +3580,7 @@
 cleanup:			
 	if (retval) {
 		if (tty->count == 1)
-			info->tty = NULL;/* tty layer will release tty struct */
+			info->tty = NULL; /* tty layer will release tty struct */
 		if(info->count)
 			info->count--;
 	}
@@ -4415,12 +4403,10 @@
 		     	info->max_frame_size );
 	}
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-#ifdef MODULE
-	if (info->dosyncppp)
-#endif
-		mgsl_sppp_init(info);
+#ifdef CONFIG_HDLC
+	hdlcdev_init(info);
 #endif
+
 }	/* end of mgsl_add_device() */
 
 /* mgsl_allocate_device()
@@ -4575,9 +4561,8 @@
 
 	info = mgsl_device_list;
 	while(info) {
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-		if (info->dosyncppp)
-			mgsl_sppp_delete(info);
+#ifdef CONFIG_HDLC
+		hdlcdev_exit(info);
 #endif
 		mgsl_release_resources(info);
 		tmp = info;
@@ -6750,9 +6735,12 @@
 				return_frame = 1;
 		}
 		framesize = 0;
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
 	} else
 		return_frame = 1;
@@ -6823,11 +6811,9 @@
 						*ptmp);
 			}
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-			if (info->netcount) {
-				/* pass frame to syncppp device */
-				mgsl_sppp_rx_done(info,info->intermediate_rxbuffer,framesize);
-			} 
+#ifdef CONFIG_HDLC
+			if (info->netcount)
+				hdlcdev_rx(info,info->intermediate_rxbuffer,framesize);
 			else
 #endif
 			{
@@ -7736,9 +7722,9 @@
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	
-#ifdef CONFIG_SYNCLINK_SYNCPPP
+#ifdef CONFIG_HDLC
 	if (info->netcount)
-		mgsl_sppp_tx_done(info);
+		hdlcdev_tx_done(info);
 	else
 #endif
 		mgsl_bh_transmit(info);
@@ -7819,79 +7805,125 @@
 	return usc_InReg( info, CCSR ) & BIT6 ? 1 : 0 ;
 }			  
 
-#ifdef CONFIG_SYNCLINK_SYNCPPP
-/* syncppp net device routines
+#ifdef CONFIG_HDLC
+
+/**
+ * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
+ * set encoding and frame check sequence (FCS) options
+ *
+ * dev       pointer to network device structure
+ * encoding  serial encoding setting
+ * parity    FCS setting
+ *
+ * returns 0 if success, otherwise error code
  */
-static void mgsl_setup(struct net_device *dev)
+static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
+			  unsigned short parity)
 {
-	dev->open = mgsl_sppp_open;
-	dev->stop = mgsl_sppp_close;
-	dev->hard_start_xmit = mgsl_sppp_tx;
-	dev->do_ioctl = mgsl_sppp_ioctl;
-	dev->get_stats = mgsl_net_stats;
-	dev->tx_timeout = mgsl_sppp_tx_timeout;
-	dev->watchdog_timeo = 10*HZ;
-}
+	struct mgsl_struct *info = dev_to_port(dev);
+	unsigned char  new_encoding;
+	unsigned short new_crctype;
 
-static void mgsl_sppp_init(struct mgsl_struct *info)
-{
-	struct net_device *d;
+	/* return error if TTY interface open */
+	if (info->count)
+		return -EBUSY;
 
-	sprintf(info->netname,"mgsl%d",info->line);
+	switch (encoding)
+	{
+	case ENCODING_NRZ:        new_encoding = HDLC_ENCODING_NRZ; break;
+	case ENCODING_NRZI:       new_encoding = HDLC_ENCODING_NRZI_SPACE; break;
+	case ENCODING_FM_MARK:    new_encoding = HDLC_ENCODING_BIPHASE_MARK; break;
+	case ENCODING_FM_SPACE:   new_encoding = HDLC_ENCODING_BIPHASE_SPACE; break;
+	case ENCODING_MANCHESTER: new_encoding = HDLC_ENCODING_BIPHASE_LEVEL; break;
+	default: return -EINVAL;
+	}
 
-	d = alloc_netdev(0, info->netname, mgsl_setup);
-	if (!d) {
-		printk(KERN_WARNING "%s: alloc_netdev failed.\n",
-						info->netname);
-		return;
+	switch (parity)
+	{
+	case PARITY_NONE:            new_crctype = HDLC_CRC_NONE; break;
+	case PARITY_CRC16_PR1_CCITT: new_crctype = HDLC_CRC_16_CCITT; break;
+	case PARITY_CRC32_PR1_CCITT: new_crctype = HDLC_CRC_32_CCITT; break;
+	default: return -EINVAL;
 	}
 
-	info->if_ptr = &info->pppdev;
-	info->netdev = info->pppdev.dev = d;
+	info->params.encoding = new_encoding;
+	info->params.crc_type = new_crctype;;
 
-	d->base_addr = info->io_base;
-	d->irq = info->irq_level;
-	d->dma = info->dma_level;
-	d->priv = info;
-
-	sppp_attach(&info->pppdev);
-	mgsl_setup(d);
-
-	if (register_netdev(d)) {
-		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
-		sppp_detach(info->netdev);
-		info->netdev = NULL;
-		free_netdev(d);
-		return;
-	}
+	/* if network interface up, reprogram hardware */
+	if (info->netcount)
+		mgsl_program_hw(info);
 
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_init()\n");	
+	return 0;
 }
 
-void mgsl_sppp_delete(struct mgsl_struct *info)
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
+	struct mgsl_struct *info = dev_to_port(dev);
+	struct net_device_stats *stats = hdlc_stats(dev);
+	unsigned long flags;
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_delete(%s)\n",info->netname);	
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
+	info->xmit_cnt = skb->len;
+	mgsl_load_tx_dma_buffer(info, skb->data, skb->len);
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
+	spin_lock_irqsave(&info->irq_spinlock,flags);
+	if (!info->tx_active)
+	 	usc_start_transmitter(info);
+	spin_unlock_irqrestore(&info->irq_spinlock,flags);
+
+	return 0;
 }
 
-int mgsl_sppp_open(struct net_device *d)
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
-	struct mgsl_struct *info = d->priv;
-	int err;
+	struct mgsl_struct *info = dev_to_port(dev);
+	int rc;
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_open(%s)\n",info->netname);	
+		printk("%s:hdlcdev_open(%s)\n",__FILE__,dev->name);
 
+	/* generic HDLC layer open processing */
+	if ((rc = hdlc_open(dev)))
+		return rc;
+
+	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->count != 0 || info->netcount != 0) {
-		printk(KERN_WARNING "%s: sppp_open returning busy\n", info->netname);
+		printk(KERN_WARNING "%s: hdlc_open returning busy\n", dev->name);
 		spin_unlock_irqrestore(&info->netlock, flags);
 		return -EBUSY;
 	}
@@ -7899,141 +7931,301 @@
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
 	mgsl_program_hw(info);
 
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
+	spin_lock_irqsave(&info->irq_spinlock, flags);
+	usc_get_serial_signals(info);
+	spin_unlock_irqrestore(&info->irq_spinlock, flags);
+	hdlc_set_carrier(info->serial_signals & SerialSignal_DCD, dev);
+
+	return 0;
 }
 
-void mgsl_sppp_tx_timeout(struct net_device *dev)
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
-	struct mgsl_struct *info = dev->priv;
+	struct mgsl_struct *info = dev_to_port(dev);
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_tx_timeout(%s)\n",info->netname);	
+		printk("%s:hdlcdev_close(%s)\n",__FILE__,dev->name);
 
-	info->netstats.tx_errors++;
-	info->netstats.tx_aborted_errors++;
+	netif_stop_queue(dev);
 
-	spin_lock_irqsave(&info->irq_spinlock,flags);
-	usc_stop_transmitter(info);
-	spin_unlock_irqrestore(&info->irq_spinlock,flags);
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
 
-int mgsl_sppp_tx(struct sk_buff *skb, struct net_device *dev)
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
-	struct mgsl_struct *info = dev->priv;
-	unsigned long flags;
+	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings new_line;
+	sync_serial_settings __user *line = ifr->ifr_settings.ifs_ifsu.sync;
+	struct mgsl_struct *info = dev_to_port(dev);
+	unsigned int flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_tx(%s)\n",info->netname);	
+		printk("%s:hdlcdev_ioctl(%s)\n",__FILE__,dev->name);
 
-	netif_stop_queue(dev);
+	/* return error if TTY interface open */
+	if (info->count)
+		return -EBUSY;
 
-	info->xmit_cnt = skb->len;
-	mgsl_load_tx_dma_buffer(info, skb->data, skb->len);
-	info->netstats.tx_packets++;
-	info->netstats.tx_bytes += skb->len;
-	dev_kfree_skb(skb);
+	if (cmd != SIOCWANDEV)
+		return hdlc_ioctl(dev, ifr, cmd);
 
-	dev->trans_start = jiffies;
+	switch(ifr->ifr_settings.type) {
+	case IF_GET_IFACE: /* return current sync_serial_settings */
 
-	spin_lock_irqsave(&info->irq_spinlock,flags);
-	if (!info->tx_active)
-	 	usc_start_transmitter(info);
-	spin_unlock_irqrestore(&info->irq_spinlock,flags);
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
+			mgsl_program_hw(info);
+		return 0;
+
+	default:
+		return hdlc_ioctl(dev, ifr, cmd);
+	}
 }
 
-int mgsl_sppp_close(struct net_device *d)
+/**
+ * called by network layer when transmit timeout is detected
+ *
+ * dev  pointer to network device structure
+ */
+static void hdlcdev_tx_timeout(struct net_device *dev)
 {
-	struct mgsl_struct *info = d->priv;
+	struct mgsl_struct *info = dev_to_port(dev);
+	struct net_device_stats *stats = hdlc_stats(dev);
 	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_close(%s)\n",info->netname);	
+		printk("hdlcdev_tx_timeout(%s)\n",dev->name);	
 
-	/* shutdown adapter and release resources */
-	shutdown(info);
+	stats->tx_errors++;
+	stats->tx_aborted_errors++;
+
+	spin_lock_irqsave(&info->irq_spinlock,flags);
+	usc_stop_transmitter(info);
+	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
-	/* allow syncppp to do close processing */
-	sppp_close(d);
-	netif_stop_queue(d);
+	netif_wake_queue(dev);
+}
 
-	spin_lock_irqsave(&info->netlock, flags);
-	info->netcount=0;
-	spin_unlock_irqrestore(&info->netlock, flags);
-	return 0;
+/**
+ * called by device driver when transmit completes
+ * reenable network layer transmit if stopped
+ *
+ * info  pointer to device instance information
+ */
+static void hdlcdev_tx_done(struct mgsl_struct *info)
+{
+	if (netif_queue_stopped(info->netdev))
+		netif_wake_queue(info->netdev);
 }
 
-void mgsl_sppp_rx_done(struct mgsl_struct *info, char *buf, int size)
+/**
+ * called by device driver when frame received
+ * pass frame to network layer
+ *
+ * info  pointer to device instance information
+ * buf   pointer to buffer contianing frame data
+ * size  count of data bytes in buf
+ */
+static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size)
 {
 	struct sk_buff *skb = dev_alloc_skb(size);
+	struct net_device *dev = info->netdev;
+	struct net_device_stats *stats = hdlc_stats(dev);
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_sppp_rx_done(%s)\n",info->netname);	
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
 
-void mgsl_sppp_tx_done(struct mgsl_struct *info)
-{
-	if (netif_queue_stopped(info->netdev))
-	    netif_wake_queue(info->netdev);
+	info->netdev->last_rx = jiffies;
 }
 
-struct net_device_stats *mgsl_net_stats(struct net_device *dev)
+/**
+ * called by device driver when adding device instance
+ * do generic HDLC initialization
+ *
+ * info  pointer to device instance information
+ *
+ * returns 0 if success, otherwise error code
+ */
+static int hdlcdev_init(struct mgsl_struct *info)
 {
-	struct mgsl_struct *info = dev->priv;
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("mgsl_net_stats(%s)\n",info->netname);	
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
+	dev->base_addr = info->io_base;
+	dev->irq       = info->irq_level;
+	dev->dma       = info->dma_level;
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
 
-int mgsl_sppp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+/**
+ * called by device driver when removing device instance
+ * do generic HDLC cleanup
+ *
+ * info  pointer to device instance information
+ */
+static void hdlcdev_exit(struct mgsl_struct *info)
 {
-	struct mgsl_struct *info = dev->priv;
-	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):mgsl_ioctl %s cmd=%08X\n", __FILE__,__LINE__,
-			info->netname, cmd );
-	return sppp_do_ioctl(dev, ifr, cmd);
+	unregister_hdlc_device(info->netdev);
+	free_netdev(info->netdev);
+	info->netdev = NULL;
 }
 
-#endif /* ifdef CONFIG_SYNCLINK_SYNCPPP */
+#endif /* CONFIG_HDLC */
+
 
 static int __devinit synclink_init_one (struct pci_dev *dev,
 					const struct pci_device_id *ent)



