Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbRA2TG7>; Mon, 29 Jan 2001 14:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131978AbRA2TGw>; Mon, 29 Jan 2001 14:06:52 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:408 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131091AbRA2TGg>; Mon, 29 Jan 2001 14:06:36 -0500
Date: Mon, 29 Jan 2001 19:46:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@chiara.elte.hu>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
Message-ID: <Pine.GSO.3.96.1010129182851.29329A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 After an extensive testing I concluded the infamous APIC lock-up happens
when a level-triggered interrupt gets masked in an I/O APIC when it's in
the send pending state (bit 12 of the respective interrupt redirection
entry is set).  Under this condition, the interrupt is still posted to
CPUs as set up by the redirection entry but with the trigger mode
incorrectly set to edge.  It's possible that setting the mask bit corrupts
somehow the state of the message in progress.  The I/O APIC still
remembers the interrupt to be level-triggered in the IRR bit so it expects
an EOI message from a local unit.  But no local unit is going to send it. 
The only way to recover from the lock-up of the entry is to program it for
the edge-trigged mode which resets the IRR bit. 

 It's possible to detect an incorrect trigger mode received at a local
APIC and reset the respective I/O APIC entry in case of a mismatch, but it
proved to be an overkill.  Manfred's idea of switching the mode upon
mask/unmask_IO_APIC_irq() costs us only two ALU instructions which is
really cheap, so we can afford having it unconditionally (a mismatch
detection would certainly cost us more, including a costly uncached local
APIC access).

 Following is a modification of Manfred's patch -- the original one was
making two r/w I/O APIC accesses unnecessarily.  It proved to work for me
under heavy interrupt load (I've chosen to set up my 8254 interrupt source
as level-triggered, which is a reliable way to provide lots of interrupts) 
with Andrew's IRQ whacker.  Without the patch I've repeatedly got an APIC
lockup after about 800k interrupts, which, I assume, was the point the
first disable_irq(0) was executed.  I've tested it on a DP i430HX board
equipped with an external 82093AA I/O APIC.

 The patch leaves the focus CPU feature enabled -- it does not seem to
make my system any less stable.  The fact that lock-ups were more likely
with the feature enabled is the result of a higher probability of
delivering consecutive interrupts from the same source to the same CPU,
hence it was also more probable for the interrupt to be in the send
pending state.  Empirical tests confirm this fact -- with the 8254
interrupt set up as level-triggered, both CPUs receive a similar number of
timer interrupts when the focus CPU feature is disabled and one of the
CPUs receives about twice more interrupts than the other one otherwise. 

 The patch should be safe for any 0x1x or 0x2x version of I/O APIC.  For
the 82489DX APIC the patch is probably harmful -- 82489DX APICs do not
define EOI messages but I/O units send level-deassert messages instead.  A
local unit considers an IRQ asserted as long as it does not receive a
deassert message.  By resetting an IRR bit in an I/O unit we would make it
asserted (almost) infinitely.  Since we are calling
mask/unmask_IO_APIC_irq() mostly indirectly, that should not be a problem
-- we may implement 82489DX-specific versions of the functions and install
them at run-time. 

 I'll implement an 82489DX update in a few days, but for now I'd like
everyone interested to test the following patch as much as possible.  It
applies to 2.4.0, 2.4.0-ac12 and 2.4.1-pre11 cleanly.

 Happy testing,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-io_apic-2
diff -up --recursive --new-file linux-2.4.0.macro/arch/i386/kernel/apic.c linux-2.4.0/arch/i386/kernel/apic.c
--- linux-2.4.0.macro/arch/i386/kernel/apic.c	Wed Dec 13 23:54:27 2000
+++ linux-2.4.0/arch/i386/kernel/apic.c	Sun Jan 28 08:58:02 2001
@@ -270,7 +270,7 @@ void __init setup_local_APIC (void)
 	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
 	 *   BX chipset. ]
 	 */
-#if 0
+#if 1
 	/* Enable focus processor (bit==0) */
 	value &= ~(1<<9);
 #else
diff -up --recursive --new-file linux-2.4.0.macro/arch/i386/kernel/io_apic.c linux-2.4.0/arch/i386/kernel/io_apic.c
--- linux-2.4.0.macro/arch/i386/kernel/io_apic.c	Thu Oct  5 21:08:17 2000
+++ linux-2.4.0/arch/i386/kernel/io_apic.c	Sun Jan 28 08:58:02 2001
@@ -122,8 +122,25 @@ static void add_pin_to_irq(unsigned int 
 	static void name##_IO_APIC_irq (unsigned int irq)		\
 	__DO_ACTION(R, ACTION, FINAL)
 
-DO_ACTION( __mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
-DO_ACTION( __unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
+/*
+ * It appears there is an erratum which affects at least the 82093AA
+ * I/O APIC.  If a level-triggered interrupt input is being masked in
+ * the redirection entry while the interrupt is send pending (its
+ * delivery status bit is set), the interrupt is erroneously
+ * delivered as edge-triggered but the IRR bit gets set nevertheless.
+ * As a result the I/O unit expects an EOI message but it will never
+ * arrive and further interrupts are blocked for the source.
+ *
+ * A workaround is to set the trigger mode to edge when masking
+ * a level-triggered interrupt and to revert the mode when unmasking.
+ * The idea is from Manfred Spraul.
+ */
+DO_ACTION( __mask,         0, = (reg & 0xffff7fff) | 0x00010000,
+	io_apic_sync(entry->apic))		/* mask = 1, trigger = edge */
+DO_ACTION( __unmask_edge,  0, &= 0xfffeffff,
+	)					/* mask = 0 */
+DO_ACTION( __unmask_level, 0, = (reg & 0xfffeffff) | 0x00008000,
+	)					/* mask = 0, trigger = level */
 
 static void mask_IO_APIC_irq (unsigned int irq)
 {
@@ -134,15 +151,26 @@ static void mask_IO_APIC_irq (unsigned i
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-static void unmask_IO_APIC_irq (unsigned int irq)
+static void unmask_edge_IO_APIC_irq (unsigned int irq)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__unmask_IO_APIC_irq(irq);
+	__unmask_edge_IO_APIC_irq(irq);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+static void unmask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__unmask_level_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+#define unmask_IO_APIC_irq unmask_edge_IO_APIC_irq
+
 void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
@@ -1116,7 +1144,7 @@ static int __init nmi_irq_works(void)
  * that was delayed but this is now handled in the device
  * independent code.
  */
-#define enable_edge_ioapic_irq unmask_IO_APIC_irq
+#define enable_edge_ioapic_irq unmask_edge_IO_APIC_irq
 
 static void disable_edge_ioapic_irq (unsigned int irq) { /* nothing */ }
 
@@ -1141,7 +1169,7 @@ static unsigned int startup_edge_ioapic_
 		if (i8259A_irq_pending(irq))
 			was_pending = 1;
 	}
-	__unmask_IO_APIC_irq(irq);
+	__unmask_edge_IO_APIC_irq(irq);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return was_pending;
@@ -1181,13 +1209,13 @@ static void end_edge_ioapic_irq (unsigne
  */
 static unsigned int startup_level_ioapic_irq (unsigned int irq)
 {
-	unmask_IO_APIC_irq(irq);
+	unmask_level_IO_APIC_irq(irq);
 
 	return 0; /* don't check for pending */
 }
 
 #define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_IO_APIC_irq
+#define enable_level_ioapic_irq		unmask_level_IO_APIC_irq
 #define disable_level_ioapic_irq	mask_IO_APIC_irq
 
 static void end_level_ioapic_irq (unsigned int i)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
