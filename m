Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCPBf1>; Thu, 15 Mar 2001 20:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRCPBfS>; Thu, 15 Mar 2001 20:35:18 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:28766 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S129506AbRCPBfC>; Thu, 15 Mar 2001 20:35:02 -0500
Date: Thu, 15 Mar 2001 17:34:18 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.2 and AMD-760MP I/O APIC
Message-ID: <20010315173418.G25511@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The I/O APIC code for 2.2 contains a little trick which sets the destination
to 0 to disable an I/O APIC entry. This apparently trips up the I/O APIC
on AMD-760MP systems causing a lockup during boot.

This patch removes that trick in favor of doing what 2.4 does, masking out
the entries.

This patch is relative to 2.2.18, but should apply cleanly to 2.2.19-pre
since -pre17 doesn't touch this code at all.

JE

--- linux-2.2.18.orig/arch/i386/kernel/io_apic.c	Mon Sep  4 13:39:16 2000
+++ linux-2.2.18/arch/i386/kernel/io_apic.c	Thu Mar 15 17:23:46 2001
@@ -200,8 +200,6 @@
  * We disable IO-APIC IRQs by setting their 'destination CPU mask' to
  * zero. Trick by Ramesh Nalluri.
  */
-DO_ACTION( disable, 1, &= 0x00ffffff, io_apic_sync(entry->apic))/* destination = 0x00 */
-DO_ACTION( enable,  1, |= 0xff000000, )				/* destination = 0xff */
 DO_ACTION( mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
 DO_ACTION( unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
 
@@ -612,7 +610,7 @@
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = 1;			/* logical delivery */
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 0;	/* but no route */
+		entry.dest.logical.logical_dest = 0xff;	/* but no route */
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -1017,13 +1015,10 @@
 static void enable_edge_ioapic_irq(unsigned int irq)
 {
 	self_IPI(irq);
-	enable_IO_APIC_irq(irq);
+	unmask_IO_APIC_irq(irq);
 }
 
-static void disable_edge_ioapic_irq(unsigned int irq)
-{
-	disable_IO_APIC_irq(irq);
-}
+static void disable_edge_ioapic_irq(unsigned int irq) { /* nothing */ }
 
 /*
  * Starting up a edge-triggered IO-APIC interrupt is
@@ -1239,7 +1234,7 @@
 
 	pin1 = find_timer_pin(mp_INT);
 	pin2 = find_timer_pin(mp_ExtINT);
-	enable_IO_APIC_irq(0);
+	unmask_IO_APIC_irq(0);
 	if (!timer_irq_works()) {
 
 		if (pin1 != -1)
