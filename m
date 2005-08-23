Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVHWB6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVHWB6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 21:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVHWB6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 21:58:54 -0400
Received: from fmr19.intel.com ([134.134.136.18]:12237 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751293AbVHWB6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 21:58:53 -0400
Subject: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 10:01:40 +0800
Message-Id: <1124762500.3013.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It's widely seen a MCE non-fatal error reported after resume. It seems
MCE resume is lacked under ia32. This patch tries to fix the gap.


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/k7.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/mce.c     |    4 ++--
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p4.c      |    4 ++--
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p5.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p6.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/winchip.c |    2 +-
 linux-2.6.13-rc6-root/arch/i386/power/cpu.c                 |    5 +++++
 7 files changed, 13 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/cpu/mcheck/k7.c~mcheck_resume arch/i386/kernel/cpu/mcheck/k7.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/k7.c~mcheck_resume	2005-08-23 09:26:53.956518776 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/k7.c	2005-08-23 09:27:15.916180400 +0800
@@ -69,7 +69,7 @@ static fastcall void k7_machine_check(st
 
 
 /* AMD K7 machine check is Intel like */
-void __devinit amd_mcheck_init(struct cpuinfo_x86 *c)
+void amd_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~mcheck_resume arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/mce.c~mcheck_resume	2005-08-23 09:27:40.301473272 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/mce.c	2005-08-23 09:28:17.394834224 +0800
@@ -16,7 +16,7 @@
 
 #include "mce.h"
 
-int mce_disabled __devinitdata = 0;
+int mce_disabled = 0;
 int nr_mce_banks;
 
 EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
@@ -31,7 +31,7 @@ static fastcall void unexpected_machine_
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
-void __devinit mcheck_init(struct cpuinfo_x86 *c)
+void mcheck_init(struct cpuinfo_x86 *c)
 {
 	if (mce_disabled==1)
 		return;
diff -puN arch/i386/kernel/cpu/mcheck/p4.c~mcheck_resume arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p4.c~mcheck_resume	2005-08-23 09:29:17.665671664 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p4.c	2005-08-23 09:29:59.738275656 +0800
@@ -78,7 +78,7 @@ fastcall void smp_thermal_interrupt(stru
 }
 
 /* P4/Xeon Thermal regulation detect and init */
-static void __devinit intel_init_thermal(struct cpuinfo_x86 *c)
+static void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
@@ -232,7 +232,7 @@ static fastcall void intel_machine_check
 }
 
 
-void __devinit intel_p4_mcheck_init(struct cpuinfo_x86 *c)
+void intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/p5.c~mcheck_resume arch/i386/kernel/cpu/mcheck/p5.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p5.c~mcheck_resume	2005-08-23 09:29:22.504935984 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p5.c	2005-08-23 09:30:12.610318808 +0800
@@ -29,7 +29,7 @@ static fastcall void pentium_machine_che
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c)
+void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	
diff -puN arch/i386/kernel/cpu/mcheck/p6.c~mcheck_resume arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p6.c~mcheck_resume	2005-08-23 09:29:25.030552032 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p6.c	2005-08-23 09:30:26.595192784 +0800
@@ -80,7 +80,7 @@ static fastcall void intel_machine_check
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __devinit intel_p6_mcheck_init(struct cpuinfo_x86 *c)
+void intel_p6_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/winchip.c~mcheck_resume arch/i386/kernel/cpu/mcheck/winchip.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/winchip.c~mcheck_resume	2005-08-23 09:29:34.589098912 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/winchip.c	2005-08-23 09:30:42.652751664 +0800
@@ -23,7 +23,7 @@ static fastcall void winchip_machine_che
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
-void __devinit winchip_mcheck_init(struct cpuinfo_x86 *c)
+void winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 	machine_check_vector = winchip_machine_check;
diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
--- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-23 09:32:13.054008584 +0800
+++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-23 09:41:54.992540480 +0800
@@ -104,6 +104,8 @@ static void fix_processor_context(void)
 
 }
 
+extern void mcheck_init(struct cpuinfo_x86 *c);
+
 void __restore_processor_state(struct saved_context *ctxt)
 {
 	/*
@@ -138,6 +140,9 @@ void __restore_processor_state(struct sa
 	fix_processor_context();
 	do_fpu_end();
 	mtrr_ap_init();
+#ifdef CONFIG_X86_MCE
+	mcheck_init(&boot_cpu_data);
+#endif
 }
 
 void restore_processor_state(void)
_


