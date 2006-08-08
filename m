Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWHHTev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWHHTev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWHHTer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:47 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36083 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030257AbWHHTem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:42 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:34:05 +0200
Message-Id: <20060808193405.1396.14701.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 4/9] e100 driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the netdev_alloc_skb() API and the
NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 drivers/net/e100.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/net/e100.c
===================================================================
--- linux-2.6.orig/drivers/net/e100.c
+++ linux-2.6/drivers/net/e100.c
@@ -1763,7 +1763,7 @@ static inline void e100_start_receiver(s
 #define RFD_BUF_LEN (sizeof(struct rfd) + VLAN_ETH_FRAME_LEN)
 static int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
 {
-	if(!(rx->skb = dev_alloc_skb(RFD_BUF_LEN + NET_IP_ALIGN)))
+	if(!(rx->skb = netdev_alloc_skb(nic->netdev, RFD_BUF_LEN + NET_IP_ALIGN)))
 		return -ENOMEM;
 
 	/* Align, init, and map the RFD. */
@@ -2143,7 +2143,7 @@ static int e100_loopback_test(struct nic
 
 	e100_start_receiver(nic, NULL);
 
-	if(!(skb = dev_alloc_skb(ETH_DATA_LEN))) {
+	if(!(skb = netdev_alloc_skb(nic->netdev, ETH_DATA_LEN))) {
 		err = -ENOMEM;
 		goto err_loopback_none;
 	}
@@ -2573,6 +2573,7 @@ static int __devinit e100_probe(struct p
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = e100_netpoll;
 #endif
+	netdev->features |= NETIF_F_MEMALLOC;
 	strcpy(netdev->name, pci_name(pdev));
 
 	nic = netdev_priv(netdev);
