Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVHCXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVHCXDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVHCXBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:01:44 -0400
Received: from fmr22.intel.com ([143.183.121.14]:15254 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261452AbVHCXBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:01:33 -0400
Date: Wed, 3 Aug 2005 16:01:14 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Suresh B Siddha <suresh.b.siddha@intel.com>, ashok.raj@intel.com,
       Andi Kleen <ak@suse.de>, Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] updated - Automatically enable bigsmp when we have more than 8 CPUs
Message-ID: <20050803160114.A5938@unix-os.sc.intel.com>
References: <20050728115142.A30921@unix-os.sc.intel.com> <20050803102023.GN10895@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050803102023.GN10895@wotan.suse.de>; from ak@suse.de on Wed, Aug 03, 2005 at 12:20:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is the updated patch.

Changes from previous version:
* Make sure there are no side-effects on other i386 subarchs.
* Make sure nothing in this patch affects x86_64
* Add additional check for Intel CPUs before switching to bigsmp mode
* Add a warning message if more than 8 CPUs are found with X86_PC subarch

Thanks,
Venki

i386 generic subarchitecture requires explicit dmi strings or command line
to enable bigsmp mode. The patch below removes that restriction, and
uses bigsmp as soon as it finds more than 8 logical CPUs, Intel processors 
and xAPIC support.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c linux-2.6.13-rc3-auto/arch/i386/kernel/acpi/boot.c
--- linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/acpi/boot.c	2005-08-03 10:13:02.000000000 -0700
@@ -833,6 +833,9 @@ acpi_process_madt(void)
 		if (!error) {
 			acpi_lapic = 1;
 
+#ifdef CONFIG_X86_GENERICARCH
+			generic_bigsmp_probe();
+#endif   
 			/*
 			 * Parse MADT IO-APIC entries
 			 */
diff -purN linux-2.6.13-rc3/arch/i386/kernel/mpparse.c linux-2.6.13-rc3-auto/arch/i386/kernel/mpparse.c
--- linux-2.6.13-rc3/arch/i386/kernel/mpparse.c	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/mpparse.c	2005-08-03 14:12:34.156775936 -0700
@@ -65,6 +65,8 @@ int nr_ioapics;
 int pic_mode;
 unsigned long mp_lapic_addr;
 
+unsigned int def_to_bigsmp = 0;
+
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
 /* Internal processor count */
@@ -213,6 +215,13 @@ static void __init MP_processor_info (st
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	if ((num_processors > 8) && 
+	    APIC_XAPIC(ver) && 
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
+		def_to_bigsmp = 1;
+	else
+		def_to_bigsmp = 0;
+
 	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
diff -purN linux-2.6.13-rc3/arch/i386/kernel/setup.c linux-2.6.13-rc3-auto/arch/i386/kernel/setup.c
--- linux-2.6.13-rc3/arch/i386/kernel/setup.c	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/setup.c	2005-08-03 14:33:34.450182216 -0700
@@ -1593,8 +1594,13 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	acpi_boot_table_init();
 	acpi_boot_init();
-#endif
 
+#ifdef CONFIG_X86_PC
+	if (def_to_bigsmp) {
+		printk(KERN_WARNING "More than 8 CPUs detected and CONFIG_X86_PC cannot handle it. Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.\n");
+	}
+#endif
+#endif
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (smp_found_config)
 		get_smp_config();
diff -purN linux-2.6.13-rc3/arch/i386/mach-generic/bigsmp.c linux-2.6.13-rc3-auto/arch/i386/mach-generic/bigsmp.c
--- linux-2.6.13-rc3/arch/i386/mach-generic/bigsmp.c	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/mach-generic/bigsmp.c	2005-08-03 09:54:58.000000000 -0700
@@ -47,7 +47,10 @@ static struct dmi_system_id __initdata b
 
 static __init int probe_bigsmp(void)
 { 
-	dmi_check_system(bigsmp_dmi_table);
+	if (def_to_bigsmp)
+        	dmi_bigsmp = 1;
+	else
+		dmi_check_system(bigsmp_dmi_table);
 	return dmi_bigsmp; 
 } 
 
diff -purN linux-2.6.13-rc3/arch/i386/mach-generic/probe.c linux-2.6.13-rc3-auto/arch/i386/mach-generic/probe.c
--- linux-2.6.13-rc3/arch/i386/mach-generic/probe.c	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/mach-generic/probe.c	2005-08-03 14:00:38.533567200 -0700
@@ -30,6 +30,25 @@ struct genapic *apic_probe[] __initdata 
 	NULL,
 };
 
+static int cmdline_apic;
+
+void __init generic_bigsmp_probe(void) 
+{
+	/*
+	 * This routine is used to switch to bigsmp mode when
+	 * - There is no apic= option specified by the user
+	 * - generic_apic_probe() has choosen apic_default as the sub_arch
+	 * - we find more than 8 CPUs in acpi LAPIC listing with xAPIC support
+	 */
+	   
+	if (!cmdline_apic && genapic == &apic_default)
+		if (apic_bigsmp.probe()) {
+			genapic = &apic_bigsmp;
+			printk(KERN_INFO "Overriding APIC driver with %s\n", 
+			       genapic->name);
+		}
+}
+
 void __init generic_apic_probe(char *command_line) 
 { 
 	char *s;
@@ -52,6 +71,7 @@ void __init generic_apic_probe(char *com
 		if (!changed)
 			printk(KERN_ERR "Unknown genapic `%s' specified.\n", s);
 		*p = old;
+		cmdline_apic = changed;
 	} 
 	for (i = 0; !changed && apic_probe[i]; i++) { 
 		if (apic_probe[i]->probe()) {
diff -purN linux-2.6.13-rc3/include/asm-i386/apicdef.h linux-2.6.13-rc3-auto/include/asm-i386/apicdef.h
--- linux-2.6.13-rc3/include/asm-i386/apicdef.h	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/include/asm-i386/apicdef.h	2005-08-03 09:54:58.000000000 -0700
@@ -16,6 +16,7 @@
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
 #define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFF)
 #define			APIC_INTEGRATED(x)	((x)&0xF0)
+#define			APIC_XAPIC(x)		((x) >= 0x14)
 #define		APIC_TASKPRI	0x80
 #define			APIC_TPRI_MASK		0xFF
 #define		APIC_ARBPRI	0x90
diff -purN linux-2.6.13-rc3/include/asm-i386/mach-generic/mach_apic.h linux-2.6.13-rc3-auto/include/asm-i386/mach-generic/mach_apic.h
--- linux-2.6.13-rc3/include/asm-i386/mach-generic/mach_apic.h	2005-07-27 00:02:25.000000000 -0700
+++ linux-2.6.13-rc3-auto/include/asm-i386/mach-generic/mach_apic.h	2005-08-03 10:13:12.000000000 -0700
@@ -28,4 +28,6 @@
 #define enable_apic_mode (genapic->enable_apic_mode)
 #define phys_pkg_id (genapic->phys_pkg_id)
 
+extern void generic_bigsmp_probe(void);
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN linux-2.6.13-rc3/include/asm-i386/mpspec.h linux-2.6.13-rc3-auto/include/asm-i386/mpspec.h
--- linux-2.6.13-rc3/include/asm-i386/mpspec.h	2005-07-29 00:58:06.000000000 -0700
+++ linux-2.6.13-rc3-auto/include/asm-i386/mpspec.h	2005-08-03 09:54:58.000000000 -0700
@@ -11,6 +11,7 @@ extern int mp_bus_id_to_local [MAX_MP_BU
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
+extern unsigned int def_to_bigsmp;
 extern unsigned int boot_cpu_physical_apicid;
 extern int smp_found_config;
 extern void find_smp_config (void);
