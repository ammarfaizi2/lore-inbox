Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWGCIBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGCIBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWGCIBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:01:30 -0400
Received: from srv1.iportent.com ([62.90.210.153]:36520 "EHLO iportent.com")
	by vger.kernel.org with ESMTP id S1750774AbWGCIBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:01:30 -0400
Subject: [PATCH 2.6.17.1 1/2] dllink driver: porting v1.19 to linux 2.6.17
From: Hayim Shaul <hayim@iportent.com>
To: edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 11:06:30 +0300
Message-Id: <1151913990.2859.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
For DLink Fiber NIC, Linux 2.4.22 ships with driver version 1.19,
whereas, Linux 2.6.x ship with driver version 1.17.

The following patch upgrades the 2.6.x driver to include changes (and
bug fixes done until 1.19b).

These fixes are (copied from the driver):
    1.18    2002/11/07  New tx scheme, adaptive tx_coalesce.
                    Remove tx_coalesce option.
    1.19    2003/12/16  Fix problem parsing the eeprom on big endian
                    systems. (philt@4bridgeworks.com)

Disclaimer:
Since I returned my DLink NIC to the store I couldn't test it
thoroughly. It seemed to work just as well as v1.17. However, both
version made the NIC hang after a few minutes.

Signed-off-by: Hayim Shaul <hayim@iportent.com>

--- linux-2.6.17.1/drivers/net/dl2k.h.orig	2006-07-03 10:28:47.000000000
+0300
+++ linux-2.6.17.1/drivers/net/dl2k.h	2006-07-03 10:41:13.000000000
+0300
@@ -36,7 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/time.h>
 #define TX_RING_SIZE	256
-#define TX_QUEUE_LEN	(TX_RING_SIZE - 1) /* Limit ring entries actually
used.*/
+#define TX_QUEUE_LEN	(TX_RING_SIZE - 10) /* Limit ring entries actually
used.*/
 #define RX_RING_SIZE 	256
 #define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
 #define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)
@@ -243,6 +243,9 @@ enum TFC_bits {
 	VLANTagInsert = 0x0000000010000000,
 	TFDDone = 0x80000000,
 	VIDShift = 32,
+	/* This const is too large for 32bit CPUs */
+	/* and is not used anyway */
+/*	CFI = 0x0000100000000000, */
 	UsePriorityShift = 48,
 };
 
@@ -512,7 +515,7 @@ typedef union t_MII_ESR {
 	u16 image;
 	struct {
 		u16 _bit_11_0:12;	// bit 11:0
-		u16 media_1000BT_HD:2;	// bit 12
+		u16 media_1000BT_HD:1;	// bit 12
 		u16 media_1000BT_FD:1;	// bit 13
 		u16 media_1000BX_HD:1;	// bit 14
 		u16 media_1000BX_FD:1;	// bit 15
@@ -655,6 +658,8 @@ struct netdev_private {
 	struct net_device_stats stats;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
 	unsigned int speed;		/* Operating speed */
+	struct tasklet_struct tx_tasklet;
+	struct tasklet_struct rx_tasklet;
 	unsigned int vlan;		/* VLAN Id */
 	unsigned int chip_id;		/* PCI table chip id */
 	unsigned int rx_coalesce; 	/* Maximum frames each RxDMAComplete intr
*/
@@ -672,6 +677,9 @@ struct netdev_private {
 	struct netdev_desc *last_tx;	/* Last Tx descriptor used. */
 	unsigned long cur_rx, old_rx;	/* Producer/consumer ring indices */
 	unsigned long cur_tx, old_tx;
+	unsigned long cur_task;
+	atomic_t tx_desc_lock;
+	int budget;
 	struct timer_list timer;
 	int wake_polarity;
 	char name[256];		/* net device description */
@@ -695,7 +703,7 @@ struct netdev_private {
         class_mask              of the class are honored during the
comparison.
         driver_data             Data private to the driver.
 */
-static struct pci_device_id rio_pci_tbl[] = {
+static struct pci_device_id rio_pci_tbl[] __devinitdata = {
 	{0x1186, 0x4000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
@@ -708,4 +716,5 @@ MODULE_DEVICE_TABLE (pci, rio_pci_tbl);
 #define DEFAULT_RXT		750
 #define DEFAULT_TXC		1
 #define MAX_TXC			8
+#define RX_BUDGET		RX_RING_SIZE/2
 #endif				/* __DL2K_H__ */

