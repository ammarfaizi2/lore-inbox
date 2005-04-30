Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVD3IOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVD3IOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVD3IOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:14:34 -0400
Received: from fmr17.intel.com ([134.134.136.16]:3265 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261151AbVD3IOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:14:19 -0400
Subject: [PATCH]mcheck init call cleanup
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Racing Guo <racing.guo@intel.com>
Content-Type: text/plain
Message-Id: <1114848679.2616.20.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 30 Apr 2005 16:11:19 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
The machine check changes in -rc3-mm1 break the SMP suspend/resume
patches as you expected. Here is a fix.
1. clean the __init call
2. calling on_each_cpu in sysdev's .resume/.suspend methods (which are
called with interrupt disabled) is known broken. The MTRR driver is a
such case. The patch makes only BSP call the .resume.

Thanks,
Shaohua


Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/init.c      |    8 ++--
 linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/mce.c       |   18 ++++------
 linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/mce_intel.c |    4 +-
 linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/winchip.c   |    2 -
 4 files changed, 15 insertions(+), 17 deletions(-)

diff -puN arch/i386/kernel/cpu/mcheck/init.c~mce_init_cleanup arch/i386/kernel/cpu/mcheck/init.c
--- linux-2.6.11-rc3-mm1/arch/i386/kernel/cpu/mcheck/init.c~mce_init_cleanup	2005-04-30 15:29:49.083231744 +0800
+++ linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/init.c	2005-04-30 15:41:55.182847824 +0800
@@ -16,9 +16,9 @@
 
 #include "mce.h"
 
-extern int __init mce_dont_init;
-extern void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c);
-void __init winchip_mcheck_init(struct cpuinfo_x86 *c);
+extern int __devinitdata mce_dont_init;
+extern void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c);
+void __devinit winchip_mcheck_init(struct cpuinfo_x86 *c);
 fastcall void do_machine_check(struct pt_regs * regs, long error_code);
 
 /* Handle unconfigured int18 (should never happen) */
@@ -31,7 +31,7 @@ static fastcall void unexpected_machine_
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
-void __init machine_check_init(struct cpuinfo_x86 *c)
+void __devinit machine_check_init(struct cpuinfo_x86 *c)
 {
 	if (mce_dont_init)
 		return;
diff -puN arch/i386/kernel/cpu/mcheck/mce_intel.c~mce_init_cleanup arch/i386/kernel/cpu/mcheck/mce_intel.c
--- linux-2.6.11-rc3-mm1/arch/i386/kernel/cpu/mcheck/mce_intel.c~mce_init_cleanup	2005-04-30 15:31:39.591431944 +0800
+++ linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/mce_intel.c	2005-04-30 15:32:18.009591496 +0800
@@ -47,7 +47,7 @@ done:
 	irq_exit();
 }
 
-static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+static void __devinit intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int tm2 = 0;
@@ -98,7 +98,7 @@ static void __init intel_init_thermal(st
 	return;
 }
 
-void __init mce_intel_feature_init(struct cpuinfo_x86 *c)
+void __devinit mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
 	intel_init_thermal(c);
 }
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~mce_init_cleanup arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.11-rc3-mm1/arch/i386/kernel/cpu/mcheck/mce.c~mce_init_cleanup	2005-04-30 15:31:49.078989616 +0800
+++ linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/mce.c	2005-04-30 15:47:48.764095304 +0800
@@ -25,7 +25,7 @@
 #define MISC_MCELOG_MINOR 227
 #define NR_BANKS 5
 
-int __initdata mce_dont_init = 0;
+int __devinitdata mce_dont_init = 0;
 
 /* 0: always panic, 1: panic if deadlock possible, 2: try to avoid panic,
    3: never panic or exit (for testing only) */
@@ -326,7 +326,7 @@ static void mce_init(void *dummy)
 }
 
 /* Add per CPU specific workarounds here */
-static void __init mce_cpu_quirks(struct cpuinfo_x86 *c)
+static void __devinit mce_cpu_quirks(struct cpuinfo_x86 *c)
 {
 	/* This should be disabled by the BIOS, but isn't always */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 15) {
@@ -336,7 +336,7 @@ static void __init mce_cpu_quirks(struct
 	}
 }
 
-static void __init mce_cpu_features(struct cpuinfo_x86 *c)
+static void __devinit mce_cpu_features(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
@@ -353,13 +353,9 @@ static void __init mce_cpu_features(stru
  */
 void __devinit mcheck_init(struct cpuinfo_x86 *c)
 {
-	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
-
 	mce_cpu_quirks(c);
 
-	if (mce_dont_init ||
-	    cpu_test_and_set(smp_processor_id(), mce_cpus) ||
-	    !mce_available(c))
+	if (mce_dont_init || !mce_available(c))
 		return;
 
 	mce_init(NULL);
@@ -484,10 +480,12 @@ __setup("mce", mcheck_enable);
  * Sysfs support
  */
 
-/* On resume clear all MCE state. Don't want to see leftovers from the BIOS. */
+/* On resume clear all MCE state. Don't want to see leftovers from the BIOS.
+ * Only BSP call this routine, APs follow boot code path.
+ */
 static int mce_resume(struct sys_device *dev)
 {
-	on_each_cpu(mce_init, NULL, 1, 1);
+	mce_init(NULL);
 	return 0;
 }
 
diff -puN arch/i386/kernel/cpu/mcheck/winchip.c~mce_init_cleanup arch/i386/kernel/cpu/mcheck/winchip.c
--- linux-2.6.11-rc3-mm1/arch/i386/kernel/cpu/mcheck/winchip.c~mce_init_cleanup	2005-04-30 15:42:10.926454432 +0800
+++ linux-2.6.11-rc3-mm1-root/arch/i386/kernel/cpu/mcheck/winchip.c	2005-04-30 15:42:24.909328712 +0800
@@ -25,7 +25,7 @@ static fastcall void winchip_machine_che
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
-void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 	machine_check_vector = winchip_machine_check;
_



