Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTKJNuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTKJNuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:50:37 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49322 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263580AbTKJNuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:50:02 -0500
Date: Mon, 10 Nov 2003 19:24:54 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: lkcd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, suparna@in.ibm.com
Subject: LKCD Network dump over netpoll patch (2.6.0-test9)
Message-ID: <20031110135454.GH1409@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch includes LKCD networkdump code changes over netpoll API's for 
kernel version 2.6.0-test9. Both the netconsole and network dumping can be 
achieved. Procedure for netdumping is explained below:

1. Apply the netpoll-core.patch and netconsole.patch (http://www.selenic.com/netpoll/)
2. Download the LKCD code from the cvs using
	cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/lkcd login (presee enter key for passwd)
 
	cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/lkcd co 2.6  
	cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/lkcd co lkcdutils 

3. Copy the lkcd files to the kernel source directory.
	#cp -r ../2.6/* ./linux-2.6-test9/
4. Apply the kernel-changes.patch from the 2.6/patches directory.
5. Apply the pollcontroller.patch from the 2.6/patches 
	directory now.
6. Apply the lkcd-netpoll.patch(below)
7. Buid the kernel with LKCD network dumping enabled ;reboot and insert the dump_netdev.o module.

8. You also need to install and setup the lkcdutils.
	#./configure; make ; make install.
	#cd netdump
	#make; make install.
9. Configure the netdump fileds in the /etc/sysconfig/dump file.
	#you need to specify the local port,remote port, local ip, target ip and device name for netdump. 
	eg :	DUMP_ACTIVE=1
		DUMPDEV=eth0
		DUMPDIR=/var/log/dump
		DUMP_SAVE=1
		DUMP_LEVEL=2
		DUMP_FLAGS=0x40000000 
		DUMP_COMPRESS=0
		PANIC_TIMEOUT=5

		TARGET_HOST=9.182.14.40 #h set this to vaild hostname/IP
		TARGET_PORT=6688
		SOURCE_PORT=6688
		ETH_ADDRESS=00:07:95:E6:08:FB

10. Run lkcd config and now you can try test dumps..


diff -urNp linux.orig/drivers/net/3c59x.c linux-2.6.0-test9/drivers/net/3c59x.c
--- linux.orig/drivers/net/3c59x.c	2003-11-11 06:14:48.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/3c59x.c	2003-11-11 06:15:54.386937760 +0530
@@ -900,6 +900,7 @@ static void set_rx_mode(struct net_devic
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
+static void vorboom_poll(struct net_device *dev);
 static struct ethtool_ops vortex_ethtool_ops;
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
@@ -1450,6 +1451,9 @@ static int __devinit vortex_probe1(struc
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &vorboom_poll;
+#endif
 	if (pdev) {
 		vp->pm_state_valid = 1;
  		pci_save_state(VORTEX_PCI(vp), vp->power_state);
@@ -2440,6 +2444,29 @@ handler_exit:
 	return IRQ_HANDLED;
 }
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void vorboom_poll (struct net_device *dev)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+
+	disable_irq(dev->irq);
+	if (vp->full_bus_master_tx)
+		boomerang_interrupt(dev->irq, dev, 0);
+	else
+		vortex_interrupt(dev->irq, dev, 0);
+	enable_irq(dev->irq);
+}
+
+#endif
+
+
 static int vortex_rx(struct net_device *dev)
 {
 	struct vortex_private *vp = (struct vortex_private *)dev->priv;
diff -urNp linux.orig/drivers/net/e100/e100_main.c linux-2.6.0-test9/drivers/net/e100/e100_main.c
--- linux.orig/drivers/net/e100/e100_main.c	2003-11-11 06:14:48.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/e100/e100_main.c	2003-11-11 06:15:54.398935936 +0530
@@ -539,6 +539,22 @@ e100_trigger_SWI(struct e100_private *bd
 	readw(&(bdp->scb->scb_status));	/* flushes last write, read-safe */
 }
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void
+e100_poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	e100intr(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 static int __devinit
 e100_found1(struct pci_dev *pcid, const struct pci_device_id *ent)
 {
@@ -557,6 +573,9 @@ e100_found1(struct pci_dev *pcid, const 
 
 	SET_MODULE_OWNER(dev);
 
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &e100_poll;
+#endif
 	if (first_time) {
 		first_time = false;
         	printk(KERN_NOTICE "%s - version %s\n",
diff -urNp linux.orig/drivers/net/e1000/e1000_main.c linux-2.6.0-test9/drivers/net/e1000/e1000_main.c
--- linux.orig/drivers/net/e1000/e1000_main.c	2003-11-11 06:14:48.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/e1000/e1000_main.c	2003-11-11 06:15:54.439929704 +0530
@@ -165,6 +165,7 @@ static void e1000_leave_82542_rst(struct
 static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
                                      struct e1000_rx_desc *rx_desc,
                                      struct sk_buff *skb);
+static void e1000_Poll(struct net_device *dev);
 static void e1000_tx_timeout(struct net_device *dev);
 static void e1000_tx_timeout_task(struct net_device *dev);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
@@ -442,6 +443,9 @@ e1000_probe(struct pci_dev *pdev,
 
 	adapter->bd_number = cards_found;
 
+#ifdef HAVE_POLL_CONTROLLER
+	netdev->poll_controller = &e1000_Poll;
+#endif
 	/* setup the private structure */
 
 	if((err = e1000_sw_init(adapter)))
@@ -2106,6 +2110,15 @@ e1000_intr(int irq, void *data, struct p
 		mod_timer(&adapter->watchdog_timer, jiffies);
 	}
 
+#ifdef HAVE_POLL_CONTROLLER
+static void e1000_Poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	e1000_intr(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 #ifdef CONFIG_E1000_NAPI
 	if(netif_rx_schedule_prep(netdev)) {
 
diff -urNp linux.orig/drivers/net/eepro100.c linux-2.6.0-test9/drivers/net/eepro100.c
--- linux.orig/drivers/net/eepro100.c	2003-11-11 06:14:49.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/eepro100.c	2003-11-11 06:15:54.455927272 +0530
@@ -543,6 +543,7 @@ static void speedo_refill_rx_buffers(str
 static int speedo_rx(struct net_device *dev);
 static void speedo_tx_buffer_gc(struct net_device *dev);
 static irqreturn_t speedo_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void poll_speedo (struct net_device *dev);
 static int speedo_close(struct net_device *dev);
 static struct net_device_stats *speedo_get_stats(struct net_device *dev);
 static int speedo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
@@ -885,6 +886,9 @@ static int __devinit speedo_found1(struc
 	dev->get_stats = &speedo_get_stats;
 	dev->set_multicast_list = &set_rx_mode;
 	dev->do_ioctl = &speedo_ioctl;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_speedo;
+#endif
 
 	if (register_netdevice(dev))
 		goto err_free_unlock;
@@ -1675,6 +1679,23 @@ static irqreturn_t speedo_interrupt(int 
 	return IRQ_RETVAL(handled);
 }
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_speedo (struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	speedo_interrupt (dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+
+#endif
+
 static inline struct RxFD *speedo_rx_alloc(struct net_device *dev, int entry)
 {
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
diff -urNp linux.orig/drivers/net/smc-ultra.c linux-2.6.0-test9/drivers/net/smc-ultra.c
--- linux.orig/drivers/net/smc-ultra.c	2003-11-11 06:14:49.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/smc-ultra.c	2003-11-11 06:15:54.466925600 +0530
@@ -122,6 +122,14 @@ MODULE_DEVICE_TABLE(isapnp, ultra_device
 #define ULTRA_IO_EXTENT 32
 #define EN0_ERWCNT		0x08	/* Early receive warning count. */
 
+
+static void ultra_poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	ei_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+
 /*	Probe for the Ultra.  This looks like a 8013 with the station
 	address PROM at I/O ports <base>+8 to <base>+13, with a checksum
 	following.
@@ -134,6 +142,9 @@ int __init ultra_probe(struct net_device
 
 	SET_MODULE_OWNER(dev);
 
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &ultra_poll;
+#endif
 	if (base_addr > 0x1ff)		/* Check a single specified location. */
 		return ultra_probe1(dev, base_addr);
 	else if (base_addr != 0)	/* Don't probe at all. */
diff -urNp linux.orig/drivers/net/tlan.c linux-2.6.0-test9/drivers/net/tlan.c
--- linux.orig/drivers/net/tlan.c	2003-11-11 06:14:49.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/tlan.c	2003-11-11 06:15:54.472924688 +0530
@@ -346,6 +346,8 @@ static int	TLan_EeSendByte( u16, u8, int
 static void	TLan_EeReceiveByte( u16, u8 *, int );
 static int	TLan_EeReadByte( struct net_device *, u8, u8 * );
 
+static void	TLan_Poll(struct net_device *);
+
 
 static void 
 TLan_StoreSKB( struct tlan_list_tag *tag, struct sk_buff *skb)
@@ -893,6 +895,9 @@ static int TLan_Init( struct net_device 
 	dev->get_stats = &TLan_GetStats;
 	dev->set_multicast_list = &TLan_SetMulticastList;
 	dev->do_ioctl = &TLan_ioctl;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &TLan_Poll;
+#endif
 	dev->tx_timeout = &TLan_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
@@ -1176,7 +1181,14 @@ static irqreturn_t TLan_HandleInterrupt(
 	return IRQ_HANDLED;
 } /* TLan_HandleInterrupts */
 
-
+#ifdef HAVE_POLL_CONTROLLER
+static void TLan_Poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	TLan_HandleInterrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
 
 
 	/***************************************************************
diff -urNp linux.orig/drivers/net/tulip/tulip_core.c linux-2.6.0-test9/drivers/net/tulip/tulip_core.c
--- linux.orig/drivers/net/tulip/tulip_core.c	2003-11-11 06:14:48.000000000 +0530
+++ linux-2.6.0-test9/drivers/net/tulip/tulip_core.c	2003-11-11 06:15:54.501920280 +0530
@@ -247,6 +247,7 @@ static void tulip_down(struct net_device
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+static void poll_tulip(struct net_device *dev);
 
 
 
@@ -1632,6 +1633,9 @@ static int __devinit tulip_init_one (str
 	dev->get_stats = tulip_get_stats;
 	dev->do_ioctl = private_ioctl;
 	dev->set_multicast_list = set_rx_mode;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_tulip;
+#endif
 
 	if (register_netdev(dev))
 		goto err_out_free_ring;
@@ -1789,6 +1793,24 @@ static void __devexit tulip_remove_one (
 }
 
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_tulip (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       tulip_interrupt (dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+
+#endif
+
+
 static struct pci_driver tulip_driver = {
 	.name		= DRV_NAME,
 	.id_table	= tulip_pci_tbl,
diff -urNp linux.orig/include/linux/netdevice.h linux-2.6.0-test9/include/linux/netdevice.h
--- linux.orig/include/linux/netdevice.h	2003-11-11 06:15:18.000000000 +0530
+++ linux-2.6.0-test9/include/linux/netdevice.h	2003-11-11 06:15:54.000000000 +0530
@@ -455,10 +455,10 @@ struct net_device
 #ifdef CONFIG_NETPOLL_RX
 	int			netpoll_rx;
 #endif
+#define HAVE_POLL_CONTROLLER
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	void                    (*poll_controller)(struct net_device *dev);
+       void                    (*poll_controller)(struct net_device *dev);
 #endif
-
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
 
diff -urNp linux.orig/net/core/dev.c linux-2.6.0-test9/net/core/dev.c
--- linux.orig/net/core/dev.c	2003-11-11 06:15:16.000000000 +0530
+++ linux-2.6.0-test9/net/core/dev.c	2003-11-11 06:17:09.000000000 +0530
@@ -1387,8 +1387,6 @@ int netif_rx(struct sk_buff *skb)
 	}
 #endif
 
-	if (!skb->stamp.tv_sec)
-		do_gettimeofday(&skb->stamp);
 
 	/*
 	 * The code is rearranged so that the path is the most
-- 
Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
