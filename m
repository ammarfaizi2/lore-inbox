Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFKNaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFKNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:30:07 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:6885 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id S261153AbTFKN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:29:15 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BDA75@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: torvalds@transmeta.com
Cc: "'akpm@digeo.com'" <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2][2.5]Unisys ES7000 platform subarch
Date: Wed, 11 Jun 2003 08:42:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3301F.418F6C86"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3301F.418F6C86
Content-Type: text/plain;
	charset="iso-8859-1"

This is patch #2. It includes ES7000 specific code for es7000 subarch.


diff -Naur linux-2.5.70/arch/i386/Kconfig linux70-nbp/arch/i386/Kconfig
--- linux-2.5.70/arch/i386/Kconfig	2003-05-26 19:00:24.000000000 -0600
+++ linux70-nbp/arch/i386/Kconfig	2003-06-09 10:11:25.000000000 -0600
@@ -99,6 +99,15 @@
           This option compiles in the Summit, bigsmp, default
subarchitectures.
 	  It is intended for a generic binary kernel.
 
+config X86_ES7000
+	bool "Support for Unisys ES7000 IA32 series"
+	depends on SMP
+	help
+	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel is
+	  supposed to run on an IA32-based Unisys ES7000 system. 
+	  Only choose this option if you have such a system, otherwise you 
+	  should say N here.
+
 endchoice
 
 config ACPI_SRAT
@@ -111,6 +120,11 @@
        default y
        depends on X86_SUMMIT || X86_GENERICARCH
 
+config ES7000_CLUSTERED_APIC
+	bool
+	default y
+	depends on SMP && X86_ES7000 && MPENTIUMIII
+
 choice
 	prompt "Processor family"
 	default M686
diff -Naur linux-2.5.70/arch/i386/Makefile linux70-nbp/arch/i386/Makefile
--- linux-2.5.70/arch/i386/Makefile	2003-05-26 19:00:37.000000000 -0600
+++ linux70-nbp/arch/i386/Makefile	2003-06-09 10:11:25.000000000 -0600
@@ -78,6 +78,10 @@
 mcore-$(CONFIG_X86_GENERICARCH) := mach-default
 core-$(CONFIG_X86_GENERICARCH) += arch/i386/mach-generic/
 
+# ES7000 subarch support
+mflags-$(CONFIG_X86_ES7000)	:= -Iinclude/asm-i386/mach-es7000
+mcore-$(CONFIG_X86_ES7000)	:= mach-es7000
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
diff -Naur linux-2.5.70/arch/i386/kernel/apic.c
linux70-nbp/arch/i386/kernel/apic.c
--- linux-2.5.70/arch/i386/kernel/apic.c	2003-05-26
19:01:02.000000000 -0600
+++ linux70-nbp/arch/i386/kernel/apic.c	2003-06-09 10:11:25.000000000 -0600
@@ -158,6 +158,7 @@
 		outb(0x70, 0x22);
 		outb(0x01, 0x23);
 	}
+	enable_apic_mode();
 }
 
 void disconnect_bsp_APIC(void)
diff -Naur linux-2.5.70/arch/i386/mach-es7000/Makefile
linux70-nbp/arch/i386/mach-es7000/Makefile
--- linux-2.5.70/arch/i386/mach-es7000/Makefile	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/Makefile	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y		:= setup.o topology.o es7000.o
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.c
linux70-nbp/arch/i386/mach-es7000/es7000.c
--- linux-2.5.70/arch/i386/mach-es7000/es7000.c	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/es7000.c	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,281 @@
+/*
+ * Written by: Garry Forsgren, Unisys Corporation
+ *             Natalie Protasevich, Unisys Corporation
+ * This file contains the code to configure and interface 
+ * with Unisys ES7000 series hardware system manager.
+ *
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Unisys Corporation, Township Line & Union Meeting 
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
+ *
+ * http://www.unisys.com
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <asm/io.h>
+#include <asm/nmi.h>
+#include <asm/smp.h>
+#include <asm/apicdef.h>
+#include "es7000.h"
+
+/*
+ * ES7000 Globals
+ */
+
+volatile unsigned long	*psai = NULL;
+struct mip_reg		*mip_reg;  
+struct mip_reg		*host_reg;
+int 			mip_port;
+unsigned long		mip_addr, host_addr;
+
+static int		es7000_plat;
+
+/*
+ * Parse the OEM Table
+ */
+
+void __init
+parse_unisys_oem (char *oemptr, int oem_entries)
+{
+	int                     i;
+	int 			success = 0;
+	unsigned char           type, size;
+	unsigned long           val;
+	char                    *tp = NULL;  
+	struct psai             *psaip = NULL;
+	struct mip_reg_info 	*mi;
+	struct mip_reg		*host, *mip;
+
+	tp = oemptr;
+
+	tp += 8;
+
+	for (i=0; i <= oem_entries; i++) {
+		type = *tp++;
+		size = *tp++;
+		tp -= 2;
+		switch (type) {
+		case MIP_REG:
+			mi = (struct mip_reg_info *)tp;
+			val = MIP_RD_LO(mi->host_reg);
+			host_addr = val;
+			host = (struct mip_reg *)val;
+			host_reg = __va(host);
+			val = MIP_RD_LO(mi->mip_reg);
+			mip_addr = val;
+			mip = (struct mip_reg *)val;
+			mip_reg = __va(mip);
+			Dprintk("es7000_mipcfg: host_reg = 0x%lx \n", 
+				(unsigned long)host_reg);
+			Dprintk("es7000_mipcfg: mip_reg = 0x%lx \n", 
+				(unsigned long)mip_reg);
+			success++;
+			break;
+		case MIP_PSAI_REG:
+			psaip = (struct psai *)tp;
+			if (tp != NULL) {
+				if (psaip->addr)
+					psai = __va(psaip->addr);
+				else
+					psai = NULL;
+				success++;
+			}
+			break;
+		default:
+			break;
+		}
+		if (i == 6) break;
+		tp += size;
+	}
+
+	if (success < 2) {
+		printk("\nNo ES7000 found.\n");
+		es7000_plat = 0;
+	} else {
+		printk("\nEnabling ES7000 specific features...\n");
+		es7000_plat = 1;
+	}
+	return;
+}
+
+int __init 
+find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length) 
+{
+	struct acpi_table_rsdp		*rsdp = NULL;
+	unsigned long			rsdp_phys = 0;
+	struct acpi_table_header 	*header = NULL;
+	int				i;
+	struct acpi_table_sdt		sdt;
+
+	rsdp_phys = acpi_find_rsdp();
+	rsdp = __va(rsdp_phys);
+	if (rsdp->rsdt_address) {
+		struct acpi_table_rsdt	*mapped_rsdt = NULL;
+		sdt.pa = rsdp->rsdt_address;
+
+		header = (struct acpi_table_header *)
+			__acpi_map_table(sdt.pa, sizeof(struct
acpi_table_header));
+		if (!header)
+			return -ENODEV;
+
+		sdt.count = (header->length - sizeof(struct
acpi_table_header)) >> 3;
+		mapped_rsdt = (struct acpi_table_rsdt *)
+			__acpi_map_table(sdt.pa, header->length);
+		if (!mapped_rsdt)
+			return -ENODEV;
+
+		header = &mapped_rsdt->header;
+
+		for (i = 0; i < sdt.count; i++)
+			sdt.entry[i].pa = (unsigned long)
mapped_rsdt->entry[i];
+	};
+	for (i = 0; i < sdt.count; i++) {
+
+		header = (struct acpi_table_header *)
+			__acpi_map_table(sdt.entry[i].pa,
+				sizeof(struct acpi_table_header));
+		if (!header)
+			continue;
+		if (!strncmp((char *) &header->signature, "OEM1", 4)) {
+			if (!strncmp((char *) &header->oem_id, "UNISYS", 6))
{
+				void *addr;
+				struct oem_table *t;
+				acpi_table_print(header, sdt.entry[i].pa);
+				t = (struct oem_table *)
__acpi_map_table(sdt.entry[i].pa, header->length);
+				addr = (void *)
__acpi_map_table(t->OEMTableAddr, t->OEMTableSize);
+				*length = header->length;
+				*oem_addr = (unsigned long) addr;
+				return 0;
+			}
+		}
+	}
+	printk("ES7000: did not find Unisys ACPI OEM table!\n");
+	return -1;
+}
+
+static void
+es7000_spin(int n)
+{
+	int i = 0;
+
+	while (i++ < n) 
+		rep_nop();
+}
+
+static int __init
+es7000_mip_write(struct mip_reg *mip_reg)
+{
+	int			status = 0;
+	int			spin;
+
+	spin = MIP_SPIN;
+	while (((unsigned long long)host_reg->off_38 &
+		(unsigned long long)MIP_VALID) != 0) {
+			if (--spin <= 0) {
+				printk("es7000_mip_write: Timeout waiting
for Host Valid Flag");
+				return -1;
+			}
+		es7000_spin(MIP_SPIN);
+	}
+
+	memcpy(host_reg, mip_reg, sizeof(struct mip_reg));
+	outb(1, mip_port);
+
+	spin = MIP_SPIN;
+
+	while (((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)MIP_VALID) == 0) {
+		if (--spin <= 0) {
+			printk("es7000_mip_write: Timeout waiting for MIP
Valid Flag");
+			return -1;
+		}
+		es7000_spin(MIP_SPIN);
+	}
+
+	status = ((unsigned long long)mip_reg->off_0 &
+		(unsigned long long)0xffff0000000000) >> 48;
+	mip_reg->off_38 = ((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)~MIP_VALID);
+	return status;
+}
+
+int 
+es7000_start_cpu(int cpu, unsigned long eip)
+{
+	unsigned long vect = 0, psaival = 0;
+
+	if (psai == NULL)
+		return -1;
+
+	vect = ((unsigned long)__pa(eip)/0x1000) << 16;
+	psaival = (0x1000000 | vect | cpu);
+
+	while (*psai & 0x1000000)
+                ;
+
+	*psai = psaival;
+
+	return 0;
+
+}
+
+int 
+es7000_stop_cpu(int cpu)
+{
+	int startup;
+
+	if (psai == NULL)
+		return -1;
+
+	startup= (0x1000000 | cpu);
+
+	while ((*psai & 0xff00ffff) != startup)
+		;
+
+	startup = (*psai & 0xff0000) >> 16;
+	*psai &= 0xffffff;
+
+	return 0;
+
+}
+
+void __init
+es7000_sw_apic()
+{
+	if (es7000_plat) {
+		int mip_status;
+		struct mip_reg es7000_mip_reg;
+
+		printk("ES7000: Enabling APIC mode.\n");
+        	memset(&es7000_mip_reg, 0, sizeof(struct mip_reg));
+        	es7000_mip_reg.off_0 = MIP_SW_APIC;
+        	es7000_mip_reg.off_38 = (MIP_VALID);
+        	while ((mip_status = es7000_mip_write(&es7000_mip_reg)) !=
0)
+              		printk("es7000_sw_apic: command failed, status =
%x\n", 
+				mip_status);
+		return;
+	}
+}
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.h
linux70-nbp/arch/i386/mach-es7000/es7000.h
--- linux-2.5.70/arch/i386/mach-es7000/es7000.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/es7000.h	2003-06-10
04:43:09.000000000 -0600
@@ -0,0 +1,109 @@
+/*
+ * Written by: Garry Forsgren, Unisys Corporation
+ *             Natalie Protasevich, Unisys Corporation
+ * This file contains the code to configure and interface 
+ * with Unisys ES7000 series hardware system manager.
+ *
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Unisys Corporation, Township Line & Union Meeting 
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
+ *
+ * http://www.unisys.com
+ */
+
+#define	MIP_REG			1
+#define	MIP_PSAI_REG		4
+
+#define	MIP_BUSY		1
+#define	MIP_SPIN		0xf0000
+#define	MIP_VALID		0x0100000000000000
+
+#define	MIP_RD_LO(VALUE)	(VALUE & 0xffffffff)   
+
+struct mip_reg_info {
+	unsigned long long mip_info;
+	unsigned long long delivery_info;
+	unsigned long long host_reg;
+	unsigned long long mip_reg;
+};
+
+struct part_info {
+	unsigned char type;   
+	unsigned char length;
+	unsigned char part_id;
+	unsigned char apic_mode;
+	unsigned long snum;    
+	char ptype[16];
+	char sname[64];
+	char pname[64];
+};
+
+struct psai {
+	unsigned long long entry_type;
+	unsigned long long addr;
+	unsigned long long bep_addr;
+};
+
+struct es7000_mem_info {
+	unsigned char type;   
+	unsigned char length;
+	unsigned char resv[6];
+	unsigned long long  start; 
+	unsigned long long  size; 
+};
+
+struct es7000_oem_table {
+	unsigned long long hdr;
+	struct mip_reg_info mip;
+	struct part_info pif;
+	struct es7000_mem_info shm;
+	struct psai psai;
+};
+
+struct acpi_table_sdt {
+	unsigned long pa;
+	unsigned long count;
+	struct {
+		unsigned long pa;
+		enum acpi_table_id id;
+		unsigned long size;
+	}	entry[50];
+};
+
+struct oem_table {
+	struct acpi_table_header Header;
+	u32 OEMTableAddr;
+	u32 OEMTableSize;
+};
+
+struct mip_reg {
+	unsigned long long off_0;
+	unsigned long long off_8;
+	unsigned long long off_10;
+	unsigned long long off_18;
+	unsigned long long off_20;
+	unsigned long long off_28;
+	unsigned long long off_30;
+	unsigned long long off_38;
+};
+
+#define	MIP_SW_APIC		0x1020b
+#define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
+
+extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int
*length);
+extern int es7000_start_cpu(int cpu, unsigned long eip);
+extern void es7000_sw_apic(void);
diff -Naur linux-2.5.70/arch/i386/mach-es7000/setup.c
linux70-nbp/arch/i386/mach-es7000/setup.c
--- linux-2.5.70/arch/i386/mach-es7000/setup.c	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/setup.c	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,105 @@
+/*
+ *	Machine specific setup for es7000
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt
vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+	setup_irq(2, &irq2);
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0,
"timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ
listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
+#ifdef CONFIG_MCA
+/**
+ * mca_nmi_hook - hook into MCA specific NMI chain
+ *
+ * Description:
+ *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
+ *	along the MCA bus.  Use this to hook into that chain if you will
need
+ *	it.
+ **/
+void __init mca_nmi_hook(void)
+{
+	/* If I recall correctly, there's a whole bunch of other things that
+	 * we can do to check for NMI problems, but that's all I know about
+	 * at the moment.
+	 */
+
+	printk("NMI generated from unknown source!\n");
+}
+
+#endif
diff -Naur linux-2.5.70/arch/i386/mach-es7000/topology.c
linux70-nbp/arch/i386/mach-es7000/topology.c
--- linux-2.5.70/arch/i386/mach-es7000/topology.c	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/topology.c	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,68 @@
+/*
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology
information
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+#include <asm/memblk.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < num_online_memblks(); i++)
+		arch_register_memblk(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h
linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h	2003-05-26
19:00:58.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -123,6 +123,10 @@
 {
 }
 
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
 	return (1);
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_apic.h
linux70-nbp/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-default/mach_apic.h	2003-05-26
19:01:02.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-default/mach_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -118,4 +118,8 @@
 	return cpumask;
 }
 
+static inline void enable_apic_mode(void)
+{
+}
+
 #endif /* __ASM_MACH_APIC_H */
--- linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h	2003-05-26
19:00:42.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-summit/mach_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -136,6 +136,10 @@
 		return test_bit(boot_cpu_physical_apicid,
&phys_cpu_present_map);
 }
 
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
 	int num_bits_set;
diff -Naur linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h
linux70-nbp/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h	2003-05-26
19:00:20.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-visws/mach_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -72,6 +72,10 @@
 {
 }
 
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h
linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h	2003-05-26
19:00:39.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h	2003-06-09
10:11:25.000000000 -0600
@@ -107,6 +107,10 @@
 	return (1);
 }
 
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
 	int num_bits_set;
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h
linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h	2003-06-09
10:12:33.000000000 -0600
@@ -0,0 +1,189 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+extern u8 bios_cpu_apicid[];
+
+#define xapic_phys_to_log_apicid(cpu) (bios_cpu_apicid[cpu])
+#define esr_disable (1)
+
+static inline int apic_id_registered(void)
+{
+	        return (1);
+}
+
+static inline unsigned long target_cpus(void)
+{ 
+#if defined CONFIG_ES7000_CLUSTERED_APIC
+	return (0xff);
+#else
+	return (bios_cpu_apicid[smp_processor_id()]);
+#endif
+}
+#define TARGET_CPUS	(target_cpus())
+
+#if defined CONFIG_ES7000_CLUSTERED_APIC
+#define APIC_DFR_VALUE		(APIC_DFR_CLUSTER)
+#define INT_DELIVERY_MODE	(dest_LowestPrio)
+#define INT_DEST_MODE		(1)    /* logical delivery broadcast to all
procs */
+#define NO_BALANCE_IRQ 		(1)
+#undef  WAKE_SECONDARY_VIA_INIT
+#define WAKE_SECONDARY_VIA_MIP
+#else
+#define APIC_DFR_VALUE		(APIC_DFR_FLAT)
+#define INT_DELIVERY_MODE	(dest_Fixed)
+#define INT_DEST_MODE		(0)    /* phys delivery to target procs */
+#define NO_BALANCE_IRQ 		(0)
+#undef  APIC_DEST_LOGICAL
+#define APIC_DEST_LOGICAL	0x0
+#define WAKE_SECONDARY_VIA_INIT
+#endif
+
+#define APIC_BROADCAST_ID	(0xff)
+
+static inline unsigned long check_apicid_used(unsigned long bitmap, int
apicid) 
+{ 
+	return 0;
+} 
+static inline unsigned long check_apicid_present(int bit) 
+{
+	return (phys_cpu_present_map & (1 << bit));
+}
+
+#define apicid_cluster(apicid) (apicid & 0xF0)
+
+static inline unsigned long calculate_ldr(int cpu)
+{
+	unsigned long id;
+	id = xapic_phys_to_log_apicid(cpu);
+	return (SET_APIC_LOGICAL_ID(id));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LdR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+	int cpu = smp_processor_id();
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val = calculate_ldr(cpu);
+	apic_write_around(APIC_LDR, val);
+}
+
+extern void es7000_sw_apic(void);
+static inline void enable_apic_mode(void)
+{
+	es7000_sw_apic();
+	return;
+}
+
+extern int apic_version [MAX_APICS];
+static inline void clustered_apic_check(void)
+{
+	int apic = bios_cpu_apicid[smp_processor_id()];
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus
%lx\n",
+		(apic_version[apic] == 0x14) ? 
+		"Physical Cluster" : "Logical Cluster", nr_ioapics,
TARGET_CPUS);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
+}
+
+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (!mps_cpu)
+		return boot_cpu_physical_apicid;
+	else
+		return (int) bios_cpu_apicid[mps_cpu];
+}
+
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)
+{
+	static int cpu = 0;
+	return (1ul << cpu++);
+}
+
+extern volatile u8 cpu_2_logical_apicid[];
+/* Mapping from cpu number to logical apicid */
+static inline int cpu_to_logical_apicid(int cpu)
+{
+       return (int)cpu_2_logical_apicid[cpu];
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+	        m->mpc_apicid,
+	        (m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+	        (m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+	        m->mpc_apicver);
+	return (m->mpc_apicid);
+}
+
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* For clustered we don't have a good way to do this yet - hack */
+	return (0xff);
+}
+
+
+static inline void setup_portio_remap(void)
+{
+}
+
+extern unsigned int boot_cpu_physical_apicid;
+static inline int check_phys_apicid_present(int cpu_physical_apicid)
+{
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	return (1);
+}
+
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	int num_bits_set;
+	int cpus_found = 0;
+	int cpu;
+	int apicid;	
+
+	if (cpumask == TARGET_CPUS)
+		return cpumask;
+	num_bits_set = hweight32(cpumask); 
+	/* Return id to all */
+	if (num_bits_set == 32)
+		return TARGET_CPUS;
+	/* 
+	 * The cpus in the mask must all be on the apic cluster.  If are not

+	 * on the same apicid cluster return default value of TARGET_CPUS. 
+	 */
+	cpu = ffs(cpumask)-1;
+	apicid = cpu_to_logical_apicid(cpu);
+	while (cpus_found < num_bits_set) {
+		if (cpumask & (1 << cpu)) {
+			int new_apicid = cpu_to_logical_apicid(cpu);
+			if (apicid_cluster(apicid) != 
+					apicid_cluster(new_apicid)){
+				printk ("%s: Not a valid
mask!\n",__FUNCTION__);
+				return TARGET_CPUS;
+			}
+			apicid = new_apicid;
+			cpus_found++;
+		}
+		cpu++;
+	}
+	return apicid;
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h
linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define		APIC_ID_MASK		(0xFF<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xFF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+#endif
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h
linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	unsigned long mask = cpu_online_map & ~(1 << smp_processor_id());
+
+	if (mask)
+		send_IPI_mask(mask, vector);
+}
+
+static inline void send_IPI_all(int vector)
+{
+	send_IPI_mask(cpu_online_map, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h
linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,38 @@
+#ifndef __ASM_MACH_MPPARSE_H
+#define __ASM_MACH_MPPARSE_H
+
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
+				struct mpc_config_translation *translation)
+{
+	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
+}
+
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
+				struct mpc_config_translation *translation)
+{
+}
+
+extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int
*length);
+
+static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+		char *productid)
+{
+	if (mpc->mpc_oemptr) {
+		struct mp_config_oemtable *oem_table = 
+			(struct mp_config_oemtable *)mpc->mpc_oemptr;
+		parse_unisys_oem((char *)oem_table, oem_table->oem_length);
+	}
+}
+
+/* Hook from generic ACPI tables.c */
+static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	unsigned long oem_addr; 
+	int oem_entries;
+	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))
+		parse_unisys_oem((char *)oem_addr, oem_entries);
+}
+
+
+#endif /* __ASM_MACH_MPPARSE_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h
linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h	2003-06-09
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
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h
linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h	1969-12-31
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h	2003-06-09
10:11:25.000000000 -0600
@@ -0,0 +1,58 @@
+#ifndef __ASM_MACH_WAKECPU_H
+#define __ASM_MACH_WAKECPU_H
+
+/* 
+ * This file copes with machines that wakeup secondary CPUs by the
+ * INIT, INIT, STARTUP sequence.
+ */
+
+#ifdef CONFIG_ES7000_CLUSTERED_APIC
+#define WAKE_SECONDARY_VIA_MIP
+#else
+#define WAKE_SECONDARY_VIA_INIT
+#endif
+
+#ifdef WAKE_SECONDARY_VIA_MIP
+extern int es7000_start_cpu(int cpu, unsigned long eip);
+static inline int
+wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)
+{
+	int boot_error = 0;
+	boot_error = es7000_start_cpu(phys_apicid, start_eip);
+	return boot_error;
+}
+#endif
+
+#define TRAMPOLINE_LOW phys_to_virt(0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(0x469)
+
+#define boot_cpu_apicid boot_cpu_physical_apicid
+
+static inline void wait_for_init_deassert(atomic_t *deassert)
+{
+#ifdef WAKE_SECONDARY_VIA_INIT
+	while (!atomic_read(deassert));
+#endif
+	return;
+}
+
+/* Nothing to do for most platforms, since cleared by the INIT cycle */
+static inline void smp_callin_clear_local_apic(void)
+{
+}
+
+static inline void store_NMI_vector(unsigned short *high, unsigned short
*low)
+{
+}
+
+static inline void restore_NMI_vector(unsigned short *high, unsigned short
*low)
+{
+}
+
+#if APIC_DEBUG
+ #define inquire_remote_apic(apicid) __inquire_remote_apic(apicid)
+#else
+ #define inquire_remote_apic(apicid) {}
+#endif
+
+#endif /* __ASM_MACH_WAKECPU_H */


 <<es7000-2.5.70.txt>> 

------_=_NextPart_000_01C3301F.418F6C86
Content-Type: text/plain;
	name="es7000-2.5.70.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="es7000-2.5.70.txt"

diff -Naur linux-2.5.70/arch/i386/Kconfig linux70-nbp/arch/i386/Kconfig
--- linux-2.5.70/arch/i386/Kconfig	2003-05-26 19:00:24.000000000 -0600
+++ linux70-nbp/arch/i386/Kconfig	2003-06-09 10:11:25.000000000 -0600
@@ -99,6 +99,15 @@
           This option compiles in the Summit, bigsmp, default =
subarchitectures.
 	  It is intended for a generic binary kernel.
=20
+config X86_ES7000
+	bool "Support for Unisys ES7000 IA32 series"
+	depends on SMP
+	help
+	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel is
+	  supposed to run on an IA32-based Unisys ES7000 system.=20
+	  Only choose this option if you have such a system, otherwise you=20
+	  should say N here.
+
 endchoice
=20
 config ACPI_SRAT
@@ -111,6 +120,11 @@
        default y
        depends on X86_SUMMIT || X86_GENERICARCH
=20
+config ES7000_CLUSTERED_APIC
+	bool
+	default y
+	depends on SMP && X86_ES7000 && MPENTIUMIII
+
 choice
 	prompt "Processor family"
 	default M686
diff -Naur linux-2.5.70/arch/i386/Makefile =
linux70-nbp/arch/i386/Makefile
--- linux-2.5.70/arch/i386/Makefile	2003-05-26 19:00:37.000000000 -0600
+++ linux70-nbp/arch/i386/Makefile	2003-06-09 10:11:25.000000000 -0600
@@ -78,6 +78,10 @@
 mcore-$(CONFIG_X86_GENERICARCH) :=3D mach-default
 core-$(CONFIG_X86_GENERICARCH) +=3D arch/i386/mach-generic/
=20
+# ES7000 subarch support
+mflags-$(CONFIG_X86_ES7000)	:=3D -Iinclude/asm-i386/mach-es7000
+mcore-$(CONFIG_X86_ES7000)	:=3D mach-es7000
+
 # default subarch .h files
 mflags-y +=3D -Iinclude/asm-i386/mach-default
=20
diff -Naur linux-2.5.70/arch/i386/kernel/apic.c =
linux70-nbp/arch/i386/kernel/apic.c
--- linux-2.5.70/arch/i386/kernel/apic.c	2003-05-26 19:01:02.000000000 =
-0600
+++ linux70-nbp/arch/i386/kernel/apic.c	2003-06-09 10:11:25.000000000 =
-0600
@@ -158,6 +158,7 @@
 		outb(0x70, 0x22);
 		outb(0x01, 0x23);
 	}
+	enable_apic_mode();
 }
=20
 void disconnect_bsp_APIC(void)
diff -Naur linux-2.5.70/arch/i386/mach-es7000/Makefile =
linux70-nbp/arch/i386/mach-es7000/Makefile
--- linux-2.5.70/arch/i386/mach-es7000/Makefile	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/Makefile	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+=3D -I../kernel
+
+obj-y		:=3D setup.o topology.o es7000.o
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.c =
linux70-nbp/arch/i386/mach-es7000/es7000.c
--- linux-2.5.70/arch/i386/mach-es7000/es7000.c	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/es7000.c	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,281 @@
+/*
+ * Written by: Garry Forsgren, Unisys Corporation
+ *             Natalie Protasevich, Unisys Corporation
+ * This file contains the code to configure and interface=20
+ * with Unisys ES7000 series hardware system manager.
+ *
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or =
modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, =
but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License =
along
+ * with this program; if not, write the Free Software Foundation, =
Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Unisys Corporation, Township Line & Union =
Meeting=20
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
+ *
+ * http://www.unisys.com
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <asm/io.h>
+#include <asm/nmi.h>
+#include <asm/smp.h>
+#include <asm/apicdef.h>
+#include "es7000.h"
+
+/*
+ * ES7000 Globals
+ */
+
+volatile unsigned long	*psai =3D NULL;
+struct mip_reg		*mip_reg; =20
+struct mip_reg		*host_reg;
+int 			mip_port;
+unsigned long		mip_addr, host_addr;
+
+static int		es7000_plat;
+
+/*
+ * Parse the OEM Table
+ */
+
+void __init
+parse_unisys_oem (char *oemptr, int oem_entries)
+{
+	int                     i;
+	int 			success =3D 0;
+	unsigned char           type, size;
+	unsigned long           val;
+	char                    *tp =3D NULL; =20
+	struct psai             *psaip =3D NULL;
+	struct mip_reg_info 	*mi;
+	struct mip_reg		*host, *mip;
+
+	tp =3D oemptr;
+
+	tp +=3D 8;
+
+	for (i=3D0; i <=3D oem_entries; i++) {
+		type =3D *tp++;
+		size =3D *tp++;
+		tp -=3D 2;
+		switch (type) {
+		case MIP_REG:
+			mi =3D (struct mip_reg_info *)tp;
+			val =3D MIP_RD_LO(mi->host_reg);
+			host_addr =3D val;
+			host =3D (struct mip_reg *)val;
+			host_reg =3D __va(host);
+			val =3D MIP_RD_LO(mi->mip_reg);
+			mip_addr =3D val;
+			mip =3D (struct mip_reg *)val;
+			mip_reg =3D __va(mip);
+			Dprintk("es7000_mipcfg: host_reg =3D 0x%lx \n",=20
+				(unsigned long)host_reg);
+			Dprintk("es7000_mipcfg: mip_reg =3D 0x%lx \n",=20
+				(unsigned long)mip_reg);
+			success++;
+			break;
+		case MIP_PSAI_REG:
+			psaip =3D (struct psai *)tp;
+			if (tp !=3D NULL) {
+				if (psaip->addr)
+					psai =3D __va(psaip->addr);
+				else
+					psai =3D NULL;
+				success++;
+			}
+			break;
+		default:
+			break;
+		}
+		if (i =3D=3D 6) break;
+		tp +=3D size;
+	}
+
+	if (success < 2) {
+		printk("\nNo ES7000 found.\n");
+		es7000_plat =3D 0;
+	} else {
+		printk("\nEnabling ES7000 specific features...\n");
+		es7000_plat =3D 1;
+	}
+	return;
+}
+
+int __init=20
+find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length)=20
+{
+	struct acpi_table_rsdp		*rsdp =3D NULL;
+	unsigned long			rsdp_phys =3D 0;
+	struct acpi_table_header 	*header =3D NULL;
+	int				i;
+	struct acpi_table_sdt		sdt;
+
+	rsdp_phys =3D acpi_find_rsdp();
+	rsdp =3D __va(rsdp_phys);
+	if (rsdp->rsdt_address) {
+		struct acpi_table_rsdt	*mapped_rsdt =3D NULL;
+		sdt.pa =3D rsdp->rsdt_address;
+
+		header =3D (struct acpi_table_header *)
+			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
+		if (!header)
+			return -ENODEV;
+
+		sdt.count =3D (header->length - sizeof(struct acpi_table_header)) >> =
3;
+		mapped_rsdt =3D (struct acpi_table_rsdt *)
+			__acpi_map_table(sdt.pa, header->length);
+		if (!mapped_rsdt)
+			return -ENODEV;
+
+		header =3D &mapped_rsdt->header;
+
+		for (i =3D 0; i < sdt.count; i++)
+			sdt.entry[i].pa =3D (unsigned long) mapped_rsdt->entry[i];
+	};
+	for (i =3D 0; i < sdt.count; i++) {
+
+		header =3D (struct acpi_table_header *)
+			__acpi_map_table(sdt.entry[i].pa,
+				sizeof(struct acpi_table_header));
+		if (!header)
+			continue;
+		if (!strncmp((char *) &header->signature, "OEM1", 4)) {
+			if (!strncmp((char *) &header->oem_id, "UNISYS", 6)) {
+				void *addr;
+				struct oem_table *t;
+				acpi_table_print(header, sdt.entry[i].pa);
+				t =3D (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, =
header->length);
+				addr =3D (void *) __acpi_map_table(t->OEMTableAddr, =
t->OEMTableSize);
+				*length =3D header->length;
+				*oem_addr =3D (unsigned long) addr;
+				return 0;
+			}
+		}
+	}
+	printk("ES7000: did not find Unisys ACPI OEM table!\n");
+	return -1;
+}
+
+static void
+es7000_spin(int n)
+{
+	int i =3D 0;
+
+	while (i++ < n)=20
+		rep_nop();
+}
+
+static int __init
+es7000_mip_write(struct mip_reg *mip_reg)
+{
+	int			status =3D 0;
+	int			spin;
+
+	spin =3D MIP_SPIN;
+	while (((unsigned long long)host_reg->off_38 &
+		(unsigned long long)MIP_VALID) !=3D 0) {
+			if (--spin <=3D 0) {
+				printk("es7000_mip_write: Timeout waiting for Host Valid Flag");
+				return -1;
+			}
+		es7000_spin(MIP_SPIN);
+	}
+
+	memcpy(host_reg, mip_reg, sizeof(struct mip_reg));
+	outb(1, mip_port);
+
+	spin =3D MIP_SPIN;
+
+	while (((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)MIP_VALID) =3D=3D 0) {
+		if (--spin <=3D 0) {
+			printk("es7000_mip_write: Timeout waiting for MIP Valid Flag");
+			return -1;
+		}
+		es7000_spin(MIP_SPIN);
+	}
+
+	status =3D ((unsigned long long)mip_reg->off_0 &
+		(unsigned long long)0xffff0000000000) >> 48;
+	mip_reg->off_38 =3D ((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)~MIP_VALID);
+	return status;
+}
+
+int=20
+es7000_start_cpu(int cpu, unsigned long eip)
+{
+	unsigned long vect =3D 0, psaival =3D 0;
+
+	if (psai =3D=3D NULL)
+		return -1;
+
+	vect =3D ((unsigned long)__pa(eip)/0x1000) << 16;
+	psaival =3D (0x1000000 | vect | cpu);
+
+	while (*psai & 0x1000000)
+                ;
+
+	*psai =3D psaival;
+
+	return 0;
+
+}
+
+int=20
+es7000_stop_cpu(int cpu)
+{
+	int startup;
+
+	if (psai =3D=3D NULL)
+		return -1;
+
+	startup=3D (0x1000000 | cpu);
+
+	while ((*psai & 0xff00ffff) !=3D startup)
+		;
+
+	startup =3D (*psai & 0xff0000) >> 16;
+	*psai &=3D 0xffffff;
+
+	return 0;
+
+}
+
+void __init
+es7000_sw_apic()
+{
+	if (es7000_plat) {
+		int mip_status;
+		struct mip_reg es7000_mip_reg;
+
+		printk("ES7000: Enabling APIC mode.\n");
+        	memset(&es7000_mip_reg, 0, sizeof(struct mip_reg));
+        	es7000_mip_reg.off_0 =3D MIP_SW_APIC;
+        	es7000_mip_reg.off_38 =3D (MIP_VALID);
+        	while ((mip_status =3D es7000_mip_write(&es7000_mip_reg)) =
!=3D 0)
+              		printk("es7000_sw_apic: command failed, status =3D =
%x\n",=20
+				mip_status);
+		return;
+	}
+}
diff -Naur linux-2.5.70/arch/i386/mach-es7000/es7000.h =
linux70-nbp/arch/i386/mach-es7000/es7000.h
--- linux-2.5.70/arch/i386/mach-es7000/es7000.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/es7000.h	2003-06-10 =
04:43:09.000000000 -0600
@@ -0,0 +1,109 @@
+/*
+ * Written by: Garry Forsgren, Unisys Corporation
+ *             Natalie Protasevich, Unisys Corporation
+ * This file contains the code to configure and interface=20
+ * with Unisys ES7000 series hardware system manager.
+ *
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or =
modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, =
but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License =
along
+ * with this program; if not, write the Free Software Foundation, =
Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Unisys Corporation, Township Line & Union =
Meeting=20
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
+ *
+ * http://www.unisys.com
+ */
+
+#define	MIP_REG			1
+#define	MIP_PSAI_REG		4
+
+#define	MIP_BUSY		1
+#define	MIP_SPIN		0xf0000
+#define	MIP_VALID		0x0100000000000000
+
+#define	MIP_RD_LO(VALUE)	(VALUE & 0xffffffff)  =20
+
+struct mip_reg_info {
+	unsigned long long mip_info;
+	unsigned long long delivery_info;
+	unsigned long long host_reg;
+	unsigned long long mip_reg;
+};
+
+struct part_info {
+	unsigned char type;  =20
+	unsigned char length;
+	unsigned char part_id;
+	unsigned char apic_mode;
+	unsigned long snum;   =20
+	char ptype[16];
+	char sname[64];
+	char pname[64];
+};
+
+struct psai {
+	unsigned long long entry_type;
+	unsigned long long addr;
+	unsigned long long bep_addr;
+};
+
+struct es7000_mem_info {
+	unsigned char type;  =20
+	unsigned char length;
+	unsigned char resv[6];
+	unsigned long long  start;=20
+	unsigned long long  size;=20
+};
+
+struct es7000_oem_table {
+	unsigned long long hdr;
+	struct mip_reg_info mip;
+	struct part_info pif;
+	struct es7000_mem_info shm;
+	struct psai psai;
+};
+
+struct acpi_table_sdt {
+	unsigned long pa;
+	unsigned long count;
+	struct {
+		unsigned long pa;
+		enum acpi_table_id id;
+		unsigned long size;
+	}	entry[50];
+};
+
+struct oem_table {
+	struct acpi_table_header Header;
+	u32 OEMTableAddr;
+	u32 OEMTableSize;
+};
+
+struct mip_reg {
+	unsigned long long off_0;
+	unsigned long long off_8;
+	unsigned long long off_10;
+	unsigned long long off_18;
+	unsigned long long off_20;
+	unsigned long long off_28;
+	unsigned long long off_30;
+	unsigned long long off_38;
+};
+
+#define	MIP_SW_APIC		0x1020b
+#define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
+
+extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);
+extern int es7000_start_cpu(int cpu, unsigned long eip);
+extern void es7000_sw_apic(void);
diff -Naur linux-2.5.70/arch/i386/mach-es7000/setup.c =
linux70-nbp/arch/i386/mach-es7000/setup.c
--- linux-2.5.70/arch/i386/mach-es7000/setup.c	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/setup.c	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,105 @@
+/*
+ *	Machine specific setup for es7000
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt =
vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq2 =3D { no_action, 0, 0, "cascade", NULL, =
NULL};
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine =
rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+	setup_irq(2, &irq2);
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() =
execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to =
initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  =3D { timer_interrupt, SA_INTERRUPT, 0, =
"timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system =
timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ =
listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
+#ifdef CONFIG_MCA
+/**
+ * mca_nmi_hook - hook into MCA specific NMI chain
+ *
+ * Description:
+ *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
+ *	along the MCA bus.  Use this to hook into that chain if you will =
need
+ *	it.
+ **/
+void __init mca_nmi_hook(void)
+{
+	/* If I recall correctly, there's a whole bunch of other things that
+	 * we can do to check for NMI problems, but that's all I know about
+	 * at the moment.
+	 */
+
+	printk("NMI generated from unknown source!\n");
+}
+
+#endif
diff -Naur linux-2.5.70/arch/i386/mach-es7000/topology.c =
linux70-nbp/arch/i386/mach-es7000/topology.c
--- linux-2.5.70/arch/i386/mach-es7000/topology.c	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/arch/i386/mach-es7000/topology.c	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,68 @@
+/*
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology =
information
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.         =20
+ *
+ * This program is free software; you can redistribute it and/or =
modify
+ * it under the terms of the GNU General Public License as published =
by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+#include <asm/memblk.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i =3D 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i =3D 0; i < num_online_memblks(); i++)
+		arch_register_memblk(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
diff -Naur linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h =
linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-bigsmp/mach_apic.h	2003-05-26 =
19:00:58.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-bigsmp/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -123,6 +123,10 @@
 {
 }
=20
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline int check_phys_apicid_present(int =
boot_cpu_physical_apicid)
 {
 	return (1);
diff -Naur linux-2.5.70/include/asm-i386/mach-default/mach_apic.h =
linux70-nbp/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-default/mach_apic.h	2003-05-26 =
19:01:02.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-default/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -118,4 +118,8 @@
 	return cpumask;
 }
=20
+static inline void enable_apic_mode(void)
+{
+}
+
 #endif /* __ASM_MACH_APIC_H */
--- linux-2.5.70/include/asm-i386/mach-summit/mach_apic.h	2003-05-26 =
19:00:42.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-summit/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -136,6 +136,10 @@
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
=20
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
 	int num_bits_set;
diff -Naur linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h =
linux70-nbp/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-visws/mach_apic.h	2003-05-26 =
19:00:20.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-visws/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -72,6 +72,10 @@
 {
 }
=20
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline int check_phys_apicid_present(int =
boot_cpu_physical_apicid)
 {
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
diff -Naur linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h =
linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-numaq/mach_apic.h	2003-05-26 =
19:00:39.000000000 -0600
+++ linux70-nbp/include/asm-i386/mach-numaq/mach_apic.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -107,6 +107,10 @@
 	return (1);
 }
=20
+static inline void enable_apic_mode(void)
+{
+}
+
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
 	int num_bits_set;
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apic.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apic.h	2003-06-09 =
10:12:33.000000000 -0600
@@ -0,0 +1,189 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+extern u8 bios_cpu_apicid[];
+
+#define xapic_phys_to_log_apicid(cpu) (bios_cpu_apicid[cpu])
+#define esr_disable (1)
+
+static inline int apic_id_registered(void)
+{
+	        return (1);
+}
+
+static inline unsigned long target_cpus(void)
+{=20
+#if defined CONFIG_ES7000_CLUSTERED_APIC
+	return (0xff);
+#else
+	return (bios_cpu_apicid[smp_processor_id()]);
+#endif
+}
+#define TARGET_CPUS	(target_cpus())
+
+#if defined CONFIG_ES7000_CLUSTERED_APIC
+#define APIC_DFR_VALUE		(APIC_DFR_CLUSTER)
+#define INT_DELIVERY_MODE	(dest_LowestPrio)
+#define INT_DEST_MODE		(1)    /* logical delivery broadcast to all =
procs */
+#define NO_BALANCE_IRQ 		(1)
+#undef  WAKE_SECONDARY_VIA_INIT
+#define WAKE_SECONDARY_VIA_MIP
+#else
+#define APIC_DFR_VALUE		(APIC_DFR_FLAT)
+#define INT_DELIVERY_MODE	(dest_Fixed)
+#define INT_DEST_MODE		(0)    /* phys delivery to target procs */
+#define NO_BALANCE_IRQ 		(0)
+#undef  APIC_DEST_LOGICAL
+#define APIC_DEST_LOGICAL	0x0
+#define WAKE_SECONDARY_VIA_INIT
+#endif
+
+#define APIC_BROADCAST_ID	(0xff)
+
+static inline unsigned long check_apicid_used(unsigned long bitmap, =
int apicid)=20
+{=20
+	return 0;
+}=20
+static inline unsigned long check_apicid_present(int bit)=20
+{
+	return (phys_cpu_present_map & (1 << bit));
+}
+
+#define apicid_cluster(apicid) (apicid & 0xF0)
+
+static inline unsigned long calculate_ldr(int cpu)
+{
+	unsigned long id;
+	id =3D xapic_phys_to_log_apicid(cpu);
+	return (SET_APIC_LOGICAL_ID(id));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LdR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+	int cpu =3D smp_processor_id();
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val =3D calculate_ldr(cpu);
+	apic_write_around(APIC_LDR, val);
+}
+
+extern void es7000_sw_apic(void);
+static inline void enable_apic_mode(void)
+{
+	es7000_sw_apic();
+	return;
+}
+
+extern int apic_version [MAX_APICS];
+static inline void clustered_apic_check(void)
+{
+	int apic =3D bios_cpu_apicid[smp_processor_id()];
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus =
%lx\n",
+		(apic_version[apic] =3D=3D 0x14) ?=20
+		"Physical Cluster" : "Logical Cluster", nr_ioapics, TARGET_CPUS);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
+}
+
+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (!mps_cpu)
+		return boot_cpu_physical_apicid;
+	else
+		return (int) bios_cpu_apicid[mps_cpu];
+}
+
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)
+{
+	static int cpu =3D 0;
+	return (1ul << cpu++);
+}
+
+extern volatile u8 cpu_2_logical_apicid[];
+/* Mapping from cpu number to logical apicid */
+static inline int cpu_to_logical_apicid(int cpu)
+{
+       return (int)cpu_2_logical_apicid[cpu];
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int =
quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+	        m->mpc_apicid,
+	        (m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+	        (m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+	        m->mpc_apicver);
+	return (m->mpc_apicid);
+}
+
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* For clustered we don't have a good way to do this yet - hack */
+	return (0xff);
+}
+
+
+static inline void setup_portio_remap(void)
+{
+}
+
+extern unsigned int boot_cpu_physical_apicid;
+static inline int check_phys_apicid_present(int cpu_physical_apicid)
+{
+	boot_cpu_physical_apicid =3D GET_APIC_ID(apic_read(APIC_ID));
+	return (1);
+}
+
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	int num_bits_set;
+	int cpus_found =3D 0;
+	int cpu;
+	int apicid;=09
+
+	if (cpumask =3D=3D TARGET_CPUS)
+		return cpumask;
+	num_bits_set =3D hweight32(cpumask);=20
+	/* Return id to all */
+	if (num_bits_set =3D=3D 32)
+		return TARGET_CPUS;
+	/*=20
+	 * The cpus in the mask must all be on the apic cluster.  If are not=20
+	 * on the same apicid cluster return default value of TARGET_CPUS.=20
+	 */
+	cpu =3D ffs(cpumask)-1;
+	apicid =3D cpu_to_logical_apicid(cpu);
+	while (cpus_found < num_bits_set) {
+		if (cpumask & (1 << cpu)) {
+			int new_apicid =3D cpu_to_logical_apicid(cpu);
+			if (apicid_cluster(apicid) !=3D=20
+					apicid_cluster(new_apicid)){
+				printk ("%s: Not a valid mask!\n",__FUNCTION__);
+				return TARGET_CPUS;
+			}
+			apicid =3D new_apicid;
+			cpus_found++;
+		}
+		cpu++;
+	}
+	return apicid;
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_apicdef.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_apicdef.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define		APIC_ID_MASK		(0xFF<<24)
+
+static inline unsigned get_apic_id(unsigned long x)=20
+{=20
+	return (((x)>>24)&0xFF);
+}=20
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+#endif
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_ipi.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_ipi.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	unsigned long mask =3D cpu_online_map & ~(1 << smp_processor_id());
+
+	if (mask)
+		send_IPI_mask(mask, vector);
+}
+
+static inline void send_IPI_all(int vector)
+{
+	send_IPI_mask(cpu_online_map, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpparse.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpparse.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,38 @@
+#ifndef __ASM_MACH_MPPARSE_H
+#define __ASM_MACH_MPPARSE_H
+
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char =
*name,=20
+				struct mpc_config_translation *translation)
+{
+	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
+}
+
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m,=20
+				struct mpc_config_translation *translation)
+{
+}
+
+extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);
+
+static inline void mps_oem_check(struct mp_config_table *mpc, char =
*oem,=20
+		char *productid)
+{
+	if (mpc->mpc_oemptr) {
+		struct mp_config_oemtable *oem_table =3D=20
+			(struct mp_config_oemtable *)mpc->mpc_oemptr;
+		parse_unisys_oem((char *)oem_table, oem_table->oem_length);
+	}
+}
+
+/* Hook from generic ACPI tables.c */
+static inline void acpi_madt_oem_check(char *oem_id, char =
*oem_table_id)
+{
+	unsigned long oem_addr;=20
+	int oem_entries;
+	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))
+		parse_unisys_oem((char *)oem_addr, oem_entries);
+}
+
+
+#endif /* __ASM_MACH_MPPARSE_H */
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_mpspec.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_mpspec.h	2003-06-09 =
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
diff -Naur linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h =
linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h
--- linux-2.5.70/include/asm-i386/mach-es7000/mach_wakecpu.h	1969-12-31 =
17:00:00.000000000 -0700
+++ linux70-nbp/include/asm-i386/mach-es7000/mach_wakecpu.h	2003-06-09 =
10:11:25.000000000 -0600
@@ -0,0 +1,58 @@
+#ifndef __ASM_MACH_WAKECPU_H
+#define __ASM_MACH_WAKECPU_H
+
+/*=20
+ * This file copes with machines that wakeup secondary CPUs by the
+ * INIT, INIT, STARTUP sequence.
+ */
+
+#ifdef CONFIG_ES7000_CLUSTERED_APIC
+#define WAKE_SECONDARY_VIA_MIP
+#else
+#define WAKE_SECONDARY_VIA_INIT
+#endif
+
+#ifdef WAKE_SECONDARY_VIA_MIP
+extern int es7000_start_cpu(int cpu, unsigned long eip);
+static inline int
+wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)
+{
+	int boot_error =3D 0;
+	boot_error =3D es7000_start_cpu(phys_apicid, start_eip);
+	return boot_error;
+}
+#endif
+
+#define TRAMPOLINE_LOW phys_to_virt(0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(0x469)
+
+#define boot_cpu_apicid boot_cpu_physical_apicid
+
+static inline void wait_for_init_deassert(atomic_t *deassert)
+{
+#ifdef WAKE_SECONDARY_VIA_INIT
+	while (!atomic_read(deassert));
+#endif
+	return;
+}
+
+/* Nothing to do for most platforms, since cleared by the INIT cycle =
*/
+static inline void smp_callin_clear_local_apic(void)
+{
+}
+
+static inline void store_NMI_vector(unsigned short *high, unsigned =
short *low)
+{
+}
+
+static inline void restore_NMI_vector(unsigned short *high, unsigned =
short *low)
+{
+}
+
+#if APIC_DEBUG
+ #define inquire_remote_apic(apicid) __inquire_remote_apic(apicid)
+#else
+ #define inquire_remote_apic(apicid) {}
+#endif
+
+#endif /* __ASM_MACH_WAKECPU_H */

------_=_NextPart_000_01C3301F.418F6C86--
