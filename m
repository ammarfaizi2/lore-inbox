Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVHPDYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVHPDYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVHPDYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:24:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9878 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965081AbVHPDYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:24:50 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Mon, 15 Aug 2005 20:24:42 -0700
User-Agent: KMail/1.7.1
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200507260012.41968.jamesclv@us.ibm.com> <200508141957.53396.jamesclv@us.ibm.com> <20050815174432.GC20749@wotan.suse.de>
In-Reply-To: <20050815174432.GC20749@wotan.suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6xVAD1JeQCwxbO/"
Message-Id: <200508152024.42529.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6xVAD1JeQCwxbO/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 15 August 2005 10:44 am, Andi Kleen wrote:
> On Sun, Aug 14, 2005 at 07:57:53PM -0700, James Cleverdon wrote:
> > On Thursday 04 August 2005 02:22 am, Andi Kleen wrote:
> > > On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:
> > > > diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c
> > > > n12.3/arch/i386/kernel/acpi/boot.c ---
> > > > 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000
> > > > -0700 +++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04
> > > > 00:01:10.199710211 -0700 @@ -42,6 +42,7 @@
> > > >  static inline void  acpi_madt_oem_check(char *oem_id, char
> > > > *oem_table_id) { } extern void __init clustered_apic_check(void);
> > > >  static inline int ioapic_setup_disabled(void) { return 0; }
> > > > +extern int gsi_irq_sharing(int gsi);
> > > >  #include <asm/proto.h>
> > > >
> > > >  #else	/* X86 */
> > > > @@ -51,6 +52,9 @@ static inline int ioapic_setup_disabled(
> > > >  #include <mach_mpparse.h>
> > > >  #endif	/* CONFIG_X86_LOCAL_APIC */
> > > >
> > > > +static inline int gsi_irq_sharing(int gsi) { return gsi; }
> > >
> > > Why is this different for i386/x86-64? It shouldn't.
> > 
> > True.  Have added code for i386.  Unfortunately, I didn't see one file 
> > that is shared by both architectures and which is included when 
> > building with I/O APIC support.  So, I duplicated the function into 
> > io_apic.c
> 
> That needs to be cleaned up before merge. This code is already ugly and I don't
> want the cruft accumulating here.

OK, I moved the function into a separate file that can be used by
both architectures.

> > > As a unrelated note we really need to get rid of this whole ifdef
> > > block.
> > >
> > > > +++ n12.3/arch/x86_64/Kconfig	2005-08-03 21:31:07.487451167 -0700
> > > > @@ -280,13 +280,13 @@ config HAVE_DEC_LOCK
> > > >  	default y
> > > >
> > > >  config NR_CPUS
> > > > -	int "Maximum number of CPUs (2-256)"
> > > > -	range 2 256
> > > > +	int "Maximum number of CPUs (2-255)"
> > > > +	range 2 255
> > > >  	depends on SMP
> > > > -	default "8"
> > > > +	default "16"
> > >
> > > Don't change the default please.
> > >
> > > > +static int next_irq = 16;
> > >
> > > Won't this need a lock for hotplug later?
> > 
> > That's what I thought originally, but maybe not.  We initialize all RTEs 
> > and assign IRQs+vectors fairly early in boot, plus store the results in 
> > arrays.  Thereafter the functions just return the preallocated values.
> 
> I was thinking of IO-APIC hotplug here. IIRC the ia64 folks
> have it already and I'm sure someone will turn up with a patch
> for i386/x86-64 soon. For devices it should be ok, you're right.
> 
> Ok I guess they can change it in that patch then. Perhaps
> just add a comment.

I've already got a spin lock there, so may as well keep it.

> > > > have a different trigger mode +	 * than PCI.
> > > > +	 */
> > >
> > > Can we perhaps force such sharing early temporarily even when the
> > > table is not filled up?  This way we would get better test coverage
> > > of all of  this.
> > >
> > > That would be later disabled of course.
> > 
> > Suppose I added a static counter and pretended that every third 
> > non-legacy IRQ needed to be shared?
> 
> Can you drop into the sharing path unconditionally?
> 
> -Andi

If no vectors/IRQs are ever allocated, there is nothing to share.
Added some simple minded forced sharing to gsi_irq_sharing.  It
forces 1 in 3 IRQs to be shared.  That should exercise some of the
code paths.

Patch attached.  (Sorry.)

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_6xVAD1JeQCwxbO/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vect_share_irq_2005-08-15_2.6.12.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vect_share_irq_2005-08-15_2.6.12.3"

diff -pruN 2.6.12.3/arch/i386/kernel/Makefile z12.3/arch/i386/kernel/Makefile
--- 2.6.12.3/arch/i386/kernel/Makefile	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/Makefile	2005-08-15 15:57:45.000000000 -0700
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o
+		doublefault.o quirks.o gsi2irq.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c z12.3/arch/i386/kernel/acpi/boot.c
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
 
diff -pruN 2.6.12.3/arch/i386/kernel/gsi2irq.c z12.3/arch/i386/kernel/gsi2irq.c
--- 2.6.12.3/arch/i386/kernel/gsi2irq.c	1969-12-31 16:00:00.000000000 -0800
+++ z12.3/arch/i386/kernel/gsi2irq.c	2005-08-15 18:18:24.000000000 -0700
@@ -0,0 +1,134 @@
+/*
+ * Copyright 2005 James Cleverdon, IBM.
+ * Subject to the GNU Public License, v.2
+ *
+ * gsi2irq.c:
+ *
+ * IRQ and vector compression/sharing routines for i386 and x86-64 by
+ * James Cleverdon from a patch by Natalie Protasevich and
+ * architecture code from io_apic.c
+ */
+#include <linux/config.h>
+#include <asm/smp.h>
+#include <linux/irq.h>
+#include <asm/hw_irq.h>
+
+#ifdef	CONFIG_X86_64
+
+#include <asm/irq.h>
+
+#else	/* X86 */
+
+#include <irq_vectors_limits.h>
+
+#endif	/* X86 */
+
+
+#ifdef CONFIG_X86_IO_APIC
+
+extern int __assign_irq_vector(int irq);
+
+static int next_irq = 16;
+
+static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
+
+static DEFINE_SPINLOCK(gsi_irq_lock);
+
+#define DEBUG_GSI_IRQ_SHARING	1
+
+#ifdef DEBUG_GSI_IRQ_SHARING
+
+#undef KERN_INFO	/* Raise printk level. */
+#define KERN_INFO	KERN_ERR
+
+#define DEBUG_GSI_FORCE_SHARE_N	3
+static int gsi_irq_dbg_cnt = DEBUG_GSI_FORCE_SHARE_N;
+static int gsi_irq_dbg_irq = 16;
+
+#endif	/* DEBUG_GSI_IRQ_SHARING */
+
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
+#ifdef DEBUG_GSI_IRQ_SHARING
+	if (--gsi_irq_dbg_cnt < 0) {
+		/* Debug:  Force sharing on 1 of N IRQs.  N must be > 1. */
+		gsi_irq_dbg_cnt = DEBUG_GSI_FORCE_SHARE_N;
+		i = gsi_irq_dbg_irq++;
+		if (gsi_irq_dbg_irq >= next_irq)
+			gsi_irq_dbg_irq = 16;
+		gsi_2_irq[gsi] = i;
+		spin_unlock_irqrestore(&gsi_irq_lock, flags);
+		printk(KERN_INFO "GSI %d debug-share vector 0x%02X and IRQ %d\n",
+				gsi, IO_APIC_VECTOR(i), i);
+		return i;
+	}
+#endif	/* DEBUG_GSI_IRQ_SHARING */
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
+#else	/* CONFIG_X86_IO_APIC */
+
+/* No compression needed if no I/O APICs. */
+
+int gsi_irq_sharing(int gsi)
+{
+	return gsi;
+}
+
+#endif	/* CONFIG_X86_IO_APIC */
diff -pruN 2.6.12.3/arch/i386/kernel/io_apic.c z12.3/arch/i386/kernel/io_apic.c
--- 2.6.12.3/arch/i386/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/i386/kernel/io_apic.c	2005-08-15 14:40:38.000000000 -0700
@@ -62,7 +62,7 @@ int nr_ioapic_registers[MAX_IO_APICS];
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
-#define MAX_PLUS_SHARED_IRQS NR_IRQS
+#define MAX_PLUS_SHARED_IRQS NR_IRQ_VECTORS
 #define PIN_MAP_SIZE (MAX_PLUS_SHARED_IRQS + NR_IRQS)
 
 /*
@@ -1071,6 +1071,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 
 			/*
 			 * For MPS mode, so far only needed by ES7000 platform
@@ -1127,11 +1128,11 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-int assign_irq_vector(int irq)
+int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
 	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
@@ -1140,17 +1141,24 @@ next:
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
@@ -2514,6 +2522,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask  = 1;
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pruN 2.6.12.3/arch/i386/kernel/mpparse.c z12.3/arch/i386/kernel/mpparse.c
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
 
diff -pruN 2.6.12.3/arch/x86_64/kernel/Makefile z12.3/arch/x86_64/kernel/Makefile
--- 2.6.12.3/arch/x86_64/kernel/Makefile	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/Makefile	2005-08-15 15:06:26.000000000 -0700
@@ -7,7 +7,7 @@ EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o
+		setup64.o bootflag.o e820.o reboot.o quirks.o gsi2irq.o
 
 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
@@ -44,3 +44,4 @@ swiotlb-$(CONFIG_SWIOTLB)      += ../../
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
 intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
 quirks-y			+= ../../i386/kernel/quirks.o
+gsi2irq-y			+= ../../i386/kernel/gsi2irq.o
diff -pruN 2.6.12.3/arch/x86_64/kernel/io_apic.c z12.3/arch/x86_64/kernel/io_apic.c
--- 2.6.12.3/arch/x86_64/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/io_apic.c	2005-08-15 15:18:07.000000000 -0700
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
@@ -610,6 +611,7 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -619,6 +621,7 @@ static int pin_2_irq(int idx, int apic, 
 			break;
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 
 	/*
 	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
@@ -634,6 +637,7 @@ static int pin_2_irq(int idx, int apic, 
 			}
 		}
 	}
+	BUG_ON(irq >= NR_IRQS);
 	return irq;
 }
 
@@ -657,12 +661,12 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-int assign_irq_vector(int irq)
+int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
-	if (IO_APIC_VECTOR(irq) > 0)
+	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
 	current_vector += 8;
@@ -670,17 +674,24 @@ next:
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
@@ -1866,6 +1877,7 @@ int io_apic_set_pci_routing (int ioapic,
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
 
+	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
diff -pruN 2.6.12.3/arch/x86_64/kernel/mpparse.c z12.3/arch/x86_64/kernel/mpparse.c
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
 
diff -pruN 2.6.12.3/include/asm-i386/apic.h z12.3/include/asm-i386/apic.h
--- 2.6.12.3/include/asm-i386/apic.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-i386/apic.h	2005-08-14 15:34:49.000000000 -0700
@@ -108,6 +108,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern int gsi_irq_sharing(int gsi);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
diff -pruN 2.6.12.3/include/asm-i386/hw_irq.h z12.3/include/asm-i386/hw_irq.h
--- 2.6.12.3/include/asm-i386/hw_irq.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-i386/hw_irq.h	2005-08-15 15:14:32.000000000 -0700
@@ -28,6 +28,7 @@
 extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 #define AUTO_ASSIGN		-1
+extern int vector_irq[NR_VECTORS];
 
 extern void (*interrupt[NR_IRQS])(void);
 
diff -pruN 2.6.12.3/include/asm-i386/mach-generic/mach_mpspec.h z12.3/include/asm-i386/mach-generic/mach_mpspec.h
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
diff -pruN 2.6.12.3/include/asm-x86_64/apic.h z12.3/include/asm-x86_64/apic.h
--- 2.6.12.3/include/asm-x86_64/apic.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-x86_64/apic.h	2005-08-14 15:36:51.000000000 -0700
@@ -98,6 +98,7 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
+extern int gsi_irq_sharing(int gsi);
 
 extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
diff -pruN 2.6.12.3/include/asm-x86_64/hw_irq.h z12.3/include/asm-x86_64/hw_irq.h
--- 2.6.12.3/include/asm-x86_64/hw_irq.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-x86_64/hw_irq.h	2005-08-15 15:14:41.000000000 -0700
@@ -79,6 +75,7 @@ struct hw_interrupt_type;
 extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 #define AUTO_ASSIGN		-1
+extern int vector_irq[NR_VECTORS];
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
diff -pruN 2.6.12.3/include/asm-x86_64/mpspec.h z12.3/include/asm-x86_64/mpspec.h
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

--Boundary-00=_6xVAD1JeQCwxbO/--
