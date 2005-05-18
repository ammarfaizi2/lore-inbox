Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVERB4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVERB4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVERB4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:56:23 -0400
Received: from graphe.net ([209.204.138.32]:62469 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261984AbVERB4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:56:09 -0400
Date: Tue, 17 May 2005 18:56:06 -0700 (PDT)
From: Christoph Lameter <christoph@graphe.net>
To: linux-kernel@vger.kernel.org
cc: netdev@oss.sgi.com, akpm@osdl.org
Subject: [PATCH] NUMA aware allocation of transmit and receive buffers for
 e1000
Message-ID: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA awareness for the e1000 driver. Allocate transmit and receive buffers
on the node of the device.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Justin M. Forbes <jmforbes@linuxtx.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.11.orig/drivers/net/e1000/e1000_main.c	2005-05-17 16:44:20.000000000 -0700
+++ linux-2.6.11/drivers/net/e1000/e1000_main.c	2005-05-17 17:47:43.000000000 -0700
@@ -120,8 +120,8 @@ int e1000_up(struct e1000_adapter *adapt
 void e1000_down(struct e1000_adapter *adapter);
 void e1000_reset(struct e1000_adapter *adapter);
 int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
-int e1000_setup_tx_resources(struct e1000_adapter *adapter);
-int e1000_setup_rx_resources(struct e1000_adapter *adapter);
+int e1000_setup_tx_resources(struct e1000_adapter *adapter, int node);
+int e1000_setup_rx_resources(struct e1000_adapter *adapter, int node);
 void e1000_free_tx_resources(struct e1000_adapter *adapter);
 void e1000_free_rx_resources(struct e1000_adapter *adapter);
 void e1000_update_stats(struct e1000_adapter *adapter);
@@ -513,6 +513,7 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
+	netdev->node = pcibus_to_node(pdev->bus);
 
 	adapter->bd_number = cards_found;
 
@@ -785,12 +786,12 @@ e1000_open(struct net_device *netdev)
 
 	/* allocate transmit descriptors */
 
-	if((err = e1000_setup_tx_resources(adapter)))
+	if((err = e1000_setup_tx_resources(adapter, netdev->node)))
 		goto err_setup_tx;
 
 	/* allocate receive descriptors */
 
-	if((err = e1000_setup_rx_resources(adapter)))
+	if((err = e1000_setup_rx_resources(adapter, netdev->node)))
 		goto err_setup_rx;
 
 	if((err = e1000_up(adapter)))
@@ -866,14 +867,14 @@ e1000_check_64k_bound(struct e1000_adapt
  **/
 
 int
-e1000_setup_tx_resources(struct e1000_adapter *adapter)
+e1000_setup_tx_resources(struct e1000_adapter *adapter, int node)
 {
 	struct e1000_desc_ring *txdr = &adapter->tx_ring;
 	struct pci_dev *pdev = adapter->pdev;
 	int size;
 
 	size = sizeof(struct e1000_buffer) * txdr->count;
-	txdr->buffer_info = vmalloc(size);
+	txdr->buffer_info = kmalloc_node(size, GFP_KERNEL, node);
 	if(!txdr->buffer_info) {
 		DPRINTK(PROBE, ERR, 
 		"Unable to Allocate Memory for the Transmit descriptor ring\n");
@@ -891,7 +892,7 @@ e1000_setup_tx_resources(struct e1000_ad
 setup_tx_desc_die:
 		DPRINTK(PROBE, ERR, 
 		"Unable to Allocate Memory for the Transmit descriptor ring\n");
-		vfree(txdr->buffer_info);
+		kfree(txdr->buffer_info);
 		return -ENOMEM;
 	}
 
@@ -1018,14 +1019,14 @@ e1000_configure_tx(struct e1000_adapter 
  **/
 
 int
-e1000_setup_rx_resources(struct e1000_adapter *adapter)
+e1000_setup_rx_resources(struct e1000_adapter *adapter, int node)
 {
 	struct e1000_desc_ring *rxdr = &adapter->rx_ring;
 	struct pci_dev *pdev = adapter->pdev;
 	int size;
 
 	size = sizeof(struct e1000_buffer) * rxdr->count;
-	rxdr->buffer_info = vmalloc(size);
+	rxdr->buffer_info = kmalloc_node(size, GFP_KERNEL, node);
 	if(!rxdr->buffer_info) {
 		DPRINTK(PROBE, ERR, 
 		"Unable to Allocate Memory for the Recieve descriptor ring\n");
@@ -1044,7 +1045,7 @@ e1000_setup_rx_resources(struct e1000_ad
 setup_rx_desc_die:
 		DPRINTK(PROBE, ERR, 
 		"Unble to Allocate Memory for the Recieve descriptor ring\n");
-		vfree(rxdr->buffer_info);
+		kfree(rxdr->buffer_info);
 		return -ENOMEM;
 	}
 
@@ -1197,7 +1198,7 @@ e1000_free_tx_resources(struct e1000_ada
 
 	e1000_clean_tx_ring(adapter);
 
-	vfree(adapter->tx_ring.buffer_info);
+	kfree(adapter->tx_ring.buffer_info);
 	adapter->tx_ring.buffer_info = NULL;
 
 	pci_free_consistent(pdev, adapter->tx_ring.size,
@@ -1279,7 +1280,7 @@ e1000_free_rx_resources(struct e1000_ada
 
 	e1000_clean_rx_ring(adapter);
 
-	vfree(rx_ring->buffer_info);
+	kfree(rx_ring->buffer_info);
 	rx_ring->buffer_info = NULL;
 
 	pci_free_consistent(pdev, rx_ring->size, rx_ring->desc, rx_ring->dma);
Index: linux-2.6.11/include/linux/netdevice.h
===================================================================
--- linux-2.6.11.orig/include/linux/netdevice.h	2005-05-17 16:44:20.000000000 -0700
+++ linux-2.6.11/include/linux/netdevice.h	2005-05-17 17:03:01.000000000 -0700
@@ -279,6 +279,7 @@ struct net_device
 	unsigned long		mem_start;	/* shared mem start	*/
 	unsigned long		base_addr;	/* device I/O address	*/
 	unsigned int		irq;		/* device IRQ number	*/
+	unsigned int            node;           /* device node number   */
 
 	/*
 	 *	Some hardware also needs these fields, but they are not
