Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUBJBUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUBJBUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:20:40 -0500
Received: from palrel12.hp.com ([156.153.255.237]:58296 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265622AbUBJBMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:12:24 -0500
Date: Mon, 9 Feb 2004 17:12:22 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] ali-ircc irq retval
Message-ID: <20040210011222.GF673@bougret.hpl.hp.com>
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

ir262_irq_retval_ali.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in ali-ircc driver.


diff -u -p linux/drivers/net/irda.d7/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda.d7/ali-ircc.c	Wed Feb  4 11:55:57 2004
+++ linux/drivers/net/irda/ali-ircc.c	Mon Feb  9 16:12:48 2004
@@ -103,7 +103,7 @@ static struct net_device_stats *ali_ircc
 
 /* SIR function */
 static int  ali_ircc_sir_hard_xmit(struct sk_buff *skb, struct net_device *dev);
-static void ali_ircc_sir_interrupt(int irq, struct ali_ircc_cb *self, struct pt_regs *regs);
+static irqreturn_t ali_ircc_sir_interrupt(struct ali_ircc_cb *self);
 static void ali_ircc_sir_receive(struct ali_ircc_cb *self);
 static void ali_ircc_sir_write_wakeup(struct ali_ircc_cb *self);
 static int  ali_ircc_sir_write(int iobase, int fifo_size, __u8 *buf, int len);
@@ -112,7 +112,7 @@ static void ali_ircc_sir_change_speed(st
 /* FIR function */
 static int  ali_ircc_fir_hard_xmit(struct sk_buff *skb, struct net_device *dev);
 static void ali_ircc_fir_change_speed(struct ali_ircc_cb *priv, __u32 speed);
-static void ali_ircc_fir_interrupt(int irq, struct ali_ircc_cb *self, struct pt_regs *regs);
+static irqreturn_t ali_ircc_fir_interrupt(struct ali_ircc_cb *self);
 static int  ali_ircc_dma_receive(struct ali_ircc_cb *self); 
 static int  ali_ircc_dma_receive_complete(struct ali_ircc_cb *self);
 static int  ali_ircc_dma_xmit_complete(struct ali_ircc_cb *self);
@@ -635,6 +635,7 @@ static irqreturn_t ali_ircc_interrupt(in
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct ali_ircc_cb *self;
+	int ret;
 		
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);
 		
@@ -649,22 +650,22 @@ static irqreturn_t ali_ircc_interrupt(in
 	
 	/* Dispatch interrupt handler for the current speed */
 	if (self->io.speed > 115200)
-		ali_ircc_fir_interrupt(irq, self, regs);
+		ret = ali_ircc_fir_interrupt(self);
 	else
-		ali_ircc_sir_interrupt(irq, self, regs);	
+		ret = ali_ircc_sir_interrupt(self);
 		
 	spin_unlock(&self->lock);
 	
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__);
-	return IRQ_HANDLED;
+	return ret;
 }
 /*
- * Function ali_ircc_fir_interrupt(irq, struct ali_ircc_cb *self, regs)
+ * Function ali_ircc_fir_interrupt(irq, struct ali_ircc_cb *self)
  *
  *    Handle MIR/FIR interrupt
  *
  */
-static void ali_ircc_fir_interrupt(int irq, struct ali_ircc_cb *self, struct pt_regs *regs)
+static irqreturn_t ali_ircc_fir_interrupt(struct ali_ircc_cb *self)
 {
 	__u8 eir, OldMessageCount;
 	int iobase, tmp;
@@ -777,6 +778,7 @@ static void ali_ircc_fir_interrupt(int i
 	SetCOMInterrupts(self, TRUE);	
 		
 	IRDA_DEBUG(1, "%s(), ----------------- End ---------------\n", __FUNCTION__);
+	return IRQ_RETVAL(eir);
 }
 
 /*
@@ -785,7 +787,7 @@ static void ali_ircc_fir_interrupt(int i
  *    Handle SIR interrupt
  *
  */
-static void ali_ircc_sir_interrupt(int irq, struct ali_ircc_cb *self, struct pt_regs *regs)
+static irqreturn_t ali_ircc_sir_interrupt(struct ali_ircc_cb *self)
 {
 	int iobase;
 	int iir, lsr;
@@ -827,6 +829,8 @@ static void ali_ircc_sir_interrupt(int i
 	
 	
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__);	
+
+	return IRQ_RETVAL(iir);
 }
 
 
