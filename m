Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUGNVBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUGNVBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUGNVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:01:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21745 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264579AbUGNVB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:01:29 -0400
Date: Wed, 14 Jul 2004 23:01:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.6 patch] e1000_main.c: fix inline compile errors
Message-ID: <20040714210121.GN7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/net/e1000/e1000_main.c in 2.6.8-rc1-mm1 
with gcc 3.4 results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/net/e1000/e1000_main.o
drivers/net/e1000/e1000_main.c: In function `e1000_up':
drivers/net/e1000/e1000_main.c:136: sorry, unimplemented: inlining 
failed in call to 'e1000_irq_enable': function body not available
drivers/net/e1000/e1000_main.c:274: sorry, unimplemented: called from here
make[3]: *** [drivers/net/e1000/e1000_main.o] Error 1

<--  snip  -->


The patch below moves some inlined functions before the place where they 
are called the first time.

An alternative approach would be to remove the inlines.


diffstat output:
 drivers/net/e1000/e1000_main.c |  137 ++++++++++++++++-----------------
 1 files changed, 69 insertions(+), 68 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/e1000/e1000_main.c.old	2004-07-14 22:54:53.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/e1000/e1000_main.c	2004-07-14 22:58:41.000000000 +0200
@@ -100,6 +100,9 @@
 
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
+static inline void e1000_irq_disable(struct e1000_adapter *adapter);
+static inline void e1000_irq_enable(struct e1000_adapter *adapter);
+
 int e1000_up(struct e1000_adapter *adapter);
 void e1000_down(struct e1000_adapter *adapter);
 void e1000_reset(struct e1000_adapter *adapter);
@@ -132,10 +135,11 @@
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
 static int e1000_change_mtu(struct net_device *netdev, int new_mtu);
 static int e1000_set_mac(struct net_device *netdev, void *p);
-static inline void e1000_irq_disable(struct e1000_adapter *adapter);
-static inline void e1000_irq_enable(struct e1000_adapter *adapter);
 static irqreturn_t e1000_intr(int irq, void *data, struct pt_regs *regs);
 static boolean_t e1000_clean_tx_irq(struct e1000_adapter *adapter);
+static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
+                                     struct e1000_rx_desc *rx_desc,
+                                     struct sk_buff *skb);
 #ifdef CONFIG_E1000_NAPI
 static int e1000_clean(struct net_device *netdev, int *budget);
 static boolean_t e1000_clean_rx_irq(struct e1000_adapter *adapter,
@@ -150,9 +154,6 @@
 void set_ethtool_ops(struct net_device *netdev);
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
-static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
-                                     struct e1000_rx_desc *rx_desc,
-                                     struct sk_buff *skb);
 static void e1000_tx_timeout(struct net_device *dev);
 static void e1000_tx_timeout_task(struct net_device *dev);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
@@ -248,6 +249,34 @@
 module_exit(e1000_exit_module);
 
 
+/**
+ * e1000_irq_disable - Mask off interrupt generation on the NIC
+ * @adapter: board private structure
+ **/
+
+static inline void
+e1000_irq_disable(struct e1000_adapter *adapter)
+{
+	atomic_inc(&adapter->irq_sem);
+	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
+	E1000_WRITE_FLUSH(&adapter->hw);
+	synchronize_irq(adapter->pdev->irq);
+}
+
+/**
+ * e1000_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ **/
+
+static inline void
+e1000_irq_enable(struct e1000_adapter *adapter)
+{
+	if(atomic_dec_and_test(&adapter->irq_sem)) {
+		E1000_WRITE_REG(&adapter->hw, IMS, IMS_ENABLE_MASK);
+		E1000_WRITE_FLUSH(&adapter->hw);
+	}
+}
+
 int
 e1000_up(struct e1000_adapter *adapter)
 {
@@ -2055,34 +2084,6 @@
 }
 
 /**
- * e1000_irq_disable - Mask off interrupt generation on the NIC
- * @adapter: board private structure
- **/
-
-static inline void
-e1000_irq_disable(struct e1000_adapter *adapter)
-{
-	atomic_inc(&adapter->irq_sem);
-	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
-	E1000_WRITE_FLUSH(&adapter->hw);
-	synchronize_irq(adapter->pdev->irq);
-}
-
-/**
- * e1000_irq_enable - Enable default interrupt generation settings
- * @adapter: board private structure
- **/
-
-static inline void
-e1000_irq_enable(struct e1000_adapter *adapter)
-{
-	if(atomic_dec_and_test(&adapter->irq_sem)) {
-		E1000_WRITE_REG(&adapter->hw, IMS, IMS_ENABLE_MASK);
-		E1000_WRITE_FLUSH(&adapter->hw);
-	}
-}
-
-/**
  * e1000_intr - Interrupt Handler
  * @irq: interrupt number
  * @data: pointer to a network interface device structure
@@ -2227,6 +2228,41 @@
 }
 
 /**
+ * e1000_rx_checksum - Receive Checksum Offload for 82543
+ * @adapter: board private structure
+ * @rx_desc: receive descriptor
+ * @sk_buff: socket buffer with received data
+ **/
+
+static inline void
+e1000_rx_checksum(struct e1000_adapter *adapter,
+                  struct e1000_rx_desc *rx_desc,
+                  struct sk_buff *skb)
+{
+	/* 82543 or newer only */
+	if((adapter->hw.mac_type < e1000_82543) ||
+	/* Ignore Checksum bit is set */
+	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
+	/* TCP Checksum has not been calculated */
+	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	/* At this point we know the hardware did the TCP checksum */
+	/* now look at the TCP checksum error bit */
+	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
+		/* let the stack verify checksum errors */
+		skb->ip_summed = CHECKSUM_NONE;
+		adapter->hw_csum_err++;
+	} else {
+	/* TCP checksum is good */
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		adapter->hw_csum_good++;
+	}
+}
+
+/**
  * e1000_clean_rx_irq - Send received data up the network stack,
  * @adapter: board private structure
  **/
@@ -2580,41 +2616,6 @@
 	return E1000_SUCCESS;
 }
 
-/**
- * e1000_rx_checksum - Receive Checksum Offload for 82543
- * @adapter: board private structure
- * @rx_desc: receive descriptor
- * @sk_buff: socket buffer with received data
- **/
-
-static inline void
-e1000_rx_checksum(struct e1000_adapter *adapter,
-                  struct e1000_rx_desc *rx_desc,
-                  struct sk_buff *skb)
-{
-	/* 82543 or newer only */
-	if((adapter->hw.mac_type < e1000_82543) ||
-	/* Ignore Checksum bit is set */
-	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
-	/* TCP Checksum has not been calculated */
-	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
-		skb->ip_summed = CHECKSUM_NONE;
-		return;
-	}
-
-	/* At this point we know the hardware did the TCP checksum */
-	/* now look at the TCP checksum error bit */
-	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
-		/* let the stack verify checksum errors */
-		skb->ip_summed = CHECKSUM_NONE;
-		adapter->hw_csum_err++;
-	} else {
-	/* TCP checksum is good */
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		adapter->hw_csum_good++;
-	}
-}
-
 void
 e1000_pci_set_mwi(struct e1000_hw *hw)
 {
