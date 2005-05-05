Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVEFRQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEFRQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVEFRQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 13:16:02 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:17536 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S261221AbVEFRPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 13:15:41 -0400
Subject: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Thu, 05 May 2005 15:11:16 -0700
Message-Id: <20050505221117.508BB42AE4@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch disables unique IO_APIC_ID check for xAPIC systems running in EM64T mode. Xeon-based ES7000s panic failing this unnecessary check. I added IOAPIC_ID_CHECK config option and turned it off for Intel processors. Also added the boot option that overrides default and turnes this check on/off in case it is needed for some reason. Hope this is acceptable way to fix the problem.

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/x86_64/kernel/setup.c~no-ioapic-check-x86_64 arch/x86_64/kernel/setup.c
--- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/setup.c~no-ioapic-check-x86_64	2005-05-05 02:41:58.664407056 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/x86_64/kernel/setup.c	2005-05-05 03:18:57.728058104 -0700
@@ -346,6 +346,9 @@ static __init void parse_cmdline_early (
 			ioapic_force = 1;
 		}
 			
+		if (!memcmp(from, "ioapic_id_check=", 16))
+			ioapic_id_check_setup(from+16);
+
 		if (!memcmp(from, "mem=", 4))
 			parse_memopt(from+4, &from); 
 
@@ -547,6 +550,9 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = virt_to_phys(&_etext);
 	data_resource.end = virt_to_phys(&_edata)-1;
 
+#ifdef CONFIG_NO_IOAPIC_CHECK
+	skip_ioapic_id_check = 1;
+#endif
 	parse_cmdline_early(cmdline_p);
 
 	early_identify_cpu(&boot_cpu_data);
diff -puN arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64 arch/x86_64/kernel/io_apic.c
--- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64	2005-05-05 02:41:58.718398848 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/x86_64/kernel/io_apic.c	2005-05-05 03:15:45.511279496 -0700
@@ -216,6 +216,7 @@ static void clear_IO_APIC (void)
 static int pirq_entries [MAX_PIRQS];
 static int pirqs_enabled;
 int skip_ioapic_setup;
+int skip_ioapic_id_check;
 int ioapic_force;
 
 /* dummy parsing: see setup.c */
@@ -233,8 +234,19 @@ static int __init enable_ioapic_setup(ch
 	return 1;
 }
 
+int __init ioapic_id_check_setup(char *str)
+{
+	if (!strncmp(str, "on", 2)) {
+		skip_ioapic_id_check = 0;
+	} else if (!strncmp(str, "off", 3)) {
+		skip_ioapic_id_check = 1;
+	}
+	return 1;
+}
+
 __setup("noapic", disable_ioapic_setup);
 __setup("apic", enable_ioapic_setup);
+__setup("ioapic_id_check=", ioapic_id_check_setup);
 
 #include <asm/pci-direct.h>
 #include <linux/pci_ids.h>
@@ -1867,12 +1879,15 @@ int __init io_apic_get_unique_id (int io
 	int i = 0;
 
 	/*
+	 * P4-class systems take advantage of APIC system bus architecture.
+	 */
+
+	if (skip_ioapic_id_check)
+		return apic_id;
+	/*
 	 * The P4 platform supports up to 256 APIC IDs on two separate APIC 
 	 * buses (one for LAPICs, one for IOAPICs), where predecessors only 
 	 * supports up to 16 on one shared APIC bus.
-	 * 
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
 	 */
 
 	if (physids_empty(apic_id_map))
diff -puN arch/x86_64/Kconfig~no-ioapic-check-x86_64 arch/x86_64/Kconfig
--- linux-2.6.13-rc3-mm3/arch/x86_64/Kconfig~no-ioapic-check-x86_64	2005-05-05 02:41:58.752393680 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/x86_64/Kconfig	2005-05-05 02:46:11.027042104 -0700
@@ -163,6 +163,11 @@ config X86_IO_APIC
 	bool
 	default y
 
+config NO_IOAPIC_CHECK
+	bool
+	depends on GENERIC_CPU || MPSC
+	default y
+
 config X86_LOCAL_APIC
 	bool
 	default y
diff -puN include/asm-x86_64/io_apic.h~no-ioapic-check-x86_64 include/asm-x86_64/io_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-x86_64/io_apic.h~no-ioapic-check-x86_64	2005-05-05 03:22:43.026807488 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-x86_64/io_apic.h	2005-05-05 03:23:33.772093032 -0700
@@ -195,6 +195,9 @@ static inline void io_apic_sync(unsigned
 /* 1 if "noapic" boot option passed */
 extern int skip_ioapic_setup;
 
+/* 1 if "ioapic_id_check=off" boot option passed */
+extern int skip_ioapic_id_check;
+
 /*
  * If we use the IO-APIC for IRQ routing, disable automatic
  * assignment of PCI IRQ's.
diff -puN include/asm-x86_64/proto.h~no-ioapic-check-x86_64 include/asm-x86_64/proto.h
--- linux-2.6.13-rc3-mm3/include/asm-x86_64/proto.h~no-ioapic-check-x86_64	2005-05-05 03:22:43.060802320 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-x86_64/proto.h	2005-05-05 03:24:36.259593488 -0700
@@ -75,6 +75,7 @@ extern void syscall32_cpu_init(void);
 extern void setup_node_bootmem(int nodeid, unsigned long start, unsigned long end);
 
 extern void check_ioapic(void);
+extern int ioapic_id_check_setup(char *str);
 extern void check_efer(void);
 
 extern int unhandled_signal(struct task_struct *tsk, int sig);
@@ -93,6 +94,7 @@ extern int disable_apic;
 extern unsigned cpu_khz;
 extern int ioapic_force;
 extern int skip_ioapic_setup;
+extern int extern int skip_ioapic_id_check;
 extern int acpi_ht;
 extern int acpi_disabled;
 
_
