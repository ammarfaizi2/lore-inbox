Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSH3Xp7>; Fri, 30 Aug 2002 19:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSH3Xp7>; Fri, 30 Aug 2002 19:45:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32947 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311885AbSH3Xpr>;
	Fri, 30 Aug 2002 19:45:47 -0400
Date: Fri, 30 Aug 2002 16:43:50 -0700 (PDT)
Message-Id: <20020830.164350.04709191.davem@redhat.com>
To: rkuhn@e18.physik.tu-muenchen.de
Cc: kwijibo@zianet.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020807.154004.104177403.davem@redhat.com>
References: <3D51940A.60805@zianet.com>
	<Pine.LNX.4.44.0208080007300.4058-100000@pc40.e18.physik.tu-muenchen.de>
	<20020807.154004.104177403.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Roland, can you give these patches a try for your problem?
I am very confident it will fix your bug.

If something goes wrong, verify that the driver is setting
TG3_FLAG_MBOX_WRITE_REORDER in tp->tg3_flags.  This workaround
is 100 times more efficient than the hacked one we were trying
to use the other week (and the one Broadcom's driver is now
using).

The problem is that the AMD762, even with the correct PCI config space
register values in the host controller, can reorder writes to the chip
registers (beyond the normal PCI write posting allowed by the PCI spec.).

What this results in (and how the tg3.c:1557 BUG() gets triggered) is
that the chip receives the TX descriptor mailbox write before the
descriptors themselves fully get written.  It is also possible for
mailbox register writes themselves to arrive out of order so f.e. the
chip can see the sequence:
	write(TX_MAILBOX, NEW)
	write(TX_MAILBOX, OLD)
even though we did:
	write(TX_MAILBOX, OLD)
	write(TX_MAILBOX, NEW)
which is a good way to confuse hardware :-)

I also audited the whole driver for obeying "delay after write"
and PCI write posting rules in general.  It also fixes some issues
with not properly programming the chip into low power modes.

I intend to send this to Marcelo after I do some more extensive
testing of my own, so I look forward to your feedback. :-)

This patch is against 2.4.20-pre5

--- drivers/net/tg3.c.~1~	Fri Aug 30 14:33:46 2002
+++ drivers/net/tg3.c	Fri Aug 30 16:32:11 2002
@@ -52,8 +52,8 @@
 
 #define DRV_MODULE_NAME		"tg3"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"1.0"
-#define DRV_MODULE_RELDATE	"Jul 19, 2002"
+#define DRV_MODULE_VERSION	"1.1"
+#define DRV_MODULE_RELDATE	"Aug 30, 2002"
 
 #define TG3_DEF_MAC_MODE	0
 #define TG3_DEF_RX_MODE		0
@@ -212,6 +212,7 @@ static void tg3_disable_ints(struct tg3 
 	tw32(TG3PCI_MISC_HOST_CTRL,
 	     (tp->misc_host_ctrl | MISC_HOST_CTRL_MASK_PCI_INT));
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0x00000001);
+	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 }
 
 static void tg3_enable_ints(struct tg3 *tp)
@@ -220,9 +221,11 @@ static void tg3_enable_ints(struct tg3 *
 	     (tp->misc_host_ctrl & ~MISC_HOST_CTRL_MASK_PCI_INT));
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0x00000000);
 
-	if (tp->hw_status->status & SD_STATUS_UPDATED)
+	if (tp->hw_status->status & SD_STATUS_UPDATED) {
 		tw32(GRC_LOCAL_CTRL,
 		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
+	}
+	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
 }
 
 #define PHY_BUSY_LOOPS	5000
@@ -235,6 +238,7 @@ static int tg3_readphy(struct tg3 *tp, i
 	if ((tp->mi_mode & MAC_MI_MODE_AUTO_POLL) != 0) {
 		tw32(MAC_MI_MODE,
 		     (tp->mi_mode & ~MAC_MI_MODE_AUTO_POLL));
+		tr32(MAC_MI_MODE);
 		udelay(40);
 	}
 
@@ -247,9 +251,11 @@ static int tg3_readphy(struct tg3 *tp, i
 	frame_val |= (MI_COM_CMD_READ | MI_COM_START);
 	
 	tw32(MAC_MI_COM, frame_val);
+	tr32(MAC_MI_COM);
 
 	loops = PHY_BUSY_LOOPS;
 	while (loops-- > 0) {
+		udelay(10);
 		frame_val = tr32(MAC_MI_COM);
 
 		if ((frame_val & MI_COM_BUSY) == 0) {
@@ -257,7 +263,6 @@ static int tg3_readphy(struct tg3 *tp, i
 			frame_val = tr32(MAC_MI_COM);
 			break;
 		}
-		udelay(10);
 	}
 
 	ret = -EBUSY;
@@ -268,6 +273,7 @@ static int tg3_readphy(struct tg3 *tp, i
 
 	if ((tp->mi_mode & MAC_MI_MODE_AUTO_POLL) != 0) {
 		tw32(MAC_MI_MODE, tp->mi_mode);
+		tr32(MAC_MI_MODE);
 		udelay(40);
 	}
 
@@ -282,6 +288,7 @@ static int tg3_writephy(struct tg3 *tp, 
 	if ((tp->mi_mode & MAC_MI_MODE_AUTO_POLL) != 0) {
 		tw32(MAC_MI_MODE,
 		     (tp->mi_mode & ~MAC_MI_MODE_AUTO_POLL));
+		tr32(MAC_MI_MODE);
 		udelay(40);
 	}
 
@@ -293,16 +300,17 @@ static int tg3_writephy(struct tg3 *tp, 
 	frame_val |= (MI_COM_CMD_WRITE | MI_COM_START);
 	
 	tw32(MAC_MI_COM, frame_val);
+	tr32(MAC_MI_COM);
 
 	loops = PHY_BUSY_LOOPS;
 	while (loops-- > 0) {
+		udelay(10);
 		frame_val = tr32(MAC_MI_COM);
 		if ((frame_val & MI_COM_BUSY) == 0) {
 			udelay(5);
 			frame_val = tr32(MAC_MI_COM);
 			break;
 		}
-		udelay(10);
 	}
 
 	ret = -EBUSY;
@@ -311,6 +319,7 @@ static int tg3_writephy(struct tg3 *tp, 
 
 	if ((tp->mi_mode & MAC_MI_MODE_AUTO_POLL) != 0) {
 		tw32(MAC_MI_MODE, tp->mi_mode);
+		tr32(MAC_MI_MODE);
 		udelay(40);
 	}
 
@@ -388,6 +397,9 @@ static int tg3_set_power_state(struct tg
 				      pm + PCI_PM_CTRL,
 				      power_control);
 		tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl);
+		tr32(GRC_LOCAL_CTRL);
+		udelay(100);
+
 		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x02);
 		return 0;
 
@@ -424,6 +436,7 @@ static int tg3_set_power_state(struct tg
 	}
 
 	tp->link_config.speed = SPEED_10;
+	tp->link_config.duplex = DUPLEX_HALF;
 	tp->link_config.autoneg = AUTONEG_ENABLE;
 	tg3_setup_phy(tp);
 
@@ -435,51 +448,108 @@ static int tg3_set_power_state(struct tg
 		u32 mac_mode;
 
 		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x5a);
+		udelay(40);
 
-		mac_mode = MAC_MODE_PORT_MODE_MII |
-			MAC_MODE_LINK_POLARITY;
+		mac_mode = MAC_MODE_PORT_MODE_MII;
+
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5700 ||
+		    !(tp->tg3_flags & TG3_FLAG_WOL_SPEED_100MB))
+			mac_mode |= MAC_MODE_LINK_POLARITY;
 
 		if (((power_caps & PCI_PM_CAP_PME_D3cold) &&
 		     (tp->tg3_flags & TG3_FLAG_WOL_ENABLE)))
 			mac_mode |= MAC_MODE_MAGIC_PKT_ENABLE;
 
 		tw32(MAC_MODE, mac_mode);
+		tr32(MAC_MODE);
+		udelay(40);
+
 		tw32(MAC_RX_MODE, RX_MODE_ENABLE);
+		tr32(MAC_RX_MODE);
+		udelay(10);
 	}
 
 	if (tp->tg3_flags & TG3_FLAG_WOL_SPEED_100MB) {
-		tw32(TG3PCI_CLOCK_CTRL,
-		     (CLOCK_CTRL_RXCLK_DISABLE |
-		      CLOCK_CTRL_TXCLK_DISABLE |
-		      CLOCK_CTRL_ALTCLK));
-		tw32(TG3PCI_CLOCK_CTRL,
-		     (CLOCK_CTRL_RXCLK_DISABLE |
-		      CLOCK_CTRL_TXCLK_DISABLE |
-		      CLOCK_CTRL_44MHZ_CORE));
-		tw32(TG3PCI_CLOCK_CTRL,
-		     (CLOCK_CTRL_RXCLK_DISABLE |
-		      CLOCK_CTRL_TXCLK_DISABLE |
-		      CLOCK_CTRL_ALTCLK |
-		      CLOCK_CTRL_44MHZ_CORE));
+		u32 base_val;
+
+		base_val = 0;
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)
+			base_val |= (CLOCK_CTRL_RXCLK_DISABLE |
+				     CLOCK_CTRL_TXCLK_DISABLE);
+
+		tw32(TG3PCI_CLOCK_CTRL, base_val |
+		     CLOCK_CTRL_ALTCLK);
+		tr32(TG3PCI_CLOCK_CTRL);
+		udelay(40);
+
+		tw32(TG3PCI_CLOCK_CTRL, base_val |
+		     CLOCK_CTRL_ALTCLK |
+		     CLOCK_CTRL_44MHZ_CORE);
+		tr32(TG3PCI_CLOCK_CTRL);
+		udelay(40);
+
+		tw32(TG3PCI_CLOCK_CTRL, base_val |
+		     CLOCK_CTRL_44MHZ_CORE);
+		tr32(TG3PCI_CLOCK_CTRL);
+		udelay(40);
 	} else {
-		tw32(TG3PCI_CLOCK_CTRL,
-		     (CLOCK_CTRL_RXCLK_DISABLE |
-		      CLOCK_CTRL_TXCLK_DISABLE |
-		      CLOCK_CTRL_ALTCLK |
-		      CLOCK_CTRL_PWRDOWN_PLL133));
-	}
+		u32 base_val;
 
-	udelay(40);
+		base_val = 0;
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)
+			base_val |= (CLOCK_CTRL_RXCLK_DISABLE |
+				     CLOCK_CTRL_TXCLK_DISABLE);
+
+		tw32(TG3PCI_CLOCK_CTRL, base_val |
+		     CLOCK_CTRL_ALTCLK |
+		     CLOCK_CTRL_PWRDOWN_PLL133);
+		tr32(TG3PCI_CLOCK_CTRL);
+		udelay(40);
+	}
 
-	if ((power_caps & PCI_PM_CAP_PME_D3cold) &&
+	if (!(tp->tg3_flags & TG3_FLAG_EEPROM_WRITE_PROT) &&
 	    (tp->tg3_flags & TG3_FLAG_WOL_ENABLE)) {
-		/* Move to auxilliary power. */
-		tw32(GRC_LOCAL_CTRL,
-		     (GRC_LCLCTRL_GPIO_OE0 |
-		      GRC_LCLCTRL_GPIO_OE1 |
-		      GRC_LCLCTRL_GPIO_OE2 |
-		      GRC_LCLCTRL_GPIO_OUTPUT0 |
-		      GRC_LCLCTRL_GPIO_OUTPUT1));
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
+			tw32(GRC_LOCAL_CTRL,
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+		} else {
+			tw32(GRC_LOCAL_CTRL,
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT2));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL,
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1 |
+			      GRC_LCLCTRL_GPIO_OUTPUT2));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+
+			tw32(GRC_LOCAL_CTRL,
+			     (GRC_LCLCTRL_GPIO_OE0 |
+			      GRC_LCLCTRL_GPIO_OE1 |
+			      GRC_LCLCTRL_GPIO_OE2 |
+			      GRC_LCLCTRL_GPIO_OUTPUT0 |
+			      GRC_LCLCTRL_GPIO_OUTPUT1));
+			tr32(GRC_LOCAL_CTRL);
+			udelay(100);
+		}
 	}
 
 	/* Finally, set the new power state. */
@@ -636,8 +706,9 @@ static int tg3_phy_copper_begin(struct t
 				new_adv |= MII_TG3_CTRL_ADV_1000_HALF;
 			if (tp->link_config.advertising & ADVERTISED_1000baseT_Full)
 				new_adv |= MII_TG3_CTRL_ADV_1000_FULL;
-			if (tp->pci_chip_rev_id == CHIPREV_ID_5701_A0 ||
-			    tp->pci_chip_rev_id == CHIPREV_ID_5701_B0)
+			if (!(tp->tg3_flags & TG3_FLAG_10_100_ONLY) &&
+			    (tp->pci_chip_rev_id == CHIPREV_ID_5701_A0 ||
+			     tp->pci_chip_rev_id == CHIPREV_ID_5701_B0))
 				new_adv |= (MII_TG3_CTRL_AS_MASTER |
 					    MII_TG3_CTRL_ENABLE_AS_MASTER);
 			tg3_writephy(tp, MII_TG3_CTRL, new_adv);
@@ -787,9 +858,12 @@ static int tg3_setup_copper_phy(struct t
 	tw32(MAC_STATUS,
 	     (MAC_STATUS_SYNC_CHANGED |
 	      MAC_STATUS_CFG_CHANGED));
+	tr32(MAC_STATUS);
+	udelay(40);
 
 	tp->mi_mode = MAC_MI_MODE_BASE;
 	tw32(MAC_MI_MODE, tp->mi_mode);
+	tr32(MAC_MI_MODE);
 	udelay(40);
 
 	if ((tp->phy_id & PHY_ID_MASK) == PHY_ID_BCM5401) {
@@ -968,10 +1042,13 @@ static int tg3_setup_copper_phy(struct t
 	    tp->pci_chip_rev_id == CHIPREV_ID_5700_ALTIMA) {
 		tp->mi_mode |= MAC_MI_MODE_AUTO_POLL;
 		tw32(MAC_MI_MODE, tp->mi_mode);
+		tr32(MAC_MI_MODE);
 		udelay(40);
 	}
 
 	tw32(MAC_MODE, tp->mac_mode);
+	tr32(MAC_MODE);
+	udelay(40);
 
 	if (tp->tg3_flags &
 	    (TG3_FLAG_USE_LINKCHG_REG |
@@ -981,6 +1058,8 @@ static int tg3_setup_copper_phy(struct t
 	} else {
 		tw32(MAC_EVENT, MAC_EVENT_LNKSTATE_CHANGED);
 	}
+	tr32(MAC_EVENT);
+	udelay(40);
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5700 &&
 	    current_link_up == 1 &&
@@ -991,6 +1070,8 @@ static int tg3_setup_copper_phy(struct t
 		tw32(MAC_STATUS,
 		     (MAC_STATUS_SYNC_CHANGED |
 		      MAC_STATUS_CFG_CHANGED));
+		tr32(MAC_STATUS);
+		udelay(40);
 		tg3_write_mem(tp,
 			      NIC_SRAM_FIRMWARE_MBOX,
 			      NIC_SRAM_FIRMWARE_MBOX_MAGIC2);
@@ -1152,6 +1233,9 @@ static int tg3_fiber_aneg_smachine(struc
 		tw32(MAC_TX_AUTO_NEG, 0);
 		tp->mac_mode |= MAC_MODE_SEND_CONFIGS;
 		tw32(MAC_MODE, tp->mac_mode);
+		tr32(MAC_MODE);
+		udelay(40);
+
 		ret = ANEG_TIMER_ENAB;
 		ap->state = ANEG_STATE_RESTART;
 
@@ -1175,6 +1259,8 @@ static int tg3_fiber_aneg_smachine(struc
 		tw32(MAC_TX_AUTO_NEG, ap->txconfig);
 		tp->mac_mode |= MAC_MODE_SEND_CONFIGS;
 		tw32(MAC_MODE, tp->mac_mode);
+		tr32(MAC_MODE);
+		udelay(40);
 
 		ap->state = ANEG_STATE_ABILITY_DETECT;
 		break;
@@ -1190,6 +1276,8 @@ static int tg3_fiber_aneg_smachine(struc
 		tw32(MAC_TX_AUTO_NEG, ap->txconfig);
 		tp->mac_mode |= MAC_MODE_SEND_CONFIGS;
 		tw32(MAC_MODE, tp->mac_mode);
+		tr32(MAC_MODE);
+		udelay(40);
 
 		ap->state = ANEG_STATE_ACK_DETECT;
 
@@ -1275,6 +1363,8 @@ static int tg3_fiber_aneg_smachine(struc
 		ap->link_time = ap->cur_time;
 		tp->mac_mode &= ~MAC_MODE_SEND_CONFIGS;
 		tw32(MAC_MODE, tp->mac_mode);
+		tr32(MAC_MODE);
+		udelay(40);
 
 		ap->state = ANEG_STATE_IDLE_DETECT;
 		ret = ANEG_TIMER_ENAB;
@@ -1331,6 +1421,7 @@ static int tg3_setup_fiber_phy(struct tg
 	tp->mac_mode &= ~(MAC_MODE_PORT_MODE_MASK | MAC_MODE_HALF_DUPLEX);
 	tp->mac_mode |= MAC_MODE_PORT_MODE_TBI;
 	tw32(MAC_MODE, tp->mac_mode);
+	tr32(MAC_MODE);
 	udelay(40);
 
 	/* Reset when initting first time or we have a link. */
@@ -1381,6 +1472,8 @@ static int tg3_setup_fiber_phy(struct tg
 		tw32(MAC_EVENT, MAC_EVENT_LNKSTATE_CHANGED);
 	else
 		tw32(MAC_EVENT, 0);
+	tr32(MAC_EVENT);
+	udelay(40);
 
 	current_link_up = 0;
 	if (tr32(MAC_STATUS) & MAC_STATUS_PCS_SYNCED) {
@@ -1398,9 +1491,12 @@ static int tg3_setup_fiber_phy(struct tg
 
 			tmp = tp->mac_mode & ~MAC_MODE_PORT_MODE_MASK;
 			tw32(MAC_MODE, tmp | MAC_MODE_PORT_MODE_GMII);
-			udelay(20);
+			tr32(MAC_MODE);
+			udelay(40);
 
 			tw32(MAC_MODE, tp->mac_mode | MAC_MODE_SEND_CONFIGS);
+			tr32(MAC_MODE);
+			udelay(40);
 
 			aninfo.state = ANEG_STATE_UNKNOWN;
 			aninfo.cur_time = 0;
@@ -1416,6 +1512,8 @@ static int tg3_setup_fiber_phy(struct tg
 
 			tp->mac_mode &= ~MAC_MODE_SEND_CONFIGS;
 			tw32(MAC_MODE, tp->mac_mode);
+			tr32(MAC_MODE);
+			udelay(40);
 
 			if (status == ANEG_DONE &&
 			    (aninfo.flags &
@@ -1441,8 +1539,8 @@ static int tg3_setup_fiber_phy(struct tg
 				tw32(MAC_STATUS,
 				     (MAC_STATUS_SYNC_CHANGED |
 				      MAC_STATUS_CFG_CHANGED));
-
-				udelay(20);
+				tr32(MAC_STATUS);
+				udelay(40);
 				if ((tr32(MAC_STATUS) &
 				     (MAC_STATUS_SYNC_CHANGED |
 				      MAC_STATUS_CFG_CHANGED)) == 0)
@@ -1460,6 +1558,8 @@ static int tg3_setup_fiber_phy(struct tg
 
 	tp->mac_mode &= ~MAC_MODE_LINK_POLARITY;
 	tw32(MAC_MODE, tp->mac_mode);
+	tr32(MAC_MODE);
+	udelay(40);
 
 	tp->hw_status->status =
 		(SD_STATUS_UPDATED |
@@ -1470,8 +1570,8 @@ static int tg3_setup_fiber_phy(struct tg
 		tw32(MAC_STATUS,
 		     (MAC_STATUS_SYNC_CHANGED |
 		      MAC_STATUS_CFG_CHANGED));
-
-		udelay(20);
+		tr32(MAC_STATUS);
+		udelay(40);
 		if ((tr32(MAC_STATUS) &
 		     (MAC_STATUS_SYNC_CHANGED |
 		      MAC_STATUS_CFG_CHANGED)) == 0)
@@ -1507,9 +1607,12 @@ static int tg3_setup_fiber_phy(struct tg
 
 	if ((tr32(MAC_STATUS) & MAC_STATUS_PCS_SYNCED) == 0) {
 		tw32(MAC_MODE, tp->mac_mode | MAC_MODE_LINK_POLARITY);
+		tr32(MAC_MODE);
+		udelay(40);
 		if (tp->tg3_flags & TG3_FLAG_INIT_COMPLETE) {
-			udelay(1);
 			tw32(MAC_MODE, tp->mac_mode);
+			tr32(MAC_MODE);
+			udelay(40);
 		}
 	}
 
@@ -1881,23 +1984,31 @@ next_pkt_nopost:
 	tp->rx_rcb_ptr = rx_rcb_ptr;
 	tw32_mailbox(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW,
 		     (rx_rcb_ptr % TG3_RX_RCB_RING_SIZE));
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW);
 
 	/* Refill RX ring(s). */
 	if (work_mask & RXD_OPAQUE_RING_STD) {
 		sw_idx = tp->rx_std_ptr % TG3_RX_RING_SIZE;
 		tw32_mailbox(MAILBOX_RCV_STD_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_RCV_STD_PROD_IDX + TG3_64BIT_REG_LOW);
 	}
 	if (work_mask & RXD_OPAQUE_RING_JUMBO) {
 		sw_idx = tp->rx_jumbo_ptr % TG3_RX_JUMBO_RING_SIZE;
 		tw32_mailbox(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW);
 	}
 #if TG3_MINI_RING_WORKS
 	if (work_mask & RXD_OPAQUE_RING_MINI) {
 		sw_idx = tp->rx_mini_ptr % TG3_RX_MINI_RING_SIZE;
 		tw32_mailbox(MAILBOX_RCV_MINI_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_RCV_MINI_PROD_IDX + TG3_64BIT_REG_LOW);
 	}
 #endif
 
@@ -1974,6 +2085,9 @@ static __inline__ void tg3_interrupt_mai
 		return;
 
 	if (netif_rx_schedule_prep(dev)) {
+		/* NOTE: This write is posted by the readback of
+		 *       the mailbox register done by our caller.
+		 */
 		tw32(TG3PCI_MISC_HOST_CTRL,
 		     (tp->misc_host_ctrl | MISC_HOST_CTRL_MASK_PCI_INT));
 		__netif_rx_schedule(dev);
@@ -2323,12 +2437,27 @@ static int tg3_start_xmit_4gbug(struct s
 		if (tp->tg3_flags & TG3_FLAG_TXD_MBOX_HWBUG)
 			tw32_mailbox((MAILBOX_SNDHOST_PROD_IDX_0 +
 				      TG3_64BIT_REG_LOW), entry);
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDHOST_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
 	} else {
+		/* First, make sure tg3 sees last descriptor fully
+		 * in SRAM.
+		 */
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDNIC_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
+
 		tw32_mailbox((MAILBOX_SNDNIC_PROD_IDX_0 +
 			      TG3_64BIT_REG_LOW), entry);
 		if (tp->tg3_flags & TG3_FLAG_TXD_MBOX_HWBUG)
 			tw32_mailbox((MAILBOX_SNDNIC_PROD_IDX_0 +
 				      TG3_64BIT_REG_LOW), entry);
+
+		/* Now post the mailbox write itself.  */
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDNIC_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
 	}
 
 	tp->tx_prod = entry;
@@ -2420,9 +2549,24 @@ static int tg3_start_xmit(struct sk_buff
 	if (tp->tg3_flags & TG3_FLAG_HOST_TXDS) {
 		tw32_mailbox((MAILBOX_SNDHOST_PROD_IDX_0 +
 			      TG3_64BIT_REG_LOW), entry);
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDHOST_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
 	} else {
+		/* First, make sure tg3 sees last descriptor fully
+		 * in SRAM.
+		 */
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDNIC_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
+
 		tw32_mailbox((MAILBOX_SNDNIC_PROD_IDX_0 +
 			      TG3_64BIT_REG_LOW), entry);
+
+		/* Now post the mailbox write itself.  */
+		if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+			tr32(MAILBOX_SNDNIC_PROD_IDX_0 +
+			     TG3_64BIT_REG_LOW);
 	}
 
 	tp->tx_prod = entry;
@@ -2816,13 +2960,13 @@ static int tg3_stop_block(struct tg3 *tp
 	val = tr32(ofs);
 	val &= ~enable_bit;
 	tw32(ofs, val);
+	tr32(ofs);
 
 	for (i = 0; i < MAX_WAIT_CNT; i++) {
+		udelay(100);
 		val = tr32(ofs);
-
 		if ((val & enable_bit) == 0)
 			break;
-		udelay(100);
 	}
 
 	if (i == MAX_WAIT_CNT) {
@@ -2844,6 +2988,8 @@ static int tg3_abort_hw(struct tg3 *tp)
 
 	tp->rx_mode &= ~RX_MODE_ENABLE;
 	tw32(MAC_RX_MODE, tp->rx_mode);
+	tr32(MAC_RX_MODE);
+	udelay(10);
 
 	err  = tg3_stop_block(tp, RCVBDI_MODE, RCVBDI_MODE_ENABLE);
 	err |= tg3_stop_block(tp, RCVLPC_MODE, RCVLPC_MODE_ENABLE);
@@ -2863,9 +3009,13 @@ static int tg3_abort_hw(struct tg3 *tp)
 
 	tp->mac_mode &= ~MAC_MODE_TDE_ENABLE;
 	tw32(MAC_MODE, tp->mac_mode);
+	tr32(MAC_MODE);
+	udelay(40);
 
 	tp->tx_mode &= ~TX_MODE_ENABLE;
 	tw32(MAC_TX_MODE, tp->tx_mode);
+	tr32(MAC_TX_MODE);
+
 	for (i = 0; i < MAX_WAIT_CNT; i++) {
 		udelay(100);
 		if (!(tr32(MAC_TX_MODE) & TX_MODE_ENABLE))
@@ -2899,6 +3049,7 @@ out:
 /* tp->lock is held. */
 static void tg3_chip_reset(struct tg3 *tp)
 {
+	unsigned long flags;
 	u32 val;
 
 	/* Force NVRAM to settle.
@@ -2916,7 +3067,16 @@ static void tg3_chip_reset(struct tg3 *t
 		}
 	}
 
-	tw32(GRC_MISC_CFG, GRC_MISC_CFG_CORECLK_RESET);
+	/* Use indirect register writes for this so that there are
+	 * no PCI write posting issues.
+	 */
+	spin_lock_irqsave(&tp->indirect_lock, flags);
+	pci_write_config_dword(tp->pdev, TG3PCI_REG_BASE_ADDR,
+			       GRC_MISC_CFG);
+	pci_write_config_dword(tp->pdev, TG3PCI_REG_DATA,
+			       GRC_MISC_CFG_CORECLK_RESET);
+	spin_unlock_irqrestore(&tp->indirect_lock, flags);
+
 	udelay(40);
 	udelay(40);
 	udelay(40);
@@ -3112,6 +3272,7 @@ static int tg3_reset_cpu(struct tg3 *tp,
 				break;
 		tw32(offset + CPU_STATE, 0xffffffff);
 		tw32(offset + CPU_MODE,  CPU_MODE_RESET);
+		tr32(offset + CPU_MODE);
 		udelay(10);
 	} else {
 		for (i = 0; i < 10000; i++) {
@@ -3119,6 +3280,7 @@ static int tg3_reset_cpu(struct tg3 *tp,
 				break;
 			tw32(offset + CPU_STATE, 0xffffffff);
 			tw32(offset + CPU_MODE,  CPU_MODE_RESET);
+			tr32(offset + CPU_MODE);
 			udelay(10);
 		}
 	}
@@ -3311,6 +3473,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 		tw32(MAC_MODE, tp->mac_mode);
 	} else
 		tw32(MAC_MODE, 0);
+	tr32(MAC_MODE);
+	udelay(40);
 
 	/* Wait for firmware initialization to complete. */
 	for (i = 0; i < 100000; i++) {
@@ -3333,6 +3497,7 @@ static int tg3_reset_hw(struct tg3 *tp)
 	val = tr32(TG3PCI_CLOCK_CTRL);
 	val |= CLOCK_CTRL_DELAY_PCI_GRANT;
 	tw32(TG3PCI_CLOCK_CTRL, val);
+	tr32(TG3PCI_CLOCK_CTRL);
 
 	/* Clear statistics/status block in chip, and status block in ram. */
 	for (i = NIC_SRAM_STATS_BLK;
@@ -3491,6 +3656,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 	tp->tx_cons = 0;
 	tw32_mailbox(MAILBOX_SNDHOST_PROD_IDX_0 + TG3_64BIT_REG_LOW, 0);
 	tw32_mailbox(MAILBOX_SNDNIC_PROD_IDX_0 + TG3_64BIT_REG_LOW, 0);
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_SNDNIC_PROD_IDX_0 + TG3_64BIT_REG_LOW);
 
 	if (tp->tg3_flags & TG3_FLAG_HOST_TXDS) {
 		tg3_set_bdinfo(tp, NIC_SRAM_SEND_RCB,
@@ -3512,6 +3679,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 
 	tp->rx_rcb_ptr = 0;
 	tw32_mailbox(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW, 0);
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW);
 
 	tg3_set_bdinfo(tp, NIC_SRAM_RCV_RET_RCB,
 		       tp->rx_rcb_mapping,
@@ -3522,10 +3691,14 @@ static int tg3_reset_hw(struct tg3 *tp)
 	tp->rx_std_ptr = tp->rx_pending;
 	tw32_mailbox(MAILBOX_RCV_STD_PROD_IDX + TG3_64BIT_REG_LOW,
 		     tp->rx_std_ptr);
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_RCV_STD_PROD_IDX + TG3_64BIT_REG_LOW);
 #if TG3_MINI_RING_WORKS
 	tp->rx_mini_ptr = tp->rx_mini_pending;
 	tw32_mailbox(MAILBOX_RCV_MINI_PROD_IDX + TG3_64BIT_REG_LOW,
 		     tp->rx_mini_ptr);
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_RCV_MINI_PROD_IDX + TG3_64BIT_REG_LOW);
 #endif
 
 	if (tp->tg3_flags & TG3_FLAG_JUMBO_ENABLE)
@@ -3534,6 +3707,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 		tp->rx_jumbo_ptr = 0;
 	tw32_mailbox(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW,
 		     tp->rx_jumbo_ptr);
+	if (tp->tg3_flags & TG3_FLAG_MBOX_WRITE_REORDER)
+		tr32(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW);
 
 	/* Initialize MAC address and backoff seed. */
 	__tg3_set_mac_addr(tp);
@@ -3601,25 +3776,37 @@ static int tg3_reset_hw(struct tg3 *tp)
 	tp->mac_mode = MAC_MODE_TXSTAT_ENABLE | MAC_MODE_RXSTAT_ENABLE |
 		MAC_MODE_TDE_ENABLE | MAC_MODE_RDE_ENABLE | MAC_MODE_FHDE_ENABLE;
 	tw32(MAC_MODE, tp->mac_mode | MAC_MODE_RXSTAT_CLEAR | MAC_MODE_TXSTAT_CLEAR);
+	tr32(MAC_MODE);
+	udelay(40);
 
 	tp->grc_local_ctrl = GRC_LCLCTRL_INT_ON_ATTN | GRC_LCLCTRL_GPIO_OE1 |
 		GRC_LCLCTRL_GPIO_OUTPUT1 | GRC_LCLCTRL_AUTO_SEEPROM;
 	tw32(GRC_LOCAL_CTRL, tp->grc_local_ctrl);
+	tr32(GRC_LOCAL_CTRL);
+	udelay(100);
 
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0);
+	tr32(MAILBOX_INTERRUPT_0);
 
 	tw32(DMAC_MODE, DMAC_MODE_ENABLE);
+	tr32(DMAC_MODE);
+	udelay(40);
 
 	tw32(WDMAC_MODE, (WDMAC_MODE_ENABLE | WDMAC_MODE_TGTABORT_ENAB |
 			  WDMAC_MODE_MSTABORT_ENAB | WDMAC_MODE_PARITYERR_ENAB |
 			  WDMAC_MODE_ADDROFLOW_ENAB | WDMAC_MODE_FIFOOFLOW_ENAB |
 			  WDMAC_MODE_FIFOURUN_ENAB | WDMAC_MODE_FIFOOREAD_ENAB |
 			  WDMAC_MODE_LNGREAD_ENAB));
+	tr32(WDMAC_MODE);
+	udelay(40);
+
 	tw32(RDMAC_MODE, (RDMAC_MODE_ENABLE | RDMAC_MODE_TGTABORT_ENAB |
 			  RDMAC_MODE_MSTABORT_ENAB | RDMAC_MODE_PARITYERR_ENAB |
 			  RDMAC_MODE_ADDROFLOW_ENAB | RDMAC_MODE_FIFOOFLOW_ENAB |
 			  RDMAC_MODE_FIFOURUN_ENAB | RDMAC_MODE_FIFOOREAD_ENAB |
 			  RDMAC_MODE_LNGREAD_ENAB));
+	tr32(RDMAC_MODE);
+	udelay(40);
 
 	tw32(RCVDCC_MODE, RCVDCC_MODE_ENABLE | RCVDCC_MODE_ATTN_ENABLE);
 	tw32(MBFREE_MODE, MBFREE_MODE_ENABLE);
@@ -3639,8 +3826,13 @@ static int tg3_reset_hw(struct tg3 *tp)
 
 	tp->tx_mode = TX_MODE_ENABLE;
 	tw32(MAC_TX_MODE, tp->tx_mode);
+	tr32(MAC_TX_MODE);
+	udelay(100);
+
 	tp->rx_mode = RX_MODE_ENABLE;
 	tw32(MAC_RX_MODE, tp->rx_mode);
+	tr32(MAC_RX_MODE);
+	udelay(10);
 
 	if (tp->link_config.phy_is_low_power) {
 		tp->link_config.phy_is_low_power = 0;
@@ -3651,11 +3843,17 @@ static int tg3_reset_hw(struct tg3 *tp)
 
 	tp->mi_mode = MAC_MI_MODE_BASE;
 	tw32(MAC_MI_MODE, tp->mi_mode);
+	tr32(MAC_MI_MODE);
+	udelay(40);
+
 	tw32(MAC_LED_CTRL, 0);
 	tw32(MAC_MI_STAT, MAC_MI_STAT_LNKSTAT_ATTN_ENAB);
 	tw32(MAC_RX_MODE, RX_MODE_RESET);
+	tr32(MAC_RX_MODE);
 	udelay(10);
 	tw32(MAC_RX_MODE, tp->rx_mode);
+	tr32(MAC_RX_MODE);
+	udelay(10);
 
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5703_A1)
 		tw32(MAC_SERDES_CFG, 0x616000);
@@ -3738,7 +3936,7 @@ static void tg3_timer(unsigned long __op
 		tw32(GRC_LOCAL_CTRL,
 		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
 	} else {
-		tw32(HOSTCC_MODE,
+		tw32(HOSTCC_MODE, tp->coalesce_mode |
 		     (HOSTCC_MODE_ENABLE | HOSTCC_MODE_NOW));
 	}
 
@@ -3781,8 +3979,11 @@ static void tg3_timer(unsigned long __op
 				tw32(MAC_MODE,
 				     (tp->mac_mode &
 				      ~MAC_MODE_PORT_MODE_MASK));
+				tr32(MAC_MODE);
 				udelay(40);
 				tw32(MAC_MODE, tp->mac_mode);
+				tr32(MAC_MODE);
+				udelay(40);
 				tg3_setup_phy(tp);
 			}
 		}
@@ -4272,10 +4473,10 @@ static inline u32 calc_crc(unsigned char
 static void tg3_set_multi(struct tg3 *tp, unsigned int accept_all)
 {
 	/* accept or reject all multicast frames */
-	tw32 (MAC_HASH_REG_0, accept_all ? 0xffffffff : 0);
-	tw32 (MAC_HASH_REG_1, accept_all ? 0xffffffff : 0);
-	tw32 (MAC_HASH_REG_2, accept_all ? 0xffffffff : 0);
-	tw32 (MAC_HASH_REG_3, accept_all ? 0xffffffff : 0);
+	tw32(MAC_HASH_REG_0, accept_all ? 0xffffffff : 0);
+	tw32(MAC_HASH_REG_1, accept_all ? 0xffffffff : 0);
+	tw32(MAC_HASH_REG_2, accept_all ? 0xffffffff : 0);
+	tw32(MAC_HASH_REG_3, accept_all ? 0xffffffff : 0);
 }
 
 static void __tg3_set_rx_mode(struct net_device *dev)
@@ -4283,7 +4484,10 @@ static void __tg3_set_rx_mode(struct net
 	struct tg3 *tp = dev->priv;
 	u32 rx_mode;
 
-	rx_mode = tp->rx_mode & ~RX_MODE_PROMISC;
+	rx_mode = tp->rx_mode & ~(RX_MODE_PROMISC |
+				  RX_MODE_KEEP_VLAN_TAG);
+	if (!tp->vlgrp)
+		rx_mode |= RX_MODE_KEEP_VLAN_TAG;
 
 	if (dev->flags & IFF_PROMISC) {
 		/* Promiscuous mode. */
@@ -4313,15 +4517,17 @@ static void __tg3_set_rx_mode(struct net
 			mc_filter[regidx] |= (1 << bit);
 		}
 
-		tw32 (MAC_HASH_REG_0, mc_filter[0]);
-		tw32 (MAC_HASH_REG_1, mc_filter[1]);
-		tw32 (MAC_HASH_REG_2, mc_filter[2]);
-		tw32 (MAC_HASH_REG_3, mc_filter[3]);
+		tw32(MAC_HASH_REG_0, mc_filter[0]);
+		tw32(MAC_HASH_REG_1, mc_filter[1]);
+		tw32(MAC_HASH_REG_2, mc_filter[2]);
+		tw32(MAC_HASH_REG_3, mc_filter[3]);
 	}
 
 	if (rx_mode != tp->rx_mode) {
 		tp->rx_mode = rx_mode;
-		tw32 (MAC_RX_MODE, rx_mode);
+		tw32(MAC_RX_MODE, rx_mode);
+		tr32(MAC_RX_MODE);
+		udelay(10);
 	}
 }
 
@@ -4837,7 +5043,12 @@ static void tg3_vlan_rx_register(struct 
 
 	spin_lock_irq(&tp->lock);
 	spin_lock(&tp->tx_lock);
+
 	tp->vlgrp = grp;
+
+	/* Update RX_MODE_KEEP_VLAN_TAG bit in RX_MODE register. */
+	__tg3_set_rx_mode(dev);
+
 	spin_unlock(&tp->tx_lock);
 	spin_unlock_irq(&tp->lock);
 }
@@ -4872,6 +5083,7 @@ static void __devinit tg3_nvram_init(str
 	/* Enable seeprom accesses. */
 	tw32(GRC_LOCAL_CTRL,
 	     tr32(GRC_LOCAL_CTRL) | GRC_LCLCTRL_AUTO_SEEPROM);
+	tr32(GRC_LOCAL_CTRL);
 	udelay(100);
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5700 &&
@@ -5079,12 +5291,12 @@ static int __devinit tg3_phy_probe(struc
 			eeprom_led_mode = led_mode_auto;
 			break;
 		};
+		if ((tp->pci_chip_rev_id == CHIPREV_ID_5703_A1 ||
+		     tp->pci_chip_rev_id == CHIPREV_ID_5703_A2) &&
+		    (nic_cfg & NIC_SRAM_DATA_CFG_EEPROM_WP))
+			tp->tg3_flags |= TG3_FLAG_EEPROM_WRITE_PROT;
 	}
 
-	err = tg3_phy_reset(tp, 0);
-	if (err)
-		return err;
-
 	/* Now read the physical PHY_ID from the chip and verify
 	 * that it is sane.  If it doesn't look good, we fall back
 	 * to either the hard-coded table based PHY_ID and failing
@@ -5114,30 +5326,24 @@ static int __devinit tg3_phy_probe(struc
 		}
 	}
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703) {
-		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x0c00);
-		tg3_writephy(tp, MII_TG3_DSP_ADDRESS, 0x201f);
-		tg3_writephy(tp, MII_TG3_DSP_RW_PORT, 0x2aaa);
-	}
+	err = tg3_phy_reset(tp, 1);
+	if (err)
+		return err;
 
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5701_A0 ||
-	    tp->pci_chip_rev_id == CHIPREV_ID_5701_B0)
-		tp->tg3_flags |= TG3_FLAG_PHY_RESET_ON_INIT;
-
-	if (tp->tg3_flags & TG3_FLAG_PHY_RESET_ON_INIT) {
+	    tp->pci_chip_rev_id == CHIPREV_ID_5701_B0) {
 		u32 mii_tg3_ctrl;
-
-		err = tg3_phy_reset(tp, 1);
-		if (err)
-			return err;
-
-		/* These chips, when reset, only advertise 10Mb capabilities.
-		 * Fix that.
+		
+		/* These chips, when reset, only advertise 10Mb
+		 * capabilities.  Fix that.
 		 */
 		err  = tg3_writephy(tp, MII_ADVERTISE,
 				    (ADVERTISE_CSMA |
-				     ADVERTISE_10HALF | ADVERTISE_10FULL |
-				     ADVERTISE_100HALF | ADVERTISE_100FULL));
+				     ADVERTISE_PAUSE_CAP |
+				     ADVERTISE_10HALF |
+				     ADVERTISE_10FULL |
+				     ADVERTISE_100HALF |
+				     ADVERTISE_100FULL));
 		mii_tg3_ctrl = (MII_TG3_CTRL_ADV_1000_HALF |
 				MII_TG3_CTRL_ADV_1000_FULL |
 				MII_TG3_CTRL_AS_MASTER |
@@ -5150,6 +5356,17 @@ static int __devinit tg3_phy_probe(struc
 				    (BMCR_ANRESTART | BMCR_ANENABLE));
 	}
 
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703) {
+		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x0c00);
+		tg3_writephy(tp, MII_TG3_DSP_ADDRESS, 0x201f);
+		tg3_writephy(tp, MII_TG3_DSP_RW_PORT, 0x2aaa);
+	}
+
+	/* Enable Ethernet@WireSpeed */
+	tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x7007);
+	tg3_readphy(tp, MII_TG3_AUX_CTRL, &val);
+	tg3_writephy(tp, MII_TG3_AUX_CTRL, (val | (1 << 15) | (1 << 4)));
+
 	if (!err && ((tp->phy_id & PHY_ID_MASK) == PHY_ID_BCM5401)) {
 		err = tg3_init_5401phy_dsp(tp);
 	}
@@ -5247,6 +5464,20 @@ static int __devinit tg3_get_invariants(
 	u16 pci_cmd;
 	int err;
 
+	/* If we have an AMD 762 or Intel ICH/ICH0 chipset, write
+	 * reordering to the mailbox registers done by the host
+	 * controller can cause major troubles.  We read back from
+	 * every mailbox register write to force the writes to be
+	 * posted to the chip in order.
+	 */
+	if (pci_find_device(PCI_VENDOR_ID_INTEL,
+			    PCI_DEVICE_ID_INTEL_82801AA_8, NULL) ||
+	    pci_find_device(PCI_VENDOR_ID_INTEL,
+			    PCI_DEVICE_ID_INTEL_82801AB_8, NULL) ||
+	    pci_find_device(PCI_VENDOR_ID_AMD,
+			    PCI_DEVICE_ID_AMD_FE_GATE_700C, NULL))
+		tp->tg3_flags |= TG3_FLAG_MBOX_WRITE_REORDER;
+
 	/* Force memory write invalidate off.  If we leave it on,
 	 * then on 5700_BX chips we have to enable a workaround.
 	 * The workaround is to set the TG3PCI_DMA_RW_CTRL boundry
@@ -5258,12 +5489,24 @@ static int __devinit tg3_get_invariants(
 	pci_cmd &= ~PCI_COMMAND_INVALIDATE;
 	pci_write_config_word(tp->pdev, PCI_COMMAND, pci_cmd);
 
+	/* It is absolutely critical that TG3PCI_MISC_HOST_CTRL
+	 * has the register indirect write enable bit set before
+	 * we try to access any of the MMIO registers.  It is also
+	 * critical that the PCI-X hw workaround situation is decided
+	 * before that as well.
+	 */
 	pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
 			      &misc_ctrl_reg);
 
 	tp->pci_chip_rev_id = (misc_ctrl_reg >>
 			       MISC_HOST_CTRL_CHIPREV_SHIFT);
 
+	/* Initialize misc host control in PCI block. */
+	tp->misc_host_ctrl |= (misc_ctrl_reg &
+			       MISC_HOST_CTRL_CHIPREV);
+	pci_write_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
+			       tp->misc_host_ctrl);
+
 	pci_read_config_dword(tp->pdev, TG3PCI_CACHELINESZ,
 			      &cacheline_sz_reg);
 
@@ -5377,14 +5620,9 @@ static int __devinit tg3_get_invariants(
 	    GET_CHIP_REV(tp->pci_chip_rev_id) != CHIPREV_5700_BX)
 		tp->coalesce_mode |= HOSTCC_MODE_32BYTE;
 
-	/* Initialize misc host control in PCI block. */
-	tp->misc_host_ctrl |= (misc_ctrl_reg &
-			       MISC_HOST_CTRL_CHIPREV);
-	pci_write_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
-			       tp->misc_host_ctrl);
-
 	/* Initialize MAC MI mode, polling disabled. */
 	tw32(MAC_MI_MODE, tp->mi_mode);
+	tr32(MAC_MI_MODE);
 	udelay(40);
 
 	/* Initialize data/descriptor byte/word swapping. */
@@ -5520,6 +5758,11 @@ static int __devinit tg3_get_invariants(
 	    (tp->tg3_flags & TG3_FLAG_PCIX_MODE) != 0)
 		tp->rx_offset = 0;
 
+	/* By default, disable wake-on-lan.  User can change this
+	 * using ETHTOOL_SWOL.
+	 */
+	tp->tg3_flags &= ~TG3_FLAG_WOL_ENABLE;
+
 	return err;
 }
 
@@ -5593,11 +5836,21 @@ static int __devinit tg3_do_test_dma(str
 	if (to_device) {
 		test_desc.cqid_sqid = (13 << 8) | 2;
 		tw32(RDMAC_MODE, RDMAC_MODE_RESET);
+		tr32(RDMAC_MODE);
+		udelay(40);
+
 		tw32(RDMAC_MODE, RDMAC_MODE_ENABLE);
+		tr32(RDMAC_MODE);
+		udelay(40);
 	} else {
 		test_desc.cqid_sqid = (16 << 8) | 7;
 		tw32(WDMAC_MODE, WDMAC_MODE_RESET);
+		tr32(WDMAC_MODE);
+		udelay(40);
+
 		tw32(WDMAC_MODE, WDMAC_MODE_ENABLE);
+		tr32(WDMAC_MODE);
+		udelay(40);
 	}
 	test_desc.flags = 0x00000004;
 
--- drivers/net/tg3.h.~1~	Fri Aug 30 14:33:47 2002
+++ drivers/net/tg3.h	Fri Aug 30 16:30:43 2002
@@ -1248,14 +1248,19 @@
 #define  NIC_SRAM_DATA_SIG_MAGIC	 0x4b657654 /* ascii for 'KevT' */
 
 #define NIC_SRAM_DATA_CFG			0x00000b58
-#define  NIC_SRAM_DATA_CFG_PHY_TYPE_MASK	 0x0000000c
-#define  NIC_SRAM_DATA_CFG_PHY_TYPE_UNKNOWN	 0x00000000
-#define  NIC_SRAM_DATA_CFG_PHY_TYPE_COPPER	 0x00000004
-#define  NIC_SRAM_DATA_CFG_PHY_TYPE_FIBER	 0x00000008
-#define  NIC_SRAM_DATA_CFG_LED_MODE_MASK	 0x00000030
+#define  NIC_SRAM_DATA_CFG_LED_MODE_MASK	 0x0000000c
 #define  NIC_SRAM_DATA_CFG_LED_MODE_UNKNOWN	 0x00000000
-#define  NIC_SRAM_DATA_CFG_LED_TRIPLE_SPD	 0x00000010
-#define  NIC_SRAM_DATA_CFG_LED_LINK_SPD		 0x00000020
+#define  NIC_SRAM_DATA_CFG_LED_TRIPLE_SPD	 0x00000004
+#define  NIC_SRAM_DATA_CFG_LED_OPEN_DRAIN	 0x00000004
+#define  NIC_SRAM_DATA_CFG_LED_LINK_SPD		 0x00000008
+#define  NIC_SRAM_DATA_CFG_LED_OUTPUT		 0x00000008
+#define  NIC_SRAM_DATA_CFG_PHY_TYPE_MASK	 0x00000030
+#define  NIC_SRAM_DATA_CFG_PHY_TYPE_UNKNOWN	 0x00000000
+#define  NIC_SRAM_DATA_CFG_PHY_TYPE_COPPER	 0x00000010
+#define  NIC_SRAM_DATA_CFG_PHY_TYPE_FIBER	 0x00000020
+#define  NIC_SRAM_DATA_CFG_WOL_ENABLE		 0x00000040
+#define  NIC_SRAM_DATA_CFG_ASF_ENABLE		 0x00000080
+#define  NIC_SRAM_DATA_CFG_EEPROM_WP		 0x00000100
 
 #define NIC_SRAM_DATA_PHY_ID		0x00000b74
 #define  NIC_SRAM_DATA_PHY_ID1_MASK	 0xffff0000
@@ -1738,10 +1743,11 @@ struct tg3 {
 #define TG3_FLAG_USE_LINKCHG_REG	0x00000008
 #define TG3_FLAG_USE_MI_INTERRUPT	0x00000010
 #define TG3_FLAG_POLL_SERDES		0x00000080
-#define TG3_FLAG_PHY_RESET_ON_INIT	0x00000100
+#define TG3_FLAG_MBOX_WRITE_REORDER	0x00000100
 #define TG3_FLAG_PCIX_TARGET_HWBUG	0x00000200
 #define TG3_FLAG_WOL_SPEED_100MB	0x00000400
-#define TG3_FLAG_WOL_ENABLE		0x00001000
+#define TG3_FLAG_WOL_ENABLE		0x00000800
+#define TG3_FLAG_EEPROM_WRITE_PROT	0x00001000
 #define TG3_FLAG_NVRAM			0x00002000
 #define TG3_FLAG_NVRAM_BUFFERED		0x00004000
 #define TG3_FLAG_RX_PAUSE		0x00008000
