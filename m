Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWDLWOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWDLWOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDLWOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:14:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:41650 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932344AbWDLWOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:14:42 -0400
Date: Wed, 12 Apr 2006 18:14:37 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060412221437.GA20899@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/b44.c             |   64 ++++++---------
 drivers/net/bnx2.c            |    2 
 drivers/net/hydra.h           |  177 ------------------------------------------
 drivers/net/ixgb/ixgb_main.c  |   13 ++-
 drivers/net/mv643xx_eth.c     |   19 +++-
 drivers/net/natsemi.c         |    2 
 drivers/net/pcmcia/axnet_cs.c |    2 
 drivers/net/skge.c            |    2 
 drivers/net/sky2.c            |    6 -
 drivers/net/sky2.h            |    2 
 drivers/net/starfire.c        |    2 
 drivers/net/typhoon.c         |    2 
 drivers/net/via-rhine.c       |    7 -
 13 files changed, 67 insertions(+), 233 deletions(-)

Adrian Bunk:
      drivers/net/via-rhine.c: make a function static
      remove drivers/net/hydra.h

Andreas Schwab:
      Use pci_set_consistent_dma_mask in ixgb driver

Brent Cook:
      mv643xx_eth: Always free completed tx descs on tx interrupt

Dale Farnsworth:
      mv643xx_eth: Fix tx_timeout to only conditionally wake tx queue

Gary Zambrano:
      b44: disable default tx pause
      b44: increase version to 1.00

Jeff Garzik:
      [netdrvr b44] trim trailing whitespace

Komuro:
      network: axnet_cs.c: add missing 'PRIV' in ei_rx_overrun

Randy Dunlap:
      net drivers: fix section attributes for gcc

Roger Luethi:
      via-rhine: execute bounce buffers code on Rhine-I only

Stephen Hemminger:
      dlink pci cards using wrong driver
      sky2: bad memory reference on dual port cards

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index c4e12b5..3d30668 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2,6 +2,7 @@
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
  * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
+ * Copyright (C) 2006 Broadcom Corporation.
  *
  * Distribute under GPL.
  */
@@ -28,8 +29,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.97"
-#define DRV_MODULE_RELDATE	"Nov 30, 2005"
+#define DRV_MODULE_VERSION	"1.00"
+#define DRV_MODULE_RELDATE	"Apr 7, 2006"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -136,7 +137,7 @@ static inline unsigned long br32(const s
 	return readl(bp->regs + reg);
 }
 
-static inline void bw32(const struct b44 *bp, 
+static inline void bw32(const struct b44 *bp,
 			unsigned long reg, unsigned long val)
 {
 	writel(val, bp->regs + reg);
@@ -286,13 +287,13 @@ static void __b44_cam_write(struct b44 *
 	val |= ((u32) data[4]) <<  8;
 	val |= ((u32) data[5]) <<  0;
 	bw32(bp, B44_CAM_DATA_LO, val);
-	val = (CAM_DATA_HI_VALID | 
+	val = (CAM_DATA_HI_VALID |
 	       (((u32) data[0]) << 8) |
 	       (((u32) data[1]) << 0));
 	bw32(bp, B44_CAM_DATA_HI, val);
 	bw32(bp, B44_CAM_CTRL, (CAM_CTRL_WRITE |
 			    (index << CAM_CTRL_INDEX_SHIFT)));
-	b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);	
+	b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);
 }
 
 static inline void __b44_disable_ints(struct b44 *bp)
@@ -410,25 +411,18 @@ static void __b44_set_flow_ctrl(struct b
 
 static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
 {
-	u32 pause_enab = bp->flags & (B44_FLAG_TX_PAUSE |
-				      B44_FLAG_RX_PAUSE);
+	u32 pause_enab = 0;
 
-	if (local & ADVERTISE_PAUSE_CAP) {
-		if (local & ADVERTISE_PAUSE_ASYM) {
-			if (remote & LPA_PAUSE_CAP)
-				pause_enab |= (B44_FLAG_TX_PAUSE |
-					       B44_FLAG_RX_PAUSE);
-			else if (remote & LPA_PAUSE_ASYM)
-				pause_enab |= B44_FLAG_RX_PAUSE;
-		} else {
-			if (remote & LPA_PAUSE_CAP)
-				pause_enab |= (B44_FLAG_TX_PAUSE |
-					       B44_FLAG_RX_PAUSE);
-		}
-	} else if (local & ADVERTISE_PAUSE_ASYM) {
-		if ((remote & LPA_PAUSE_CAP) &&
-		    (remote & LPA_PAUSE_ASYM))
-			pause_enab |= B44_FLAG_TX_PAUSE;
+	/* The driver supports only rx pause by default because
+	   the b44 mac tx pause mechanism generates excessive
+	   pause frames.
+	   Use ethtool to turn on b44 tx pause if necessary.
+	 */
+	if ((local & ADVERTISE_PAUSE_CAP) &&
+	    (local & ADVERTISE_PAUSE_ASYM)){
+		if ((remote & LPA_PAUSE_ASYM) &&
+		    !(remote & LPA_PAUSE_CAP))
+			pause_enab |= B44_FLAG_RX_PAUSE;
 	}
 
 	__b44_set_flow_ctrl(bp, pause_enab);
@@ -1063,7 +1057,7 @@ static int b44_change_mtu(struct net_dev
 	spin_unlock_irq(&bp->lock);
 
 	b44_enable_ints(bp);
-	
+
 	return 0;
 }
 
@@ -1381,7 +1375,7 @@ static void b44_init_hw(struct b44 *bp)
 	bw32(bp, B44_DMARX_ADDR, bp->rx_ring_dma + bp->dma_offset);
 
 	bw32(bp, B44_DMARX_PTR, bp->rx_pending);
-	bp->rx_prod = bp->rx_pending;	
+	bp->rx_prod = bp->rx_pending;
 
 	bw32(bp, B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
 
@@ -1553,9 +1547,9 @@ static void __b44_set_rx_mode(struct net
 			val |= RXCONFIG_ALLMULTI;
 		else
 			i = __b44_load_mcast(bp, dev);
-		
+
 		for (; i < 64; i++) {
-			__b44_cam_write(bp, zero, i);			
+			__b44_cam_write(bp, zero, i);
 		}
 		bw32(bp, B44_RXCONFIG, val);
         	val = br32(bp, B44_CAM_CTRL);
@@ -1737,7 +1731,7 @@ static int b44_set_ringparam(struct net_
 	spin_unlock_irq(&bp->lock);
 
 	b44_enable_ints(bp);
-	
+
 	return 0;
 }
 
@@ -1782,7 +1776,7 @@ static int b44_set_pauseparam(struct net
 	spin_unlock_irq(&bp->lock);
 
 	b44_enable_ints(bp);
-	
+
 	return 0;
 }
 
@@ -1898,7 +1892,7 @@ static int __devinit b44_get_invariants(
 	bp->core_unit = ssb_core_unit(bp);
 	bp->dma_offset = SB_PCI_DMA;
 
-	/* XXX - really required? 
+	/* XXX - really required?
 	   bp->flags |= B44_FLAG_BUGGY_TXPTR;
          */
 out:
@@ -1946,7 +1940,7 @@ static int __devinit b44_init_one(struct
 		       "aborting.\n");
 		goto err_out_free_res;
 	}
-	
+
 	err = pci_set_consistent_dma_mask(pdev, (u64) B44_DMA_MASK);
 	if (err) {
 		printk(KERN_ERR PFX "No usable DMA configuration, "
@@ -2041,9 +2035,9 @@ static int __devinit b44_init_one(struct
 
 	pci_save_state(bp->pdev);
 
-	/* Chip reset provides power to the b44 MAC & PCI cores, which 
+	/* Chip reset provides power to the b44 MAC & PCI cores, which
 	 * is necessary for MAC register access.
-	 */ 
+	 */
 	b44_chip_reset(bp);
 
 	printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev->name);
@@ -2091,10 +2085,10 @@ static int b44_suspend(struct pci_dev *p
 
 	del_timer_sync(&bp->timer);
 
-	spin_lock_irq(&bp->lock); 
+	spin_lock_irq(&bp->lock);
 
 	b44_halt(bp);
-	netif_carrier_off(bp->dev); 
+	netif_carrier_off(bp->dev);
 	netif_device_detach(bp->dev);
 	b44_free_rings(bp);
 
diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
index 2671da2..5ca99e2 100644
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -63,7 +63,7 @@
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (5*HZ)
 
-static char version[] __devinitdata =
+static const char version[] __devinitdata =
 	"Broadcom NetXtreme II Gigabit Ethernet Driver " DRV_MODULE_NAME " v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("Michael Chan <mchan@broadcom.com>");
diff --git a/drivers/net/hydra.h b/drivers/net/hydra.h
deleted file mode 100644
index 3741414..0000000
--- a/drivers/net/hydra.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/*	$Linux: hydra.h,v 1.0 1994/10/26 02:03:47 cgd Exp $	*/
-
-/*
- * Copyright (c) 1994 Timo Rossi
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. All advertising materials mentioning features or use of this software
- *    must display the following acknowledgement:
- *      This product includes software developed by  Timo Rossi
- * 4. The name of the author may not be used to endorse or promote products
- *    derived from this software without specific prior written permission
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/*
- * The Hydra Systems card uses the National Semiconductor
- * 8390 NIC (Network Interface Controller) chip, located
- * at card base address + 0xffe1. NIC registers are accessible
- * only at odd byte addresses, so the register offsets must
- * be multiplied by two.
- *
- * Card address PROM is located at card base + 0xffc0 (even byte addresses)
- *
- * RAM starts at the card base address, and is 16K or 64K.
- * The current Amiga NetBSD hydra driver is hardwired for 16K.
- * It seems that the RAM should be accessed as words or longwords only.
- *
- */
-
-/* adapted for Linux by Topi Kanerva 03/29/95
-   with original author's permission          */
-
-#define HYDRA_NIC_BASE 0xffe1
-
-/* Page0 registers */
-
-#define NIC_CR     0       /* Command register   */
-#define NIC_PSTART (1*2)   /* Page start (write) */
-#define NIC_PSTOP  (2*2)   /* Page stop (write)  */
-#define NIC_BNDRY  (3*2)   /* Boundary pointer   */
-#define NIC_TSR    (4*2)   /* Transmit status (read) */
-#define NIC_TPSR   (4*2)   /* Transmit page start (write) */
-#define NIC_NCR    (5*2)   /* Number of collisions, read  */
-#define NIC_TBCR0  (5*2)   /* Transmit byte count low (write)  */
-#define NIC_FIFO   (6*2)   /* FIFO reg. (read)   */
-#define NIC_TBCR1  (6*2)   /* Transmit byte count high (write) */
-#define NIC_ISR    (7*2)   /* Interrupt status register */
-#define NIC_RBCR0  (0xa*2) /* Remote byte count low (write)  */
-#define NIC_RBCR1  (0xb*2) /* Remote byte count high (write) */
-#define NIC_RSR    (0xc*2) /* Receive status (read)  */
-#define NIC_RCR    (0xc*2) /* Receive config (write) */
-#define NIC_CNTR0  (0xd*2) /* Frame alignment error count (read) */
-#define NIC_TCR    (0xd*2) /* Transmit config (write)  */
-#define NIC_CNTR1  (0xe*2) /* CRC error counter (read) */
-#define NIC_DCR    (0xe*2) /* Data config (write) */
-#define NIC_CNTR2  (0xf*2) /* missed packet counter (read) */
-#define NIC_IMR    (0xf*2) /* Interrupt mask reg. (write)  */
-
-/* Page1 registers */
-
-#define NIC_PAR0   (1*2)   /* Physical address */
-#define NIC_PAR1   (2*2)
-#define NIC_PAR2   (3*2)
-#define NIC_PAR3   (4*2)
-#define NIC_PAR4   (5*2)
-#define NIC_PAR5   (6*2)
-#define NIC_CURR   (7*2)   /* Current RX ring-buffer page */
-#define NIC_MAR0   (8*2)   /* Multicast address */
-#define NIC_MAR1   (9*2)
-#define NIC_MAR2   (0xa*2)
-#define NIC_MAR3   (0xb*2)
-#define NIC_MAR4   (0xc*2)
-#define NIC_MAR5   (0xd*2)
-#define NIC_MAR6   (0xe*2)
-#define NIC_MAR7   (0xf*2)
-
-/* Command register definitions */
-
-#define CR_STOP   0x01 /* Stop -- software reset command */
-#define CR_START  0x02 /* Start */
-#define CR_TXP   0x04 /* Transmit packet */
-
-#define CR_RD0    0x08 /* Remote DMA cmd */
-#define CR_RD1    0x10
-#define CR_RD2    0x20
-
-#define CR_NODMA  CR_RD2
-
-#define CR_PS0    0x40 /* Page select */
-#define CR_PS1    0x80
-
-#define CR_PAGE0  0
-#define CR_PAGE1  CR_PS0
-#define CR_PAGE2  CR_PS1
-
-/* Interrupt status reg. definitions */
-
-#define ISR_PRX   0x01 /* Packet received without errors */
-#define ISR_PTX   0x02 /* Packet transmitted without errors */
-#define ISR_RXE   0x04 /* Receive error  */
-#define ISR_TXE   0x08 /* Transmit error */
-#define ISR_OVW   0x10 /* Ring buffer overrun */
-#define ISR_CNT   0x20 /* Counter overflow    */
-#define ISR_RDC   0x40 /* Remote DMA compile */
-#define ISR_RST   0x80 /* Reset status      */
-
-/* Data config reg. definitions */
-
-#define DCR_WTS   0x01 /* Word transfer select  */
-#define DCR_BOS   0x02 /* Byte order select     */
-#define DCR_LAS   0x04 /* Long address select   */
-#define DCR_LS    0x08 /* Loopback select       */
-#define DCR_AR    0x10 /* Auto-init remote      */
-#define DCR_FT0   0x20 /* FIFO threshold select */
-#define DCR_FT1   0x40
-
-/* Transmit config reg. definitions */
-
-#define TCR_CRC  0x01 /* Inhibit CRC */
-#define TCR_LB0  0x02 /* Loopback control */
-#define TCR_LB1  0x04
-#define TCR_ATD  0x08 /* Auto transmit disable */
-#define TCR_OFST 0x10 /* Collision offset enable */
-
-/* Transmit status reg. definitions */
-
-#define TSR_PTX  0x01 /* Packet transmitted */
-#define TSR_COL  0x04 /* Transmit collided */
-#define TSR_ABT  0x08 /* Transmit aborted */
-#define TSR_CRS  0x10 /* Carrier sense lost */
-#define TSR_FU   0x20 /* FIFO underrun */
-#define TSR_CDH  0x40 /* CD Heartbeat */
-#define TSR_OWC  0x80 /* Out of Window Collision */
-
-/* Receiver config register definitions */
-
-#define RCR_SEP  0x01 /* Save errored packets */
-#define RCR_AR   0x02 /* Accept runt packets */
-#define RCR_AB   0x04 /* Accept broadcast */
-#define RCR_AM   0x08 /* Accept multicast */
-#define RCR_PRO  0x10 /* Promiscuous mode */
-#define RCR_MON  0x20 /* Monitor mode */
-
-/* Receiver status register definitions */
-
-#define RSR_PRX  0x01 /* Packet received without error */
-#define RSR_CRC  0x02 /* CRC error */
-#define RSR_FAE  0x04 /* Frame alignment error */
-#define RSR_FO   0x08 /* FIFO overrun */
-#define RSR_MPA  0x10 /* Missed packet */
-#define RSR_PHY  0x20 /* Physical address */
-#define RSR_DIS  0x40 /* Received disabled */
-#define RSR_DFR  0x80 /* Deferring (jabber) */
-
-/* Hydra System card address PROM offset */
-
-#define HYDRA_ADDRPROM 0xffc0
-
-
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index f9f77e4..cfd67d8 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -357,18 +357,20 @@ ixgb_probe(struct pci_dev *pdev,
 	if((err = pci_enable_device(pdev)))
 		return err;
 
-	if(!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
+	if(!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK)) &&
+	   !(err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))) {
 		pci_using_dac = 1;
 	} else {
-		if((err = pci_set_dma_mask(pdev, DMA_32BIT_MASK))) {
+		if((err = pci_set_dma_mask(pdev, DMA_32BIT_MASK)) ||
+		   (err = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK))) {
 			IXGB_ERR("No usable DMA configuration, aborting\n");
-			return err;
+			goto err_dma_mask;
 		}
 		pci_using_dac = 0;
 	}
 
 	if((err = pci_request_regions(pdev, ixgb_driver_name)))
-		return err;
+		goto err_request_regions;
 
 	pci_set_master(pdev);
 
@@ -502,6 +504,9 @@ err_ioremap:
 	free_netdev(netdev);
 err_alloc_etherdev:
 	pci_release_regions(pdev);
+err_request_regions:
+err_dma_mask:
+	pci_disable_device(pdev);
 	return err;
 }
 
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 9f26613..ea62a3e 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -281,10 +281,16 @@ static void mv643xx_eth_tx_timeout_task(
 {
 	struct mv643xx_private *mp = netdev_priv(dev);
 
-	netif_device_detach(dev);
+	if (!netif_running(dev))
+		return;
+
+	netif_stop_queue(dev);
+
 	eth_port_reset(mp->port_num);
 	eth_port_start(dev);
-	netif_device_attach(dev);
+
+	if (mp->tx_ring_size - mp->tx_desc_count >= MAX_DESCS_PER_SKB)
+		netif_wake_queue(dev);
 }
 
 /**
@@ -552,9 +558,9 @@ static irqreturn_t mv643xx_eth_int_handl
 #else
 	if (eth_int_cause & ETH_INT_CAUSE_RX)
 		mv643xx_eth_receive_queue(dev, INT_MAX);
+#endif
 	if (eth_int_cause_ext & ETH_INT_CAUSE_TX)
 		mv643xx_eth_free_completed_tx_descs(dev);
-#endif
 
 	/*
 	 * If no real interrupt occured, exit.
@@ -1186,7 +1192,12 @@ static int mv643xx_eth_start_xmit(struct
 
 	BUG_ON(netif_queue_stopped(dev));
 	BUG_ON(skb == NULL);
-	BUG_ON(mp->tx_ring_size - mp->tx_desc_count < MAX_DESCS_PER_SKB);
+
+	if (mp->tx_ring_size - mp->tx_desc_count < MAX_DESCS_PER_SKB) {
+		printk(KERN_ERR "%s: transmit with queue full\n", dev->name);
+		netif_stop_queue(dev);
+		return 1;
+	}
 
 	if (has_tiny_unaligned_frags(skb)) {
 		if ((skb_linearize(skb, GFP_ATOMIC) != 0)) {
diff --git a/drivers/net/natsemi.c b/drivers/net/natsemi.c
index 7826afb..9062775 100644
--- a/drivers/net/natsemi.c
+++ b/drivers/net/natsemi.c
@@ -238,7 +238,7 @@ static int full_duplex[MAX_UNITS];
 #define NATSEMI_RX_LIMIT	2046	/* maximum supported by hardware */
 
 /* These identify the driver base version and may not be removed. */
-static char version[] __devinitdata =
+static const char version[] __devinitdata =
   KERN_INFO DRV_NAME " dp8381x driver, version "
       DRV_VERSION ", " DRV_RELDATE "\n"
   KERN_INFO "  originally by Donald Becker <becker@scyld.com>\n"
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 56233af..448a094 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -1560,7 +1560,7 @@ static void ei_receive(struct net_device
 
 static void ei_rx_overrun(struct net_device *dev)
 {
-	axnet_dev_t *info = (axnet_dev_t *)dev;
+	axnet_dev_t *info = PRIV(dev);
 	long e8390_base = dev->base_addr;
 	unsigned char was_txing, must_resend = 0;
 	struct ei_device *ei_local = (struct ei_device *) netdev_priv(dev);
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 35dbf05..a70c2b0 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -78,6 +78,8 @@ static const struct pci_device_id skge_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_GE) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_YU) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, PCI_DEVICE_ID_DLINK_DGE510T), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) }, /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, PCI_DEVICE_ID_CNET_GIGACARD) },
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 68f9c20..67b0eab 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -99,8 +99,6 @@ MODULE_PARM_DESC(disable_msi, "Disable M
 static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4340) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4341) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4342) },
@@ -579,8 +577,8 @@ static void sky2_mac_init(struct sky2_hw
 	reg = gma_read16(hw, port, GM_PHY_ADDR);
 	gma_write16(hw, port, GM_PHY_ADDR, reg | GM_PAR_MIB_CLR);
 
-	for (i = 0; i < GM_MIB_CNT_SIZE; i++)
-		gma_read16(hw, port, GM_MIB_CNT_BASE + 8 * i);
+	for (i = GM_MIB_CNT_BASE; i <= GM_MIB_CNT_END; i += 4)
+		gma_read16(hw, port, i);
 	gma_write16(hw, port, GM_PHY_ADDR, reg);
 
 	/* transmit control */
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 62532b4..89dd18c 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1375,7 +1375,7 @@ enum {
 	GM_PHY_ADDR	= 0x0088,	/* 16 bit r/w	GPHY Address Register */
 /* MIB Counters */
 	GM_MIB_CNT_BASE	= 0x0100,	/* Base Address of MIB Counters */
-	GM_MIB_CNT_SIZE	= 256,
+	GM_MIB_CNT_END	= 0x025C,	/* Last MIB counter */
 };
 
 
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index 45ad036..9b7805b 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -335,7 +335,7 @@ do { \
 
 
 /* These identify the driver base version and may not be removed. */
-static char version[] __devinitdata =
+static const char version[] __devinitdata =
 KERN_INFO "starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>\n"
 KERN_INFO " (unofficial 2.2/2.4 kernel port, version " DRV_VERSION ", " DRV_RELDATE ")\n";
 
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index c1ce87a..d9258d4 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -134,7 +134,7 @@ static const int multicast_filter_limit 
 #include "typhoon.h"
 #include "typhoon-firmware.h"
 
-static char version[] __devinitdata =
+static const char version[] __devinitdata =
     "typhoon.c: version " DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("David Dillow <dave@thedillows.org>");
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index a9b2150..6a23964 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -469,7 +469,7 @@ struct rhine_private {
 	struct sk_buff *tx_skbuff[TX_RING_SIZE];
 	dma_addr_t tx_skbuff_dma[TX_RING_SIZE];
 
-	/* Tx bounce buffers */
+	/* Tx bounce buffers (Rhine-I only) */
 	unsigned char *tx_buf[TX_RING_SIZE];
 	unsigned char *tx_bufs;
 	dma_addr_t tx_bufs_dma;
@@ -1043,7 +1043,8 @@ static void alloc_tbufs(struct net_devic
 		rp->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
 		rp->tx_ring[i].next_desc = cpu_to_le32(next);
-		rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];
+		if (rp->quirks & rqRhineI)
+			rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];
 	}
 	rp->tx_ring[i-1].next_desc = cpu_to_le32(rp->tx_ring_dma);
 
@@ -1091,7 +1092,7 @@ static void rhine_check_media(struct net
 }
 
 /* Called after status of force_media possibly changed */
-void rhine_set_carrier(struct mii_if_info *mii)
+static void rhine_set_carrier(struct mii_if_info *mii)
 {
 	if (mii->force_media) {
 		/* autoneg is off: Link is always assumed to be up */
