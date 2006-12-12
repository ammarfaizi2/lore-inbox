Return-Path: <linux-kernel-owner+w=401wt.eu-S1751507AbWLLQvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWLLQvN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWLLQvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:51:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37903 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbWLLQvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:51:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=M0bwkjMjax6w0MY+iAmhNpDYRWJSQe5W5Y8Z5Y1wCXSLMcZ0poJz2aC2IDtVh8hAPVVxh/ElC1oQ2+pjWzZERIjEtUuvknAYQnRPQE2SrRSbLOkvq2LQZ4EFIT2kdJcvGUcBvYUbDbe8eNPaCki7ef7ONSr6/Xoi7hpwkfe4HE8=
Subject: [PATCH 2.6.19] e1000: replace kmalloc with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, cramerj@intel.com
Content-Type: text/plain
Date: Tue, 12 Dec 2006 18:53:08 +0200
Message-Id: <1165942389.5611.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/drivers/net/e1000/e1000_ethtool.c linux-2.6.19-rc5_kzalloc/drivers/net/e1000/e1000_ethtool.c
--- linux-2.6.19-rc5_orig/drivers/net/e1000/e1000_ethtool.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/e1000/e1000_ethtool.c	2006-11-11 22:44:04.000000000 +0200
@@ -1053,11 +1053,10 @@ e1000_setup_desc_rings(struct e1000_adap
 		txdr->count = E1000_DEFAULT_TXD;
 
 	size = txdr->count * sizeof(struct e1000_buffer);
-	if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
+	if (!(txdr->buffer_info = kzalloc(size, GFP_KERNEL))) {
 		ret_val = 1;
 		goto err_nomem;
 	}
-	memset(txdr->buffer_info, 0, size);
 
 	txdr->size = txdr->count * sizeof(struct e1000_tx_desc);
 	E1000_ROUNDUP(txdr->size, 4096);
@@ -1109,11 +1108,10 @@ e1000_setup_desc_rings(struct e1000_adap
 		rxdr->count = E1000_DEFAULT_RXD;
 
 	size = rxdr->count * sizeof(struct e1000_buffer);
-	if (!(rxdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
+	if (!(rxdr->buffer_info = kzalloc(size, GFP_KERNEL))) {
 		ret_val = 4;
 		goto err_nomem;
 	}
-	memset(rxdr->buffer_info, 0, size);
 
 	rxdr->size = rxdr->count * sizeof(struct e1000_rx_desc);
 	if (!(rxdr->desc = pci_alloc_consistent(pdev, rxdr->size, &rxdr->dma))) {
diff -rubp linux-2.6.19-rc5_orig/drivers/net/e1000/e1000_main.c linux-2.6.19-rc5_kzalloc/drivers/net/e1000/e1000_main.c
--- linux-2.6.19-rc5_orig/drivers/net/e1000/e1000_main.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/e1000/e1000_main.c	2006-11-11 22:44:26.000000000 +0200
@@ -1228,28 +1228,25 @@ e1000_alloc_queues(struct e1000_adapter 
 	int size;
 
 	size = sizeof(struct e1000_tx_ring) * adapter->num_tx_queues;
-	adapter->tx_ring = kmalloc(size, GFP_KERNEL);
+	adapter->tx_ring = kzalloc(size, GFP_KERNEL);
 	if (!adapter->tx_ring)
 		return -ENOMEM;
-	memset(adapter->tx_ring, 0, size);
 
 	size = sizeof(struct e1000_rx_ring) * adapter->num_rx_queues;
-	adapter->rx_ring = kmalloc(size, GFP_KERNEL);
+	adapter->rx_ring = kzalloc(size, GFP_KERNEL);
 	if (!adapter->rx_ring) {
 		kfree(adapter->tx_ring);
 		return -ENOMEM;
 	}
-	memset(adapter->rx_ring, 0, size);
 
 #ifdef CONFIG_E1000_NAPI
 	size = sizeof(struct net_device) * adapter->num_rx_queues;
-	adapter->polling_netdev = kmalloc(size, GFP_KERNEL);
+	adapter->polling_netdev = kzalloc(size, GFP_KERNEL);
 	if (!adapter->polling_netdev) {
 		kfree(adapter->tx_ring);
 		kfree(adapter->rx_ring);
 		return -ENOMEM;
 	}
-	memset(adapter->polling_netdev, 0, size);
 #endif
 
 	return E1000_SUCCESS;
@@ -1626,17 +1623,16 @@ e1000_setup_rx_resources(struct e1000_ad
 	memset(rxdr->buffer_info, 0, size);
 
 	size = sizeof(struct e1000_ps_page) * rxdr->count;
-	rxdr->ps_page = kmalloc(size, GFP_KERNEL);
+	rxdr->ps_page = kzalloc(size, GFP_KERNEL);
 	if (!rxdr->ps_page) {
 		vfree(rxdr->buffer_info);
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the receive descriptor ring\n");
 		return -ENOMEM;
 	}
-	memset(rxdr->ps_page, 0, size);
 
 	size = sizeof(struct e1000_ps_page_dma) * rxdr->count;
-	rxdr->ps_page_dma = kmalloc(size, GFP_KERNEL);
+	rxdr->ps_page_dma = kzalloc(size, GFP_KERNEL);
 	if (!rxdr->ps_page_dma) {
 		vfree(rxdr->buffer_info);
 		kfree(rxdr->ps_page);
@@ -1644,7 +1640,6 @@ e1000_setup_rx_resources(struct e1000_ad
 		"Unable to allocate memory for the receive descriptor ring\n");
 		return -ENOMEM;
 	}
-	memset(rxdr->ps_page_dma, 0, size);
 
 	if (adapter->hw.mac_type <= e1000_82547_rev_2)
 		desc_len = sizeof(struct e1000_rx_desc);



