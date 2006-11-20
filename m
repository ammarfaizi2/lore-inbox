Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966375AbWKTSaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966375AbWKTSaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966388AbWKTSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:30:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20616 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966387AbWKTSaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:30:05 -0500
Date: Mon, 20 Nov 2006 19:29:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120182902.GA23957@elte.hu>
References: <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com> <20061120172642.GA8683@elte.hu> <20061120175502.GA12733@elte.hu> <1164046818.3028.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164046818.3028.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > -               desc->chip->mask(irq);
> > -               desc->chip->ack(irq);
> > +               if (desc->chip->mask)
> > +                       desc->chip->mask(irq);
> > +               if (desc->chip->mask)
> > +                       desc->chip->ack(irq);
> >         }
> >  } 
> 
> Did you mean to check ->mask both times here?

good catch - fixed patch below.

	Ingo

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1272,22 +1272,12 @@ static struct irq_chip ioapic_chip;
 static void ioapic_register_intr(int irq, int vector, unsigned long trigger)
 {
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-			trigger == IOAPIC_LEVEL) {
-#ifdef CONFIG_PREEMPT_HARDIRQS
+			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					    handle_level_irq, "level-threaded");
-#else
-		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					      handle_fasteoi_irq, "fasteoi");
-#endif
-	} else {
-#ifdef CONFIG_PREEMPT_HARDIRQS
+					 handle_fasteoi_irq, "fasteoi");
+	else {
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					      handle_edge_irq, "edge-threaded");
-#else
-		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					      handle_edge_irq, "edge");
-#endif
+					 handle_edge_irq, "edge");
 	}
 	set_intr_gate(vector, interrupt[irq]);
 }
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -787,22 +787,12 @@ static struct irq_chip ioapic_chip;
 static void ioapic_register_intr(int irq, int vector, unsigned long trigger)
 {
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-			trigger == IOAPIC_LEVEL) {
-#ifdef CONFIG_PREEMPT_HARDIRQS
-		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					    handle_level_irq, "level-threaded");
-#else
+			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					      handle_fasteoi_irq, "fasteoi");
-#endif
-	} else {
-#ifdef CONFIG_PREEMPT_HARDIRQS
-		set_irq_chip_and_handler_name(irq, &ioapic_chip,
-					      handle_edge_irq, "edge-threaded");
-#else
+	else {
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					      handle_edge_irq, "edge");
-#endif
 	}
 }
 
Index: linux/kernel/Kconfig.preempt
===================================================================
--- linux.orig/kernel/Kconfig.preempt
+++ linux/kernel/Kconfig.preempt
@@ -105,7 +105,7 @@ config PREEMPT_SOFTIRQS
 config PREEMPT_HARDIRQS
 	bool "Thread Hardirqs"
 	default n
-#	depends on PREEMPT
+	depends on !GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This option reduces the latency of the kernel by 'threading'
           hardirqs. This means that all (or selected) hardirqs will run
Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -238,8 +238,10 @@ static inline void mask_ack_irq(struct i
 	if (desc->chip->mask_ack)
 		desc->chip->mask_ack(irq);
 	else {
-		desc->chip->mask(irq);
-		desc->chip->ack(irq);
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
+		if (desc->chip->ack)
+			desc->chip->ack(irq);
 	}
 }
 
Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c
+++ linux/kernel/irq/handle.c
@@ -266,12 +266,6 @@ fastcall notrace unsigned int __do_IRQ(u
 		goto out;
 
 	/*
-	 * hardirq redirection to the irqd process context:
-	 */
-	if (redirect_hardirq(desc))
-		goto out_no_end;
-
-	/*
 	 * Edge triggered interrupts need to remember
 	 * pending events.
 	 * This applies to any hw interrupts that allow a second
@@ -303,7 +297,6 @@ out:
 	 * disabled while the handler was running.
 	 */
 	desc->chip->end(irq);
-out_no_end:
 	spin_unlock(&desc->lock);
 
 	return 1;
