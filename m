Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130293AbRBBWVk>; Fri, 2 Feb 2001 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRBBWVa>; Fri, 2 Feb 2001 17:21:30 -0500
Received: from colorfullife.com ([216.156.138.34]:60176 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130258AbRBBWVT>;
	Fri, 2 Feb 2001 17:21:19 -0500
Message-ID: <3A7B3204.6A433394@colorfullife.com>
Date: Fri, 02 Feb 2001 23:17:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gérard Roudier <groudier@club-internet.fr>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <Pine.LNX.4.10.10102021848290.785-100000@linux.local>
Content-Type: multipart/mixed;
 boundary="------------D6BC067988B9169D22E5E57E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D6BC067988B9169D22E5E57E
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Gérard Roudier wrote:
> 
> So, why not using a pure software flag in memory and only tampering the
> things if the offending interrupt is actually delivered ? If the given
> interrupt is delivered and the software mask is set we could simply do:
> 
> - MASK the given interrupt
> - EOI it.
> - return
>
Good idea.
I implemented it, and it was a full success: not it always locks up :-(

If I apply the attached patch, then I get a lockup after ~ 100 packets
flood ping.
I've also attached the dmesg print.
I know that startup is currently wrong (must set trigger to level), but
that doesn't matter since I only ifup once.

But I think we can change the bug description:

If an io apic io redirection entry is unmasked while the irq pin is
active, then the io apic sends out the interrupt as edge triggered, but
nevertheless sets the IRR bit.

In a second test run I checked the TMR bit in the local apics: the bit
on the cpu that received the last interrupt is really 0.

I'll not try a 2 step enable:
* unmask.
* io_apic_sync()
* set trigger mode to level.

--
	Manfred
--------------D6BC067988B9169D22E5E57E
Content-Type: text/plain; charset=us-ascii;
 name="patch-ger2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ger2"

--- 2.4/arch/i386/kernel/io_apic.c	Fri Feb  2 15:51:57 2001
+++ build-2.4/arch/i386/kernel/io_apic.c	Fri Feb  2 23:04:44 2001
@@ -115,10 +115,10 @@
 
 /*
  * It appears there is an erratum which affects at least the 82093AA
- * I/O APIC.  If a level-triggered interrupt input is being masked in
- * the redirection entry while the interrupt is send pending (its
- * delivery status bit is set), the interrupt is erroneously
- * delivered as edge-triggered but the IRR bit gets set nevertheless.
+ * I/O APIC.  If a level-triggered interrupt input is being unmasked in
+ * the redirection entry while the interrupt line is active, then
+ * the interrupt is erroneously delivered as edge-triggered but the
+ * IRR bit gets set nevertheless.
  * As a result the I/O unit expects an EOI message but it will never
  * arrive and further interrupts are blocked for the source.
  *
@@ -126,12 +126,8 @@
  * a level-triggered interrupt and to revert the mode when unmasking.
  * The idea is from Manfred Spraul.
  */
-DO_ACTION( __mask,         0, = (reg & 0xffff7fff) | 0x00010000,
-	io_apic_sync(entry->apic))		/* mask = 1, trigger = edge */
-DO_ACTION( __unmask_edge,  0, &= 0xfffeffff,
-	)					/* mask = 0 */
-DO_ACTION( __unmask_level, 0, = (reg & 0xfffeffff) | 0x00008000,
-	)					/* mask = 0, trigger = level */
+DO_ACTION( __mask,         0, = (reg & 0xffff7fff) | 0x00010000, io_apic_sync(entry->apic))	/* mask = 1 */
+DO_ACTION( __unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
 
 static void mask_IO_APIC_irq (unsigned int irq)
 {
@@ -142,26 +138,15 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-static void unmask_edge_IO_APIC_irq (unsigned int irq)
+static void unmask_IO_APIC_irq (unsigned int irq)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__unmask_edge_IO_APIC_irq(irq);
+	__unmask_IO_APIC_irq(irq);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-static void unmask_level_IO_APIC_irq (unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	__unmask_level_IO_APIC_irq(irq);
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-}
-
-#define unmask_IO_APIC_irq unmask_edge_IO_APIC_irq
-
 void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
@@ -712,7 +697,7 @@
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
 }
 
-void __init print_IO_APIC(void)
+void print_IO_APIC(void)
 {
 	int apic, i;
 	struct IO_APIC_reg_00 reg_00;
@@ -1117,7 +1102,7 @@
  * that was delayed but this is now handled in the device
  * independent code.
  */
-#define enable_edge_ioapic_irq unmask_edge_IO_APIC_irq
+#define enable_edge_ioapic_irq unmask_IO_APIC_irq
 
 static void disable_edge_ioapic_irq (unsigned int irq) { /* nothing */ }
 
@@ -1142,7 +1127,7 @@
 		if (i8259A_irq_pending(irq))
 			was_pending = 1;
 	}
-	__unmask_edge_IO_APIC_irq(irq);
+	__unmask_IO_APIC_irq(irq);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return was_pending;
@@ -1182,21 +1167,66 @@
  */
 static unsigned int startup_level_ioapic_irq (unsigned int irq)
 {
-	unmask_level_IO_APIC_irq(irq);
+	unmask_IO_APIC_irq(irq);
 
 	return 0; /* don't check for pending */
 }
 
 #define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_level_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
+
+static void enable_level_ioapic_irq (unsigned int i)
+{
+	unsigned long flags;
+	int pin;
+	struct irq_pin_list *entry;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	entry = irq_2_pin + i;
+
+	for (;;) {
+		unsigned int reg, reg2;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		if(!(reg & 0x10000)) {
+			printk(KERN_DEBUG "quick enable_level_ioapic_irq for %d.\n",i);
+			break;
+		}
+		reg &= ~(0x10000);
+		reg |= 0x8000;
+		printk(KERN_DEBUG "physically reenabling int %d, writing %lxh.\n",i, reg);
+reg2 = io_apic_read(entry->apic, 0x10 + pin*2);
+		io_apic_modify(entry->apic, reg);
+printk(KERN_DEBUG "overwriting %xh.\n",reg2);
+		io_apic_sync(entry->apic);
+reg2 = io_apic_read(entry->apic, 0x10 + pin*2);
+printk(KERN_DEBUG "new val %xh.\n",reg2);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+static void disable_level_ioapic_irq (unsigned int i) { /* delayed */ }
 
 static void end_level_ioapic_irq (unsigned int i)
 {
 	ack_APIC_irq();
 }
 
-static void mask_and_ack_level_ioapic_irq (unsigned int i) { /* nothing */ }
+static void mask_and_ack_level_ioapic_irq (unsigned int i)
+{
+	if(i == 16)
+		printk(KERN_DEBUG "irq 0x16 seen on cpu %d.\n",
+			smp_processor_id());
+	if (irq_desc[i].status & IRQ_DISABLED) {
+		mask_IO_APIC_irq(i);
+		printk(KERN_DEBUG "physically disabling int %d.\n",i);
+	}
+}
 
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {

--------------D6BC067988B9169D22E5E57E
Content-Type: text/plain; charset=us-ascii;
 name="dmesg-ger2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-ger2"

quick enable_level_ioapic_irq for 16.
irq 0x16 seen on cpu 1.
quick enable_level_ioapic_irq for 16.
irq 0x16 seen on cpu 0.
irq 0x16 seen on cpu 1.
quick enable_level_ioapic_irq for 16.
irq 0x16 seen on cpu 0.
irq 0x16 seen on cpu 1.
irq 0x16 seen on cpu 0.
quick enable_level_ioapic_irq for 16.
irq 0x16 seen on cpu 1.
physically disabling int 16.
physically reenabling int 16, writing a9a1h.
overwriting 129a1h.
new val f9a1h.
irq 0x16 seen on cpu 1.
quick enable_level_ioapic_irq for 16.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=37.
quick enable_level_ioapic_irq for 16.
quick enable_level_ioapic_irq for 16.
quick enable_level_ioapic_irq for 16.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=40.
quick enable_level_ioapic_irq for 16.

--------------D6BC067988B9169D22E5E57E--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
