Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267193AbUHMTRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267193AbUHMTRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHMTPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:15:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267264AbUHMTLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:11:40 -0400
Message-ID: <411D126B.6090303@redhat.com>
Date: Fri, 13 Aug 2004 15:11:39 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pete Zaitcev <zaitcev@redhat.com>, mike_phillips@urscorp.com
Subject: [Patch} to fix oops in olympic token ring driver on media disconnect
Content-Type: multipart/mixed;
 boundary="------------000308000505000302000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000308000505000302000004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey all-
     I've put this patch together to fix up an oops in the olympic token 
ring driver.  The problem was orgionally reported as an oops which 
occurs on media disconnect.  The problem was that free_irq was being 
called from several places in the olympic interrupt handler, which 
triggered the subsequent oops.  This patch corrects that by removing the 
free_irq call from all the interrupt handler code paths, instead 
allowing the olympic_close to handle the free_irq on an interface down 
event.  The patch also cleans up some double free conditions on the 
receive ring buffer that arose due to this change.  Lastly the patch 
corrects a situation in which calling ifdown on an interface owned by 
the driver would hang the process in cases where the adaper needed to be 
reset to complete any operations, but never woke the wait queue which 
the olympic_close routine was waiting on.  This patch cleans that up.

Tested by me, on 2.4 and 2.6 with good, working results, and no more oopses.

Thanks!
Neil
-- 
-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/

--------------000308000505000302000004
Content-Type: text/plain;
 name="linux-2.6.7-olympic-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-olympic-oops.patch"

--- linux-2.6.6-1.435.2.3/drivers/net/tokenring/olympic.c	2004-07-01 08:24:45.000000000 -0400
+++ linux-2.6.6-1.435.2.3-olympic/drivers/net/tokenring/olympic.c	2004-08-13 13:14:44.000000000 -0400
@@ -220,8 +220,10 @@ static int __devinit olympic_probe(struc
 	}
 
 	olympic_priv = dev->priv ;
 	
+	spin_lock_init(&olympic_priv->olympic_lock) ; 
+
 	init_waitqueue_head(&olympic_priv->srb_wait);
 	init_waitqueue_head(&olympic_priv->trb_wait);
 #if OLYMPIC_DEBUG  
 	printk(KERN_INFO "pci_device: %p, dev:%p, dev->priv: %p\n", pdev, dev, dev->priv);
@@ -310,9 +312,8 @@ static int __devinit olympic_init(struct
 			return -ENODEV;
 		}
 	}
 
-	spin_lock_init(&olympic_priv->olympic_lock) ; 
 
 	/* Needed for cardbus */
 	if(!(readl(olympic_mmio+BCTL) & BCTL_MODE_INDICATOR)) {
 		writel(readl(olympic_priv->olympic_mmio+FERMASK)|FERMASK_INT_BIT, olympic_mmio+FERMASK);
@@ -441,8 +442,10 @@ static int olympic_open(struct net_devic
 	int i, open_finished = 1 ;
 
 	DECLARE_WAITQUEUE(wait,current) ; 
 
+	olympic_init(dev);
+
 	if(request_irq(dev->irq, &olympic_interrupt, SA_SHIRQ , "olympic", dev)) {
 		return -EAGAIN;
 	}
 
@@ -897,9 +900,12 @@ static void olympic_freemem(struct net_d
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
 	int i;
 			
 	for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
-		dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+		if (olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received] != NULL) {
+			dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+			olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received] = NULL;
+		}
 		if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
 			pci_unmap_single(olympic_priv->pdev, 
 			le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
 			olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
@@ -943,11 +949,8 @@ static irqreturn_t olympic_interrupt(int
 
 	/* Hotswap gives us this on removal */
 	if (sisr == 0xffffffff) { 
 		printk(KERN_WARNING "%s: Hotswap adapter removal.\n",dev->name) ; 
-		olympic_freemem(dev) ; 
-		free_irq(dev->irq, dev) ;
-		dev->stop = NULL ;  
 		spin_unlock(&olympic_priv->olympic_lock) ; 
 		return IRQ_NONE;
 	} 
 		
@@ -960,11 +963,9 @@ static irqreturn_t olympic_interrupt(int
 			printk(KERN_ERR "Olympic: EISR Error, EISR=%08x\n",readl(olympic_mmio+EISR)) ; 
 			printk(KERN_ERR "The adapter must be reset to clear this condition.\n") ; 
 			printk(KERN_ERR "Please report this error to the driver maintainer and/\n") ; 
 			printk(KERN_ERR "or the linux-tr mailing list.\n") ; 
-			olympic_freemem(dev) ; 
-			free_irq(dev->irq, dev) ;
-			dev->stop = NULL ;  
+			wake_up_interruptible(&olympic_priv->srb_wait);
 			spin_unlock(&olympic_priv->olympic_lock) ; 
 			return IRQ_HANDLED;
 		} /* SISR_ERR */
 
@@ -1005,11 +1006,8 @@ static irqreturn_t olympic_interrupt(int
 			printk(KERN_WARNING "%s: Adapter Check Interrupt Raised, 8 bytes of information follow:\n", dev->name);
 			writel(readl(olympic_mmio+LAPWWC),olympic_mmio+LAPA);
 			adapter_check_area = olympic_priv->olympic_lap + ((readl(olympic_mmio+LAPWWC)) & (~0xf800)) ;
 			printk(KERN_WARNING "%s: Bytes %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, readb(adapter_check_area+0), readb(adapter_check_area+1), readb(adapter_check_area+2), readb(adapter_check_area+3), readb(adapter_check_area+4), readb(adapter_check_area+5), readb(adapter_check_area+6), readb(adapter_check_area+7)) ; 
-			olympic_freemem(dev) ;
-			free_irq(dev->irq, dev) ;
-			dev->stop = NULL ;  
 			spin_unlock(&olympic_priv->olympic_lock) ; 
 			return IRQ_HANDLED; 
 		} /* SISR_ADAPTER_CHECK */
 	
@@ -1093,36 +1091,34 @@ static int olympic_close(struct net_devi
     	writeb(SRB_CLOSE_ADAPTER,srb+0);
 	writeb(0,srb+1);
 	writeb(OLYMPIC_CLEAR_RET_CODE,srb+2);
 
+	add_wait_queue(&olympic_priv->srb_wait,&wait) ;
+	set_current_state(TASK_INTERRUPTIBLE) ; 
+
 	spin_lock_irqsave(&olympic_priv->olympic_lock,flags);
 	olympic_priv->srb_queued=1;
 
 	writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
 	spin_unlock_irqrestore(&olympic_priv->olympic_lock,flags);
-	
-	t = jiffies ; 
-
-	add_wait_queue(&olympic_priv->srb_wait,&wait) ;
-	set_current_state(TASK_INTERRUPTIBLE) ; 
 
 	while(olympic_priv->srb_queued) {
-		schedule() ; 
+
+		t = schedule_timeout(60*HZ); 
+
         	if(signal_pending(current))	{            
 			printk(KERN_WARNING "%s: SRB timed out.\n",dev->name);
             		printk(KERN_WARNING "SISR=%x MISR=%x\n",readl(olympic_mmio+SISR),readl(olympic_mmio+LISR));
             		olympic_priv->srb_queued=0;
             		break;
         	}
-		if ((jiffies-t) > 60*HZ) { 
+
+		if (t == 0) { 
 			printk(KERN_WARNING "%s: SRB timed out. May not be fatal. \n",dev->name) ; 
-			olympic_priv->srb_queued=0;
-			break ; 
 		} 
-		set_current_state(TASK_INTERRUPTIBLE) ; 
+		olympic_priv->srb_queued=0;
     	}
 	remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
-	set_current_state(TASK_RUNNING) ; 
 
 	olympic_priv->rx_status_last_received++;
 	olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
 
@@ -1512,31 +1508,8 @@ drop_frame:
 			udelay(1);
 			writel(readl(olympic_mmio+BCTL)&~(3<<13),olympic_mmio+BCTL);
 			netif_stop_queue(dev);
 			olympic_priv->srb = readw(olympic_priv->olympic_lap + LAPWWO) ; 
-			for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
-				dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
-				if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
-					pci_unmap_single(olympic_priv->pdev, 
-						le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
-						olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
-				}
-				olympic_priv->rx_status_last_received++;
-				olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
-			}
-			/* unmap rings */
-			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
-				sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
-			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
-				sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
-
-			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
-				sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
-			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
-				sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
-
-			free_irq(dev->irq,dev);
-			dev->stop=NULL;
 			printk(KERN_WARNING "%s: Adapter has been closed \n", dev->name) ; 
 		} /* If serious error */
 		
 		if (olympic_priv->olympic_message_level) { 

--------------000308000505000302000004--
