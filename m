Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135598AbRD1TPX>; Sat, 28 Apr 2001 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135601AbRD1TPN>; Sat, 28 Apr 2001 15:15:13 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:65288 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135598AbRD1TPF>;
	Sat, 28 Apr 2001 15:15:05 -0400
Date: Sat, 28 Apr 2001 21:15:07 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: cep@andrew.cmu.edu
Subject: Re: Network error persists in 2.4.4
Message-ID: <20010428211507.A24432@unternet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> (on problems with ne2k-pci on SMP-systems)

Seems you're experiencing the effects of the infamous IO-APIC problem
('erratum' in Intel-lingo). There's a patch for these problems by Maciej W.
Rozycki, which should (IMnsHO) really be accepted into the main kernel tree
since many people are experiencing these problems and the patch fixes them
quite well.

The patch has been submitted to the list several times now, but I'll do it
again. (attached to this message...)

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.1-io_apic-46"

diff -up --recursive --new-file linux-2.4.1.macro/arch/i386/kernel/apic.c linux-2.4.1/arch/i386/kernel/apic.c
--- linux-2.4.1.macro/arch/i386/kernel/apic.c	Wed Dec 13 23:54:27 2000
+++ linux-2.4.1/arch/i386/kernel/apic.c	Mon Feb 12 16:11:15 2001
@@ -23,6 +23,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/atomic.h>
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
@@ -270,7 +271,13 @@ void __init setup_local_APIC (void)
 	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
 	 *   BX chipset. ]
 	 */
-#if 0
+	/*
+	 * Actually disabling the focus CPU check just makes the hang less
+	 * frequent as it makes the interrupt distributon model be more
+	 * like LRU than MRU (the short-term load is more even across CPUs).
+	 * See also the comment in end_level_ioapic_irq().  --macro
+	 */
+#if 1
 	/* Enable focus processor (bit==0) */
 	value &= ~(1<<9);
 #else
@@ -764,7 +771,7 @@ asmlinkage void smp_error_interrupt(void
 	apic_write(APIC_ESR, 0);
 	v1 = apic_read(APIC_ESR);
 	ack_APIC_irq();
-	irq_err_count++;
+	atomic_inc(&irq_err_count);
 
 	/* Here is what the APIC error bits mean:
 	   0: Send CS error
diff -up --recursive --new-file linux-2.4.1.macro/arch/i386/kernel/i8259.c linux-2.4.1/arch/i386/kernel/i8259.c
--- linux-2.4.1.macro/arch/i386/kernel/i8259.c	Mon Nov 20 18:01:58 2000
+++ linux-2.4.1/arch/i386/kernel/i8259.c	Sun Feb 11 19:54:33 2001
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -321,7 +322,7 @@ spurious_8259A_irq:
 			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
-		irq_err_count++;
+		atomic_inc(&irq_err_count);
 		/*
 		 * Theoretically we do not have to handle this IRQ,
 		 * but in Linux this does not cause problems and is
diff -up --recursive --new-file linux-2.4.1.macro/arch/i386/kernel/io_apic.c linux-2.4.1/arch/i386/kernel/io_apic.c
--- linux-2.4.1.macro/arch/i386/kernel/io_apic.c	Sat Feb  3 12:05:49 2001
+++ linux-2.4.1/arch/i386/kernel/io_apic.c	Tue Feb 13 19:59:55 2001
@@ -33,6 +33,8 @@
 #include <asm/smp.h>
 #include <asm/desc.h>
 
+#define APIC_LOCKUP_DEBUG
+
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -122,8 +124,14 @@ static void add_pin_to_irq(unsigned int 
 	static void name##_IO_APIC_irq (unsigned int irq)		\
 	__DO_ACTION(R, ACTION, FINAL)
 
-DO_ACTION( __mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
-DO_ACTION( __unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
+DO_ACTION( __mask,             0, |= 0x00010000, io_apic_sync(entry->apic) )
+						/* mask = 1 */
+DO_ACTION( __unmask,           0, &= 0xfffeffff, )
+						/* mask = 0 */
+DO_ACTION( __mask_and_edge,    0, = (reg & 0xffff7fff) | 0x00010000, )
+						/* mask = 1, trigger = 0 */
+DO_ACTION( __unmask_and_level, 0, = (reg & 0xfffeffff) | 0x00008000, )
+						/* mask = 0, trigger = 1 */
 
 static void mask_IO_APIC_irq (unsigned int irq)
 {
@@ -847,6 +855,8 @@ void /*__init*/ print_local_APIC(void * 
 
 	v = apic_read(APIC_EOI);
 	printk(KERN_DEBUG "... APIC EOI: %08x\n", v);
+	v = apic_read(APIC_RRR);
+	printk(KERN_DEBUG "... APIC RRR: %08x\n", v);
 	v = apic_read(APIC_LDR);
 	printk(KERN_DEBUG "... APIC LDR: %08x\n", v);
 	v = apic_read(APIC_DFR);
@@ -1191,12 +1201,61 @@ static unsigned int startup_level_ioapic
 #define enable_level_ioapic_irq		unmask_IO_APIC_irq
 #define disable_level_ioapic_irq	mask_IO_APIC_irq
 
-static void end_level_ioapic_irq (unsigned int i)
+static void end_level_ioapic_irq (unsigned int irq)
 {
+	unsigned long v;
+
+/*
+ * It appears there is an erratum which affects at least version 0x11
+ * of I/O APIC (that's the 82093AA and cores integrated into various
+ * chipsets).  Under certain conditions a level-triggered interrupt is
+ * erroneously delivered as edge-triggered one but the respective IRR
+ * bit gets set nevertheless.  As a result the I/O unit expects an EOI
+ * message but it will never arrive and further interrupts are blocked
+ * from the source.  The exact reason is so far unknown, but the
+ * phenomenon was observed when two consecutive interrupt requests
+ * from a given source get delivered to the same CPU and the source is
+ * temporarily disabled in between.
+ *
+ * A workaround is to simulate an EOI message manually.  We achieve it
+ * by setting the trigger mode to edge and then to level when the edge
+ * trigger mode gets detected in the TMR of a local APIC for a
+ * level-triggered interrupt.  We mask the source for the time of the
+ * operation to prevent an edge-triggered interrupt escaping meanwhile.
+ * The idea is from Manfred Spraul.  --macro
+ */
+	v = apic_read(APIC_TMR + ((IO_APIC_VECTOR(irq) & ~0x1f) >> 1));
+
 	ack_APIC_irq();
+
+	if (!(v & (1 << (IO_APIC_VECTOR(irq) & 0x1f)))) {
+#ifdef APIC_MISMATCH_DEBUG
+		atomic_inc(&irq_mis_count);
+#endif
+		spin_lock(&ioapic_lock);
+		__mask_and_edge_IO_APIC_irq(irq);
+#ifdef APIC_LOCKUP_DEBUG
+		for (;;) {
+			struct irq_pin_list *entry = irq_2_pin + irq;
+			unsigned int reg;
+
+			if (entry->pin == -1)
+				break;
+			reg = io_apic_read(entry->apic, 0x10 + entry->pin * 2);
+			if (reg & 0x00004000)
+				printk(KERN_CRIT "Aieee!!!  Remote IRR"
+					" still set after unlock!\n");
+			if (!entry->next)
+				break;
+			entry = irq_2_pin + entry->next;
+		}
+#endif
+		__unmask_and_level_IO_APIC_irq(irq);
+		spin_unlock(&ioapic_lock);
+	}
 }
 
-static void mask_and_ack_level_ioapic_irq (unsigned int i) { /* nothing */ }
+static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
 
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
diff -up --recursive --new-file linux-2.4.1.macro/arch/i386/kernel/irq.c linux-2.4.1/arch/i386/kernel/irq.c
--- linux-2.4.1.macro/arch/i386/kernel/irq.c	Wed Dec 13 23:54:27 2000
+++ linux-2.4.1/arch/i386/kernel/irq.c	Mon Feb 12 13:37:37 2001
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 
+#include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/system.h>
@@ -119,7 +120,12 @@ struct hw_interrupt_type no_irq_type = {
 	end_none
 };
 
-volatile unsigned long irq_err_count;
+atomic_t irq_err_count;
+#ifdef CONFIG_X86_IO_APIC
+#ifdef APIC_MISMATCH_DEBUG
+atomic_t irq_mis_count;
+#endif
+#endif
 
 /*
  * Generic, controller-independent functions:
@@ -167,7 +173,12 @@ int get_irq_list(char *buf)
 			apic_timer_irqs[cpu_logical_map(j)]);
 	p += sprintf(p, "\n");
 #endif
-	p += sprintf(p, "ERR: %10lu\n", irq_err_count);
+	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+#ifdef CONFIG_X86_IO_APIC
+#ifdef APIC_MISMATCH_DEBUG
+	p += sprintf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+#endif
+#endif
 	return p - buf;
 }
 
diff -up --recursive --new-file linux-2.4.1.macro/include/asm-i386/hw_irq.h linux-2.4.1/include/asm-i386/hw_irq.h
--- linux-2.4.1.macro/include/asm-i386/hw_irq.h	Sat Feb  3 13:12:29 2001
+++ linux-2.4.1/include/asm-i386/hw_irq.h	Sun Feb 11 20:02:57 2001
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <asm/atomic.h>
 #include <asm/irq.h>
 
 /*
@@ -83,7 +84,9 @@ extern int IO_APIC_get_PCI_irq_vector(in
 extern void send_IPI(int dest, int vector);
 
 extern unsigned long io_apic_irqs;
-extern volatile unsigned long irq_err_count;
+
+extern atomic_t irq_err_count;
+extern atomic_t irq_mis_count;
 
 extern char _stext, _etext;
 
diff -up --recursive --new-file linux-2.4.1.macro/include/asm-i386/io_apic.h linux-2.4.1/include/asm-i386/io_apic.h
--- linux-2.4.1.macro/include/asm-i386/io_apic.h	Wed Nov 22 21:34:56 2000
+++ linux-2.4.1/include/asm-i386/io_apic.h	Mon Feb 12 13:41:02 2001
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+#define APIC_MISMATCH_DEBUG
+
 #define IO_APIC_BASE(idx) \
 		((volatile int *)__fix_to_virt(FIX_IO_APIC_BASE_0 + idx))
 
diff -up --recursive --new-file linux-2.4.1.macro/include/linux/irq.h linux-2.4.1/include/linux/irq.h
--- linux-2.4.1.macro/include/linux/irq.h	Sat Feb  3 13:12:29 2001
+++ linux-2.4.1/include/linux/irq.h	Sun Feb 11 20:08:41 2001
@@ -62,7 +62,4 @@ extern int setup_irq(unsigned int , stru
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 extern void no_action(int cpl, void *dev_id, struct pt_regs *regs);
 
-extern volatile unsigned long irq_err_count;
-
 #endif /* __asm_h */
-

--fdj2RfSjLxBAspz7--
