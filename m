Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKKVW0>; Sat, 11 Nov 2000 16:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKKVWR>; Sat, 11 Nov 2000 16:22:17 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:45577 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129040AbQKKVWF>; Sat, 11 Nov 2000 16:22:05 -0500
Date: Sat, 11 Nov 2000 21:23:05 GMT
Message-Id: <200011112123.VAA32326@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda14 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda14 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda14.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda14.diff :
-----------------
	o [CRITICA] Allow immediate driver speed change from within IrDA stack

diff -urpN linux-2.4.0-test10-linus/net/irda/irlap.c linux-2.4.0-test10-irda/net/irda/irlap.c
--- linux-2.4.0-test10-linus/net/irda/irlap.c	Sat Nov 11 19:49:03 2000
+++ linux-2.4.0-test10-irda/net/irda/irlap.c	Fri Nov 10 00:07:48 2000
@@ -876,6 +876,8 @@ void irlap_flush_all_queues(struct irlap
  */
 void irlap_change_speed(struct irlap_cb *self, __u32 speed, int now)
 {
+	struct sk_buff *skb;
+
 	IRDA_DEBUG(0, __FUNCTION__ "(), setting speed to %d\n", speed);
 
 	ASSERT(self != NULL, return;);
@@ -884,8 +886,11 @@ void irlap_change_speed(struct irlap_cb 
 	self->speed = speed;
 
 	/* Change speed now, or just piggyback speed on frames */
-	if (now)
-		irda_device_change_speed(self->netdev, speed);
+	if (now) {
+		/* Send down empty frame to trigger speed change */
+		skb = dev_alloc_skb(0);
+		irlap_queue_xmit(self, skb);
+	}
 }
 
 #ifdef CONFIG_IRDA_COMPRESSION
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/irport.c linux-2.4.0-test10-irda/drivers/net/irda/irport.c
--- linux-2.4.0-test10-linus/drivers/net/irda/irport.c	Sat Nov 11 19:47:43 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/irport.c	Sat Nov 11 20:06:31 2000
@@ -629,8 +629,16 @@ int irport_hard_xmit(struct sk_buff *skb
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			irda_task_execute(self, __irport_change_speed, 
+					  irport_change_speed_complete, 
+					  NULL, (void *) speed);
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
 
 	spin_lock_irqsave(&self->lock, flags);
 
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/irtty.c linux-2.4.0-test10-irda/drivers/net/irda/irtty.c
--- linux-2.4.0-test10-linus/drivers/net/irda/irtty.c	Sat Nov 11 19:47:43 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/irtty.c	Sat Nov 11 20:06:25 2000
@@ -638,8 +638,16 @@ static int irtty_hard_xmit(struct sk_buf
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			irda_task_execute(self, irtty_change_speed, 
+					  irtty_change_speed_complete, 
+					  NULL, (void *) speed);
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
 
 	/* Init tx buffer*/
 	self->tx_buff.data = self->tx_buff.head;
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/nsc-ircc.c linux-2.4.0-test10-irda/drivers/net/irda/nsc-ircc.c
--- linux-2.4.0-test10-linus/drivers/net/irda/nsc-ircc.c	Sat Nov 11 19:47:43 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/nsc-ircc.c	Sat Nov 11 20:02:20 2000
@@ -1076,9 +1075,15 @@ static int nsc_ircc_hard_xmit_sir(struct
 	netif_stop_queue(dev);
 		
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
-	
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			nsc_ircc_change_speed(self, speed); 
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
+
 	spin_lock_irqsave(&self->lock, flags);
 	
 	/* Save current bank */
@@ -1120,8 +1125,14 @@ static int nsc_ircc_hard_xmit_fir(struct
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			nsc_ircc_change_speed_complete(self, speed); 
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
 
 	spin_lock_irqsave(&self->lock, flags);
 
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/smc-ircc.c linux-2.4.0-test10-irda/drivers/net/irda/smc-ircc.c
--- linux-2.4.0-test10-linus/drivers/net/irda/smc-ircc.c	Sat Nov 11 19:47:43 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/smc-ircc.c	Sat Nov 11 20:05:18 2000
@@ -589,6 +589,8 @@ static void ircc_change_speed(void *priv
 	
 	register_bank(iobase, 0);
 	outb(fast, iobase+IRCC_LCR_A);
+	
+	netif_start_queue(dev);
 }
 
 /*
@@ -612,13 +614,19 @@ static int ircc_hard_xmit(struct sk_buff
 
 	iobase = self->io.fir_base;
 
-	spin_lock_irqsave(&self->lock, flags);
+	netif_stop_queue(dev);
 
 	/* Check if we need to change the speed after this frame */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			smc_ircc_change_speed(self, speed); 
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
 	
-	netif_stop_queue(dev);
+	spin_lock_irqsave(&self->lock, flags);
 
 	memcpy(self->tx_buff.head, skb->data, skb->len);
 
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/toshoboe.c linux-2.4.0-test10-irda/drivers/net/irda/toshoboe.c
--- linux-2.4.0-test10-linus/drivers/net/irda/toshoboe.c	Sat Nov 11 19:47:43 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/toshoboe.c	Sat Nov 11 20:02:03 2000
@@ -272,8 +272,14 @@ toshoboe_hard_xmit (struct sk_buff *skb,
     );
 
   /* Check if we need to change the speed */
-  if ((speed = irda_get_speed(skb)) != self->io.speed)
-	  self->new_speed = speed;
+  if ((speed = irda_get_speed(skb)) != self->io.speed) {
+	/* Check for empty frame */
+	if (!skb->len) {
+	    toshoboe_change_speed(self, speed); 
+	    return 0;
+	} else
+	    self->new_speed = speed;
+  }
 
   netif_stop_queue(dev);
   
diff -urpN linux-2.4.0-test10-linus/drivers/net/irda/w83977af_ir.c linux-2.4.0-test10-irda/drivers/net/irda/w83977af_ir.c
--- linux-2.4.0-test10-linus/drivers/net/irda/w83977af_ir.c	Sat Nov 11 19:47:47 2000
+++ linux-2.4.0-test10-irda/drivers/net/irda/w83977af_ir.c	Sat Nov 11 20:02:35 2000
@@ -513,8 +513,14 @@ int w83977af_hard_xmit(struct sk_buff *s
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
-	if ((speed = irda_get_speed(skb)) != self->io.speed)
-		self->new_speed = speed;
+	if ((speed = irda_get_speed(skb)) != self->io.speed) {
+		/* Check for empty frame */
+		if (!skb->len) {
+			w83977af_change_speed(self, speed); 
+			return 0;
+		} else
+			self->new_speed = speed;
+	}
 
 	/* Save current set */
 	set = inb(iobase+SSR);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
