Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVJZQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVJZQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVJZQr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:47:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:50869 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964815AbVJZQrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:47:11 -0400
Date: Wed, 26 Oct 2005 10:47:08 -0600
From: Santiago Leon <santil@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>
Message-Id: <20051026164555.21820.85804.sendpatchset@localhost.localdomain>
In-Reply-To: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
References: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/5] ibmveth fix buffer replenishing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the allocation of RX skb's  buffers from a workqueue
to be called directly at RX processing time.  This change was suggested
by Dave Miller when the driver was starving the RX buffers and
deadlocking under heavy traffic:


> Allocating RX SKBs via tasklet is, IMHO, the worst way to
> do it.  It is no surprise that there are starvation cases.
> 
> If tasklets or work queues get delayed in any way, you lose,
> and it's very easy for a card to catch up with the driver RX'ing
> packets very fast, no matter how aggressive you make the
> replenishing.  By the time you detect that you need to be
> "more aggressive" it is already too late.
> The only pseudo-reliable way is to allocate at RX processing time.
> 

Signed-off-by: Santiago Leon <santil@us.ibm.com>
---

 drivers/net/ibmveth.c |   48 ++++++++----------------------------------------
 drivers/net/ibmveth.h |    4 ----
 2 files changed, 8 insertions(+), 44 deletions(-)

--- a/drivers/net/ibmveth.c	2005-10-17 12:04:58.000000000 -0500
+++ b/drivers/net/ibmveth.c	2005-10-17 12:23:22.000000000 -0500
@@ -96,7 +96,6 @@
 static void ibmveth_proc_register_adapter(struct ibmveth_adapter *adapter);
 static void ibmveth_proc_unregister_adapter(struct ibmveth_adapter *adapter);
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
-static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter*);
 static inline void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter);
 
 #ifdef CONFIG_PROC_FS
@@ -257,29 +256,7 @@
 	atomic_add(buffers_added, &(pool->available));
 }
 
-/* check if replenishing is needed.  */
-static inline int ibmveth_is_replenishing_needed(struct ibmveth_adapter *adapter)
-{
-	int i;
-
-	for(i = 0; i < IbmVethNumBufferPools; i++)
-		if(adapter->rx_buff_pool[i].active &&
-		  (atomic_read(&adapter->rx_buff_pool[i].available) <
-		   adapter->rx_buff_pool[i].threshold))
-			return 1;
-	return 0;
-}
-
-/* kick the replenish tasklet if we need replenishing and it isn't already running */
-static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter *adapter)
-{
-	if(ibmveth_is_replenishing_needed(adapter) &&
-	   (atomic_dec_if_positive(&adapter->not_replenishing) == 0)) {
-		schedule_work(&adapter->replenish_task);
-	}
-}
-
-/* replenish tasklet routine */
+/* replenish routine */
 static void ibmveth_replenish_task(struct ibmveth_adapter *adapter) 
 {
 	int i;
@@ -292,10 +269,6 @@
 						     &adapter->rx_buff_pool[i]);
 
 	adapter->rx_no_buffer = *(u64*)(((char*)adapter->buffer_list_addr) + 4096 - 8);
-
-	atomic_inc(&adapter->not_replenishing);
-
-	ibmveth_schedule_replenishing(adapter);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -563,10 +536,10 @@
 		return rc;
 	}
 
-	netif_start_queue(netdev);
+	ibmveth_debug_printk("initial replenish cycle\n");
+	ibmveth_replenish_task(adapter);
 
-	ibmveth_debug_printk("scheduling initial replenish cycle\n");
-	ibmveth_schedule_replenishing(adapter);
+	netif_start_queue(netdev);
 
 	ibmveth_debug_printk("open complete\n");
 
@@ -584,9 +557,6 @@
 
 	free_irq(netdev->irq, netdev);
 
-	cancel_delayed_work(&adapter->replenish_task);
-	flush_scheduled_work();
-
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_isLongBusy(lpar_rc) || (lpar_rc == H_Busy));
@@ -795,7 +765,7 @@
 		}
 	} while(more_work && (frames_processed < max_frames_to_process));
 
-	ibmveth_schedule_replenishing(adapter);
+	ibmveth_replenish_task(adapter);
 
 	if(more_work) {
 		/* more work to do - return that we are not done yet */
@@ -931,8 +901,10 @@
 
 	}
 
+	/* kick the interrupt handler so that the new buffer pools get
+	   replenished or deallocated */
+	ibmveth_interrupt(dev->irq, dev, NULL);
 
-	ibmveth_schedule_replenishing(adapter);
 	dev->mtu = new_mtu;
 	return 0;	
 }
@@ -1017,14 +989,10 @@
 
 	ibmveth_debug_printk("adapter @ 0x%p\n", adapter);
 
-	INIT_WORK(&adapter->replenish_task, (void*)ibmveth_replenish_task, (void*)adapter);
-
 	adapter->buffer_list_dma = DMA_ERROR_CODE;
 	adapter->filter_list_dma = DMA_ERROR_CODE;
 	adapter->rx_queue.queue_dma = DMA_ERROR_CODE;
 
-	atomic_set(&adapter->not_replenishing, 1);
-
 	ibmveth_debug_printk("registering netdev...\n");
 
 	rc = register_netdev(netdev);
diff -urN a/drivers/net/ibmveth.h b/drivers/net/ibmveth.h
--- a/drivers/net/ibmveth.h	2005-10-17 12:04:58.000000000 -0500
+++ b/drivers/net/ibmveth.h	2005-10-17 12:23:22.000000000 -0500
@@ -118,10 +118,6 @@
     dma_addr_t filter_list_dma;
     struct ibmveth_buff_pool rx_buff_pool[IbmVethNumBufferPools];
     struct ibmveth_rx_q rx_queue;
-    atomic_t not_replenishing;
-
-    /* helper tasks */
-    struct work_struct replenish_task;
 
     /* adapter specific stats */
     u64 replenish_task_cycles;
