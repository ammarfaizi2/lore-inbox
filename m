Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFKNoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTFKNoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:44:10 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:4592 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id S261245AbTFKNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:43:11 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BDA74@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
To: torvalds@transmeta.com
Cc: "'akpm@digeo.com'" <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2][2.5]Unisys ES7000 platform subarch
Date: Wed, 11 Jun 2003 08:41:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3301F.3578C032"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3301F.3578C032
Content-Type: text/plain;
	charset="iso-8859-1"

Here is the "generic" patch #1. It deals with the IRQ overrides (most of
changes in mpparse.c and PCI range adjustment in io_apic.c), insufficient
width of IO-APIC ID, and a corner case for defining quantities of things
like APICs, IRQ sources, etc. (the attempt to make easier defining these
items in subarchs resulted in separation of MP definition portion in
include/asm-i386/mpparse.h from its enumeration portion). It has also
Venkatesh Palladi's fix that he suggested earlier for the correct APIC
version; I had to have it for this platform since the correct APIC version
will be needed later for dynamic platform discovery when es7000 will be
incorporated into genapic.




diff -Naur linux-2.5.70/arch/i386/kernel/io_apic.c
linux70-nbp/arch/i386/kernel/io_apic.c
--- linux-2.5.70/arch/i386/kernel/io_apic.c	2003-05-26
19:00:28.000000000 -0600
+++ linux70-nbp/arch/i386/kernel/io_apic.c	2003-06-09
10:11:25.000000000 -0600
@@ -1072,6 +1072,8 @@
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+			if ((!apic) && (irq < 16)) 
+				irq += 16;
 			break;
 		}
 		default:
@@ -1299,7 +1301,9 @@
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n",
reg_00.ID);
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n",
reg_00.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
-	if (reg_00.__reserved_0 || reg_00.__reserved_1 ||
reg_00.__reserved_2)
+	if (reg_00.ID >= APIC_BROADCAST_ID)
+		UNEXPECTED_IO_APIC();
+	if (reg_00.__reserved_1 || reg_00.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
@@ -1623,7 +1627,7 @@
 			mp_ioapics[apic].mpc_apicid = i;
 		} else {
 			printk("Setting %d in the phys_id_present_map\n",
mp_ioapics[apic].mpc_apicid);
-			phys_id_present_map |= 1 <<
mp_ioapics[apic].mpc_apicid;
+			phys_id_present_map |=
apicid_to_cpu_present(mp_ioapics[apic].mpc_apicid);
 		}
 
 
@@ -2224,10 +2228,10 @@
 	 * Every APIC in a system must have a unique ID or we get lots of
nice 
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.
 	 */
-	if (apic_id_map & (1 << apic_id)) {
+	if (check_apicid_used(apic_id_map, apic_id)) {
 
 		for (i = 0; i < IO_APIC_MAX_ID; i++) {
-			if (!(apic_id_map & (1 << i)))
+			if (!check_apicid_used(apic_id_map, i))
 				break;
 		}
 
@@ -2240,7 +2244,7 @@
 		apic_id = i;
 	} 
 
-	apic_id_map |= (1 << apic_id);
+	apic_id_map |= apicid_to_cpu_present(apic_id);
 
 	if (reg_00.ID != apic_id) {
 		reg_00.ID = apic_id;
diff -Naur linux-2.5.70/arch/i386/kernel/mpparse.c
linux70-nbp/arch/i386/kernel/mpparse.c
--- linux-2.5.70/arch/i386/kernel/mpparse.c	2003-05-26
19:00:27.000000000 -0600
+++ linux70-nbp/arch/i386/kernel/mpparse.c	2003-06-10
04:13:34.000000000 -0600
@@ -814,7 +814,7 @@
 
 	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-	processor.mpc_apicver = 0x10; /* TBD: lapic version */
+	processor.mpc_apicver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) | 
@@ -951,7 +951,7 @@
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
-			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq ==
intsrc.mpc_srcbusirq)) {
 			mp_irqs[i] = intsrc;
 			found = 1;
 			break;
@@ -1109,6 +1109,8 @@
 			continue;
 		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
+		if (!ioapic && (irq < 16))
+			irq += 16;
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries

 		 * with redundant pin->irq mappings (but unique PCI
devices);
diff -Naur linux-2.5.70/include/asm-i386/io_apic.h
linux70-nbp/include/asm-i386/io_apic.h
--- linux-2.5.70/include/asm-i386/io_apic.h	2003-05-26
19:00:42.000000000 -0600
+++ linux70-nbp/include/asm-i386/io_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -27,8 +27,7 @@
 		LTS		:  1,
 		delivery_type	:  1,
 		__reserved_1	:  8,
-		ID		:  4,
-		__reserved_0	:  4;
+		ID		:  8;
 } __attribute__ ((packed));
 
 struct IO_APIC_reg_01 {
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 16 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 16
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 16 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 16
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 512
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h
linux70-nbp/include/asm-i386/mach-summit/mach_apic.h
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mpspec.h
linux70-nbp/include/asm-i386/mpspec.h
--- linux-2.5.70/include/asm-i386/mpspec.h	2003-05-26
19:00:19.000000000 -0600
+++ linux70-nbp/include/asm-i386/mpspec.h	2003-06-09
10:11:25.000000000 -0600
@@ -1,204 +1,9 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
-/*
- * Structure definitions for SMP machines following the
- * Intel Multiprocessing Specification 1.1 and 1.4.
- */
-
-/*
- * This tag identifies where the SMP configuration
- * information is. 
- */
- 
-#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
-
-/*
- * a maximum of 16 APICs with the current APIC ID architecture.
- */
-#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT) ||
defined(CONFIG_X86_GENERICARCH)
-#define MAX_APICS 256
-#else
-#define MAX_APICS 16
-#endif
-
-#define MAX_MPC_ENTRY 1024
+#include <asm/mpspec_def.h>
+#include <mach_mpspec.h>
 
-struct intel_mp_floating
-{
-	char mpf_signature[4];		/* "_MP_" 			*/
-	unsigned long mpf_physptr;	/* Configuration table address	*/
-	unsigned char mpf_length;	/* Our length (paragraphs)	*/
-	unsigned char mpf_specification;/* Specification version	*/
-	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/
-	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/
-	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/
-	unsigned char mpf_feature3;	/* Unused (0)			*/
-	unsigned char mpf_feature4;	/* Unused (0)			*/
-	unsigned char mpf_feature5;	/* Unused (0)			*/
-};
-
-struct mp_config_table
-{
-	char mpc_signature[4];
-#define MPC_SIGNATURE "PCMP"
-	unsigned short mpc_length;	/* Size of table */
-	char  mpc_spec;			/* 0x01 */
-	char  mpc_checksum;
-	char  mpc_oem[8];
-	char  mpc_productid[12];
-	unsigned long mpc_oemptr;	/* 0 if not present */
-	unsigned short mpc_oemsize;	/* 0 if not present */
-	unsigned short mpc_oemcount;
-	unsigned long mpc_lapic;	/* APIC address */
-	unsigned long reserved;
-};
-
-/* Followed by entries */
-
-#define	MP_PROCESSOR	0
-#define	MP_BUS		1
-#define	MP_IOAPIC	2
-#define	MP_INTSRC	3
-#define	MP_LINTSRC	4
-#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node
locality */
-
-struct mpc_config_processor
-{
-	unsigned char mpc_type;
-	unsigned char mpc_apicid;	/* Local APIC number */
-	unsigned char mpc_apicver;	/* Its versions */
-	unsigned char mpc_cpuflag;
-#define CPU_ENABLED		1	/* Processor is available */
-#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */
-	unsigned long mpc_cpufeature;		
-#define CPU_STEPPING_MASK 0x0F
-#define CPU_MODEL_MASK	0xF0
-#define CPU_FAMILY_MASK	0xF00
-	unsigned long mpc_featureflag;	/* CPUID feature value */
-	unsigned long mpc_reserved[2];
-};
-
-struct mpc_config_bus
-{
-	unsigned char mpc_type;
-	unsigned char mpc_busid;
-	unsigned char mpc_bustype[6] __attribute((packed));
-};
-
-/* List of Bus Type string values, Intel MP Spec. */
-#define BUSTYPE_EISA	"EISA"
-#define BUSTYPE_ISA	"ISA"
-#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
-#define BUSTYPE_MCA	"MCA"
-#define BUSTYPE_VL	"VL"		/* Local bus */
-#define BUSTYPE_PCI	"PCI"
-#define BUSTYPE_PCMCIA	"PCMCIA"
-#define BUSTYPE_CBUS	"CBUS"
-#define BUSTYPE_CBUSII	"CBUSII"
-#define BUSTYPE_FUTURE	"FUTURE"
-#define BUSTYPE_MBI	"MBI"
-#define BUSTYPE_MBII	"MBII"
-#define BUSTYPE_MPI	"MPI"
-#define BUSTYPE_MPSA	"MPSA"
-#define BUSTYPE_NUBUS	"NUBUS"
-#define BUSTYPE_TC	"TC"
-#define BUSTYPE_VME	"VME"
-#define BUSTYPE_XPRESS	"XPRESS"
-#define BUSTYPE_NEC98	"NEC98"
-
-struct mpc_config_ioapic
-{
-	unsigned char mpc_type;
-	unsigned char mpc_apicid;
-	unsigned char mpc_apicver;
-	unsigned char mpc_flags;
-#define MPC_APIC_USABLE		0x01
-	unsigned long mpc_apicaddr;
-};
-
-struct mpc_config_intsrc
-{
-	unsigned char mpc_type;
-	unsigned char mpc_irqtype;
-	unsigned short mpc_irqflag;
-	unsigned char mpc_srcbus;
-	unsigned char mpc_srcbusirq;
-	unsigned char mpc_dstapic;
-	unsigned char mpc_dstirq;
-};
-
-enum mp_irq_source_types {
-	mp_INT = 0,
-	mp_NMI = 1,
-	mp_SMI = 2,
-	mp_ExtINT = 3
-};
-
-#define MP_IRQDIR_DEFAULT	0
-#define MP_IRQDIR_HIGH		1
-#define MP_IRQDIR_LOW		3
-
-
-struct mpc_config_lintsrc
-{
-	unsigned char mpc_type;
-	unsigned char mpc_irqtype;
-	unsigned short mpc_irqflag;
-	unsigned char mpc_srcbusid;
-	unsigned char mpc_srcbusirq;
-	unsigned char mpc_destapic;	
-#define MP_APIC_ALL	0xFF
-	unsigned char mpc_destapiclint;
-};
-
-struct mp_config_oemtable
-{
-	char oem_signature[4];
-#define MPC_OEM_SIGNATURE "_OEM"
-	unsigned short oem_length;	/* Size of table */
-	char  oem_rev;			/* 0x01 */
-	char  oem_checksum;
-	char  mpc_oem[8];
-};
-
-struct mpc_config_translation
-{
-        unsigned char mpc_type;
-        unsigned char trans_len;
-        unsigned char trans_type;
-        unsigned char trans_quad;
-        unsigned char trans_global;
-        unsigned char trans_local;
-        unsigned short trans_reserved;
-};
-
-/*
- *	Default configurations
- *
- *	1	2 CPU ISA 82489DX
- *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA
chaining
- *	3	2 CPU EISA 82489DX
- *	4	2 CPU MCA 82489DX
- *	5	2 CPU ISA+PCI
- *	6	2 CPU EISA+PCI
- *	7	2 CPU MCA+PCI
- */
-
-#ifdef CONFIG_X86_NUMAQ
-#define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_X86_NUMAQ */
-#define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_X86_NUMAQ */
-
-#define MAX_MP_BUSSES 32
-enum mp_bustype {
-	MP_BUS_ISA = 1,
-	MP_BUS_EISA,
-	MP_BUS_PCI,
-	MP_BUS_MCA,
-	MP_BUS_NEC98
-};
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_node [MAX_MP_BUSSES];
 extern int mp_bus_id_to_local [MAX_MP_BUSSES];
diff -Naur linux-2.5.70/include/asm-i386/mpspec_def.h
linux70-nbp/include/asm-i386/mpspec_def.h
--- linux-2.5.70/include/asm-i386/mpspec_def.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mpspec_def.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,187 @@
+#ifndef __ASM_MPSPEC_DEF_H
+#define __ASM_MPSPEC_DEF_H
+
+/*
+ * Structure definitions for SMP machines following the
+ * Intel Multiprocessing Specification 1.1 and 1.4.
+ */
+
+/*
+ * This tag identifies where the SMP configuration
+ * information is. 
+ */
+ 
+#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
+
+#define MAX_MPC_ENTRY 1024
+
+struct intel_mp_floating
+{
+	char mpf_signature[4];		/* "_MP_" 			*/
+	unsigned long mpf_physptr;	/* Configuration table address	*/
+	unsigned char mpf_length;	/* Our length (paragraphs)	*/
+	unsigned char mpf_specification;/* Specification version	*/
+	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/
+	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/
+	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/
+	unsigned char mpf_feature3;	/* Unused (0)			*/
+	unsigned char mpf_feature4;	/* Unused (0)			*/
+	unsigned char mpf_feature5;	/* Unused (0)			*/
+};
+
+struct mp_config_table
+{
+	char mpc_signature[4];
+#define MPC_SIGNATURE "PCMP"
+	unsigned short mpc_length;	/* Size of table */
+	char  mpc_spec;			/* 0x01 */
+	char  mpc_checksum;
+	char  mpc_oem[8];
+	char  mpc_productid[12];
+	unsigned long mpc_oemptr;	/* 0 if not present */
+	unsigned short mpc_oemsize;	/* 0 if not present */
+	unsigned short mpc_oemcount;
+	unsigned long mpc_lapic;	/* APIC address */
+	unsigned long reserved;
+};
+
+/* Followed by entries */
+
+#define	MP_PROCESSOR	0
+#define	MP_BUS		1
+#define	MP_IOAPIC	2
+#define	MP_INTSRC	3
+#define	MP_LINTSRC	4
+#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node
locality */
+
+struct mpc_config_processor
+{
+	unsigned char mpc_type;
+	unsigned char mpc_apicid;	/* Local APIC number */
+	unsigned char mpc_apicver;	/* Its versions */
+	unsigned char mpc_cpuflag;
+#define CPU_ENABLED		1	/* Processor is available */
+#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */
+	unsigned long mpc_cpufeature;		
+#define CPU_STEPPING_MASK 0x0F
+#define CPU_MODEL_MASK	0xF0
+#define CPU_FAMILY_MASK	0xF00
+	unsigned long mpc_featureflag;	/* CPUID feature value */
+	unsigned long mpc_reserved[2];
+};
+
+struct mpc_config_bus
+{
+	unsigned char mpc_type;
+	unsigned char mpc_busid;
+	unsigned char mpc_bustype[6] __attribute((packed));
+};
+
+/* List of Bus Type string values, Intel MP Spec. */
+#define BUSTYPE_EISA	"EISA"
+#define BUSTYPE_ISA	"ISA"
+#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
+#define BUSTYPE_MCA	"MCA"
+#define BUSTYPE_VL	"VL"		/* Local bus */
+#define BUSTYPE_PCI	"PCI"
+#define BUSTYPE_PCMCIA	"PCMCIA"
+#define BUSTYPE_CBUS	"CBUS"
+#define BUSTYPE_CBUSII	"CBUSII"
+#define BUSTYPE_FUTURE	"FUTURE"
+#define BUSTYPE_MBI	"MBI"
+#define BUSTYPE_MBII	"MBII"
+#define BUSTYPE_MPI	"MPI"
+#define BUSTYPE_MPSA	"MPSA"
+#define BUSTYPE_NUBUS	"NUBUS"
+#define BUSTYPE_TC	"TC"
+#define BUSTYPE_VME	"VME"
+#define BUSTYPE_XPRESS	"XPRESS"
+#define BUSTYPE_NEC98	"NEC98"
+
+struct mpc_config_ioapic
+{
+	unsigned char mpc_type;
+	unsigned char mpc_apicid;
+	unsigned char mpc_apicver;
+	unsigned char mpc_flags;
+#define MPC_APIC_USABLE		0x01
+	unsigned long mpc_apicaddr;
+};
+
+struct mpc_config_intsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbus;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_dstapic;
+	unsigned char mpc_dstirq;
+};
+
+enum mp_irq_source_types {
+	mp_INT = 0,
+	mp_NMI = 1,
+	mp_SMI = 2,
+	mp_ExtINT = 3
+};
+
+#define MP_IRQDIR_DEFAULT	0
+#define MP_IRQDIR_HIGH		1
+#define MP_IRQDIR_LOW		3
+
+
+struct mpc_config_lintsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbusid;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_destapic;	
+#define MP_APIC_ALL	0xFF
+	unsigned char mpc_destapiclint;
+};
+
+struct mp_config_oemtable
+{
+	char oem_signature[4];
+#define MPC_OEM_SIGNATURE "_OEM"
+	unsigned short oem_length;	/* Size of table */
+	char  oem_rev;			/* 0x01 */
+	char  oem_checksum;
+	char  mpc_oem[8];
+};
+
+struct mpc_config_translation
+{
+        unsigned char mpc_type;
+        unsigned char trans_len;
+        unsigned char trans_type;
+        unsigned char trans_quad;
+        unsigned char trans_global;
+        unsigned char trans_local;
+        unsigned short trans_reserved;
+};
+
+/*
+ *	Default configurations
+ *
+ *	1	2 CPU ISA 82489DX
+ *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA
chaining
+ *	3	2 CPU EISA 82489DX
+ *	4	2 CPU MCA 82489DX
+ *	5	2 CPU ISA+PCI
+ *	6	2 CPU EISA+PCI
+ *	7	2 CPU MCA+PCI
+ */
+
+enum mp_bustype {
+	MP_BUS_ISA = 1,
+	MP_BUS_EISA,
+	MP_BUS_PCI,
+	MP_BUS_MCA,
+	MP_BUS_NEC98
+};
+#endif
+

 <<gen2.5.70.txt>> 

------_=_NextPart_000_01C3301F.3578C032
Content-Type: text/plain;
	name="gen2.5.70.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gen2.5.70.txt"

diff -Naur linux-2.5.70/arch/i386/kernel/io_apic.c =
linux70-nbp/arch/i386/kernel/io_apic.c
--- linux-2.5.70/arch/i386/kernel/io_apic.c	2003-05-26 =
19:00:28.000000000 -0600
+++ linux70-nbp/arch/i386/kernel/io_apic.c	2003-06-09 =
10:11:25.000000000 -0600
@@ -1072,6 +1072,8 @@
 			while (i < apic)
 				irq +=3D nr_ioapic_registers[i++];
 			irq +=3D pin;
+			if ((!apic) && (irq < 16))=20
+				irq +=3D 16;
 			break;
 		}
 		default:
@@ -1299,7 +1301,9 @@
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", =
reg_00.ID);
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", =
reg_00.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
-	if (reg_00.__reserved_0 || reg_00.__reserved_1 || =
reg_00.__reserved_2)
+	if (reg_00.ID >=3D APIC_BROADCAST_ID)
+		UNEXPECTED_IO_APIC();
+	if (reg_00.__reserved_1 || reg_00.__reserved_2)
 		UNEXPECTED_IO_APIC();
=20
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
@@ -1623,7 +1627,7 @@
 			mp_ioapics[apic].mpc_apicid =3D i;
 		} else {
 			printk("Setting %d in the phys_id_present_map\n", =
mp_ioapics[apic].mpc_apicid);
-			phys_id_present_map |=3D 1 << mp_ioapics[apic].mpc_apicid;
+			phys_id_present_map |=3D =
apicid_to_cpu_present(mp_ioapics[apic].mpc_apicid);
 		}
=20
=20
@@ -2224,10 +2228,10 @@
 	 * Every APIC in a system must have a unique ID or we get lots of =
nice=20
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.
 	 */
-	if (apic_id_map & (1 << apic_id)) {
+	if (check_apicid_used(apic_id_map, apic_id)) {
=20
 		for (i =3D 0; i < IO_APIC_MAX_ID; i++) {
-			if (!(apic_id_map & (1 << i)))
+			if (!check_apicid_used(apic_id_map, i))
 				break;
 		}
=20
@@ -2240,7 +2244,7 @@
 		apic_id =3D i;
 	}=20
=20
-	apic_id_map |=3D (1 << apic_id);
+	apic_id_map |=3D apicid_to_cpu_present(apic_id);
=20
 	if (reg_00.ID !=3D apic_id) {
 		reg_00.ID =3D apic_id;
diff -Naur linux-2.5.70/arch/i386/kernel/mpparse.c =
linux70-nbp/arch/i386/kernel/mpparse.c
--- linux-2.5.70/arch/i386/kernel/mpparse.c	2003-05-26 =
19:00:27.000000000 -0600
+++ linux70-nbp/arch/i386/kernel/mpparse.c	2003-06-10 =
04:13:34.000000000 -0600
@@ -814,7 +814,7 @@
=20
 	processor.mpc_type =3D MP_PROCESSOR;
 	processor.mpc_apicid =3D id;
-	processor.mpc_apicver =3D 0x10; /* TBD: lapic version */
+	processor.mpc_apicver =3D GET_APIC_VERSION(apic_read(APIC_LVR));
 	processor.mpc_cpuflag =3D (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |=3D (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature =3D (boot_cpu_data.x86 << 8) |=20
@@ -951,7 +951,7 @@
 	 */
 	for (i =3D 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_dstapic =3D=3D intsrc.mpc_dstapic)=20
-			&& (mp_irqs[i].mpc_dstirq =3D=3D intsrc.mpc_dstirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq =3D=3D intsrc.mpc_srcbusirq)) {
 			mp_irqs[i] =3D intsrc;
 			found =3D 1;
 			break;
@@ -1109,6 +1109,8 @@
 			continue;
 		ioapic_pin =3D irq - mp_ioapic_routing[ioapic].irq_start;
=20
+		if (!ioapic && (irq < 16))
+			irq +=3D 16;
 		/*=20
 		 * Avoid pin reprogramming.  PRTs typically include entries =20
 		 * with redundant pin->irq mappings (but unique PCI devices);
diff -Naur linux-2.5.70/include/asm-i386/io_apic.h =
linux70-nbp/include/asm-i386/io_apic.h
--- linux-2.5.70/include/asm-i386/io_apic.h	2003-05-26 =
19:00:42.000000000 -0600
+++ linux70-nbp/include/asm-i386/io_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -27,8 +27,7 @@
 		LTS		:  1,
 		delivery_type	:  1,
 		__reserved_1	:  8,
-		ID		:  4,
-		__reserved_0	:  4;
+		ID		:  8;
 } __attribute__ ((packed));
=20
 struct IO_APIC_reg_01 {
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 16 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 16
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 16 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 16
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 512
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h =
linux70-nbp/include/asm-i386/mach-summit/mach_apic.h
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_MPSPEC_H
+#define __ASM_MACH_MPSPEC_H
+
+/*
+ * a maximum of 256 APICs with the current APIC ID architecture.
+ */
+#define MAX_APICS 256
+
+#define MAX_IRQ_SOURCES 256
+
+#define MAX_MP_BUSSES 32
+
+#endif /* __ASM_MACH_MPSPEC_H */
diff -Naur linux-2.5.70/include/asm-i386/mpspec.h =
linux70-nbp/include/asm-i386/mpspec.h
--- linux-2.5.70/include/asm-i386/mpspec.h	2003-05-26 =
19:00:19.000000000 -0600
+++ linux70-nbp/include/asm-i386/mpspec.h	2003-06-09 10:11:25.000000000 =
-0600
@@ -1,204 +1,9 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
=20
-/*
- * Structure definitions for SMP machines following the
- * Intel Multiprocessing Specification 1.1 and 1.4.
- */
-
-/*
- * This tag identifies where the SMP configuration
- * information is.=20
- */
-=20
-#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
-
-/*
- * a maximum of 16 APICs with the current APIC ID architecture.
- */
-#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT) || =
defined(CONFIG_X86_GENERICARCH)
-#define MAX_APICS 256
-#else
-#define MAX_APICS 16
-#endif
-
-#define MAX_MPC_ENTRY 1024
+#include <asm/mpspec_def.h>
+#include <mach_mpspec.h>
=20
-struct intel_mp_floating
-{
-	char mpf_signature[4];		/* "_MP_" 			*/
-	unsigned long mpf_physptr;	/* Configuration table address	*/
-	unsigned char mpf_length;	/* Our length (paragraphs)	*/
-	unsigned char mpf_specification;/* Specification version	*/
-	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/
-	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/
-	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/
-	unsigned char mpf_feature3;	/* Unused (0)			*/
-	unsigned char mpf_feature4;	/* Unused (0)			*/
-	unsigned char mpf_feature5;	/* Unused (0)			*/
-};
-
-struct mp_config_table
-{
-	char mpc_signature[4];
-#define MPC_SIGNATURE "PCMP"
-	unsigned short mpc_length;	/* Size of table */
-	char  mpc_spec;			/* 0x01 */
-	char  mpc_checksum;
-	char  mpc_oem[8];
-	char  mpc_productid[12];
-	unsigned long mpc_oemptr;	/* 0 if not present */
-	unsigned short mpc_oemsize;	/* 0 if not present */
-	unsigned short mpc_oemcount;
-	unsigned long mpc_lapic;	/* APIC address */
-	unsigned long reserved;
-};
-
-/* Followed by entries */
-
-#define	MP_PROCESSOR	0
-#define	MP_BUS		1
-#define	MP_IOAPIC	2
-#define	MP_INTSRC	3
-#define	MP_LINTSRC	4
-#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node =
locality */
-
-struct mpc_config_processor
-{
-	unsigned char mpc_type;
-	unsigned char mpc_apicid;	/* Local APIC number */
-	unsigned char mpc_apicver;	/* Its versions */
-	unsigned char mpc_cpuflag;
-#define CPU_ENABLED		1	/* Processor is available */
-#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */
-	unsigned long mpc_cpufeature;	=09
-#define CPU_STEPPING_MASK 0x0F
-#define CPU_MODEL_MASK	0xF0
-#define CPU_FAMILY_MASK	0xF00
-	unsigned long mpc_featureflag;	/* CPUID feature value */
-	unsigned long mpc_reserved[2];
-};
-
-struct mpc_config_bus
-{
-	unsigned char mpc_type;
-	unsigned char mpc_busid;
-	unsigned char mpc_bustype[6] __attribute((packed));
-};
-
-/* List of Bus Type string values, Intel MP Spec. */
-#define BUSTYPE_EISA	"EISA"
-#define BUSTYPE_ISA	"ISA"
-#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
-#define BUSTYPE_MCA	"MCA"
-#define BUSTYPE_VL	"VL"		/* Local bus */
-#define BUSTYPE_PCI	"PCI"
-#define BUSTYPE_PCMCIA	"PCMCIA"
-#define BUSTYPE_CBUS	"CBUS"
-#define BUSTYPE_CBUSII	"CBUSII"
-#define BUSTYPE_FUTURE	"FUTURE"
-#define BUSTYPE_MBI	"MBI"
-#define BUSTYPE_MBII	"MBII"
-#define BUSTYPE_MPI	"MPI"
-#define BUSTYPE_MPSA	"MPSA"
-#define BUSTYPE_NUBUS	"NUBUS"
-#define BUSTYPE_TC	"TC"
-#define BUSTYPE_VME	"VME"
-#define BUSTYPE_XPRESS	"XPRESS"
-#define BUSTYPE_NEC98	"NEC98"
-
-struct mpc_config_ioapic
-{
-	unsigned char mpc_type;
-	unsigned char mpc_apicid;
-	unsigned char mpc_apicver;
-	unsigned char mpc_flags;
-#define MPC_APIC_USABLE		0x01
-	unsigned long mpc_apicaddr;
-};
-
-struct mpc_config_intsrc
-{
-	unsigned char mpc_type;
-	unsigned char mpc_irqtype;
-	unsigned short mpc_irqflag;
-	unsigned char mpc_srcbus;
-	unsigned char mpc_srcbusirq;
-	unsigned char mpc_dstapic;
-	unsigned char mpc_dstirq;
-};
-
-enum mp_irq_source_types {
-	mp_INT =3D 0,
-	mp_NMI =3D 1,
-	mp_SMI =3D 2,
-	mp_ExtINT =3D 3
-};
-
-#define MP_IRQDIR_DEFAULT	0
-#define MP_IRQDIR_HIGH		1
-#define MP_IRQDIR_LOW		3
-
-
-struct mpc_config_lintsrc
-{
-	unsigned char mpc_type;
-	unsigned char mpc_irqtype;
-	unsigned short mpc_irqflag;
-	unsigned char mpc_srcbusid;
-	unsigned char mpc_srcbusirq;
-	unsigned char mpc_destapic;=09
-#define MP_APIC_ALL	0xFF
-	unsigned char mpc_destapiclint;
-};
-
-struct mp_config_oemtable
-{
-	char oem_signature[4];
-#define MPC_OEM_SIGNATURE "_OEM"
-	unsigned short oem_length;	/* Size of table */
-	char  oem_rev;			/* 0x01 */
-	char  oem_checksum;
-	char  mpc_oem[8];
-};
-
-struct mpc_config_translation
-{
-        unsigned char mpc_type;
-        unsigned char trans_len;
-        unsigned char trans_type;
-        unsigned char trans_quad;
-        unsigned char trans_global;
-        unsigned char trans_local;
-        unsigned short trans_reserved;
-};
-
-/*
- *	Default configurations
- *
- *	1	2 CPU ISA 82489DX
- *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining
- *	3	2 CPU EISA 82489DX
- *	4	2 CPU MCA 82489DX
- *	5	2 CPU ISA+PCI
- *	6	2 CPU EISA+PCI
- *	7	2 CPU MCA+PCI
- */
-
-#ifdef CONFIG_X86_NUMAQ
-#define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_X86_NUMAQ */
-#define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_X86_NUMAQ */
-
-#define MAX_MP_BUSSES 32
-enum mp_bustype {
-	MP_BUS_ISA =3D 1,
-	MP_BUS_EISA,
-	MP_BUS_PCI,
-	MP_BUS_MCA,
-	MP_BUS_NEC98
-};
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_node [MAX_MP_BUSSES];
 extern int mp_bus_id_to_local [MAX_MP_BUSSES];
diff -Naur linux-2.5.70/include/asm-i386/mpspec_def.h =
linux70-nbp/include/asm-i386/mpspec_def.h
--- linux-2.5.70/include/asm-i386/mpspec_def.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mpspec_def.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,187 @@
+#ifndef __ASM_MPSPEC_DEF_H
+#define __ASM_MPSPEC_DEF_H
+
+/*
+ * Structure definitions for SMP machines following the
+ * Intel Multiprocessing Specification 1.1 and 1.4.
+ */
+
+/*
+ * This tag identifies where the SMP configuration
+ * information is.=20
+ */
+=20
+#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
+
+#define MAX_MPC_ENTRY 1024
+
+struct intel_mp_floating
+{
+	char mpf_signature[4];		/* "_MP_" 			*/
+	unsigned long mpf_physptr;	/* Configuration table address	*/
+	unsigned char mpf_length;	/* Our length (paragraphs)	*/
+	unsigned char mpf_specification;/* Specification version	*/
+	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/
+	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/
+	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/
+	unsigned char mpf_feature3;	/* Unused (0)			*/
+	unsigned char mpf_feature4;	/* Unused (0)			*/
+	unsigned char mpf_feature5;	/* Unused (0)			*/
+};
+
+struct mp_config_table
+{
+	char mpc_signature[4];
+#define MPC_SIGNATURE "PCMP"
+	unsigned short mpc_length;	/* Size of table */
+	char  mpc_spec;			/* 0x01 */
+	char  mpc_checksum;
+	char  mpc_oem[8];
+	char  mpc_productid[12];
+	unsigned long mpc_oemptr;	/* 0 if not present */
+	unsigned short mpc_oemsize;	/* 0 if not present */
+	unsigned short mpc_oemcount;
+	unsigned long mpc_lapic;	/* APIC address */
+	unsigned long reserved;
+};
+
+/* Followed by entries */
+
+#define	MP_PROCESSOR	0
+#define	MP_BUS		1
+#define	MP_IOAPIC	2
+#define	MP_INTSRC	3
+#define	MP_LINTSRC	4
+#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node =
locality */
+
+struct mpc_config_processor
+{
+	unsigned char mpc_type;
+	unsigned char mpc_apicid;	/* Local APIC number */
+	unsigned char mpc_apicver;	/* Its versions */
+	unsigned char mpc_cpuflag;
+#define CPU_ENABLED		1	/* Processor is available */
+#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */
+	unsigned long mpc_cpufeature;	=09
+#define CPU_STEPPING_MASK 0x0F
+#define CPU_MODEL_MASK	0xF0
+#define CPU_FAMILY_MASK	0xF00
+	unsigned long mpc_featureflag;	/* CPUID feature value */
+	unsigned long mpc_reserved[2];
+};
+
+struct mpc_config_bus
+{
+	unsigned char mpc_type;
+	unsigned char mpc_busid;
+	unsigned char mpc_bustype[6] __attribute((packed));
+};
+
+/* List of Bus Type string values, Intel MP Spec. */
+#define BUSTYPE_EISA	"EISA"
+#define BUSTYPE_ISA	"ISA"
+#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
+#define BUSTYPE_MCA	"MCA"
+#define BUSTYPE_VL	"VL"		/* Local bus */
+#define BUSTYPE_PCI	"PCI"
+#define BUSTYPE_PCMCIA	"PCMCIA"
+#define BUSTYPE_CBUS	"CBUS"
+#define BUSTYPE_CBUSII	"CBUSII"
+#define BUSTYPE_FUTURE	"FUTURE"
+#define BUSTYPE_MBI	"MBI"
+#define BUSTYPE_MBII	"MBII"
+#define BUSTYPE_MPI	"MPI"
+#define BUSTYPE_MPSA	"MPSA"
+#define BUSTYPE_NUBUS	"NUBUS"
+#define BUSTYPE_TC	"TC"
+#define BUSTYPE_VME	"VME"
+#define BUSTYPE_XPRESS	"XPRESS"
+#define BUSTYPE_NEC98	"NEC98"
+
+struct mpc_config_ioapic
+{
+	unsigned char mpc_type;
+	unsigned char mpc_apicid;
+	unsigned char mpc_apicver;
+	unsigned char mpc_flags;
+#define MPC_APIC_USABLE		0x01
+	unsigned long mpc_apicaddr;
+};
+
+struct mpc_config_intsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbus;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_dstapic;
+	unsigned char mpc_dstirq;
+};
+
+enum mp_irq_source_types {
+	mp_INT =3D 0,
+	mp_NMI =3D 1,
+	mp_SMI =3D 2,
+	mp_ExtINT =3D 3
+};
+
+#define MP_IRQDIR_DEFAULT	0
+#define MP_IRQDIR_HIGH		1
+#define MP_IRQDIR_LOW		3
+
+
+struct mpc_config_lintsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbusid;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_destapic;=09
+#define MP_APIC_ALL	0xFF
+	unsigned char mpc_destapiclint;
+};
+
+struct mp_config_oemtable
+{
+	char oem_signature[4];
+#define MPC_OEM_SIGNATURE "_OEM"
+	unsigned short oem_length;	/* Size of table */
+	char  oem_rev;			/* 0x01 */
+	char  oem_checksum;
+	char  mpc_oem[8];
+};
+
+struct mpc_config_translation
+{
+        unsigned char mpc_type;
+        unsigned char trans_len;
+        unsigned char trans_type;
+        unsigned char trans_quad;
+        unsigned char trans_global;
+        unsigned char trans_local;
+        unsigned short trans_reserved;
+};
+
+/*
+ *	Default configurations
+ *
+ *	1	2 CPU ISA 82489DX
+ *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining
+ *	3	2 CPU EISA 82489DX
+ *	4	2 CPU MCA 82489DX
+ *	5	2 CPU ISA+PCI
+ *	6	2 CPU EISA+PCI
+ *	7	2 CPU MCA+PCI
+ */
+
+enum mp_bustype {
+	MP_BUS_ISA =3D 1,
+	MP_BUS_EISA,
+	MP_BUS_PCI,
+	MP_BUS_MCA,
+	MP_BUS_NEC98
+};
+#endif
+
------_=_NextPart_000_01C3301F.3578C032--
