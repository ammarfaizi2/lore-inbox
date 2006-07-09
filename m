Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWGIV65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWGIV65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWGIV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:58:57 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:62856 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161175AbWGIV65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:58:57 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com
Subject: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Date: Sun, 9 Jul 2006 14:58:51 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cwXsELzE/28piPz"
Message-Id: <200607091458.52298.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_cwXsELzE/28piPz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It's not just "normal" mode operation that needs refcounting for the
{en,dis}able_irq() calls ... "wakeup" mode calls need it too, for the
very same reasons.

This patch adds that refcounting.  I expect that some ARM drivers will
be triggering the new warning, but this call isn't yet widely used.
(Which is probably why the bug has lingered this long...)

- Dave


--Boundary-00=_cwXsELzE/28piPz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="irqwake.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="irqwake.patch"

IRQs need refcounting and a state flag to track whether the the IRQ should
be enabled or disabled as a "normal IRQ" source after a series of calls to
disable_irq() and enable_irq().  For shared IRQs, the IRQ must be enabled
so long as at least one driver needs it active.

Likewise, IRQs need the same support to track whether the IRQ should be
enabled or disabled as a "wakeup event" source after a series of calls to
enable_irq_wake() and disable_irq_wake().  For shared IRQs, the IRQ must
be wakeup-enabled so long as at least one driver needs it.

But right now they don't have that refcounting ... which means sharing
wakeup-capable IRQs can't work correctly in some configurations.  This
patch adds the refcount and flag mechanisms to set_irq_wake(), and a
minimal description of what an irq wake mechanism is.

Drivers relying on the older (broken) "toggle" semantics will trigger a
warning; that'll be a handful of drivers on ARM systems.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: at91/include/linux/irq.h
===================================================================
--- at91.orig/include/linux/irq.h	2006-07-09 13:46:34.000000000 -0700
+++ at91/include/linux/irq.h	2006-07-09 13:57:35.000000000 -0700
@@ -58,6 +58,7 @@
 #define IRQ_NOREQUEST		0x04000000	/* IRQ cannot be requested */
 #define IRQ_NOAUTOEN		0x08000000	/* IRQ will not be enabled on request irq */
 #define IRQ_DELAYED_DISABLE	0x10000000	/* IRQ disable (masking) happens delayed. */
+#define IRQ_WAKEUP		0x20000000	/* IRQ triggers system wakeup */
 
 struct proc_dir_entry;
 
@@ -124,6 +125,7 @@ struct irq_chip {
  * @action:		the irq action chain
  * @status:		status information
  * @depth:		disable-depth, for nested irq_disable() calls
+ * @wake_depth:		enable depth, for multiple set_irq_wake() callers
  * @irq_count:		stats field to detect stalled irqs
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @lock:		locking for SMP
@@ -147,6 +149,7 @@ struct irq_desc {
 	unsigned int		status;		/* IRQ status */
 
 	unsigned int		depth;		/* nested irq disables */
+	unsigned int		wake_depth;	/* nested wake enables */
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned int		irqs_unhandled;
 	spinlock_t		lock;
Index: at91/kernel/irq/manage.c
===================================================================
--- at91.orig/kernel/irq/manage.c	2006-07-09 13:46:34.000000000 -0700
+++ at91/kernel/irq/manage.c	2006-07-09 13:57:35.000000000 -0700
@@ -137,16 +137,40 @@ EXPORT_SYMBOL(enable_irq);
  *	@irq:	interrupt to control
  *	@on:	enable/disable power management wakeup
  *
- *	Enable/disable power management wakeup mode
+ *	Enable/disable power management wakeup mode, which is
+ *	disabled by default.  Enables and disables must match,
+ *	just as they match for non-wakeup mode support.
+ *
+ *	Wakeup mode lets this IRQ wake the system from sleep
+ *	states like "suspend to RAM".
  */
 int set_irq_wake(unsigned int irq, unsigned int on)
 {
 	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 	int ret = -ENXIO;
+	int (*set_wake)(unsigned, unsigned) = desc->chip->set_wake;
 
+	/* wakeup-capable irqs can be shared between drivers that
+	 * don't need to have the same sleep mode behaviors.
+	 */
 	spin_lock_irqsave(&desc->lock, flags);
-	if (desc->chip->set_wake)
+	if (on) {
+		if (desc->wake_depth++ == 0)
+			desc->status |= IRQ_WAKEUP;
+		else
+			set_wake = NULL;
+	} else {
+		if (desc->wake_depth == 0) {
+			printk(KERN_WARNING "Unbalanced IRQ %d "
+					"wake disable\n", irq);
+			WARN_ON(1);
+		} else if (--desc->wake_depth == 0)
+			desc->status &= ~IRQ_WAKEUP;
+		else
+			set_wake = NULL;
+	}
+	if (set_wake)
 		ret = desc->chip->set_wake(irq, on);
 	spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;

--Boundary-00=_cwXsELzE/28piPz--
