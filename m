Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbULMWbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbULMWbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbULMWa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:30:58 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:57752 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261209AbULMWUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:20:45 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:20:43 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 6/6] mv643xx_eth: add configurable parameters via platform device interface
Message-ID: <20041213222043.GF19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for passing additional parameters via the
platform device interface.  These additional parameters are:
	size of RX and TX descriptor rings
	port_config value
	port_config_extend value
	port_sdma_config value
	port_serial_control value
	PHY address

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-13 14:30:39.866524559 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:30:44.084710360 -0700
@@ -75,6 +75,7 @@
 #ifdef MV64340_NAPI
 static int mv64340_poll(struct net_device *dev, int *budget);
 #endif
+static void ethernet_phy_set(unsigned int eth_port_num, int phy_addr);
 
 static void __iomem *mv64x60_eth_shared_base;
 
@@ -250,12 +251,12 @@
 		ethernet_set_config_reg
 		    (mp->port_num,
 		     ethernet_get_config_reg(mp->port_num) |
-		     ETH_UNICAST_PROMISCUOUS_MODE);
+		     MV64340_ETH_UNICAST_PROMISCUOUS_MODE);
 	} else {
 		ethernet_set_config_reg
 		    (mp->port_num,
 		     ethernet_get_config_reg(mp->port_num) &
-		     ~(unsigned int) ETH_UNICAST_PROMISCUOUS_MODE);
+		     ~(unsigned int) MV64340_ETH_UNICAST_PROMISCUOUS_MODE);
 	}
 }
 
@@ -509,8 +510,7 @@
 		/* UDP change : We may need this */
 		if ((eth_int_cause_ext & 0x0000ffff) &&
 		    (mv64340_eth_free_tx_queue(dev, eth_int_cause_ext) == 0) &&
-		    (MV64340_TX_QUEUE_SIZE >
-					mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
+		    (mp->tx_ring_size > mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
                                          netif_wake_queue(dev);
 #ifdef MV64340_NAPI
 	} else {
@@ -830,47 +830,72 @@
 	mp->rx_task_busy = 0;
 	mp->rx_timer_flag = 0;
 
+	/* Allocate RX and TX skb rings */
+	mp->rx_skb = kmalloc(sizeof(*mp->rx_skb)*mp->rx_ring_size, GFP_KERNEL);
+	if (!mp->rx_skb) {
+		printk(KERN_ERR "%s: Cannot allocate Rx skb ring\n", dev->name);
+		return -ENOMEM;
+	}
+	mp->tx_skb = kmalloc(sizeof(*mp->tx_skb)*mp->tx_ring_size, GFP_KERNEL);
+	if (!mp->tx_skb) {
+		printk(KERN_ERR "%s: Cannot allocate Tx skb ring\n", dev->name);
+		kfree(mp->rx_skb);
+		return -ENOMEM;
+	}
+
 	/* Allocate TX ring */
 	mp->tx_ring_skbs = 0;
-	mp->tx_ring_size = MV64340_TX_QUEUE_SIZE;
 	size = mp->tx_ring_size * sizeof(struct eth_tx_desc);
 	mp->tx_desc_area_size = size;
 
-	/* Assumes allocated ring is 16 bytes alligned */
-	mp->p_tx_desc_area = dma_alloc_coherent(NULL, size, &mp->tx_desc_dma,
-								GFP_KERNEL);
+	if (mp->tx_sram_size) {
+		mp->p_tx_desc_area = ioremap(mp->tx_sram_addr,
+							mp->tx_sram_size);
+		mp->tx_desc_dma = mp->tx_sram_addr;
+	} else
+		mp->p_tx_desc_area = dma_alloc_coherent(NULL, size,
+						&mp->tx_desc_dma, GFP_KERNEL);
+
 	if (!mp->p_tx_desc_area) {
 		printk(KERN_ERR "%s: Cannot allocate Tx Ring (size %d bytes)\n",
 		       dev->name, size);
+		kfree(mp->rx_skb);
+		kfree(mp->tx_skb);
 		return -ENOMEM;
 	}
+	BUG_ON((u32)mp->p_tx_desc_area & 0xf);	/* check 16-byte alignment */
 	memset((void *) mp->p_tx_desc_area, 0, mp->tx_desc_area_size);
 
-	/* Dummy will be replaced upon real tx */
 	ether_init_tx_desc_ring(mp);
 
 	/* Allocate RX ring */
-	/* Meantime RX Ring are fixed - but must be configurable by user */
-	mp->rx_ring_size = MV64340_RX_QUEUE_SIZE;
 	mp->rx_ring_skbs = 0;
 	size = mp->rx_ring_size * sizeof(struct eth_rx_desc);
 	mp->rx_desc_area_size = size;
 
-	/* Assumes allocated ring is 16 bytes aligned */
-
-	mp->p_rx_desc_area = dma_alloc_coherent(NULL, size, &mp->rx_desc_dma,
-								GFP_KERNEL);
+	if (mp->rx_sram_size) {
+		mp->p_rx_desc_area = ioremap(mp->rx_sram_addr,
+							mp->rx_sram_size);
+		mp->rx_desc_dma = mp->rx_sram_addr;
+	} else
+		mp->p_rx_desc_area = dma_alloc_coherent(NULL, size,
+						&mp->rx_desc_dma, GFP_KERNEL);
 
 	if (!mp->p_rx_desc_area) {
 		printk(KERN_ERR "%s: Cannot allocate Rx ring (size %d bytes)\n",
 		       dev->name, size);
 		printk(KERN_ERR "%s: Freeing previously allocated TX queues...",
 		       dev->name);
-		dma_free_coherent(NULL, mp->tx_desc_area_size,
+		if (mp->rx_sram_size)
+			iounmap(mp->p_rx_desc_area);
+		else
+			dma_free_coherent(NULL, mp->tx_desc_area_size,
 				    mp->p_tx_desc_area, mp->tx_desc_dma);
+		kfree(mp->rx_skb);
+		kfree(mp->tx_skb);
 		return -ENOMEM;
 	}
-	memset(mp->p_rx_desc_area, 0, size);
+	memset((void *)mp->p_rx_desc_area, 0, size);
 
 	ether_init_rx_desc_ring(mp);
 
@@ -918,11 +943,9 @@
 	MV_WRITE(MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(port_num),
 		 0x0000ff00);
 
-	/* Free TX rings */
+
 	/* Free outstanding skb's on TX rings */
-	for (curr = 0;
-	     (mp->tx_ring_skbs) && (curr < MV64340_TX_QUEUE_SIZE);
-	     curr++) {
+	for (curr = 0; mp->tx_ring_skbs && curr < mp->tx_ring_size; curr++) {
 		if (mp->tx_skb[curr]) {
 			dev_kfree_skb(mp->tx_skb[curr]);
 			mp->tx_ring_skbs--;
@@ -932,7 +955,12 @@
 		printk("%s: Error on Tx descriptor free - could not free %d"
 		     " descriptors\n", dev->name,
 		     mp->tx_ring_skbs);
-	dma_free_coherent(0, mp->tx_desc_area_size,
+
+	/* Free TX ring */
+	if (mp->tx_sram_size)
+		iounmap(mp->p_tx_desc_area);
+	else
+		dma_free_coherent(NULL, mp->tx_desc_area_size,
 			    mp->p_tx_desc_area, mp->tx_desc_dma);
 }
 
@@ -946,11 +974,8 @@
 	MV_WRITE(MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num),
 		 0x0000ff00);
 
-	/* Free RX rings */
 	/* Free preallocated skb's on RX rings */
-	for (curr = 0;
-		mp->rx_ring_skbs && (curr < MV64340_RX_QUEUE_SIZE);
-		curr++) {
+	for (curr = 0; mp->rx_ring_skbs && curr < mp->rx_ring_size; curr++) {
 		if (mp->rx_skb[curr]) {
 			dev_kfree_skb(mp->rx_skb[curr]);
 			mp->rx_ring_skbs--;
@@ -962,7 +987,11 @@
 		       "%s: Error in freeing Rx Ring. %d skb's still"
 		       " stuck in RX Ring - ignoring them\n", dev->name,
 		       mp->rx_ring_skbs);
-	dma_free_coherent(NULL, mp->rx_desc_area_size,
+	/* Free RX ring */
+	if (mp->rx_sram_size)
+		iounmap(mp->p_rx_desc_area);
+	else
+		dma_free_coherent(NULL, mp->rx_desc_area_size,
 			    mp->p_rx_desc_area, mp->rx_desc_dma);
 }
 
@@ -1043,8 +1072,8 @@
 	}
 
 	if (netif_queue_stopped(dev) &&
-            MV64340_TX_QUEUE_SIZE > mp->tx_ring_skbs + MAX_DESCS_PER_SKB)
-                       netif_wake_queue(dev);
+			mp->tx_ring_size > mp->tx_ring_skbs + MAX_DESCS_PER_SKB)
+		netif_wake_queue(dev);
 }
 
 /*
@@ -1123,8 +1152,8 @@
 	}
 
 	/* This is a hard error, log it. */
-	if ((MV64340_TX_QUEUE_SIZE - mp->tx_ring_skbs) <=
-	    (skb_shinfo(skb)->nr_frags + 1)) {
+	if ((mp->tx_ring_size - mp->tx_ring_skbs) <=
+					(skb_shinfo(skb)->nr_frags + 1)) {
 		netif_stop_queue(dev);
 		printk(KERN_ERR
 		       "%s: Bug in mv64340_eth - Trying to transmit when"
@@ -1135,6 +1164,7 @@
 	/* Paranoid check - this shouldn't happen */
 	if (skb == NULL) {
 		stats->tx_dropped++;
+		printk(KERN_ERR "mv64320_eth paranoid check failed\n");
 		return 1;
 	}
 
@@ -1274,7 +1304,7 @@
 	/* Check if TX queue can handle another skb. If not, then
 	 * signal higher layers to stop requesting TX
 	 */
-	if (MV64340_TX_QUEUE_SIZE <= (mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
+	if (mp->tx_ring_size <= (mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
 		/* 
 		 * Stop getting skb's from upper layers.
 		 * Getting skb's from upper layers will be enabled again after
@@ -1318,7 +1348,7 @@
  * and set the MAC address of the interface
  *
  * Input : struct device *
- * Output : -ENOMEM or -ENODEV if failed , 0 if success
+ * Output : -ENOMEM if failed , 0 if success
  */
 static int mv64340_eth_probe(struct device *ddev)
 {
@@ -1339,12 +1369,9 @@
 
 	mp = netdev_priv(dev);
 
-	if ((res = platform_get_resource(pdev, IORESOURCE_IRQ, 0)))
-		dev->irq = res->start;
-	else {
-		err = -ENODEV;
-		goto out;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	BUG_ON(!res);
+	dev->irq = res->start;
 
 	mp->port_num = port_num;
 
@@ -1363,7 +1390,7 @@
 #endif
 
 	dev->watchdog_timeo = 2 * HZ;
-	dev->tx_queue_len = MV64340_TX_QUEUE_SIZE;
+	dev->tx_queue_len = mp->tx_ring_size;
 	dev->base_addr = 0;
 	dev->change_mtu = mv64340_eth_change_mtu;
 
@@ -1388,10 +1415,48 @@
 	
 	/* set default config values */
 	eth_port_uc_addr_get(dev, dev->dev_addr);
+	mp->port_config = MV64340_ETH_PORT_CONFIG_DEFAULT_VALUE;
+	mp->port_config_extend = MV64340_ETH_PORT_CONFIG_EXTEND_DEFAULT_VALUE;
+	mp->port_sdma_config = MV64340_ETH_PORT_SDMA_CONFIG_DEFAULT_VALUE;
+	mp->port_serial_control = MV64340_ETH_PORT_SERIAL_CONTROL_DEFAULT_VALUE;
+	mp->rx_ring_size = MV64340_ETH_PORT_DEFAULT_RECEIVE_QUEUE_SIZE;
+	mp->tx_ring_size = MV64340_ETH_PORT_DEFAULT_TRANSMIT_QUEUE_SIZE;
+
 	pd = pdev->dev.platform_data;
 	if (pd) {
 		if (pd->mac_addr != NULL)
 			memcpy(dev->dev_addr, pd->mac_addr, 6);
+
+		if (pd->phy_addr || pd->force_phy_addr)
+			ethernet_phy_set(port_num, pd->phy_addr);
+
+		if (pd->port_config || pd->force_port_config)
+			mp->port_config = pd->port_config;
+
+		if (pd->port_config_extend || pd->force_port_config_extend)
+			mp->port_config_extend = pd->port_config_extend;
+
+		if (pd->port_sdma_config || pd->force_port_sdma_config)
+			mp->port_sdma_config = pd->port_sdma_config;
+
+		if (pd->port_serial_control || pd->force_port_serial_control)
+			mp->port_serial_control = pd->port_serial_control;
+
+		if (pd->rx_queue_size)
+			mp->rx_ring_size = pd->rx_queue_size;
+
+		if (pd->tx_queue_size)
+			mp->tx_ring_size = pd->tx_queue_size;
+
+		if (pd->tx_sram_size) {
+			mp->tx_sram_size = pd->tx_sram_size;
+			mp->tx_sram_addr = pd->tx_sram_addr;
+		}
+
+		if (pd->rx_sram_size) {
+			mp->rx_sram_size = pd->rx_sram_size;
+			mp->rx_sram_addr = pd->rx_sram_addr;
+		}
 	}
 
 	err = register_netdev(dev);
@@ -1404,7 +1469,7 @@
 		dev->name, port_num, p[0], p[1], p[2], p[3], p[4], p[5]);
 
 	if (dev->features & NETIF_F_SG)
-		printk(KERN_NOTICE "%s: Scatter Gather Enabled", dev->name);
+		printk(KERN_NOTICE "%s: Scatter Gather Enabled\n", dev->name);
 
 	if (dev->features & NETIF_F_IP_CSUM)
 		printk(KERN_NOTICE "%s: TX TCP/IP Checksumming Supported\n",
@@ -1658,12 +1723,6 @@
  *       port_sdma_config      User port SDMA config value.
  *       port_serial_control   User port serial control value.
  *
- *       This driver introduce a set of default values:
- *       PORT_CONFIG_VALUE           Default port configuration value
- *       PORT_CONFIG_EXTEND_VALUE    Default port extend configuration value
- *       PORT_SDMA_CONFIG_VALUE      Default sdma control value
- *       PORT_SERIAL_CONTROL_VALUE   Default port serial control value
- *
  *		This driver data flow is done using the struct pkt_info which
  *              is a unified struct for Rx and Tx operations:
  *
@@ -1684,6 +1743,7 @@
 
 /* PHY routines */
 static int ethernet_phy_get(unsigned int eth_port_num);
+static void ethernet_phy_set(unsigned int eth_port_num, int phy_addr);
 
 /* Ethernet Port routines */
 static int eth_port_uc_addr(unsigned int eth_port_num, unsigned char uc_nibble,
@@ -1715,18 +1775,6 @@
  */
 static void eth_port_init(struct mv64340_private * mp)
 {
-	mp->port_config = PORT_CONFIG_VALUE;
-	mp->port_config_extend = PORT_CONFIG_EXTEND_VALUE;
-#if defined(__BIG_ENDIAN)
-	mp->port_sdma_config = PORT_SDMA_CONFIG_VALUE;
-#elif defined(__LITTLE_ENDIAN)
-	mp->port_sdma_config = PORT_SDMA_CONFIG_VALUE |
-		ETH_BLM_RX_NO_SWAP | ETH_BLM_TX_NO_SWAP;
-#else
-#error One of __LITTLE_ENDIAN or __BIG_ENDIAN must be defined!
-#endif
-	mp->port_serial_control = PORT_SERIAL_CONTROL_VALUE;
-
 	mp->port_rx_queue_command = 0;
 	mp->port_tx_queue_command = 0;
 
@@ -1798,7 +1846,7 @@
 		 mp->port_serial_control);
 
 	MV_SET_REG_BITS(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num),
-			ETH_SERIAL_PORT_ENABLE);
+			MV64340_ETH_SERIAL_PORT_ENABLE);
 
 	/* Assign port SDMA configuration */
 	MV_WRITE(MV64340_ETH_SDMA_CONFIG_REG(eth_port_num),
@@ -2049,6 +2097,34 @@
 }
 
 /*
+ * ethernet_phy_set - Set the ethernet port PHY address.
+ *
+ * DESCRIPTION:
+ *       This routine sets the given ethernet port PHY address.
+ *
+ * INPUT:
+ *	unsigned int	eth_port_num	Ethernet Port number.
+ *	int		phy_addr	PHY address.
+ *
+ * OUTPUT:
+ *       None.
+ *
+ * RETURN:
+ *       None.
+ *
+ */
+static void ethernet_phy_set(unsigned int eth_port_num, int phy_addr)
+{
+	u32 reg_data;
+	int addr_shift = 5 * eth_port_num;
+
+	reg_data = MV_READ(MV64340_ETH_PHY_ADDR_REG);
+	reg_data &= ~(0x1f << addr_shift);
+	reg_data |= (phy_addr & 0x1f) << addr_shift;
+	MV_WRITE(MV64340_ETH_PHY_ADDR_REG, reg_data);
+}
+
+/*
  * ethernet_phy_reset - Reset Ethernet port PHY.
  *
  * DESCRIPTION:
@@ -2132,7 +2208,7 @@
 
 	/* Reset the Enable bit in the Configuration Register */
 	reg_data = MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(port_num));
-	reg_data &= ~ETH_SERIAL_PORT_ENABLE;
+	reg_data &= ~MV64340_ETH_SERIAL_PORT_ENABLE;
 	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(port_num), reg_data);
 }
 
@@ -2360,7 +2436,7 @@
 
 	current_descriptor = &mp->p_tx_desc_area[tx_desc_curr];
 
-	tx_next_desc = (tx_desc_curr + 1) % MV64340_TX_QUEUE_SIZE;
+	tx_next_desc = (tx_desc_curr + 1) % mp->tx_ring_size;
 
         current_descriptor->buf_ptr = p_pkt_info->buf_ptr;
         current_descriptor->byte_cnt = p_pkt_info->byte_cnt;
@@ -2444,7 +2520,7 @@
 	ETH_ENABLE_TX_QUEUE(mp->port_num);
 
 	/* Finish Tx packet. Update first desc in case of Tx resource error */
-	tx_desc_curr = (tx_desc_curr + 1) % MV64340_TX_QUEUE_SIZE;
+	tx_desc_curr = (tx_desc_curr + 1) % mp->tx_ring_size;
 
 	/* Update the current descriptor */
  	mp->tx_curr_desc_q = tx_desc_curr;
@@ -2520,7 +2596,7 @@
 	mp->tx_skb[tx_desc_used] = NULL;
 
 	/* Update the next descriptor to release. */
-	mp->tx_used_desc_q = (tx_desc_used + 1) % MV64340_TX_QUEUE_SIZE;
+	mp->tx_used_desc_q = (tx_desc_used + 1) % mp->tx_ring_size;
 
 	/* Any Tx return cancels the Tx resource error status */
 	mp->tx_resource_err = 0;
@@ -2586,7 +2662,7 @@
 	mp->rx_skb[rx_curr_desc] = NULL;
 
 	/* Update current index in data structure */
-	rx_next_curr_desc = (rx_curr_desc + 1) % MV64340_RX_QUEUE_SIZE;
+	rx_next_curr_desc = (rx_curr_desc + 1) % mp->rx_ring_size;
 	mp->rx_curr_desc_q = rx_next_curr_desc;
 
 	/* Rx descriptors exhausted. Set the Rx ring resource error flag */
@@ -2640,7 +2716,7 @@
 	wmb();
 
 	/* Move the used descriptor pointer to the next descriptor */
-	mp->rx_used_desc_q = (used_rx_desc + 1) % MV64340_RX_QUEUE_SIZE;
+	mp->rx_used_desc_q = (used_rx_desc + 1) % mp->rx_ring_size;
 
 	/* Any Rx return cancels the Rx resource error status */
 	mp->rx_resource_err = 0;
Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.h	2004-12-13 14:30:39.867524366 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h	2004-12-13 14:30:44.085710167 -0700
@@ -61,10 +61,10 @@
  */
 
 /* Default TX ring size is 1000 descriptors */
-#define MV64340_TX_QUEUE_SIZE 1000
+#define MV64340_DEFAULT_TX_QUEUE_SIZE 1000
 
 /* Default RX ring size is 400 descriptors */
-#define MV64340_RX_QUEUE_SIZE 400
+#define MV64340_DEFAULT_RX_QUEUE_SIZE 400
 
 #define MV64340_TX_COAL 100
 #ifdef MV64340_COAL
@@ -89,58 +89,6 @@
  *
  */
 
-/* Default port configuration value */
-#define PORT_CONFIG_VALUE                       \
-             ETH_UNICAST_NORMAL_MODE		|   \
-             ETH_DEFAULT_RX_QUEUE_0		|   \
-             ETH_DEFAULT_RX_ARP_QUEUE_0		|   \
-             ETH_RECEIVE_BC_IF_NOT_IP_OR_ARP	|   \
-             ETH_RECEIVE_BC_IF_IP		|   \
-             ETH_RECEIVE_BC_IF_ARP 		|   \
-             ETH_CAPTURE_TCP_FRAMES_DIS		|   \
-             ETH_CAPTURE_UDP_FRAMES_DIS		|   \
-             ETH_DEFAULT_RX_TCP_QUEUE_0		|   \
-             ETH_DEFAULT_RX_UDP_QUEUE_0		|   \
-             ETH_DEFAULT_RX_BPDU_QUEUE_0
-
-/* Default port extend configuration value */
-#define PORT_CONFIG_EXTEND_VALUE		\
-             ETH_SPAN_BPDU_PACKETS_AS_NORMAL	|   \
-             ETH_PARTITION_DISABLE
-
-
-/* Default sdma control value */
-#define PORT_SDMA_CONFIG_VALUE			\
-			 ETH_RX_BURST_SIZE_16_64BIT 	|	\
-			 GT_ETH_IPG_INT_RX(0) 		|	\
-			 ETH_TX_BURST_SIZE_16_64BIT;
-
-#define GT_ETH_IPG_INT_RX(value)                \
-            ((value & 0x3fff) << 8)
-
-/* Default port serial control value */
-#define PORT_SERIAL_CONTROL_VALUE		\
-			ETH_FORCE_LINK_PASS 			|	\
-			ETH_ENABLE_AUTO_NEG_FOR_DUPLX		|	\
-			ETH_DISABLE_AUTO_NEG_FOR_FLOW_CTRL 	|	\
-			ETH_ADV_SYMMETRIC_FLOW_CTRL 		|	\
-			ETH_FORCE_FC_MODE_NO_PAUSE_DIS_TX 	|	\
-			ETH_FORCE_BP_MODE_NO_JAM 		|	\
-			BIT9 					|	\
-			ETH_DO_NOT_FORCE_LINK_FAIL 		|	\
-			ETH_RETRANSMIT_16_ATTEMPTS 		|	\
-			ETH_ENABLE_AUTO_NEG_SPEED_GMII	 	|	\
-			ETH_DTE_ADV_0 				|	\
-			ETH_DISABLE_AUTO_NEG_BYPASS		|	\
-			ETH_AUTO_NEG_NO_CHANGE 			|	\
-			ETH_MAX_RX_PACKET_9700BYTE 		|	\
-			ETH_CLR_EXT_LOOPBACK 			|	\
-			ETH_SET_FULL_DUPLEX_MODE 		|	\
-			ETH_ENABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX
-
-#define RX_BUFFER_MAX_SIZE  0x4000000
-#define TX_BUFFER_MAX_SIZE  0x4000000
-
 /* MAC accepet/reject macros */
 #define ACCEPT_MAC_ADDR	    0
 #define REJECT_MAC_ADDR	    1
@@ -207,156 +155,12 @@
 #define ETH_PORT_TX_FIFO_EMPTY                          BIT10
 
 
-/* These macros describes the Port configuration reg (Px_cR) bits */
-#define ETH_UNICAST_NORMAL_MODE                         0
-#define ETH_UNICAST_PROMISCUOUS_MODE                    BIT0
-#define ETH_DEFAULT_RX_QUEUE_0                          0
-#define ETH_DEFAULT_RX_QUEUE_1                          BIT1
-#define ETH_DEFAULT_RX_QUEUE_2                          BIT2
-#define ETH_DEFAULT_RX_QUEUE_3                          (BIT2 | BIT1)
-#define ETH_DEFAULT_RX_QUEUE_4                          BIT3
-#define ETH_DEFAULT_RX_QUEUE_5                          (BIT3 | BIT1)
-#define ETH_DEFAULT_RX_QUEUE_6                          (BIT3 | BIT2)
-#define ETH_DEFAULT_RX_QUEUE_7                          (BIT3 | BIT2 | BIT1)
-#define ETH_DEFAULT_RX_ARP_QUEUE_0                      0
-#define ETH_DEFAULT_RX_ARP_QUEUE_1                      BIT4
-#define ETH_DEFAULT_RX_ARP_QUEUE_2                      BIT5
-#define ETH_DEFAULT_RX_ARP_QUEUE_3                      (BIT5 | BIT4)
-#define ETH_DEFAULT_RX_ARP_QUEUE_4                      BIT6
-#define ETH_DEFAULT_RX_ARP_QUEUE_5                      (BIT6 | BIT4)
-#define ETH_DEFAULT_RX_ARP_QUEUE_6                      (BIT6 | BIT5)
-#define ETH_DEFAULT_RX_ARP_QUEUE_7                      (BIT6 | BIT5 | BIT4)
-#define ETH_RECEIVE_BC_IF_NOT_IP_OR_ARP                 0
-#define ETH_REJECT_BC_IF_NOT_IP_OR_ARP                  BIT7
-#define ETH_RECEIVE_BC_IF_IP                            0
-#define ETH_REJECT_BC_IF_IP                             BIT8
-#define ETH_RECEIVE_BC_IF_ARP                           0
-#define ETH_REJECT_BC_IF_ARP                            BIT9
-#define ETH_TX_AM_NO_UPDATE_ERROR_SUMMARY               BIT12
-#define ETH_CAPTURE_TCP_FRAMES_DIS                      0
-#define ETH_CAPTURE_TCP_FRAMES_EN                       BIT14
-#define ETH_CAPTURE_UDP_FRAMES_DIS                      0
-#define ETH_CAPTURE_UDP_FRAMES_EN                       BIT15
-#define ETH_DEFAULT_RX_TCP_QUEUE_0                      0
-#define ETH_DEFAULT_RX_TCP_QUEUE_1                      BIT16
-#define ETH_DEFAULT_RX_TCP_QUEUE_2                      BIT17
-#define ETH_DEFAULT_RX_TCP_QUEUE_3                      (BIT17 | BIT16)
-#define ETH_DEFAULT_RX_TCP_QUEUE_4                      BIT18
-#define ETH_DEFAULT_RX_TCP_QUEUE_5                      (BIT18 | BIT16)
-#define ETH_DEFAULT_RX_TCP_QUEUE_6                      (BIT18 | BIT17)
-#define ETH_DEFAULT_RX_TCP_QUEUE_7                      (BIT18 | BIT17 | BIT16)
-#define ETH_DEFAULT_RX_UDP_QUEUE_0                      0
-#define ETH_DEFAULT_RX_UDP_QUEUE_1                      BIT19
-#define ETH_DEFAULT_RX_UDP_QUEUE_2                      BIT20
-#define ETH_DEFAULT_RX_UDP_QUEUE_3                      (BIT20 | BIT19)
-#define ETH_DEFAULT_RX_UDP_QUEUE_4                      (BIT21
-#define ETH_DEFAULT_RX_UDP_QUEUE_5                      (BIT21 | BIT19)
-#define ETH_DEFAULT_RX_UDP_QUEUE_6                      (BIT21 | BIT20)
-#define ETH_DEFAULT_RX_UDP_QUEUE_7                      (BIT21 | BIT20 | BIT19)
-#define ETH_DEFAULT_RX_BPDU_QUEUE_0                      0
-#define ETH_DEFAULT_RX_BPDU_QUEUE_1                     BIT22
-#define ETH_DEFAULT_RX_BPDU_QUEUE_2                     BIT23
 #define ETH_DEFAULT_RX_BPDU_QUEUE_3                     (BIT23 | BIT22)
 #define ETH_DEFAULT_RX_BPDU_QUEUE_4                     BIT24
 #define ETH_DEFAULT_RX_BPDU_QUEUE_5                     (BIT24 | BIT22)
 #define ETH_DEFAULT_RX_BPDU_QUEUE_6                     (BIT24 | BIT23)
 #define ETH_DEFAULT_RX_BPDU_QUEUE_7                     (BIT24 | BIT23 | BIT22)
 
-
-/* These macros describes the Port configuration extend reg (Px_cXR) bits*/
-#define ETH_CLASSIFY_EN                                 BIT0
-#define ETH_SPAN_BPDU_PACKETS_AS_NORMAL                 0
-#define ETH_SPAN_BPDU_PACKETS_TO_RX_QUEUE_7             BIT1
-#define ETH_PARTITION_DISABLE                           0
-#define ETH_PARTITION_ENABLE                            BIT2
-
-
-/* Tx/Rx queue command reg (RQCR/TQCR)*/
-#define ETH_QUEUE_0_ENABLE                              BIT0
-#define ETH_QUEUE_1_ENABLE                              BIT1
-#define ETH_QUEUE_2_ENABLE                              BIT2
-#define ETH_QUEUE_3_ENABLE                              BIT3
-#define ETH_QUEUE_4_ENABLE                              BIT4
-#define ETH_QUEUE_5_ENABLE                              BIT5
-#define ETH_QUEUE_6_ENABLE                              BIT6
-#define ETH_QUEUE_7_ENABLE                              BIT7
-#define ETH_QUEUE_0_DISABLE                             BIT8
-#define ETH_QUEUE_1_DISABLE                             BIT9
-#define ETH_QUEUE_2_DISABLE                             BIT10
-#define ETH_QUEUE_3_DISABLE                             BIT11
-#define ETH_QUEUE_4_DISABLE                             BIT12
-#define ETH_QUEUE_5_DISABLE                             BIT13
-#define ETH_QUEUE_6_DISABLE                             BIT14
-#define ETH_QUEUE_7_DISABLE                             BIT15
-
-
-/* These macros describes the Port Sdma configuration reg (SDCR) bits */
-#define ETH_RIFB                                        BIT0
-#define ETH_RX_BURST_SIZE_1_64BIT                       0
-#define ETH_RX_BURST_SIZE_2_64BIT                       BIT1
-#define ETH_RX_BURST_SIZE_4_64BIT                       BIT2
-#define ETH_RX_BURST_SIZE_8_64BIT                       (BIT2 | BIT1)
-#define ETH_RX_BURST_SIZE_16_64BIT                      BIT3
-#define ETH_BLM_RX_NO_SWAP                              BIT4
-#define ETH_BLM_RX_BYTE_SWAP                            0
-#define ETH_BLM_TX_NO_SWAP                              BIT5
-#define ETH_BLM_TX_BYTE_SWAP                            0
-#define ETH_DESCRIPTORS_BYTE_SWAP                       BIT6
-#define ETH_DESCRIPTORS_NO_SWAP                         0
-#define ETH_TX_BURST_SIZE_1_64BIT                       0
-#define ETH_TX_BURST_SIZE_2_64BIT                       BIT22
-#define ETH_TX_BURST_SIZE_4_64BIT                       BIT23
-#define ETH_TX_BURST_SIZE_8_64BIT                       (BIT23 | BIT22)
-#define ETH_TX_BURST_SIZE_16_64BIT                      BIT24
-
-
-
-/* These macros describes the Port serial control reg (PSCR) bits */
-#define ETH_SERIAL_PORT_DISABLE                         0
-#define ETH_SERIAL_PORT_ENABLE                          BIT0
-#define ETH_FORCE_LINK_PASS                             BIT1
-#define ETH_DO_NOT_FORCE_LINK_PASS                      0
-#define ETH_ENABLE_AUTO_NEG_FOR_DUPLX                   0
-#define ETH_DISABLE_AUTO_NEG_FOR_DUPLX                  BIT2
-#define ETH_ENABLE_AUTO_NEG_FOR_FLOW_CTRL               0
-#define ETH_DISABLE_AUTO_NEG_FOR_FLOW_CTRL              BIT3
-#define ETH_ADV_NO_FLOW_CTRL                            0
-#define ETH_ADV_SYMMETRIC_FLOW_CTRL                     BIT4
-#define ETH_FORCE_FC_MODE_NO_PAUSE_DIS_TX               0
-#define ETH_FORCE_FC_MODE_TX_PAUSE_DIS                  BIT5
-#define ETH_FORCE_BP_MODE_NO_JAM                        0
-#define ETH_FORCE_BP_MODE_JAM_TX                        BIT7
-#define ETH_FORCE_BP_MODE_JAM_TX_ON_RX_ERR              BIT8
-#define ETH_FORCE_LINK_FAIL                             0
-#define ETH_DO_NOT_FORCE_LINK_FAIL                      BIT10
-#define ETH_RETRANSMIT_16_ATTEMPTS                      0
-#define ETH_RETRANSMIT_FOREVER                          BIT11
-#define ETH_DISABLE_AUTO_NEG_SPEED_GMII                 BIT13
-#define ETH_ENABLE_AUTO_NEG_SPEED_GMII                  0
-#define ETH_DTE_ADV_0                                   0
-#define ETH_DTE_ADV_1                                   BIT14
-#define ETH_DISABLE_AUTO_NEG_BYPASS                     0
-#define ETH_ENABLE_AUTO_NEG_BYPASS                      BIT15
-#define ETH_AUTO_NEG_NO_CHANGE                          0
-#define ETH_RESTART_AUTO_NEG                            BIT16
-#define ETH_MAX_RX_PACKET_1518BYTE                      0
-#define ETH_MAX_RX_PACKET_1522BYTE                      BIT17
-#define ETH_MAX_RX_PACKET_1552BYTE                      BIT18
-#define ETH_MAX_RX_PACKET_9022BYTE                      (BIT18 | BIT17)
-#define ETH_MAX_RX_PACKET_9192BYTE                      BIT19
-#define ETH_MAX_RX_PACKET_9700BYTE                      (BIT19 | BIT17)
-#define ETH_SET_EXT_LOOPBACK                            BIT20
-#define ETH_CLR_EXT_LOOPBACK                            0
-#define ETH_SET_FULL_DUPLEX_MODE                        BIT21
-#define ETH_SET_HALF_DUPLEX_MODE                        0
-#define ETH_ENABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX       BIT22
-#define ETH_DISABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX      0
-#define ETH_SET_GMII_SPEED_TO_10_100                    0
-#define ETH_SET_GMII_SPEED_TO_1000                      BIT23
-#define ETH_SET_MII_SPEED_TO_10                         0
-#define ETH_SET_MII_SPEED_TO_100                        BIT24
-
-
 /* SMI reg */
 #define ETH_SMI_BUSY        	BIT28	/* 0 - Write, 1 - Read          */
 #define ETH_SMI_READ_VALID  	BIT27	/* 0 - Write, 1 - Read          */
@@ -495,6 +299,11 @@
 	u32	port_tx_queue_command;	/* Port active Tx queues summary */
 	u32	port_rx_queue_command;	/* Port active Rx queues summary */
 
+	u32	rx_sram_addr;		/* Base address of rx sram area	*/
+	u32	rx_sram_size;		/* Size of rx sram area		*/
+	u32	tx_sram_addr;		/* Base address of tx sram area	*/
+	u32	tx_sram_size;		/* Size of tx sram area		*/
+
 	int	rx_resource_err;	/* Rx ring resource error flag */
 	int	tx_resource_err;	/* Tx ring resource error flag */
 
@@ -517,12 +326,12 @@
 	struct eth_rx_desc		* p_rx_desc_area;
 	dma_addr_t			rx_desc_dma;
 	unsigned int			rx_desc_area_size;
-	struct sk_buff			* rx_skb[MV64340_RX_QUEUE_SIZE];
+	struct sk_buff			** rx_skb;
 
 	struct eth_tx_desc		* p_tx_desc_area;
 	dma_addr_t			tx_desc_dma;
 	unsigned int			tx_desc_area_size;
-	struct sk_buff			* tx_skb[MV64340_TX_QUEUE_SIZE];
+	struct sk_buff			** tx_skb;
 
 	struct work_struct		tx_timeout_task;
 
Index: linux-2.5-marvell-submit/include/linux/mv643xx.h
===================================================================
--- linux-2.5-marvell-submit.orig/include/linux/mv643xx.h	2004-12-13 14:30:39.868524173 -0700
+++ linux-2.5-marvell-submit/include/linux/mv643xx.h	2004-12-13 14:30:44.086709974 -0700
@@ -1043,13 +1043,207 @@
 
 extern void mv64340_irq_init(unsigned int base);
 
+/* These macros describe Ethernet Port configuration reg (Px_cR) bits */
+#define MV64340_ETH_UNICAST_NORMAL_MODE		0
+#define MV64340_ETH_UNICAST_PROMISCUOUS_MODE	(1<<0)
+#define MV64340_ETH_DEFAULT_RX_QUEUE_0		0
+#define MV64340_ETH_DEFAULT_RX_QUEUE_1		(1<<1)
+#define MV64340_ETH_DEFAULT_RX_QUEUE_2		(1<<2)
+#define MV64340_ETH_DEFAULT_RX_QUEUE_3		((1<<2) | (1<<1))
+#define MV64340_ETH_DEFAULT_RX_QUEUE_4		(1<<3)
+#define MV64340_ETH_DEFAULT_RX_QUEUE_5		((1<<3) | (1<<1))
+#define MV64340_ETH_DEFAULT_RX_QUEUE_6		((1<<3) | (1<<2))
+#define MV64340_ETH_DEFAULT_RX_QUEUE_7		((1<<3) | (1<<2) | (1<<1))
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_0	0
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_1	(1<<4)
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_2	(1<<5)
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_3	((1<<5) | (1<<4))
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_4	(1<<6)
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_5	((1<<6) | (1<<4))
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_6	((1<<6) | (1<<5))
+#define MV64340_ETH_DEFAULT_RX_ARP_QUEUE_7	((1<<6) | (1<<5) | (1<<4))
+#define MV64340_ETH_RECEIVE_BC_IF_NOT_IP_OR_ARP	0
+#define MV64340_ETH_REJECT_BC_IF_NOT_IP_OR_ARP	(1<<7)
+#define MV64340_ETH_RECEIVE_BC_IF_IP		0
+#define MV64340_ETH_REJECT_BC_IF_IP		(1<<8)
+#define MV64340_ETH_RECEIVE_BC_IF_ARP		0
+#define MV64340_ETH_REJECT_BC_IF_ARP		(1<<9)
+#define MV64340_ETH_TX_AM_NO_UPDATE_ERROR_SUMMARY (1<<12)
+#define MV64340_ETH_CAPTURE_TCP_FRAMES_DIS	0
+#define MV64340_ETH_CAPTURE_TCP_FRAMES_EN	(1<<14)
+#define MV64340_ETH_CAPTURE_UDP_FRAMES_DIS	0
+#define MV64340_ETH_CAPTURE_UDP_FRAMES_EN	(1<<15)
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_0	0
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_1	(1<<16)
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_2	(1<<17)
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_3	((1<<17) | (1<<16))
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_4	(1<<18)
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_5	((1<<18) | (1<<16))
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_6	((1<<18) | (1<<17))
+#define MV64340_ETH_DEFAULT_RX_TCP_QUEUE_7	((1<<18) | (1<<17) | (1<<16))
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_0	0
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_1	(1<<19)
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_2	(1<<20)
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_3	((1<<20) | (1<<19))
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_4	((1<<21)
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_5	((1<<21) | (1<<19))
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_6	((1<<21) | (1<<20))
+#define MV64340_ETH_DEFAULT_RX_UDP_QUEUE_7	((1<<21) | (1<<20) | (1<<19))
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_0	0
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_1	(1<<22)
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_2	(1<<23)
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_3	((1<<23) | (1<<22))
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_4	(1<<24)
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_5	((1<<24) | (1<<22))
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_6	((1<<24) | (1<<23))
+#define MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_7	((1<<24) | (1<<23) | (1<<22))
+
+#define	MV64340_ETH_PORT_CONFIG_DEFAULT_VALUE			\
+		MV64340_ETH_UNICAST_NORMAL_MODE		|	\
+		MV64340_ETH_DEFAULT_RX_QUEUE_0		|	\
+		MV64340_ETH_DEFAULT_RX_ARP_QUEUE_0	|	\
+		MV64340_ETH_RECEIVE_BC_IF_NOT_IP_OR_ARP	|	\
+		MV64340_ETH_RECEIVE_BC_IF_IP		|	\
+		MV64340_ETH_RECEIVE_BC_IF_ARP		|	\
+		MV64340_ETH_CAPTURE_TCP_FRAMES_DIS	|	\
+		MV64340_ETH_CAPTURE_UDP_FRAMES_DIS	|	\
+		MV64340_ETH_DEFAULT_RX_TCP_QUEUE_0	|	\
+		MV64340_ETH_DEFAULT_RX_UDP_QUEUE_0	|	\
+		MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_0
+
+/* These macros describe Ethernet Port configuration extend reg (Px_cXR) bits*/
+#define MV64340_ETH_CLASSIFY_EN				(1<<0)
+#define MV64340_ETH_SPAN_BPDU_PACKETS_AS_NORMAL		0
+#define MV64340_ETH_SPAN_BPDU_PACKETS_TO_RX_QUEUE_7	(1<<1)
+#define MV64340_ETH_PARTITION_DISABLE			0
+#define MV64340_ETH_PARTITION_ENABLE			(1<<2)
+
+#define	MV64340_ETH_PORT_CONFIG_EXTEND_DEFAULT_VALUE		\
+		MV64340_ETH_SPAN_BPDU_PACKETS_AS_NORMAL	|	\
+		MV64340_ETH_PARTITION_DISABLE
+
+/* These macros describe Ethernet Port Sdma configuration reg (SDCR) bits */
+#define MV64340_ETH_RIFB			(1<<0)
+#define MV64340_ETH_RX_BURST_SIZE_1_64BIT		0
+#define MV64340_ETH_RX_BURST_SIZE_2_64BIT		(1<<1)
+#define MV64340_ETH_RX_BURST_SIZE_4_64BIT		(1<<2)
+#define MV64340_ETH_RX_BURST_SIZE_8_64BIT		((1<<2) | (1<<1))
+#define MV64340_ETH_RX_BURST_SIZE_16_64BIT		(1<<3)
+#define MV64340_ETH_BLM_RX_NO_SWAP			(1<<4)
+#define MV64340_ETH_BLM_RX_BYTE_SWAP			0
+#define MV64340_ETH_BLM_TX_NO_SWAP			(1<<5)
+#define MV64340_ETH_BLM_TX_BYTE_SWAP			0
+#define MV64340_ETH_DESCRIPTORS_BYTE_SWAP		(1<<6)
+#define MV64340_ETH_DESCRIPTORS_NO_SWAP			0
+#define MV64340_ETH_TX_BURST_SIZE_1_64BIT		0
+#define MV64340_ETH_TX_BURST_SIZE_2_64BIT		(1<<22)
+#define MV64340_ETH_TX_BURST_SIZE_4_64BIT		(1<<23)
+#define MV64340_ETH_TX_BURST_SIZE_8_64BIT		((1<<23) | (1<<22))
+#define MV64340_ETH_TX_BURST_SIZE_16_64BIT		(1<<24)
+
+#define	MV64340_ETH_IPG_INT_RX(value) ((value & 0x3fff) << 8)
+
+#define	MV64340_ETH_PORT_SDMA_CONFIG_DEFAULT_VALUE		\
+		MV64340_ETH_RX_BURST_SIZE_4_64BIT	|	\
+		MV64340_ETH_IPG_INT_RX(0)		|	\
+		MV64340_ETH_TX_BURST_SIZE_4_64BIT
+
+/* These macros describe Ethernet Port serial control reg (PSCR) bits */
+#define MV64340_ETH_SERIAL_PORT_DISABLE			0
+#define MV64340_ETH_SERIAL_PORT_ENABLE			(1<<0)
+#define MV64340_ETH_FORCE_LINK_PASS			(1<<1)
+#define MV64340_ETH_DO_NOT_FORCE_LINK_PASS		0
+#define MV64340_ETH_ENABLE_AUTO_NEG_FOR_DUPLX		0
+#define MV64340_ETH_DISABLE_AUTO_NEG_FOR_DUPLX		(1<<2)
+#define MV64340_ETH_ENABLE_AUTO_NEG_FOR_FLOW_CTRL	0
+#define MV64340_ETH_DISABLE_AUTO_NEG_FOR_FLOW_CTRL	(1<<3)
+#define MV64340_ETH_ADV_NO_FLOW_CTRL			0
+#define MV64340_ETH_ADV_SYMMETRIC_FLOW_CTRL		(1<<4)
+#define MV64340_ETH_FORCE_FC_MODE_NO_PAUSE_DIS_TX	0
+#define MV64340_ETH_FORCE_FC_MODE_TX_PAUSE_DIS		(1<<5)
+#define MV64340_ETH_FORCE_BP_MODE_NO_JAM		0
+#define MV64340_ETH_FORCE_BP_MODE_JAM_TX		(1<<7)
+#define MV64340_ETH_FORCE_BP_MODE_JAM_TX_ON_RX_ERR	(1<<8)
+#define MV64340_ETH_FORCE_LINK_FAIL			0
+#define MV64340_ETH_DO_NOT_FORCE_LINK_FAIL		(1<<10)
+#define MV64340_ETH_RETRANSMIT_16_ATTEMPTS		0
+#define MV64340_ETH_RETRANSMIT_FOREVER			(1<<11)
+#define MV64340_ETH_DISABLE_AUTO_NEG_SPEED_GMII		(1<<13)
+#define MV64340_ETH_ENABLE_AUTO_NEG_SPEED_GMII		0
+#define MV64340_ETH_DTE_ADV_0				0
+#define MV64340_ETH_DTE_ADV_1				(1<<14)
+#define MV64340_ETH_DISABLE_AUTO_NEG_BYPASS		0
+#define MV64340_ETH_ENABLE_AUTO_NEG_BYPASS		(1<<15)
+#define MV64340_ETH_AUTO_NEG_NO_CHANGE			0
+#define MV64340_ETH_RESTART_AUTO_NEG			(1<<16)
+#define MV64340_ETH_MAX_RX_PACKET_1518BYTE		0
+#define MV64340_ETH_MAX_RX_PACKET_1522BYTE		(1<<17)
+#define MV64340_ETH_MAX_RX_PACKET_1552BYTE		(1<<18)
+#define MV64340_ETH_MAX_RX_PACKET_9022BYTE		((1<<18) | (1<<17))
+#define MV64340_ETH_MAX_RX_PACKET_9192BYTE		(1<<19)
+#define MV64340_ETH_MAX_RX_PACKET_9700BYTE		((1<<19) | (1<<17))
+#define MV64340_ETH_SET_EXT_LOOPBACK			(1<<20)
+#define MV64340_ETH_CLR_EXT_LOOPBACK			0
+#define MV64340_ETH_SET_FULL_DUPLEX_MODE		(1<<21)
+#define MV64340_ETH_SET_HALF_DUPLEX_MODE		0
+#define MV64340_ETH_ENABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX (1<<22)
+#define MV64340_ETH_DISABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX 0
+#define MV64340_ETH_SET_GMII_SPEED_TO_10_100		0
+#define MV64340_ETH_SET_GMII_SPEED_TO_1000		(1<<23)
+#define MV64340_ETH_SET_MII_SPEED_TO_10			0
+#define MV64340_ETH_SET_MII_SPEED_TO_100		(1<<24)
+
+#define	MV64340_ETH_PORT_SERIAL_CONTROL_DEFAULT_VALUE		\
+		MV64340_ETH_DO_NOT_FORCE_LINK_PASS	|	\
+		MV64340_ETH_ENABLE_AUTO_NEG_FOR_DUPLX	|	\
+		MV64340_ETH_DISABLE_AUTO_NEG_FOR_FLOW_CTRL |	\
+		MV64340_ETH_ADV_SYMMETRIC_FLOW_CTRL	|	\
+		MV64340_ETH_FORCE_FC_MODE_NO_PAUSE_DIS_TX |	\
+		MV64340_ETH_FORCE_BP_MODE_NO_JAM	|	\
+		(1<<9)	/* reserved */			|	\
+		MV64340_ETH_DO_NOT_FORCE_LINK_FAIL	|	\
+		MV64340_ETH_RETRANSMIT_16_ATTEMPTS	|	\
+		MV64340_ETH_ENABLE_AUTO_NEG_SPEED_GMII	|	\
+		MV64340_ETH_DTE_ADV_0			|	\
+		MV64340_ETH_DISABLE_AUTO_NEG_BYPASS	|	\
+		MV64340_ETH_AUTO_NEG_NO_CHANGE		|	\
+		MV64340_ETH_MAX_RX_PACKET_9700BYTE	|	\
+		MV64340_ETH_CLR_EXT_LOOPBACK		|	\
+		MV64340_ETH_SET_FULL_DUPLEX_MODE	|	\
+		MV64340_ETH_ENABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX
+
+#define	MV64340_ETH_PORT_DEFAULT_TRANSMIT_QUEUE_SIZE	800
+#define	MV64340_ETH_PORT_DEFAULT_RECEIVE_QUEUE_SIZE	400
+
 #define MV64340_ETH_DESC_SIZE				64
 
 #define MV64XXX_ETH_SHARED_NAME	"mv64xxx_eth_shared"
 #define MV64XXX_ETH_NAME	"mv64xxx_eth"
 
 struct mv64xxx_eth_platform_data {
-	char	*mac_addr;	/* pointer to mac address */
+	/* 
+	 * Non-values for mac_addr, phy_addr, port_config, etc.
+	 * override the default value.  Setting the corresponding
+	 * force_* field, causes the default value to be overridden
+	 * even when zero.
+	 */
+	unsigned int	force_phy_addr:1;
+	unsigned int	force_port_config:1;
+	unsigned int	force_port_config_extend:1;
+	unsigned int	force_port_sdma_config:1;
+	unsigned int	force_port_serial_control:1;
+	int		phy_addr;
+	char		*mac_addr;	/* pointer to mac address */
+	u32		port_config;
+	u32		port_config_extend;
+	u32		port_sdma_config;
+	u32		port_serial_control;
+	u32		tx_queue_size;
+	u32		rx_queue_size;
+	u32		tx_sram_addr;
+	u32		tx_sram_size;
+	u32		rx_sram_addr;
+	u32		rx_sram_size;
 };
 
 #endif /* __ASM_MV64340_H */
