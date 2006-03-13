Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWCMSGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCMSGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCMSGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:06:06 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:28940 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932220AbWCMSGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:06:02 -0500
Date: Mon, 13 Mar 2006 10:05:58 -0800
Message-Id: <200603131805.k2DI5wlO005693@zach-dev.vmware.com>
Subject: [RFC, PATCH 9/24] i386 Vmi smp support
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:05:58.0569 (UTC) FILETIME=[C7C61990:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP bootstrapping support.  Just as in the physical platform model,
the BSP is responsible for initializing the AP state prior to execution.
The dependence on lots of processor state information is a design choice
of our implementation.  Conceivably, this could be a hypercall that
awakens the same start of day state on APs as on the BSP.

It is likely the AP startup and the start-of-day model will eventually
merge into a more common interface.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Daniel Arai <arai@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/Makefile	2006-03-08 11:01:45.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile	2006-03-08 11:02:43.000000000 -0800
@@ -6,4 +6,4 @@ EXTRA_CFLAGS	+= -I../kernel
 
 export CFLAGS_stubs.o += -ffunction-sections
 
-obj-y				:= setup.o stubs.o stubs-asm.o
+obj-y	:= setup.o stubs.o stubs-asm.o smpboot_hooks.o
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/smpboot_hooks.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/smpboot_hooks.c	2006-03-08 11:02:12.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/smpboot_hooks.c	2006-03-08 11:02:16.000000000 -0800
@@ -0,0 +1,135 @@
+/*
+ * Special hooks for smpboot.c, needed for vmi.
+ *
+ * Copyright (C) 2005, VMware, Inc.
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
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <asm/acpi.h>
+#include <asm/arch_hooks.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+#include <asm/io.h>
+#include <asm/highmem.h>
+#include <asm/pgtable.h>
+#include <vmi.h>
+
+extern long boot_gdt_table;
+extern struct desc_struct idt_table[256];
+extern unsigned char *trampoline_base;
+
+#ifdef CONFIG_SMP
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define DEFAULT_SEND_IPI	(1)
+#else
+#define DEFAULT_SEND_IPI	(0)
+#endif
+
+int no_broadcast=DEFAULT_SEND_IPI;
+
+APState ap;
+
+void __init
+smpboot_startup_ipi_hook(int phys_apicid, unsigned long start_eip,
+                         unsigned long start_esp)
+{
+        /* We require phys_acpicid to be the cpu number. */
+        if (hypervisor_found) {
+                /* Default everything to zero.  This is fine for most GPRs. */
+                memset(&ap, 0, sizeof(APState));
+
+                /* Set up AP's per-cpu GDT. */
+                memcpy(get_cpu_gdt_table(phys_apicid), cpu_gdt_table,
+                       GDT_SIZE);
+                ap.gdtr_limit = GDT_SIZE - 1;
+                ap.gdtr_base = (unsigned long) get_cpu_gdt_table(phys_apicid);
+                
+                ap.idtr_limit = IDT_ENTRIES * 8 - 1;
+                ap.idtr_base = (unsigned long) idt_table;
+
+                ap.ldtr = 0;
+                
+                ap.cs = __KERNEL_CS;
+                ap.eip = (unsigned long) start_eip;
+                ap.ss = __KERNEL_DS;
+                ap.esp = (unsigned long) start_esp;
+                
+                ap.ds = __USER_DS;
+                ap.es = __USER_DS;
+                ap.fs = 0;
+                ap.gs = 0;
+                
+                ap.eflags = 0;
+                
+#ifdef CONFIG_X86_PAE
+                /* efer should match BSP efer. */
+                if (cpu_has_nx) {
+                        unsigned l, h;
+                        rdmsr(MSR_EFER, l, h);
+                        ap.efer = (unsigned long long) h << 32 | l;
+                }
+#endif
+
+                ap.cr3 = __pa(swapper_pg_dir);
+                /* Protected mode, paging, AM, WP, NE, MP. */
+                ap.cr0 = 0x80050023;
+                ap.cr4 = mmu_cr4_features;
+                
+                vmi_set_initial_ap_state(__pa(&ap), phys_apicid);
+        }
+}
+
+void __init smpboot_pre_start_secondary_hook(void)
+{
+        if (vmi_hypervisor_found()) {
+                *(unsigned long *) trampoline_base = 0xa5a5a5a5;
+        }
+}
+
+static __init int no_ipi_broadcast(char *str)
+{
+	get_option(&str, &no_broadcast);
+	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
+											"IPI Broadcast");
+	return 1;
+}
+
+__setup("no_ipi_broadcast", no_ipi_broadcast);
+
+static int __init print_ipi_mode(void)
+{
+	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
+											"Shortcut");
+	return 0;
+}
+
+late_initcall(print_ipi_mode);
+#endif
+
Index: linux-2.6.16-rc5/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/smpboot.c	2006-03-08 10:53:46.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/smpboot.c	2006-03-08 11:02:16.000000000 -0800
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(x86_cpu_to_apicid);
 
 extern unsigned char trampoline_data [];
 extern unsigned char trampoline_end  [];
-static unsigned char *trampoline_base;
+unsigned char *trampoline_base;
 static int trampoline_exec;
 
 static void map_cpu_to_logical_apicid(void);
@@ -507,6 +507,7 @@ static void __devinit start_secondary(vo
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
+	smpboot_pre_start_secondary_hook();
 	cpu_init();
 	preempt_disable();
 	smp_callin();
@@ -782,6 +783,10 @@ wakeup_secondary_cpu(int phys_apicid, un
 	else
 		num_starts = 0;
 
+	smpboot_startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
+		(unsigned long) stack_start.esp);
+
+
 	/*
 	 * Run STARTUP IPI loop.
 	 */
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/smpboot_hooks.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/smpboot_hooks.h	2006-03-08 10:53:46.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/smpboot_hooks.h	2006-03-08 11:02:16.000000000 -0800
@@ -42,3 +42,15 @@ static inline void smpboot_setup_io_apic
 	if (!skip_ioapic_setup && nr_ioapics)
 		setup_IO_APIC();
 }
+
+static inline void smpboot_startup_ipi_hook(int phys_apicid, 
+                                            unsigned long start_eip,
+                                            unsigned long start_esp)
+{
+
+}
+
+static inline void smpboot_pre_start_secondary_hook(void)
+{
+
+}
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/smpboot_hooks.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/smpboot_hooks.h	2006-03-08 11:02:12.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/smpboot_hooks.h	2006-03-08 11:02:16.000000000 -0800
@@ -0,0 +1,51 @@
+/* 
+ * include/asm-i386/mach-default/smpboot_hooks.h
+ *
+ * Portions Copyright 2005 VMware, Inc.
+ */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+}
+
+static inline void smpboot_restore_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	CMOS_WRITE(0, 0xf);
+
+	*((volatile long *) phys_to_virt(0x467)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
+
+extern void smpboot_startup_ipi_hook(int phys_apicid, unsigned long start_eip,
+                             unsigned long start_esp);
+extern void smpboot_pre_start_secondary_hook(void);
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/entry_arch.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/entry_arch.h	2006-03-08 11:02:12.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/entry_arch.h	2006-03-08 11:02:16.000000000 -0800
@@ -0,0 +1,34 @@
+/*
+ * This file is designed to contain the BUILD_INTERRUPT specifications for
+ * all of the extra named interrupt vectors used by the architecture.
+ * Usually this is the Inter Process Interrupts (IPIs)
+ */
+
+/*
+ * The following vectors are part of the Linux architecture, there
+ * is no hardware IRQ pin equivalent for them, they are triggered
+ * through the ICC by us (IPIs)
+ */
+#ifdef CONFIG_X86_SMP
+BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
+BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
+BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#endif
+
+/*
+ * every pentium local APIC has two 'local interrupts', with a
+ * soft-definable vector attached to both interrupts, one of
+ * which is a timer interrupt, the other one is error counter
+ * overflow. Linux uses the local APIC timer interrupt to get
+ * a much simpler SMP time architecture:
+ */
+#ifdef CONFIG_X86_LOCAL_APIC
+BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
+#endif
+
+#endif
