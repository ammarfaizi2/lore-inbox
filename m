Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSJMTqc>; Sun, 13 Oct 2002 15:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSJMTqc>; Sun, 13 Oct 2002 15:46:32 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:29584 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S261617AbSJMTqU>;
	Sun, 13 Oct 2002 15:46:20 -0400
Date: Sun, 13 Oct 2002 21:52:01 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, mitch@sfgoth.com
Subject: Re: [PATCH] 2.4.20-pre8-ac3 - drivers/atm/iphase update
Message-ID: <20021013215201.C28206@fafner.intra.cogenit.fr>
References: <20021013000424.A20547@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021013000424.A20547@fafner.intra.cogenit.fr>; from romieu@cogenit.fr on Sun, Oct 13, 2002 at 12:04:24AM +0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Francois Romieu <romieu@cogenit.fr> :
[iphase update]

The diff of the header file is bOrken. Correct version attached.
Online version has been updated.

Merge/diff against against 2.5.x is available in parts and complete at
http://www.cogenit.fr/linux/patches/2.5.42-ac1/

--
Ueimor

--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=iphase-all

--- linux-2.4.20-pre8-ac3/drivers/atm/iphase.h	Sun Feb  4 19:05:29 2001
+++ linux-2.4.20-pre8-ac3/drivers/atm/iphase.h	Sun Oct 13 21:17:20 2002
@@ -200,7 +200,13 @@ struct cpcs_trailer 
 	u_short length;  
 	u_int	crc32;  
 };  
-  
+
+struct cpcs_trailer_desc
+{
+	struct cpcs_trailer *cpcs;
+	dma_addr_t dma_addr;
+};
+
 struct ia_vcc 
 { 
 	int rxing;	 
@@ -272,6 +278,7 @@ struct ext_vc 
 #define DLE_ENTRIES 256  
 #define DMA_INT_ENABLE 0x0002	/* use for both Tx and Rx */  
 #define TX_DLE_PSI 0x0001  
+#define DLE_TOTAL_SIZE (sizeof(struct dle)*DLE_ENTRIES)
   
 /* Descriptor List Entries (DLE) */  
 struct dle 
@@ -1017,7 +1024,7 @@ typedef struct iadev_t {  
         struct wait_queue     *close_wait;
         struct wait_queue     *timeout_wait;
 #endif
-	caddr_t *tx_buf;  
+	struct cpcs_trailer_desc *tx_buf;
         u16 num_tx_desc, tx_buf_sz, rate_limit;
         u32 tx_cell_cnt, tx_pkt_cnt;
         u32 MAIN_VC_TABLE_ADDR, EXT_VC_TABLE_ADDR, ABR_SCHED_TABLE_ADDR;
@@ -1063,7 +1070,9 @@ typedef struct iadev_t {  
         struct desc_tbl_t *desc_tbl;
         u_short host_tcq_wr;
         struct testTable_t **testTable;
-} IADEV;  
+	dma_addr_t tx_dle_dma;
+	dma_addr_t rx_dle_dma;
+} IADEV;
   
   
 #define INPH_IA_DEV(d) ((IADEV *) (d)->dev_data)  
--- linux-2.4.20-pre8-ac3/drivers/atm/iphase.c	Sat Oct 12 22:36:01 2002
+++ linux-2.4.20-pre8-ac3/drivers/atm/iphase.c	Sun Oct 13 21:17:20 2002
@@ -124,7 +124,7 @@ static void ia_enque_head_rtn_q (IARTN_Q
 }
 
 static int ia_enque_rtn_q (IARTN_Q *que, struct desc_tbl_t data) {
-   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
    if (!entry) return -1;
    entry->data = data;
    entry->next = NULL;
@@ -629,6 +629,7 @@ static int ia_que_tx (IADEV *iadev) { 
    struct ia_vcc *iavcc;
    static int ia_pkt_tx (struct atm_vcc *vcc, struct sk_buff *skb);
    num_desc = ia_avail_descs(iadev);
+
    while (num_desc && (skb = skb_dequeue(&iadev->tx_backlog))) {
       if (!(vcc = ATM_SKB(skb)->vcc)) {
          dev_kfree_skb_any(skb);
@@ -648,6 +649,7 @@ static int ia_que_tx (IADEV *iadev) { 
    }
    return 0;
 }
+
 void ia_tx_poll (IADEV *iadev) {
    struct atm_vcc *vcc = NULL;
    struct sk_buff *skb = NULL, *skb1 = NULL;
@@ -1091,6 +1093,7 @@ static int rx_pkt(struct atm_dev *dev)  
 	int len;  
 	struct sk_buff *skb;  
 	u_int buf_addr, dma_addr;  
+
 	iadev = INPH_IA_DEV(dev);  
 	if (iadev->rfL.pcq_rd == (readw(iadev->reass_reg+PCQ_WR_PTR)&0xffff)) 
 	{  
@@ -1192,7 +1195,8 @@ static int rx_pkt(struct atm_dev *dev)  
 
 	/* Build the DLE structure */  
 	wr_ptr = iadev->rx_dle_q.write;  
-	wr_ptr->sys_pkt_addr = virt_to_bus(skb->data);	  
+	wr_ptr->sys_pkt_addr = pci_map_single(iadev->pci, skb->data,
+		len, PCI_DMA_FROMDEVICE);
 	wr_ptr->local_pkt_addr = buf_addr;  
 	wr_ptr->bytes = len;	/* We don't know this do we ?? */  
 	wr_ptr->mode = DMA_INT_ENABLE;  
@@ -1311,6 +1315,9 @@ static void rx_dle_intr(struct atm_dev *
           struct cpcs_trailer *trailer;
           u_short length;
           struct ia_vcc *ia_vcc;
+
+	  pci_unmap_single(iadev->pci, iadev->rx_dle_q.write->sys_pkt_addr,
+	  	len, PCI_DMA_FROMDEVICE);
           /* no VCC related housekeeping done as yet. lets see */  
           vcc = ATM_SKB(skb)->vcc;
 	  if (!vcc) {
@@ -1430,7 +1437,7 @@ static int rx_init(struct atm_dev *dev) 
 	IADEV *iadev;  
 	struct rx_buf_desc *buf_desc_ptr;  
 	unsigned long rx_pkt_start = 0;  
-	u32 *odle_addr, *dle_addr;  
+	void *dle_addr;  
 	struct abr_vc_table  *abr_vc_table; 
 	u16 *vc_table;  
 	u16 *reass_table;  
@@ -1441,25 +1448,14 @@ static int rx_init(struct atm_dev *dev) 
   
 	iadev = INPH_IA_DEV(dev);  
   //    spin_lock_init(&iadev->rx_lock); 
-	/* I need to initialize the DLEs somewhere. Lets see what I   
-		need to do for this, hmmm...  
-		- allocate memory for 256 DLEs. make sure that it starts  
-		on a 4k byte address boundary. Program the start address   
-		in Receive List address register.  ..... to do for TX also  
-	   To make sure that it is a 4k byte boundary - allocate 8k and find   
-		4k byte boundary within.  
-		( (addr + (4k-1)) & ~(4k-1) )  
-	*/   
   
-	/* allocate 8k bytes */  
-	odle_addr = kmalloc(2*sizeof(struct dle)*DLE_ENTRIES, GFP_KERNEL);  
-	if (!odle_addr)  
-	{  
-		printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");  
-		return -ENOMEM;
-	}  
-	/* find 4k byte boundary within the 8k allocated */  
-	dle_addr = (u32*)( ((u32)odle_addr+(4096-1)) & ~(4096-1) );  
+	/* Allocate 4k bytes - more aligned than needed (4k boundary) */
+	dle_addr = pci_alloc_consistent(iadev->pci, DLE_TOTAL_SIZE,
+					&iadev->rx_dle_dma);  
+	if (!dle_addr)  {  
+		printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
+		goto err_out;
+	}
 	iadev->rx_dle_q.start = (struct dle*)dle_addr;  
 	iadev->rx_dle_q.read = iadev->rx_dle_q.start;  
 	iadev->rx_dle_q.write = iadev->rx_dle_q.start;  
@@ -1468,7 +1464,8 @@ static int rx_init(struct atm_dev *dev) 
 	DLE that can be used. */  
   
 	/* write the upper 20 bits of the start address to rx list address register */  
-	writel(virt_to_bus(dle_addr) & 0xfffff000, iadev->dma+IPHASE5575_RX_LIST_ADDR);  
+	writel(iadev->rx_dle_dma & 0xfffff000,
+	       iadev->dma + IPHASE5575_RX_LIST_ADDR);  
 	IF_INIT(printk("Tx Dle list addr: 0x%08x value: 0x%0x\n", 
                       (u32)(iadev->dma+IPHASE5575_TX_LIST_ADDR), 
                       *(u32*)(iadev->dma+IPHASE5575_TX_LIST_ADDR));  
@@ -1642,8 +1639,7 @@ static int rx_init(struct atm_dev *dev) 
 	{  
 		printk(KERN_ERR DEV_LABEL "itf %d couldn't get free page\n",
 		dev->number);  
-		kfree(odle_addr);
-		return -ENOMEM;  
+		goto err_free_dle;
 	}  
 	memset(iadev->rx_open, 0, 4*iadev->num_vc);  
         iadev->rxing = 1;
@@ -1651,6 +1647,12 @@ static int rx_init(struct atm_dev *dev) 
 	/* Mode Register */  
 	writew(R_ONLINE, iadev->reass_reg+MODE_REG);  
 	return 0;  
+
+err_free_dle:
+	pci_free_consistent(iadev->pci, DLE_TOTAL_SIZE, iadev->rx_dle_q.start,
+			    iadev->rx_dle_dma);  
+err_out:
+	return -ENOMEM;
 }  
   
 
@@ -1715,6 +1717,12 @@ static void tx_dle_intr(struct atm_dev *
             /* free the DMAed skb */ 
             skb = skb_dequeue(&iadev->tx_dma_q); 
             if (!skb) break;
+
+	    /* Revenge of the 2 dle (skb + trailer) used in ia_pkt_tx() */
+	    if (!((dle - iadev->tx_dle_q.start)%(2*sizeof(struct dle)))) {
+		pci_unmap_single(iadev->pci, dle->sys_pkt_addr, skb->len,
+				 PCI_DMA_TODEVICE);
+	    }
             vcc = ATM_SKB(skb)->vcc;
             if (!vcc) {
                   printk("tx_dle_intr: vcc is null\n");
@@ -1907,7 +1915,7 @@ static int tx_init(struct atm_dev *dev) 
 	IADEV *iadev;  
 	struct tx_buf_desc *buf_desc_ptr;
 	unsigned int tx_pkt_start;  
-	u32 *dle_addr;  
+	void *dle_addr;  
 	int i;  
 	u_short tcq_st_adr;  
 	u_short *tcq_start;  
@@ -1923,24 +1931,22 @@ static int tx_init(struct atm_dev *dev) 
  
 	IF_INIT(printk("Tx MASK REG: 0x%0x\n", 
                                 readw(iadev->seg_reg+SEG_MASK_REG));)  
-	/*---------- Initializing Transmit DLEs ----------*/  
-	/* allocating 8k memory for transmit DLEs */  
-	dle_addr = kmalloc(2*sizeof(struct dle)*DLE_ENTRIES, GFP_KERNEL);  
-	if (!dle_addr)  
-	{  
-		printk(KERN_ERR DEV_LABEL "can't allocate TX DLEs\n");  
-		return -ENOMEM;
-	}  
-  
-	/* find 4k byte boundary within the 8k allocated */  
-	dle_addr = (u32*)(((u32)dle_addr+(4096-1)) & ~(4096-1));  
+
+	/* Allocate 4k (boundary aligned) bytes */
+	dle_addr = pci_alloc_consistent(iadev->pci, DLE_TOTAL_SIZE,
+					&iadev->tx_dle_dma);  
+	if (!dle_addr)  {
+		printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
+		goto err_out;
+	}
 	iadev->tx_dle_q.start = (struct dle*)dle_addr;  
 	iadev->tx_dle_q.read = iadev->tx_dle_q.start;  
 	iadev->tx_dle_q.write = iadev->tx_dle_q.start;  
 	iadev->tx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE_ENTRIES);  
 
 	/* write the upper 20 bits of the start address to tx list address register */  
-	writel(virt_to_bus(dle_addr) & 0xfffff000, iadev->dma+IPHASE5575_TX_LIST_ADDR);  
+	writel(iadev->tx_dle_dma & 0xfffff000,
+	       iadev->dma + IPHASE5575_TX_LIST_ADDR);  
 	writew(0xffff, iadev->seg_reg+SEG_MASK_REG);  
 	writew(0, iadev->seg_reg+MODE_REG_0);  
 	writew(RESET_SEG, iadev->seg_reg+SEG_COMMAND_REG);  
@@ -1984,23 +1990,28 @@ static int tx_init(struct atm_dev *dev) 
 		buf_desc_ptr++;		  
 		tx_pkt_start += iadev->tx_buf_sz;  
 	}  
-        iadev->tx_buf = kmalloc(iadev->num_tx_desc*sizeof(caddr_t), GFP_KERNEL);
+        iadev->tx_buf = kmalloc(iadev->num_tx_desc*sizeof(struct cpcs_trailer_desc), GFP_KERNEL);
         if (!iadev->tx_buf) {
             printk(KERN_ERR DEV_LABEL " couldn't get mem\n");
-            return -EAGAIN;
+	    goto err_free_dle;
         }
        	for (i= 0; i< iadev->num_tx_desc; i++)
        	{
+	    struct cpcs_trailer *cpcs;
  
-       	    iadev->tx_buf[i] = kmalloc(sizeof(struct cpcs_trailer),
-                                                           GFP_KERNEL|GFP_DMA);
-            if(!iadev->tx_buf[i]) {                
+       	    cpcs = kmalloc(sizeof(*cpcs), GFP_KERNEL|GFP_DMA);
+            if(!cpcs) {                
 		printk(KERN_ERR DEV_LABEL " couldn't get freepage\n"); 
-         	return -EAGAIN;
+		goto err_free_tx_bufs;
             }
+	    iadev->tx_buf[i].cpcs = cpcs;
+	    iadev->tx_buf[i].dma_addr = pci_map_single(iadev->pci,
+		cpcs, sizeof(*cpcs), PCI_DMA_TODEVICE);
         }
         iadev->desc_tbl = kmalloc(iadev->num_tx_desc *
                                    sizeof(struct desc_tbl_t), GFP_KERNEL);
+        if(!iadev->desc_tbl)
+		goto err_free_all_tx_bufs;
   
 	/* Communication Queues base address */  
         i = TX_COMP_Q * iadev->memSize;
@@ -2128,7 +2139,7 @@ static int tx_init(struct atm_dev *dev) 
         iadev->testTable = kmalloc(sizeof(long)*iadev->num_vc, GFP_KERNEL); 
         if (!iadev->testTable) {
            printk("Get freepage  failed\n");
-           return -EAGAIN; 
+	   goto err_free_desc_tbl;
         }
 	for(i=0; i<iadev->num_vc; i++)  
 	{  
@@ -2137,7 +2148,7 @@ static int tx_init(struct atm_dev *dev) 
                 iadev->testTable[i] = kmalloc(sizeof(struct testTable_t),
 						GFP_KERNEL);
 		if (!iadev->testTable[i])
-			return -ENOMEM;
+			goto err_free_test_tables;
               	iadev->testTable[i]->lastTime = 0;
  		iadev->testTable[i]->fract = 0;
                 iadev->testTable[i]->vc_status = VC_UBR;
@@ -2193,7 +2204,30 @@ static int tx_init(struct atm_dev *dev) 
         iadev->tx_pkt_cnt = 0;
         iadev->rate_limit = iadev->LineRate / 3;
   
-	return 0;  
+	return 0;
+
+err_free_test_tables:
+	while (--i >= 0)
+		kfree(iadev->testTable[i]);
+	kfree(iadev->testTable);
+err_free_desc_tbl:
+	kfree(iadev->desc_tbl);
+err_free_all_tx_bufs:
+	i = iadev->num_tx_desc;
+err_free_tx_bufs:
+	while (--i >= 0) {
+		struct cpcs_trailer_desc *desc = iadev->tx_buf + i;
+
+		pci_unmap_single(iadev->pci, desc->dma_addr,
+			sizeof(*desc->cpcs), PCI_DMA_TODEVICE);
+		kfree(desc->cpcs);
+	}
+	kfree(iadev->tx_buf);
+err_free_dle:
+	pci_free_consistent(iadev->pci, DLE_TOTAL_SIZE, iadev->tx_dle_q.start,
+			    iadev->tx_dle_dma);  
+err_out:
+	return -ENOMEM;
 }   
    
 static void ia_int(int irq, void *dev_id, struct pt_regs *regs)  
@@ -2455,6 +2489,33 @@ static unsigned char ia_phy_get(struct a
 	return readl(INPH_IA_DEV(dev)->phy+addr);  
 }  
 
+static void ia_free_tx(IADEV *iadev)
+{
+	int i;
+
+	kfree(iadev->desc_tbl);
+	for (i = 0; i < iadev->num_vc; i++)
+		kfree(iadev->testTable[i]);
+	kfree(iadev->testTable);
+	for (i = 0; i < iadev->num_tx_desc; i++) {
+		struct cpcs_trailer_desc *desc = iadev->tx_buf + i;
+
+		pci_unmap_single(iadev->pci, desc->dma_addr,
+			sizeof(*desc->cpcs), PCI_DMA_TODEVICE);
+		kfree(desc->cpcs);
+	}
+	kfree(iadev->tx_buf);
+	pci_free_consistent(iadev->pci, DLE_TOTAL_SIZE, iadev->tx_dle_q.start,
+			    iadev->tx_dle_dma);  
+}
+
+static void ia_free_rx(IADEV *iadev)
+{
+	kfree(iadev->rx_open);
+	pci_free_consistent(iadev->pci, DLE_TOTAL_SIZE, iadev->rx_dle_q.start,
+			    iadev->rx_dle_dma);  
+}
+
 #if LINUX_VERSION_CODE >= 0x20312
 static int __init ia_start(struct atm_dev *dev)
 #else
@@ -2462,7 +2523,7 @@ __initfunc(static int ia_start(struct at
 #endif  
 {  
 	IADEV *iadev;  
-	int error = 1;  
+	int error;  
 	unsigned char phy;  
 	u32 ctrl_reg;  
 	IF_EVENT(printk(">ia_start\n");)  
@@ -2470,7 +2531,8 @@ __initfunc(static int ia_start(struct at
         if (request_irq(iadev->irq, &ia_int, SA_SHIRQ, DEV_LABEL, dev)) {  
                 printk(KERN_ERR DEV_LABEL "(itf %d): IRQ%d is already in use\n",  
                     dev->number, iadev->irq);  
-                return -EAGAIN;  
+		error = -EAGAIN;
+		goto err_out;
         }  
         /* @@@ should release IRQ on error */  
 	/* enabling memory + master */  
@@ -2480,8 +2542,8 @@ __initfunc(static int ia_start(struct at
 	{  
                 printk(KERN_ERR DEV_LABEL "(itf %d): can't enable memory+"  
                     "master (0x%x)\n",dev->number, error);  
-                free_irq(iadev->irq, dev); 
-                return -EIO;  
+		error = -EIO;  
+		goto err_free_irq;
         }  
 	udelay(10);  
   
@@ -2515,15 +2577,11 @@ __initfunc(static int ia_start(struct at
     
         ia_hw_type(iadev); 
 	error = tx_init(dev);  
-	if (error) {
-           free_irq(iadev->irq, dev);  
-           return error;
-        }  
+	if (error)
+		goto err_free_irq;
 	error = rx_init(dev);  
-	if (error) {
-          free_irq(iadev->irq, dev); 
-          return error;  
-        }
+	if (error)
+		goto err_free_tx;
   
 	ctrl_reg = readl(iadev->reg+IPHASE5575_BUS_CONTROL_REG);  
        	writel(ctrl_reg | CTRL_FE_RST, iadev->reg+IPHASE5575_BUS_CONTROL_REG);   
@@ -2538,33 +2596,36 @@ __initfunc(static int ia_start(struct at
 
         if (iadev->phy_type &  FE_25MBIT_PHY) {
            ia_mb25_init(iadev);
-           return 0;
-        }
-        if (iadev->phy_type & (FE_DS3_PHY | FE_E3_PHY)) {
+        } else if (iadev->phy_type & (FE_DS3_PHY | FE_E3_PHY)) {
            ia_suni_pm7345_init(iadev);
-           return 0;
-        }
-
-	error = suni_init(dev);  
-	if (error) {
-          free_irq(iadev->irq, dev); 
-          return error;  
-        }
-
-        /* Enable interrupt on loss of signal SUNI_RSOP_CIE 0x10
-           SUNI_RSOP_CIE_LOSE - 0x04
-        */
-        ia_phy_put(dev, ia_phy_get(dev,0x10) | 0x04, 0x10);         
+        } else {
+		error = suni_init(dev);
+		if (error)
+			goto err_free_rx;
+		/* 
+		 * Enable interrupt on loss of signal
+		 * SUNI_RSOP_CIE - 0x10
+		 * SUNI_RSOP_CIE_LOSE - 0x04
+		 */
+		ia_phy_put(dev, ia_phy_get(dev, 0x10) | 0x04, 0x10);
 #ifndef MODULE
-	error = dev->phy->start(dev);  
-	if (error) {
-          free_irq(iadev->irq, dev);
-          return error;
-        }   
+		error = dev->phy->start(dev);
+		if (error)
+			goto err_free_rx;
 #endif
-        /* Get iadev->carrier_detect status */
-        IaFrontEndIntr(iadev);
-	return 0;  
+		/* Get iadev->carrier_detect status */
+		IaFrontEndIntr(iadev);
+	}
+	return 0;
+
+err_free_rx:
+	ia_free_rx(iadev);
+err_free_tx:
+	ia_free_tx(iadev);
+err_free_irq:
+	free_irq(iadev->irq, dev);  
+err_out:
+	return error;
 }  
   
 static void ia_close(struct atm_vcc *vcc)  
@@ -2873,10 +2934,10 @@ static int ia_pkt_tx (struct atm_vcc *vc
         struct tx_buf_desc *buf_desc_ptr;
         int desc;
         int comp_code;
-        unsigned int addr;
         int total_len, pad, last;
         struct cpcs_trailer *trailer;
         struct ia_vcc *iavcc;
+
         iadev = INPH_IA_DEV(vcc->dev);  
         iavcc = INPH_IA_VCC(vcc);
         if (!iavcc->txing) {
@@ -2961,13 +3022,9 @@ static int ia_pkt_tx (struct atm_vcc *vc
 	IF_TX(printk("ia packet len:%d padding:%d\n", total_len, pad);)  
  
 	/* Put the packet in a tx buffer */   
-	if (!iadev->tx_buf[desc-1])  
-		printk("couldn't get free page\n");  
-
+	trailer = iadev->tx_buf[desc-1].cpcs;
         IF_TX(printk("Sent: skb = 0x%x skb->data: 0x%x len: %d, desc: %d\n",
                   (u32)skb, (u32)skb->data, skb->len, desc);)
-        addr = virt_to_bus(skb->data);
-	trailer = (struct cpcs_trailer*)iadev->tx_buf[desc-1];  
 	trailer->control = 0; 
         /*big endian*/ 
 	trailer->length = ((skb->len & 0xff) << 8) | ((skb->len & 0xff00) >> 8);
@@ -2983,6 +3040,7 @@ static int ia_pkt_tx (struct atm_vcc *vc
 	buf_desc_ptr = (struct tx_buf_desc *)(iadev->seg_ram+TX_DESC_BASE);  
 	buf_desc_ptr += desc;	/* points to the corresponding entry */  
 	buf_desc_ptr->desc_mode = AAL5 | EOM_EN | APP_CRC32 | CMPL_INT;   
+	/* Huh ? p.115 of users guide describes this as a read-only register */
         writew(TRANSMIT_DONE, iadev->seg_reg+SEG_INTR_STATUS_REG);
 	buf_desc_ptr->vc_index = vcc->vci;
 	buf_desc_ptr->bytes = total_len;  
@@ -2993,7 +3051,8 @@ static int ia_pkt_tx (struct atm_vcc *vc
 	/* Build the DLE structure */  
 	wr_ptr = iadev->tx_dle_q.write;  
 	memset((caddr_t)wr_ptr, 0, sizeof(*wr_ptr));  
-	wr_ptr->sys_pkt_addr = addr;  
+	wr_ptr->sys_pkt_addr = pci_map_single(iadev->pci, skb->data,
+		skb->len, PCI_DMA_TODEVICE);
 	wr_ptr->local_pkt_addr = (buf_desc_ptr->buf_start_hi << 16) | 
                                                   buf_desc_ptr->buf_start_lo;  
 	/* wr_ptr->bytes = swap(total_len);	didn't seem to affect ?? */  
@@ -3011,7 +3070,7 @@ static int ia_pkt_tx (struct atm_vcc *vc
 		wr_ptr = iadev->tx_dle_q.start;  
         
         /* Build trailer dle */
-        wr_ptr->sys_pkt_addr = virt_to_bus(iadev->tx_buf[desc-1]);
+        wr_ptr->sys_pkt_addr = iadev->tx_buf[desc-1].dma_addr;
         wr_ptr->local_pkt_addr = ((buf_desc_ptr->buf_start_hi << 16) | 
           buf_desc_ptr->buf_start_lo) + total_len - sizeof(struct cpcs_trailer);
 
@@ -3163,135 +3222,130 @@ static const struct atmdev_ops ops = {  
 };  
 	  
   
-#if LINUX_VERSION_CODE >= 0x20312
-int __init ia_detect(void)
-#else
-__initfunc(int ia_detect(void)) 
-#endif 
+static int __devinit ia_init_one(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
 {  
 	struct atm_dev *dev;  
 	IADEV *iadev;  
         unsigned long flags;
-        int index = 0;  
-	struct pci_dev *prev_dev;       
-	if (!pci_present()) {  
-		printk(KERN_ERR DEV_LABEL " driver but no PCI BIOS ?\n");  
-		return 0;  
-	}  
+	int ret;
+
 	iadev = kmalloc(sizeof(*iadev), GFP_KERNEL); 
-	if (!iadev) return -ENOMEM;  
-        memset((char*)iadev, 0, sizeof(*iadev));
-	prev_dev = NULL;  
-	while((iadev->pci = pci_find_device(PCI_VENDOR_ID_IPHASE,  
-		PCI_DEVICE_ID_IPHASE_5575,  prev_dev))) {  
-		IF_INIT(printk("ia detected at bus:%d dev: %d function:%d\n",
-                     iadev->pci->bus->number, PCI_SLOT(iadev->pci->devfn), 
-                                                 PCI_FUNC(iadev->pci->devfn));)  
-		if (pci_enable_device(iadev->pci)) break;
-		dev = atm_dev_register(DEV_LABEL, &ops, -1, NULL);
-		if (!dev) break;  
-		IF_INIT(printk(DEV_LABEL "registered at (itf :%d)\n", 
-                                                             dev->number);)  
-		INPH_IA_DEV(dev) = iadev; 
-                // TODO: multi_board using ia_boards logic in cleanup_module
-		ia_dev[index] = iadev;
-		_ia_dev[index] = dev;
-                IF_INIT(printk("dev_id = 0x%x iadev->LineRate = %d \n", 
-                                        (u32)dev, iadev->LineRate);)
-                iadev_count++;
-                spin_lock_init(&iadev->misc_lock);
-                spin_lock_irqsave(&iadev->misc_lock, flags); 
-		if (ia_init(dev) || ia_start(dev)) {  
-			atm_dev_deregister(dev);  
-                        IF_INIT(printk("IA register failed!\n");)
-                        ia_dev[index] = NULL;
-                        _ia_dev[index] = NULL;
-                        iadev_count--;
-                        spin_unlock_irqrestore(&iadev->misc_lock, flags); 
-			return -EINVAL;  
-		}  
-                spin_unlock_irqrestore(&iadev->misc_lock, flags);
-                IF_EVENT(printk("iadev_count = %d\n", iadev_count);)
-		prev_dev = iadev->pci;  
-		iadev->next_board = ia_boards;  
-		ia_boards = dev;  
-		iadev = kmalloc(sizeof(*iadev), GFP_KERNEL);  
-		if (!iadev) break;   
-                memset((char*)iadev, 0, sizeof(*iadev)); 
-		index++;  
-                dev = NULL;
-	}  
-	return index;  
-}  
-  
+	if (!iadev) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	memset(iadev, 0, sizeof(*iadev));
+	iadev->pci = pdev;
 
-#ifdef MODULE  
-  
-int init_module(void)  
-{  
-	IF_EVENT(printk(">ia init_module\n");)  
-	if (!ia_detect()) {  
-		printk(KERN_ERR DEV_LABEL ": no adapter found\n");  
-		return -ENXIO;  
-	}  
-   	ia_timer.expires = jiffies + 3*HZ;
-   	add_timer(&ia_timer); 
-   
-	return 0;  
-}  
-  
-  
-void cleanup_module(void)  
-{  
-	struct atm_dev *dev;  
-	IADEV *iadev;  
-	unsigned short command;  
-        int i, j= 0;
- 
-	IF_EVENT(printk(">ia cleanup_module\n");)  
-	if (MOD_IN_USE)  
-		printk("ia: module in use\n");  
-        del_timer(&ia_timer);
-	while(ia_dev[j])  
-	{  
-		dev = ia_boards;  
-		iadev = INPH_IA_DEV(dev);  
-		ia_boards = iadev->next_board;  
-                
-        	/* disable interrupt of lost signal */
-        	ia_phy_put(dev, ia_phy_get(dev,0x10) & ~(0x4), 0x10); 
-        	udelay(1);
-
-      		/* De-register device */  
-      		atm_dev_deregister(dev);  
-		IF_EVENT(printk("iav deregistered at (itf:%d)\n", dev->number);)
-		for (i= 0; i< iadev->num_tx_desc; i++)
-                        kfree(iadev->tx_buf[i]);
-                kfree(iadev->tx_buf);
-      		/* Disable memory mapping and busmastering */  
-		if (pci_read_config_word(iadev->pci,  
-					     PCI_COMMAND, &command) != 0)  
-      		{  
-         		printk("ia: can't read PCI_COMMAND.\n");  
-      		}  
-      		command &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);  
-      		if (pci_write_config_word(iadev->pci,  
-					      PCI_COMMAND, command) != 0)  
-      		{  
-         		printk("ia: can't write PCI_COMMAND.\n");  
-      		}  
-      		free_irq(iadev->irq, dev);  
-      		iounmap((void *) iadev->base);  
-      		kfree(iadev);  
-                j++;
-	}  
-	/* and voila whatever we tried seems to work. I don't know if it will  
-		fix suni errors though. Really doubt that. */  
-        for (i = 0; i<8; i++) {
-               ia_dev[i] =  NULL;
-              _ia_dev[i] = NULL;
-        }
-}  
+	IF_INIT(printk("ia detected at bus:%d dev: %d function:%d\n",
+		pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));)
+	if (pci_enable_device(pdev)) {
+		ret = -ENODEV;
+		goto err_out_free_iadev;
+	}
+	dev = atm_dev_register(DEV_LABEL, &ops, -1, NULL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto err_out_disable_dev;
+	}
+	INPH_IA_DEV(dev) = iadev; 
+	IF_INIT(printk(DEV_LABEL "registered at (itf :%d)\n", dev->number);)
+	IF_INIT(printk("dev_id = 0x%x iadev->LineRate = %d \n", (u32)dev,
+		iadev->LineRate);)
+
+	ia_dev[iadev_count] = iadev;
+	_ia_dev[iadev_count] = dev;
+	iadev_count++;
+	spin_lock_init(&iadev->misc_lock);
+	/* First fixes first. I don't want to think about this now. */
+	spin_lock_irqsave(&iadev->misc_lock, flags); 
+	if (ia_init(dev) || ia_start(dev)) {  
+		IF_INIT(printk("IA register failed!\n");)
+		iadev_count--;
+		ia_dev[iadev_count] = NULL;
+		_ia_dev[iadev_count] = NULL;
+		spin_unlock_irqrestore(&iadev->misc_lock, flags); 
+		ret = -EINVAL;
+		goto err_out_deregister_dev;
+	}
+	spin_unlock_irqrestore(&iadev->misc_lock, flags); 
+	IF_EVENT(printk("iadev_count = %d\n", iadev_count);)
 
-#endif  
+	iadev->next_board = ia_boards;  
+	ia_boards = dev;  
+
+	pci_set_drvdata(pdev, dev);
+
+	return 0;
+
+err_out_deregister_dev:
+	atm_dev_deregister(dev);  
+err_out_disable_dev:
+	pci_disable_device(pdev);
+err_out_free_iadev:
+	kfree(iadev);
+err_out:
+	return ret;
+}
+
+static void __devexit ia_remove_one(struct pci_dev *pdev)
+{
+	struct atm_dev *dev = pci_get_drvdata(pdev);
+	IADEV *iadev = INPH_IA_DEV(dev);
+
+	ia_phy_put(dev, ia_phy_get(dev,0x10) & ~(0x4), 0x10); 
+	udelay(1);
+
+	/* De-register device */  
+      	free_irq(iadev->irq, dev);
+	iadev_count--;
+	ia_dev[iadev_count] = NULL;
+	_ia_dev[iadev_count] = NULL;
+	atm_dev_deregister(dev);
+	IF_EVENT(printk("iav deregistered at (itf:%d)\n", dev->number);)
+
+      	iounmap((void *) iadev->base);  
+	pci_disable_device(pdev);
+
+	ia_free_rx(iadev);
+	ia_free_tx(iadev);
+
+      	kfree(iadev);
+}
+
+static struct pci_device_id ia_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_IPHASE, 0x0008, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_IPHASE, 0x0009, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0,}
+};
+MODULE_DEVICE_TABLE(pci, ia_pci_tbl);
+
+static struct pci_driver ia_driver = {
+	.name =         DEV_LABEL,
+	.id_table =     ia_pci_tbl,
+	.probe =        ia_init_one,
+	.remove =       ia_remove_one,
+};
+
+static int __init ia_init_module(void)
+{
+	int ret;
+
+	ret = pci_module_init(&ia_driver);
+	if (ret >= 0) {
+		ia_timer.expires = jiffies + 3*HZ;
+		add_timer(&ia_timer); 
+	}
+	return ret;
+}
+
+static void __exit ia_cleanup_module(void)
+{
+	pci_unregister_driver(&ia_driver);
+
+        del_timer(&ia_timer);
+}
 
+module_init(ia_init_module);
+module_exit(ia_cleanup_module);

--ftEhullJWpWg/VHq--
