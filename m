Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSKTSqX>; Wed, 20 Nov 2002 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSKTSqX>; Wed, 20 Nov 2002 13:46:23 -0500
Received: from robur.slu.se ([130.238.98.12]:23826 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S261416AbSKTSqV>;
	Wed, 20 Nov 2002 13:46:21 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.56316.564937.169193@robur.slu.se>
Date: Wed, 20 Nov 2002 20:01:16 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se
Subject: e1000 fixes (NAPI)
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Two fixes the NAPI branch of e1000.


1) e1000_irq_disable was used to disable irqs which called synchronize_irq
   which in turn caused a solid hang on SMP systems.

2) Interrupt acking patch previously sent by DaveM.

Cheers.
						--ro



--- linux/drivers/net/e1000.vanilla/e1000.h	2002-11-13 12:54:49.000000000 +0100
+++ linux/drivers/net/e1000/e1000.h	2002-11-20 15:00:14.000000000 +0100
@@ -181,6 +181,10 @@
 	uint32_t tx_abs_int_delay;
 	int max_data_per_txd;
 
+#ifdef CONFIG_E1000_NAPI
+        uint32_t icr_pending;
+#endif
+
 	/* RX */
 	struct e1000_desc_ring rx_ring;
 	uint64_t hw_csum_err;
--- linux/drivers/net/e1000.vanilla/e1000_main.c	2002-11-13 12:54:49.000000000 +0100
+++ linux/drivers/net/e1000/e1000_main.c	2002-11-20 17:37:55.000000000 +0100
@@ -1896,15 +1896,29 @@
 {
 	struct net_device *netdev = data;
 	struct e1000_adapter *adapter = netdev->priv;
+	uint32_t icr;
+	int i = E1000_MAX_INTR;
+
 	
 #ifdef CONFIG_E1000_NAPI
-	if (netif_rx_schedule_prep(netdev)) {
-		e1000_irq_disable(adapter);
+	icr = E1000_READ_REG(&adapter->hw, ICR);
+	if (icr && netif_rx_schedule_prep(netdev)) {
+
+	        /* Disable interrupts */
+                atomic_inc(&adapter->irq_sem);
+                E1000_WRITE_REG(&adapter->hw, IMC, ~0);
+
+		/*      E1000_WRITE_FLUSH(&adapter->hw); 
+		 * E1000_READ below syncs it  --ro
+		 */
+
 		__netif_rx_schedule(netdev);
+ 
+		adapter->icr_pending = icr;
+		while (i-- && (icr = E1000_READ_REG(&adapter->hw, ICR)) != 0)
+		         adapter->icr_pending |= icr;
 	}
 #else
-	uint32_t icr;
-	int i = E1000_MAX_INTR;
 
 	while(i && (icr = E1000_READ_REG(&adapter->hw, ICR))) {
 
@@ -1930,7 +1944,15 @@
 	int i = E1000_MAX_INTR;
 	int hasReceived = 0;
 
-	while(i && (icr = E1000_READ_REG(&adapter->hw, ICR))) {
+        while(i) {
+                if (adapter->icr_pending) {
+                        icr = adapter->icr_pending;
+                        adapter->icr_pending = 0;
+                } else
+                        icr = E1000_READ_REG(&adapter->hw, ICR);
+                if (!icr)
+                        break;
+
 		if (icr & E1000_ICR_RXT0)
 			hasReceived = 1;
  

