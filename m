Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRJaXZV>; Wed, 31 Oct 2001 18:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJaXZN>; Wed, 31 Oct 2001 18:25:13 -0500
Received: from AGrenoble-101-1-3-57.abo.wanadoo.fr ([193.253.251.57]:4485 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S275571AbRJaXZF>;
	Wed, 31 Oct 2001 18:25:05 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] back from NETDEV WATCHDOG: eth0: transmit timed out
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Wed, 31 Oct 2001 23:51:56 +0100
Message-ID: <22563.1004568716@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a way to get me out of the dreadful

	NETDEV WATCHDOG: eth0: transmit timed out

condition, which irremediably used to hang the network on my machine,
forcing me to reboot.

This fix was inspired by the long thread between Manfred Spraul and
Franck de Lange, a while back.

The fix leads to the following trail in kern.log:

 NETDEV WATCHDOG: eth0: transmit timed out
 eth0: Tx queue start entry 23742746  dirty entry 23742742.
 eth0:  Tx descriptor 0 is 00002000.
 eth0:  Tx descriptor 1 is 00002000.
 eth0:  Tx descriptor 2 is 00002000. (queue head)
 eth0:  Tx descriptor 3 is 00002000.
 eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
 Kicking IO-APIC pin #16:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 Before:
  00 003 03  0    1    1   1   0    1    1    91
 After switching to edge:
  00 003 03  0    0    1   1   0    1    1    91
 After switch back:
  00 003 03  0    1    1   1   0    1    1    91
 nfs: server lyon not responding, still trying
 nfs: server lyon not responding, still trying
 nfs: server lyon OK
 nfs: server lyon OK

Here's the patch.  It only fixes the 8139too.c network driver, because
this is the one relevant for me.  Perhaps this can be added to other
drivers as well?

NOTE: the printk(KERN_EMERG) is probably too high for logging everything.
A KERN_CRIT would perhaps be more suitable, but Manfred had used this
in his patch, and I respected his decision.  However, having all my xterms
clogged with:

	Message from syslogd@nice at Wed Oct 31 23:37:36 2001 ...
	nice kernel: Kicking IO-APIC pin #16: 

is probably excessive ;-)

Raphael

--- ./drivers/net/8139too.c.orig	Mon Oct 29 19:33:34 2001
+++ ./drivers/net/8139too.c	Mon Oct 29 19:47:09 2001
@@ -1732,6 +1732,7 @@
 
 	/* ...and finally, reset everything */
 	rtl8139_hw_start (dev);
+	kick_IOAPIC_pin(dev->irq);		/* Added by RAM */
 
 	netif_wake_queue (dev);
 }
--- ./arch/i386/kernel/io_apic.c.orig	Mon Oct 29 19:34:42 2001
+++ ./arch/i386/kernel/io_apic.c	Mon Oct 29 19:45:18 2001
@@ -1616,3 +1616,59 @@
 	check_timer();
 	print_IO_APIC();
 }
+
+/*
+ * Added by RAM, from Manfred Spraul
+ */
+static void print_line(struct IO_APIC_route_entry* entry)
+{
+	printk(KERN_EMERG " %02x %03X %02X  ",
+		0,
+		entry->dest.logical.logical_dest,
+		entry->dest.physical.physical_dest
+	);
+	printk("%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
+		entry->mask,
+		entry->trigger,
+		entry->irr,
+		entry->polarity,
+		entry->delivery_status,
+		entry->dest_mode,
+		entry->delivery_mode,
+		entry->vector
+	);
+}
+
+void kick_IOAPIC_pin(int pin)
+{
+	unsigned long flags;
+	struct IO_APIC_route_entry entry;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+
+	*(((int *)&entry) + 1) = io_apic_read(0, 0x11 + 2 * pin);
+	*(((int *)&entry) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+
+	printk(KERN_EMERG "Kicking IO-APIC pin #%d:\n", pin);
+	printk(KERN_EMERG " NR Log Phy Mask Trig IRR Pol"
+					  " Stat Dest Deli Vect:   \n");
+	printk(KERN_EMERG "Before:\n");
+	print_line(&entry);
+
+	entry.trigger = 0;
+	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	udelay(10);
+	printk(KERN_EMERG "After switching to edge:\n");
+	print_line(&entry);
+
+	entry.trigger = 1;
+	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	udelay(10);
+	printk(KERN_EMERG "After switch back:\n");
+	print_line(&entry);
+
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
