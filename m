Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVG1SyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVG1SyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1SwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:52:14 -0400
Received: from fmr22.intel.com ([143.183.121.14]:48836 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261471AbVG1SwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:52:01 -0400
Date: Thu, 28 Jul 2005 11:51:42 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Automatically enable bigsmp when we have more than 8 CPUs
Message-ID: <20050728115142.A30921@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Today, bigsmp mode is only detected with special oem dmi string or a 
boot option. This patch makes the selection of bigsmp automatic, whenever 
there are more 8 CPUs and xAPIC (APIC version 0x14) is supported. 
This patch should only affect systems with more than 8 logical CPUs 
that doesn't belong to any other special sub-archs.

The same issue was also discussed around a year back:
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/1679.html
where I had posted a slightly different patch from the one below and that
patch did not go anywhere. The patch below is cleaner than the one in 
above link.

Please apply.

Thanks,
Venki


i386 generic subarchitecture requires explicit dmi strings or command line
to enable bigsmp mode. The patch below removes that restriction, and
uses bigsmp as soon as it finds more than 8 logical CPUs and xAPIC support.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c linux-2.6.13-rc3-auto/arch/i386/kernel/acpi/boot.c
--- linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c	2005-07-29 00:58:06.174571656 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/acpi/boot.c	2005-07-28 06:44:43.000000000 -0700
@@ -41,7 +41,6 @@
 #ifdef	CONFIG_X86_64
 
 static inline void  acpi_madt_oem_check(char *oem_id, char *oem_table_id) { }
-extern void __init clustered_apic_check(void);
 static inline int ioapic_setup_disabled(void) { return 0; }
 #include <asm/proto.h>
 
@@ -843,7 +842,6 @@ acpi_process_madt(void)
 				acpi_ioapic = 1;
 
 				smp_found_config = 1;
-				clustered_apic_check();
 			}
 		}
 		if (error == -EINVAL) {
diff -purN linux-2.6.13-rc3/arch/i386/kernel/mpparse.c linux-2.6.13-rc3-auto/arch/i386/kernel/mpparse.c
--- linux-2.6.13-rc3/arch/i386/kernel/mpparse.c	2005-07-29 00:58:06.175571504 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/mpparse.c	2005-07-29 01:38:13.557593808 -0700
@@ -65,6 +65,8 @@ int nr_ioapics;
 int pic_mode;
 unsigned long mp_lapic_addr;
 
+unsigned int def_to_bigsmp = 0;
+
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
 /* Internal processor count */
@@ -213,6 +215,11 @@ static void __init MP_processor_info (st
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	if ((num_processors > 8) && APIC_XAPIC(ver))
+		def_to_bigsmp = 1;
+	else
+		def_to_bigsmp = 0;
+
 	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
@@ -479,7 +486,6 @@ static int __init smp_read_mpc(struct mp
 		}
 		++mpc_record;
 	}
-	clustered_apic_check();
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
diff -purN linux-2.6.13-rc3/arch/i386/kernel/setup.c linux-2.6.13-rc3-auto/arch/i386/kernel/setup.c
--- linux-2.6.13-rc3/arch/i386/kernel/setup.c	2005-07-29 00:58:06.177571200 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/kernel/setup.c	2005-07-29 01:51:55.627620168 -0700
@@ -60,6 +60,11 @@
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
+#ifdef  CONFIG_X86_LOCAL_APIC
+#include <mach_apic.h>
+#include <mach_mpparse.h>
+#endif  /* CONFIG_X86_LOCAL_APIC */
+
 /* Forward Declaration. */
 void __init find_max_pfn(void);
 
@@ -1581,9 +1586,6 @@ void __init setup_arch(char **cmdline_p)
 
 	dmi_scan_machine();
 
-#ifdef CONFIG_X86_GENERICARCH
-	generic_apic_probe(*cmdline_p);
-#endif	
 	if (efi_enabled)
 		efi_map_memmap();
 
@@ -1600,6 +1602,14 @@ void __init setup_arch(char **cmdline_p)
 		get_smp_config();
 #endif
 
+#ifdef CONFIG_X86_GENERICARCH
+	generic_apic_probe(*cmdline_p);
+#endif        
+
+#ifdef  CONFIG_X86_LOCAL_APIC
+	clustered_apic_check();
+#endif
+
 	register_memory();
 
 #ifdef CONFIG_VT
diff -purN linux-2.6.13-rc3/arch/i386/mach-generic/bigsmp.c linux-2.6.13-rc3-auto/arch/i386/mach-generic/bigsmp.c
--- linux-2.6.13-rc3/arch/i386/mach-generic/bigsmp.c	2005-07-29 00:58:06.177571200 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/mach-generic/bigsmp.c	2005-07-28 06:44:43.000000000 -0700
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
--- linux-2.6.13-rc3/arch/i386/mach-generic/probe.c	2005-07-29 00:58:06.178571048 -0700
+++ linux-2.6.13-rc3-auto/arch/i386/mach-generic/probe.c	2005-07-28 06:44:43.000000000 -0700
@@ -24,9 +24,9 @@ struct genapic *genapic = &apic_default;
 
 struct genapic *apic_probe[] __initdata = { 
 	&apic_summit,
-	&apic_bigsmp, 
 	&apic_es7000,
-	&apic_default,	/* must be last */
+	&apic_bigsmp,  /* must be last but one */
+	&apic_default, /* must be last */
 	NULL,
 };
 
diff -purN linux-2.6.13-rc3/include/asm-i386/apicdef.h linux-2.6.13-rc3-auto/include/asm-i386/apicdef.h
--- linux-2.6.13-rc3/include/asm-i386/apicdef.h	2005-07-29 00:58:06.186569832 -0700
+++ linux-2.6.13-rc3-auto/include/asm-i386/apicdef.h	2005-07-29 00:58:40.466358512 -0700
@@ -16,6 +16,7 @@
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
 #define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFF)
 #define			APIC_INTEGRATED(x)	((x)&0xF0)
+#define			APIC_XAPIC(x)		((x) == 0x14)
 #define		APIC_TASKPRI	0x80
 #define			APIC_TPRI_MASK		0xFF
 #define		APIC_ARBPRI	0x90
diff -purN linux-2.6.13-rc3/include/asm-i386/mpspec.h linux-2.6.13-rc3-auto/include/asm-i386/mpspec.h
--- linux-2.6.13-rc3/include/asm-i386/mpspec.h	2005-07-29 00:58:06.186569832 -0700
+++ linux-2.6.13-rc3-auto/include/asm-i386/mpspec.h	2005-07-29 01:32:46.132370008 -0700
@@ -11,6 +11,7 @@ extern int mp_bus_id_to_local [MAX_MP_BU
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
+extern unsigned int def_to_bigsmp;
 extern unsigned int boot_cpu_physical_apicid;
 extern int smp_found_config;
 extern void find_smp_config (void);

