Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUCRJ5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCRJ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:57:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262478AbUCRJyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:54:09 -0500
Message-ID: <405971B3.3080700@pobox.com>
Date: Thu, 18 Mar 2004 04:53:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
References: <16473.28514.341276.209224@alkaid.it.uu.se> <40597123.8020903@pobox.com>
In-Reply-To: <40597123.8020903@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------040200060305080103060502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040200060305080103060502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

er, oops... lemme find the right patch...



--------------040200060305080103060502
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/tulip/21142.c b/drivers/net/tulip/21142.c
--- a/drivers/net/tulip/21142.c	Mon Mar 15 21:48:00 2004
+++ b/drivers/net/tulip/21142.c	Mon Mar 15 21:48:00 2004
@@ -29,7 +29,7 @@
 void t21142_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int csr12 = inl(ioaddr + CSR12);
 	int next_tick = 60*HZ;
@@ -103,7 +103,7 @@
 
 void t21142_start_nway(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int csr14 = ((tp->sym_advertise & 0x0780) << 9)  |
 		((tp->sym_advertise & 0x0020) << 1) | 0xffbf;
@@ -131,7 +131,7 @@
 
 void t21142_lnk_change(struct net_device *dev, int csr5)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int csr12 = inl(ioaddr + CSR12);
 
diff -Nru a/drivers/net/tulip/eeprom.c b/drivers/net/tulip/eeprom.c
--- a/drivers/net/tulip/eeprom.c	Mon Mar 15 21:48:08 2004
+++ b/drivers/net/tulip/eeprom.c	Mon Mar 15 21:48:08 2004
@@ -136,7 +136,7 @@
 	static struct mediatable *last_mediatable;
 	static unsigned char *last_ee_data;
 	static int controller_index;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	unsigned char *ee_data = tp->eeprom;
 	int i;
 
diff -Nru a/drivers/net/tulip/interrupt.c b/drivers/net/tulip/interrupt.c
--- a/drivers/net/tulip/interrupt.c	Mon Mar 15 21:48:00 2004
+++ b/drivers/net/tulip/interrupt.c	Mon Mar 15 21:48:00 2004
@@ -63,7 +63,7 @@
 
 int tulip_refill_rx(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int entry;
 	int refilled = 0;
 
@@ -109,7 +109,7 @@
 
 int tulip_poll(struct net_device *dev, int *budget)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int entry = tp->cur_rx % RX_RING_SIZE;
 	int rx_work_limit = *budget;
 	int received = 0;
@@ -191,9 +191,9 @@
                                    && (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
                                        skb->dev = dev;
                                        skb_reserve(skb, 2);    /* 16 byte align the IP header */
-                                       pci_dma_sync_single(tp->pdev,
-                                                           tp->rx_buffers[entry].mapping,
-                                                           pkt_len, PCI_DMA_FROMDEVICE);
+                                       pci_dma_sync_single_for_cpu(tp->pdev,
+								   tp->rx_buffers[entry].mapping,
+								   pkt_len, PCI_DMA_FROMDEVICE);
 #if ! defined(__alpha__)
                                        eth_copy_and_sum(skb, tp->rx_buffers[entry].skb->tail,
                                                         pkt_len, 0);
@@ -203,6 +203,9 @@
                                               tp->rx_buffers[entry].skb->tail,
                                               pkt_len);
 #endif
+                                       pci_dma_sync_single_for_device(tp->pdev,
+								      tp->rx_buffers[entry].mapping,
+								      pkt_len, PCI_DMA_FROMDEVICE);
                                } else {        /* Pass up the skb already on the Rx ring. */
                                        char *temp = skb_put(skb = tp->rx_buffers[entry].skb,
                                                             pkt_len);
@@ -354,7 +357,7 @@
 
 static int tulip_rx(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int entry = tp->cur_rx % RX_RING_SIZE;
 	int rx_work_limit = tp->dirty_rx + RX_RING_SIZE - tp->cur_rx;
 	int received = 0;
@@ -412,9 +415,9 @@
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
-				pci_dma_sync_single(tp->pdev,
-						    tp->rx_buffers[entry].mapping,
-						    pkt_len, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single_for_cpu(tp->pdev,
+							    tp->rx_buffers[entry].mapping,
+							    pkt_len, PCI_DMA_FROMDEVICE);
 #if ! defined(__alpha__)
 				eth_copy_and_sum(skb, tp->rx_buffers[entry].skb->tail,
 						 pkt_len, 0);
@@ -424,6 +427,9 @@
 				       tp->rx_buffers[entry].skb->tail,
 				       pkt_len);
 #endif
+				pci_dma_sync_single_for_device(tp->pdev,
+							       tp->rx_buffers[entry].mapping,
+							       pkt_len, PCI_DMA_FROMDEVICE);
 			} else { 	/* Pass up the skb already on the Rx ring. */
 				char *temp = skb_put(skb = tp->rx_buffers[entry].skb,
 						     pkt_len);
@@ -465,7 +471,7 @@
 {
 #ifdef __hppa__
 	int csr12 = inl(dev->base_addr + CSR12) & 0xff;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 
 	if (csr12 != tp->csr12_shadow) {
 		/* ack interrupt */
@@ -490,7 +496,7 @@
 irqreturn_t tulip_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *)dev_instance;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int csr5;
 	int missed;
diff -Nru a/drivers/net/tulip/media.c b/drivers/net/tulip/media.c
--- a/drivers/net/tulip/media.c	Mon Mar 15 21:48:00 2004
+++ b/drivers/net/tulip/media.c	Mon Mar 15 21:48:00 2004
@@ -48,7 +48,7 @@
 
 int tulip_mdio_read(struct net_device *dev, int phy_id, int location)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int i;
 	int read_cmd = (0xf6 << 10) | ((phy_id & 0x1f) << 5) | location;
 	int retval = 0;
@@ -111,7 +111,7 @@
 
 void tulip_mdio_write(struct net_device *dev, int phy_id, int location, int val)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int i;
 	int cmd = (0x5002 << 16) | ((phy_id & 0x1f) << 23) | (location<<18) | (val & 0xffff);
 	long ioaddr = dev->base_addr;
@@ -171,7 +171,7 @@
 void tulip_select_media(struct net_device *dev, int startup)
 {
 	long ioaddr = dev->base_addr;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	struct mediatable *mtable = tp->mtable;
 	u32 new_csr6;
 	int i;
@@ -374,7 +374,7 @@
   */
 int tulip_check_duplex(struct net_device *dev)
 {
-	struct tulip_private *tp = dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	unsigned int bmsr, lpa, negotiated, new_csr6;
 
 	bmsr = tulip_mdio_read(dev, tp->phys[0], MII_BMSR);
@@ -420,7 +420,7 @@
 
 void __devinit tulip_find_mii (struct net_device *dev, int board_idx)
 {
-	struct tulip_private *tp = dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int phyn, phy_idx = 0;
 	int mii_reg0;
 	int mii_advert;
diff -Nru a/drivers/net/tulip/pnic.c b/drivers/net/tulip/pnic.c
--- a/drivers/net/tulip/pnic.c	Mon Mar 15 21:48:02 2004
+++ b/drivers/net/tulip/pnic.c	Mon Mar 15 21:48:02 2004
@@ -20,7 +20,7 @@
 
 void pnic_do_nway(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	u32 phy_reg = inl(ioaddr + 0xB8);
 	u32 new_csr6 = tp->csr6 & ~0x40C40200;
@@ -53,7 +53,7 @@
 
 void pnic_lnk_change(struct net_device *dev, int csr5)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int phy_reg = inl(ioaddr + 0xB8);
 
@@ -89,7 +89,7 @@
 void pnic_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
 
diff -Nru a/drivers/net/tulip/pnic2.c b/drivers/net/tulip/pnic2.c
--- a/drivers/net/tulip/pnic2.c	Mon Mar 15 21:48:00 2004
+++ b/drivers/net/tulip/pnic2.c	Mon Mar 15 21:48:00 2004
@@ -84,7 +84,7 @@
 void pnic2_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
 
@@ -100,7 +100,7 @@
 
 void pnic2_start_nway(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
         int csr14;
         int csr12;
@@ -175,7 +175,7 @@
 
 void pnic2_lnk_change(struct net_device *dev, int csr5)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
         int csr14;
 
diff -Nru a/drivers/net/tulip/timer.c b/drivers/net/tulip/timer.c
--- a/drivers/net/tulip/timer.c	Mon Mar 15 21:47:59 2004
+++ b/drivers/net/tulip/timer.c	Mon Mar 15 21:47:59 2004
@@ -20,7 +20,7 @@
 void tulip_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	u32 csr12 = inl(ioaddr + CSR12);
 	int next_tick = 2*HZ;
@@ -135,7 +135,7 @@
 void mxic_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
 
@@ -152,7 +152,7 @@
 void comet_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
 
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Mon Mar 15 21:48:02 2004
+++ b/drivers/net/tulip/tulip_core.c	Mon Mar 15 21:48:02 2004
@@ -253,7 +253,7 @@
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
-
+static void poll_tulip(struct net_device *dev);
 
 
 static void tulip_set_power_state (struct tulip_private *tp,
@@ -276,7 +276,7 @@
 
 static void tulip_up(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 3*HZ;
 	int i;
@@ -499,7 +499,7 @@
 
 static void tulip_tx_timeout(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	unsigned long flags;
 
@@ -587,7 +587,7 @@
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void tulip_init_ring(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int i;
 
 	tp->susp_rx = 0;
@@ -638,7 +638,7 @@
 static int
 tulip_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int entry;
 	u32 flag;
 	dma_addr_t mapping;
@@ -724,7 +724,7 @@
 static void tulip_down (struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct tulip_private *tp = (struct tulip_private *) dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	unsigned long flags;
 
 	del_timer_sync (&tp->timer);
@@ -764,7 +764,7 @@
 static int tulip_close (struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct tulip_private *tp = (struct tulip_private *) dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	int i;
 
 	netif_stop_queue (dev);
@@ -811,7 +811,7 @@
 
 static struct net_device_stats *tulip_get_stats(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	if (netif_running(dev)) {
@@ -830,7 +830,7 @@
 
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
-	struct tulip_private *np = dev->priv;
+	struct tulip_private *np = netdev_priv(dev);
 	u32 ethcmd;
 
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
@@ -855,7 +855,7 @@
 /* Provide ioctl() calls to examine the MII xcvr state. */
 static int private_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct tulip_private *tp = dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	const unsigned int phy_idx = 0;
@@ -964,7 +964,7 @@
 
 static void build_setup_frame_hash(u16 *setup_frm, struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	u16 hash_table[32];
 	struct dev_mc_list *mclist;
 	int i;
@@ -995,7 +995,7 @@
 
 static void build_setup_frame_perfect(u16 *setup_frm, struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	struct dev_mc_list *mclist;
 	int i;
 	u16 *eaddrs;
@@ -1023,7 +1023,7 @@
 
 static void set_rx_mode(struct net_device *dev)
 {
-	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int csr6;
 
@@ -1150,7 +1150,7 @@
 static void __devinit tulip_mwi_config (struct pci_dev *pdev,
 					struct net_device *dev)
 {
-	struct tulip_private *tp = dev->priv;
+	struct tulip_private *tp = netdev_priv(dev);
 	u8 cache;
 	u16 pci_command;
 	u32 csr0;
@@ -1373,7 +1373,7 @@
 	 * initialize private data structure 'tp'
 	 * it is zeroed and aligned in alloc_etherdev
 	 */
-	tp = dev->priv;
+	tp = netdev_priv(dev);
 
 	tp->rx_ring = pci_alloc_consistent(pdev,
 					   sizeof(struct tulip_rx_desc) * RX_RING_SIZE +
@@ -1618,6 +1618,9 @@
 	dev->get_stats = tulip_get_stats;
 	dev->do_ioctl = private_ioctl;
 	dev->set_multicast_list = set_rx_mode;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = &poll_tulip;
+#endif
 
 	if (register_netdev(dev))
 		goto err_out_free_ring;
@@ -1756,7 +1759,7 @@
 	if (!dev)
 		return;
 
-	tp = dev->priv;
+	tp = netdev_priv(dev);
 	pci_free_consistent (pdev,
 			     sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
 			     sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
@@ -1774,6 +1777,22 @@
 	/* pci_power_off (pdev, -1); */
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_tulip (struct net_device *dev)
+{
+	/* disable_irq here is not very nice, but with the lockless
+	   interrupt handler we have no other choice. */
+	disable_irq(dev->irq);
+	tulip_interrupt (dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
 
 static struct pci_driver tulip_driver = {
 	.name		= DRV_NAME,

--------------040200060305080103060502--

