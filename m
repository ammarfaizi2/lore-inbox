Return-Path: <linux-kernel-owner+w=401wt.eu-S1751139AbXANHgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbXANHgD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXANHgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:36:02 -0500
Received: from www.osadl.org ([213.239.205.134]:57899 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751144AbXANHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:35:36 -0500
Message-Id: <20070114081927.018926390@inhelltoy.tec.linutronix.de>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de>
User-Agent: quilt/0.46-1
Date: Sun, 14 Jan 2007 08:33:47 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch-mm 3/3] Scheduled removal of SA_xxx interrupt flags fixups 2
	(mm)
Content-Disposition: inline;
	filename=sa-irqflags-scheduled-feature-removal-fix-mm-users.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The obsolete SA_xxx interrupt flags have been used despite the scheduled
removal. Fixup the remaining users in -mm.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.20-rc4-mm1/arch/i386/kernel/vmitime.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/i386/kernel/vmitime.c
+++ linux-2.6.20-rc4-mm1/arch/i386/kernel/vmitime.c
@@ -121,12 +121,10 @@ static struct clocksource clocksource_vm
 static irqreturn_t vmi_timer_interrupt(int irq, void *dev_id);
 
 struct irqaction vmi_timer_irq  = {
-	vmi_timer_interrupt,
-	SA_INTERRUPT,
-	CPU_MASK_NONE,
-	"VMI-alarm",
-	NULL,
-	NULL
+	.handler = vmi_timer_interrupt,
+	.flags = IRQF_DISABLED,
+	.mask = CPU_MASK_NONE,
+	.name = "VMI-alarm",
 };
 
 /* Alarm rate */
Index: linux-2.6.20-rc4-mm1/drivers/char/nozomi.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/char/nozomi.c
+++ linux-2.6.20-rc4-mm1/drivers/char/nozomi.c
@@ -1378,7 +1378,7 @@ static int nozomi_setup_interrupt(struct
 {
 	int rval;
 
-	rval = request_irq(dc->pdev->irq, &interrupt_handler, SA_SHIRQ,
+	rval = request_irq(dc->pdev->irq, &interrupt_handler, IRQF_SHARED,
 			   NOZOMI_NAME, dc);
 	if (rval)
 		dev_err(&dc->pdev->dev, "Cannot open because IRQ %d "
Index: linux-2.6.20-rc4-mm1/drivers/firewire/fw-ohci.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/firewire/fw-ohci.c
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-ohci.c
@@ -714,7 +714,7 @@ static int ohci_enable(struct fw_card *c
 	reg_write(ohci, OHCI1394_AsReqFilterHiSet, 0x80000000);
 
 	if (request_irq(dev->irq, irq_handler,
-			SA_SHIRQ, ohci_driver_name, ohci)) {
+			IRQF_SHARED, ohci_driver_name, ohci)) {
 		fw_error("Failed to allocate shared interrupt %d.\n",
 			 dev->irq);
 		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
Index: linux-2.6.20-rc4-mm1/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/input/keyboard/gpio_keys.c
+++ linux-2.6.20-rc4-mm1/drivers/input/keyboard/gpio_keys.c
@@ -78,7 +78,7 @@ static int __devinit gpio_keys_probe(str
 		int irq = IRQ_GPIO(pdata->buttons[i].gpio);
 
 		set_irq_type(irq, IRQ_TYPE_EDGE_BOTH);
-		error = request_irq(irq, gpio_keys_isr, SA_SAMPLE_RANDOM,
+		error = request_irq(irq, gpio_keys_isr, IRQF_SAMPLE_RANDOM,
 				     pdata->buttons[i].desc ? pdata->buttons[i].desc : "gpio_keys",
 				     pdev);
 		if (error) {
Index: linux-2.6.20-rc4-mm1/drivers/mtd/nand/cafe.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/mtd/nand/cafe.c
+++ linux-2.6.20-rc4-mm1/drivers/mtd/nand/cafe.c
@@ -596,7 +596,8 @@ static int __devinit cafe_nand_probe(str
 		cafe_writel(cafe, 0xffffffff, NAND_TIMING3);
 	}
 	cafe_writel(cafe, 0xffffffff, NAND_IRQ_MASK);
-	err = request_irq(pdev->irq, &cafe_nand_interrupt, SA_SHIRQ, "CAFE NAND", mtd);
+	err = request_irq(pdev->irq, &cafe_nand_interrupt, IRQF_SHARED,
+			  "CAFE NAND", mtd);
 	if (err) {
 		dev_warn(&pdev->dev, "Could not register IRQ %d\n", pdev->irq);
 
Index: linux-2.6.20-rc4-mm1/drivers/net/cxgb3/cxgb3_main.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/net/cxgb3/cxgb3_main.c
+++ linux-2.6.20-rc4-mm1/drivers/net/cxgb3/cxgb3_main.c
@@ -709,7 +709,8 @@ static int cxgb_up(struct adapter *adap)
 				      t3_intr_handler(adap,
 						      adap->sge.qs[0].rspq.
 						      polling),
-				      (adap->flags & USING_MSI) ? 0 : SA_SHIRQ,
+				      (adap->flags & USING_MSI) ?
+				       0 : IRQF_SHARED,
 				      adap->name, adap)))
 		goto irq_err;
 
Index: linux-2.6.20-rc4-mm1/drivers/net/sc92031.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/net/sc92031.c
+++ linux-2.6.20-rc4-mm1/drivers/net/sc92031.c
@@ -1035,7 +1035,7 @@ static int sc92031_open(struct net_devic
 	priv->tx_head = priv->tx_tail = 0;
 
 	err = request_irq(pdev->irq, sc92031_interrupt,
-			SA_SHIRQ, dev->name, dev);
+			IRQF_SHARED, dev->name, dev);
 	if (unlikely(err < 0))
 		goto out_request_irq;
 
Index: linux-2.6.20-rc4-mm1/kernel/irq/manage.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/kernel/irq/manage.c
+++ linux-2.6.20-rc4-mm1/kernel/irq/manage.c
@@ -394,7 +394,7 @@ void free_irq(unsigned int irq, void *de
 
 			/* Make sure it's not being used on another CPU */
 			synchronize_irq(irq);
-			if (action->flags & SA_SHIRQ)
+			if (action->flags & IRQF_SHARED)
 				handler = action->handler;
 			kfree(action);
 			return;
@@ -487,14 +487,14 @@ int request_irq(unsigned int irq, irq_ha
 	select_smp_affinity(irq);
 
 #ifdef CONFIG_DEBUG_SHIRQ
-	if (irqflags & SA_SHIRQ) {
+	if (irqflags & IRQF_SHARED) {
 		/*
 		 * It's a shared IRQ -- the driver ought to be prepared for it
 		 * to happen immediately, so let's make sure....
 		 * We do this before actually registering it, to make sure that
 		 * a 'real' IRQ doesn't run in parallel with our fake
 		 */
-		if (irqflags & SA_INTERRUPT) {
+		if (irqflags & IRQF_DISABLED) {
 			unsigned long flags;
 
 			local_irq_save(flags);

-- 

