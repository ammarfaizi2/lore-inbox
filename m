Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbQKLVuY>; Sun, 12 Nov 2000 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131217AbQKLVuP>; Sun, 12 Nov 2000 16:50:15 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:20496 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S130527AbQKLVt4>; Sun, 12 Nov 2000 16:49:56 -0500
Date: Sun, 12 Nov 2000 21:50:40 GMT
Message-Id: <200011122150.VAA65437@tepid.osl.fast.no>
Subject: [patch] Re: Compile and link errors in irda in test11-pre3
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] Re: Compile and link errors in irda in test11-pre3
In-Reply-To: %s: <20001112164236.J637@jaquet.dk>
Cc: linux-irda@pasta.cs.uit.no, linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com, rasmus@jaquet.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch that fixes the compile and link errors in the latest IrDA code in
linux-2.4.0-test11-pre3.

Changes:

o Fixes some errors in the change_speed name for a couple of drivers.
   Includes the previous patch I sent you (nsc-ircc) (me)

o Fixes irport driver where the netdev timeout was set to shorter than the 
  time required for a speed change (me)

o Fixes warning in init code in irsyms.c (Rasmus Andersen)

-- Dag

diff -urpN linux-2.4.0-test11-pre3/drivers/net/irda/irport.c linux/drivers/net/irda/irport.c
--- linux-2.4.0-test11-pre3/drivers/net/irda/irport.c	Sun Nov 12 09:08:11 2000
+++ linux/drivers/net/irda/irport.c	Sun Nov 12 21:56:47 2000
@@ -230,7 +230,7 @@ irport_open(int i, unsigned int iobase, 
 	dev->init            = irport_net_init;
 	dev->hard_start_xmit = irport_hard_xmit;
 	dev->tx_timeout	     = irport_timeout;
-	dev->watchdog_timeo  = HZ/20;
+	dev->watchdog_timeo  = HZ;  /* Allow time enough for speed change */
 	dev->open            = irport_net_open;
 	dev->stop            = irport_net_close;
 	dev->get_stats	     = irport_net_get_stats;
@@ -496,7 +496,6 @@ static void irport_write_wakeup(struct i
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
 	} else {
-		
 		/* 
 		 *  Now serial buffer is almost free & we can start 
 		 *  transmission of another packet. But first we must check
diff -urpN linux-2.4.0-test11-pre3/drivers/net/irda/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux-2.4.0-test11-pre3/drivers/net/irda/nsc-ircc.c	Sun Nov 12 09:08:11 2000
+++ linux/drivers/net/irda/nsc-ircc.c	Sun Nov 12 09:57:17 2000
@@ -1129,7 +1129,7 @@ static int nsc_ircc_hard_xmit_fir(struct
 	if ((speed = irda_get_speed(skb)) != self->io.speed) {
 		/* Check for empty frame */
 		if (!skb->len) {
-			nsc_ircc_change_speed_complete(self, speed); 
+			nsc_ircc_change_speed(self, speed); 
 			return 0;
 		} else
 			self->new_speed = speed;
diff -urpN linux-2.4.0-test11-pre3/drivers/net/irda/smc-ircc.c linux/drivers/net/irda/smc-ircc.c
--- linux-2.4.0-test11-pre3/drivers/net/irda/smc-ircc.c	Sun Nov 12 09:08:11 2000
+++ linux/drivers/net/irda/smc-ircc.c	Sun Nov 12 22:00:01 2000
@@ -7,7 +7,7 @@
  * Author:        Thomas Davis (tadavis@jps.net)
  * Created at:    
  * Modified at:   Tue Feb 22 10:05:06 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli
  *     Copyright (c) 1998-1999 Thomas Davis, 
@@ -252,6 +252,7 @@ static int ircc_open(int i, unsigned int
 		IR_115200|IR_576000|IR_1152000|(IR_4000000 << 8);
 
 	irport->qos.min_turn_time.bits = 0x07;
+	irport->qos.window_size.bits = 0x01;
 	irda_qos_bits_to_value(&irport->qos);
 
 	irport->flags = IFF_FIR|IFF_MIR|IFF_SIR|IFF_DMA|IFF_PIO;
@@ -508,6 +509,10 @@ static void ircc_change_speed(void *priv
 	outb(0x00, iobase+IRCC_MASTER);
 
 	switch (speed) {
+	default:
+		IRDA_DEBUG(0, __FUNCTION__ "(), unknown baud rate of %d\n", 
+			   speed);
+		/* FALLTHROUGH */
 	case 9600:
 	case 19200:
 	case 38400:
@@ -535,10 +540,6 @@ static void ircc_change_speed(void *priv
 		fast = IRCC_LCR_A_FAST;
 		IRDA_DEBUG(0, __FUNCTION__ "(), handling baud of 4000000\n");
 		break;
-	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), unknown baud rate of %d\n", 
-			   speed);
-		return;
 	}
 	
 	register_bank(iobase, 0);
@@ -620,7 +621,7 @@ static int ircc_hard_xmit(struct sk_buff
 	if ((speed = irda_get_speed(skb)) != self->io.speed) {
 		/* Check for empty frame */
 		if (!skb->len) {
-			smc_ircc_change_speed(self, speed); 
+			ircc_change_speed(self, speed); 
 			return 0;
 		} else
 			self->new_speed = speed;
@@ -638,7 +639,7 @@ static int ircc_hard_xmit(struct sk_buff
 		int bofs;
 
 		/* 
-		 * Compute who many BOFS (STA or PA's) we need to waste the
+		 * Compute how many BOFs (STA or PA's) we need to waste the
 		 * min turn time given the speed of the link.
 		 */
 		bofs = mtt * (self->io.speed / 1000) / 8000;
@@ -650,7 +651,6 @@ static int ircc_hard_xmit(struct sk_buff
 		/* Transmit frame */
 		ircc_dma_xmit(self, iobase, 0);
 	}
-	
 	spin_unlock_irqrestore(&self->lock, flags);
 	dev_kfree_skb(skb);
 
@@ -767,6 +767,7 @@ static int ircc_dma_receive(struct ircc_
 
 	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
 		  DMA_RX_MODE);
+
 	/* Set max Rx frame size */
 	register_bank(iobase, 4);
 	outb((2050 >> 8) & 0x0f, iobase+IRCC_RX_SIZE_HI);
@@ -795,7 +796,6 @@ static int ircc_dma_receive(struct ircc_
  *
  *    Finished with receiving frames
  *
- *    
  */
 static void ircc_dma_receive_complete(struct ircc_cb *self, int iobase)
 {
diff -urpN linux-2.4.0-test11-pre3/drivers/net/irda/toshoboe.c linux/drivers/net/irda/toshoboe.c
--- linux-2.4.0-test11-pre3/drivers/net/irda/toshoboe.c	Sun Nov 12 09:08:11 2000
+++ linux/drivers/net/irda/toshoboe.c	Sun Nov 12 10:34:52 2000
@@ -275,7 +275,7 @@ toshoboe_hard_xmit (struct sk_buff *skb,
   if ((speed = irda_get_speed(skb)) != self->io.speed) {
 	/* Check for empty frame */
 	if (!skb->len) {
-	    toshoboe_change_speed(self, speed); 
+	    toshoboe_setbaud(self, speed); 
 	    return 0;
 	} else
 	    self->new_speed = speed;
--- linux-240-t11-pre3-clean/net/irda/irsyms.c	Sun Nov 12 09:46:15 2000
+++ linux/net/irda/irsyms.c	Sun Nov 12 16:32:10 2000
@@ -182,7 +182,7 @@
 EXPORT_SYMBOL(irtty_set_packet_mode);
 #endif
 
-static int __init irda_init(void)
+int __init irda_init(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
