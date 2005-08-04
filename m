Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVHDHHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVHDHHC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVHDHHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:07:02 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59097 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261907AbVHDHFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:05:53 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@suse.de>
Subject: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 4 Aug 2005 00:05:50 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
References: <200507260012.41968.jamesclv@us.ibm.com> <20050726160319.GB5353@wotan.suse.de>
In-Reply-To: <20050726160319.GB5353@wotan.suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O5b8C8tWSRhAHbb"
Message-Id: <200508040005.50817.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_O5b8C8tWSRhAHbb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Due to some device driver issues, I built this iteration of the patch 
vs. 2.6.12.3.

(Sorry about the attachment, but KMail is still word wrapping inserted 
files.)

Background:

Here's a patch that builds on Natalie Protasevich's IRQ compression 
patch and tries to work for MPS boots as well as ACPI.  It is meant for 
a 4-node IBM x460 NUMA box, which was dying because it had interrupt 
pins with GSI numbers > NR_IRQS and thus overflowed irq_desc.

The problem is that this system has 280 GSIs (which are 1:1 mapped with 
I/O APIC RTEs) and an 8-node box would have 560.  This is much bigger 
than NR_IRQS (224 for both i386 and x86_64).  Also, there aren't enough 
vectors to go around.  There are about 190 usable vectors, not counting 
the reserved ones and the unused vectors at 0x20 to 0x2F.  So, my patch 
attempts to compress the GSI range and share vectors by sharing IRQs.


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_O5b8C8tWSRhAHbb
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vect_share_irq_2005-08-03c_2.6.12.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vect_share_irq_2005-08-03c_2.6.12.3"

diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c n12.3/arch/i386/kernel/acpi/boot.c
--- 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000 -0700
+++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04 00:01:10.199710211 -0700
@@ -42,6 +42,7 @@
 static inline void  acpi_madt_oem_check(char *oem_id, char *oem_table_id) { }
 extern void __init clustered_apic_check(void);
 static inline int ioapic_setup_disabled(void) { return 0; }
+extern int gsi_irq_sharing(int gsi);
 #include <asm/proto.h>
 
 #else	/* X86 */
@@ -51,6 +52,9 @@ static inline int ioapic_setup_disabled(
 #include <mach_mpparse.h>
 #endif	/* CONFIG_X86_LOCAL_APIC */
 
+static inline int gsi_irq_sharing(int gsi) { return gsi; }
+
+
 #endif	/* X86 */
 
 #define BAD_MADT_ENTRY(entry, end) (					    \
@@ -453,7 +457,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
  		*irq = IO_APIC_VECTOR(gsi);
 	else
 #endif
-		*irq = gsi;
+		*irq = gsi_irq_sharing(gsi);
 	return 0;
 }
 
diff -pruN 2.6.12.3/arch/x86_64/Kconfig n12.3/arch/x86_64/Kconfig
--- 2.6.12.3/arch/x86_64/Kconfig	2005-07-15 14:18:57.000000000 -0700
+++ n12.3/arch/x86_64/Kconfig	2005-08-03 21:31:07.487451167 -0700
@@ -280,13 +280,13 @@ config HAVE_DEC_LOCK
 	default y
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-256)"
-	range 2 256
+	int "Maximum number of CPUs (2-255)"
+	range 2 255
 	depends on SMP
-	default "8"
+	default "16"
 	help
 	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support. Current maximum is 256 CPUs due to
+	  kernel will support. Current maximum is 255 CPUs due to
 	  APIC addressing limits. Less depending on the hardware.
 
 	  This is purely to save memory - each supported CPU requires
diff -pruN 2.6.12.3/arch/x86_64/kernel/io_apic.c n12.3/arch/x86_64/kernel/io_apic.c
--- 2.6.12.3/arch/x86_64/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ n12.3/arch/x86_64/kernel/io_apic.c	2005-08-03 21:31:07.488451039 -0700
@@ -56,7 +56,7 @@ int nr_ioapic_registers[MAX_IO_APICS];
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
-#define MAX_PLUS_SHARED_IRQS NR_IRQS
+#define MAX_PLUS_SHARED_IRQS NR_IRQ_VECTORS
 #define PIN_MAP_SIZE (MAX_PLUS_SHARED_IRQS + NR_IRQS)
 
 /*
@@ -182,6 +182,8 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
+
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
  * specific CPU-side IRQs.
@@ -581,6 +583,64 @@ static inline int irq_trigger(int idx)
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
+	int i, irq, vector;
+
+	BUG_ON(gsi >= NR_IRQ_VECTORS);
+
+	if (platform_legacy_irq(gsi)) {
+		gsi_2_irq[gsi] = gsi;
+		return gsi;
+	}
+
+	if (gsi_2_irq[gsi] != 0xFF)
+		return (int)gsi_2_irq[gsi];
+
+ retry_vector:
+	vector = assign_irq_vector(gsi);
+
+	/*
+	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
+	 * use of vector and if found, return that IRQ.  However, we never want
+	 * to share legacy IRQs, which usually have a different trigger mode
+	 * than PCI.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		if (IO_APIC_VECTOR(i) == vector) {
+			if (!platform_legacy_irq(i))
+				break;			/* got one */
+			IO_APIC_VECTOR(gsi) = 0;
+			goto retry_vector;
+		}
+	if (i < NR_IRQS) {
+		irq = i;
+		gsi_2_irq[gsi] = i;
+		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ %d\n",
+				gsi, vector, irq);
+		return irq;
+	}
+
+	irq = next_irq++;
+	BUG_ON(irq >= NR_IRQS);
+	gsi_2_irq[gsi] = irq;
+	IO_APIC_VECTOR(irq) = vector;
+	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, irq);
+
+	return irq;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -610,6 +670,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -670,9 +731,8 @@ next:
 		goto next;
 
 	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset++;
-		if (!(offset%8))
-			return -ENOSPC;
+		/* If we run out of vectors on large boxen, must share them. */
+		offset = (offset + 1) % 8;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
@@ -1866,6 +1926,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pruN 2.6.12.3/arch/x86_64/kernel/mpparse.c n12.3/arch/x86_64/kernel/mpparse.c
--- 2.6.12.3/arch/x86_64/kernel/mpparse.c	2005-07-15 14:18:57.000000000 -0700
+++ n12.3/arch/x86_64/kernel/mpparse.c	2005-08-03 21:31:07.489450912 -0700
@@ -214,7 +214,7 @@ static void __init MP_intsrc_info (struc
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries >= MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
diff -pruN 2.6.12.3/include/asm-x86_64/mpspec.h n12.3/include/asm-x86_64/mpspec.h
--- 2.6.12.3/include/asm-x86_64/mpspec.h	2005-07-15 14:18:57.000000000 -0700
+++ n12.3/include/asm-x86_64/mpspec.h	2005-08-03 21:31:07.489450912 -0700
@@ -157,7 +157,8 @@ struct mpc_config_lintsrc
  */
 
 #define MAX_MP_BUSSES 256
-#define MAX_IRQ_SOURCES 256
+/* Each PCI slot may be a combo card with its own bus.  4 IRQ pins per slot. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,

--Boundary-00=_O5b8C8tWSRhAHbb--
