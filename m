Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJHTK7>; Tue, 8 Oct 2002 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSJHTKV>; Tue, 8 Oct 2002 15:10:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263231AbSJHTDh>; Tue, 8 Oct 2002 15:03:37 -0400
Subject: PATCH: (forwarded) Olympic fixes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:00:28 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzam-0004tD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like they escaped your notice

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/tokenring/olympic.c linux.2.5.41-ac1/drivers/net/tokenring/olympic.c
--- linux.2.5.41/drivers/net/tokenring/olympic.c	2002-10-02 21:34:05.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/tokenring/olympic.c	2002-10-02 21:43:12.000000000 +0100
@@ -56,8 +56,15 @@
  * 07/19/01 - Improve bad LAA reporting, strip out freemem
  *	      into a separate function, its called from 3 
  *	      different places now. 
- * 02/09/01 - Replaced sleep_on. 
- *
+ * 02/09/02 - Replaced sleep_on. 
+ * 03/01/02 - Replace access to several registers from 32 bit to 
+ * 	      16 bit. Fixes alignment errors on PPC 64 bit machines.
+ * 	      Thanks to Al Trautman for this one.
+ * 03/10/02 - Fix BUG in arb_cmd. Bug was there all along but was
+ * 	      silently ignored until the error checking code 
+ * 	      went into version 1.0.0 
+ * 06/04/02 - Add correct start up sequence for the cardbus adapters.
+ * 	      Required for strict compliance with pci power mgmt specs.
  *  To Do:
  *
  *	     Wake on lan	
@@ -111,7 +118,7 @@
  */
 
 static char version[] __devinitdata = 
-"Olympic.c v1.0.0 2/9/02  - Peter De Schrijver & Mike Phillips" ; 
+"Olympic.c v1.0.5 6/04/02 - Peter De Schrijver & Mike Phillips" ; 
 
 static char *open_maj_error[]  = {"No error", "Lobe Media Test", "Physical Insertion",
 				   "Address Verification", "Neighbor Notification (Ring Poll)",
@@ -296,9 +303,10 @@
 	spin_lock_init(&olympic_priv->olympic_lock) ; 
 
 	/* Needed for cardbus */
-	if(!(readl(olympic_mmio+BCTL) & BCTL_MODE_INDICATOR))
+	if(!(readl(olympic_mmio+BCTL) & BCTL_MODE_INDICATOR)) {
 		writel(readl(olympic_priv->olympic_mmio+FERMASK)|FERMASK_INT_BIT, olympic_mmio+FERMASK);
-
+	}
+	
 #if OLYMPIC_DEBUG
 	printk("BCTL: %x\n",readl(olympic_mmio+BCTL));
 	printk("GPR: %x\n",readw(olympic_mmio+GPR));
@@ -311,24 +319,42 @@
 	writel(readl(olympic_mmio+BCTL)|BCTL_MIMREB,olympic_mmio+BCTL);
 	
 	if (olympic_priv->olympic_ring_speed  == 0) { /* Autosense */
-		writel(readl(olympic_mmio+GPR)|GPR_AUTOSENSE,olympic_mmio+GPR);
+		writew(readw(olympic_mmio+GPR)|GPR_AUTOSENSE,olympic_mmio+GPR);
 		if (olympic_priv->olympic_message_level) 
 			printk(KERN_INFO "%s: Ringspeed autosense mode on\n",olympic_priv->olympic_card_name);
 	} else if (olympic_priv->olympic_ring_speed == 16) {
 		if (olympic_priv->olympic_message_level) 
 			printk(KERN_INFO "%s: Trying to open at 16 Mbps as requested\n", olympic_priv->olympic_card_name);
-		writel(GPR_16MBPS, olympic_mmio+GPR);
+		writew(GPR_16MBPS, olympic_mmio+GPR);
 	} else if (olympic_priv->olympic_ring_speed == 4) {
 		if (olympic_priv->olympic_message_level) 
 			printk(KERN_INFO "%s: Trying to open at 4 Mbps as requested\n", olympic_priv->olympic_card_name) ; 
-		writel(0, olympic_mmio+GPR);
+		writew(0, olympic_mmio+GPR);
 	} 
 	
-	writel(readl(olympic_mmio+GPR)|GPR_NEPTUNE_BF,olympic_mmio+GPR);
+	writew(readw(olympic_mmio+GPR)|GPR_NEPTUNE_BF,olympic_mmio+GPR);
 
 #if OLYMPIC_DEBUG
 	printk("GPR = %x\n",readw(olympic_mmio + GPR) ) ; 
 #endif
+	/* Solo has been paused to meet the Cardbus power
+	 * specs if the adapter is cardbus. Check to 
+	 * see its been paused and then restart solo. The
+	 * adapter should set the pause bit within 1 second.
+	 */
+
+	if(!(readl(olympic_mmio+BCTL) & BCTL_MODE_INDICATOR)) { 
+		t=jiffies;
+		while (!readl(olympic_mmio+CLKCTL) & CLKCTL_PAUSE) { 
+			schedule() ; 
+			if(jiffies-t > 2*HZ) { 
+				printk(KERN_ERR "IBM Cardbus tokenring adapter not responsing.\n") ; 
+				return -ENODEV;
+			}
+		}
+		writel(readl(olympic_mmio+CLKCTL) & ~CLKCTL_PAUSE, olympic_mmio+CLKCTL) ; 
+	}
+	
 	/* start solo init */
 	writel((1<<15),olympic_mmio+SISR_MASK_SUM);
 
@@ -341,13 +367,13 @@
 		}
 	}
 	
-	writel(readl(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
+	writel(readw(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
 
 #if OLYMPIC_DEBUG
 	printk("LAPWWO: %x, LAPA: %x\n",readl(olympic_mmio+LAPWWO), readl(olympic_mmio+LAPA));
 #endif
 
-	init_srb=olympic_priv->olympic_lap + ((readl(olympic_mmio+LAPWWO)) & (~0xf800));
+	init_srb=olympic_priv->olympic_lap + ((readw(olympic_mmio+LAPWWO)) & (~0xf800));
 
 #if OLYMPIC_DEBUG		
 {
@@ -422,11 +448,11 @@
 
 	/* adapter is closed, so SRB is pointed to by LAPWWO */
 
-	writel(readl(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
-	init_srb=olympic_priv->olympic_lap + ((readl(olympic_mmio+LAPWWO)) & (~0xf800));
+	writel(readw(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
+	init_srb=olympic_priv->olympic_lap + ((readw(olympic_mmio+LAPWWO)) & (~0xf800));
 	
 #if OLYMPIC_DEBUG
-	printk("LAPWWO: %x, LAPA: %x\n",readl(olympic_mmio+LAPWWO), readl(olympic_mmio+LAPA));
+	printk("LAPWWO: %x, LAPA: %x\n",readw(olympic_mmio+LAPWWO), readl(olympic_mmio+LAPA));
 	printk("SISR Mask = %04x\n", readl(olympic_mmio+SISR_MASK));
 	printk("Before the open command \n");
 #endif	
@@ -486,7 +512,7 @@
             			olympic_priv->srb_queued=0;
             			break;
         		}
-			if ((jiffies-t) > 60*HZ) { 
+			if ((jiffies-t) > 10*HZ) { 
 				printk(KERN_WARNING "%s: SRB timed out. \n",dev->name) ; 
 				olympic_priv->srb_queued=0;
 				break ; 
@@ -495,7 +521,7 @@
     		}
 		remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
 		set_current_state(TASK_RUNNING) ; 
-
+		olympic_priv->srb_queued = 0 ; 
 #if OLYMPIC_DEBUG
 		printk("init_srb(%p): ",init_srb);
 		for(i=0;i<20;i++)
@@ -629,7 +655,8 @@
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr = %08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
+%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
@@ -790,7 +817,7 @@
 			   	   	   first. Ideally all frames would be in a single buffer, this can be tuned by
                                	   	   altering the buffer size. If the length of the packet is less than
 					   1500 bytes we're going to copy it over anyway to stop packets getting
-					   dropped from sockets with buffers small than our pkt_buf_sz. */
+					   dropped from sockets with buffers smaller than our pkt_buf_sz. */
 				
  					if (buffer_cnt==1) {
 						olympic_priv->rx_ring_last_received++ ; 
@@ -1097,10 +1124,13 @@
 	writel(readl(olympic_mmio+BCTL)&~(3<<13),olympic_mmio+BCTL);
 
 #if OLYMPIC_DEBUG
+	{
+	int i ; 
 	printk("srb(%p): ",srb);
 	for(i=0;i<4;i++)
 		printk("%x ",readb(srb+i));
 	printk("\n");
+	}
 #endif
 	free_irq(dev->irq,dev);
 
@@ -1369,8 +1399,7 @@
 	arb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
 	asb_block = (u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
 	srb = (u8 *)(olympic_priv->olympic_lap + olympic_priv->srb) ; 
-	writel(readl(olympic_mmio+LAPA),olympic_mmio+LAPWWO);
-
+	
 	if (readb(arb_block+0) == ARB_RECEIVE_DATA) { /* Receive.data, MAC frames */
 
 		header_len = readb(arb_block+8) ; /* 802.5 Token-Ring Header Length */	
@@ -1423,7 +1452,7 @@
 		/* Now tell the card we have dealt with the received frame */
 
 		/* Set LISR Bit 1 */
-		writel(LISR_ARB_FREE,olympic_priv->olympic_lap + LISR_SUM);
+		writel(LISR_ARB_FREE,olympic_priv->olympic_mmio + LISR_SUM);
 
 		/* Is the ASB free ? */ 	
 		
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/tokenring/olympic.h linux.2.5.41-ac1/drivers/net/tokenring/olympic.h
--- linux.2.5.41/drivers/net/tokenring/olympic.h	2002-07-20 20:12:26.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/tokenring/olympic.h	2002-10-02 21:43:12.000000000 +0100
@@ -91,6 +91,7 @@
 #define TIMER 0x50
 
 #define CLKCTL 0x74
+#define CLKCTL_PAUSE (1<<15) 
 
 #define PM_CON 0x4
 
