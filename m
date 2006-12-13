Return-Path: <linux-kernel-owner+w=401wt.eu-S932607AbWLMHlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWLMHlp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWLMHlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:41:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:31962 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbWLMHlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:41:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HwhY13SYp71rVY54cJoThKut/X1avNGwNFTtPOcgIRGnKsFb/WEl2xcFFGu6X+OhMkmtvl26cfJ4cPObQ6kvVJkCyQcxzIhTfWQoBCc42Oo/J0zokLCKaSihTObx7KvCmlAbCoKRf/7wKvjxV/A8FeNFBN3MSafA9fbFaNbvQco=
Subject: [PATCH 2.6.19] e1000: replace kmalloc+memset with kcalloc and
	indent the way it is done in other parts of e1000
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: auke-jan.h.kok@intel.com
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:43:55 +0200
Message-Id: <1165995835.11348.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kcalloc + remove now unused size variable

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c linux-2.6.19_tests/drivers/net/e1000/e1000_ethtool.c
--- linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c	2006-11-30 21:28:21.000000000 +0200
+++ linux-2.6.19_tests/drivers/net/e1000/e1000_ethtool.c	2006-12-13 09:31:25.000000000 +0200
@@ -1045,19 +1045,18 @@ e1000_setup_desc_rings(struct e1000_adap
 	struct e1000_rx_ring *rxdr = &adapter->test_rx_ring;
 	struct pci_dev *pdev = adapter->pdev;
 	uint32_t rctl;
-	int size, i, ret_val;
+	int i, ret_val;
 
 	/* Setup Tx descriptor ring and Tx buffers */
 
 	if (!txdr->count)
 		txdr->count = E1000_DEFAULT_TXD;
 
-	size = txdr->count * sizeof(struct e1000_buffer);
-	if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
+	if (!(txdr->buffer_info = kcalloc(txdr->count, sizeof(struct e1000_buffer),
+					  GFP_KERNEL))) {
 		ret_val = 1;
 		goto err_nomem;
 	}
-	memset(txdr->buffer_info, 0, size);
 
 	txdr->size = txdr->count * sizeof(struct e1000_tx_desc);
 	E1000_ROUNDUP(txdr->size, 4096);
@@ -1108,12 +1107,11 @@ e1000_setup_desc_rings(struct e1000_adap
 	if (!rxdr->count)
 		rxdr->count = E1000_DEFAULT_RXD;
 
-	size = rxdr->count * sizeof(struct e1000_buffer);
-	if (!(rxdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
+	if (!(rxdr->buffer_info = kcalloc(rxdr->count, sizeof(struct e1000_buffer),
+					  GFP_KERNEL))) {
 		ret_val = 4;
 		goto err_nomem;
 	}
-	memset(rxdr->buffer_info, 0, size);
 
 	rxdr->size = rxdr->count * sizeof(struct e1000_rx_desc);
 	if (!(rxdr->desc = pci_alloc_consistent(pdev, rxdr->size, &rxdr->dma))) {
diff -rubp linux-2.6.19_orig/drivers/net/e1000/e1000_main.c linux-2.6.19_tests/drivers/net/e1000/e1000_main.c
--- linux-2.6.19_orig/drivers/net/e1000/e1000_main.c	2006-11-30 21:28:21.000000000 +0200
+++ linux-2.6.19_tests/drivers/net/e1000/e1000_main.c	2006-12-13 09:34:19.000000000 +0200
@@ -1225,31 +1225,26 @@ e1000_sw_init(struct e1000_adapter *adap
 static int __devinit
 e1000_alloc_queues(struct e1000_adapter *adapter)
 {
-	int size;
-
-	size = sizeof(struct e1000_tx_ring) * adapter->num_tx_queues;
-	adapter->tx_ring = kmalloc(size, GFP_KERNEL);
+	adapter->tx_ring = kcalloc(adapter->num_tx_queues, 
+				   sizeof(struct e1000_tx_ring), GFP_KERNEL);
 	if (!adapter->tx_ring)
 		return -ENOMEM;
-	memset(adapter->tx_ring, 0, size);
 
-	size = sizeof(struct e1000_rx_ring) * adapter->num_rx_queues;
-	adapter->rx_ring = kmalloc(size, GFP_KERNEL);
+	adapter->rx_ring = kcalloc(adapter->num_rx_queues,
+				   sizeof(struct e1000_rx_ring), GFP_KERNEL);
 	if (!adapter->rx_ring) {
 		kfree(adapter->tx_ring);
 		return -ENOMEM;
 	}
-	memset(adapter->rx_ring, 0, size);
 
 #ifdef CONFIG_E1000_NAPI
-	size = sizeof(struct net_device) * adapter->num_rx_queues;
-	adapter->polling_netdev = kmalloc(size, GFP_KERNEL);
+	adapter->polling_netdev = kcalloc(adapter->num_rx_queues,
+					  sizeof(struct net_device), GFP_KERNEL);
 	if (!adapter->polling_netdev) {
 		kfree(adapter->tx_ring);
 		kfree(adapter->rx_ring);
 		return -ENOMEM;
 	}
-	memset(adapter->polling_netdev, 0, size);
 #endif
 
 	return E1000_SUCCESS;
@@ -1625,18 +1620,17 @@ e1000_setup_rx_resources(struct e1000_ad
 	}
 	memset(rxdr->buffer_info, 0, size);
 
-	size = sizeof(struct e1000_ps_page) * rxdr->count;
-	rxdr->ps_page = kmalloc(size, GFP_KERNEL);
+	rxdr->ps_page = kcalloc(rxdr->count, sizeof(struct e1000_ps_page),
+				GFP_KERNEL);
 	if (!rxdr->ps_page) {
 		vfree(rxdr->buffer_info);
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the receive descriptor ring\n");
 		return -ENOMEM;
 	}
-	memset(rxdr->ps_page, 0, size);
 
-	size = sizeof(struct e1000_ps_page_dma) * rxdr->count;
-	rxdr->ps_page_dma = kmalloc(size, GFP_KERNEL);
+	rxdr->ps_page_dma = kcalloc(rxdr->count, sizeof(struct e1000_ps_page_dma),
+				    GFP_KERNEL);
 	if (!rxdr->ps_page_dma) {
 		vfree(rxdr->buffer_info);
 		kfree(rxdr->ps_page);
@@ -1644,7 +1638,6 @@ e1000_setup_rx_resources(struct e1000_ad
 		"Unable to allocate memory for the receive descriptor ring\n");
 		return -ENOMEM;
 	}
-	memset(rxdr->ps_page_dma, 0, size);
 
 	if (adapter->hw.mac_type <= e1000_82547_rev_2)
 		desc_len = sizeof(struct e1000_rx_desc);



