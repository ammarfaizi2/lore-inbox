Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUHCAO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUHCAO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUHCAOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:14:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20983 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264638AbUHCAMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:12:14 -0400
Date: Tue, 3 Aug 2004 02:12:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux.nics@intel.com, Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ixgb_main.c: fix inline compile errors (fwd)
Message-ID: <20040803001207.GU2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm2.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 14 Jul 2004 23:47:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux.nics@intel.com
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] ixgb_main.c: fix inline compile errors

Trying to compile drivers/net/ixgb/ixgb_main.c in 2.6.8-rc1-mm1 using 
gcc 3.4 results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/net/ixgb/ixgb_main.o
drivers/net/ixgb/ixgb_main.c: In function `ixgb_up':
drivers/net/ixgb/ixgb_main.c:86: sorry, unimplemented: inlining failed 
in call to 'ixgb_irq_enable': function body not available
drivers/net/ixgb/ixgb_main.c:234: sorry, unimplemented: called from here
make[3]: *** [drivers/net/ixgb/ixgb_main.o] Error 1

<--  snip  -->


The patch below moves some inlined functions above the place where they
are called the first time.

An alternative approach would be to remove the inlines.


diffstat output:
 drivers/net/ixgb/ixgb_main.c |  132 +++++++++++++++++------------------
 1 files changed, 66 insertions(+), 66 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/ixgb/ixgb_main.c.old	2004-07-14 23:41:47.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/ixgb/ixgb_main.c	2004-07-14 23:43:55.000000000 +0200
@@ -55,6 +55,8 @@
 
 /* Local Function Prototypes */
 
+static inline void ixgb_irq_disable(struct ixgb_adapter *adapter);
+static inline void ixgb_irq_enable(struct ixgb_adapter *adapter);
 int ixgb_up(struct ixgb_adapter *adapter);
 void ixgb_down(struct ixgb_adapter *adapter, boolean_t kill_watchdog);
 void ixgb_reset(struct ixgb_adapter *adapter);
@@ -82,10 +84,11 @@
 static int ixgb_change_mtu(struct net_device *netdev, int new_mtu);
 static int ixgb_set_mac(struct net_device *netdev, void *p);
 static void ixgb_update_stats(struct ixgb_adapter *adapter);
-static inline void ixgb_irq_disable(struct ixgb_adapter *adapter);
-static inline void ixgb_irq_enable(struct ixgb_adapter *adapter);
 static irqreturn_t ixgb_intr(int irq, void *data, struct pt_regs *regs);
 static boolean_t ixgb_clean_tx_irq(struct ixgb_adapter *adapter);
+static inline void ixgb_rx_checksum(struct ixgb_adapter *adapter,
+				    struct ixgb_rx_desc *rx_desc,
+				    struct sk_buff *skb);
 #ifdef CONFIG_IXGB_NAPI
 static int ixgb_clean(struct net_device *netdev, int *budget);
 static boolean_t ixgb_clean_rx_irq(struct ixgb_adapter *adapter,
@@ -95,9 +98,6 @@
 #endif
 static void ixgb_alloc_rx_buffers(struct ixgb_adapter *adapter);
 static int ixgb_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
-static inline void ixgb_rx_checksum(struct ixgb_adapter *adapter,
-				    struct ixgb_rx_desc *rx_desc,
-				    struct sk_buff *skb);
 static void ixgb_tx_timeout(struct net_device *dev);
 static void ixgb_tx_timeout_task(struct net_device *dev);
 static void ixgb_vlan_rx_register(struct net_device *netdev,
@@ -185,6 +185,34 @@
 
 module_exit(ixgb_exit_module);
 
+/**
+ * ixgb_irq_disable - Mask off interrupt generation on the NIC
+ * @adapter: board private structure
+ **/
+
+static inline void ixgb_irq_disable(struct ixgb_adapter *adapter)
+{
+	atomic_inc(&adapter->irq_sem);
+	IXGB_WRITE_REG(&adapter->hw, IMC, ~0);
+	IXGB_WRITE_FLUSH(&adapter->hw);
+	synchronize_irq(adapter->pdev->irq);
+}
+
+/**
+ * ixgb_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ **/
+
+static inline void ixgb_irq_enable(struct ixgb_adapter *adapter)
+{
+	if (atomic_dec_and_test(&adapter->irq_sem)) {
+		IXGB_WRITE_REG(&adapter->hw, IMS,
+			       IXGB_INT_RXT0 | IXGB_INT_RXDMT0 | IXGB_INT_TXDW |
+			       IXGB_INT_RXO | IXGB_INT_LSC);
+		IXGB_WRITE_FLUSH(&adapter->hw);
+	}
+}
+
 int ixgb_up(struct ixgb_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1550,34 +1578,6 @@
 	adapter->net_stats.tx_window_errors = 0;
 }
 
-/**
- * ixgb_irq_disable - Mask off interrupt generation on the NIC
- * @adapter: board private structure
- **/
-
-static inline void ixgb_irq_disable(struct ixgb_adapter *adapter)
-{
-	atomic_inc(&adapter->irq_sem);
-	IXGB_WRITE_REG(&adapter->hw, IMC, ~0);
-	IXGB_WRITE_FLUSH(&adapter->hw);
-	synchronize_irq(adapter->pdev->irq);
-}
-
-/**
- * ixgb_irq_enable - Enable default interrupt generation settings
- * @adapter: board private structure
- **/
-
-static inline void ixgb_irq_enable(struct ixgb_adapter *adapter)
-{
-	if (atomic_dec_and_test(&adapter->irq_sem)) {
-		IXGB_WRITE_REG(&adapter->hw, IMS,
-			       IXGB_INT_RXT0 | IXGB_INT_RXDMT0 | IXGB_INT_TXDW |
-			       IXGB_INT_RXO | IXGB_INT_LSC);
-		IXGB_WRITE_FLUSH(&adapter->hw);
-	}
-}
-
 #define IXGB_MAX_INTR 10
 /**
  * ixgb_intr - Interrupt Handler
@@ -1730,6 +1730,39 @@
 }
 
 /**
+ * ixgb_rx_checksum - Receive Checksum Offload for 82597.
+ * @adapter: board private structure
+ * @rx_desc: receive descriptor
+ * @sk_buff: socket buffer with received data
+ **/
+
+static inline void
+ixgb_rx_checksum(struct ixgb_adapter *adapter,
+		 struct ixgb_rx_desc *rx_desc, struct sk_buff *skb)
+{
+	/* Ignore Checksum bit is set OR 
+	 * TCP Checksum has not been calculated 
+	 */
+	if ((rx_desc->status & IXGB_RX_DESC_STATUS_IXSM) ||
+	    (!(rx_desc->status & IXGB_RX_DESC_STATUS_TCPCS))) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	/* At this point we know the hardware did the TCP checksum */
+	/* now look at the TCP checksum error bit */
+	if (rx_desc->errors & IXGB_RX_DESC_ERRORS_TCPE) {
+		/* let the stack verify checksum errors */
+		skb->ip_summed = CHECKSUM_NONE;
+		adapter->hw_csum_rx_error++;
+	} else {
+		/* TCP checksum is good */
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		adapter->hw_csum_rx_good++;
+	}
+}
+
+/**
  * ixgb_clean_rx_irq - Send received data up the network stack,
  * @adapter: board private structure
  **/
@@ -1956,39 +1989,6 @@
 }
 
 /**
- * ixgb_rx_checksum - Receive Checksum Offload for 82597.
- * @adapter: board private structure
- * @rx_desc: receive descriptor
- * @sk_buff: socket buffer with received data
- **/
-
-static inline void
-ixgb_rx_checksum(struct ixgb_adapter *adapter,
-		 struct ixgb_rx_desc *rx_desc, struct sk_buff *skb)
-{
-	/* Ignore Checksum bit is set OR 
-	 * TCP Checksum has not been calculated 
-	 */
-	if ((rx_desc->status & IXGB_RX_DESC_STATUS_IXSM) ||
-	    (!(rx_desc->status & IXGB_RX_DESC_STATUS_TCPCS))) {
-		skb->ip_summed = CHECKSUM_NONE;
-		return;
-	}
-
-	/* At this point we know the hardware did the TCP checksum */
-	/* now look at the TCP checksum error bit */
-	if (rx_desc->errors & IXGB_RX_DESC_ERRORS_TCPE) {
-		/* let the stack verify checksum errors */
-		skb->ip_summed = CHECKSUM_NONE;
-		adapter->hw_csum_rx_error++;
-	} else {
-		/* TCP checksum is good */
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		adapter->hw_csum_rx_good++;
-	}
-}
-
-/**
  * ixgb_vlan_rx_register - enables or disables vlan tagging/stripping.
  * 
  * @param netdev network interface device structure
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


