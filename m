Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVDDCIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVDDCIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVDDCIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:08:31 -0400
Received: from fmr17.intel.com ([134.134.136.16]:1411 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261970AbVDDCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:08:19 -0400
Subject: [RFC 1/6]SEP initialization rework
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:05:56 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make SEP init per-cpu, so is hotplug safe.

Thanks,
Shaohua

---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
 linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
 linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
--- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
+++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
@@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
 	int cpu = get_cpu();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
+	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+		put_cpu();
+		return;
+	}
+
 	tss->ss1 = __KERNEL_CS;
 	tss->esp1 = sizeof(struct tss_struct) + (unsigned long) tss;
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
@@ -41,7 +46,7 @@ void enable_sep_cpu(void *info)
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 
-static int __init sysenter_setup(void)
+int __init sysenter_setup(void)
 {
 	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
 
@@ -58,8 +63,5 @@ static int __init sysenter_setup(void)
 	       &vsyscall_sysenter_start,
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
-	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
-
-__initcall(sysenter_setup);
diff -puN arch/i386/kernel/smpboot.c~sep_init_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~sep_init_cleanup	2005-03-28 09:33:49.972288952 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-03-28 09:46:01.814032096 +0800
@@ -415,6 +415,8 @@ static void __init smp_callin(void)
 
 static int cpucount;
 
+extern int sysenter_setup(void);
+extern void enable_sep_cpu(void *);
 /*
  * Activate a secondary processor.
  */
@@ -445,6 +447,7 @@ static void __init start_secondary(void 
 
 	/* We can take interrupts now: we're officially "up". */
 	local_irq_enable();
+	enable_sep_cpu(NULL);
 
 	wmb();
 	cpu_idle();
@@ -913,6 +916,9 @@ static void __init smp_boot_cpus(unsigne
 	cpus_clear(cpu_sibling_map[0]);
 	cpu_set(0, cpu_sibling_map[0]);
 
+	sysenter_setup();
+	enable_sep_cpu(NULL);
+
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
diff -puN arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.11/arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup	2005-03-28 09:48:27.909822160 +0800
+++ linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c	2005-03-28 09:51:37.896939728 +0800
@@ -441,6 +441,8 @@ setup_trampoline(void)
 	return virt_to_phys((__u8 *)trampoline_base);
 }
 
+extern void enable_sep_cpu(void *);
+extern int sysenter_setup(void);
 /* Routine initially called when a non-boot CPU is brought online */
 static void __init
 start_secondary(void *unused)
@@ -499,6 +501,7 @@ start_secondary(void *unused)
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		rep_nop();
 	local_irq_enable();
+	enable_sep_cpu(NULL);
 
 	local_flush_tlb();
 
@@ -696,6 +699,9 @@ smp_boot_cpus(void)
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);
 
+	sysenter_setup();
+	enable_sep_cpu(NULL);
+
 	if(is_cpu_quad()) {
 		/* booting on a Quad CPU */
 		printk("VOYAGER SMP: Boot CPU is Quad\n");
_


