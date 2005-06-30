Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVF3CFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVF3CFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 22:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVF3CFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 22:05:08 -0400
Received: from fmr17.intel.com ([134.134.136.16]:6328 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262770AbVF3CEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 22:04:21 -0400
Subject: Re: [PATCH]MTRR suspend/resume cleanup
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       ncunningham@cyclades.com, ak@muc.de, pavel@ucw.cz
In-Reply-To: <20050627222444.370457d4.akpm@osdl.org>
References: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
	 <20050627222444.370457d4.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 10:13:21 +0800
Message-Id: <1120097601.2942.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 13:24 +0800, Andrew Morton wrote:
> > @@ -332,6 +332,7 @@ int mtrr_add_page(unsigned long base, un
> > 
> >       error = -EINVAL;
> > 
> > +     lock_cpu_hotplug();
> >       /*  Search for existing MTRR  */
> >       down(&main_lock);
> >       for (i = 0; i < num_var_ranges; ++i) {
>        
> Is this new locking?  If so, please describe it.
<Snip>
Ok, this is an updated patch based on your suggestion. Could this be put
into next -mm tree?

Thanks,
Shaohua


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.12-mm1-root/arch/i386/kernel/cpu/common.c       |    5 
 linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/generic.c |   22 ++--
 linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/main.c    |   76 +++++++++-----
 linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/mtrr.h    |    1 
 linux-2.6.12-mm1-root/arch/i386/power/cpu.c               |    1 
 linux-2.6.12-mm1-root/arch/x86_64/kernel/setup.c          |    4 
 linux-2.6.12-mm1-root/arch/x86_64/kernel/suspend.c        |    1 
 linux-2.6.12-mm1-root/include/asm-i386/processor.h        |    8 +
 linux-2.6.12-mm1-root/include/asm-x86_64/proto.h          |    7 +
 9 files changed, 90 insertions(+), 35 deletions(-)

diff -puN arch/i386/kernel/cpu/mtrr/main.c~mtrr_cpuhotplug_cleanup arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.12-mm1/arch/i386/kernel/cpu/mtrr/main.c~mtrr_cpuhotplug_cleanup	2005-06-23 18:50:45.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/main.c	2005-06-28 13:30:43.000000000 +0800
@@ -332,6 +332,8 @@ int mtrr_add_page(unsigned long base, un
 
 	error = -EINVAL;
 
+	/* No CPU hotplug when we change MTRR entries */
+	lock_cpu_hotplug();
 	/*  Search for existing MTRR  */
 	down(&main_lock);
 	for (i = 0; i < num_var_ranges; ++i) {
@@ -372,6 +374,7 @@ int mtrr_add_page(unsigned long base, un
 	error = i;
  out:
 	up(&main_lock);
+	unlock_cpu_hotplug();
 	return error;
 }
 
@@ -461,6 +464,8 @@ int mtrr_del_page(int reg, unsigned long
 		return -ENXIO;
 
 	max = num_var_ranges;
+	/* No CPU hotplug when we change MTRR entries */
+	lock_cpu_hotplug();
 	down(&main_lock);
 	if (reg < 0) {
 		/*  Search for existing MTRR  */
@@ -501,6 +506,7 @@ int mtrr_del_page(int reg, unsigned long
 	error = reg;
  out:
 	up(&main_lock);
+	unlock_cpu_hotplug();
 	return error;
 }
 /**
@@ -544,21 +550,9 @@ static void __init init_ifs(void)
 	centaur_init_mtrr();
 }
 
-static void __init init_other_cpus(void)
-{
-	if (use_intel())
-		get_mtrr_state();
-
-	/* bring up the other processors */
-	set_mtrr(~0U,0,0,0);
-
-	if (use_intel()) {
-		finalize_mtrr_state();
-		mtrr_state_warn();
-	}
-}
-
-
+/* The suspend/resume methods are only for CPU without MTRR. CPU using generic
+ * MTRR driver doesn't require this
+ */
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
@@ -611,13 +605,13 @@ static struct sysdev_driver mtrr_sysdev_
 
 
 /**
- * mtrr_init - initialize mtrrs on the boot CPU
+ * mtrr_bp_init - initialize mtrrs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are 
  * initialized (i.e. before smp_init()).
  * 
  */
-static int __init mtrr_init(void)
+void __init mtrr_bp_init(void)
 {
 	init_ifs();
 
@@ -674,12 +668,48 @@ static int __init mtrr_init(void)
 	if (mtrr_if) {
 		set_num_var_ranges();
 		init_table();
-		init_other_cpus();
-
-		return sysdev_driver_register(&cpu_sysdev_class,
-					      &mtrr_sysdev_driver);
+		if (use_intel())
+			get_mtrr_state();
 	}
-	return -ENXIO;
 }
 
-subsys_initcall(mtrr_init);
+void mtrr_ap_init(void)
+{
+	unsigned long flags;
+
+	if (!mtrr_if || !use_intel())
+		return;
+	/*
+	 * Ideally we should hold main_lock here to avoid mtrr entries changed,
+	 * but this routine will be called in cpu boot time, holding the lock
+	 * breaks it. This routine is called in two cases: 1.very earily time
+	 * of software resume, when there absolutely isn't mtrr entry changes;
+	 * 2.cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug lock to
+	 * prevent mtrr entry changes
+	 */
+	local_irq_save(flags);
+
+	mtrr_if->set_all();
+
+	local_irq_restore(flags);
+}
+
+static int __init mtrr_init_finialize(void)
+{
+	if (!mtrr_if)
+		return 0;
+	if (use_intel())
+		mtrr_state_warn();
+	else {
+		/* The CPUs haven't MTRR and seemes not support SMP. They have
+		 * specific drivers, we use a tricky method to support
+		 * suspend/resume for them.
+		 * TBD: is there any system with such CPU which supports
+		 * suspend/resume?  if no, we should remove the code.
+		 */
+		sysdev_driver_register(&cpu_sysdev_class,
+			&mtrr_sysdev_driver);
+	}
+	return 0;
+}
+subsys_initcall(mtrr_init_finialize);
diff -puN arch/i386/kernel/cpu/mtrr/generic.c~mtrr_cpuhotplug_cleanup arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.6.12-mm1/arch/i386/kernel/cpu/mtrr/generic.c~mtrr_cpuhotplug_cleanup	2005-06-23 18:50:45.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/generic.c	2005-06-23 20:04:36.000000000 +0800
@@ -67,13 +67,6 @@ void __init get_mtrr_state(void)
 	mtrr_state.enabled = (lo & 0xc00) >> 10;
 }
 
-/*  Free resources associated with a struct mtrr_state  */
-void __init finalize_mtrr_state(void)
-{
-	kfree(mtrr_state.var_ranges);
-	mtrr_state.var_ranges = NULL;
-}
-
 /*  Some BIOS's are fucked and don't set all MTRRs the same!  */
 void __init mtrr_state_warn(void)
 {
@@ -334,6 +327,9 @@ static void generic_set_mtrr(unsigned in
 */
 {
 	unsigned long flags;
+	struct mtrr_var_range *vr;
+
+	vr = &mtrr_state.var_ranges[reg];
 
 	local_irq_save(flags);
 	prepare_set();
@@ -342,11 +338,15 @@ static void generic_set_mtrr(unsigned in
 		/* The invalid bit is kept in the mask, so we simply clear the
 		   relevant mask register to disable a range. */
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), 0, 0);
+		memset(vr, 0, sizeof(struct mtrr_var_range));
 	} else {
-		mtrr_wrmsr(MTRRphysBase_MSR(reg), base << PAGE_SHIFT | type,
-		      (base & size_and_mask) >> (32 - PAGE_SHIFT));
-		mtrr_wrmsr(MTRRphysMask_MSR(reg), -size << PAGE_SHIFT | 0x800,
-		      (-size & size_and_mask) >> (32 - PAGE_SHIFT));
+		vr->base_lo = base << PAGE_SHIFT | type;
+		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
+		vr->mask_lo = -size << PAGE_SHIFT | 0x800;
+		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
+
+		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
+		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
 	}
 
 	post_set();
diff -puN arch/i386/kernel/cpu/mtrr/mtrr.h~mtrr_cpuhotplug_cleanup arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-2.6.12-mm1/arch/i386/kernel/cpu/mtrr/mtrr.h~mtrr_cpuhotplug_cleanup	2005-06-23 18:50:45.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/cpu/mtrr/mtrr.h	2005-06-23 18:50:45.000000000 +0800
@@ -91,7 +91,6 @@ extern struct mtrr_ops * mtrr_if;
 
 extern unsigned int num_var_ranges;
 
-void finalize_mtrr_state(void);
 void mtrr_state_warn(void);
 char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
diff -puN arch/i386/kernel/cpu/common.c~mtrr_cpuhotplug_cleanup arch/i386/kernel/cpu/common.c
--- linux-2.6.12-mm1/arch/i386/kernel/cpu/common.c~mtrr_cpuhotplug_cleanup	2005-06-23 18:50:45.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/kernel/cpu/common.c	2005-06-23 19:49:26.000000000 +0800
@@ -435,6 +435,11 @@ void __devinit identify_cpu(struct cpuin
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
+
+	if (c == &boot_cpu_data)
+		mtrr_bp_init();
+	else
+		mtrr_ap_init();
 }
 
 #ifdef CONFIG_X86_HT
diff -puN include/asm-i386/processor.h~mtrr_cpuhotplug_cleanup include/asm-i386/processor.h
--- linux-2.6.12-mm1/include/asm-i386/processor.h~mtrr_cpuhotplug_cleanup	2005-06-23 19:43:51.000000000 +0800
+++ linux-2.6.12-mm1-root/include/asm-i386/processor.h	2005-06-28 13:32:46.000000000 +0800
@@ -696,4 +696,12 @@ extern unsigned long boot_option_idle_ov
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+#ifdef CONFIG_MTRR
+extern void mtrr_ap_init(void);
+extern void mtrr_bp_init(void);
+#else
+#define mtrr_ap_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
+#endif
+
 #endif /* __ASM_I386_PROCESSOR_H */
diff -puN arch/i386/power/cpu.c~mtrr_cpuhotplug_cleanup arch/i386/power/cpu.c
--- linux-2.6.12-mm1/arch/i386/power/cpu.c~mtrr_cpuhotplug_cleanup	2005-06-23 19:48:23.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/i386/power/cpu.c	2005-06-23 19:48:37.000000000 +0800
@@ -137,6 +137,7 @@ void __restore_processor_state(struct sa
 
 	fix_processor_context();
 	do_fpu_end();
+	mtrr_ap_init();
 }
 
 void restore_processor_state(void)
diff -puN include/asm-x86_64/proto.h~mtrr_cpuhotplug_cleanup include/asm-x86_64/proto.h
--- linux-2.6.12-mm1/include/asm-x86_64/proto.h~mtrr_cpuhotplug_cleanup	2005-06-23 20:06:54.000000000 +0800
+++ linux-2.6.12-mm1-root/include/asm-x86_64/proto.h	2005-06-28 13:33:28.000000000 +0800
@@ -15,6 +15,13 @@ extern void pda_init(int); 
 extern void early_idt_handler(void);
 
 extern void mcheck_init(struct cpuinfo_x86 *c);
+#ifdef CONFIG_MTRR
+extern void mtrr_ap_init(void);
+extern void mtrr_bp_init(void);
+#else
+#define mtrr_ap_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
+#endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
 
 extern void system_call(void); 
diff -puN arch/x86_64/kernel/suspend.c~mtrr_cpuhotplug_cleanup arch/x86_64/kernel/suspend.c
--- linux-2.6.12-mm1/arch/x86_64/kernel/suspend.c~mtrr_cpuhotplug_cleanup	2005-06-23 20:08:56.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/x86_64/kernel/suspend.c	2005-06-23 20:09:16.000000000 +0800
@@ -119,6 +119,7 @@ void __restore_processor_state(struct sa
 	fix_processor_context();
 
 	do_fpu_end();
+	mtrr_ap_init();
 }
 
 void restore_processor_state(void)
diff -puN arch/x86_64/kernel/setup.c~mtrr_cpuhotplug_cleanup arch/x86_64/kernel/setup.c
--- linux-2.6.12-mm1/arch/x86_64/kernel/setup.c~mtrr_cpuhotplug_cleanup	2005-06-23 20:09:32.000000000 +0800
+++ linux-2.6.12-mm1-root/arch/x86_64/kernel/setup.c	2005-06-23 20:10:11.000000000 +0800
@@ -1076,6 +1076,10 @@ void __cpuinit identify_cpu(struct cpuin
 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
 #endif
+	if (c == &boot_cpu_data)
+		mtrr_bp_init();
+	else
+		mtrr_ap_init();
 #ifdef CONFIG_NUMA
 	if (c != &boot_cpu_data)
 		numa_add_cpu(c - cpu_data);
_


