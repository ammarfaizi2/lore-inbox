Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVHOC6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVHOC6F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 22:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVHOC6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 22:58:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5591 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932645AbVHOC6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 22:58:03 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Sun, 14 Aug 2005 19:57:53 -0700
User-Agent: KMail/1.7.1
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200507260012.41968.jamesclv@us.ibm.com> <200508040005.50817.jamesclv@us.ibm.com> <20050804092221.GL8266@wotan.suse.de>
In-Reply-To: <20050804092221.GL8266@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xSAADGpXAsUaIsm"
Message-Id: <200508141957.53396.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xSAADGpXAsUaIsm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 August 2005 02:22 am, Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:
> > diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c
> > n12.3/arch/i386/kernel/acpi/boot.c ---
> > 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000
> > -0700 +++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04
> > 00:01:10.199710211 -0700 @@ -42,6 +42,7 @@
> >  static inline void  acpi_madt_oem_check(char *oem_id, char
> > *oem_table_id) { } extern void __init clustered_apic_check(void);
> >  static inline int ioapic_setup_disabled(void) { return 0; }
> > +extern int gsi_irq_sharing(int gsi);
> >  #include <asm/proto.h>
> >
> >  #else	/* X86 */
> > @@ -51,6 +52,9 @@ static inline int ioapic_setup_disabled(
> >  #include <mach_mpparse.h>
> >  #endif	/* CONFIG_X86_LOCAL_APIC */
> >
> > +static inline int gsi_irq_sharing(int gsi) { return gsi; }
>
> Why is this different for i386/x86-64? It shouldn't.

True.  Have added code for i386.  Unfortunately, I didn't see one file 
that is shared by both architectures and which is included when 
building with I/O APIC support.  So, I duplicated the function into 
io_apic.c

> As a unrelated note we really need to get rid of this whole ifdef
> block.
>
> > +++ n12.3/arch/x86_64/Kconfig	2005-08-03 21:31:07.487451167 -0700
> > @@ -280,13 +280,13 @@ config HAVE_DEC_LOCK
> >  	default y
> >
> >  config NR_CPUS
> > -	int "Maximum number of CPUs (2-256)"
> > -	range 2 256
> > +	int "Maximum number of CPUs (2-255)"
> > +	range 2 255
> >  	depends on SMP
> > -	default "8"
> > +	default "16"
>
> Don't change the default please.
>
> > +static int next_irq = 16;
>
> Won't this need a lock for hotplug later?

That's what I thought originally, but maybe not.  We initialize all RTEs 
and assign IRQs+vectors fairly early in boot, plus store the results in 
arrays.  Thereafter the functions just return the preallocated values.

Hmmm...  Since the I/O APIC init comes after the other CPUs are brought 
online, and since I don't understand all that the MSI driver is trying 
to accomplish, it might be safer to use a spin lock anyway.

> > +
> > + retry_vector:
> > +	vector = assign_irq_vector(gsi);
> > +
> > +	/*
> > +	 * Sharing vectors means sharing IRQs, so scan irq_vectors for
> > previous +	 * use of vector and if found, return that IRQ. 
> > However, we never want +	 * to share legacy IRQs, which usually
> > have a different trigger mode +	 * than PCI.
> > +	 */
>
> Can we perhaps force such sharing early temporarily even when the
> table is not filled up?  This way we would get better test coverage
> of all of  this.
>
> That would be later disabled of course.

Suppose I added a static counter and pretended that every third 
non-legacy IRQ needed to be shared?

> Rest looks ok to me.
>
> -Andi

Sigh.  Have to attach the file again.  Sorry about that.

Signed-off-by:  James Cleverdon <jamesclv@us.ibm.com>

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm


--Boundary-00=_xSAADGpXAsUaIsm
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vect_share_irq_2005-08-14_2.6.12.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vect_share_irq_2005-08-14_2.6.12.3"

diff -pru 2.6.12.3/arch/i386/kernel/acpi/boot.c z12.3/arch/i386/kernel/acpi/boot.c
--- 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/acpi/boot.c	2005-08-14 15:40:36.000000000 -0700
@@ -453,7 +453,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
  		*irq = IO_APIC_VECTOR(gsi);
 	else
 #endif
-		*irq = gsi;
+		*irq = gsi_irq_sharing(gsi);
 	return 0;
 }
 
diff -pru 2.6.12.3/arch/i386/kernel/io_apic.c z12.3/arch/i386/kernel/io_apic.c
--- 2.6.12.3/arch/i386/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/io_apic.c	2005-08-14 17:33:46.000000000 -0700
@@ -62,7 +62,7 @@ int nr_ioapic_registers[MAX_IO_APICS];
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
-#define MAX_PLUS_SHARED_IRQS NR_IRQS
+#define MAX_PLUS_SHARED_IRQS NR_IRQ_VECTORS
 #define PIN_MAP_SIZE (MAX_PLUS_SHARED_IRQS + NR_IRQS)
 
 /*
@@ -1041,6 +1041,74 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+static int __assign_irq_vector(int irq);
+
+static int next_irq = 16;
+
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
+
+static DEFINE_SPINLOCK(gsi_irq_lock);
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
+	unsigned long flags;
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
+	spin_lock_irqsave(&gsi_irq_lock, flags);
+	i = next_irq++;
+	BUG_ON(i >= NR_IRQS);
+	gsi_2_irq[gsi] = i;
+	IO_APIC_VECTOR(i) = vector;
+	vector_irq[vector] = i;
+	spin_unlock_irqrestore(&gsi_irq_lock, flags);
+	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, i);
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -1071,6 +1139,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 
 			/*
 			 * For MPS mode, so far only needed by ES7000 platform
@@ -1127,11 +1196,11 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-int assign_irq_vector(int irq)
+static int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
 	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
@@ -1140,17 +1209,24 @@ next:
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
 
 static struct hw_interrupt_type ioapic_level_type;
@@ -2514,6 +2590,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask  = 1;
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pru 2.6.12.3/arch/i386/kernel/mpparse.c z12.3/arch/i386/kernel/mpparse.c
--- 2.6.12.3/arch/i386/kernel/mpparse.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/mpparse.c	2005-08-14 15:33:52.000000000 -0700
@@ -274,7 +274,7 @@ static void __init MP_intsrc_info (struc
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries >= MAX_IRQ_SOURCES)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
diff -pru 2.6.12.3/arch/x86_64/kernel/io_apic.c z12.3/arch/x86_64/kernel/io_apic.c
--- 2.6.12.3/arch/x86_64/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/io_apic.c	2005-08-14 16:45:13.000000000 -0700
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
@@ -581,6 +582,74 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+static int __assign_irq_vector(int irq);
+
+static int next_irq = 16;
+
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
+
+static DEFINE_SPINLOCK(gsi_irq_lock);
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
+	unsigned long flags;
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
+	spin_lock_irqsave(&gsi_irq_lock, flags);
+	i = next_irq++;
+	BUG_ON(i >= NR_IRQS);
+	gsi_2_irq[gsi] = i;
+	IO_APIC_VECTOR(i) = vector;
+	vector_irq[vector] = i;
+	spin_unlock_irqrestore(&gsi_irq_lock, flags);
+	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, i);
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -610,6 +679,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -619,6 +689,7 @@ static int pin_2_irq(int idx, int apic, 
 			break;
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 
 	/*
 	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
@@ -634,6 +705,7 @@ static int pin_2_irq(int idx, int apic, 
 			}
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 	return irq;
 }
 
@@ -657,12 +729,12 @@ static inline int IO_APIC_irq_trigger(in
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
@@ -670,17 +742,24 @@ next:
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
@@ -1866,6 +1945,7 @@ int io_apic_set_pci_routing (int ioapic,
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
 
diff -pru 2.6.12.3/include/asm-i386/apic.h z12.3/include/asm-i386/apic.h
--- 2.6.12.3/include/asm-i386/apic.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-i386/apic.h	2005-08-14 15:34:49.000000000 -0700
@@ -108,6 +108,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern int gsi_irq_sharing(int gsi);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
diff -pru 2.6.12.3/include/asm-i386/mach-generic/mach_mpspec.h z12.3/include/asm-i386/mach-generic/mach_mpspec.h
--- 2.6.12.3/include/asm-i386/mach-generic/mach_mpspec.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-i386/mach-generic/mach_mpspec.h	2005-08-14 15:39:10.000000000 -0700
@@ -1,7 +1,8 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-#define MAX_IRQ_SOURCES 256
+/* Each PCI slot may be a combo card with its own bus.  4 IRQ pins per slot. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
 
 /* Summit or generic (i.e. installer) kernels need lots of bus entries. */
 /* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
diff -pru 2.6.12.3/include/asm-x86_64/apic.h z12.3/include/asm-x86_64/apic.h
--- 2.6.12.3/include/asm-x86_64/apic.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-x86_64/apic.h	2005-08-14 15:36:51.000000000 -0700
@@ -98,6 +98,7 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
+extern int gsi_irq_sharing(int gsi);
 
 extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
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

--Boundary-00=_xSAADGpXAsUaIsm--
