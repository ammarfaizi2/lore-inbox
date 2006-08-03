Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWHCVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWHCVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWHCVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:55:27 -0400
Received: from havoc.gtf.org ([69.61.125.42]:4737 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030182AbWHCVzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:55:24 -0400
Date: Thu, 3 Aug 2006 17:55:22 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20060803215522.GA15952@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/myri10ge/myri10ge.c         |   24 -
 drivers/net/phy/phy.c                   |    8 
 drivers/net/s2io.c                      |  386 ++++++++++++++------------------
 drivers/net/s2io.h                      |   10 
 drivers/net/wireless/zd1211rw/zd_chip.c |    4 
 drivers/net/wireless/zd1211rw/zd_chip.h |   10 
 drivers/net/wireless/zd1211rw/zd_mac.c  |   16 -
 drivers/net/wireless/zd1211rw/zd_usb.c  |    7 
 8 files changed, 215 insertions(+), 250 deletions(-)

Ananda Raju:
      s2io driver bug fixes #1
      s2io driver bug fixes #2

Brice Goglin:
      myri10ge - Write the firmware in 256-bytes chunks
      myri10ge - Fix spurious invokations of the watchdog reset handler

Daniel Drake:
      zd1211rw: Pass more management frame types up to host
      zd1211rw: Fix software encryption/decryption
      zd1211rw: Remove bogus assert

Sergei Shtylylov:
      Stop calling phy_stop_interrupts() twice

Ulrich Kunitz:
      zd1211rw: Fixes radiotap header
      zd1211rw: Fixed endianess issue with length info tag detection
      zd1211rw: Packet filter fix for managed (STA) mode

diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index c3e52c8..06440a8 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -177,6 +177,7 @@ struct myri10ge_priv {
 	struct work_struct watchdog_work;
 	struct timer_list watchdog_timer;
 	int watchdog_tx_done;
+	int watchdog_tx_req;
 	int watchdog_resets;
 	int tx_linearized;
 	int pause;
@@ -448,6 +449,7 @@ static int myri10ge_load_hotplug_firmwar
 	struct mcp_gen_header *hdr;
 	size_t hdr_offset;
 	int status;
+	unsigned i;
 
 	if ((status = request_firmware(&fw, mgp->fw_name, dev)) < 0) {
 		dev_err(dev, "Unable to load %s firmware image via hotplug\n",
@@ -479,18 +481,12 @@ static int myri10ge_load_hotplug_firmwar
 		goto abort_with_fw;
 
 	crc = crc32(~0, fw->data, fw->size);
-	if (mgp->tx.boundary == 2048) {
-		/* Avoid PCI burst on chipset with unaligned completions. */
-		int i;
-		__iomem u32 *ptr = (__iomem u32 *) (mgp->sram +
-						    MYRI10GE_FW_OFFSET);
-		for (i = 0; i < fw->size / 4; i++) {
-			__raw_writel(((u32 *) fw->data)[i], ptr + i);
-			wmb();
-		}
-	} else {
-		myri10ge_pio_copy(mgp->sram + MYRI10GE_FW_OFFSET, fw->data,
-				  fw->size);
+	for (i = 0; i < fw->size; i += 256) {
+		myri10ge_pio_copy(mgp->sram + MYRI10GE_FW_OFFSET + i,
+				  fw->data + i,
+				  min(256U, (unsigned)(fw->size - i)));
+		mb();
+		readb(mgp->sram);
 	}
 	/* corruption checking is good for parity recovery and buggy chipset */
 	memcpy_fromio(fw->data, mgp->sram + MYRI10GE_FW_OFFSET, fw->size);
@@ -2547,7 +2543,8 @@ static void myri10ge_watchdog_timer(unsi
 
 	mgp = (struct myri10ge_priv *)arg;
 	if (mgp->tx.req != mgp->tx.done &&
-	    mgp->tx.done == mgp->watchdog_tx_done)
+	    mgp->tx.done == mgp->watchdog_tx_done &&
+	    mgp->watchdog_tx_req != mgp->watchdog_tx_done)
 		/* nic seems like it might be stuck.. */
 		schedule_work(&mgp->watchdog_work);
 	else
@@ -2556,6 +2553,7 @@ static void myri10ge_watchdog_timer(unsi
 			  jiffies + myri10ge_watchdog_timeout * HZ);
 
 	mgp->watchdog_tx_done = mgp->tx.done;
+	mgp->watchdog_tx_req = mgp->tx.req;
 }
 
 static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 7d5c223..f5aad77 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -419,9 +419,8 @@ void phy_start_machine(struct phy_device
 
 /* phy_stop_machine
  *
- * description: Stops the state machine timer, sets the state to
- *   UP (unless it wasn't up yet), and then frees the interrupt,
- *   if it is in use. This function must be called BEFORE
+ * description: Stops the state machine timer, sets the state to UP
+ *   (unless it wasn't up yet). This function must be called BEFORE
  *   phy_detach.
  */
 void phy_stop_machine(struct phy_device *phydev)
@@ -433,9 +432,6 @@ void phy_stop_machine(struct phy_device 
 		phydev->state = PHY_UP;
 	spin_unlock(&phydev->lock);
 
-	if (phydev->irq != PHY_POLL)
-		phy_stop_interrupts(phydev);
-
 	phydev->adjust_state = NULL;
 }
 
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index e1fe3a0..132ed32 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -76,7 +76,7 @@ #include <asm/div64.h>
 #include "s2io.h"
 #include "s2io-regs.h"
 
-#define DRV_VERSION "2.0.14.2"
+#define DRV_VERSION "2.0.15.2"
 
 /* S2io Driver name & version. */
 static char s2io_driver_name[] = "Neterion";
@@ -370,38 +370,50 @@ static const u64 fix_mac[] = {
 	END_SIGN
 };
 
+MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@neterion.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+
 /* Module Loadable parameters. */
-static unsigned int tx_fifo_num = 1;
-static unsigned int tx_fifo_len[MAX_TX_FIFOS] =
-    {DEFAULT_FIFO_0_LEN, [1 ...(MAX_TX_FIFOS - 1)] = DEFAULT_FIFO_1_7_LEN};
-static unsigned int rx_ring_num = 1;
-static unsigned int rx_ring_sz[MAX_RX_RINGS] =
-    {[0 ...(MAX_RX_RINGS - 1)] = SMALL_BLK_CNT};
-static unsigned int rts_frm_len[MAX_RX_RINGS] =
-    {[0 ...(MAX_RX_RINGS - 1)] = 0 };
-static unsigned int rx_ring_mode = 1;
-static unsigned int use_continuous_tx_intrs = 1;
-static unsigned int rmac_pause_time = 0x100;
-static unsigned int mc_pause_threshold_q0q3 = 187;
-static unsigned int mc_pause_threshold_q4q7 = 187;
-static unsigned int shared_splits;
-static unsigned int tmac_util_period = 5;
-static unsigned int rmac_util_period = 5;
-static unsigned int bimodal = 0;
-static unsigned int l3l4hdr_size = 128;
-#ifndef CONFIG_S2IO_NAPI
-static unsigned int indicate_max_pkts;
-#endif
+S2IO_PARM_INT(tx_fifo_num, 1);
+S2IO_PARM_INT(rx_ring_num, 1);
+
+
+S2IO_PARM_INT(rx_ring_mode, 1);
+S2IO_PARM_INT(use_continuous_tx_intrs, 1);
+S2IO_PARM_INT(rmac_pause_time, 0x100);
+S2IO_PARM_INT(mc_pause_threshold_q0q3, 187);
+S2IO_PARM_INT(mc_pause_threshold_q4q7, 187);
+S2IO_PARM_INT(shared_splits, 0);
+S2IO_PARM_INT(tmac_util_period, 5);
+S2IO_PARM_INT(rmac_util_period, 5);
+S2IO_PARM_INT(bimodal, 0);
+S2IO_PARM_INT(l3l4hdr_size, 128);
 /* Frequency of Rx desc syncs expressed as power of 2 */
-static unsigned int rxsync_frequency = 3;
+S2IO_PARM_INT(rxsync_frequency, 3);
 /* Interrupt type. Values can be 0(INTA), 1(MSI), 2(MSI_X) */
-static unsigned int intr_type = 0;
+S2IO_PARM_INT(intr_type, 0);
 /* Large receive offload feature */
-static unsigned int lro = 0;
+S2IO_PARM_INT(lro, 0);
 /* Max pkts to be aggregated by LRO at one time. If not specified,
  * aggregation happens until we hit max IP pkt size(64K)
  */
-static unsigned int lro_max_pkts = 0xFFFF;
+S2IO_PARM_INT(lro_max_pkts, 0xFFFF);
+#ifndef CONFIG_S2IO_NAPI
+S2IO_PARM_INT(indicate_max_pkts, 0);
+#endif
+
+static unsigned int tx_fifo_len[MAX_TX_FIFOS] =
+    {DEFAULT_FIFO_0_LEN, [1 ...(MAX_TX_FIFOS - 1)] = DEFAULT_FIFO_1_7_LEN};
+static unsigned int rx_ring_sz[MAX_RX_RINGS] =
+    {[0 ...(MAX_RX_RINGS - 1)] = SMALL_BLK_CNT};
+static unsigned int rts_frm_len[MAX_RX_RINGS] =
+    {[0 ...(MAX_RX_RINGS - 1)] = 0 };
+
+module_param_array(tx_fifo_len, uint, NULL, 0);
+module_param_array(rx_ring_sz, uint, NULL, 0);
+module_param_array(rts_frm_len, uint, NULL, 0);
 
 /*
  * S2IO device table.
@@ -464,10 +476,9 @@ static int init_shared_mem(struct s2io_n
 		size += config->tx_cfg[i].fifo_len;
 	}
 	if (size > MAX_AVAILABLE_TXDS) {
-		DBG_PRINT(ERR_DBG, "%s: Requested TxDs too high, ",
-			  __FUNCTION__);
+		DBG_PRINT(ERR_DBG, "s2io: Requested TxDs too high, ");
 		DBG_PRINT(ERR_DBG, "Requested: %d, max supported: 8192\n", size);
-		return FAILURE;
+		return -EINVAL;
 	}
 
 	lst_size = (sizeof(TxD_t) * config->max_txds);
@@ -547,6 +558,7 @@ static int init_shared_mem(struct s2io_n
 	nic->ufo_in_band_v = kmalloc((sizeof(u64) * size), GFP_KERNEL);
 	if (!nic->ufo_in_band_v)
 		return -ENOMEM;
+	memset(nic->ufo_in_band_v, 0, size);
 
 	/* Allocation and initialization of RXDs in Rings */
 	size = 0;
@@ -1213,7 +1225,7 @@ static int init_nic(struct s2io_nic *nic
 		break;
 	}
 
-	/* Enable Tx FIFO partition 0. */
+	/* Enable all configured Tx FIFO partitions */
 	val64 = readq(&bar0->tx_fifo_partition_0);
 	val64 |= (TX_FIFO_PARTITION_EN);
 	writeq(val64, &bar0->tx_fifo_partition_0);
@@ -1650,7 +1662,7 @@ static void en_dis_able_nic_intrs(struct
 			writeq(temp64, &bar0->general_int_mask);
 			/*
 			 * If Hercules adapter enable GPIO otherwise
-			 * disabled all PCIX, Flash, MDIO, IIC and GPIO
+			 * disable all PCIX, Flash, MDIO, IIC and GPIO
 			 * interrupts for now.
 			 * TODO
 			 */
@@ -2119,7 +2131,7 @@ static struct sk_buff *s2io_txdl_getskb(
 				       frag->size, PCI_DMA_TODEVICE);
 		}
 	}
-	txdlp->Host_Control = 0;
+	memset(txdlp,0, (sizeof(TxD_t) * fifo_data->max_txds));
 	return(skb);
 }
 
@@ -2371,9 +2383,14 @@ #endif
 			skb->data = (void *) (unsigned long)tmp;
 			skb->tail = (void *) (unsigned long)tmp;
 
-			((RxD3_t*)rxdp)->Buffer0_ptr =
-			    pci_map_single(nic->pdev, ba->ba_0, BUF0_LEN,
+			if (!(((RxD3_t*)rxdp)->Buffer0_ptr))
+				((RxD3_t*)rxdp)->Buffer0_ptr =
+				   pci_map_single(nic->pdev, ba->ba_0, BUF0_LEN,
 					   PCI_DMA_FROMDEVICE);
+			else
+				pci_dma_sync_single_for_device(nic->pdev,
+				    (dma_addr_t) ((RxD3_t*)rxdp)->Buffer0_ptr,
+				    BUF0_LEN, PCI_DMA_FROMDEVICE);
 			rxdp->Control_2 = SET_BUFFER0_SIZE_3(BUF0_LEN);
 			if (nic->rxd_mode == RXD_MODE_3B) {
 				/* Two buffer mode */
@@ -2386,10 +2403,13 @@ #endif
 				(nic->pdev, skb->data, dev->mtu + 4,
 						PCI_DMA_FROMDEVICE);
 
-				/* Buffer-1 will be dummy buffer not used */
-				((RxD3_t*)rxdp)->Buffer1_ptr =
-				pci_map_single(nic->pdev, ba->ba_1, BUF1_LEN,
-					PCI_DMA_FROMDEVICE);
+				/* Buffer-1 will be dummy buffer. Not used */
+				if (!(((RxD3_t*)rxdp)->Buffer1_ptr)) {
+					((RxD3_t*)rxdp)->Buffer1_ptr =
+						pci_map_single(nic->pdev, 
+						ba->ba_1, BUF1_LEN,
+						PCI_DMA_FROMDEVICE);
+				}
 				rxdp->Control_2 |= SET_BUFFER1_SIZE_3(1);
 				rxdp->Control_2 |= SET_BUFFER2_SIZE_3
 								(dev->mtu + 4);
@@ -2614,23 +2634,23 @@ no_rx:
 }
 #endif
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
 /**
- * s2io_netpoll - Rx interrupt service handler for netpoll support
+ * s2io_netpoll - netpoll event handler entry point
  * @dev : pointer to the device structure.
  * Description:
- * Polling 'interrupt' - used by things like netconsole to send skbs
- * without having to re-enable interrupts. It's not called while
- * the interrupt routine is executing.
+ * 	This function will be called by upper layer to check for events on the
+ * interface in situations where interrupts are disabled. It is used for
+ * specific in-kernel networking tasks, such as remote consoles and kernel
+ * debugging over the network (example netdump in RedHat).
  */
-
-#ifdef CONFIG_NET_POLL_CONTROLLER
 static void s2io_netpoll(struct net_device *dev)
 {
 	nic_t *nic = dev->priv;
 	mac_info_t *mac_control;
 	struct config_param *config;
 	XENA_dev_config_t __iomem *bar0 = nic->bar0;
-	u64 val64;
+	u64 val64 = 0xFFFFFFFFFFFFFFFFULL;
 	int i;
 
 	disable_irq(dev->irq);
@@ -2639,9 +2659,17 @@ static void s2io_netpoll(struct net_devi
 	mac_control = &nic->mac_control;
 	config = &nic->config;
 
-	val64 = readq(&bar0->rx_traffic_int);
 	writeq(val64, &bar0->rx_traffic_int);
+	writeq(val64, &bar0->tx_traffic_int);
 
+	/* we need to free up the transmitted skbufs or else netpoll will 
+	 * run out of skbs and will fail and eventually netpoll application such
+	 * as netdump will fail.
+	 */
+	for (i = 0; i < config->tx_fifo_num; i++)
+		tx_intr_handler(&mac_control->fifos[i]);
+
+	/* check for received packet and indicate up to network */
 	for (i = 0; i < config->rx_ring_num; i++)
 		rx_intr_handler(&mac_control->rings[i]);
 
@@ -2708,7 +2736,7 @@ #endif
 		/* If your are next to put index then it's FIFO full condition */
 		if ((get_block == put_block) &&
 		    (get_info.offset + 1) == put_info.offset) {
-			DBG_PRINT(ERR_DBG, "%s: Ring Full\n",dev->name);
+			DBG_PRINT(INTR_DBG, "%s: Ring Full\n",dev->name);
 			break;
 		}
 		skb = (struct sk_buff *) ((unsigned long)rxdp->Host_Control);
@@ -2728,18 +2756,15 @@ #endif
 				 HEADER_SNAP_SIZE,
 				 PCI_DMA_FROMDEVICE);
 		} else if (nic->rxd_mode == RXD_MODE_3B) {
-			pci_unmap_single(nic->pdev, (dma_addr_t)
+			pci_dma_sync_single_for_cpu(nic->pdev, (dma_addr_t)
 				 ((RxD3_t*)rxdp)->Buffer0_ptr,
 				 BUF0_LEN, PCI_DMA_FROMDEVICE);
 			pci_unmap_single(nic->pdev, (dma_addr_t)
-				 ((RxD3_t*)rxdp)->Buffer1_ptr,
-				 BUF1_LEN, PCI_DMA_FROMDEVICE);
-			pci_unmap_single(nic->pdev, (dma_addr_t)
 				 ((RxD3_t*)rxdp)->Buffer2_ptr,
 				 dev->mtu + 4,
 				 PCI_DMA_FROMDEVICE);
 		} else {
-			pci_unmap_single(nic->pdev, (dma_addr_t)
+			pci_dma_sync_single_for_cpu(nic->pdev, (dma_addr_t)
 					 ((RxD3_t*)rxdp)->Buffer0_ptr, BUF0_LEN,
 					 PCI_DMA_FROMDEVICE);
 			pci_unmap_single(nic->pdev, (dma_addr_t)
@@ -3327,7 +3352,7 @@ static void s2io_reset(nic_t * sp)
 
 	/* Clear certain PCI/PCI-X fields after reset */
 	if (sp->device_type == XFRAME_II_DEVICE) {
-		/* Clear parity err detect bit */
+		/* Clear "detected parity error" bit */
 		pci_write_config_word(sp->pdev, PCI_STATUS, 0x8000);
 
 		/* Clearing PCIX Ecc status register */
@@ -3528,7 +3553,7 @@ static void restore_xmsi_data(nic_t *nic
 	u64 val64;
 	int i;
 
-	for (i=0; i< nic->avail_msix_vectors; i++) {
+	for (i=0; i < MAX_REQUESTED_MSI_X; i++) {
 		writeq(nic->msix_info[i].addr, &bar0->xmsi_address);
 		writeq(nic->msix_info[i].data, &bar0->xmsi_data);
 		val64 = (BIT(7) | BIT(15) | vBIT(i, 26, 6));
@@ -3547,7 +3572,7 @@ static void store_xmsi_data(nic_t *nic)
 	int i;
 
 	/* Store and display */
-	for (i=0; i< nic->avail_msix_vectors; i++) {
+	for (i=0; i < MAX_REQUESTED_MSI_X; i++) {
 		val64 = (BIT(15) | vBIT(i, 26, 6));
 		writeq(val64, &bar0->xmsi_access);
 		if (wait_for_msix_trans(nic, i)) {
@@ -3808,13 +3833,11 @@ static int s2io_xmit(struct sk_buff *skb
 	TxD_t *txdp;
 	TxFIFO_element_t __iomem *tx_fifo;
 	unsigned long flags;
-#ifdef NETIF_F_TSO
-	int mss;
-#endif
 	u16 vlan_tag = 0;
 	int vlan_priority = 0;
 	mac_info_t *mac_control;
 	struct config_param *config;
+	int offload_type;
 
 	mac_control = &sp->mac_control;
 	config = &sp->config;
@@ -3862,13 +3885,11 @@ #endif
 		return 0;
 	}
 
-	txdp->Control_1 = 0;
-	txdp->Control_2 = 0;
+	offload_type = s2io_offload_type(skb);
 #ifdef NETIF_F_TSO
-	mss = skb_shinfo(skb)->gso_size;
-	if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
 		txdp->Control_1 |= TXD_TCP_LSO_EN;
-		txdp->Control_1 |= TXD_TCP_LSO_MSS(mss);
+		txdp->Control_1 |= TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
 	}
 #endif
 	if (skb->ip_summed == CHECKSUM_HW) {
@@ -3886,10 +3907,10 @@ #endif
 	}
 
 	frg_len = skb->len - skb->data_len;
-	if (skb_shinfo(skb)->gso_type == SKB_GSO_UDP) {
+	if (offload_type == SKB_GSO_UDP) {
 		int ufo_size;
 
-		ufo_size = skb_shinfo(skb)->gso_size;
+		ufo_size = s2io_udp_mss(skb);
 		ufo_size &= ~7;
 		txdp->Control_1 |= TXD_UFO_EN;
 		txdp->Control_1 |= TXD_UFO_MSS(ufo_size);
@@ -3906,16 +3927,13 @@ #endif
 					sp->ufo_in_band_v,
 					sizeof(u64), PCI_DMA_TODEVICE);
 		txdp++;
-		txdp->Control_1 = 0;
-		txdp->Control_2 = 0;
 	}
 
 	txdp->Buffer_Pointer = pci_map_single
 	    (sp->pdev, skb->data, frg_len, PCI_DMA_TODEVICE);
 	txdp->Host_Control = (unsigned long) skb;
 	txdp->Control_1 |= TXD_BUFFER0_SIZE(frg_len);
-
-	if (skb_shinfo(skb)->gso_type == SKB_GSO_UDP)
+	if (offload_type == SKB_GSO_UDP)
 		txdp->Control_1 |= TXD_UFO_EN;
 
 	frg_cnt = skb_shinfo(skb)->nr_frags;
@@ -3930,12 +3948,12 @@ #endif
 		    (sp->pdev, frag->page, frag->page_offset,
 		     frag->size, PCI_DMA_TODEVICE);
 		txdp->Control_1 = TXD_BUFFER0_SIZE(frag->size);
-		if (skb_shinfo(skb)->gso_type == SKB_GSO_UDP)
+		if (offload_type == SKB_GSO_UDP)
 			txdp->Control_1 |= TXD_UFO_EN;
 	}
 	txdp->Control_1 |= TXD_GATHER_CODE_LAST;
 
-	if (skb_shinfo(skb)->gso_type == SKB_GSO_UDP)
+	if (offload_type == SKB_GSO_UDP)
 		frg_cnt++; /* as Txd0 was used for inband header */
 
 	tx_fifo = mac_control->tx_FIFO_start[queue];
@@ -3944,13 +3962,9 @@ #endif
 
 	val64 = (TX_FIFO_LAST_TXD_NUM(frg_cnt) | TX_FIFO_FIRST_LIST |
 		 TX_FIFO_LAST_LIST);
-
-#ifdef NETIF_F_TSO
-	if (mss)
-		val64 |= TX_FIFO_SPECIAL_FUNC;
-#endif
-	if (skb_shinfo(skb)->gso_type == SKB_GSO_UDP)
+	if (offload_type)
 		val64 |= TX_FIFO_SPECIAL_FUNC;
+
 	writeq(val64, &tx_fifo->List_Control);
 
 	mmiowb();
@@ -3984,13 +3998,41 @@ s2io_alarm_handle(unsigned long data)
 	mod_timer(&sp->alarm_timer, jiffies + HZ / 2);
 }
 
+static int s2io_chk_rx_buffers(nic_t *sp, int rng_n)
+{
+	int rxb_size, level;
+
+	if (!sp->lro) {
+		rxb_size = atomic_read(&sp->rx_bufs_left[rng_n]);
+		level = rx_buffer_level(sp, rxb_size, rng_n);
+
+		if ((level == PANIC) && (!TASKLET_IN_USE)) {
+			int ret;
+			DBG_PRINT(INTR_DBG, "%s: Rx BD hit ", __FUNCTION__);
+			DBG_PRINT(INTR_DBG, "PANIC levels\n");
+			if ((ret = fill_rx_buffers(sp, rng_n)) == -ENOMEM) {
+				DBG_PRINT(ERR_DBG, "Out of memory in %s",
+					  __FUNCTION__);
+				clear_bit(0, (&sp->tasklet_status));
+				return -1;
+			}
+			clear_bit(0, (&sp->tasklet_status));
+		} else if (level == LOW)
+			tasklet_schedule(&sp->task);
+
+	} else if (fill_rx_buffers(sp, rng_n) == -ENOMEM) {
+			DBG_PRINT(ERR_DBG, "%s:Out of memory", sp->dev->name);
+			DBG_PRINT(ERR_DBG, " in Rx Intr!!\n");
+	}
+	return 0;
+}
+
 static irqreturn_t
 s2io_msi_handle(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	nic_t *sp = dev->priv;
 	int i;
-	int ret;
 	mac_info_t *mac_control;
 	struct config_param *config;
 
@@ -4012,35 +4054,8 @@ s2io_msi_handle(int irq, void *dev_id, s
 	 * reallocate the buffers from the interrupt handler itself,
 	 * else schedule a tasklet to reallocate the buffers.
 	 */
-	for (i = 0; i < config->rx_ring_num; i++) {
-		if (!sp->lro) {
-			int rxb_size = atomic_read(&sp->rx_bufs_left[i]);
-			int level = rx_buffer_level(sp, rxb_size, i);
-
-			if ((level == PANIC) && (!TASKLET_IN_USE)) {
-				DBG_PRINT(INTR_DBG, "%s: Rx BD hit ", 
-							dev->name);
-				DBG_PRINT(INTR_DBG, "PANIC levels\n");
-				if ((ret = fill_rx_buffers(sp, i)) == -ENOMEM) {
-					DBG_PRINT(ERR_DBG, "%s:Out of memory",
-						  dev->name);
-					DBG_PRINT(ERR_DBG, " in ISR!!\n");
-					clear_bit(0, (&sp->tasklet_status));
-					atomic_dec(&sp->isr_cnt);
-					return IRQ_HANDLED;
-				}
-				clear_bit(0, (&sp->tasklet_status));
-			} else if (level == LOW) {
-				tasklet_schedule(&sp->task);
-			}
-		}
-		else if (fill_rx_buffers(sp, i) == -ENOMEM) {
-				DBG_PRINT(ERR_DBG, "%s:Out of memory",
-							dev->name);
-				DBG_PRINT(ERR_DBG, " in Rx Intr!!\n");
-				break;
-		}
-	}
+	for (i = 0; i < config->rx_ring_num; i++)
+		s2io_chk_rx_buffers(sp, i);
 
 	atomic_dec(&sp->isr_cnt);
 	return IRQ_HANDLED;
@@ -4051,39 +4066,13 @@ s2io_msix_ring_handle(int irq, void *dev
 {
 	ring_info_t *ring = (ring_info_t *)dev_id;
 	nic_t *sp = ring->nic;
-	struct net_device *dev = (struct net_device *) dev_id;
-	int rxb_size, level, rng_n;
 
 	atomic_inc(&sp->isr_cnt);
-	rx_intr_handler(ring);
-
-	rng_n = ring->ring_no;
-	if (!sp->lro) {
-		rxb_size = atomic_read(&sp->rx_bufs_left[rng_n]);
-		level = rx_buffer_level(sp, rxb_size, rng_n);
 
-		if ((level == PANIC) && (!TASKLET_IN_USE)) {
-			int ret;
-			DBG_PRINT(INTR_DBG, "%s: Rx BD hit ", __FUNCTION__);
-			DBG_PRINT(INTR_DBG, "PANIC levels\n");
-			if ((ret = fill_rx_buffers(sp, rng_n)) == -ENOMEM) {
-				DBG_PRINT(ERR_DBG, "Out of memory in %s",
-					  __FUNCTION__);
-				clear_bit(0, (&sp->tasklet_status));
-				return IRQ_HANDLED;
-			}
-			clear_bit(0, (&sp->tasklet_status));
-		} else if (level == LOW) {
-			tasklet_schedule(&sp->task);
-		}
-	}
-	else if (fill_rx_buffers(sp, rng_n) == -ENOMEM) {
-			DBG_PRINT(ERR_DBG, "%s:Out of memory", dev->name);
-			DBG_PRINT(ERR_DBG, " in Rx Intr!!\n");
-	}
+	rx_intr_handler(ring);
+	s2io_chk_rx_buffers(sp, ring->ring_no);
 
 	atomic_dec(&sp->isr_cnt);
-
 	return IRQ_HANDLED;
 }
 
@@ -4248,37 +4237,8 @@ #endif
 	 * else schedule a tasklet to reallocate the buffers.
 	 */
 #ifndef CONFIG_S2IO_NAPI
-	for (i = 0; i < config->rx_ring_num; i++) {
-		if (!sp->lro) {
-			int ret;
-			int rxb_size = atomic_read(&sp->rx_bufs_left[i]);
-			int level = rx_buffer_level(sp, rxb_size, i);
-
-			if ((level == PANIC) && (!TASKLET_IN_USE)) {
-				DBG_PRINT(INTR_DBG, "%s: Rx BD hit ", 
-							dev->name);
-				DBG_PRINT(INTR_DBG, "PANIC levels\n");
-				if ((ret = fill_rx_buffers(sp, i)) == -ENOMEM) {
-					DBG_PRINT(ERR_DBG, "%s:Out of memory",
-						  dev->name);
-					DBG_PRINT(ERR_DBG, " in ISR!!\n");
-					clear_bit(0, (&sp->tasklet_status));
-					atomic_dec(&sp->isr_cnt);
-					writeq(org_mask, &bar0->general_int_mask);
-					return IRQ_HANDLED;
-				}
-				clear_bit(0, (&sp->tasklet_status));
-			} else if (level == LOW) {
-				tasklet_schedule(&sp->task);
-			}
-		}
-		else if (fill_rx_buffers(sp, i) == -ENOMEM) {
-				DBG_PRINT(ERR_DBG, "%s:Out of memory",
-							dev->name);
-				DBG_PRINT(ERR_DBG, " in Rx intr!!\n");
-				break;
-		}
-	}
+	for (i = 0; i < config->rx_ring_num; i++)
+		s2io_chk_rx_buffers(sp, i);
 #endif
 	writeq(org_mask, &bar0->general_int_mask);
 	atomic_dec(&sp->isr_cnt);
@@ -4308,6 +4268,8 @@ static void s2io_updt_stats(nic_t *sp)
 			if (cnt == 5)
 				break; /* Updt failed */
 		} while(1);
+	} else {
+		memset(sp->mac_control.stats_info, 0, sizeof(StatInfo_t));
 	}
 }
 
@@ -4942,7 +4904,8 @@ static int write_eeprom(nic_t * sp, int 
 }
 static void s2io_vpd_read(nic_t *nic)
 {
-	u8 vpd_data[256],data;
+	u8 *vpd_data;
+	u8 data;
 	int i=0, cnt, fail = 0;
 	int vpd_addr = 0x80;
 
@@ -4955,6 +4918,10 @@ static void s2io_vpd_read(nic_t *nic)
 		vpd_addr = 0x50;
 	}
 
+	vpd_data = kmalloc(256, GFP_KERNEL);
+	if (!vpd_data)
+		return;
+
 	for (i = 0; i < 256; i +=4 ) {
 		pci_write_config_byte(nic->pdev, (vpd_addr + 2), i);
 		pci_read_config_byte(nic->pdev,  (vpd_addr + 2), &data);
@@ -4977,6 +4944,7 @@ static void s2io_vpd_read(nic_t *nic)
 		memset(nic->product_name, 0, vpd_data[1]);
 		memcpy(nic->product_name, &vpd_data[3], vpd_data[1]);
 	}
+	kfree(vpd_data);
 }
 
 /**
@@ -5295,7 +5263,7 @@ static int s2io_link_test(nic_t * sp, ui
 	else
 		*data = 0;
 
-	return 0;
+	return *data;
 }
 
 /**
@@ -5753,6 +5721,19 @@ static int s2io_ethtool_op_set_tx_csum(s
 	return 0;
 }
 
+static u32 s2io_ethtool_op_get_tso(struct net_device *dev)
+{
+	return (dev->features & NETIF_F_TSO) != 0;
+}
+static int s2io_ethtool_op_set_tso(struct net_device *dev, u32 data)
+{
+	if (data)
+		dev->features |= (NETIF_F_TSO | NETIF_F_TSO6);
+	else
+		dev->features &= ~(NETIF_F_TSO | NETIF_F_TSO6);
+
+	return 0;
+}
 
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_settings = s2io_ethtool_gset,
@@ -5773,8 +5754,8 @@ static struct ethtool_ops netdev_ethtool
 	.get_sg = ethtool_op_get_sg,
 	.set_sg = ethtool_op_set_sg,
 #ifdef NETIF_F_TSO
-	.get_tso = ethtool_op_get_tso,
-	.set_tso = ethtool_op_set_tso,
+	.get_tso = s2io_ethtool_op_get_tso,
+	.set_tso = s2io_ethtool_op_set_tso,
 #endif
 	.get_ufo = ethtool_op_get_ufo,
 	.set_ufo = ethtool_op_set_ufo,
@@ -6337,7 +6318,7 @@ static int s2io_card_up(nic_t * sp)
 	s2io_set_multicast(dev);
 
 	if (sp->lro) {
-		/* Initialize max aggregatable pkts based on MTU */
+		/* Initialize max aggregatable pkts per session based on MTU */
 		sp->lro_max_aggr_per_sess = ((1<<16) - 1) / dev->mtu;
 		/* Check if we can use(if specified) user provided value */
 		if (lro_max_pkts < sp->lro_max_aggr_per_sess)
@@ -6438,7 +6419,7 @@ static void s2io_tx_watchdog(struct net_
  *   @cksum : FCS checksum of the frame.
  *   @ring_no : the ring from which this RxD was extracted.
  *   Description:
- *   This function is called by the Tx interrupt serivce routine to perform
+ *   This function is called by the Rx interrupt serivce routine to perform
  *   some OS related operations on the SKB before passing it to the upper
  *   layers. It mainly checks if the checksum is OK, if so adds it to the
  *   SKBs cksum variable, increments the Rx packet count and passes the SKB
@@ -6698,33 +6679,6 @@ static void s2io_init_pci(nic_t * sp)
 	pci_read_config_word(sp->pdev, PCI_COMMAND, &pci_cmd);
 }
 
-MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@neterion.com>");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
-
-module_param(tx_fifo_num, int, 0);
-module_param(rx_ring_num, int, 0);
-module_param(rx_ring_mode, int, 0);
-module_param_array(tx_fifo_len, uint, NULL, 0);
-module_param_array(rx_ring_sz, uint, NULL, 0);
-module_param_array(rts_frm_len, uint, NULL, 0);
-module_param(use_continuous_tx_intrs, int, 1);
-module_param(rmac_pause_time, int, 0);
-module_param(mc_pause_threshold_q0q3, int, 0);
-module_param(mc_pause_threshold_q4q7, int, 0);
-module_param(shared_splits, int, 0);
-module_param(tmac_util_period, int, 0);
-module_param(rmac_util_period, int, 0);
-module_param(bimodal, bool, 0);
-module_param(l3l4hdr_size, int , 0);
-#ifndef CONFIG_S2IO_NAPI
-module_param(indicate_max_pkts, int, 0);
-#endif
-module_param(rxsync_frequency, int, 0);
-module_param(intr_type, int, 0);
-module_param(lro, int, 0);
-module_param(lro_max_pkts, int, 0);
-
 static int s2io_verify_parm(struct pci_dev *pdev, u8 *dev_intr_type)
 {
 	if ( tx_fifo_num > 8) {
@@ -6832,8 +6786,8 @@ s2io_init_nic(struct pci_dev *pdev, cons
 	}
 	if (dev_intr_type != MSI_X) {
 		if (pci_request_regions(pdev, s2io_driver_name)) {
-			DBG_PRINT(ERR_DBG, "Request Regions failed\n"),
-			    pci_disable_device(pdev);
+			DBG_PRINT(ERR_DBG, "Request Regions failed\n");
+			pci_disable_device(pdev);
 			return -ENODEV;
 		}
 	}
@@ -6957,7 +6911,7 @@ s2io_init_nic(struct pci_dev *pdev, cons
 	/*  initialize the shared memory used by the NIC and the host */
 	if (init_shared_mem(sp)) {
 		DBG_PRINT(ERR_DBG, "%s: Memory allocation failed\n",
-			  __FUNCTION__);
+			  dev->name);
 		ret = -ENOMEM;
 		goto mem_alloc_failed;
 	}
@@ -7094,6 +7048,9 @@ #endif
 	dev->addr_len = ETH_ALEN;
 	memcpy(dev->dev_addr, sp->def_mac_addr, ETH_ALEN);
 
+	/* reset Nic and bring it to known state */
+	s2io_reset(sp);
+
 	/*
 	 * Initialize the tasklet status and link state flags
 	 * and the card state parameter
@@ -7131,11 +7088,11 @@ #endif
 		goto register_failed;
 	}
 	s2io_vpd_read(sp);
-	DBG_PRINT(ERR_DBG, "%s: Neterion %s",dev->name, sp->product_name);
-	DBG_PRINT(ERR_DBG, "(rev %d), Driver version %s\n",
-				get_xena_rev_id(sp->pdev),
-				s2io_driver_version);
 	DBG_PRINT(ERR_DBG, "Copyright(c) 2002-2005 Neterion Inc.\n");
+	DBG_PRINT(ERR_DBG, "%s: Neterion %s (rev %d)\n",dev->name,
+		  sp->product_name, get_xena_rev_id(sp->pdev));
+	DBG_PRINT(ERR_DBG, "%s: Driver version %s\n", dev->name,
+		  s2io_driver_version);
 	DBG_PRINT(ERR_DBG, "%s: MAC ADDR: "
 			  "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
 			  sp->def_mac_addr[0].mac_addr[0],
@@ -7436,8 +7393,13 @@ static int verify_l3_l4_lro_capable(lro_
 	if (ip->ihl != 5) /* IP has options */
 		return -1;
 
+	/* If we see CE codepoint in IP header, packet is not mergeable */
+	if (INET_ECN_is_ce(ipv4_get_dsfield(ip)))
+		return -1;
+
+	/* If we see ECE or CWR flags in TCP header, packet is not mergeable */
 	if (tcp->urg || tcp->psh || tcp->rst || tcp->syn || tcp->fin ||
-								!tcp->ack) {
+				    tcp->ece || tcp->cwr || !tcp->ack) {
 		/*
 		 * Currently recognize only the ack control word and
 		 * any other control field being set would result in
@@ -7591,18 +7553,16 @@ #endif
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb,
 			   u32 tcp_len)
 {
-	struct sk_buff *tmp, *first = lro->parent;
+	struct sk_buff *first = lro->parent;
 
 	first->len += tcp_len;
 	first->data_len = lro->frags_len;
 	skb_pull(skb, (skb->len - tcp_len));
-	if ((tmp = skb_shinfo(first)->frag_list)) {
-		while (tmp->next)
-			tmp = tmp->next;
-		tmp->next = skb;
-	}
+	if (skb_shinfo(first)->frag_list)
+		lro->last_frag->next = skb;
 	else
 		skb_shinfo(first)->frag_list = skb;
+	lro->last_frag = skb;
 	sp->mac_control.stats_info->sw_stat.clubbed_frms_cnt++;
 	return;
 }
diff --git a/drivers/net/s2io.h b/drivers/net/s2io.h
index 217097b..5ed49c3 100644
--- a/drivers/net/s2io.h
+++ b/drivers/net/s2io.h
@@ -719,6 +719,7 @@ struct msix_info_st {
 /* Data structure to represent a LRO session */
 typedef struct lro {
 	struct sk_buff	*parent;
+	struct sk_buff  *last_frag;
 	u8		*l2h;
 	struct iphdr	*iph;
 	struct tcphdr	*tcph;
@@ -1011,4 +1012,13 @@ static void clear_lro_session(lro_t *lro
 static void queue_rx_frame(struct sk_buff *skb);
 static void update_L3L4_header(nic_t *sp, lro_t *lro);
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb, u32 tcp_len);
+
+#define s2io_tcp_mss(skb) skb_shinfo(skb)->gso_size
+#define s2io_udp_mss(skb) skb_shinfo(skb)->gso_size
+#define s2io_offload_type(skb) skb_shinfo(skb)->gso_type
+
+#define S2IO_PARM_INT(X, def_val) \
+	static unsigned int X = def_val;\
+		module_param(X , uint, 0);
+
 #endif				/* _S2IO_H */
diff --git a/drivers/net/wireless/zd1211rw/zd_chip.c b/drivers/net/wireless/zd1211rw/zd_chip.c
index efc9c4b..da9d06b 100644
--- a/drivers/net/wireless/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zd1211rw/zd_chip.c
@@ -797,7 +797,7 @@ static int zd1211_hw_init_hmac(struct zd
 		{ CR_ADDA_MBIAS_WARMTIME,	0x30000808 },
 		{ CR_ZD1211_RETRY_MAX,		0x2 },
 		{ CR_SNIFFER_ON,		0 },
-		{ CR_RX_FILTER,			AP_RX_FILTER },
+		{ CR_RX_FILTER,			STA_RX_FILTER },
 		{ CR_GROUP_HASH_P1,		0x00 },
 		{ CR_GROUP_HASH_P2,		0x80000000 },
 		{ CR_REG1,			0xa4 },
@@ -844,7 +844,7 @@ static int zd1211b_hw_init_hmac(struct z
 		{ CR_ZD1211B_AIFS_CTL2,		0x008C003C },
 		{ CR_ZD1211B_TXOP,		0x01800824 },
 		{ CR_SNIFFER_ON,		0 },
-		{ CR_RX_FILTER,			AP_RX_FILTER },
+		{ CR_RX_FILTER,			STA_RX_FILTER },
 		{ CR_GROUP_HASH_P1,		0x00 },
 		{ CR_GROUP_HASH_P2,		0x80000000 },
 		{ CR_REG1,			0xa4 },
diff --git a/drivers/net/wireless/zd1211rw/zd_chip.h b/drivers/net/wireless/zd1211rw/zd_chip.h
index 8051210..069d2b4 100644
--- a/drivers/net/wireless/zd1211rw/zd_chip.h
+++ b/drivers/net/wireless/zd1211rw/zd_chip.h
@@ -461,10 +461,15 @@ #define CR_UNDERRUN_CNT			CTL_REG(0x0688
 
 #define CR_RX_FILTER			CTL_REG(0x068c)
 #define RX_FILTER_ASSOC_RESPONSE	0x0002
+#define RX_FILTER_REASSOC_RESPONSE	0x0008
 #define RX_FILTER_PROBE_RESPONSE	0x0020
 #define RX_FILTER_BEACON		0x0100
+#define RX_FILTER_DISASSOC		0x0400
 #define RX_FILTER_AUTH			0x0800
-/* Sniff modus sets filter to 0xfffff */
+#define AP_RX_FILTER			0x0400feff
+#define STA_RX_FILTER			0x0000ffff
+
+/* Monitor mode sets filter to 0xfffff */
 
 #define CR_ACK_TIMEOUT_EXT		CTL_REG(0x0690)
 #define CR_BCN_FIFO_SEMAPHORE		CTL_REG(0x0694)
@@ -546,9 +551,6 @@ #define CR_ZD1211B_AIFS_CTL2		CTL_REG(0x
 #define CR_ZD1211B_TXOP			CTL_REG(0x0b20)
 #define CR_ZD1211B_RETRY_MAX		CTL_REG(0x0b28)
 
-#define AP_RX_FILTER			0x0400feff
-#define STA_RX_FILTER			0x0000ffff
-
 #define CWIN_SIZE			0x007f043f
 
 
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index 3bdc54d..d6f3e02 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -108,7 +108,9 @@ int zd_mac_init_hw(struct zd_mac *mac, u
 	if (r)
 		goto disable_int;
 
-	r = zd_set_encryption_type(chip, NO_WEP);
+	/* We must inform the device that we are doing encryption/decryption in
+	 * software at the moment. */
+	r = zd_set_encryption_type(chip, ENC_SNIFFER);
 	if (r)
 		goto disable_int;
 
@@ -136,10 +138,8 @@ static int reset_mode(struct zd_mac *mac
 {
 	struct ieee80211_device *ieee = zd_mac_to_ieee80211(mac);
 	struct zd_ioreq32 ioreqs[3] = {
-		{ CR_RX_FILTER, RX_FILTER_BEACON|RX_FILTER_PROBE_RESPONSE|
-			        RX_FILTER_AUTH|RX_FILTER_ASSOC_RESPONSE },
+		{ CR_RX_FILTER, STA_RX_FILTER },
 		{ CR_SNIFFER_ON, 0U },
-		{ CR_ENCRYPTION_TYPE, NO_WEP },
 	};
 
 	if (ieee->iw_mode == IW_MODE_MONITOR) {
@@ -713,10 +713,10 @@ static int zd_mac_tx(struct zd_mac *mac,
 struct zd_rt_hdr {
 	struct ieee80211_radiotap_header rt_hdr;
 	u8  rt_flags;
+	u8  rt_rate;
 	u16 rt_channel;
 	u16 rt_chbitmask;
-	u16 rt_rate;
-};
+} __attribute__((packed));
 
 static void fill_rt_header(void *buffer, struct zd_mac *mac,
 	                   const struct ieee80211_rx_stats *stats,
@@ -735,14 +735,14 @@ static void fill_rt_header(void *buffer,
 	if (status->decryption_type & (ZD_RX_WEP64|ZD_RX_WEP128|ZD_RX_WEP256))
 		hdr->rt_flags |= IEEE80211_RADIOTAP_F_WEP;
 
+	hdr->rt_rate = stats->rate / 5;
+
 	/* FIXME: 802.11a */
 	hdr->rt_channel = cpu_to_le16(ieee80211chan2mhz(
 		                             _zd_chip_get_channel(&mac->chip)));
 	hdr->rt_chbitmask = cpu_to_le16(IEEE80211_CHAN_2GHZ |
 		((status->frame_status & ZD_RX_FRAME_MODULATION_MASK) ==
 		ZD_RX_OFDM ? IEEE80211_CHAN_OFDM : IEEE80211_CHAN_CCK));
-
-	hdr->rt_rate = stats->rate / 5;
 }
 
 /* Returns 1 if the data packet is for us and 0 otherwise. */
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 72f9052..6320984 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -323,7 +323,6 @@ static void disable_read_regs_int(struct
 {
 	struct zd_usb_interrupt *intr = &usb->intr;
 
-	ZD_ASSERT(in_interrupt());
 	spin_lock(&intr->lock);
 	intr->read_regs_enabled = 0;
 	spin_unlock(&intr->lock);
@@ -545,11 +544,11 @@ static void handle_rx_packet(struct zd_u
 	 * be padded. Unaligned access might also happen if the length_info
 	 * structure is not present.
 	 */
-	if (get_unaligned(&length_info->tag) == RX_LENGTH_INFO_TAG) {
+	if (get_unaligned(&length_info->tag) == cpu_to_le16(RX_LENGTH_INFO_TAG))
+	{
 		unsigned int l, k, n;
 		for (i = 0, l = 0;; i++) {
-			k = le16_to_cpu(get_unaligned(
-				&length_info->length[i]));
+			k = le16_to_cpu(get_unaligned(&length_info->length[i]));
 			n = l+k;
 			if (n > length)
 				return;
