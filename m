Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVHLDAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVHLDAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVHLDAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:00:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3991 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751143AbVHLC77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:59:59 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 19:59:56 -0700
User-Agent: KMail/1.7.1
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB4@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB4@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sCB/CCI14WNF1n+"
Message-Id: <200508111959.56780.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sCB/CCI14WNF1n+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached hack to assign_irq_vector may be marginally less ugly.
However, I haven't rearranged the code like Andi wanted yet.


On Thursday 11 August 2005 02:55 pm, Protasevich, Natalie wrote:
> > After sleeping on it, maybe the original code can be patched 
> > without having to hack assign_irq_vector(), etc.  How about:
> > 
> > --- io_apic.c	2005-08-11 10:14:33.564748923 -0700
> > +++ io_apic.c.new	2005-08-11 10:15:55.412331115 -0700
> > @@ -617,7 +617,7 @@ int gsi_irq_sharing(int gsi)
> >  	 * than PCI.
> >  	 */
> >  	for (i = 0; i < NR_IRQS; i++)
> > -		if (IO_APIC_VECTOR(i) == vector) {
> > +		if (IO_APIC_VECTOR(i) == vector && i != gsi) {
> >  			if (!platform_legacy_irq(i))
> >  				break;			/* got one */
> >  			IO_APIC_VECTOR(gsi) = 0;
> > 
> > 
> Yes that did it, on my small system it looked just right:
> 
> <7>IRQ to pin mappings:
> <7>IRQ0 -> 0:2
> <7>IRQ1 -> 0:1
> <7>IRQ3 -> 0:3
> <7>IRQ4 -> 0:4
> <7>IRQ5 -> 0:5
> <7>IRQ6 -> 0:6
> <7>IRQ7 -> 0:7
> <7>IRQ8 -> 0:8
> <7>IRQ9 -> 0:9
> <7>IRQ10 -> 0:10
> <7>IRQ11 -> 0:11
> <7>IRQ12 -> 0:12
> <7>IRQ14 -> 0:14
> <7>IRQ15 -> 0:15
> <7>IRQ16 -> 0:16
> <7>IRQ17 -> 0:17
> <7>IRQ18 -> 0:18
> <7>IRQ19 -> 0:19
> <7>IRQ20 -> 0:20
> <7>IRQ21 -> 0:23
> <7>IRQ22 -> 1:2
> <7>IRQ23 -> 1:3
> <7>IRQ24 -> 1:4
> <7>IRQ25 -> 1:5
> <7>IRQ26 -> 2:0
> <7>IRQ27 -> 2:1
> <7>IRQ28 -> 2:2
> <7>IRQ29 -> 2:3
> <7>IRQ30 -> 2:4
> <7>IRQ31 -> 2:5
> <7>IRQ32 -> 2:6
> <7>IRQ33 -> 2:7
> <7>IRQ34 -> 2:8
> :!cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:      12621      15007      12781      20921    IO-APIC-edge  timer
>   1:         72          0          2        175    IO-APIC-edge  i8042
>   2:          0          0          0          0          XT-PIC
> cascade
>   8:          0          0          0          1    IO-APIC-edge  rtc
>   9:          0          0          0          0    IO-APIC-edge  acpi
>  12:          4        272          0        110    IO-APIC-edge  i8042
>  15:          4          0          0         39    IO-APIC-edge  ide1
>  16:          0          0          0          0   IO-APIC-level
> uhci_hcd:usb1, uhci_hcd:usb4
>  17:          0          0          0          2   IO-APIC-level
> ohci1394
>  18:        730       2407        932       2083   IO-APIC-level
> libata, uhci_hcd:usb3
>  19:          0          0          0          0   IO-APIC-level
> uhci_hcd:usb2
>  21:          0          0          0          0   IO-APIC-level
> ehci_hcd:usb5
>  26:        416          0          0          4   IO-APIC-level  eth0
> NMI:        116         71         73         51
> LOC:      61280      61258      61236      61214
> ERR:          3
> MIS:          0
> 
> Looks good! I will try the patch also on the ES7000 hopefully big enough
> to exercise some vector sharing.
> 
> Regards,
> --Natalie
> 
> 
> 

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_sCB/CCI14WNF1n+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vect_share_irq_2005-08-11_2.6.12.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vect_share_irq_2005-08-11_2.6.12.3"

diff -pru 2.6.12.3/arch/i386/kernel/acpi/boot.c z12.3/arch/i386/kernel/acpi/boot.c
--- 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/acpi/boot.c	2005-08-11 19:27:46.000000000 -0700
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
 
diff -pru 2.6.12.3/arch/x86_64/kernel/io_apic.c z12.3/arch/x86_64/kernel/io_apic.c
--- 2.6.12.3/arch/x86_64/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/io_apic.c	2005-08-11 19:32:28.000000000 -0700
@@ -56,7 +56,7 @@ int nr_ioapic_registers[MAX_IO_APICS];
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
-#define MAX_PLUS_SHARED_IRQS NR_IRQS
+#define MAX_PLUS_SHARED_IRQS NR_IRQ_VECTORS
 #define PIN_MAP_SIZE (MAX_PLUS_SHARED_IRQS + NR_IRQS)
 
 /*
@@ -88,6 +88,7 @@ static void add_pin_to_irq(unsigned int 
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
 
+	BUG_ON(irq >= NR_IRQS);
 	while (entry->next)
 		entry = irq_2_pin + entry->next;
 
@@ -95,7 +96,7 @@ static void add_pin_to_irq(unsigned int 
 		entry->next = first_free_entry;
 		entry = irq_2_pin + entry->next;
 		if (++first_free_entry >= PIN_MAP_SIZE)
-			panic("io_apic.c: whoops");
+			panic("io_apic.c: ran out of irq_2_pin entries!");
 	}
 	entry->apic = apic;
 	entry->pin = pin;
@@ -581,6 +582,69 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+static int __assign_irq_vector(int irq);
+
+static int next_irq = 16;
+
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
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
+	if (platform_legacy_irq(gsi)) {
+		gsi_2_irq[gsi] = gsi;
+		return gsi;
+	}
+
+	if (gsi_2_irq[gsi] != 0xFF)
+		return (int)gsi_2_irq[gsi];
+
+	tries = NR_IRQS;
+  try_again:
+	vector = __assign_irq_vector(gsi);
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
+		if (--tries >= 0)
+			goto try_again;
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
+	vector_irq[vector] = i;
+	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, i);
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -610,6 +674,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -619,6 +684,7 @@ static int pin_2_irq(int idx, int apic, 
 			break;
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 
 	/*
 	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
@@ -634,6 +700,7 @@ static int pin_2_irq(int idx, int apic, 
 			}
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 	return irq;
 }
 
@@ -657,12 +724,12 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-int assign_irq_vector(int irq)
+static int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
-	if (IO_APIC_VECTOR(irq) > 0)
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
 	current_vector += 8;
@@ -670,17 +737,24 @@ next:
 		goto next;
 
 	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset++;
-		if (!(offset%8))
-			return -ENOSPC;
+		/* If we run out of vectors on large boxen, must share them. */
+		offset = (offset + 1) % 8;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	vector_irq[current_vector] = irq;
+	return current_vector;
+}
+
+int assign_irq_vector(int irq)
+{
+	int vect;
+
+	vect = __assign_irq_vector(irq);
+	vector_irq[vect] = irq;
 	if (irq != AUTO_ASSIGN)
-		IO_APIC_VECTOR(irq) = current_vector;
+		IO_APIC_VECTOR(irq) = vect;
 
-	return current_vector;
+	return vect;
 }
 
 extern void (*interrupt[NR_IRQS])(void);
@@ -1866,6 +1940,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pru 2.6.12.3/arch/x86_64/kernel/mpparse.c z12.3/arch/x86_64/kernel/mpparse.c
--- 2.6.12.3/arch/x86_64/kernel/mpparse.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/mpparse.c	2005-08-11 19:34:53.000000000 -0700
@@ -214,7 +214,7 @@ static void __init MP_intsrc_info (struc
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries >= MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
diff -pru 2.6.12.3/include/asm-x86_64/mpspec.h z12.3/include/asm-x86_64/mpspec.h
--- 2.6.12.3/include/asm-x86_64/mpspec.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-x86_64/mpspec.h	2005-08-10 17:08:45.000000000 -0700
@@ -157,7 +157,8 @@ struct mpc_config_lintsrc
  */
 
 #define MAX_MP_BUSSES 256
-#define MAX_IRQ_SOURCES 256
+/* Each PCI slot may be a combo card with its own bus.  4 IRQ pins per slot. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,

--Boundary-00=_sCB/CCI14WNF1n+--
