Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTDGXWM (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDGXN4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:13:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58752
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263818AbTDGXFa (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:05:30 -0400
Date: Tue, 8 Apr 2003 01:24:23 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080024.h380ONVo009101@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: first cut at scc.c for 2.5 locking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/hamradio/scc.c linux-2.5.67-ac1/drivers/net/hamradio/scc.c
--- linux-2.5.67/drivers/net/hamradio/scc.c	2003-02-15 03:39:31.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/hamradio/scc.c	2003-04-07 20:08:53.000000000 +0100
@@ -235,13 +235,14 @@
 
 /* These provide interrupt save 2-step access to the Z8530 registers */
 
+static spinlock_t iolock;	/* Guards paired accesses */
+
 static inline unsigned char InReg(io_port port, unsigned char reg)
 {
 	unsigned long flags;
 	unsigned char r;
-	
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(&iolock, flags);	
 #ifdef SCC_LDELAY
 	Outb(port, reg);
 	udelay(SCC_LDELAY);
@@ -251,16 +252,15 @@
 	Outb(port, reg);
 	r=Inb(port);
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&iolock, flags);
 	return r;
 }
 
 static inline void OutReg(io_port port, unsigned char reg, unsigned char val)
 {
 	unsigned long flags;
-	
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(&iolock, flags);
 #ifdef SCC_LDELAY
 	Outb(port, reg); udelay(SCC_LDELAY);
 	Outb(port, val); udelay(SCC_LDELAY);
@@ -268,7 +268,7 @@
 	Outb(port, reg);
 	Outb(port, val);
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&iolock, flags);
 }
 
 static inline void wr(struct scc_channel *scc, unsigned char reg,
@@ -295,9 +295,7 @@
 {
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-	
+	spin_lock_irqsave(&scc->lock, flags);	
 	if (scc->tx_buff != NULL)
 	{
 		dev_kfree_skb(scc->tx_buff);
@@ -307,7 +305,7 @@
 	while (skb_queue_len(&scc->tx_queue))
 		dev_kfree_skb(skb_dequeue(&scc->tx_queue));
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 
@@ -609,6 +607,7 @@
 
 static void scc_isr_dispatch(struct scc_channel *scc, int vector)
 {
+	spin_lock(&scc->lock);
 	switch (vector & VECTOR_MASK)
 	{
 		case TXINT: scc_txint(scc); break;
@@ -616,6 +615,7 @@
 		case RXINT: scc_rxint(scc); break;
 		case SPINT: scc_spint(scc); break;
 	}
+	spin_unlock(&scc->lock);
 }
 
 /* If the card has a latch for the interrupt vector (like the PA0HZP card)
@@ -722,12 +722,13 @@
 
 static inline void set_speed(struct scc_channel *scc)
 {
-	disable_irq(scc->irq);
+	unsigned long flags;
+	spin_lock_irqsave(&scc->lock, flags);
 
 	if (scc->modem.speed > 0)	/* paranoia... */
 		set_brg(scc, (unsigned) (scc->clock / (scc->modem.speed * 64)) - 2);
-
-	enable_irq(scc->irq);
+		
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 
@@ -988,14 +989,8 @@
 
 /* ----> SCC timer interrupt handler and friends. <---- */
 
-static void scc_start_tx_timer(struct scc_channel *scc, void (*handler)(unsigned long), unsigned long when)
+static void __scc_start_tx_timer(struct scc_channel *scc, void (*handler)(unsigned long), unsigned long when)
 {
-	unsigned long flags;
-	
-	
-	save_flags(flags);
-	cli();
-
 	del_timer(&scc->tx_t);
 
 	if (when == 0)
@@ -1009,17 +1004,22 @@
 		scc->tx_t.expires = jiffies + (when*HZ)/100;
 		add_timer(&scc->tx_t);
 	}
+}
+
+static void scc_start_tx_timer(struct scc_channel *scc, void (*handler)(unsigned long), unsigned long when)
+{
+	unsigned long flags;
 	
-	restore_flags(flags);
+	spin_lock_irqsave(&scc->lock, flags);
+	__scc_start_tx_timer(scc, handler, when);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 static void scc_start_defer(struct scc_channel *scc)
 {
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&scc->lock, flags);
 	del_timer(&scc->tx_wdog);
 	
 	if (scc->kiss.maxdefer != 0 && scc->kiss.maxdefer != TIMER_OFF)
@@ -1029,16 +1029,14 @@
 		scc->tx_wdog.expires = jiffies + HZ*scc->kiss.maxdefer;
 		add_timer(&scc->tx_wdog);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 static void scc_start_maxkeyup(struct scc_channel *scc)
 {
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&scc->lock, flags);
 	del_timer(&scc->tx_wdog);
 	
 	if (scc->kiss.maxkeyup != 0 && scc->kiss.maxkeyup != TIMER_OFF)
@@ -1048,8 +1046,7 @@
 		scc->tx_wdog.expires = jiffies + HZ*scc->kiss.maxkeyup;
 		add_timer(&scc->tx_wdog);
 	}
-	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 /* 
@@ -1189,13 +1186,10 @@
 	struct scc_channel *scc = (struct scc_channel *) channel;
 	unsigned long flags;
 	
- 	save_flags(flags);
- 	cli();
- 
+	spin_lock_irqsave(&scc->lock, flags); 
  	del_timer(&scc->tx_wdog);	
  	scc_key_trx(scc, TX_OFF);
-
- 	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 
  	if (scc->stat.tx_state == TXS_TIMEOUT)		/* we had a timeout? */
  	{
@@ -1242,9 +1236,7 @@
 	struct scc_channel *scc = (struct scc_channel *) channel;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&scc->lock, flags);
 	/* 
 	 * let things settle down before we start to
 	 * accept new data.
@@ -1259,7 +1251,7 @@
 	cl(scc, R15, TxUIE);		/* count it. */
 	OutReg(scc->ctrl, R0, RES_Tx_P);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 
 	scc->stat.txerrs++;
 	scc->stat.tx_state = TXS_TIMEOUT;
@@ -1289,13 +1281,10 @@
 static void scc_init_timer(struct scc_channel *scc)
 {
 	unsigned long flags;
-	
-	save_flags(flags); 
-	cli();
-	
-	scc->stat.tx_state = TXS_IDLE;
 
-	restore_flags(flags);
+	spin_lock_irqsave(&scc->lock, flags);	
+	scc->stat.tx_state = TXS_IDLE;
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 
@@ -1414,9 +1403,7 @@
 	struct scc_channel *scc = (struct scc_channel *) channel;
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&scc->lock, flags);
 	del_timer(&scc->tx_wdog);
 	scc_key_trx(scc, TX_OFF);
 	wr(scc, R6, 0);
@@ -1425,7 +1412,7 @@
 	Outb(scc->ctrl,RES_EXT_INT);
 
 	netif_wake_queue(scc->dev);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 
@@ -1434,9 +1421,7 @@
 {
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&scc->lock, flags);
 	netif_stop_queue(scc->dev);
 	scc_discard_buffers(scc);
 
@@ -1460,7 +1445,7 @@
 	Outb(scc->ctrl,RES_EXT_INT);
 
 	scc_key_trx(scc, TX_ON);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&scc->lock, flags);
 }
 
 /* ******************************************************************* */
@@ -1508,16 +1493,14 @@
 			
 		/* Reset and pre-init Z8530 */
 
-		save_flags(flags);
-		cli();
-		
+		spin_lock_irqsave(&scc->lock, flags);
+				
 		Outb(scc->ctrl, 0);
 		OutReg(scc->ctrl,R9,FHWRES);		/* force hardware reset */
 		udelay(100);				/* give it 'a bit' more time than required */
 		wr(scc, R2, chip*16);			/* interrupt vector */
 		wr(scc, R9, VIS);			/* vector includes status */
-		
-        	restore_flags(flags);
+		spin_unlock_irqrestore(&scc->lock, flags);		
         }
 
  
@@ -1548,6 +1531,8 @@
 	dev->priv = (void *) scc;
 	dev->init = scc_net_init;
 
+	spin_lock_init(&scc->lock);
+	
 	if ((addev? register_netdevice(dev) : register_netdev(dev)) != 0) {
 		kfree(dev);
                 return -EIO;
@@ -1625,17 +1610,14 @@
 
 	netif_stop_queue(dev);
 
-	save_flags(flags); 
-	cli();
-	
+	spin_lock_irqsave(&scc->lock, flags);	
 	Outb(scc->ctrl,0);		/* Make sure pointer is written */
 	wr(scc,R1,0);			/* disable interrupts */
 	wr(scc,R3,0);
+	spin_unlock_irqrestore(&scc->lock, flags);
 
-	del_timer(&scc->tx_t);
-	del_timer(&scc->tx_wdog);
-
-	restore_flags(flags);
+	del_timer_sync(&scc->tx_t);
+	del_timer_sync(&scc->tx_wdog);
 	
 	scc_discard_buffers(scc);
 
@@ -1689,9 +1671,8 @@
 		return 0;
 	}
 
-	save_flags(flags);
-	cli();
-	
+	spin_lock_irqsave(&scc->lock, flags);
+		
 	if (skb_queue_len(&scc->tx_queue) > scc->dev->tx_queue_len) {
 		struct sk_buff *skb_del;
 		skb_del = skb_dequeue(&scc->tx_queue);
@@ -1710,12 +1691,11 @@
 	if(scc->stat.tx_state == TXS_IDLE || scc->stat.tx_state == TXS_IDLE2) {
 		scc->stat.tx_state = TXS_BUSY;
 		if (scc->kiss.fulldup == KISS_DUPLEX_HALF)
-			scc_start_tx_timer(scc, t_dwait, scc->kiss.waittime);
+			__scc_start_tx_timer(scc, t_dwait, scc->kiss.waittime);
 		else
-			scc_start_tx_timer(scc, t_dwait, 0);
+			__scc_start_tx_timer(scc, t_dwait, 0);
 	}
-
-	restore_flags(flags);	
+	spin_unlock_irqrestore(&scc->lock, flags);
 	return 0;
 }
 
@@ -1785,19 +1765,23 @@
 				hwcfg.clock = SCC_DEFAULT_CLOCK;
 
 #ifndef SCC_DONT_CHECK
-			disable_irq(hwcfg.irq);
-
-			check_region(scc->ctrl, 1);
-			Outb(hwcfg.ctrl_a, 0);
-			OutReg(hwcfg.ctrl_a, R9, FHWRES);
-			udelay(100);
-			OutReg(hwcfg.ctrl_a,R13,0x55);		/* is this chip really there? */
-			udelay(5);
 
-			if (InReg(hwcfg.ctrl_a,R13) != 0x55)
+			if(request_region(scc->ctrl, 1, "scc-probe"))
+			{
+				disable_irq(hwcfg.irq);
+				Outb(hwcfg.ctrl_a, 0);
+				OutReg(hwcfg.ctrl_a, R9, FHWRES);
+				udelay(100);
+				OutReg(hwcfg.ctrl_a,R13,0x55);		/* is this chip really there? */
+				udelay(5);
+
+				if (InReg(hwcfg.ctrl_a,R13) != 0x55)
+					found = 0;
+				enable_irq(hwcfg.irq);
+				release_region(scc->ctrl, 1);
+			}
+			else
 				found = 0;
-
-			enable_irq(hwcfg.irq);
 #endif
 
 			if (found)
@@ -2111,6 +2095,8 @@
 	
 	printk(banner);
 	
+	spin_lock_init(&iolock);
+	
 	sprintf(devname,"%s0", SCC_DriverName);
 	
 	result = scc_net_setup(SCC_Info, devname, 0);
@@ -2127,20 +2113,19 @@
 
 static void __exit scc_cleanup_driver(void)
 {
-	unsigned long flags;
 	io_port ctrl;
 	int k;
 	struct scc_channel *scc;
 	
-	save_flags(flags); 
-	cli();
-
 	if (Nchips == 0)
 	{
 		unregister_netdev(SCC_Info[0].dev);
 		kfree(SCC_Info[0].dev);
 	}
 
+	/* Guard against chip prattle */
+	local_irq_disable();
+	
 	for (k = 0; k < Nchips; k++)
 		if ( (ctrl = SCC_ctrl[k].chan_A) )
 		{
@@ -2149,6 +2134,13 @@
 			udelay(50);
 		}
 		
+	/* To unload the port must be closed so no real IRQ pending */
+	for (k=0; k < NR_IRQS ; k++)
+		if (Ivec[k].used) free_irq(k, NULL);
+		
+	local_irq_enable();
+		
+	/* Now clean up */
 	for (k = 0; k < Nchips*2; k++)
 	{
 		scc = &SCC_Info[k];
@@ -2164,14 +2156,10 @@
 		}
 	}
 	
-	for (k=0; k < NR_IRQS ; k++)
-		if (Ivec[k].used) free_irq(k, NULL);
 		
 	if (Vector_Latch)
 		release_region(Vector_Latch, 1);
 
-	restore_flags(flags);
-
 	proc_net_remove("z8530drv");
 }
 
