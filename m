Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWEaKTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWEaKTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWEaKTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:19:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58286 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751577AbWEaKTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:19:05 -0400
Date: Wed, 31 May 2006 12:19:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: tglx@linutronix.de, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch, -rc5-mm1] genirq: add chip->eoi(), fastack -> fasteoi
Message-ID: <20060531101925.GA27637@elte.hu>
References: <1149040361.766.10.camel@localhost.localdomain> <1149064735.20582.85.camel@localhost.localdomain> <1149066718.766.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149066718.766.51.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > I see your point, but isn't EOI the chip specific implementation of 
> > chip->ack() in that case ?
> 
> Not ack, end :)
> 
> The ack is implicit when retreiving the irq number (when the irq 
> happens), the register is even called the ack register :) the EOI 
> isn't ack'ing, it's really "end of interrupt", that is end of handling 
> by the processor, thus the CPU local priority can be lowered to what 
> it was when the interrupt happened.

yeah. That's quite similar to how the APIC works on x86.

this is mostly a naming issue, and i agree it should be cleaned up some 
more . Right now the 'fastack' handler just cheats a bit and pretends 
that ->ack() is the EOI. But you are right and we could as well 
introduce a separate ->eoi() chip method that clearly separates an 
ack+mask+unmask based chip from an ->eoi chip. [I'd not reuse the 
->end() method because that really is a flow thing in many places and 
the conversion is cleaner. Having one more entry in the chip operations 
structure is no big issue.]

> [...] Beside, eoi _must_ be called wether it was masked in between or 
> not or the controller will lose track.

correct - and that must happen for x86 APICs too. This is a plain bug in 
the fastack handler.

sounds like a plan? The patch below works fine for me.

	Ingo

----------------
Subject: genirq: add chip->eoi(), fastack -> fasteoi
From: Ingo Molnar <mingo@elte.hu>

clean up the fastack concept by turning it into fasteoi and
introducing the ->eoi() method for chips.

this also allows the cleanup of an i386 EOI quirk - now the
quirk is cleanly separated from the pure ACK implementation.

the patch also enables the fasteoi handler for i386 level-triggered
IO-APIC irqs.

tested on i386 and x86_64 with MSI on and off as well.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/io_apic.c   |   28 +++++++++++++++++++---------
 arch/x86_64/kernel/io_apic.c |    9 +++++----
 include/linux/irq.h          |    6 ++++--
 kernel/irq/chip.c            |   25 ++++++++++++-------------
 4 files changed, 40 insertions(+), 28 deletions(-)

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1214,7 +1214,7 @@ static void ioapic_register_intr(int irq
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler(idx, &ioapic_chip,
-					 handle_level_irq);
+					 handle_fasteoi_irq);
 	else
 		set_irq_chip_and_handler(idx, &ioapic_chip,
 					 handle_edge_irq);
@@ -1946,6 +1946,12 @@ static unsigned int startup_ioapic_irq(u
 	return was_pending;
 }
 
+static void ack_ioapic_irq(unsigned int irq)
+{
+	move_irq(irq);
+	ack_APIC_irq();
+}
+
 static void ack_ioapic_quirk_irq(unsigned int irq)
 {
 	unsigned long v;
@@ -1971,11 +1977,6 @@ static void ack_ioapic_quirk_irq(unsigne
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
-	if (irq_desc[irq].handle_irq == handle_edge_irq) {
-		ack_APIC_irq();
-		return;
-	}
-
 	i = IO_APIC_VECTOR(irq);
 
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
@@ -1998,6 +1999,14 @@ static unsigned int startup_ioapic_vecto
 	return startup_ioapic_irq(irq);
 }
 
+static void ack_ioapic_vector(unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+
+	move_native_irq(vector);
+	ack_ioapic_irq(irq);
+}
+
 static void ack_ioapic_quirk_vector(unsigned int vector)
 {
 	int irq = vector_to_irq(vector);
@@ -2050,7 +2059,8 @@ static struct irq_chip ioapic_chip __rea
 	.startup 	= startup_ioapic_vector,
 	.mask	 	= mask_IO_APIC_vector,
 	.unmask	 	= unmask_IO_APIC_vector,
-	.ack 		= ack_ioapic_quirk_vector,
+	.ack 		= ack_ioapic_vector,
+	.eoi 		= ack_ioapic_quirk_vector,
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity,
 #endif
@@ -2124,7 +2134,7 @@ static struct irq_chip lapic_chip __read
 	.name		= "local-APIC-edge",
 	.mask		= mask_lapic_irq,
 	.unmask		= unmask_lapic_irq,
-	.ack		= ack_apic,
+	.eoi		= ack_apic,
 };
 
 static void setup_nmi (void)
@@ -2305,7 +2315,7 @@ static inline void check_timer(void)
 	printk(KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
 
 	disable_8259A_irq(0);
-	set_irq_chip_and_handler(0, &lapic_chip, handle_fastack_irq);
+	set_irq_chip_and_handler(0, &lapic_chip, handle_fasteoi_irq);
 	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -865,7 +865,7 @@ static void ioapic_register_intr(int irq
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler(idx, &ioapic_chip,
-					 handle_fastack_irq);
+					 handle_fasteoi_irq);
 	else
 		set_irq_chip_and_handler(idx, &ioapic_chip,
 					 handle_edge_irq);
@@ -970,7 +970,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	set_irq_chip_and_handler(0, &ioapic_chip, handle_fastack_irq);
+	set_irq_chip_and_handler(0, &ioapic_chip, handle_fasteoi_irq);
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -1563,6 +1563,7 @@ static struct irq_chip ioapic_chip __rea
 	.mask	 	= mask_ioapic_vector,
 	.unmask	 	= unmask_ioapic_vector,
 	.ack 		= ack_apic,
+	.eoi 		= ack_apic,
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity_vector,
 #endif
@@ -1626,7 +1627,7 @@ static struct irq_chip lapic_chip __read
 	.name		= "local-APIC-edge",
 	.mask		= mask_lapic_irq,
 	.unmask		= unmask_lapic_irq,
-	.ack		= ack_apic,
+	.eoi		= ack_apic,
 };
 
 static void setup_nmi (void)
@@ -1808,7 +1809,7 @@ static inline void check_timer(void)
 	apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
 
 	disable_8259A_irq(0);
-	set_irq_chip_and_handler(0, &lapic_chip, handle_fastack_irq);
+	set_irq_chip_and_handler(0, &lapic_chip, handle_fasteoi_irq);
 	apic_write(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
Index: linux/include/linux/irq.h
===================================================================
--- linux.orig/include/linux/irq.h
+++ linux/include/linux/irq.h
@@ -73,7 +73,8 @@ struct proc_dir_entry;
  * @mask:		mask an interrupt source
  * @mask_ack:		ack and mask an interrupt source
  * @unmask:		unmask an interrupt source
- * @end:		end of interrupt
+ * @eoi:		end of interrupt - chip level
+ * @end:		end of interrupt - flow level
  * @set_affinity:	set the CPU affinity on SMP machines
  * @retrigger:		resend an IRQ to the CPU
  * @set_type:		set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
@@ -93,6 +94,7 @@ struct irq_chip {
 	void		(*mask)(unsigned int irq);
 	void		(*mask_ack)(unsigned int irq);
 	void		(*unmask)(unsigned int irq);
+	void		(*eoi)(unsigned int irq);
 
 	void		(*end)(unsigned int irq);
 	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
@@ -286,7 +288,7 @@ extern int handle_IRQ_event(unsigned int
 extern void fastcall
 handle_level_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
 extern void fastcall
-handle_fastack_irq(unsigned int irq, struct irq_desc *desc,
+handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc,
 			 struct pt_regs *regs);
 extern void fastcall
 handle_edge_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -280,18 +280,18 @@ out:
 }
 
 /**
- *	handle_fastack_irq - irq handler for transparent controllers
+ *	handle_fasteoi_irq - irq handler for transparent controllers
  *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *	@regs:	pointer to a register structure
  *
- *	Only a single callback will be issued to the chip: an ->ack()
+ *	Only a single callback will be issued to the chip: an ->eoi()
  *	call when the interrupt has been serviced. This enables support
  *	for modern forms of interrupt handlers, which handle the flow
  *	details in hardware, transparently.
  */
 void fastcall
-handle_fastack_irq(unsigned int irq, struct irq_desc *desc,
+handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc,
 		   struct pt_regs *regs)
 {
 	unsigned int cpu = smp_processor_id();
@@ -324,10 +324,9 @@ handle_fastack_irq(unsigned int irq, str
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 out:
-	if (!(desc->status & IRQ_DISABLED))
-		desc->chip->ack(irq);
-	else
+	if (unlikely(desc->status & IRQ_DISABLED))
 		desc->chip->mask(irq);
+	desc->chip->eoi(irq);
 
 	spin_unlock(&desc->lock);
 }
@@ -507,19 +506,19 @@ handle_irq_name(void fastcall (*handle)(
 					struct pt_regs *))
 {
 	if (handle == handle_level_irq)
-		return "level ";
-	if (handle == handle_fastack_irq)
-		return "level ";
+		return "level  ";
+	if (handle == handle_fasteoi_irq)
+		return "fasteoi";
 	if (handle == handle_edge_irq)
-		return "edge  ";
+		return "edge   ";
 	if (handle == handle_simple_irq)
-		return "simple";
+		return "simple ";
 #ifdef CONFIG_SMP
 	if (handle == handle_percpu_irq)
-		return "percpu";
+		return "percpu ";
 #endif
 	if (handle == handle_bad_irq)
-		return "bad   ";
+		return "bad    ";
 
 	return NULL;
 }
