Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319504AbSH2WuQ>; Thu, 29 Aug 2002 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319507AbSH2WuP>; Thu, 29 Aug 2002 18:50:15 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:6084 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319504AbSH2WqT>;
	Thu, 29 Aug 2002 18:46:19 -0400
Date: Thu, 29 Aug 2002 15:49:01 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir255_nsc_speed-4.diff
Message-ID: <20020829224900.GD14118@bougret.hpl.hp.com>
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

ir255_nsc_speed-4.diff :
----------------------
	o [FEATURE] Cleanly change speed back to 9600bps
	o [CORRECT] Change speed under spinlock/irq disabled
	o [CORRECT] Make sure interrupt handlers don't mess irq mask
	o [CORRECT] Don't change speed if we haven't fully finished to Tx


diff -u -p linux/include/net/irda/nsc-ircc.d2.h linux/include/net/irda/nsc-ircc.h
--- linux/include/net/irda/nsc-ircc.d2.h	Mon Jul 15 16:13:58 2002
+++ linux/include/net/irda/nsc-ircc.h	Mon Jul 15 16:18:55 2002
@@ -253,6 +253,7 @@ struct nsc_ircc_cb {
 	
 	__u32 flags;               /* Interface flags */
 	__u32 new_speed;
+	int speed_cnt;		   /* Number of frames before speed change */
 	int index;                 /* Instance index */
 
         struct pm_dev *dev;
diff -u -p linux/drivers/net/irda/nsc-ircc.d2.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d2.c	Mon Jul 15 15:42:50 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Tue Jul 16 10:43:37 2002
@@ -953,6 +953,7 @@ static void nsc_ircc_change_dongle_speed
  *
  *    Change the speed of the device
  *
+ * This function *must* be called with irq off and spin-lock.
  */
 static void nsc_ircc_change_speed(struct nsc_ircc_cb *self, __u32 speed)
 {
@@ -1048,7 +1049,6 @@ static void nsc_ircc_change_speed(struct
     	
 	/* Restore BSR */
 	outb(bank, iobase+BSR);
-	netif_wake_queue(dev);
 	
 }
 
@@ -1074,20 +1074,30 @@ static int nsc_ircc_hard_xmit_sir(struct
 
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
+			if (self->io.direction == IO_RECV)
+				nsc_ircc_change_speed(self, speed); 
+			else
+				self->new_speed = speed;
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
+			netif_wake_queue(dev);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-	
 	/* Save current bank */
 	bank = inb(iobase+BSR);
 	
@@ -1126,20 +1136,34 @@ static int nsc_ircc_hard_xmit_fir(struct
 
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
+			if(self->tx_fifo.len == 0)
+				nsc_ircc_change_speed(self, speed); 
+			else {
+				self->new_speed = speed;
+				self->speed_cnt = self->tx_fifo.len;
+			}
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
+			netif_wake_queue(dev);
 			return 0;
-		} else
+		} else {
 			self->new_speed = speed;
+			/* Save the number of frames currently in the fifo
+			 * so that we know *when* to change the speed. */
+			self->speed_cnt = self->tx_fifo.len + 1;
+		}
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Save current bank */
 	bank = inb(iobase+BSR);
 
@@ -1334,16 +1358,23 @@ static int nsc_ircc_dma_xmit_complete(st
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
 
+	/* Check if we need to change the speed.
+	 * Do it after self->tx_fifo.len--; to avoid races with
+	 * nsc_ircc_hard_xmit_fir().
+	 * We do it synchronous to the packets in the fifo, so that's
+	 * why we wait for the right frame to do it. - Jean II */
+	if ((self->new_speed) && (--self->speed_cnt == 0)) {
+		/* There seem to be some issue with corrupting the
+		 * frame just before a speed change. Workaround. Jean II */
+		udelay(100);
+		nsc_ircc_change_speed(self, self->new_speed);
+		self->new_speed = 0;
+	}
+
 	/* Any frames to be sent back-to-back? */
 	if (self->tx_fifo.len) {
 		nsc_ircc_dma_xmit(self, iobase);
@@ -1634,7 +1665,12 @@ static void nsc_ircc_sir_interrupt(struc
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
 			nsc_ircc_change_speed(self, self->new_speed);
@@ -1649,9 +1685,6 @@ static void nsc_ircc_sir_interrupt(struc
 				return;
 			}
 		}
-		/* Turn around and get ready to receive some data */
-		self->io.direction = IO_RECV;
-		self->ier = IER_RXHDL_IE;
 	}
 
 	/* Rx FIFO threshold or timeout */
