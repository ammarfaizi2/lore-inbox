Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273281AbSISVc5>; Thu, 19 Sep 2002 17:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273221AbSISVc5>; Thu, 19 Sep 2002 17:32:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7437 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S273545AbSISVbY>;
	Thu, 19 Sep 2002 17:31:24 -0400
Message-ID: <3D8A433B.5010703@mandrakesoft.com>
Date: Thu, 19 Sep 2002 17:35:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Donald Becker <becker@scyld.com>, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>, edward_peng@dlink.com.tw
Subject: PATCH: [my] sundance #5
References: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com> <3D8A25D1.3060300@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------050008070108080200010708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008070108080200010708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

next sundance patch in the series, updated with Jason's patches

Note, with the patching of Configure.help this is a 2.4-specific patch.

--------------050008070108080200010708
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Sep 19 17:32:40 2002
+++ b/Documentation/Configure.help	Thu Sep 19 17:32:41 2002
@@ -11799,6 +11799,14 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called sundance.o.
 
+Sundance Alta memory-mapped I/O support
+CONFIG_SUNDANCE_MMIO
+  Enable memory-mapped I/O for interaction with Sundance NIC registers.
+  Do NOT enable this by default, PIO (enabled when MMIO is disabled)
+  is known to solve bugs on certain chips.
+
+  If unsure, say N.
+
 Sun3/Sun3x on-board LANCE support
 CONFIG_SUN3LANCE
   Most Sun3 and Sun3x motherboards (including the 3/50, 3/60 and 3/80)
diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	Thu Sep 19 17:32:40 2002
+++ b/drivers/net/Config.in	Thu Sep 19 17:32:40 2002
@@ -192,6 +192,7 @@
       dep_tristate '    SiS 900/7016 PCI Fast Ethernet Adapter support' CONFIG_SIS900 $CONFIG_PCI
       dep_tristate '    SMC EtherPower II' CONFIG_EPIC100 $CONFIG_PCI
       dep_tristate '    Sundance Alta support' CONFIG_SUNDANCE $CONFIG_PCI
+      dep_mbool '      Use MMIO instead of PIO' CONFIG_SUNDANCE_MMIO $CONFIG_SUNDANCE
       if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" ]; then
          tristate '    TI ThunderLAN support' CONFIG_TLAN
       fi
diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c	Thu Sep 19 17:32:40 2002
+++ b/drivers/net/sundance.c	Thu Sep 19 17:32:40 2002
@@ -33,10 +33,11 @@
 	- Tx timeout recovery
 	- More support for ethtool.
 
-	Version LK1.04a (jgarzik):
+	Version LK1.04a:
 	- Remove unused/constant members from struct pci_id_info
 	(which then allows removal of 'drv_flags' from private struct)
-	- If no phy is found, fail to load that board
+	(jgarzik)
+	- If no phy is found, fail to load that board (jgarzik)
 	- Always start phy id scan at id 1 to avoid problems (Donald Becker)
 	- Autodetect where mii_preable_required is needed,
 	default to not needed.  (Donald Becker)
@@ -45,18 +46,25 @@
 	- Remove mii_preamble_required module parameter (Donald Becker)
 	- Add per-interface mii_preamble_required (setting is autodetected)
 	  (Donald Becker)
-	- Remove unnecessary cast from void pointer
-	- Re-align comments in private struct
+	- Remove unnecessary cast from void pointer (jgarzik)
+	- Re-align comments in private struct (jgarzik)
 
-	Version LK1.04c:
+	Version LK1.04c (jgarzik):
 	- Support bitmapped message levels (NETIF_MSG_xxx), and the
 	  two ethtool ioctls that get/set them
 	- Don't hand-code MII ethtool support, use standard API/lib
 
+	Version LK1.04d:
+	- Merge from Donald Becker's sundance.c: (Jason Lunz)
+		* proper support for variably-sized MTUs
+		* default to PIO, to fix chip bugs
+	- Add missing unregister_netdev (Jason Lunz)
+	- Add CONFIG_SUNDANCE_MMIO config option (jgarzik)
+
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01+LK1.04c"
+#define DRV_VERSION	"1.01+LK1.04d"
 #define DRV_RELDATE	"19-Sep-2002"
 
 
@@ -65,7 +73,6 @@
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 0;
-static int mtu;
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    Typical is a 64 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 32;
@@ -162,13 +169,11 @@
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
@@ -247,6 +252,10 @@
 
 */
 
+/* Work-around for Kendin chip bugs. */
+#ifndef CONFIG_SUNDANCE_MMIO
+#define USE_IO_OPS 1
+#endif
 
 static struct pci_device_id sundance_pci_tbl[] __devinitdata = {
 	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
@@ -329,7 +338,7 @@
 	MACCtrl0 = 0x50,
 	MACCtrl1 = 0x52,
 	StationAddr = 0x54,
-	MaxTxSize = 0x5A,
+	MaxFrameSize = 0x5A,
 	RxMode = 0x5c,
 	MIICtrl = 0x5e,
 	MulticastFilter0 = 0x60,
@@ -457,6 +466,7 @@
 			IntrDrvRqst | IntrTxDone | StatsMax | \
 			LinkChange)
 
+static int  change_mtu(struct net_device *dev, int new_mtu);
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
@@ -563,11 +573,9 @@
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
@@ -599,7 +607,7 @@
 		if (phy_idx == 0) {
 			printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC status %x\n",
 				   dev->name, readl(ioaddr + ASICCtrl));
-			goto err_out_unmap_rx;
+			goto err_out_unregister;
 		}
 
 		np->mii_if.phy_id = np->phys[0];
@@ -673,6 +681,8 @@
 	card_idx++;
 	return 0;
 
+err_out_unregister:
+	unregister_netdev(dev);
 err_out_unmap_rx:
         pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring, np->rx_ring_dma);
 err_out_unmap_tx:
@@ -689,6 +699,15 @@
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
@@ -818,6 +837,10 @@
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
+	writew(dev->mtu + 14, ioaddr + MaxFrameSize);
+	if (dev->mtu > 2047)
+		writel(readl(ioaddr + ASICCtrl) | 0x0C, ioaddr + ASICCtrl);
+
 	/* Configure the PCI bus bursts and FIFO thresholds. */
 
 	if (dev->if_port == 0)
@@ -950,7 +973,7 @@
 	np->cur_rx = np->cur_tx = 0;
 	np->dirty_rx = np->dirty_tx = 0;
 
-	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 36);
 
 	/* Initialize all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {

--------------050008070108080200010708--

