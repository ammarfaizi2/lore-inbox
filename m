Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTEMWNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTEMWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:13:08 -0400
Received: from palrel13.hp.com ([156.153.255.238]:10183 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263643AbTEMWLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:11:05 -0400
Date: Tue, 13 May 2003 15:23:46 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] irport fixes
Message-ID: <20030513222346.GG2634@bougret.hpl.hp.com>
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

ir259_irport-6.diff :
	o [CORRECT] fix module ownership in irport
	o [CORRECT] Properly initialise dev->trans_start in irport
	o [CORRECT] Add delay to drain the Tx fifo to avoid corrupting
		last outgoing Tx byte when changing speed
	o [FEATURE] Safer locking around speed change in irport_hard_xmit()
	o [FEATURE] Enforce half duplex operation in interrupt handler
	o [FEATURE] Optimise interrupt handler for latency and I/O ops
	o [FEATURE] Optimise Tx path in irport_write()
	o [FEATURE] Add ZeroCopy Rx
	o [FEATURE] Better debugging in watchdog timeout
	o [FEATURE] Various other cleanups and comments


diff -u -p linux/include/net/irda/irport.d0.h linux/include/net/irda/irport.h
--- linux/include/net/irda/irport.d0.h	Mon May 12 18:12:18 2003
+++ linux/include/net/irda/irport.h	Mon May 12 18:17:06 2003
@@ -67,6 +67,7 @@ struct irport_cb {
 	__u32 new_speed;
 	int mode;
 	int index;                 /* Instance index */
+	int transmitting;	   /* Are we transmitting ? */
 
 	spinlock_t lock;           /* For serializing operations */
 
diff -u -p linux/drivers/net/irda/irport.d0.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda/irport.d0.c	Mon May 12 18:03:50 2003
+++ linux/drivers/net/irda/irport.c	Tue May 13 13:07:43 2003
@@ -11,6 +11,7 @@
  * Sources:	  serial.c by Linus Torvalds 
  * 
  *     Copyright (c) 1997, 1998, 1999-2000 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2003 Jean Tourrilhes, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -48,6 +49,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 #include <linux/rtnetlink.h>
 
 #include <asm/system.h>
@@ -72,14 +74,14 @@ static unsigned int qos_mtt_bits = 0x03;
 static struct irport_cb *dev_self[] = { NULL, NULL, NULL, NULL};
 static char *driver_name = "irport";
 
-static void irport_write_wakeup(struct irport_cb *self);
-static int  irport_write(int iobase, int fifo_size, __u8 *buf, int len);
-static void irport_receive(struct irport_cb *self);
+static inline void irport_write_wakeup(struct irport_cb *self);
+static inline int  irport_write(int iobase, int fifo_size, __u8 *buf, int len);
+static inline void irport_receive(struct irport_cb *self);
 
 static int  irport_net_init(struct net_device *dev);
 static int  irport_net_ioctl(struct net_device *dev, struct ifreq *rq, 
 			     int cmd);
-static int  irport_is_receiving(struct irport_cb *self);
+static inline int  irport_is_receiving(struct irport_cb *self);
 static int  irport_set_dtr_rts(struct net_device *dev, int dtr, int rts);
 static int  irport_raw_write(struct net_device *dev, __u8 *buf, int len);
 static struct net_device_stats *irport_net_get_stats(struct net_device *dev);
@@ -169,7 +171,7 @@ irport_open(int i, unsigned int iobase, 
 	self->io.sir_base  = iobase;
         self->io.sir_ext   = IO_EXTENT;
         self->io.irq       = irq;
-        self->io.fifo_size = 16;
+        self->io.fifo_size = 16;		/* 16550A and compatible */
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
@@ -181,39 +183,47 @@ irport_open(int i, unsigned int iobase, 
 	irda_qos_bits_to_value(&self->qos);
 	
 	self->flags = IFF_SIR|IFF_PIO;
+	self->mode = IRDA_IRLAP;
+
+	/* Bootstrap ZeroCopy Rx */
+	self->rx_buff.truesize = IRDA_SKB_MAX_MTU;
+	self->rx_buff.skb = __dev_alloc_skb(self->rx_buff.truesize,
+					    GFP_KERNEL);
+	if (self->rx_buff.skb == NULL)
+		return NULL;
+	skb_reserve(self->rx_buff.skb, 1);
+	self->rx_buff.head = self->rx_buff.skb->data;
+	/* No need to memset the buffer, unless you are really pedantic */
+
+	/* Finish setup the Rx buffer descriptor */
+	self->rx_buff.in_frame = FALSE;
+	self->rx_buff.state = OUTSIDE_FRAME;
+	self->rx_buff.data = self->rx_buff.head;
 
 	/* Specify how much memory we want */
-	self->rx_buff.truesize = 4000; 
 	self->tx_buff.truesize = 4000;
 	
 	/* Allocate memory if needed */
-	if (self->rx_buff.truesize > 0) {
-		self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
-						      GFP_KERNEL);
-		if (self->rx_buff.head == NULL)
-			return NULL;
-		memset(self->rx_buff.head, 0, self->rx_buff.truesize);
-	}
 	if (self->tx_buff.truesize > 0) {
 		self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
 						      GFP_KERNEL);
 		if (self->tx_buff.head == NULL) {
-			kfree(self->rx_buff.head);
+			kfree_skb(self->rx_buff.skb);
+			self->rx_buff.skb = NULL;
+			self->rx_buff.head = NULL;
 			return NULL;
 		}
 		memset(self->tx_buff.head, 0, self->tx_buff.truesize);
 	}	
-	self->rx_buff.in_frame = FALSE;
-	self->rx_buff.state = OUTSIDE_FRAME;
 	self->tx_buff.data = self->tx_buff.head;
-	self->rx_buff.data = self->rx_buff.head;
-	self->mode = IRDA_IRLAP;
 
 	if (!(dev = dev_alloc("irda%d", &err))) {
 		ERROR("%s(), dev_alloc() failed!\n", __FUNCTION__);
 		return NULL;
 	}
 	self->netdev = dev;
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(dev);
 
 	/* May be overridden by piggyback drivers */
  	dev->priv = (void *) self;
@@ -241,7 +251,8 @@ irport_open(int i, unsigned int iobase, 
 		ERROR("%s(), register_netdev() failed!\n", __FUNCTION__);
 		return NULL;
 	}
-	MESSAGE("IrDA: Registered device %s\n", dev->name);
+	MESSAGE("IrDA: Registered device %s (irport io=0x%X irq=%d)\n",
+		dev->name, iobase, irq);
 
 	return self;
 }
@@ -270,8 +281,9 @@ int irport_close(struct irport_cb *self)
 	if (self->tx_buff.head)
 		kfree(self->tx_buff.head);
 	
-	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+	if (self->rx_buff.skb)
+		kfree_skb(self->rx_buff.skb);
+	self->rx_buff.skb = NULL;
 	
 	/* Remove ourselves */
 	dev_self[self->index] = NULL;
@@ -306,6 +318,9 @@ void irport_stop(struct irport_cb *self)
 
 	/* We can't lock, we may be called from a FIR driver - Jean II */
 
+	/* We are not transmitting any more */
+	self->transmitting = 0;
+
 	/* Reset UART */
 	outb(0, iobase+UART_MCR);
 	
@@ -327,6 +342,33 @@ int irport_probe(int iobase)
 }
 
 /*
+ * Function irport_get_fcr (speed)
+ *
+ *    Compute value of fcr
+ *
+ */
+static inline unsigned int irport_get_fcr(__u32 speed)
+{
+	unsigned int fcr;    /* FIFO control reg */
+
+	/* Enable fifos */
+	fcr = UART_FCR_ENABLE_FIFO;
+
+	/* 
+	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
+	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
+	 * about this timeout since it will always be fast enough. 
+	 */
+	if (speed < 38400)
+		fcr |= UART_FCR_TRIGGER_1;
+	else 
+		//fcr |= UART_FCR_TRIGGER_14;
+		fcr |= UART_FCR_TRIGGER_8;
+
+	return(fcr);
+}
+ 
+/*
  * Function irport_change_speed (self, speed)
  *
  *    Set speed of IrDA port to specified baudrate
@@ -337,11 +379,12 @@ void irport_change_speed(void *priv, __u
 {
 	struct irport_cb *self = (struct irport_cb *) priv;
 	int iobase; 
-	int fcr;    /* FIFO control reg */
-	int lcr;    /* Line control reg */
+	unsigned int fcr;    /* FIFO control reg */
+	unsigned int lcr;    /* Line control reg */
 	int divisor;
 
 	ASSERT(self != NULL, return;);
+	ASSERT(speed != 0, return;);
 
 	IRDA_DEBUG(1, "%s(), Setting speed to: %d - iobase=%#x\n",
 		    __FUNCTION__, speed, self->io.sir_base);
@@ -358,18 +401,9 @@ void irport_change_speed(void *priv, __u
 
 	divisor = SPEED_MAX/speed;
 	
-	fcr = UART_FCR_ENABLE_FIFO;
+	/* Get proper fifo configuration */
+	fcr = irport_get_fcr(speed);
 
-	/* 
-	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
-	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
-	 * about this timeout since it will always be fast enough. 
-	 */
-	if (self->io.speed < 38400)
-		fcr |= UART_FCR_TRIGGER_1;
-	else 
-		fcr |= UART_FCR_TRIGGER_14;
-        
 	/* IrDA ports use 8N1 */
 	lcr = UART_LCR_WLEN8;
 	
@@ -380,7 +414,7 @@ void irport_change_speed(void *priv, __u
 	outb(fcr,		  iobase+UART_FCR); /* Enable FIFO's */
 
 	/* Turn on interrups */
-	/* This will generate a fata interrupt storm.
+	/* This will generate a fatal interrupt storm.
 	 * People calling us will do that properly - Jean II */
 	//outb(/*UART_IER_RLSI|*/UART_IER_RDI/*|UART_IER_THRI*/, iobase+UART_IER);
 }
@@ -467,8 +501,8 @@ int __irport_change_speed(struct irda_ta
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		ret = -1;
 		break;
-	}	
-	/* Put stuff in the sate we found them - Jean II */
+	}
+	/* Put stuff in the state we found them - Jean II */
 	if(wasunlocked) {
 		spin_unlock_irqrestore(&self->lock, flags);
 	}
@@ -477,98 +511,6 @@ int __irport_change_speed(struct irda_ta
 }
 
 /*
- * Function irport_write_wakeup (tty)
- *
- *    Called by the driver when there's room for more data.  If we have
- *    more packets to send, we send them here.
- *
- */
-static void irport_write_wakeup(struct irport_cb *self)
-{
-	int actual = 0;
-	int iobase;
-	int fcr;
-
-	ASSERT(self != NULL, return;);
-
-	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
-
-	iobase = self->io.sir_base;
-
-	/* Finished with frame?  */
-	if (self->tx_buff.len > 0)  {
-		/* Write data left in transmit buffer */
-		actual = irport_write(iobase, self->io.fifo_size, 
-				      self->tx_buff.data, self->tx_buff.len);
-		self->tx_buff.data += actual;
-		self->tx_buff.len  -= actual;
-
-		/* Turn on transmit finished interrupt. */
-		outb(UART_IER_THRI, iobase+UART_IER); 
-	} else {
-		/* 
-		 *  Now serial buffer is almost free & we can start 
-		 *  transmission of another packet. But first we must check
-		 *  if we need to change the speed of the hardware
-		 */
-		if (self->new_speed) {
-			IRDA_DEBUG(5, "%s(), Changing speed!\n", __FUNCTION__);
-			irda_task_execute(self, __irport_change_speed, 
-					  irport_change_speed_complete, 
-					  NULL, (void *) self->new_speed);
-			self->new_speed = 0;
-			IRDA_DEBUG(5, "%s(), Speed changed!\n", __FUNCTION__ );
-		} else {
-			/* Tell network layer that we want more frames */
-			netif_wake_queue(self->netdev);
-		}
-		self->stats.tx_packets++;
-
-		/* 
-		 * Reset Rx FIFO to make sure that all reflected transmit data
-		 * is discarded. This is needed for half duplex operation
-		 */
-		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR;
-		if (self->io.speed < 38400)
-			fcr |= UART_FCR_TRIGGER_1;
-		else 
-			fcr |= UART_FCR_TRIGGER_14;
-
-		outb(fcr, iobase+UART_FCR);
-
-		/* Turn on receive interrupts */
-		outb(UART_IER_RDI, iobase+UART_IER);
-	}
-}
-
-/*
- * Function irport_write (driver)
- *
- *    Fill Tx FIFO with transmit data
- *
- */
-static int irport_write(int iobase, int fifo_size, __u8 *buf, int len)
-{
-	int actual = 0;
-
-	/* Tx FIFO should be empty! */
-	if (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG(0, "%s(), failed, fifo not empty!\n", __FUNCTION__);
-		return 0;
-	}
-        
-	/* Fill FIFO with current frame */
-	while ((fifo_size-- > 0) && (actual < len)) {
-		/* Transmit next byte */
-		outb(buf[actual], iobase+UART_TX);
-
-		actual++;
-	}
-        
-	return actual;
-}
-
-/*
  * Function irport_change_speed_complete (task)
  *
  *    Called when the change speed operation completes
@@ -604,24 +546,80 @@ static void irport_timeout(struct net_de
 {
 	struct irport_cb *self;
 	int iobase;
+	int iir, lsr;
 	unsigned long flags;
 
 	self = (struct irport_cb *) dev->priv;
+	ASSERT(self != NULL, return;);
 	iobase = self->io.sir_base;
 	
-	WARNING("%s: transmit timed out\n", dev->name);
+	WARNING("%s: transmit timed out, jiffies = %ld, trans_start = %ld\n",
+		dev->name, jiffies, dev->trans_start);
 	spin_lock_irqsave(&self->lock, flags);
+
+	/* Debug what's happening... */
+
+	/* Get interrupt status */
+	lsr = inb(iobase+UART_LSR);
+	/* Read interrupt register */
+	iir = inb(iobase+UART_IIR);
+	IRDA_DEBUG(0, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n", 
+		   __FUNCTION__, iir, lsr, iobase);
+
+	IRDA_DEBUG(0, "%s(), transmitting=%d, remain=%d, done=%d\n", 
+		   __FUNCTION__, self->transmitting, self->tx_buff.len,
+		   self->tx_buff.data - self->tx_buff.head);
+
+	/* Now, restart the port */
 	irport_start(self);
 	self->change_speed(self->priv, self->io.speed);
 	/* This will re-enable irqs */
 	outb(/*UART_IER_RLSI|*/UART_IER_RDI/*|UART_IER_THRI*/, iobase+UART_IER);
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 
-	dev->trans_start = jiffies;
 	netif_wake_queue(dev);
 }
  
 /*
+ * Function irport_wait_hw_transmitter_finish ()
+ *
+ *    Wait for the real end of HW transmission
+ *
+ * The UART is a strict FIFO, and we get called only when we have finished
+ * pushing data to the FIFO, so the maximum amount of time we must wait
+ * is only for the FIFO to drain out.
+ *
+ * We use a simple calibrated loop. We may need to adjust the loop
+ * delay (udelay) to balance I/O traffic and latency. And we also need to
+ * adjust the maximum timeout.
+ * It would probably be better to wait for the proper interrupt,
+ * but it doesn't seem to be available.
+ *
+ * We can't use jiffies or kernel timers because :
+ * 1) We are called from the interrupt handler, which disable softirqs,
+ * so jiffies won't be increased
+ * 2) Jiffies granularity is usually very coarse (10ms), and we don't
+ * want to wait that long to detect stuck hardware.
+ * Jean II
+ */
+
+static void irport_wait_hw_transmitter_finish(struct irport_cb *self)
+{
+	int iobase;
+	int count = 1000;	/* 1 ms */
+	
+	iobase = self->io.sir_base;
+
+	/* Calibrated busy loop */
+	while((count-- > 0) && !(inb(iobase+UART_LSR) & UART_LSR_TEMT))
+		udelay(1);
+
+	if(count == 0)
+		IRDA_DEBUG(0, "%s(): stuck transmitter\n", __FUNCTION__);
+}
+
+/*
  * Function irport_hard_start_xmit (struct sk_buff *skb, struct net_device *dev)
  *
  *    Transmits the current frame until FIFO is full, then
@@ -645,8 +643,8 @@ int irport_hard_xmit(struct sk_buff *skb
 	iobase = self->io.sir_base;
 
 	netif_stop_queue(dev);
-	
-	/* Make sure tests *& speed change are atomic */
+
+	/* Make sure tests & speed change are atomic */
 	spin_lock_irqsave(&self->lock, flags);
 
 	/* Check if we need to change the speed */
@@ -654,10 +652,21 @@ int irport_hard_xmit(struct sk_buff *skb
 	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
+			/*
+			 * We send frames one by one in SIR mode (no
+			 * pipelining), so at this point, if we were sending
+			 * a previous frame, we just received the interrupt
+			 * telling us it is finished (UART_IIR_THRI).
+			 * Therefore, waiting for the transmitter to really
+			 * finish draining the fifo won't take too long.
+			 * And the interrupt handler is not expected to run.
+			 * - Jean II */
+			irport_wait_hw_transmitter_finish(self);
 			/* Better go there already locked - Jean II */
 			irda_task_execute(self, __irport_change_speed, 
 					  irport_change_speed_complete, 
 					  NULL, (void *) speed);
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -674,9 +683,13 @@ int irport_hard_xmit(struct sk_buff *skb
 	
 	self->stats.tx_bytes += self->tx_buff.len;
 
+	/* We are transmitting */
+	self->transmitting = 1;
+
 	/* Turn on transmit finished interrupt. Will fire immediately!  */
 	outb(UART_IER_THRI, iobase+UART_IER); 
 
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 
 	dev_kfree_skb(skb);
@@ -685,12 +698,100 @@ int irport_hard_xmit(struct sk_buff *skb
 }
         
 /*
+ * Function irport_write (driver)
+ *
+ *    Fill Tx FIFO with transmit data
+ *
+ * Called only from irport_write_wakeup()
+ */
+static inline int irport_write(int iobase, int fifo_size, __u8 *buf, int len)
+{
+	int actual = 0;
+
+	/* Fill FIFO with current frame */
+	while ((actual < fifo_size) && (actual < len)) {
+		/* Transmit next byte */
+		outb(buf[actual], iobase+UART_TX);
+
+		actual++;
+	}
+        
+	return actual;
+}
+
+/*
+ * Function irport_write_wakeup (tty)
+ *
+ *    Called by the driver when there's room for more data.  If we have
+ *    more packets to send, we send them here.
+ *
+ * Called only from irport_interrupt()
+ * Make sure this function is *not* called while we are receiving,
+ * otherwise we will reset fifo and loose data :-(
+ */
+static inline void irport_write_wakeup(struct irport_cb *self)
+{
+	int actual = 0;
+	int iobase;
+	unsigned int fcr;
+
+	ASSERT(self != NULL, return;);
+
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
+
+	iobase = self->io.sir_base;
+
+	/* Finished with frame?  */
+	if (self->tx_buff.len > 0)  {
+		/* Write data left in transmit buffer */
+		actual = irport_write(iobase, self->io.fifo_size, 
+				      self->tx_buff.data, self->tx_buff.len);
+		self->tx_buff.data += actual;
+		self->tx_buff.len  -= actual;
+	} else {
+		/* 
+		 *  Now serial buffer is almost free & we can start 
+		 *  transmission of another packet. But first we must check
+		 *  if we need to change the speed of the hardware
+		 */
+		if (self->new_speed) {
+			irport_wait_hw_transmitter_finish(self);
+			irda_task_execute(self, __irport_change_speed, 
+					  irport_change_speed_complete, 
+					  NULL, (void *) self->new_speed);
+			self->new_speed = 0;
+		} else {
+			/* Tell network layer that we want more frames */
+			netif_wake_queue(self->netdev);
+		}
+		self->stats.tx_packets++;
+
+		/* 
+		 * Reset Rx FIFO to make sure that all reflected transmit data
+		 * is discarded. This is needed for half duplex operation
+		 */
+		fcr = irport_get_fcr(self->io.speed);
+		fcr |= UART_FCR_CLEAR_RCVR;
+		outb(fcr, iobase+UART_FCR);
+
+		/* Finished transmitting */
+		self->transmitting = 0;
+
+		/* Turn on receive interrupts */
+		outb(UART_IER_RDI, iobase+UART_IER);
+
+		IRDA_DEBUG(1, "%s() : finished Tx\n", __FUNCTION__);
+	}
+}
+
+/*
  * Function irport_receive (self)
  *
  *    Receive one frame from the infrared port
  *
+ * Called only from irport_interrupt()
  */
-static void irport_receive(struct irport_cb *self) 
+static inline void irport_receive(struct irport_cb *self) 
 {
 	int boguscount = 0;
 	int iobase;
@@ -739,40 +840,51 @@ irqreturn_t irport_interrupt(int irq, vo
 
 	iobase = self->io.sir_base;
 
-	iir = inb(iobase+UART_IIR) & UART_IIR_ID;
-	while (iir) {
-		handled = 1;
+	/* Cut'n'paste interrupt routine from serial.c
+	 * This version try to minimise latency and I/O operations.
+	 * Simplified and modified to enforce half duplex operation.
+	 * - Jean II */
 
-		/* Clear interrupt */
+	/* Check status even is iir reg is cleared, more robust and
+	 * eliminate a read on the I/O bus - Jean II */
+	do {
+		/* Get interrupt status ; Clear interrupt */
 		lsr = inb(iobase+UART_LSR);
-
-		IRDA_DEBUG(4, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n", 
-			   __FUNCTION__, iir, lsr, iobase);
-
-		switch (iir) {
-		case UART_IIR_RLSI:
-			IRDA_DEBUG(2, "%s(), RLSI\n", __FUNCTION__);
-			break;
-		case UART_IIR_RDI:
-			/* Receive interrupt */
-			irport_receive(self);
-			break;
-		case UART_IIR_THRI:
-			if (lsr & UART_LSR_THRE)
-				/* Transmitter ready for data */
-				irport_write_wakeup(self);
-			break;
-		default:
-			IRDA_DEBUG(0, "%s(), unhandled IIR=%#x\n", __FUNCTION__, iir);
-			break;
-		} 
 		
-		/* Make sure we don't stay here too long */
-		if (boguscount++ > 100)
+		/* Are we receiving or transmitting ? */
+		if(!self->transmitting) {
+			/* Received something ? */
+			if (lsr & UART_LSR_DR)
+				irport_receive(self);
+		} else {
+			/* Room in Tx fifo ? */
+			if (lsr & (UART_LSR_THRE | UART_LSR_TEMT))
+				irport_write_wakeup(self);
+		}
+
+		/* A bit hackish, but working as expected... Jean II */
+		if(lsr & (UART_LSR_THRE | UART_LSR_TEMT | UART_LSR_DR))
+			handled = 1;
+
+		/* Make sure we don't stay here to long */
+		if (boguscount++ > 10) {
+			WARNING("%s() irq handler looping : lsr=%02x\n",
+				__FUNCTION__, lsr);
 			break;
+		}
+
+		/* Read interrupt register */
+ 	        iir = inb(iobase+UART_IIR);
+
+		/* Enable this debug only when no other options and at low
+		 * bit rates, otherwise it may cause Rx overruns (lsr=63).
+		 * - Jean II */
+		IRDA_DEBUG(6, "%s(), iir=%02x, lsr=%02x, iobase=%#x\n", 
+			    __FUNCTION__, iir, lsr, iobase);
+
+		/* As long as interrupt pending... */
+	} while ((iir & UART_IIR_NO_INT) == 0);
 
- 	        iir = inb(iobase + UART_IIR) & UART_IIR_ID;
-	}
 	spin_unlock(&self->lock);
 	return IRQ_RETVAL(handled);
 }
@@ -800,8 +912,8 @@ int irport_net_open(struct net_device *d
 	char hwname[16];
 	unsigned long flags;
 
-	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
-	
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
 	ASSERT(dev != NULL, return -1;);
 	self = (struct irport_cb *) dev->priv;
 
@@ -815,7 +927,12 @@ int irport_net_open(struct net_device *d
 	}
 
 	spin_lock_irqsave(&self->lock, flags);
+	/* Init uart */
 	irport_start(self);
+	/* Set 9600 bauds per default, including at the dongle */
+	irda_task_execute(self, __irport_change_speed, 
+			  irport_change_speed_complete, 
+			  NULL, (void *) 9600);
 	spin_unlock_irqrestore(&self->lock, flags);
 
 
@@ -828,12 +945,9 @@ int irport_net_open(struct net_device *d
 	 */
 	self->irlap = irlap_open(dev, &self->qos, hwname);
 
-	/* FIXME: change speed of dongle */
 	/* Ready to play! */
 
 	netif_start_queue(dev);
-	
-	MOD_INC_USE_COUNT;
 
 	return 0;
 }
@@ -873,40 +987,16 @@ int irport_net_close(struct net_device *
 
 	free_irq(self->io.irq, dev);
 
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
 /*
- * Function irport_wait_until_sent (self)
- *
- *    Delay exectution until finished transmitting
- *
- */
-#if 0
-void irport_wait_until_sent(struct irport_cb *self)
-{
-	int iobase;
-
-	iobase = self->io.sir_base;
-
-	/* Wait until Tx FIFO is empty */
-	while (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
-		IRDA_DEBUG(2, "%s(), waiting!\n", __FUNCTION__);
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(MSECS_TO_JIFFIES(60));
-	}
-}
-#endif
-
-/*
  * Function irport_is_receiving (self)
  *
  *    Returns true is we are currently receiving data
  *
  */
-static int irport_is_receiving(struct irport_cb *self)
+static inline int irport_is_receiving(struct irport_cb *self)
 {
 	return (self->rx_buff.state != OUTSIDE_FRAME);
 }
@@ -997,6 +1087,12 @@ static int irport_net_ioctl(struct net_d
 			ret = -EPERM;
 			break;
 		}
+
+		/* Locking :
+		 * irda_device_dongle_init() can't be locked.
+		 * irda_task_execute() doesn't need to be locked.
+		 * Jean II
+		 */
 
 		/* Initialize dongle */
 		dongle = irda_device_dongle_init(dev, irq->ifr_dongle);
