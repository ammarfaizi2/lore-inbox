Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFKNnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFKNnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:43:09 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:31727 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id S261180AbTFKNm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:42:27 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BDA73@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
To: torvalds@transmeta.com
Cc: "'akpm@digeo.com'" <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 0/2][2.5]Unisys ES7000 platform subarch
Date: Wed, 11 Jun 2003 08:41:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3301F.2300E90C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3301F.2300E90C
Content-Type: text/plain;
	charset="iso-8859-1"

The patch set adds support for the Unisys ES7000 series architecture. 
It covers different ES7000 platform variations with their corresponding APIC
architectures, such as Fosters-Gallatins based (XAPIC) ES7000s as well as
older Cascades based (logical cluster) ES7000 machines.
The patch was discussed among platform developers on LK and later resided in
the Alan's tree for 4-5 weeks for testing. Alan indicated that there are
"Zero complaints of any kind, zero problems from the changed code". He
recommended submit the patch. The code was tested by IBM as well as others
and did not have any impact on existing subarchs and on standard systems.

The patch is divided into two parts: first covers generic changes to the
main source; and the second one is only for ES7000 specific code. 
Please include these changes into your source tree at your earliest
convenience.


Thanks,

--Natalie Protasevich

(I am attaching the entire patch in case if I messed up while surgically
separating the two parts, or if someone would like to see the whole piece.)

 <<all-e7k-2.5.70.txt>> 

------_=_NextPart_000_01C3301F.2300E90C
Content-Type: text/plain;
	name="all-e7k-2.5.70.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="all-e7k-2.5.70.txt"

diff -Naur linux-2.5.70/arch/i386/Kconfig =
linux70-nbp/arch/i386/Kconfig=0A=
--- linux-2.5.70/arch/i386/Kconfig	2003-05-26 19:00:24.000000000 =
-0600=0A=
+++ linux70-nbp/arch/i386/Kconfig	2003-06-09 10:11:25.000000000 =
-0600=0A=
@@ -99,6 +99,15 @@=0A=
           This option compiles in the Summit, bigsmp, default =
subarchitectures.=0A=
 	  It is intended for a generic binary kernel.=0A=
 =0A=
+config X86_ES7000=0A=
+	bool "Support for Unisys ES7000 IA32 series"=0A=
+	depends on SMP=0A=
+	help=0A=
+	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel =
is=0A=
+	  supposed to run on an IA32-based Unisys ES7000 system. =0A=
+	  Only choose this option if you have such a system, otherwise you =
=0A=
+	  should say N here.=0A=
+=0A=
 endchoice=0A=
 =0A=
 config ACPI_SRAT=0A=
@@ -111,6 +120,11 @@=0A=
        default y=0A=
        depends on X86_SUMMIT || X86_GENERICARCH=0A=
 =0A=
+config ES7000_CLUSTERED_APIC=0A=
+	bool=0A=
+	default y=0A=
+	depends on SMP && X86_ES7000 && MPENTIUMIII=0A=
+=0A=
 choice=0A=
 	prompt "Processor family"=0A=
 	default M686=0A=
diff -Naur linux-2.5.70/arch/i386/Makefile =
linux70-nbp/arch/i386/Makefile=0A=
--- linux-2.5.70/arch/i386/Makefile	2003-05-26 19:00:37.000000000 =
-0600=0A=
+++ linux70-nbp/arch/i386/Makefile	2003-06-09 10:11:25.000000000 =
-0600=0A=
@@ -78,6 +78,10 @@=0A=
 mcore-$(CONFIG_X86_GENERICARCH) :=3D mach-default=0A=
 core-$(CONFIG_X86_GENERICARCH) +=3D arch/i386/mach-generic/=0A=
 =0A=
+# ES7000 subarch support=0A=
+mflags-$(CONFIG_X86_ES7000)	:=3D -Iinclude/asm-i386/mach-es7000=0A=
+mcore-$(CONFIG_X86_ES7000)	:=3D mach-es7000=0A=
+=0A=
 # default subarch .h files=0A=
 mflags-y +=3D -Iinclude/asm-i386/mach-default=0A=
 =0A=
diff -Naur linux-2.5.70/arch/i386/kernel/apic.c =
linux70-nbp/arch/i386/kernel/apic.c=0A=
--- linux-2.5.70/arch/i386/kernel/apic.c	2003-05-26 19:01:02.000000000 =
-0600=0A=
+++ linux70-nbp/arch/i386/kernel/apic.c	2003-06-09 10:11:25.000000000 =
-0600=0A=
@@ -158,6 +158,7 @@=0A=
 		outb(0x70, 0x22);=0A=
 		outb(0x01, 0x23);=0A=
 	}=0A=
+	enable_apic_mode();=0A=
 }=0A=
 =0A=
 void disconnect_bsp_APIC(void)=0A=
diff -Naur linux-2.5.70/arch/i386/kernel/io_apic.c =
linux70-nbp/arch/i386/kernel/io_apic.c=0A=
--- linux-2.5.70/arch/i386/kernel/io_apic.c	2003-05-26 =
19:00:28.000000000 -0600=0A=
+++ linux70-nbp/arch/i386/kernel/io_apic.c	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -1072,6 +1072,8 @@=0A=
 			while (i < apic)=0A=
 				irq +=3D nr_ioapic_registers[i++];=0A=
 			irq +=3D pin;=0A=
+			if ((!apic) && (irq < 16)) =0A=
+				irq +=3D 16;=0A=
 			break;=0A=
 		}=0A=
 		default:=0A=
@@ -1299,7 +1301,9 @@=0A=
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", =
reg_00.ID);=0A=
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", =
reg_00.delivery_type);=0A=
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);=0A=
-	if (reg_00.__reserved_0 || reg_00.__reserved_1 || =
reg_00.__reserved_2)=0A=
+	if (reg_00.ID >=3D APIC_BROADCAST_ID)=0A=
+		UNEXPECTED_IO_APIC();=0A=
+	if (reg_00.__reserved_1 || reg_00.__reserved_2)=0A=
 		UNEXPECTED_IO_APIC();=0A=
 =0A=
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);=0A=
@@ -1623,7 +1627,7 @@=0A=
 			mp_ioapics[apic].mpc_apicid =3D i;=0A=
 		} else {=0A=
 			printk("Setting %d in the phys_id_present_map\n", =
mp_ioapics[apic].mpc_apicid);=0A=
-			phys_id_present_map |=3D 1 << mp_ioapics[apic].mpc_apicid;=0A=
+			phys_id_present_map |=3D =
apicid_to_cpu_present(mp_ioapics[apic].mpc_apicid);=0A=
 		}=0A=
 =0A=
 =0A=
@@ -2224,10 +2228,10 @@=0A=
 	 * Every APIC in a system must have a unique ID or we get lots of =
nice =0A=
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.=0A=
 	 */=0A=
-	if (apic_id_map & (1 << apic_id)) {=0A=
+	if (check_apicid_used(apic_id_map, apic_id)) {=0A=
 =0A=
 		for (i =3D 0; i < IO_APIC_MAX_ID; i++) {=0A=
-			if (!(apic_id_map & (1 << i)))=0A=
+			if (!check_apicid_used(apic_id_map, i))=0A=
 				break;=0A=
 		}=0A=
 =0A=
@@ -2240,7 +2244,7 @@=0A=
 		apic_id =3D i;=0A=
 	} =0A=
 =0A=
-	apic_id_map |=3D (1 << apic_id);=0A=
+	apic_id_map |=3D apicid_to_cpu_present(apic_id);=0A=
 =0A=
 	if (reg_00.ID !=3D apic_id) {=0A=
 		reg_00.ID =3D apic_id;=0A=
diff -Naur linux-2.5.70/arch/i386/kernel/mpparse.c =
linux70-nbp/arch/i386/kernel/mpparse.c=0A=
--- linux-2.5.70/arch/i386/kernel/mpparse.c	2003-05-26 =
19:00:27.000000000 -0600=0A=
+++ linux70-nbp/arch/i386/kernel/mpparse.c	2003-06-10 =
04:13:34.000000000 -0600=0A=
@@ -814,7 +814,7 @@=0A=
 =0A=
 	processor.mpc_type =3D MP_PROCESSOR;=0A=
 	processor.mpc_apicid =3D id;=0A=
-	processor.mpc_apicver =3D 0x10; /* TBD: lapic version */=0A=
+	processor.mpc_apicver =3D GET_APIC_VERSION(apic_read(APIC_LVR));=0A=
 	processor.mpc_cpuflag =3D (enabled ? CPU_ENABLED : 0);=0A=
 	processor.mpc_cpuflag |=3D (boot_cpu ? CPU_BOOTPROCESSOR : 0);=0A=
 	processor.mpc_cpufeature =3D (boot_cpu_data.x86 << 8) | =0A=
@@ -951,7 +951,7 @@=0A=
 	 */=0A=
 	for (i =3D 0; i < mp_irq_entries; i++) {=0A=
 		if ((mp_irqs[i].mpc_dstapic =3D=3D intsrc.mpc_dstapic) =0A=
-			&& (mp_irqs[i].mpc_dstirq =3D=3D intsrc.mpc_dstirq)) {=0A=
+			&& (mp_irqs[i].mpc_srcbusirq =3D=3D intsrc.mpc_srcbusirq)) {=0A=
 			mp_irqs[i] =3D intsrc;=0A=
 			found =3D 1;=0A=
 			break;=0A=
@@ -1109,6 +1109,8 @@=0A=
 			continue;=0A=
 		ioapic_pin =3D irq - mp_ioapic_routing[ioapic].irq_start;=0A=
 =0A=
+		if (!ioapic && (irq < 16))=0A=
+			irq +=3D 16;=0A=
 		/* =0A=
 		 * Avoid pin reprogramming.  PRTs typically include entries  =0A=
 		 * with redundant pin->irq mappings (but unique PCI devices);=0A=
diff -Naur linux-2.5.70/arch/i386/mach-es7000/Makefile =
linux70-nbp/arch/i386/mach-es7000/Makefile=0A=
--- linux-2.5.70/arch/i386/mach-es7000/Makefile	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/arch/i386/mach-es7000/Makefile	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,7 @@=0A=
+#=0A=
+# Makefile for the linux kernel.=0A=
+#=0A=
+=0A=
+EXTRA_CFLAGS	+=3D -I../kernel=0A=
+=0A=
+obj-y		:=3D setup.o topology.o es7000.o=0A=
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.c =
linux70-nbp/arch/i386/mach-es7000/es7000.c=0A=
--- linux-2.5.70/arch/i386/mach-es7000/es7000.c	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/arch/i386/mach-es7000/es7000.c	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,281 @@=0A=
+/*=0A=
+ * Written by: Garry Forsgren, Unisys Corporation=0A=
+ *             Natalie Protasevich, Unisys Corporation=0A=
+ * This file contains the code to configure and interface =0A=
+ * with Unisys ES7000 series hardware system manager.=0A=
+ *=0A=
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or =
modify it=0A=
+ * under the terms of version 2 of the GNU General Public License =
as=0A=
+ * published by the Free Software Foundation.=0A=
+ *=0A=
+ * This program is distributed in the hope that it would be useful, =
but=0A=
+ * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License =
along=0A=
+ * with this program; if not, write the Free Software Foundation, =
Inc., 59=0A=
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.=0A=
+ *=0A=
+ * Contact information: Unisys Corporation, Township Line & Union =
Meeting =0A=
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:=0A=
+ *=0A=
+ * http://www.unisys.com=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/smp.h>=0A=
+#include <linux/string.h>=0A=
+#include <linux/spinlock.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/notifier.h>=0A=
+#include <linux/reboot.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/acpi.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/nmi.h>=0A=
+#include <asm/smp.h>=0A=
+#include <asm/apicdef.h>=0A=
+#include "es7000.h"=0A=
+=0A=
+/*=0A=
+ * ES7000 Globals=0A=
+ */=0A=
+=0A=
+volatile unsigned long	*psai =3D NULL;=0A=
+struct mip_reg		*mip_reg;  =0A=
+struct mip_reg		*host_reg;=0A=
+int 			mip_port;=0A=
+unsigned long		mip_addr, host_addr;=0A=
+=0A=
+static int		es7000_plat;=0A=
+=0A=
+/*=0A=
+ * Parse the OEM Table=0A=
+ */=0A=
+=0A=
+void __init=0A=
+parse_unisys_oem (char *oemptr, int oem_entries)=0A=
+{=0A=
+	int                     i;=0A=
+	int 			success =3D 0;=0A=
+	unsigned char           type, size;=0A=
+	unsigned long           val;=0A=
+	char                    *tp =3D NULL;  =0A=
+	struct psai             *psaip =3D NULL;=0A=
+	struct mip_reg_info 	*mi;=0A=
+	struct mip_reg		*host, *mip;=0A=
+=0A=
+	tp =3D oemptr;=0A=
+=0A=
+	tp +=3D 8;=0A=
+=0A=
+	for (i=3D0; i <=3D oem_entries; i++) {=0A=
+		type =3D *tp++;=0A=
+		size =3D *tp++;=0A=
+		tp -=3D 2;=0A=
+		switch (type) {=0A=
+		case MIP_REG:=0A=
+			mi =3D (struct mip_reg_info *)tp;=0A=
+			val =3D MIP_RD_LO(mi->host_reg);=0A=
+			host_addr =3D val;=0A=
+			host =3D (struct mip_reg *)val;=0A=
+			host_reg =3D __va(host);=0A=
+			val =3D MIP_RD_LO(mi->mip_reg);=0A=
+			mip_addr =3D val;=0A=
+			mip =3D (struct mip_reg *)val;=0A=
+			mip_reg =3D __va(mip);=0A=
+			Dprintk("es7000_mipcfg: host_reg =3D 0x%lx \n", =0A=
+				(unsigned long)host_reg);=0A=
+			Dprintk("es7000_mipcfg: mip_reg =3D 0x%lx \n", =0A=
+				(unsigned long)mip_reg);=0A=
+			success++;=0A=
+			break;=0A=
+		case MIP_PSAI_REG:=0A=
+			psaip =3D (struct psai *)tp;=0A=
+			if (tp !=3D NULL) {=0A=
+				if (psaip->addr)=0A=
+					psai =3D __va(psaip->addr);=0A=
+				else=0A=
+					psai =3D NULL;=0A=
+				success++;=0A=
+			}=0A=
+			break;=0A=
+		default:=0A=
+			break;=0A=
+		}=0A=
+		if (i =3D=3D 6) break;=0A=
+		tp +=3D size;=0A=
+	}=0A=
+=0A=
+	if (success < 2) {=0A=
+		printk("\nNo ES7000 found.\n");=0A=
+		es7000_plat =3D 0;=0A=
+	} else {=0A=
+		printk("\nEnabling ES7000 specific features...\n");=0A=
+		es7000_plat =3D 1;=0A=
+	}=0A=
+	return;=0A=
+}=0A=
+=0A=
+int __init =0A=
+find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length) =0A=
+{=0A=
+	struct acpi_table_rsdp		*rsdp =3D NULL;=0A=
+	unsigned long			rsdp_phys =3D 0;=0A=
+	struct acpi_table_header 	*header =3D NULL;=0A=
+	int				i;=0A=
+	struct acpi_table_sdt		sdt;=0A=
+=0A=
+	rsdp_phys =3D acpi_find_rsdp();=0A=
+	rsdp =3D __va(rsdp_phys);=0A=
+	if (rsdp->rsdt_address) {=0A=
+		struct acpi_table_rsdt	*mapped_rsdt =3D NULL;=0A=
+		sdt.pa =3D rsdp->rsdt_address;=0A=
+=0A=
+		header =3D (struct acpi_table_header *)=0A=
+			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));=0A=
+		if (!header)=0A=
+			return -ENODEV;=0A=
+=0A=
+		sdt.count =3D (header->length - sizeof(struct acpi_table_header)) >> =
3;=0A=
+		mapped_rsdt =3D (struct acpi_table_rsdt *)=0A=
+			__acpi_map_table(sdt.pa, header->length);=0A=
+		if (!mapped_rsdt)=0A=
+			return -ENODEV;=0A=
+=0A=
+		header =3D &mapped_rsdt->header;=0A=
+=0A=
+		for (i =3D 0; i < sdt.count; i++)=0A=
+			sdt.entry[i].pa =3D (unsigned long) mapped_rsdt->entry[i];=0A=
+	};=0A=
+	for (i =3D 0; i < sdt.count; i++) {=0A=
+=0A=
+		header =3D (struct acpi_table_header *)=0A=
+			__acpi_map_table(sdt.entry[i].pa,=0A=
+				sizeof(struct acpi_table_header));=0A=
+		if (!header)=0A=
+			continue;=0A=
+		if (!strncmp((char *) &header->signature, "OEM1", 4)) {=0A=
+			if (!strncmp((char *) &header->oem_id, "UNISYS", 6)) {=0A=
+				void *addr;=0A=
+				struct oem_table *t;=0A=
+				acpi_table_print(header, sdt.entry[i].pa);=0A=
+				t =3D (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, =
header->length);=0A=
+				addr =3D (void *) __acpi_map_table(t->OEMTableAddr, =
t->OEMTableSize);=0A=
+				*length =3D header->length;=0A=
+				*oem_addr =3D (unsigned long) addr;=0A=
+				return 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	printk("ES7000: did not find Unisys ACPI OEM table!\n");=0A=
+	return -1;=0A=
+}=0A=
+=0A=
+static void=0A=
+es7000_spin(int n)=0A=
+{=0A=
+	int i =3D 0;=0A=
+=0A=
+	while (i++ < n) =0A=
+		rep_nop();=0A=
+}=0A=
+=0A=
+static int __init=0A=
+es7000_mip_write(struct mip_reg *mip_reg)=0A=
+{=0A=
+	int			status =3D 0;=0A=
+	int			spin;=0A=
+=0A=
+	spin =3D MIP_SPIN;=0A=
+	while (((unsigned long long)host_reg->off_38 &=0A=
+		(unsigned long long)MIP_VALID) !=3D 0) {=0A=
+			if (--spin <=3D 0) {=0A=
+				printk("es7000_mip_write: Timeout waiting for Host Valid =
Flag");=0A=
+				return -1;=0A=
+			}=0A=
+		es7000_spin(MIP_SPIN);=0A=
+	}=0A=
+=0A=
+	memcpy(host_reg, mip_reg, sizeof(struct mip_reg));=0A=
+	outb(1, mip_port);=0A=
+=0A=
+	spin =3D MIP_SPIN;=0A=
+=0A=
+	while (((unsigned long long)mip_reg->off_38 &=0A=
+		(unsigned long long)MIP_VALID) =3D=3D 0) {=0A=
+		if (--spin <=3D 0) {=0A=
+			printk("es7000_mip_write: Timeout waiting for MIP Valid Flag");=0A=
+			return -1;=0A=
+		}=0A=
+		es7000_spin(MIP_SPIN);=0A=
+	}=0A=
+=0A=
+	status =3D ((unsigned long long)mip_reg->off_0 &=0A=
+		(unsigned long long)0xffff0000000000) >> 48;=0A=
+	mip_reg->off_38 =3D ((unsigned long long)mip_reg->off_38 &=0A=
+		(unsigned long long)~MIP_VALID);=0A=
+	return status;=0A=
+}=0A=
+=0A=
+int =0A=
+es7000_start_cpu(int cpu, unsigned long eip)=0A=
+{=0A=
+	unsigned long vect =3D 0, psaival =3D 0;=0A=
+=0A=
+	if (psai =3D=3D NULL)=0A=
+		return -1;=0A=
+=0A=
+	vect =3D ((unsigned long)__pa(eip)/0x1000) << 16;=0A=
+	psaival =3D (0x1000000 | vect | cpu);=0A=
+=0A=
+	while (*psai & 0x1000000)=0A=
+                ;=0A=
+=0A=
+	*psai =3D psaival;=0A=
+=0A=
+	return 0;=0A=
+=0A=
+}=0A=
+=0A=
+int =0A=
+es7000_stop_cpu(int cpu)=0A=
+{=0A=
+	int startup;=0A=
+=0A=
+	if (psai =3D=3D NULL)=0A=
+		return -1;=0A=
+=0A=
+	startup=3D (0x1000000 | cpu);=0A=
+=0A=
+	while ((*psai & 0xff00ffff) !=3D startup)=0A=
+		;=0A=
+=0A=
+	startup =3D (*psai & 0xff0000) >> 16;=0A=
+	*psai &=3D 0xffffff;=0A=
+=0A=
+	return 0;=0A=
+=0A=
+}=0A=
+=0A=
+void __init=0A=
+es7000_sw_apic()=0A=
+{=0A=
+	if (es7000_plat) {=0A=
+		int mip_status;=0A=
+		struct mip_reg es7000_mip_reg;=0A=
+=0A=
+		printk("ES7000: Enabling APIC mode.\n");=0A=
+        	memset(&es7000_mip_reg, 0, sizeof(struct mip_reg));=0A=
+        	es7000_mip_reg.off_0 =3D MIP_SW_APIC;=0A=
+        	es7000_mip_reg.off_38 =3D (MIP_VALID);=0A=
+        	while ((mip_status =3D es7000_mip_write(&es7000_mip_reg)) =
!=3D 0)=0A=
+              		printk("es7000_sw_apic: command failed, status =3D =
%x\n", =0A=
+				mip_status);=0A=
+		return;=0A=
+	}=0A=
+}=0A=
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.h =
linux70-nbp/arch/i386/mach-es7000/es7000.h=0A=
--- linux-2.5.70/arch/i386/mach-es7000/es7000.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/arch/i386/mach-es7000/es7000.h	2003-06-10 =
04:43:09.000000000 -0600=0A=
@@ -0,0 +1,109 @@=0A=
+/*=0A=
+ * Written by: Garry Forsgren, Unisys Corporation=0A=
+ *             Natalie Protasevich, Unisys Corporation=0A=
+ * This file contains the code to configure and interface =0A=
+ * with Unisys ES7000 series hardware system manager.=0A=
+ *=0A=
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or =
modify it=0A=
+ * under the terms of version 2 of the GNU General Public License =
as=0A=
+ * published by the Free Software Foundation.=0A=
+ *=0A=
+ * This program is distributed in the hope that it would be useful, =
but=0A=
+ * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License =
along=0A=
+ * with this program; if not, write the Free Software Foundation, =
Inc., 59=0A=
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.=0A=
+ *=0A=
+ * Contact information: Unisys Corporation, Township Line & Union =
Meeting =0A=
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:=0A=
+ *=0A=
+ * http://www.unisys.com=0A=
+ */=0A=
+=0A=
+#define	MIP_REG			1=0A=
+#define	MIP_PSAI_REG		4=0A=
+=0A=
+#define	MIP_BUSY		1=0A=
+#define	MIP_SPIN		0xf0000=0A=
+#define	MIP_VALID		0x0100000000000000=0A=
+=0A=
+#define	MIP_RD_LO(VALUE)	(VALUE & 0xffffffff)   =0A=
+=0A=
+struct mip_reg_info {=0A=
+	unsigned long long mip_info;=0A=
+	unsigned long long delivery_info;=0A=
+	unsigned long long host_reg;=0A=
+	unsigned long long mip_reg;=0A=
+};=0A=
+=0A=
+struct part_info {=0A=
+	unsigned char type;   =0A=
+	unsigned char length;=0A=
+	unsigned char part_id;=0A=
+	unsigned char apic_mode;=0A=
+	unsigned long snum;    =0A=
+	char ptype[16];=0A=
+	char sname[64];=0A=
+	char pname[64];=0A=
+};=0A=
+=0A=
+struct psai {=0A=
+	unsigned long long entry_type;=0A=
+	unsigned long long addr;=0A=
+	unsigned long long bep_addr;=0A=
+};=0A=
+=0A=
+struct es7000_mem_info {=0A=
+	unsigned char type;   =0A=
+	unsigned char length;=0A=
+	unsigned char resv[6];=0A=
+	unsigned long long  start; =0A=
+	unsigned long long  size; =0A=
+};=0A=
+=0A=
+struct es7000_oem_table {=0A=
+	unsigned long long hdr;=0A=
+	struct mip_reg_info mip;=0A=
+	struct part_info pif;=0A=
+	struct es7000_mem_info shm;=0A=
+	struct psai psai;=0A=
+};=0A=
+=0A=
+struct acpi_table_sdt {=0A=
+	unsigned long pa;=0A=
+	unsigned long count;=0A=
+	struct {=0A=
+		unsigned long pa;=0A=
+		enum acpi_table_id id;=0A=
+		unsigned long size;=0A=
+	}	entry[50];=0A=
+};=0A=
+=0A=
+struct oem_table {=0A=
+	struct acpi_table_header Header;=0A=
+	u32 OEMTableAddr;=0A=
+	u32 OEMTableSize;=0A=
+};=0A=
+=0A=
+struct mip_reg {=0A=
+	unsigned long long off_0;=0A=
+	unsigned long long off_8;=0A=
+	unsigned long long off_10;=0A=
+	unsigned long long off_18;=0A=
+	unsigned long long off_20;=0A=
+	unsigned long long off_28;=0A=
+	unsigned long long off_30;=0A=
+	unsigned long long off_38;=0A=
+};=0A=
+=0A=
+#define	MIP_SW_APIC		0x1020b=0A=
+#define	MIP_FUNC(VALUE) 	(VALUE & 0xff)=0A=
+=0A=
+extern void parse_unisys_oem (char *oemptr, int oem_entries);=0A=
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);=0A=
+extern int es7000_start_cpu(int cpu, unsigned long eip);=0A=
+extern void es7000_sw_apic(void);=0A=
diff -Naur linux-2.5.70/arch/i386/mach-es7000/setup.c =
linux70-nbp/arch/i386/mach-es7000/setup.c=0A=
--- linux-2.5.70/arch/i386/mach-es7000/setup.c	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/arch/i386/mach-es7000/setup.c	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,105 @@=0A=
+/*=0A=
+ *	Machine specific setup for generic=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/smp.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/irq.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <asm/arch_hooks.h>=0A=
+=0A=
+/**=0A=
+ * pre_intr_init_hook - initialisation prior to setting up interrupt =
vectors=0A=
+ *=0A=
+ * Description:=0A=
+ *	Perform any necessary interrupt initialisation prior to setting =
up=0A=
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the =
ISA=0A=
+ *	interrupts should be initialised here if the machine emulates a =
PC=0A=
+ *	in any way.=0A=
+ **/=0A=
+void __init pre_intr_init_hook(void)=0A=
+{=0A=
+	init_ISA_irqs();=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IRQ2 is cascade interrupt to second interrupt controller=0A=
+ */=0A=
+static struct irqaction irq2 =3D { no_action, 0, 0, "cascade", NULL, =
NULL};=0A=
+=0A=
+/**=0A=
+ * intr_init_hook - post gate setup interrupt initialisation=0A=
+ *=0A=
+ * Description:=0A=
+ *	Fill in any interrupts that may have been left out by the =
general=0A=
+ *	init_IRQ() routine.  interrupts having to do with the machine =
rather=0A=
+ *	than the devices on the I/O bus (like APIC interrupts in intel =
MP=0A=
+ *	systems) are started here.=0A=
+ **/=0A=
+void __init intr_init_hook(void)=0A=
+{=0A=
+#ifdef CONFIG_X86_LOCAL_APIC=0A=
+	apic_intr_init();=0A=
+#endif=0A=
+=0A=
+	setup_irq(2, &irq2);=0A=
+}=0A=
+=0A=
+/**=0A=
+ * pre_setup_arch_hook - hook called prior to any setup_arch() =
execution=0A=
+ *=0A=
+ * Description:=0A=
+ *	generally used to activate any machine specific identification=0A=
+ *	routines that may be needed before setup_arch() runs.  On VISWS=0A=
+ *	this is used to get the board revision and type.=0A=
+ **/=0A=
+void __init pre_setup_arch_hook(void)=0A=
+{=0A=
+}=0A=
+=0A=
+/**=0A=
+ * trap_init_hook - initialise system specific traps=0A=
+ *=0A=
+ * Description:=0A=
+ *	Called as the final act of trap_init().  Used in VISWS to =
initialise=0A=
+ *	the various board specific APIC traps.=0A=
+ **/=0A=
+void __init trap_init_hook(void)=0A=
+{=0A=
+}=0A=
+=0A=
+static struct irqaction irq0  =3D { timer_interrupt, SA_INTERRUPT, 0, =
"timer", NULL, NULL};=0A=
+=0A=
+/**=0A=
+ * time_init_hook - do any specific initialisations for the system =
timer.=0A=
+ *=0A=
+ * Description:=0A=
+ *	Must plug the system timer interrupt source at HZ into the IRQ =
listed=0A=
+ *	in irq_vectors.h:TIMER_IRQ=0A=
+ **/=0A=
+void __init time_init_hook(void)=0A=
+{=0A=
+	setup_irq(0, &irq0);=0A=
+}=0A=
+=0A=
+#ifdef CONFIG_MCA=0A=
+/**=0A=
+ * mca_nmi_hook - hook into MCA specific NMI chain=0A=
+ *=0A=
+ * Description:=0A=
+ *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI =
sources=0A=
+ *	along the MCA bus.  Use this to hook into that chain if you will =
need=0A=
+ *	it.=0A=
+ **/=0A=
+void __init mca_nmi_hook(void)=0A=
+{=0A=
+	/* If I recall correctly, there's a whole bunch of other things =
that=0A=
+	 * we can do to check for NMI problems, but that's all I know =
about=0A=
+	 * at the moment.=0A=
+	 */=0A=
+=0A=
+	printk("NMI generated from unknown source!\n");=0A=
+}=0A=
+=0A=
+#endif=0A=
diff -Naur linux-2.5.70/arch/i386/mach-es7000/topology.c =
linux70-nbp/arch/i386/mach-es7000/topology.c=0A=
--- linux-2.5.70/arch/i386/mach-es7000/topology.c	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/arch/i386/mach-es7000/topology.c	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,68 @@=0A=
+/*=0A=
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology =
information=0A=
+ *=0A=
+ * Written by: Matthew Dobson, IBM Corporation=0A=
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, =
OSDL=0A=
+ *=0A=
+ * Copyright (C) 2002, IBM Corp.=0A=
+ *=0A=
+ * All rights reserved.          =0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or =
modify=0A=
+ * it under the terms of the GNU General Public License as published =
by=0A=
+ * the Free Software Foundation; either version 2 of the License, =
or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful, =
but=0A=
+ * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE =
or=0A=
+ * NON INFRINGEMENT.  See the GNU General Public License for more=0A=
+ * details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public =
License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ * Send feedback to <colpatch@us.ibm.com>=0A=
+ */=0A=
+#include <linux/init.h>=0A=
+#include <linux/smp.h>=0A=
+#include <asm/cpu.h>=0A=
+=0A=
+struct i386_cpu cpu_devices[NR_CPUS];=0A=
+=0A=
+#ifdef CONFIG_NUMA=0A=
+#include <linux/mmzone.h>=0A=
+#include <asm/node.h>=0A=
+#include <asm/memblk.h>=0A=
+=0A=
+struct i386_node node_devices[MAX_NUMNODES];=0A=
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];=0A=
+=0A=
+static int __init topology_init(void)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < num_online_nodes(); i++)=0A=
+		arch_register_node(i);=0A=
+	for (i =3D 0; i < NR_CPUS; i++)=0A=
+		if (cpu_possible(i)) arch_register_cpu(i);=0A=
+	for (i =3D 0; i < num_online_memblks(); i++)=0A=
+		arch_register_memblk(i);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+#else /* !CONFIG_NUMA */=0A=
+=0A=
+static int __init topology_init(void)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < NR_CPUS; i++)=0A=
+		if (cpu_possible(i)) arch_register_cpu(i);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+#endif /* CONFIG_NUMA */=0A=
+=0A=
+subsys_initcall(topology_init);=0A=
diff -Naur linux-2.5.70/include/asm-i386/io_apic.h =
linux70-nbp/include/asm-i386/io_apic.h=0A=
--- linux-2.5.70/include/asm-i386/io_apic.h	2003-05-26 =
19:00:42.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/io_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -27,8 +27,7 @@=0A=
 		LTS		:  1,=0A=
 		delivery_type	:  1,=0A=
 		__reserved_1	:  8,=0A=
-		ID		:  4,=0A=
-		__reserved_0	:  4;=0A=
+		ID		:  8;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
 struct IO_APIC_reg_01 {=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h =
linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h	2003-05-26 =
19:00:58.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -123,6 +123,10 @@=0A=
 {=0A=
 }=0A=
 =0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+}=0A=
+=0A=
 static inline int check_phys_apicid_present(int =
boot_cpu_physical_apicid)=0A=
 {=0A=
 	return (1);=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 16 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 16=0A=
+=0A=
+#define MAX_IRQ_SOURCES 256=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_apic.h =
linux70-nbp/include/asm-i386/mach-default/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-default/mach_apic.h	2003-05-26 =
19:01:02.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mach-default/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -118,4 +118,8 @@=0A=
 	return cpumask;=0A=
 }=0A=
 =0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+}=0A=
+=0A=
 #endif /* __ASM_MACH_APIC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-default/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-default/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 16 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 16=0A=
+=0A=
+#define MAX_IRQ_SOURCES 256=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h	2003-06-09 =
10:12:33.000000000 -0600=0A=
@@ -0,0 +1,189 @@=0A=
+#ifndef __ASM_MACH_APIC_H=0A=
+#define __ASM_MACH_APIC_H=0A=
+=0A=
+extern u8 bios_cpu_apicid[];=0A=
+=0A=
+#define xapic_phys_to_log_apicid(cpu) (bios_cpu_apicid[cpu])=0A=
+#define esr_disable (1)=0A=
+=0A=
+static inline int apic_id_registered(void)=0A=
+{=0A=
+	        return (1);=0A=
+}=0A=
+=0A=
+static inline unsigned long target_cpus(void)=0A=
+{ =0A=
+#if defined CONFIG_ES7000_CLUSTERED_APIC=0A=
+	return (0xff);=0A=
+#else=0A=
+	return (bios_cpu_apicid[smp_processor_id()]);=0A=
+#endif=0A=
+}=0A=
+#define TARGET_CPUS	(target_cpus())=0A=
+=0A=
+#if defined CONFIG_ES7000_CLUSTERED_APIC=0A=
+#define APIC_DFR_VALUE		(APIC_DFR_CLUSTER)=0A=
+#define INT_DELIVERY_MODE	(dest_LowestPrio)=0A=
+#define INT_DEST_MODE		(1)    /* logical delivery broadcast to all =
procs */=0A=
+#define NO_BALANCE_IRQ 		(1)=0A=
+#undef  WAKE_SECONDARY_VIA_INIT=0A=
+#define WAKE_SECONDARY_VIA_MIP=0A=
+#else=0A=
+#define APIC_DFR_VALUE		(APIC_DFR_FLAT)=0A=
+#define INT_DELIVERY_MODE	(dest_Fixed)=0A=
+#define INT_DEST_MODE		(0)    /* phys delivery to target procs */=0A=
+#define NO_BALANCE_IRQ 		(0)=0A=
+#undef  APIC_DEST_LOGICAL=0A=
+#define APIC_DEST_LOGICAL	0x0=0A=
+#define WAKE_SECONDARY_VIA_INIT=0A=
+#endif=0A=
+=0A=
+#define APIC_BROADCAST_ID	(0xff)=0A=
+=0A=
+static inline unsigned long check_apicid_used(unsigned long bitmap, =
int apicid) =0A=
+{ =0A=
+	return 0;=0A=
+} =0A=
+static inline unsigned long check_apicid_present(int bit) =0A=
+{=0A=
+	return (phys_cpu_present_map & (1 << bit));=0A=
+}=0A=
+=0A=
+#define apicid_cluster(apicid) (apicid & 0xF0)=0A=
+=0A=
+static inline unsigned long calculate_ldr(int cpu)=0A=
+{=0A=
+	unsigned long id;=0A=
+	id =3D xapic_phys_to_log_apicid(cpu);=0A=
+	return (SET_APIC_LOGICAL_ID(id));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Set up the logical destination ID.=0A=
+ *=0A=
+ * Intel recommends to set DFR, LdR and TPR before enabling=0A=
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel=0A=
+ * document number 292116).  So here it goes...=0A=
+ */=0A=
+static inline void init_apic_ldr(void)=0A=
+{=0A=
+	unsigned long val;=0A=
+	int cpu =3D smp_processor_id();=0A=
+=0A=
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);=0A=
+	val =3D calculate_ldr(cpu);=0A=
+	apic_write_around(APIC_LDR, val);=0A=
+}=0A=
+=0A=
+extern void es7000_sw_apic(void);=0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+	es7000_sw_apic();=0A=
+	return;=0A=
+}=0A=
+=0A=
+extern int apic_version [MAX_APICS];=0A=
+static inline void clustered_apic_check(void)=0A=
+{=0A=
+	int apic =3D bios_cpu_apicid[smp_processor_id()];=0A=
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus =
%lx\n",=0A=
+		(apic_version[apic] =3D=3D 0x14) ? =0A=
+		"Physical Cluster" : "Logical Cluster", nr_ioapics, TARGET_CPUS);=0A=
+}=0A=
+=0A=
+static inline int multi_timer_check(int apic, int irq)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static inline int apicid_to_node(int logical_apicid)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+static inline int cpu_present_to_apicid(int mps_cpu)=0A=
+{=0A=
+	if (!mps_cpu)=0A=
+		return boot_cpu_physical_apicid;=0A=
+	else=0A=
+		return (int) bios_cpu_apicid[mps_cpu];=0A=
+}=0A=
+=0A=
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)=0A=
+{=0A=
+	static int cpu =3D 0;=0A=
+	return (1ul << cpu++);=0A=
+}=0A=
+=0A=
+extern volatile u8 cpu_2_logical_apicid[];=0A=
+/* Mapping from cpu number to logical apicid */=0A=
+static inline int cpu_to_logical_apicid(int cpu)=0A=
+{=0A=
+       return (int)cpu_2_logical_apicid[cpu];=0A=
+}=0A=
+=0A=
+static inline int mpc_apic_id(struct mpc_config_processor *m, int =
quad)=0A=
+{=0A=
+	printk("Processor #%d %ld:%ld APIC version %d\n",=0A=
+	        m->mpc_apicid,=0A=
+	        (m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,=0A=
+	        (m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,=0A=
+	        m->mpc_apicver);=0A=
+	return (m->mpc_apicid);=0A=
+}=0A=
+=0A=
+static inline ulong ioapic_phys_id_map(ulong phys_map)=0A=
+{=0A=
+	/* For clustered we don't have a good way to do this yet - hack */=0A=
+	return (0xff);=0A=
+}=0A=
+=0A=
+=0A=
+static inline void setup_portio_remap(void)=0A=
+{=0A=
+}=0A=
+=0A=
+extern unsigned int boot_cpu_physical_apicid;=0A=
+static inline int check_phys_apicid_present(int =
cpu_physical_apicid)=0A=
+{=0A=
+	boot_cpu_physical_apicid =3D GET_APIC_ID(apic_read(APIC_ID));=0A=
+	return (1);=0A=
+}=0A=
+=0A=
+static inline unsigned int cpu_mask_to_apicid (unsigned long =
cpumask)=0A=
+{=0A=
+	int num_bits_set;=0A=
+	int cpus_found =3D 0;=0A=
+	int cpu;=0A=
+	int apicid;	=0A=
+=0A=
+	if (cpumask =3D=3D TARGET_CPUS)=0A=
+		return cpumask;=0A=
+	num_bits_set =3D hweight32(cpumask); =0A=
+	/* Return id to all */=0A=
+	if (num_bits_set =3D=3D 32)=0A=
+		return TARGET_CPUS;=0A=
+	/* =0A=
+	 * The cpus in the mask must all be on the apic cluster.  If are not =
=0A=
+	 * on the same apicid cluster return default value of TARGET_CPUS. =
=0A=
+	 */=0A=
+	cpu =3D ffs(cpumask)-1;=0A=
+	apicid =3D cpu_to_logical_apicid(cpu);=0A=
+	while (cpus_found < num_bits_set) {=0A=
+		if (cpumask & (1 << cpu)) {=0A=
+			int new_apicid =3D cpu_to_logical_apicid(cpu);=0A=
+			if (apicid_cluster(apicid) !=3D =0A=
+					apicid_cluster(new_apicid)){=0A=
+				printk ("%s: Not a valid mask!\n",__FUNCTION__);=0A=
+				return TARGET_CPUS;=0A=
+			}=0A=
+			apicid =3D new_apicid;=0A=
+			cpus_found++;=0A=
+		}=0A=
+		cpu++;=0A=
+	}=0A=
+	return apicid;=0A=
+}=0A=
+=0A=
+#endif /* __ASM_MACH_APIC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_APICDEF_H=0A=
+#define __ASM_MACH_APICDEF_H=0A=
+=0A=
+#define		APIC_ID_MASK		(0xFF<<24)=0A=
+=0A=
+static inline unsigned get_apic_id(unsigned long x) =0A=
+{ =0A=
+	return (((x)>>24)&0xFF);=0A=
+} =0A=
+=0A=
+#define		GET_APIC_ID(x)	get_apic_id(x)=0A=
+=0A=
+#endif=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,24 @@=0A=
+#ifndef __ASM_MACH_IPI_H=0A=
+#define __ASM_MACH_IPI_H=0A=
+=0A=
+static inline void send_IPI_mask_sequence(int mask, int vector);=0A=
+=0A=
+static inline void send_IPI_mask(int mask, int vector)=0A=
+{=0A=
+	send_IPI_mask_sequence(mask, vector);=0A=
+}=0A=
+=0A=
+static inline void send_IPI_allbutself(int vector)=0A=
+{=0A=
+	unsigned long mask =3D cpu_online_map & ~(1 << =
smp_processor_id());=0A=
+=0A=
+	if (mask)=0A=
+		send_IPI_mask(mask, vector);=0A=
+}=0A=
+=0A=
+static inline void send_IPI_all(int vector)=0A=
+{=0A=
+	send_IPI_mask(cpu_online_map, vector);=0A=
+}=0A=
+=0A=
+#endif /* __ASM_MACH_IPI_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,38 @@=0A=
+#ifndef __ASM_MACH_MPPARSE_H=0A=
+#define __ASM_MACH_MPPARSE_H=0A=
+=0A=
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char =
*name, =0A=
+				struct mpc_config_translation *translation)=0A=
+{=0A=
+	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);=0A=
+}=0A=
+=0A=
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, =0A=
+				struct mpc_config_translation *translation)=0A=
+{=0A=
+}=0A=
+=0A=
+extern void parse_unisys_oem (char *oemptr, int oem_entries);=0A=
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);=0A=
+=0A=
+static inline void mps_oem_check(struct mp_config_table *mpc, char =
*oem, =0A=
+		char *productid)=0A=
+{=0A=
+	if (mpc->mpc_oemptr) {=0A=
+		struct mp_config_oemtable *oem_table =3D =0A=
+			(struct mp_config_oemtable *)mpc->mpc_oemptr;=0A=
+		parse_unisys_oem((char *)oem_table, oem_table->oem_length);=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Hook from generic ACPI tables.c */=0A=
+static inline void acpi_madt_oem_check(char *oem_id, char =
*oem_table_id)=0A=
+{=0A=
+	unsigned long oem_addr; =0A=
+	int oem_entries;=0A=
+	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))=0A=
+		parse_unisys_oem((char *)oem_addr, oem_entries);=0A=
+}=0A=
+=0A=
+=0A=
+#endif /* __ASM_MACH_MPPARSE_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 256 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 256=0A=
+=0A=
+#define MAX_IRQ_SOURCES 256=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h=0A=
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,58 @@=0A=
+#ifndef __ASM_MACH_WAKECPU_H=0A=
+#define __ASM_MACH_WAKECPU_H=0A=
+=0A=
+/* =0A=
+ * This file copes with machines that wakeup secondary CPUs by the=0A=
+ * INIT, INIT, STARTUP sequence.=0A=
+ */=0A=
+=0A=
+#ifdef CONFIG_ES7000_CLUSTERED_APIC=0A=
+#define WAKE_SECONDARY_VIA_MIP=0A=
+#else=0A=
+#define WAKE_SECONDARY_VIA_INIT=0A=
+#endif=0A=
+=0A=
+#ifdef WAKE_SECONDARY_VIA_MIP=0A=
+extern int es7000_start_cpu(int cpu, unsigned long eip);=0A=
+static inline int=0A=
+wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)=0A=
+{=0A=
+	int boot_error =3D 0;=0A=
+	boot_error =3D es7000_start_cpu(phys_apicid, start_eip);=0A=
+	return boot_error;=0A=
+}=0A=
+#endif=0A=
+=0A=
+#define TRAMPOLINE_LOW phys_to_virt(0x467)=0A=
+#define TRAMPOLINE_HIGH phys_to_virt(0x469)=0A=
+=0A=
+#define boot_cpu_apicid boot_cpu_physical_apicid=0A=
+=0A=
+static inline void wait_for_init_deassert(atomic_t *deassert)=0A=
+{=0A=
+#ifdef WAKE_SECONDARY_VIA_INIT=0A=
+	while (!atomic_read(deassert));=0A=
+#endif=0A=
+	return;=0A=
+}=0A=
+=0A=
+/* Nothing to do for most platforms, since cleared by the INIT cycle =
*/=0A=
+static inline void smp_callin_clear_local_apic(void)=0A=
+{=0A=
+}=0A=
+=0A=
+static inline void store_NMI_vector(unsigned short *high, unsigned =
short *low)=0A=
+{=0A=
+}=0A=
+=0A=
+static inline void restore_NMI_vector(unsigned short *high, unsigned =
short *low)=0A=
+{=0A=
+}=0A=
+=0A=
+#if APIC_DEBUG=0A=
+ #define inquire_remote_apic(apicid) __inquire_remote_apic(apicid)=0A=
+#else=0A=
+ #define inquire_remote_apic(apicid) {}=0A=
+#endif=0A=
+=0A=
+#endif /* __ASM_MACH_WAKECPU_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-generic/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-generic/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 256 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 256=0A=
+=0A=
+#define MAX_IRQ_SOURCES 256=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h =
linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h	2003-05-26 =
19:00:39.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -107,6 +107,10 @@=0A=
 	return (1);=0A=
 }=0A=
 =0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+}=0A=
+=0A=
 static inline unsigned int cpu_mask_to_apicid (unsigned long =
cpumask)=0A=
 {=0A=
 	int num_bits_set;=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 256 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 256=0A=
+=0A=
+#define MAX_IRQ_SOURCES 512=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h =
linux70-nbp/include/asm-i386/mach-summit/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h	2003-05-26 =
19:00:42.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mach-summit/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -136,6 +136,10 @@=0A=
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);=0A=
 }=0A=
 =0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+}=0A=
+=0A=
 static inline unsigned int cpu_mask_to_apicid (unsigned long =
cpumask)=0A=
 {=0A=
 	int num_bits_set;=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mach-summit/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mach-summit/mach_mpspec.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,13 @@=0A=
+#ifndef __ASM_MACH_MPSPEC_H=0A=
+#define __ASM_MACH_MPSPEC_H=0A=
+=0A=
+/*=0A=
+ * a maximum of 256 APICs with the current APIC ID architecture.=0A=
+ */=0A=
+#define MAX_APICS 256=0A=
+=0A=
+#define MAX_IRQ_SOURCES 256=0A=
+=0A=
+#define MAX_MP_BUSSES 32=0A=
+=0A=
+#endif /* __ASM_MACH_MPSPEC_H */=0A=
diff -Naur linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h =
linux70-nbp/include/asm-i386/mach-visws/mach_apic.h=0A=
--- linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h	2003-05-26 =
19:00:20.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mach-visws/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -72,6 +72,10 @@=0A=
 {=0A=
 }=0A=
 =0A=
+static inline void enable_apic_mode(void)=0A=
+{=0A=
+}=0A=
+=0A=
 static inline int check_phys_apicid_present(int =
boot_cpu_physical_apicid)=0A=
 {=0A=
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);=0A=
diff -Naur linux-2.5.70/include/asm-i386/mpspec.h =
linux70-nbp/include/asm-i386/mpspec.h=0A=
--- linux-2.5.70/include/asm-i386/mpspec.h	2003-05-26 =
19:00:19.000000000 -0600=0A=
+++ linux70-nbp/include/asm-i386/mpspec.h	2003-06-09 10:11:25.000000000 =
-0600=0A=
@@ -1,204 +1,9 @@=0A=
 #ifndef __ASM_MPSPEC_H=0A=
 #define __ASM_MPSPEC_H=0A=
 =0A=
-/*=0A=
- * Structure definitions for SMP machines following the=0A=
- * Intel Multiprocessing Specification 1.1 and 1.4.=0A=
- */=0A=
-=0A=
-/*=0A=
- * This tag identifies where the SMP configuration=0A=
- * information is. =0A=
- */=0A=
- =0A=
-#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')=0A=
-=0A=
-/*=0A=
- * a maximum of 16 APICs with the current APIC ID architecture.=0A=
- */=0A=
-#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT) || =
defined(CONFIG_X86_GENERICARCH)=0A=
-#define MAX_APICS 256=0A=
-#else=0A=
-#define MAX_APICS 16=0A=
-#endif=0A=
-=0A=
-#define MAX_MPC_ENTRY 1024=0A=
+#include <asm/mpspec_def.h>=0A=
+#include <mach_mpspec.h>=0A=
 =0A=
-struct intel_mp_floating=0A=
-{=0A=
-	char mpf_signature[4];		/* "_MP_" 			*/=0A=
-	unsigned long mpf_physptr;	/* Configuration table address	*/=0A=
-	unsigned char mpf_length;	/* Our length (paragraphs)	*/=0A=
-	unsigned char mpf_specification;/* Specification version	*/=0A=
-	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/=0A=
-	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/=0A=
-	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/=0A=
-	unsigned char mpf_feature3;	/* Unused (0)			*/=0A=
-	unsigned char mpf_feature4;	/* Unused (0)			*/=0A=
-	unsigned char mpf_feature5;	/* Unused (0)			*/=0A=
-};=0A=
-=0A=
-struct mp_config_table=0A=
-{=0A=
-	char mpc_signature[4];=0A=
-#define MPC_SIGNATURE "PCMP"=0A=
-	unsigned short mpc_length;	/* Size of table */=0A=
-	char  mpc_spec;			/* 0x01 */=0A=
-	char  mpc_checksum;=0A=
-	char  mpc_oem[8];=0A=
-	char  mpc_productid[12];=0A=
-	unsigned long mpc_oemptr;	/* 0 if not present */=0A=
-	unsigned short mpc_oemsize;	/* 0 if not present */=0A=
-	unsigned short mpc_oemcount;=0A=
-	unsigned long mpc_lapic;	/* APIC address */=0A=
-	unsigned long reserved;=0A=
-};=0A=
-=0A=
-/* Followed by entries */=0A=
-=0A=
-#define	MP_PROCESSOR	0=0A=
-#define	MP_BUS		1=0A=
-#define	MP_IOAPIC	2=0A=
-#define	MP_INTSRC	3=0A=
-#define	MP_LINTSRC	4=0A=
-#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node =
locality */=0A=
-=0A=
-struct mpc_config_processor=0A=
-{=0A=
-	unsigned char mpc_type;=0A=
-	unsigned char mpc_apicid;	/* Local APIC number */=0A=
-	unsigned char mpc_apicver;	/* Its versions */=0A=
-	unsigned char mpc_cpuflag;=0A=
-#define CPU_ENABLED		1	/* Processor is available */=0A=
-#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */=0A=
-	unsigned long mpc_cpufeature;		=0A=
-#define CPU_STEPPING_MASK 0x0F=0A=
-#define CPU_MODEL_MASK	0xF0=0A=
-#define CPU_FAMILY_MASK	0xF00=0A=
-	unsigned long mpc_featureflag;	/* CPUID feature value */=0A=
-	unsigned long mpc_reserved[2];=0A=
-};=0A=
-=0A=
-struct mpc_config_bus=0A=
-{=0A=
-	unsigned char mpc_type;=0A=
-	unsigned char mpc_busid;=0A=
-	unsigned char mpc_bustype[6] __attribute((packed));=0A=
-};=0A=
-=0A=
-/* List of Bus Type string values, Intel MP Spec. */=0A=
-#define BUSTYPE_EISA	"EISA"=0A=
-#define BUSTYPE_ISA	"ISA"=0A=
-#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */=0A=
-#define BUSTYPE_MCA	"MCA"=0A=
-#define BUSTYPE_VL	"VL"		/* Local bus */=0A=
-#define BUSTYPE_PCI	"PCI"=0A=
-#define BUSTYPE_PCMCIA	"PCMCIA"=0A=
-#define BUSTYPE_CBUS	"CBUS"=0A=
-#define BUSTYPE_CBUSII	"CBUSII"=0A=
-#define BUSTYPE_FUTURE	"FUTURE"=0A=
-#define BUSTYPE_MBI	"MBI"=0A=
-#define BUSTYPE_MBII	"MBII"=0A=
-#define BUSTYPE_MPI	"MPI"=0A=
-#define BUSTYPE_MPSA	"MPSA"=0A=
-#define BUSTYPE_NUBUS	"NUBUS"=0A=
-#define BUSTYPE_TC	"TC"=0A=
-#define BUSTYPE_VME	"VME"=0A=
-#define BUSTYPE_XPRESS	"XPRESS"=0A=
-#define BUSTYPE_NEC98	"NEC98"=0A=
-=0A=
-struct mpc_config_ioapic=0A=
-{=0A=
-	unsigned char mpc_type;=0A=
-	unsigned char mpc_apicid;=0A=
-	unsigned char mpc_apicver;=0A=
-	unsigned char mpc_flags;=0A=
-#define MPC_APIC_USABLE		0x01=0A=
-	unsigned long mpc_apicaddr;=0A=
-};=0A=
-=0A=
-struct mpc_config_intsrc=0A=
-{=0A=
-	unsigned char mpc_type;=0A=
-	unsigned char mpc_irqtype;=0A=
-	unsigned short mpc_irqflag;=0A=
-	unsigned char mpc_srcbus;=0A=
-	unsigned char mpc_srcbusirq;=0A=
-	unsigned char mpc_dstapic;=0A=
-	unsigned char mpc_dstirq;=0A=
-};=0A=
-=0A=
-enum mp_irq_source_types {=0A=
-	mp_INT =3D 0,=0A=
-	mp_NMI =3D 1,=0A=
-	mp_SMI =3D 2,=0A=
-	mp_ExtINT =3D 3=0A=
-};=0A=
-=0A=
-#define MP_IRQDIR_DEFAULT	0=0A=
-#define MP_IRQDIR_HIGH		1=0A=
-#define MP_IRQDIR_LOW		3=0A=
-=0A=
-=0A=
-struct mpc_config_lintsrc=0A=
-{=0A=
-	unsigned char mpc_type;=0A=
-	unsigned char mpc_irqtype;=0A=
-	unsigned short mpc_irqflag;=0A=
-	unsigned char mpc_srcbusid;=0A=
-	unsigned char mpc_srcbusirq;=0A=
-	unsigned char mpc_destapic;	=0A=
-#define MP_APIC_ALL	0xFF=0A=
-	unsigned char mpc_destapiclint;=0A=
-};=0A=
-=0A=
-struct mp_config_oemtable=0A=
-{=0A=
-	char oem_signature[4];=0A=
-#define MPC_OEM_SIGNATURE "_OEM"=0A=
-	unsigned short oem_length;	/* Size of table */=0A=
-	char  oem_rev;			/* 0x01 */=0A=
-	char  oem_checksum;=0A=
-	char  mpc_oem[8];=0A=
-};=0A=
-=0A=
-struct mpc_config_translation=0A=
-{=0A=
-        unsigned char mpc_type;=0A=
-        unsigned char trans_len;=0A=
-        unsigned char trans_type;=0A=
-        unsigned char trans_quad;=0A=
-        unsigned char trans_global;=0A=
-        unsigned char trans_local;=0A=
-        unsigned short trans_reserved;=0A=
-};=0A=
-=0A=
-/*=0A=
- *	Default configurations=0A=
- *=0A=
- *	1	2 CPU ISA 82489DX=0A=
- *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining=0A=
- *	3	2 CPU EISA 82489DX=0A=
- *	4	2 CPU MCA 82489DX=0A=
- *	5	2 CPU ISA+PCI=0A=
- *	6	2 CPU EISA+PCI=0A=
- *	7	2 CPU MCA+PCI=0A=
- */=0A=
-=0A=
-#ifdef CONFIG_X86_NUMAQ=0A=
-#define MAX_IRQ_SOURCES 512=0A=
-#else /* !CONFIG_X86_NUMAQ */=0A=
-#define MAX_IRQ_SOURCES 256=0A=
-#endif /* CONFIG_X86_NUMAQ */=0A=
-=0A=
-#define MAX_MP_BUSSES 32=0A=
-enum mp_bustype {=0A=
-	MP_BUS_ISA =3D 1,=0A=
-	MP_BUS_EISA,=0A=
-	MP_BUS_PCI,=0A=
-	MP_BUS_MCA,=0A=
-	MP_BUS_NEC98=0A=
-};=0A=
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];=0A=
 extern int mp_bus_id_to_node [MAX_MP_BUSSES];=0A=
 extern int mp_bus_id_to_local [MAX_MP_BUSSES];=0A=
diff -Naur linux-2.5.70/include/asm-i386/mpspec_def.h =
linux70-nbp/include/asm-i386/mpspec_def.h=0A=
--- linux-2.5.70/include/asm-i386/mpspec_def.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ linux70-nbp/include/asm-i386/mpspec_def.h	2003-06-09 =
10:11:25.000000000 -0600=0A=
@@ -0,0 +1,187 @@=0A=
+#ifndef __ASM_MPSPEC_DEF_H=0A=
+#define __ASM_MPSPEC_DEF_H=0A=
+=0A=
+/*=0A=
+ * Structure definitions for SMP machines following the=0A=
+ * Intel Multiprocessing Specification 1.1 and 1.4.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * This tag identifies where the SMP configuration=0A=
+ * information is. =0A=
+ */=0A=
+ =0A=
+#define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')=0A=
+=0A=
+#define MAX_MPC_ENTRY 1024=0A=
+=0A=
+struct intel_mp_floating=0A=
+{=0A=
+	char mpf_signature[4];		/* "_MP_" 			*/=0A=
+	unsigned long mpf_physptr;	/* Configuration table address	*/=0A=
+	unsigned char mpf_length;	/* Our length (paragraphs)	*/=0A=
+	unsigned char mpf_specification;/* Specification version	*/=0A=
+	unsigned char mpf_checksum;	/* Checksum (makes sum 0)	*/=0A=
+	unsigned char mpf_feature1;	/* Standard or configuration ? 	*/=0A=
+	unsigned char mpf_feature2;	/* Bit7 set for IMCR|PIC	*/=0A=
+	unsigned char mpf_feature3;	/* Unused (0)			*/=0A=
+	unsigned char mpf_feature4;	/* Unused (0)			*/=0A=
+	unsigned char mpf_feature5;	/* Unused (0)			*/=0A=
+};=0A=
+=0A=
+struct mp_config_table=0A=
+{=0A=
+	char mpc_signature[4];=0A=
+#define MPC_SIGNATURE "PCMP"=0A=
+	unsigned short mpc_length;	/* Size of table */=0A=
+	char  mpc_spec;			/* 0x01 */=0A=
+	char  mpc_checksum;=0A=
+	char  mpc_oem[8];=0A=
+	char  mpc_productid[12];=0A=
+	unsigned long mpc_oemptr;	/* 0 if not present */=0A=
+	unsigned short mpc_oemsize;	/* 0 if not present */=0A=
+	unsigned short mpc_oemcount;=0A=
+	unsigned long mpc_lapic;	/* APIC address */=0A=
+	unsigned long reserved;=0A=
+};=0A=
+=0A=
+/* Followed by entries */=0A=
+=0A=
+#define	MP_PROCESSOR	0=0A=
+#define	MP_BUS		1=0A=
+#define	MP_IOAPIC	2=0A=
+#define	MP_INTSRC	3=0A=
+#define	MP_LINTSRC	4=0A=
+#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node =
locality */=0A=
+=0A=
+struct mpc_config_processor=0A=
+{=0A=
+	unsigned char mpc_type;=0A=
+	unsigned char mpc_apicid;	/* Local APIC number */=0A=
+	unsigned char mpc_apicver;	/* Its versions */=0A=
+	unsigned char mpc_cpuflag;=0A=
+#define CPU_ENABLED		1	/* Processor is available */=0A=
+#define CPU_BOOTPROCESSOR	2	/* Processor is the BP */=0A=
+	unsigned long mpc_cpufeature;		=0A=
+#define CPU_STEPPING_MASK 0x0F=0A=
+#define CPU_MODEL_MASK	0xF0=0A=
+#define CPU_FAMILY_MASK	0xF00=0A=
+	unsigned long mpc_featureflag;	/* CPUID feature value */=0A=
+	unsigned long mpc_reserved[2];=0A=
+};=0A=
+=0A=
+struct mpc_config_bus=0A=
+{=0A=
+	unsigned char mpc_type;=0A=
+	unsigned char mpc_busid;=0A=
+	unsigned char mpc_bustype[6] __attribute((packed));=0A=
+};=0A=
+=0A=
+/* List of Bus Type string values, Intel MP Spec. */=0A=
+#define BUSTYPE_EISA	"EISA"=0A=
+#define BUSTYPE_ISA	"ISA"=0A=
+#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */=0A=
+#define BUSTYPE_MCA	"MCA"=0A=
+#define BUSTYPE_VL	"VL"		/* Local bus */=0A=
+#define BUSTYPE_PCI	"PCI"=0A=
+#define BUSTYPE_PCMCIA	"PCMCIA"=0A=
+#define BUSTYPE_CBUS	"CBUS"=0A=
+#define BUSTYPE_CBUSII	"CBUSII"=0A=
+#define BUSTYPE_FUTURE	"FUTURE"=0A=
+#define BUSTYPE_MBI	"MBI"=0A=
+#define BUSTYPE_MBII	"MBII"=0A=
+#define BUSTYPE_MPI	"MPI"=0A=
+#define BUSTYPE_MPSA	"MPSA"=0A=
+#define BUSTYPE_NUBUS	"NUBUS"=0A=
+#define BUSTYPE_TC	"TC"=0A=
+#define BUSTYPE_VME	"VME"=0A=
+#define BUSTYPE_XPRESS	"XPRESS"=0A=
+#define BUSTYPE_NEC98	"NEC98"=0A=
+=0A=
+struct mpc_config_ioapic=0A=
+{=0A=
+	unsigned char mpc_type;=0A=
+	unsigned char mpc_apicid;=0A=
+	unsigned char mpc_apicver;=0A=
+	unsigned char mpc_flags;=0A=
+#define MPC_APIC_USABLE		0x01=0A=
+	unsigned long mpc_apicaddr;=0A=
+};=0A=
+=0A=
+struct mpc_config_intsrc=0A=
+{=0A=
+	unsigned char mpc_type;=0A=
+	unsigned char mpc_irqtype;=0A=
+	unsigned short mpc_irqflag;=0A=
+	unsigned char mpc_srcbus;=0A=
+	unsigned char mpc_srcbusirq;=0A=
+	unsigned char mpc_dstapic;=0A=
+	unsigned char mpc_dstirq;=0A=
+};=0A=
+=0A=
+enum mp_irq_source_types {=0A=
+	mp_INT =3D 0,=0A=
+	mp_NMI =3D 1,=0A=
+	mp_SMI =3D 2,=0A=
+	mp_ExtINT =3D 3=0A=
+};=0A=
+=0A=
+#define MP_IRQDIR_DEFAULT	0=0A=
+#define MP_IRQDIR_HIGH		1=0A=
+#define MP_IRQDIR_LOW		3=0A=
+=0A=
+=0A=
+struct mpc_config_lintsrc=0A=
+{=0A=
+	unsigned char mpc_type;=0A=
+	unsigned char mpc_irqtype;=0A=
+	unsigned short mpc_irqflag;=0A=
+	unsigned char mpc_srcbusid;=0A=
+	unsigned char mpc_srcbusirq;=0A=
+	unsigned char mpc_destapic;	=0A=
+#define MP_APIC_ALL	0xFF=0A=
+	unsigned char mpc_destapiclint;=0A=
+};=0A=
+=0A=
+struct mp_config_oemtable=0A=
+{=0A=
+	char oem_signature[4];=0A=
+#define MPC_OEM_SIGNATURE "_OEM"=0A=
+	unsigned short oem_length;	/* Size of table */=0A=
+	char  oem_rev;			/* 0x01 */=0A=
+	char  oem_checksum;=0A=
+	char  mpc_oem[8];=0A=
+};=0A=
+=0A=
+struct mpc_config_translation=0A=
+{=0A=
+        unsigned char mpc_type;=0A=
+        unsigned char trans_len;=0A=
+        unsigned char trans_type;=0A=
+        unsigned char trans_quad;=0A=
+        unsigned char trans_global;=0A=
+        unsigned char trans_local;=0A=
+        unsigned short trans_reserved;=0A=
+};=0A=
+=0A=
+/*=0A=
+ *	Default configurations=0A=
+ *=0A=
+ *	1	2 CPU ISA 82489DX=0A=
+ *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining=0A=
+ *	3	2 CPU EISA 82489DX=0A=
+ *	4	2 CPU MCA 82489DX=0A=
+ *	5	2 CPU ISA+PCI=0A=
+ *	6	2 CPU EISA+PCI=0A=
+ *	7	2 CPU MCA+PCI=0A=
+ */=0A=
+=0A=
+enum mp_bustype {=0A=
+	MP_BUS_ISA =3D 1,=0A=
+	MP_BUS_EISA,=0A=
+	MP_BUS_PCI,=0A=
+	MP_BUS_MCA,=0A=
+	MP_BUS_NEC98=0A=
+};=0A=
+#endif=0A=
+=0A=

------_=_NextPart_000_01C3301F.2300E90C--
