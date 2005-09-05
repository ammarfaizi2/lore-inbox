Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVIEWrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVIEWrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 18:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVIEWrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 18:47:19 -0400
Received: from havoc.gtf.org ([69.61.125.42]:19079 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964904AbVIEWrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 18:47:13 -0400
Date: Mon, 5 Sep 2005 18:47:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20050905224708.GA1607@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the following changes:


 drivers/net/Kconfig                   |    9 
 drivers/net/chelsio/common.h          |    4 
 drivers/net/chelsio/cxgb2.c           |    2 
 drivers/net/e1000/e1000_hw.h          |    2 
 drivers/net/mv643xx_eth.c             |  139 +---
 drivers/net/mv643xx_eth.h             |    4 
 drivers/net/ne3210.c                  |    9 
 drivers/net/phy/Kconfig               |    2 
 drivers/net/phy/mdio_bus.c            |    2 
 drivers/net/s2io.c                    |   14 
 drivers/net/sis190.c                  |  131 ++-
 drivers/net/tulip/uli526x.c           |    2 
 drivers/net/wireless/Kconfig          |   38 -
 drivers/net/wireless/Makefile         |    2 
 drivers/net/wireless/ipw2100.c        |   69 +-
 drivers/net/wireless/ipw2200.h        |    1 
 drivers/net/wireless/orinoco.c        |   93 +-
 drivers/net/wireless/orinoco_cs.c     |    1 
 drivers/net/wireless/orinoco_nortel.c |  324 +++++++++
 drivers/net/wireless/spectrum_cs.c    | 1120 ++++++++++++++++++++++++++++++++++
 net/core/ethtool.c                    |    2 
 21 files changed, 1736 insertions(+), 234 deletions(-)



Adrian Bunk:
  drivers/net/ne3210.c: cleanups

Al Viro:
  (15/22) Kconfig fix (82596)

Dale Farnsworth:
  mv643xx: fix skb memory leak
  mv643xx: fix outstanding tx skb counter
  mv643xx: Disable per port bandwidth limits
  mv643xx: Fix promiscuous mode handling
  mv643xx: add netpoll api support

Francois Romieu:
  sis190: unmask the link change events
  sis190: recent chipsets from SiS include a RGMII
  sis190: make 10Mbps the default when handling the StationControl register
  sis190: RGMII Tx internal delay fiddling
  sis190: basic sis191 support

Pavel Roskin:
  orinoco: Change orinoco_translate_scan() to return error code on error.
  orinoco: Remove entry for Intel PRO/Wireless 2011B.
  orinoco: Fix memory leak on error in processing hostscan frames.
  orinoco: Optimize orinoco_join_ap()
  orinoco: Remove EXPERIMENTAL mark from PLX_HERMES, TMD_HERMES and PCI_HERMES.
  orinoco: New driver - orinoco_nortel.
  orinoco: New driver - spectrum_cs.

Peter Chubb:
  'mdio_bus_exit' in discarded section .text.exit

viro@ftp.linux.org.uk:
  (1/7) chelsio sparse annotations
  (2/7) iomem annotations (e1000)
  (3/7) iomem annotations (s2io)
  (4/7) missing include (uli526x)
  (5/7) iomem annotations, NULL noise removal (ipw2100)
  (6/7) missing include (ipw2200)
  (7/7) __user annotations (ethtool)

viro@ZenIV.linux.org.uk:
  Kconfig fix (PHYLIB vs. s390)




diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -397,7 +397,7 @@ config SUN3LANCE
 	  If you're not building a kernel for a Sun 3, say N.
 
 config SUN3_82586
-	tristate "Sun3 on-board Intel 82586 support"
+	bool "Sun3 on-board Intel 82586 support"
 	depends on NET_ETHERNET && SUN3
 	help
 	  This driver enables support for the on-board Intel 82586 based
@@ -1924,12 +1924,15 @@ config R8169_VLAN
 	  If in doubt, say Y.
 
 config SIS190
-	tristate "SiS190 gigabit ethernet support"
+	tristate "SiS190/SiS191 gigabit ethernet support"
 	depends on PCI
 	select CRC32
 	select MII
 	---help---
-	  Say Y here if you have a SiS 190 PCI Gigabit Ethernet adapter.
+	  Say Y here if you have a SiS 190 PCI Fast Ethernet adapter or
+	  a SiS 191 PCI Gigabit Ethernet adapter. Both are expected to
+	  appear in lan on motherboard designs which are based on SiS 965
+	  and SiS 966 south bridge.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called sis190.  This is recommended.
diff --git a/drivers/net/chelsio/common.h b/drivers/net/chelsio/common.h
--- a/drivers/net/chelsio/common.h
+++ b/drivers/net/chelsio/common.h
@@ -88,7 +88,7 @@ struct t1_rx_mode {
 
 static inline u8 *t1_get_next_mcaddr(struct t1_rx_mode *rm)
 {
-	u8 *addr = 0;
+	u8 *addr = NULL;
 
 	if (rm->idx++ < rm->dev->mc_count) {
 		addr = rm->list->dmi_addr;
@@ -190,7 +190,7 @@ struct sge;
 struct peespi;
 
 struct adapter {
-	u8 *regs;
+	u8 __iomem *regs;
 	struct pci_dev *pdev;
 	unsigned long registered_device_map;
 	unsigned long open_device_map;
diff --git a/drivers/net/chelsio/cxgb2.c b/drivers/net/chelsio/cxgb2.c
--- a/drivers/net/chelsio/cxgb2.c
+++ b/drivers/net/chelsio/cxgb2.c
@@ -824,7 +824,7 @@ static void cxgb_proc_cleanup(struct ada
 static int t1_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
 {
         struct adapter *adapter = dev->priv;
-        struct mii_ioctl_data *data = (struct mii_ioctl_data *)&req->ifr_data;
+        struct mii_ioctl_data *data = if_mii(req);
 
 	switch (cmd) {
         case SIOCGMIIPHY:
diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -1270,7 +1270,7 @@ struct e1000_hw_stats {
 
 /* Structure containing variables used by the shared code (e1000_hw.c) */
 struct e1000_hw {
-    uint8_t *hw_addr;
+    uint8_t __iomem *hw_addr;
     uint8_t *flash_address;
     e1000_mac_type mac_type;
     e1000_phy_type phy_type;
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -58,11 +58,10 @@
 
 #define INT_CAUSE_UNMASK_ALL		0x0007ffff
 #define INT_CAUSE_UNMASK_ALL_EXT	0x0011ffff
-#ifdef MV643XX_RX_QUEUE_FILL_ON_TASK
 #define INT_CAUSE_MASK_ALL		0x00000000
+#define INT_CAUSE_MASK_ALL_EXT		0x00000000
 #define INT_CAUSE_CHECK_BITS		INT_CAUSE_UNMASK_ALL
 #define INT_CAUSE_CHECK_BITS_EXT	INT_CAUSE_UNMASK_ALL_EXT
-#endif
 
 #ifdef MV643XX_CHECKSUM_OFFLOAD_TX
 #define MAX_DESCS_PER_SKB	(MAX_SKB_FRAGS + 1)
@@ -259,14 +258,13 @@ static void mv643xx_eth_update_mac_addre
 static void mv643xx_eth_set_rx_mode(struct net_device *dev)
 {
 	struct mv643xx_private *mp = netdev_priv(dev);
-	u32 config_reg;
 
-	config_reg = ethernet_get_config_reg(mp->port_num);
 	if (dev->flags & IFF_PROMISC)
-		config_reg |= (u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
+		mp->port_config |= (u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
 	else
-		config_reg &= ~(u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
-	ethernet_set_config_reg(mp->port_num, config_reg);
+		mp->port_config &= ~(u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
+
+	mv_write(MV643XX_ETH_PORT_CONFIG_REG(mp->port_num), mp->port_config);
 }
 
 /*
@@ -369,15 +367,6 @@ static int mv643xx_eth_free_tx_queue(str
 
 			dev_kfree_skb_irq(pkt_info.return_info);
 			released = 0;
-
-			/*
-			 * Decrement the number of outstanding skbs counter on
-			 * the TX queue.
-			 */
-			if (mp->tx_ring_skbs == 0)
-				panic("ERROR - TX outstanding SKBs"
-						" counter is corrupted");
-			mp->tx_ring_skbs--;
 		} else
 			dma_unmap_page(NULL, pkt_info.buf_ptr,
 					pkt_info.byte_cnt, DMA_TO_DEVICE);
@@ -412,15 +401,13 @@ static int mv643xx_eth_receive_queue(str
 	struct pkt_info pkt_info;
 
 #ifdef MV643XX_NAPI
-	while (eth_port_receive(mp, &pkt_info) == ETH_OK && budget > 0) {
+	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
 #else
 	while (eth_port_receive(mp, &pkt_info) == ETH_OK) {
 #endif
 		mp->rx_ring_skbs--;
 		received_packets++;
-#ifdef MV643XX_NAPI
-		budget--;
-#endif
+
 		/* Update statistics. Note byte count includes 4 byte CRC count */
 		stats->rx_packets++;
 		stats->rx_bytes += pkt_info.byte_cnt;
@@ -1044,9 +1031,6 @@ static void mv643xx_tx(struct net_device
 						DMA_TO_DEVICE);
 
 			dev_kfree_skb_irq(pkt_info.return_info);
-
-			if (mp->tx_ring_skbs)
-				mp->tx_ring_skbs--;
 		} else
 			dma_unmap_page(NULL, pkt_info.buf_ptr,
 					pkt_info.byte_cnt, DMA_TO_DEVICE);
@@ -1189,7 +1173,6 @@ linear:
 		pkt_info.buf_ptr = dma_map_single(NULL, skb->data, skb->len,
 							DMA_TO_DEVICE);
 		pkt_info.return_info = skb;
-		mp->tx_ring_skbs++;
 		status = eth_port_send(mp, &pkt_info);
 		if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
 			printk(KERN_ERR "%s: Error on transmitting packet\n",
@@ -1274,7 +1257,6 @@ linear:
 				pkt_info.cmd_sts |= ETH_TX_ENABLE_INTERRUPT |
 							ETH_TX_LAST_DESC;
 				pkt_info.return_info = skb;
-				mp->tx_ring_skbs++;
 			} else {
 				pkt_info.return_info = 0;
 			}
@@ -1311,7 +1293,6 @@ linear:
 	pkt_info.buf_ptr = dma_map_single(NULL, skb->data, skb->len,
 								DMA_TO_DEVICE);
 	pkt_info.return_info = skb;
-	mp->tx_ring_skbs++;
 	status = eth_port_send(mp, &pkt_info);
 	if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
 		printk(KERN_ERR "%s: Error on transmitting packet\n",
@@ -1356,6 +1337,43 @@ static struct net_device_stats *mv643xx_
 	return &mp->stats;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static inline void mv643xx_enable_irq(struct mv643xx_private *mp)
+{
+	int port_num = mp->port_num;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mp->lock, flags);
+	mv_write(MV643XX_ETH_INTERRUPT_MASK_REG(port_num),
+					INT_CAUSE_UNMASK_ALL);
+	mv_write(MV643XX_ETH_INTERRUPT_EXTEND_MASK_REG(port_num),
+					INT_CAUSE_UNMASK_ALL_EXT);
+	spin_unlock_irqrestore(&mp->lock, flags);
+}
+
+static inline void mv643xx_disable_irq(struct mv643xx_private *mp)
+{
+	int port_num = mp->port_num;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mp->lock, flags);
+	mv_write(MV643XX_ETH_INTERRUPT_MASK_REG(port_num),
+					INT_CAUSE_MASK_ALL);
+	mv_write(MV643XX_ETH_INTERRUPT_EXTEND_MASK_REG(port_num),
+					INT_CAUSE_MASK_ALL_EXT);
+	spin_unlock_irqrestore(&mp->lock, flags);
+}
+
+static void mv643xx_netpoll(struct net_device *netdev)
+{
+	struct mv643xx_private *mp = netdev_priv(netdev);
+
+	mv643xx_disable_irq(mp);
+	mv643xx_eth_int_handler(netdev->irq, netdev, NULL);
+	mv643xx_enable_irq(mp);
+}
+#endif
+
 /*/
  * mv643xx_eth_probe
  *
@@ -1406,6 +1424,10 @@ static int mv643xx_eth_probe(struct devi
 	dev->weight = 64;
 #endif
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = mv643xx_netpoll;
+#endif
+
 	dev->watchdog_timeo = 2 * HZ;
 	dev->tx_queue_len = mp->tx_ring_size;
 	dev->base_addr = 0;
@@ -1883,6 +1905,9 @@ static void eth_port_start(struct mv643x
 	/* Enable port Rx. */
 	mv_write(MV643XX_ETH_RECEIVE_QUEUE_COMMAND_REG(port_num),
 						mp->port_rx_queue_command);
+
+	/* Disable port bandwidth limits by clearing MTU register */
+	mv_write(MV643XX_ETH_MAXIMUM_TRANSMIT_UNIT(port_num), 0);
 }
 
 /*
@@ -2292,34 +2317,6 @@ static void eth_port_reset(unsigned int 
 	mv_write(MV643XX_ETH_PORT_SERIAL_CONTROL_REG(port_num), reg_data);
 }
 
-/*
- * ethernet_set_config_reg - Set specified bits in configuration register.
- *
- * DESCRIPTION:
- *	This function sets specified bits in the given ethernet
- *	configuration register.
- *
- * INPUT:
- *	unsigned int	eth_port_num	Ethernet Port number.
- *	unsigned int	value		32 bit value.
- *
- * OUTPUT:
- *	The set bits in the value parameter are set in the configuration
- *	register.
- *
- * RETURN:
- *	None.
- *
- */
-static void ethernet_set_config_reg(unsigned int eth_port_num,
-							unsigned int value)
-{
-	unsigned int eth_config_reg;
-
-	eth_config_reg = mv_read(MV643XX_ETH_PORT_CONFIG_REG(eth_port_num));
-	eth_config_reg |= value;
-	mv_write(MV643XX_ETH_PORT_CONFIG_REG(eth_port_num), eth_config_reg);
-}
 
 static int eth_port_autoneg_supported(unsigned int eth_port_num)
 {
@@ -2346,31 +2343,6 @@ static int eth_port_link_is_up(unsigned 
 }
 
 /*
- * ethernet_get_config_reg - Get the port configuration register
- *
- * DESCRIPTION:
- *	This function returns the configuration register value of the given
- *	ethernet port.
- *
- * INPUT:
- *	unsigned int	eth_port_num	Ethernet Port number.
- *
- * OUTPUT:
- *	None.
- *
- * RETURN:
- *	Port configuration register value.
- */
-static unsigned int ethernet_get_config_reg(unsigned int eth_port_num)
-{
-	unsigned int eth_config_reg;
-
-	eth_config_reg = mv_read(MV643XX_ETH_PORT_CONFIG_EXTEND_REG
-								(eth_port_num));
-	return eth_config_reg;
-}
-
-/*
  * eth_port_read_smi_reg - Read PHY registers
  *
  * DESCRIPTION:
@@ -2528,6 +2500,9 @@ static ETH_FUNC_RET_STATUS eth_port_send
 		return ETH_ERROR;
 	}
 
+	mp->tx_ring_skbs++;
+	BUG_ON(mp->tx_ring_skbs > mp->tx_ring_size);
+
 	/* Get the Tx Desc ring indexes */
 	tx_desc_curr = mp->tx_curr_desc_q;
 	tx_desc_used = mp->tx_used_desc_q;
@@ -2594,6 +2569,9 @@ static ETH_FUNC_RET_STATUS eth_port_send
 	if (mp->tx_resource_err)
 		return ETH_QUEUE_FULL;
 
+	mp->tx_ring_skbs++;
+	BUG_ON(mp->tx_ring_skbs > mp->tx_ring_size);
+
 	/* Get the Tx Desc ring indexes */
 	tx_desc_curr = mp->tx_curr_desc_q;
 	tx_desc_used = mp->tx_used_desc_q;
@@ -2694,6 +2672,9 @@ static ETH_FUNC_RET_STATUS eth_tx_return
 	/* Any Tx return cancels the Tx resource error status */
 	mp->tx_resource_err = 0;
 
+	BUG_ON(mp->tx_ring_skbs == 0);
+	mp->tx_ring_skbs--;
+
 	return ETH_OK;
 }
 
diff --git a/drivers/net/mv643xx_eth.h b/drivers/net/mv643xx_eth.h
--- a/drivers/net/mv643xx_eth.h
+++ b/drivers/net/mv643xx_eth.h
@@ -408,10 +408,6 @@ static void eth_port_init(struct mv643xx
 static void eth_port_reset(unsigned int eth_port_num);
 static void eth_port_start(struct mv643xx_private *mp);
 
-static void ethernet_set_config_reg(unsigned int eth_port_num,
-				    unsigned int value);
-static unsigned int ethernet_get_config_reg(unsigned int eth_port_num);
-
 /* Port MAC address routines */
 static void eth_port_uc_addr_set(unsigned int eth_port_num,
 				 unsigned char *p_addr);
diff --git a/drivers/net/ne3210.c b/drivers/net/ne3210.c
--- a/drivers/net/ne3210.c
+++ b/drivers/net/ne3210.c
@@ -26,9 +26,6 @@
 	Updated to EISA probing API 5/2003 by Marc Zyngier.
 */
 
-static const char *version =
-	"ne3210.c: Driver revision v0.03, 30/09/98\n";
-
 #include <linux/module.h>
 #include <linux/eisa.h>
 #include <linux/kernel.h>
@@ -197,7 +194,7 @@ static int __init ne3210_eisa_probe (str
 	ei_status.priv = phys_mem;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk("ne3210 loaded.\n");
 
 	ei_status.reset_8390 = &ne3210_reset_8390;
 	ei_status.block_input = &ne3210_block_input;
@@ -360,12 +357,12 @@ MODULE_DESCRIPTION("NE3210 EISA Ethernet
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(eisa, ne3210_ids);
 
-int ne3210_init(void)
+static int ne3210_init(void)
 {
 	return eisa_driver_register (&ne3210_eisa_driver);
 }
 
-void ne3210_cleanup(void)
+static void ne3210_cleanup(void)
 {
 	eisa_driver_unregister (&ne3210_eisa_driver);
 }
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -6,7 +6,7 @@ menu "PHY device support"
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (BROKEN || !ARCH_S390)
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -170,7 +170,7 @@ int __init mdio_bus_init(void)
 	return bus_register(&mdio_bus_type);
 }
 
-void __exit mdio_bus_exit(void)
+void mdio_bus_exit(void)
 {
 	bus_unregister(&mdio_bus_type);
 }
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -686,7 +686,7 @@ static void free_shared_mem(struct s2io_
 
 static int s2io_verify_pci_mode(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	register u64 val64 = 0;
 	int     mode;
 
@@ -704,7 +704,7 @@ static int s2io_verify_pci_mode(nic_t *n
  */
 static int s2io_print_pci_mode(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	register u64 val64 = 0;
 	int	mode;
 	struct config_param *config = &nic->config;
@@ -1403,7 +1403,7 @@ static int init_nic(struct s2io_nic *nic
 	writeq(0xffbbffbbffbbffbbULL, &bar0->mc_pause_thresh_q4q7);
 
 	/* Disable RMAC PAD STRIPPING */
-	add = (void *) &bar0->mac_cfg;
+	add = &bar0->mac_cfg;
 	val64 = readq(&bar0->mac_cfg);
 	val64 &= ~(MAC_CFG_RMAC_STRIP_PAD);
 	writeq(RMAC_CFG_KEY(0x4C0D), &bar0->rmac_cfg_key);
@@ -1934,7 +1934,7 @@ static int start_nic(struct s2io_nic *ni
 		val64 |= 0x0000800000000000ULL;
 		writeq(val64, &bar0->gpio_control);
 		val64 = 0x0411040400000000ULL;
-		writeq(val64, (void __iomem *) ((u8 *) bar0 + 0x2700));
+		writeq(val64, (void __iomem *)bar0 + 0x2700);
 	}
 
 	/*
@@ -2395,7 +2395,7 @@ static int s2io_poll(struct net_device *
 	int pkt_cnt = 0, org_pkts_to_process;
 	mac_info_t *mac_control;
 	struct config_param *config;
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
 	int i;
 
@@ -2831,7 +2831,7 @@ void s2io_reset(nic_t * sp)
 		val64 |= 0x0000800000000000ULL;
 		writeq(val64, &bar0->gpio_control);
 		val64 = 0x0411040400000000ULL;
-		writeq(val64, (void __iomem *) ((u8 *) bar0 + 0x2700));
+		writeq(val64, (void __iomem *)bar0 + 0x2700);
 	}
 
 	/*
@@ -3234,7 +3234,7 @@ s2io_alarm_handle(unsigned long data)
 
 static void s2io_txpic_intr_handle(nic_t *sp)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) sp->bar0;
+	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	u64 val64;
 
 	val64 = readq(&bar0->pic_int_status);
diff --git a/drivers/net/sis190.c b/drivers/net/sis190.c
--- a/drivers/net/sis190.c
+++ b/drivers/net/sis190.c
@@ -179,14 +179,6 @@ enum sis190_register_content {
 	TxInterFrameGapShift	= 24,
 	TxDMAShift		= 8, /* DMA burst value (0-7) is shift this many bits */
 
-	/* StationControl */
-	_1000bpsF		= 0x1c00,
-	_1000bpsH		= 0x0c00,
-	_100bpsF		= 0x1800,
-	_100bpsH		= 0x0800,
-	_10bpsF			= 0x1400,
-	_10bpsH			= 0x0400,
-
 	LinkStatus		= 0x02,		// unused
 	FullDup			= 0x01,		// unused
 
@@ -279,6 +271,12 @@ enum sis190_eeprom_address {
 	EEPROMMACAddr	= 0x03
 };
 
+enum sis190_feature {
+	F_HAS_RGMII	= 1,
+	F_PHY_88E1111	= 2,
+	F_PHY_BCM5461	= 4
+};
+
 struct sis190_private {
 	void __iomem *mmio_addr;
 	struct pci_dev *pci_dev;
@@ -300,6 +298,7 @@ struct sis190_private {
 	u32 msg_enable;
 	struct mii_if_info mii_if;
 	struct list_head first_phy;
+	u32 features;
 };
 
 struct sis190_phy {
@@ -321,24 +320,25 @@ static struct mii_chip_info {
         const char *name;
         u16 id[2];
         unsigned int type;
+	u32 feature;
 } mii_chip_table[] = {
-	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN },
-	{ "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN },
-	{ "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN },
-	{ "Realtek PHY RTL8201",  { 0x0000, 0x8200 }, LAN },
+	{ "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN, F_PHY_BCM5461 },
+	{ "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN, 0 },
+	{ "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN, F_PHY_88E1111 },
+	{ "Realtek PHY RTL8201",  { 0x0000, 0x8200 }, LAN, 0 },
 	{ NULL, }
 };
 
 const static struct {
 	const char *name;
-	u8 version;		/* depend on docs */
-	u32 RxConfigMask;	/* clear the bits supported by this chip */
 } sis_chip_info[] = {
-	{ DRV_NAME, 0x00, 0xff7e1880, },
+	{ "SiS 190 PCI Fast Ethernet adapter" },
+	{ "SiS 191 PCI Gigabit Ethernet adapter" },
 };
 
 static struct pci_device_id sis190_pci_tbl[] __devinitdata = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0190), 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0191), 0, 0, 1 },
 	{ 0, },
 };
 
@@ -360,7 +360,7 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
 
 static const u32 sis190_intr_mask =
-	RxQEmpty | RxQInt | TxQ1Int | TxQ0Int | RxHalt | TxHalt;
+	RxQEmpty | RxQInt | TxQ1Int | TxQ0Int | RxHalt | TxHalt | LinkChange;
 
 /*
  * Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
@@ -879,11 +879,6 @@ static void sis190_hw_start(struct net_d
 
 	SIS_W32(IntrStatus, 0xffffffff);
 	SIS_W32(IntrMask, 0x0);
-	/*
-	 * Default is 100Mbps.
-	 * A bit strange: 100Mbps is 0x1801 elsewhere -- FR 2005/06/09
-	 */
-	SIS_W16(StationControl, 0x1901);
 	SIS_W32(GMIIControl, 0x0);
 	SIS_W32(TxMacControl, 0x60);
 	SIS_W16(RxMacControl, 0x02);
@@ -923,35 +918,30 @@ static void sis190_phy_task(void * data)
 		     BMSR_ANEGCOMPLETE)) {
 		net_link(tp, KERN_WARNING "%s: PHY reset until link up.\n",
 			 dev->name);
+		netif_carrier_off(dev);
 		mdio_write(ioaddr, phy_id, MII_BMCR, val | BMCR_RESET);
 		mod_timer(&tp->timer, jiffies + SIS190_PHY_TIMEOUT);
 	} else {
 		/* Rejoice ! */
 		struct {
 			int val;
+			u32 ctl;
 			const char *msg;
-			u16 ctl;
 		} reg31[] = {
-			{ LPA_1000XFULL | LPA_SLCT,
-				"1000 Mbps Full Duplex",
-				0x01 | _1000bpsF },
-			{ LPA_1000XHALF | LPA_SLCT,
-				"1000 Mbps Half Duplex",
-				0x01 | _1000bpsH },
-			{ LPA_100FULL,
-				"100 Mbps Full Duplex",
-				0x01 | _100bpsF },
-			{ LPA_100HALF,
-				"100 Mbps Half Duplex",
-				0x01 | _100bpsH },
-			{ LPA_10FULL,
-				"10 Mbps Full Duplex",
-				0x01 | _10bpsF },
-			{ LPA_10HALF,
-				"10 Mbps Half Duplex",
-				0x01 | _10bpsH },
-			{ 0, "unknown", 0x0000 }
-		}, *p;
+			{ LPA_1000XFULL | LPA_SLCT, 0x07000c00 | 0x00001000,
+				"1000 Mbps Full Duplex" },
+			{ LPA_1000XHALF | LPA_SLCT, 0x07000c00,
+				"1000 Mbps Half Duplex" },
+			{ LPA_100FULL, 0x04000800 | 0x00001000,
+				"100 Mbps Full Duplex" },
+			{ LPA_100HALF, 0x04000800,
+				"100 Mbps Half Duplex" },
+			{ LPA_10FULL, 0x04000400 | 0x00001000,
+				"10 Mbps Full Duplex" },
+			{ LPA_10HALF, 0x04000400,
+				"10 Mbps Half Duplex" },
+			{ 0, 0x04000400, "unknown" }
+ 		}, *p;
 		u16 adv;
 
 		val = mdio_read(ioaddr, phy_id, 0x1f);
@@ -964,12 +954,29 @@ static void sis190_phy_task(void * data)
 
 		val &= adv;
 
-		for (p = reg31; p->ctl; p++) {
+		for (p = reg31; p->val; p++) {
 			if ((val & p->val) == p->val)
 				break;
 		}
-		if (p->ctl)
-			SIS_W16(StationControl, p->ctl);
+
+		p->ctl |= SIS_R32(StationControl) & ~0x0f001c00;
+
+		if ((tp->features & F_HAS_RGMII) &&
+		    (tp->features & F_PHY_BCM5461)) {
+			// Set Tx Delay in RGMII mode.
+			mdio_write(ioaddr, phy_id, 0x18, 0xf1c7);
+			udelay(200);
+			mdio_write(ioaddr, phy_id, 0x1c, 0x8c00);
+			p->ctl |= 0x03000000;
+		}
+
+		SIS_W32(StationControl, p->ctl);
+
+		if (tp->features & F_HAS_RGMII) {
+			SIS_W32(RGDelay, 0x0441);
+			SIS_W32(RGDelay, 0x0440);
+		}
+
 		net_link(tp, KERN_INFO "%s: link on %s mode.\n", dev->name,
 			 p->msg);
 		netif_carrier_on(dev);
@@ -1308,6 +1315,7 @@ static void sis190_init_phy(struct net_d
 		phy->type = (p->type == MIX) ?
 			((mii_status & (BMSR_100FULL | BMSR_100HALF)) ?
 				LAN : HOME) : p->type;
+		tp->features |= p->feature;
 	} else
 		phy->type = UNKNOWN;
 
@@ -1316,6 +1324,25 @@ static void sis190_init_phy(struct net_d
 		  (phy->type == UNKNOWN) ? "Unknown PHY" : p->name, phy_id);
 }
 
+static void sis190_mii_probe_88e1111_fixup(struct sis190_private *tp)
+{
+	if (tp->features & F_PHY_88E1111) {
+		void __iomem *ioaddr = tp->mmio_addr;
+		int phy_id = tp->mii_if.phy_id;
+		u16 reg[2][2] = {
+			{ 0x808b, 0x0ce1 },
+			{ 0x808f, 0x0c60 }
+		}, *p;
+
+		p = (tp->features & F_HAS_RGMII) ? reg[0] : reg[1];
+
+		mdio_write(ioaddr, phy_id, 0x1b, p[0]);
+		udelay(200);
+		mdio_write(ioaddr, phy_id, 0x14, p[1]);
+		udelay(200);
+	}
+}
+
 /**
  *	sis190_mii_probe - Probe MII PHY for sis190
  *	@dev: the net device to probe for
@@ -1366,6 +1393,8 @@ static int __devinit sis190_mii_probe(st
 	/* Select default PHY for mac */
 	sis190_default_phy(dev);
 
+	sis190_mii_probe_88e1111_fixup(tp);
+
 	mii_if->dev = dev;
 	mii_if->mdio_read = __mdio_read;
 	mii_if->mdio_write = __mdio_write;
@@ -1505,6 +1534,11 @@ static void sis190_tx_timeout(struct net
 	netif_wake_queue(dev);
 }
 
+static void sis190_set_rgmii(struct sis190_private *tp, u8 reg)
+{
+	tp->features |= (reg & 0x80) ? F_HAS_RGMII : 0;
+}
+
 static int __devinit sis190_get_mac_addr_from_eeprom(struct pci_dev *pdev,
 						     struct net_device *dev)
 {
@@ -1532,6 +1566,8 @@ static int __devinit sis190_get_mac_addr
 		((u16 *)dev->dev_addr)[0] = le16_to_cpu(w);
 	}
 
+	sis190_set_rgmii(tp, sis190_read_eeprom(ioaddr, EEPROMInfo));
+
 	return 0;
 }
 
@@ -1577,6 +1613,8 @@ static int __devinit sis190_get_mac_addr
 	outb(0x12, 0x78);
 	reg = inb(0x79);
 
+	sis190_set_rgmii(tp, reg);
+
 	/* Restore the value to ISA Bridge */
 	pci_write_config_byte(isa_bridge, 0x48, tmp8);
 	pci_dev_put(isa_bridge);
@@ -1799,6 +1837,9 @@ static int __devinit sis190_init_one(str
 	       dev->dev_addr[2], dev->dev_addr[3],
 	       dev->dev_addr[4], dev->dev_addr[5]);
 
+	net_probe(tp, KERN_INFO "%s: %s mode.\n", dev->name,
+		  (tp->features & F_HAS_RGMII) ? "RGMII" : "GMII");
+
 	netif_carrier_off(dev);
 
 	sis190_set_speed_auto(dev);
diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
--- a/drivers/net/tulip/uli526x.c
+++ b/drivers/net/tulip/uli526x.c
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
@@ -34,6 +33,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/processor.h>
 #include <asm/bitops.h>
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -289,8 +289,8 @@ config APPLE_AIRPORT
 	  a non-standard interface
 
 config PLX_HERMES
-	tristate "Hermes in PLX9052 based PCI adaptor support (Netgear MA301 etc.) (EXPERIMENTAL)"
-	depends on PCI && HERMES && EXPERIMENTAL
+	tristate "Hermes in PLX9052 based PCI adaptor support (Netgear MA301 etc.)"
+	depends on PCI && HERMES
 	help
 	  Enable support for PCMCIA cards supported by the "Hermes" (aka
 	  orinoco) driver when used in PLX9052 based PCI adaptors.  These
@@ -299,12 +299,9 @@ config PLX_HERMES
 	  802.11b PCMCIA cards can be used in desktop machines.  The Netgear
 	  MA301 is such an adaptor.
 
-	  Support for these adaptors is so far still incomplete and buggy.
-	  You have been warned.
-
 config TMD_HERMES
-	tristate "Hermes in TMD7160 based PCI adaptor support (EXPERIMENTAL)"
-	depends on PCI && HERMES && EXPERIMENTAL
+	tristate "Hermes in TMD7160 based PCI adaptor support"
+	depends on PCI && HERMES
 	help
 	  Enable support for PCMCIA cards supported by the "Hermes" (aka
 	  orinoco) driver when used in TMD7160 based PCI adaptors.  These
@@ -312,12 +309,18 @@ config TMD_HERMES
 	  PCI <-> PCMCIA bridge.  Several vendors sell such adaptors so that
 	  802.11b PCMCIA cards can be used in desktop machines.
 
-	  Support for these adaptors is so far still incomplete and buggy.
-	  You have been warned.
+config NORTEL_HERMES
+	tristate "Nortel emobility PCI adaptor support"
+	depends on PCI && HERMES
+	help
+	  Enable support for PCMCIA cards supported by the "Hermes" (aka
+	  orinoco) driver when used in Nortel emobility PCI adaptors.  These
+	  adaptors are not full PCMCIA controllers, but act as a more limited
+	  PCI <-> PCMCIA bridge.
 
 config PCI_HERMES
-	tristate "Prism 2.5 PCI 802.11b adaptor support (EXPERIMENTAL)"
-	depends on PCI && HERMES && EXPERIMENTAL
+	tristate "Prism 2.5 PCI 802.11b adaptor support"
+	depends on PCI && HERMES
 	help
 	  Enable support for PCI and mini-PCI 802.11b wireless NICs based on
 	  the Prism 2.5 chipset.  These are true PCI cards, not the 802.11b
@@ -372,6 +375,19 @@ config PCMCIA_HERMES
 	  configure your card and that /etc/pcmcia/wireless.opts works:
 	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
 
+config PCMCIA_SPECTRUM
+	tristate "Symbol Spectrum24 Trilogy PCMCIA card support"
+	depends on NET_RADIO && PCMCIA && HERMES
+	---help---
+
+	  This is a driver for 802.11b cards using RAM-loadable Symbol
+	  firmware, such as Symbol Wireless Networker LA4100, CompactFlash
+	  cards by Socket Communications and Intel PRO/Wireless 2011B.
+
+	  This driver requires firmware download on startup.  Utilities
+	  for downloading Symbol firmware are available at
+	  <http://sourceforge.net/projects/orinoco/>
+
 config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
 	depends on NET_RADIO && PCMCIA && (BROKEN || !M32R)
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -22,6 +22,8 @@ obj-$(CONFIG_APPLE_AIRPORT)	+= airport.o
 obj-$(CONFIG_PLX_HERMES)	+= orinoco_plx.o
 obj-$(CONFIG_PCI_HERMES)	+= orinoco_pci.o
 obj-$(CONFIG_TMD_HERMES)	+= orinoco_tmd.o
+obj-$(CONFIG_NORTEL_HERMES)	+= orinoco_nortel.o
+obj-$(CONFIG_PCMCIA_SPECTRUM)	+= spectrum_cs.o
 
 obj-$(CONFIG_AIRO)		+= airo.o
 obj-$(CONFIG_AIRO_CS)		+= airo_cs.o airo.o
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -327,38 +327,38 @@ static struct iw_handler_def ipw2100_wx_
 
 static inline void read_register(struct net_device *dev, u32 reg, u32 *val)
 {
-	*val = readl((void *)(dev->base_addr + reg));
+	*val = readl((void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("r: 0x%08X => 0x%08X\n", reg, *val);
 }
 
 static inline void write_register(struct net_device *dev, u32 reg, u32 val)
 {
-	writel(val, (void *)(dev->base_addr + reg));
+	writel(val, (void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("w: 0x%08X <= 0x%08X\n", reg, val);
 }
 
 static inline void read_register_word(struct net_device *dev, u32 reg, u16 *val)
 {
-	*val = readw((void *)(dev->base_addr + reg));
+	*val = readw((void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("r: 0x%08X => %04X\n", reg, *val);
 }
 
 static inline void read_register_byte(struct net_device *dev, u32 reg, u8 *val)
 {
-	*val = readb((void *)(dev->base_addr + reg));
+	*val = readb((void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("r: 0x%08X => %02X\n", reg, *val);
 }
 
 static inline void write_register_word(struct net_device *dev, u32 reg, u16 val)
 {
-	writew(val, (void *)(dev->base_addr + reg));
+	writew(val, (void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("w: 0x%08X <= %04X\n", reg, val);
 }
 
 
 static inline void write_register_byte(struct net_device *dev, u32 reg, u8 val)
 {
-	writeb(val, (void *)(dev->base_addr + reg));
+	writeb(val, (void __iomem *)(dev->base_addr + reg));
 	IPW_DEBUG_IO("w: 0x%08X =< %02X\n", reg, val);
 }
 
@@ -498,7 +498,7 @@ static inline void read_nic_memory(struc
 static inline int ipw2100_hw_is_adapter_in_system(struct net_device *dev)
 {
 	return (dev->base_addr &&
-		(readl((void *)(dev->base_addr + IPW_REG_DOA_DEBUG_AREA_START))
+		(readl((void __iomem *)(dev->base_addr + IPW_REG_DOA_DEBUG_AREA_START))
 		 == IPW_DATA_DOA_DEBUG_VALUE));
 }
 
@@ -2125,19 +2125,19 @@ static void isr_indicate_scanning(struct
 }
 
 static const struct ipw2100_status_indicator status_handlers[] = {
-	IPW2100_HANDLER(IPW_STATE_INITIALIZED, 0),
-	IPW2100_HANDLER(IPW_STATE_COUNTRY_FOUND, 0),
+	IPW2100_HANDLER(IPW_STATE_INITIALIZED, NULL),
+	IPW2100_HANDLER(IPW_STATE_COUNTRY_FOUND, NULL),
 	IPW2100_HANDLER(IPW_STATE_ASSOCIATED, isr_indicate_associated),
 	IPW2100_HANDLER(IPW_STATE_ASSN_LOST, isr_indicate_association_lost),
-	IPW2100_HANDLER(IPW_STATE_ASSN_CHANGED, 0),
+	IPW2100_HANDLER(IPW_STATE_ASSN_CHANGED, NULL),
 	IPW2100_HANDLER(IPW_STATE_SCAN_COMPLETE, isr_scan_complete),
-	IPW2100_HANDLER(IPW_STATE_ENTERED_PSP, 0),
-	IPW2100_HANDLER(IPW_STATE_LEFT_PSP, 0),
+	IPW2100_HANDLER(IPW_STATE_ENTERED_PSP, NULL),
+	IPW2100_HANDLER(IPW_STATE_LEFT_PSP, NULL),
 	IPW2100_HANDLER(IPW_STATE_RF_KILL, isr_indicate_rf_kill),
-	IPW2100_HANDLER(IPW_STATE_DISABLED, 0),
-	IPW2100_HANDLER(IPW_STATE_POWER_DOWN, 0),
+	IPW2100_HANDLER(IPW_STATE_DISABLED, NULL),
+	IPW2100_HANDLER(IPW_STATE_POWER_DOWN, NULL),
 	IPW2100_HANDLER(IPW_STATE_SCANNING, isr_indicate_scanning),
-	IPW2100_HANDLER(-1, 0)
+	IPW2100_HANDLER(-1, NULL)
 };
 
 
@@ -6327,7 +6327,7 @@ static void ipw2100_irq_tasklet(struct i
 
 static struct net_device *ipw2100_alloc_device(
 	struct pci_dev *pci_dev,
-	char *base_addr,
+	void __iomem *base_addr,
 	unsigned long mem_start,
 	unsigned long mem_len)
 {
@@ -6474,7 +6474,7 @@ static int ipw2100_pci_init_one(struct p
 				const struct pci_device_id *ent)
 {
 	unsigned long mem_start, mem_len, mem_flags;
-	char *base_addr = NULL;
+	void __iomem *base_addr = NULL;
 	struct net_device *dev = NULL;
 	struct ipw2100_priv *priv = NULL;
 	int err = 0;
@@ -6664,7 +6664,7 @@ static int ipw2100_pci_init_one(struct p
 	}
 
 	if (base_addr)
-		iounmap((char*)base_addr);
+		iounmap(base_addr);
 
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
@@ -6714,7 +6714,7 @@ static void __devexit ipw2100_pci_remove
 			free_irq(dev->irq, priv);
 
 		if (dev->base_addr)
-			iounmap((unsigned char *)dev->base_addr);
+			iounmap((void __iomem *)dev->base_addr);
 
 		free_ieee80211(dev);
 	}
@@ -8574,6 +8574,7 @@ static int ipw2100_ucode_download(struct
 	struct net_device *dev = priv->net_dev;
 	const unsigned char *microcode_data = fw->uc.data;
 	unsigned int microcode_data_left = fw->uc.size;
+	void __iomem *reg = (void __iomem *)dev->base_addr;
 
 	struct symbol_alive_response response;
 	int i, j;
@@ -8581,23 +8582,23 @@ static int ipw2100_ucode_download(struct
 
 	/* Symbol control */
 	write_nic_word(dev, IPW2100_CONTROL_REG, 0x703);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_word(dev, IPW2100_CONTROL_REG, 0x707);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* HW config */
 	write_nic_byte(dev, 0x210014, 0x72);	/* fifo width =16 */
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210014, 0x72);	/* fifo width =16 */
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* EN_CS_ACCESS bit to reset control store pointer */
 	write_nic_byte(dev, 0x210000, 0x40);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210000, 0x0);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210000, 0x40);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* copy microcode from buffer into Symbol */
 
@@ -8609,31 +8610,31 @@ static int ipw2100_ucode_download(struct
 
 	/* EN_CS_ACCESS bit to reset the control store pointer */
 	write_nic_byte(dev, 0x210000, 0x0);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* Enable System (Reg 0)
 	 * first enable causes garbage in RX FIFO */
 	write_nic_byte(dev, 0x210000, 0x0);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210000, 0x80);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* Reset External Baseband Reg */
 	write_nic_word(dev, IPW2100_CONTROL_REG, 0x703);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_word(dev, IPW2100_CONTROL_REG, 0x707);
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* HW Config (Reg 5) */
 	write_nic_byte(dev, 0x210014, 0x72);	// fifo width =16
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210014, 0x72);	// fifo width =16
-	readl((void *)(dev->base_addr));
+	readl(reg);
 
 	/* Enable System (Reg 0)
 	 * second enable should be OK */
 	write_nic_byte(dev, 0x210000, 0x00);	// clear enable system
-	readl((void *)(dev->base_addr));
+	readl(reg);
 	write_nic_byte(dev, 0x210000, 0x80);	// set enable system
 
 	/* check Symbol is enabled - upped this from 5 as it wasn't always
diff --git a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
--- a/drivers/net/wireless/ipw2200.h
+++ b/drivers/net/wireless/ipw2200.h
@@ -42,6 +42,7 @@
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
 #include <linux/random.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/firmware.h>
 #include <linux/wireless.h>
diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -1053,8 +1053,9 @@ static void orinoco_join_ap(struct net_d
 		u16 channel;
 	} __attribute__ ((packed)) req;
 	const int atom_len = offsetof(struct prism2_scan_apinfo, atim);
-	struct prism2_scan_apinfo *atom;
+	struct prism2_scan_apinfo *atom = NULL;
 	int offset = 4;
+	int found = 0;
 	u8 *buf;
 	u16 len;
 
@@ -1089,15 +1090,18 @@ static void orinoco_join_ap(struct net_d
 	 * we were requested to join */
 	for (; offset + atom_len <= len; offset += atom_len) {
 		atom = (struct prism2_scan_apinfo *) (buf + offset);
-		if (memcmp(&atom->bssid, priv->desired_bssid, ETH_ALEN) == 0)
-			goto found;
+		if (memcmp(&atom->bssid, priv->desired_bssid, ETH_ALEN) == 0) {
+			found = 1;
+			break;
+		}
 	}
 
-	DEBUG(1, "%s: Requested AP not found in scan results\n",
-	      dev->name);
-	goto out;
+	if (! found) {
+		DEBUG(1, "%s: Requested AP not found in scan results\n",
+		      dev->name);
+		goto out;
+	}
 
- found:
 	memcpy(req.bssid, priv->desired_bssid, ETH_ALEN);
 	req.channel = atom->channel;	/* both are little-endian */
 	err = HERMES_WRITE_RECORD(hw, USER_BAP, HERMES_RID_CNFJOINREQUEST,
@@ -1284,8 +1288,10 @@ static void __orinoco_ev_info(struct net
 		/* Read scan data */
 		err = hermes_bap_pread(hw, IRQ_BAP, (void *) buf, len,
 				       infofid, sizeof(info));
-		if (err)
+		if (err) {
+			kfree(buf);
 			break;
+		}
 
 #ifdef ORINOCO_DEBUG
 		{
@@ -4021,7 +4027,8 @@ static int orinoco_ioctl_setscan(struct 
 }
 
 /* Translate scan data returned from the card to a card independant
- * format that the Wireless Tools will understand - Jean II */
+ * format that the Wireless Tools will understand - Jean II
+ * Return message length or -errno for fatal errors */
 static inline int orinoco_translate_scan(struct net_device *dev,
 					 char *buffer,
 					 char *scan,
@@ -4061,13 +4068,19 @@ static inline int orinoco_translate_scan
 		break;
 	case FIRMWARE_TYPE_INTERSIL:
 		offset = 4;
-		if (priv->has_hostscan)
-			atom_len = scan[0] + (scan[1] << 8);
-		else
+		if (priv->has_hostscan) {
+			atom_len = le16_to_cpup((u16 *)scan);
+			/* Sanity check for atom_len */
+			if (atom_len < sizeof(struct prism2_scan_apinfo)) {
+				printk(KERN_ERR "%s: Invalid atom_len in scan data: %d\n",
+				dev->name, atom_len);
+				return -EIO;
+			}
+		} else
 			atom_len = offsetof(struct prism2_scan_apinfo, atim);
 		break;
 	default:
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	/* Check that we got an whole number of atoms */
@@ -4075,7 +4088,7 @@ static inline int orinoco_translate_scan
 		printk(KERN_ERR "%s: Unexpected scan data length %d, "
 		       "atom_len %d, offset %d\n", dev->name, scan_len,
 		       atom_len, offset);
-		return 0;
+		return -EIO;
 	}
 
 	/* Read the entries one by one */
@@ -4210,33 +4223,41 @@ static int orinoco_ioctl_getscan(struct 
 		/* We have some results to push back to user space */
 
 		/* Translate to WE format */
-		srq->length = orinoco_translate_scan(dev, extra,
-						     priv->scan_result,
-						     priv->scan_len);
-
-		/* Return flags */
-		srq->flags = (__u16) priv->scan_mode;
+		int ret = orinoco_translate_scan(dev, extra,
+						 priv->scan_result,
+						 priv->scan_len);
+
+		if (ret < 0) {
+			err = ret;
+			kfree(priv->scan_result);
+			priv->scan_result = NULL;
+		} else {
+			srq->length = ret;
 
-		/* Results are here, so scan no longer in progress */
-		priv->scan_inprogress = 0;
+			/* Return flags */
+			srq->flags = (__u16) priv->scan_mode;
 
-		/* In any case, Scan results will be cleaned up in the
-		 * reset function and when exiting the driver.
-		 * The person triggering the scanning may never come to
-		 * pick the results, so we need to do it in those places.
-		 * Jean II */
+			/* In any case, Scan results will be cleaned up in the
+			 * reset function and when exiting the driver.
+			 * The person triggering the scanning may never come to
+			 * pick the results, so we need to do it in those places.
+			 * Jean II */
 
 #ifdef SCAN_SINGLE_READ
-		/* If you enable this option, only one client (the first
-		 * one) will be able to read the result (and only one
-		 * time). If there is multiple concurent clients that
-		 * want to read scan results, this behavior is not
-		 * advisable - Jean II */
-		kfree(priv->scan_result);
-		priv->scan_result = NULL;
+			/* If you enable this option, only one client (the first
+			 * one) will be able to read the result (and only one
+			 * time). If there is multiple concurent clients that
+			 * want to read scan results, this behavior is not
+			 * advisable - Jean II */
+			kfree(priv->scan_result);
+			priv->scan_result = NULL;
 #endif /* SCAN_SINGLE_READ */
-		/* Here, if too much time has elapsed since last scan,
-		 * we may want to clean up scan results... - Jean II */
+			/* Here, if too much time has elapsed since last scan,
+			 * we may want to clean up scan results... - Jean II */
+		}
+
+		/* Scan is no longer in progress */
+		priv->scan_inprogress = 0;
 	}
 	  
 	orinoco_unlock(priv, &flags);
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -604,7 +604,6 @@ static char version[] __initdata = DRIVE
 
 static struct pcmcia_device_id orinoco_cs_ids[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x000b, 0x7300),
-	PCMCIA_DEVICE_MANF_CARD(0x0089, 0x0001),
 	PCMCIA_DEVICE_MANF_CARD(0x0138, 0x0002),
 	PCMCIA_DEVICE_MANF_CARD(0x0156, 0x0002),
 	PCMCIA_DEVICE_MANF_CARD(0x01eb, 0x080a),
diff --git a/drivers/net/wireless/orinoco_nortel.c b/drivers/net/wireless/orinoco_nortel.c
new file mode 100644
--- /dev/null
+++ b/drivers/net/wireless/orinoco_nortel.c
@@ -0,0 +1,324 @@
+/* orinoco_nortel.c
+ * 
+ * Driver for Prism II devices which would usually be driven by orinoco_cs,
+ * but are connected to the PCI bus by a Nortel PCI-PCMCIA-Adapter. 
+ *
+ * Copyright (C) 2002 Tobias Hoffmann
+ *           (C) 2003 Christoph Jungegger <disdos@traum404.de>
+ *
+ * Some of this code is borrowed from orinoco_plx.c
+ *	Copyright (C) 2001 Daniel Barlow
+ * Some of this code is borrowed from orinoco_pci.c 
+ *  Copyright (C) 2001 Jean Tourrilhes
+ * Some of this code is "inspired" by linux-wlan-ng-0.1.10, but nothing
+ * has been copied from it. linux-wlan-ng-0.1.10 is originally :
+ *	Copyright (C) 1999 AbsoluteValue Systems, Inc.  All Rights Reserved.
+ * 
+ * The contents of this file are subject to the Mozilla Public License
+ * Version 1.1 (the "License"); you may not use this file except in
+ * compliance with the License. You may obtain a copy of the License
+ * at http://www.mozilla.org/MPL/
+ *
+ * Software distributed under the License is distributed on an "AS IS"
+ * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
+ * the License for the specific language governing rights and
+ * limitations under the License.
+ *
+ * Alternatively, the contents of this file may be used under the
+ * terms of the GNU General Public License version 2 (the "GPL"), in
+ * which case the provisions of the GPL are applicable instead of the
+ * above.  If you wish to allow the use of your version of this file
+ * only under the terms of the GPL and not to allow others to use your
+ * version of this file under the MPL, indicate your decision by
+ * deleting the provisions above and replace them with the notice and
+ * other provisions required by the GPL.  If you do not delete the
+ * provisions above, a recipient may use your version of this file
+ * under either the MPL or the GPL.
+ */
+
+#define DRIVER_NAME "orinoco_nortel"
+#define PFX DRIVER_NAME ": "
+
+#include <linux/config.h>
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/ioport.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/etherdevice.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/fcntl.h>
+
+#include <pcmcia/cisreg.h>
+
+#include "hermes.h"
+#include "orinoco.h"
+
+#define COR_OFFSET    (0xe0)	/* COR attribute offset of Prism2 PC card */
+#define COR_VALUE     (COR_LEVEL_REQ | COR_FUNC_ENA)	/* Enable PC card with interrupt in level trigger */
+
+
+/* Nortel specific data */
+struct nortel_pci_card {
+	unsigned long iobase1;
+	unsigned long iobase2;
+};
+
+/*
+ * Do a soft reset of the PCI card using the Configuration Option Register
+ * We need this to get going...
+ * This is the part of the code that is strongly inspired from wlan-ng
+ *
+ * Note bis : Don't try to access HERMES_CMD during the reset phase.
+ * It just won't work !
+ */
+static int nortel_pci_cor_reset(struct orinoco_private *priv)
+{
+	struct nortel_pci_card *card = priv->card;
+
+	/* Assert the reset until the card notice */
+	outw_p(8, card->iobase1 + 2);
+	inw(card->iobase2 + COR_OFFSET);
+	outw_p(0x80, card->iobase2 + COR_OFFSET);
+	mdelay(1);
+
+	/* Give time for the card to recover from this hard effort */
+	outw_p(0, card->iobase2 + COR_OFFSET);
+	outw_p(0, card->iobase2 + COR_OFFSET);
+	mdelay(1);
+
+	/* set COR as usual */
+	outw_p(COR_VALUE, card->iobase2 + COR_OFFSET);
+	outw_p(COR_VALUE, card->iobase2 + COR_OFFSET);
+	mdelay(1);
+
+	outw_p(0x228, card->iobase1 + 2);
+
+	return 0;
+}
+
+int nortel_pci_hw_init(struct nortel_pci_card *card)
+{
+	int i;
+	u32 reg;
+
+	/* setup bridge */
+	if (inw(card->iobase1) & 1) {
+		printk(KERN_ERR PFX "brg1 answer1 wrong\n");
+		return -EBUSY;
+	}
+	outw_p(0x118, card->iobase1 + 2);
+	outw_p(0x108, card->iobase1 + 2);
+	mdelay(30);
+	outw_p(0x8, card->iobase1 + 2);
+	for (i = 0; i < 30; i++) {
+		mdelay(30);
+		if (inw(card->iobase1) & 0x10) {
+			break;
+		}
+	}
+	if (i == 30) {
+		printk(KERN_ERR PFX "brg1 timed out\n");
+		return -EBUSY;
+	}
+	if (inw(card->iobase2 + 0xe0) & 1) {
+		printk(KERN_ERR PFX "brg2 answer1 wrong\n");
+		return -EBUSY;
+	}
+	if (inw(card->iobase2 + 0xe2) & 1) {
+		printk(KERN_ERR PFX "brg2 answer2 wrong\n");
+		return -EBUSY;
+	}
+	if (inw(card->iobase2 + 0xe4) & 1) {
+		printk(KERN_ERR PFX "brg2 answer3 wrong\n");
+		return -EBUSY;
+	}
+
+	/* set the PCMCIA COR-Register */
+	outw_p(COR_VALUE, card->iobase2 + COR_OFFSET);
+	mdelay(1);
+	reg = inw(card->iobase2 + COR_OFFSET);
+	if (reg != COR_VALUE) {
+		printk(KERN_ERR PFX "Error setting COR value (reg=%x)\n",
+		       reg);
+		return -EBUSY;
+	}
+
+	/* set leds */
+	outw_p(1, card->iobase1 + 10);
+	return 0;
+}
+
+static int nortel_pci_init_one(struct pci_dev *pdev,
+			       const struct pci_device_id *ent)
+{
+	int err;
+	struct orinoco_private *priv;
+	struct nortel_pci_card *card;
+	struct net_device *dev;
+	void __iomem *iomem;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		printk(KERN_ERR PFX "Cannot enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRIVER_NAME);
+	if (err != 0) {
+		printk(KERN_ERR PFX "Cannot obtain PCI resources\n");
+		goto fail_resources;
+	}
+
+	iomem = pci_iomap(pdev, 3, 0);
+	if (!iomem) {
+		err = -ENOMEM;
+		goto fail_map_io;
+	}
+
+	/* Allocate network device */
+	dev = alloc_orinocodev(sizeof(*card), nortel_pci_cor_reset);
+	if (!dev) {
+		printk(KERN_ERR PFX "Cannot allocate network device\n");
+		err = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	priv = netdev_priv(dev);
+	card = priv->card;
+	card->iobase1 = pci_resource_start(pdev, 0);
+	card->iobase2 = pci_resource_start(pdev, 1);
+	dev->base_addr = pci_resource_start(pdev, 2);
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	hermes_struct_init(&priv->hw, iomem, HERMES_16BIT_REGSPACING);
+
+	printk(KERN_DEBUG PFX "Detected Nortel PCI device at %s irq:%d, "
+	       "io addr:0x%lx\n", pci_name(pdev), pdev->irq, dev->base_addr);
+
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
+			  dev->name, dev);
+	if (err) {
+		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
+		err = -EBUSY;
+		goto fail_irq;
+	}
+	dev->irq = pdev->irq;
+
+	err = nortel_pci_hw_init(card);
+	if (err) {
+		printk(KERN_ERR PFX "Hardware initialization failed\n");
+		goto fail;
+	}
+
+	err = nortel_pci_cor_reset(priv);
+	if (err) {
+		printk(KERN_ERR PFX "Initial reset failed\n");
+		goto fail;
+	}
+
+
+	err = register_netdev(dev);
+	if (err) {
+		printk(KERN_ERR PFX "Cannot register network device\n");
+		goto fail;
+	}
+
+	pci_set_drvdata(pdev, dev);
+
+	return 0;
+
+ fail:
+	free_irq(pdev->irq, dev);
+
+ fail_irq:
+	pci_set_drvdata(pdev, NULL);
+	free_orinocodev(dev);
+
+ fail_alloc:
+	pci_iounmap(pdev, iomem);
+
+ fail_map_io:
+	pci_release_regions(pdev);
+
+ fail_resources:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void __devexit nortel_pci_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct nortel_pci_card *card = priv->card;
+
+	/* clear leds */
+	outw_p(0, card->iobase1 + 10);
+
+	unregister_netdev(dev);
+	free_irq(dev->irq, dev);
+	pci_set_drvdata(pdev, NULL);
+	free_orinocodev(dev);
+	pci_iounmap(pdev, priv->hw.iobase);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+
+static struct pci_device_id nortel_pci_id_table[] = {
+	/* Nortel emobility PCI */
+	{0x126c, 0x8030, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, nortel_pci_id_table);
+
+static struct pci_driver nortel_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = nortel_pci_id_table,
+	.probe = nortel_pci_init_one,
+	.remove = __devexit_p(nortel_pci_remove_one),
+};
+
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (Tobias Hoffmann & Christoph Jungegger <disdos@traum404.de>)";
+MODULE_AUTHOR("Christoph Jungegger <disdos@traum404.de>");
+MODULE_DESCRIPTION
+    ("Driver for wireless LAN cards using the Nortel PCI bridge");
+MODULE_LICENSE("Dual MPL/GPL");
+
+static int __init nortel_pci_init(void)
+{
+	printk(KERN_DEBUG "%s\n", version);
+	return pci_module_init(&nortel_pci_driver);
+}
+
+static void __exit nortel_pci_exit(void)
+{
+	pci_unregister_driver(&nortel_pci_driver);
+	ssleep(1);
+}
+
+module_init(nortel_pci_init);
+module_exit(nortel_pci_exit);
+
+/*
+ * Local variables:
+ *  c-indent-level: 8
+ *  c-basic-offset: 8
+ *  tab-width: 8
+ * End:
+ */
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
new file mode 100644
--- /dev/null
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -0,0 +1,1120 @@
+/*
+ * Driver for 802.11b cards using RAM-loadable Symbol firmware, such as
+ * Symbol Wireless Networker LA4100, CompactFlash cards by Socket
+ * Communications and Intel PRO/Wireless 2011B.
+ *
+ * The driver implements Symbol firmware download.  The rest is handled
+ * in hermes.c and orinoco.c.
+ *
+ * Utilities for downloading the Symbol firmware are available at
+ * http://sourceforge.net/projects/orinoco/
+ *
+ * Copyright (C) 2002-2005 Pavel Roskin <proski@gnu.org>
+ * Portions based on orinoco_cs.c:
+ * 	Copyright (C) David Gibson, Linuxcare Australia
+ * Portions based on Spectrum24tDnld.c from original spectrum24 driver:
+ * 	Copyright (C) Symbol Technologies.
+ *
+ * See copyright notice in file orinoco.c.
+ */
+
+#define DRIVER_NAME "spectrum_cs"
+#define PFX DRIVER_NAME ": "
+
+#include <linux/config.h>
+#ifdef  __IN_PCMCIA_PACKAGE__
+#include <pcmcia/k_compat.h>
+#endif /* __IN_PCMCIA_PACKAGE__ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/etherdevice.h>
+#include <linux/wireless.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/cisreg.h>
+#include <pcmcia/ds.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+#include "orinoco.h"
+
+/*
+ * If SPECTRUM_FW_INCLUDED is defined, the firmware is hardcoded into
+ * the driver.  Use get_symbol_fw script to generate spectrum_fw.h and
+ * copy it to the same directory as spectrum_cs.c.
+ *
+ * If SPECTRUM_FW_INCLUDED is not defined, the firmware is loaded at the
+ * runtime using hotplug.  Use the same get_symbol_fw script to generate
+ * files symbol_sp24t_prim_fw symbol_sp24t_sec_fw, copy them to the
+ * hotplug firmware directory (typically /usr/lib/hotplug/firmware) and
+ * make sure that you have hotplug installed and enabled in the kernel.
+ */
+/* #define SPECTRUM_FW_INCLUDED 1 */
+
+#ifdef SPECTRUM_FW_INCLUDED
+/* Header with the firmware */
+#include "spectrum_fw.h"
+#else	/* !SPECTRUM_FW_INCLUDED */
+#include <linux/firmware.h>
+static unsigned char *primsym;
+static unsigned char *secsym;
+static const char primary_fw_name[] = "symbol_sp24t_prim_fw";
+static const char secondary_fw_name[] = "symbol_sp24t_sec_fw";
+#endif	/* !SPECTRUM_FW_INCLUDED */
+
+/********************************************************************/
+/* Module stuff							    */
+/********************************************************************/
+
+MODULE_AUTHOR("Pavel Roskin <proski@gnu.org>");
+MODULE_DESCRIPTION("Driver for Symbol Spectrum24 Trilogy cards with firmware downloader");
+MODULE_LICENSE("Dual MPL/GPL");
+
+/* Module parameters */
+
+/* Some D-Link cards have buggy CIS. They do work at 5v properly, but
+ * don't have any CIS entry for it. This workaround it... */
+static int ignore_cis_vcc; /* = 0 */
+module_param(ignore_cis_vcc, int, 0);
+MODULE_PARM_DESC(ignore_cis_vcc, "Allow voltage mismatch between card and socket");
+
+/********************************************************************/
+/* Magic constants						    */
+/********************************************************************/
+
+/*
+ * The dev_info variable is the "key" that is used to match up this
+ * device driver with appropriate cards, through the card
+ * configuration database.
+ */
+static dev_info_t dev_info = DRIVER_NAME;
+
+/********************************************************************/
+/* Data structures						    */
+/********************************************************************/
+
+/* PCMCIA specific device information (goes in the card field of
+ * struct orinoco_private */
+struct orinoco_pccard {
+	dev_link_t link;
+	dev_node_t node;
+};
+
+/*
+ * A linked list of "instances" of the device.  Each actual PCMCIA
+ * card corresponds to one device instance, and is described by one
+ * dev_link_t structure (defined in ds.h).
+ */
+static dev_link_t *dev_list; /* = NULL */
+
+/********************************************************************/
+/* Function prototypes						    */
+/********************************************************************/
+
+/* device methods */
+static int spectrum_cs_hard_reset(struct orinoco_private *priv);
+
+/* PCMCIA gumpf */
+static void spectrum_cs_config(dev_link_t * link);
+static void spectrum_cs_release(dev_link_t * link);
+static int spectrum_cs_event(event_t event, int priority,
+			    event_callback_args_t * args);
+
+static dev_link_t *spectrum_cs_attach(void);
+static void spectrum_cs_detach(dev_link_t *);
+
+/********************************************************************/
+/* Firmware downloader						    */
+/********************************************************************/
+
+/* Position of PDA in the adapter memory */
+#define EEPROM_ADDR	0x3000
+#define EEPROM_LEN	0x200
+#define PDA_OFFSET	0x100
+
+#define PDA_ADDR	(EEPROM_ADDR + PDA_OFFSET)
+#define PDA_WORDS	((EEPROM_LEN - PDA_OFFSET) / 2)
+
+/* Constants for the CISREG_CCSR register */
+#define HCR_RUN		0x07	/* run firmware after reset */
+#define HCR_IDLE	0x0E	/* don't run firmware after reset */
+#define HCR_MEM16	0x10	/* memory width bit, should be preserved */
+
+/*
+ * AUX port access.  To unlock the AUX port write the access keys to the
+ * PARAM0-2 registers, then write HERMES_AUX_ENABLE to the HERMES_CONTROL
+ * register.  Then read it and make sure it's HERMES_AUX_ENABLED.
+ */
+#define HERMES_AUX_ENABLE	0x8000	/* Enable auxiliary port access */
+#define HERMES_AUX_DISABLE	0x4000	/* Disable to auxiliary port access */
+#define HERMES_AUX_ENABLED	0xC000	/* Auxiliary port is open */
+
+#define HERMES_AUX_PW0	0xFE01
+#define HERMES_AUX_PW1	0xDC23
+#define HERMES_AUX_PW2	0xBA45
+
+/* End markers */
+#define PDI_END		0x00000000	/* End of PDA */
+#define BLOCK_END	0xFFFFFFFF	/* Last image block */
+#define TEXT_END	0x1A		/* End of text header */
+
+/*
+ * The following structures have little-endian fields denoted by
+ * the leading underscore.  Don't access them directly - use inline
+ * functions defined below.
+ */
+
+/*
+ * The binary image to be downloaded consists of series of data blocks.
+ * Each block has the following structure.
+ */
+struct dblock {
+	u32 _addr;		/* adapter address where to write the block */
+	u16 _len;		/* length of the data only, in bytes */
+	char data[0];		/* data to be written */
+} __attribute__ ((packed));
+
+/*
+ * Plug Data References are located in in the image after the last data
+ * block.  They refer to areas in the adapter memory where the plug data
+ * items with matching ID should be written.
+ */
+struct pdr {
+	u32 _id;		/* record ID */
+	u32 _addr;		/* adapter address where to write the data */
+	u32 _len;		/* expected length of the data, in bytes */
+	char next[0];		/* next PDR starts here */
+} __attribute__ ((packed));
+
+
+/*
+ * Plug Data Items are located in the EEPROM read from the adapter by
+ * primary firmware.  They refer to the device-specific data that should
+ * be plugged into the secondary firmware.
+ */
+struct pdi {
+	u16 _len;		/* length of ID and data, in words */
+	u16 _id;		/* record ID */
+	char data[0];		/* plug data */
+} __attribute__ ((packed));;
+
+
+/* Functions for access to little-endian data */
+static inline u32
+dblock_addr(const struct dblock *blk)
+{
+	return le32_to_cpu(blk->_addr);
+}
+
+static inline u32
+dblock_len(const struct dblock *blk)
+{
+	return le16_to_cpu(blk->_len);
+}
+
+static inline u32
+pdr_id(const struct pdr *pdr)
+{
+	return le32_to_cpu(pdr->_id);
+}
+
+static inline u32
+pdr_addr(const struct pdr *pdr)
+{
+	return le32_to_cpu(pdr->_addr);
+}
+
+static inline u32
+pdr_len(const struct pdr *pdr)
+{
+	return le32_to_cpu(pdr->_len);
+}
+
+static inline u32
+pdi_id(const struct pdi *pdi)
+{
+	return le16_to_cpu(pdi->_id);
+}
+
+/* Return length of the data only, in bytes */
+static inline u32
+pdi_len(const struct pdi *pdi)
+{
+	return 2 * (le16_to_cpu(pdi->_len) - 1);
+}
+
+
+/* Set address of the auxiliary port */
+static inline void
+spectrum_aux_setaddr(hermes_t *hw, u32 addr)
+{
+	hermes_write_reg(hw, HERMES_AUXPAGE, (u16) (addr >> 7));
+	hermes_write_reg(hw, HERMES_AUXOFFSET, (u16) (addr & 0x7F));
+}
+
+
+/* Open access to the auxiliary port */
+static int
+spectrum_aux_open(hermes_t *hw)
+{
+	int i;
+
+	/* Already open? */
+	if (hermes_read_reg(hw, HERMES_CONTROL) == HERMES_AUX_ENABLED)
+		return 0;
+
+	hermes_write_reg(hw, HERMES_PARAM0, HERMES_AUX_PW0);
+	hermes_write_reg(hw, HERMES_PARAM1, HERMES_AUX_PW1);
+	hermes_write_reg(hw, HERMES_PARAM2, HERMES_AUX_PW2);
+	hermes_write_reg(hw, HERMES_CONTROL, HERMES_AUX_ENABLE);
+
+	for (i = 0; i < 20; i++) {
+		udelay(10);
+		if (hermes_read_reg(hw, HERMES_CONTROL) ==
+		    HERMES_AUX_ENABLED)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
+
+#define CS_CHECK(fn, ret) \
+  do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
+
+/*
+ * Reset the card using configuration registers COR and CCSR.
+ * If IDLE is 1, stop the firmware, so that it can be safely rewritten.
+ */
+static int
+spectrum_reset(dev_link_t *link, int idle)
+{
+	int last_ret, last_fn;
+	conf_reg_t reg;
+	u_int save_cor;
+
+	/* Doing it if hardware is gone is guaranteed crash */
+	if (!(link->state & DEV_CONFIG))
+		return -ENODEV;
+
+	/* Save original COR value */
+	reg.Function = 0;
+	reg.Action = CS_READ;
+	reg.Offset = CISREG_COR;
+	CS_CHECK(AccessConfigurationRegister,
+		 pcmcia_access_configuration_register(link->handle, &reg));
+	save_cor = reg.Value;
+
+	/* Soft-Reset card */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_COR;
+	reg.Value = (save_cor | COR_SOFT_RESET);
+	CS_CHECK(AccessConfigurationRegister,
+		 pcmcia_access_configuration_register(link->handle, &reg));
+	udelay(1000);
+
+	/* Read CCSR */
+	reg.Action = CS_READ;
+	reg.Offset = CISREG_CCSR;
+	CS_CHECK(AccessConfigurationRegister,
+		 pcmcia_access_configuration_register(link->handle, &reg));
+
+	/*
+	 * Start or stop the firmware.  Memory width bit should be
+	 * preserved from the value we've just read.
+	 */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_CCSR;
+	reg.Value = (idle ? HCR_IDLE : HCR_RUN) | (reg.Value & HCR_MEM16);
+	CS_CHECK(AccessConfigurationRegister,
+		 pcmcia_access_configuration_register(link->handle, &reg));
+	udelay(1000);
+
+	/* Restore original COR configuration index */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_COR;
+	reg.Value = (save_cor & ~COR_SOFT_RESET);
+	CS_CHECK(AccessConfigurationRegister,
+		 pcmcia_access_configuration_register(link->handle, &reg));
+	udelay(1000);
+	return 0;
+
+      cs_failed:
+	cs_error(link->handle, last_fn, last_ret);
+	return -ENODEV;
+}
+
+
+/*
+ * Scan PDR for the record with the specified RECORD_ID.
+ * If it's not found, return NULL.
+ */
+static struct pdr *
+spectrum_find_pdr(struct pdr *first_pdr, u32 record_id)
+{
+	struct pdr *pdr = first_pdr;
+
+	while (pdr_id(pdr) != PDI_END) {
+		/*
+		 * PDR area is currently not terminated by PDI_END.
+		 * It's followed by CRC records, which have the type
+		 * field where PDR has length.  The type can be 0 or 1.
+		 */
+		if (pdr_len(pdr) < 2)
+			return NULL;
+
+		/* If the record ID matches, we are done */
+		if (pdr_id(pdr) == record_id)
+			return pdr;
+
+		pdr = (struct pdr *) pdr->next;
+	}
+	return NULL;
+}
+
+
+/* Process one Plug Data Item - find corresponding PDR and plug it */
+static int
+spectrum_plug_pdi(hermes_t *hw, struct pdr *first_pdr, struct pdi *pdi)
+{
+	struct pdr *pdr;
+
+	/* Find the PDI corresponding to this PDR */
+	pdr = spectrum_find_pdr(first_pdr, pdi_id(pdi));
+
+	/* No match is found, safe to ignore */
+	if (!pdr)
+		return 0;
+
+	/* Lengths of the data in PDI and PDR must match */
+	if (pdi_len(pdi) != pdr_len(pdr))
+		return -EINVAL;
+
+	/* do the actual plugging */
+	spectrum_aux_setaddr(hw, pdr_addr(pdr));
+	hermes_write_words(hw, HERMES_AUXDATA, pdi->data,
+			   pdi_len(pdi) / 2);
+
+	return 0;
+}
+
+
+/* Read PDA from the adapter */
+static int
+spectrum_read_pda(hermes_t *hw, u16 *pda, int pda_len)
+{
+	int ret;
+	int pda_size;
+
+	/* Issue command to read EEPROM */
+	ret = hermes_docmd_wait(hw, HERMES_CMD_READMIF, 0, NULL);
+	if (ret)
+		return ret;
+
+	/* Open auxiliary port */
+	ret = spectrum_aux_open(hw);
+	if (ret)
+		return ret;
+
+	/* read PDA from EEPROM */
+	spectrum_aux_setaddr(hw, PDA_ADDR);
+	hermes_read_words(hw, HERMES_AUXDATA, pda, pda_len / 2);
+
+	/* Check PDA length */
+	pda_size = le16_to_cpu(pda[0]);
+	if (pda_size > pda_len)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+/* Parse PDA and write the records into the adapter */
+static int
+spectrum_apply_pda(hermes_t *hw, const struct dblock *first_block,
+		   u16 *pda)
+{
+	int ret;
+	struct pdi *pdi;
+	struct pdr *first_pdr;
+	const struct dblock *blk = first_block;
+
+	/* Skip all blocks to locate Plug Data References */
+	while (dblock_addr(blk) != BLOCK_END)
+		blk = (struct dblock *) &blk->data[dblock_len(blk)];
+
+	first_pdr = (struct pdr *) blk;
+
+	/* Go through every PDI and plug them into the adapter */
+	pdi = (struct pdi *) (pda + 2);
+	while (pdi_id(pdi) != PDI_END) {
+		ret = spectrum_plug_pdi(hw, first_pdr, pdi);
+		if (ret)
+			return ret;
+
+		/* Increment to the next PDI */
+		pdi = (struct pdi *) &pdi->data[pdi_len(pdi)];
+	}
+	return 0;
+}
+
+
+/* Load firmware blocks into the adapter */
+static int
+spectrum_load_blocks(hermes_t *hw, const struct dblock *first_block)
+{
+	const struct dblock *blk;
+	u32 blkaddr;
+	u32 blklen;
+
+	blk = first_block;
+	blkaddr = dblock_addr(blk);
+	blklen = dblock_len(blk);
+
+	while (dblock_addr(blk) != BLOCK_END) {
+		spectrum_aux_setaddr(hw, blkaddr);
+		hermes_write_words(hw, HERMES_AUXDATA, blk->data,
+				   blklen / 2);
+
+		blk = (struct dblock *) &blk->data[blklen];
+		blkaddr = dblock_addr(blk);
+		blklen = dblock_len(blk);
+	}
+	return 0;
+}
+
+
+/*
+ * Process a firmware image - stop the card, load the firmware, reset
+ * the card and make sure it responds.  For the secondary firmware take
+ * care of the PDA - read it and then write it on top of the firmware.
+ */
+static int
+spectrum_dl_image(hermes_t *hw, dev_link_t *link,
+		  const unsigned char *image)
+{
+	int ret;
+	const unsigned char *ptr;
+	const struct dblock *first_block;
+
+	/* Plug Data Area (PDA) */
+	u16 pda[PDA_WORDS];
+
+	/* Binary block begins after the 0x1A marker */
+	ptr = image;
+	while (*ptr++ != TEXT_END);
+	first_block = (const struct dblock *) ptr;
+
+	/* Read the PDA */
+	if (image != primsym) {
+		ret = spectrum_read_pda(hw, pda, sizeof(pda));
+		if (ret)
+			return ret;
+	}
+
+	/* Stop the firmware, so that it can be safely rewritten */
+	ret = spectrum_reset(link, 1);
+	if (ret)
+		return ret;
+
+	/* Program the adapter with new firmware */
+	ret = spectrum_load_blocks(hw, first_block);
+	if (ret)
+		return ret;
+
+	/* Write the PDA to the adapter */
+	if (image != primsym) {
+		ret = spectrum_apply_pda(hw, first_block, pda);
+		if (ret)
+			return ret;
+	}
+
+	/* Run the firmware */
+	ret = spectrum_reset(link, 0);
+	if (ret)
+		return ret;
+
+	/* Reset hermes chip and make sure it responds */
+	ret = hermes_init(hw);
+
+	/* hermes_reset() should return 0 with the secondary firmware */
+	if (image != primsym && ret != 0)
+		return -ENODEV;
+
+	/* And this should work with any firmware */
+	if (!hermes_present(hw))
+		return -ENODEV;
+
+	return 0;
+}
+
+
+/*
+ * Download the firmware into the card, this also does a PCMCIA soft
+ * reset on the card, to make sure it's in a sane state.
+ */
+static int
+spectrum_dl_firmware(hermes_t *hw, dev_link_t *link)
+{
+	int ret;
+	client_handle_t handle = link->handle;
+
+#ifndef SPECTRUM_FW_INCLUDED
+	const struct firmware *fw_entry;
+
+	if (request_firmware(&fw_entry, primary_fw_name,
+			     &handle_to_dev(handle)) == 0) {
+		primsym = fw_entry->data;
+	} else {
+		printk(KERN_ERR PFX "Cannot find firmware: %s\n",
+		       primary_fw_name);
+		return -ENOENT;
+	}
+
+	if (request_firmware(&fw_entry, secondary_fw_name,
+			     &handle_to_dev(handle)) == 0) {
+		secsym = fw_entry->data;
+	} else {
+		printk(KERN_ERR PFX "Cannot find firmware: %s\n",
+		       secondary_fw_name);
+		return -ENOENT;
+	}
+#endif
+
+	/* Load primary firmware */
+	ret = spectrum_dl_image(hw, link, primsym);
+	if (ret) {
+		printk(KERN_ERR PFX "Primary firmware download failed\n");
+		return ret;
+	}
+
+	/* Load secondary firmware */
+	ret = spectrum_dl_image(hw, link, secsym);
+
+	if (ret) {
+		printk(KERN_ERR PFX "Secondary firmware download failed\n");
+	}
+
+	return ret;
+}
+
+/********************************************************************/
+/* Device methods     						    */
+/********************************************************************/
+
+static int
+spectrum_cs_hard_reset(struct orinoco_private *priv)
+{
+	struct orinoco_pccard *card = priv->card;
+	dev_link_t *link = &card->link;
+	int err;
+
+	if (!hermes_present(&priv->hw)) {
+		/* The firmware needs to be reloaded */
+		if (spectrum_dl_firmware(&priv->hw, &card->link) != 0) {
+			printk(KERN_ERR PFX "Firmware download failed\n");
+			err = -ENODEV;
+		}
+	} else {
+		/* Soft reset using COR and HCR */
+		spectrum_reset(link, 0);
+	}
+
+	return 0;
+}
+
+/********************************************************************/
+/* PCMCIA stuff     						    */
+/********************************************************************/
+
+/*
+ * This creates an "instance" of the driver, allocating local data
+ * structures for one device.  The device is registered with Card
+ * Services.
+ * 
+ * The dev_link structure is initialized, but we don't actually
+ * configure the card at this point -- we wait until we receive a card
+ * insertion event.  */
+static dev_link_t *
+spectrum_cs_attach(void)
+{
+	struct net_device *dev;
+	struct orinoco_private *priv;
+	struct orinoco_pccard *card;
+	dev_link_t *link;
+	client_reg_t client_reg;
+	int ret;
+
+	dev = alloc_orinocodev(sizeof(*card), spectrum_cs_hard_reset);
+	if (! dev)
+		return NULL;
+	priv = netdev_priv(dev);
+	card = priv->card;
+
+	/* Link both structures together */
+	link = &card->link;
+	link->priv = dev;
+
+	/* Interrupt setup */
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
+	link->irq.IRQInfo1 = IRQ_LEVEL_ID;
+	link->irq.Handler = orinoco_interrupt;
+	link->irq.Instance = dev; 
+
+	/* General socket configuration defaults can go here.  In this
+	 * client, we assume very little, and rely on the CIS for
+	 * almost everything.  In most clients, many details (i.e.,
+	 * number, sizes, and attributes of IO windows) are fixed by
+	 * the nature of the device, and can be hard-wired here. */
+	link->conf.Attributes = 0;
+	link->conf.IntType = INT_MEMORY_AND_IO;
+
+	/* Register with Card Services */
+	/* FIXME: need a lock? */
+	link->next = dev_list;
+	dev_list = link;
+
+	client_reg.dev_info = &dev_info;
+	client_reg.Version = 0x0210; /* FIXME: what does this mean? */
+	client_reg.event_callback_args.client_data = link;
+
+	ret = pcmcia_register_client(&link->handle, &client_reg);
+	if (ret != CS_SUCCESS) {
+		cs_error(link->handle, RegisterClient, ret);
+		spectrum_cs_detach(link);
+		return NULL;
+	}
+
+	return link;
+}				/* spectrum_cs_attach */
+
+/*
+ * This deletes a driver "instance".  The device is de-registered with
+ * Card Services.  If it has been released, all local data structures
+ * are freed.  Otherwise, the structures will be freed when the device
+ * is released.
+ */
+static void spectrum_cs_detach(dev_link_t *link)
+{
+	dev_link_t **linkp;
+	struct net_device *dev = link->priv;
+
+	/* Locate device structure */
+	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
+		if (*linkp == link)
+			break;
+
+	BUG_ON(*linkp == NULL);
+
+	if (link->state & DEV_CONFIG)
+		spectrum_cs_release(link);
+
+	/* Break the link with Card Services */
+	if (link->handle)
+		pcmcia_deregister_client(link->handle);
+
+	/* Unlink device structure, and free it */
+	*linkp = link->next;
+	DEBUG(0, PFX "detach: link=%p link->dev=%p\n", link, link->dev);
+	if (link->dev) {
+		DEBUG(0, PFX "About to unregister net device %p\n",
+		      dev);
+		unregister_netdev(dev);
+	}
+	free_orinocodev(dev);
+}				/* spectrum_cs_detach */
+
+/*
+ * spectrum_cs_config() is scheduled to run after a CARD_INSERTION
+ * event is received, to configure the PCMCIA socket, and to make the
+ * device available to the system.
+ */
+
+static void
+spectrum_cs_config(dev_link_t *link)
+{
+	struct net_device *dev = link->priv;
+	client_handle_t handle = link->handle;
+	struct orinoco_private *priv = netdev_priv(dev);
+	struct orinoco_pccard *card = priv->card;
+	hermes_t *hw = &priv->hw;
+	int last_fn, last_ret;
+	u_char buf[64];
+	config_info_t conf;
+	cisinfo_t info;
+	tuple_t tuple;
+	cisparse_t parse;
+	void __iomem *mem;
+
+	CS_CHECK(ValidateCIS, pcmcia_validate_cis(handle, &info));
+
+	/*
+	 * This reads the card's CONFIG tuple to find its
+	 * configuration registers.
+	 */
+	tuple.DesiredTuple = CISTPL_CONFIG;
+	tuple.Attributes = 0;
+	tuple.TupleData = buf;
+	tuple.TupleDataMax = sizeof(buf);
+	tuple.TupleOffset = 0;
+	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
+	CS_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
+	CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
+	link->conf.ConfigBase = parse.config.base;
+	link->conf.Present = parse.config.rmask[0];
+
+	/* Configure card */
+	link->state |= DEV_CONFIG;
+
+	/* Look up the current Vcc */
+	CS_CHECK(GetConfigurationInfo,
+		 pcmcia_get_configuration_info(handle, &conf));
+	link->conf.Vcc = conf.Vcc;
+
+	/*
+	 * In this loop, we scan the CIS for configuration table
+	 * entries, each of which describes a valid card
+	 * configuration, including voltage, IO window, memory window,
+	 * and interrupt settings.
+	 *
+	 * We make no assumptions about the card to be configured: we
+	 * use just the information available in the CIS.  In an ideal
+	 * world, this would work for any PCMCIA card, but it requires
+	 * a complete and accurate CIS.  In practice, a driver usually
+	 * "knows" most of these things without consulting the CIS,
+	 * and most client drivers will only use the CIS to fill in
+	 * implementation-defined details.
+	 */
+	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
+	while (1) {
+		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
+		cistpl_cftable_entry_t dflt = { .index = 0 };
+
+		if ( (pcmcia_get_tuple_data(handle, &tuple) != 0)
+		    || (pcmcia_parse_tuple(handle, &tuple, &parse) != 0))
+			goto next_entry;
+
+		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+			dflt = *cfg;
+		if (cfg->index == 0)
+			goto next_entry;
+		link->conf.ConfigIndex = cfg->index;
+
+		/* Does this card need audio output? */
+		if (cfg->flags & CISTPL_CFTABLE_AUDIO) {
+			link->conf.Attributes |= CONF_ENABLE_SPKR;
+			link->conf.Status = CCSR_AUDIO_ENA;
+		}
+
+		/* Use power settings for Vcc and Vpp if present */
+		/* Note that the CIS values need to be rescaled */
+		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "spectrum_cs_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
+				if (!ignore_cis_vcc)
+					goto next_entry;
+			}
+		} else if (dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (conf.Vcc != dflt.vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "spectrum_cs_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, dflt.vcc.param[CISTPL_POWER_VNOM] / 10000);
+				if(!ignore_cis_vcc)
+					goto next_entry;
+			}
+		}
+
+		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
+			link->conf.Vpp1 = link->conf.Vpp2 =
+			    cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+		else if (dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
+			link->conf.Vpp1 = link->conf.Vpp2 =
+			    dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
+		
+		/* Do we need to allocate an interrupt? */
+		link->conf.Attributes |= CONF_ENABLE_IRQ;
+
+		/* IO window settings */
+		link->io.NumPorts1 = link->io.NumPorts2 = 0;
+		if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
+			cistpl_io_t *io =
+			    (cfg->io.nwin) ? &cfg->io : &dflt.io;
+			link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
+			if (!(io->flags & CISTPL_IO_8BIT))
+				link->io.Attributes1 =
+				    IO_DATA_PATH_WIDTH_16;
+			if (!(io->flags & CISTPL_IO_16BIT))
+				link->io.Attributes1 =
+				    IO_DATA_PATH_WIDTH_8;
+			link->io.IOAddrLines =
+			    io->flags & CISTPL_IO_LINES_MASK;
+			link->io.BasePort1 = io->win[0].base;
+			link->io.NumPorts1 = io->win[0].len;
+			if (io->nwin > 1) {
+				link->io.Attributes2 =
+				    link->io.Attributes1;
+				link->io.BasePort2 = io->win[1].base;
+				link->io.NumPorts2 = io->win[1].len;
+			}
+
+			/* This reserves IO space but doesn't actually enable it */
+			if (pcmcia_request_io(link->handle, &link->io) != 0)
+				goto next_entry;
+		}
+
+
+		/* If we got this far, we're cool! */
+
+		break;
+		
+	next_entry:
+		if (link->io.NumPorts1)
+			pcmcia_release_io(link->handle, &link->io);
+		last_ret = pcmcia_get_next_tuple(handle, &tuple);
+		if (last_ret  == CS_NO_MORE_ITEMS) {
+			printk(KERN_ERR PFX "GetNextTuple(): No matching "
+			       "CIS configuration.  Maybe you need the "
+			       "ignore_cis_vcc=1 parameter.\n");
+			goto cs_failed;
+		}
+	}
+
+	/*
+	 * Allocate an interrupt line.  Note that this does not assign
+	 * a handler to the interrupt, unless the 'Handler' member of
+	 * the irq structure is initialized.
+	 */
+	CS_CHECK(RequestIRQ, pcmcia_request_irq(link->handle, &link->irq));
+
+	/* We initialize the hermes structure before completing PCMCIA
+	 * configuration just in case the interrupt handler gets
+	 * called. */
+	mem = ioport_map(link->io.BasePort1, link->io.NumPorts1);
+	if (!mem)
+		goto cs_failed;
+
+	hermes_struct_init(hw, mem, HERMES_16BIT_REGSPACING);
+
+	/*
+	 * This actually configures the PCMCIA socket -- setting up
+	 * the I/O windows and the interrupt mapping, and putting the
+	 * card and host interface into "Memory and IO" mode.
+	 */
+	CS_CHECK(RequestConfiguration,
+		 pcmcia_request_configuration(link->handle, &link->conf));
+
+	/* Ok, we have the configuration, prepare to register the netdev */
+	dev->base_addr = link->io.BasePort1;
+	dev->irq = link->irq.AssignedIRQ;
+	SET_MODULE_OWNER(dev);
+	card->node.major = card->node.minor = 0;
+
+	/* Reset card and download firmware */
+	if (spectrum_cs_hard_reset(priv) != 0) {
+		goto failed;
+	}
+
+	SET_NETDEV_DEV(dev, &handle_to_dev(handle));
+	/* Tell the stack we exist */
+	if (register_netdev(dev) != 0) {
+		printk(KERN_ERR PFX "register_netdev() failed\n");
+		goto failed;
+	}
+
+	/* At this point, the dev_node_t structure(s) needs to be
+	 * initialized and arranged in a linked list at link->dev. */
+	strcpy(card->node.dev_name, dev->name);
+	link->dev = &card->node; /* link->dev being non-NULL is also
+                                    used to indicate that the
+                                    net_device has been registered */
+	link->state &= ~DEV_CONFIG_PENDING;
+
+	/* Finally, report what we've done */
+	printk(KERN_DEBUG "%s: index 0x%02x: Vcc %d.%d",
+	       dev->name, link->conf.ConfigIndex,
+	       link->conf.Vcc / 10, link->conf.Vcc % 10);
+	if (link->conf.Vpp1)
+		printk(", Vpp %d.%d", link->conf.Vpp1 / 10,
+		       link->conf.Vpp1 % 10);
+	printk(", irq %d", link->irq.AssignedIRQ);
+	if (link->io.NumPorts1)
+		printk(", io 0x%04x-0x%04x", link->io.BasePort1,
+		       link->io.BasePort1 + link->io.NumPorts1 - 1);
+	if (link->io.NumPorts2)
+		printk(" & 0x%04x-0x%04x", link->io.BasePort2,
+		       link->io.BasePort2 + link->io.NumPorts2 - 1);
+	printk("\n");
+
+	return;
+
+ cs_failed:
+	cs_error(link->handle, last_fn, last_ret);
+
+ failed:
+	spectrum_cs_release(link);
+}				/* spectrum_cs_config */
+
+/*
+ * After a card is removed, spectrum_cs_release() will unregister the
+ * device, and release the PCMCIA configuration.  If the device is
+ * still open, this will be postponed until it is closed.
+ */
+static void
+spectrum_cs_release(dev_link_t *link)
+{
+	struct net_device *dev = link->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	/* We're committed to taking the device away now, so mark the
+	 * hardware as unavailable */
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->hw_unavailable++;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/* Don't bother checking to see if these succeed or not */
+	pcmcia_release_configuration(link->handle);
+	if (link->io.NumPorts1)
+		pcmcia_release_io(link->handle, &link->io);
+	if (link->irq.AssignedIRQ)
+		pcmcia_release_irq(link->handle, &link->irq);
+	link->state &= ~DEV_CONFIG;
+	if (priv->hw.iobase)
+		ioport_unmap(priv->hw.iobase);
+}				/* spectrum_cs_release */
+
+/*
+ * The card status event handler.  Mostly, this schedules other stuff
+ * to run after an event is received.
+ */
+static int
+spectrum_cs_event(event_t event, int priority,
+		       event_callback_args_t * args)
+{
+	dev_link_t *link = args->client_data;
+	struct net_device *dev = link->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
+	int err = 0;
+	unsigned long flags;
+
+	switch (event) {
+	case CS_EVENT_CARD_REMOVAL:
+		link->state &= ~DEV_PRESENT;
+		if (link->state & DEV_CONFIG) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&priv->lock, flags);
+			netif_device_detach(dev);
+			priv->hw_unavailable++;
+			spin_unlock_irqrestore(&priv->lock, flags);
+		}
+		break;
+
+	case CS_EVENT_CARD_INSERTION:
+		link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
+		spectrum_cs_config(link);
+		break;
+
+	case CS_EVENT_PM_SUSPEND:
+		link->state |= DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_RESET_PHYSICAL:
+		/* Mark the device as stopped, to block IO until later */
+		if (link->state & DEV_CONFIG) {
+			/* This is probably racy, but I can't think of
+                           a better way, short of rewriting the PCMCIA
+                           layer to not suck :-( */
+			spin_lock_irqsave(&priv->lock, flags);
+
+			err = __orinoco_down(dev);
+			if (err)
+				printk(KERN_WARNING "%s: %s: Error %d downing interface\n",
+				       dev->name,
+				       event == CS_EVENT_PM_SUSPEND ? "SUSPEND" : "RESET_PHYSICAL",
+				       err);
+
+			netif_device_detach(dev);
+			priv->hw_unavailable++;
+
+			spin_unlock_irqrestore(&priv->lock, flags);
+
+			pcmcia_release_configuration(link->handle);
+		}
+		break;
+
+	case CS_EVENT_PM_RESUME:
+		link->state &= ~DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_CARD_RESET:
+		if (link->state & DEV_CONFIG) {
+			/* FIXME: should we double check that this is
+			 * the same card as we had before */
+			pcmcia_request_configuration(link->handle, &link->conf);
+			netif_device_attach(dev);
+			priv->hw_unavailable--;
+			schedule_work(&priv->reset_work);
+		}
+		break;
+	}
+
+	return err;
+}				/* spectrum_cs_event */
+
+/********************************************************************/
+/* Module initialization					    */
+/********************************************************************/
+
+/* Can't be declared "const" or the whole __initdata section will
+ * become const */
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (Pavel Roskin <proski@gnu.org>,"
+	" David Gibson <hermes@gibson.dropbear.id.au>, et al)";
+
+static struct pcmcia_device_id spectrum_cs_ids[] = {
+	PCMCIA_DEVICE_MANF_CARD(0x026c, 0x0001), /* Symbol Spectrum24 LA4100 */
+	PCMCIA_DEVICE_MANF_CARD(0x0104, 0x0001), /* Socket Communications CF */
+	PCMCIA_DEVICE_MANF_CARD(0x0089, 0x0001), /* Intel PRO/Wireless 2011B */
+	PCMCIA_DEVICE_NULL,
+};
+MODULE_DEVICE_TABLE(pcmcia, spectrum_cs_ids);
+
+static struct pcmcia_driver orinoco_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= DRIVER_NAME,
+	},
+	.attach		= spectrum_cs_attach,
+	.event		= spectrum_cs_event,
+	.detach		= spectrum_cs_detach,
+	.id_table       = spectrum_cs_ids,
+};
+
+static int __init
+init_spectrum_cs(void)
+{
+	printk(KERN_DEBUG "%s\n", version);
+
+	return pcmcia_register_driver(&orinoco_driver);
+}
+
+static void __exit
+exit_spectrum_cs(void)
+{
+	pcmcia_unregister_driver(&orinoco_driver);
+	BUG_ON(dev_list != NULL);
+}
+
+module_init(init_spectrum_cs);
+module_exit(exit_spectrum_cs);
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -695,7 +695,7 @@ static int ethtool_get_stats(struct net_
 	return ret;
 }
 
-static int ethtool_get_perm_addr(struct net_device *dev, void *useraddr)
+static int ethtool_get_perm_addr(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_perm_addr epaddr;
 	u8 *data;
