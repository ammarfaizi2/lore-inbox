Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRFIEhw>; Sat, 9 Jun 2001 00:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263786AbRFIEhm>; Sat, 9 Jun 2001 00:37:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51398 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263780AbRFIEhW>;
	Sat, 9 Jun 2001 00:37:22 -0400
Message-ID: <3B21A7FA.484F0175@mandrakesoft.com>
Date: Sat, 09 Jun 2001 00:37:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH: 8139too fixes for testing
Content-Type: multipart/mixed;
 boundary="------------09662B121B65A134A6188822"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------09662B121B65A134A6188822
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Testing requested, especially if you had problems with 8139too in recent
2.4.x kernels.
-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------09662B121B65A134A6188822
Content-Type: text/plain; charset=us-ascii;
 name="8139-pre1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8139-pre1.patch"

Index: linux_2_4/drivers/net/8139too.c
diff -u linux_2_4/drivers/net/8139too.c:1.1.1.39 linux_2_4/drivers/net/8139too.c:1.1.1.39.2.3
--- linux_2_4/drivers/net/8139too.c:1.1.1.39	Fri Jun  8 15:40:33 2001
+++ linux_2_4/drivers/net/8139too.c	Fri Jun  8 21:22:43 2001
@@ -136,6 +136,10 @@
 
 */
 
+#define DRV_NAME	"8139too"
+#define DRV_VERSION	"0.9.18-pre1"
+
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -146,13 +150,13 @@
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <asm/io.h>
+#include <asm/uaccess.h>
 
 
-#define RTL8139_VERSION "0.9.17"
-#define MODNAME "8139too"
-#define RTL8139_DRIVER_NAME   MODNAME " Fast Ethernet driver " RTL8139_VERSION
-#define PFX MODNAME ": "
+#define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
+#define PFX DRV_NAME ": "
 
 
 /* enable PIO instead of MMIO, if CONFIG_8139TOO_PIO is selected */
@@ -363,7 +367,10 @@
 	TxOK = 0x04,
 	RxErr = 0x02,
 	RxOK = 0x01,
+
+	RxAckBits = RxFIFOOver | RxOverflow | RxOK,
 };
+
 enum TxStatusBits {
 	TxHostOwns = 0x2000,
 	TxUnderrun = 0x4000,
@@ -542,6 +549,11 @@
 
 };
 
+struct rtl_extra_stats {
+	unsigned long early_rx;
+	unsigned long tx_buf_mapped;
+	unsigned long tx_timeouts;
+};
 
 struct rtl8139_private {
 	void *mmio_addr;
@@ -560,7 +572,6 @@
 	dma_addr_t rx_ring_dma;
 	dma_addr_t tx_bufs_dma;
 	signed char phys[4];		/* MII device addresses. */
-	u16 advertising;		/* NWay media advertisement */
 	char twistie, twist_row, twist_col;	/* Twister tune state. */
 	unsigned int full_duplex:1;	/* Full-duplex operation requested. */
 	unsigned int duplex_lock:1;
@@ -574,6 +585,7 @@
 	wait_queue_head_t thr_wait;
 	struct semaphore thr_exited;
 	u32 rx_config;
+	struct rtl_extra_stats xstats;
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
@@ -582,6 +594,10 @@
 MODULE_PARM (max_interrupt_work, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM (full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
+MODULE_PARM_DESC (max_interrupt_work, "8139too maximum events handled per interrupt");
+MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (1)");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
@@ -596,7 +612,7 @@
 static void rtl8139_interrupt (int irq, void *dev_instance,
 			       struct pt_regs *regs);
 static int rtl8139_close (struct net_device *dev);
-static int mii_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
+static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
 static struct net_device_stats *rtl8139_get_stats (struct net_device *dev);
 static inline u32 ether_crc (int length, unsigned char *data);
 static void rtl8139_set_rx_mode (struct net_device *dev);
@@ -938,7 +954,7 @@
 	dev->stop = rtl8139_close;
 	dev->get_stats = rtl8139_get_stats;
 	dev->set_multicast_list = rtl8139_set_rx_mode;
-	dev->do_ioctl = mii_ioctl;
+	dev->do_ioctl = netdev_ioctl;
 	dev->tx_timeout = rtl8139_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
@@ -984,11 +1000,11 @@
 		for (phy = 0; phy < 32 && phy_idx < sizeof(tp->phys); phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+				u16 advertising = mdio_read(dev, phy, 4);
 				tp->phys[phy_idx++] = phy;
-				tp->advertising = mdio_read(dev, phy, 4);
 				printk(KERN_INFO "%s: MII transceiver %d status 0x%4.4x "
 					   "advertising %4.4x.\n",
-					   dev->name, phy, mii_status, tp->advertising);
+					   dev->name, phy, mii_status, advertising);
 			}
 		}
 		if (phy_idx == 0) {
@@ -1331,16 +1347,16 @@
 	rtl8139_chip_reset (ioaddr);
 
 	/* unlock Config[01234] and BMCR register writes */
-	RTL_W8 (Cfg9346, Cfg9346_Unlock);
+	RTL_W8_F (Cfg9346, Cfg9346_Unlock);
 	/* Restore our idea of the MAC address. */
 	RTL_W32_F (MAC0 + 0, cpu_to_le32 (*(u32 *) (dev->dev_addr + 0)));
-	RTL_W32 (MAC0 + 4, cpu_to_le32 (*(u32 *) (dev->dev_addr + 4)));
+	RTL_W32_F (MAC0 + 4, cpu_to_le32 (*(u32 *) (dev->dev_addr + 4)));
 
 	/* Must enable Tx/Rx before setting transfer thresholds! */
 	RTL_W8 (ChipCmd, CmdRxEnb | CmdTxEnb);
 
 	tp->rx_config = rtl8139_rx_config | AcceptBroadcast | AcceptMyPhys;
-	RTL_W32 (RxConfig, rtl8139_rx_config);
+	RTL_W32 (RxConfig, tp->rx_config);
 
 	/* Check this value: the documentation for IFG contradicts ifself. */
 	RTL_W32 (TxConfig, (TX_DMA_BURST << TxDMAShift));
@@ -1357,24 +1373,15 @@
 		else if ((mii_reg5 & 0x0100) == 0x0100
 				 || (mii_reg5 & 0x00C0) == 0x0040)
 			tp->full_duplex = 1;
-		if (mii_reg5) {
-			printk(KERN_INFO"%s: Setting %s%s-duplex based on"
-			   " auto-negotiated partner ability %4.4x.\n", dev->name,
-			   mii_reg5 == 0 ? "" :
-			   (mii_reg5 & 0x0180) ? "100mbps " : "10mbps ",
-			   tp->full_duplex ? "full" : "half", mii_reg5);
-		} else {
-			printk(KERN_INFO"%s: media is unconnected, link down, or incompatible connection\n",
-			       dev->name);
-		}
+
+		printk (KERN_INFO"%s: Setting %s%s-duplex based on"
+				" auto-negotiated partner ability %4.4x.\n",
+		        dev->name, mii_reg5 == 0 ? "" :
+				(mii_reg5 & 0x0180) ? "100mbps " : "10mbps ",
+			tp->full_duplex ? "full" : "half", mii_reg5);
 	}
 
 	if (tp->chipset >= CH_8139B) {
-		tmp = RTL_R8 (Config4) & ~(1<<2);
-		/* chip will clear Rx FIFO overflow automatically */
-		tmp |= (1<<7);
-		RTL_W8 (Config4, tmp);
-
 		/* disable magic packet scanning, which is enabled
 		 * when PM is enabled in Config1 */
 		RTL_W8 (Config3, RTL_R8 (Config3) & ~(1<<5));
@@ -1654,6 +1661,8 @@
 		 RTL_R16 (IntrStatus),
 		 RTL_R8 (MediaStatus));
 
+	tp->xstats.tx_timeouts++;
+
 	/* disable Tx ASAP, if not already */
 	tmp8 = RTL_R8 (ChipCmd);
 	if (tmp8 & CmdTxEnb)
@@ -1704,6 +1713,7 @@
 		RTL_W32 (TxAddr0 + (entry * 4),
 			 tp->tx_bufs_dma + (tp->tx_buf[entry] - tp->tx_bufs));
 	} else {
+		tp->xstats.tx_buf_mapped++;
 		tp->tx_info[entry].mapping =
 		    pci_map_single (tp->pci_dev, skb->data, skb->len,
 				    PCI_DMA_TODEVICE);
@@ -1760,7 +1770,7 @@
 			tp->stats.tx_errors++;
 			if (txstatus & TxAborted) {
 				tp->stats.tx_aborted_errors++;
-				RTL_W32 (TxConfig, TxClearAbt | (TX_DMA_BURST << TxDMAShift));
+				RTL_W32_F (TxConfig, TxClearAbt);
 			}
 			if (txstatus & TxCarrierLost)
 				tp->stats.tx_carrier_errors++;
@@ -1865,11 +1875,10 @@
 
 
 static void rtl8139_rx_interrupt (struct net_device *dev,
-				  struct rtl8139_private *tp, void *ioaddr,
-				  u16 status)
+				  struct rtl8139_private *tp, void *ioaddr)
 {
 	unsigned char *rx_ring;
-	u16 cur_rx, ackstat;
+	u16 cur_rx;
 
 	assert (dev != NULL);
 	assert (tp != NULL);
@@ -1883,11 +1892,6 @@
 		 RTL_R16 (RxBufAddr),
 		 RTL_R16 (RxBufPtr), RTL_R8 (ChipCmd));
 
-	if (status & RxFIFOOver)
-		status = RxOverflow | RxOK;
-	else
-		status = RxOK;
-
 	while ((RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {
 		int ring_offset = cur_rx % RX_BUF_LEN;
 		u32 rx_status;
@@ -1895,8 +1899,6 @@
 		unsigned int pkt_size;
 		struct sk_buff *skb;
 
-		mb();
-
 		/* read size+status of next frame from DMA ring buffer */
 		rx_status = le32_to_cpu (*(u32 *) (rx_ring + ring_offset));
 		rx_size = rx_status >> 16;
@@ -1916,8 +1918,10 @@
 		}
 #endif
 
-		if (rx_size == 0xfff0) /* Early Rx in progress */
+		if (rx_size == 0xfff0) { /* Early Rx in progress */
+			tp->xstats.early_rx++;
 			break;
+		}
 
 		/* If Rx err or invalid rx_size/rx_status received
 		 * (which happens if we get lost in the ring),
@@ -1963,9 +1967,8 @@
 		cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
 		RTL_W16 (RxBufPtr, cur_rx - 16);
 
-		ackstat = RTL_R16 (IntrStatus) & status;
-		if (ackstat)
-			RTL_W16 (IntrStatus, ackstat);
+		if (RTL_R16 (IntrStatus) & RxAckBits)
+			RTL_W16_F (IntrStatus, RxAckBits);
 	}
 
 	DPRINTK ("%s: Done rtl8139_rx(), current %4.4x BufAddr %4.4x,"
@@ -1975,11 +1978,9 @@
 
 	tp->cur_rx = cur_rx;
 
-	if (RTL_R8 (ChipCmd) & RxBufEmpty) {
-		ackstat = RTL_R16 (IntrStatus) & status;
-		if (ackstat)
-			RTL_W16_F (IntrStatus, ackstat);
-	}
+	if ((RTL_R8 (ChipCmd) & RxBufEmpty) &&
+	    (RTL_R16 (IntrStatus) & RxAckBits))
+		RTL_W16_F (IntrStatus, RxAckBits);
 }
 
 
@@ -2059,26 +2060,10 @@
 		if (status & RxUnderrun)
 			link_changed = RTL_R16 (CSCR) & CSCR_LinkChangeBit;
 
-		/* E. Gill */
-		/* In case of an RxFIFOOver we must also clear the RxOverflow
-		   bit to avoid dropping frames for ever. Believe me, I got a
-		   lot of troubles copying huge data (approximately 2 RxFIFOOver
-		   errors per 1GB data transfer).
-		   The following is written in the 'p-guide.pdf' file (RTL8139(A/B)
-		   Programming guide V0.1, from 1999/1/15) on page 9 from REALTEC.
-		   -----------------------------------------------------------
-		   2. RxFIFOOvw handling:
-		     When RxFIFOOvw occurs, all incoming packets are discarded.
-		     Clear ISR(RxFIFOOvw) doesn't dismiss RxFIFOOvw event. To
-		     dismiss RxFIFOOvw event, the ISR(RxBufOvw) must be written
-		     with a '1'.
-		   -----------------------------------------------------------
-		   Unfortunately I was not able to find any reason for the
-		   RxFIFOOver error (I got the feeling this depends on the
-		   CPU speed, lower CPU speed --> more errors).
-		   After clearing the RxOverflow bit the transfer of the
-		   packet was repeated and all data are error free transferred */
-		ackstat = status & ~(RxFIFOOver | RxOverflow | RxOK);
+		/* The chip takes special action when we clear RxAckBits,
+		 * so we clear them later in rtl8139_rx_interrupt
+		 */
+		ackstat = status & ~RxAckBits;
 		RTL_W16 (IntrStatus, ackstat);
 
 		DPRINTK ("%s: interrupt  status=%#4.4x ackstat=%#4.4x new intstat=%#4.4x.\n",
@@ -2089,9 +2074,8 @@
 		      RxFIFOOver | TxErr | TxOK | RxErr | RxOK)) == 0)
 			break;
 
-		if (netif_running (dev) &&
-		    status & (RxOK | RxUnderrun | RxOverflow | RxFIFOOver))	/* Rx interrupt */
-			rtl8139_rx_interrupt (dev, tp, ioaddr, status);
+		if (netif_running (dev) && (status & RxAckBits))
+			rtl8139_rx_interrupt (dev, tp, ioaddr);
 
 		/* Check uncommon events with one test. */
 		if (status & (PCIErr | PCSTimeout | RxUnderrun | RxOverflow |
@@ -2099,8 +2083,7 @@
 			rtl8139_weird_interrupt (dev, tp, ioaddr,
 						 status, link_changed);
 
-		if (netif_running (dev) &&
-		    status & (TxOK | TxErr)) {
+		if (netif_running (dev) && (status & (TxOK | TxErr))) {
 			spin_lock (&tp->lock);
 			rtl8139_tx_interrupt (dev, tp, ioaddr);
 			spin_unlock (&tp->lock);
@@ -2110,10 +2093,8 @@
 	} while (boguscnt > 0);
 
 	if (boguscnt <= 0) {
-		printk (KERN_WARNING
-			"%s: Too much work at interrupt, "
-			"IntrStatus=0x%4.4x.\n", dev->name,
-			status);
+		printk (KERN_WARNING "%s: Too much work at interrupt, "
+			"IntrStatus=0x%4.4x.\n", dev->name, status);
 
 		/* Clear all interrupt sources. */
 		RTL_W16 (IntrStatus, 0xffff);
@@ -2183,8 +2164,32 @@
 	return 0;
 }
 
+
+static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+{
+	struct rtl8139_private *np = dev->priv;
+	u32 ethcmd;
+		
+	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+		return -EFAULT;
+
+        switch (ethcmd) {
+        case ETHTOOL_GDRVINFO: {
+		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
+		strcpy(info.driver, DRV_NAME);
+		strcpy(info.version, DRV_VERSION);
+		strcpy(info.bus_info, np->pci_dev->slot_name);
+		if (copy_to_user(useraddr, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+
+        }
+	
+	return -EOPNOTSUPP;
+}
 
-static int mii_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
+static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct rtl8139_private *tp = dev->priv;
 	u16 *data = (u16 *) & rq->ifr_data;
@@ -2193,6 +2198,8 @@
 	DPRINTK ("ENTER\n");
 
 	switch (cmd) {
+	case SIOCETHTOOL:
+		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 	case SIOCDEVPRIVATE:	/* Get the address of the PHY in use. */
 		data[0] = tp->phys[0] & 0x3f;
 		/* Fall Through */
@@ -2216,7 +2223,7 @@
 				if (tp->medialock)
 					tp->full_duplex = (value & 0x0100) ? 1 : 0;
 				break;
-			case 4: tp->advertising = value; break;
+			case 4: /* tp->advertising = value; */ break;
 			}
 		}
 		mdio_write(dev, data[0], data[1] & 0x1f, data[2]);
@@ -2323,7 +2330,7 @@
 		tp->rx_config = tmp;
 	}
 	RTL_W32_F (MAR0 + 0, mc_filter[0]);
-	RTL_W32 (MAR0 + 4, mc_filter[1]);
+	RTL_W32_F (MAR0 + 4, mc_filter[1]);
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
@@ -2369,7 +2376,7 @@
 
 
 static struct pci_driver rtl8139_pci_driver = {
-	name:		MODNAME,
+	name:		DRV_NAME,
 	id_table:	rtl8139_pci_tbl,
 	probe:		rtl8139_init_one,
 	remove:		rtl8139_remove_one,

--------------09662B121B65A134A6188822--

