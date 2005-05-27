Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVE0VxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVE0VxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVE0VxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:53:24 -0400
Received: from graphe.net ([209.204.138.32]:17876 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262612AbVE0VxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:53:05 -0400
Date: Fri, 27 May 2005 14:52:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shai@scalex86.org
Subject: [PATCH] e1000: NUMA aware allocation of descriptors V2
In-Reply-To: <20050518134250.3ee2703f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505271450200.25909@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
 <20050517190343.2e57fdd7.akpm@osdl.org> <Pine.LNX.4.62.0505171941340.21153@graphe.net>
 <20050517.195703.104034854.davem@davemloft.net> <Pine.LNX.4.62.0505172125210.22920@graphe.net>
 <20050517215845.2f87be2f.akpm@osdl.org> <5fc59ff305051808558f1ce59@mail.gmail.com>
 <20050518134250.3ee2703f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA awareness for the e1000 driver. Allocate tx and rx descriptors
on the node of the device.

It is safe to replace vmalloc by kmalloc node since only the descriptors
are allocated in a NUMA aware way. These will not be so large that the
use of vmalloc becomes necesssary.

The patch includes a modification to slab.h to revert from inline functions
for kmalloc_node/kmem_cache_alloc_node to a macro so that an undefined variable
may be specified. Is that ok? If so then I probably need to spin a separate
patch just for slab.h.

V1-V2:
- Patch against 2.6.12-rc5-mm1
- Do not defined netdev->node for non NUMA case
- Change kmem_cache_alloc_node and kmalloc_node to fall back to macro
  definitions for the non numa case so that an undefined variable can be
  specified.

References to earlier discussions:
http://marc.theaimsgroup.com/?t=111638151000001&r=1&w=2

Note that i386 pci_alloc_coherent also needs to be made NUMA aware.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Justin M. Forbes <jmforbes@linuxtx.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.12-rc5/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.12-rc5.orig/drivers/net/e1000/e1000_main.c	2005-05-27 21:22:39.000000000 +0000
+++ linux-2.6.12-rc5/drivers/net/e1000/e1000_main.c	2005-05-27 21:25:28.000000000 +0000
@@ -567,7 +567,9 @@
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
-
+#ifdef CONFIG_NUMA
+	netdev->node = pcibus_to_node(pdev->bus);
+#endif
 	adapter->bd_number = cards_found;
 
 	/* setup the private structure */
@@ -971,7 +973,9 @@
 	int size;
 
 	size = sizeof(struct e1000_buffer) * txdr->count;
-	txdr->buffer_info = vmalloc(size);
+
+	txdr->buffer_info = kmalloc_node(size, GFP_KERNEL, adapter->netdev->node );
+
 	if(!txdr->buffer_info) {
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the transmit descriptor ring\n");
@@ -987,7 +991,7 @@
 	txdr->desc = pci_alloc_consistent(pdev, txdr->size, &txdr->dma);
 	if(!txdr->desc) {
 setup_tx_desc_die:
-		vfree(txdr->buffer_info);
+		kfree(txdr->buffer_info);
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the transmit descriptor ring\n");
 		return -ENOMEM;
@@ -1015,7 +1019,7 @@
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the transmit descriptor ring\n");
-			vfree(txdr->buffer_info);
+			kfree(txdr->buffer_info);
 			return -ENOMEM;
 		} else {
 			/* Free old allocation, new allocation was successful */
@@ -1123,7 +1127,8 @@
 	int size, desc_len;
 
 	size = sizeof(struct e1000_buffer) * rxdr->count;
-	rxdr->buffer_info = vmalloc(size);
+	rxdr->buffer_info = kmalloc_node(size, GFP_KERNEL, adapter->netdev->node);
+
 	if(!rxdr->buffer_info) {
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the receive descriptor ring\n");
@@ -1134,7 +1139,7 @@
 	size = sizeof(struct e1000_ps_page) * rxdr->count;
 	rxdr->ps_page = kmalloc(size, GFP_KERNEL);
 	if(!rxdr->ps_page) {
-		vfree(rxdr->buffer_info);
+		kfree(rxdr->buffer_info);
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the receive descriptor ring\n");
 		return -ENOMEM;
@@ -1144,7 +1149,7 @@
 	size = sizeof(struct e1000_ps_page_dma) * rxdr->count;
 	rxdr->ps_page_dma = kmalloc(size, GFP_KERNEL);
 	if(!rxdr->ps_page_dma) {
-		vfree(rxdr->buffer_info);
+		kfree(rxdr->buffer_info);
 		kfree(rxdr->ps_page);
 		DPRINTK(PROBE, ERR,
 		"Unable to allocate memory for the receive descriptor ring\n");
@@ -1166,7 +1171,7 @@
 
 	if(!rxdr->desc) {
 setup_rx_desc_die:
-		vfree(rxdr->buffer_info);
+		kfree(rxdr->buffer_info);
 		kfree(rxdr->ps_page);
 		kfree(rxdr->ps_page_dma);
 		DPRINTK(PROBE, ERR,
@@ -1196,7 +1201,7 @@
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the receive descriptor ring\n");
-			vfree(rxdr->buffer_info);
+			kfree(rxdr->buffer_info);
 			kfree(rxdr->ps_page);
 			kfree(rxdr->ps_page_dma);
 			return -ENOMEM;
@@ -1393,7 +1398,7 @@
 
 	e1000_clean_tx_ring(adapter);
 
-	vfree(adapter->tx_ring.buffer_info);
+	kfree(adapter->tx_ring.buffer_info);
 	adapter->tx_ring.buffer_info = NULL;
 
 	pci_free_consistent(pdev, adapter->tx_ring.size,
@@ -1473,7 +1478,7 @@
 
 	e1000_clean_rx_ring(adapter);
 
-	vfree(rx_ring->buffer_info);
+	kfree(rx_ring->buffer_info);
 	rx_ring->buffer_info = NULL;
 	kfree(rx_ring->ps_page);
 	rx_ring->ps_page = NULL;
Index: linux-2.6.12-rc5/include/linux/netdevice.h
===================================================================
--- linux-2.6.12-rc5.orig/include/linux/netdevice.h	2005-05-27 21:22:39.000000000 +0000
+++ linux-2.6.12-rc5/include/linux/netdevice.h	2005-05-27 21:22:43.000000000 +0000
@@ -279,7 +279,9 @@
 	unsigned long		mem_start;	/* shared mem start	*/
 	unsigned long		base_addr;	/* device I/O address	*/
 	unsigned int		irq;		/* device IRQ number	*/
-
+#ifdef CONFIG_NUMA
+	unsigned int            node;           /* device node number   */
+#endif
 	/*
 	 *	Some hardware also needs these fields, but they are not
 	 *	part of the usual set specified in Space.c.
Index: linux-2.6.12-rc5/include/linux/slab.h
===================================================================
--- linux-2.6.12-rc5.orig/include/linux/slab.h	2005-05-25 03:31:20.000000000 +0000
+++ linux-2.6.12-rc5/include/linux/slab.h	2005-05-27 21:30:42.000000000 +0000
@@ -106,14 +106,12 @@
 extern void *kmem_cache_alloc_node(kmem_cache_t *, int flags, int node);
 extern void *kmalloc_node(size_t size, int flags, int node);
 #else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int node)
-{
-	return kmem_cache_alloc(cachep, flags);
-}
-static inline void *kmalloc_node(size_t size, int flags, int node)
-{
-	return kmalloc(size, flags);
-}
+/*
+ * The definitions are macros here to allow the use of an undefined variable
+ * for the node. The variable may only be defined if CONFIG_NUMA is set.
+ */
+#define kmem_cache_alloc_node(__cachep, __flags, __node) kmem_cache_alloc(__cachep, __flags)
+#define kmalloc_node(__size, __flags, __node) kmalloc(__size, __flags)
 #endif
 
 extern int FASTCALL(kmem_cache_reap(int));
