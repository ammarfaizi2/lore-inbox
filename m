Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUBZDOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUBZDOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:14:15 -0500
Received: from palrel13.hp.com ([156.153.255.238]:62855 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262625AbUBZDNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:13:34 -0500
Date: Wed, 25 Feb 2004 19:13:32 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irq_retval_smsc2-fix (resent)
Message-ID: <20040226031332.GD32263@bougret.hpl.hp.com>
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

irXXX_irq_retval_smsc2-fix.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Fix the handling of shared IRQs in smsc-ircc2 driver.


diff -Nru a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
--- a/drivers/net/irda/smsc-ircc2.c	Tue Feb 24 11:17:34 2004
+++ b/drivers/net/irda/smsc-ircc2.c	Tue Feb 24 11:17:34 2004
@@ -1385,11 +1385,12 @@
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct smsc_ircc_cb *self;
 	int iobase, iir, lcra, lsr;
+	irqreturn_t ret = IRQ_NONE;
 
 	if (dev == NULL) {
 		printk(KERN_WARNING "%s: irq %d for unknown device.\n", 
 		       driver_name, irq);
-		return IRQ_NONE;
+		goto irq_ret;
 	}
 	self = (struct smsc_ircc_cb *) dev->priv;
 	ASSERT(self != NULL, return IRQ_NONE;);
@@ -1399,14 +1400,18 @@
 
 	/* Check if we should use the SIR interrupt handler */
 	if (self->io.speed <=  SMSC_IRCC2_MAX_SIR_SPEED) {
-		irqreturn_t ret = smsc_ircc_interrupt_sir(dev);
-		spin_unlock(&self->lock);	
-		return ret;
+		ret = smsc_ircc_interrupt_sir(dev);
+		goto irq_ret_unlock;
 	}
+
 	iobase = self->io.fir_base;
 
 	register_bank(iobase, 0);
 	iir = inb(iobase+IRCC_IIR);
+	if (iir == 0) 
+		goto irq_ret_unlock;
+	ret = IRQ_HANDLED;
+
 	/* Disable interrupts */
 	outb(0, iobase+IRCC_IER);
 	lcra = inb(iobase+IRCC_LCR_A);
@@ -1432,8 +1437,10 @@
 	register_bank(iobase, 0);
 	outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, iobase+IRCC_IER);
 
+ irq_ret_unlock:
 	spin_unlock(&self->lock);
-	return IRQ_RETVAL(iir);
+ irq_ret:
+	return ret;
 }
 
 /*
@@ -1454,6 +1461,8 @@
 	iobase = self->io.sir_base;
 
 	iir = inb(iobase+UART_IIR) & UART_IIR_ID;
+	if (iir == 0)
+		return IRQ_NONE;
 	while (iir) {
 		/* Clear interrupt */
 		lsr = inb(iobase+UART_LSR);
@@ -1487,7 +1496,7 @@
  	        iir = inb(iobase + UART_IIR) & UART_IIR_ID;
 	}
 	/*spin_unlock(&self->lock);*/
-	return IRQ_RETVAL(iir);
+	return IRQ_HANDLED;
 }
 
 

