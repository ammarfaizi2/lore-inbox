Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVA1Njo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVA1Njo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVA1Njo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:39:44 -0500
Received: from mail.suse.de ([195.135.220.2]:51425 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261342AbVA1Nj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:39:29 -0500
Date: Fri, 28 Jan 2005 14:39:27 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Message-ID: <20050128133927.GC6703@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a new CONFIG_X86_APIC_OFF option. This is useful
for distribution UP kernels who should run with local APIC off by
default (because older machines often have broken mptables etc.).

But there are a few machines who don't boot with apic off so there
needs to be an command line option to enable it.

When X86_APIC_OFF is set the APIC code is compiled in, but is 
only enabled when "apic" or "lapic" is specified on the command line
(or a DMI scanner force enables it).

The option can be only enabled for UP kernels, for SMP
it doesn't make much sense to disable the local APICs.

In addition there are some bugfixes in there to fix problems
in the no APIC error handling paths.  In particular try to clear
the APIC flag more often and clear nr_ioapics when the local
APIC doesn't work. 

It's unfortunately still not quite correct for ACPI in the 
case when X86_APIC_OFF is not set - in case ACPI finds APICs
in the MADT, but enabling it fails later for some reason the ACPI
state will be all messed up. Fixing that was a bit too complicated,
I leave that to the ACPI maintainers and only added a comment
(it should be relatively unlikely to happen) 

I also disabled some (IMHO) not so useful debugging printks
in the APIC and subarch code because it looked a bit weird when there
were lots of messages talking about APICs when all the APICs
were actually disabled.

It needs some minor changes to x86-64 too because the ACPI boot
code is shared.

Variants of this patch have been shipped by SUSE for a long time.
I believe the original patch came from Kurt Garloff.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux/include/asm-i386/mach-default/mach_apic.h-o linux/include/asm-i386/mach-default/mach_apic.h
--- linux/include/asm-i386/mach-default/mach_apic.h-o	2004-08-15 19:45:46.000000000 +0200
+++ linux/include/asm-i386/mach-default/mach_apic.h	2005-01-28 13:43:48.000000000 +0100
@@ -58,8 +58,6 @@
 
 static inline void clustered_apic_check(void)
 {
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-					"Flat", nr_ioapics);
 }
 
 static inline int multi_timer_check(int apic, int irq)
diff -u linux/include/asm-i386/apic.h-o linux/include/asm-i386/apic.h
--- linux/include/asm-i386/apic.h-o	2005-01-04 12:13:21.000000000 +0100
+++ linux/include/asm-i386/apic.h	2005-01-28 12:29:16.000000000 +0100
@@ -118,6 +118,10 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+extern int lapic_disable(char *str);
+extern int lapic_enable(char *str);
+extern int enable_local_apic;
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 
diff -u linux/arch/i386/kernel/acpi/boot.c-o linux/arch/i386/kernel/acpi/boot.c
--- linux/arch/i386/kernel/acpi/boot.c-o	2005-01-28 12:22:43.000000000 +0100
+++ linux/arch/i386/kernel/acpi/boot.c	2005-01-28 13:07:27.000000000 +0100
@@ -774,6 +774,18 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 	int count, error;
 
+	/* 
+	 * Warning, broken error handling here.
+	 * When X86_APIC_OFF is not set and the APIC initialization
+	 * later fails then the ACPI state will be all messed up.
+	 */
+#ifdef CONFIG_X86_APIC_OFF
+	if (enable_local_apic <= 0) { 
+		printk(KERN_INFO "ACPI: local apic disabled\n");
+		return;
+	}
+#endif	   
+
 	count = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
 	if (count >= 1) {
 
diff -u linux/arch/i386/kernel/io_apic.c-o linux/arch/i386/kernel/io_apic.c
--- linux/arch/i386/kernel/io_apic.c-o	2005-01-28 12:23:33.000000000 +0100
+++ linux/arch/i386/kernel/io_apic.c	2005-01-28 13:28:49.000000000 +0100
@@ -690,7 +690,8 @@
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-int skip_ioapic_setup;
+
+int skip_ioapic_setup = 0;
 
 static int __init ioapic_setup(char *str)
 {
diff -u linux/arch/i386/kernel/apic.c-o linux/arch/i386/kernel/apic.c
--- linux/arch/i386/kernel/apic.c-o	2005-01-28 12:23:32.000000000 +0100
+++ linux/arch/i386/kernel/apic.c	2005-01-28 13:33:30.000000000 +0100
@@ -669,9 +669,10 @@
 /*
  * Knob to control our willingness to enable the local APIC.
  */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+int enable_local_apic __initdata = 0;
 
-static int __init lapic_disable(char *str)
+/* These two are early parsed too */
+int __init lapic_disable(char *str)
 {
 	enable_local_apic = -1;
 	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
@@ -679,7 +680,7 @@
 }
 __setup("nolapic", lapic_disable);
 
-static int __init lapic_enable(char *str)
+int __init lapic_enable(char *str)
 {
 	enable_local_apic = 1;
 	return 0;
@@ -688,7 +689,11 @@
 
 static int __init apic_set_verbosity(char *str)
 {
-	if (strcmp("debug", str) == 0)
+	if (*str == '=') 
+		str++;
+	if (*str == 0) {
+		/* parsed early already */ 
+	} else if (strcmp("debug", str) == 0)
 		apic_verbosity = APIC_DEBUG;
 	else if (strcmp("verbose", str) == 0)
 		apic_verbosity = APIC_VERBOSE;
@@ -699,16 +704,21 @@
 	return 0;
 }
 
-__setup("apic=", apic_set_verbosity);
+__setup("apic", apic_set_verbosity);
 
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
+#ifdef CONFIG_X86_APIC_OFF
+	if (enable_local_apic < 1) 
+		return -1; 
+#else
 	/* Disabled by kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
+#endif
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
@@ -800,8 +810,6 @@
 		apic_phys = mp_lapic_addr;
 
 	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
-	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
-	       apic_phys);
 
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
@@ -834,8 +842,6 @@
 				ioapic_phys = __pa(ioapic_phys);
 			}
 			set_fixmap_nocache(idx, ioapic_phys);
-			printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
-			       __fix_to_virt(idx), ioapic_phys);
 			idx++;
 		}
 	}
@@ -1243,11 +1249,21 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
+#ifdef CONFIG_X86_APIC_OFF
+	if (enable_local_apic <= 0) { 
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+		nr_ioapics = 0;
+		return -1;
+	}
+#endif
+
 	if (enable_local_apic < 0)
 		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 
-	if (!smp_found_config && !cpu_has_apic)
+	if (!smp_found_config && !cpu_has_apic) { 
+		nr_ioapics = 0;
 		return -1;
+	}
 
 	/*
 	 * Complain if the BIOS pretends there is one.
@@ -1255,6 +1271,8 @@
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_physical_apicid);
+		nr_ioapics = 0;
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 		return -1;
 	}
 
diff -u linux/arch/i386/kernel/setup.c-o linux/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c-o	2005-01-28 12:23:49.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2005-01-28 12:45:23.000000000 +0100
@@ -49,6 +49,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/apic.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -809,8 +810,14 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* disable IO-APIC */
-		else if (!memcmp(from, "noapic", 6))
+		else if (c == ' ' && !memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
+		else if (c == ' ' && !memcmp(from, "apic", 4))
+		        lapic_enable(from+4);
+		else if (c == ' ' && !memcmp(from, "lapic", 5))
+		        lapic_enable(from+7);
+		else if (c == ' ' && !memcmp(from, "nolapic", 7))
+		        lapic_disable(from+7);
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
diff -u linux/arch/i386/kernel/mpparse.c-o linux/arch/i386/kernel/mpparse.c
diff -u linux/arch/i386/Kconfig-o linux/arch/i386/Kconfig
--- linux/arch/i386/Kconfig-o	2005-01-28 12:22:43.000000000 +0100
+++ linux/arch/i386/Kconfig	2005-01-28 12:29:16.000000000 +0100
@@ -563,6 +563,15 @@
 	depends on !SMP && X86_UP_APIC
 	default y
 
+config X86_APIC_OFF
+        bool "Disable local/IO APIC by default" 
+	depends on X86_LOCAL_APIC 
+	default n
+	help
+	  When this option is enabled the IO/local APIC code is compiled in, but 
+	  only enabled when the kernel is booted with "apic" on the kernel 
+	  command line  or an DMI entry forced APIC mode. 
+
 config X86_IO_APIC
 	bool
 	depends on !SMP && X86_UP_IOAPIC
diff -u linux/arch/x86_64/kernel/apic.c-o linux/arch/x86_64/kernel/apic.c
--- linux/arch/x86_64/kernel/apic.c-o	2005-01-28 12:22:44.000000000 +0100
+++ linux/arch/x86_64/kernel/apic.c	2005-01-28 12:29:16.000000000 +0100
@@ -1023,6 +1023,8 @@
 }
 
 int disable_apic; 
+/* just used to communicate with shared i386 code: */
+int enable_local_apic = 1; 
 
 /*
  * This initializes the IO-APIC and APIC hardware if this is
@@ -1036,6 +1038,7 @@
 	}
 	if (!cpu_has_apic) { 
 		disable_apic = 1;
+		enable_local_apic = -1; 
 		printk(KERN_INFO "Apic disabled by BIOS\n");
 		return -1;
 	}
@@ -1062,12 +1065,14 @@
 
 static __init int setup_disableapic(char *str) 
 { 
+	enable_local_apic = -1;
 	disable_apic = 1;
 	return 0;
 } 
 
 static __init int setup_nolapic(char *str) 
 { 
+	enable_local_apic = -1;
 	disable_apic = 1;
 	return 0;
 } 
diff -u linux/Documentation/kernel-parameters.txt-o linux/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt-o	2005-01-28 12:23:52.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2005-01-28 12:29:16.000000000 +0100
@@ -214,6 +214,12 @@
 	apm=		[APM] Advanced Power Management
 			See header of arch/i386/kernel/apm.c.
 
+	apic		[UP,APIC] Tells the kernel to make use of the APIC on
+	                uniprocessor systems. When CONFIG_X86_APIC_OFF is set it 
+			needs this parameter to really activate it (needed to 
+			avoid problems with certain machines). This enables IO 
+			and local APICs.
+ 
 	applicom=	[HW]
 			Format: <mem>,<irq>
  
