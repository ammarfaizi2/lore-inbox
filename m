Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272983AbSISU7E>; Thu, 19 Sep 2002 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273012AbSISU7E>; Thu, 19 Sep 2002 16:59:04 -0400
Received: from dsl-65-188-251-69.telocity.com ([65.188.251.69]:7328 "EHLO
	orr.homenet") by vger.kernel.org with ESMTP id <S272983AbSISU7C>;
	Thu, 19 Sep 2002 16:59:02 -0400
Date: Thu, 19 Sep 2002 17:03:48 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Donald Becker <becker@scyld.com>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>, edward_peng@dlink.com.tw
Subject: PATCH: sundance #5 (variable per-interface MTU support)
Message-ID: <20020919210348.GC17492@orr.falooley.org>
References: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com> <3D8A25D1.3060300@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <3D8A25D1.3060300@mandrakesoft.com>
User-Agent: Mutt/1.4i
From: Jason Lunz <lunz@falooley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This is a straightforward merge of variable mtu from donald's driver.

Jason

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sundance-5

--- sundance-ioops.c	Thu Sep 19 16:58:44 2002
+++ sundance-mtu.c	Thu Sep 19 17:00:30 2002
@@ -65,7 +65,6 @@
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 0;
-static int mtu;
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    Typical is a 64 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 32;
@@ -162,13 +161,11 @@
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(max_interrupt_work, "i");
-MODULE_PARM(mtu, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "s");
 MODULE_PARM(flowctrl, "i");
 MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled per interrupt");
-MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
 MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
 MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(flowctrl, "Sundance Alta flow control [0|1]");
@@ -333,7 +330,7 @@
 	MACCtrl0 = 0x50,
 	MACCtrl1 = 0x52,
 	StationAddr = 0x54,
-	MaxTxSize = 0x5A,
+	MaxFrameSize = 0x5A,
 	RxMode = 0x5c,
 	MIICtrl = 0x5e,
 	MulticastFilter0 = 0x60,
@@ -461,6 +458,7 @@
 			IntrDrvRqst | IntrTxDone | StatsMax | \
 			LinkChange)
 
+static int  change_mtu(struct net_device *dev, int new_mtu);
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
@@ -567,11 +565,9 @@
 	dev->do_ioctl = &netdev_ioctl;
 	dev->tx_timeout = &tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
+	dev->change_mtu = &change_mtu;
 	pci_set_drvdata(pdev, dev);
 
-	if (mtu)
-		dev->mtu = mtu;
-
 	i = register_netdev(dev);
 	if (i)
 		goto err_out_unmap_rx;
@@ -694,6 +690,15 @@
 	return -ENODEV;
 }
 
+static int change_mtu(struct net_device *dev, int new_mtu)
+{
+	if ((new_mtu < 68) || (new_mtu > 8191)) /* Set by RxDMAFrameLen */
+		return -EINVAL;
+	if (netif_running(dev))
+		return -EBUSY;
+	dev->mtu = new_mtu;
+	return 0;
+}
 
 /* Read the EEPROM and MII Management Data I/O (MDIO) interfaces. */
 static int __devinit eeprom_read(long ioaddr, int location)
@@ -823,6 +828,10 @@
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
+	writew(dev->mtu + 14, ioaddr + MaxFrameSize);
+	if (dev->mtu > 2047)
+		writel(readl(ioaddr + ASICCtrl) | 0x0C, ioaddr + ASICCtrl);
+
 	/* Configure the PCI bus bursts and FIFO thresholds. */
 
 	if (dev->if_port == 0)
@@ -955,7 +964,7 @@
 	np->cur_rx = np->cur_tx = 0;
 	np->dirty_rx = np->dirty_tx = 0;
 
-	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 36);
 
 	/* Initialize all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {

--Y5rl02BVI9TCfPar--
