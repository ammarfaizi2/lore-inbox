Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317928AbSFNPHL>; Fri, 14 Jun 2002 11:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317929AbSFNPHK>; Fri, 14 Jun 2002 11:07:10 -0400
Received: from AGrenoble-202-1-1-27.abo.wanadoo.fr ([80.14.157.27]:744 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S317928AbSFNPHJ>;
	Fri, 14 Jun 2002 11:07:09 -0400
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: The buggy APIC of the Abit BP6
Date: 14 Jun 2002 15:07:00 GMT
Organization: Home, Grenoble, France
Message-ID: <aed0qk$4b3$1@lyon.ram.loc>
In-Reply-To: <000201c21261$3a8fde70$020da8c0@nitemare>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robbert Kouprie <robbert@radium.jvb.tudelft.nl> from ml.linux.kernel:
:I am experiencing problems for a long time now, which are always related
:to the NIC in the box (probably due the being a device that generates a
:lot of interrupts). The NIC has changed a couple of times (from 3com 10
:Mbit to Intel eepro100 to 3Com PCI 3c905B Cyclone 100baseTx now), and
:it's NOT placed in the infamous (I believe 3rd) PCI slot of the board
:(mentioned in the manual). Also, /proc/interrups shows NO sharing with
:another device. The running kernel is 2.4.19-pre8-ac5 SMP, though many
:kernels have preceded it, with the same results.

Here's my own solution for it, in an old article.  I've been running
with this patch since then, and transmit timeouts have never been a problem.

I run 2.4.18-pre7 nowadays, and the patch below applied without problem.

Raphael

------------------------------------------------------------------------
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Recover from lockups after "eth0: transmit timed out"
Date: Thu, 08 Nov 2001 19:42:05 +0100
Message-ID: <30043.1005244925@nice.ram.loc>

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
