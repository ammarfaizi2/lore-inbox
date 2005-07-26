Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVGZHMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVGZHMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVGZHMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:12:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6546 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261813AbVGZHMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:12:46 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: linux-kernel@vger.kernel.org
Subject: [RFC][2.6.13-rc3-mm1] IRQ compression/sharing patch
Date: Tue, 26 Jul 2005 00:12:41 -0700
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pJe5C+IDUMXI2jB"
Message-Id: <200507260012.41968.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pJe5C+IDUMXI2jB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a patch that builds on Natalie Protasevich's IRQ compression 
patch and tries to work for MPS boots as well as ACPI.  It is meant for 
a 4-node IBM x460 NUMA box, which was dying because it had interrupt 
pins with GSI numbers > NR_IRQS and thus overflowed irq_desc.

The problem is that this system has 270 GSIs (which are 1:1 mapped with 
I/O APIC RTEs) and an 8-node box would have 540.  This is much bigger 
than NR_IRQS (224 for both i386 and x86_64).  Also, there aren't enough 
vectors to go around.  There are about 190 usable vectors, not counting 
the reserved ones and the unused vectors at 0x20 to 0x2F.  So, my patch 
attempts to compress the GSI range and share vectors by sharing IRQs.

Important safety note:  While the SLES 9 version of this patch works, I 
haven't been able to test the -rc3-mm1 patch enclosed.  I keep getting 
errors from the adp94xx driver.  8-(

(Sorry about doing an attachment, but KMail is steadfastly word wrapping 
inserted files.  I need to upgrade....)

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_pJe5C+IDUMXI2jB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vect_share_irq_2005-07-23_2.6.13-rc3-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vect_share_irq_2005-07-23_2.6.13-rc3-mm1"

diff -pru 2.6.13-rc3-mm1/arch/i386/kernel/acpi/boot.c j13-rc3-mm1/arch/i386/kernel/acpi/boot.c
--- 2.6.13-rc3-mm1/arch/i386/kernel/acpi/boot.c	2005-07-22 18:32:35.000000000 -0700
+++ j13-rc3-mm1/arch/i386/kernel/acpi/boot.c	2005-07-23 18:32:06.000000000 -0700
@@ -40,9 +40,10 @@
 
 #ifdef	CONFIG_X86_64
 
-static inline void  acpi_madt_oem_check(char *oem_id, char *oem_table_id) { }
+extern void  acpi_madt_oem_check(char *oem_id, char *oem_table_id);
 extern void __init clustered_apic_check(void);
 static inline int ioapic_setup_disabled(void) { return 0; }
+extern int gsi_irq_sharing(int gsi);
 #include <asm/proto.h>
 
 #else	/* X86 */
@@ -52,6 +53,10 @@ static inline int ioapic_setup_disabled(
 #include <mach_mpparse.h>
 #endif	/* CONFIG_X86_LOCAL_APIC */
 
+static inline int ioapic_setup_disabled(void) { return 0; }
+static inline int gsi_irq_sharing(int gsi) { return gsi; }
+
+
 #endif	/* X86 */
 
 #define BAD_MADT_ENTRY(entry, end) (					    \
@@ -480,7 +485,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
  		*irq = IO_APIC_VECTOR(gsi);
 	else
 #endif
-		*irq = gsi;
+		*irq = gsi_irq_sharing(gsi);
 	return 0;
 }
 
diff -pru 2.6.13-rc3-mm1/arch/x86_64/Kconfig j13-rc3-mm1/arch/x86_64/Kconfig
--- 2.6.13-rc3-mm1/arch/x86_64/Kconfig	2005-07-22 18:32:35.000000000 -0700
+++ j13-rc3-mm1/arch/x86_64/Kconfig	2005-07-22 18:34:08.000000000 -0700
@@ -276,13 +276,13 @@ config HAVE_DEC_LOCK
 	default y
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-256)"
-	range 2 256
+	int "Maximum number of CPUs (2-255)"
+	range 2 255
 	depends on SMP
-	default "8"
+	default "64"
 	help
 	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support. Current maximum is 256 CPUs due to
+	  kernel will support. Current maximum is 255 CPUs due to
 	  APIC addressing limits. Less depending on the hardware.
 
 	  This is purely to save memory - each supported CPU requires
diff -pru 2.6.13-rc3-mm1/arch/x86_64/kernel/genapic.c j13-rc3-mm1/arch/x86_64/kernel/genapic.c
--- 2.6.13-rc3-mm1/arch/x86_64/kernel/genapic.c	2005-07-12 21:46:46.000000000 -0700
+++ j13-rc3-mm1/arch/x86_64/kernel/genapic.c	2005-07-22 18:34:08.000000000 -0700
@@ -103,3 +103,19 @@ void send_IPI_self(int vector)
 {
 	__send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
 }
+
+/*
+ * Check the APIC IDs in MADT table header and choose the APIC mode.
+ */
+void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	/* May need to check OEM strings in the future. */
+}
+
+/*
+ * Check the IDs in MPS header and choose the APIC mode.
+ */
+void mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid)
+{
+	/* May need to check OEM strings in the future. */
+}
diff -pru 2.6.13-rc3-mm1/arch/x86_64/kernel/io_apic.c j13-rc3-mm1/arch/x86_64/kernel/io_apic.c
--- 2.6.13-rc3-mm1/arch/x86_64/kernel/io_apic.c	2005-07-22 18:32:35.000000000 -0700
+++ j13-rc3-mm1/arch/x86_64/kernel/io_apic.c	2005-07-23 18:32:40.000000000 -0700
@@ -56,7 +56,7 @@ int nr_ioapic_registers[MAX_IO_APICS];
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
-#define MAX_PLUS_SHARED_IRQS NR_IRQS
+#define MAX_PLUS_SHARED_IRQS NR_IRQ_VECTORS
 #define PIN_MAP_SIZE (MAX_PLUS_SHARED_IRQS + NR_IRQS)
 
 /*
@@ -84,6 +84,7 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
 	int pin;							\
 	struct irq_pin_list *entry = irq_2_pin + irq;			\
 									\
+	BUG_ON(irq >= NR_IRQS);						\
 	for (;;) {							\
 		unsigned int reg;					\
 		pin = entry->pin;					\
@@ -126,6 +127,8 @@ static void set_ioapic_affinity_irq(unsi
 }
 #endif
 
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -136,6 +139,7 @@ static void add_pin_to_irq(unsigned int 
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
 
+	BUG_ON(irq >= NR_IRQS);
 	while (entry->next)
 		entry = irq_2_pin + entry->next;
 
@@ -143,7 +147,7 @@ static void add_pin_to_irq(unsigned int 
 		entry->next = first_free_entry;
 		entry = irq_2_pin + entry->next;
 		if (++first_free_entry >= PIN_MAP_SIZE)
-			panic("io_apic.c: whoops");
+			panic("io_apic.c: ran out of irq_2_pin entries!");
 	}
 	entry->apic = apic;
 	entry->pin = pin;
@@ -419,6 +423,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 				best_guess = irq;
 		}
 	}
+	BUG_ON(best_guess >= NR_IRQS);
 	return best_guess;
 }
 
@@ -609,6 +614,64 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+static int next_irq = 16;
+
+/*
+ * gsi_irq_sharing -- Name overload!  "irq" can be either a legacy IRQ
+ * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
+ * from ACPI, which can reach 800 in large boxen.
+ *
+ * Compact the sparse GSI space into a sequential IRQ series and reuse
+ * vectors if possible.
+ */
+int gsi_irq_sharing(int gsi)
+{
+	int i, tries, vector;
+
+	BUG_ON(gsi >= NR_IRQ_VECTORS);
+
+	if (platform_legacy_irq(gsi))
+		return gsi;
+
+	if (gsi_2_irq[gsi] != 0xFF)
+		return (int)gsi_2_irq[gsi];
+
+	tries = NR_IRQS;
+  try_again:
+	vector = assign_irq_vector(gsi);
+
+	/*
+	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
+	 * use of vector and if found, return that IRQ.  However, we never want
+	 * to share legacy IRQs, which usually have a different trigger mode
+	 * than PCI.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		if (IO_APIC_VECTOR(i) == vector)
+			break;
+	if (platform_legacy_irq(i)) {
+		if (--tries >= 0) {
+			IO_APIC_VECTOR(i) = 0;
+			goto try_again;
+		}
+		panic("gsi_irq_sharing: didn't find an IRQ using vector 0x%02X for GSI %d", vector, gsi);
+	}
+	if (i < NR_IRQS) {
+		gsi_2_irq[gsi] = i;
+		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ %d\n",
+				gsi, vector, i);
+		return i;
+	}
+
+	i = next_irq++;
+	BUG_ON(i >= NR_IRQS);
+	gsi_2_irq[gsi] = i;
+	IO_APIC_VECTOR(i) = vector;
+	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, i);
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -638,6 +701,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -647,6 +711,7 @@ static int pin_2_irq(int idx, int apic, 
 			break;
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 
 	/*
 	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
@@ -662,6 +727,7 @@ static int pin_2_irq(int idx, int apic, 
 			}
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 	return irq;
 }
 
@@ -689,8 +755,8 @@ int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
-	if (IO_APIC_VECTOR(irq) > 0)
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
 	current_vector += 8;
@@ -698,9 +764,8 @@ next:
 		goto next;
 
 	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset++;
-		if (!(offset%8))
-			return -ENOSPC;
+		/* If we run out of vectors on large boxen, must share them. */
+		offset = (offset + 1) % 8;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
@@ -1920,6 +1985,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pru 2.6.13-rc3-mm1/arch/x86_64/kernel/irq.c j13-rc3-mm1/arch/x86_64/kernel/irq.c
--- 2.6.13-rc3-mm1/arch/x86_64/kernel/irq.c	2005-07-22 18:32:35.000000000 -0700
+++ j13-rc3-mm1/arch/x86_64/kernel/irq.c	2005-07-22 18:34:08.000000000 -0700
@@ -99,7 +99,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	unsigned irq = regs->orig_rax & 0xff;
 
 	irq_enter();
-	BUG_ON(irq > 256);
+	BUG_ON(irq > NR_IRQS);
 
 	__do_IRQ(irq, regs);
 	irq_exit();
diff -pru 2.6.13-rc3-mm1/arch/x86_64/kernel/mpparse.c j13-rc3-mm1/arch/x86_64/kernel/mpparse.c
--- 2.6.13-rc3-mm1/arch/x86_64/kernel/mpparse.c	2005-07-22 18:32:35.000000000 -0700
+++ j13-rc3-mm1/arch/x86_64/kernel/mpparse.c	2005-07-22 18:34:08.000000000 -0700
@@ -216,7 +216,7 @@ static void __init MP_intsrc_info (struc
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries >= MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
@@ -248,9 +248,10 @@ static void __init MP_lintsrc_info (stru
 
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
-	char str[16];
+	char oem[9], str[16];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	extern void mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid);
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		printk("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -273,14 +274,16 @@ static int __init smp_read_mpc(struct mp
 		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 		return 0;
 	}
-	memcpy(str,mpc->mpc_oem,8);
-	str[8]=0;
-	printk(KERN_INFO "OEM ID: %s ",str);
+	memcpy(oem, mpc->mpc_oem, 8);
+	oem[8] = 0;
+	printk(KERN_INFO "OEM ID: %s ", oem);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
 	printk(KERN_INFO "Product ID: %s ",str);
 
+	mps_oem_check(mpc, oem, str);
+
 	printk(KERN_INFO "APIC at: 0x%X\n",mpc->mpc_lapic);
 
 	/* save the local APIC address, it might be non-default */
diff -pru 2.6.13-rc3-mm1/include/asm-x86_64/desc.h j13-rc3-mm1/include/asm-x86_64/desc.h
--- 2.6.13-rc3-mm1/include/asm-x86_64/desc.h	2005-07-12 21:46:46.000000000 -0700
+++ j13-rc3-mm1/include/asm-x86_64/desc.h	2005-07-22 18:34:08.000000000 -0700
@@ -95,16 +95,19 @@ static inline void _set_gate(void *adr, 
 
 static inline void set_intr_gate(int nr, void *func) 
 { 
+	BUG_ON((unsigned)nr > 0xFF);
 	_set_gate(&idt_table[nr], GATE_INTERRUPT, (unsigned long) func, 0, 0); 
 } 
 
 static inline void set_intr_gate_ist(int nr, void *func, unsigned ist) 
 { 
+	BUG_ON((unsigned)nr > 0xFF);
 	_set_gate(&idt_table[nr], GATE_INTERRUPT, (unsigned long) func, 0, ist); 
 } 
 
 static inline void set_system_gate(int nr, void *func) 
 { 
+	BUG_ON((unsigned)nr > 0xFF);
 	_set_gate(&idt_table[nr], GATE_INTERRUPT, (unsigned long) func, 3, 0); 
 } 
 
diff -pru 2.6.13-rc3-mm1/include/asm-x86_64/mpspec.h j13-rc3-mm1/include/asm-x86_64/mpspec.h
--- 2.6.13-rc3-mm1/include/asm-x86_64/mpspec.h	2005-07-12 21:46:46.000000000 -0700
+++ j13-rc3-mm1/include/asm-x86_64/mpspec.h	2005-07-22 18:34:08.000000000 -0700
@@ -157,7 +157,8 @@ struct mpc_config_lintsrc
  */
 
 #define MAX_MP_BUSSES 256
-#define MAX_IRQ_SOURCES 256
+/* Each PCI slot may be a combo card with its own bus.  4 IRQ pins per slot. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,

--Boundary-00=_pJe5C+IDUMXI2jB--
