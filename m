Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbRFBXYl>; Sat, 2 Jun 2001 19:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbRFBXYc>; Sat, 2 Jun 2001 19:24:32 -0400
Received: from pak218.pakuni.net ([207.91.34.218]:15366 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S262215AbRFBXYQ>;
	Sat, 2 Jun 2001 19:24:16 -0400
Date: Sat, 2 Jun 2001 18:58:43 -0500 (CDT)
From: Mike Phillips <mikep@linuxtr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Olympic Update
Message-ID: <Pine.LNX.4.10.10106021854380.2706-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts in place some of Jeff's comments on the previous update
and adds the buffer copy if skb->len <= 1500 as discussed on the list
recently. (And gets NFS over olympic working again in less than epoc time
:)

Thanks
Mike Phillips
http://www.linuxtr.net

diff -urN --exclude-from=dontdiff linux-2.4.5-ac6.clean/drivers/net/tokenring/olympic.c linux-2.4.5-ac6/drivers/net/tokenring/olympic.c
--- linux-2.4.5-ac6.clean/drivers/net/tokenring/olympic.c	Sun May 20 14:11:38 2001
+++ linux-2.4.5-ac6/drivers/net/tokenring/olympic.c	Sat Jun  2 16:09:55 2001
@@ -49,6 +49,8 @@
  * 04/09/01 - Couple of bug fixes to the dma unmaps and ejecting the
  *	      adapter when live does not take the system down with it.
  * 
+ * 06/02/01 - Clean up, copy skb for small packets
+ *
  *  To Do:
  *
  *	     Complete full Cardbus / hot-swap support.
@@ -64,7 +66,10 @@
 
 #define OLYMPIC_DEBUG 0
 
+
+#include <linux/config.h>
 #include <linux/module.h>
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
@@ -99,8 +104,8 @@
  * Official releases will only have an a.b.c version number format. 
  */
 
-static char *version = 
-"Olympic.c v0.9.C 4/18/01 - Peter De Schrijver & Mike Phillips" ; 
+static char version[] __devinitdata = 
+"Olympic.c v0.9.7 6/02/01 - Peter De Schrijver & Mike Phillips" ; 
 
 static char *open_maj_error[]  = {"No error", "Lobe Media Test", "Physical Insertion",
 				   "Address Verification", "Neighbor Notification (Ring Poll)",
@@ -116,6 +121,9 @@
 
 /* Module paramters */
 
+MODULE_AUTHOR("Mike Phillips <mikep@linuxtr.net>") ; 
+MODULE_DESCRIPTION("Olympic PCI/Cardbus Chipset Driver \n") ; 
+
 /* Ring Speed 0,4,16,100 
  * 0 = Autosense         
  * 4,16 = Selected speed only, no autosense
@@ -157,7 +165,8 @@
 };
 MODULE_DEVICE_TABLE(pci,olympic_pci_tbl) ; 
 
-static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent); 
+
+static int olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent); 
 static int olympic_init(struct net_device *dev);
 static int olympic_open(struct net_device *dev);
 static int olympic_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -172,7 +181,7 @@
 static void olympic_asb_bh(struct net_device *dev) ; 
 static int olympic_proc_info(char *buffer, char **start, off_t offset, int length, int *eof, void *data) ; 
 
-static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *dev ; 
 	struct olympic_private *olympic_priv;
@@ -239,6 +248,7 @@
 	dev->set_multicast_list=&olympic_set_rx_mode;
 	dev->get_stats=&olympic_get_stats ;
 	dev->set_mac_address=&olympic_set_mac_address ;  
+	SET_MODULE_OWNER(dev) ; 
 
 	pci_set_drvdata(pdev,dev) ; 
 	register_netdev(dev) ; 
@@ -253,10 +263,10 @@
 	return  0 ;
 }
 
-static int __init olympic_init(struct net_device *dev)
+static int __devinit olympic_init(struct net_device *dev)
 {
     	struct olympic_private *olympic_priv;
-	__u8 *olympic_mmio, *init_srb,*adapter_addr;
+	u8 *olympic_mmio, *init_srb,*adapter_addr;
 	unsigned long t; 
 	unsigned int uaa_addr;
 
@@ -268,7 +278,7 @@
 
 	writel(readl(olympic_mmio+BCTL) | BCTL_SOFTRESET,olympic_mmio+BCTL);
 	t=jiffies;
-	while((readl(olympic_priv->olympic_mmio+BCTL)) & BCTL_SOFTRESET) {
+	while((readl(olympic_mmio+BCTL)) & BCTL_SOFTRESET) {
 		schedule();		
 		if(jiffies-t > 40*HZ) {
 			printk(KERN_ERR "IBM PCI tokenring card not responding.\n");
@@ -381,7 +391,7 @@
 static int olympic_open(struct net_device *dev) 
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *olympic_mmio=olympic_priv->olympic_mmio,*init_srb;
+	u8 *olympic_mmio=olympic_priv->olympic_mmio,*init_srb;
 	unsigned long flags, t;
 	char open_error[255] ; 
 	int i, open_finished = 1 ;
@@ -632,10 +642,10 @@
 #endif
 
 	if (olympic_priv->olympic_network_monitor) { 
-		__u8 *oat ; 
-		__u8 *opt ; 
-		oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
-		opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
+		u8 *oat ; 
+		u8 *opt ; 
+		oat = (u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
+		opt = (u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
 
 		printk("%s: Node Address: %02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, 
 			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)), 
@@ -659,7 +669,6 @@
 	}
 	
 	netif_start_queue(dev);
-	MOD_INC_USE_COUNT ;
 	return 0;
 	
 }	
@@ -673,12 +682,16 @@
  *	This means that we may process the frame before we receive the end
  *	of frame interrupt. This is why we always test the status instead
  *	of blindly processing the next frame.
+ *
+ *	We also remove the last 4 bytes from the packet as well, these are
+ *	just token ring trailer info and upset protocols that don't check 
+ *	their own length, i.e. SNA. 
  *	
  */
 static void olympic_rx(struct net_device *dev)
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *olympic_mmio=olympic_priv->olympic_mmio;
+	u8 *olympic_mmio=olympic_priv->olympic_mmio;
 	struct olympic_rx_status *rx_status;
 	struct olympic_rx_desc *rx_desc ; 
 	int rx_ring_last_received,length, buffer_cnt, cpy_length, frag_len;
@@ -688,7 +701,7 @@
 	rx_status=&(olympic_priv->olympic_rx_status_ring[(olympic_priv->rx_status_last_received + 1) & (OLYMPIC_RX_RING_SIZE - 1)]) ; 
  
 	while (rx_status->status_buffercnt) { 
-                __u32 l_status_buffercnt;
+                u32 l_status_buffercnt;
 
 		olympic_priv->rx_status_last_received++ ;
 		olympic_priv->rx_status_last_received &= (OLYMPIC_RX_RING_SIZE -1);
@@ -742,36 +755,50 @@
 			   	   	   If only one buffer is used we can simply swap the buffers around.
 			   	   	   If more than one then we must use the new buffer and copy the information
 			   	   	   first. Ideally all frames would be in a single buffer, this can be tuned by
-                               	   	   altering the buffer size. */
+                               	   	   altering the buffer size. If the length of the packet is less than
+					   1500 bytes we're going to copy it over anyway to stop packets getting
+					   dropped from sockets with buffers small than our pkt_buf_sz. */
 				
  					if (buffer_cnt==1) {
 						olympic_priv->rx_ring_last_received++ ; 
 						olympic_priv->rx_ring_last_received &= (OLYMPIC_RX_RING_SIZE -1);
 						rx_ring_last_received = olympic_priv->rx_ring_last_received ;
-						skb2=olympic_priv->rx_ring_skb[rx_ring_last_received] ; 
-						/* unmap buffer */
-						pci_unmap_single(olympic_priv->pdev,
-							le32_to_cpu(olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer), 
-							olympic_priv->pkt_buf_sz,PCI_DMA_FROMDEVICE) ; 
-						skb_put(skb2,length);
-						skb2->protocol = tr_type_trans(skb2,dev);
-						olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer = 
-							cpu_to_le32(pci_map_single(olympic_priv->pdev, skb->data, 
-							olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE));
-						olympic_priv->olympic_rx_ring[rx_ring_last_received].res_length = 
-							cpu_to_le32(olympic_priv->pkt_buf_sz); 
-						olympic_priv->rx_ring_skb[rx_ring_last_received] = skb ; 
-						netif_rx(skb2) ; 
+						if (length > 1500) { 
+							skb2=olympic_priv->rx_ring_skb[rx_ring_last_received] ; 
+							/* unmap buffer */
+							pci_unmap_single(olympic_priv->pdev,
+								le32_to_cpu(olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer), 
+								olympic_priv->pkt_buf_sz,PCI_DMA_FROMDEVICE) ; 
+							skb_put(skb2,length-4);
+							skb2->protocol = tr_type_trans(skb2,dev);
+							olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer = 
+								cpu_to_le32(pci_map_single(olympic_priv->pdev, skb->data, 
+								olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE));
+							olympic_priv->olympic_rx_ring[rx_ring_last_received].res_length = 
+								cpu_to_le32(olympic_priv->pkt_buf_sz); 
+							olympic_priv->rx_ring_skb[rx_ring_last_received] = skb ; 
+							netif_rx(skb2) ; 
+						} else { 
+							pci_dma_sync_single(olympic_priv->pdev,
+								le32_to_cpu(olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer),
+								olympic_priv->pkt_buf_sz,PCI_DMA_FROMDEVICE) ; 
+							memcpy(skb_put(skb,length-4),olympic_priv->rx_ring_skb[rx_ring_last_received]->data,length-4) ; 
+							skb->protocol = tr_type_trans(skb,dev) ; 
+							netif_rx(skb) ; 
+						} 
 					} else {
 						do { /* Walk the buffers */ 
 							olympic_priv->rx_ring_last_received++ ; 
 							olympic_priv->rx_ring_last_received &= (OLYMPIC_RX_RING_SIZE -1);
 							rx_ring_last_received = olympic_priv->rx_ring_last_received ; 
+							pci_dma_sync_single(olympic_priv->pdev,
+								le32_to_cpu(olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer),
+								olympic_priv->pkt_buf_sz,PCI_DMA_FROMDEVICE) ; 
 							rx_desc = &(olympic_priv->olympic_rx_ring[rx_ring_last_received]);
 							cpy_length = (i == 1 ? frag_len : le32_to_cpu(rx_desc->res_length)); 
 							memcpy(skb_put(skb, cpy_length), olympic_priv->rx_ring_skb[rx_ring_last_received]->data, cpy_length) ;
 						} while (--i) ; 
-		
+						skb_trim(skb,skb->len-4) ; 
 						skb->protocol = tr_type_trans(skb,dev);
 						netif_rx(skb) ; 
 					} 
@@ -799,9 +826,9 @@
 {
 	struct net_device *dev= (struct net_device *)dev_id;
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *olympic_mmio=olympic_priv->olympic_mmio;
-	__u32 sisr;
-	__u8 *adapter_check_area ; 
+	u8 *olympic_mmio=olympic_priv->olympic_mmio;
+	u32 sisr;
+	u8 *adapter_check_area ; 
 	
 	/* 
 	 *  Read sisr but don't reset it yet. 
@@ -855,7 +882,7 @@
 			netif_stop_queue(dev);
 			printk(KERN_WARNING "%s: Adapter Check Interrupt Raised, 8 bytes of information follow:\n", dev->name);
 			writel(readl(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
-			adapter_check_area = (__u8 *)(olympic_mmio+LAPWWO) ; 
+			adapter_check_area = (u8 *)(olympic_mmio+LAPWWO) ; 
 			printk(KERN_WARNING "%s: Bytes %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, readb(adapter_check_area+0), readb(adapter_check_area+1), readb(adapter_check_area+2), readb(adapter_check_area+3), readb(adapter_check_area+4), readb(adapter_check_area+5), readb(adapter_check_area+6), readb(adapter_check_area+7)) ; 
 			/* The adapter is effectively dead, clean up and exit */
 			for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
@@ -880,7 +907,6 @@
 				sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
 
 			free_irq(dev->irq, dev) ;
-			MOD_DEC_USE_COUNT ;
 			dev->stop = NULL ;  
 			spin_unlock(&olympic_priv->olympic_lock) ; 
 			return ; 
@@ -921,7 +947,7 @@
 static int olympic_xmit(struct sk_buff *skb, struct net_device *dev) 
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *olympic_mmio=olympic_priv->olympic_mmio;
+	u8 *olympic_mmio=olympic_priv->olympic_mmio;
 	unsigned long flags ; 
 
 	spin_lock_irqsave(&olympic_priv->olympic_lock, flags);
@@ -952,7 +978,7 @@
 static int olympic_close(struct net_device *dev) 
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-    	__u8 *olympic_mmio=olympic_priv->olympic_mmio,*srb;
+    	u8 *olympic_mmio=olympic_priv->olympic_mmio,*srb;
 	unsigned long t,flags;
 	int i;
 
@@ -1027,7 +1053,6 @@
 #endif
 	free_irq(dev->irq,dev);
 
-	MOD_DEC_USE_COUNT ; 
 	return 0;
 	
 }
@@ -1035,9 +1060,9 @@
 static void olympic_set_rx_mode(struct net_device *dev) 
 {
 	struct olympic_private *olympic_priv = (struct olympic_private *) dev->priv ; 
-   	__u8 *olympic_mmio = olympic_priv->olympic_mmio ; 
-	__u8 options = 0; 
-	__u8 *srb;
+   	u8 *olympic_mmio = olympic_priv->olympic_mmio ; 
+	u8 options = 0; 
+	u8 *srb;
 	struct dev_mc_list *dmi ; 
 	unsigned char dev_mc_address[4] ; 
 	int i ; 
@@ -1103,8 +1128,8 @@
 static void olympic_srb_bh(struct net_device *dev) 
 { 
 	struct olympic_private *olympic_priv = (struct olympic_private *) dev->priv ; 
-   	__u8 *olympic_mmio = olympic_priv->olympic_mmio ; 
-	__u8 *srb;
+   	u8 *olympic_mmio = olympic_priv->olympic_mmio ; 
+	u8 *srb;
 
 	writel(olympic_priv->srb,olympic_mmio+LAPA);
 	srb=olympic_priv->olympic_lap + (olympic_priv->srb & (~0xf800));
@@ -1277,22 +1302,22 @@
 static void olympic_arb_cmd(struct net_device *dev)
 {
 	struct olympic_private *olympic_priv = (struct olympic_private *) dev->priv;
-    	__u8 *olympic_mmio=olympic_priv->olympic_mmio;
-	__u8 *arb_block, *asb_block, *srb  ; 
-	__u8 header_len ; 
-	__u16 frame_len, buffer_len ;
+    	u8 *olympic_mmio=olympic_priv->olympic_mmio;
+	u8 *arb_block, *asb_block, *srb  ; 
+	u8 header_len ; 
+	u16 frame_len, buffer_len ;
 	struct sk_buff *mac_frame ;  
-	__u8 *buf_ptr ;
-	__u8 *frame_data ;  
-	__u16 buff_off ; 
-	__u16 lan_status = 0, lan_status_diff  ; /* Initialize to stop compiler warning */
-	__u8 fdx_prot_error ; 
-	__u16 next_ptr;
+	u8 *buf_ptr ;
+	u8 *frame_data ;  
+	u16 buff_off ; 
+	u16 lan_status = 0, lan_status_diff  ; /* Initialize to stop compiler warning */
+	u8 fdx_prot_error ; 
+	u16 next_ptr;
 	int i ; 
 
-	arb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
-	asb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
-	srb = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->srb) ; 
+	arb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
+	asb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
+	srb = (u8 *)(olympic_priv->olympic_lap + olympic_priv->srb) ; 
 	writel(readl(olympic_mmio+LAPA),olympic_mmio+LAPWWO);
 
 	if (readb(arb_block+0) == ARB_RECEIVE_DATA) { /* Receive.data, MAC frames */
@@ -1421,7 +1446,6 @@
 			free_irq(dev->irq,dev);
 			dev->stop=NULL;
 			printk(KERN_WARNING "%s: Adapter has been closed \n", dev->name) ; 
-			MOD_DEC_USE_COUNT ; 
 		} /* If serious error */
 		
 		if (olympic_priv->olympic_message_level) { 
@@ -1489,10 +1513,10 @@
 static void olympic_asb_bh(struct net_device *dev) 
 {
 	struct olympic_private *olympic_priv = (struct olympic_private *) dev->priv ; 
-	__u8 *arb_block, *asb_block ; 
+	u8 *arb_block, *asb_block ; 
 
-	arb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
-	asb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
+	arb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
+	asb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
 
 	if (olympic_priv->asb_queued == 1) {   /* Dropped through the first time */
 
@@ -1529,7 +1553,7 @@
 static int olympic_change_mtu(struct net_device *dev, int mtu) 
 {
 	struct olympic_private *olympic_priv = (struct olympic_private *) dev->priv;
-	__u16 max_mtu ; 
+	u16 max_mtu ; 
 
 	if (olympic_priv->olympic_ring_speed == 4)
 		max_mtu = 4500 ; 
@@ -1551,8 +1575,8 @@
 {
 	struct net_device *dev = (struct net_device *)data ; 
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
-	__u8 *opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
+	u8 *oat = (u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
+	u8 *opt = (u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
 	int size = 0 ; 
 	int len=0;
 	off_t begin=0;
@@ -1672,7 +1696,8 @@
 	unregister_trdev(dev) ; 
 	iounmap(olympic_priv->olympic_mmio) ; 
 	iounmap(olympic_priv->olympic_lap) ; 
-	pci_release_regions(pdev) ; 	
+	pci_release_regions(pdev) ;
+	pci_set_drvdata(pdev,NULL) ;  	
 	kfree(dev) ; 
 }
 
diff -urN --exclude-from=dontdiff linux-2.4.5-ac6.clean/drivers/net/tokenring/olympic.h linux-2.4.5-ac6/drivers/net/tokenring/olympic.h
--- linux-2.4.5-ac6.clean/drivers/net/tokenring/olympic.h	Wed Apr 18 13:39:21 2001
+++ linux-2.4.5-ac6/drivers/net/tokenring/olympic.h	Sat Jun  2 16:09:55 2001
@@ -214,43 +214,43 @@
 /* xxxx These structures are all little endian in hardware. */
 
 struct olympic_tx_desc {
-	__u32 buffer;
-	__u32 status_length;
+	u32 buffer;
+	u32 status_length;
 };
 
 struct olympic_tx_status {
-	__u32 status;
+	u32 status;
 };
 
 struct olympic_rx_desc {
-	__u32 buffer;
-	__u32 res_length; 
+	u32 buffer;
+	u32 res_length; 
 };
 
 struct olympic_rx_status {
-	__u32 fragmentcnt_framelen;
-	__u32 status_buffercnt;
+	u32 fragmentcnt_framelen;
+	u32 status_buffercnt;
 };
 /* xxxx END These structures are all little endian in hardware. */
 /* xxxx There may be more, but I'm pretty sure about these */
 
 struct mac_receive_buffer {
-	__u16 next ; 
-	__u8 padding ; 
-	__u8 frame_status ;
-	__u16 buffer_length ; 
-	__u8 frame_data ; 
+	u16 next ; 
+	u8 padding ; 
+	u8 frame_status ;
+	u16 buffer_length ; 
+	u8 frame_data ; 
 };
 
 struct olympic_private {
 	
-	__u16 srb;      /* be16 */
-	__u16 trb;      /* be16 */
-	__u16 arb;      /* be16 */
-	__u16 asb;      /* be16 */
+	u16 srb;      /* be16 */
+	u16 trb;      /* be16 */
+	u16 arb;      /* be16 */
+	u16 asb;      /* be16 */
 
-	__u8 *olympic_mmio;
-	__u8 *olympic_lap;
+	u8 *olympic_mmio;
+	u8 *olympic_lap;
 	struct pci_dev *pdev ; 
 	char *olympic_card_name ; 
 
@@ -274,47 +274,47 @@
 	int tx_ring_free, tx_ring_last_status, rx_ring_last_received,rx_status_last_received, free_tx_ring_entries;
 
 	struct net_device_stats olympic_stats ;
-	__u16 olympic_lan_status ;
-	__u8 olympic_ring_speed ;
-	__u16 pkt_buf_sz ; 
-	__u8 olympic_receive_options, olympic_copy_all_options,olympic_message_level, olympic_network_monitor;  
-	__u16 olympic_addr_table_addr, olympic_parms_addr ; 
-	__u8 olympic_laa[6] ; 
-	__u32 rx_ring_dma_addr;
-	__u32 rx_status_ring_dma_addr;
-	__u32 tx_ring_dma_addr;
-	__u32 tx_status_ring_dma_addr;
+	u16 olympic_lan_status ;
+	u8 olympic_ring_speed ;
+	u16 pkt_buf_sz ; 
+	u8 olympic_receive_options, olympic_copy_all_options,olympic_message_level, olympic_network_monitor;  
+	u16 olympic_addr_table_addr, olympic_parms_addr ; 
+	u8 olympic_laa[6] ; 
+	u32 rx_ring_dma_addr;
+	u32 rx_status_ring_dma_addr;
+	u32 tx_ring_dma_addr;
+	u32 tx_status_ring_dma_addr;
 };
 
 struct olympic_adapter_addr_table {
 
-	__u8 node_addr[6] ; 
-	__u8 reserved[4] ; 
-	__u8 func_addr[4] ; 
+	u8 node_addr[6] ; 
+	u8 reserved[4] ; 
+	u8 func_addr[4] ; 
 } ; 
 
 struct olympic_parameters_table { 
 	
-	__u8  phys_addr[4] ; 
-	__u8  up_node_addr[6] ; 
-	__u8  up_phys_addr[4] ; 
-	__u8  poll_addr[6] ; 
-	__u16 reserved ; 
-	__u16 acc_priority ; 
-	__u16 auth_source_class ; 
-	__u16 att_code ; 
-	__u8  source_addr[6] ; 
-	__u16 beacon_type ; 
-	__u16 major_vector ; 
-	__u16 lan_status ; 
-	__u16 soft_error_time ; 
- 	__u16 reserved1 ; 
-	__u16 local_ring ; 
-	__u16 mon_error ; 
-	__u16 beacon_transmit ; 
-	__u16 beacon_receive ; 
-	__u16 frame_correl ; 
-	__u8  beacon_naun[6] ; 
-	__u32 reserved2 ; 
-	__u8  beacon_phys[4] ; 	
+	u8  phys_addr[4] ; 
+	u8  up_node_addr[6] ; 
+	u8  up_phys_addr[4] ; 
+	u8  poll_addr[6] ; 
+	u16 reserved ; 
+	u16 acc_priority ; 
+	u16 auth_source_class ; 
+	u16 att_code ; 
+	u8  source_addr[6] ; 
+	u16 beacon_type ; 
+	u16 major_vector ; 
+	u16 lan_status ; 
+	u16 soft_error_time ; 
+ 	u16 reserved1 ; 
+	u16 local_ring ; 
+	u16 mon_error ; 
+	u16 beacon_transmit ; 
+	u16 beacon_receive ; 
+	u16 frame_correl ; 
+	u8  beacon_naun[6] ; 
+	u32 reserved2 ; 
+	u8  beacon_phys[4] ; 	
 }; 

