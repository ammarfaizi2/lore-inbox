Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWBCAGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWBCAGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWBCAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:06:12 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:38788 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964783AbWBCAGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:06:11 -0500
Date: Thu, 2 Feb 2006 19:00:53 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4] i386 cpu hotplug: don't access freed memory
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Message-ID: <200602021904_MC3-1-B771-46F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 CPU init code accesses freed init memory when booting
a newly-started processor after CPU hotplug.  The cpu_devs
array is searched to find the vendor and it contains pointers
to freed data.

Fix that by:

        1. Zeroing entries for freed vendor data after bootup.
        2. Changing Transmeta, NSC and UMC to all __init[data].
        3. Printing a warning (once only) and setting this_cpu
           to a safe default when the vendor is not found.

This does not change behavior for AMD systems.  They were broken
already but no error was reported.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/cpu/amd.c             |    8 ++++++++
 arch/i386/kernel/cpu/centaur.c         |    8 ++++++++
 arch/i386/kernel/cpu/common.c          |   11 ++++++++++-
 arch/i386/kernel/cpu/cyrix.c           |   18 +++++++++++++++++-
 arch/i386/kernel/cpu/intel_cacheinfo.c |    1 +
 arch/i386/kernel/cpu/nexgen.c          |    8 ++++++++
 arch/i386/kernel/cpu/rise.c            |    8 ++++++++
 arch/i386/kernel/cpu/transmeta.c       |   14 +++++++++++---
 arch/i386/kernel/cpu/umc.c             |   12 ++++++++++--
 9 files changed, 81 insertions(+), 7 deletions(-)

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/amd.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/amd.c
@@ -282,3 +282,11 @@ int __init amd_init_cpu(void)
 }
 
 //early_arch_initcall(amd_init_cpu);
+
+int __init amd_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_AMD] = NULL;
+	return 0;
+}
+
+late_initcall(amd_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/centaur.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/centaur.c
@@ -470,3 +470,11 @@ int __init centaur_init_cpu(void)
 }
 
 //early_arch_initcall(centaur_init_cpu);
+
+int __init centaur_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_CENTAUR] = NULL;
+	return 0;
+}
+
+late_initcall(centaur_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/common.c
@@ -45,6 +45,7 @@ static void default_init(struct cpuinfo_
 
 static struct cpu_dev default_cpu = {
 	.c_init	= default_init,
+	.c_vendor = "Unknown",
 };
 static struct cpu_dev * this_cpu = &default_cpu;
 
@@ -151,6 +152,7 @@ static void __cpuinit get_cpu_vendor(str
 {
 	char *v = c->x86_vendor_id;
 	int i;
+	static int printed = 0;
 
 	for (i = 0; i < X86_VENDOR_NUM; i++) {
 		if (cpu_devs[i]) {
@@ -160,10 +162,17 @@ static void __cpuinit get_cpu_vendor(str
 				c->x86_vendor = i;
 				if (!early)
 					this_cpu = cpu_devs[i];
-				break;
+				return;
 			}
 		}
 	}
+	if (!printed) {
+		printed++;
+		printk(KERN_ERR "CPU: Vendor unknown, using generic init.\n");
+		printk(KERN_ERR "CPU: Your system may be unstable.\n");
+	}
+	c->x86_vendor = X86_VENDOR_UNKNOWN;
+	this_cpu = &default_cpu;
 }
 
 
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/cyrix.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/cyrix.c
@@ -345,7 +345,7 @@ static void __init init_cyrix(struct cpu
 /*
  * Handle National Semiconductor branded processors
  */
-static void __cpuinit init_nsc(struct cpuinfo_x86 *c)
+static void __init init_nsc(struct cpuinfo_x86 *c)
 {
 	/* There may be GX1 processors in the wild that are branded
 	 * NSC and not Cyrix.
@@ -444,6 +444,14 @@ int __init cyrix_init_cpu(void)
 
 //early_arch_initcall(cyrix_init_cpu);
 
+int __init cyrix_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_CYRIX] = NULL;
+	return 0;
+}
+
+late_initcall(cyrix_exit_cpu);
+
 static struct cpu_dev nsc_cpu_dev __initdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
@@ -458,3 +466,11 @@ int __init nsc_init_cpu(void)
 }
 
 //early_arch_initcall(nsc_init_cpu);
+
+int __init nsc_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_NSC] = NULL;
+	return 0;
+}
+
+late_initcall(nsc_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -152,6 +152,7 @@ static int __cpuinit cpuid4_cache_lookup
 	return 0;
 }
 
+/* will only be called once; __init is safe here */
 static int __init find_num_cache_leaves(void)
 {
 	unsigned int		eax, ebx, ecx, edx;
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/nexgen.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/nexgen.c
@@ -61,3 +61,11 @@ int __init nexgen_init_cpu(void)
 }
 
 //early_arch_initcall(nexgen_init_cpu);
+
+int __init nexgen_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_NEXGEN] = NULL;
+	return 0;
+}
+
+late_initcall(nexgen_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/rise.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/rise.c
@@ -51,3 +51,11 @@ int __init rise_init_cpu(void)
 }
 
 //early_arch_initcall(rise_init_cpu);
+
+int __init rise_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_RISE] = NULL;
+	return 0;
+}
+
+late_initcall(rise_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/transmeta.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/transmeta.c
@@ -4,7 +4,7 @@
 #include <asm/msr.h>
 #include "cpu.h"
 
-static void __cpuinit init_transmeta(struct cpuinfo_x86 *c)
+static void __init init_transmeta(struct cpuinfo_x86 *c)
 {
 	unsigned int cap_mask, uk, max, dummy;
 	unsigned int cms_rev1, cms_rev2;
@@ -84,7 +84,7 @@ static void __cpuinit init_transmeta(str
 #endif
 }
 
-static void transmeta_identify(struct cpuinfo_x86 * c)
+static void __init transmeta_identify(struct cpuinfo_x86 * c)
 {
 	u32 xlvl;
 	generic_identify(c);
@@ -97,7 +97,7 @@ static void transmeta_identify(struct cp
 	}
 }
 
-static struct cpu_dev transmeta_cpu_dev __cpuinitdata = {
+static struct cpu_dev transmeta_cpu_dev __initdata = {
 	.c_vendor	= "Transmeta",
 	.c_ident	= { "GenuineTMx86", "TransmetaCPU" },
 	.c_init		= init_transmeta,
@@ -111,3 +111,11 @@ int __init transmeta_init_cpu(void)
 }
 
 //early_arch_initcall(transmeta_init_cpu);
+
+int __init transmeta_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_TRANSMETA] = NULL;
+	return 0;
+}
+
+late_initcall(transmeta_exit_cpu);
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/umc.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/umc.c
@@ -5,12 +5,12 @@
 
 /* UMC chips appear to be only either 386 or 486, so no special init takes place.
  */
-static void __cpuinit init_umc(struct cpuinfo_x86 * c)
+static void __init init_umc(struct cpuinfo_x86 * c)
 {
 
 }
 
-static struct cpu_dev umc_cpu_dev __cpuinitdata = {
+static struct cpu_dev umc_cpu_dev __initdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
 	.c_models = {
@@ -31,3 +31,11 @@ int __init umc_init_cpu(void)
 }
 
 //early_arch_initcall(umc_init_cpu);
+
+int __init umc_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_UMC] = NULL;
+	return 0;
+}
+
+late_initcall(umc_exit_cpu);
-- 
Chuck
