Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271783AbTGRObr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271775AbTGROCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:02:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17029
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271723AbTGRN7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:59:14 -0400
Date: Fri, 18 Jul 2003 15:13:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181413.h6IEDZK3017708@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: convert ewrk3 for new locking etc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/net/ni65.c linux-2.6.0-test1-ac2/drivers/net/ni65.c
--- linux-2.6.0-test1/drivers/net/ni65.c	2003-07-10 21:06:49.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/net/ni65.c	2003-07-14 18:38:10.000000000 +0100
@@ -245,6 +245,7 @@
 	int cmdr_addr;
 	int cardno;
 	int features;
+	spinlock_t ring_lock;
 };
 
 static int  ni65_probe1(struct net_device *dev,int);
@@ -299,7 +300,7 @@
 	int irqval = request_irq(dev->irq, &ni65_interrupt,0,
                         cards[p->cardno].cardname,dev);
 	if (irqval) {
-		printk ("%s: unable to get IRQ %d (irqval=%d).\n",
+		printk(KERN_ERR "%s: unable to get IRQ %d (irqval=%d).\n",
 		          dev->name,dev->irq, irqval);
 		return -EAGAIN;
 	}
@@ -409,12 +410,14 @@
 	p = (struct priv *) dev->priv;
 	p->cmdr_addr = ioaddr + cards[i].cmd_offset;
 	p->cardno = i;
+	spin_lock_init(&p->ring_lock);
 
-	printk("%s: %s found at %#3x, ", dev->name, cards[p->cardno].cardname , ioaddr);
+	printk(KERN_INFO "%s: %s found at %#3x, ", dev->name, cards[p->cardno].cardname , ioaddr);
 
 	outw(inw(PORT+L_RESET),PORT+L_RESET); /* first: reset the card */
 	if( (j=readreg(CSR0)) != 0x4) {
-		 printk(KERN_ERR "can't RESET card: %04x\n",j);
+		 printk("failed.\n");
+		 printk(KERN_ERR "%s: Can't RESET card: %04x\n", dev->name, j);
 		 ni65_free_buffer(p);
 		 release_region(ioaddr, cards[p->cardno].total_size);
 		 return -EAGAIN;
@@ -467,7 +470,8 @@
 					break;
 			}
 			if(i == 5) {
-				printk("Can't detect DMA channel!\n");
+				printk("failed.\n");
+				printk(KERN_ERR "%s: Can't detect DMA channel!\n", dev->name);
 				ni65_free_buffer(p);
 				release_region(ioaddr, cards[p->cardno].total_size);
 				return -EAGAIN;
@@ -480,13 +484,13 @@
 
 		if(dev->irq < 2)
 		{
-			unsigned long irq_mask, delay;
+			unsigned long irq_mask;
 
 			ni65_init_lance(p,dev->dev_addr,0,0);
 			irq_mask = probe_irq_on();
 			writereg(CSR0_INIT|CSR0_INEA,CSR0); /* trigger interrupt */
-			delay = jiffies + HZ/50;
-			while (time_before(jiffies, delay)) ;
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/50);
 			dev->irq = probe_irq_off(irq_mask);
 			if(!dev->irq)
 			{
@@ -503,7 +507,7 @@
 
 	if(request_dma(dev->dma, cards[p->cardno].cardname ) != 0)
 	{
-		printk("%s: Can't request dma-channel %d\n",dev->name,(int) dev->dma);
+		printk(KERN_ERR "%s: Can't request dma-channel %d\n",dev->name,(int) dev->dma);
 		ni65_free_buffer(p);
 		release_region(ioaddr, cards[p->cardno].total_size);
 		return -EAGAIN;
@@ -570,7 +574,7 @@
 	if(type) {
 		ret = skb = alloc_skb(2+16+size,GFP_KERNEL|GFP_DMA);
 		if(!skb) {
-			printk("%s: unable to allocate %s memory.\n",dev->name,what);
+			printk(KERN_WARNING "%s: unable to allocate %s memory.\n",dev->name,what);
 			return NULL;
 		}
 		skb->dev = dev;
@@ -581,12 +585,12 @@
 	else {
 		ret = ptr = kmalloc(T_BUF_SIZE,GFP_KERNEL | GFP_DMA);
 		if(!ret) {
-			printk("%s: unable to allocate %s memory.\n",dev->name,what);
+			printk(KERN_WARNING "%s: unable to allocate %s memory.\n",dev->name,what);
 			return NULL;
 		}
 	}
 	if( (u32) virt_to_phys(ptr+size) > 0x1000000) {
-		printk("%s: unable to allocate %s memory in lower 16MB!\n",dev->name,what);
+		printk(KERN_WARNING "%s: unable to allocate %s memory in lower 16MB!\n",dev->name,what);
 		if(type)
 			kfree_skb(skb);
 		else
@@ -692,7 +696,7 @@
 	writedatareg(CSR0_STOP);
 
 	if(debuglevel > 1)
-		printk("ni65_stop_start\n");
+		printk(KERN_DEBUG "ni65_stop_start\n");
 
 	if(p->features & INIT_RING_BEFORE_START) {
 		int i;
@@ -846,6 +850,8 @@
 
 	p = (struct priv *) dev->priv;
 
+	spin_lock(&p->ring_lock);
+	
 	while(--bcnt) {
 		csr0 = inw(PORT+L_DATAREG);
 
@@ -867,7 +873,7 @@
 		{
 			struct priv *p = (struct priv *) dev->priv;
 			if(debuglevel > 1)
-				printk("%s: general error: %04x.\n",dev->name,csr0);
+				printk(KERN_ERR "%s: general error: %04x.\n",dev->name,csr0);
 			if(csr0 & CSR0_BABL)
 				p->stats.tx_errors++;
 			if(csr0 & CSR0_MISS) {
@@ -879,7 +885,7 @@
 			}
 			if(csr0 & CSR0_MERR) {
 				if(debuglevel > 1)
-					printk("%s: Ooops .. memory error: %04x.\n",dev->name,csr0);
+					printk(KERN_ERR "%s: Ooops .. memory error: %04x.\n",dev->name,csr0);
 				ni65_stop_start(dev,p);
 			}
 		}
@@ -932,12 +938,13 @@
 #endif
 
 	if( (csr0 & (CSR0_RXON | CSR0_TXON)) != (CSR0_RXON | CSR0_TXON) ) {
-		printk("%s: RX or TX was offline -> restart\n",dev->name);
+		printk(KERN_DEBUG "%s: RX or TX was offline -> restart\n",dev->name);
 		ni65_stop_start(dev,p);
 	}
 	else
 		writedatareg(CSR0_INEA);
 
+	spin_unlock(&p->ring_lock);
 	return IRQ_HANDLED;
 }
 
@@ -1147,9 +1154,7 @@
 				memset((char *)p->tmdbounce[p->tmdbouncenum]+skb->len, 0, len-skb->len);
 			dev_kfree_skb (skb);
 
-			save_flags(flags);
-			cli();
-
+			spin_lock_irqsave(&p->ring_lock, flags);
 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(p->tmdbounce[p->tmdbouncenum]);
 			p->tmdbouncenum = (p->tmdbouncenum + 1) & (TMDNUM - 1);
@@ -1157,8 +1162,7 @@
 #ifdef XMT_VIA_SKB
 		}
 		else {
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&p->ring_lock, flags);
 
 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(skb->data);
@@ -1178,8 +1182,8 @@
 			
 		p->lock = 0;
 		dev->trans_start = jiffies;
-
-		restore_flags(flags);
+		
+		spin_unlock_irqrestore(&p->ring_lock, flags);
 	}
 
 	return 0;
@@ -1238,10 +1242,8 @@
 {
 	struct priv *p;
 	p = (struct priv *) dev_ni65.priv;
-	if(!p) {
-		printk("Ooops .. no private struct\n");
-		return;
-	}
+	if(!p)
+		BUG();
 	disable_dma(dev_ni65.dma);
 	free_dma(dev_ni65.dma);
 	unregister_netdev(&dev_ni65);
@@ -1250,6 +1252,7 @@
 	dev_ni65.priv = NULL;
 }
 #endif /* MODULE */
+
 MODULE_LICENSE("GPL");
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/net/ni65.h linux-2.6.0-test1-ac2/drivers/net/ni65.h
--- linux-2.6.0-test1/drivers/net/ni65.h	2003-07-10 21:15:01.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/net/ni65.h	2003-07-14 18:31:52.000000000 +0100
@@ -20,32 +20,32 @@
 #define CSR0_BABL	0x4000	/* Babble transmitter timeout error (RC) */
 #define CSR0_CERR	0x2000	/* Collision Error (RC) */
 #define CSR0_MISS	0x1000	/* Missed packet (RC) */
-#define CSR0_MERR	0x0800	/* Memory Error (RC) */ 
+#define CSR0_MERR	0x0800	/* Memory Error (RC) */
 #define CSR0_RINT	0x0400	/* Receiver Interrupt (RC) */
-#define CSR0_TINT       0x0200	/* Transmit Interrupt (RC) */ 
+#define CSR0_TINT       0x0200	/* Transmit Interrupt (RC) */
 #define CSR0_IDON	0x0100	/* Initialization Done (RC) */
 #define CSR0_INTR	0x0080	/* Interrupt Flag (R) */
 #define CSR0_INEA	0x0040	/* Interrupt Enable (RW) */
 #define CSR0_RXON	0x0020	/* Receiver on (R) */
-#define CSR0_TXON	0x0010  /* Transmitter on (R) */
+#define CSR0_TXON	0x0010	/* Transmitter on (R) */
 #define CSR0_TDMD	0x0008	/* Transmit Demand (RS) */
-#define CSR0_STOP	0x0004 	/* Stop (RS) */
+#define CSR0_STOP	0x0004	/* Stop (RS) */
 #define CSR0_STRT	0x0002	/* Start (RS) */
 #define CSR0_INIT	0x0001	/* Initialize (RS) */
 
-#define CSR0_CLRALL    0x7f00  /* mask for all clearable bits */
+#define CSR0_CLRALL    0x7f00	/* mask for all clearable bits */
 /*
  *	Initialization Block  Mode operation Bit Definitions.
  */
 
 #define M_PROM		0x8000	/* Promiscuous Mode */
-#define M_INTL		0x0040  /* Internal Loopback */
-#define M_DRTY		0x0020  /* Disable Retry */ 
+#define M_INTL		0x0040	/* Internal Loopback */
+#define M_DRTY		0x0020	/* Disable Retry */
 #define M_COLL		0x0010	/* Force Collision */
 #define M_DTCR		0x0008	/* Disable Transmit CRC) */
 #define M_LOOP		0x0004	/* Loopback */
-#define M_DTX		0x0002	/* Disable the Transmitter */ 
-#define M_DRX		0x0001  /* Disable the Receiver */
+#define M_DTX		0x0002	/* Disable the Transmitter */
+#define M_DRX		0x0001	/* Disable the Receiver */
 
 
 /*
@@ -56,7 +56,7 @@
 #define RCV_ERR		0x40	/* Error Summary */
 #define RCV_FRAM	0x20	/* Framing Error */
 #define RCV_OFLO	0x10	/* Overflow Error */
-#define RCV_CRC		0x08	/* CRC Error */ 
+#define RCV_CRC		0x08	/* CRC Error */
 #define RCV_BUF_ERR	0x04	/* Buffer Error */
 #define RCV_START	0x02	/* Start of Packet */
 #define RCV_END		0x01	/* End of Packet */
@@ -67,7 +67,7 @@
  */
 
 #define XMIT_OWN	0x80	/* owner bit 0 = host, 1 = lance */
-#define XMIT_ERR	0x40    /* Error Summary */
+#define XMIT_ERR	0x40	/* Error Summary */
 #define XMIT_RETRY	0x10	/* more the 1 retry needed to Xmit */
 #define XMIT_1_RETRY	0x08	/* one retry needed to Xmit */
 #define XMIT_DEF	0x04	/* Deferred */
@@ -78,53 +78,44 @@
  * transmit status (2) (valid if XMIT_ERR == 1)
  */
 
-#define XMIT_TDRMASK    0x03ff  /* time-domain-reflectometer-value */
-#define XMIT_RTRY 	0x0400  /* Failed after 16 retransmissions  */
-#define XMIT_LCAR 	0x0800  /* Loss of Carrier */
-#define XMIT_LCOL 	0x1000  /* Late collision */
-#define XMIT_RESERV 	0x2000  /* Reserved */
-#define XMIT_UFLO 	0x4000  /* Underflow (late memory) */
-#define XMIT_BUFF 	0x8000  /* Buffering error (no ENP) */
-
-struct init_block 
-{
-  unsigned short mode;
-  unsigned char eaddr[6];
-  unsigned char filter[8];
-  /* bit 29-31: number of rmd's (power of 2) */
-  u32 rrp;   /* receive ring pointer (align 8) */
-  /* bit 29-31: number of tmd's (power of 2) */
-  u32 trp;   /* transmit ring pointer (align 8) */
+#define XMIT_TDRMASK    0x03ff	/* time-domain-reflectometer-value */
+#define XMIT_RTRY 	0x0400	/* Failed after 16 retransmissions  */
+#define XMIT_LCAR 	0x0800	/* Loss of Carrier */
+#define XMIT_LCOL 	0x1000	/* Late collision */
+#define XMIT_RESERV 	0x2000	/* Reserved */
+#define XMIT_UFLO 	0x4000	/* Underflow (late memory) */
+#define XMIT_BUFF 	0x8000	/* Buffering error (no ENP) */
+
+struct init_block {
+	unsigned short mode;
+	unsigned char eaddr[6];
+	unsigned char filter[8];
+	/* bit 29-31: number of rmd's (power of 2) */
+	u32 rrp;		/* receive ring pointer (align 8) */
+	/* bit 29-31: number of tmd's (power of 2) */
+	u32 trp;		/* transmit ring pointer (align 8) */
 };
 
-struct rmd /* Receive Message Descriptor */
-{ 
-  union
-  {
-    volatile u32 buffer;
-    struct 
-    {
-      volatile unsigned char dummy[3];
-      volatile unsigned char status; 
-    } s;
-  } u;
-  volatile short blen;
-  volatile unsigned short mlen;
+struct rmd {			/* Receive Message Descriptor */
+	union {
+		volatile u32 buffer;
+		struct {
+			volatile unsigned char dummy[3];
+			volatile unsigned char status;
+		} s;
+	} u;
+	volatile short blen;
+	volatile unsigned short mlen;
 };
 
-struct tmd
-{
-  union 
-  {
-    volatile u32 buffer;
-    struct 
-    {
-      volatile unsigned char dummy[3];
-      volatile unsigned char status;
-    } s;
-  } u;
-  volatile unsigned short blen;
-  volatile unsigned short status2;
+struct tmd {
+	union {
+		volatile u32 buffer;
+		struct {
+			volatile unsigned char dummy[3];
+			volatile unsigned char status;
+		} s;
+	} u;
+	volatile unsigned short blen;
+	volatile unsigned short status2;
 };
-
-
