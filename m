Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSDQTLY>; Wed, 17 Apr 2002 15:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313510AbSDQTLX>; Wed, 17 Apr 2002 15:11:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57557 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313529AbSDQTLW>;
	Wed, 17 Apr 2002 15:11:22 -0400
Date: Wed, 17 Apr 2002 19:07:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: James Bourne <jbourne@MtRoyal.AB.CA>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204171237010.21779-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.4.44.0204171907180.5540-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Apr 2002, James Bourne wrote:

> Where would I find this separate patch?  Is there something I could do
> some testing on?

the timer irq inbalance problem should be solved by the attached patch.

	Ingo

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

