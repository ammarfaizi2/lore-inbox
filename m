Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbRBBMYM>; Fri, 2 Feb 2001 07:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRBBMXw>; Fri, 2 Feb 2001 07:23:52 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:62403 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129126AbRBBMXq>; Fri, 2 Feb 2001 07:23:46 -0500
Date: Fri, 2 Feb 2001 13:08:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <3A78B4B3.56EB5C28@uow.edu.au>
Message-ID: <Pine.GSO.3.96.1010202125033.28509C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Andrew Morton wrote:

> Your latest patch passes all my testing.
> 
> 2.4.1+irq-whacker+netperf:        APIC dies instantly
> 2.4.1+irq-whacker+netperf+patch:  8 million interrupts, then I got bored.

 Linus, would you please apply the following patch for 2.4.2?  The idea of
operation is described in the comment below.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-io_apic-4
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
+++ linux-2.4.0/arch/i386/kernel/io_apic.c	Tue Jan 30 07:49:01 2001
@@ -122,8 +122,27 @@ static void add_pin_to_irq(unsigned int 
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
+ * The idea is from Manfred Spraul.  --macro
+ */
+DO_ACTION( __mask,         0, |= 0x00010000,
+	)					/* mask = 1 */
+DO_ACTION( __unmask,       0, &= 0xfffeffff,
+	io_apic_sync(entry->apic))		/* mask = 0 */
+DO_ACTION( __mask_level,   0, = (reg & 0xffff7fff) | 0x00010000,
+	io_apic_sync(entry->apic))		/* mask = 1, trigger = edge */
+DO_ACTION( __unmask_level, 0, = (reg & 0xfffeffff) | 0x00008000,
+	)					/* mask = 0, trigger = level */
 
 static void mask_IO_APIC_irq (unsigned int irq)
 {
@@ -143,6 +162,24 @@ static void unmask_IO_APIC_irq (unsigned
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+static void mask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__mask_level_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+static void unmask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__unmask_level_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
@@ -1181,14 +1218,18 @@ static void end_edge_ioapic_irq (unsigne
  */
 static unsigned int startup_level_ioapic_irq (unsigned int irq)
 {
-	unmask_IO_APIC_irq(irq);
+	unmask_level_IO_APIC_irq(irq);
 
 	return 0; /* don't check for pending */
 }
 
-#define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
+#define shutdown_level_ioapic_irq	mask_level_IO_APIC_irq
+#define enable_level_ioapic_irq		unmask_level_IO_APIC_irq
+#define disable_level_ioapic_irq	mask_level_IO_APIC_irq
+
+#define shutdown_level_82489dx_irq	mask_IO_APIC_irq
+#define enable_level_82489dx_irq	unmask_IO_APIC_irq
+#define disable_level_82489dx_irq	mask_IO_APIC_irq
 
 static void end_level_ioapic_irq (unsigned int i)
 {
@@ -1503,6 +1544,27 @@ static inline void check_timer(void)
 }
 
 /*
+ * We can't set the trigger mode to edge when masking a
+ * level-triggered interrupt in the 82489DX I/O APIC as
+ * no deassert message will be sent in this case and a
+ * local APIC may keep delivering the interrupt to a CPU.
+ * Hence we substitute generic versions for affected
+ * handlers.
+ */
+
+static inline void setup_IO_APIC_irq_handlers(void)
+{
+	struct IO_APIC_reg_01 reg_01;
+
+	*(int *)&reg_01 = io_apic_read(0, 1);
+	if (reg_01.version < 0x10) {
+		ioapic_level_irq_type.shutdown = shutdown_level_82489dx_irq;
+		ioapic_level_irq_type.enable = enable_level_82489dx_irq;
+		ioapic_level_irq_type.disable = disable_level_82489dx_irq;
+	}
+}
+
+/*
  *
  * IRQ's that are handled by the old PIC in all cases:
  * - IRQ2 is the cascade IRQ, and cannot be a io-apic IRQ.
@@ -1520,6 +1582,8 @@ static inline void check_timer(void)
 
 void __init setup_IO_APIC(void)
 {
+	setup_IO_APIC_irq_handlers();
+
 	enable_IO_APIC();
 
 	io_apic_irqs = ~PIC_IRQS;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
