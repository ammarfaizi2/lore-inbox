Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUBJBPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265643AbUBJBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:14:19 -0500
Received: from palrel12.hp.com ([156.153.255.237]:42169 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265640AbUBJBM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:12:58 -0500
Date: Mon, 9 Feb 2004 17:12:57 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] smsc-ircc2 irq retval
Message-ID: <20040210011257.GG673@bougret.hpl.hp.com>
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

ir262_irq_retval_smsc2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in smsc-ircc2 driver.


diff -u -p linux/drivers/net/irda.d7/smsc-ircc2.c linux/drivers/net/irda/smsc-ircc2.c
--- linux/drivers/net/irda.d7/smsc-ircc2.c	Wed Feb  4 11:55:57 2004
+++ linux/drivers/net/irda/smsc-ircc2.c	Mon Feb  9 16:12:38 2004
@@ -154,7 +154,7 @@ static void smsc_ircc_dma_xmit_complete(
 static void smsc_ircc_change_speed(void *priv, u32 speed);
 static void smsc_ircc_set_sir_speed(void *priv, u32 speed);
 static irqreturn_t smsc_ircc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static void smsc_ircc_interrupt_sir(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t smsc_ircc_interrupt_sir(struct net_device *dev);
 static void smsc_ircc_sir_start(struct smsc_ircc_cb *self);
 #if SMSC_IRCC2_C_SIR_STOP
 static void smsc_ircc_sir_stop(struct smsc_ircc_cb *self);
@@ -1401,9 +1401,9 @@ static irqreturn_t smsc_ircc_interrupt(i
 
 	/* Check if we should use the SIR interrupt handler */
 	if (self->io.speed <=  SMSC_IRCC2_MAX_SIR_SPEED) {
-		smsc_ircc_interrupt_sir(irq, dev_id, regs);
+		irqreturn_t ret = smsc_ircc_interrupt_sir(dev);
 		spin_unlock(&self->lock);	
-		return IRQ_HANDLED;
+		return ret;
 	}
 	iobase = self->io.fir_base;
 
@@ -1435,7 +1435,7 @@ static irqreturn_t smsc_ircc_interrupt(i
 	outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, iobase+IRCC_IER);
 
 	spin_unlock(&self->lock);
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(iir);
 }
 
 /*
@@ -1443,21 +1443,13 @@ static irqreturn_t smsc_ircc_interrupt(i
  *
  *    Interrupt handler for SIR modes
  */
-void smsc_ircc_interrupt_sir(int irq, void *dev_id, struct pt_regs *regs) 
+static irqreturn_t smsc_ircc_interrupt_sir(struct net_device *dev)
 {
-	struct net_device *dev = (struct net_device *) dev_id;
-	struct smsc_ircc_cb *self;
+	struct smsc_ircc_cb *self = dev->priv;
 	int boguscount = 0;
 	int iobase;
 	int iir, lsr;
 
-	if (!dev) {
-		WARNING("%s() irq %d for unknown device.\n",
-			__FUNCTION__, irq);
-		return;
-	}
-	self = (struct smsc_ircc_cb *) dev->priv;
-
 	/* Already locked comming here in smsc_ircc_interrupt() */
 	/*spin_lock(&self->lock);*/
 
@@ -1497,6 +1489,7 @@ void smsc_ircc_interrupt_sir(int irq, vo
  	        iir = inb(iobase + UART_IIR) & UART_IIR_ID;
 	}
 	/*spin_unlock(&self->lock);*/
+	return IRQ_RETVAL(iir);
 }
 
 
