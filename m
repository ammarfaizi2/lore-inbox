Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319457AbSH3Aw4>; Thu, 29 Aug 2002 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319472AbSH3Awz>; Thu, 29 Aug 2002 20:52:55 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:5369 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319457AbSH3Aww>;
	Thu, 29 Aug 2002 20:52:52 -0400
Date: Thu, 29 Aug 2002 17:55:34 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Re: [PATCH 2.5] : ir252_nsc_speed_both.diff (don't apply ir255_nsc_speed-4.diff)
Message-ID: <20020830005534.GA14430@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020829224900.GD14118@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020829224900.GD14118@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus,

	The subject of this e-mail probably gave it away, but I mixed
up my patches and sent you the *WRONG* patch. Not only it contains a
bug, but it will prevent the subsequent driver patch to apply cleanly.
	Please ignore the patch called ir255_nsc_speed-4.diff (or
revert it if you already applied it), and use this one instead.
	Sorry for the mistake...

	Jean

On Thu, Aug 29, 2002 at 03:49:01PM -0700, jt wrote:
> ir255_nsc_speed-4.diff :
> ----------------------
> 	o [FEATURE] Cleanly change speed back to 9600bps
> 	o [CORRECT] Change speed under spinlock/irq disabled
> 	o [CORRECT] Make sure interrupt handlers don't mess irq mask
> 	o [CORRECT] Don't change speed if we haven't fully finished to Tx

	Correct patch is :

ir252_nsc_speed_both.diff :
-------------------------
	o [FEATURE] Cleanly change speed back to 9600bps
	o [CORRECT] Change speed under spinlock/irq disabled
	o [CORRECT] Make sure interrupt handlers don't mess irq mask
	o [CORRECT] Don't change speed if we haven't fully finished to Tx


diff -u -p linux/drivers/net/irda/nsc-ircc.d3.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d3.c	Fri Aug 23 11:06:10 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Fri Aug 23 11:07:06 2002
@@ -130,7 +130,7 @@ static int  nsc_ircc_hard_xmit_sir(struc
 static int  nsc_ircc_hard_xmit_fir(struct sk_buff *skb, struct net_device *dev);
 static int  nsc_ircc_pio_write(int iobase, __u8 *buf, int len, int fifo_size);
 static void nsc_ircc_dma_xmit(struct nsc_ircc_cb *self, int iobase);
-static void nsc_ircc_change_speed(struct nsc_ircc_cb *self, __u32 baud);
+static __u8 nsc_ircc_change_speed(struct nsc_ircc_cb *self, __u32 baud);
 static void nsc_ircc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static int  nsc_ircc_is_receiving(struct nsc_ircc_cb *self);
 static int  nsc_ircc_read_dongle_id (int iobase);
@@ -953,17 +953,19 @@ static void nsc_ircc_change_dongle_speed
  *
  *    Change the speed of the device
  *
+ * This function *must* be called with irq off and spin-lock.
  */
-static void nsc_ircc_change_speed(struct nsc_ircc_cb *self, __u32 speed)
+static __u8 nsc_ircc_change_speed(struct nsc_ircc_cb *self, __u32 speed)
 {
 	struct net_device *dev = self->netdev;
 	__u8 mcr = MCR_SIR;
 	int iobase; 
 	__u8 bank;
+	__u8 ier;                  /* Interrupt enable register */
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d\n", speed);
 
-	ASSERT(self != NULL, return;);
+	ASSERT(self != NULL, return 0;);
 
 	iobase = self->io.fir_base;
 
@@ -1038,18 +1040,21 @@ static void nsc_ircc_change_speed(struct
 	if (speed > 115200) {
 		/* Install FIR xmit handler */
 		dev->hard_start_xmit = nsc_ircc_hard_xmit_fir;
-		outb(IER_SFIF_IE, iobase+IER);
+		ier = IER_SFIF_IE;
 		nsc_ircc_dma_receive(self);
 	} else {
 		/* Install SIR xmit handler */
 		dev->hard_start_xmit = nsc_ircc_hard_xmit_sir;
-		outb(IER_RXHDL_IE, iobase+IER);
+		ier = IER_RXHDL_IE;
 	}
+	/* Set our current interrupt mask */
+	outb(ier, iobase+IER);
     	
 	/* Restore BSR */
 	outb(bank, iobase+BSR);
-	netif_wake_queue(dev);
-	
+
+	/* Make sure interrupt handlers keep the proper interrupt mask */
+	return(ier);
 }
 
 /*
@@ -1074,20 +1079,36 @@ static int nsc_ircc_hard_xmit_sir(struct
 
 	netif_stop_queue(dev);
 		
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->lock, flags);
+	
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
-		/* Check for empty frame */
+		/* Check for empty frame. */
 		if (!skb->len) {
-			nsc_ircc_change_speed(self, speed); 
+			/* If we just sent a frame, we get called before
+			 * the last bytes get out (because of the SIR FIFO).
+			 * If this is the case, let interrupt handler change
+			 * the speed itself... Jean II */
+			if (self->io.direction == IO_RECV) {
+				nsc_ircc_change_speed(self, speed); 
+				/* TODO : For SIR->SIR, the next packet
+				 * may get corrupted - Jean II */
+				netif_wake_queue(dev);
+			} else {
+				self->new_speed = speed;
+				/* Queue will be restarted after speed change
+				 * to make sure packets gets through the
+				 * proper xmit handler - Jean II */
+			}
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-	
 	/* Save current bank */
 	bank = inb(iobase+BSR);
 	
@@ -1126,20 +1147,38 @@ static int nsc_ircc_hard_xmit_fir(struct
 
 	netif_stop_queue(dev);
 	
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
-		/* Check for empty frame */
+		/* Check for empty frame. */
 		if (!skb->len) {
-			nsc_ircc_change_speed(self, speed); 
+			/* If we are currently transmitting, defer to
+			 * interrupt handler. - Jean II */
+			if(self->tx_fifo.len == 0) {
+				nsc_ircc_change_speed(self, speed); 
+				netif_wake_queue(dev);
+			} else {
+				self->new_speed = speed;
+				/* Keep queue stopped :
+				 * the speed change operation may change the
+				 * xmit handler, and we want to make sure
+				 * the next packet get through the proper
+				 * Tx path, so block the Tx queue until
+				 * the speed change has been done.
+				 * Jean II */
+			}
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
-		} else
+		} else {
+			/* Change speed after current frame */
 			self->new_speed = speed;
+		}
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Save current bank */
 	bank = inb(iobase+BSR);
 
@@ -1209,8 +1248,9 @@ static int nsc_ircc_hard_xmit_fir(struct
 		nsc_ircc_dma_xmit(self, iobase);
 	}
  out:
-	/* Not busy transmitting anymore if window is not full */
-	if (self->tx_fifo.free < MAX_TX_WINDOW)
+	/* Not busy transmitting anymore if window is not full,
+	 * and if we don't need to change speed */
+	if ((self->tx_fifo.free < MAX_TX_WINDOW) && (self->new_speed == 0))
 		netif_wake_queue(self->netdev);
 
 	/* Restore bank register */
@@ -1334,12 +1374,6 @@ static int nsc_ircc_dma_xmit_complete(st
 		self->stats.tx_packets++;
 	}
 
-	/* Check if we need to change the speed */
-	if (self->new_speed) {
-		nsc_ircc_change_speed(self, self->new_speed);
-		self->new_speed = 0;
-	}
-
 	/* Finished with this frame, so prepare for next */
 	self->tx_fifo.ptr++;
 	self->tx_fifo.len--;
@@ -1356,8 +1390,9 @@ static int nsc_ircc_dma_xmit_complete(st
 		self->tx_fifo.tail = self->tx_buff.head;
 	}
 
-	/* Make sure we have room for more frames */
-	if (self->tx_fifo.free < MAX_TX_WINDOW) {
+	/* Make sure we have room for more frames and
+	 * that we don't need to change speed */
+	if ((self->tx_fifo.free < MAX_TX_WINDOW) && (self->new_speed == 0)) {
 		/* Not busy transmitting anymore */
 		/* Tell the network layer, that we can accept more frames */
 		netif_wake_queue(self->netdev);
@@ -1634,24 +1669,25 @@ static void nsc_ircc_sir_interrupt(struc
 	}
 	/* Check if transmission has completed */
 	if (eir & EIR_TXEMP_EV) {
-		/* Check if we need to change the speed? */
+		/* Turn around and get ready to receive some data */
+		self->io.direction = IO_RECV;
+		self->ier = IER_RXHDL_IE;
+		/* Check if we need to change the speed?
+		 * Need to be after self->io.direction to avoid race with
+		 * nsc_ircc_hard_xmit_sir() - Jean II */
 		if (self->new_speed) {
 			IRDA_DEBUG(2, __FUNCTION__ "(), Changing speed!\n");
-			nsc_ircc_change_speed(self, self->new_speed);
+			self->ier = nsc_ircc_change_speed(self,
+							  self->new_speed);
 			self->new_speed = 0;
+			netif_wake_queue(self->netdev);
 
 			/* Check if we are going to FIR */
 			if (self->io.speed > 115200) {
-				/* Should wait for status FIFO interrupt */
-				self->ier = IER_SFIF_IE;
-
 				/* No need to do anymore SIR stuff */
 				return;
 			}
 		}
-		/* Turn around and get ready to receive some data */
-		self->io.direction = IO_RECV;
-		self->ier = IER_RXHDL_IE;
 	}
 
 	/* Rx FIFO threshold or timeout */
@@ -1710,19 +1746,36 @@ static void nsc_ircc_fir_interrupt(struc
 		}
 	} else if (eir & EIR_DMA_EV) {
 		/* Finished with all transmissions? */
-		if (nsc_ircc_dma_xmit_complete(self)) {		
-			/* Check if there are more frames to be transmitted */
-			if (irda_device_txqueue_empty(self->netdev)) {
-				/* Prepare for receive */
-				nsc_ircc_dma_receive(self);
-			
-				self->ier = IER_SFIF_IE;
+		if (nsc_ircc_dma_xmit_complete(self)) {
+			if(self->new_speed != 0) {
+				/* As we stop the Tx queue, the speed change
+				 * need to be done when the Tx fifo is
+				 * empty. Ask for a Tx done interrupt */
+				self->ier = IER_TXEMP_IE;
+			} else {
+				/* Check if there are more frames to be
+				 * transmitted */
+				if (irda_device_txqueue_empty(self->netdev)) {
+					/* Prepare for receive */
+					nsc_ircc_dma_receive(self);
+					self->ier = IER_SFIF_IE;
+				} else
+					WARNING(__FUNCTION__ "(), potential "
+						"Tx queue lockup !\n");
 			}
 		} else {
 			/*  Not finished yet, so interrupt on DMA again */
 			self->ier = IER_DMA_IE;
 		}
+	} else if (eir & EIR_TXEMP_EV) {
+		/* The Tx FIFO has totally drained out, so now we can change
+		 * the speed... - Jean II */
+		self->ier = nsc_ircc_change_speed(self, self->new_speed);
+		self->new_speed = 0;
+		netif_wake_queue(self->netdev);
+		/* Note : nsc_ircc_change_speed() restarted Rx fifo */
 	}
+
 	outb(bank, iobase+BSR);
 }
 
