Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUF3S7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUF3S7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUF3S7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:59:14 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6358 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266807AbUF3S5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:57:11 -0400
Message-ID: <40E30CA7.3020209@colorfullife.com>
Date: Wed, 30 Jun 2004 20:55:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
References: <40E25328.8020102@colorfullife.com> <40E25944.8010200@pobox.com> <40E2E618.5020601@colorfullife.com>
In-Reply-To: <40E2E618.5020601@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------000006020406060009000704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006020406060009000704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:

>>
>> your driver needs to call pci_set_dma_mask() and 
>> pci_set_consistent_dma_mask().
>>
> I'll add that.
>
I've checked the pci layer: 32-bit is the default, thus no calls are 
required. What's missing is error handling for pci_map, I'll add that later.

Attached is an incremental patch that fixes the simple issues you 
mentioned. Could you merge both patches together to your tree? They 
improve the driver significantly and I want some test input from users.

I've added message flags and pci_map error handling to my todo list.
--
    Manfred

--------------000006020406060009000704
Content-Type: text/plain;
 name="patch-forced-candidate-inc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forced-candidate-inc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 7
//  EXTRAVERSION = -mm2
--- 2.6/drivers/net/forcedeth.c	2004-06-30 18:45:23.000000000 +0200
+++ build-2.6/drivers/net/forcedeth.c	2004-06-30 18:45:05.000000000 +0200
@@ -348,18 +348,22 @@ struct ring_desc {
 
 /* General driver defaults */
 #define NV_WATCHDOG_TIMEO	(5*HZ)
-#define DEFAULT_MTU		1500	/* also maximum supported, at least for now */
 
 #define RX_RING		128
 #define TX_RING		64
-/* limited to 1 packet until we understand NV_TX_LASTPACKET */
+/* 
+ * If your nic mysteriously hangs then try to reduce the limits
+ * to 1/0: It might be required to set NV_TX_LASTPACKET in the
+ * last valid ring entry. But this would be impossible to
+ * implement - probably a disassembly error.
+ */
 #define TX_LIMIT_STOP	63
 #define TX_LIMIT_START	62
 
 /* rx/tx mac addr + type + vlan + align + slack*/
-#define RX_NIC_BUFSIZE		(DEFAULT_MTU + 64)
+#define RX_NIC_BUFSIZE		(ETH_DATA_LEN + 64)
 /* even more slack */
-#define RX_ALLOC_BUFSIZE	(DEFAULT_MTU + 128)
+#define RX_ALLOC_BUFSIZE	(ETH_DATA_LEN + 128)
 
 #define OOM_REFILL	(1+HZ/20)
 #define POLL_WAIT	(1+HZ/100)
@@ -988,7 +992,7 @@ static void nv_tx_done(struct net_device
 	while (np->nic_tx != np->next_tx) {
 		i = np->nic_tx % TX_RING;
 
-		Flags = cpu_to_le32(np->tx_ring[i].FlagLen);
+		Flags = le32_to_cpu(np->tx_ring[i].FlagLen);
 
 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
 					dev->name, np->nic_tx, Flags);
@@ -1077,7 +1081,7 @@ static void nv_rx_process(struct net_dev
 			break;	/* we scanned the whole ring - do not continue */
 
 		i = np->cur_rx % RX_RING;
-		Flags = cpu_to_le32(np->rx_ring[i].FlagLen);
+		Flags = le32_to_cpu(np->rx_ring[i].FlagLen);
 		len = nv_descr_getlength(&np->rx_ring[i], np->desc_ver);
 
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
@@ -1193,7 +1197,7 @@ next_pkt:
  */
 static int nv_change_mtu(struct net_device *dev, int new_mtu)
 {
-	if (new_mtu > DEFAULT_MTU)
+	if (new_mtu > ETH_DATA_LEN)
 		return -EINVAL;
 	dev->mtu = new_mtu;
 	return 0;
@@ -1999,7 +2003,7 @@ static void __exit exit_nic(void)
 	pci_unregister_driver(&driver);
 }
 
-MODULE_PARM(max_interrupt_work, "i");
+module_param(max_interrupt_work, int, 0);
 MODULE_PARM_DESC(max_interrupt_work, "forcedeth maximum events handled per interrupt");
 
 MODULE_AUTHOR("Manfred Spraul <manfred@colorfullife.com>");

--------------000006020406060009000704--
