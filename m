Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVIHH1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVIHH1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVIHH1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:27:33 -0400
Received: from [211.20.77.211] ([211.20.77.211]:29867 "EHLO mail.redin.com.tw")
	by vger.kernel.org with ESMTP id S1751332AbVIHH1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:27:31 -0400
Message-ID: <431FE7C9.5070507@tw.ibm.com>
Date: Thu, 08 Sep 2005 15:27:05 +0800
From: Hubert WS Lin <wslin@tw.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, fubar@us.ibm.com, donf@us.ibm.com,
       jklewis@us.ibm.com
Subject: [PATCH 2.6.13] pcnet32: set_ringparam implementation
Content-Type: multipart/mixed;
 boundary="------------000609080201090308000407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609080201090308000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch implements the set_ringparam(), one of the ethtool 
operations, which allows changing tx/rx ring sizes via ethtool.

Changelog:
- Changed memery allocation of tx/rx ring from static to dynamic
- Implemented set_ringparam()
- Tested on i386 and ppc64

Signed-off-by: Hubert WS Lin <wslin@tw.ibm.com>
Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>

--------------000609080201090308000407
Content-Type: text/x-patch;
 name="pcnet32-set_ringparam.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32-set_ringparam.diff"

--- a/drivers/net/pcnet32.c	2005-09-02 15:06:30.000000000 +0800
+++ b/drivers/net/pcnet32.c	2005-09-02 15:58:06.000000000 +0800
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.30j"
-#define DRV_RELDATE	"29.04.2005"
+#define DRV_VERSION	"1.31"
+#define DRV_RELDATE	"02.Sep.2005"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -257,6 +257,7 @@ static int homepna[MAX_UNITS];
  * v1.30h  24 Jun 2004 Don Fry correctly select auto, speed, duplex in bcr32.
  * v1.30i  28 Jun 2004 Don Fry change to use module_param.
  * v1.30j  29 Apr 2005 Don Fry fix skb/map leak with loopback test.
+ * v1.31   02 Sep 2005 Hubert WS Lin <wslin@tw.ibm.c0m> added set_ringparam().
  */
 
 
@@ -266,17 +267,17 @@ static int homepna[MAX_UNITS];
  * That translates to 2 (4 == 2^^2) and 4 (16 == 2^^4).
  */
 #ifndef PCNET32_LOG_TX_BUFFERS
-#define PCNET32_LOG_TX_BUFFERS 4
-#define PCNET32_LOG_RX_BUFFERS 5
+#define PCNET32_LOG_TX_BUFFERS		4
+#define PCNET32_LOG_RX_BUFFERS		5
+#define PCNET32_LOG_MAX_TX_BUFFERS	9	/* 2^9 == 512 */
+#define PCNET32_LOG_MAX_RX_BUFFERS	9
 #endif
 
 #define TX_RING_SIZE		(1 << (PCNET32_LOG_TX_BUFFERS))
-#define TX_RING_MOD_MASK	(TX_RING_SIZE - 1)
-#define TX_RING_LEN_BITS	((PCNET32_LOG_TX_BUFFERS) << 12)
+#define TX_MAX_RING_SIZE	(1 << (PCNET32_LOG_MAX_TX_BUFFERS))
 
 #define RX_RING_SIZE		(1 << (PCNET32_LOG_RX_BUFFERS))
-#define RX_RING_MOD_MASK	(RX_RING_SIZE - 1)
-#define RX_RING_LEN_BITS	((PCNET32_LOG_RX_BUFFERS) << 4)
+#define RX_MAX_RING_SIZE	(1 << (PCNET32_LOG_MAX_RX_BUFFERS))
 
 #define PKT_BUF_SZ		1544
 
@@ -339,8 +340,8 @@ struct pcnet32_access {
  */
 struct pcnet32_private {
     /* The Tx and Rx ring entries must be aligned on 16-byte boundaries in 32bit mode. */
-    struct pcnet32_rx_head    rx_ring[RX_RING_SIZE];
-    struct pcnet32_tx_head    tx_ring[TX_RING_SIZE];
+    struct pcnet32_rx_head    *rx_ring;
+    struct pcnet32_tx_head    *tx_ring;
     struct pcnet32_init_block init_block;
     dma_addr_t		dma_addr;	/* DMA address of beginning of this
 					   object, returned by
@@ -349,13 +350,21 @@ struct pcnet32_private {
 					   structure */
     const char		*name;
     /* The saved address of a sent-in-place packet/buffer, for skfree(). */
-    struct sk_buff	*tx_skbuff[TX_RING_SIZE];
-    struct sk_buff	*rx_skbuff[RX_RING_SIZE];
-    dma_addr_t		tx_dma_addr[TX_RING_SIZE];
-    dma_addr_t		rx_dma_addr[RX_RING_SIZE];
+    struct sk_buff	**tx_skbuff;
+    struct sk_buff	**rx_skbuff;
+    dma_addr_t		*tx_dma_addr;
+    dma_addr_t		*rx_dma_addr;
     struct pcnet32_access	a;
     spinlock_t		lock;		/* Guard lock */
     unsigned int	cur_rx, cur_tx;	/* The next free ring entry */
+    unsigned int	rx_ring_size;	/* current rx ring size */
+    unsigned int	tx_ring_size;	/* current tx ring size */
+    unsigned int	rx_mod_mask;	/* rx ring modular mask */
+    unsigned int	tx_mod_mask;	/* tx ring modular mask */
+    unsigned short	rx_len_bits;
+    unsigned short	tx_len_bits;
+    dma_addr_t		rx_ring_dma_addr;
+    dma_addr_t		tx_ring_dma_addr;
     unsigned int	dirty_rx, dirty_tx; /* The ring entries to be free()ed. */
     struct net_device_stats stats;
     char		tx_full;
@@ -397,6 +406,9 @@ static int pcnet32_get_regs_len(struct n
 static void pcnet32_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	void *ptr);
 static void pcnet32_purge_tx_ring(struct net_device *dev);
+static int pcnet32_alloc_ring(struct net_device *dev);
+static void pcnet32_free_ring(struct net_device *dev);
+
 
 enum pci_flags_bit {
     PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
@@ -613,10 +625,59 @@ static void pcnet32_get_ringparam(struct
 {
     struct pcnet32_private *lp = dev->priv;
 
-    ering->tx_max_pending = TX_RING_SIZE - 1;
-    ering->tx_pending = lp->cur_tx - lp->dirty_tx;
-    ering->rx_max_pending = RX_RING_SIZE - 1;
-    ering->rx_pending = lp->cur_rx & RX_RING_MOD_MASK;
+    ering->tx_max_pending = TX_MAX_RING_SIZE - 1;
+    ering->tx_pending = lp->tx_ring_size - 1;
+    ering->rx_max_pending = RX_MAX_RING_SIZE - 1;
+    ering->rx_pending = lp->rx_ring_size - 1;
+}
+
+static int pcnet32_set_ringparam(struct net_device *dev, struct ethtool_ringparam *ering)
+{
+    struct pcnet32_private *lp = dev->priv;
+    unsigned long flags;
+    int i;
+
+    if (ering->rx_mini_pending || ering->rx_jumbo_pending)
+	return -EINVAL;
+
+    if (netif_running(dev))
+	pcnet32_close(dev);
+
+    spin_lock_irqsave(&lp->lock, flags);
+    pcnet32_free_ring(dev);
+    lp->tx_ring_size = min(ering->tx_pending, (unsigned int) TX_MAX_RING_SIZE);
+    lp->rx_ring_size = min(ering->rx_pending, (unsigned int) RX_MAX_RING_SIZE);
+
+    for (i = 0; i <= PCNET32_LOG_MAX_TX_BUFFERS; i++) {
+	if (lp->tx_ring_size <= (1 << i))
+	    break;
+    }
+    lp->tx_ring_size = (1 << i);
+    lp->tx_mod_mask = lp->tx_ring_size - 1;
+    lp->tx_len_bits = (i << 12);
+
+    for (i = 0; i <= PCNET32_LOG_MAX_RX_BUFFERS; i++) {
+	if (lp->rx_ring_size <= (1 << i))
+	    break;
+    }
+    lp->rx_ring_size = (1 << i);
+    lp->rx_mod_mask = lp->rx_ring_size - 1;
+    lp->rx_len_bits = (i << 4);
+
+    if (pcnet32_alloc_ring(dev)) {
+	pcnet32_free_ring(dev);
+	return -ENOMEM;
+    }
+
+    spin_unlock_irqrestore(&lp->lock, flags);
+
+    if (pcnet32_debug & NETIF_MSG_DRV)
+	printk(KERN_INFO PFX "Ring Param Settings: RX: %d, TX: %d\n", lp->rx_ring_size, lp->tx_ring_size);
+
+    if (netif_running(dev))
+	pcnet32_open(dev);
+
+    return 0;
 }
 
 static void pcnet32_get_strings(struct net_device *dev, u32 stringset, u8 *data)
@@ -948,6 +1009,7 @@ static struct ethtool_ops pcnet32_ethtoo
     .nway_reset		= pcnet32_nway_reset,
     .get_link		= pcnet32_get_link,
     .get_ringparam	= pcnet32_get_ringparam,
+    .set_ringparam	= pcnet32_set_ringparam,
     .get_tx_csum	= ethtool_op_get_tx_csum,
     .get_sg		= ethtool_op_get_sg,
     .get_tso		= ethtool_op_get_tso,
@@ -1239,6 +1301,12 @@ pcnet32_probe1(unsigned long ioaddr, int
     dev->priv = lp;
     lp->name = chipname;
     lp->shared_irq = shared;
+    lp->tx_ring_size = TX_RING_SIZE;		/* default tx ring size */
+    lp->rx_ring_size = RX_RING_SIZE;		/* default rx ring size */
+    lp->tx_mod_mask = lp->tx_ring_size - 1;
+    lp->rx_mod_mask = lp->rx_ring_size - 1;
+    lp->tx_len_bits = (PCNET32_LOG_TX_BUFFERS << 12);
+    lp->rx_len_bits = (PCNET32_LOG_RX_BUFFERS << 4);
     lp->mii_if.full_duplex = fdx;
     lp->mii_if.phy_id_mask = 0x1f;
     lp->mii_if.reg_num_mask = 0x1f;
@@ -1265,21 +1333,23 @@ pcnet32_probe1(unsigned long ioaddr, int
     }
     lp->a = *a;
 
+    if (pcnet32_alloc_ring(dev)) {
+	ret = -ENOMEM;
+	goto err_free_ring;
+    }
     /* detect special T1/E1 WAN card by checking for MAC address */
     if (dev->dev_addr[0] == 0x00 && dev->dev_addr[1] == 0xe0
 	    && dev->dev_addr[2] == 0x75)
 	lp->options = PCNET32_PORT_FD | PCNET32_PORT_GPSI;
 
     lp->init_block.mode = le16_to_cpu(0x0003);	/* Disable Rx and Tx. */
-    lp->init_block.tlen_rlen = le16_to_cpu(TX_RING_LEN_BITS | RX_RING_LEN_BITS);
+    lp->init_block.tlen_rlen = le16_to_cpu(lp->tx_len_bits | lp->rx_len_bits);
     for (i = 0; i < 6; i++)
 	lp->init_block.phys_addr[i] = dev->dev_addr[i];
     lp->init_block.filter[0] = 0x00000000;
     lp->init_block.filter[1] = 0x00000000;
-    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->dma_addr +
-	    offsetof(struct pcnet32_private, rx_ring));
-    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->dma_addr +
-	    offsetof(struct pcnet32_private, tx_ring));
+    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->rx_ring_dma_addr);
+    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->tx_ring_dma_addr);
 
     /* switch pcnet32 to 32bit mode */
     a->write_bcr(ioaddr, 20, 2);
@@ -1310,7 +1380,7 @@ pcnet32_probe1(unsigned long ioaddr, int
 	    if (pcnet32_debug & NETIF_MSG_PROBE)
 		printk(", failed to detect IRQ line.\n");
 	    ret = -ENODEV;
-	    goto err_free_consistent;
+	    goto err_free_ring;
 	}
 	if (pcnet32_debug & NETIF_MSG_PROBE)
 	    printk(", probed IRQ %d.\n", dev->irq);
@@ -1341,7 +1411,7 @@ pcnet32_probe1(unsigned long ioaddr, int
 
     /* Fill in the generic fields of the device structure. */
     if (register_netdev(dev))
-	goto err_free_consistent;
+	goto err_free_ring;
 
     if (pdev) {
 	pci_set_drvdata(pdev, dev);
@@ -1359,6 +1429,8 @@ pcnet32_probe1(unsigned long ioaddr, int
 
     return 0;
 
+err_free_ring:
+    pcnet32_free_ring(dev);
 err_free_consistent:
     pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 err_free_netdev:
@@ -1369,6 +1441,94 @@ err_release_region:
 }
 
 
+static int pcnet32_alloc_ring(struct net_device *dev)
+{
+    struct pcnet32_private *lp = dev->priv;
+
+    if ((lp->tx_ring = pci_alloc_consistent(lp->pci_dev, sizeof(struct pcnet32_tx_head) * lp->tx_ring_size,
+	&lp->tx_ring_dma_addr)) == NULL) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Consistent memory allocation failed.\n");
+	return -ENOMEM;
+    }
+
+    if ((lp->rx_ring = pci_alloc_consistent(lp->pci_dev, sizeof(struct pcnet32_rx_head) * lp->rx_ring_size,
+	&lp->rx_ring_dma_addr)) == NULL) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Consistent memory allocation failed.\n");
+	return -ENOMEM;
+    }
+
+    if (!(lp->tx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->tx_ring_size, GFP_ATOMIC))) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	return -ENOMEM;
+    }
+    memset(lp->tx_dma_addr, 0, sizeof(dma_addr_t) * lp->tx_ring_size);
+
+    if (!(lp->rx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->rx_ring_size, GFP_ATOMIC))) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	return -ENOMEM;
+    }
+    memset(lp->rx_dma_addr, 0, sizeof(dma_addr_t) * lp->rx_ring_size);
+
+    if (!(lp->tx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->tx_ring_size, GFP_ATOMIC))) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	return -ENOMEM;
+    }
+    memset(lp->tx_skbuff, 0, sizeof(struct sk_buff *) * lp->tx_ring_size);
+
+    if (!(lp->rx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->rx_ring_size, GFP_ATOMIC))) {
+	if (pcnet32_debug & NETIF_MSG_DRV)
+	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	return -ENOMEM;
+    }
+    memset(lp->rx_skbuff, 0, sizeof(struct sk_buff *) * lp->rx_ring_size);
+
+    return 0;
+}
+
+
+static void pcnet32_free_ring(struct net_device *dev)
+{
+    struct pcnet32_private *lp = dev->priv;
+
+    if (lp->tx_skbuff) {
+	kfree(lp->tx_skbuff);
+	lp->tx_skbuff = NULL;
+    }
+
+    if (lp->rx_skbuff) {
+	kfree(lp->rx_skbuff);
+	lp->rx_skbuff = NULL;
+    }
+
+    if (lp->tx_dma_addr) {
+	kfree(lp->tx_dma_addr);
+	lp->tx_dma_addr = NULL;
+    }
+
+    if (lp->rx_dma_addr) {
+	kfree(lp->rx_dma_addr);
+	lp->rx_dma_addr = NULL;
+    }
+
+    if (lp->tx_ring) {
+	pci_free_consistent(lp->pci_dev, sizeof(struct pcnet32_tx_head) * lp->tx_ring_size,
+		lp->tx_ring, lp->tx_ring_dma_addr);
+	lp->tx_ring = NULL;
+    }
+
+    if (lp->rx_ring) {
+	pci_free_consistent(lp->pci_dev, sizeof(struct pcnet32_rx_head) * lp->rx_ring_size,
+		lp->rx_ring, lp->rx_ring_dma_addr);
+	lp->rx_ring = NULL;
+    }
+}
+
+
 static int
 pcnet32_open(struct net_device *dev)
 {
@@ -1400,8 +1560,8 @@ pcnet32_open(struct net_device *dev)
     if (netif_msg_ifup(lp))
 	printk(KERN_DEBUG "%s: pcnet32_open() irq %d tx/rx rings %#x/%#x init %#x.\n",
 	       dev->name, dev->irq,
-	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, tx_ring)),
-	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, rx_ring)),
+	       (u32) (lp->tx_ring_dma_addr),
+	       (u32) (lp->rx_ring_dma_addr),
 	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, init_block)));
 
     /* set/reset autoselect bit */
@@ -1521,7 +1681,7 @@ pcnet32_open(struct net_device *dev)
 
 err_free_ring:
     /* free any allocated skbuffs */
-    for (i = 0; i < RX_RING_SIZE; i++) {
+    for (i = 0; i < lp->rx_ring_size; i++) {
 	lp->rx_ring[i].status = 0;
 	if (lp->rx_skbuff[i]) {
 	    pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], PKT_BUF_SZ-2,
@@ -1531,6 +1691,9 @@ err_free_ring:
 	lp->rx_skbuff[i] = NULL;
 	lp->rx_dma_addr[i] = 0;
     }
+
+    pcnet32_free_ring(dev);
+
     /*
      * Switch back to 16bit mode to avoid problems with dumb
      * DOS packet driver after a warm reboot
@@ -1562,7 +1725,7 @@ pcnet32_purge_tx_ring(struct net_device 
     struct pcnet32_private *lp = dev->priv;
     int i;
 
-    for (i = 0; i < TX_RING_SIZE; i++) {
+    for (i = 0; i < lp->tx_ring_size; i++) {
 	lp->tx_ring[i].status = 0;	/* CPU owns buffer */
 	wmb();	/* Make sure adapter sees owner change */
 	if (lp->tx_skbuff[i]) {
@@ -1587,7 +1750,7 @@ pcnet32_init_ring(struct net_device *dev
     lp->cur_rx = lp->cur_tx = 0;
     lp->dirty_rx = lp->dirty_tx = 0;
 
-    for (i = 0; i < RX_RING_SIZE; i++) {
+    for (i = 0; i < lp->rx_ring_size; i++) {
 	struct sk_buff *rx_skbuff = lp->rx_skbuff[i];
 	if (rx_skbuff == NULL) {
 	    if (!(rx_skbuff = lp->rx_skbuff[i] = dev_alloc_skb (PKT_BUF_SZ))) {
@@ -1611,20 +1774,18 @@ pcnet32_init_ring(struct net_device *dev
     }
     /* The Tx buffer address is filled in as needed, but we do need to clear
      * the upper ownership bit. */
-    for (i = 0; i < TX_RING_SIZE; i++) {
+    for (i = 0; i < lp->tx_ring_size; i++) {
 	lp->tx_ring[i].status = 0;	/* CPU owns buffer */
 	wmb();	/* Make sure adapter sees owner change */
 	lp->tx_ring[i].base = 0;
 	lp->tx_dma_addr[i] = 0;
     }
 
-    lp->init_block.tlen_rlen = le16_to_cpu(TX_RING_LEN_BITS | RX_RING_LEN_BITS);
+    lp->init_block.tlen_rlen = le16_to_cpu(lp->tx_len_bits | lp->rx_len_bits);
     for (i = 0; i < 6; i++)
 	lp->init_block.phys_addr[i] = dev->dev_addr[i];
-    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->dma_addr +
-	    offsetof(struct pcnet32_private, rx_ring));
-    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->dma_addr +
-	    offsetof(struct pcnet32_private, tx_ring));
+    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->rx_ring_dma_addr);
+    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->tx_ring_dma_addr);
     wmb();	/* Make sure all changes are visible */
     return 0;
 }
@@ -1682,13 +1843,13 @@ pcnet32_tx_timeout (struct net_device *d
 	printk(KERN_DEBUG " Ring data dump: dirty_tx %d cur_tx %d%s cur_rx %d.",
 	   lp->dirty_tx, lp->cur_tx, lp->tx_full ? " (full)" : "",
 	   lp->cur_rx);
-	for (i = 0 ; i < RX_RING_SIZE; i++)
+	for (i = 0 ; i < lp->rx_ring_size; i++)
 	printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
 	       le32_to_cpu(lp->rx_ring[i].base),
 	       (-le16_to_cpu(lp->rx_ring[i].buf_length)) & 0xffff,
 	       le32_to_cpu(lp->rx_ring[i].msg_length),
 	       le16_to_cpu(lp->rx_ring[i].status));
-	for (i = 0 ; i < TX_RING_SIZE; i++)
+	for (i = 0 ; i < lp->tx_ring_size; i++)
 	printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
 	       le32_to_cpu(lp->tx_ring[i].base),
 	       (-le16_to_cpu(lp->tx_ring[i].length)) & 0xffff,
@@ -1729,7 +1890,7 @@ pcnet32_start_xmit(struct sk_buff *skb, 
     /* Fill in a Tx ring entry */
 
     /* Mask to ring buffer boundary. */
-    entry = lp->cur_tx & TX_RING_MOD_MASK;
+    entry = lp->cur_tx & lp->tx_mod_mask;
 
     /* Caution: the write order is important here, set the status
      * with the "ownership" bits last. */
@@ -1753,7 +1914,7 @@ pcnet32_start_xmit(struct sk_buff *skb, 
 
     dev->trans_start = jiffies;
 
-    if (lp->tx_ring[(entry+1) & TX_RING_MOD_MASK].base != 0) {
+    if (lp->tx_ring[(entry+1) & lp->tx_mod_mask].base != 0) {
 	lp->tx_full = 1;
 	netif_stop_queue(dev);
     }
@@ -1806,7 +1967,7 @@ pcnet32_interrupt(int irq, void *dev_id,
 	    int delta;
 
 	    while (dirty_tx != lp->cur_tx) {
-		int entry = dirty_tx & TX_RING_MOD_MASK;
+		int entry = dirty_tx & lp->tx_mod_mask;
 		int status = (short)le16_to_cpu(lp->tx_ring[entry].status);
 
 		if (status < 0)
@@ -1864,18 +2025,18 @@ pcnet32_interrupt(int irq, void *dev_id,
 		dirty_tx++;
 	    }
 
-	    delta = (lp->cur_tx - dirty_tx) & (TX_RING_MOD_MASK + TX_RING_SIZE);
-	    if (delta > TX_RING_SIZE) {
+	    delta = (lp->cur_tx - dirty_tx) & (lp->tx_mod_mask + lp->tx_ring_size);
+	    if (delta > lp->tx_ring_size) {
 		if (netif_msg_drv(lp))
 		    printk(KERN_ERR "%s: out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
 			    dev->name, dirty_tx, lp->cur_tx, lp->tx_full);
-		dirty_tx += TX_RING_SIZE;
-		delta -= TX_RING_SIZE;
+		dirty_tx += lp->tx_ring_size;
+		delta -= lp->tx_ring_size;
 	    }
 
 	    if (lp->tx_full &&
 		netif_queue_stopped(dev) &&
-		delta < TX_RING_SIZE - 2) {
+		delta < lp->tx_ring_size - 2) {
 		/* The ring is no longer full, clear tbusy. */
 		lp->tx_full = 0;
 		netif_wake_queue (dev);
@@ -1932,8 +2093,8 @@ static int
 pcnet32_rx(struct net_device *dev)
 {
     struct pcnet32_private *lp = dev->priv;
-    int entry = lp->cur_rx & RX_RING_MOD_MASK;
-    int boguscnt = RX_RING_SIZE / 2;
+    int entry = lp->cur_rx & lp->rx_mod_mask;
+    int boguscnt = lp->rx_ring_size / 2;
 
     /* If we own the next entry, it's a new packet. Send it up. */
     while ((short)le16_to_cpu(lp->rx_ring[entry].status) >= 0) {
@@ -1998,12 +2159,12 @@ pcnet32_rx(struct net_device *dev)
 		    if (netif_msg_drv(lp))
 			printk(KERN_ERR "%s: Memory squeeze, deferring packet.\n",
 				dev->name);
-		    for (i = 0; i < RX_RING_SIZE; i++)
+		    for (i = 0; i < lp->rx_ring_size; i++)
 			if ((short)le16_to_cpu(lp->rx_ring[(entry+i)
-				    & RX_RING_MOD_MASK].status) < 0)
+				    & lp->rx_mod_mask].status) < 0)
 			    break;
 
-		    if (i > RX_RING_SIZE -2) {
+		    if (i > lp->rx_ring_size -2) {
 			lp->stats.rx_dropped++;
 			lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
 			wmb();	/* Make sure adapter sees owner change */
@@ -2041,7 +2202,7 @@ pcnet32_rx(struct net_device *dev)
 	lp->rx_ring[entry].buf_length = le16_to_cpu(2-PKT_BUF_SZ);
 	wmb(); /* Make sure owner changes after all others are visible */
 	lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
-	entry = (++lp->cur_rx) & RX_RING_MOD_MASK;
+	entry = (++lp->cur_rx) & lp->rx_mod_mask;
 	if (--boguscnt <= 0) break;	/* don't stay in loop forever */
     }
 
@@ -2084,7 +2245,7 @@ pcnet32_close(struct net_device *dev)
     spin_lock_irqsave(&lp->lock, flags);
 
     /* free all allocated skbuffs */
-    for (i = 0; i < RX_RING_SIZE; i++) {
+    for (i = 0; i < lp->rx_ring_size; i++) {
 	lp->rx_ring[i].status = 0;
 	wmb();		/* Make sure adapter sees owner change */
 	if (lp->rx_skbuff[i]) {
@@ -2096,7 +2257,7 @@ pcnet32_close(struct net_device *dev)
 	lp->rx_dma_addr[i] = 0;
     }
 
-    for (i = 0; i < TX_RING_SIZE; i++) {
+    for (i = 0; i < lp->tx_ring_size; i++) {
 	lp->tx_ring[i].status = 0;	/* CPU owns buffer */
 	wmb();		/* Make sure adapter sees owner change */
 	if (lp->tx_skbuff[i]) {
@@ -2265,6 +2426,7 @@ static void __devexit pcnet32_remove_one
 	struct pcnet32_private *lp = dev->priv;
 
 	unregister_netdev(dev);
+	pcnet32_free_ring(dev);
 	release_region(dev->base_addr, PCNET32_TOTAL_SIZE);
 	pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	free_netdev(dev);
@@ -2340,6 +2502,7 @@ static void __exit pcnet32_cleanup_modul
 	struct pcnet32_private *lp = pcnet32_dev->priv;
 	next_dev = lp->next;
 	unregister_netdev(pcnet32_dev);
+	pcnet32_free_ring(pcnet32_dev);
 	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
 	pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	free_netdev(pcnet32_dev);

--------------000609080201090308000407--
