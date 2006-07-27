Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWG0Hxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWG0Hxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWG0Hxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:53:52 -0400
Received: from msr29.hinet.net ([168.95.4.129]:10447 "EHLO msr29.hinet.net")
	by vger.kernel.org with ESMTP id S932539AbWG0Hxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:53:51 -0400
Subject: [PATCH] Create IP100A Driver
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 27 Jul 2006 15:39:32 -0400
Message-Id: <1154029172.5967.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

This is the first version of IP100A Linux Driver.

Change Logs:

---


 drivers/net/ipf.c | 1378
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ipf.h |  267 ++++++++++
 2 files changed, 1644 insertions(+), 1 deletions(-)

5e4c20f6799411d9262fc281b5ab1834c85c532a
diff --git a/drivers/net/ipf.c b/drivers/net/ipf.c
index 8b13789..6e610bd 100644
--- a/drivers/net/ipf.c
+++ b/drivers/net/ipf.c
@@ -1 +1,1379 @@
+/*PCI_DEVICE_ID_IP100A
+ *
+ * ipf.c
+ *
+ * IC Plus IP100A Fast Ethernet Adapter Linux Driver v2.01
+ * by IC Plus Corp. 2006
+ *
+ * Initiator:
+ * Donald Becker
+ * Scyld Computing Corporation
+ * 410 Severn Ave., Suite 210
+ * Annapolis MD 21403
+ * http://www.scyld.com/network/sundance.html
+ * becker@scyld.com
+ *
+ * Current Maintainer:
+ * Sorbica Shieh.
+ * IC Plus Corporation
+ * 10F, No.47, Lane 2, Kwang-Fu RD.
+ * Sec. 2, Hsin-Chu, Taiwan, R.O.C.
+ * http://www.icplus.com.tw
+ * sorbica@icplus.com.tw
+ */
+
+/* Work-around for Kendin chip bugs. */
+#define CONFIG_SUNDANCE_MMIO		// use MMIO
+#ifndef CONFIG_SUNDANCE_MMIO
+#define USE_IO_OPS 1
+#endif
+
+#include "ipf.h"
+
+#define DRV_NAME	"ipf"
+#define DRV_VERSION	"2.00+LK0.01"
+#define DRV_RELDATE	"06-23-2006"
+/* These identify the driver base version and may not be removed. */
+static char version[] __devinitdata =
+KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " by IC Plus
Corp.\n"
+KERN_INFO "http://www.icplus.com\n";
+
+
+MODULE_AUTHOR("IC Plus Corp. 2006");
+MODULE_DESCRIPTION("IC Plus IP100A Fast Ethernet Adapter Linux
Driver");
+MODULE_LICENSE("GPL");
+
+/* The user-configurable parameters. */
+/* These may be modified when a driver module is loaded.*/
+static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
+/* Maximum number of multicast addresses to filter (vs.
rx-all-multicast).
+   Typical is a 64 element hash table based on the Ethernet CRC.  */
+static int multicast_filter_limit = 32;
+
+/* Set the copy breakpoint for the copy-only-tiny-frames scheme.
+   Setting to > 1518 effectively disables this feature.
+   This chip can receive into offset buffers, so the Alpha does not
+   need a copy-align. */
+static int rx_copybreak;
+static int flowctrl=1;
+
+/* media[] specifies the media type the NIC operates at.
+		 autosense	Autosensing active media.
+		 10mbps_hd 	10Mbps half duplex.
+		 10mbps_fd 	10Mbps full duplex.
+		 100mbps_hd 	100Mbps half duplex.
+		 100mbps_fd 	100Mbps full duplex.
+		 0		Autosensing active media.
+		 1	 	10Mbps half duplex.
+		 2	 	10Mbps full duplex.
+		 3	 	100Mbps half duplex.
+		 4	 	100Mbps full duplex.
+*/
+#define MAX_UNITS 8
+static char *media[MAX_UNITS];
+
+module_param(rx_copybreak, int, 0);
+module_param_array(media, charp, NULL, 0);
+module_param(flowctrl, int, 0);
+MODULE_PARM_DESC(debug, "IC+ IP100A debug level (0-5)");
+MODULE_PARM_DESC(rx_copybreak, "IC+ IP100A copy breakpoint for
copy-only-tiny-frames");
+MODULE_PARM_DESC(flowctrl, "IC+ IP100A flow control [0|1]");
+
+
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
+#if !defined(__OPTIMIZE__)
+#warning  You must compile this file with the correct options!
+#warning  See the last lines of the source file.
+#error You must compile this driver with "-O".
+#endif
+
+
+static inline void __iomem *ipf_ioaddr(struct net_device *dev)
+{
+	struct netdev_private *sp = netdev_priv(dev);
+	return sp->ioaddr;
+}
+
+/*  MII transceiver control section. DP83840A data sheet
+	The maximum data clock rate is 2.5 Mhz.  The minimum timing is usually
+	met by back-to-back 33Mhz PCI cycles.
+*/
+#define mdio_delay() iord8(mdio_addr)
+
+enum mii_reg_bits {
+	MDIO_ShiftClk=0x0001, MDIO_Data=0x0002, MDIO_EnbOutput=0x0004,
+};
+#define MDIO_EnbIn  (0)
+#define MDIO_WRITE0 (MDIO_EnbOutput)
+#define MDIO_WRITE1 (MDIO_Data | MDIO_EnbOutput)
+
+static void mdio_setbit(int bitval, void __iomem * mdio_addr)
+{
+	iowr8(bitval, mdio_addr);
+	mdio_delay();
+	iowr8(bitval | MDIO_ShiftClk, mdio_addr);
+	mdio_delay();
+}
+
+
+/* Generate the preamble required for initial synchronization and
+   a few older transceivers. */
+static void mdio_sync(void __iomem * mdio_addr)
+{
+	int bits = 32;
+
+	/* Establish sync by sending at least 32 logic ones. */
+	while (--bits >= 0) {
+		mdio_setbit(MDIO_WRITE1, mdio_addr);
+	}
+}
+
+static int mdio_read(struct net_device *dev, int phy_id, int location)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * mdio_addr = ipf_ioaddr(dev) + MIICtrl;
+	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
+	int i, retval = 0;
+
+	if (np->mii_preamble_required)
+		mdio_sync(mdio_addr);
+
+	/* Shift the read command bits out. */
+	for (i = 15; i >= 0; i--) {
+		int dataval = (mii_cmd & (1 << i)) ? MDIO_WRITE1 : MDIO_WRITE0;
+		mdio_setbit(dataval, mdio_addr);
+	}
+	/* Read the two transition, 16 data, and wire-idle bits. */
+	for (i = 19; i > 0; i--) {
+		iowr8(MDIO_EnbIn, mdio_addr);
+		mdio_delay();
+		retval = (retval << 1) | ((iord8(mdio_addr) & MDIO_Data) ? 1 : 0);
+		iowr8(MDIO_EnbIn | MDIO_ShiftClk, mdio_addr);
+		mdio_delay();
+	}
+	return (retval>>1) & 0xffff;
+}
+
+static void mdio_write(struct net_device *dev, int phy_id, int
location, int value)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * mdio_addr = ipf_ioaddr(dev) + MIICtrl;
+	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location<<18) |
value;
+	int i;
+
+	if (np->mii_preamble_required)
+		mdio_sync(mdio_addr);
+
+	/* Shift the command bits out. */
+	for (i = 31; i >= 0; i--) {
+		int dataval = (mii_cmd & (1 << i)) ? MDIO_WRITE1 : MDIO_WRITE0;
+		mdio_setbit(dataval, mdio_addr);
+	}
+	/* Clear out extra bits. */
+	for (i = 2; i > 0; i--) {
+		mdio_setbit(MDIO_EnbIn, mdio_addr);
+	}
+	return;
+}
+
+
+/* Read the EEPROM and MII Management Data I/O (MDIO) interfaces. */
+static int __devinit eeprom_read(void __iomem * ioaddr, int location)
+{
+	int boguscnt = 1000;		/* Typical 190 ticks. */
+	iowr16(0x0200 | (location & 0xff), ioaddr + EECtrl);
+	do {
+		if (! (iord16(ioaddr + EECtrl) & 0x8000)) {
+			return iord16(ioaddr + EEData);
+		}
+	} while (--boguscnt > 0);
+	return 0;
+}
+
+static int change_mtu(struct net_device *dev, int new_mtu)
+{
+	if ((new_mtu < 68) || (new_mtu > 8191)) /* Set by RxDMAFrameLen */
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static int ipf_get_settings(struct net_device *dev, struct ethtool_cmd
*cmd)
+{
+	struct netdev_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_ethtool_gset(&sp->mii_if, cmd);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static int ipf_set_settings(struct net_device *dev, struct ethtool_cmd
*cmd)
+{
+	struct netdev_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_ethtool_sset(&sp->mii_if, cmd);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static int ipf_nway_reset(struct net_device *dev)
+{
+	struct netdev_private *sp = netdev_priv(dev);
+	int rc;
+
+	mutex_lock(&sp->mii_mutex);
+	rc = mii_nway_restart(&sp->mii_if);
+	mutex_unlock(&sp->mii_mutex);
+
+	return rc;
+}
+
+static struct ethtool_ops ipf_ethtool_ops = {
+	.get_settings = ipf_get_settings,
+	.set_settings = ipf_set_settings,
+	.nway_reset   = ipf_nway_reset,
+};
+
+static void check_duplex(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int mii_lpa = mdio_read(dev, np->phys[0], MII_LPA);
+	int negotiated = mii_lpa & np->mii_if.advertising;
+	int duplex;
+
+	/* Force media */
+	if (!np->an_enable || mii_lpa == 0xffff) {
+		if (np->mii_if.full_duplex)
+			iowr16 (iord16 (ioaddr + MACCtrl0) | EnbFullDuplex,
+				ioaddr + MACCtrl0);
+		return;
+	}
+
+	/* Autonegotiation */
+	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
+	if (np->mii_if.full_duplex != duplex) {
+		np->mii_if.full_duplex = duplex;
+		if (netif_msg_link(np))
+			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
+				   "negotiated capability %4.4x.\n", dev->name,
+				   duplex ? "full" : "half", np->phys[0], negotiated);
+		iowr16(iord16(ioaddr + MACCtrl0) | duplex ? 0x20 : 0, ioaddr +
MACCtrl0);
+	}
+}
+
+
+static void netdev_timer(ULONG data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int next_tick = 10*HZ;
+
+	if (netif_msg_timer(np)) {
+		printk(KERN_DEBUG "%s: Media selection timer tick, intr status %4.4x,
"
+			   "Tx %x Rx %x.\n",
+			   dev->name, iord16(ioaddr + IntrEnable),
+			   iord8(ioaddr + TxStatus), iord32(ioaddr + RxStatus));
+	}
+	check_duplex(dev);
+	np->timer.expires = jiffies + next_tick;
+	add_timer(&np->timer);
+}
+
+/* Initialize the Rx and Tx rings, along with various 'dev' bits. */
+static void init_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int i;
+
+	np->cur_rx = np->cur_tx = 0;
+	np->dirty_rx = np->dirty_tx = 0;
+	np->cur_task = 0;
+
+	np->rx_buf_sz = (dev->mtu <= 1520 ? PKT_BUF_SZ : dev->mtu + 16);
+
+	/* Initialize all Rx descriptors. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].next_desc = cpu_to_le32(np->rx_ring_dma +
+			((i+1)%RX_RING_SIZE)*sizeof(*np->rx_ring));
+		np->rx_ring[i].status = 0;
+		np->rx_ring[i].frag[0].length = 0;
+		np->rx_skbuff[i] = 0;
+	}
+
+	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
+		np->rx_skbuff[i] = skb;
+		if (skb == NULL)
+			break;
+		skb->dev = dev;		/* Mark as being used by this device. */
+		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
+		np->rx_ring[i].frag[0].addr = cpu_to_le32(
+			pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz,
+				PCI_DMA_FROMDEVICE));
+		np->rx_ring[i].frag[0].length = cpu_to_le32(np->rx_buf_sz |
LastFrag);
+	}
+	np->dirty_rx = ( UINT )(i - RX_RING_SIZE);
+
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_skbuff[i] = 0;
+		np->tx_ring[i].status = 0;
+	}
+	return;
+}
+
+
+/* Reset hardware tx and free all of tx buffers */
+static int reset_tx (struct net_device *dev)
+{
+	struct netdev_private *np = (struct netdev_private*) dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	struct sk_buff *skb;
+	int i;
+	int irq = in_interrupt();
+	tasklet_kill(&np->tx_tasklet);
+	/* Reset tx logic, TxListPtr will be cleaned */
+	iowr16 (TxDisable, ioaddr + MACCtrl1);
+	iowr16 (TxReset | DMAReset | FIFOReset | NetworkReset,
+			ioaddr + ASICCtrl + 2);
+	for (i=50; i > 0; i--) {
+		if ((iord16(ioaddr + ASICCtrl + 2) & ResetBusy) == 0)
+			break;
+		mdelay(1);
+	}
+	/* free all tx skbuff */
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].next_desc=0;
+
+		skb = np->tx_skbuff[i];
+		if (skb) {
+			pci_unmap_single(np->pci_dev,
+				np->tx_ring[i].frag[0].addr, skb->len,
+				PCI_DMA_TODEVICE);
+			if (irq)
+				dev_kfree_skb_irq (skb);
+			else
+				dev_kfree_skb (skb);
+			np->tx_skbuff[i] = 0;
+			np->stats.tx_dropped++;
+		}
+	}
+	np->cur_tx = np->dirty_tx = 0;
+	np->cur_task = 0;
+	np->last_tx=0;
+
+	iowr8(127, ioaddr + TxDMAPollPeriod);
+	iowr16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
+	return 0;
+}
+
+static int __set_mac_addr(struct net_device *dev)
+{
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	u16 addr16;
+
+	addr16 = (dev->dev_addr[0] | (dev->dev_addr[1] << 8));
+	iowr16(addr16, ioaddr + StationAddr);
+	addr16 = (dev->dev_addr[2] | (dev->dev_addr[3] << 8));
+	iowr16(addr16, ioaddr + StationAddr+2);
+	addr16 = (dev->dev_addr[4] | (dev->dev_addr[5] << 8));
+	iowr16(addr16, ioaddr + StationAddr+4);
+	return 0;
+}
+
+
+static struct net_device_stats *get_stats(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int i;
+
+	/* We should lock this segment of code for SMP eventually, although
+	   the vulnerability window is very small and statistics are
+	   non-critical. */
+	/* The chip only need report frame silently dropped. */
+	np->stats.rx_missed_errors	+= iord8(ioaddr + RxMissed);
+	np->stats.tx_packets += iord16(ioaddr + TxFramesOK);
+	np->stats.rx_packets += iord16(ioaddr + RxFramesOK);
+	np->stats.collisions += iord8(ioaddr + StatsLateColl);
+	np->stats.collisions += iord8(ioaddr + StatsMultiColl);
+	np->stats.collisions += iord8(ioaddr + StatsOneColl);
+	np->stats.tx_carrier_errors += iord8(ioaddr + StatsCarrierError);
+	iord8(ioaddr + StatsTxDefer);
+	for (i = StatsTxDefer; i <= StatsMcastRx; i++)
+		iord8(ioaddr + i);
+	np->stats.tx_bytes += iord16(ioaddr + TxOctetsLow);
+	np->stats.tx_bytes += iord16(ioaddr + TxOctetsHigh) << 16;
+	np->stats.rx_bytes += iord16(ioaddr + RxOctetsLow);
+	np->stats.rx_bytes += iord16(ioaddr + RxOctetsHigh) << 16;
+
+	return &np->stats;
+}
+
+
+static void netdev_error(struct net_device *dev, int intr_status)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	u16 mii_ctl, mii_advertise, mii_lpa;
+	int speed;
+
+	if (intr_status & LinkChange) {
+		if (np->an_enable) {
+			mii_advertise = mdio_read (dev, np->phys[0], MII_ADVERTISE);
+			mii_lpa= mdio_read (dev, np->phys[0], MII_LPA);
+			mii_advertise &= mii_lpa;
+			printk (KERN_INFO "%s: Link changed: ", dev->name);
+			if (mii_advertise & ADVERTISE_100FULL) {
+				np->speed = 100;
+				printk ("100Mbps, full duplex\n");
+			} else if (mii_advertise & ADVERTISE_100HALF) {
+				np->speed = 100;
+				printk ("100Mbps, half duplex\n");
+			} else if (mii_advertise & ADVERTISE_10FULL) {
+				np->speed = 10;
+				printk ("10Mbps, full duplex\n");
+			} else if (mii_advertise & ADVERTISE_10HALF) {
+				np->speed = 10;
+				printk ("10Mbps, half duplex\n");
+			} else
+				printk ("\n");
+
+		} else {
+			mii_ctl = mdio_read (dev, np->phys[0], MII_BMCR);
+			speed = (mii_ctl & BMCR_SPEED100) ? 100 : 10;
+			np->speed = speed;
+			printk (KERN_INFO "%s: Link changed: %dMbps ,",
+				dev->name, speed);
+			printk ("%s duplex.\n", (mii_ctl & BMCR_FULLDPLX) ?
+				"full" : "half");
+		}
+		check_duplex (dev);
+		if (np->flowctrl && np->mii_if.full_duplex) {
+			iowr16(iord16(ioaddr + MulticastFilter1+2) | 0x0200,
+				ioaddr + MulticastFilter1+2);
+			iowr16(iord16(ioaddr + MACCtrl0) | EnbFlowCtrl,
+				ioaddr + MACCtrl0);
+		}
+	}
+	if (intr_status & StatsMax) {
+		get_stats(dev);
+	}
+	if (intr_status & IntrPCIErr) {
+		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
+			   dev->name, intr_status);
+		/* We must do a global reset of DMA to continue. */
+	}
+}
+
+static void set_rx_mode(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	u16 mc_filter[4];			/* Multicast hash filter */
+	u32 rx_mode;
+	int i;
+
+	rx_mode = AcceptBroadcast | AcceptMyPhys;
+	memset (mc_filter, 0, sizeof (mc_filter));
+
+	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
+		/* Unconditionally log net taps. */
+		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
+		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptAll |
AcceptMyPhys;
+	} else if ((dev->mc_count > multicast_filter_limit)
+			   ||  (dev->flags & IFF_ALLMULTI)) {
+		/* Too many to match, or accept all multicasts. */
+		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+	} else if (dev->mc_count) {
+		struct dev_mc_list *mclist;
+		int index;
+
+		for (mclist = dev->mc_list; mclist != NULL; mclist = mclist->next) {
+			index = crc32_le(0xffffffff, mclist->dmi_addr, ETH_ALEN);
+			index = index & 0x3F;
+			mc_filter[index/16] |= (1 << (index % 16));
+		}
+		rx_mode = AcceptBroadcast | AcceptMultiHash | AcceptMyPhys;
+		if (np->mii_if.full_duplex && np->flowctrl)
+			mc_filter[3] |= 0x0200;
+	}
+	for (i = 0; i < 4; i++)
+		iowr16(mc_filter[i], ioaddr + MulticastFilter0 + i*2);
+	iowr8(rx_mode, ioaddr + RxMode);
+}
+
+/* The interrupt handler cleans up after the Tx thread,
+   and schedule a Rx thread work
+ */
+static irqreturn_t intr_handler(int irq, void *dev_instance, struct
pt_regs *rgs)
+{
+	struct net_device *dev = (struct net_device *)dev_instance;
+	struct netdev_private *np=dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int hw_frame_id;
+	int tx_cnt;
+	int tx_status;
+    irqreturn_t intr_handled=IRQ_HANDLED;//IRQ_NONE;
+
+
+	do {
+		int intr_status = iord16(ioaddr + IntrStatus);
+		iowr16(intr_status, ioaddr + IntrStatus);
+
+		if (netif_msg_intr(np))
+			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
+				   dev->name, intr_status);
+
+		if (!(intr_status & DEFAULT_INTR))	break;
+
+		if (intr_status & (IntrRxDMADone)) {
+			iowr16(DEFAULT_INTR & ~(IntrRxDone|IntrRxDMADone),
+					ioaddr + IntrEnable);
+			if (np->budget < 0)	np->budget = RX_BUDGET;
+			tasklet_schedule(&np->rx_tasklet);
+		}
+		if (intr_status & (IntrTxDone | IntrDrvRqst)) {
+			tx_status = iord16 (ioaddr + TxStatus);
+			for (tx_cnt=32; tx_status & 0x80; --tx_cnt) {
+				if (netif_msg_tx_done(np))
+					printk("%s: Transmit status is %2.2x.\n",
+				     	dev->name, tx_status);
+				if (tx_status & 0x1e) {
+					np->stats.tx_errors++;
+					if (tx_status & 0x10) np->stats.tx_fifo_errors++;
+					if (tx_status & 0x08) np->stats.collisions++;
+					if (tx_status & 0x02) np->stats.tx_window_errors++;
+					/* This reset has not been verified!. */
+					if (tx_status & 0x10) {	/* Reset the Tx. */
+						np->stats.tx_fifo_errors++;
+						spin_lock(&np->lock);
+						reset_tx(dev);
+						spin_unlock(&np->lock);
+					}
+					if (tx_status & 0x1e) {
+					/* It could fail to restart the tx when MaxCollions, need to try
more times */
+						int i = 10;
+						do {
+							iowr16 (iord16(ioaddr + MACCtrl1) | TxEnable, ioaddr +
MACCtrl1);
+							if (iord16(ioaddr + MACCtrl1) & TxEnabled) break;
+							mdelay(1);
+						} while (--i);
+					}
+				}
+				/* Yup, this is a documentation bug.  It cost me *hours*. */
+				iowr16 (0, ioaddr + TxStatus);
+				tx_status = iord16 (ioaddr + TxStatus);
+				if (tx_cnt < 0)	break;
+			}
+			hw_frame_id = (tx_status >> 8) & 0xff;
+		} else 	{
+			hw_frame_id = iord8(ioaddr + TxFrameId);
+		}
+
+		if (np->pci_rev_id >= 0x14) {
+			spin_lock(&np->lock);
+			for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+				int entry = np->dirty_tx % TX_RING_SIZE;
+				struct sk_buff *skb;
+				int sw_frame_id;
+				sw_frame_id=(le32_to_cpu(np->tx_ring[entry].status)>> 2) & 0xff;
+				if (sw_frame_id == hw_frame_id &&
+					!(le32_to_cpu(np->tx_ring[entry].status) & 0x00010000)
+				   )
+				   break;
+				if (sw_frame_id == (hw_frame_id + 1) %	TX_RING_SIZE)
+				   break;
+				skb = np->tx_skbuff[entry];
+				/* Free the original skb. */
+				pci_unmap_single(np->pci_dev, np->tx_ring[entry].frag[0].addr,
+					             skb->len, PCI_DMA_TODEVICE);
+				dev_kfree_skb_irq (np->tx_skbuff[entry]);
+				np->tx_skbuff[entry] = 0;
+				np->tx_ring[entry].frag[0].addr = 0;
+				np->tx_ring[entry].frag[0].length = 0;
+			}
+			spin_unlock(&np->lock);
+		} else {
+			spin_lock(&np->lock);
+			for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
+				int entry = np->dirty_tx % TX_RING_SIZE;
+				struct sk_buff *skb;
+				if (!(le32_to_cpu(np->tx_ring[entry].status) & 0x00010000))
+					break;
+				skb = np->tx_skbuff[entry];
+				/* Free the original skb. */
+				pci_unmap_single(np->pci_dev, np->tx_ring[entry].frag[0].addr,
+					             skb->len, PCI_DMA_TODEVICE);
+				dev_kfree_skb_irq (np->tx_skbuff[entry]);
+				np->tx_skbuff[entry] = 0;
+				np->tx_ring[entry].frag[0].addr = 0;
+				np->tx_ring[entry].frag[0].length = 0;
+			}
+			spin_unlock(&np->lock);
+		}
+
+		if (netif_queue_stopped(dev) &&
+			np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
+			/* The ring is no longer full, clear busy flag. */
+			netif_wake_queue (dev);
+		}
+		/* Abnormal error summary/uncommon events handlers. */
+		if (intr_status & (IntrPCIErr | LinkChange | StatsMax))
+			netdev_error(dev, intr_status);
+	} while (0);
+	if (netif_msg_intr(np))
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
+			   dev->name, iord16(ioaddr + IntrStatus));
+	iowr32(5000, ioaddr + DownCounter);
+
+    return intr_handled;
+}
+
+
+static int netdev_open(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int i;
+
+   for(i=0;i<10;i++)
+   {
+   	if(np->ProbeDone==1)break;//For Mandrake10.x multi-cpu
+   	mdelay(1000);
+   }
+	/* Do we need to reset the chip??? */
+
+	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	if (i)		return i;
+
+	if (netif_msg_ifup(np))
+		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
+			   dev->name, dev->irq);
+	init_ring(dev);
+
+	iowr32(np->rx_ring_dma, ioaddr + RxListPtr);
+	/* The Tx list pointer is written as packets are queued. */
+
+	/* Initialize other registers. */
+	__set_mac_addr(dev);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	iowr16(dev->mtu + 18, ioaddr + MaxFrameSize);
+#else
+	iowr16(dev->mtu + 14, ioaddr + MaxFrameSize);
+#endif
+	if (dev->mtu > 2047)
+		iowr32(iord32(ioaddr + ASICCtrl) | 0x0C, ioaddr + ASICCtrl);
+
+	/* Configure the PCI bus bursts and FIFO thresholds. */
+
+	if (dev->if_port == 0)	dev->if_port = np->default_port;
+
+	np->mcastlock = (spinlock_t) SPIN_LOCK_UNLOCKED;
+
+	set_rx_mode(dev);
+	iowr16(0, ioaddr + IntrEnable);
+	iowr16(0, ioaddr + DownCounter);
+	/* Set the chip to poll every N*320nsec. */
+	iowr8(100, ioaddr + RxDMAPollPeriod);
+	iowr8(127, ioaddr + TxDMAPollPeriod);
+	/* Fix DFE-580TX packet drop issue */
+	if (np->pci_rev_id >= 0x14)
+		iowr8(0x01, ioaddr + DebugCtrl1);
+	netif_start_queue(dev);
+
+	// 04/19/2005 Jesse fix for complete initial step
+	spin_lock(&np->lock);
+	reset_tx(dev);
+	spin_unlock(&np->lock);
+	iowr16(0x200, ioaddr + DMACtrl);
+	iowr16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
+
+	if (netif_msg_ifup(np))
+		printk(KERN_DEBUG "%s: Done netdev_open(), status: Rx %x Tx %x "
+			   "MAC Control %x, %4.4x %4.4x.\n",
+			   dev->name, iord32(ioaddr + RxStatus), iord8(ioaddr + TxStatus),
+			   iord32(ioaddr + MACCtrl0),
+			   iord16(ioaddr + MACCtrl1), iord16(ioaddr + MACCtrl0));
+
+	/* Set the timer to check for link beat. */
+	init_timer(&np->timer);
+	np->timer.expires = jiffies + 3*HZ;
+	np->timer.data = (ULONG )dev;
+	np->timer.function = &netdev_timer;				/* timer handler */
+	add_timer(&np->timer);
+
+	/* Enable interrupts by setting the interrupt mask. */
+	iowr16(DEFAULT_INTR, ioaddr + IntrEnable);
+
+	return 0;
+}
+
+
+static void tx_timeout(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	ULONG  flag;
+
+	netif_stop_queue(dev);
+	tasklet_disable(&np->tx_tasklet);
+	iowr16(0, ioaddr + IntrEnable);
+	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
+		   "TxFrameId %2.2x,"
+		   " resetting...\n", dev->name, iord8(ioaddr + TxStatus),
+		   iord8(ioaddr + TxFrameId));
+
+	{
+		int i;
+		for (i=0; i<TX_RING_SIZE; i++) {
+			printk(KERN_DEBUG "%02x %08x %08x %08x(%02x) %08x %08x\n", i,
+				(u32)np->tx_ring_dma + i*sizeof(*np->tx_ring),
+				le32_to_cpu(np->tx_ring[i].next_desc),
+				le32_to_cpu(np->tx_ring[i].status),
+				(le32_to_cpu(np->tx_ring[i].status) >> 2) & 0xff,
+				le32_to_cpu(np->tx_ring[i].frag[0].addr),
+				le32_to_cpu(np->tx_ring[i].frag[0].length));
+		}
+		printk(KERN_DEBUG "TxListPtr=%08x netif_queue_stopped=%d\n",
+			iord32(ioaddr + TxListPtr),
+			netif_queue_stopped(dev));
+		printk(KERN_DEBUG "cur_tx=%d(%02x) dirty_tx=%d(%02x)\n",
+			np->cur_tx, np->cur_tx % TX_RING_SIZE,
+			np->dirty_tx, np->dirty_tx % TX_RING_SIZE);
+		printk(KERN_DEBUG "cur_rx=%d dirty_rx=%d\n", np->cur_rx,
np->dirty_rx);
+		printk(KERN_DEBUG "cur_task=%d\n", np->cur_task);
+	}
+	spin_lock_irqsave(&np->lock, flag);
+
+	/* Stop and restart the chip's Tx processes . */
+	reset_tx(dev);
+	spin_unlock_irqrestore(&np->lock, flag);
+
+	dev->if_port = 0;
+
+	dev->trans_start = jiffies;
+	np->stats.tx_errors++;
+	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
+		netif_wake_queue(dev);
+	}
+	iowr16(DEFAULT_INTR, ioaddr + IntrEnable);
+	tasklet_enable(&np->tx_tasklet);
+}
+
+
+
+
+static void tx_poll ( ULONG data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	unsigned head = np->cur_task % TX_RING_SIZE;
+	struct netdev_desc *txdesc =
+		&np->tx_ring[(np->cur_tx - 1) % TX_RING_SIZE];
+
+	/* Chain the next pointer */
+	for (; np->cur_tx - np->cur_task > 0; np->cur_task++) {
+		int entry = np->cur_task % TX_RING_SIZE;
+		txdesc = &np->tx_ring[entry];
+		if (np->last_tx) {
+			np->last_tx->next_desc = cpu_to_le32(np->tx_ring_dma +
+				entry*sizeof(struct netdev_desc));
+		}
+		np->last_tx = txdesc;
+	}
+	/* Indicate the latest descriptor of tx ring */
+	txdesc->status |= cpu_to_le32(DescIntrOnTx);
+
+	if (iord32 (ioaddr + TxListPtr) == 0)
+		iowr32 (np->tx_ring_dma + head * sizeof(struct netdev_desc),
+			ioaddr + TxListPtr);
+	return;
+}
+
+static int
+start_tx (struct sk_buff *skb, struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	struct netdev_desc *txdesc;
+	unsigned entry;
+
+	/* Calculate the next Tx descriptor entry. */
+	entry = np->cur_tx % TX_RING_SIZE;
+	np->tx_skbuff[entry] = skb;
+	txdesc = &np->tx_ring[entry];
+
+	txdesc->next_desc = 0;
+	txdesc->status = cpu_to_le32 ((entry << 2) | DisableAlign);
+	txdesc->frag[0].addr = cpu_to_le32 (pci_map_single (np->pci_dev,
skb->data,
+							skb->len,
+							PCI_DMA_TODEVICE));
+	txdesc->frag[0].length = cpu_to_le32 (skb->len | LastFrag);
+
+	/* Increment cur_tx before tasklet_schedule() */
+	np->cur_tx++;
+	mb();
+	/* Schedule a tx_poll() task */
+	tasklet_schedule(&np->tx_tasklet);
+
+	/* On some architectures: explicitly flush cache lines here. */
+	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1
+			&& !netif_queue_stopped(dev)) {
+		/* do nothing */
+	} else {
+		netif_stop_queue (dev);
+	}
+	dev->trans_start = jiffies;
+	if (netif_msg_tx_queued(np)) {
+		printk (KERN_DEBUG
+			"%s: Transmit frame #%d queued in slot %d.\n",
+			dev->name, np->cur_tx, entry);
+	}
+	return 0;
+}
+
+static void refill_rx (struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	int entry;
+	int cnt = 0;
+
+	/* Refill the Rx ring buffers. */
+	for (;(np->cur_rx - np->dirty_rx + RX_RING_SIZE) % RX_RING_SIZE > 0;
+		np->dirty_rx = (np->dirty_rx + 1) % RX_RING_SIZE) {
+		struct sk_buff *skb;
+		entry = np->dirty_rx % RX_RING_SIZE;
+		if (np->rx_skbuff[entry] == NULL) {
+			skb = dev_alloc_skb(np->rx_buf_sz);
+			np->rx_skbuff[entry] = skb;
+			if (skb == NULL)
+				break;		/* Better luck next round. */
+			skb->dev = dev;		/* Mark as being used by this device. */
+			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
+			np->rx_ring[entry].frag[0].addr = cpu_to_le32(
+				pci_map_single(np->pci_dev, skb->tail,
+					np->rx_buf_sz, PCI_DMA_FROMDEVICE));
+		}
+		/* Perhaps we need not reset this field. */
+		np->rx_ring[entry].frag[0].length =
+			cpu_to_le32(np->rx_buf_sz | LastFrag);
+		np->rx_ring[entry].status = 0;
+		cnt++;
+	}
+	return;
+}
+
+static void rx_poll( ULONG  data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct netdev_private *np = dev->priv;
+	int entry = np->cur_rx % RX_RING_SIZE;
+	int boguscnt = np->budget;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	int received = 0;
+
+	/* If EOP is set on the next entry, it's a new packet. Send it up. */
+	while (1) {
+		struct netdev_desc *desc = &(np->rx_ring[entry]);
+		u32 frame_status = le32_to_cpu(desc->status);
+		int pkt_len;
+
+		if (--boguscnt < 0) {
+			goto not_done;
+		}
+		if (!(frame_status & DescOwn))
+			break;
+		pkt_len = frame_status & 0x1fff;	/* Chip omits the CRC. */
+		if (netif_msg_rx_status(np))
+			printk(KERN_DEBUG "  netdev_rx() status was %8.8x.\n",
+				   frame_status);
+
+		if (frame_status & 0x001f4000) {
+			/* There was a error. */
+			if (netif_msg_rx_err(np))
+				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",
+					   frame_status);
+			np->stats.rx_errors++;
+			if (frame_status & 0x00100000) np->stats.rx_length_errors++;
+			if (frame_status & 0x00010000) np->stats.rx_fifo_errors++;
+			if (frame_status & 0x00060000) np->stats.rx_frame_errors++;
+			if (frame_status & 0x00080000) np->stats.rx_crc_errors++;
+			if (frame_status & 0x00100000) {
+				printk(KERN_WARNING "%s: Oversized Ethernet frame,"
+					   " status %8.8x.\n",
+					   dev->name, frame_status);
+			}
+		} else {
+			struct sk_buff *skb;
+#ifndef final_version
+			if (netif_msg_rx_status(np))
+				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
+					   ", bogus_cnt %d.\n",
+					   pkt_len, boguscnt);
+#endif
+			/* Check if the packet is long enough to accept without copying
+			   to a minimally-sized skbuff. */
+			if (pkt_len < rx_copybreak
+				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
+				skb->dev = dev;
+				skb_reserve(skb, 2);	/* 16 byte align the IP header */
+				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
+				skb_put(skb, pkt_len);
+			} else {
+				pci_unmap_single(np->pci_dev,
+					desc->frag[0].addr,
+					np->rx_buf_sz,
+					PCI_DMA_FROMDEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				np->rx_skbuff[entry] = NULL;
+			}
+			skb->protocol = eth_type_trans(skb, dev);
+			/* Note: checksum -> skb->ip_summed = CHECKSUM_UNNECESSARY; */
+			netif_rx(skb);
+			dev->last_rx = jiffies;
+		}
+		entry = (entry + 1) % RX_RING_SIZE;
+		received++;
+	}
+	np->cur_rx = entry;
+	refill_rx (dev);
+	np->budget -= received;
+	iowr16(DEFAULT_INTR, ioaddr + IntrEnable);
+	return;
+
+not_done:
+	np->cur_rx = entry;
+	refill_rx (dev);
+	if (!received)
+		received = 1;
+	np->budget -= received;
+	if (np->budget <= 0)  np->budget = RX_BUDGET;
+	tasklet_schedule(&np->rx_tasklet);
+	return;
+}
+
+
+
+static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int
cmd)
+{
+	struct netdev_private *np = dev->priv;
+	struct mii_ioctl_data *data = if_mii(rq);
+	int rc;
+
+	mutex_lock(&np->mii_mutex);
+	rc = generic_mii_ioctl(&np->mii_if, data, cmd, NULL);
+	mutex_unlock(&np->mii_mutex);
+
+	return rc;
+}
+
+
+static int netdev_close(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	void __iomem * ioaddr = ipf_ioaddr(dev);
+	struct sk_buff *skb;
+	int i;
+
+	/* Wait and kill tasklet */
+	tasklet_kill(&np->rx_tasklet);
+	tasklet_kill(&np->tx_tasklet);
+   np->cur_tx = np->dirty_tx = 0;
+	np->cur_task = 0;
+	np->last_tx=0;
+
+	netif_stop_queue(dev);
+
+	if (netif_msg_ifdown(np)) {
+		printk(KERN_DEBUG "%s: Shutting down ethercard, status was Tx %2.2x "
+			   "Rx %4.4x Int %2.2x.\n",
+			   dev->name, iord8(ioaddr + TxStatus),
+			   iord32(ioaddr + RxStatus), iord16(ioaddr + IntrStatus));
+		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %
d.\n",
+			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
+	}
+
+	/* Stop the chip's Rx processes. */
+	iowr16(RxDisable | StatsDisable, ioaddr + MACCtrl1);
+	iowr16(0x100, ioaddr + DMACtrl);
+
+	/* Stop the chip's Tx processes. */
+	iowr16(0x400, ioaddr + DMACtrl);
+	iowr16(TxDisable, ioaddr + MACCtrl1);
+
+	/* Disable interrupts by clearing the interrupt mask. */
+	iowr16(0x0000, ioaddr + IntrEnable);
+
+    for(i=2000;i> 0;i--) {
+		if((iord32(ioaddr + DMACtrl)&0xC000) == 0)break;
+		mdelay(1);
+    }
+
+    iowr16(GlobalReset | DMAReset | FIFOReset |NetworkReset, ioaddr
+ASICCtrl + 2);
+
+    for(i=2000;i >0;i--)
+    {
+		if((iord16(ioaddr + ASICCtrl +2)&ResetBusy) == 0)
+	    	break;
+		mdelay(1);
+    }
+
+#ifdef __i386__
+	if (netif_msg_hw(np)) {
+		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
+			   (int)(np->tx_ring_dma));
+		for (i = 0; i < TX_RING_SIZE; i++)
+			printk(" #%d desc. %4.4x %8.8x %8.8x.\n",
+				   i, np->tx_ring[i].status, np->tx_ring[i].frag[0].addr,
+				   np->tx_ring[i].frag[0].length);
+		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
+			   (int)(np->rx_ring_dma));
+		for (i = 0; i < /*RX_RING_SIZE*/4 ; i++) {
+			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x\n",
+				   i, np->rx_ring[i].status, np->rx_ring[i].frag[0].addr,
+				   np->rx_ring[i].frag[0].length);
+		}
+	}
+#endif /* __i386__ debugging only */
+
+	free_irq(dev->irq, dev);
+
+	del_timer_sync(&np->timer);
+
+	/* Free all the skbuffs in the Rx queue. */
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		np->rx_ring[i].status = 0;
+		np->rx_ring[i].frag[0].addr = 0xBADF00D0; /* An invalid address. */
+		skb = np->rx_skbuff[i];
+		if (skb) {
+			pci_unmap_single(np->pci_dev,
+				np->rx_ring[i].frag[0].addr, np->rx_buf_sz,
+				PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(skb);
+			np->rx_skbuff[i] = 0;
+		}
+	}
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		np->tx_ring[i].next_desc=0;
+
+		skb = np->tx_skbuff[i];
+		if (skb) {
+			pci_unmap_single(np->pci_dev,
+				np->tx_ring[i].frag[0].addr, skb->len,
+				PCI_DMA_TODEVICE);
+			dev_kfree_skb(skb);
+			np->tx_skbuff[i] = 0;
+		}
+	}
+
+	return 0;
+}
+
+
+
+static int __devinit ipf_probe1 (struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
+{
+	struct net_device *dev;
+	struct netdev_private *np;
+	static int card_idx;
+	int chip_idx = ent->driver_data;
+	int irq;
+	int i;
+	void __iomem *ioaddr;
+	u16 mii_ctl,mii_avt;
+	void *ring_space;
+	dma_addr_t ring_dma;
+
+	int rc;
+
+
+	rc = pci_enable_device(pdev);
+	if (rc < 0) return rc;
+
+	printk(KERN_INFO "%s: %s\n", pci_name(pdev),
pci_id_tbl[chip_idx].name);
+
+	pci_set_master(pdev);
+
+	irq = pdev->irq;
+	/* Initialize net device */
+	dev = alloc_etherdev(sizeof(*np));
+	if (!dev) {
+		printk(KERN_ERR "%s: alloc_etherdev failed\n", pci_name(pdev));
+		rc = -ENOMEM;
+		goto err_disable_0;
+	}
+
+	/* The chip-specific entries in the device structure. */
+	dev->open = &netdev_open;
+	dev->hard_start_xmit = &start_tx;
+	dev->stop = &netdev_close;
+	dev->get_stats = &get_stats;
+	dev->set_multicast_list = &set_rx_mode;
+	dev->do_ioctl = netdev_ioctl;
+	dev->tx_timeout = &tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+	dev->change_mtu = &change_mtu;
+
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_ETHTOOL_OPS(dev, &ipf_ethtool_ops);
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)	goto err_out_netdev;
+
+#ifdef USE_IO_OPS
+	ioaddr = (void __iomem*)(pci_resource_start(pdev,
0)&0xffffff80);////20040826Jesse_mask_BaseAddr:Mask IOBaseAddr[bit0~6]
+#else
+	ioaddr = pci_iomap(pdev, 1, pci_resource_len(pdev, 1));
+	if (!ioaddr)
+	{
+		printk(KERN_ERR"%s: can't map MMIO\n", pci_name(pdev));
+		rc = -EIO;
+		goto err_out_res;
+	}
+#endif
+
+	for (i = 0; i < 3; i++)
+		((u16 *)dev->dev_addr)[i] =
+			le16_to_cpu(eeprom_read(ioaddr, i + EEPROM_SA_OFFSET));
+
+	dev->irq = irq;
+
+	np = dev->priv;
+    np->ioaddr = ioaddr;
+	np->ProbeDone=0;//For Mandrake10.x multi-cpu
+	np->pci_dev = pdev;
+
+	np->msg_enable = (1 << debug) - 1;
+	spin_lock_init(&np->lock);
+	mutex_init(&np->mii_mutex);
+
+	tasklet_init(&np->rx_tasklet, rx_poll, (ULONG )dev);
+	tasklet_init(&np->tx_tasklet, tx_poll, (ULONG )dev);
+
+	rc = -ENOMEM;
+	ring_space = pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
+
+	if (!ring_space)  goto err_out_cleardev;
+	np->tx_ring = (struct netdev_desc *)ring_space;
+	np->tx_ring_dma = ring_dma;
+
+	ring_space = pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
+
+	if (!ring_space) goto err_out_unmap_tx;
+	np->rx_ring = (struct netdev_desc *)ring_space;
+	np->rx_ring_dma = ring_dma;
+
+	np->mii_if.dev = dev;
+	np->mii_if.mdio_read = mdio_read;
+	np->mii_if.mdio_write = mdio_write;
+	np->mii_if.phy_id_mask = 0x1f;
+	np->mii_if.reg_num_mask = 0x1f;
+
+
+	pci_set_drvdata(pdev, dev);
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &np->pci_rev_id);
+
+	i = register_netdev(dev);
+	if (i)	goto err_out_unmap_rx;
+
+	printk(KERN_INFO "%s: %s at 0x%lx, ",
+		   dev->name, pci_id_tbl[chip_idx].name, (long)ioaddr);
+
+	for (i = 0; i < 5; i++)	printk("%2.2x:", dev->dev_addr[i]);
+	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
+
+	if (1) {
+		int phy, phy_idx = 0;
+		np->phys[0] = 1;		/* Default setting */
+		np->mii_preamble_required++;
+		//for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {//Modify by
Jesse
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
+			int mii_status = mdio_read(dev, phy, MII_BMSR);
+			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+				np->phys[phy_idx++] = phy;
+				np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
+				if ((mii_status & 0x0040) == 0)
+					np->mii_preamble_required++;
+				printk(KERN_INFO "%s: MII PHY found at address %d, status "
+					   "0x%4.4x advertising %4.4x.\n",
+					   dev->name, phy, mii_status, np->mii_if.advertising);
+			}
+		}
+		np->mii_preamble_required--;
+
+		if (phy_idx == 0) {
+			printk(KERN_INFO "%s: No MII transceiver found, aborting.  ASIC
status %x\n",
+				   dev->name, iord32(ioaddr + ASICCtrl));
+			goto err_out_unregister;
+		}
+
+		np->mii_if.phy_id = np->phys[0];
+	}
+
+	/* Parse override configuration */
+	np->an_enable = 1;
+	if (card_idx < MAX_UNITS) {
+		if (media[card_idx] != NULL) {
+			np->an_enable = 0;
+			if (strcmp (media[card_idx], "100mbps_fd") == 0 ||
+			    strcmp (media[card_idx], "4") == 0) {
+				np->speed = 100;
+				np->mii_if.full_duplex = 1;
+			} else if (strcmp (media[card_idx], "100mbps_hd") == 0
+				   || strcmp (media[card_idx], "3") == 0) {
+				np->speed = 100;
+				np->mii_if.full_duplex = 0;
+			} else if (strcmp (media[card_idx], "10mbps_fd") == 0 ||
+				   strcmp (media[card_idx], "2") == 0) {
+				np->speed = 10;
+				np->mii_if.full_duplex = 1;
+			} else if (strcmp (media[card_idx], "10mbps_hd") == 0 ||
+				   strcmp (media[card_idx], "1") == 0) {
+				np->speed = 10;
+				np->mii_if.full_duplex = 0;
+			} else {
+				np->an_enable = 1;
+			}
+		}
+		if (flowctrl == 1)
+			np->flowctrl = 1;
+	}
+
+	/* Fibre PHY? */
+	if (iord32 (ioaddr + ASICCtrl) & 0x80) {
+		/* Default 100Mbps Full */
+		if (np->an_enable) {
+			np->speed = 100;
+			np->mii_if.full_duplex = 1;
+			np->an_enable = 0;
+		}
+	}
+	/* Reset PHY */
+	mdio_write (dev, np->phys[0], MII_BMCR, BMCR_RESET);
+	mdelay (300);
+	/* If flow control enabled, we need to advertise it.*/
+	if (np->flowctrl)
+		mdio_write (dev, np->phys[0], MII_ADVERTISE, np->mii_if.advertising |
0x0400);
+	//mdio_write (dev, np->phys[0], MII_BMCR, BMCR_ANENABLE|
BMCR_ANRESTART);//20040817Jesse_ChangeSpeed: Remove
+	/* Force media type */
+	if (!np->an_enable) {
+		mii_ctl=(mdio_read(dev,np->phys[0],MII_BMCR)&0x0000ffff);
+
mii_avt=(mdio_read(dev,np->phys[0],MII_ADVERTISE)&~(ADVERTISE_100FULL
+ADVERTISE_100HALF+ADVERTISE_10FULL+ADVERTISE_10HALF));
+        if(np->speed==100)
+		{
+		   mii_avt|
=(np->mii_if.full_duplex)?ADVERTISE_100FULL:ADVERTISE_100HALF;
+		}
+		else
+		{
+		   mii_avt|
=(np->mii_if.full_duplex)?ADVERTISE_10FULL:ADVERTISE_10HALF;
+		}
+                mdio_write(dev,np->phys[0],MII_ADVERTISE,mii_avt);
+                mdio_write(dev,np->phys[0],MII_BMCR,mii_ctl|0x1000|
0x200);
+	}
+	else
+   {
+	mdio_write (dev, np->phys[0], MII_BMCR, BMCR_ANENABLE|
BMCR_ANRESTART);//20040817Jesse_ChangeSpeed: move to here
+   }
+   //20040817Jesse_ChangeSpeed: Add
+   for(i=1000;i;i--)
+   {
+	   mdelay(1);
+      if(mdio_read(dev,np->phys[0],MII_BMSR)&0x20)break;
+   }
+
+	/* Perhaps move the reset here? */
+	/* Reset the chip to erase previous misconfiguration. */
+	if (netif_msg_hw(np))
+		printk("ASIC Control is %x.\n", iord32(ioaddr + ASICCtrl));
+
+	iowr16(0x00ff, ioaddr + ASICCtrl + 2);
+	if (netif_msg_hw(np))
+		printk("ASIC Control is now %x.\n", iord32(ioaddr + ASICCtrl));
+
+	card_idx++;
+	np->ProbeDone=1;//For Mandrake10.x multi-cpu
+	return 0;
+
+err_out_unregister:
+	unregister_netdev(dev);
+err_out_unmap_rx:
+        pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring,
np->rx_ring_dma);
+err_out_unmap_tx:
+        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring,
np->tx_ring_dma);
+err_out_cleardev:
+	pci_set_drvdata(pdev, NULL);
+#ifndef USE_IO_OPS
+	pci_iounmap(pdev, ioaddr);
+err_out_res:
+#endif
+	pci_release_regions(pdev);
+err_out_netdev:
+	free_netdev(dev);        // kfree (dev);
+err_disable_0:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+
+static void __devexit ipf_remove1 (struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
+	if (dev) {
+		struct netdev_private *np = dev->priv;
+
+		unregister_netdev(dev);
+        	pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring,
+			np->rx_ring_dma);
+	        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring,
+			np->tx_ring_dma);
+		pci_release_regions(pdev);
+#ifndef USE_IO_OPS
+		pci_iounmap(pdev, np->ioaddr);
+#endif
+		kfree(dev);
+		pci_set_drvdata(pdev, NULL);
+	}
+}
+
+static struct pci_driver ipf_driver = {
+	.name		= DRV_NAME,
+	.id_table	= ipf_pci_tbl,
+	.probe		= ipf_probe1,
+	.remove		= __devexit_p(ipf_remove1),
+};
+
+static int __init ipf_init(void)
+{
+/* when a module, this is printed whether or not devices are found in
probe */
+#ifdef MODULE
+	printk(version);
+#endif
+	return pci_module_init(&ipf_driver);
+}
+
+static void __exit ipf_exit(void)
+{
+	pci_unregister_driver(&ipf_driver);
+}
+
+module_init(ipf_init);
+module_exit(ipf_exit);
+
 
diff --git a/drivers/net/ipf.h b/drivers/net/ipf.h
index 8b13789..0d9d578 100644
--- a/drivers/net/ipf.h
+++ b/drivers/net/ipf.h
@@ -1 +1,266 @@
-
+/*
+ *
+ * ipf.h
+ *
+ * Include file for IP100A Fast Ethernet device driver by
+ * utilizing the IC Plus Corp. IP100A  Controller.
+ */
+
+/* Include files, designed to support most kernel versions 2.0.0 and
later. */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/version.h>
+#include <asm/uaccess.h>
+#include <asm/processor.h>		/* Processor type for cache alignment. */
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+
+#include <linux/crc32.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+
+typedef unsigned int 	UINT;
+typedef int 			INT;
+typedef unsigned char 	UCHAR;
+typedef char 			CHAR;
+typedef unsigned long 	ULONG;
+typedef long 			LONG;
+
+/* Default parameters' value */
+#define TX_RING_SIZE	32
+#define TX_QUEUE_LEN	(TX_RING_SIZE - 1) /* Limit ring entries actually
used.  */
+#define RX_RING_SIZE	64
+#define RX_BUDGET	32
+#define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
+#define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)
+
+/* Operational parameters that usually are not changed. */
+/* Time in jiffies before concluding the transmitter is hung. */
+#define TX_TIMEOUT  (4*HZ)
+#define PKT_BUF_SZ		1536	/* Size of each temporary Rx buffer.*/
+
+#ifdef USE_IO_OPS
+#define iord8(addr)		inb((unsigned long __force) addr)
+#define iord16(addr)	inw((unsigned long __force) addr)
+#define iord32(addr)	inl((unsigned long __force) addr)
+#define iowr8(val, addr)	outb(val, (unsigned long __force) addr)
+#define iowr16(val, addr)	outw(val, (unsigned long __force) addr)
+#define iowr32(val, addr)	outl(val, (unsigned long __force) addr)
+#else
+#define iord8(addr)		readb(addr)
+#define iord16(addr)	readw(addr)
+#define iord32(addr)	readl(addr)
+#define iowr8(val, addr)	writeb(val, addr)
+#define iowr16(val, addr)	writew(val, addr)
+#define iowr32(val, addr)	writel(val, addr)
+#endif
+
+
+static struct pci_device_id ipf_pci_tbl[] __devinitdata = {
+	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
+	{0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
+	{0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
+	{0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
+	{0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
+	{0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, ipf_pci_tbl);
+
+enum {
+	netdev_io_size = 128
+};
+
+struct pci_id_info {
+        const char *name;
+};
+
+static struct pci_id_info pci_id_tbl[] = {
+	{"D-Link DFE-550TX FAST Ethernet Adapter"},
+	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},
+	{"D-Link DFE-580TX 4 port Server Adapter"},
+	{"D-Link DFE-530TXS FAST Ethernet Adapter"},
+	{"D-Link DL10050-based FAST Ethernet Adapter"},
+    {"IC Plus IP100 Fast Ethernet Adapter"},
+    {"IC Plus IP100A Fast Ethernet Adapter" },
+	{0,},			/* 0 terminated list. */
+};
+
+
+/* IO register Offsets */
+enum alta_offsets {
+	DMACtrl = 0x00,
+	TxListPtr = 0x04,
+	TxDMABurstThresh = 0x08,
+	TxDMAUrgentThresh = 0x09,
+	TxDMAPollPeriod = 0x0a,
+	RxDMAStatus = 0x0c,
+	RxListPtr = 0x10,
+	DebugCtrl0 = 0x1a,
+	DebugCtrl1 = 0x1c,
+	RxDMABurstThresh = 0x14,
+	RxDMAUrgentThresh = 0x15,
+	RxDMAPollPeriod = 0x16,
+	LEDCtrl = 0x1a,
+	ASICCtrl = 0x30,
+	EEData = 0x34,
+	EECtrl = 0x36,
+	TxStartThresh = 0x3c,
+	RxEarlyThresh = 0x3e,
+	FlashAddr = 0x40,
+	FlashData = 0x44,
+	TxStatus = 0x46,
+	TxFrameId = 0x47,
+	DownCounter = 0x18,
+	IntrClear = 0x4a,
+	IntrEnable = 0x4c,
+	IntrStatus = 0x4e,
+	MACCtrl0 = 0x50,
+	MACCtrl1 = 0x52,
+	StationAddr = 0x54,
+	MaxFrameSize = 0x5A,
+	RxMode = 0x5c,
+	MIICtrl = 0x5e,
+	MulticastFilter0 = 0x60,
+	MulticastFilter1 = 0x64,
+	RxOctetsLow = 0x68,
+	RxOctetsHigh = 0x6a,
+	TxOctetsLow = 0x6c,
+	TxOctetsHigh = 0x6e,
+	TxFramesOK = 0x70,
+	RxFramesOK = 0x72,
+	StatsCarrierError = 0x74,
+	StatsLateColl = 0x75,
+	StatsMultiColl = 0x76,
+	StatsOneColl = 0x77,
+	StatsTxDefer = 0x78,
+	RxMissed = 0x79,
+	StatsTxXSDefer = 0x7a,
+	StatsTxAbort = 0x7b,
+	StatsBcastTx = 0x7c,
+	StatsBcastRx = 0x7d,
+	StatsMcastTx = 0x7e,
+	StatsMcastRx = 0x7f,
+	/* Aliased and bogus values! */
+	RxStatus = 0x0c,
+};
+enum ASICCtrl_HiWord_bit {
+	GlobalReset = 0x0001,
+	RxReset = 0x0002,
+	TxReset = 0x0004,
+	DMAReset = 0x0008,
+	FIFOReset = 0x0010,
+	NetworkReset = 0x0020,
+	HostReset = 0x0040,
+	ResetBusy = 0x0400,
+};
+
+/* Bits in the interrupt status/mask registers. */
+enum intr_status_bits {
+	IntrSummary=0x0001, IntrPCIErr=0x0002, IntrMACCtrl=0x0008,
+	IntrTxDone=0x0004, IntrRxDone=0x0010, IntrRxStart=0x0020,
+	IntrDrvRqst=0x0040,
+	StatsMax=0x0080, LinkChange=0x0100,
+	IntrTxDMADone=0x0200, IntrRxDMADone=0x0400,
+};
+
+/* Bits in the RxMode register. */
+enum rx_mode_bits {
+	AcceptAllIPMulti=0x20, AcceptMultiHash=0x10, AcceptAll=0x08,
+	AcceptBroadcast=0x04, AcceptMulticast=0x02, AcceptMyPhys=0x01,
+};
+/* Bits in MACCtrl. */
+enum mac_ctrl0_bits {
+	EnbFullDuplex=0x20, EnbRcvLargeFrame=0x40,
+	EnbFlowCtrl=0x100, EnbPassRxCRC=0x200,
+};
+enum mac_ctrl1_bits {
+	StatsEnable=0x0020,	StatsDisable=0x0040, StatsEnabled=0x0080,
+	TxEnable=0x0100, TxDisable=0x0200, TxEnabled=0x0400,
+	RxEnable=0x0800, RxDisable=0x1000, RxEnabled=0x2000,
+};
+
+/* The Rx and Tx buffer descriptors. */
+/* Note that using only 32 bit fields simplifies conversion to
big-endian
+   architectures. */
+struct netdev_desc {
+	u32 next_desc;
+	u32 status;
+	struct desc_frag { u32 addr, length; } frag[1];
+};
+
+/* Bits in netdev_desc.status */
+enum desc_status_bits {
+	DescOwn=0x8000,
+	DescEndPacket=0x4000,
+	DescEndRing=0x2000,
+	LastFrag=0x80000000,
+	DescIntrOnTx=0x8000,
+	DescIntrOnDMADone=0x80000000,
+	DisableAlign = 0x00000001,
+};
+
+#define PRIV_ALIGN	15 	/* Required alignment mask */
+/* Use  __attribute__((aligned (L1_CACHE_BYTES)))  to maintain
alignment
+   within the structure. */
+#define MII_CNT		4
+struct netdev_private {
+	void __iomem   *ioaddr; 	// io base address
+	/* Descriptor rings first for alignment. */
+	struct netdev_desc *rx_ring;
+	struct netdev_desc *tx_ring;
+	struct sk_buff* rx_skbuff[RX_RING_SIZE];
+	struct sk_buff* tx_skbuff[TX_RING_SIZE];
+        dma_addr_t tx_ring_dma;
+        dma_addr_t rx_ring_dma;
+	struct net_device_stats stats;
+	struct timer_list timer;		/* Media monitoring timer. */
+	/* Frequently used values: keep some adjacent for cache effect. */
+	spinlock_t lock;
+	spinlock_t rx_lock;			/* Group with Tx control cache line. */
+	INT  msg_enable;
+	UINT cur_rx, dirty_rx;		/* Producer/consumer ring indices */
+	UINT rx_buf_sz;			/* Based on MTU+slack. */
+	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
+	UINT cur_tx, dirty_tx;
+	/* These values are keep track of the transceiver/media in use. */
+	UINT flowctrl:1;
+	UINT default_port:4;		/* Last dev->if_port value. */
+	UINT an_enable:1;
+	UINT speed;
+	struct tasklet_struct rx_tasklet;
+	struct tasklet_struct tx_tasklet;
+	INT budget;
+	INT cur_task;
+	/* Multicast and receive mode. */
+	spinlock_t mcastlock;			/* SMP lock multicast updates. */
+	u16 mcast_filter[4];
+	/* MII transceiver section. */
+	struct mutex	   mii_mutex;
+	struct mii_if_info mii_if;
+
+	INT mii_preamble_required;
+	UCHAR phys[MII_CNT];		/* MII device address, only first one used.*/
+	struct pci_dev *pci_dev;
+	UCHAR pci_rev_id;
+	UCHAR ProbeDone;
+};
+
+/* The station address location in the EEPROM. */
+#define EEPROM_SA_OFFSET	0x10
+#define DEFAULT_INTR       (IntrRxDMADone|IntrPCIErr|IntrDrvRqst|
IntrTxDone|\
+                            StatsMax|LinkChange)
-- 
1.3.GIT



