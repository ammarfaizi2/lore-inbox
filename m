Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbULOT03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbULOT03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbULOT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:26:28 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:18054 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262450AbULOTSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:18:15 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 15 Dec 2004 12:18:14 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 8/6] mv643xx_eth: address style issues raised by Christoph Hellwig
Message-ID: <20041215191814.GA22620@xyzzy>
References: <20041213220949.GA19609@xyzzy> <20041215190207.GA21410@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215190207.GA21410@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 12:02:07PM -0700, dale wrote:
> This patch addresses the style issues raised by Christoph Hellwig.
> Locally, I have folded these changes into my patch set, but since they
> are issues of style, rather than substance, I don't think it's worth
> re-releasing the patch set now, and I'm just supplying this additional
> patch.

I botched the previous patch.  Please disregard it and use this one.

This patch addresses the style issues raised by Christoph Hellwig.
Locally, I have folded these changes into my patch set, but since they
are issues of style, rather than substance, I don't think it's worth
re-releasing the patch set now, and I'm just supplying this additional
patch.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

diff -u linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
--- linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-15 11:38:29.662690590 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-15 12:06:25.259733848 -0700
@@ -66,6 +66,9 @@
 #define MAX_DESCS_PER_SKB	1
 #endif
 
+#define PHY_WAIT_ITERATIONS	1000	/* 1000 iterations * 10uS = 10mS max */
+#define PHY_WAIT_MICRO_SECONDS	10
+
 /* Static function declarations */
 static void eth_port_uc_addr_get(struct net_device *dev,
 		                                 unsigned char *MacAddr);
@@ -81,6 +84,7 @@
 
 static void __iomem *mv64x60_eth_shared_base;
 
+/* used to protect MV64340_ETH_SMI_REG, which is shared across ports */
 static spinlock_t mv64340_eth_phy_lock = SPIN_LOCK_UNLOCKED;
 
 #undef MV_READ
@@ -355,8 +359,7 @@
 				dma_unmap_single(NULL, pkt_info.buf_ptr,
 					pkt_info.byte_cnt, DMA_TO_DEVICE);
 
-			dev_kfree_skb_irq((struct sk_buff *)
-					  pkt_info.return_info);
+			dev_kfree_skb_irq(pkt_info.return_info);
 			released = 0;
 
 			/* 
@@ -415,7 +418,7 @@
 		/* Update statistics. Note byte count includes 4 byte CRC count */
 		stats->rx_packets++;
 		stats->rx_bytes += pkt_info.byte_cnt;
-		skb = (struct sk_buff *) pkt_info.return_info;
+		skb = pkt_info.return_info;
 		/*
 		 * In case received a packet without first / last bits on OR
 		 * the error summary bit is on, the packets needs to be dropeed.
@@ -948,7 +951,7 @@
 					& 0xfff1ffff));
 
 	/* wait up to 1 second for link to come up */
-	for (i=0; i<10; i++) {
+	for (i = 0; i < 10; i++) {
 		eth_port_read_smi_reg(port_num, 1, &phy_reg_data);
 		if (phy_reg_data & 0x20) {
 			netif_start_queue(dev);
@@ -1089,8 +1092,7 @@
                                  dma_unmap_single(NULL, pkt_info.buf_ptr,
                                              pkt_info.byte_cnt, DMA_TO_DEVICE);
 
-			dev_kfree_skb_irq((struct sk_buff *)
-                                                  pkt_info.return_info);
+			dev_kfree_skb_irq(pkt_info.return_info);
 
                         if (mp->tx_ring_skbs != 0)
                                 mp->tx_ring_skbs--;
@@ -1949,22 +1951,21 @@
  *	N/A.
  *
  */
-static void eth_port_uc_addr_get(struct net_device *dev, unsigned char *MacAddr)
+static void eth_port_uc_addr_get(struct net_device *dev, unsigned char *p_addr)
 {
 	struct mv64340_private *mp = netdev_priv(dev);
-	unsigned int port_num = mp->port_num;
-        u32 MacLow;
-        u32 MacHigh;
-
-        MacLow = MV_READ(MV64340_ETH_MAC_ADDR_LOW(port_num));
-        MacHigh = MV_READ(MV64340_ETH_MAC_ADDR_HIGH(port_num));
-
-        MacAddr[5] = (MacLow) & 0xff;
-        MacAddr[4] = (MacLow >> 8) & 0xff;
-        MacAddr[3] = (MacHigh) & 0xff;
-        MacAddr[2] = (MacHigh >> 8) & 0xff;
-        MacAddr[1] = (MacHigh >> 16) & 0xff;
-        MacAddr[0] = (MacHigh >> 24) & 0xff;
+	unsigned int mac_h;
+	unsigned int mac_l;
+
+	mac_h = MV_READ(MV64340_ETH_MAC_ADDR_HIGH(mp->port_num));
+	mac_l = MV_READ(MV64340_ETH_MAC_ADDR_LOW(mp->port_num));
+
+	p_addr[0] = (mac_h >> 24) & 0xff;
+	p_addr[1] = (mac_h >> 16) & 0xff;
+	p_addr[2] = (mac_h >> 8) & 0xff;
+	p_addr[3] = mac_h & 0xff;
+	p_addr[4] = (mac_l >> 8) & 0xff;
+	p_addr[5] = mac_l & 0xff;
 }
 
 /*
@@ -2297,9 +2298,6 @@
 	return eth_config_reg;
 }
 
-#define PHY_WAIT_ITERATIONS	1000	/* 1000 iterations * 10uS = 10mS max */
-
-
 /*
  * eth_port_read_smi_reg - Read PHY registers
  *
@@ -2331,24 +2329,24 @@
 	spin_lock_irqsave(&mv64340_eth_phy_lock, flags);
 
 	/* wait for the SMI register to become available */
-	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
+	for (i = 0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
 		if (i == PHY_WAIT_ITERATIONS) {
 			printk("mv64340 PHY busy timeout, port %d\n", port_num);
 			goto out;
 		}
-		udelay(10);
+		udelay(PHY_WAIT_MICRO_SECONDS);
 	}
 
 	MV_WRITE(MV64340_ETH_SMI_REG,
 		 (phy_addr << 16) | (phy_reg << 21) | ETH_SMI_OPCODE_READ);
 
 	/* now wait for the data to be valid */
-	for (i=0; !(MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_READ_VALID); i++) {
+	for (i = 0; !(MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_READ_VALID); i++) {
 		if (i == PHY_WAIT_ITERATIONS) {
 			printk("mv64340 PHY read timeout, port %d\n", port_num);
 			goto out;
 		}
-		udelay(10);
+		udelay(PHY_WAIT_MICRO_SECONDS);
 	}
 	 
 	*value = MV_READ(MV64340_ETH_SMI_REG) & 0xffff;
@@ -2390,13 +2388,13 @@
 	spin_lock_irqsave(&mv64340_eth_phy_lock, flags);
 
 	/* wait for the SMI register to become available */
-	for (i=0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
+	for (i = 0; MV_READ(MV64340_ETH_SMI_REG) & ETH_SMI_BUSY; i++) {
 		if (i == PHY_WAIT_ITERATIONS) {
 			printk("mv64340 PHY busy timeout, port %d\n",
 								eth_port_num);
 			goto out;
 		}
-		udelay(10);
+		udelay(PHY_WAIT_MICRO_SECONDS);
 	}
 
 	MV_WRITE(MV64340_ETH_SMI_REG, (phy_addr << 16) | (phy_reg << 21) |
@@ -2470,7 +2468,7 @@
         current_descriptor->buf_ptr = p_pkt_info->buf_ptr;
         current_descriptor->byte_cnt = p_pkt_info->byte_cnt;
         current_descriptor->l4i_chk = p_pkt_info->l4i_chk;
-        mp->tx_skb[tx_desc_curr] = (struct sk_buff*) p_pkt_info->return_info;
+        mp->tx_skb[tx_desc_curr] = p_pkt_info->return_info;
 
 	command = p_pkt_info->cmd_sts | ETH_ZERO_PADDING | ETH_GEN_CRC |
 							ETH_BUFFER_OWNED_BY_DMA;
@@ -2537,7 +2535,7 @@
 	command_status = p_pkt_info->cmd_sts | ETH_ZERO_PADDING | ETH_GEN_CRC;
 	current_descriptor->buf_ptr = p_pkt_info->buf_ptr;
 	current_descriptor->byte_cnt = p_pkt_info->byte_cnt;
-	mp->tx_skb[tx_desc_curr] = (struct sk_buff *) p_pkt_info->return_info;
+	mp->tx_skb[tx_desc_curr] = p_pkt_info->return_info;
 
 
 	/* Set last desc with DMA ownership and interrupt enable. */
