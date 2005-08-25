Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVHYCdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVHYCdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHYCdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:33:37 -0400
Received: from fmr18.intel.com ([134.134.136.17]:35747 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932491AbVHYCdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:33:37 -0400
Subject: Re: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20050824085054.GA4310@elf.ucw.cz>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com>
	 <20050823103256.GB2795@elf.ucw.cz>
	 <1124846001.3007.7.camel@linux-hp.sh.intel.com>
	 <20050824085054.GA4310@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:36:31 +0800
Message-Id: <1124937391.4884.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 10:50 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
> > > > --- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-23 09:32:13.054008584 +0800
> > > > +++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-23 09:41:54.992540480 +0800
> > > > @@ -104,6 +104,8 @@ static void fix_processor_context(void)
> > > >  
> > > >  }
> > > >  
> > > > +extern void mcheck_init(struct cpuinfo_x86 *c);
> > > > +
> > > >  void __restore_processor_state(struct saved_context *ctxt)
> > > >  {
> > > >  	/*
> > > 
> > > 
> > > this should go to some header file and most importantly
> > If you agree my other points, I'll do this.
Ok, updated one.
Reinitialize MCE to avoid MCE non-fatal warning after resume.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/common.c         |    5 +----
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/k7.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/mce.c     |    4 ++--
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p4.c      |    4 ++--
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p5.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p6.c      |    2 +-
 linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/winchip.c |    2 +-
 linux-2.6.13-rc6-root/arch/i386/power/cpu.c                 |    1 +
 linux-2.6.13-rc6-root/include/asm-i386/processor.h          |    6 ++++++
 9 files changed, 16 insertions(+), 12 deletions(-)

diff -puN arch/i386/kernel/cpu/mcheck/k7.c~mcheck_resume arch/i386/kernel/cpu/mcheck/k7.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/k7.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/k7.c	2005-08-24 17:00:32.000000000 +0800
@@ -69,7 +69,7 @@ static fastcall void k7_machine_check(st
 
 
 /* AMD K7 machine check is Intel like */
-void __devinit amd_mcheck_init(struct cpuinfo_x86 *c)
+void amd_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~mcheck_resume arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/mce.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/mce.c	2005-08-24 17:00:32.000000000 +0800
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
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p4.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p4.c	2005-08-24 17:00:32.000000000 +0800
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
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p5.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p5.c	2005-08-24 17:00:32.000000000 +0800
@@ -29,7 +29,7 @@ static fastcall void pentium_machine_che
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c)
+void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	
diff -puN arch/i386/kernel/cpu/mcheck/p6.c~mcheck_resume arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/p6.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/p6.c	2005-08-24 17:00:32.000000000 +0800
@@ -80,7 +80,7 @@ static fastcall void intel_machine_check
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __devinit intel_p6_mcheck_init(struct cpuinfo_x86 *c)
+void intel_p6_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/winchip.c~mcheck_resume arch/i386/kernel/cpu/mcheck/winchip.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/mcheck/winchip.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/mcheck/winchip.c	2005-08-24 17:00:32.000000000 +0800
@@ -23,7 +23,7 @@ static fastcall void winchip_machine_che
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
-void __devinit winchip_mcheck_init(struct cpuinfo_x86 *c)
+void winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 	machine_check_vector = winchip_machine_check;
diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
--- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-24 17:00:32.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-24 17:07:00.000000000 +0800
@@ -138,6 +138,7 @@ void __restore_processor_state(struct sa
 	fix_processor_context();
 	do_fpu_end();
 	mtrr_ap_init();
+	mcheck_init(&boot_cpu_data);
 }
 
 void restore_processor_state(void)
diff -puN include/asm-i386/processor.h~mcheck_resume include/asm-i386/processor.h
--- linux-2.6.13-rc6/include/asm-i386/processor.h~mcheck_resume	2005-08-23 09:43:33.000000000 +0800
+++ linux-2.6.13-rc6-root/include/asm-i386/processor.h	2005-08-24 17:07:10.000000000 +0800
@@ -702,4 +702,10 @@ extern void mtrr_bp_init(void);
 #define mtrr_bp_init() do {} while (0)
 #endif
 
+#ifdef CONFIG_X86_MCE
+extern void mcheck_init(struct cpuinfo_x86 *c);
+#else
+#define mcheck_init(c) do {} while(0)
+#endif
+
 #endif /* __ASM_I386_PROCESSOR_H */
diff -puN arch/i386/kernel/cpu/common.c~mcheck_resume arch/i386/kernel/cpu/common.c
--- linux-2.6.13-rc6/arch/i386/kernel/cpu/common.c~mcheck_resume	2005-08-24 17:07:50.000000000 +0800
+++ linux-2.6.13-rc6-root/arch/i386/kernel/cpu/common.c	2005-08-24 17:08:16.000000000 +0800
@@ -30,8 +30,6 @@ static int disable_x86_serial_nr __devin
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
-extern void mcheck_init(struct cpuinfo_x86 *c);
-
 extern int disable_pse;
 
 static void default_init(struct cpuinfo_x86 * c)
@@ -429,9 +427,8 @@ void __devinit identify_cpu(struct cpuin
 	}
 
 	/* Init Machine Check Exception if available. */
-#ifdef CONFIG_X86_MCE
 	mcheck_init(c);
-#endif
+
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
_


