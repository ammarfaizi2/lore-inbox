Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUIMXbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUIMXbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269069AbUIMXbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:31:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:25763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269063AbUIMXac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:30:32 -0400
Date: Mon, 13 Sep 2004 16:30:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: Pekka Pietikainen <pp@ee.oulu.fi>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Fix for b44 warnings.
Message-Id: <20040913163001.7fa560c6@dell_ss3.pdx.osdl.net>
In-Reply-To: <200408292218.00756.jolt@tuxbox.org>
References: <200408292218.00756.jolt@tuxbox.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

B44 driver was using unsigned long as an io memory address.
Recent changes caused this to be a warning.  This patch fixes that
and makes the readl/writel wrapper into inline's instead of macros
with magic variable side effect (yuck).

diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	2004-09-13 15:33:00 -07:00
+++ b/drivers/net/b44.c	2004-09-13 15:33:00 -07:00
@@ -98,13 +98,24 @@
 static void b44_init_rings(struct b44 *);
 static void b44_init_hw(struct b44 *);
 
+static inline unsigned long br32(const struct b44 *bp, unsigned long reg)
+{
+	return readl(bp->regs + reg);
+}
+
+static inline void bw32(const struct b44 *bp, 
+			unsigned long reg, unsigned long val)
+{
+	writel(val, bp->regs + reg);
+}
+
 static int b44_wait_bit(struct b44 *bp, unsigned long reg,
 			u32 bit, unsigned long timeout, const int clear)
 {
 	unsigned long i;
 
 	for (i = 0; i < timeout; i++) {
-		u32 val = br32(reg);
+		u32 val = br32(bp, reg);
 
 		if (clear && !(val & bit))
 			break;
@@ -168,7 +179,7 @@
 
 static u32 ssb_get_core_rev(struct b44 *bp)
 {
-	return (br32(B44_SBIDHIGH) & SBIDHIGH_RC_MASK);
+	return (br32(bp, B44_SBIDHIGH) & SBIDHIGH_RC_MASK);
 }
 
 static u32 ssb_pci_setup(struct b44 *bp, u32 cores)
@@ -180,13 +191,13 @@
 			       ssb_get_addr(bp, SBID_REG_PCI, 0));
 	pci_rev = ssb_get_core_rev(bp);
 
-	val = br32(B44_SBINTVEC);
+	val = br32(bp, B44_SBINTVEC);
 	val |= cores;
-	bw32(B44_SBINTVEC, val);
+	bw32(bp, B44_SBINTVEC, val);
 
-	val = br32(SSB_PCI_TRANS_2);
+	val = br32(bp, SSB_PCI_TRANS_2);
 	val |= SSB_PCI_PREF | SSB_PCI_BURST;
-	bw32(SSB_PCI_TRANS_2, val);
+	bw32(bp, SSB_PCI_TRANS_2, val);
 
 	pci_write_config_dword(bp->pdev, SSB_BAR0_WIN, bar_orig);
 
@@ -195,18 +206,18 @@
 
 static void ssb_core_disable(struct b44 *bp)
 {
-	if (br32(B44_SBTMSLOW) & SBTMSLOW_RESET)
+	if (br32(bp, B44_SBTMSLOW) & SBTMSLOW_RESET)
 		return;
 
-	bw32(B44_SBTMSLOW, (SBTMSLOW_REJECT | SBTMSLOW_CLOCK));
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_REJECT | SBTMSLOW_CLOCK));
 	b44_wait_bit(bp, B44_SBTMSLOW, SBTMSLOW_REJECT, 100000, 0);
 	b44_wait_bit(bp, B44_SBTMSHIGH, SBTMSHIGH_BUSY, 100000, 1);
-	bw32(B44_SBTMSLOW, (SBTMSLOW_FGC | SBTMSLOW_CLOCK |
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_FGC | SBTMSLOW_CLOCK |
 			    SBTMSLOW_REJECT | SBTMSLOW_RESET));
-	br32(B44_SBTMSLOW);
+	br32(bp, B44_SBTMSLOW);
 	udelay(1);
-	bw32(B44_SBTMSLOW, (SBTMSLOW_REJECT | SBTMSLOW_RESET));
-	br32(B44_SBTMSLOW);
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_REJECT | SBTMSLOW_RESET));
+	br32(bp, B44_SBTMSLOW);
 	udelay(1);
 }
 
@@ -215,31 +226,31 @@
 	u32 val;
 
 	ssb_core_disable(bp);
-	bw32(B44_SBTMSLOW, (SBTMSLOW_RESET | SBTMSLOW_CLOCK | SBTMSLOW_FGC));
-	br32(B44_SBTMSLOW);
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_RESET | SBTMSLOW_CLOCK | SBTMSLOW_FGC));
+	br32(bp, B44_SBTMSLOW);
 	udelay(1);
 
 	/* Clear SERR if set, this is a hw bug workaround.  */
-	if (br32(B44_SBTMSHIGH) & SBTMSHIGH_SERR)
-		bw32(B44_SBTMSHIGH, 0);
+	if (br32(bp, B44_SBTMSHIGH) & SBTMSHIGH_SERR)
+		bw32(bp, B44_SBTMSHIGH, 0);
 
-	val = br32(B44_SBIMSTATE);
+	val = br32(bp, B44_SBIMSTATE);
 	if (val & (SBIMSTATE_IBE | SBIMSTATE_TO))
-		bw32(B44_SBIMSTATE, val & ~(SBIMSTATE_IBE | SBIMSTATE_TO));
+		bw32(bp, B44_SBIMSTATE, val & ~(SBIMSTATE_IBE | SBIMSTATE_TO));
 
-	bw32(B44_SBTMSLOW, (SBTMSLOW_CLOCK | SBTMSLOW_FGC));
-	br32(B44_SBTMSLOW);
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_CLOCK | SBTMSLOW_FGC));
+	br32(bp, B44_SBTMSLOW);
 	udelay(1);
 
-	bw32(B44_SBTMSLOW, (SBTMSLOW_CLOCK));
-	br32(B44_SBTMSLOW);
+	bw32(bp, B44_SBTMSLOW, (SBTMSLOW_CLOCK));
+	br32(bp, B44_SBTMSLOW);
 	udelay(1);
 }
 
 static int ssb_core_unit(struct b44 *bp)
 {
 #if 0
-	u32 val = br32(B44_SBADMATCH0);
+	u32 val = br32(bp, B44_SBADMATCH0);
 	u32 base;
 
 	type = val & SBADMATCH0_TYPE_MASK;
@@ -263,7 +274,7 @@
 
 static int ssb_is_core_up(struct b44 *bp)
 {
-	return ((br32(B44_SBTMSLOW) & (SBTMSLOW_RESET | SBTMSLOW_REJECT | SBTMSLOW_CLOCK))
+	return ((br32(bp, B44_SBTMSLOW) & (SBTMSLOW_RESET | SBTMSLOW_REJECT | SBTMSLOW_CLOCK))
 		== SBTMSLOW_CLOCK);
 }
 
@@ -275,19 +286,19 @@
 	val |= ((u32) data[3]) << 16;
 	val |= ((u32) data[4]) <<  8;
 	val |= ((u32) data[5]) <<  0;
-	bw32(B44_CAM_DATA_LO, val);
+	bw32(bp, B44_CAM_DATA_LO, val);
 	val = (CAM_DATA_HI_VALID | 
 	       (((u32) data[0]) << 8) |
 	       (((u32) data[1]) << 0));
-	bw32(B44_CAM_DATA_HI, val);
-	bw32(B44_CAM_CTRL, (CAM_CTRL_WRITE |
+	bw32(bp, B44_CAM_DATA_HI, val);
+	bw32(bp, B44_CAM_CTRL, (CAM_CTRL_WRITE |
 			    (index << CAM_CTRL_INDEX_SHIFT)));
 	b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);	
 }
 
 static inline void __b44_disable_ints(struct b44 *bp)
 {
-	bw32(B44_IMASK, 0);
+	bw32(bp, B44_IMASK, 0);
 }
 
 static void b44_disable_ints(struct b44 *bp)
@@ -295,34 +306,34 @@
 	__b44_disable_ints(bp);
 
 	/* Flush posted writes. */
-	br32(B44_IMASK);
+	br32(bp, B44_IMASK);
 }
 
 static void b44_enable_ints(struct b44 *bp)
 {
-	bw32(B44_IMASK, bp->imask);
+	bw32(bp, B44_IMASK, bp->imask);
 }
 
 static int b44_readphy(struct b44 *bp, int reg, u32 *val)
 {
 	int err;
 
-	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
-	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
+	bw32(bp, B44_EMAC_ISTAT, EMAC_INT_MII);
+	bw32(bp, B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_READ << MDIO_DATA_OP_SHIFT) |
 			     (bp->phy_addr << MDIO_DATA_PMD_SHIFT) |
 			     (reg << MDIO_DATA_RA_SHIFT) |
 			     (MDIO_TA_VALID << MDIO_DATA_TA_SHIFT)));
 	err = b44_wait_bit(bp, B44_EMAC_ISTAT, EMAC_INT_MII, 100, 0);
-	*val = br32(B44_MDIO_DATA) & MDIO_DATA_DATA;
+	*val = br32(bp, B44_MDIO_DATA) & MDIO_DATA_DATA;
 
 	return err;
 }
 
 static int b44_writephy(struct b44 *bp, int reg, u32 val)
 {
-	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
-	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
+	bw32(bp, B44_EMAC_ISTAT, EMAC_INT_MII);
+	bw32(bp, B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_WRITE << MDIO_DATA_OP_SHIFT) |
 			     (bp->phy_addr << MDIO_DATA_PMD_SHIFT) |
 			     (reg << MDIO_DATA_RA_SHIFT) |
@@ -382,20 +393,20 @@
 	bp->flags &= ~(B44_FLAG_TX_PAUSE | B44_FLAG_RX_PAUSE);
 	bp->flags |= pause_flags;
 
-	val = br32(B44_RXCONFIG);
+	val = br32(bp, B44_RXCONFIG);
 	if (pause_flags & B44_FLAG_RX_PAUSE)
 		val |= RXCONFIG_FLOW;
 	else
 		val &= ~RXCONFIG_FLOW;
-	bw32(B44_RXCONFIG, val);
+	bw32(bp, B44_RXCONFIG, val);
 
-	val = br32(B44_MAC_FLOW);
+	val = br32(bp, B44_MAC_FLOW);
 	if (pause_flags & B44_FLAG_TX_PAUSE)
 		val |= (MAC_FLOW_PAUSE_ENAB |
 			(0xc0 & MAC_FLOW_RX_HI_WATER));
 	else
 		val &= ~MAC_FLOW_PAUSE_ENAB;
-	bw32(B44_MAC_FLOW, val);
+	bw32(bp, B44_MAC_FLOW, val);
 }
 
 static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
@@ -491,11 +502,11 @@
 
 	val = &bp->hw_stats.tx_good_octets;
 	for (reg = B44_TX_GOOD_O; reg <= B44_TX_PAUSE; reg += 4UL) {
-		*val++ += br32(reg);
+		*val++ += br32(bp, reg);
 	}
 	val = &bp->hw_stats.rx_good_octets;
 	for (reg = B44_RX_GOOD_O; reg <= B44_RX_NPAUSE; reg += 4UL) {
-		*val++ += br32(reg);
+		*val++ += br32(bp, reg);
 	}
 }
 
@@ -535,14 +546,14 @@
 
 		if (!netif_carrier_ok(bp->dev) &&
 		    (bmsr & BMSR_LSTATUS)) {
-			u32 val = br32(B44_TX_CTRL);
+			u32 val = br32(bp, B44_TX_CTRL);
 			u32 local_adv, remote_adv;
 
 			if (bp->flags & B44_FLAG_FULL_DUPLEX)
 				val |= TX_CTRL_DUPLEX;
 			else
 				val &= ~TX_CTRL_DUPLEX;
-			bw32(B44_TX_CTRL, val);
+			bw32(bp, B44_TX_CTRL, val);
 
 			if (!(bp->flags & B44_FLAG_FORCE_LINK) &&
 			    !b44_readphy(bp, MII_ADVERTISE, &local_adv) &&
@@ -587,7 +598,7 @@
 {
 	u32 cur, cons;
 
-	cur  = br32(B44_DMATX_STAT) & DMATX_STAT_CDMASK;
+	cur  = br32(bp, B44_DMATX_STAT) & DMATX_STAT_CDMASK;
 	cur /= sizeof(struct dma_desc);
 
 	/* XXX needs updating when NETIF_F_SG is supported */
@@ -611,7 +622,7 @@
 	    TX_BUFFS_AVAIL(bp) > B44_TX_WAKEUP_THRESH)
 		netif_wake_queue(bp->dev);
 
-	bw32(B44_GPTIMER, 0);
+	bw32(bp, B44_GPTIMER, 0);
 }
 
 /* Works like this.  This chip writes a 'struct rx_header" 30 bytes
@@ -708,7 +719,7 @@
 	u32 cons, prod;
 
 	received = 0;
-	prod  = br32(B44_DMARX_STAT) & DMARX_STAT_CDMASK;
+	prod  = br32(bp, B44_DMARX_STAT) & DMARX_STAT_CDMASK;
 	prod /= sizeof(struct dma_desc);
 	cons = bp->rx_cons;
 
@@ -787,7 +798,7 @@
 	}
 
 	bp->rx_cons = cons;
-	bw32(B44_DMARX_PTR, cons * sizeof(struct dma_desc));
+	bw32(bp, B44_DMARX_PTR, cons * sizeof(struct dma_desc));
 
 	return received;
 }
@@ -851,8 +862,8 @@
 
 	spin_lock_irqsave(&bp->lock, flags);
 
-	istat = br32(B44_ISTAT);
-	imask = br32(B44_IMASK);
+	istat = br32(bp, B44_ISTAT);
+	imask = br32(bp, B44_IMASK);
 
 	/* ??? What the fuck is the purpose of the interrupt mask
 	 * ??? register if we have to mask it out by hand anyways?
@@ -872,8 +883,8 @@
 			       dev->name);
 		}
 
-		bw32(B44_ISTAT, istat);
-		br32(B44_ISTAT);
+		bw32(bp, B44_ISTAT, istat);
+		br32(bp, B44_ISTAT);
 	}
 	spin_unlock_irqrestore(&bp->lock, flags);
 	return IRQ_RETVAL(handled);
@@ -937,11 +948,11 @@
 
 	wmb();
 
-	bw32(B44_DMATX_PTR, entry * sizeof(struct dma_desc));
+	bw32(bp, B44_DMATX_PTR, entry * sizeof(struct dma_desc));
 	if (bp->flags & B44_FLAG_BUGGY_TXPTR)
-		bw32(B44_DMATX_PTR, entry * sizeof(struct dma_desc));
+		bw32(bp, B44_DMATX_PTR, entry * sizeof(struct dma_desc));
 	if (bp->flags & B44_FLAG_REORDER_BUG)
-		br32(B44_DMATX_PTR);
+		br32(bp, B44_DMATX_PTR);
 
 	if (TX_BUFFS_AVAIL(bp) < 1)
 		netif_stop_queue(dev);
@@ -1109,27 +1120,27 @@
 {
 	unsigned long reg;
 
-	bw32(B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
+	bw32(bp, B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
 	for (reg = B44_TX_GOOD_O; reg <= B44_TX_PAUSE; reg += 4UL)
-		br32(reg);
+		br32(bp, reg);
 	for (reg = B44_RX_GOOD_O; reg <= B44_RX_NPAUSE; reg += 4UL)
-		br32(reg);
+		br32(bp, reg);
 }
 
 /* bp->lock is held. */
 static void b44_chip_reset(struct b44 *bp)
 {
 	if (ssb_is_core_up(bp)) {
-		bw32(B44_RCV_LAZY, 0);
-		bw32(B44_ENET_CTRL, ENET_CTRL_DISABLE);
+		bw32(bp, B44_RCV_LAZY, 0);
+		bw32(bp, B44_ENET_CTRL, ENET_CTRL_DISABLE);
 		b44_wait_bit(bp, B44_ENET_CTRL, ENET_CTRL_DISABLE, 100, 1);
-		bw32(B44_DMATX_CTRL, 0);
+		bw32(bp, B44_DMATX_CTRL, 0);
 		bp->tx_prod = bp->tx_cons = 0;
-		if (br32(B44_DMARX_STAT) & DMARX_STAT_EMASK) {
+		if (br32(bp, B44_DMARX_STAT) & DMARX_STAT_EMASK) {
 			b44_wait_bit(bp, B44_DMARX_STAT, DMARX_STAT_SIDLE,
 				     100, 0);
 		}
-		bw32(B44_DMARX_CTRL, 0);
+		bw32(bp, B44_DMARX_CTRL, 0);
 		bp->rx_prod = bp->rx_cons = 0;
 	} else {
 		ssb_pci_setup(bp, (bp->core_unit == 0 ?
@@ -1142,20 +1153,20 @@
 	b44_clear_stats(bp);
 
 	/* Make PHY accessible. */
-	bw32(B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
+	bw32(bp, B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
 			     (0x0d & MDIO_CTRL_MAXF_MASK)));
-	br32(B44_MDIO_CTRL);
+	br32(bp, B44_MDIO_CTRL);
 
-	if (!(br32(B44_DEVCTRL) & DEVCTRL_IPP)) {
-		bw32(B44_ENET_CTRL, ENET_CTRL_EPSEL);
-		br32(B44_ENET_CTRL);
+	if (!(br32(bp, B44_DEVCTRL) & DEVCTRL_IPP)) {
+		bw32(bp, B44_ENET_CTRL, ENET_CTRL_EPSEL);
+		br32(bp, B44_ENET_CTRL);
 		bp->flags &= ~B44_FLAG_INTERNAL_PHY;
 	} else {
-		u32 val = br32(B44_DEVCTRL);
+		u32 val = br32(bp, B44_DEVCTRL);
 
 		if (val & DEVCTRL_EPR) {
-			bw32(B44_DEVCTRL, (val & ~DEVCTRL_EPR));
-			br32(B44_DEVCTRL);
+			bw32(bp, B44_DEVCTRL, (val & ~DEVCTRL_EPR));
+			br32(bp, B44_DEVCTRL);
 			udelay(100);
 		}
 		bp->flags |= B44_FLAG_INTERNAL_PHY;
@@ -1172,13 +1183,13 @@
 /* bp->lock is held. */
 static void __b44_set_mac_addr(struct b44 *bp)
 {
-	bw32(B44_CAM_CTRL, 0);
+	bw32(bp, B44_CAM_CTRL, 0);
 	if (!(bp->dev->flags & IFF_PROMISC)) {
 		u32 val;
 
 		__b44_cam_write(bp, bp->dev->dev_addr, 0);
-		val = br32(B44_CAM_CTRL);
-		bw32(B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
+		val = br32(bp, B44_CAM_CTRL);
+		bw32(bp, B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
 	}
 }
 
@@ -1212,30 +1223,30 @@
 	b44_setup_phy(bp);
 
 	/* Enable CRC32, set proper LED modes and power on PHY */
-	bw32(B44_MAC_CTRL, MAC_CTRL_CRC32_ENAB | MAC_CTRL_PHY_LEDCTRL);
-	bw32(B44_RCV_LAZY, (1 << RCV_LAZY_FC_SHIFT));
+	bw32(bp, B44_MAC_CTRL, MAC_CTRL_CRC32_ENAB | MAC_CTRL_PHY_LEDCTRL);
+	bw32(bp, B44_RCV_LAZY, (1 << RCV_LAZY_FC_SHIFT));
 
 	/* This sets the MAC address too.  */
 	__b44_set_rx_mode(bp->dev);
 
 	/* MTU + eth header + possible VLAN tag + struct rx_header */
-	bw32(B44_RXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
-	bw32(B44_TXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
+	bw32(bp, B44_RXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
+	bw32(bp, B44_TXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
 
-	bw32(B44_TX_WMARK, 56); /* XXX magic */
-	bw32(B44_DMATX_CTRL, DMATX_CTRL_ENABLE);
-	bw32(B44_DMATX_ADDR, bp->tx_ring_dma + bp->dma_offset);
-	bw32(B44_DMARX_CTRL, (DMARX_CTRL_ENABLE |
+	bw32(bp, B44_TX_WMARK, 56); /* XXX magic */
+	bw32(bp, B44_DMATX_CTRL, DMATX_CTRL_ENABLE);
+	bw32(bp, B44_DMATX_ADDR, bp->tx_ring_dma + bp->dma_offset);
+	bw32(bp, B44_DMARX_CTRL, (DMARX_CTRL_ENABLE |
 			      (bp->rx_offset << DMARX_CTRL_ROSHIFT)));
-	bw32(B44_DMARX_ADDR, bp->rx_ring_dma + bp->dma_offset);
+	bw32(bp, B44_DMARX_ADDR, bp->rx_ring_dma + bp->dma_offset);
 
-	bw32(B44_DMARX_PTR, bp->rx_pending);
+	bw32(bp, B44_DMARX_PTR, bp->rx_pending);
 	bp->rx_prod = bp->rx_pending;	
 
-	bw32(B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
+	bw32(bp, B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
 
-	val = br32(B44_ENET_CTRL);
-	bw32(B44_ENET_CTRL, (val | ENET_CTRL_ENABLE));
+	val = br32(bp, B44_ENET_CTRL);
+	bw32(bp, B44_ENET_CTRL, (val | ENET_CTRL_ENABLE));
 }
 
 static int b44_open(struct net_device *dev)
@@ -1372,11 +1383,11 @@
 	int i=0;
 	unsigned char zero[6] = {0,0,0,0,0,0};
 
-	val = br32(B44_RXCONFIG);
+	val = br32(bp, B44_RXCONFIG);
 	val &= ~(RXCONFIG_PROMISC | RXCONFIG_ALLMULTI);
 	if (dev->flags & IFF_PROMISC) {
 		val |= RXCONFIG_PROMISC;
-		bw32(B44_RXCONFIG, val);
+		bw32(bp, B44_RXCONFIG, val);
 	} else {
 		__b44_set_mac_addr(bp);
 
@@ -1388,9 +1399,9 @@
 		for(;i<64;i++) {
 			__b44_cam_write(bp, zero, i);			
 		}
-		bw32(B44_RXCONFIG, val);
-        	val = br32(B44_CAM_CTRL);
-	        bw32(B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
+		bw32(bp, B44_RXCONFIG, val);
+        	val = br32(bp, B44_CAM_CTRL);
+	        bw32(bp, B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
 	}
 }
 
@@ -1760,7 +1771,7 @@
 
 	spin_lock_init(&bp->lock);
 
-	bp->regs = (unsigned long) ioremap(b44reg_base, b44reg_len);
+	bp->regs = ioremap(b44reg_base, b44reg_len);
 	if (bp->regs == 0UL) {
 		printk(KERN_ERR PFX "Cannot map device registers, "
 		       "aborting.\n");
diff -Nru a/drivers/net/b44.h b/drivers/net/b44.h
--- a/drivers/net/b44.h	2004-09-13 15:33:00 -07:00
+++ b/drivers/net/b44.h	2004-09-13 15:33:00 -07:00
@@ -395,9 +395,6 @@
 #define SSB_PCI_MASK1		0xfc000000
 #define SSB_PCI_MASK2		0xc0000000
 
-#define br32(REG)	readl(bp->regs + (REG))
-#define bw32(REG,VAL)	writel((VAL), bp->regs + (REG))
-
 /* 4400 PHY registers */
 #define B44_MII_AUXCTRL		24	/* Auxiliary Control */
 #define  MII_AUXCTRL_DUPLEX	0x0001  /* Full Duplex */
@@ -530,7 +527,7 @@
 	struct net_device_stats	stats;
 	struct b44_hw_stats	hw_stats;
 
-	unsigned long		regs;
+	volatile void __iomem   *regs;
 	struct pci_dev		*pdev;
 	struct net_device	*dev;
 
