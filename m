Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUIMFId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUIMFId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 01:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUIMFId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 01:08:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:39553 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266009AbUIMFG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 01:06:26 -0400
Subject: vDSO for ppc64 : Preliminary release #5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Alan Modra <amodra@bigpond.net.au>, Ulrich Drepper <drepper@redhat.com>,
       Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain
Message-Id: <1095051764.2664.267.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 15:02:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a 5th drop of the ppc64 vdso, changes from #4 are fixed Makefile's
and a new version of the CFI informations for signal trampolines by
Alan.

I'm now waiting for something to happen on the glibc side...

Ben.


diff -urN linux-2.5/arch/ppc64/Makefile linux-vdso/arch/ppc64/Makefile
--- linux-2.5/arch/ppc64/Makefile	2004-08-26 15:46:30.000000000 +1000
+++ linux-vdso/arch/ppc64/Makefile	2004-08-27 13:07:59.000000000 +1000
@@ -43,6 +43,8 @@
 
 libs-y				+= arch/ppc64/lib/
 core-y				+= arch/ppc64/kernel/
+core-y				+= arch/ppc64/kernel/vdso32/
+core-y				+= arch/ppc64/kernel/vdso64/
 core-y				+= arch/ppc64/mm/
 core-$(CONFIG_XMON)		+= arch/ppc64/xmon/
 drivers-$(CONFIG_OPROFILE)	+= arch/ppc64/oprofile/
diff -urN linux-2.5/arch/ppc64/kernel/Makefile linux-vdso/arch/ppc64/kernel/Makefile
--- linux-2.5/arch/ppc64/kernel/Makefile	2004-08-26 15:46:30.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/Makefile	2004-09-07 18:25:37.000000000 +1000
@@ -11,7 +11,7 @@
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
 			ptrace32.o signal32.o rtc.o init_task.o \
 			lmb.o cputable.o cpu_setup_power4.o idle_power4.o \
-			iommu.o sysfs.o vio.o
+			iommu.o sysfs.o vio.o vdso.o
 
 obj-$(CONFIG_PPC_OF) +=	of_device.o
 
diff -urN linux-2.5/arch/ppc64/kernel/asm-offsets.c linux-vdso/arch/ppc64/kernel/asm-offsets.c
--- linux-2.5/arch/ppc64/kernel/asm-offsets.c	2004-09-09 17:33:52.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/asm-offsets.c	2004-09-10 16:14:48.000000000 +1000
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/time.h>
 #include <linux/hardirq.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -36,6 +37,8 @@
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/cputable.h>
+#include <asm/systemcfg.h>
+#include <asm/compat.h>
 
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -170,5 +173,24 @@
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
+	/* systemcfg offsets for use by vdso */
+	DEFINE(CFG_TB_ORIG_STAMP, offsetof(struct systemcfg, tb_orig_stamp));
+	DEFINE(CFG_TB_TICKS_PER_SEC, offsetof(struct systemcfg, tb_ticks_per_sec));
+	DEFINE(CFG_TB_TO_XS, offsetof(struct systemcfg, tb_to_xs));
+	DEFINE(CFG_STAMP_XSEC, offsetof(struct systemcfg, stamp_xsec));
+	DEFINE(CFG_TB_UPDATE_COUNT, offsetof(struct systemcfg, tb_update_count));
+	DEFINE(CFG_TZ_MINUTEWEST, offsetof(struct systemcfg, tz_minuteswest));
+	DEFINE(CFG_TZ_DSTTIME, offsetof(struct systemcfg, tz_dsttime));
+	DEFINE(CFG_SYSCALL_MAP32, offsetof(struct systemcfg, syscall_map_32));
+	DEFINE(CFG_SYSCALL_MAP64, offsetof(struct systemcfg, syscall_map_64));
+
+	/* timeval/timezone offsets for use by vdso */
+	DEFINE(TVAL64_TV_SEC, offsetof(struct timeval, tv_sec));
+	DEFINE(TVAL64_TV_USEC, offsetof(struct timeval, tv_usec));
+	DEFINE(TVAL32_TV_SEC, offsetof(struct compat_timeval, tv_sec));
+	DEFINE(TVAL32_TV_USEC, offsetof(struct compat_timeval, tv_usec));
+	DEFINE(TZONE_TZ_MINWEST, offsetof(struct timezone, tz_minuteswest));
+	DEFINE(TZONE_TZ_DSTTIME, offsetof(struct timezone, tz_dsttime));
+
 	return 0;
 }
diff -urN linux-2.5/arch/ppc64/kernel/setup.c linux-vdso/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2004-09-09 17:33:52.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/setup.c	2004-09-10 16:14:48.000000000 +1000
@@ -375,6 +375,7 @@
 	printk("naca->debug_switch            = 0x%lx\n", naca->debug_switch);
 	printk("naca->interrupt_controller    = 0x%ld\n", naca->interrupt_controller);
 	printk("systemcfg                     = 0x%p\n", systemcfg);
+	printk("systemcfg size                = 0x%d\n", (int)sizeof(struct systemcfg));
 	printk("systemcfg->processorCount     = 0x%lx\n", systemcfg->processorCount);
 	printk("systemcfg->physicalMemorySize = 0x%lx\n", systemcfg->physicalMemorySize);
 	printk("systemcfg->dCacheL1LineSize   = 0x%x\n", systemcfg->dCacheL1LineSize);
@@ -744,6 +745,34 @@
 }
 
 /*
+ * Called from setup_arch to initialize the bitmap of available
+ * syscalls in the systemcfg page
+ */
+void __init setup_syscall_map(void)
+{
+	unsigned int i, count64 = 0, count32 = 0;
+	extern unsigned long *sys_call_table;
+	extern unsigned long *sys_call_table32;
+	extern unsigned long sys_ni_syscall;
+
+
+	for (i = 0; i < __NR_syscalls; i++) {
+		if (sys_call_table[i] == sys_ni_syscall)
+			continue;
+		count64++;
+		systemcfg->syscall_map_64[i >> 5] |= 0x80000000UL >> (i & 0x1f);
+	}
+	for (i = 0; i < __NR_syscalls; i++) {
+		if (sys_call_table32[i] == sys_ni_syscall)
+			continue;
+		count32++;
+		systemcfg->syscall_map_32[i >> 5] |= 0x80000000UL >> (i & 0x1f);
+	}
+	printk(KERN_INFO "Syscall map setup, %d 32 bits and %d 64 bits syscalls\n",
+	       count32, count64);
+}
+
+/*
  * Called into from start_kernel, after lock_kernel has been called.
  * Initializes bootmem, which is unsed to manage page allocation until
  * mem_init is called.
@@ -794,9 +823,13 @@
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 
+	/* initialize the syscall map in systemcfg */
+	setup_syscall_map();
+
 	ppc_md.setup_arch();
 
 	paging_init();
+
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
diff -urN linux-2.5/arch/ppc64/kernel/signal.c linux-vdso/arch/ppc64/kernel/signal.c
--- linux-2.5/arch/ppc64/kernel/signal.c	2004-08-26 15:46:30.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/signal.c	2004-09-07 18:25:41.000000000 +1000
@@ -34,6 +34,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/vdso.h>
 
 #define DEBUG_SIG 0
 
@@ -412,10 +413,14 @@
 		goto badframe;
 
 	/* Set up to return from userspace. */
-	err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
-	if (err)
-		goto badframe;
-
+	if (vdso64_rt_sigtramp && current->thread.vdso_base) {
+		regs->link = current->thread.vdso_base + vdso64_rt_sigtramp;
+	} else {
+		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
+		if (err)
+			goto badframe;
+		regs->link = (unsigned long) &frame->tramp[0];
+	}
 	funct_desc_ptr = (func_descr_t __user *) ka->sa.sa_handler;
 
 	/* Allocate a dummy caller frame for the signal handler. */
@@ -424,7 +429,6 @@
 
 	/* Set up "regs" so we "return" to the signal handler. */
 	err |= get_user(regs->nip, &funct_desc_ptr->entry);
-	regs->link = (unsigned long) &frame->tramp[0];
 	regs->gpr[1] = newsp;
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
diff -urN linux-2.5/arch/ppc64/kernel/signal32.c linux-vdso/arch/ppc64/kernel/signal32.c
--- linux-2.5/arch/ppc64/kernel/signal32.c	2004-08-26 15:46:30.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/signal32.c	2004-09-09 17:05:06.000000000 +1000
@@ -30,6 +30,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/vdso.h>
 
 #define DEBUG_SIG 0
 
@@ -677,18 +678,24 @@
 
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	if (save_user_regs(regs, frame, __NR_rt_sigreturn))
-		goto badframe;
-
 	if (put_user(regs->gpr[1], (unsigned long __user *)newsp))
 		goto badframe;
+
+	if (vdso32_rt_sigtramp && current->thread.vdso_base) {
+		if (save_user_regs(regs, frame, 0))
+			goto badframe;
+		regs->link = current->thread.vdso_base + vdso32_rt_sigtramp;
+	} else {
+		if (save_user_regs(regs, frame, __NR_rt_sigreturn))
+			goto badframe;
+		regs->link = (unsigned long) frame->tramp;
+	}
 	regs->gpr[1] = (unsigned long) newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
-	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 	regs->result = 0;
 
@@ -842,8 +849,15 @@
 	    || __put_user(sig, &sc->signal))
 		goto badframe;
 
-	if (save_user_regs(regs, &frame->mctx, __NR_sigreturn))
-		goto badframe;
+	if (vdso32_sigtramp && current->thread.vdso_base) {
+		if (save_user_regs(regs, &frame->mctx, 0))
+			goto badframe;
+		regs->link = current->thread.vdso_base + vdso32_sigtramp;
+	} else {
+		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn))
+			goto badframe;
+		regs->link = (unsigned long) frame->mctx.tramp;
+	}
 
 	if (put_user(regs->gpr[1], (unsigned long __user *)newsp))
 		goto badframe;
@@ -851,7 +865,6 @@
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
-	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 	regs->result = 0;
 
diff -urN linux-2.5/arch/ppc64/kernel/smp.c linux-vdso/arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c	2004-09-09 17:33:52.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/smp.c	2004-09-09 17:56:36.000000000 +1000
@@ -784,7 +784,7 @@
 	 * For now we leave it which means the time can be some
 	 * number of msecs off until someone does a settimeofday()
 	 */
-	do_gtod.tb_orig_stamp = tb_last_stamp;
+	do_gtod.varp->tb_orig_stamp = tb_last_stamp;
 	systemcfg->tb_orig_stamp = tb_last_stamp;
 #endif
 
diff -urN linux-2.5/arch/ppc64/kernel/time.c linux-vdso/arch/ppc64/kernel/time.c
--- linux-2.5/arch/ppc64/kernel/time.c	2004-09-13 13:17:33.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/time.c	2004-09-13 14:41:51.000000000 +1000
@@ -158,6 +158,51 @@
 	}
 }
 
+/*
+ * When the timebase - tb_orig_stamp gets too big, we do a manipulation
+ * between tb_orig_stamp and stamp_xsec. The goal here is to keep the
+ * difference tb - tb_orig_stamp small enough to always fit inside a
+ * 32 bits number. This is a requirement of our fast 32 bits userland
+ * implementation in the vdso. If we "miss" a call to this function
+ * (interrupt latency, CPU locked in a spinlock, ...) and we end up
+ * with a too big difference, then the vdso will fallback to calling
+ * the syscall
+ */ 
+static __inline__ void timer_recalc_offset( unsigned long cur_tb )
+{
+	struct gettimeofday_vars * temp_varp;
+	unsigned temp_idx;
+	unsigned long offset, new_stamp_xsec, new_tb_orig_stamp;
+
+	if (((cur_tb - do_gtod.varp->tb_orig_stamp) & 0x80000000u) == 0)
+		return;
+
+	if (do_gtod.var_idx == 0) {
+		temp_varp = &do_gtod.vars[1];
+		temp_idx  = 1;
+	} else {
+		temp_varp = &do_gtod.vars[0];
+		temp_idx  = 0;
+	}
+
+	new_tb_orig_stamp = cur_tb;
+	offset = new_tb_orig_stamp - do_gtod.varp->tb_orig_stamp;
+	new_stamp_xsec = do_gtod.varp->stamp_xsec + mulhdu(offset, do_gtod.varp->tb_to_xs);
+
+	temp_varp->tb_orig_stamp = new_tb_orig_stamp;
+	temp_varp->stamp_xsec = new_stamp_xsec;
+	mb();
+	do_gtod.varp = temp_varp;
+	do_gtod.var_idx = temp_idx;
+
+	++(systemcfg->tb_update_count);
+	wmb();
+	systemcfg->tb_orig_stamp = new_tb_orig_stamp;
+	systemcfg->stamp_xsec = new_stamp_xsec;
+	wmb();
+	++(systemcfg->tb_update_count);
+}
+
 #ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -277,6 +322,7 @@
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
+			timer_recalc_offset( cur_tb );
 			timer_sync_xtime( cur_tb );
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
@@ -330,8 +376,8 @@
 	 * if done in units of 1/2^20 rather than microseconds.
 	 * The conversion to microseconds at the end is done
 	 * without a divide (and in fact, without a multiply) */
-	tb_ticks = get_tb() - do_gtod.tb_orig_stamp;
 	temp_varp = do_gtod.varp;
+	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;
 	temp_tb_to_xs = temp_varp->tb_to_xs;
 	temp_stamp_xsec = temp_varp->stamp_xsec;
 	tb_xsec = mulhdu( tb_ticks, temp_tb_to_xs );
@@ -393,7 +439,9 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	delta_xsec = mulhdu( (tb_last_stamp-do_gtod.tb_orig_stamp), do_gtod.varp->tb_to_xs );
+	delta_xsec = mulhdu( (tb_last_stamp-do_gtod.varp->tb_orig_stamp),
+			     do_gtod.varp->tb_to_xs );
+
 	new_xsec = (new_nsec * XSEC_PER_SEC) / NSEC_PER_SEC;
 	new_xsec += new_sec * XSEC_PER_SEC;
 	if ( new_xsec > delta_xsec ) {
@@ -406,7 +454,7 @@
 		 * before 1970 ... eg. we booted ten days ago, and we are setting
 		 * the time to Jan 5, 1970 */
 		do_gtod.varp->stamp_xsec = new_xsec;
-		do_gtod.tb_orig_stamp = tb_last_stamp;
+		do_gtod.varp->tb_orig_stamp = tb_last_stamp;
 		systemcfg->stamp_xsec = new_xsec;
 		systemcfg->tb_orig_stamp = tb_last_stamp;
 	}
@@ -509,9 +557,9 @@
 	xtime.tv_sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			      tm.tm_hour, tm.tm_min, tm.tm_sec);
 	tb_last_stamp = get_tb();
-	do_gtod.tb_orig_stamp = tb_last_stamp;
 	do_gtod.varp = &do_gtod.vars[0];
 	do_gtod.var_idx = 0;
+	do_gtod.varp->tb_orig_stamp = tb_last_stamp;
 	do_gtod.varp->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
 	do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 	do_gtod.varp->tb_to_xs = tb_to_xs;
@@ -629,12 +677,12 @@
 	   stamp_xsec which is the time (in 1/2^20 second units) corresponding to tb_orig_stamp.  This 
 	   new value of stamp_xsec compensates for the change in frequency (implied by the new tb_to_xs)
 	   which guarantees that the current time remains the same */ 
-	tb_ticks = get_tb() - do_gtod.tb_orig_stamp;
+	write_seqlock_irqsave( &xtime_lock, flags );
+	tb_ticks = get_tb() - do_gtod.varp->tb_orig_stamp;
 	div128_by_32( 1024*1024, 0, new_tb_ticks_per_sec, &divres );
 	new_tb_to_xs = divres.result_low;
 	new_xsec = mulhdu( tb_ticks, new_tb_to_xs );
 
-	write_seqlock_irqsave( &xtime_lock, flags );
 	old_xsec = mulhdu( tb_ticks, do_gtod.varp->tb_to_xs );
 	new_stamp_xsec = do_gtod.varp->stamp_xsec + old_xsec - new_xsec;
 
diff -urN linux-2.5/arch/ppc64/kernel/vdso.c linux-vdso/arch/ppc64/kernel/vdso.c
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso.c	2004-09-10 16:14:48.000000000 +1000
@@ -0,0 +1,476 @@
+/*
+ *  linux/arch/ppc64/kernel/vdso.c
+ *
+ *    Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/elf.h>
+#include <linux/security.h>
+#include <linux/bootmem.h>
+
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/mmu.h>
+#include <asm/mmu_context.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/sections.h>
+#include <asm/vdso.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+
+/*
+ * The vDSOs themselves are here
+ */ 
+extern char vdso64_start, vdso64_end;
+extern char vdso32_start, vdso32_end;
+
+static void *vdso64_kbase = &vdso64_start;
+static void *vdso32_kbase = &vdso32_start;
+
+unsigned int vdso64_pages;
+unsigned int vdso32_pages;
+
+/* Signal trampolines user addresses */
+
+unsigned long vdso64_rt_sigtramp;
+unsigned long vdso32_sigtramp;
+unsigned long vdso32_rt_sigtramp;
+
+/*
+ * Some infos carried around for each of them during parsing at
+ * boot time.
+ */
+struct lib32_elfinfo
+{
+	Elf32_Ehdr	*hdr;		/* ptr to ELF */
+	Elf32_Sym	*dynsym;	/* ptr to .dynsym section */
+	unsigned long	dynsymsize;	/* size of .dynsym section */
+	char		*dynstr;	/* ptr to .dynstr section */
+	unsigned long	text;		/* offset of .text section in .so */
+};
+
+struct lib64_elfinfo
+{
+	Elf64_Ehdr	*hdr;
+	Elf64_Sym	*dynsym;
+	unsigned long	dynsymsize;
+	char		*dynstr;
+	unsigned long	text;
+};
+
+
+#ifdef __DEBUG
+static void dump_one_vdso_page(struct page *pg, struct page *upg)
+{
+	printk("kpg: %p (c:%d,f:%08lx)", __va(page_to_pfn(pg) << PAGE_SHIFT),
+	       page_count(pg),
+	       pg->flags);
+	if (upg/* && pg != upg*/) {
+		printk(" upg: %p (c:%d,f:%08lx)", __va(page_to_pfn(upg) << PAGE_SHIFT),
+		       page_count(upg),
+		       upg->flags);
+	}
+	printk("\n");
+}
+
+static void dump_vdso_pages(struct vm_area_struct * vma)
+{
+	int i;
+
+	if (!vma || test_thread_flag(TIF_32BIT)) {
+		printk("vDSO32 @ %016lx:\n", (unsigned long)vdso32_kbase);
+		for (i=0; i<vdso32_pages; i++) {
+			struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
+			struct page *upg = (vma && vma->vm_mm) ?
+				follow_page(vma->vm_mm, vma->vm_start + i*PAGE_SIZE, 0)
+				: NULL;
+			dump_one_vdso_page(pg, upg);
+		}
+	}
+	if (!vma || !test_thread_flag(TIF_32BIT)) {
+		printk("vDSO64 @ %016lx:\n", (unsigned long)vdso64_kbase);
+		for (i=0; i<vdso64_pages; i++) {
+			struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
+			struct page *upg = (vma && vma->vm_mm) ?
+				follow_page(vma->vm_mm, vma->vm_start + i*PAGE_SIZE, 0)
+				: NULL;
+			dump_one_vdso_page(pg, upg);
+		}
+	}
+}
+#endif /* DEBUG */
+
+/*
+ * Keep a dummy vma_close for now, it will prevent VMA merging.
+ */
+static void vdso_vma_close(struct vm_area_struct * vma)
+{
+}
+
+/*
+ * Our nopage() function, maps in the actual vDSO kernel pages, they will
+ * be mapped read-only by do_no_page(), and eventually COW'ed, either
+ * right away for an initial write access, or by do_wp_page().
+ */
+static struct page * vdso_vma_nopage(struct vm_area_struct * vma,
+				     unsigned long address, int *type)
+{
+	unsigned long offset = address - vma->vm_start;
+	struct page *pg;
+	void *vbase = test_thread_flag(TIF_32BIT) ? vdso32_kbase : vdso64_kbase;
+
+	DBG("vdso_vma_nopage(current: %s, address: %016lx, off: %lx)\n",
+	    current->comm, address, offset);
+
+	if (address < vma->vm_start || address > vma->vm_end)
+		return NOPAGE_SIGBUS;
+
+	/*
+	 * Last page is systemcfg, special handling here, no get_page() a
+	 * this is a reserved page
+	 */
+	if ((vma->vm_end - address) <= PAGE_SIZE)
+		return virt_to_page(SYSTEMCFG_VIRT_ADDR);
+	
+	pg = virt_to_page(vbase + offset);
+	get_page(pg);
+	DBG(" ->page count: %d\n", page_count(pg));
+
+	return pg;
+}
+
+static struct vm_operations_struct vdso_vmops = {
+	.close	= vdso_vma_close,
+	.nopage	= vdso_vma_nopage,
+};
+
+/*
+ * This is called from binfmt_elf, we create the special vma for the
+ * vDSO and insert it into the mm struct tree
+ */
+int arch_setup_additional_pages(struct linux_binprm *bprm, int executable_stack)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long vdso_pages;
+	unsigned long vdso_base;
+
+	if (test_thread_flag(TIF_32BIT)) {
+		vdso_pages = vdso32_pages;
+		vdso_base = VDSO32_BASE;
+	} else {
+		vdso_pages = vdso64_pages;
+		vdso_base = VDSO64_BASE;
+	}
+
+	/* vDSO has a problem and was disabled, just don't "enable" it for the
+	 * process
+	 */
+	if (vdso_pages == 0) {
+		current->thread.vdso_base = 0;
+		return 0;
+	}
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (vma == NULL)
+		return -ENOMEM;
+	if (security_vm_enough_memory(vdso_pages)) {
+		kmem_cache_free(vm_area_cachep, vma);
+		return -ENOMEM;
+	}
+	memset(vma, 0, sizeof(*vma));
+
+	/*
+	 * pick a base address for the vDSO in process space. We have a default
+	 * base of 1Mb on which we had a random offset up to 1Mb.
+	 * XXX: Add possibility for a program header to specify that location
+	 */
+	current->thread.vdso_base = vdso_base 
+		+ 0xaa000;/* + ((unsigned long)vma & 0x000ff000); */
+
+	vma->vm_mm = mm;
+	vma->vm_start = current->thread.vdso_base;
+
+	/*
+	 * the VMA size is one page more than the vDSO since systemcfg
+	 * is mapped in the last one
+	 */
+	vma->vm_end = vma->vm_start + ((vdso_pages + 1) << PAGE_SHIFT);
+
+	/*
+	 * our vma flags don't have VM_WRITE so by default, the process isn't allowed
+	 * to write those pages.
+	 * gdb can break that with ptrace interface, and thus trigger COW on those
+	 * pages but it's then your responsibility to never do that on the "data" page
+	 * of the vDSO or you'll stop getting kernel updates and your nice userland
+	 * gettimeofday will be totally dead. It's fine to use that for setting
+	 * breakpoints in the vDSO code pages though
+	 */
+	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
+	vma->vm_ops = &vdso_vmops;
+
+	down_write(&mm->mmap_sem);
+	insert_vm_struct(mm, vma);
+	mm->total_vm += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	up_write(&mm->mmap_sem);
+
+	return 0;
+}
+
+static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
+				  unsigned long *size)
+{
+	Elf32_Shdr *sechdrs;
+	unsigned int i;
+	char *secnames;
+
+	/* Grab section headers and strings so we can tell who is who */
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+	secnames = (void *)ehdr + sechdrs[ehdr->e_shstrndx].sh_offset;
+
+	/* Find the section they want */
+	for (i = 1; i < ehdr->e_shnum; i++) {
+		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
+			if (size)
+				*size = sechdrs[i].sh_size;
+			return (void *)ehdr + sechdrs[i].sh_offset;
+		}
+	}
+	*size = 0;
+	return NULL;
+}
+
+static void * __init find_section64(Elf64_Ehdr *ehdr, const char *secname,
+				  unsigned long *size)
+{
+	Elf64_Shdr *sechdrs;
+	unsigned int i;
+	char *secnames;
+
+	/* Grab section headers and strings so we can tell who is who */
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+	secnames = (void *)ehdr + sechdrs[ehdr->e_shstrndx].sh_offset;
+
+	/* Find the section they want */
+	for (i = 1; i < ehdr->e_shnum; i++) {
+		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
+			if (size)
+				*size = sechdrs[i].sh_size;
+			return (void *)ehdr + sechdrs[i].sh_offset;
+		}
+	}
+	if (size)
+		*size = 0;
+	return NULL;
+}
+
+static Elf32_Sym * __init find_symbol32(struct lib32_elfinfo *lib, const char *symname)
+{
+	unsigned int i;
+
+	for (i = 0; i < (lib->dynsymsize / sizeof(Elf32_Sym)); i++) {
+		if (lib->dynsym[i].st_name == 0)
+			continue;
+		if (strcmp(symname, lib->dynstr + lib->dynsym[i].st_name) == 0)
+			return &lib->dynsym[i];
+	}
+	return NULL;
+}
+
+static Elf64_Sym * __init find_symbol64(struct lib64_elfinfo *lib, const char *symname)
+{
+	unsigned int i;
+
+	for (i = 0; i < (lib->dynsymsize / sizeof(Elf64_Sym)); i++) {
+		if (lib->dynsym[i].st_name == 0)
+			continue;
+		if (strcmp(symname, lib->dynstr + lib->dynsym[i].st_name) == 0)
+			return &lib->dynsym[i];
+	}
+	return NULL;
+}
+
+/* Note that we assume the section is .text and the symbol is relative to
+ * the library base
+ */
+static unsigned long __init find_function32(struct lib32_elfinfo *lib, const char *symname)
+{
+	Elf32_Sym *sym = find_symbol32(lib, symname);
+
+	if (sym == NULL) {
+		printk(KERN_WARNING "vDSO32: function %s not found !\n", symname);
+		return 0;
+	}
+	return sym->st_value - VDSO32_BASE;
+}
+
+/* Note that we assume the section is .text and the symbol is relative to
+ * the library base
+ */
+static unsigned long __init find_function64(struct lib64_elfinfo *lib, const char *symname)
+{
+	Elf64_Sym *sym = find_symbol64(lib, symname);
+
+	if (sym == NULL) {
+		printk(KERN_WARNING "vDSO64: function %s not found !\n", symname);
+		return 0;
+	}
+	return sym->st_value - VDSO64_BASE;
+}
+
+
+static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
+					struct lib64_elfinfo *v64)
+{
+	void *sect;
+
+	/*
+	 * Locate symbol tables & text section
+	 */
+
+	v32->dynsym = find_section32(v32->hdr, ".dynsym", &v32->dynsymsize);
+	v32->dynstr = find_section32(v32->hdr, ".dynstr", NULL);
+	if (v32->dynsym == NULL || v32->dynstr == NULL) {
+		printk(KERN_ERR "vDSO32: a required symbol section was not found\n");
+		return -1;
+	}
+	sect = find_section32(v32->hdr, ".text", NULL);
+	if (sect == NULL) {
+		printk(KERN_ERR "vDSO32: the .text section was not found\n");
+		return -1;
+	}
+	v32->text = sect - vdso32_kbase;
+
+	v64->dynsym = find_section64(v64->hdr, ".dynsym", &v64->dynsymsize);
+	v64->dynstr = find_section64(v64->hdr, ".dynstr", NULL);
+	if (v64->dynsym == NULL || v64->dynstr == NULL) {
+		printk(KERN_ERR "vDSO64: a required symbol section was not found\n");
+		return -1;
+	}
+	sect = find_section64(v64->hdr, ".text", NULL);
+	if (sect == NULL) {
+		printk(KERN_ERR "vDSO64: the .text section was not found\n");
+		return -1;
+	}
+	v64->text = sect - vdso64_kbase;
+
+	return 0;
+}
+
+static __init void vdso_setup_trampolines(struct lib32_elfinfo *v32,
+					  struct lib64_elfinfo *v64)
+{
+	/*
+	 * Find signal trampolines
+	 */
+
+	vdso64_rt_sigtramp	= find_function64(v64, "__v_sigtramp_rt64");
+	vdso32_sigtramp		= find_function32(v32, "__v_sigtramp32");
+	vdso32_rt_sigtramp	= find_function32(v32, "__v_sigtramp_rt32");
+}
+
+static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
+				       struct lib64_elfinfo *v64)
+{
+	Elf32_Sym *sym32;
+	Elf64_Sym *sym64;
+
+	sym32 = find_symbol32(v32, "__v_datapage_offset");
+	if (sym32 == NULL) {
+		printk(KERN_ERR "vDSO32: Can't find symbol __v_datapage_offset !\n");
+		return -1;
+	}
+	*((int *)(vdso32_kbase + (sym32->st_value - VDSO32_BASE))) =
+		(vdso32_pages << PAGE_SHIFT) - (sym32->st_value - VDSO32_BASE);
+
+       	sym64 = find_symbol64(v64, "__v_datapage_offset");
+	if (sym64 == NULL) {
+		printk(KERN_ERR "vDSO64: Can't find symbol __v_datapage_offset !\n");
+		return -1;
+	}
+	*((int *)(vdso64_kbase + sym64->st_value - VDSO64_BASE)) =
+		(vdso64_pages << PAGE_SHIFT) - (sym64->st_value - VDSO64_BASE);
+
+	return 0;
+}
+
+static __init int vdso_setup(void)
+{
+	struct lib32_elfinfo	v32;
+	struct lib64_elfinfo	v64;
+
+	v32.hdr = vdso32_kbase;
+	v64.hdr = vdso64_kbase;
+
+	if (vdso_do_find_sections(&v32, &v64))
+		return -1;
+
+	if (vdso_fixup_datapage(&v32, &v64))
+		return -1;
+
+	vdso_setup_trampolines(&v32, &v64);
+
+	return 0;
+}
+
+void __init vdso_init(void)
+{
+	int i;
+
+	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
+	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
+
+	DBG("vdso64_kbase: %p, 0x%x pages, vdso32_kbase: %p, 0x%x pages\n",
+	       vdso64_kbase, vdso64_pages, vdso32_kbase, vdso32_pages);
+
+	/*
+	 * Initialize the vDSO images in memory, that is do necessary
+	 * fixups of vDSO symbols, locate trampolines, etc...
+	 */
+	if (vdso_setup()) {
+		printk(KERN_ERR "vDSO setup failure, not enabled !\n");
+		/* XXX should free pages here ? */
+		vdso64_pages = vdso32_pages = 0;
+		return;
+	}
+
+	/* Make sure pages are in the correct state */
+	for (i = 0; i < vdso64_pages; i++) {
+		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
+		ClearPageReserved(pg);
+		get_page(pg);
+	}
+	for (i = 0; i < vdso32_pages; i++) {
+		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
+		ClearPageReserved(pg);
+		get_page(pg);
+	}
+}
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/Makefile linux-vdso/arch/ppc64/kernel/vdso32/Makefile
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/Makefile	2004-09-13 14:11:43.000000000 +1000
@@ -0,0 +1,50 @@
+# Choose compiler
+#
+# XXX FIXME: We probably want to enforce using a biarch compiler by default
+#             and thus use (CC) with -m64, while letting the user pass a
+#             CROSS32_COMPILE prefix if wanted. Same goes for the zImage
+#             wrappers
+#
+
+CROSS32_COMPILE ?=
+
+CROSS32CC		:= $(CROSS32_COMPILE)gcc
+CROSS32AS		:= $(CROSS32_COMPILE)as
+
+# List of files in the vdso, has to be asm only for now
+
+src-vdso32 = sigtramp.S gettimeofday.S datapage.S
+
+# Build rules
+
+obj-vdso32 := $(addsuffix .o, $(basename $(src-vdso32)))
+targets := $(obj-vdso32) vdso32.so
+obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
+src-vdso32 := $(addprefix $(src)/, $(src-vdso32))
+
+
+EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin
+EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1
+EXTRA_AFLAGS := -D__VDSO32__ -s
+
+obj-y += vdso32_wrapper.o
+extra-y += vdso32.lds
+CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32)
+	$(call if_changed,vdso32ld)
+
+# assembly rules for the .S files
+$(obj-vdso32): %.o: %.S
+	$(call if_changed_dep,vdso32as)
+
+# actual build commands
+quiet_cmd_vdso32ld = VDSO32L $@
+      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdso32as = VDSO32A $@
+      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
+
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/datapage.S linux-vdso/arch/ppc64/kernel/vdso32/datapage.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/datapage.S	2004-09-10 16:14:48.000000000 +1000
@@ -0,0 +1,53 @@
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+	.text
+V_FUNCTION_BEGIN(__v_get_datapage)
+	/* We don't want that exposed or overridable as we want other objects
+	 * to be able to bl directly to here
+	 */
+	.protected __v_get_datapage
+	.hidden __v_get_datapage
+
+	mflr	r0
+  .cfi_register lr,r0
+
+	bcl	20,31,1f
+	.global	__v_datapage_offset;
+__v_datapage_offset:
+	.long	0
+1:
+	mflr	r3
+	mtlr	r0
+	lwz	r0,0(r3)
+	add	r3,r0,r3
+	blr
+V_FUNCTION_END(__v_get_datapage)
+
+/*
+ * void *_v_get_syscall_map(unsigned int *syscall_count) ;
+ *
+ * returns a pointer to the syscall map. the map is agnostic to the
+ * size of "long", unlike kernel bitops, it stores bits from top to
+ * bottom so that memory actually contains a linear bitmap
+ * check for syscall N by testing bit (0x80000000 >> (N & 0x1f)) of
+ * 32 bits int at N >> 5.
+ */
+V_FUNCTION_BEGIN(_v_get_syscall_map)
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r4,r3
+	bl	__v_get_datapage
+	mtlr	r12
+	addi	r3,r3,CFG_SYSCALL_MAP32
+	cmpli	cr0,r4,0
+	beqlr
+	li	r0,__NR_syscalls
+	stw	r0,0(r4)
+	blr
+V_FUNCTION_END(_v_get_syscall_map)
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/gettimeofday.S linux-vdso/arch/ppc64/kernel/vdso32/gettimeofday.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/gettimeofday.S	2004-09-10 16:14:48.000000000 +1000
@@ -0,0 +1,137 @@
+/*
+ * Userland implementation of gettimeofday() for 32 bits processes in a
+ * ppc64 kernel for use in the vDSO
+ *
+ * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org), IBM Corp.
+ *  
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+#include <asm/offsets.h>
+#include <asm/unistd.h>
+
+	.text
+/*
+ * Exact prototype of gettimeofday
+ *
+ * int _v_gettimeofday(struct timeval *tv, struct timezone *tz);
+ *
+ */
+V_FUNCTION_BEGIN(_v_gettimeofday)
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r10,r3			/* r10 saves tv */
+	mr	r11,r4			/* r11 saves tz */
+	bl	__v_get_datapage	/* get data page */
+	mr	r9, r3			/* datapage ptr in r9 */
+	bl	__v_do_get_xsec		/* get xsec from tb & kernel */
+	bne-	2f			/* out of line -> do syscall */
+
+	/* seconds are xsec >> 20 */
+	rlwinm	r5,r4,12,20,31
+	rlwimi	r5,r3,12,0,19
+	stw	r5,TVAL32_TV_SEC(r10)
+
+	/* get remaining xsec and convert to usec. we scale
+	 * up remaining xsec by 12 bits and get the top 32 bits
+	 * of the multiplication
+	 */
+	rlwinm	r5,r4,12,0,19
+	lis	r6,1000000@h
+	ori	r6,r6,1000000@l
+	mulhwu	r5,r5,r6		
+	stw	r5,TVAL32_TV_USEC(r10)
+
+	cmpli	cr0,r11,0		/* check if tz is NULL */
+	beq	1f
+	lwz	r4,CFG_TZ_MINUTEWEST(r9)/* fill tz */
+	lwz	r5,CFG_TZ_DSTTIME(r9)
+	stw	r4,TZONE_TZ_MINWEST(r11)
+	stw	r5,TZONE_TZ_DSTTIME(r11)
+	
+1:	mtlr	r12
+	blr
+
+2:	mr	r3,r10
+	mr	r4,r11
+	li	r0,__NR_gettimeofday
+	sc
+	b	1b
+V_FUNCTION_END(_v_gettimeofday)
+
+/*
+ * This is the core of gettimeofday(), it returns the xsec
+ * value in r3 & r4 and expects the datapage ptr (non clobbered)
+ * in r9. clobbers r0,r4,r5,r6,r7,r8
+*/ 
+__v_do_get_xsec:
+  .cfi_startproc
+	/* Check for update count & load values. We use the low
+	 * order 32 bits of the update count
+	 */
+1:	lwz	r8,(CFG_TB_UPDATE_COUNT+4)(r9)
+	andi.	r0,r8,1			/* pending update ? loop */
+	bne-	1b
+	xor	r0,r8,r8		/* create dependency */
+	add	r9,r9,r0
+
+	/* Load orig stamp (offset to TB) */
+	lwz	r5,CFG_TB_ORIG_STAMP(r9)
+	lwz	r6,(CFG_TB_ORIG_STAMP+4)(r9)
+
+	/* Get a stable TB value */
+2:	mftbu	r3
+	mftbl	r4
+	mftbu	r0
+	cmpl	cr0,r3,r0
+	bne-	2b
+
+	/* Substract tb orig stamp. If the high part is non-zero, we jump to the
+	 * slow path which call the syscall. If it's ok, then we have our 32 bits
+	 * tb_ticks value in r7
+	 */
+	subfc	r7,r6,r4
+	subfe.	r0,r5,r3
+	bne-	3f
+
+	/* Load scale factor & do multiplication */
+	lwz	r5,CFG_TB_TO_XS(r9)	/* load values */
+	lwz	r6,(CFG_TB_TO_XS+4)(r9)
+	mulhwu	r4,r7,r5
+	mulhwu	r6,r7,r6
+	mullw	r6,r7,r5
+	addc	r6,r6,r0
+
+	/* At this point, we have the scaled xsec value in r4 + XER:CA
+	 * we load & add the stamp since epoch
+	 */
+	lwz	r5,CFG_STAMP_XSEC(r9)
+	lwz	r6,(CFG_STAMP_XSEC+4)(r9)
+	adde	r4,r4,r6
+	addze	r3,r5
+
+	/* We now have our result in r3,r4. We create a fake dependency
+	 * on that result and re-check the counter
+	 */
+	xor	r0,r4,r4
+	add	r9,r9,r0
+	lwz	r0,(CFG_TB_UPDATE_COUNT+4)(r9)
+        cmpl    cr0,r8,r0		/* check if updated */
+	bne-	1b
+
+	/* Warning ! The caller expects CR:EQ to be set to indicate a
+	 * successful calculation (so it won't fallback to the syscall
+	 * method). We have overriden that CR bit in the counter check,
+	 * but fortunately, the loop exit condition _is_ CR:EQ set, so
+	 * we can exit safely here. If you change this code, be careful
+	 * of that side effect.
+	 */
+3:	blr
+  .cfi_endproc
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/sigtramp.S linux-vdso/arch/ppc64/kernel/vdso32/sigtramp.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/sigtramp.S	2004-09-13 14:44:43.000000000 +1000
@@ -0,0 +1,296 @@
+/*
+ * Signal trampolines for 32 bits processes in a ppc64 kernel for
+ * use in the vDSO
+ *
+ * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org), IBM Corp.
+ * Copyright (C) 2004 Alan Modra (amodra@au.ibm.com)), IBM Corp.
+ *  
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+	.text
+
+V_FUNCTION_BEGIN(__v_sigtramp32)
+.Lsig_start:
+	li	r0,__NR_sigreturn
+	sc
+.Lsig_end:
+V_FUNCTION_END(__v_sigtramp32)
+
+V_FUNCTION_BEGIN(__v_sigtramp_rt32)
+.Lsigrt_start:
+	li	r0,__NR_rt_sigreturn
+	sc
+.Lsigrt_end:
+V_FUNCTION_END(__v_sigtramp_rt32)
+
+
+	.section .eh_frame,"a",@progbits
+
+/* Register r1 can be found at offset 4 of a pt_regs structure.
+   A pointer to the pt_regs is stored in memory at the old sp plus PTREGS.  */
+#define cfa_save \
+  .byte 0x0f;			/* DW_CFA_def_cfa_expression */		\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x23; .uleb128 RSIZE;	/*     DW_OP_plus_uconst */		\
+  .byte 0x06;			/*     DW_OP_deref */			\
+9:
+
+/* Register REGNO can be found at offset OFS of a pt_regs structure.
+   A pointer to the pt_regs is stored in memory at the old sp plus PTREGS.  */
+#define rsave(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .ifne ofs;								\
+    .byte 0x23; .uleb128 ofs;	/*     DW_OP_plus_uconst */		\
+  .endif;								\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset REGNO*16
+   of the VMX reg struct.  The VMX reg struct is at offset VREGS of
+   the pt_regs struct.  This macro is for REGNO == 0, and contains
+   'subroutines' that the other macros jump to.  */
+#define vsave_msr0(regno) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x30 + regno;		/*     DW_OP_lit0 */			\
+2:									\
+  .byte 0x34;			/*     DW_OP_lit4 */			\
+  .byte 0x24;			/*     DW_OP_shl */			\
+3:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x12;			/*     DW_OP_dup */			\
+  .byte 0x23;			/*     DW_OP_plus_uconst */		\
+    .uleb128 33*RSIZE;		/*       msr offset */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x49;			/*     DW_OP_lit25 */			\
+  .byte 0x25;			/*     DW_OP_shr */			\
+  .byte 0x31;			/*     DW_OP_lit1 */			\
+  .byte 0x1a;			/*     DW_OP_and */			\
+  .byte 0x12;			/*     DW_OP_dup, ret 0 if bra taken */	\
+  .byte 0x31;			/*     DW_OP_lit1 */			\
+  .byte 0x27;			/*     DW_OP_xor */			\
+  .byte 0x28; .short 0x7fff;	/*     DW_OP_bra to end */		\
+  .byte 0x13;			/*     DW_OP_drop, pop the 0 */		\
+  .byte 0x23; .uleb128 VREGS;	/*     DW_OP_plus_uconst */		\
+  .byte 0x22;			/*     DW_OP_plus */			\
+  .byte 0x2f; .short 0x7fff;	/*     DW_OP_skip to end */		\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset REGNO*16
+   of the VMX reg struct.  REGNO is 1 thru 31.  */
+#define vsave_msr1(regno) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x30 + regno;		/*     DW_OP_lit n */			\
+  .byte 0x2f; .short 2b - 9f;	/*     DW_OP_skip */			\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset OFS of
+   the VMX save block.  */
+#define vsave_msr2(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x0a; .short ofs;	/*     DW_OP_const2u */			\
+  .byte 0x2f; .short 3b - 9f;	/*     DW_OP_skip */			\
+9:
+
+/* VMX register REGNO is at offset OFS of the VMX save area.  */
+#define vsave(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x23; .uleb128 VREGS;	/*     DW_OP_plus_uconst */		\
+  .byte 0x23; .uleb128 ofs;	/*     DW_OP_plus_uconst */		\
+9:
+
+/* This is where the pt_regs pointer can be found on the stack.  */
+#define PTREGS 64+28
+
+/* Size of regs.  */
+#define RSIZE 4
+
+/* This is the offset of the VMX regs.  */
+#define VREGS 48*RSIZE+34*8
+
+/* Describe where general purpose regs are saved.  */
+#define EH_FRAME_GEN \
+  cfa_save;								\
+  rsave ( 0,  0*RSIZE);							\
+  rsave ( 2,  2*RSIZE);							\
+  rsave ( 3,  3*RSIZE);							\
+  rsave ( 4,  4*RSIZE);							\
+  rsave ( 5,  5*RSIZE);							\
+  rsave ( 6,  6*RSIZE);							\
+  rsave ( 7,  7*RSIZE);							\
+  rsave ( 8,  8*RSIZE);							\
+  rsave ( 9,  9*RSIZE);							\
+  rsave (10, 10*RSIZE);							\
+  rsave (11, 11*RSIZE);							\
+  rsave (12, 12*RSIZE);							\
+  rsave (13, 13*RSIZE);							\
+  rsave (14, 14*RSIZE);							\
+  rsave (15, 15*RSIZE);							\
+  rsave (16, 16*RSIZE);							\
+  rsave (17, 17*RSIZE);							\
+  rsave (18, 18*RSIZE);							\
+  rsave (19, 19*RSIZE);							\
+  rsave (20, 20*RSIZE);							\
+  rsave (21, 21*RSIZE);							\
+  rsave (22, 22*RSIZE);							\
+  rsave (23, 23*RSIZE);							\
+  rsave (24, 24*RSIZE);							\
+  rsave (25, 25*RSIZE);							\
+  rsave (26, 26*RSIZE);							\
+  rsave (27, 27*RSIZE);							\
+  rsave (28, 28*RSIZE);							\
+  rsave (29, 29*RSIZE);							\
+  rsave (30, 30*RSIZE);							\
+  rsave (31, 31*RSIZE);							\
+  rsave (67, 32*RSIZE);		/* ap, used as temp for nip */		\
+  rsave (65, 36*RSIZE);		/* lr */				\
+  rsave (70, 38*RSIZE)		/* cr */
+
+/* Describe where the FP regs are saved.  */
+#define EH_FRAME_FP \
+  rsave (32, 48*RSIZE +  0*8);						\
+  rsave (33, 48*RSIZE +  1*8);						\
+  rsave (34, 48*RSIZE +  2*8);						\
+  rsave (35, 48*RSIZE +  3*8);						\
+  rsave (36, 48*RSIZE +  4*8);						\
+  rsave (37, 48*RSIZE +  5*8);						\
+  rsave (38, 48*RSIZE +  6*8);						\
+  rsave (39, 48*RSIZE +  7*8);						\
+  rsave (40, 48*RSIZE +  8*8);						\
+  rsave (41, 48*RSIZE +  9*8);						\
+  rsave (42, 48*RSIZE + 10*8);						\
+  rsave (43, 48*RSIZE + 11*8);						\
+  rsave (44, 48*RSIZE + 12*8);						\
+  rsave (45, 48*RSIZE + 13*8);						\
+  rsave (46, 48*RSIZE + 14*8);						\
+  rsave (47, 48*RSIZE + 15*8);						\
+  rsave (48, 48*RSIZE + 16*8);						\
+  rsave (49, 48*RSIZE + 17*8);						\
+  rsave (50, 48*RSIZE + 18*8);						\
+  rsave (51, 48*RSIZE + 19*8);						\
+  rsave (52, 48*RSIZE + 20*8);						\
+  rsave (53, 48*RSIZE + 21*8);						\
+  rsave (54, 48*RSIZE + 22*8);						\
+  rsave (55, 48*RSIZE + 23*8);						\
+  rsave (56, 48*RSIZE + 24*8);						\
+  rsave (57, 48*RSIZE + 25*8);						\
+  rsave (58, 48*RSIZE + 26*8);						\
+  rsave (59, 48*RSIZE + 27*8);						\
+  rsave (60, 48*RSIZE + 28*8);						\
+  rsave (61, 48*RSIZE + 29*8);						\
+  rsave (62, 48*RSIZE + 30*8);						\
+  rsave (63, 48*RSIZE + 31*8)
+
+/* Describe where the VMX regs are saved.  */
+#ifdef CONFIG_ALTIVEC
+#define EH_FRAME_VMX \
+  vsave_msr0 ( 0);							\
+  vsave_msr1 ( 1);							\
+  vsave_msr1 ( 2);							\
+  vsave_msr1 ( 3);							\
+  vsave_msr1 ( 4);							\
+  vsave_msr1 ( 5);							\
+  vsave_msr1 ( 6);							\
+  vsave_msr1 ( 7);							\
+  vsave_msr1 ( 8);							\
+  vsave_msr1 ( 9);							\
+  vsave_msr1 (10);							\
+  vsave_msr1 (11);							\
+  vsave_msr1 (12);							\
+  vsave_msr1 (13);							\
+  vsave_msr1 (14);							\
+  vsave_msr1 (15);							\
+  vsave_msr1 (16);							\
+  vsave_msr1 (17);							\
+  vsave_msr1 (18);							\
+  vsave_msr1 (19);							\
+  vsave_msr1 (20);							\
+  vsave_msr1 (21);							\
+  vsave_msr1 (22);							\
+  vsave_msr1 (23);							\
+  vsave_msr1 (24);							\
+  vsave_msr1 (25);							\
+  vsave_msr1 (26);							\
+  vsave_msr1 (27);							\
+  vsave_msr1 (28);							\
+  vsave_msr1 (29);							\
+  vsave_msr1 (30);							\
+  vsave_msr1 (31);							\
+  vsave_msr2 (33, 32*16+12);						\
+  vsave      (32, 32*16)
+#else
+#define EH_FRAME_VMX
+#endif
+
+.Lcie:
+	.long .Lcie_end - .Lcie_start
+.Lcie_start:
+	.long 0			/* CIE ID */
+	.byte 1			/* Version number */
+	.string "zR"		/* NUL-terminated augmentation string */
+	.uleb128 4		/* Code alignment factor */
+	.sleb128 -4		/* Data alignment factor */
+	.byte 67		/* Return address register column, ap */
+	.uleb128 1		/* Augmentation value length */
+	.byte 0x1b		/* DW_EH_PE_pcrel | DW_EH_PE_sdata4. */
+	.byte 0x0c,1,0		/* DW_CFA_def_cfa: r1 ofs 0 */
+	.balign 4
+.Lcie_end:
+
+	.long .Lfde0_end - .Lfde0_start
+.Lfde0_start:
+	.long .Lfde0_start - .Lcie	/* CIE pointer. */
+	.long .Lsig_start - .		/* PC start, length */
+	.long .Lsig_end - .Lsig_start
+	.uleb128 0			/* Augmentation */
+	EH_FRAME_GEN
+	EH_FRAME_FP
+	EH_FRAME_VMX
+	.balign 4
+.Lfde0_end:
+
+/* We have a different stack layout for rt_sigreturn.  */
+#undef PTREGS
+#define PTREGS 64+16+128+20+28
+
+	.long .Lfde1_end - .Lfde1_start
+.Lfde1_start:
+	.long .Lfde1_start - .Lcie	/* CIE pointer. */
+	.long .Lsigrt_start - .		/* PC start, length */
+	.long .Lsigrt_end - .Lsigrt_start
+	.uleb128 0			/* Augmentation */
+	EH_FRAME_GEN
+	EH_FRAME_FP
+	EH_FRAME_VMX
+	.balign 4
+.Lfde1_end:
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/vdso32.lds.S linux-vdso/arch/ppc64/kernel/vdso32/vdso32.lds.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/vdso32.lds.S	2004-09-09 13:13:18.000000000 +1000
@@ -0,0 +1,91 @@
+
+/*
+ * This is the infamous ld script for the 32 bits vdso
+ * library
+ */
+#include <asm/vdso.h>
+
+/* Default link addresses for the vDSOs */
+OUTPUT_FORMAT("elf32-powerpc", "elf32-powerpc", "elf32-powerpc")
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_start)
+
+SECTIONS
+{
+  . = VDSO32_BASE + SIZEOF_HEADERS;
+  .hash           : { *(.hash) }		:text
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  . = ALIGN (16);
+  .text :
+  {
+    *(.text .stub .text.* .gnu.linkonce.t.*)
+  }
+  PROVIDE (__etext = .);
+  PROVIDE (_etext = .);
+  PROVIDE (etext = .);
+
+  /* Other stuff is appended to the text segment: */
+  .rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+  .rodata1		: { *(.rodata1) }
+  .eh_frame_hdr		: { *(.eh_frame_hdr) }
+  .eh_frame		: { KEEP (*(.eh_frame)) }
+  .gcc_except_table	: { *(.gcc_except_table) }
+  .fixup		: { *(.fixup) }
+
+  .got ALIGN(4)		: { *(.got.plt) *(.got) }
+
+  .dynamic		: { *(.dynamic) }	:text	:dynamic
+
+  _end = .;
+  __end = .;
+  PROVIDE (end = .);
+
+
+  /* Stabs debugging sections are here too
+   */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+  .debug 0 : { *(.debug) }
+  .line 0 : { *(.line) }
+
+  .debug_srcinfo 0 : { *(.debug_srcinfo) }
+  .debug_sfnames 0 : { *(.debug_sfnames) }
+
+  .debug_aranges 0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+
+  .debug_info 0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev 0 : { *(.debug_abbrev) }
+  .debug_line 0 : { *(.debug_line) }
+  .debug_frame 0 : { *(.debug_frame) }
+  .debug_str 0 : { *(.debug_str) }
+  .debug_loc 0 : { *(.debug_loc) }
+  .debug_macinfo 0 : { *(.debug_macinfo) }
+
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames 0 : { *(.debug_varnames) }
+
+  /DISCARD/ : { *(.note.GNU-stack) }
+  /DISCARD/ : { *(.data .data.* .gnu.linkonce.d.* .sdata*) }
+  /DISCARD/ : { *(.bss .sbss .dynbss .dynsbss) }
+}
+
+
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
diff -urN linux-2.5/arch/ppc64/kernel/vdso32/vdso32_wrapper.S linux-vdso/arch/ppc64/kernel/vdso32/vdso32_wrapper.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso32/vdso32_wrapper.S	2004-09-07 18:25:44.000000000 +1000
@@ -0,0 +1,12 @@
+#include <linux/init.h>
+
+	.section ".data"
+
+	.globl vdso32_start, vdso32_end
+	.balign 4096
+vdso32_start:
+	.incbin "arch/ppc64/kernel/vdso32/vdso32.so"
+	.balign 4096
+vdso32_end:
+
+	.previous
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/Makefile linux-vdso/arch/ppc64/kernel/vdso64/Makefile
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/Makefile	2004-09-13 14:11:43.000000000 +1000
@@ -0,0 +1,37 @@
+# List of files in the vdso, has to be asm only for now
+
+src-vdso64 = sigtramp.S gettimeofday.S datapage.S
+
+# Build rules
+
+obj-vdso64 := $(addsuffix .o, $(basename $(src-vdso64)))
+targets := $(obj-vdso64) vdso64.so
+obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
+src-vdso64 := $(addprefix $(src)/, $(src-vdso64))
+
+EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin
+EXTRA_CFLAGS +=  -nostdlib -Wl,-soname=linux-vdso64.so.1
+EXTRA_AFLAGS := -D__VDSO64__ -s
+
+obj-y += vdso64_wrapper.o
+extra-y += vdso64.lds
+CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/vdso64.so: $(src)/vdso64.lds $(obj-vdso64)
+	$(call if_changed,vdso64ld)
+
+# assembly rules for the .S files
+$(obj-vdso64): %.o: %.S
+	$(call if_changed_dep,vdso64as)
+
+# actual build commands
+quiet_cmd_vdso64ld = VDSO64L $@
+      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdso64as = VDSO64A $@
+      cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
+
+
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/datapage.S linux-vdso/arch/ppc64/kernel/vdso64/datapage.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/datapage.S	2004-09-10 16:14:49.000000000 +1000
@@ -0,0 +1,53 @@
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+	.text
+V_FUNCTION_BEGIN(__v_get_datapage)
+	/* We don't want that exposed or overridable as we want other objects
+	 * to be able to bl directly to here
+	 */
+	.protected __v_get_datapage
+	.hidden __v_get_datapage
+
+	mflr	r0
+  .cfi_register lr,r0
+
+	bcl	20,31,1f
+	.global	__v_datapage_offset;
+__v_datapage_offset:
+	.long	0
+1:
+	mflr	r3
+	mtlr	r0
+	lwz	r0,0(r3)
+	add	r3,r0,r3
+	blr
+V_FUNCTION_END(__v_get_datapage)
+
+/*
+ * void *_v_get_syscall_map(unsigned int *syscall_count) ;
+ *
+ * returns a pointer to the syscall map. the map is agnostic to the
+ * size of "long", unlike kernel bitops, it stores bits from top to
+ * bottom so that memory actually contains a linear bitmap
+ * check for syscall N by testing bit (0x80000000 >> (N & 0x1f)) of
+ * 32 bits int at N >> 5.
+ */
+V_FUNCTION_BEGIN(_v_get_syscall_map)
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r4,r3
+	bl	.__v_get_datapage
+	mtlr	r12
+	addi	r3,r3,CFG_SYSCALL_MAP64
+	cmpli	cr0,r4,0
+	beqlr
+	li	r0,__NR_syscalls
+	stw	r0,0(r4)
+	blr
+V_FUNCTION_END(_v_get_syscall_map)
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/gettimeofday.S linux-vdso/arch/ppc64/kernel/vdso64/gettimeofday.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/gettimeofday.S	2004-09-09 16:43:13.000000000 +1000
@@ -0,0 +1,88 @@
+/*
+ * Userland implementation of gettimeofday() for 64 bits processes in a
+ * ppc64 kernel for use in the vDSO
+ *
+ * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org),
+ *                    IBM Corp.
+ *  
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+#include <asm/offsets.h>
+
+	.text
+/*
+ * Exact prototype of gettimeofday
+ *
+ * int _v_gettimeofday(struct timeval *tv, struct timezone *tz);
+ *
+ */
+V_FUNCTION_BEGIN(_v_gettimeofday)
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r11,r3			/* r11 holds tv */
+	mr	r10,r4			/* r10 holds tz */
+	bl	.__v_get_datapage	/* get data page */
+	bl	.__v_do_get_xsec	/* get xsec from tb & kernel */
+	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
+	ori     r7,r7,16960
+	rldicl  r5,r4,44,20		/* r5 = sec = xsec / XSEC_PER_SEC */
+	rldicr  r6,r5,20,43		/* r6 = sec * XSEC_PER_SEC */
+	std	r5,TVAL64_TV_SEC(r11)	/* store sec in tv */
+	subf	r0,r6,r4		/* r0 = xsec = (xsec - r6) */
+	mulld   r0,r0,r7		/* usec = (xsec * USEC_PER_SEC) / XSEC_PER_SEC */
+	rldicl  r0,r0,44,20
+	cmpldi	cr0,r10,0		/* check if tz is NULL */
+	std	r0,TVAL64_TV_USEC(r11)	/* store usec in tv */
+	beq	1f
+	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
+	lwz	r5,CFG_TZ_DSTTIME(r3)
+	stw	r4,TZONE_TZ_MINWEST(r10)
+	stw	r5,TZONE_TZ_DSTTIME(r10)
+1:	mtlr	r12
+	li	r3,0			/* always success */
+	blr
+V_FUNCTION_END(_v_gettimeofday)
+
+
+/*
+ * This is the core of gettimeofday(), it returns the xsec
+ * value in r4 and expects the datapage ptr (non clobbered)
+ * in r3. clobbers r0,r4,r5,r6,r7,r8
+*/ 
+.__v_do_get_xsec:
+  .cfi_startproc
+	/* check for update count & load values */
+1:	ld	r7,CFG_TB_UPDATE_COUNT(r3)
+	andi.	r0,r4,1			/* pending update ? loop */
+	bne-	1b
+	xor	r0,r4,r4		/* create dependency */
+	add	r3,r3,r0
+
+	/* Get TB & offset it */
+	mftb	r8
+	ld	r9,CFG_TB_ORIG_STAMP(r3)
+	subf	r8,r9,r8
+
+	/* Scale result */
+	ld	r5,CFG_TB_TO_XS(r3)
+	mulhdu	r8,r8,r5
+
+	/* Add stamp since epoch */
+	ld	r6,CFG_STAMP_XSEC(r3)
+	add	r4,r6,r8
+
+	xor	r0,r4,r4
+	add	r3,r3,r0
+	ld	r0,CFG_TB_UPDATE_COUNT(r3)
+        cmpld   cr0,r0,r7		/* check if updated */
+	bne-	1b
+	blr
+  .cfi_endproc
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/sigtramp.S linux-vdso/arch/ppc64/kernel/vdso64/sigtramp.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/sigtramp.S	2004-09-13 14:44:43.000000000 +1000
@@ -0,0 +1,284 @@
+/*
+ * Signal trampoline for 64 bits processes in a ppc64 kernel for
+ * use in the vDSO
+ *
+ * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org), IBM Corp.
+ * Copyright (C) 2004 Alan Modra (amodra@au.ibm.com)), IBM Corp.
+ *  
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+	
+	.text
+
+V_FUNCTION_BEGIN(__v_sigtramp_rt64)
+.Lsigrt_start:
+	addi	r1, r1, __SIGNAL_FRAMESIZE
+	li	r0,__NR_rt_sigreturn
+	sc
+.Lsigrt_end:
+V_FUNCTION_END(__v_sigtramp_rt64)
+
+
+/* Register r1 can be found at offset 8 of a pt_regs structure.
+   A pointer to the pt_regs is stored in memory at the old sp plus PTREGS.  */
+#define cfa_save \
+  .byte 0x0f;			/* DW_CFA_def_cfa_expression */		\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x23; .uleb128 RSIZE;	/*     DW_OP_plus_uconst */		\
+  .byte 0x06;			/*     DW_OP_deref */			\
+9:
+
+/* Register REGNO can be found at offset OFS of a pt_regs structure.
+   A pointer to the pt_regs is stored in memory at the old sp plus PTREGS.  */
+#define rsave(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .ifne ofs;								\
+    .byte 0x23; .uleb128 ofs;	/*     DW_OP_plus_uconst */		\
+  .endif;								\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset REGNO*16
+   of the VMX reg struct.  A pointer to the VMX reg struct is at VREGS in
+   the pt_regs struct.  This macro is for REGNO == 0, and contains
+   'subroutines' that the other macros jump to.  */
+#define vsave_msr0(regno) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x30 + regno;		/*     DW_OP_lit0 */			\
+2:									\
+  .byte 0x34;			/*     DW_OP_lit4 */			\
+  .byte 0x24;			/*     DW_OP_shl */			\
+3:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x12;			/*     DW_OP_dup */			\
+  .byte 0x23;			/*     DW_OP_plus_uconst */		\
+    .uleb128 33*RSIZE;		/*       msr offset */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x49;			/*     DW_OP_lit25 */			\
+  .byte 0x25;			/*     DW_OP_shr */			\
+  .byte 0x31;			/*     DW_OP_lit1 */			\
+  .byte 0x1a;			/*     DW_OP_and */			\
+  .byte 0x12;			/*     DW_OP_dup, ret 0 if bra taken */	\
+  .byte 0x31;			/*     DW_OP_lit1 */			\
+  .byte 0x27;			/*     DW_OP_xor */			\
+  .byte 0x28; .short 0x7fff;	/*     DW_OP_bra to end */		\
+  .byte 0x13;			/*     DW_OP_drop, pop the 0 */		\
+  .byte 0x23; .uleb128 VREGS;	/*     DW_OP_plus_uconst */		\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x22;			/*     DW_OP_plus */			\
+  .byte 0x2f; .short 0x7fff;	/*     DW_OP_skip to end */		\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset REGNO*16
+   of the VMX reg struct.  REGNO is 1 thru 31.  */
+#define vsave_msr1(regno) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x30 + regno;		/*     DW_OP_lit n */			\
+  .byte 0x2f; .short 2b - 9f;	/*     DW_OP_skip */			\
+9:
+
+/* If msr bit 1<<25 is set, then VMX register REGNO is at offset OFS of
+   the VMX save block.  */
+#define vsave_msr2(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x0a; .short ofs;	/*     DW_OP_const2u */			\
+  .byte 0x2f; .short 3b - 9f;	/*     DW_OP_skip */			\
+9:
+
+/* VMX register REGNO is at offset OFS of the VMX save area.  */
+#define vsave(regno, ofs) \
+  .byte 0x10;			/* DW_CFA_expression */			\
+  .uleb128 regno + 77;		/*   regno */				\
+  .uleb128 9f - 1f;		/*   length */				\
+1:									\
+  .byte 0x71; .sleb128 PTREGS;	/*     DW_OP_breg1 */			\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x23; .uleb128 VREGS;	/*     DW_OP_plus_uconst */		\
+  .byte 0x06;			/*     DW_OP_deref */			\
+  .byte 0x23; .uleb128 ofs;	/*     DW_OP_plus_uconst */		\
+9:
+
+/* This is where the pt_regs pointer can be found on the stack.  */
+#define PTREGS 128+168+56
+
+/* Size of regs.  */
+#define RSIZE 8
+
+/* This is the offset of the VMX reg pointer.  */
+#define VREGS 48*RSIZE+33*8
+
+/* Describe where general purpose regs are saved.  */
+#define EH_FRAME_GEN \
+  cfa_save;								\
+  rsave ( 0,  0*RSIZE);							\
+  rsave ( 2,  2*RSIZE);							\
+  rsave ( 3,  3*RSIZE);							\
+  rsave ( 4,  4*RSIZE);							\
+  rsave ( 5,  5*RSIZE);							\
+  rsave ( 6,  6*RSIZE);							\
+  rsave ( 7,  7*RSIZE);							\
+  rsave ( 8,  8*RSIZE);							\
+  rsave ( 9,  9*RSIZE);							\
+  rsave (10, 10*RSIZE);							\
+  rsave (11, 11*RSIZE);							\
+  rsave (12, 12*RSIZE);							\
+  rsave (13, 13*RSIZE);							\
+  rsave (14, 14*RSIZE);							\
+  rsave (15, 15*RSIZE);							\
+  rsave (16, 16*RSIZE);							\
+  rsave (17, 17*RSIZE);							\
+  rsave (18, 18*RSIZE);							\
+  rsave (19, 19*RSIZE);							\
+  rsave (20, 20*RSIZE);							\
+  rsave (21, 21*RSIZE);							\
+  rsave (22, 22*RSIZE);							\
+  rsave (23, 23*RSIZE);							\
+  rsave (24, 24*RSIZE);							\
+  rsave (25, 25*RSIZE);							\
+  rsave (26, 26*RSIZE);							\
+  rsave (27, 27*RSIZE);							\
+  rsave (28, 28*RSIZE);							\
+  rsave (29, 29*RSIZE);							\
+  rsave (30, 30*RSIZE);							\
+  rsave (31, 31*RSIZE);							\
+  rsave (67, 32*RSIZE);		/* ap, used as temp for nip */		\
+  rsave (65, 36*RSIZE);		/* lr */				\
+  rsave (70, 38*RSIZE)		/* cr */
+
+/* Describe where the FP regs are saved.  */
+#define EH_FRAME_FP \
+  rsave (32, 48*RSIZE +  0*8);						\
+  rsave (33, 48*RSIZE +  1*8);						\
+  rsave (34, 48*RSIZE +  2*8);						\
+  rsave (35, 48*RSIZE +  3*8);						\
+  rsave (36, 48*RSIZE +  4*8);						\
+  rsave (37, 48*RSIZE +  5*8);						\
+  rsave (38, 48*RSIZE +  6*8);						\
+  rsave (39, 48*RSIZE +  7*8);						\
+  rsave (40, 48*RSIZE +  8*8);						\
+  rsave (41, 48*RSIZE +  9*8);						\
+  rsave (42, 48*RSIZE + 10*8);						\
+  rsave (43, 48*RSIZE + 11*8);						\
+  rsave (44, 48*RSIZE + 12*8);						\
+  rsave (45, 48*RSIZE + 13*8);						\
+  rsave (46, 48*RSIZE + 14*8);						\
+  rsave (47, 48*RSIZE + 15*8);						\
+  rsave (48, 48*RSIZE + 16*8);						\
+  rsave (49, 48*RSIZE + 17*8);						\
+  rsave (50, 48*RSIZE + 18*8);						\
+  rsave (51, 48*RSIZE + 19*8);						\
+  rsave (52, 48*RSIZE + 20*8);						\
+  rsave (53, 48*RSIZE + 21*8);						\
+  rsave (54, 48*RSIZE + 22*8);						\
+  rsave (55, 48*RSIZE + 23*8);						\
+  rsave (56, 48*RSIZE + 24*8);						\
+  rsave (57, 48*RSIZE + 25*8);						\
+  rsave (58, 48*RSIZE + 26*8);						\
+  rsave (59, 48*RSIZE + 27*8);						\
+  rsave (60, 48*RSIZE + 28*8);						\
+  rsave (61, 48*RSIZE + 29*8);						\
+  rsave (62, 48*RSIZE + 30*8);						\
+  rsave (63, 48*RSIZE + 31*8)
+
+/* Describe where the VMX regs are saved.  */
+#ifdef CONFIG_ALTIVEC
+#define EH_FRAME_VMX \
+  vsave_msr0 ( 0);							\
+  vsave_msr1 ( 1);							\
+  vsave_msr1 ( 2);							\
+  vsave_msr1 ( 3);							\
+  vsave_msr1 ( 4);							\
+  vsave_msr1 ( 5);							\
+  vsave_msr1 ( 6);							\
+  vsave_msr1 ( 7);							\
+  vsave_msr1 ( 8);							\
+  vsave_msr1 ( 9);							\
+  vsave_msr1 (10);							\
+  vsave_msr1 (11);							\
+  vsave_msr1 (12);							\
+  vsave_msr1 (13);							\
+  vsave_msr1 (14);							\
+  vsave_msr1 (15);							\
+  vsave_msr1 (16);							\
+  vsave_msr1 (17);							\
+  vsave_msr1 (18);							\
+  vsave_msr1 (19);							\
+  vsave_msr1 (20);							\
+  vsave_msr1 (21);							\
+  vsave_msr1 (22);							\
+  vsave_msr1 (23);							\
+  vsave_msr1 (24);							\
+  vsave_msr1 (25);							\
+  vsave_msr1 (26);							\
+  vsave_msr1 (27);							\
+  vsave_msr1 (28);							\
+  vsave_msr1 (29);							\
+  vsave_msr1 (30);							\
+  vsave_msr1 (31);							\
+  vsave_msr2 (33, 32*16+12);						\
+  vsave      (32, 33*16)
+#else
+#define EH_FRAME_VMX
+#endif
+
+	.section .eh_frame,"a",@progbits
+.Lcie:
+	.long .Lcie_end - .Lcie_start
+.Lcie_start:
+	.long 0			/* CIE ID */
+	.byte 1			/* Version number */
+	.string "zR"		/* NUL-terminated augmentation string */
+	.uleb128 4		/* Code alignment factor */
+	.sleb128 -8		/* Data alignment factor */
+	.byte 67		/* Return address register column, ap */
+	.uleb128 1		/* Augmentation value length */
+	.byte 0x14		/* DW_EH_PE_pcrel | DW_EH_PE_udata8. */
+	.byte 0x0c,1,0		/* DW_CFA_def_cfa: r1 ofs 0 */
+	.balign 4
+.Lcie_end:
+
+	.long .Lfde0_end - .Lfde0_start
+.Lfde0_start:
+	.long .Lfde0_start - .Lcie	/* CIE pointer. */
+	.quad .Lsigrt_start - .		/* PC start, length */
+	.quad .Lsigrt_end - .Lsigrt_start
+	.uleb128 0			/* Augmentation */
+	EH_FRAME_GEN
+	EH_FRAME_FP
+	EH_FRAME_VMX
+# Do we really need to describe the frame at this point?  ie. will
+# we ever have some call chain that returns somewhere past the addi?
+# I don't think so, since gcc doesn't support async signals.
+#	.byte 0x41		/* DW_CFA_advance_loc 1*4 */
+#undef PTREGS
+#define PTREGS 168+56
+#	EH_FRAME_GEN
+#	EH_FRAME_FP
+#	EH_FRAME_VMX
+	.balign 4
+.Lfde0_end:
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/vdso64.lds.S linux-vdso/arch/ppc64/kernel/vdso64/vdso64.lds.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/vdso64.lds.S	2004-09-09 13:13:18.000000000 +1000
@@ -0,0 +1,93 @@
+/*
+ * This is the infamous ld script for the 64 bits vdso
+ * library
+ */
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
+OUTPUT_ARCH(powerpc:common64)
+ENTRY(_start)
+
+SECTIONS
+{
+  . = VDSO64_BASE + SIZEOF_HEADERS;
+  .hash           : { *(.hash) }		:text
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  . = ALIGN (16);
+  .text           :
+  {
+    *(.text .stub .text.* .gnu.linkonce.t.*)
+    *(.sfpr .glink)
+  }
+  PROVIDE (__etext = .);
+  PROVIDE (_etext = .);
+  PROVIDE (etext = .);
+ 
+  /* Other stuff is appended to the text segment: */
+  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+  .rodata1        : { *(.rodata1) }
+  .eh_frame_hdr : { *(.eh_frame_hdr) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : { *(.gcc_except_table) }
+
+  .opd           ALIGN(8) : { KEEP (*(.opd)) }
+  .got		 ALIGN(8) : { *(.got .toc) }
+  .rela.dyn	 ALIGN(8) : { *(.rela.dyn) }
+
+  .dynamic        : { *(.dynamic) }		:text	:dynamic
+
+  _end = .;
+  PROVIDE (end = .);
+
+  /* Stabs debugging sections are here too
+   */
+  .stab          0 : { *(.stab) }
+  .stabstr       0 : { *(.stabstr) }
+  .stab.excl     0 : { *(.stab.excl) }
+  .stab.exclstr  0 : { *(.stab.exclstr) }
+  .stab.index    0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment       0 : { *(.comment) }
+  /* DWARF debug sectio/ns.
+     Symbols in the DWARF debugging sections are relative to the beginning
+     of the section so we begin them at 0.  */
+  /* DWARF 1 */
+  .debug          0 : { *(.debug) }
+  .line           0 : { *(.line) }
+  /* GNU DWARF 1 extensions */
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  /* DWARF 1.1 and DWARF 2 */
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  /* DWARF 2 */
+  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev   0 : { *(.debug_abbrev) }
+  .debug_line     0 : { *(.debug_line) }
+  .debug_frame    0 : { *(.debug_frame) }
+  .debug_str      0 : { *(.debug_str) }
+  .debug_loc      0 : { *(.debug_loc) }
+  .debug_macinfo  0 : { *(.debug_macinfo) }
+  /* SGI/MIPS DWARF 2 extensions */
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames  0 : { *(.debug_varnames) }
+
+  /DISCARD/ : { *(.note.GNU-stack) }
+  /DISCARD/ : { *(.branch_lt) }
+  /DISCARD/ : { *(.data .data.* .gnu.linkonce.d.*) }
+  /DISCARD/ : { *(.bss .sbss .dynbss .dynsbss) }
+}
+
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
diff -urN linux-2.5/arch/ppc64/kernel/vdso64/vdso64_wrapper.S linux-vdso/arch/ppc64/kernel/vdso64/vdso64_wrapper.S
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/arch/ppc64/kernel/vdso64/vdso64_wrapper.S	2004-09-07 18:25:46.000000000 +1000
@@ -0,0 +1,12 @@
+#include <linux/init.h>
+
+	.section ".data"
+
+	.globl vdso64_start, vdso64_end
+	.balign 4096
+vdso64_start:
+	.incbin "arch/ppc64/kernel/vdso64/vdso64.so"
+	.balign 4096
+vdso64_end:
+
+	.previous
diff -urN linux-2.5/arch/ppc64/mm/init.c linux-vdso/arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c	2004-09-13 13:17:33.000000000 +1000
+++ linux-vdso/arch/ppc64/mm/init.c	2004-09-13 14:41:51.000000000 +1000
@@ -61,6 +61,7 @@
 #include <asm/system.h>
 #include <asm/iommu.h>
 #include <asm/abs_addr.h>
+#include <asm/vdso.h>
 
 
 struct mmu_context_queue_t mmu_context_queue;
@@ -711,6 +712,8 @@
 #ifdef CONFIG_PPC_ISERIES
 	iommu_vio_init();
 #endif
+	/* Initialize the vDSO */
+	vdso_init();
 }
 
 /*
diff -urN linux-2.5/fs/binfmt_elf.c linux-vdso/fs/binfmt_elf.c
--- linux-2.5/fs/binfmt_elf.c	2004-09-01 11:02:35.000000000 +1000
+++ linux-vdso/fs/binfmt_elf.c	2004-09-03 14:55:56.000000000 +1000
@@ -716,6 +716,14 @@
 		goto out_free_dentry;
 	}
 	
+#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
+	retval = arch_setup_additional_pages(bprm, executable_stack);
+	if (retval < 0) {
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
+#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
+
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into
diff -urN linux-2.5/include/asm-ppc64/a.out.h linux-vdso/include/asm-ppc64/a.out.h
--- linux-2.5/include/asm-ppc64/a.out.h	2004-08-10 10:22:36.000000000 +1000
+++ linux-vdso/include/asm-ppc64/a.out.h	2004-09-07 18:24:53.000000000 +1000
@@ -30,14 +30,11 @@
 
 #ifdef __KERNEL__
 
-#define STACK_TOP_USER64 (TASK_SIZE_USER64)
+#define STACK_TOP_USER64 TASK_SIZE_USER64
+#define STACK_TOP_USER32 TASK_SIZE_USER32
 
-/* Give 32-bit user space a full 4G address space to live in. */
-#define STACK_TOP_USER32 (TASK_SIZE_USER32)
-
-#define STACK_TOP ((test_thread_flag(TIF_32BIT) || \
-		(ppcdebugset(PPCDBG_BINFMT_32ADDR))) ? \
-		STACK_TOP_USER32 : STACK_TOP_USER64)
+#define STACK_TOP (test_thread_flag(TIF_32BIT) ? \
+		   STACK_TOP_USER32 : STACK_TOP_USER64)
 
 #endif /* __KERNEL__ */
 
diff -urN linux-2.5/include/asm-ppc64/elf.h linux-vdso/include/asm-ppc64/elf.h
--- linux-2.5/include/asm-ppc64/elf.h	2004-08-10 10:22:37.000000000 +1000
+++ linux-vdso/include/asm-ppc64/elf.h	2004-09-07 18:25:28.000000000 +1000
@@ -238,10 +238,20 @@
 /* A special ignored type value for PPC, for glibc compatibility.  */
 #define AT_IGNOREPPC		22
 
+/* The vDSO location. We have to use the same value as x86 for glibc's
+ * sake :-)
+ */
+#define AT_SYSINFO_EHDR		33
+
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
 
+/* We do have an arch_setup_additional_pages for vDSO matters */
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm, int executable_stack);
+
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -260,6 +270,8 @@
 	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
+	/* vDSO base */							\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, current->thread.vdso_base);       	\
  } while (0)
 
 /* PowerPC64 relocations defined by the ABIs */
diff -urN linux-2.5/include/asm-ppc64/page.h linux-vdso/include/asm-ppc64/page.h
--- linux-2.5/include/asm-ppc64/page.h	2004-09-06 16:43:57.000000000 +1000
+++ linux-vdso/include/asm-ppc64/page.h	2004-09-06 17:01:15.000000000 +1000
@@ -183,6 +183,11 @@
 
 extern int page_is_ram(unsigned long pfn);
 
+/* We do define AT_SYSINFO_EHDR but don't use the gate mecanism */
+#define CONFIG_ARCH_GATE_AREA		1
+#define get_gate_vma(tsk)		(NULL)
+#define in_gate_area(task, addr)	(0)
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef MODULE
diff -urN linux-2.5/include/asm-ppc64/processor.h linux-vdso/include/asm-ppc64/processor.h
--- linux-2.5/include/asm-ppc64/processor.h	2004-09-06 16:43:57.000000000 +1000
+++ linux-vdso/include/asm-ppc64/processor.h	2004-09-06 17:01:15.000000000 +1000
@@ -518,8 +518,8 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(STACK_TOP_USER32 / 4))
-#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(STACK_TOP_USER64 / 4))
+#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
+#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(TASK_SIZE_USER64 / 4))
 
 #define TASK_UNMAPPED_BASE ((test_thread_flag(TIF_32BIT)||(ppcdebugset(PPCDBG_BINFMT_32ADDR))) ? \
 		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
@@ -536,7 +536,8 @@
 	double		fpr[32];	/* Complete floating point set */
 	unsigned long	fpscr;		/* Floating point status (plus pad) */
 	unsigned long	fpexc_mode;	/* Floating-point exception mode */
-	unsigned long	pad[3];		/* was saved_msr, saved_softe */
+	unsigned long	pad[2];		/* was saved_msr, saved_softe */
+	unsigned long	vdso_base;	/* base of the vDSO library */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute((aligned(16)));
diff -urN linux-2.5/include/asm-ppc64/systemcfg.h linux-vdso/include/asm-ppc64/systemcfg.h
--- linux-2.5/include/asm-ppc64/systemcfg.h	2004-08-10 10:22:39.000000000 +1000
+++ linux-vdso/include/asm-ppc64/systemcfg.h	2004-09-10 16:15:04.000000000 +1000
@@ -15,23 +15,19 @@
  * End Change Activity 
  */
 
-
-#ifndef __KERNEL__
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <linux/types.h>
-#endif
-
 /*
  * If the major version changes we are incompatible.
  * Minor version changes are a hint.
  */
 #define SYSTEMCFG_MAJOR 1
-#define SYSTEMCFG_MINOR 0
+#define SYSTEMCFG_MINOR 1
 
 #ifndef __ASSEMBLY__
 
+#include <linux/unistd.h>
+
+#define SYSCALL_MAP_SIZE	((__NR_syscalls + 31) / 32)
+
 struct systemcfg {
 	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
 	struct {			/* Systemcfg version numbers	     */
@@ -54,7 +50,9 @@
 	__u32 dCacheL1LineSize;		/* L1 d-cache line size		0x64 */
 	__u32 iCacheL1Size;		/* L1 i-cache size		0x68 */
 	__u32 iCacheL1LineSize;		/* L1 i-cache line size		0x6C */
-	__u8  reserved0[3984];		/* Reserve rest of page		0x70 */
+	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of available syscalls 0x70 */
+	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of available syscalls 0x70 */
+	__u8  reserved0[3984-2*4*SYSCALL_MAP_SIZE]; /* Reserve rest of page */
 };
 
 #ifdef __KERNEL__
@@ -88,24 +86,6 @@
 #define _machine	(systemcfg->platform)
 #define _MACH_Pmac	PLATFORM_POWERMAC
 
-
-static inline volatile struct systemcfg *systemcfg_init(void)
-{
-	int fd = open("/proc/ppc64/systemcfg", O_RDONLY);
-	volatile struct systemcfg *ret;
-
-	if (fd == -1)
-		return 0;
-	ret = mmap(0, sizeof(struct systemcfg), PROT_READ, MAP_SHARED, fd, 0);
-	close(fd);
-	if (!ret)
-		return 0;
-	if (ret->version.major != SYSTEMCFG_MAJOR || ret->version.minor < SYSTEMCFG_MINOR) {
-		munmap((void *)ret, sizeof(struct systemcfg));
-		return 0;
-	}
-	return ret;
-}
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff -urN linux-2.5/include/asm-ppc64/time.h linux-vdso/include/asm-ppc64/time.h
--- linux-2.5/include/asm-ppc64/time.h	2004-08-10 10:22:38.000000000 +1000
+++ linux-vdso/include/asm-ppc64/time.h	2004-09-09 16:43:16.000000000 +1000
@@ -43,10 +43,10 @@
 struct gettimeofday_vars {
 	unsigned long tb_to_xs;
 	unsigned long stamp_xsec;
+	unsigned long tb_orig_stamp;
 };
 
 struct gettimeofday_struct {
-	unsigned long tb_orig_stamp;
 	unsigned long tb_ticks_per_sec;
 	struct gettimeofday_vars vars[2];
 	struct gettimeofday_vars * volatile varp;
diff -urN linux-2.5/include/asm-ppc64/vdso.h linux-vdso/include/asm-ppc64/vdso.h
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-vdso/include/asm-ppc64/vdso.h	2004-09-13 10:07:28.000000000 +1000
@@ -0,0 +1,60 @@
+#ifndef __PPC64_VDSO_H__
+#define __PPC64_VDSO_H__
+
+#ifdef __KERNEL__
+
+/* Default link addresses for the vDSOs */
+#define VDSO32_BASE	0x100000
+#define VDSO64_BASE	0x100000
+
+#ifndef __ASSEMBLY__
+
+extern unsigned int vdso64_pages;
+extern unsigned int vdso32_pages;
+
+/* Offsets relative to thread->vdso_base */
+extern unsigned long vdso64_rt_sigtramp;
+extern unsigned long vdso32_sigtramp;
+extern unsigned long vdso32_rt_sigtramp;
+
+extern void vdso_init(void);
+
+#else /* __ASSEMBLY__ */
+
+#ifdef __VDSO64__
+#define V_FUNCTION_BEGIN(name)		\
+	.globl name;			\
+        .section ".opd","a";		\
+        .align 3;			\
+	name:				\
+	.quad .name,.TOC.@tocbase,0;	\
+	.previous;			\
+	.globl .name;			\
+	.type .name,@function; 		\
+	.name:				\
+	.cfi_startproc
+
+#define V_FUNCTION_END(name)		\
+	.cfi_endproc			\
+	.size .name,.-.name;
+#endif /* __VDSO64__ */
+
+#ifdef __VDSO32__
+
+#define V_FUNCTION_BEGIN(name)		\
+	.globl name;			\
+	.type name,@function; 		\
+	name:				\
+	.cfi_startproc
+
+#define V_FUNCTION_END(name)		\
+	.cfi_endproc			\
+	.size name,.-name;
+
+#endif /* __VDSO32__ */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __PPC64_VDSO_H__ */


