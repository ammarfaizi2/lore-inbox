Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRKHTS2>; Thu, 8 Nov 2001 14:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRKHTSJ>; Thu, 8 Nov 2001 14:18:09 -0500
Received: from AGrenoble-101-1-2-10.abo.wanadoo.fr ([193.253.227.10]:59290
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S277533AbRKHTSC>; Thu, 8 Nov 2001 14:18:02 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Recover from lockups after "eth0: transmit timed out"
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Thu, 08 Nov 2001 19:42:05 +0100
Message-ID: <30043.1005244925@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my second take at the fix.  I've tested it on my ABIT BP6 with
linux 2.4.12-ac3, but it should apply fine on more recent versions.
I've verified that I indeed recovered from a timeout situation where
I had to reboot before.

The fix assumes that the "NETDEV WATCHDOG" will only run when there is
an APIC, so it's OK to call apic routines.  If this assumption is wrong,
then could someone more knowledgeable than me protect the call correctly
so we don't address missing hardware?

This fix is driver-independent, contrary to my first fix.  It's also
shorter, as it re-uses existing macros in io_apic.c instead of expanding
them.

Please apply, and if rejected, let me know why.

Raphael

--- linux-2.4.12-ac3/arch/i386/kernel/io_apic.c.orig	Mon Oct 29 19:34:42 2001
+++ linux-2.4.12-ac3/arch/i386/kernel/io_apic.c	Sun Nov  4 15:53:05 2001
@@ -1616,3 +1616,35 @@
 	check_timer();
 	print_IO_APIC();
 }
+
+/*
+ * The purpose of this routine is to recover from hopeless situations,
+ * where the IO-APIC level interrupt no longer happens, despite the use
+ * of end_level_ioapic_irq().
+ *
+ * This happens mainly whith Ethernet cards under heavy network traffic,
+ * on boxes with streams of APIC errors.  The visible symptom is a message:
+ *
+ *	NETDEV WATCHDOG: eth0: transmit timed out
+ *
+ * At this point, a driver-specific TX timout routine is called.  Upon
+ * return, the watchdog calls:
+ *
+ *	kick_IO_APIC_irq(dev->irq)
+ *
+ * to re-enable the interrupt source, or the machine may be stuck without
+ * network, until rebooted.
+ *
+ * Idea was suggested by Manfred Spraul, implemented by Raphael Manfredi.
+ */
+void kick_IO_APIC_irq(int irq)
+{
+	printk(KERN_CRIT "Kicking IO-APIC IRQ %d:\n", irq);
+
+	spin_lock(&ioapic_lock);
+	__mask_and_edge_IO_APIC_irq(irq);
+	udelay(10);
+	__unmask_and_level_IO_APIC_irq(irq);
+	spin_unlock(&ioapic_lock);
+}
+
--- linux-2.4.12-ac3/net/sched/sch_generic.c.orig	Sun Nov  4 15:47:10 2001
+++ linux-2.4.12-ac3/net/sched/sch_generic.c	Sun Nov  4 15:51:14 2001
@@ -153,6 +153,7 @@
 			    (jiffies - dev->trans_start) > dev->watchdog_timeo) {
 				printk(KERN_INFO "NETDEV WATCHDOG: %s: transmit timed out\n", dev->name);
 				dev->tx_timeout(dev);
+				kick_IO_APIC_irq(dev->irq);		/* Added by RAM */
 			}
 			if (!mod_timer(&dev->watchdog_timer, jiffies + dev->watchdog_timeo))
 				dev_hold(dev);
