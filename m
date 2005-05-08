Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVEHD7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVEHD7B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVEHD7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:59:01 -0400
Received: from fmr18.intel.com ([134.134.136.17]:42669 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262811AbVEHD6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:58:12 -0400
Subject: Re: 2.6.12-rc3-mm1
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Coywolf Qi Hunt <coywolf@lovecn.org>, coywolf@gmail.com,
       zwane@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>, ak@muc.de,
       bunk@stusta.de
In-Reply-To: <20050430124611.54b5ab15.akpm@osdl.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <20050430142035.GB3571@stusta.de>
	 <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com>
	 <2cd57c9005043010051c6455fb@mail.gmail.com>
	 <20050430180823.GA14922@lovecn.org> <20050430124611.54b5ab15.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1115524388.8980.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 08 May 2005 11:53:09 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-01 at 03:46, Andrew Morton wrote:
> Thanks, guys.  I seem to have it limping along on UP now, partly with the
> below.
> 
> Li, it's a bit awkward to be calling things by hand on SMP and with an
> initcall on UP.  Maybe something neater can be done there.
Andrew, how about below one?

Thanks,
Shaohua



---

 linux-2.6.11-root/arch/i386/kernel/cpu/common.c        |    3 +++
 linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    5 -----
 linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ----------
 linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    4 ----
 linux-2.6.11-root/include/asm-i386/processor.h         |    1 +
 linux-2.6.11-root/include/asm-i386/smp.h               |    2 --
 6 files changed, 4 insertions(+), 21 deletions(-)

diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
--- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-05-08 10:50:05.266387824 +0800
+++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-05-08 11:12:05.610664984 +0800
@@ -65,13 +65,3 @@ int __init sysenter_setup(void)
 
 	return 0;
 }
-
-#ifndef CONFIG_SMP
-static int __init sysenter_sep_setup(void)
-{
-	sysenter_setup();
-	enable_sep_cpu();
-	return 0;
-}
-module_init(sysenter_sep_setup);
-#endif
diff -puN arch/i386/kernel/cpu/common.c~sep_init_cleanup arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c~sep_init_cleanup	2005-05-08 10:50:05.268387520 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/common.c	2005-05-08 10:50:05.275386456 +0800
@@ -428,6 +428,9 @@ void __devinit identify_cpu(struct cpuin
 #ifdef CONFIG_X86_MCE
 	machine_check_init(c);
 #endif
+	if (c == &boot_cpu_data)
+		sysenter_setup();
+	enable_sep_cpu();
 }
 
 #ifdef CONFIG_X86_HT
diff -puN arch/i386/kernel/smpboot.c~sep_init_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~sep_init_cleanup	2005-05-08 10:50:05.269387368 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-05-08 10:50:05.275386456 +0800
@@ -495,8 +495,6 @@ static void __devinit start_secondary(vo
 	set_cpu_sibling_map(_smp_processor_id());
 	wmb();
 
-	/* Note: this must be done before __cpu_up finish */
-	enable_sep_cpu();
 	cpu_set(smp_processor_id(), cpu_online_map);
 
 	/* We can take interrupts now: we're officially "up". */
@@ -1079,9 +1077,6 @@ static void __init smp_boot_cpus(unsigne
 	cpus_clear(cpu_core_map[0]);
 	cpu_set(0, cpu_core_map[0]);
 
-	sysenter_setup();
-	enable_sep_cpu();
-
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
diff -puN arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.11/arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup	2005-05-08 10:50:05.271387064 +0800
+++ linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c	2005-05-08 10:50:05.276386304 +0800
@@ -499,7 +499,6 @@ start_secondary(void *unused)
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		rep_nop();
 	local_irq_enable();
-	enable_sep_cpu();
 
 	local_flush_tlb();
 
@@ -697,9 +696,6 @@ smp_boot_cpus(void)
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);
 
-	sysenter_setup();
-	enable_sep_cpu();
-
 	if(is_cpu_quad()) {
 		/* booting on a Quad CPU */
 		printk("VOYAGER SMP: Boot CPU is Quad\n");
diff -puN include/asm-i386/smp.h~sep_init_cleanup include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~sep_init_cleanup	2005-05-08 11:12:29.334058480 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-05-08 11:12:42.703026088 +0800
@@ -37,8 +37,6 @@ extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 
-extern int sysenter_setup(void);
-
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
diff -puN include/asm-i386/processor.h~sep_init_cleanup include/asm-i386/processor.h
--- linux-2.6.11/include/asm-i386/processor.h~sep_init_cleanup	2005-05-08 11:12:51.875631640 +0800
+++ linux-2.6.11-root/include/asm-i386/processor.h	2005-05-08 11:13:22.290007952 +0800
@@ -694,5 +694,6 @@ extern void select_idle_routine(const st
 
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
+extern int sysenter_setup(void);
 
 #endif /* __ASM_I386_PROCESSOR_H */
_


