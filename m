Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVCNV1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVCNV1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVCNV0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:26:39 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:62737 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261952AbVCNVZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:25:23 -0500
Date: Mon, 14 Mar 2005 16:25:15 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch 2.6.11] e1000: avoid sleeping in watchdog timer context
Message-ID: <20050314212510.GA12573@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	jgarzik@pobox.com, cramerj@intel.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move bulk of e1000_watchdog to a workqueue to make it safe to call
functions which can sleep.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
The e1000 driver uses a timer to invoke e1000_watchdog().
e1000_watchdog() calls e1000_check_for_link() which can call
e1000_config_dsp_after_link_change().  This in turn can call
msec_delay().  msec_delay() is, of course, simply a wrapper for
msleep().

Since a timer does not have a process context, sleeping is impossible.
Attempting to do so causes a crash.

The fix is to move the body of e1000_watchdog() to the newly defined
e1000_watchdog_task().  This is invoked via the workqueue interface
from the new version of e1000_watchdog().

 drivers/net/e1000/e1000.h      |    1 +
 drivers/net/e1000/e1000_main.c |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

--- linux-2.6.11/drivers/net/e1000/e1000.h.orig	2005-03-14 16:06:53.000000000 -0500
+++ linux-2.6.11/drivers/net/e1000/e1000.h	2005-03-14 16:16:37.436364543 -0500
@@ -203,6 +203,7 @@ struct e1000_adapter {
 	spinlock_t stats_lock;
 	atomic_t irq_sem;
 	struct work_struct tx_timeout_task;
+	struct work_struct watchdog_task;
 	uint8_t fc_autoneg;
 
 	struct timer_list blink_timer;
--- linux-2.6.11/drivers/net/e1000/e1000_main.c.orig	2005-03-14 16:09:42.991007873 -0500
+++ linux-2.6.11/drivers/net/e1000/e1000_main.c	2005-03-14 16:16:37.438364260 -0500
@@ -142,6 +142,7 @@ static void e1000_clean_rx_ring(struct e
 static void e1000_set_multi(struct net_device *netdev);
 static void e1000_update_phy_info(unsigned long data);
 static void e1000_watchdog(unsigned long data);
+static void e1000_watchdog_task(struct e1000_adapter *adapter);
 static void e1000_82547_tx_fifo_stall(unsigned long data);
 static int e1000_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
@@ -574,6 +575,9 @@ e1000_probe(struct pci_dev *pdev,
 	adapter->watchdog_timer.function = &e1000_watchdog;
 	adapter->watchdog_timer.data = (unsigned long) adapter;
 
+	INIT_WORK(&adapter->watchdog_task,
+		(void (*)(void *))e1000_watchdog_task, adapter);
+
 	init_timer(&adapter->phy_info_timer);
 	adapter->phy_info_timer.function = &e1000_update_phy_info;
 	adapter->phy_info_timer.data = (unsigned long) adapter;
@@ -1529,13 +1533,20 @@ e1000_82547_tx_fifo_stall(unsigned long 
 
 /**
  * e1000_watchdog - Timer Call-back
- * @data: pointer to netdev cast into an unsigned long
+ * @data: pointer to adapter cast into an unsigned long
  **/
-
 static void
 e1000_watchdog(unsigned long data)
 {
 	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+
+	/* Do the rest outside of interrupt context */
+	schedule_work(&adapter->watchdog_task);
+}
+
+static void
+e1000_watchdog_task(struct e1000_adapter *adapter)
+{
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_desc_ring *txdr = &adapter->tx_ring;
 	uint32_t link;
-- 
John W. Linville
linville@tuxdriver.com
