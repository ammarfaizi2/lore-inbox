Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTEMWWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTEMWLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:11:30 -0400
Received: from palrel11.hp.com ([156.153.255.246]:57003 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263633AbTEMWKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:10:24 -0400
Date: Tue, 13 May 2003 15:23:10 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] Various IrDA drivers
Message-ID: <20030513222310.GF2634@bougret.hpl.hp.com>
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

ir259_trans_start-4.diff :
	o [CORRECT] Properly initialise dev->trans_start in various drivers
	o [CRITICA] Unregister power management at unload in smc-ircc
	o [CORRECT] fix module ownership in smc-ircc


diff -u -p linux/drivers/net/irda/ali-ircc.d1.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda/ali-ircc.d1.c	Mon May 12 17:32:06 2003
+++ linux/drivers/net/irda/ali-ircc.c	Mon May 12 18:05:59 2003
@@ -1451,6 +1451,7 @@ static int ali_ircc_fir_hard_xmit(struct
 		/* Check for empty frame */
 		if (!skb->len) {
 			ali_ircc_change_speed(self, speed); 
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -1560,6 +1561,7 @@ static int ali_ircc_fir_hard_xmit(struct
 	/* Restore bank register */
 	switch_bank(iobase, BANK0);
 
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 	dev_kfree_skb(skb);
 
@@ -1974,6 +1976,7 @@ static int ali_ircc_sir_hard_xmit(struct
 		/* Check for empty frame */
 		if (!skb->len) {
 			ali_ircc_change_speed(self, speed); 
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -1993,6 +1996,7 @@ static int ali_ircc_sir_hard_xmit(struct
 	/* Turn on transmit finished interrupt. Will fire immediately!  */
 	outb(UART_IER_THRI, iobase+UART_IER); 
 
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 
 	dev_kfree_skb(skb);
diff -u -p linux/drivers/net/irda/donauboe.d1.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda/donauboe.d1.c	Mon May 12 17:32:14 2003
+++ linux/drivers/net/irda/donauboe.c	Mon May 12 18:05:59 2003
@@ -1051,7 +1051,9 @@ toshoboe_hard_xmit (struct sk_buff *skb,
 
   toshoboe_checkstuck (self);
 
-  /* Check if we need to change the speed */
+  dev->trans_start = jiffies;
+
+ /* Check if we need to change the speed */
   /* But not now. Wait after transmission if mtt not required */
   speed=irda_get_next_speed(skb);
   if ((speed != self->io.speed) && (speed != -1))
diff -u -p linux/drivers/net/irda/nsc-ircc.d1.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d1.c	Mon May 12 17:32:26 2003
+++ linux/drivers/net/irda/nsc-ircc.c	Mon May 12 18:05:59 2003
@@ -1096,6 +1096,7 @@ static int nsc_ircc_hard_xmit_sir(struct
 				 * to make sure packets gets through the
 				 * proper xmit handler - Jean II */
 			}
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -1120,6 +1121,7 @@ static int nsc_ircc_hard_xmit_sir(struct
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
 
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 
 	dev_kfree_skb(skb);
@@ -1164,6 +1166,7 @@ static int nsc_ircc_hard_xmit_fir(struct
 				 * the speed change has been done.
 				 * Jean II */
 			}
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -1250,6 +1253,7 @@ static int nsc_ircc_hard_xmit_fir(struct
 	/* Restore bank register */
 	outb(bank, iobase+BSR);
 
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->lock, flags);
 	dev_kfree_skb(skb);
 
diff -u -p linux/drivers/net/irda/smc-ircc.d1.c linux/drivers/net/irda/smc-ircc.c
--- linux/drivers/net/irda/smc-ircc.d1.c	Mon May 12 17:32:35 2003
+++ linux/drivers/net/irda/smc-ircc.c	Tue May 13 13:28:15 2003
@@ -529,6 +529,9 @@ static int __init ircc_open(unsigned int
 
 	irport->priv = self;
 
+	/* Keep track of module usage */
+	SET_MODULE_OWNER(self->netdev);
+
 	/* Initialize IO */
 	self->io           = &irport->io;
 	self->io->fir_base  = fir_base;
@@ -747,6 +750,7 @@ static int ircc_hard_xmit(struct sk_buff
 		/* Check for empty frame */
 		if (!skb->len) {
 			ircc_change_speed(self, speed); 
+			dev->trans_start = jiffies;
 			spin_unlock_irqrestore(&self->irport->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
@@ -776,6 +780,7 @@ static int ircc_hard_xmit(struct sk_buff
 		/* Transmit frame */
 		ircc_dma_xmit(self, iobase, 0);
 	}
+	dev->trans_start = jiffies;
 	spin_unlock_irqrestore(&self->irport->lock, flags);
 	dev_kfree_skb(skb);
 
@@ -1090,8 +1095,6 @@ static int ircc_net_open(struct net_devi
 		WARNING("%s(), unable to allocate DMA=%d\n", __FUNCTION__, self->io->dma);
 		return -EAGAIN;
 	}
-	
-	MOD_INC_USE_COUNT;
 
 	return 0;
 }
@@ -1124,8 +1127,6 @@ static int ircc_net_close(struct net_dev
 
 	free_dma(self->io->dma);
 
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
@@ -1186,6 +1187,9 @@ static int __exit ircc_close(struct ircc
 	ASSERT(self != NULL, return -1;);
 
         iobase = self->irport->io.fir_base;
+
+        if (self->pmdev)
+		pm_unregister(self->pmdev);
 
 	/* This will destroy irport */
 	irport_close(self->irport);
diff -u -p linux/drivers/net/irda/w83977af_ir.d1.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda/w83977af_ir.d1.c	Mon May 12 17:32:43 2003
+++ linux/drivers/net/irda/w83977af_ir.c	Mon May 12 18:05:59 2003
@@ -524,6 +524,7 @@ int w83977af_hard_xmit(struct sk_buff *s
 		/* Check for empty frame */
 		if (!skb->len) {
 			w83977af_change_speed(self, speed); 
+			dev->trans_start = jiffies;
 			dev_kfree_skb(skb);
 			return 0;
 		} else
@@ -579,6 +580,7 @@ int w83977af_hard_xmit(struct sk_buff *s
 		switch_bank(iobase, SET0);
 		outb(ICR_ETXTHI, iobase+ICR);
 	}
+	dev->trans_start = jiffies;
 	dev_kfree_skb(skb);
 
 	/* Restore set register */
