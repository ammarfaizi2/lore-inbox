Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWEJVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWEJVmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWEJVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:42:50 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:62648 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S965032AbWEJVmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:42:47 -0400
Date: Wed, 10 May 2006 14:42:41 -0700 (PDT)
From: Brice Goglin <bgoglin@myri.com>
To: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>
cc: LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, <brice@myri.com>
Subject: [PATCH 5/6] myri10ge - Second half of the driver
In-Reply-To: <446259A0.8050504@myri.com>
Message-ID: <Pine.GSO.4.44.0605101441510.498-100000@adel.myri.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 5/6] myri10ge - Second half of the driver

The second half of the myri10ge driver core.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 myri10ge.c | 1540 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1540 insertions(+)

--- linux/drivers/net/myri10ge/myri10ge.c.old	2006-05-09 23:00:54.000000000 +0200
+++ linux/drivers/net/myri10ge/myri10ge.c	2006-05-09 23:00:54.000000000 +0200
@@ -1481,3 +1481,1543 @@ static struct ethtool_ops myri10ge_ethto
 	.get_stats_count		= myri10ge_get_stats_count,
 	.get_ethtool_stats		= myri10ge_get_ethtool_stats
 };
+
+static int
+myri10ge_open(struct net_device *dev)
+{
+	struct myri10ge_priv *mgp;
+	size_t bytes;
+	myri10ge_cmd_t cmd;
+	int tx_ring_size, rx_ring_size;
+	int tx_ring_entries, rx_ring_entries;
+	int i, status, big_pow2;
+
+	mgp = dev->priv;
+
+	if (mgp->running != MYRI10GE_ETH_STOPPED)
+		return -EBUSY;
+
+	mgp->running = MYRI10GE_ETH_STARTING;
+	status = myri10ge_reset(mgp);
+	if (status != 0) {
+		printk(KERN_ERR "myri10ge: %s: failed reset\n", dev->name);
+		mgp->running = MYRI10GE_ETH_STOPPED;
+		return -ENXIO;
+	}
+
+	/* decide what small buffer size to use.  For good TCP rx
+	 * performance, it is important to not receive 1514 byte
+	 * frames into jumbo buffers, as it confuses the socket buffer
+	 * accounting code, leading to drops and erratic performance.
+	 */
+
+	if (dev->mtu <= ETH_DATA_LEN) {
+		mgp->small_bytes = 128;			/* enough for a TCP header */
+	} else {
+		mgp->small_bytes = ETH_FRAME_LEN;	/* enough for an ETH_DATA_LEN frame */
+	}
+	/* Override the small buffer size? */
+	if (myri10ge_small_bytes > 0) {
+		mgp->small_bytes = myri10ge_small_bytes;
+	}
+
+	/* If the user sets an obscenely small MTU, adjust the small
+	 * bytes down to nearly nothing */
+	if (mgp->small_bytes >= (dev->mtu + ETH_HLEN))
+		mgp->small_bytes = 64;
+
+	/* get ring sizes */
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_GET_SEND_RING_SIZE, &cmd);
+	tx_ring_size = cmd.data0;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_GET_RX_RING_SIZE, &cmd);
+	rx_ring_size = cmd.data0;
+
+	/* get the lanai pointers to the send and receive rings */
+
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_GET_SEND_OFFSET, &cmd);
+	mgp->tx.lanai = (mcp_kreq_ether_send_t __iomem *) (mgp->sram + cmd.data0);
+
+
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_GET_SMALL_RX_OFFSET, &cmd);
+	mgp->rx_small.lanai = (mcp_kreq_ether_recv_t __iomem *) (mgp->sram + cmd.data0);
+
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_GET_BIG_RX_OFFSET, &cmd);
+	mgp->rx_big.lanai = (mcp_kreq_ether_recv_t __iomem *) (mgp->sram + cmd.data0);
+
+	if (status != 0) {
+		printk(KERN_ERR "myri10ge: %s: failed to get ring sizes or locations\n",
+		      dev->name);
+		mgp->running = MYRI10GE_ETH_STOPPED;
+		return -ENXIO;
+	}
+
+	if (mgp->mtrr >= 0) {
+		mgp->tx.wc_fifo = mgp->sram + 0x200000;
+		mgp->rx_small.wc_fifo = mgp->sram + 0x300000;
+		mgp->rx_big.wc_fifo = mgp->sram + 0x340000;
+	} else {
+		mgp->tx.wc_fifo = NULL;
+		mgp->rx_small.wc_fifo = NULL;
+		mgp->rx_big.wc_fifo = NULL;
+	}
+
+	tx_ring_entries = tx_ring_size / sizeof (mcp_kreq_ether_send_t);
+	rx_ring_entries = rx_ring_size / sizeof (mcp_dma_addr_t);
+	mgp->tx.mask = tx_ring_entries - 1;
+	mgp->rx_small.mask = mgp->rx_big.mask = rx_ring_entries - 1;
+
+	/* allocate the host shadow rings */
+
+	bytes = 8 + (MYRI10GE_MCP_ETHER_MAX_SEND_DESC_TSO + 4)
+		* sizeof (*mgp->tx.req_list);
+	mgp->tx.req_bytes = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->tx.req_bytes == NULL)
+		goto abort_with_nothing;
+	memset(mgp->tx.req_bytes, 0, bytes);
+
+	/* ensure req_list entries are aligned to 8 bytes */
+	mgp->tx.req_list = (mcp_kreq_ether_send_t *)
+		((unsigned long)(mgp->tx.req_bytes + 7) & ~7UL);
+
+	bytes = rx_ring_entries * sizeof (*mgp->rx_small.shadow);
+	mgp->rx_small.shadow = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->rx_small.shadow == NULL)
+		goto abort_with_tx_req_bytes;
+	memset(mgp->rx_small.shadow, 0, bytes);
+
+	bytes = rx_ring_entries * sizeof (*mgp->rx_big.shadow);
+	mgp->rx_big.shadow = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->rx_big.shadow == NULL)
+		goto abort_with_rx_small_shadow;
+	memset(mgp->rx_big.shadow, 0, bytes);
+
+	/* allocate the host info rings */
+
+	bytes = tx_ring_entries * sizeof (*mgp->tx.info);
+	mgp->tx.info = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->tx.info == NULL)
+		goto abort_with_rx_big_shadow;
+	memset(mgp->tx.info, 0, bytes);
+
+	bytes = rx_ring_entries * sizeof (*mgp->rx_small.info);
+	mgp->rx_small.info = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->rx_small.info == NULL)
+		goto abort_with_tx_info;
+	memset(mgp->rx_small.info, 0, bytes);
+
+	bytes = rx_ring_entries * sizeof (*mgp->rx_big.info);
+	mgp->rx_big.info = kmalloc(bytes, GFP_KERNEL);
+	if (mgp->rx_big.info == NULL)
+		goto abort_with_rx_small_info;
+	memset(mgp->rx_big.info, 0, bytes);
+
+	/* Fill the receive rings */
+	for (i = 0; i <= mgp->rx_small.mask; i++) {
+		status = myri10ge_getbuf(&mgp->rx_small, mgp->pdev,
+					 mgp->small_bytes, i);
+		if (status) {
+			printk(KERN_ERR "myri10ge: %s: alloced only %d small bufs\n",
+			       dev->name, i);
+			goto abort_with_rx_small_ring;
+		}
+	}
+
+	for (i = 0; i <= mgp->rx_big.mask; i++) {
+		status = myri10ge_getbuf(&mgp->rx_big, mgp->pdev, dev->mtu + ETH_HLEN, i);
+		if (status) {
+			printk(KERN_ERR "myri10ge: %s: alloced only %d big bufs\n",
+			       dev->name, i);
+			goto abort_with_rx_big_ring;
+		}
+	}
+
+	/* Firmware needs the big buff size as a power of 2.  Lie and
+	 * tell him the buffer is larger, because we only use 1
+	 * buffer/pkt, and the mtu will prevent overruns.
+	 */
+	big_pow2 = dev->mtu + ETH_HLEN + MYRI10GE_MCP_ETHER_PAD;
+	while ((big_pow2 & (big_pow2 - 1)) != 0)
+		big_pow2++;
+
+	/* now give firmware buffers sizes, and MTU */
+	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_MTU, &cmd);
+	cmd.data0 = mgp->small_bytes;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_SMALL_BUFFER_SIZE, &cmd);
+	cmd.data0 = big_pow2;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_BIG_BUFFER_SIZE, &cmd);
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Couldn't set buffer sizes\n",
+		       dev->name);
+		goto abort_with_rx_big_ring;
+	}
+
+	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->fw_stats_bus);
+	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->fw_stats_bus);
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_STATS_DMA, &cmd);
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Couldn't set stats DMA\n",
+		       dev->name);
+		goto abort_with_rx_big_ring;
+	}
+
+	mgp->link_state = -1;
+	mgp->rdma_tags_available = 15;
+
+	if (myri10ge_napi) /* must happen prior to any irq */
+		netif_poll_enable(mgp->dev);
+
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_ETHERNET_UP, &cmd);
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Couldn't bring up link\n",
+		       dev->name);
+		goto abort_with_rx_big_ring;
+	}
+
+	mgp->wake_queue = 0;
+	mgp->stop_queue = 0;
+	mgp->running = MYRI10GE_ETH_RUNNING;
+	mgp->watchdog_timer.expires =
+		jiffies + myri10ge_watchdog_timeout * HZ;
+	add_timer(&mgp->watchdog_timer);
+	netif_wake_queue(dev);
+	return 0;
+
+abort_with_rx_big_ring:
+	for (i = 0; i <= mgp->rx_big.mask; i++) {
+		if (mgp->rx_big.info[i].skb != NULL)
+			dev_kfree_skb_any(mgp->rx_big.info[i].skb);
+		if (pci_unmap_len(&mgp->rx_big.info[i], len)) {
+			pci_unmap_single(mgp->pdev,
+					 pci_unmap_addr(&mgp->rx_big.info[i], bus),
+					 pci_unmap_len(&mgp->rx_big.info[i], len),
+					 PCI_DMA_FROMDEVICE);
+		}
+	}
+
+abort_with_rx_small_ring:
+	for (i = 0; i <= mgp->rx_small.mask; i++) {
+		if (mgp->rx_small.info[i].skb != NULL)
+			dev_kfree_skb_any(mgp->rx_small.info[i].skb);
+		if (pci_unmap_len(&mgp->rx_small.info[i], len)) {
+			pci_unmap_single(mgp->pdev,
+					 pci_unmap_addr(&mgp->rx_small.info[i], bus),
+					 pci_unmap_len(&mgp->rx_small.info[i], len),
+					 PCI_DMA_FROMDEVICE);
+		}
+	}
+	kfree(mgp->rx_big.info);
+
+abort_with_rx_small_info:
+	kfree(mgp->rx_small.info);
+
+abort_with_tx_info:
+	kfree(mgp->tx.info);
+
+abort_with_rx_big_shadow:
+	kfree(mgp->rx_big.shadow);
+
+abort_with_rx_small_shadow:
+	kfree(mgp->rx_small.shadow);
+
+abort_with_tx_req_bytes:
+	kfree(mgp->tx.req_bytes);
+	mgp->tx.req_bytes = NULL;
+	mgp->tx.req_list = NULL;
+
+abort_with_nothing:
+	mgp->running = MYRI10GE_ETH_STOPPED;
+	return -ENOMEM;
+
+}
+static int
+myri10ge_close(struct net_device *dev)
+{
+	struct myri10ge_priv *mgp;
+	struct sk_buff *skb;
+	myri10ge_tx_buf_t *tx;
+	int status, i, old_down_cnt, len, idx;
+	myri10ge_cmd_t cmd;
+
+	mgp = dev->priv;
+
+	if (mgp->running != MYRI10GE_ETH_RUNNING)
+		return 0;
+
+	if (mgp->tx.req_bytes == NULL)
+		return 0;
+
+	del_timer_sync(&mgp->watchdog_timer);
+	mgp->running = MYRI10GE_ETH_STOPPING;
+	if (myri10ge_napi)
+		netif_poll_disable(mgp->dev);
+	netif_carrier_off(dev);
+	netif_stop_queue(dev);
+	old_down_cnt = mgp->down_cnt;
+	mb();
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_ETHERNET_DOWN, &cmd);
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Couldn't bring down link\n",
+		       dev->name);
+	}
+	set_current_state (TASK_UNINTERRUPTIBLE);
+	if (old_down_cnt == mgp->down_cnt)
+		schedule_timeout(HZ);
+	set_current_state(TASK_RUNNING);
+	if (old_down_cnt == mgp->down_cnt) {
+		printk(KERN_ERR "myri10ge: %s never got down irq\n",
+		       dev->name);
+	}
+	netif_tx_disable(dev);
+
+	for (i = 0; i <= mgp->rx_big.mask; i++) {
+		if (mgp->rx_big.info[i].skb != NULL)
+			dev_kfree_skb_any(mgp->rx_big.info[i].skb);
+		if (pci_unmap_len(&mgp->rx_big.info[i], len)) {
+			pci_unmap_single(mgp->pdev,
+					 pci_unmap_addr(&mgp->rx_big.info[i], bus),
+					 pci_unmap_len(&mgp->rx_big.info[i], len),
+					 PCI_DMA_FROMDEVICE);
+		}
+	}
+
+	for (i = 0; i <= mgp->rx_small.mask; i++) {
+		if (mgp->rx_small.info[i].skb != NULL)
+			dev_kfree_skb_any(mgp->rx_small.info[i].skb);
+		if (pci_unmap_len(&mgp->rx_small.info[i], len)) {
+			pci_unmap_single(mgp->pdev,
+					 pci_unmap_addr(&mgp->rx_small.info[i], bus),
+					 pci_unmap_len(&mgp->rx_small.info[i], len),
+					 PCI_DMA_FROMDEVICE);
+		}
+	}
+
+	tx = &mgp->tx;
+	while (tx->done != tx->req) {
+		idx = tx->done & tx->mask;
+		skb = tx->info[idx].skb;
+
+		/* Mark as free */
+		tx->info[idx].skb = NULL;
+		tx->done++;
+		len = pci_unmap_len(&tx->info[idx], len);
+		pci_unmap_len_set(&tx->info[idx], len, 0);
+		if (skb) {
+			mgp->stats.tx_dropped++;
+			dev_kfree_skb_any(skb);
+			if (len)
+				pci_unmap_single(mgp->pdev,
+						 pci_unmap_addr(&tx->info[idx], bus),
+						 len, PCI_DMA_TODEVICE);
+		} else {
+			if (len)
+				pci_unmap_page(mgp->pdev,
+					       pci_unmap_addr(&tx->info[idx], bus),
+					       len, PCI_DMA_TODEVICE);
+		}
+	}
+	kfree(mgp->rx_big.info);
+
+	kfree(mgp->rx_small.info);
+
+	kfree(mgp->tx.info);
+
+	kfree(mgp->rx_big.shadow);
+
+	kfree(mgp->rx_small.shadow);
+
+	kfree(mgp->tx.req_bytes);
+	mgp->tx.req_bytes = NULL;
+	mgp->tx.req_list = NULL;
+	mgp->running = MYRI10GE_ETH_STOPPED;
+	return 0;
+}
+
+/* copy an array of mcp_kreq_ether_send_t's to the mcp.  Copy
+ * backwards one at a time and handle ring wraps */
+
+static inline void
+myri10ge_submit_req_backwards(myri10ge_tx_buf_t *tx,
+			      mcp_kreq_ether_send_t *src, int cnt)
+{
+	int idx, starting_slot;
+	starting_slot = tx->req;
+	while (cnt > 1) {
+		cnt--;
+		idx = (starting_slot + cnt) & tx->mask;
+		myri10ge_pio_copy(&tx->lanai[idx],
+				  &src[cnt], sizeof(*src));
+		mb();
+	}
+}
+
+/*
+ * copy an array of mcp_kreq_ether_send_t's to the mcp.  Copy
+ * at most 32 bytes at a time, so as to avoid involving the software
+ * pio handler in the nic.   We re-write the first segment's flags
+ * to mark them valid only after writing the entire chain.
+ */
+
+static inline void
+myri10ge_submit_req(myri10ge_tx_buf_t *tx, mcp_kreq_ether_send_t *src,
+		    int cnt)
+{
+	int idx, i;
+	uint32_t __iomem *dst_ints;
+	uint32_t *src_ints;
+	mcp_kreq_ether_send_t __iomem *dstp, *dst;
+	mcp_kreq_ether_send_t *srcp;
+	uint8_t last_flags;
+
+	idx = tx->req & tx->mask;
+
+	last_flags = src->flags;
+	src->flags = 0;
+	mb();
+	dst = dstp = &tx->lanai[idx];
+	srcp = src;
+
+	if ((idx + cnt) < tx->mask) {
+		for (i = 0; i < (cnt - 1); i += 2) {
+			myri10ge_pio_copy(dstp, srcp, 2 * sizeof(*src));
+			mb();	/* force write every 32 bytes */
+			srcp += 2;
+			dstp += 2;
+		}
+	} else {
+		/* submit all but the first request, and ensure
+		   that it is submitted below */
+		myri10ge_submit_req_backwards(tx, src, cnt);
+		i = 0;
+	}
+	if (i < cnt) {
+		/* submit the first request */
+		myri10ge_pio_copy(dstp, srcp, sizeof(*src));
+		mb(); /* barrier before setting valid flag */
+	}
+
+	/* re-write the last 32-bits with the valid flags */
+	src->flags = last_flags;
+	src_ints = (uint32_t *) src;
+	src_ints += 3;
+	dst_ints = (uint32_t __iomem *) dst;
+	dst_ints += 3;
+	*(uint32_t __force *) dst_ints = *src_ints;
+	tx->req += cnt;
+	mb();
+}
+
+static inline void
+myri10ge_submit_req_wc(myri10ge_tx_buf_t *tx,
+		       mcp_kreq_ether_send_t *src, int cnt)
+{
+	tx->req += cnt;
+	mb();
+	while (cnt >= 4) {
+		myri10ge_pio_copy((void __iomem *) tx->wc_fifo, src, 64);
+		mb();
+		src += 4;
+		cnt -= 4;
+	}
+	if (cnt > 0) {
+		/* pad it to 64 bytes.  The src is 64 bytes bigger than it
+		 * needs to be so that we don't overrun it */
+		myri10ge_pio_copy((void __iomem *) tx->wc_fifo + (cnt<<18), src, 64);
+		mb();
+	}
+}
+
+#ifdef NETIF_F_TSO
+static inline unsigned long
+myri10ge_tcpend(struct sk_buff *skb)
+{
+	struct iphdr *ip;
+	int iphlen, tcplen;
+	struct tcphdr *tcp;
+
+	ip = (struct iphdr *) ((char *) skb->data + 14);
+	iphlen = ip->ihl << 2;
+	tcp = (struct tcphdr *) ((char *) ip + iphlen);
+	tcplen = tcp->doff << 2;
+	return (tcplen + iphlen + 14);
+}
+#endif
+
+static inline void
+myri10ge_csum_fixup(struct sk_buff *skb, int cksum_offset,
+		    int pseudo_hdr_offset)
+{
+	int csum;
+	uint16_t *csum_ptr;
+
+
+	csum = skb_checksum(skb, cksum_offset,
+			    skb->len - cksum_offset, 0);
+	csum_ptr = (uint16_t *) (skb->h.raw + skb->csum);
+	if (!pskb_may_pull(skb, pseudo_hdr_offset)) {
+		printk(KERN_ERR "myri10ge: can't pull skb %d\n",
+		       pseudo_hdr_offset);
+		return;
+	}
+	*csum_ptr = csum_fold(csum);
+	/* need to fixup IPv4 UDP packets according to RFC768 */
+	if (unlikely(*csum_ptr == 0 &&
+		     skb->protocol == htons(ETH_P_IP) &&
+		     skb->nh.iph->protocol == IPPROTO_UDP)) {
+		*csum_ptr = 0xffff;
+	}
+}
+
+/*
+ * Transmit a packet.  We need to split the packet so that a single
+ * segment does not cross myri10ge->tx.boundary, so this makes segment
+ * counting tricky.  So rather than try to count segments up front, we
+ * just give up if there are too few segments to hold a reasonably
+ * fragmented packet currently available.  If we run
+ * out of segments while preparing a packet for DMA, we just linearize
+ * it and try again.
+ */
+
+static int
+myri10ge_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct myri10ge_priv *mgp = dev->priv;
+	mcp_kreq_ether_send_t *req;
+	myri10ge_tx_buf_t *tx = &mgp->tx;
+	struct skb_frag_struct *frag;
+	dma_addr_t bus;
+	uint32_t low, high_swapped;
+	unsigned int len;
+	int idx, last_idx, avail, frag_cnt, frag_idx, count, mss, max_segments;
+	uint16_t pseudo_hdr_offset, cksum_offset;
+	int cum_len, seglen, boundary, rdma_count;
+	uint8_t flags, odd_flag;
+
+again:
+	req = tx->req_list;
+	avail = tx->mask - 1 - (tx->req - tx->done);
+
+	mss = 0;
+	max_segments = MYRI10GE_MCP_ETHER_MAX_SEND_DESC;
+
+#ifdef NETIF_F_TSO
+	if (skb->len > (dev->mtu + ETH_HLEN)) {
+		mss = skb_shinfo(skb)->tso_size;
+		if (mss != 0)
+			max_segments = MYRI10GE_MCP_ETHER_MAX_SEND_DESC_TSO;
+	}
+#endif /*NETIF_F_TSO */
+
+	if ((unlikely(avail < max_segments))) {
+		/* we are out of transmit resources */
+		mgp->stop_queue++;
+		netif_stop_queue(dev);
+		return 1;
+	}
+
+	/* Setup checksum offloading, if needed */
+	cksum_offset = 0;
+	pseudo_hdr_offset = 0;
+	odd_flag = 0;
+	flags = (MYRI10GE_MCP_ETHER_FLAGS_NO_TSO |
+		 MYRI10GE_MCP_ETHER_FLAGS_FIRST);
+	if (likely(skb->ip_summed == CHECKSUM_HW)) {
+		cksum_offset = (skb->h.raw - skb->data);
+		pseudo_hdr_offset = (skb->h.raw + skb->csum) - skb->data;
+		/* If the headers are excessively large, then we must
+		 * fall back to a software checksum */
+		if (unlikely(cksum_offset > 255 ||
+			     pseudo_hdr_offset > 127)) {
+			myri10ge_csum_fixup(skb, cksum_offset, pseudo_hdr_offset);
+			cksum_offset = 0;
+			pseudo_hdr_offset = 0;
+		} else {
+			pseudo_hdr_offset = htons(pseudo_hdr_offset);
+			odd_flag = MYRI10GE_MCP_ETHER_FLAGS_ALIGN_ODD;
+			flags |= MYRI10GE_MCP_ETHER_FLAGS_CKSUM;
+		}
+	}
+
+	cum_len = 0;
+
+#ifdef NETIF_F_TSO
+	if (mss) { /* TSO */
+		/* this removes any CKSUM flag from before */
+		flags = (MYRI10GE_MCP_ETHER_FLAGS_TSO_HDR |
+			 MYRI10GE_MCP_ETHER_FLAGS_FIRST);
+
+		/* negative cum_len signifies to the
+		 * send loop that we are still in the
+		 * header portion of the TSO packet.
+		 * TSO header must be at most 134 bytes long */
+		cum_len = -myri10ge_tcpend(skb);
+
+		/* for TSO, pseudo_hdr_offset holds mss.
+		 * The firmware figures out where to put
+		 * the checksum by parsing the header. */
+		pseudo_hdr_offset = htons(mss);
+	} else
+#endif /*NETIF_F_TSO */
+	/* Mark small packets, and pad out tiny packets */
+	if (skb->len <= MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE) {
+		flags |= MYRI10GE_MCP_ETHER_FLAGS_SMALL;
+
+		/* pad frames to at least ETH_ZLEN bytes */
+		if (unlikely(skb->len < ETH_ZLEN)) {
+			skb = skb_padto(skb, ETH_ZLEN);
+			if (skb == NULL) {
+				/* The packet is gone, so we must
+				   return 0 */
+				mgp->stats.tx_dropped += 1;
+				return 0;
+			}
+			/* adjust the len to account for the zero pad
+			   so that the nic can know how long it is */
+			skb->len = ETH_ZLEN;
+		}
+	}
+
+	/* map the skb for DMA */
+	len = skb->len - skb->data_len;
+	idx = tx->req & tx->mask;
+	tx->info[idx].skb = skb;
+	bus = pci_map_single(mgp->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	pci_unmap_addr_set(&tx->info[idx], bus, bus);
+	pci_unmap_len_set(&tx->info[idx], len, len);
+
+	frag_cnt = skb_shinfo(skb)->nr_frags;
+	frag_idx = 0;
+	count = 0;
+	rdma_count = 0;
+
+	/* "rdma_count" is the number of RDMAs belonging to the
+	 * current packet BEFORE the current send request. For
+	 * non-TSO packets, this is equal to "count".
+	 * For TSO packets, rdma_count needs to be reset
+	 * to 0 after a segment cut.
+	 *
+	 * The rdma_count field of the send request is
+	 * the number of RDMAs of the packet starting at
+	 * that request. For TSO send requests with one ore more cuts
+	 * in the middle, this is the number of RDMAs starting
+	 * after the last cut in the request. All previous
+	 * segments before the last cut implicitly have 1 RDMA.
+	 *
+	 * Since the number of RDMAs is not known beforehand,
+	 * it must be filled-in retroactively - after each
+	 * segmentation cut or at the end of the entire packet.
+	 */
+
+	while (1) {
+		/* Break the SKB or Fragment up into pieces which
+		   do not cross mgp->tx.boundary */
+		low = MYRI10GE_LOWPART_TO_U32(bus);
+		high_swapped = htonl(MYRI10GE_HIGHPART_TO_U32(bus));
+		while (len) {
+			uint8_t flags_next;
+			int cum_len_next;
+
+			if (unlikely(count == max_segments))
+				goto abort_linearize;
+
+			boundary = (low + tx->boundary) & ~(tx->boundary - 1);
+			seglen = boundary - low;
+			if (seglen > len)
+				seglen = len;
+			flags_next = flags & ~MYRI10GE_MCP_ETHER_FLAGS_FIRST;
+			cum_len_next = cum_len + seglen;
+#ifdef NETIF_F_TSO
+			if (mss) { /* TSO */
+				(req-rdma_count)->rdma_count = rdma_count + 1;
+
+				if (likely(cum_len >= 0)) { /* payload */
+					int next_is_first, chop;
+
+					chop = (cum_len_next>mss);
+					cum_len_next = cum_len_next % mss;
+					next_is_first = (cum_len_next == 0);
+					flags |= chop *
+						MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP;
+					flags_next |= next_is_first *
+						MYRI10GE_MCP_ETHER_FLAGS_FIRST;
+					rdma_count |= -(chop | next_is_first);
+					rdma_count += chop & !next_is_first;
+				} else if (likely(cum_len_next >= 0)) { /* header ends */
+					int small;
+
+					rdma_count = -1;
+					cum_len_next = 0;
+					seglen = -cum_len;
+					small = (mss <= MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE);
+					flags_next = MYRI10GE_MCP_ETHER_FLAGS_TSO_PLD |
+						MYRI10GE_MCP_ETHER_FLAGS_FIRST |
+						(small * MYRI10GE_MCP_ETHER_FLAGS_SMALL);
+				}
+			}
+#endif /* NETIF_F_TSO */
+			req->addr_high = high_swapped;
+			req->addr_low = htonl(low);
+			req->pseudo_hdr_offset = pseudo_hdr_offset;
+			req->pad = 0;	/* complete solid 16-byte block; does this matter? */
+			req->rdma_count = 1;
+			req->length = htons(seglen);
+			req->cksum_offset = cksum_offset;
+			req->flags = flags | ((cum_len & 1) * odd_flag);
+
+			low += seglen;
+			len -= seglen;
+			cum_len = cum_len_next;
+			flags = flags_next;
+			req++;
+			count++;
+			rdma_count++;
+			if (unlikely(cksum_offset > seglen))
+				cksum_offset -= seglen;
+			else
+				cksum_offset = 0;
+		}
+		if (frag_idx == frag_cnt)
+			break;
+
+		/* map next fragment for DMA */
+		idx = (count + tx->req) & tx->mask;
+		frag = &skb_shinfo(skb)->frags[frag_idx];
+		frag_idx++;
+		len = frag->size;
+		bus = pci_map_page(mgp->pdev, frag->page, frag->page_offset,
+				   len, PCI_DMA_TODEVICE);
+		pci_unmap_addr_set(&tx->info[idx], bus, bus);
+		pci_unmap_len_set(&tx->info[idx], len, len);
+	}
+
+	(req-rdma_count)->rdma_count = rdma_count;
+#ifdef NETIF_F_TSO
+	if (mss) {
+		do {
+			req--;
+			req->flags |= MYRI10GE_MCP_ETHER_FLAGS_TSO_LAST;
+		} while (!(req->flags & (MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP |
+					 MYRI10GE_MCP_ETHER_FLAGS_FIRST)));
+	}
+#endif
+	idx = ((count - 1) + tx->req) & tx->mask;
+	tx->info[idx].last = 1;
+	if (tx->wc_fifo == NULL)
+		myri10ge_submit_req(tx, tx->req_list, count);
+	else
+		myri10ge_submit_req_wc(tx, tx->req_list, count);
+	tx->pkt_start++;
+	if ((avail - count) < MYRI10GE_MCP_ETHER_MAX_SEND_DESC) {
+		mgp->stop_queue++;
+		netif_stop_queue(dev);
+	}
+	dev->trans_start = jiffies;
+	return 0;
+
+
+abort_linearize:
+	/* Free any DMA resources we've alloced and clear out the skb
+	 * slot so as to not trip up assertions, and to avoid a
+	 * double-free if linearizing fails */
+
+	last_idx = (idx + 1) & tx->mask;
+	idx = tx->req & tx->mask;
+	tx->info[idx].skb = NULL;
+	do {
+		len = pci_unmap_len(&tx->info[idx], len);
+		if (len) {
+			if (tx->info[idx].skb != NULL) {
+				pci_unmap_single(mgp->pdev,
+						 pci_unmap_addr(&tx->info[idx], bus),
+						 len, PCI_DMA_TODEVICE);
+			} else {
+				pci_unmap_page(mgp->pdev,
+					       pci_unmap_addr(&tx->info[idx], bus),
+					       len, PCI_DMA_TODEVICE);
+			}
+			pci_unmap_len_set(&tx->info[idx], len, 0);
+			tx->info[idx].skb = NULL;
+		}
+		idx = (idx + 1) & tx->mask;
+	} while (idx != last_idx);
+	if (skb_shinfo(skb)->tso_size) {
+		printk(KERN_ERR "myri10ge: %s: TSO but wanted to linearize?!?!?\n",
+		       mgp->dev->name);
+		goto drop;
+	}
+
+	if (skb_linearize(skb, GFP_ATOMIC)) {
+		goto drop;
+	}
+	mgp->tx_linearized++;
+	goto again;
+
+drop:
+	dev_kfree_skb_any(skb);
+	mgp->stats.tx_dropped += 1;
+	return 0;
+
+
+}
+
+static struct net_device_stats *
+myri10ge_get_stats(struct net_device *dev)
+{
+	struct myri10ge_priv *mgp = dev->priv;
+	return &mgp->stats;
+}
+
+static void
+myri10ge_set_multicast_list(struct net_device *dev)
+{
+	myri10ge_change_promisc(dev->priv, dev->flags & IFF_PROMISC);
+}
+
+
+static int
+myri10ge_set_mac_address (struct net_device *dev, void *addr)
+{
+	struct sockaddr *sa = (struct sockaddr *) addr;
+	struct myri10ge_priv *mgp = dev->priv;
+	int status;
+
+	if (!is_valid_ether_addr(sa->sa_data))
+		return -EADDRNOTAVAIL;
+
+	status = myri10ge_update_mac_address(mgp, sa->sa_data);
+	if (status != 0) {
+		printk(KERN_ERR "myri10ge: %s: changing mac address failed with %d\n",
+		       dev->name, status);
+		return status;
+	}
+
+	/* change the dev structure */
+	memcpy(dev->dev_addr, sa->sa_data, 6);
+	return 0;
+}
+static int
+myri10ge_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int
+myri10ge_init(struct net_device *dev)
+{
+	return 0;
+}
+
+static int
+myri10ge_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct myri10ge_priv *mgp = dev->priv;
+	int error = 0;
+
+	if ((new_mtu < 68) || (ETH_HLEN + new_mtu > MYRI10GE_MAX_ETHER_MTU)) {
+		printk(KERN_ERR "myri10ge: %s: new mtu (%d) is not valid\n",
+		       dev->name, new_mtu);
+		return -EINVAL;
+	}
+	printk("%s: changing mtu from %d to %d\n",
+	       dev->name, dev->mtu, new_mtu);
+	if (mgp->running) {
+		/* if we change the mtu on an active device, we must
+		 * reset the device so the firmware sees the change */
+		myri10ge_close(dev);
+		dev->mtu = new_mtu;
+		myri10ge_open(dev);
+	} else {
+		dev->mtu = new_mtu;
+	}
+	return error;
+}
+
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+
+/*
+ * Enable ECRC to align PCI-E Completion packets.  Rather than using
+ * normal pci config space writes, we must map the Nvidia config space
+ * ourselves.  This is because on opteron/nvidia class machine the
+ * 0xe000000 mapping is handled by the nvidia chipset, that means
+ * the internal PCI device (the on-chip northbridge), or the amd-8131
+ * bridge and things behind them are not visible by this method.
+ */
+
+static void
+myri10ge_enable_ecrc(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *bridge = mgp->pdev->bus->self;
+	struct device * dev = &mgp->pdev->dev;
+	unsigned cap;
+	unsigned err_cap;
+	int ret;
+
+	if (!myri10ge_ecrc_enable || !bridge)
+		return;
+
+	cap = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ERR);
+	/* nvidia ext cap is not always linked in ext cap chain */
+	if (!cap
+	    && bridge->vendor == PCI_VENDOR_ID_NVIDIA
+	    && bridge->device == PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_PCIE)
+		cap = 0x160;
+
+	if (!cap)
+		return;
+
+	ret = pci_read_config_dword(bridge, cap + PCI_ERR_CAP, &err_cap);
+	if (ret) {
+		dev_err(dev, "failed reading ext-conf-space of %s\n",
+			pci_name(bridge));
+		dev_err(dev, "\t pci=nommconf in use? "
+			"or buggy/incomplete/absent acpi MCFG attr?\n");
+		return;
+	}
+	if (!(err_cap & PCI_ERR_CAP_ECRC_GENC))
+		return;
+
+	err_cap |= PCI_ERR_CAP_ECRC_GENE;
+	pci_write_config_dword(bridge, cap + PCI_ERR_CAP, err_cap);
+	dev_info(dev,
+		 "Enabled ECRC on upstream bridge %s\n",
+		 pci_name(bridge));
+	mgp->tx.boundary = 4096;
+	mgp->fw_name = myri10ge_fw_aligned;
+}
+#endif /* defined(CONFIG_X86) || defined(CONFIG_X86_64) */
+
+/*
+ * The Lanai Z8E PCI-E interface achieves higher Read-DMA throughput
+ * when the PCI-E Completion packets are aligned on an 8-byte
+ * boundary.  Some PCI-E chip sets always align Completion packets; on
+ * the ones that do not, the alignment can be enforced by enabling
+ * ECRC generation (if supported).
+ *
+ * When PCI-E Completion packets are not aligned, it is actually more
+ * efficient to limit Read-DMA transactions to 2KB, rather than 4KB.
+ *
+ * If the driver can neither enable ECRC nor verify that it has
+ * already been enabled, then it must use a firmware image which works
+ * around unaligned completion packets (myri10ge_ethp_z8e.dat), and it
+ * should also ensure that it never gives the device a Read-DMA which is
+ * larger than 2KB by setting the tx.boundary to 2KB.  If ECRC is
+ * enabled, then the driver should use the aligned (myri10ge_eth_z8e.dat)
+ * firmware image, and set tx.boundary to 4KB.
+ */
+
+static void
+myri10ge_select_firmware(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *bridge = mgp->pdev->bus->self;
+
+	mgp->tx.boundary = 2048;
+	mgp->fw_name = myri10ge_fw_unaligned;
+
+	if (myri10ge_force_firmware == 0) {
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+		myri10ge_enable_ecrc(mgp);
+#endif
+		/* Check to see if the upstream bridge is known to
+		 * provide aligned completions */
+		if (bridge
+		    /* ServerWorks HT2000/HT1000 */
+		    && bridge->vendor == PCI_VENDOR_ID_SERVERWORKS
+		    && bridge->device == PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE) {
+			dev_info(&mgp->pdev->dev,
+				 "Assuming aligned completions (0x%x:0x%x)\n",
+				 bridge->vendor, bridge->device);
+			mgp->tx.boundary = 4096;
+			mgp->fw_name = myri10ge_fw_aligned;
+		}
+	} else {
+		if (myri10ge_force_firmware == 1) {
+			dev_info(&mgp->pdev->dev,
+				 "Assuming aligned completions (forced)\n");
+			mgp->tx.boundary = 4096;
+			mgp->fw_name = myri10ge_fw_aligned;
+		} else {
+			dev_info(&mgp->pdev->dev,
+				 "Assuming unaligned completions (forced)\n");
+			mgp->tx.boundary = 2048;
+			mgp->fw_name = myri10ge_fw_unaligned;
+		}
+	}
+	if (myri10ge_fw_name != NULL) {
+		dev_info(&mgp->pdev->dev, "overriding firmware to %s\n",
+			 myri10ge_fw_name);
+		mgp->fw_name = myri10ge_fw_name;
+	}
+}
+
+
+static void
+myri10ge_save_state(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *pdev =	mgp->pdev;
+	int cap;
+
+	pci_save_state(pdev);
+	/* now save PCIe and MSI state that Linux will not
+	   save for us */
+	cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DEVCTL, &mgp->devctl);
+	cap = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+	pci_read_config_word(pdev, cap + PCI_MSI_FLAGS, &mgp->msi_flags);
+	pci_read_config_dword(pdev, cap + PCI_MSI_ADDRESS_LO,
+			      &mgp->msi_addr_low);
+	pci_read_config_dword(pdev, cap + PCI_MSI_ADDRESS_HI,
+			      &mgp->msi_addr_high);
+	pci_read_config_word(pdev, cap + PCI_MSI_DATA_32,
+			     &mgp->msi_data_32);
+	pci_read_config_word(pdev, cap + PCI_MSI_DATA_64,
+			     &mgp->msi_data_64);
+}
+
+static void
+myri10ge_restore_state(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *pdev =	mgp->pdev;
+	int cap;
+
+	pci_restore_state(pdev);
+	/* restore PCIe and MSI state that linux will not */
+	cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	pci_write_config_dword(pdev, cap + PCI_CAP_ID_EXP, mgp->devctl);
+	cap = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+	pci_write_config_word(pdev, cap + PCI_MSI_FLAGS, mgp->msi_flags);
+	pci_write_config_dword(pdev, cap + PCI_MSI_ADDRESS_LO,
+			       mgp->msi_addr_low);
+	pci_write_config_dword(pdev, cap + PCI_MSI_ADDRESS_HI,
+			       mgp->msi_addr_high);
+	pci_write_config_word(pdev, cap + PCI_MSI_DATA_32,
+			      mgp->msi_data_32);
+	pci_write_config_word(pdev, cap + PCI_MSI_DATA_64,
+			      mgp->msi_data_64);
+}
+
+#ifdef CONFIG_PM
+
+static int
+myri10ge_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct myri10ge_priv *mgp;
+	struct net_device *netdev;
+
+	mgp = (struct myri10ge_priv *) pci_get_drvdata(pdev);
+	if (mgp == NULL)
+		return -EINVAL;
+	netdev = mgp->dev;
+
+	if (netif_running(netdev)) {
+		printk("myri10ge: closing %s\n", netdev->name);
+		myri10ge_close(netdev);
+	}
+	myri10ge_dummy_rdma(mgp, 0);
+	free_irq(pdev->irq, mgp);
+#ifdef CONFIG_PCI_MSI
+	if (mgp->msi_enabled)
+		pci_disable_msi(pdev);
+#endif
+	netif_device_detach(netdev);
+	myri10ge_save_state(mgp);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return 0;
+}
+
+static int
+myri10ge_resume(struct pci_dev *pdev)
+{
+	struct myri10ge_priv *mgp;
+	struct net_device *netdev;
+	int status;
+
+	mgp = (struct myri10ge_priv *) pci_get_drvdata(pdev);
+	if (mgp == NULL)
+		return -EINVAL;
+	netdev = mgp->dev;
+	pci_set_power_state(pdev, 0);  /* zeros conf space as a side effect */
+	udelay(5000);	/* give card time to respond */
+	myri10ge_restore_state(mgp);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+
+#ifdef CONFIG_PCI_MSI
+	if (myri10ge_use_msi(pdev)) {
+		status = pci_enable_msi(pdev);
+		if (status != 0) {
+			dev_err(&pdev->dev,
+				"Error %d setting up MSI; falling back to xPIC\n",
+				status);
+
+		} else {
+			mgp->msi_enabled = 1;
+		}
+	}
+#endif
+	if (myri10ge_napi) {
+		status = request_irq(pdev->irq, myri10ge_napi_intr, SA_SHIRQ,
+				     netdev->name, mgp);
+	} else {
+
+		status = request_irq(pdev->irq, myri10ge_intr, SA_SHIRQ,
+				     netdev->name, mgp);
+	}
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQ\n");
+		goto abort_with_msi;
+	}
+
+	myri10ge_reset(mgp);
+	myri10ge_dummy_rdma(mgp, mgp->tx.boundary != 4096);
+
+	/* Save configuration space to be restored if the
+	   nic resets due to a parity error */
+	myri10ge_save_state(mgp);
+
+	netif_device_attach(netdev);
+	if (netif_running(netdev))
+		myri10ge_open(netdev);
+	return 0;
+
+abort_with_msi:
+#ifdef CONFIG_PCI_MSI
+	if (mgp->msi_enabled)
+		pci_disable_msi(pdev);
+#endif
+	return -EIO;
+
+}
+
+#endif /* CONFIG_PM */
+
+static uint32_t
+myri10ge_read_reboot(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *pdev = mgp->pdev;
+	int vs = mgp->vendor_specific_offset;
+	uint32_t reboot;
+
+	/*enter read32 mode */
+	pci_write_config_byte(pdev, vs + 0x10, 0x3);
+
+	/*read REBOOT_STATUS (0xfffffff0) */
+	pci_write_config_dword(pdev, vs + 0x18, 0xfffffff0);
+	pci_read_config_dword(pdev, vs + 0x14, &reboot);
+	return reboot;
+}
+
+static void
+myri10ge_watchdog(void *arg)
+{
+	struct myri10ge_priv *mgp = arg;
+	uint32_t reboot;
+	int status;
+	uint16_t cmd, vendor;
+
+	mgp->watchdog_resets++;
+	pci_read_config_word(mgp->pdev, PCI_COMMAND, &cmd);
+	if ((cmd & PCI_COMMAND_MASTER) == 0) {
+		/* Bus master DMA disabled?  Check to see
+		 * if the card rebooted due to a parity error
+		 * For now, just report it */
+		reboot = myri10ge_read_reboot(mgp);
+		printk(KERN_ERR "myri10ge: %s: NIC rebooted (0x%x), resetting\n",
+		       mgp->dev->name, reboot);
+		/*
+		 * A rebooted nic will come back with config space as
+		 * it was after power was applied to PCIe bus.
+		 * Attempt to restore config space which was saved
+		 * when the driver was loaded, or the last time the
+		 * nic was resumed from power saving mode.
+		 */
+		myri10ge_restore_state(mgp);
+	} else {
+		/* if we get back -1's from our slot, perhaps somebody
+		   powered off our card.  Don't try to reset it in
+		   this case */
+		if (cmd == 0xffff) {
+			pci_read_config_word(mgp->pdev, PCI_VENDOR_ID, &vendor);
+			if (vendor == 0xffff) {
+				printk(KERN_ERR "myri10ge: %s: device disappeared!\n",
+				       mgp->dev->name);
+				return;
+			}
+		}
+		/* Perhaps it is a software error.  Try to reset */
+
+		printk(KERN_ERR "myri10ge: %s: device timeout, resetting\n",
+		       mgp->dev->name);
+		printk("myri10ge: %s: %d %d %d %d %d\n", mgp->dev->name,
+		       mgp->tx.req, mgp->tx.done, mgp->tx.pkt_start,
+		       mgp->tx.pkt_done,
+		       (int)ntohl(mgp->fw_stats->send_done_count));
+		set_current_state (TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ*2);
+		set_current_state(TASK_RUNNING);
+		printk("myri10ge: %s: %d %d %d %d %d\n", mgp->dev->name,
+		       mgp->tx.req, mgp->tx.done, mgp->tx.pkt_start,
+		       mgp->tx.pkt_done,
+		       (int)ntohl(mgp->fw_stats->send_done_count));
+	}
+	myri10ge_close(mgp->dev);
+	status = myri10ge_load_firmware(mgp);
+	if (status != 0) {
+		printk(KERN_ERR "myri10ge: %s: failed to load firmware\n",
+		       mgp->dev->name);
+		return;
+	}
+	myri10ge_open(mgp->dev);
+}
+
+static void
+myri10ge_watchdog_timer(unsigned long arg)
+{
+	struct myri10ge_priv *mgp;
+
+	mgp = (struct myri10ge_priv *) arg;
+	if (mgp->tx.req != mgp->tx.done &&
+	    mgp->tx.done == mgp->watchdog_tx_done) {
+		/* nic seems like it might be stuck.. */
+		schedule_work(&mgp->watchdog_work);
+	} else {
+		/* rearm timer */
+		mod_timer(&mgp->watchdog_timer,
+			  jiffies + myri10ge_watchdog_timeout * HZ);
+	}
+	mgp->watchdog_tx_done = mgp->tx.done;
+}
+
+static int
+myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct net_device *netdev;
+	struct myri10ge_priv *mgp;
+	struct device *dev = &pdev->dev;
+	size_t bytes;
+	int i;
+	int status = -ENXIO;
+	int cap;
+	u16 val;
+
+	netdev = alloc_etherdev(sizeof(*mgp));
+	if (netdev == NULL) {
+		dev_err(dev, "Could not allocate ethernet device\n");
+		return -ENOMEM;
+	}
+
+	mgp = netdev_priv(netdev);
+	memset(mgp, 0, sizeof (*mgp));
+	mgp->dev = netdev;
+	mgp->pdev = pdev;
+	mgp->csum_flag = MYRI10GE_MCP_ETHER_FLAGS_CKSUM;
+	mgp->pause = myri10ge_flow_control;
+	mgp->intr_coal_delay = myri10ge_intr_coal_delay;
+
+	spin_lock_init(&mgp->cmd_lock);
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev, "pci_enable_device call failed\n");
+		status = -ENODEV;
+		goto abort_with_netdev;
+	}
+	myri10ge_select_firmware(mgp);
+
+	/* Find the vendor-specific cap so we can check
+	   the reboot register later on */
+	mgp->vendor_specific_offset
+		= pci_find_capability(pdev, PCI_CAP_ID_VNDR);
+
+	/* Set our max read request to 4KB */
+	cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	if (cap < 64) {
+		dev_err(&pdev->dev,"Bad PCI_CAP_ID_EXP location %d\n", cap);
+		goto abort_with_netdev;
+	}
+	status = pci_read_config_word(pdev, cap + PCI_EXP_DEVCTL, &val);
+	if (status != 0) {
+		dev_err(&pdev->dev, "Error %d reading PCI_EXP_DEVCTL\n", status);
+		goto abort_with_netdev;
+	}
+	val = (val & ~PCI_EXP_DEVCTL_READRQ) | (5 << 12);
+	status = pci_write_config_word(pdev, cap + PCI_EXP_DEVCTL, val);
+	if (status != 0) {
+		dev_err(&pdev->dev, "Error %d writing PCI_EXP_DEVCTL\n", status);
+		goto abort_with_netdev;
+	}
+
+	pci_set_master(pdev);
+	status = pci_set_dma_mask(pdev, (dma_addr_t)~0ULL);
+	if (status != 0) {
+		dev_err(&pdev->dev, "64-bit pci address mask was refused, trying 32-bit");
+		status = pci_set_dma_mask(pdev, (dma_addr_t)0xffffffffULL);
+	}
+	if (status != 0) {
+		dev_err(&pdev->dev, "Error %d setting DMA mask\n", status);
+		goto abort_with_netdev;
+	}
+	mgp->cmd = (mcp_cmd_response_t *)
+		pci_alloc_consistent(pdev, sizeof (*mgp->cmd), &mgp->cmd_bus);
+	if (mgp->cmd == NULL) {
+		goto abort_with_netdev;
+	}
+
+	mgp->fw_stats = (mcp_irq_data_t *)
+		pci_alloc_consistent(pdev, sizeof (*mgp->fw_stats),
+				     &mgp->fw_stats_bus);
+	if (mgp->fw_stats == NULL) {
+		goto abort_with_cmd;
+	}
+
+	strcpy(netdev->name, "eth%d");
+	mgp->board_span = pci_resource_len(pdev, 0);
+	mgp->iomem_base = pci_resource_start(pdev, 0);
+	mgp->mtrr = -1;
+#ifdef CONFIG_MTRR
+	mgp->mtrr = mtrr_add(mgp->iomem_base, mgp->board_span,
+			     MTRR_TYPE_WRCOMB, 1);
+#endif
+	/* Hack.  need to get rid of these magic numbers */
+	mgp->sram_size = 2*1024*1024 - (2*(48*1024)+(32*1024)) - 0x100;
+	if (mgp->sram_size > mgp->board_span) {
+		dev_err(&pdev->dev, "board span %ld bytes too small\n",
+		       mgp->board_span);
+		goto abort_with_wc;
+	}
+	mgp->sram = ioremap(mgp->iomem_base, mgp->board_span);
+	if (mgp->sram == NULL) {
+		dev_err(&pdev->dev, "ioremap failed for %ld bytes at 0x%lx\n",
+		       mgp->board_span, mgp->iomem_base);
+		status = -ENXIO;
+		goto abort_with_wc;
+	}
+	memcpy_fromio(mgp->eeprom_strings,
+		      mgp->sram + mgp->sram_size - MYRI10GE_EEPROM_STRINGS_SIZE,
+		      MYRI10GE_EEPROM_STRINGS_SIZE);
+	memset(mgp->eeprom_strings + MYRI10GE_EEPROM_STRINGS_SIZE - 2, 0, 2);
+	status = myri10ge_read_mac_addr(mgp);
+	if (status) {
+		goto abort_with_ioremap;
+	}
+	for (i = 0; i < 6; i++) {
+		netdev->dev_addr[i] = mgp->mac_addr[i];
+	}
+	/* allocate rx done ring */
+	bytes = myri10ge_max_intr_slots * sizeof (*mgp->rx_done.entry);
+	mgp->rx_done.entry = (mcp_slot_t *)
+		pci_alloc_consistent(pdev, bytes, &mgp->rx_done.bus);
+	if (mgp->rx_done.entry == NULL)
+		goto abort_with_ioremap;
+	memset(mgp->rx_done.entry, 0, bytes);
+
+	status = myri10ge_load_firmware(mgp);
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to load firmware\n");
+		goto abort_with_rx_done;
+	}
+
+	status = myri10ge_reset(mgp);
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed reset\n");
+		goto abort_with_firmware;
+	}
+
+#ifdef CONFIG_PCI_MSI
+	if (myri10ge_use_msi(pdev)) {
+		status = pci_enable_msi(pdev);
+		if (status != 0) {
+			dev_err(&pdev->dev,
+				"Error %d setting up MSI; falling back to xPIC\n",
+				status);
+		} else {
+			mgp->msi_enabled = 1;
+		}
+	}
+#endif
+
+	if (myri10ge_napi) {
+		status = request_irq(pdev->irq, myri10ge_napi_intr, SA_SHIRQ,
+				     netdev->name, mgp);
+	} else {
+		status = request_irq(pdev->irq, myri10ge_intr, SA_SHIRQ,
+				     netdev->name, mgp);
+	}
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQ\n");
+		goto abort_with_firmware;
+	}
+
+	pci_set_drvdata(pdev, mgp);
+	if ((myri10ge_initial_mtu + ETH_HLEN) > MYRI10GE_MAX_ETHER_MTU)
+		myri10ge_initial_mtu = MYRI10GE_MAX_ETHER_MTU - ETH_HLEN;
+	if ((myri10ge_initial_mtu + ETH_HLEN) < 68)
+		myri10ge_initial_mtu = 68;
+	netdev->mtu = myri10ge_initial_mtu;
+	netdev->open = myri10ge_open;
+	netdev->stop = myri10ge_close;
+	netdev->hard_start_xmit = myri10ge_xmit;
+	netdev->get_stats = myri10ge_get_stats;
+	netdev->base_addr = mgp->iomem_base;
+	netdev->irq = pdev->irq;
+	netdev->init = myri10ge_init;
+	netdev->change_mtu = myri10ge_change_mtu;
+	netdev->set_multicast_list = myri10ge_set_multicast_list;
+	netdev->set_mac_address = myri10ge_set_mac_address;
+	netdev->do_ioctl = myri10ge_ioctl;
+	netdev->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
+#if 0
+	/* TSO can be enabled via ethtool -K eth1 tso on */
+#ifdef NETIF_F_TSO
+	netdev->features |= NETIF_F_TSO;
+#endif
+#endif
+	if (myri10ge_napi) {
+		netdev->poll = myri10ge_poll;
+		netdev->weight = myri10ge_napi_weight;
+	}
+
+	/* Save configuration space to be restored if the
+	 * nic resets due to a parity error */
+	myri10ge_save_state(mgp);
+
+	/* Setup the watchdog timer */
+	init_timer(&mgp->watchdog_timer);
+	mgp->watchdog_timer.data = (unsigned long)mgp;
+	mgp->watchdog_timer.function = myri10ge_watchdog_timer;
+
+	SET_ETHTOOL_OPS(netdev, &myri10ge_ethtool_ops);
+	INIT_WORK(&mgp->watchdog_work, myri10ge_watchdog, mgp);
+	status = register_netdev(netdev);
+	if (status != 0) {
+		dev_err(&pdev->dev, "register_netdev failed: %d\n", status);
+		goto abort_with_irq;
+	}
+
+	printk("myri10ge: %s: %s IRQ %d, tx bndry %d, fw %s, WC %s\n",
+	       netdev->name,  (mgp->msi_enabled ? "MSI" : "xPIC"),
+	       pdev->irq, mgp->tx.boundary, mgp->fw_name,
+	       (mgp->mtrr >= 0 ? "Enabled" : "Disabled"));
+
+	return 0;
+
+abort_with_irq:
+	free_irq(pdev->irq, mgp);
+#ifdef CONFIG_PCI_MSI
+	if (mgp->msi_enabled)
+		pci_disable_msi(pdev);
+#endif
+
+abort_with_firmware:
+	myri10ge_dummy_rdma(mgp, 0);
+
+abort_with_rx_done:
+	bytes = myri10ge_max_intr_slots * sizeof (*mgp->rx_done.entry);
+	pci_free_consistent(pdev, bytes, mgp->rx_done.entry, mgp->rx_done.bus);
+
+abort_with_ioremap:
+	iounmap((void __iomem *) mgp->sram);
+
+abort_with_wc:
+#ifdef CONFIG_MTRR
+	if (mgp->mtrr >= 0)
+		mtrr_del(mgp->mtrr, mgp->iomem_base, mgp->board_span);
+#endif
+	pci_free_consistent(pdev, sizeof (*mgp->fw_stats),
+			    mgp->fw_stats, mgp->fw_stats_bus);
+
+abort_with_cmd:
+	pci_free_consistent(pdev, sizeof (*mgp->cmd), mgp->cmd, mgp->cmd_bus);
+
+abort_with_netdev:
+
+	free_netdev(netdev);
+	return status;
+}
+
+/****************************************************************
+ * myri10ge_remove
+ *
+ * Does what is necessary to shutdown one Myrinet device. Called
+ *   once for each Myrinet card by the kernel when a module is
+ *   unloaded.
+ ****************************************************************/
+
+static void
+myri10ge_remove(struct pci_dev *pdev)
+{
+	struct myri10ge_priv *mgp;
+	struct net_device *netdev;
+	size_t bytes;
+
+	mgp = (struct myri10ge_priv *) pci_get_drvdata(pdev);
+	if (mgp == NULL)
+		return;
+
+	flush_scheduled_work();
+	netdev = mgp->dev;
+	unregister_netdev(netdev);
+	free_irq(pdev->irq, mgp);
+#ifdef CONFIG_PCI_MSI
+	if (mgp->msi_enabled)
+		pci_disable_msi(pdev);
+#endif
+
+	myri10ge_dummy_rdma(mgp, 0);
+
+
+	bytes = myri10ge_max_intr_slots * sizeof (*mgp->rx_done.entry);
+	pci_free_consistent(pdev, bytes, mgp->rx_done.entry, mgp->rx_done.bus);
+
+	iounmap((void __iomem *) mgp->sram);
+
+#ifdef CONFIG_MTRR
+	if (mgp->mtrr >= 0)
+		mtrr_del(mgp->mtrr, mgp->iomem_base, mgp->board_span);
+#endif
+	pci_free_consistent(pdev, sizeof (*mgp->fw_stats),
+			    mgp->fw_stats, mgp->fw_stats_bus);
+
+	pci_free_consistent(pdev, sizeof (*mgp->cmd), mgp->cmd, mgp->cmd_bus);
+
+	free_netdev(netdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+
+#define MYRI10GE_PCI_VENDOR_MYRICOM 	0x14c1
+#define MYRI10GE_PCI_DEVICE_Z8E 	0x0008
+static struct pci_device_id myri10ge_pci_tbl[] = {
+	{MYRI10GE_PCI_VENDOR_MYRICOM, MYRI10GE_PCI_DEVICE_Z8E,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,},
+};
+
+static struct pci_driver myri10ge_driver = {
+	.name = "myri10ge",
+	.probe = myri10ge_probe,
+	.remove = myri10ge_remove,
+	.id_table = myri10ge_pci_tbl,
+#ifdef CONFIG_PM
+	.suspend = myri10ge_suspend,
+	.resume = myri10ge_resume,
+#endif
+};
+
+static int
+myri10ge_init_module(void)
+{
+	int rc;
+	printk("%s: Version %s\n", myri10ge_driver.name,
+	       MYRI10GE_VERSION_STR);
+	rc = pci_register_driver(&myri10ge_driver);
+	return rc < 0 ? rc : 0;
+}
+
+static void
+myri10ge_cleanup_module(void)
+{
+	pci_unregister_driver(&myri10ge_driver);
+}
+
+module_init(myri10ge_init_module);
+module_exit(myri10ge_cleanup_module);
+


