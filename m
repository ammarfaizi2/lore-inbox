Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290303AbSBKTvk>; Mon, 11 Feb 2002 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBKTvX>; Mon, 11 Feb 2002 14:51:23 -0500
Received: from pak218.pakuni.net ([207.91.34.218]:5637 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S290303AbSBKTvH>;
	Mon, 11 Feb 2002 14:51:07 -0500
Date: Mon, 11 Feb 2002 14:33:33 -0600 (CST)
From: Mike Phillips <mikep@linuxtr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] Olympic - Janitor: replace sleep_on
Message-ID: <Pine.LNX.4.10.10202111430330.959-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Attached is a patch to the olympic driver to replace with sleep_in
functions. Also included are a couple of minor error reporting updates
and the proper detection for cardbus removal.

Patch is against 2.4.17

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

diff -urN -X /home/phillim/dontdiff -x ibmtr.c linux-2.4.17-vanilla/drivers/net/tokenring/olympic.c linux-2.4.17-production/drivers/net/tokenring/olympic.c
--- linux-2.4.17-vanilla/drivers/net/tokenring/olympic.c	Fri Dec 21 12:41:54 2001
+++ linux-2.4.17-production/drivers/net/tokenring/olympic.c	Sat Feb  9 11:37:01 2002
@@ -50,10 +50,16 @@
  *	      adapter when live does not take the system down with it.
  * 
  * 06/02/01 - Clean up, copy skb for small packets
+ * 
+ * 06/22/01 - Add EISR error handling routines 
+ *
+ * 07/19/01 - Improve bad LAA reporting, strip out freemem
+ *	      into a separate function, its called from 3 
+ *	      different places now. 
+ * 02/09/01 - Replaced sleep_on. 
  *
  *  To Do:
  *
- *	     Complete full Cardbus / hot-swap support.
  *	     Wake on lan	
  * 
  *  If Problems do Occur
@@ -105,7 +111,7 @@
  */
 
 static char version[] __devinitdata = 
-"Olympic.c v0.9.7 6/02/01 - Peter De Schrijver & Mike Phillips" ; 
+"Olympic.c v1.0.0 2/9/02  - Peter De Schrijver & Mike Phillips" ; 
 
 static char *open_maj_error[]  = {"No error", "Lobe Media Test", "Physical Insertion",
 				   "Address Verification", "Neighbor Notification (Ring Poll)",
@@ -172,6 +178,7 @@
 static int olympic_xmit(struct sk_buff *skb, struct net_device *dev);
 static int olympic_close(struct net_device *dev);
 static void olympic_set_rx_mode(struct net_device *dev);
+static void olympic_freemem(struct net_device *dev) ;  
 static void olympic_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static struct net_device_stats * olympic_get_stats(struct net_device *dev);
 static int olympic_set_mac_address(struct net_device *dev, void *addr) ; 
@@ -396,6 +403,8 @@
 	char open_error[255] ; 
 	int i, open_finished = 1 ;
 
+	DECLARE_WAITQUEUE(wait,current) ; 
+
 	if(request_irq(dev->irq, &olympic_interrupt, SA_SHIRQ , "olympic", dev)) {
 		return -EAGAIN;
 	}
@@ -441,8 +450,12 @@
 			writew(swab16(OPEN_ADAPTER_ENABLE_FDX | OPEN_ADAPTER_PASS_ADC_MAC | OPEN_ADAPTER_PASS_ATT_MAC | OPEN_ADAPTER_PASS_BEACON), init_srb+8);
 		else
 			writew(swab16(OPEN_ADAPTER_ENABLE_FDX), init_srb+8);
+	
+		/* Test OR of first 3 bytes as its totally possible for 
+		 * someone to set the first 2 bytes to be zero, although this 
+		 * is an error, the first byte must have bit 6 set to 1  */
 
-		if (olympic_priv->olympic_laa[0]) {
+		if (olympic_priv->olympic_laa[0] | olympic_priv->olympic_laa[1] | olympic_priv->olympic_laa[2]) {
 			writeb(olympic_priv->olympic_laa[0],init_srb+12);
 			writeb(olympic_priv->olympic_laa[1],init_srb+13);
 			writeb(olympic_priv->olympic_laa[2],init_srb+14);
@@ -458,8 +471,12 @@
 		writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
 
 		t = jiffies ; 
+	
+		add_wait_queue(&olympic_priv->srb_wait,&wait) ;
+		set_current_state(TASK_INTERRUPTIBLE) ; 
+ 
  		while(olympic_priv->srb_queued) {        
-        		interruptible_sleep_on_timeout(&olympic_priv->srb_wait, 60*HZ);
+			schedule() ; 
         		if(signal_pending(current))	{            
 				printk(KERN_WARNING "%s: Signal received in open.\n",
                 			dev->name);
@@ -474,7 +491,11 @@
 				olympic_priv->srb_queued=0;
 				break ; 
 			} 
+			set_current_state(TASK_INTERRUPTIBLE) ; 
     		}
+		remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
+		set_current_state(TASK_RUNNING) ; 
+
 		restore_flags(flags);
 #if OLYMPIC_DEBUG
 		printk("init_srb(%p): ",init_srb);
@@ -515,6 +536,17 @@
 					return -EIO ; 
  
 				}	/* if autosense && open_finished */
+			} else if (init_srb[2] == 0x32) {
+				printk(KERN_WARNING "%s: Invalid LAA: %02x:%02x:%02x:%02x:%02x:%02x\n",
+					dev->name, 
+					olympic_priv->olympic_laa[0],
+					olympic_priv->olympic_laa[1],
+					olympic_priv->olympic_laa[2],
+					olympic_priv->olympic_laa[3],
+					olympic_priv->olympic_laa[4],
+					olympic_priv->olympic_laa[5]) ; 
+				free_irq(dev->irq,dev) ; 
+				return -EIO ; 
 			} else {  
 				printk(KERN_WARNING "%s: Bad OPEN response: %x\n", dev->name,init_srb[2]);
 				free_irq(dev->irq, dev);
@@ -634,7 +666,10 @@
 	olympic_priv->tx_ring_free=0; /* next entry in tx ring to use */
 	olympic_priv->tx_ring_last_status=OLYMPIC_TX_RING_SIZE-1; /* last processed tx status */
 
-	writel(SISR_TX1_EOF | SISR_ADAPTER_CHECK | SISR_ARB_CMD | SISR_TRB_REPLY | SISR_ASB_FREE,olympic_mmio+SISR_MASK_SUM);
+	writel(0xffffffff, olympic_mmio+EISR_RWM) ; /* clean the eisr */
+	writel(0,olympic_mmio+EISR) ; 
+	writel(EISR_MASK_OPTIONS,olympic_mmio+EISR_MASK) ; /* enables most of the TX error interrupts */
+	writel(SISR_TX1_EOF | SISR_ADAPTER_CHECK | SISR_ARB_CMD | SISR_TRB_REPLY | SISR_ASB_FREE | SISR_ERR,olympic_mmio+SISR_MASK_SUM);
 
 #if OLYMPIC_DEBUG 
 	printk("BMCTL: %x\n",readl(olympic_mmio+BMCTL_SUM));
@@ -822,6 +857,35 @@
 
 }
 
+static void olympic_freemem(struct net_device *dev) 
+{ 
+	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
+	int i;
+			
+	for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
+		dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+		if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
+			pci_unmap_single(olympic_priv->pdev, 
+			le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
+			olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
+		}
+		olympic_priv->rx_status_last_received++;
+		olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
+	}
+	/* unmap rings */
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
+		sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
+		sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
+
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
+		sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
+		sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
+
+	return ; 
+}
+ 
 static void olympic_interrupt(int irq, void *dev_id, struct pt_regs *regs) 
 {
 	struct net_device *dev= (struct net_device *)dev_id;
@@ -842,9 +906,33 @@
 
 	spin_lock(&olympic_priv->olympic_lock);
 
+	/* Hotswap gives us this on removal */
+	if (sisr == 0xffffffff) { 
+		printk(KERN_WARNING "%s: Hotswap adapter removal.\n",dev->name) ; 
+		olympic_freemem(dev) ; 
+		free_irq(dev->irq, dev) ;
+		dev->stop = NULL ;  
+		spin_unlock(&olympic_priv->olympic_lock) ; 
+		return ;
+	} 
+		
 	if (sisr & (SISR_SRB_REPLY | SISR_TX1_EOF | SISR_RX_STATUS | SISR_ADAPTER_CHECK |  
-			SISR_ASB_FREE | SISR_ARB_CMD | SISR_TRB_REPLY | SISR_RX_NOBUF)) {  
+			SISR_ASB_FREE | SISR_ARB_CMD | SISR_TRB_REPLY | SISR_RX_NOBUF | SISR_ERR)) {  
 	
+		/* If we ever get this the adapter is seriously dead. Only a reset is going to 
+		 * bring it back to life. We're talking pci bus errors and such like :( */ 
+		if((sisr & SISR_ERR) && (readl(olympic_mmio+EISR) & EISR_MASK_OPTIONS)) {
+			printk(KERN_ERR "Olympic: EISR Error, EISR=%08x\n",readl(olympic_mmio+EISR)) ; 
+			printk(KERN_ERR "The adapter must be reset to clear this condition.\n") ; 
+			printk(KERN_ERR "Please report this error to the driver maintainer and/\n") ; 
+			printk(KERN_ERR "or the linux-tr mailing list.\n") ; 
+			olympic_freemem(dev) ; 
+			free_irq(dev->irq, dev) ;
+			dev->stop = NULL ;  
+			spin_unlock(&olympic_priv->olympic_lock) ; 
+			return ;
+		} /* SISR_ERR */
+
 		if(sisr & SISR_SRB_REPLY) {
 			if(olympic_priv->srb_queued==1) {
 				wake_up_interruptible(&olympic_priv->srb_wait);
@@ -878,34 +966,12 @@
 		} /* SISR_RX_STATUS */
 	
 		if (sisr & SISR_ADAPTER_CHECK) {
-			int i ; 
 			netif_stop_queue(dev);
 			printk(KERN_WARNING "%s: Adapter Check Interrupt Raised, 8 bytes of information follow:\n", dev->name);
-			writel(readl(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
-			adapter_check_area = (u8 *)(olympic_mmio+LAPWWO) ; 
+			writel(readl(olympic_mmio+LAPWWC),olympic_mmio+LAPA);
+			adapter_check_area = olympic_priv->olympic_lap + ((readl(olympic_mmio+LAPWWC)) & (~0xf800)) ;
 			printk(KERN_WARNING "%s: Bytes %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, readb(adapter_check_area+0), readb(adapter_check_area+1), readb(adapter_check_area+2), readb(adapter_check_area+3), readb(adapter_check_area+4), readb(adapter_check_area+5), readb(adapter_check_area+6), readb(adapter_check_area+7)) ; 
-			/* The adapter is effectively dead, clean up and exit */
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
+			olympic_freemem(dev) ;
 			free_irq(dev->irq, dev) ;
 			dev->stop = NULL ;  
 			spin_unlock(&olympic_priv->olympic_lock) ; 
@@ -980,7 +1046,8 @@
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
     	u8 *olympic_mmio=olympic_priv->olympic_mmio,*srb;
 	unsigned long t,flags;
-	int i;
+
+	DECLARE_WAITQUEUE(wait,current) ; 
 
 	netif_stop_queue(dev);
 	
@@ -999,8 +1066,12 @@
 	writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
 	
 	t = jiffies ; 
+
+	add_wait_queue(&olympic_priv->srb_wait,&wait) ;
+	set_current_state(TASK_INTERRUPTIBLE) ; 
+
 	while(olympic_priv->srb_queued) {
-	        interruptible_sleep_on_timeout(&olympic_priv->srb_wait, jiffies+60*HZ);
+		schedule() ; 
         	if(signal_pending(current))	{            
 			printk(KERN_WARNING "%s: SRB timed out.\n",dev->name);
             		printk(KERN_WARNING "SISR=%x MISR=%x\n",readl(olympic_mmio+SISR),readl(olympic_mmio+LISR));
@@ -1012,32 +1083,16 @@
 			olympic_priv->srb_queued=0;
 			break ; 
 		} 
+		set_current_state(TASK_INTERRUPTIBLE) ; 
     	}
+	remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
+	set_current_state(TASK_RUNNING) ; 
 
 	restore_flags(flags) ; 
 	olympic_priv->rx_status_last_received++;
 	olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
-	
-	for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
-		dev_kfree_skb(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
-		if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
-			pci_unmap_single(olympic_priv->pdev, 
-				le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
-				olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
-		}
-		olympic_priv->rx_status_last_received++;
-		olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
-	}
-	/* unmap rings */
-	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
-		sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
-	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
-		sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
 
-	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
-		sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
-	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
-		sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
+	olympic_freemem(dev) ; 	
 
 	/* reset tx/rx fifo's and busmaster logic */
 
diff -urN -X /home/phillim/dontdiff -x ibmtr.c linux-2.4.17-vanilla/drivers/net/tokenring/olympic.h linux-2.4.17-production/drivers/net/tokenring/olympic.h
--- linux-2.4.17-vanilla/drivers/net/tokenring/olympic.h	Wed Jun 20 14:13:18 2001
+++ linux-2.4.17-production/drivers/net/tokenring/olympic.h	Sat Feb  9 11:14:47 2002
@@ -79,6 +79,7 @@
 #define EISR 0x34
 #define EISR_RWM 0x38
 #define EISR_MASK 0x3c
+#define EISR_MASK_OPTIONS 0x001FFF7F
 
 #define LAPA 0x60
 #define LAPWWO 0x64

