Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTFLDRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 23:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbTFLDRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 23:17:40 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:11001 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264709AbTFLDRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 23:17:35 -0400
Date: Thu, 12 Jun 2003 13:32:04 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Scott Feldman <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       Nancy Milliner <milliner@us.ibm.com>,
       Herman Dierks <hdierks@us.ibm.com>,
       Ricardo Gonzalez <ricardoz@us.ibm.com>
Subject: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030612033204.GJ9900@zax>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Scott Feldman <scott.feldman@intel.com>,
	linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
	Nancy Milliner <milliner@us.ibm.com>,
	Herman Dierks <hdierks@us.ibm.com>,
	Ricardo Gonzalez <ricardoz@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

Peculiarities in the PCI bridges on Power4 based ppc64 machines mean
that unaligned DMAs are horribly slow.  This hits us hard on gigabit
transfers, since the packets (starting from the MAC header) are
usually only 2-byte aligned.

The patch below addresses this by copying and realigning packets into
nicely 2k aligned buffers.  As well as fixing the alignment that
minimises the number of TCE lookups, and because we allocate the
buffers pci_alloc_consistent(), we avoid setting up and tearing down
the TCE mappings for each packet.

It's definitely a ppc64 specific hack, but I've tried to minimise the
patch's adverse impact on the rest of the code: It should cause no
change in behaviour or performance when the realignment is disabled,
which is true by default on everything except ppc64.  I've also
attempted to minimise the impact on the readability of the rest of the
code.

It would be very helpful if you could include this patch in the
mainline driver.

diff -urN /scratch/anton/export/drivers/net/e1000/e1000.h linux-congo/drivers/net/e1000/e1000.h
--- /scratch/anton/export/drivers/net/e1000/e1000.h	2003-05-30 01:28:06.000000000 +1000
+++ linux-congo/drivers/net/e1000/e1000.h	2003-06-12 12:39:10.000000000 +1000
@@ -163,6 +163,43 @@
 #define E1000_TX_DESC(R, i)		E1000_GET_DESC(R, i, e1000_tx_desc)
 #define E1000_CONTEXT_DESC(R, i)	E1000_GET_DESC(R, i, e1000_context_desc)
 
+#ifdef CONFIG_PPC64
+/* We have a POWER4 specific performance hack to deal with the
+ * slowness of transferring unaligned frames over the PCI bus */
+#define E1000_REALIGN_DATA_HACK	1
+#else
+#define E1000_REALIGN_DATA_HACK	0
+#endif
+
+#define E1000_REALIGN_BUFFER_SIZE	2048 /* importantly, >1514 */
+#define E1000_REALIGN_TARGET_ALIGNMENT	E1000_REALIGN_BUFFER_SIZE
+
+#if E1000_REALIGN_DATA_HACK
+/* We want each buffer to lie within one page, to minimise TCE
+ * lookups */
+#if (PAGE_SIZE % E1000_REALIGN_BUFFER_SIZE)
+#warning E1000_REALIGN_BUFFER_SIZE is not a factor of page size.
+#endif
+
+struct e1000_realign_ring {
+	unsigned char *vaddr;
+	dma_addr_t dma_handle;
+	size_t size;
+};
+
+#define E1000_REALIGN_BUFFER_OFFSET(i)	((i)*E1000_REALIGN_BUFFER_SIZE)
+#define E1000_REALIGN_BUFFER(a,i) ((a)->realign_ring.vaddr ? \
+	(a)->realign_ring.vaddr + E1000_REALIGN_BUFFER_OFFSET(i) : \
+	NULL)
+#define E1000_REALIGN_BUFFER_DMA(a,i) ((a)->realign_ring.dma_handle \
+	+ E1000_REALIGN_BUFFER_OFFSET(i))
+
+#else /* ! E1000_REALIGN_DATA_HACK */
+#define E1000_REALIGN_BUFFER(a,i)	NULL
+#define E1000_REALIGN_BUFFER_DMA(a,i)	0
+#endif /* ! E1000_REALIGN_DATA_HACK */
+
+
 /* board specific private data structure */
 
 struct e1000_adapter {
@@ -186,6 +223,9 @@
 
 	/* TX */
 	struct e1000_desc_ring tx_ring;
+#if E1000_REALIGN_DATA_HACK
+	struct e1000_realign_ring realign_ring;
+#endif /* E1000_REALIGN_DATA_HACK */
 	uint32_t txd_cmd;
 	uint32_t tx_int_delay;
 	uint32_t tx_abs_int_delay;
diff -urN /scratch/anton/export/drivers/net/e1000/e1000_main.c linux-congo/drivers/net/e1000/e1000_main.c
--- /scratch/anton/export/drivers/net/e1000/e1000_main.c	2003-05-30 01:23:39.000000000 +1000
+++ linux-congo/drivers/net/e1000/e1000_main.c	2003-06-12 12:52:58.000000000 +1000
@@ -702,6 +702,23 @@
 	return 0;
 }
 
+static inline void
+e1000_setup_realign_ring(struct e1000_adapter *adapter)
+{
+#if E1000_REALIGN_DATA_HACK
+	struct e1000_desc_ring *txdr = &adapter->tx_ring;
+	struct e1000_realign_ring *rr = &adapter->realign_ring;
+
+	rr->size = txdr->count * E1000_REALIGN_BUFFER_SIZE;
+	rr->vaddr = pci_alloc_consistent(adapter->pdev, rr->size,
+					 &rr->dma_handle);
+
+	if (! rr->vaddr)
+		printk(KERN_WARNING "%s: could not allocate realignment buffers.  Expect poor performance on Power4 hardware\n",
+		       adapter->netdev->name);
+#endif /* E1000_REALIGN_DATA_HACK */
+}
+
 /**
  * e1000_setup_tx_resources - allocate Tx resources (Descriptors)
  * @adapter: board private structure
@@ -735,6 +752,8 @@
 	}
 	memset(txdr->desc, 0, txdr->size);
 
+	e1000_setup_realign_ring(adapter);
+
 	txdr->next_to_use = 0;
 	txdr->next_to_clean = 0;
 
@@ -951,6 +970,19 @@
 	E1000_WRITE_REG(&adapter->hw, RCTL, rctl);
 }
 
+static inline void
+e1000_free_realign_ring(struct e1000_adapter *adapter)
+{
+#if E1000_REALIGN_DATA_HACK
+	struct e1000_realign_ring *rr = &adapter->realign_ring;
+
+	if (rr->vaddr)
+		pci_free_consistent(adapter->pdev, rr->size,
+				    rr->vaddr, rr->dma_handle);
+	rr->vaddr = NULL;
+#endif /* E1000_REALIGN_DATA_HACK */
+}
+
 /**
  * e1000_free_tx_resources - Free Tx Resources
  * @adapter: board private structure
@@ -972,6 +1004,8 @@
 	                    adapter->tx_ring.desc, adapter->tx_ring.dma);
 
 	adapter->tx_ring.desc = NULL;
+
+	e1000_free_realign_ring(adapter);
 }
 
 /**
@@ -990,11 +1024,11 @@
 
 	for(i = 0; i < adapter->tx_ring.count; i++) {
 		if(adapter->tx_ring.buffer_info[i].skb) {
-
-			pci_unmap_page(pdev,
-			               adapter->tx_ring.buffer_info[i].dma,
-			               adapter->tx_ring.buffer_info[i].length,
-			               PCI_DMA_TODEVICE);
+			if(adapter->tx_ring.buffer_info[i].dma)
+				pci_unmap_page(pdev,
+					       adapter->tx_ring.buffer_info[i].dma,
+					       adapter->tx_ring.buffer_info[i].length,
+					       PCI_DMA_TODEVICE);
 
 			dev_kfree_skb(adapter->tx_ring.buffer_info[i].skb);
 
@@ -1491,6 +1525,21 @@
 #define E1000_MAX_DATA_PER_TXD	(1<<E1000_MAX_TXD_PWR)
 
 static inline int
+e1000_realign_data(struct e1000_adapter *adapter, unsigned char *data,
+		     int size, int i)
+{
+	unsigned char *buf = E1000_REALIGN_BUFFER(adapter, i);
+
+	if(buf && (size <= E1000_REALIGN_BUFFER_SIZE)
+	   && ((unsigned long)(data) % E1000_REALIGN_TARGET_ALIGNMENT)) {
+
+		memcpy(buf, data, size);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int
 e1000_tx_map(struct e1000_adapter *adapter, struct sk_buff *skb,
 	unsigned int first)
 {
@@ -1515,11 +1564,13 @@
 			size -= 4;
 #endif
 		tx_ring->buffer_info[i].length = size;
-		tx_ring->buffer_info[i].dma =
-			pci_map_single(adapter->pdev,
-				skb->data + offset,
-				size,
-				PCI_DMA_TODEVICE);
+		if (e1000_realign_data(adapter, skb->data+offset, size, i))
+			tx_ring->buffer_info[i].dma = 0;
+		else
+			tx_ring->buffer_info[i].dma =
+				pci_map_single(adapter->pdev,
+					       skb->data + offset, size,
+					       PCI_DMA_TODEVICE);
 		tx_ring->buffer_info[i].time_stamp = jiffies;
 
 		len -= size;
@@ -1593,7 +1644,13 @@
 
 	while(count--) {
 		tx_desc = E1000_TX_DESC(*tx_ring, i);
-		tx_desc->buffer_addr = cpu_to_le64(tx_ring->buffer_info[i].dma);
+		if (E1000_REALIGN_DATA_HACK
+		    && !tx_ring->buffer_info[i].dma)
+			tx_desc->buffer_addr =
+				cpu_to_le64(E1000_REALIGN_BUFFER_DMA(adapter, i));
+		else
+			tx_desc->buffer_addr =
+				cpu_to_le64(tx_ring->buffer_info[i].dma);
 		tx_desc->lower.data =
 			cpu_to_le32(txd_lower | tx_ring->buffer_info[i].length);
 		tx_desc->upper.data = cpu_to_le32(txd_upper);


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
