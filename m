Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271895AbTG2RNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271928AbTG2RNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:13:55 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:34178
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271895AbTG2RJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:09:56 -0400
Date: Tue, 29 Jul 2003 13:09:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: PATCH: bcm5705 support -- buggy
Message-ID: <20030729170954.GA16370@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of requests for Broadcom BCM5705/5782 support.

Here is the current patch for it...  it's not as simple as adding the
PCI ids, as some have speculated.

Note that this patch does not work fully yet (otherwise it would have
been sent to Marcelo/Linus long before now).

I should have it fully debugged before September rolls around, but
here's the pre-release if hackers want to play.


diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Tue Jul 29 13:08:22 2003
+++ b/drivers/net/tg3.c	Tue Jul 29 13:08:22 2003
@@ -69,7 +69,8 @@
 
 /* hardware minimum and maximum for a single frame's data payload */
 #define TG3_MIN_MTU			60
-#define TG3_MAX_MTU			9000
+#define TG3_MAX_MTU(tp)	\
+	(GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 ? 9000 : 1500)
 
 /* These numbers seem to be hard coded in the NIC firmware somehow.
  * You can't change the ring sizes, but you can change where you place
@@ -79,7 +80,17 @@
 #define TG3_DEF_RX_RING_PENDING		200
 #define TG3_RX_JUMBO_RING_SIZE		256
 #define TG3_DEF_RX_JUMBO_RING_PENDING	100
-#define TG3_RX_RCB_RING_SIZE		1024
+
+/* Do not place this n-ring entries value into the tp struct itself,
+ * we really want to expose these constants to GCC so that modulo et
+ * al.  operations are done with shifts and masks instead of with
+ * hw multiply/modulo instructions.  Another solution would be to
+ * replace things like '% foo' with '& (foo - 1)'.
+ */
+#define TG3_RX_RCB_RING_SIZE(tp)	\
+	(GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 ? \
+	 512 : 1024)
+
 #define TG3_TX_RING_SIZE		512
 #define TG3_DEF_TX_RING_PENDING		(TG3_TX_RING_SIZE - 1)
 
@@ -87,8 +98,8 @@
 				 TG3_RX_RING_SIZE)
 #define TG3_RX_JUMBO_RING_BYTES	(sizeof(struct tg3_rx_buffer_desc) * \
 			         TG3_RX_JUMBO_RING_SIZE)
-#define TG3_RX_RCB_RING_BYTES	(sizeof(struct tg3_rx_buffer_desc) * \
-			         TG3_RX_RCB_RING_SIZE)
+#define TG3_RX_RCB_RING_BYTES(tp) (sizeof(struct tg3_rx_buffer_desc) * \
+			           TG3_RX_RCB_RING_SIZE(tp))
 #define TG3_TX_RING_BYTES	(sizeof(struct tg3_tx_buffer_desc) * \
 				 TG3_TX_RING_SIZE)
 #define TX_RING_GAP(TP)	\
@@ -129,6 +140,10 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702FE,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5705,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5705M,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702X,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703X,
@@ -274,17 +289,28 @@
 
 static void tg3_switch_clocks(struct tg3 *tp)
 {
-	if (tr32(TG3PCI_CLOCK_CTRL) & CLOCK_CTRL_44MHZ_CORE) {
+	u32 clock_ctrl = tr32(TG3PCI_CLOCK_CTRL);
+	u32 orig_clock_ctrl;
+
+	orig_clock_ctrl = clock_ctrl;
+	clock_ctrl &= (CLOCK_CTRL_FORCE_CLKRUN |
+		       CLOCK_CTRL_CLKRUN_OENABLE |
+		       0x1f);
+	tp->pci_clock_ctrl = clock_ctrl;
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 &&
+	    (orig_clock_ctrl & CLOCK_CTRL_44MHZ_CORE) != 0) {
 		tw32(TG3PCI_CLOCK_CTRL,
+		     clock_ctrl |
 		     (CLOCK_CTRL_44MHZ_CORE | CLOCK_CTRL_ALTCLK));
 		tr32(TG3PCI_CLOCK_CTRL);
 		udelay(40);
 		tw32(TG3PCI_CLOCK_CTRL,
-		     (CLOCK_CTRL_ALTCLK));
+		     clock_ctrl | (CLOCK_CTRL_ALTCLK));
 		tr32(TG3PCI_CLOCK_CTRL);
 		udelay(40);
 	}
-	tw32(TG3PCI_CLOCK_CTRL, 0);
+	tw32(TG3PCI_CLOCK_CTRL, clock_ctrl);
 	tr32(TG3PCI_CLOCK_CTRL);
 	udelay(40);
 }
@@ -387,6 +413,18 @@
 	return ret;
 }
 
+static void tg3_phy_set_wirespeed(struct tg3 *tp)
+{
+	u32 val;
+
+	if (tp->tg3_flags2 & TG3_FLG2_NO_ETH_WIRE_SPEED)
+		return;
+
+	tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x7007);
+	tg3_readphy(tp, MII_TG3_AUX_CTRL, &val);
+	tg3_writephy(tp, MII_TG3_AUX_CTRL, (val | (1 << 15) | (1 << 4)));
+}
+
 /* This will reset the tigon3 PHY if there is no valid
  * link unless the FORCE argument is non-zero.
  */
@@ -422,12 +460,102 @@
 
 		if ((phy_control & BMCR_RESET) == 0) {
 			udelay(40);
-			return 0;
+			goto out;
 		}
 		udelay(10);
 	}
 
 	return -EBUSY;
+
+out:
+	tg3_phy_set_wirespeed(tp);
+	return 0;
+}
+
+static void tg3_frob_aux_power(struct tg3 *tp)
+{
+	struct tg3 *tp_peer = tp;
+
+	if ((tp->tg3_flags & TG3_FLAG_EEPROM_WRITE_PROT) != 0)
+		return;
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704) {
+		tp_peer = pci_get_drvdata(tp->pdev_peer);
+		if (!tp_peer)
+			BUG();
+	}
+
+
+	if ((tp->tg3_flags & TG3_FLAG_WOL_ENABLE) != 0 ||
+	    (tp_peer->tg3_flags & TG3_FLAG_WOL_ENABLE) != 0) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+		} else {
+			if (tp_peer != tp &&
+			    (tp_peer->tg3_flags & TG3_FLAG_INIT_COMPLETE) != 0)
+				return;
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT2));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT2));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+		}
+	} else {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5700 &&
+		    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5701) {
+			if (tp_peer != tp &&
+			    (tp_peer->tg3_flags & TG3_FLAG_INIT_COMPLETE) != 0)
+				return;
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl |
+			     (GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+		}
+	}
 }
 
 static int tg3_setup_phy(struct tg3 *);
@@ -533,89 +661,65 @@
 		udelay(10);
 	}
 
-	if (tp->tg3_flags & TG3_FLAG_WOL_SPEED_100MB) {
+	if (!(tp->tg3_flags & TG3_FLAG_WOL_SPEED_100MB) &&
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)) {
 		u32 base_val;
 
-		base_val = 0;
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)
-			base_val |= (CLOCK_CTRL_RXCLK_DISABLE |
-				     CLOCK_CTRL_TXCLK_DISABLE);
-
-		tw32(TG3PCI_CLOCK_CTRL, base_val |
-		     CLOCK_CTRL_ALTCLK);
-		tr32(TG3PCI_CLOCK_CTRL);
-		udelay(40);
+		base_val = tp->pci_clock_ctrl;
+		base_val |= (CLOCK_CTRL_RXCLK_DISABLE |
+			     CLOCK_CTRL_TXCLK_DISABLE);
 
 		tw32(TG3PCI_CLOCK_CTRL, base_val |
 		     CLOCK_CTRL_ALTCLK |
-		     CLOCK_CTRL_44MHZ_CORE);
-		tr32(TG3PCI_CLOCK_CTRL);
-		udelay(40);
-
-		tw32(TG3PCI_CLOCK_CTRL, base_val |
-		     CLOCK_CTRL_44MHZ_CORE);
+		     CLOCK_CTRL_PWRDOWN_PLL133);
 		tr32(TG3PCI_CLOCK_CTRL);
 		udelay(40);
 	} else {
-		u32 base_val;
+		u32 newbits1, newbits2;
 
-		base_val = 0;
 		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)
-			base_val |= (CLOCK_CTRL_RXCLK_DISABLE |
-				     CLOCK_CTRL_TXCLK_DISABLE);
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
+			newbits1 = (CLOCK_CTRL_RXCLK_DISABLE |
+				    CLOCK_CTRL_TXCLK_DISABLE |
+				    CLOCK_CTRL_ALTCLK);
+			newbits2 = newbits1 | CLOCK_CTRL_44MHZ_CORE;
+		} else if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+			newbits1 = CLOCK_CTRL_625_CORE;
+			newbits2 = newbits1 | CLOCK_CTRL_ALTCLK;
+		} else {
+			newbits1 = CLOCK_CTRL_ALTCLK;
+			newbits2 = newbits1 | CLOCK_CTRL_44MHZ_CORE;
+		}
 
-		tw32(TG3PCI_CLOCK_CTRL, base_val |
-		     CLOCK_CTRL_ALTCLK |
-		     CLOCK_CTRL_PWRDOWN_PLL133);
+		tw32(TG3PCI_CLOCK_CTRL, tp->pci_clock_ctrl | newbits1);
 		tr32(TG3PCI_CLOCK_CTRL);
 		udelay(40);
-	}
 
-	if (!(tp->tg3_flags & TG3_FLAG_EEPROM_WRITE_PROT) &&
-	    (tp->tg3_flags & TG3_FLAG_WOL_ENABLE)) {
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
-			tw32(GRC_LOCAL_CTRL,
-			     (GRC_LCLCTRL_GPIO_OE0 |
-			      GRC_LCLCTRL_GPIO_OE1 |
-			      GRC_LCLCTRL_GPIO_OE2 |
-			      GRC_LCLCTRL_GPIO_OUTPUT0 |
-			      GRC_LCLCTRL_GPIO_OUTPUT1));
-			tr32(GRC_LOCAL_CTRL);
-			udelay(100);
-		} else {
-			tw32(GRC_LOCAL_CTRL,
-			     (GRC_LCLCTRL_GPIO_OE0 |
-			      GRC_LCLCTRL_GPIO_OE1 |
-			      GRC_LCLCTRL_GPIO_OE2 |
-			      GRC_LCLCTRL_GPIO_OUTPUT1 |
-			      GRC_LCLCTRL_GPIO_OUTPUT2));
-			tr32(GRC_LOCAL_CTRL);
-			udelay(100);
+		tw32(TG3PCI_CLOCK_CTRL, tp->pci_clock_ctrl | newbits2);
+		tr32(TG3PCI_CLOCK_CTRL);
+		udelay(40);
 
-			tw32(GRC_LOCAL_CTRL,
-			     (GRC_LCLCTRL_GPIO_OE0 |
-			      GRC_LCLCTRL_GPIO_OE1 |
-			      GRC_LCLCTRL_GPIO_OE2 |
-			      GRC_LCLCTRL_GPIO_OUTPUT0 |
-			      GRC_LCLCTRL_GPIO_OUTPUT1 |
-			      GRC_LCLCTRL_GPIO_OUTPUT2));
-			tr32(GRC_LOCAL_CTRL);
-			udelay(100);
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+			u32 newbits3;
 
-			tw32(GRC_LOCAL_CTRL,
-			     (GRC_LCLCTRL_GPIO_OE0 |
-			      GRC_LCLCTRL_GPIO_OE1 |
-			      GRC_LCLCTRL_GPIO_OE2 |
-			      GRC_LCLCTRL_GPIO_OUTPUT0 |
-			      GRC_LCLCTRL_GPIO_OUTPUT1));
-			tr32(GRC_LOCAL_CTRL);
-			udelay(100);
+			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+			    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
+				newbits3 = (CLOCK_CTRL_RXCLK_DISABLE |
+					    CLOCK_CTRL_TXCLK_DISABLE |
+					    CLOCK_CTRL_44MHZ_CORE);
+			} else {
+				newbits3 = CLOCK_CTRL_44MHZ_CORE;
+			}
+
+			tw32(TG3PCI_CLOCK_CTRL, tp->pci_clock_ctrl | newbits3);
+			tr32(TG3PCI_CLOCK_CTRL);
+			udelay(40);
 		}
 	}
 
+	tg3_frob_aux_power(tp);
+
 	/* Finally, set the new power state. */
 	pci_write_config_word(tp->pdev, pm + PCI_PM_CTRL, power_control);
 
@@ -934,11 +1038,10 @@
 
 	/* Some third-party PHYs need to be reset on link going
 	 * down.
-	 *
-	 * XXX 5705 note: This workaround also applies to 5705_a0
 	 */
 	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703 ||
-	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704) &&
+	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 ||
+	     tp->pci_chip_rev_id == CHIPREV_ID_5705_A0) &&
 	    netif_carrier_ok(tp->dev)) {
 		tg3_readphy(tp, MII_BMSR, &bmsr);
 		tg3_readphy(tp, MII_BMSR, &bmsr);
@@ -1928,7 +2031,7 @@
 	int received;
 
 	hw_idx = tp->hw_status->idx[0].rx_producer;
-	sw_idx = rx_rcb_ptr % TG3_RX_RCB_RING_SIZE;
+	sw_idx = rx_rcb_ptr % TG3_RX_RCB_RING_SIZE(tp);
 	work_mask = 0;
 	received = 0;
 	while (sw_idx != hw_idx && budget > 0) {
@@ -2029,13 +2132,13 @@
 		(*post_ptr)++;
 next_pkt_nopost:
 		rx_rcb_ptr++;
-		sw_idx = rx_rcb_ptr % TG3_RX_RCB_RING_SIZE;
+		sw_idx = rx_rcb_ptr % TG3_RX_RCB_RING_SIZE(tp);
 	}
 
 	/* ACK the status ring. */
 	tp->rx_rcb_ptr = rx_rcb_ptr;
 	tw32_mailbox(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW,
-		     (rx_rcb_ptr % TG3_RX_RCB_RING_SIZE));
+		     (rx_rcb_ptr % TG3_RX_RCB_RING_SIZE(tp)));
 	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
 		tr32(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW);
 
@@ -2655,7 +2758,7 @@
 {
 	struct tg3 *tp = dev->priv;
 
-	if (new_mtu < TG3_MIN_MTU || new_mtu > TG3_MAX_MTU)
+	if (new_mtu < TG3_MIN_MTU || new_mtu > TG3_MAX_MTU(tp))
 		return -EINVAL;
 
 	if (!netif_running(dev)) {
@@ -2774,7 +2877,7 @@
 	/* Zero out all descriptors. */
 	memset(tp->rx_std, 0, TG3_RX_RING_BYTES);
 	memset(tp->rx_jumbo, 0, TG3_RX_JUMBO_RING_BYTES);
-	memset(tp->rx_rcb, 0, TG3_RX_RCB_RING_BYTES);
+	memset(tp->rx_rcb, 0, TG3_RX_RCB_RING_BYTES(tp));
 
 	if (tp->tg3_flags & TG3_FLAG_HOST_TXDS) {
 		memset(tp->tx_ring, 0, TG3_TX_RING_BYTES);
@@ -2857,7 +2960,7 @@
 		tp->rx_jumbo = NULL;
 	}
 	if (tp->rx_rcb) {
-		pci_free_consistent(tp->pdev, TG3_RX_RCB_RING_BYTES,
+		pci_free_consistent(tp->pdev, TG3_RX_RCB_RING_BYTES(tp),
 				    tp->rx_rcb, tp->rx_rcb_mapping);
 		tp->rx_rcb = NULL;
 	}
@@ -2915,7 +3018,7 @@
 	if (!tp->rx_jumbo)
 		goto err_out;
 
-	tp->rx_rcb = pci_alloc_consistent(tp->pdev, TG3_RX_RCB_RING_BYTES,
+	tp->rx_rcb = pci_alloc_consistent(tp->pdev, TG3_RX_RCB_RING_BYTES(tp),
 					  &tp->rx_rcb_mapping);
 	if (!tp->rx_rcb)
 		goto err_out;
@@ -2962,6 +3065,23 @@
 	unsigned int i;
 	u32 val;
 
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		switch (ofs) {
+		case RCVLSC_MODE:
+		case DMAC_MODE:
+		case MBFREE_MODE:
+		case BUFMGR_MODE:
+		case MEMARB_MODE:
+			/* We can't enable/disable these bits of the
+			 * 5705, just say success.
+			 */
+			return 0;
+
+		default:
+			break;
+		};
+	}
+
 	val = tr32(ofs);
 	val &= ~enable_bit;
 	tw32(ofs, val);
@@ -3083,7 +3203,10 @@
 	tp->tg3_flags &= ~TG3_FLAG_5701_REG_WRITE_BUG;
 
 	/* do the reset */
-	tw32(GRC_MISC_CFG, GRC_MISC_CFG_CORECLK_RESET);
+	val = GRC_MISC_CFG_CORECLK_RESET;
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		val |= GRC_MISC_CFG_KEEP_GPHY_POWER;
+	tw32(GRC_MISC_CFG, val);
 
 	/* restore 5701 hardware bug workaround flag */
 	tp->tg3_flags = flags_save;
@@ -3119,6 +3242,13 @@
 
 	tw32(MEMARB_MODE, MEMARB_MODE_ENABLE);
 
+	if ((tp->nic_sram_data_cfg & NIC_SRAM_DATA_CFG_MINI_PCI) != 0 &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		tp->pci_clock_ctrl |=
+			(CLOCK_CTRL_FORCE_CLKRUN | CLOCK_CTRL_CLKRUN_OENABLE);
+		tw32(TG3PCI_CLOCK_CTRL, tp->pci_clock_ctrl);
+	}
+
 	tw32(TG3PCI_MISC_HOST_CTRL, tp->misc_host_ctrl);
 }
 
@@ -3317,6 +3447,10 @@
 {
 	int i;
 
+	if (offset == TX_CPU_BASE &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		BUG();
+
 	tw32(offset + CPU_STATE, 0xffffffff);
 	tw32(offset + CPU_MODE,  CPU_MODE_RESET);
 	if (offset == RX_CPU_BASE) {
@@ -3367,6 +3501,14 @@
 	int err, i;
 	u32 orig_tg3_flags = tp->tg3_flags;
 
+	if (cpu_base == TX_CPU_BASE &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		printk(KERN_ERR PFX "tg3_load_firmware_cpu: Trying to load "
+		       "TX cpu firmware on %s which is 5705.\n",
+		       tp->dev->name);
+		return -EINVAL;
+	}
+
 	/* Force use of PCI config space for indirect register
 	 * write calls.
 	 */
@@ -3746,6 +3888,9 @@
 	struct fw_info info;
 	int err, i;
 
+	/* XXX 5705 note: Need different firmware here, and load it onto
+	 * XXX            RX cpu instead of TX cpu as 5705 lacks the latter.
+	 */
 	info.text_base = TG3_TSO_FW_TEXT_ADDR;
 	info.text_len = TG3_TSO_FW_TEXT_LEN;
 	info.text_data = &tg3TsoFwText[0];
@@ -3815,6 +3960,15 @@
 		tw32(MAC_ADDR_0_LOW + (i * 8), addr_low);
 	}
 
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5700 &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5701 &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		for (i = 0; i < 12; i++) {
+			tw32(MAC_EXTADDR_0_HIGH + (i * 8), addr_high);
+			tw32(MAC_EXTADDR_0_LOW + (i * 8), addr_low);
+		}
+	}
+
 	addr_high = (tp->dev->dev_addr[0] +
 		     tp->dev->dev_addr[1] +
 		     tp->dev->dev_addr[2] +
@@ -3848,23 +4002,19 @@
 			   u32 nic_addr)
 {
 	tg3_write_mem(tp,
-		      (bdinfo_addr +
-		       TG3_BDINFO_HOST_ADDR +
-		       TG3_64BIT_REG_HIGH),
+		      (bdinfo_addr + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_HIGH),
 		      ((u64) mapping >> 32));
 	tg3_write_mem(tp,
-		      (bdinfo_addr +
-		       TG3_BDINFO_HOST_ADDR +
-		       TG3_64BIT_REG_LOW),
+		      (bdinfo_addr + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_LOW),
 		      ((u64) mapping & 0xffffffff));
 	tg3_write_mem(tp,
-		      (bdinfo_addr +
-		       TG3_BDINFO_MAXLEN_FLAGS),
+		      (bdinfo_addr + TG3_BDINFO_MAXLEN_FLAGS),
 		       maxlen_flags);
-	tg3_write_mem(tp,
-		      (bdinfo_addr +
-		       TG3_BDINFO_NIC_ADDR),
-		      nic_addr);
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705)
+		tg3_write_mem(tp,
+			      (bdinfo_addr + TG3_BDINFO_NIC_ADDR),
+			      nic_addr);
 }
 
 static void __tg3_set_rx_mode(struct net_device *);
@@ -3873,7 +4023,7 @@
 static int tg3_reset_hw(struct tg3 *tp)
 {
 	u32 val;
-	int i, err;
+	int i, err, limit;
 
 	tg3_disable_ints(tp);
 
@@ -3924,9 +4074,8 @@
 	 * B3 tigon3 silicon.  This bit has no effect on any
 	 * other revision.
 	 */
-	val = tr32(TG3PCI_CLOCK_CTRL);
-	val |= CLOCK_CTRL_DELAY_PCI_GRANT;
-	tw32(TG3PCI_CLOCK_CTRL, val);
+	tp->pci_clock_ctrl |= CLOCK_CTRL_DELAY_PCI_GRANT;
+	tw32(TG3PCI_CLOCK_CTRL, tp->pci_clock_ctrl);
 	tr32(TG3PCI_CLOCK_CTRL);
 
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5704_A0 &&
@@ -3937,11 +4086,13 @@
 	}
 
 	/* Clear statistics/status block in chip, and status block in ram. */
-	for (i = NIC_SRAM_STATS_BLK;
-	     i < NIC_SRAM_STATUS_BLK + TG3_HW_STATUS_SIZE;
-	     i += sizeof(u32)) {
-		tg3_write_mem(tp, i, 0);
-		udelay(40);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		for (i = NIC_SRAM_STATS_BLK;
+	     	     i < NIC_SRAM_STATUS_BLK + TG3_HW_STATUS_SIZE;
+	     	     i += sizeof(u32)) {
+			tg3_write_mem(tp, i, 0);
+			udelay(40);
+		}
 	}
 	memset(tp->hw_status, 0, TG3_HW_STATUS_SIZE);
 
@@ -3972,13 +4123,34 @@
 	     (65 << GRC_MISC_CFG_PRESCALAR_SHIFT));
 
 	/* Initialize MBUF/DESC pool. */
-	tw32(BUFMGR_MB_POOL_ADDR, NIC_SRAM_MBUF_POOL_BASE);
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704)
-		tw32(BUFMGR_MB_POOL_SIZE, NIC_SRAM_MBUF_POOL_SIZE64);
-	else
-		tw32(BUFMGR_MB_POOL_SIZE, NIC_SRAM_MBUF_POOL_SIZE96);
-	tw32(BUFMGR_DMA_DESC_POOL_ADDR, NIC_SRAM_DMA_DESC_POOL_BASE);
-	tw32(BUFMGR_DMA_DESC_POOL_SIZE, NIC_SRAM_DMA_DESC_POOL_SIZE);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		tw32(BUFMGR_MB_POOL_ADDR, NIC_SRAM_MBUF_POOL_BASE);
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704)
+			tw32(BUFMGR_MB_POOL_SIZE, NIC_SRAM_MBUF_POOL_SIZE64);
+		else
+			tw32(BUFMGR_MB_POOL_SIZE, NIC_SRAM_MBUF_POOL_SIZE96);
+		tw32(BUFMGR_DMA_DESC_POOL_ADDR, NIC_SRAM_DMA_DESC_POOL_BASE);
+		tw32(BUFMGR_DMA_DESC_POOL_SIZE, NIC_SRAM_DMA_DESC_POOL_SIZE);
+	}
+#if TG3_DO_TSO != 0
+	else if (tp->dev->features & NETIF_F_TSO) {
+		/* XXX TSO note: Ok, there will be two sets of firmware.
+		 * XXX           One for non-5705 and one for 5705 chips.
+		 * XXX           Once that is implemented we need to size
+		 * XXX		 that 5705-specific firmware and use it
+		 * XXX           to calculate the proper BUFMGR_MB_POOL_ADDR
+		 * XXX		 size (NIC_SRAM_MBUF_POOL_BASE5705 + 5705fw_len)
+		 * XXX		 and BUFMGR_MB_POOL_SIZE value
+		 * XXX		 (NIC_SRAM_MBUF_POOL_SIZE5705 - 5705fw_len - 0xa00)
+		 */
+#if 0
+		fw_len = tg3_tso_fw_len(tp);
+		fw_len = (fw_len + (0x80 - 1)) & ~(0x80 - 1);
+		tw32(BUFMGR_MB_POOL_ADDR, NIC_SRAM_MBUF_POOL_BASE5705 + fw_len);
+		tw32(BUFMGR_MB_POOL_SIZE, NIC_SRAM_MBUF_POOL_SIZE5705 - fw_len - 0xa00);
+#endif
+	}
+#endif
 
 	if (!(tp->tg3_flags & TG3_FLAG_JUMBO_ENABLE)) {
 		tw32(BUFMGR_MB_RDMA_LOW_WATER,
@@ -4025,6 +4197,9 @@
 		return -ENODEV;
 	}
 
+	/* Setup replenish threshold. */
+	tw32(RCVBDI_STD_THRESH, tp->rx_pending / 8);
+
 	/* Initialize TG3_BDINFO's at:
 	 *  RCVDBDI_STD_BD:	standard eth size rx ring
 	 *  RCVDBDI_JUMBO_BD:	jumbo frame rx ring
@@ -4046,35 +4221,50 @@
 	     ((u64) tp->rx_std_mapping >> 32));
 	tw32(RCVDBDI_STD_BD + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_LOW,
 	     ((u64) tp->rx_std_mapping & 0xffffffff));
-	tw32(RCVDBDI_STD_BD + TG3_BDINFO_MAXLEN_FLAGS,
-	     RX_STD_MAX_SIZE << BDINFO_FLAGS_MAXLEN_SHIFT);
 	tw32(RCVDBDI_STD_BD + TG3_BDINFO_NIC_ADDR,
 	     NIC_SRAM_RX_BUFFER_DESC);
 
-	tw32(RCVDBDI_MINI_BD + TG3_BDINFO_MAXLEN_FLAGS,
-	     BDINFO_FLAGS_DISABLED);
-
-	if (tp->tg3_flags & TG3_FLAG_JUMBO_ENABLE) {
-		tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_HIGH,
-		     ((u64) tp->rx_jumbo_mapping >> 32));
-		tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_LOW,
-		     ((u64) tp->rx_jumbo_mapping & 0xffffffff));
-		tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_MAXLEN_FLAGS,
-		     RX_JUMBO_MAX_SIZE << BDINFO_FLAGS_MAXLEN_SHIFT);
-		tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_NIC_ADDR,
-		     NIC_SRAM_RX_JUMBO_BUFFER_DESC);
+	/* Don't even try to program the JUMBO/MINI buffer descriptor
+	 * configs on 5705.
+	 */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		tw32(RCVDBDI_STD_BD + TG3_BDINFO_MAXLEN_FLAGS,
+		     RX_STD_MAX_SIZE_5705 << BDINFO_FLAGS_MAXLEN_SHIFT);
 	} else {
-		tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_MAXLEN_FLAGS,
+		tw32(RCVDBDI_STD_BD + TG3_BDINFO_MAXLEN_FLAGS,
+		     RX_STD_MAX_SIZE << BDINFO_FLAGS_MAXLEN_SHIFT);
+
+		tw32(RCVDBDI_MINI_BD + TG3_BDINFO_MAXLEN_FLAGS,
 		     BDINFO_FLAGS_DISABLED);
-	}
 
-	/* Setup replenish thresholds. */
-	tw32(RCVBDI_STD_THRESH, tp->rx_pending / 8);
-	tw32(RCVBDI_JUMBO_THRESH, tp->rx_jumbo_pending / 8);
+		/* Setup replenish threshold. */
+		tw32(RCVBDI_JUMBO_THRESH, tp->rx_jumbo_pending / 8);
 
-	/* Clear out send RCB ring in SRAM. */
-	for (i = NIC_SRAM_SEND_RCB; i < NIC_SRAM_RCV_RET_RCB; i += TG3_BDINFO_SIZE)
-		tg3_write_mem(tp, i + TG3_BDINFO_MAXLEN_FLAGS, BDINFO_FLAGS_DISABLED);
+		if (tp->tg3_flags & TG3_FLAG_JUMBO_ENABLE) {
+			tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_HIGH,
+			     ((u64) tp->rx_jumbo_mapping >> 32));
+			tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_HOST_ADDR + TG3_64BIT_REG_LOW,
+			     ((u64) tp->rx_jumbo_mapping & 0xffffffff));
+			tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_MAXLEN_FLAGS,
+			     RX_JUMBO_MAX_SIZE << BDINFO_FLAGS_MAXLEN_SHIFT);
+			tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_NIC_ADDR,
+			     NIC_SRAM_RX_JUMBO_BUFFER_DESC);
+		} else {
+			tw32(RCVDBDI_JUMBO_BD + TG3_BDINFO_MAXLEN_FLAGS,
+			     BDINFO_FLAGS_DISABLED);
+		}
+
+	}
+
+	/* There is only one send ring on 5705, no need to explicitly
+	 * disable the others.
+	 */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		/* Clear out send RCB ring in SRAM. */
+		for (i = NIC_SRAM_SEND_RCB; i < NIC_SRAM_RCV_RET_RCB; i += TG3_BDINFO_SIZE)
+			tg3_write_mem(tp, i + TG3_BDINFO_MAXLEN_FLAGS,
+				      BDINFO_FLAGS_DISABLED);
+	}
 
 	tp->tx_prod = 0;
 	tp->tx_cons = 0;
@@ -4096,9 +4286,15 @@
 			       NIC_SRAM_TX_BUFFER_DESC);
 	}
 
-	for (i = NIC_SRAM_RCV_RET_RCB; i < NIC_SRAM_STATS_BLK; i += TG3_BDINFO_SIZE) {
-		tg3_write_mem(tp, i + TG3_BDINFO_MAXLEN_FLAGS,
-			      BDINFO_FLAGS_DISABLED);
+	/* There is only one receive return ring on 5705, no need to explicitly
+	 * disable the others.
+	 */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		for (i = NIC_SRAM_RCV_RET_RCB; i < NIC_SRAM_STATS_BLK;
+		     i += TG3_BDINFO_SIZE) {
+			tg3_write_mem(tp, i + TG3_BDINFO_MAXLEN_FLAGS,
+				      BDINFO_FLAGS_DISABLED);
+		}
 	}
 
 	tp->rx_rcb_ptr = 0;
@@ -4108,7 +4304,7 @@
 
 	tg3_set_bdinfo(tp, NIC_SRAM_RCV_RET_RCB,
 		       tp->rx_rcb_mapping,
-		       (TG3_RX_RCB_RING_SIZE <<
+		       (TG3_RX_RCB_RING_SIZE(tp) <<
 			BDINFO_FLAGS_MAXLEN_SHIFT),
 		       0);
 
@@ -4162,33 +4358,43 @@
 	}
 
 	tw32(HOSTCC_RXCOL_TICKS, 0);
-	tw32(HOSTCC_RXMAX_FRAMES, 1);
-	tw32(HOSTCC_RXCOAL_TICK_INT, 0);
-	tw32(HOSTCC_RXCOAL_MAXF_INT, 1);
 	tw32(HOSTCC_TXCOL_TICKS, LOW_TXCOL_TICKS);
+	tw32(HOSTCC_RXMAX_FRAMES, 1);
 	tw32(HOSTCC_TXMAX_FRAMES, LOW_RXMAX_FRAMES);
-	tw32(HOSTCC_TXCOAL_TICK_INT, 0);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705)
+		tw32(HOSTCC_RXCOAL_TICK_INT, 0);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705)
+		tw32(HOSTCC_TXCOAL_TICK_INT, 0);
+	tw32(HOSTCC_RXCOAL_MAXF_INT, 1);
 	tw32(HOSTCC_TXCOAL_MAXF_INT, 0);
-	tw32(HOSTCC_STAT_COAL_TICKS,
-	     DEFAULT_STAT_COAL_TICKS);
 
-	/* Status/statistics block address. */
-	tw32(HOSTCC_STATS_BLK_HOST_ADDR + TG3_64BIT_REG_HIGH,
-	     ((u64) tp->stats_mapping >> 32));
-	tw32(HOSTCC_STATS_BLK_HOST_ADDR + TG3_64BIT_REG_LOW,
-	     ((u64) tp->stats_mapping & 0xffffffff));
+	/* set status block DMA address */
 	tw32(HOSTCC_STATUS_BLK_HOST_ADDR + TG3_64BIT_REG_HIGH,
 	     ((u64) tp->status_mapping >> 32));
 	tw32(HOSTCC_STATUS_BLK_HOST_ADDR + TG3_64BIT_REG_LOW,
 	     ((u64) tp->status_mapping & 0xffffffff));
-	tw32(HOSTCC_STATS_BLK_NIC_ADDR, NIC_SRAM_STATS_BLK);
-	tw32(HOSTCC_STATUS_BLK_NIC_ADDR, NIC_SRAM_STATUS_BLK);
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		/* Status/statistics block address.  See tg3_timer,
+		 * the tg3_periodic_fetch_stats call there, and
+		 * tg3_get_stats to see how this works for 5705 chips.
+		 */
+		tw32(HOSTCC_STAT_COAL_TICKS,
+		     DEFAULT_STAT_COAL_TICKS);
+		tw32(HOSTCC_STATS_BLK_HOST_ADDR + TG3_64BIT_REG_HIGH,
+		     ((u64) tp->stats_mapping >> 32));
+		tw32(HOSTCC_STATS_BLK_HOST_ADDR + TG3_64BIT_REG_LOW,
+		     ((u64) tp->stats_mapping & 0xffffffff));
+		tw32(HOSTCC_STATS_BLK_NIC_ADDR, NIC_SRAM_STATS_BLK);
+		tw32(HOSTCC_STATUS_BLK_NIC_ADDR, NIC_SRAM_STATUS_BLK);
+	}
 
 	tw32(HOSTCC_MODE, HOSTCC_MODE_ENABLE | tp->coalesce_mode);
 
 	tw32(RCVCC_MODE, RCVCC_MODE_ENABLE | RCVCC_MODE_ATTN_ENABLE);
 	tw32(RCVLPC_MODE, RCVLPC_MODE_ENABLE);
-	tw32(RCVLSC_MODE, RCVLSC_MODE_ENABLE | RCVLSC_MODE_ATTN_ENABLE);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705)
+		tw32(RCVLSC_MODE, RCVLSC_MODE_ENABLE | RCVLSC_MODE_ATTN_ENABLE);
 
 	tp->mac_mode = MAC_MODE_TXSTAT_ENABLE | MAC_MODE_RXSTAT_ENABLE |
 		MAC_MODE_TDE_ENABLE | MAC_MODE_RDE_ENABLE | MAC_MODE_FHDE_ENABLE;
@@ -4207,26 +4413,36 @@
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0);
 	tr32(MAILBOX_INTERRUPT_0);
 
-	tw32(DMAC_MODE, DMAC_MODE_ENABLE);
-	tr32(DMAC_MODE);
-	udelay(40);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
+		tw32(DMAC_MODE, DMAC_MODE_ENABLE);
+		tr32(DMAC_MODE);
+		udelay(40);
+	}
 
-	tw32(WDMAC_MODE, (WDMAC_MODE_ENABLE | WDMAC_MODE_TGTABORT_ENAB |
-			  WDMAC_MODE_MSTABORT_ENAB | WDMAC_MODE_PARITYERR_ENAB |
-			  WDMAC_MODE_ADDROFLOW_ENAB | WDMAC_MODE_FIFOOFLOW_ENAB |
-			  WDMAC_MODE_FIFOURUN_ENAB | WDMAC_MODE_FIFOOREAD_ENAB |
-			  WDMAC_MODE_LNGREAD_ENAB));
+	val = (WDMAC_MODE_ENABLE | WDMAC_MODE_TGTABORT_ENAB |
+	       WDMAC_MODE_MSTABORT_ENAB | WDMAC_MODE_PARITYERR_ENAB |
+	       WDMAC_MODE_ADDROFLOW_ENAB | WDMAC_MODE_FIFOOFLOW_ENAB |
+	       WDMAC_MODE_FIFOURUN_ENAB | WDMAC_MODE_FIFOOREAD_ENAB |
+	       WDMAC_MODE_LNGREAD_ENAB);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 &&
+	    (tr32(TG3PCI_PCISTATE) & PCISTATE_BUS_SPEED_HIGH) != 0)
+		val |= WDMAC_MODE_RX_ACCEL;
+	tw32(WDMAC_MODE, val);
 	tr32(WDMAC_MODE);
 	udelay(40);
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
-	    (tp->tg3_flags & TG3_FLAG_PCIX_MODE)) {
+	if ((tp->tg3_flags & TG3_FLAG_PCIX_MODE) != 0) {
 		val = tr32(TG3PCI_X_CAPS);
-		val &= ~(PCIX_CAPS_SPLIT_MASK | PCIX_CAPS_BURST_MASK);
-		val |= (PCIX_CAPS_MAX_BURST_5704 << PCIX_CAPS_BURST_SHIFT);
-		if (tp->tg3_flags & TG3_FLAG_SPLIT_MODE)
-			val |= (tp->split_mode_max_reqs <<
-				PCIX_CAPS_SPLIT_SHIFT);
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703) {
+			val &= ~PCIX_CAPS_BURST_MASK;
+			val |= (PCIX_CAPS_MAX_BURST_CPIOB << PCIX_CAPS_BURST_SHIFT);
+		} else if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704) {
+			val &= ~(PCIX_CAPS_SPLIT_MASK | PCIX_CAPS_BURST_MASK);
+			val |= (PCIX_CAPS_MAX_BURST_CPIOB << PCIX_CAPS_BURST_SHIFT);
+			if (tp->tg3_flags & TG3_FLAG_SPLIT_MODE)
+				val |= (tp->split_mode_max_reqs <<
+					PCIX_CAPS_SPLIT_SHIFT);
+		}
 		tw32(TG3PCI_X_CAPS, val);
 	}
 
@@ -4237,12 +4453,25 @@
 	       RDMAC_MODE_LNGREAD_ENAB);
 	if (tp->tg3_flags & TG3_FLAG_SPLIT_MODE)
 		val |= RDMAC_MODE_SPLIT_ENABLE;
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		if (tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) {
+#if TG3_DO_TSO != 0
+			if (tp->dev->features & NETIF_F_TSO) {
+				val |= RDMAC_MODE_FIFO_SIZE_128;
+			} else
+#endif
+			if (!(tr32(TG3PCI_PCISTATE) & PCISTATE_BUS_SPEED_HIGH)) {
+				val |= RDMAC_MODE_FIFO_LONG_BURST;
+			}
+		}
+	}
 	tw32(RDMAC_MODE, val);
 	tr32(RDMAC_MODE);
 	udelay(40);
 
 	tw32(RCVDCC_MODE, RCVDCC_MODE_ENABLE | RCVDCC_MODE_ATTN_ENABLE);
-	tw32(MBFREE_MODE, MBFREE_MODE_ENABLE);
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705)
+		tw32(MBFREE_MODE, MBFREE_MODE_ENABLE);
 	tw32(SNDDATAC_MODE, SNDDATAC_MODE_ENABLE);
 	tw32(SNDBDC_MODE, SNDBDC_MODE_ENABLE | SNDBDC_MODE_ATTN_ENABLE);
 	tw32(RCVBDI_MODE, RCVBDI_MODE_ENABLE | RCVBDI_MODE_RCB_ATTN_ENAB);
@@ -4323,22 +4552,48 @@
 	tw32(MAC_RCV_VALUE_0, 0xffffffff & RCV_RULE_DISABLE_MASK);
 	tw32(MAC_RCV_RULE_1,  0x86000004 & RCV_RULE_DISABLE_MASK);
 	tw32(MAC_RCV_VALUE_1, 0xffffffff & RCV_RULE_DISABLE_MASK);
-#if 0
-	tw32(MAC_RCV_RULE_2,  0); tw32(MAC_RCV_VALUE_2,  0);
-	tw32(MAC_RCV_RULE_3,  0); tw32(MAC_RCV_VALUE_3,  0);
-#endif
-	tw32(MAC_RCV_RULE_4,  0); tw32(MAC_RCV_VALUE_4,  0);
-	tw32(MAC_RCV_RULE_5,  0); tw32(MAC_RCV_VALUE_5,  0);
-	tw32(MAC_RCV_RULE_6,  0); tw32(MAC_RCV_VALUE_6,  0);
-	tw32(MAC_RCV_RULE_7,  0); tw32(MAC_RCV_VALUE_7,  0);
-	tw32(MAC_RCV_RULE_8,  0); tw32(MAC_RCV_VALUE_8,  0);
-	tw32(MAC_RCV_RULE_9,  0); tw32(MAC_RCV_VALUE_9,  0);
-	tw32(MAC_RCV_RULE_10,  0); tw32(MAC_RCV_VALUE_10,  0);
-	tw32(MAC_RCV_RULE_11,  0); tw32(MAC_RCV_VALUE_11,  0);
-	tw32(MAC_RCV_RULE_12,  0); tw32(MAC_RCV_VALUE_12,  0);
-	tw32(MAC_RCV_RULE_13,  0); tw32(MAC_RCV_VALUE_13,  0);
-	tw32(MAC_RCV_RULE_14,  0); tw32(MAC_RCV_VALUE_14,  0);
-	tw32(MAC_RCV_RULE_15,  0); tw32(MAC_RCV_VALUE_15,  0);
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		limit = 8;
+	else
+		limit = 16;
+	if (tp->tg3_flags & TG3_FLAG_ENABLE_ASF)
+		limit -= 4;
+	switch (limit) {
+	case 16:
+		tw32(MAC_RCV_RULE_15,  0); tw32(MAC_RCV_VALUE_15,  0);
+	case 15:
+		tw32(MAC_RCV_RULE_14,  0); tw32(MAC_RCV_VALUE_14,  0);
+	case 14:
+		tw32(MAC_RCV_RULE_13,  0); tw32(MAC_RCV_VALUE_13,  0);
+	case 13:
+		tw32(MAC_RCV_RULE_12,  0); tw32(MAC_RCV_VALUE_12,  0);
+	case 12:
+		tw32(MAC_RCV_RULE_11,  0); tw32(MAC_RCV_VALUE_11,  0);
+	case 11:
+		tw32(MAC_RCV_RULE_10,  0); tw32(MAC_RCV_VALUE_10,  0);
+	case 10:
+		tw32(MAC_RCV_RULE_9,  0); tw32(MAC_RCV_VALUE_9,  0);
+	case 9:
+		tw32(MAC_RCV_RULE_8,  0); tw32(MAC_RCV_VALUE_8,  0);
+	case 8:
+		tw32(MAC_RCV_RULE_7,  0); tw32(MAC_RCV_VALUE_7,  0);
+	case 7:
+		tw32(MAC_RCV_RULE_6,  0); tw32(MAC_RCV_VALUE_6,  0);
+	case 6:
+		tw32(MAC_RCV_RULE_5,  0); tw32(MAC_RCV_VALUE_5,  0);
+	case 5:
+		tw32(MAC_RCV_RULE_4,  0); tw32(MAC_RCV_VALUE_4,  0);
+	case 4:
+		/* tw32(MAC_RCV_RULE_3,  0); tw32(MAC_RCV_VALUE_3,  0); */
+	case 3:
+		/* tw32(MAC_RCV_RULE_2,  0); tw32(MAC_RCV_VALUE_2,  0); */
+	case 2:
+	case 1:
+
+	default:
+		break;
+	};
 
 	if (tp->tg3_flags & TG3_FLAG_INIT_COMPLETE)
 		tg3_enable_ints(tp);
@@ -4368,6 +4623,50 @@
 	return err;
 }
 
+#define TG3_STAT_ADD32(PSTAT, REG) \
+do {	u32 __val = tr32(REG); \
+	(PSTAT)->low += __val; \
+	if ((PSTAT)->low < __val) \
+		(PSTAT)->high += 1; \
+} while (0)
+
+static void tg3_periodic_fetch_stats(struct tg3 *tp)
+{
+	struct tg3_hw_stats *sp = tp->hw_stats;
+
+	if (!netif_carrier_ok(tp->dev))
+		return;
+
+	TG3_STAT_ADD32(&sp->tx_octets, MAC_TX_STATS_OCTETS);
+	TG3_STAT_ADD32(&sp->tx_collisions, MAC_TX_STATS_COLLISIONS);
+	TG3_STAT_ADD32(&sp->tx_xon_sent, MAC_TX_STATS_XON_SENT);
+	TG3_STAT_ADD32(&sp->tx_xoff_sent, MAC_TX_STATS_XOFF_SENT);
+	TG3_STAT_ADD32(&sp->tx_mac_errors, MAC_TX_STATS_MAC_ERRORS);
+	TG3_STAT_ADD32(&sp->tx_single_collisions, MAC_TX_STATS_SINGLE_COLLISIONS);
+	TG3_STAT_ADD32(&sp->tx_mult_collisions, MAC_TX_STATS_MULT_COLLISIONS);
+	TG3_STAT_ADD32(&sp->tx_deferred, MAC_TX_STATS_DEFERRED);
+	TG3_STAT_ADD32(&sp->tx_excessive_collisions, MAC_TX_STATS_EXCESSIVE_COL);
+	TG3_STAT_ADD32(&sp->tx_late_collisions, MAC_TX_STATS_LATE_COL);
+	TG3_STAT_ADD32(&sp->tx_ucast_packets, MAC_TX_STATS_UCAST);
+	TG3_STAT_ADD32(&sp->tx_mcast_packets, MAC_TX_STATS_MCAST);
+	TG3_STAT_ADD32(&sp->tx_bcast_packets, MAC_TX_STATS_BCAST);
+
+	TG3_STAT_ADD32(&sp->rx_octets, MAC_RX_STATS_OCTETS);
+	TG3_STAT_ADD32(&sp->rx_fragments, MAC_RX_STATS_FRAGMENTS);
+	TG3_STAT_ADD32(&sp->rx_ucast_packets, MAC_RX_STATS_UCAST);
+	TG3_STAT_ADD32(&sp->rx_mcast_packets, MAC_RX_STATS_MCAST);
+	TG3_STAT_ADD32(&sp->rx_bcast_packets, MAC_RX_STATS_BCAST);
+	TG3_STAT_ADD32(&sp->rx_fcs_errors, MAC_RX_STATS_FCS_ERRORS);
+	TG3_STAT_ADD32(&sp->rx_align_errors, MAC_RX_STATS_ALIGN_ERRORS);
+	TG3_STAT_ADD32(&sp->rx_xon_pause_rcvd, MAC_RX_STATS_XON_PAUSE_RECVD);
+	TG3_STAT_ADD32(&sp->rx_xoff_pause_rcvd, MAC_RX_STATS_XOFF_PAUSE_RECVD);
+	TG3_STAT_ADD32(&sp->rx_mac_ctrl_rcvd, MAC_RX_STATS_MAC_CTRL_RECVD);
+	TG3_STAT_ADD32(&sp->rx_xoff_entered, MAC_RX_STATS_XOFF_ENTERED);
+	TG3_STAT_ADD32(&sp->rx_frame_too_long_errors, MAC_RX_STATS_FRAME_TOO_LONG);
+	TG3_STAT_ADD32(&sp->rx_jabbers, MAC_RX_STATS_JABBERS);
+	TG3_STAT_ADD32(&sp->rx_undersize_packets, MAC_RX_STATS_UNDERSIZE);
+}
+
 static void tg3_timer(unsigned long __opaque)
 {
 	struct tg3 *tp = (struct tg3 *) __opaque;
@@ -4396,6 +4695,9 @@
 		return;
 	}
 
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		tg3_periodic_fetch_stats(tp);
+
 	/* This part only runs once per second. */
 	if (!--tp->timer_counter) {
 		if (tp->tg3_flags & TG3_FLAG_USE_LINKCHG_REG) {
@@ -4849,6 +5151,13 @@
 	if (!hw_stats)
 		return old_stats;
 
+	/* On the 5705 we can't DMA the stats to memory, thus
+	 * a timer simply keeps tp->stats uptodate with direct
+	 * periodic reads of the statistics registers via a timer.
+	 */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		return stats;
+
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
 		get_stat64(&hw_stats->rx_mcast_packets) +
@@ -5304,6 +5613,13 @@
 		spin_lock(&tp->tx_lock);
 
 		tp->rx_pending = ering.rx_pending;
+		if (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 &&
+#if TG3_DO_TSO != 0
+		    !(dev->features & NETIF_F_TSO) &&
+#endif
+		    !(tr32(TG3PCI_PCISTATE) & PCISTATE_BUS_SPEED_HIGH) &&
+		    tp->rx_pending > 64)
+			tp->rx_pending = 64;
 		tp->rx_jumbo_pending = ering.rx_jumbo_pending;
 		tp->tx_pending = ering.tx_pending;
 
@@ -5709,6 +6025,7 @@
 		u32 nic_cfg;
 
 		tg3_read_mem(tp, NIC_SRAM_DATA_CFG, &nic_cfg);
+		tp->nic_sram_data_cfg = nic_cfg;
 
 		eeprom_signature_found = 1;
 
@@ -5742,8 +6059,10 @@
 			eeprom_led_mode = led_mode_auto;
 			break;
 		};
-		if ((tp->pci_chip_rev_id == CHIPREV_ID_5703_A1 ||
-		     tp->pci_chip_rev_id == CHIPREV_ID_5703_A2) &&
+
+		if (((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703) ||
+		     (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704) ||
+		     (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)) &&
 		    (nic_cfg & NIC_SRAM_DATA_CFG_EEPROM_WP))
 			tp->tg3_flags |= TG3_FLAG_EEPROM_WRITE_PROT;
 
@@ -5825,9 +6144,7 @@
 	}
 
 	/* Enable Ethernet@WireSpeed */
-	tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x7007);
-	tg3_readphy(tp, MII_TG3_AUX_CTRL, &val);
-	tg3_writephy(tp, MII_TG3_AUX_CTRL, (val | (1 << 15) | (1 << 4)));
+	tg3_phy_set_wirespeed(tp);
 
 	if (!err && ((tp->phy_id & PHY_ID_MASK) == PHY_ID_BCM5401)) {
 		err = tg3_init_5401phy_dsp(tp);
@@ -6084,6 +6401,13 @@
 		tp->tg3_flags |= TG3_FLAG_WOL_SPEED_100MB;
 	}
 
+	/* A few boards don't want Ethernet@WireSpeed phy feature */
+	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700) ||
+	    ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) &&
+	     (tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) &&
+	     (tp->pci_chip_rev_id != CHIPREV_ID_5705_A1)))
+		tp->tg3_flags2 |= TG3_FLG2_NO_ETH_WIRE_SPEED;
+
 	/* Only 5701 and later support tagged irq status mode.
 	 *
 	 * However, since we are using NAPI avoid tagged irq status
@@ -6141,7 +6465,8 @@
 	/* Determine if TX descriptors will reside in
 	 * main memory or in the chip SRAM.
 	 */
-	if (tp->tg3_flags & TG3_FLAG_PCIX_TARGET_HWBUG)
+	if ((tp->tg3_flags & TG3_FLAG_PCIX_TARGET_HWBUG) != 0 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
 		tp->tg3_flags |= TG3_FLAG_HOST_TXDS;
 
 	grc_misc_cfg = tr32(GRC_MISC_CFG);
@@ -6153,8 +6478,9 @@
 		tp->split_mode_max_reqs = SPLIT_MODE_5704_MAX_REQ;
 	}
 
-	/* this one is limited to 10/100 only */
-	if (grc_misc_cfg == GRC_MISC_CFG_BOARD_ID_5702FE)
+	/* these are limited to 10/100 only */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703 &&
+	    (grc_misc_cfg == 0x8000 || grc_misc_cfg == 0x4000))
 		tp->tg3_flags |= TG3_FLAG_10_100_ONLY;
 
 	err = tg3_phy_probe(tp);
@@ -6376,8 +6702,6 @@
 		goto out_nofree;
 	}
 
-	tw32(TG3PCI_CLOCK_CTRL, 0);
-
 	if ((tp->tg3_flags & TG3_FLAG_PCIX_MODE) == 0) {
 		tp->dma_rwctrl =
 			(0x7 << DMA_RWCTRL_PCI_WRITE_CMD_SHIFT) |
@@ -6385,7 +6709,9 @@
 			(0x7 << DMA_RWCTRL_WRITE_WATER_SHIFT) |
 			(0x7 << DMA_RWCTRL_READ_WATER_SHIFT) |
 			(0x0f << DMA_RWCTRL_MIN_DMA_SHIFT);
-		/* XXX 5705 note: set MIN_DMA to zero here */
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+			tp->dma_rwctrl &= ~(DMA_RWCTRL_MIN_DMA
+					    << DMA_RWCTRL_MIN_DMA_SHIFT);
 	} else {
 		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704)
 			tp->dma_rwctrl =
@@ -6488,6 +6814,11 @@
 
 	tw32(TG3PCI_DMA_RW_CTRL, tp->dma_rwctrl);
 
+#if 0
+	/* Unneeded, already done by tg3_get_invariants.  */
+	tg3_switch_clocks(tp);
+#endif
+
 	ret = 0;
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5700 &&
 	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5701)
@@ -6592,12 +6923,35 @@
 	case PHY_ID_BCM5701:	return "5701";
 	case PHY_ID_BCM5703:	return "5703";
 	case PHY_ID_BCM5704:	return "5704";
+	case PHY_ID_BCM5705:	return "5705";
 	case PHY_ID_BCM8002:	return "8002";
 	case PHY_ID_SERDES:	return "serdes";
 	default:		return "unknown";
 	};
 }
 
+static struct pci_dev * __devinit tg3_find_5704_peer(struct tg3 *tp)
+{
+	struct pci_dev *peer = NULL;
+	unsigned int func;
+
+	for (func = 0; func < 7; func++) {
+		unsigned int devfn = tp->pdev->devfn;
+
+		devfn &= ~7;
+		devfn |= func;
+
+		if (devfn == tp->pdev->devfn)
+			continue;
+		peer = pci_find_slot(tp->pdev->bus->number, devfn);
+		if (peer)
+			break;
+	}
+	if (!peer || peer == tp->pdev)
+		BUG();
+	return peer;
+}
+
 static int __devinit tg3_init_one(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
@@ -6751,6 +7105,38 @@
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) {
+		tp->bufmgr_config.mbuf_read_dma_low_water =
+			DEFAULT_MB_RDMA_LOW_WATER_5705;
+		tp->bufmgr_config.mbuf_mac_rx_low_water =
+			DEFAULT_MB_MACRX_LOW_WATER_5705;
+		tp->bufmgr_config.mbuf_high_water =
+			DEFAULT_MB_HIGH_WATER_5705;
+	}
+
+#if TG3_DO_TSO != 0
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701 ||
+	    tp->pci_chip_rev_id == CHIPREV_ID_5705_A0 ||
+	    (tp->tg3_flags & TG3_FLAG_ENABLE_ASF) != 0)
+		dev->features &= ~NETIF_F_TSO;
+
+#if 1 /* Kill this when 5705 TSO firmware added.  */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705)
+		dev->features &= ~NETIF_F_TSO;
+#endif
+#endif
+
+	if (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 &&
+#if TG3_DO_TSO != 0
+	    !(dev->features & NETIF_F_TSO) &&
+#endif
+	    !(tr32(TG3PCI_PCISTATE) & PCISTATE_BUS_SPEED_HIGH))
+		tp->rx_pending = 64;
+
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704)
+		tp->pdev_peer = tg3_find_5704_peer(tp);
 
 	err = tg3_get_device_address(tp);
 	if (err) {
diff -Nru a/drivers/net/tg3.h b/drivers/net/tg3.h
--- a/drivers/net/tg3.h	Tue Jul 29 13:08:22 2003
+++ b/drivers/net/tg3.h	Tue Jul 29 13:08:22 2003
@@ -24,6 +24,7 @@
 #define RX_COPY_THRESHOLD  		256
 
 #define RX_STD_MAX_SIZE			1536
+#define RX_STD_MAX_SIZE_5705		512
 #define RX_JUMBO_MAX_SIZE		0xdeadbeef /* XXX */
 
 /* First 256 bytes are a mirror of PCI config space. */
@@ -59,7 +60,7 @@
 #define  PCIX_CAPS_SPLIT_SHIFT		 20
 #define  PCIX_CAPS_BURST_MASK		 0x000c0000
 #define  PCIX_CAPS_BURST_SHIFT		 18
-#define  PCIX_CAPS_MAX_BURST_5704	 2
+#define  PCIX_CAPS_MAX_BURST_CPIOB	 2
 #define TG3PCI_PM_CAP_PTR		0x00000041
 #define TG3PCI_X_COMMAND		0x00000042
 #define TG3PCI_X_STATUS			0x00000044
@@ -115,11 +116,14 @@
 #define  CHIPREV_ID_5704_A0		 0x2000
 #define  CHIPREV_ID_5704_A1		 0x2001
 #define  CHIPREV_ID_5704_A2		 0x2002
+#define  CHIPREV_ID_5705_A0		 0x3000
+#define  CHIPREV_ID_5705_A1		 0x3001
 #define  GET_ASIC_REV(CHIP_REV_ID)	((CHIP_REV_ID) >> 12)
 #define   ASIC_REV_5700			 0x07
 #define   ASIC_REV_5701			 0x00
 #define   ASIC_REV_5703			 0x01
 #define   ASIC_REV_5704			 0x02
+#define   ASIC_REV_5705			 0x03
 #define  GET_CHIP_REV(CHIP_REV_ID)	((CHIP_REV_ID) >> 8)
 #define   CHIPREV_5700_AX		 0x70
 #define   CHIPREV_5700_BX		 0x71
@@ -180,6 +184,9 @@
 #define  CLOCK_CTRL_ALTCLK		 0x00001000
 #define  CLOCK_CTRL_PWRDOWN_PLL133	 0x00008000
 #define  CLOCK_CTRL_44MHZ_CORE		 0x00040000
+#define  CLOCK_CTRL_625_CORE		 0x00100000
+#define  CLOCK_CTRL_FORCE_CLKRUN	 0x00200000
+#define  CLOCK_CTRL_CLKRUN_OENABLE	 0x00400000
 #define  CLOCK_CTRL_DELAY_PCI_GRANT	 0x80000000
 #define TG3PCI_REG_BASE_ADDR		0x00000078
 #define TG3PCI_MEM_WIN_BASE_ADDR	0x0000007c
@@ -457,17 +464,89 @@
 #define MAC_RCV_RULE_CFG		0x00000500
 #define  RCV_RULE_CFG_DEFAULT_CLASS	0x00000008
 #define MAC_LOW_WMARK_MAX_RX_FRAME	0x00000504
-/* 0x504 --> 0x590 unused */
+/* 0x508 --> 0x520 unused */
+#define MAC_HASHREGU_0			0x00000520
+#define MAC_HASHREGU_1			0x00000524
+#define MAC_HASHREGU_2			0x00000528
+#define MAC_HASHREGU_3			0x0000052c
+#define MAC_EXTADDR_0_HIGH		0x00000530
+#define MAC_EXTADDR_0_LOW		0x00000534
+#define MAC_EXTADDR_1_HIGH		0x00000538
+#define MAC_EXTADDR_1_LOW		0x0000053c
+#define MAC_EXTADDR_2_HIGH		0x00000540
+#define MAC_EXTADDR_2_LOW		0x00000544
+#define MAC_EXTADDR_3_HIGH		0x00000548
+#define MAC_EXTADDR_3_LOW		0x0000054c
+#define MAC_EXTADDR_4_HIGH		0x00000550
+#define MAC_EXTADDR_4_LOW		0x00000554
+#define MAC_EXTADDR_5_HIGH		0x00000558
+#define MAC_EXTADDR_5_LOW		0x0000055c
+#define MAC_EXTADDR_6_HIGH		0x00000560
+#define MAC_EXTADDR_6_LOW		0x00000564
+#define MAC_EXTADDR_7_HIGH		0x00000568
+#define MAC_EXTADDR_7_LOW		0x0000056c
+#define MAC_EXTADDR_8_HIGH		0x00000570
+#define MAC_EXTADDR_8_LOW		0x00000574
+#define MAC_EXTADDR_9_HIGH		0x00000578
+#define MAC_EXTADDR_9_LOW		0x0000057c
+#define MAC_EXTADDR_10_HIGH		0x00000580
+#define MAC_EXTADDR_10_LOW		0x00000584
+#define MAC_EXTADDR_11_HIGH		0x00000588
+#define MAC_EXTADDR_11_LOW		0x0000058c
 #define MAC_SERDES_CFG			0x00000590
 #define MAC_SERDES_STAT			0x00000594
 /* 0x598 --> 0x600 unused */
 #define MAC_TX_MAC_STATE_BASE		0x00000600 /* 16 bytes */
 #define MAC_RX_MAC_STATE_BASE		0x00000610 /* 20 bytes */
 /* 0x624 --> 0x800 unused */
-#define MAC_RX_STATS_BASE		0x00000800 /* 26 32-bit words */
-/* 0x868 --> 0x880 unused */
-#define MAC_TX_STATS_BASE		0x00000880 /* 28 32-bit words */
-/* 0x8f0 --> 0xc00 unused */
+#define MAC_TX_STATS_OCTETS		0x00000800
+#define MAC_TX_STATS_RESV1		0x00000804
+#define MAC_TX_STATS_COLLISIONS		0x00000808
+#define MAC_TX_STATS_XON_SENT		0x0000080c
+#define MAC_TX_STATS_XOFF_SENT		0x00000810
+#define MAC_TX_STATS_RESV2		0x00000814
+#define MAC_TX_STATS_MAC_ERRORS		0x00000818
+#define MAC_TX_STATS_SINGLE_COLLISIONS	0x0000081c
+#define MAC_TX_STATS_MULT_COLLISIONS	0x00000820
+#define MAC_TX_STATS_DEFERRED		0x00000824
+#define MAC_TX_STATS_RESV3		0x00000828
+#define MAC_TX_STATS_EXCESSIVE_COL	0x0000082c
+#define MAC_TX_STATS_LATE_COL		0x00000830
+#define MAC_TX_STATS_RESV4_1		0x00000834
+#define MAC_TX_STATS_RESV4_2		0x00000838
+#define MAC_TX_STATS_RESV4_3		0x0000083c
+#define MAC_TX_STATS_RESV4_4		0x00000840
+#define MAC_TX_STATS_RESV4_5		0x00000844
+#define MAC_TX_STATS_RESV4_6		0x00000848
+#define MAC_TX_STATS_RESV4_7		0x0000084c
+#define MAC_TX_STATS_RESV4_8		0x00000850
+#define MAC_TX_STATS_RESV4_9		0x00000854
+#define MAC_TX_STATS_RESV4_10		0x00000858
+#define MAC_TX_STATS_RESV4_11		0x0000085c
+#define MAC_TX_STATS_RESV4_12		0x00000860
+#define MAC_TX_STATS_RESV4_13		0x00000864
+#define MAC_TX_STATS_RESV4_14		0x00000868
+#define MAC_TX_STATS_UCAST		0x0000086c
+#define MAC_TX_STATS_MCAST		0x00000870
+#define MAC_TX_STATS_BCAST		0x00000874
+#define MAC_TX_STATS_RESV5_1		0x00000878
+#define MAC_TX_STATS_RESV5_2		0x0000087c
+#define MAC_RX_STATS_OCTETS		0x00000880
+#define MAC_RX_STATS_RESV1		0x00000884
+#define MAC_RX_STATS_FRAGMENTS		0x00000888
+#define MAC_RX_STATS_UCAST		0x0000088c
+#define MAC_RX_STATS_MCAST		0x00000890
+#define MAC_RX_STATS_BCAST		0x00000894
+#define MAC_RX_STATS_FCS_ERRORS		0x00000898
+#define MAC_RX_STATS_ALIGN_ERRORS	0x0000089c
+#define MAC_RX_STATS_XON_PAUSE_RECVD	0x000008a0
+#define MAC_RX_STATS_XOFF_PAUSE_RECVD	0x000008a4
+#define MAC_RX_STATS_MAC_CTRL_RECVD	0x000008a8
+#define MAC_RX_STATS_XOFF_ENTERED	0x000008ac
+#define MAC_RX_STATS_FRAME_TOO_LONG	0x000008b0
+#define MAC_RX_STATS_JABBERS		0x000008b4
+#define MAC_RX_STATS_UNDERSIZE		0x000008b8
+/* 0x8bc --> 0xc00 unused */
 
 /* Send data initiator control registers */
 #define SNDDATAI_MODE			0x00000c00
@@ -812,13 +891,16 @@
 #define BUFMGR_MB_POOL_ADDR		0x00004408
 #define BUFMGR_MB_POOL_SIZE		0x0000440c
 #define BUFMGR_MB_RDMA_LOW_WATER	0x00004410
-#define  DEFAULT_MB_RDMA_LOW_WATER	 0x00000040
+#define  DEFAULT_MB_RDMA_LOW_WATER	 0x00000050
+#define  DEFAULT_MB_RDMA_LOW_WATER_5705	 0x00000000
 #define  DEFAULT_MB_RDMA_LOW_WATER_JUMBO 0x00000130
 #define BUFMGR_MB_MACRX_LOW_WATER	0x00004414
 #define  DEFAULT_MB_MACRX_LOW_WATER	  0x00000020
+#define  DEFAULT_MB_MACRX_LOW_WATER_5705  0x00000010
 #define  DEFAULT_MB_MACRX_LOW_WATER_JUMBO 0x00000098
 #define BUFMGR_MB_HIGH_WATER		0x00004418
 #define  DEFAULT_MB_HIGH_WATER		 0x00000060
+#define  DEFAULT_MB_HIGH_WATER_5705	 0x00000060
 #define  DEFAULT_MB_HIGH_WATER_JUMBO	 0x0000017c
 #define BUFMGR_RX_MB_ALLOC_REQ		0x0000441c
 #define  BUFMGR_MB_ALLOC_BIT		 0x10000000
@@ -854,6 +936,8 @@
 #define  RDMAC_MODE_LNGREAD_ENAB	 0x00000200
 #define  RDMAC_MODE_SPLIT_ENABLE	 0x00000800
 #define  RDMAC_MODE_SPLIT_RESET		 0x00001000
+#define  RDMAC_MODE_FIFO_SIZE_128	 0x00020000
+#define  RDMAC_MODE_FIFO_LONG_BURST	 0x00030000
 #define RDMAC_STATUS			0x00004804
 #define  RDMAC_STATUS_TGTABORT		 0x00000004
 #define  RDMAC_STATUS_MSTABORT		 0x00000008
@@ -877,6 +961,7 @@
 #define  WDMAC_MODE_FIFOURUN_ENAB	 0x00000080
 #define  WDMAC_MODE_FIFOOREAD_ENAB	 0x00000100
 #define  WDMAC_MODE_LNGREAD_ENAB	 0x00000200
+#define  WDMAC_MODE_RX_ACCEL	 	 0x00000400
 #define WDMAC_STATUS			0x00004c04
 #define  WDMAC_STATUS_TGTABORT		 0x00000004
 #define  WDMAC_STATUS_MSTABORT		 0x00000008
@@ -1141,6 +1226,7 @@
 #define  GRC_MISC_CFG_BOARD_ID_5704CIOBE 0x00004000
 #define  GRC_MISC_CFG_BOARD_ID_5704_A2	0x00008000
 #define  GRC_MISC_CFG_BOARD_ID_AC91002A1 0x00018000
+#define  GRC_MISC_CFG_KEEP_GPHY_POWER	0x04000000
 #define GRC_LOCAL_CTRL			0x00006808
 #define  GRC_LCLCTRL_INT_ACTIVE		0x00000001
 #define  GRC_LCLCTRL_CLEARINT		0x00000002
@@ -1275,6 +1361,7 @@
 #define  NIC_SRAM_DATA_CFG_WOL_ENABLE		 0x00000040
 #define  NIC_SRAM_DATA_CFG_ASF_ENABLE		 0x00000080
 #define  NIC_SRAM_DATA_CFG_EEPROM_WP		 0x00000100
+#define  NIC_SRAM_DATA_CFG_MINI_PCI		 0x00001000
 #define  NIC_SRAM_DATA_CFG_FIBER_WOL		 0x00004000
 
 #define NIC_SRAM_DATA_PHY_ID		0x00000b74
@@ -1312,6 +1399,8 @@
 #define NIC_SRAM_MBUF_POOL_BASE		0x00008000
 #define  NIC_SRAM_MBUF_POOL_SIZE96	 0x00018000
 #define  NIC_SRAM_MBUF_POOL_SIZE64	 0x00010000
+#define  NIC_SRAM_MBUF_POOL_BASE5705	0x00010000
+#define  NIC_SRAM_MBUF_POOL_SIZE5705	0x0000e000
 
 /* Currently this is fixed. */
 #define PHY_ADDR		0x01
@@ -1823,6 +1912,7 @@
 #define TG3_FLAG_INIT_COMPLETE		0x80000000
 	u32				tg3_flags2;
 #define TG3_FLG2_RESTART_TIMER		0x00000001
+#define TG3_FLG2_NO_ETH_WIRE_SPEED	0x00000002
 
 	u32				split_mode_max_reqs;
 #define SPLIT_MODE_5704_MAX_REQ		3
@@ -1867,6 +1957,7 @@
 #define PHY_ID_BCM5701			0x60008110
 #define PHY_ID_BCM5703			0x60008160
 #define PHY_ID_BCM5704			0x60008190
+#define PHY_ID_BCM5705			0x600081a0
 #define PHY_ID_BCM8002			0x60010140
 #define PHY_ID_SERDES			0xfeedbee0
 #define PHY_ID_INVALID			0xffffffff
@@ -1879,6 +1970,9 @@
 	enum phy_led_mode		led_mode;
 
 	char				board_part_number[24];
+	u32				nic_sram_data_cfg;
+	u32				pci_clock_ctrl;
+	struct pci_dev			*pdev_peer;
 
 	/* This macro assumes the passed PHY ID is already masked
 	 * with PHY_ID_MASK.
@@ -1887,6 +1981,7 @@
 	((X) == PHY_ID_BCM5400 || (X) == PHY_ID_BCM5401 || \
 	 (X) == PHY_ID_BCM5411 || (X) == PHY_ID_BCM5701 || \
 	 (X) == PHY_ID_BCM5703 || (X) == PHY_ID_BCM5704 || \
+	 (X) == PHY_ID_BCM5705 || \
 	 (X) == PHY_ID_BCM8002 || (X) == PHY_ID_SERDES)
 
 	struct tg3_hw_stats		*hw_stats;
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Jul 29 13:08:22 2003
+++ b/include/linux/pci_ids.h	Tue Jul 29 13:08:22 2003
@@ -1646,6 +1646,8 @@
 #define PCI_DEVICE_ID_TIGON3_5703	0x1647
 #define PCI_DEVICE_ID_TIGON3_5704	0x1648
 #define PCI_DEVICE_ID_TIGON3_5702FE	0x164d
+#define PCI_DEVICE_ID_TIGON3_5705	0x1653
+#define PCI_DEVICE_ID_TIGON3_5705M	0x165d
 #define PCI_DEVICE_ID_TIGON3_5702X	0x16a6
 #define PCI_DEVICE_ID_TIGON3_5703X	0x16a7
 #define PCI_DEVICE_ID_TIGON3_5704S	0x16a8
