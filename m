Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVJ1V5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVJ1V5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJ1V5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:57:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58378 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750779AbVJ1V5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:57:52 -0400
Date: Fri, 28 Oct 2005 22:57:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [RFC] IRQ type flags
Message-ID: <20051028215747.GA32120@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some ARM platforms have the ability to program the interrupt controller
to detect various interrupt edges and/or levels.  For some platforms,
this is critical to setup correctly, particularly those which the
setting is dependent on the device.

Currently, ARM drivers do (eg) the following:

	err = request_irq(irq, ...);

	set_irq_type(irq, IRQT_RISING);

However, if the interrupt has previously been programmed to be level
sensitive (for whatever reason) then this will cause an interrupt
storm.

Hence, if we combine set_irq_type() with request_irq(), we can then
safely set the type prior to unmasking the interrupt.  The unfortunate
problem is that in order to support this, these flags need to be
visible outside of the ARM architecture - drivers such as smc91x
need these flags and they're cross-architecture.

Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect
the property that the device would like.  The IRQ controller code
should do its best to select the most appropriate supported mode.

Comments?

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -681,10 +681,16 @@ int setup_irq(unsigned int irq, struct i
 	 */
 	desc = irq_desc + irq;
 	spin_lock_irqsave(&irq_controller_lock, flags);
+#define SA_TRIGGER	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
+			 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)
 	p = &desc->action;
 	if ((old = *p) != NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
+		/*
+		 * Can't share interrupts unless both agree to and are
+		 * the same type.
+		 */
+		if (!(old->flags & new->flags & SA_SHIRQ) ||
+		    (~old->flags & new->flags) & SA_TRIGGER) {
 			spin_unlock_irqrestore(&irq_controller_lock, flags);
 			return -EBUSY;
 		}
@@ -704,6 +710,12 @@ int setup_irq(unsigned int irq, struct i
 		desc->running = 0;
 		desc->pending = 0;
 		desc->disable_depth = 1;
+
+		if (new->flags & SA_TRIGGER) {
+			unsigned int type = new->flags & SA_TRIGGER;
+			desc->chip->set_type(irq, type);
+		}
+
 		if (!desc->noautoenable) {
 			desc->disable_depth = 0;
 			desc->chip->unmask(irq);
diff --git a/include/linux/signal.h b/include/linux/signal.h
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -18,6 +18,14 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+/*
+ * As above, these correspond to the __IRQT defines in asm-arm/irq.h
+ * to select the interrupt line behaviour.
+ */
+#define SA_TRIGGER_HIGH		0x00000008
+#define SA_TRIGGER_LOW		0x00000004
+#define SA_TRIGGER_RISING	0x00000002
+#define SA_TRIGGER_FALLING	0x00000001
 
 /*
  * Real Time signals may be queued.
