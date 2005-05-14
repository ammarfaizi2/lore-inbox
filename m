Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVENAkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVENAkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVENAjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:39:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56967 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262637AbVENA1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:27:14 -0400
Subject: [RFC][PATCH (7/7)] new timeofday i386 vsyscall proof of concept (v
	A5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1116030222.26454.16.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <1116030222.26454.16.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:27:08 -0700
Message-Id: <1116030428.26990.1.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

        This patch implements vsyscall-gettimeofday() functions for i386
using the new timeofday core code. This is just a hackish proof of
concept that shows how it could be done and what interfaces are needed
to have a clean separation of the arch independent time keeping and the
very arch specific vsyscall code. It should apply on top of my
linux-2.6.12-rc4_timeofday-timesources-i386_A5 patch.

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc4_timeofday-vsyscall-i386_A5.patch
=================================================
Index: arch/i386/Kconfig
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/arch/i386/Kconfig  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/Kconfig  (mode:100644)
@@ -18,6 +18,9 @@
 	bool
 	default y
 
+config NEWTOD_VSYSCALL
+	depends on EXPERIMENTAL
+	bool "VSYSCALL gettimeofday() interface"
 
 config MMU
 	bool
Index: arch/i386/kernel/Makefile
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/arch/i386/kernel/Makefile  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/kernel/Makefile  (mode:100644)
@@ -10,6 +10,7 @@
 		doublefault.o quirks.o tsc.o
 
 obj-y				+= cpu/
+obj-$(CONFIG_NEWTOD_VSYSCALL)	+= vsyscall-gtod.o
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
Index: arch/i386/kernel/setup.c
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/arch/i386/kernel/setup.c  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/kernel/setup.c  (mode:100644)
@@ -50,6 +50,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/vsyscall-gtod.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -1524,6 +1525,7 @@
 #endif
 #endif
 	tsc_init();
+	vsyscall_init();
 }
 
 #include "setup_arch_post.h"
Index: arch/i386/kernel/vmlinux.lds.S
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/arch/i386/kernel/vmlinux.lds.S  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/kernel/vmlinux.lds.S  (mode:100644)
@@ -5,6 +5,8 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <linux/config.h>
+#include <asm/vsyscall-gtod.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -52,6 +54,31 @@
 
   _edata = .;			/* End of data section */
 
+/* VSYSCALL_GTOD data */
+#ifdef CONFIG_NEWTOD_VSYSCALL
+
+  /* vsyscall entry */
+   . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  .vsyscall_0 VSYSCALL_GTOD_START: AT ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095)) { *(.vsyscall_0) }
+  __vsyscall_0 = LOADADDR(.vsyscall_0);
+
+
+	/* generic gtod variables */
+  . = ALIGN(64);
+  .vsyscall_gtod_data : AT ((LOADADDR(.vsyscall_0) + SIZEOF(.vsyscall_0) + 63) & ~(63)) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = LOADADDR(.vsyscall_gtod_data);
+
+    . = ALIGN(16);
+  .vsyscall_gtod_lock : AT ((LOADADDR(.vsyscall_gtod_data) + SIZEOF(.vsyscall_gtod_data) + 15) & ~(15)) { *(.vsyscall_gtod_lock) }
+  vsyscall_gtod_lock = LOADADDR(.vsyscall_gtod_lock);
+
+  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
+  . = LOADADDR(.vsyscall_0) + 4096;
+#endif
+/* END of VSYSCALL_GTOD data*/
+
   . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : { *(.data.init_task) }
 
Index: arch/i386/kernel/vsyscall-gtod.c
===================================================================
--- /dev/null  (tree:3b4165efeade40b65ea2e8188184e4f8d3d8d636)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/kernel/vsyscall-gtod.c  (mode:100644)
@@ -0,0 +1,193 @@
+#include <linux/time.h>
+#include <linux/timeofday.h>
+#include <linux/timesource.h>
+#include <linux/sched.h>
+#include <asm/vsyscall-gtod.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/msr.h>
+#include <asm/timer.h>
+#include <asm/system.h>
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+struct vsyscall_gtod_data_t {
+	struct timeval wall_time_tv;
+	struct timezone sys_tz;
+	cycle_t offset_base;
+	struct timesource_t timesource;
+};
+
+struct vsyscall_gtod_data_t vsyscall_gtod_data;
+struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;
+
+seqlock_t vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
+seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
+
+int errno;
+static inline _syscall2(int,gettimeofday,struct timeval *,tv,struct timezone *,tz);
+
+static int vsyscall_mapped = 0; /* flag variable for remap_vsyscall() */
+extern struct timezone sys_tz;
+
+static inline void do_vgettimeofday(struct timeval* tv)
+{
+	cycle_t now, cycle_delta;
+	nsec_t nsec_delta;
+
+	if (__vsyscall_gtod_data.timesource.type == TIMESOURCE_FUNCTION) {
+		gettimeofday(tv, NULL);
+		return;
+	}
+
+	/* read the timeosurce and calc cycle_delta */
+	now = read_timesource(&__vsyscall_gtod_data.timesource);
+	cycle_delta = (now - __vsyscall_gtod_data.offset_base)
+				& __vsyscall_gtod_data.timesource.mask;
+
+	/* convert cycles to nsecs */
+	nsec_delta = cycle_delta * __vsyscall_gtod_data.timesource.mult;
+	nsec_delta = nsec_delta >> __vsyscall_gtod_data.timesource.shift;
+
+	/* add nsec offset to wall_time_tv */
+	*tv = __vsyscall_gtod_data.wall_time_tv;
+	do_div(nsec_delta, NSEC_PER_USEC);
+	tv->tv_usec += (unsigned long) nsec_delta;
+	while (tv->tv_usec > USEC_PER_SEC) {
+		tv->tv_sec += 1;
+		tv->tv_usec -= USEC_PER_SEC;
+	}
+}
+
+static inline void do_get_tz(struct timezone *tz)
+{
+	*tz = __vsyscall_gtod_data.sys_tz;
+}
+
+static int  __vsyscall(0) asmlinkage vgettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&__vsyscall_gtod_lock);
+
+		if (tv)
+			do_vgettimeofday(tv);
+		if (tz)
+			do_get_tz(tz);
+
+	} while (read_seqretry(&__vsyscall_gtod_lock, seq));
+
+	return 0;
+}
+
+static time_t __vsyscall(1) asmlinkage vtime(time_t * t)
+{
+	struct timeval tv;
+	vgettimeofday(&tv,NULL);
+	if (t)
+		*t = tv.tv_sec;
+	return tv.tv_sec;
+}
+
+struct timesource_t* curr_timesource;
+
+void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&vsyscall_gtod_lock, flags);
+
+	/* XXX - hackitty hack hack. this is terrible! */
+	if (curr_timesource != timesource) {
+		if ((timesource->type == TIMESOURCE_MMIO_32)
+				|| (timesource->type == TIMESOURCE_MMIO_64)) {
+			unsigned long vaddr = (unsigned long)timesource->mmio_ptr;
+			pgd_t *pgd = pgd_offset_k(vaddr);
+			pud_t *pud = pud_offset(pgd, vaddr);
+			pmd_t *pmd = pmd_offset(pud,vaddr);
+			pte_t *pte = pte_offset_kernel(pmd, vaddr);
+			pte->pte_low |= _PAGE_USER;
+		}
+	}
+
+	/* save off wall time as timeval */
+	vsyscall_gtod_data.wall_time_tv = ns2timeval(wall_time);
+
+	/* save offset_base */
+	vsyscall_gtod_data.offset_base = offset_base;
+
+	/* copy current timesource */
+	vsyscall_gtod_data.timesource = *timesource;
+
+	/* apply ntp adjustment to timesource mult */
+	vsyscall_gtod_data.timesource.mult += ntp_adj;
+
+	/* save off current timezone */
+	vsyscall_gtod_data.sys_tz = sys_tz;
+
+	write_sequnlock_irqrestore(&vsyscall_gtod_lock, flags);
+
+}
+extern char __vsyscall_0;
+
+static void __init map_vsyscall(void)
+{
+	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - PAGE_OFFSET;
+
+	/* Initially we map the VSYSCALL page w/ PAGE_KERNEL permissions to
+	 * keep the alternate_instruction code from bombing out when it
+	 * changes the seq_lock memory barriers in vgettimeofday()
+	 */
+	__set_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE, physaddr_page0, PAGE_KERNEL);
+}
+
+static int __init remap_vsyscall(void)
+{
+	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - PAGE_OFFSET;
+
+	if (!vsyscall_mapped)
+		return 0;
+
+	/* Remap the VSYSCALL page w/ PAGE_KERNEL_VSYSCALL permissions
+	 * after the alternate_instruction code has run
+	 */
+	clear_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE);
+	__set_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
+
+	return 0;
+}
+
+int __init vsyscall_init(void)
+{
+	printk("VSYSCALL: consistency checks...");
+	if ((unsigned long) &vgettimeofday != VSYSCALL_ADDR(__NR_vgettimeofday)) {
+		printk("vgettimeofday link addr broken\n");
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime)) {
+		printk("vtime link addr broken\n");
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+	if (VSYSCALL_ADDR(0) != __fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE)) {
+		printk("fixmap first vsyscall 0x%lx should be 0x%x\n",
+			__fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE),
+			VSYSCALL_ADDR(0));
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+
+
+	printk("passed...mapping...");
+	map_vsyscall();
+	printk("done.\n");
+	vsyscall_mapped = 1;
+	printk("VSYSCALL: fixmap virt addr: 0x%lx\n",
+		__fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE));
+
+	return 0;
+}
+__initcall(remap_vsyscall);
Index: include/asm-i386/fixmap.h
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/include/asm-i386/fixmap.h  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/include/asm-i386/fixmap.h  (mode:100644)
@@ -27,6 +27,7 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/vsyscall-gtod.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -53,6 +54,11 @@
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_VSYSCALL,
+#ifdef CONFIG_NEWTOD_VSYSCALL
+	FIX_VSYSCALL_GTOD_LAST_PAGE,
+	FIX_VSYSCALL_GTOD_FIRST_PAGE = FIX_VSYSCALL_GTOD_LAST_PAGE
+					+ VSYSCALL_GTOD_NUMPAGES - 1,
+#endif
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
Index: include/asm-i386/pgtable.h
===================================================================
--- 3b4165efeade40b65ea2e8188184e4f8d3d8d636/include/asm-i386/pgtable.h  (mode:100644)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/include/asm-i386/pgtable.h  (mode:100644)
@@ -159,6 +159,8 @@
 #define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_PCD)
 #define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
+#define __PAGE_KERNEL_VSYSCALL \
+	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 
 #define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
@@ -166,6 +168,8 @@
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC)
+#define PAGE_KERNEL_VSYSCALL __pgprot(__PAGE_KERNEL_VSYSCALL)
+#define PAGE_KERNEL_VSYSCALL_NOCACHE __pgprot(__PAGE_KERNEL_VSYSCALL|(__PAGE_KERNEL_RO | _PAGE_PCD))
 
 /*
  * The i386 can't do page protection for execute, and considers that
Index: include/asm-i386/vsyscall-gtod.h
===================================================================
--- /dev/null  (tree:3b4165efeade40b65ea2e8188184e4f8d3d8d636)
+++ 9d016193cc103e4ba0026e943774ef0f774bf72f/include/asm-i386/vsyscall-gtod.h  (mode:100644)
@@ -0,0 +1,41 @@
+#ifndef _ASM_i386_VSYSCALL_GTOD_H_
+#define _ASM_i386_VSYSCALL_GTOD_H_
+
+#ifdef CONFIG_NEWTOD_VSYSCALL
+
+/* VSYSCALL_GTOD_START must be the same as
+ * __fix_to_virt(FIX_VSYSCALL_GTOD FIRST_PAGE)
+ * and must also be same as addr in vmlinux.lds.S */
+#define VSYSCALL_GTOD_START 0xffffd000
+#define VSYSCALL_GTOD_SIZE 1024
+#define VSYSCALL_GTOD_END (VSYSCALL_GTOD_START + PAGE_SIZE)
+#define VSYSCALL_GTOD_NUMPAGES \
+	((VSYSCALL_GTOD_END-VSYSCALL_GTOD_START) >> PAGE_SHIFT)
+#define VSYSCALL_ADDR(vsyscall_nr) \
+	(VSYSCALL_GTOD_START+VSYSCALL_GTOD_SIZE*(vsyscall_nr))
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+#include <linux/seqlock.h>
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+
+/* ReadOnly generic time value attributes*/
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data")))
+
+#define __section_vsyscall_gtod_lock __attribute__ ((unused, __section__ (".vsyscall_gtod_lock")))
+
+
+enum vsyscall_num {
+	__NR_vgettimeofday,
+	__NR_vtime,
+};
+
+int vsyscall_init(void);
+extern char __vsyscall_0;
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#else /* CONFIG_NEWTOD_VSYSCALL */
+#define vsyscall_init()
+#define vsyscall_set_timesource(x)
+#endif /* CONFIG_NEWTOD_VSYSCALL */
+#endif /* _ASM_i386_VSYSCALL_GTOD_H_ */


