Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVDFWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVDFWNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVDFWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:13:34 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:39335 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S262325AbVDFWNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:13:22 -0400
Date: Wed, 6 Apr 2005 18:13:16 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: clock runs at double speed on x86_64 system w/ATI RS200
 chipset (workaround for APIC mode?)
In-Reply-To: <20050405183141.GA27195@muc.de>
Message-ID: <Pine.LNX.4.58.0504061758150.4573@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch gets the clock to work normally for me without
disabling APIC mode entirely. But I'm still not sure what's going on.


dmesg of 2.6.11.6 with default options (ACPI, APIC, 'apic=debug'):
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic

dmesg with patch, and 'timerhack apic=debug':
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug-timerhack
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic-timerhack


The patch causes the timer to be routed via the "Virtual Wire IRQ" mode,
and I see in /proc/interrupts:

	  0:     376947  local-APIC-edge  timer

instead of 'IO-APIC-edge'. I no longer get duplicate timer interrupts; it
seems to track the 'LOC' interrupt count normally.


The crucial part of the patch, besides skipping attempting to set up the
timer IRQ through the APIC mp_INT or mp_ExtINT, is:

	clear_IO_APIC_pin(0, pin1)


Without this function call, I still get duplicate timer interrupts when
using Virtual Wire to route the timer.


I'm still seeing 'APIC error on CPU0: 00(40)' messages from time to time.


-Chris
wingc@engin.umich.edu



--- linux-2.6.11.6/arch/x86_64/kernel/io_apic.c.orig	2005-03-25 22:28:21.000000000 -0500
+++ linux-2.6.11.6/arch/x86_64/kernel/io_apic.c	2005-04-06 17:56:46.486511088 -0400
@@ -1564,6 +1564,8 @@
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
+static int timer_hack = 0;
+
 static inline void check_timer(void)
 {
 	int pin1, pin2;
@@ -1592,6 +1594,10 @@

 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);

+    if (timer_hack) {
+	/* for some reason this stops duplicate timer IRQ? */
+	clear_IO_APIC_pin(0, pin1);
+    } else {
 	if (pin1 != -1) {
 		/*
 		 * Ok, does IRQ0 through the IOAPIC work?
@@ -1633,6 +1639,7 @@
 		clear_IO_APIC_pin(0, pin2);
 	}
 	printk(" failed.\n");
+    }

 	if (nmi_watchdog) {
 		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
@@ -1669,6 +1676,14 @@
 	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
 }

+static int __init timerhack(char *str)
+{
+	timer_hack = 1;
+	return 1;
+}
+__setup("timerhack", timerhack);
+
+
 /*
  *
  * IRQ's that are handled by the PIC in the MPS IOAPIC case.
