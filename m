Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWATBUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWATBUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWATBUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:20:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:12781 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030453AbWATBUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:20:49 -0500
Message-ID: <43D03AF0.3040703@us.ibm.com>
Date: Thu, 19 Jan 2006 17:20:48 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH] leave APIC code inactive by default on i386
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------010700070402050806070807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010700070402050806070807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi there,

Some old i386 systems have flaky APIC hardware that doesn't always work
right.  Right now, enabling the APIC code in Kconfig means that the APIC
code will try to activate the APICs unless 'noapic nolapic' are passed
to force them off.  The attached patch provides a config option to
change that default to keep the APICs off unless specified otherwise,
disables get_smp_config if we are not initializing the local APIC, and
makes init_apic_mappings not init the IOAPICs if they are disabled.
Note that the current behavior is maintained if
CONFIG_X86_UP_APIC_DEFAULT_OFF=n.

This patch is particularly useful for anybody booting a distro UP kernel
on a multi-chassis IBM x440/x445, because that system requires APIC
support to boot properly.  If booting a UP kernel on a large SMP machine
seems silly, think of distro installer kernels. :)  Joe Flakybox can run
his single-proc i386 box without APIC related breakage, and someone with
a x445 enable APICs in the UP kernel long enough to install a proper SMP
kernel.

Most everybody else in the world can configure their UP kernel with
CONFIG_APIC=y/n as desired and ignore this patch.

I know, it seems silly to be providing a patch that changes "enabled
unless explicitly disabled" to "disabled unless explicitly enabled",
especially since the APIC code can be forced off.  However, I _am_
curious to hear what people think about the other parts of the patch.
At the very least, I'm not quite convinced that noapic & nolapic are
doing their jobs, because it seems to me that get_smp_config pokes the
LAPIC and init_apic_mappings maps the IOAPICs into memory regardless of
whatever flags are passed.  But, I'm not an APIC expert so I'll defer to
anybody who knows more than I.  Most curiously, passing 'noapic nolapic'
still yields things like this in dmesg:

"Enabling APIC mode:  Flat.  Using 1 I/O APICs"

FWIW, this has been tested on a Sun V40z, IBM x205, x226, x206m, x445,
x260, x366, x225, x336 and a dual-node x460 without problems.  A similar
patch has been lurking in Redhat Rawhide kernels for several months
without problems.

Questions?  Flames?  The asbestos underpants have been strapped on. :)

--D

And the usual stamp for said patch:

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--------------010700070402050806070807
Content-Type: text/x-patch;
 name="iapic-kern_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iapic-kern_3.patch"

diff -Naurp a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2006-01-04 15:18:21.000000000 -0800
+++ b/arch/i386/Kconfig	2006-01-19 14:33:33.000000000 -0800
@@ -253,6 +253,20 @@ config X86_UP_IOAPIC
 	  to use it. If you say Y here even though your machine doesn't have
 	  an IO-APIC, then the kernel will still run with no slowdown at all.
 
+config X86_UP_APIC_DEFAULT_OFF
+	bool "APIC support on uniprocessors defaults to off"
+	depends on !SMP && X86_UP_APIC
+	help
+	  Some older systems have flaky APICs.  Say Y to keep leave the APICs
+	  disabled by default, while still allowing them to be enabled by the
+	  "lapic" (local APIC) and "apic" (I/O APIC) command line options.
+	  Generally speaking, either you want to enable both types of APICs
+	  or none at all.
+
+	  Usually this is only necessary for distro installer kernels that
+	  must work with everything.  Everyone else can safely say N here
+	  and configure APIC support in or out as needed.
+
 config X86_LOCAL_APIC
 	bool
 	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
diff -Naurp a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	2006-01-04 15:18:21.000000000 -0800
+++ b/arch/i386/kernel/acpi/boot.c	2006-01-19 14:17:50.000000000 -0800
@@ -37,6 +37,10 @@
 #include <asm/io.h>
 #include <asm/mpspec.h>
 
+#ifdef CONFIG_X86_32
+extern int enable_local_apic __initdata;
+#endif
+
 #ifdef	CONFIG_X86_64
 
 extern void __init clustered_apic_check(void);
@@ -807,6 +811,16 @@ static void __init acpi_process_madt(voi
 #ifdef CONFIG_X86_LOCAL_APIC
 	int count, error;
 
+#ifdef CONFIG_X86_32
+	if (enable_local_apic < 0) {
+		printk(KERN_INFO PREFIX "Local APIC disabled; pass 'lapic' "
+							"to re-enable.\n");
+		return;
+	}
+
+	printk(KERN_INFO PREFIX "Local APIC enabled.\n");
+#endif
+
 	count = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
 	if (count >= 1) {
 
diff -Naurp a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2006-01-04 15:18:21.000000000 -0800
+++ b/arch/i386/kernel/apic.c	2006-01-19 14:21:24.000000000 -0800
@@ -42,8 +42,9 @@
 
 /*
  * Knob to control our willingness to enable the local APIC.
+ * -2=default-disable, -1=force-disable, 1=force-enable, 0=automatic
  */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+int enable_local_apic __initdata = (X86_APIC_DEFAULT_OFF ? -2 : 0);
 
 /*
  * Debug level
@@ -757,7 +758,7 @@ static int __init detect_init_APIC (void
 		 * APIC only if "lapic" specified.
 		 */
 		if (enable_local_apic <= 0) {
-			printk("Local APIC disabled by BIOS -- "
+			printk("Local APIC disabled by BIOS (or by default) -- "
 			       "you can enable it with \"lapic\"\n");
 			return -1;
 		}
@@ -839,7 +840,7 @@ void __init init_apic_mappings(void)
 		int i;
 
 		for (i = 0; i < nr_ioapics; i++) {
-			if (smp_found_config) {
+			if (smp_found_config && !skip_ioapic_setup) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
 				if (!ioapic_phys) {
 					printk(KERN_ERR
@@ -1273,6 +1274,16 @@ int __init APIC_init_uniprocessor (void)
 		return -1;
 
 	/*
+	 * If local apic is off due to config_x86_apic_off option,
+	 * jump out here.
+	 */
+	if (enable_local_apic < -1) {
+		printk(KERN_INFO "Local APIC disabled by default; "
+					"use 'lapic' to enable it.\n");
+		return -1;
+	}
+
+	/*
 	 * Complain if the BIOS pretends there is one.
 	 */
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
diff -Naurp a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	2006-01-04 15:18:21.000000000 -0800
+++ b/arch/i386/kernel/io_apic.c	2006-01-17 14:58:30.000000000 -0800
@@ -681,7 +681,7 @@ void fastcall send_IPI_self(int vector)
 #define MAX_PIRQS 8
 static int pirq_entries [MAX_PIRQS];
 static int pirqs_enabled;
-int skip_ioapic_setup;
+int skip_ioapic_setup = X86_APIC_DEFAULT_OFF;
 
 static int __init ioapic_setup(char *str)
 {
diff -Naurp a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2006-01-04 15:18:21.000000000 -0800
+++ b/arch/i386/kernel/setup.c	2006-01-19 14:23:38.000000000 -0800
@@ -60,6 +60,10 @@
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
+#ifdef CONFIG_X86_LOCAL_APIC
+extern int enable_local_apic __initdata;
+#endif
+
 /* Forward Declaration. */
 void __init find_max_pfn(void);
 
@@ -865,6 +869,10 @@ static void __init parse_cmdline_early (
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
+		/* enable IO-APIC */
+		else if (!memcmp(from, "apic", 4))
+			enable_ioapic_setup();
+
 #endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_ACPI */
 
@@ -1606,8 +1614,14 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (smp_found_config)
-		get_smp_config();
+	if (smp_found_config) {
+		if (enable_local_apic >= 0) {
+			printk(KERN_INFO "LAPIC enabled.\n");
+			get_smp_config();
+		} else {
+			printk(KERN_INFO "LAPIC disabled.\n");
+		}
+	}
 #endif
 
 	register_memory();
diff -Naurp a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h	2006-01-04 15:18:23.000000000 -0800
+++ b/include/asm-i386/acpi.h	2006-01-17 14:58:30.000000000 -0800
@@ -134,6 +134,10 @@ static inline void disable_ioapic_setup(
 {
 	skip_ioapic_setup = 1;
 }
+static inline void enable_ioapic_setup(void)
+{
+	skip_ioapic_setup = 0;
+}
 
 static inline int ioapic_setup_disabled(void)
 {
diff -Naurp a/include/asm-i386/apic.h b/include/asm-i386/apic.h
--- a/include/asm-i386/apic.h	2006-01-04 15:18:23.000000000 -0800
+++ b/include/asm-i386/apic.h	2006-01-17 14:58:30.000000000 -0800
@@ -82,6 +82,12 @@ int get_physical_broadcast(void);
 # define apic_write_around(x,y) apic_write_atomic((x),(y))
 #endif
 
+#ifdef CONFIG_X86_UP_APIC_DEFAULT_OFF
+# define X86_APIC_DEFAULT_OFF 1
+#else
+# define X86_APIC_DEFAULT_OFF 0
+#endif
+
 static inline void ack_APIC_irq(void)
 {
 	/*

--------------010700070402050806070807--
