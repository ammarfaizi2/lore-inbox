Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293439AbSCARmL>; Fri, 1 Mar 2002 12:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSCARl4>; Fri, 1 Mar 2002 12:41:56 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:63471 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S293439AbSCARlh>; Fri, 1 Mar 2002 12:41:37 -0500
Date: Fri, 1 Mar 2002 18:41:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe Korty <joe.korty@ccur.com>, Ingo Molnar <mingo@chiara.elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] irq0 affinity broke on some i386 boxes
In-Reply-To: <200202251856.SAA11120@rudolph.ccur.com>
Message-ID: <Pine.GSO.3.96.1020301181736.3130F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Joe Korty wrote:

>   The following patch fixes a bug that prevents a write to
> /proc/irq/0/smp_affinity from actually changing the cpu affinity
> of IRQ #0, on all the (Dell server) SMP machines I have access to.

 A nice spotting.  However what you describe is only a side effect of the
bug, which is the IRQ is kept registered at the wrong pin.  It's only
because the timer is special and it's edge-triggered it remained unnoticed
for so long.

 I propose the following patch.  Instead of adding the new pin to the IRQ
0 registry unconditionally, it replaces the already registered pin if one
exists, otherwise it adds the new one.  The reason is to remove the
reference to the old pin, which may be connected to an unknown device or
simply dangling and weird things may happen if it ever gets unmasked. 
There is also a small performance impact of keeping two pins registered
for a single IRQ.

 I don't know if the changes are relevant to your system as you haven't
sent the relevant fragment of a bootstrap log from your system.  They
affect all systems that have a bogus IRQ 0 entry in the MP table.  For
other systems the patch is equivalent to yours.  Please test it if it
works for you as I don't have a suitable system with IRQ 0 unconnected
(I've been able to verify it builds only).  Everyone with such a system is
invited to test the patch as well.

 If results are positive, the patch will be submitted as is for inclusion
into 2.4 and 2.5. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.18-irq0_pin-1
diff -up --recursive --new-file linux-2.4.18.macro/arch/i386/kernel/io_apic.c linux-2.4.18/arch/i386/kernel/io_apic.c
--- linux-2.4.18.macro/arch/i386/kernel/io_apic.c	Fri Nov 23 15:32:04 2001
+++ linux-2.4.18/arch/i386/kernel/io_apic.c	Fri Mar  1 14:58:20 2002
@@ -67,7 +67,7 @@ static struct irq_pin_list {
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
@@ -85,6 +85,26 @@ static void add_pin_to_irq(unsigned int 
 	entry->pin = pin;
 }
 
+/*
+ * Reroute an IRQ to a different pin.
+ */
+static void __init replace_pin_at_irq(unsigned int irq,
+				      int oldapic, int oldpin,
+				      int newapic, int newpin)
+{
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	while (1) {
+		if (entry->apic == oldapic && entry->pin == oldpin) {
+			entry->apic = newapic;
+			entry->pin = newpin;
+		}
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
+
 #define __DO_ACTION(R, ACTION, FINAL)					\
 									\
 {									\
@@ -1533,6 +1553,10 @@ static inline void check_timer(void)
 		setup_ExtINT_IRQ0_pin(pin2, vector);
 		if (timer_irq_works()) {
 			printk("works.\n");
+			if (pin1 != -1)
+				replace_pin_at_irq(0, 0, pin1, 0, pin2);
+			else
+				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
 				check_nmi_watchdog();

