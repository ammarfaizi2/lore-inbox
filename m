Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319519AbSH2Ww6>; Thu, 29 Aug 2002 18:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319521AbSH2WwK>; Thu, 29 Aug 2002 18:52:10 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:7112 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319514AbSH2Wsw>;
	Thu, 29 Aug 2002 18:48:52 -0400
Date: Thu, 29 Aug 2002 15:51:33 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_ali_locking_fixes-3.diff
Message-ID: <20020829225133.GH14118@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir252_ali_locking_fixes-3.diff :
------------------------------
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrDA ali driver


--- linux/drivers/net/irda-d5/ali-ircc.c	Thu Aug 29 12:13:51 2002
+++ linux/drivers/net/irda/ali-ircc.c	Thu Aug 29 13:56:56 2002
@@ -251,6 +251,7 @@ static int ali_ircc_open(int i, chipio_t
 	struct ali_ircc_cb *self;
 	struct pm_dev *pmdev;
 	int dongle_id;
+	int ret;
 	int err;
 			
 	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");	
@@ -530,6 +531,11 @@ static int ali_ircc_setup(chipio_t *info
 	
 	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
 	
+	/* Locking comments :
+	 * Most operations here need to be protected. We are called before
+	 * the device instance is created in ali_ircc_open(), therefore 
+	 * nobody can bother us - Jean II */
+
 	/* Switch to FIR space */
 	SIR2FIR(iobase);
 	
@@ -937,6 +943,9 @@ static void ali_ircc_change_speed(struct
 	
 	IRDA_DEBUG(2, __FUNCTION__ "(), setting speed = %d \n", baud);
 	
+	/* This function *must* be called with irq off and spin-lock.
+	 * - Jean II */
+
 	iobase = self->io.fir_base;
 	
 	SetCOMInterrupts(self, FALSE); // 2000/11/24 11:43AM
@@ -1084,7 +1093,6 @@ static void ali_ircc_change_dongle_speed
 	
 	struct ali_ircc_cb *self = (struct ali_ircc_cb *) priv;
 	int iobase,dongle_id;
-	unsigned long flags;
 	int tmp = 0;
 			
 	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");	
@@ -1092,8 +1100,7 @@ static void ali_ircc_change_dongle_speed
 	iobase = self->io.fir_base; 	/* or iobase = self->io.sir_base; */
 	dongle_id = self->io.dongle_id;
 	
-	save_flags(flags);
-	cli();
+	/* We are already locked, no need to do it again */
 		
 	IRDA_DEBUG(1, __FUNCTION__ "(), Set Speed for %s , Speed = %d\n", dongle_types[dongle_id], speed);		
 	
@@ -1259,8 +1266,6 @@ static void ali_ircc_change_dongle_speed
 			
 	switch_bank(iobase, BANK0);
 	
-	restore_flags(flags);
-		
 	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");		
 }
 
@@ -1440,20 +1445,26 @@ static int ali_ircc_fir_hard_xmit(struct
 
 	netif_stop_queue(dev);
 	
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->lock, flags);
+	
+	/* Note : you should make sure that speed changes are not going
+	 * to corrupt any outgoing frame. Look at nsc-ircc for the gory
+	 * details - Jean II */
+
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			ali_ircc_change_speed(self, speed); 
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-	
 	/* Register and copy this frame to DMA memory */
 	self->tx_fifo.queue[self->tx_fifo.free].start = self->tx_fifo.tail;
 	self->tx_fifo.queue[self->tx_fifo.free].len = skb->len;
@@ -1957,20 +1968,26 @@ static int ali_ircc_sir_hard_xmit(struct
 
 	netif_stop_queue(dev);
 	
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->lock, flags);
+
+	/* Note : you should make sure that speed changes are not going
+	 * to corrupt any outgoing frame. Look at nsc-ircc for the gory
+	 * details - Jean II */
+
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			ali_ircc_change_speed(self, speed); 
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Init tx buffer */
 	self->tx_buff.data = self->tx_buff.head;
 
@@ -2016,10 +2033,6 @@ static int ali_ircc_net_ioctl(struct net
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();	
-	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSBANDWIDTH\n");
@@ -2031,7 +2044,9 @@ static int ali_ircc_net_ioctl(struct net
 		if (!in_interrupt() && !capable(CAP_NET_ADMIN))
 			return -EPERM;
 		
+		spin_lock_irqsave(&self->lock, flags);
 		ali_ircc_change_speed(self, irq->ifr_baudrate);		
+		spin_unlock_irqrestore(&self->lock, flags);
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSMEDIABUSY\n");
@@ -2041,14 +2056,13 @@ static int ali_ircc_net_ioctl(struct net
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		IRDA_DEBUG(2, __FUNCTION__ "(), SIOCGRECEIVING\n");
+		/* This is protected */
 		irq->ifr_receiving = ali_ircc_is_receiving(self);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
 	
-	restore_flags(flags);
-	
 	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
 	
 	return ret;
@@ -2219,19 +2233,16 @@ static void SetCOMInterrupts(struct ali_
 static void SIR2FIR(int iobase)
 {
 	//unsigned char tmp;
-	unsigned long flags;
 		
 	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
 	
-	save_flags(flags);
-	cli();
+	/* Already protected (change_speed() or setup()), no need to lock.
+	 * Jean II */
 	
 	outb(0x28, iobase+UART_MCR);
 	outb(0x68, iobase+UART_MCR);
 	outb(0x88, iobase+UART_MCR);		
 	
-	restore_flags(flags);
-		
 	outb(0x60, iobase+FIR_MCR); 	/*  Master Reset */
 	outb(0x20, iobase+FIR_MCR); 	/*  Master Interrupt Enable */
 	
@@ -2245,12 +2256,11 @@ static void SIR2FIR(int iobase)
 static void FIR2SIR(int iobase)
 {
 	unsigned char val;
-	unsigned long flags;
 	
 	IRDA_DEBUG(1, __FUNCTION__ "(), ---------------- Start ----------------\n");
 	
-	save_flags(flags);
-	cli();
+	/* Already protected (change_speed() or setup()), no need to lock.
+	 * Jean II */
 	
 	outb(0x20, iobase+FIR_MCR); 	/* IRQ to low */
 	outb(0x00, iobase+UART_IER); 	
@@ -2262,8 +2272,6 @@ static void FIR2SIR(int iobase)
 	val = inb(iobase+UART_RX);
 	val = inb(iobase+UART_LSR);
 	val = inb(iobase+UART_MSR);
-	
-	restore_flags(flags);
 	
 	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");
 }
