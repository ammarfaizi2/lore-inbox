Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRA3LYY>; Tue, 30 Jan 2001 06:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbRA3LYO>; Tue, 30 Jan 2001 06:24:14 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:47006 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129175AbRA3LYD>; Tue, 30 Jan 2001 06:24:03 -0500
Date: Tue, 30 Jan 2001 12:20:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <3A75D533.7F3F4019@colorfullife.com>
Message-ID: <Pine.GSO.3.96.1010130111824.678C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Manfred Spraul wrote:

> I'm not totally convinced that this fixes all problems:
> 
> No lockup, and but a slightly increased packet loss: every few minutes a
> block of 5-10 packets is lost. Cpu load is low (~30%), I'm running 3
> concurrent bw_tcp, the io apic computer is the 'server'.

 I assume you mean "comparing to the noapic mode", right?

> IIRC my original patch caused a far higher packet loss, perhaps because
> it's slower? (you wrote something about 2 r/w accesses).

  Hmm, it's possible that the IRR bit is not always cleared, but I cannot
imagine any reason at the moment.  For your patch it might be the window
between I/O APIC writes and not the prolonged execution time which is the
reason.

> Are you sure that this really fixed the bug?
> Remember that switching the 'trigger mode' bit will revive the io apic.

 That has been observed, but does it happen every time?  I hope so, but no
proof.

> It's possible that 
> * the io apic still locks up.
> * but now {en,dis}able_irq() switches the 'trigger mode' bit, and thus
> resets the io apic after a few msec --> a few lost packets.

 That should be detectable, I'll prepare some code and see if this
happens.

> It's far better than before, but I assume the bug is hidden, not fixed.

 To fix the bug we'd have to modify the silicon.  It's not feasible at
this time, so we can only write worse or better workarounds, i.e. hide the
bug. 

> Send the patch to Linus - it makes ne2k cards usable with 2.4+io apic.

 Following is the 82489DX-ized version of the patch.  I believe it's fine,
but I would feel safer if others test it before I send it to Linus.

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
