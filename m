Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293109AbSCOStl>; Fri, 15 Mar 2002 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCOSt3>; Fri, 15 Mar 2002 13:49:29 -0500
Received: from users.ccur.com ([208.248.32.211]:27362 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293109AbSCOSrt>;
	Fri, 15 Mar 2002 13:47:49 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203151845.SAA27079@rudolph.ccur.com>
Subject: Re: Advanced Programmable Interrupt Controller (APIC)?
To: timk@advfn.com
Date: Fri, 15 Mar 2002 13:45:25 -0500 (EST)
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <200203151617.g2FGHKs28765@mail.advfn.com> from "Tim Kay" at Mar 15, 2002 04:18:58 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IO APIC - APIC_IO: Testing 8254 interrupt delivery
> APIC_IO: Broken MP table detected: 8254 is not connected to IOAPIC #0
> intpin 2 
> APIC_IO: routing 8254 via 8259 and IOAPIC #0 intpin 0 
> 
> The above is a diagnostic from a FreeBSD box bootup, this would seem to 
> suggest that the motherboard rather than Linux is at fault....
> 
>>> Now I've
>>> also heard that DELL does not properly setup the APIC chip in
>>> the bios because MS os's don't use it. Have no idea if this
>>> is true or not.
>>
>> To the best of my knowledge, BIOS and Linux work together to set up the
>> APICs properly on the PowerEdge 6400 (and all our other servers too).  If
>> someone has proof that we don't, and what should be done instead, please
>> let me know.

--------------------

You might try Maciej W. Rozycki's latest IRQ0 patch, included below.  It
fixes a similar problem with IRQ0 on the Dell PowerEdge server boxes.

Joe

--------------------

> From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>,
>        Linus Torvalds <torvalds@transmeta.com>
> cc: Ingo Molnar <mingo@chiara.elte.hu>, Joe Korty <joe.korty@ccur.com>
> Subject: [patch] 2.4.18, 2.5.5: I/O APIC through-8259A mode IRQ 0 routing
> Organization: Technical University of Gdansk

Hello,

 There is a problem with the through-8259A mode for IRQ 0 on I/O APIC
systems.  Depending on correctness of an MP table, IRQ 0 routing is either
not registered at all or registered at a wrong pin.  As a result the 8254
timer IRQ only works by an accident (it's edge-triggered and never
disabled/enabled so it happens to survive this incorrect configuration). 
A visible effect is you can't change the affinity for IRQ 0. 

 Following is a patch that fixes both cases referred to above.  The code
looks obvious but it was additionally run-time tested just in case.  The
issue is serious -- please apply the patch ASAP.  As no changes were done
to io_apic.c since the development fork, the patch applies cleanly both to
2.4 and to 2.5. 

 Credit goes to Joe for discovering the affinity problem and providing a
fix proposal (incorporated in the final one). 

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

