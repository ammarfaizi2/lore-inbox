Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbVD2W7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVD2W7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVD2W7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:59:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36321 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263048AbVD2Wsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:48:55 -0400
Subject: [RFC][PATCH (4/4)] new timeofday vsyscall proof of concept (v A4)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: albert@users.sourceforge.net, paulus@samba.org, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1114814872.28231.6.camel@cog.beaverton.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
	 <1114814811.28231.4.camel@cog.beaverton.ibm.com>
	 <1114814872.28231.6.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 15:48:48 -0700
Message-Id: <1114814928.28231.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch implements vsyscall-gettimeofday() functions for i386 and
x86-64 using the new timeofday core code. This is just a hackish proof
of concept that shows how it could be done and what interfaces are
needed to have a clean separation of the arch independent time keeping
and the very arch specific vsyscall code.

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc2_timeofday-vsyscall_A4.patch
===============================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-04-29 15:31:09 -07:00
+++ b/arch/i386/Kconfig	2005-04-29 15:31:09 -07:00
@@ -464,6 +464,10 @@
 	bool "Provide RTC interrupt"
 	depends on HPET_TIMER && RTC=y
 
+config NEWTOD_VSYSCALL
+	depends on EXPERIMENTAL
+	bool "VSYSCALL gettimeofday() interface"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-04-29 15:31:09 -07:00
+++ b/arch/i386/kernel/Makefile	2005-04-29 15:31:09 -07:00
@@ -11,6 +11,7 @@
 
 obj-y				+= cpu/
 obj-$(!CONFIG_NEWTOD)		+= timers/
+obj-$(CONFIG_NEWTOD_VSYSCALL)	+= vsyscall-gtod.o
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2005-04-29 15:31:09 -07:00
+++ b/arch/i386/kernel/setup.c	2005-04-29 15:31:09 -07:00
@@ -51,6 +51,7 @@
 #include <asm/ist.h>
 #include <asm/io.h>
 #include <asm/tsc.h>
+#include <asm/vsyscall-gtod.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -1525,6 +1526,7 @@
 #endif
 #endif
 	tsc_init();
+	vsyscall_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S	2005-04-29 15:31:09 -07:00
+++ b/arch/i386/kernel/vmlinux.lds.S	2005-04-29 15:31:09 -07:00
@@ -5,6 +5,8 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <linux/config.h>
+#include <asm/vsyscall-gtod.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -51,6 +53,31 @@
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   _edata = .;			/* End of data section */
+
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
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : { *(.data.init_task) }
diff -Nru a/arch/i386/kernel/vsyscall-gtod.c b/arch/i386/kernel/vsyscall-gtod.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/kernel/vsyscall-gtod.c	2005-04-29 15:31:09 -07:00
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
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2005-04-29 15:31:09 -07:00
+++ b/arch/x86_64/Kconfig	2005-04-29 15:31:09 -07:00
@@ -57,6 +57,10 @@
 	bool
 	default y
 
+config NEWTOD_VSYSCALL
+	depends on EXPERIMENTAL
+	bool "VSYSCALL gettimeofday() interface"
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2005-04-29 15:31:09 -07:00
+++ b/arch/x86_64/kernel/time.c	2005-04-29 15:31:09 -07:00
@@ -81,6 +81,7 @@
 	rdtscll(*tsc);
 }
 
+#ifndef CONFIG_NEWTOD
 /*
  * do_gettimeoffset() returns microseconds since last timer interrupt was
  * triggered by hardware. A memory read of HPET is slower than a register read
@@ -108,7 +109,6 @@
 
 unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
 
-#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday() has microsecond resolution and better than
  * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
@@ -976,6 +976,7 @@
 	/* Some systems will want to disable TSC and use HPET. */
 	if (oem_force_hpet_timer())
 		notsc = 1;
+#ifndef CONFIG_NEWTOD
 	if (vxtime.hpet_address && notsc) {
 		timetype = "HPET";
 		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
@@ -987,6 +988,7 @@
 	}
 
 	printk(KERN_INFO "time.c: Using %s based timekeeping.\n", timetype);
+#endif /* CONFIG_NEWTOD */
 }
 
 __setup("report_lost_ticks", time_setup);
diff -Nru a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
--- a/arch/x86_64/kernel/vmlinux.lds.S	2005-04-29 15:31:09 -07:00
+++ b/arch/x86_64/kernel/vmlinux.lds.S	2005-04-29 15:31:09 -07:00
@@ -71,6 +71,13 @@
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .jiffies : AT CACHE_ALIGN(AFTER(.xtime)) { *(.jiffies) }
   jiffies = LOADADDR(.jiffies);
+
+  .vsyscall_gtod_data : AT AFTER(.jiffies) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = LOADADDR(.vsyscall_gtod_data);
+  .vsyscall_gtod_lock : AT AFTER(.vsyscall_gtod_data) { *(.vsyscall_gtod_lock) }
+  vsyscall_gtod_lock = LOADADDR(.vsyscall_gtod_lock);
+
+
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
   . = LOADADDR(.vsyscall_0) + 4096;
 
diff -Nru a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c	2005-04-29 15:31:09 -07:00
+++ b/arch/x86_64/kernel/vsyscall.c	2005-04-29 15:31:09 -07:00
@@ -19,6 +19,8 @@
  *  want per guest time just set the kernel.vsyscall64 sysctl to 0.
  */
 
+#include <linux/timeofday.h>
+#include <linux/timesource.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -40,6 +42,21 @@
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
 seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
 
+
+struct vsyscall_gtod_data_t {
+	struct timeval wall_time_tv;
+	struct timezone sys_tz;
+	cycle_t offset_base;
+	struct timesource_t timesource;
+};
+
+extern struct vsyscall_gtod_data_t vsyscall_gtod_data;
+struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;
+
+extern seqlock_t vsyscall_gtod_lock;
+seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
+
+
 #include <asm/unistd.h>
 
 static force_inline void timeval_normalize(struct timeval * tv)
@@ -52,7 +69,7 @@
 		tv->tv_sec += __sec;
 	}
 }
-
+#ifndef CONFIG_NEWTOD_VSYSCALL
 static force_inline void do_vgettimeofday(struct timeval * tv)
 {
 	long sequence, t;
@@ -82,6 +99,52 @@
 	tv->tv_sec = sec + usec / 1000000;
 	tv->tv_usec = usec % 1000000;
 }
+#else /* CONFIG_NEWTOD_VSYSCALL */
+/* XXX - this is ugly. gettimeofday() has a label in it so we can't
+	call it twice.
+ */
+static force_inline int syscall_gtod(struct timeval *tv, struct timezone *tz)
+{
+	int ret;
+	asm volatile("syscall"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+	return ret;
+}
+static force_inline void do_vgettimeofday(struct timeval* tv)
+{
+	cycle_t now, cycle_delta;
+	nsec_t nsec_delta;
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&__vsyscall_gtod_lock);
+
+		if (__vsyscall_gtod_data.timesource.type == TIMESOURCE_FUNCTION) {
+			syscall_gtod(tv, NULL);
+			return;
+		}
+
+		/* read the timeosurce and calc cycle_delta */
+		now = read_timesource(&__vsyscall_gtod_data.timesource);
+		cycle_delta = (now - __vsyscall_gtod_data.offset_base)
+					& __vsyscall_gtod_data.timesource.mask;
+
+		/* convert cycles to nsecs */
+		nsec_delta = cycle_delta * __vsyscall_gtod_data.timesource.mult;
+		nsec_delta = nsec_delta >> __vsyscall_gtod_data.timesource.shift;
+
+		/* add nsec offset to wall_time_tv */
+		*tv = __vsyscall_gtod_data.wall_time_tv;
+		do_div(nsec_delta, NSEC_PER_USEC);
+		tv->tv_usec += (unsigned long) nsec_delta;
+		while (tv->tv_usec > USEC_PER_SEC) {
+			tv->tv_sec += 1;
+			tv->tv_usec -= USEC_PER_SEC;
+		}
+	} while (read_seqretry(&__vsyscall_gtod_lock, seq));
+}
+#endif /* CONFIG_NEWTOD_VSYSCALL */
+
 
 /* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
 static force_inline void do_get_tz(struct timezone * tz)
@@ -139,6 +202,48 @@
 	return -ENOSYS;
 }
 
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
+			*pte = pte_mkread(*pte);
+		}
+		curr_timesource = timesource;
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
+
 #ifdef CONFIG_SYSCTL
 
 #define SYSCALL 0x050f
@@ -217,13 +322,8 @@
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
-/* XXX - disable vsyscall gettimeofday for now */
-#ifndef CONFIG_NEWTOD
 	sysctl_vsyscall = 1;
 	register_sysctl_table(kernel_root_table2, 0);
-#else
-	sysctl_vsyscall = 0;
-#endif
 	return 0;
 }
 
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	2005-04-29 15:31:09 -07:00
+++ b/include/asm-i386/fixmap.h	2005-04-29 15:31:09 -07:00
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
diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	2005-04-29 15:31:09 -07:00
+++ b/include/asm-i386/pgtable.h	2005-04-29 15:31:09 -07:00
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
diff -Nru a/include/asm-i386/vsyscall-gtod.h b/include/asm-i386/vsyscall-gtod.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/vsyscall-gtod.h	2005-04-29 15:31:09 -07:00
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
diff -Nru a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
--- a/include/asm-x86_64/vsyscall.h	2005-04-29 15:31:09 -07:00
+++ b/include/asm-x86_64/vsyscall.h	2005-04-29 15:31:09 -07:00
@@ -22,6 +22,8 @@
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __section_vsyscall_gtod_lock __attribute__ ((unused, __section__ (".vsyscall_gtod_lock"),aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2
diff -Nru a/kernel/timeofday.c b/kernel/timeofday.c
--- a/kernel/timeofday.c	2005-04-29 15:31:09 -07:00
+++ b/kernel/timeofday.c	2005-04-29 15:31:09 -07:00
@@ -41,7 +41,6 @@
 *   o Added getnstimeofday
 *   o Cleanups from Nish Aravamudan
 * TODO List:
-*   o vsyscall/fsyscall infrastructure
 *   o clock_was_set hook
 **********************************************************************/
 
@@ -116,6 +115,12 @@
  */
 extern nsec_t read_persistent_clock(void);
 extern void sync_persistent_clock(struct timespec ts);
+#ifdef CONFIG_NEWTOD_VSYSCALL
+extern void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj);
+#else
+#define arch_update_vsyscall_gtod(x,y,z,w) {}
+#endif
 
 
 /* get_lowres_timestamp():
@@ -282,6 +287,9 @@
 
 	update_legacy_time_values();
 
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
+
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
 	return 0;
@@ -473,6 +481,9 @@
 	/* sync legacy values */
 	update_legacy_time_values();
 
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
+
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
 	/* Set us up to go off on the next interval */
@@ -501,6 +512,9 @@
 	/* clear NTP scaling factor & state machine */
 	ntp_adj = 0;
 	ntp_clear();
+
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
 
 	/* initialize legacy time values */
 	update_legacy_time_values();


