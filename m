Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284210AbRLFU3x>; Thu, 6 Dec 2001 15:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLFU3g>; Thu, 6 Dec 2001 15:29:36 -0500
Received: from AGrenoble-101-1-1-146.abo.wanadoo.fr ([193.251.23.146]:44498
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S284210AbRLFU3V>; Thu, 6 Dec 2001 15:29:21 -0500
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: "NETDEV WATCHDOG eth0 transmit timeout" fun with ne2k-pci
Date: 6 Dec 2001 19:55:58 GMT
Organization: Home, Grenoble, France
Message-ID: <9uoige$cq4$1@lyon.ram.loc>
In-Reply-To: <1007571044.26591.7.camel@stud-assoc-pc2.rice.edu>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <1007571044.26591.7.camel@stud-assoc-pc2.rice.edu>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joshua Adam Ginsberg <rainman@owlnet.rice.edu> from ml.linux.kernel:
:I'm having that problem running a Winbond 89c940 (which I could swear is
:on a Linksys card) using the ne2k-pci drivers on the 2.4.7-10 that ships
:with RH7.2...
:
:Any hope in an easy resolution to this?

If it hangs your machine, and you have an APIC, then try the following
patch.

Raphael

-----------------------------------------------------------------
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

