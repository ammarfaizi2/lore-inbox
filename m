Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUCOWjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUCOWjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:39:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:5552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbUCOWjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:39:05 -0500
Date: Mon, 15 Mar 2004 14:41:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: mingo@elte.hu, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
Message-Id: <20040315144103.7e349f5f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403151210110.28447@montezuma.fsmlabs.com>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
	<16469.2797.130561.885788@notabene.cse.unsw.edu.au>
	<20040315080929.GA19959@elte.hu>
	<Pine.LNX.4.58.0403151210110.28447@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Mon, 15 Mar 2004, Ingo Molnar wrote:
> 
> >
> > * Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > > And it turns out it was spot on. Applying 4g-2.6.0-test2-mm2-A5.patch
> > > (on top of preceding -mm1 patches) causes my server not to boot.
> >
> > weird. 2.6.4-mm2 boots fine here (both 4g and non-4g). Could you send me
> > your .config?
> >
> > (btw., 2.6.4-mm2 needs the attached trivial fix to compile.)
> 
> Yes actually it is scrogged, but i'm sceptical as to whether it is 4G/4G,
> here is a broken configuration.

Manfred found and fixed one bug, but that was newly added in mm2.


DEBUG_PAGEALLOC switches to nopentium mode: otherwise a change_page_attr
could cause a split of a 4 MB page, which could cause a gfp which might
deadlock.

Two parts of the cpu initialization cannot be done early: the f00f bug
workaround needs a working paging setup, and loops_per_jiffies is only
initialized after the timer is running.  And everything in setup_arch instead
of before start_kernel: The first printk line should be the "Linux verion xy"
line from start_kernel.


---

 25-akpm/arch/i386/kernel/cpu/common.c |   40 ++++++++++++++++++++++------------
 25-akpm/arch/i386/kernel/setup.c      |    3 --
 25-akpm/include/asm-i386/processor.h  |    2 -
 3 files changed, 29 insertions(+), 16 deletions(-)

diff -puN arch/i386/kernel/cpu/common.c~early-x86-cpu-detection-fix arch/i386/kernel/cpu/common.c
--- 25/arch/i386/kernel/cpu/common.c~early-x86-cpu-detection-fix	2004-03-15 11:36:05.144371392 -0800
+++ 25-akpm/arch/i386/kernel/cpu/common.c	2004-03-15 11:36:05.149370632 -0800
@@ -234,7 +234,7 @@ void __init generic_identify(struct cpui
 		if ( (xlvl & 0xffff0000) == 0x80000000 ) {
 			if ( xlvl >= 0x80000001 )
 				c->x86_capability[1] = cpuid_edx(0x80000001);
-			if ( xlvl >= 0x80000004)
+			if ( xlvl >= 0x80000004 )
 				get_model_name(c); /* Default name */
 		}
 	}
@@ -263,18 +263,22 @@ static int __init x86_serial_nr_setup(ch
 }
 __setup("serialnumber", x86_serial_nr_setup);
 
-void __init early_identify_cpu(struct cpuinfo_x86 *c)
+/*
+ * This does the hard work of actually picking apart the CPU stuff...
+ */
+void __init identify_cpu(struct cpuinfo_x86 *c)
 {
-	c->loops_per_jiffy = loops_per_jiffy;
+	int i;
+
 	c->x86_cache_size = -1;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->cpuid_level = -1;	/* CPUID not detected */
 	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
-	c->x86_clflush_size = 32;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
+	c->x86_clflush_size = 0;
 	if (!have_cpuid_p()) {
 		/* First of all, decide if this is a 486 or higher */
 		/* It's a 486 if we can modify the AC flag */
@@ -285,16 +289,14 @@ void __init early_identify_cpu(struct cp
 	}
 
 	generic_identify(c);
-}
-
-/*
- * This does the hard work of actually picking apart the CPU stuff...
- */
-void __init identify_cpu(struct cpuinfo_x86 *c)
-{
-	int i;
 
-	early_identify_cpu(c);
+	if (!c->x86_clflush_size) {
+		/* No cache line size autodetected - manual estimate: */
+		if (c->x86 <= 4)
+			c->x86_clflush_size = 16;
+		else
+			c->x86_clflush_size = 32;
+	}
 
 	printk(KERN_DEBUG "CPU:     After generic identify, caps: %08lx %08lx %08lx %08lx\n",
 		c->x86_capability[0],
@@ -382,7 +384,19 @@ void __init identify_cpu(struct cpuinfo_
 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
 #endif
+	late_identify_cpu(c);
+}
+
+void __init late_identify_cpu(struct cpuinfo_x86 *c)
+{
+	/*
+	 * The timer is not yet running when identify cpu is called for the
+	 * first cpu - check_bugs() calls late_identify_cpu and transfers
+	 * loops_per_jiffy from calibrate_delay into the cpu data area.
+	 */
+	c->loops_per_jiffy = loops_per_jiffy;
 }
+
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
  */
diff -puN arch/i386/kernel/setup.c~early-x86-cpu-detection-fix arch/i386/kernel/setup.c
--- 25/arch/i386/kernel/setup.c~early-x86-cpu-detection-fix	2004-03-15 11:36:05.145371240 -0800
+++ 25-akpm/arch/i386/kernel/setup.c	2004-03-15 11:36:05.150370480 -0800
@@ -1124,6 +1124,7 @@ void __init setup_arch(char **cmdline_p)
 
 	max_low_pfn = setup_memory();
 
+	identify_cpu(&boot_cpu_data);
 	/*
 	 * NOTE: before this point _nobody_ is allowed to allocate
 	 * any memory using the bootmem allocator.
@@ -1149,8 +1150,6 @@ void __init setup_arch(char **cmdline_p)
 
 	dmi_scan_machine();
 
-	early_identify_cpu(&boot_cpu_data);
-
 #ifdef CONFIG_X86_GENERICARCH
 	generic_apic_probe(*cmdline_p);
 #endif	
diff -puN include/asm-i386/processor.h~early-x86-cpu-detection-fix include/asm-i386/processor.h
--- 25/include/asm-i386/processor.h~early-x86-cpu-detection-fix	2004-03-15 11:36:05.147370936 -0800
+++ 25-akpm/include/asm-i386/processor.h	2004-03-15 11:36:05.151370328 -0800
@@ -98,6 +98,7 @@ extern struct cpuinfo_x86 cpu_data[];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
+extern void late_identify_cpu(struct cpuinfo_x86 *c);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern void dodgy_tsc(void);
 
@@ -653,6 +654,5 @@ extern void select_idle_routine(const st
 #endif
 
 #define cache_line_size() (boot_cpu_data.x86_clflush_size)
-extern void early_identify_cpu(struct cpuinfo_x86 *c);
 
 #endif /* __ASM_I386_PROCESSOR_H */

_

