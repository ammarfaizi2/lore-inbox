Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVDFUhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVDFUhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVDFUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:37:54 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:21664 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S262325AbVDFUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:36:32 -0400
Date: Wed, 6 Apr 2005 16:36:21 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <20050405183141.GA27195@muc.de>
Message-ID: <Pine.LNX.4.58.0504061605450.4573@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the x86_64 kernel has 4 different ways of configuring the
timer interrupt in APIC mode:

arch/x86_64/kernel/io_apic.c :

/* style 1 */
        if (pin1 != -1) {
                /*
                 * Ok, does IRQ0 through the IOAPIC work?
                 */

/* style 2 */
        apic_printk(APIC_VERBOSE,KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
        if (pin2 != -1) {
                apic_printk(APIC_VERBOSE,"\n..... (found pin %d) ...", pin2);
                /*
                 * legacy devices should be connected to IO APIC #0
                 */

/* style 3 */
        apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");


/* style 4 */
        apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as ExtINT IRQ...");


I hacked the kernel with the following patch to try using all 4 timer
configurations. (by overriding 'pin1' and 'pin2', and by bypassing the
code that sets up 'Virtual Wire IRQ')

Unfortunately I wasn't able to change the behavior in any case. I couldn't
get the last configuration ('trying to set up timer as ExtINT IRQ') to
work; the machine just hung. I'm guessing that the code
io_apic.c::unlock_ExtINT_logic() may have never been tested on AMD chips?

No matter what I did, the clock still ran at double normal speed. Perhaps
we are just programming the APIC incorrectly for this board in some way?


booting with standard options (ACPI enabled, 'apic=debug'); this uses
method 1:
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic

booting with 'force_apic_timer=-1,0 apic=debug' to force it to use method
#2 to route the timer interrupt:
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug-forcetimer=-1,0
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic-forcetimer=-1,0

booting with 'force_apic_timer=-1,-1 apic=debug' to force it to use method
#3:
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug-forcetimer=-1,-1
	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic-forcetimer=-1,-1

	(note that /proc/interrupts says 'local-APIC-edge' for timer
interrupt, but it still receives twice as many interrupts)

booting with 'force_apic_timer=-1,-1 novwtimer apic=debug' to force it to
use method #4:

	(machine just hangs when trying to set up the timer)


-Chris
wingc@engin.umich.edu



--- linux-2.6.11.6/arch/x86_64/kernel/io_apic.c.orig	2005-03-25 22:28:21.000000000 -0500
+++ linux-2.6.11.6/arch/x86_64/kernel/io_apic.c	2005-04-06 16:28:25.120441232 -0400
@@ -1564,6 +1564,10 @@
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
+static int apic_timer_forced = 0;
+static int force_pin1, force_pin2;
+static int force_novwtimer = 0;
+
 static inline void check_timer(void)
 {
 	int pin1, pin2;
@@ -1587,8 +1591,13 @@
 	init_8259A(1);
 	enable_8259A_irq(0);

-	pin1 = find_isa_irq_pin(0, mp_INT);
-	pin2 = find_isa_irq_pin(0, mp_ExtINT);
+	if (apic_timer_forced) {
+		pin1 = force_pin1;
+		pin2 = force_pin2;
+	} else {
+		pin1 = find_isa_irq_pin(0, mp_INT);
+		pin2 = find_isa_irq_pin(0, mp_ExtINT);
+	}

 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);

@@ -1639,6 +1648,7 @@
 		nmi_watchdog = 0;
 	}

+    if (!force_novwtimer) {
 	apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");

 	disable_8259A_irq(0);
@@ -1652,6 +1662,7 @@
 	}
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
 	apic_printk(APIC_VERBOSE," failed.\n");
+    }

 	apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as ExtINT IRQ...");

@@ -1669,6 +1680,41 @@
 	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
 }

+static int __init force_apic_timer(char *str)
+{
+	int timer_irqs[3];
+
+	get_options(str, ARRAY_SIZE(timer_irqs), timer_irqs);
+	if (timer_irqs[0] != 2) {
+		printk(KERN_WARNING "force_apic_timer must specify pin1,pin2\n");
+		goto out;
+	}
+
+	apic_timer_forced = 1;
+	force_pin1 = timer_irqs[1];
+	force_pin2 = timer_irqs[2];
+
+out:
+	return 1;
+}
+
+static int __init novwtimer(char *str)
+{
+	force_novwtimer = 1;
+	return 1;
+}
+
+static int __init noirq(char *str)
+{
+	force_noirq = 1;
+	return 1;
+}
+
+__setup("force_apic_timer=", force_apic_timer);
+__setup("novwtimer", novwtimer);
+__setup("noirq", noirq);
+
+
 /*
  *
  * IRQ's that are handled by the PIC in the MPS IOAPIC case.
