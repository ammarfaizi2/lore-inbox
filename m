Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUH1Js1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUH1Js1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUH1Js0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:48:26 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46490 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267396AbUH1JnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:43:21 -0400
Date: Sat, 28 Aug 2004 18:44:41 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 1/4][diskdump] x86-64 support
In-reply-to: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <8AC48CE3A40753indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for diskdump common layer.


diff -Nur linux-2.6.8.1.org/arch/i386/kernel/nmi.c linux-2.6.8.1/arch/i386/kernel/nmi.c
--- linux-2.6.8.1.org/arch/i386/kernel/nmi.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/i386/kernel/nmi.c	2004-08-26 20:32:58.186207721 +0900
@@ -524,3 +524,4 @@
 EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
+EXPORT_SYMBOL_GPL(touch_nmi_watchdog);
diff -Nur linux-2.6.8.1.org/arch/i386/kernel/reboot.c linux-2.6.8.1/arch/i386/kernel/reboot.c
--- linux-2.6.8.1.org/arch/i386/kernel/reboot.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/i386/kernel/reboot.c	2004-08-26 20:32:58.186207721 +0900
@@ -330,7 +330,8 @@
 	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
 	 * other OSs see a clean IRQ state.
 	 */
-	smp_send_stop();
+	if (!crashdump_mode())
+		smp_send_stop();
 #elif defined(CONFIG_X86_LOCAL_APIC)
 	if (cpu_has_apic) {
 		local_irq_disable();
diff -Nur linux-2.6.8.1.org/arch/i386/kernel/smp.c linux-2.6.8.1/arch/i386/kernel/smp.c
--- linux-2.6.8.1.org/arch/i386/kernel/smp.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/i386/kernel/smp.c	2004-08-26 20:32:58.187184284 +0900
@@ -519,7 +519,7 @@
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(irqs_disabled() && !crashdump_mode());
 
 	data.func = func;
 	data.info = info;
diff -Nur linux-2.6.8.1.org/arch/i386/kernel/traps.c linux-2.6.8.1/arch/i386/kernel/traps.c
--- linux-2.6.8.1.org/arch/i386/kernel/traps.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/i386/kernel/traps.c	2004-08-26 20:32:58.187184284 +0900
@@ -293,6 +293,7 @@
 }
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+static int die_owner = -1;
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
@@ -300,7 +301,13 @@
 	int nl = 0;
 
 	console_verbose();
-	spin_lock_irq(&die_lock);
+	local_irq_disable();
+	if (!spin_trylock(&die_lock)) {
+		if (smp_processor_id() != die_owner)
+			spin_lock(&die_lock);
+		/* allow recursive die to fall through */
+	}
+	die_owner = smp_processor_id();
 	bust_spinlocks(1);
 	handle_BUG(regs);
 	printk(KERN_ALERT "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
@@ -319,7 +326,9 @@
 	if (nl)
 		printk("\n");
 	show_registers(regs);
+	try_crashdump(regs);
 	bust_spinlocks(0);
+	die_owner = -1;
 	spin_unlock_irq(&die_lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
diff -Nur linux-2.6.8.1.org/arch/i386/mm/init.c linux-2.6.8.1/arch/i386/mm/init.c
--- linux-2.6.8.1.org/arch/i386/mm/init.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/i386/mm/init.c	2004-08-26 20:32:58.188160846 +0900
@@ -185,7 +185,54 @@
 
 extern int is_available_memory(efi_memory_desc_t *);
 
-static inline int page_is_ram(unsigned long pagenr)
+unsigned long next_ram_page(unsigned long pagenr)
+{
+	int i;
+	unsigned long addr, end;
+	unsigned long min_pageno = ULONG_MAX;
+
+	pagenr++;
+
+	if (efi_enabled) {
+		efi_memory_desc_t *md;
+
+		for (i = 0; i < memmap.nr_map; i++) {
+			md = &memmap.map[i];
+			if (!is_available_memory(md))
+				continue;
+			addr = (md->phys_addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+			end = (md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >> PAGE_SHIFT;
+
+			if ((pagenr >= addr) && (pagenr < end))
+				return pagenr;
+			if ((pagenr < addr) && (addr < min_pageno))
+				min_pageno = addr;
+		}
+		return min_pageno;
+	}
+
+	for (i = 0; i < e820.nr_map; i++) {
+
+		if (e820.map[i].type != E820_RAM)	/* not usable memory */
+			continue;
+		/*
+		 *	!!!FIXME!!! Some BIOSen report areas as RAM that
+		 *	are not. Notably the 640->1Mb area. We need a sanity
+		 *	check here.
+		 */
+		addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+		end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
+		if  ((pagenr >= addr) && (pagenr < end))
+			return pagenr;
+		if ((pagenr < addr) && (addr < min_pageno))
+			min_pageno = addr;
+	}
+	return min_pageno;
+}
+
+EXPORT_SYMBOL_GPL(next_ram_page);
+
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 	unsigned long addr, end;
@@ -223,6 +270,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL_GPL(page_is_ram);
+
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
diff -Nur linux-2.6.8.1.org/arch/ia64/kernel/process.c linux-2.6.8.1/arch/ia64/kernel/process.c
--- linux-2.6.8.1.org/arch/ia64/kernel/process.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/ia64/kernel/process.c	2004-08-26 20:32:58.189137409 +0900
@@ -38,6 +38,7 @@
 #include <asm/uaccess.h>
 #include <asm/unwind.h>
 #include <asm/user.h>
+#include <asm/diskdump.h>
 
 #ifdef CONFIG_PERFMON
 # include <asm/perfmon.h>
@@ -547,11 +548,13 @@
 }
 
 void
-do_copy_regs (struct unw_frame_info *info, void *arg)
+ia64_do_copy_regs (struct unw_frame_info *info, void *arg)
 {
 	do_copy_task_regs(current, info, arg);
 }
 
+EXPORT_SYMBOL(ia64_do_copy_regs);
+
 void
 do_dump_fpu (struct unw_frame_info *info, void *arg)
 {
@@ -564,7 +567,7 @@
 	struct unw_frame_info tcore_info;
 
 	if (current == task) {
-		unw_init_running(do_copy_regs, regs);
+		unw_init_running(ia64_do_copy_regs, regs);
 	} else {
 		memset(&tcore_info, 0, sizeof(tcore_info));
 		unw_init_from_blocked_task(&tcore_info, task);
@@ -576,7 +579,7 @@
 void
 ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
 {
-	unw_init_running(do_copy_regs, dst);
+	unw_init_running(ia64_do_copy_regs, dst);
 }
 
 int
@@ -765,3 +768,22 @@
 }
 
 EXPORT_SYMBOL(machine_power_off);
+
+void
+ia64_freeze_cpu (struct unw_frame_info *info, void *arg)
+{
+	current->thread.ksp = (__u64)(info->sw) - 16;
+	for (;;) local_irq_disable();
+}
+
+EXPORT_SYMBOL(ia64_freeze_cpu);
+
+void
+ia64_start_dump (struct unw_frame_info *info, void *arg)
+{
+	struct dump_call_param *param = arg;
+
+	param->func(param->regs, info);
+}
+
+EXPORT_SYMBOL(ia64_start_dump);
diff -Nur linux-2.6.8.1.org/arch/ia64/kernel/smp.c linux-2.6.8.1/arch/ia64/kernel/smp.c
--- linux-2.6.8.1.org/arch/ia64/kernel/smp.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/ia64/kernel/smp.c	2004-08-26 20:32:58.189137409 +0900
@@ -332,7 +332,7 @@
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(irqs_disabled() && !crashdump_mode());
 
 	data.func = func;
 	data.info = info;
diff -Nur linux-2.6.8.1.org/arch/ia64/kernel/traps.c linux-2.6.8.1/arch/ia64/kernel/traps.c
--- linux-2.6.8.1.org/arch/ia64/kernel/traps.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/ia64/kernel/traps.c	2004-08-26 20:32:58.190113971 +0900
@@ -92,6 +92,7 @@
   	} else
 		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
 
+	try_crashdump(regs);
 	bust_spinlocks(0);
 	die.lock_owner = -1;
 	spin_unlock_irq(&die.lock);
diff -Nur linux-2.6.8.1.org/arch/ia64/mm/init.c linux-2.6.8.1/arch/ia64/mm/init.c
--- linux-2.6.8.1.org/arch/ia64/mm/init.c	2004-08-25 15:55:49.000000000 +0900
+++ linux-2.6.8.1/arch/ia64/mm/init.c	2004-08-26 20:32:58.190113971 +0900
@@ -254,6 +254,94 @@
 	return page;
 }
 
+struct curr_mem_request {
+	unsigned long requested;
+	unsigned long min_physaddr;
+	int found;
+};
+
+/*
+ *  Check whether a physical address fits within the memory descriptor
+ *  block sent from efi_mmap_walk(). If it fits, set found.
+ */
+static int
+verify_physaddr (unsigned long start, unsigned long end, void *arg)
+{
+	struct curr_mem_request *cr = arg;
+
+	start = __pa(start);
+	end = __pa(end);
+
+	if ((cr->requested >= start) && (cr->requested + PAGE_SIZE) <= end) {
+		cr->found = 1;
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * If physical page 'nr' is valid RAM then return 1.  Otherwise return 0.
+ */
+int
+page_is_ram (unsigned long pagenr)
+{
+	struct curr_mem_request cr;
+
+	if (!pfn_valid(pagenr))
+		return 0;
+
+	cr.requested = pagenr << PAGE_SHIFT;
+	cr.found = 0;
+
+	efi_memmap_walk(verify_physaddr, &cr);
+
+	return cr.found;
+}
+EXPORT_SYMBOL_GPL(page_is_ram);
+
+static int
+find_next (unsigned long start, unsigned long end, void *arg)
+{
+	struct curr_mem_request *cr = (struct curr_mem_request *)arg;
+
+	start = __pa(start);
+	end = __pa(end);
+
+	if ((cr->requested >= start) && (cr->requested + PAGE_SIZE) <= end) {
+		cr->min_physaddr = cr->requested;
+		cr->found = 1;
+		return -1;
+	}
+	if ((cr->requested < start) && (start + PAGE_SIZE) <= end)
+		if (start < cr->min_physaddr) {
+			cr->min_physaddr = start;
+			cr->found = 1;
+		}
+
+	return 0;
+}
+
+unsigned long
+next_ram_page (unsigned long pagenr)
+{
+	struct curr_mem_request cr;
+
+	pagenr++;
+
+	cr.requested = pagenr << PAGE_SHIFT;
+	cr.found = 0;
+	cr.min_physaddr = ULONG_MAX;
+
+	efi_memmap_walk(find_next, &cr);
+
+	if (cr.found)
+		return cr.min_physaddr >> PAGE_SHIFT;
+	else
+		return ULONG_MAX;
+}
+EXPORT_SYMBOL_GPL(next_ram_page);
+
 static void
 setup_gate (void)
 {
diff -Nur linux-2.6.8.1.org/arch/x86_64/kernel/reboot.c linux-2.6.8.1/arch/x86_64/kernel/reboot.c
--- linux-2.6.8.1.org/arch/x86_64/kernel/reboot.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/arch/x86_64/kernel/reboot.c	2004-08-26 20:32:58.191090534 +0900
@@ -130,7 +130,8 @@
 	int i;
 
 #ifdef CONFIG_SMP
-	smp_halt(); 
+	if (!crashdump_mode())
+		smp_halt(); 
 #endif
 
 	local_irq_disable();
@@ -141,7 +142,8 @@
 
 	disable_IO_APIC();
 	
-	local_irq_enable();
+	if (!crashdump_mode())
+		local_irq_enable();
 	
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
diff -Nur linux-2.6.8.1.org/arch/x86_64/kernel/smp.c linux-2.6.8.1/arch/x86_64/kernel/smp.c
--- linux-2.6.8.1.org/arch/x86_64/kernel/smp.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/arch/x86_64/kernel/smp.c	2004-08-26 20:32:58.191090534 +0900
@@ -405,7 +405,7 @@
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(irqs_disabled() && !crashdump_mode());
 
 	data.func = func;
 	data.info = info;
diff -Nur linux-2.6.8.1.org/arch/x86_64/kernel/traps.c linux-2.6.8.1/arch/x86_64/kernel/traps.c
--- linux-2.6.8.1.org/arch/x86_64/kernel/traps.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/arch/x86_64/kernel/traps.c	2004-08-28 14:15:24.375774680 +0900
@@ -359,6 +359,7 @@
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
+	try_crashdump(regs);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
diff -Nur linux-2.6.8.1.org/arch/x86_64/mm/init.c linux-2.6.8.1/arch/x86_64/mm/init.c
--- linux-2.6.8.1.org/arch/x86_64/mm/init.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/arch/x86_64/mm/init.c	2004-08-26 20:32:58.193043659 +0900
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/proc_fs.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -374,7 +375,36 @@
 	__flush_tlb_all();
 } 
 
-static inline int page_is_ram (unsigned long pagenr)
+unsigned long next_ram_page (unsigned long pagenr)
+{
+	int i;
+	unsigned long min_pageno = ULONG_MAX;
+
+	pagenr++;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long addr, end;
+
+		if (e820.map[i].type != E820_RAM)	/* not usable memory */
+			continue;
+		/*
+		 *	!!!FIXME!!! Some BIOSen report areas as RAM that
+		 *	are not. Notably the 640->1Mb area. We need a sanity
+		 *	check here.
+		 */
+		addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+		end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
+		if  ((pagenr >= addr) && (pagenr < end))
+			return pagenr;
+		if ((pagenr < addr) && (addr < min_pageno))
+			min_pageno = addr;
+	}
+	return min_pageno;
+}
+
+EXPORT_SYMBOL_GPL(next_ram_page);
+
+int page_is_ram (unsigned long pagenr)
 {
 	int i;
 
@@ -396,6 +426,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL_GPL(page_is_ram);
+
 static struct kcore_list kcore_mem, kcore_vmalloc, kcore_kernel, kcore_modules,
 			 kcore_vsyscall;
 
@@ -548,6 +580,7 @@
 		return 0;
 	return pfn_valid(pte_pfn(*pte));
 }
+EXPORT_SYMBOL_GPL(kern_addr_valid);
 
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
diff -Nur linux-2.6.8.1.org/drivers/block/Kconfig linux-2.6.8.1/drivers/block/Kconfig
--- linux-2.6.8.1.org/drivers/block/Kconfig	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/drivers/block/Kconfig	2004-08-26 20:32:58.193043659 +0900
@@ -347,6 +347,11 @@
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
+config DISKDUMP
+	tristate "Disk dump support"
+	---help---
+	  Disk dump support.
+
 source "drivers/s390/block/Kconfig"
 
 endmenu
diff -Nur linux-2.6.8.1.org/drivers/block/Makefile linux-2.6.8.1/drivers/block/Makefile
--- linux-2.6.8.1.org/drivers/block/Makefile	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/drivers/block/Makefile	2004-08-26 20:32:58.193043659 +0900
@@ -43,3 +43,4 @@
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 
+obj-$(CONFIG_DISKDUMP)		+= diskdump.o
diff -Nur linux-2.6.8.1.org/drivers/block/diskdump.c linux-2.6.8.1/drivers/block/diskdump.c
--- linux-2.6.8.1.org/drivers/block/diskdump.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/drivers/block/diskdump.c	2004-08-26 20:32:58.195973346 +0900
@@ -0,0 +1,992 @@
+/*
+ *  linux/drivers/block/diskdump.c
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Copyright (C) 2002  Red Hat, Inc.
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ *  Some codes were derived from netdump and copyright belongs to
+ *  Red Hat, Inc.
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/smp_lock.h>
+#include <linux/nmi.h>
+#include <linux/crc32.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/diskdump.h>
+#include <asm/diskdump.h>
+
+#define Dbg(x, ...)	pr_debug("disk_dump: " x "\n", ## __VA_ARGS__)
+#define Err(x, ...)	pr_err  ("disk_dump: " x "\n", ## __VA_ARGS__)
+#define Warn(x, ...)	pr_warn ("disk_dump: " x "\n", ## __VA_ARGS__)
+#define Info(x, ...)	pr_info ("disk_dump: " x "\n", ## __VA_ARGS__)
+
+#define ROUNDUP(x, y)	(((x) + ((y)-1))/(y))
+
+/* 512byte sectors to blocks */
+#define SECTOR_BLOCK(s)	((s) >> (DUMP_BLOCK_SHIFT - 9))
+
+/* The number of block which is used for saving format information */
+#define USER_PARAM_BLOCK	2
+
+static int fallback_on_err = 1;
+static int allow_risky_dumps = 1;
+static unsigned int block_order = 2;
+static int sample_rate = 8;
+module_param_named(fallback_on_err, fallback_on_err, bool, S_IRUGO|S_IWUSR);
+module_param_named(allow_risky_dumps, allow_risky_dumps, bool, S_IRUGO|S_IWUSR);
+module_param_named(block_order, block_order, uint, S_IRUGO|S_IWUSR);
+module_param_named(sample_rate, sample_rate, int, S_IRUGO|S_IWUSR);
+
+static unsigned long timestamp_1sec;
+static uint32_t module_crc;
+static char *scratch;
+static struct disk_dump_header dump_header;
+static struct disk_dump_sub_header dump_sub_header;
+
+/* Registered dump devices */
+static LIST_HEAD(disk_dump_devices);
+
+/* Registered dump types, e.g. SCSI, ... */
+static LIST_HEAD(disk_dump_types);
+
+static DECLARE_MUTEX(disk_dump_mutex);
+
+static unsigned int header_blocks;		/* The size of all headers */
+static unsigned int bitmap_blocks;		/* The size of bitmap header */
+static unsigned int total_ram_blocks;		/* The size of memory */
+static unsigned int total_blocks;		/* The sum of above */
+/*
+ * This is not a parameter actually, but used to pass the number of
+ * required blocks to userland tools
+ */
+module_param_named(total_blocks, total_blocks, uint, S_IRUGO);
+
+struct notifier_block *disk_dump_notifier_list;
+EXPORT_SYMBOL(disk_dump_notifier_list);
+
+unsigned long volatile diskdump_base_jiffies;
+void *diskdump_stack;
+
+extern int panic_timeout;
+extern unsigned long max_pfn;
+
+static asmlinkage void disk_dump(struct pt_regs *, void *);
+
+
+#if CONFIG_SMP
+static void freeze_cpu(void *dummy)
+{
+	unsigned int cpu = smp_processor_id();
+
+	dump_header.tasks[cpu] = current;
+
+	platform_freeze_cpu();
+}
+#endif
+
+static int lapse = 0;		/* 200msec unit */
+
+static inline unsigned long eta(unsigned long nr, unsigned long maxnr)
+{
+	unsigned long long eta;
+
+	if (nr == 0)
+		nr = 1;
+
+	eta = ((maxnr << 8) / nr) * (unsigned long long)lapse;
+
+	return (unsigned long)(eta >> 8) - lapse;
+}
+
+static inline void print_status(unsigned int nr, unsigned int maxnr)
+{
+	static char *spinner = "/|\\-";
+	static unsigned long long prev_timestamp = 0;
+	unsigned long long timestamp;
+
+	if (nr == 0)
+		nr++;
+
+	platform_timestamp(timestamp);
+
+	if (timestamp - prev_timestamp > (timestamp_1sec/5)) {
+		prev_timestamp = timestamp;
+		lapse++;
+		printk("%u/%u    %lu ETA %c          \r",
+			nr, maxnr, eta(nr, maxnr) / 5, spinner[lapse & 3]);
+	}
+}
+
+static inline void clear_status(int nr, int maxnr)
+{
+	printk("                                       \r");
+	lapse = 0;
+}
+
+/*
+ * Checking the signature on a block. The format is as follows.
+ *
+ * 1st word = 'disk'
+ * 2nd word = 'dump'
+ * 3rd word = block number
+ * 4th word = ((block number + 7) * 11) & 0xffffffff
+ * 5th word = ((4th word + 7)* 11) & 0xffffffff
+ * ..
+ *
+ * Return 1 if the signature is correct, else return 0
+ */
+static int check_block_signature(void *buf, unsigned int block_nr)
+{
+	int word_nr = PAGE_SIZE / sizeof(int);
+	int *words = buf;
+	unsigned int val;
+	int i;
+
+	/*
+	 * Block 2 is used for the area which formatter saves options like
+	 * the sampling rate or the number of blocks. the Kernel part does not
+	 * check this block.
+	 */
+	if (block_nr == USER_PARAM_BLOCK)
+		return 1;
+
+	if (memcmp(buf, DUMP_PARTITION_SIGNATURE, sizeof(*words)))
+		return 0;
+
+	val = block_nr;
+	for (i = 2; i < word_nr; i++) {
+		if (words[i] != val)
+			return 0;
+		val = (val + 7) * 11;
+	}
+
+	return 1;
+}
+
+/*
+ * Read one block into the dump partition
+ */
+static int read_blocks(struct disk_dump_partition *dump_part, unsigned int nr,
+		       char *buf, int len)
+{
+	struct disk_dump_device *device = dump_part->device;
+	int ret;
+
+	local_irq_disable();
+	touch_nmi_watchdog();
+	ret = device->ops.rw_block(dump_part, READ, nr, buf, len);
+	if (ret < 0) {
+		Err("read error on block %u", nr);
+		return ret;
+	}
+	return 0;
+}
+
+static int write_blocks(struct disk_dump_partition *dump_part, unsigned int offs, char *buf, int len)
+{
+	struct disk_dump_device *device = dump_part->device;
+	int ret;
+
+	local_irq_disable();
+	touch_nmi_watchdog();
+	ret = device->ops.rw_block(dump_part, WRITE, offs, buf, len);
+	if (ret < 0) {
+		Err("write error on block %u", offs);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * Initialize the common header
+ */
+
+/*
+ * Write the common header
+ */
+static int write_header(struct disk_dump_partition *dump_part)
+{
+	memset(scratch, 0, PAGE_SIZE);
+	memcpy(scratch, &dump_header, sizeof(dump_header));
+
+	return write_blocks(dump_part, 1, scratch, 1);
+}
+
+/*
+ * Check the signaures in all blocks of the dump partition
+ * Return 1 if the signature is correct, else return 0
+ */
+static int check_dump_partition(struct disk_dump_partition *dump_part,
+				unsigned int partition_size)
+{
+	unsigned int blk;
+	int ret;
+	unsigned int chunk_blks, skips;
+	int i;
+
+	if (sample_rate < 0)		/* No check */
+		return 1;
+
+	/*
+	 * If the device has limitations of transfer size, use it.
+	 */
+	chunk_blks = 1 << block_order;
+	if (dump_part->device->max_blocks)
+		 chunk_blks = min(chunk_blks, dump_part->device->max_blocks);
+	skips = chunk_blks << sample_rate;
+
+	lapse = 0;
+	for (blk = 0; blk < partition_size; blk += skips) {
+		unsigned int len;
+redo:
+		len = min(chunk_blks, partition_size - blk);
+		if ((ret = read_blocks(dump_part, blk, scratch, len)) < 0)
+			return 0;
+		print_status(blk + 1, partition_size);
+		for (i = 0; i < len; i++)
+			if (!check_block_signature(scratch + i * DUMP_BLOCK_SIZE, blk + i)) {
+				Err("bad signature in block %u", blk + i);
+				return 0;
+			}
+	}
+	/* Check the end of the dump partition */
+	if (blk - skips + chunk_blks < partition_size) {
+		blk = partition_size - chunk_blks;
+		goto redo;
+	}
+	clear_status(blk, partition_size);
+	return 1;
+}
+
+/*
+ * Write memory bitmap after location of dump headers.
+ */
+#define PAGE_PER_BLOCK	(PAGE_SIZE * 8)
+#define idx_to_pfn(nr, byte, bit) (((nr) * PAGE_SIZE + (byte)) * 8 + (bit))
+
+static int write_bitmap(struct disk_dump_partition *dump_part,
+			unsigned int bitmap_offset, unsigned int bitmap_blocks)
+{
+	unsigned int nr;
+	unsigned long pfn, next_ram_pfn;
+	int bit, byte;
+	int ret = 0;
+	unsigned char val;
+
+	for (nr = 0; nr < bitmap_blocks; nr++) {
+		pfn = idx_to_pfn(nr, 0, 0);
+		next_ram_pfn = next_ram_page(pfn - 1);
+
+		if (pfn + PAGE_PER_BLOCK <= next_ram_pfn)
+			memset(scratch, 0, PAGE_SIZE);
+		else
+			for (byte = 0; byte < PAGE_SIZE; byte++) {
+				val = 0;
+				for (bit = 0; bit < 8; bit++)
+					if (page_is_ram(idx_to_pfn(nr, byte,
+								   bit)))
+						val |= (1 << bit);
+				scratch[byte] = (char)val;
+			}
+		if ((ret = write_blocks(dump_part, bitmap_offset + nr,
+					scratch, 1)) < 0) {
+			Err("I/O error %d on block %u", ret, bitmap_offset + nr);
+			break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Write whole memory to dump partition.
+ * Return value is the number of writen blocks.
+ */
+static int write_memory(struct disk_dump_partition *dump_part, int offset,
+			unsigned int max_blocks_written,
+			unsigned int *blocks_written)
+{
+	char *kaddr;
+	unsigned int blocks = 0;
+	struct page *page;
+	unsigned long nr;
+	int ret = 0;
+	int blk_in_chunk = 0;
+
+	for (nr = next_ram_page(ULONG_MAX); nr < ULONG_MAX; nr = next_ram_page(nr)) {
+		print_status(blocks, max_blocks_written);
+
+
+		if (blocks >= max_blocks_written) {
+			Warn("dump device is too small. %lu pages were not saved", max_pfn - blocks);
+			goto out;
+		}
+
+		page = pfn_to_page(nr);
+		if (nr != page_to_pfn(page)) {
+			/* page_to_pfn() is called from kmap_atomic().
+			 * If page->flag is broken, it specified a wrong
+			 * zone and it causes kmap_atomic() fail.
+			 */
+			Err("Bad page. PFN %lu flags %lx\n",
+			    nr, (unsigned long)page->flags);
+			memset(scratch + blk_in_chunk * PAGE_SIZE, 0,
+			       PAGE_SIZE);
+			sprintf(scratch + blk_in_chunk * PAGE_SIZE,
+				"Bad page. PFN %lu flags %lx\n",
+			 	 nr, (unsigned long)page->flags);
+			goto write;
+		}
+
+		if (!kern_addr_valid((unsigned long)pfn_to_kaddr(nr))) {
+			memset(scratch + blk_in_chunk * PAGE_SIZE, 0,
+			       PAGE_SIZE);
+			sprintf(scratch + blk_in_chunk * PAGE_SIZE,
+				"Unmapped page. PFN %lu\n", nr);
+			goto write;
+		}
+
+		kaddr = kmap_atomic(page, KM_CRASHDUMP);
+		/*
+		 * need to copy because adapter drivers use
+		 * virt_to_bus()
+		 */
+		memcpy(scratch + blk_in_chunk * PAGE_SIZE, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_CRASHDUMP);
+
+write:
+		blk_in_chunk++;
+		blocks++;
+
+		if (blk_in_chunk >= (1 << block_order)) {
+			ret = write_blocks(dump_part, offset, scratch,
+					   blk_in_chunk);
+			if (ret < 0) {
+				Err("I/O error %d on block %u", ret, offset);
+				break;
+			}
+			offset += blk_in_chunk;
+			blk_in_chunk = 0;
+		}
+	}
+	if (ret >= 0 && blk_in_chunk > 0) {
+		ret = write_blocks(dump_part, offset, scratch, blk_in_chunk);
+		if (ret < 0)
+			Err("I/O error %d on block %u", ret, offset);
+	}
+
+out:
+	clear_status(nr, max_blocks_written);
+
+	*blocks_written = blocks;
+	return ret;
+}
+
+/*
+ * Select most suitable dump device. sanity_check() returns the state
+ * of each dump device. 0 means OK, negative value means NG, and
+ * positive value means it maybe work. select_dump_partition() first
+ * try to select a sane device and if it has no sane device and
+ * allow_risky_dumps is set, it select one from maybe OK devices.
+ *
+ * XXX We cannot handle multiple partitions yet.
+ */
+static struct disk_dump_partition *select_dump_partition(void)
+{
+	struct disk_dump_device *dump_device;
+	struct disk_dump_partition *dump_part;
+	int sanity;
+	int strict_check = 1;
+
+redo:
+	/*
+	 * Select a sane polling driver.
+	 */
+	list_for_each_entry(dump_device, &disk_dump_devices, list) {
+		sanity = 0;
+		if (dump_device->ops.sanity_check)
+			sanity = dump_device->ops.sanity_check(dump_device);
+		if (sanity < 0 || (sanity > 0 && strict_check))
+			continue;
+		list_for_each_entry(dump_part, &dump_device->partitions, list)
+				return dump_part;
+	}
+	if (allow_risky_dumps && strict_check) {
+		strict_check = 0;
+		goto redo;
+	}
+	return NULL;
+}
+
+static int dump_err = 0;	/* Indicate Error state which occured in
+				 * disk_dump(). We need to make it global
+				 * because disk_dump() can't pass
+				 * error state as return value.
+				 */
+
+static void freeze_other_cpus(void)
+{
+#if CONFIG_SMP
+	int	i;
+
+	smp_call_function(freeze_cpu, NULL, 1, 0);
+	mdelay(3000);
+	printk("CPU frozen: ");
+	for (i = 0; i < NR_CPUS; i++) {
+		if (dump_header.tasks[i] != NULL)
+			printk("#%d", i);
+
+	}
+	printk("\n");
+	printk("CPU#%d is executing diskdump.\n", smp_processor_id());
+#else
+	mdelay(1000);
+#endif
+	dump_header.tasks[smp_processor_id()] = current;
+}
+
+static void start_disk_dump(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	/* Inhibit interrupt and stop other CPUs */
+	local_irq_save(flags);
+	preempt_disable();
+
+	/*
+	 * Check the checksum of myself
+	 */
+	if (down_trylock(&disk_dump_mutex)) {
+		Err("down_trylock(disk_dump_mutex) failed.");
+		goto done;
+	}
+
+	if (!check_crc_module()) {
+		Err("checksum error. diskdump common module may be compromised.");
+		goto done;
+	}
+
+	diskdump_mode = 1;
+
+	Dbg("notify dump start.");
+	notifier_call_chain(&disk_dump_notifier_list, 0, NULL);
+
+	freeze_other_cpus();
+
+	/*
+	 *  Some platforms may want to execute netdump on its own stack.
+	 */
+	platform_start_crashdump(diskdump_stack, disk_dump, regs);
+
+done:
+	/*
+	 * If diskdump failed and fallback_on_err is set,
+	 * We just return and leave panic to netdump.
+	 */
+	if (fallback_on_err && dump_err)
+		return;
+
+	Dbg("notify panic.");
+	notifier_call_chain(&panic_notifier_list, 0, NULL);
+
+	if (panic_timeout > 0) {
+		int i;
+		/*
+	 	 * Delay timeout seconds before rebooting the machine. 
+		 * We can't use the "normal" timers since we just panicked..
+	 	 */
+		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
+		for (i = 0; i < panic_timeout; i++) {
+			touch_nmi_watchdog();
+			mdelay(1000);
+		}
+
+		/*
+		 *	Should we run the reboot notifier. For the moment Im
+		 *	choosing not too. It might crash, be corrupt or do
+		 *	more harm than good for other reasons.
+		 */
+		machine_restart(NULL);
+	}
+	printk(KERN_EMERG "halt\n");
+	for (;;) {
+		touch_nmi_watchdog();
+		machine_halt();
+		mdelay(1000);
+	}
+}
+
+static asmlinkage void disk_dump(struct pt_regs *regs, void *platform_arg)
+{
+	struct pt_regs myregs;
+	unsigned int max_written_blocks, written_blocks;
+	struct disk_dump_device *dump_device = NULL;
+	struct disk_dump_partition *dump_part = NULL;
+	int ret;
+
+	dump_err = -EIO;
+
+	/*
+	 * Setup timer/tasklet
+	 */
+	dump_clear_timers();
+	dump_clear_tasklet();
+	dump_clear_workqueue();
+
+	/* Save original jiffies value */
+	diskdump_base_jiffies = jiffies;
+
+	diskdump_setup_timestamp();
+
+	platform_fix_regs();
+
+	if (list_empty(&disk_dump_devices)) {
+		Err("adapter driver is not registered.");
+		goto done;
+	}
+
+	printk("start dumping\n");
+
+	if (!(dump_part = select_dump_partition())) {
+		Err("No sane dump device found");
+		goto done;
+	}
+	dump_device = dump_part->device;
+
+	/*
+	 * Stop ongoing I/O with polling driver and make the shift to I/O mode
+	 * for dump
+	 */
+	Dbg("do quiesce");
+	if (dump_device->ops.quiesce)
+		if ((ret = dump_device->ops.quiesce(dump_device)) < 0) {
+			Err("quiesce failed. error %d", ret);
+			goto done;
+		}
+
+	if (SECTOR_BLOCK(dump_part->nr_sects) < header_blocks + bitmap_blocks) {
+		Warn("dump partition is too small. Aborted");
+		goto done;
+	}
+
+	/* Check dump partition */
+	printk("check dump partition...\n");
+	if (!check_dump_partition(dump_part, total_blocks)) {
+		Err("check partition failed.");
+		goto done;
+	}
+
+	/*
+	 * Write the common header
+	 */
+	memcpy(dump_header.signature, DISK_DUMP_SIGNATURE,
+	       sizeof(dump_header.signature));
+	dump_header.utsname	     = system_utsname;
+	dump_header.timestamp	     = xtime;
+	dump_header.status	     = DUMP_HEADER_INCOMPLETED;
+	dump_header.block_size	     = PAGE_SIZE;
+	dump_header.sub_hdr_size     = size_of_sub_header();
+	dump_header.bitmap_blocks    = bitmap_blocks;
+	dump_header.max_mapnr	     = max_pfn;
+	dump_header.total_ram_blocks = total_ram_blocks;
+	dump_header.device_blocks    = SECTOR_BLOCK(dump_part->nr_sects);
+	dump_header.current_cpu	     = smp_processor_id();
+	dump_header.nr_cpus	     = num_online_cpus();
+	dump_header.written_blocks   = 2;
+
+	write_header(dump_part);
+
+	/*
+	 * Write the architecture dependent header
+	 */
+	Dbg("write sub header");
+	if ((ret = write_sub_header()) < 0) {
+		Err("writing sub header failed. error %d", ret);
+		goto done;
+	}
+
+	Dbg("writing memory bitmaps..");
+	if ((ret = write_bitmap(dump_part, header_blocks, bitmap_blocks)) < 0)
+		goto done;
+
+	max_written_blocks = total_ram_blocks;
+	if (dump_header.device_blocks < total_blocks) {
+		Warn("dump partition is too small. actual blocks %u. expected blocks %u. whole memory will not be saved",
+				dump_header.device_blocks, total_blocks);
+		max_written_blocks -= (total_blocks - dump_header.device_blocks);
+	}
+
+	dump_header.written_blocks += dump_header.sub_hdr_size;
+	dump_header.written_blocks += dump_header.bitmap_blocks;
+	write_header(dump_part);
+
+	printk("dumping memory..\n");
+	if ((ret = write_memory(dump_part, header_blocks + bitmap_blocks,
+				max_written_blocks, &written_blocks)) < 0)
+		goto done;
+
+	/*
+	 * Set the number of block that is written into and write it
+	 * into partition again.
+	 */
+	dump_header.written_blocks += written_blocks;
+	dump_header.status = DUMP_HEADER_COMPLETED;
+	write_header(dump_part);
+
+	dump_err = 0;
+
+done:
+	Dbg("do adapter shutdown.");
+	if (dump_device && dump_device->ops.shutdown)
+		if (dump_device->ops.shutdown(dump_device))
+			Err("adapter shutdown failed.");
+}
+
+static struct disk_dump_partition *find_dump_partition(struct block_device *bdev)
+{
+	struct disk_dump_device *dump_device;
+	struct disk_dump_partition *dump_part;
+
+	list_for_each_entry(dump_device, &disk_dump_devices, list)
+		list_for_each_entry(dump_part, &dump_device->partitions, list)
+			if (dump_part->bdev == bdev)
+				return dump_part;
+	return NULL;
+}
+
+static struct disk_dump_device *find_dump_device(struct disk_dump_device *device)
+{
+	struct disk_dump_device *dump_device;
+
+	list_for_each_entry(dump_device, &disk_dump_devices, list)
+		if (device->device == dump_device->device)
+			return  dump_device;
+	return NULL;
+}
+
+static void *find_real_device(struct device *dev,
+			      struct disk_dump_type **_dump_type)
+{
+	void *real_device;
+	struct disk_dump_type *dump_type;
+
+	list_for_each_entry(dump_type, &disk_dump_types, list)
+		if ((real_device = dump_type->probe(dev)) != NULL) {
+			*_dump_type = dump_type;
+			return real_device;
+		}
+	return NULL;
+}
+
+/*
+ * Add dump partition structure corresponding to file to the dump device
+ * structure.
+ */
+static int add_dump_partition(struct disk_dump_device *dump_device,
+			      struct block_device *bdev)
+{
+	struct disk_dump_partition *dump_part;
+	char buffer[BDEVNAME_SIZE];
+
+	if (!(dump_part = kmalloc(sizeof(*dump_part), GFP_KERNEL)))
+		return -ENOMEM;
+
+	dump_part->device = dump_device;
+	dump_part->bdev = bdev;
+
+	if (!bdev || !bdev->bd_part)
+		return -EINVAL;
+	dump_part->nr_sects   = bdev->bd_part->nr_sects;
+	dump_part->start_sect = bdev->bd_part->start_sect;
+
+	if (SECTOR_BLOCK(dump_part->nr_sects) < total_blocks)
+		Warn("%s is too small to save whole system memory\n",
+			bdevname(bdev, buffer));
+
+	list_add(&dump_part->list, &dump_device->partitions);
+
+	return 0;
+}
+
+/*
+ * Add dump device and partition.
+ * Must be called with disk_dump_mutex held.
+ */
+static int add_dump(struct device *dev, struct block_device *bdev)
+{
+	struct disk_dump_type *dump_type = NULL;
+	struct disk_dump_device *dump_device;
+	void *real_device;
+	int ret;
+
+	if ((ret = blkdev_get(bdev, FMODE_READ, 0)) < 0)
+		return ret;
+
+	/* Check whether this block device is already registered */
+	if (find_dump_partition(bdev)) {
+		blkdev_put(bdev);
+		return -EEXIST;
+	}
+
+	/* find dump_type and real device for this inode */
+	if (!(real_device = find_real_device(dev, &dump_type))) {
+		blkdev_put(bdev);
+		return -ENXIO;
+	}
+
+	/* Check whether this device is already registered */
+	dump_device = find_dump_device(real_device);
+	if (dump_device == NULL) {
+		/* real_device is not registered. create new dump_device */
+		if (!(dump_device = kmalloc(sizeof(*dump_device), GFP_KERNEL))) {
+			blkdev_put(bdev);
+			return -ENOMEM;
+		}
+
+		memset(dump_device, 0, sizeof(*dump_device));
+		INIT_LIST_HEAD(&dump_device->partitions);
+
+		dump_device->dump_type = dump_type;
+		dump_device->device = real_device;
+		if ((ret = dump_type->add_device(dump_device)) < 0) {
+			kfree(dump_device);
+			blkdev_put(bdev);
+			return ret;
+		}
+		if (!try_module_get(dump_type->owner))
+			return -EINVAL;
+		list_add(&dump_device->list, &disk_dump_devices);
+	}
+
+	ret = add_dump_partition(dump_device, bdev);
+	if (ret < 0 && list_empty(&dump_device->list)) {
+		dump_type->remove_device(dump_device);
+		module_put(dump_type->owner);
+		list_del(&dump_device->list);
+		kfree(dump_device);
+	}
+	if (ret < 0)
+		blkdev_put(bdev);
+
+	return ret;
+}
+
+/*
+ * Remove dump partition corresponding to bdev.
+ * Must be called with disk_dump_mutex held.
+ */
+static int remove_dump(struct block_device *bdev)
+{
+	struct disk_dump_device *dump_device;
+	struct disk_dump_partition *dump_part;
+	struct disk_dump_type *dump_type;
+
+	if (!(dump_part = find_dump_partition(bdev))) {
+		bdput(bdev);
+		return -ENOENT;
+	}
+
+	blkdev_put(bdev);
+	dump_device = dump_part->device;
+	list_del(&dump_part->list);
+	kfree(dump_part);
+
+	if (list_empty(&dump_device->partitions)) {
+		dump_type = dump_device->dump_type;
+		dump_type->remove_device(dump_device);
+		module_put(dump_type->owner);
+		list_del(&dump_device->list);
+		kfree(dump_device);
+	}
+
+	return 0;
+}
+
+int register_disk_dump_device(struct device *dev, struct block_device *bdev)
+{
+	int ret;
+
+	down(&disk_dump_mutex);
+	ret = add_dump(dev, bdev);
+	set_crc_modules();
+	up(&disk_dump_mutex);
+
+	return ret;
+}
+
+int unregister_disk_dump_device(struct block_device *bdev)
+{
+	int ret;
+
+	down(&disk_dump_mutex);
+	ret = remove_dump(bdev);
+	set_crc_modules();
+	up(&disk_dump_mutex);
+
+	return ret;
+}
+
+int find_disk_dump_device(struct block_device *bdev)
+{
+	int ret;
+
+	down(&disk_dump_mutex);
+	ret = (find_dump_partition(bdev) != NULL);
+	up(&disk_dump_mutex);
+
+	return ret;
+}
+
+int register_disk_dump_type(struct disk_dump_type *dump_type)
+{
+	down(&disk_dump_mutex);
+	list_add(&dump_type->list, &disk_dump_types);
+	set_crc_modules();
+	up(&disk_dump_mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(register_disk_dump_type);
+
+int unregister_disk_dump_type(struct disk_dump_type *dump_type)
+{
+	down(&disk_dump_mutex);
+	list_del(&dump_type->list);
+	set_crc_modules();
+	up(&disk_dump_mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(unregister_disk_dump_type);
+
+static void compute_total_blocks(void)
+{
+	unsigned long nr;
+
+	/*
+	 * the number of block of the common header and the header
+	 * that is depend on the architecture
+	 *
+	 * block 0:		dump partition header
+	 * block 1:		dump header
+	 * block 2:		dump subheader
+	 * block 3..n:		memory bitmap
+	 * block (n + 1)...:	saved memory
+	 *
+	 * We never overwrite block 0
+	 */
+	header_blocks = 2 + size_of_sub_header();
+
+	total_ram_blocks = 0;
+	for (nr = next_ram_page(ULONG_MAX); nr < ULONG_MAX; nr = next_ram_page(nr))
+		total_ram_blocks++;
+
+	bitmap_blocks = ROUNDUP(max_pfn, 8 * PAGE_SIZE);
+
+	/*
+	 * The necessary size of area for dump is:
+	 * 1 block for common header
+	 * m blocks for architecture dependent header
+	 * n blocks for memory bitmap
+	 * and whole memory
+	 */
+	total_blocks = header_blocks + bitmap_blocks + total_ram_blocks;
+
+	Info("total blocks required: %u (header %u + bitmap %u + memory %u)",
+		total_blocks, header_blocks, bitmap_blocks, total_ram_blocks);
+}
+
+struct disk_dump_ops dump_ops = {
+	.add_dump	= register_disk_dump_device,
+	.remove_dump	= unregister_disk_dump_device,
+	.find_dump	= find_disk_dump_device,
+};
+
+static int init_diskdump(void)
+{
+	unsigned long long t0;
+	unsigned long long t1;
+	struct page *page;
+
+	if (!platform_supports_diskdump) {
+		Err("platform does not support diskdump.");
+		return -1;
+	}
+
+	/* Allocate one block that is used temporally */
+	do {
+		page = alloc_pages(GFP_KERNEL, block_order);
+		if (page != NULL)
+			break;
+	} while (--block_order >= 0);
+	if (!page) {
+		Err("alloc_pages failed.");
+		return -1;
+	}
+	scratch = page_address(page);
+	Info("Maximum block size: %lu", PAGE_SIZE << block_order);
+
+	if (diskdump_register_hook(start_disk_dump)) {
+		Err("failed to register hooks.");
+		return -1;
+	}
+
+	if (diskdump_register_ops(&dump_ops)) {
+		Err("failed to register ops.");
+		return -1;
+	}
+
+	compute_total_blocks();
+
+	platform_timestamp(t0);
+	mdelay(1);
+	platform_timestamp(t1);
+	timestamp_1sec = (unsigned long)(t1 - t0) * 1000;
+
+	/*
+	 *  Allocate a separate stack for diskdump.
+	 */
+	platform_init_stack(&diskdump_stack);
+
+	return 0;
+}
+
+static void cleanup_diskdump(void)
+{
+	Info("shut down.");
+	diskdump_unregister_hook();
+	diskdump_unregister_ops();
+	platform_cleanup_stack(diskdump_stack);
+	free_pages((unsigned long)scratch, block_order);
+}
+
+module_init(init_diskdump);
+module_exit(cleanup_diskdump);
+
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.8.1.org/drivers/char/sysrq.c linux-2.6.8.1/drivers/char/sysrq.c
--- linux-2.6.8.1.org/drivers/char/sysrq.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/drivers/char/sysrq.c	2004-08-26 20:32:58.195973346 +0900
@@ -107,6 +107,19 @@
 	.action_msg	= "Resetting",
 };
 
+/* crash sysrq handler */
+static void sysrq_handle_crash(int key, struct pt_regs *pt_regs,
+                             struct tty_struct *tty)
+{
+	*( (char *) 0) = 0;
+}
+
+static struct sysrq_key_op sysrq_crash_op = {
+	.handler        = sysrq_handle_crash,
+	.help_msg       = "Crash",
+	.action_msg     = "Crashing the kernel by request",
+};
+
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -235,7 +248,7 @@
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-/* c */ NULL,
+/* c */ &sysrq_crash_op,
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
diff -Nur linux-2.6.8.1.org/include/asm-generic/diskdump.h linux-2.6.8.1/include/asm-generic/diskdump.h
--- linux-2.6.8.1.org/include/asm-generic/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-generic/diskdump.h	2004-08-26 20:32:58.196949908 +0900
@@ -0,0 +1,49 @@
+#ifndef _ASM_GENERIC_DISKDUMP_H_
+#define _ASM_GENERIC_DISKDUMP_H_
+
+/*
+ * linux/include/asm-generic/diskdump.h
+ *
+ * Copyright (C) 2004  FUJITSU LIMITED
+ * Copyright (c) 2003, 2004 Red Hat, Inc. All rights reserved.
+ *
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __KERNEL__
+
+static inline int page_is_ram(unsigned long x) { return 0; }
+static inline unsigned long next_ram_page(unsigned long x) { return ULONG_MAX; }
+
+#warning diskdump is not supported on this platform
+const static int platform_supports_diskdump = 0;
+
+#define platform_fix_regs() do { } while (0)
+#define platform_timestamp(x) do { (x) = 0; } while (0)  
+#define platform_freeze_cpu() do { } while (0)
+
+struct disk_dump_sub_header {};
+#define size_of_sub_header()	1
+#define write_sub_header() 	1
+
+#define platform_init_stack(stackptr) do { } while (0)
+#define platform_cleanup_stack(stackptr) do { } while (0)
+#define platform_start_crashdump(stackptr,dumpfunc,regs) (0)
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_GENERIC_DISKDUMP_H */
diff -Nur linux-2.6.8.1.org/include/asm-i386/diskdump.h linux-2.6.8.1/include/asm-i386/diskdump.h
--- linux-2.6.8.1.org/include/asm-i386/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-i386/diskdump.h	2004-08-28 14:30:43.848419667 +0900
@@ -0,0 +1,91 @@
+#ifndef _ASM_I386_DISKDUMP_H
+#define _ASM_I386_DISKDUMP_H
+
+/*
+ * linux/include/asm-i386/diskdump.h
+ *
+ * Copyright (c) 2004 FUJITSU LIMITED
+ * Copyright (c) 2003 Red Hat, Inc. All rights reserved.
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/elf.h>
+#include <asm/irq.h>
+
+extern int page_is_ram(unsigned long);
+extern unsigned long next_ram_page (unsigned long);
+const static int platform_supports_diskdump = 1;
+
+#define platform_fix_regs() \
+{                                                                      \
+       unsigned long esp;                                              \
+       unsigned short ss;                                              \
+       esp = (unsigned long) ((char *)regs + sizeof (struct pt_regs)); \
+       ss = __KERNEL_DS;                                               \
+       if (regs->xcs & 3) {                                            \
+               esp = regs->esp;                                        \
+               ss = regs->xss & 0xffff;                                \
+       }                                                               \
+       myregs = *regs;                                                 \
+       myregs.esp = esp;                                               \
+       myregs.xss = (myregs.xss & 0xffff0000) | ss;                    \
+}
+
+struct disk_dump_sub_header {
+	elf_gregset_t		elf_regs;
+};
+
+#define platform_timestamp(x) rdtscll(x)
+
+#define size_of_sub_header()	((sizeof(struct disk_dump_sub_header) + PAGE_SIZE - 1) / DUMP_BLOCK_SIZE)
+
+#define write_sub_header() 						\
+({									\
+ 	int ret;							\
+									\
+	ELF_CORE_COPY_REGS(dump_sub_header.elf_regs, (&myregs));	\
+	clear_page(scratch);						\
+	memcpy(scratch, &dump_sub_header, sizeof(dump_sub_header));	\
+ 									\
+	if ((ret = write_blocks(dump_part, 2, scratch, 1)) >= 0)	\
+		ret = 1; /* size of sub header in page */;		\
+	ret;								\
+})
+
+#define platform_freeze_cpu()					\
+{								\
+	for (;;) local_irq_disable();				\
+}
+
+typedef asmlinkage void (*crashdump_func_t)(struct pt_regs *, void *);
+
+#define platform_init_stack(stackptr) do { } while (0)
+#define platform_cleanup_stack(stackptr) do { } while (0)
+
+static inline void platform_start_crashdump(void *stackptr,
+					    crashdump_func_t dumpfunc,
+					    struct pt_regs *regs)
+{
+	dumpfunc(regs, NULL);
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_I386_DISKDUMP_H */
diff -Nur linux-2.6.8.1.org/include/asm-i386/kmap_types.h linux-2.6.8.1/include/asm-i386/kmap_types.h
--- linux-2.6.8.1.org/include/asm-i386/kmap_types.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/asm-i386/kmap_types.h	2004-08-26 20:32:58.197926471 +0900
@@ -23,7 +23,8 @@
 D(10)	KM_IRQ1,
 D(11)	KM_SOFTIRQ0,
 D(12)	KM_SOFTIRQ1,
-D(13)	KM_TYPE_NR
+D(13)	KM_CRASHDUMP,
+D(14)	KM_TYPE_NR
 };
 
 #undef D
diff -Nur linux-2.6.8.1.org/include/asm-ia64/diskdump.h linux-2.6.8.1/include/asm-ia64/diskdump.h
--- linux-2.6.8.1.org/include/asm-ia64/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-ia64/diskdump.h	2004-08-26 20:32:58.197926471 +0900
@@ -0,0 +1,100 @@
+#ifndef _ASM_IA64_DISKDUMP_H
+#define _ASM_IA64_DISKDUMP_H
+
+/*
+ * linux/include/asm-ia64/diskdump.h
+ *
+ * Copyright (c) 2004 FUJITSU LIMITED
+ * Copyright (c) 2003 Red Hat, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/elf.h>
+#include <asm/unwind.h>
+#include <asm/ptrace.h>
+
+extern void ia64_do_copy_regs(struct unw_frame_info *, void *arg);
+extern void ia64_freeze_cpu(struct unw_frame_info *, void *arg);
+extern void ia64_start_dump(struct unw_frame_info *, void *arg);
+extern int page_is_ram(unsigned long);
+extern unsigned long next_ram_page(unsigned long);
+
+const static int platform_supports_diskdump = 1;
+
+
+#define platform_fix_regs()					\
+{								\
+	struct unw_frame_info *info = platform_arg;		\
+								\
+	current->thread.ksp = (__u64)info->sw - 16;		\
+	myregs = *regs;						\
+}
+
+#define platform_timestamp(x) ({ x = ia64_get_itc(); })
+
+struct disk_dump_sub_header {
+	elf_gregset_t		 elf_regs;
+};
+
+#define size_of_sub_header()	((sizeof(struct disk_dump_sub_header) + PAGE_SIZE - 1) / DUMP_BLOCK_SIZE)
+
+#define write_sub_header() \
+({									\
+ 	int ret;							\
+	struct unw_frame_info *info = platform_arg;			\
+									\
+	ia64_do_copy_regs(info, &dump_sub_header.elf_regs);		\
+	clear_page(scratch);						\
+	memcpy(scratch, &dump_sub_header, sizeof(dump_sub_header));	\
+ 									\
+	if ((ret = write_blocks(dump_part, 2, scratch, 1)) >= 0)	\
+		ret = 1; /* size of sub header in page */;		\
+	ret;								\
+})
+
+#define platform_freeze_cpu() 					\
+{								\
+	unw_init_running(ia64_freeze_cpu, NULL);		\
+}
+
+#define platform_init_stack(stackptr) do { } while (0)
+#define platform_cleanup_stack(stackptr) do { } while (0)
+
+typedef asmlinkage void (*crashdump_func_t)(struct pt_regs *, void *);
+
+/* Container to hold dump hander information */
+struct dump_call_param {
+	crashdump_func_t func;
+	struct pt_regs	*regs;
+};
+
+static inline void platform_start_crashdump(void *stackptr,
+					    crashdump_func_t dumpfunc,
+					    struct pt_regs *regs)
+{
+	struct dump_call_param param;
+
+	param.func = dumpfunc;
+	param.regs = regs;
+	unw_init_running(ia64_start_dump, &param);
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_IA64_DISKDUMP_H */
diff -Nur linux-2.6.8.1.org/include/asm-ppc64/diskdump.h linux-2.6.8.1/include/asm-ppc64/diskdump.h
--- linux-2.6.8.1.org/include/asm-ppc64/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-ppc64/diskdump.h	2004-08-26 20:32:58.198903033 +0900
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC64_DISKDUMP_H_
+#define _ASM_PPC64_DISKDUMP_H_
+
+#include <asm-generic/diskdump.h>
+
+#endif /* _ASM_PPC64_DISKDUMP_H_ */
diff -Nur linux-2.6.8.1.org/include/asm-s390/diskdump.h linux-2.6.8.1/include/asm-s390/diskdump.h
--- linux-2.6.8.1.org/include/asm-s390/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-s390/diskdump.h	2004-08-26 20:32:58.198903033 +0900
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390_DISKDUMP_H_
+#define _ASM_S390_DISKDUMP_H_
+
+#include <asm-generic/diskdump.h>
+
+#endif /* _ASM_S390_DISKDUMP_H_ */
diff -Nur linux-2.6.8.1.org/include/asm-x86_64/diskdump.h linux-2.6.8.1/include/asm-x86_64/diskdump.h
--- linux-2.6.8.1.org/include/asm-x86_64/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/asm-x86_64/diskdump.h	2004-08-28 14:18:43.281045681 +0900
@@ -0,0 +1,82 @@
+/*
+ * include/asm-x86_64/diskdump.h
+ *
+ * Copyright (C) Hitachi, Ltd. 2004
+ * Written by Satoshi Oshima (oshima@sdl.hitachi.co.jp)
+ *
+ * Derived from include/asm-i386/diskdump.h
+ * Copyright (c) 2004 FUJITSU LIMITED
+ * Copyright (c) 2003 Red Hat, Inc. All rights reserved.
+ *
+ */
+
+#ifndef _ASM_X86_64_DISKDUMP_H
+#define _ASM_X86_64_DISKDUMP_H
+
+#ifdef __KERNEL__
+
+#include <linux/elf.h>
+
+extern int page_is_ram(unsigned long);
+extern unsigned long next_ram_page(unsigned long);
+const static int platform_supports_diskdump = 1;
+
+#define platform_fix_regs() \
+{                                                                      \
+       unsigned long rsp;                                              \
+       unsigned short ss;                                              \
+       rsp = (unsigned long) ((char *)regs + sizeof (struct pt_regs)); \
+       ss = __KERNEL_DS;                                               \
+       if (regs->cs & 3) {                                             \
+               rsp = regs->rsp;                                        \
+               ss = regs->ss & 0xffff;                                 \
+       }                                                               \
+       myregs = *regs;                                                 \
+       myregs.rsp = rsp;                                               \
+       myregs.ss = (myregs.ss & (~0xffff)) | ss;                       \
+}
+
+#define platform_timestamp(x) rdtscll(x)
+
+struct disk_dump_sub_header {
+	elf_gregset_t		elf_regs;
+};
+
+#define size_of_sub_header()	((sizeof(struct disk_dump_sub_header) + PAGE_SIZE - 1) / DUMP_BLOCK_SIZE)
+
+#define write_sub_header() 						\
+({									\
+ 	int ret;							\
+									\
+	ELF_CORE_COPY_REGS(dump_sub_header.elf_regs, (&myregs));	\
+	clear_page(scratch);						\
+	memcpy(scratch, &dump_sub_header, sizeof(dump_sub_header));	\
+ 									\
+	if ((ret = write_blocks(dump_part, 2, scratch, 1)) >= 0)	\
+		ret = 1; /* size of sub header in page */;		\
+	ret;								\
+})
+
+#define platform_freeze_cpu()					\
+{								\
+	for (;;) {						\
+		local_irq_disable();				\
+		touch_nmi_watchdog();				\
+	}							\
+}
+
+#define platform_init_stack(stackptr) do { } while (0)
+#define platform_cleanup_stack(stackptr) do { } while (0)
+
+typedef asmlinkage void (*crashdump_func_t)(struct pt_regs *, void *);
+
+static inline void platform_start_crashdump(void *stackptr,
+					    crashdump_func_t dumpfunc,
+					    struct pt_regs *regs)
+{								\
+	dumpfunc(regs, NULL);					\
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_X86_64_DISKDUMP_H */
diff -Nur linux-2.6.8.1.org/include/asm-x86_64/kmap_types.h linux-2.6.8.1/include/asm-x86_64/kmap_types.h
--- linux-2.6.8.1.org/include/asm-x86_64/kmap_types.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/asm-x86_64/kmap_types.h	2004-08-26 20:32:58.199879596 +0900
@@ -13,6 +13,7 @@
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
+	KM_CRASHDUMP,
 	KM_TYPE_NR
 };
 
diff -Nur linux-2.6.8.1.org/include/linux/diskdump.h linux-2.6.8.1/include/linux/diskdump.h
--- linux-2.6.8.1.org/include/linux/diskdump.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/include/linux/diskdump.h	2004-08-26 20:32:58.199879596 +0900
@@ -0,0 +1,174 @@
+#ifndef _LINUX_DISKDUMP_H
+#define _LINUX_DISKDUMP_H
+
+/*
+ * linux/include/linux/diskdump.h
+ *
+ * Copyright (c) 2004 FUJITSU LIMITED
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/list.h>
+#include <linux/blkdev.h>
+#include <linux/utsname.h>
+#include <linux/device.h>
+
+/* The minimum Dump I/O unit. Must be the same of PAGE_SIZE */
+#define DUMP_BLOCK_SIZE		PAGE_SIZE
+#define DUMP_BLOCK_SHIFT	PAGE_SHIFT
+
+int diskdump_register_hook(void (*dump_func)(struct pt_regs *));
+void diskdump_unregister_hook(void);
+
+/*
+ * The handler of diskdump module
+ */
+struct disk_dump_ops {
+	int (*add_dump)(struct device *, struct block_device *);
+	int (*remove_dump)(struct block_device *);
+	int (*find_dump)(struct block_device *);
+};
+
+int diskdump_register_ops(struct disk_dump_ops* op);
+void diskdump_unregister_ops(void);
+
+
+/*
+ * The handler that adapter driver provides for the common module of
+ * dump
+ */
+struct disk_dump_partition;
+struct disk_dump_device;
+
+struct disk_dump_type {
+	void *(*probe)(struct device *);
+	int (*add_device)(struct disk_dump_device *);
+	void (*remove_device)(struct disk_dump_device *);
+	struct module *owner;
+	struct list_head list;
+};
+
+struct disk_dump_device_ops {
+	int (*sanity_check)(struct disk_dump_device *);
+	int (*quiesce)(struct disk_dump_device *);
+	int (*shutdown)(struct disk_dump_device *);
+	int (*rw_block)(struct disk_dump_partition *, int rw, unsigned long block_nr, void *buf, int len);
+};
+
+/* The data structure for a dump device */
+struct disk_dump_device {
+	struct list_head list;
+	struct disk_dump_device_ops ops;
+	struct disk_dump_type *dump_type;
+	void *device;
+	unsigned int max_blocks;
+	struct list_head partitions;
+};
+
+/* The data structure for a dump partition */
+struct disk_dump_partition {
+	struct list_head list;
+	struct disk_dump_device *device;
+	struct block_device *bdev;
+	unsigned long start_sect;
+	unsigned long nr_sects;
+};
+
+int register_disk_dump_type(struct disk_dump_type *);
+int unregister_disk_dump_type(struct disk_dump_type *);
+
+
+/*
+ * sysfs interface
+ */
+ssize_t diskdump_sysfs_store(struct device *dev, const char *buf, size_t count);
+ssize_t diskdump_sysfs_show(struct device *dev, char *buf);
+
+
+void diskdump_update(void);
+void diskdump_setup_timestamp(void);
+
+
+/*
+ * Architecture-independent dump header
+ */
+
+/* The signature which is written in each block in the dump partition */
+#define DISK_DUMP_SIGNATURE		"DISKDUMP"
+#define DISK_DUMP_HEADER_VERSION	1
+
+#define DUMP_PARTITION_SIGNATURE	"diskdump"
+
+#define DUMP_HEADER_COMPLETED	0
+#define DUMP_HEADER_INCOMPLETED	1
+
+struct disk_dump_header {
+	char			signature[8];	/* = "DISKDUMP" */
+	int			header_version;	/* Dump header version */
+	struct new_utsname	utsname;	/* copy of system_utsname */
+	struct timespec		timestamp;	/* Time stamp */
+	unsigned int		status;		/* Above flags */
+	int			block_size;	/* Size of a block in byte */
+	int			sub_hdr_size;	/* Size of arch dependent
+						   header in blocks */
+	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
+						   block */
+	unsigned int		max_mapnr;	/* = max_mapnr */
+	unsigned int		total_ram_blocks;/* Size of Memory in block */
+	unsigned int		device_blocks;	/* Number of total blocks in
+						 * the dump device */
+	unsigned int		written_blocks;	/* Number of written blocks */
+	unsigned int		current_cpu;	/* CPU# which handles dump */
+	int			nr_cpus;	/* Number of CPUs */
+	struct task_struct	*tasks[NR_CPUS];
+};
+
+/*
+ * Calculate the check sum of the whole module
+ */
+#define get_crc_module()						\
+({									\
+	struct module *module = &__this_module;				\
+	crc32_le(0, (char *)(module->module_core),			\
+	  ((unsigned long)module - (unsigned long)(module->module_core))); \
+})
+
+/* Calculate the checksum of the whole module */
+#define set_crc_modules()						\
+({									\
+	module_crc = 0;							\
+	module_crc = get_crc_module();					\
+})
+
+/*
+ * Compare the checksum value that is stored in module_crc to the check
+ * sum of current whole module. Must be called with holding disk_dump_lock.
+ * Return TRUE if they are the same, else return FALSE
+ *
+ */
+#define check_crc_module()						\
+({									\
+	uint32_t orig_crc, cur_crc;					\
+									\
+	orig_crc = module_crc; module_crc = 0;				\
+	cur_crc = get_crc_module();					\
+	module_crc = orig_crc;						\
+	orig_crc == cur_crc;						\
+})
+
+
+#endif /* _LINUX_DISKDUMP_H */
diff -Nur linux-2.6.8.1.org/include/linux/interrupt.h linux-2.6.8.1/include/linux/interrupt.h
--- linux-2.6.8.1.org/include/linux/interrupt.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/linux/interrupt.h	2004-08-26 20:32:58.200856158 +0900
@@ -247,4 +247,8 @@
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
 
+
+extern void dump_clear_tasklet(void);
+extern void dump_run_tasklet(void);
+
 #endif
diff -Nur linux-2.6.8.1.org/include/linux/kernel.h linux-2.6.8.1/include/linux/kernel.h
--- linux-2.6.8.1.org/include/linux/kernel.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/linux/kernel.h	2004-08-26 20:32:58.200856158 +0900
@@ -130,6 +130,12 @@
 extern int panic_on_oops;
 extern int tainted;
 extern const char *print_tainted(void);
+struct pt_regs;
+extern void try_crashdump(struct pt_regs *);
+extern void (*diskdump_func) (struct pt_regs *regs);
+extern int diskdump_mode;
+#define crashdump_mode()       unlikely(diskdump_mode)
+
 
 /* Values used for system_state */
 extern enum system_states {
@@ -138,6 +144,7 @@
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_DUMPING,
 } system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
@@ -158,6 +165,12 @@
 #define pr_info(fmt,arg...) \
 	printk(KERN_INFO fmt,##arg)
 
+#define pr_err(fmt,arg...) \
+	printk(KERN_ERR fmt,##arg)
+
+#define pr_warn(fmt,arg...) \
+	printk(KERN_WARNING fmt,##arg)
+
 /*
  *      Display an IP address in readable format.
  */
diff -Nur linux-2.6.8.1.org/include/linux/timer.h linux-2.6.8.1/include/linux/timer.h
--- linux-2.6.8.1.org/include/linux/timer.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/linux/timer.h	2004-08-26 20:32:58.200856158 +0900
@@ -99,4 +99,7 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+extern void dump_clear_timers(void);
+extern void dump_run_timers(void);
+
 #endif
diff -Nur linux-2.6.8.1.org/include/linux/workqueue.h linux-2.6.8.1/include/linux/workqueue.h
--- linux-2.6.8.1.org/include/linux/workqueue.h	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/include/linux/workqueue.h	2004-08-26 20:32:58.201832721 +0900
@@ -84,4 +84,7 @@
 	return ret;
 }
 
+extern void dump_clear_workqueue(void);
+extern void dump_run_workqueue(void);
+
 #endif
diff -Nur linux-2.6.8.1.org/kernel/Makefile linux-2.6.8.1/kernel/Makefile
--- linux-2.6.8.1.org/kernel/Makefile	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/kernel/Makefile	2004-08-26 20:32:58.201832721 +0900
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o dump.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nur linux-2.6.8.1.org/kernel/dump.c linux-2.6.8.1/kernel/dump.c
--- linux-2.6.8.1.org/kernel/dump.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1/kernel/dump.c	2004-08-26 20:32:58.203785846 +0900
@@ -0,0 +1,241 @@
+/*
+ *  linux/kernel/dump.c
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/nmi.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/genhd.h>
+#include <linux/diskdump.h>
+#include <asm/diskdump.h>
+
+static DECLARE_MUTEX(dump_ops_mutex);
+struct disk_dump_ops* dump_ops = NULL;
+
+int diskdump_mode = 0;
+EXPORT_SYMBOL_GPL(diskdump_mode);
+
+void (*diskdump_func) (struct pt_regs *regs) = NULL;
+EXPORT_SYMBOL_GPL(diskdump_func);
+
+static unsigned long long timestamp_base;
+static unsigned long timestamp_hz;
+
+
+/*
+ * register/unregister diskdump operations
+ */
+int diskdump_register_ops(struct disk_dump_ops* op)
+{
+	down(&dump_ops_mutex);
+	if (dump_ops) {
+		up(&dump_ops_mutex);
+		return -EEXIST;
+	}
+	dump_ops = op;
+	up(&dump_ops_mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(diskdump_register_ops);
+
+void diskdump_unregister_ops(void)
+{
+	down(&dump_ops_mutex);
+	dump_ops = NULL;
+	up(&dump_ops_mutex);
+}
+
+EXPORT_SYMBOL_GPL(diskdump_unregister_ops);
+
+
+/*
+ * sysfs interface
+ */
+static struct gendisk *device_to_gendisk(struct device *dev)
+{
+	struct dentry *d;
+	struct qstr qstr;
+
+	/* trace symlink to "block" */
+	qstr.name = "block";
+	qstr.len = strlen(qstr.name);
+	qstr.hash = full_name_hash(qstr.name, qstr.len);
+	d = d_lookup(dev->kobj.dentry, &qstr);
+	if (!d || !d->d_fsdata)
+		return NULL;
+	else
+		return container_of(d->d_fsdata, struct gendisk, kobj);
+}
+
+ssize_t diskdump_sysfs_store(struct device *dev, const char *buf, size_t count)
+{
+	struct gendisk *disk;
+	struct block_device *bdev;
+	int part, remove = 0;
+
+	if (!dump_ops || !dump_ops->add_dump || !dump_ops->remove_dump)
+		return count;
+
+	/* get partition number */
+	sscanf (buf, "%d\n", &part);
+	if (part < 0) {
+		part = -part;
+		remove = 1;
+	}
+
+	/* get block device */
+	if (!(disk = device_to_gendisk(dev)) ||
+	    !(bdev = bdget_disk(disk, part)))
+		return count;
+
+	/* add/remove device */
+	down(&dump_ops_mutex);
+	if (!remove)
+		dump_ops->add_dump(dev, bdev);
+	else
+		dump_ops->remove_dump(bdev);
+	up(&dump_ops_mutex);
+
+	return count;
+}
+
+EXPORT_SYMBOL_GPL(diskdump_sysfs_store);
+
+ssize_t diskdump_sysfs_show(struct device *dev, char *buf)
+{
+	struct gendisk *disk;
+	struct block_device *bdev;
+	int part, tmp, len = 0, maxlen = 1024;
+	char* p = buf; 
+	char name[BDEVNAME_SIZE];
+
+	if (!dump_ops || !dump_ops->find_dump)
+		return 0;
+
+	/* get gendisk */
+	disk = device_to_gendisk(dev);
+	if (!disk || !disk->part)
+		return 0;
+
+	/* print device */
+	down(&dump_ops_mutex);
+	for (part = 0; part < disk->minors - 1; part++) {
+		bdev = bdget_disk(disk, part);
+		if (dump_ops->find_dump(bdev)) {
+			tmp = sprintf(p, "%s\n", bdevname(bdev, name));
+			len += tmp;
+			p += tmp;
+		}
+		bdput(bdev);
+		if(len >= maxlen)
+			break;
+	}
+	up(&dump_ops_mutex);
+
+	return len;
+}
+
+EXPORT_SYMBOL_GPL(diskdump_sysfs_show);
+
+/*
+ * run timer/tasklet/workqueue during dump
+ */
+void diskdump_setup_timestamp(void)
+{
+	unsigned long long t;
+
+	platform_timestamp(timestamp_base);
+	udelay(1000000/HZ);
+	platform_timestamp(t);
+	timestamp_hz = (unsigned long)(t - timestamp_base);
+	diskdump_update();
+}
+
+EXPORT_SYMBOL_GPL(diskdump_setup_timestamp);
+
+void diskdump_update(void)
+{
+	unsigned long long t;
+
+	touch_nmi_watchdog();
+
+	/* update jiffies */
+	platform_timestamp(t);
+	while (t > timestamp_base + timestamp_hz) {
+		timestamp_base += timestamp_hz;
+		jiffies++;
+		platform_timestamp(t);
+	}
+
+	dump_run_timers();
+	dump_run_tasklet();
+	dump_run_workqueue();
+}
+
+EXPORT_SYMBOL_GPL(diskdump_update);
+
+
+/*
+ * register/unregister hook
+ */
+int diskdump_register_hook(void (*dump_func) (struct pt_regs *))
+{
+	if (diskdump_func)
+		return -EEXIST;
+
+	diskdump_func = dump_func;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(diskdump_register_hook);
+
+void diskdump_unregister_hook(void)
+{
+	diskdump_func = NULL;
+}
+
+EXPORT_SYMBOL_GPL(diskdump_unregister_hook);
+
+/*
+ * Try crashdump. Diskdump is first, netdump is second.
+ * We clear diskdump_func before call of diskdump_func, so
+ * If double panic would occur in diskdump, netdump can handle
+ * it.
+ */
+void try_crashdump(struct pt_regs *regs)
+{
+	void (*func)(struct pt_regs *);
+
+	if (diskdump_func) {
+		system_state = SYSTEM_DUMPING;
+		func = diskdump_func;
+		diskdump_func = NULL;
+		func(regs);
+	}
+}
diff -Nur linux-2.6.8.1.org/kernel/panic.c linux-2.6.8.1/kernel/panic.c
--- linux-2.6.8.1.org/kernel/panic.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/kernel/panic.c	2004-08-26 20:32:58.204762408 +0900
@@ -60,6 +60,8 @@
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic: %s\n",buf);
+	if (diskdump_func)
+		BUG();
 	if (in_interrupt())
 		printk(KERN_EMERG "In interrupt handler - not syncing\n");
 	else if (!current->pid)
diff -Nur linux-2.6.8.1.org/kernel/softirq.c linux-2.6.8.1/kernel/softirq.c
--- linux-2.6.8.1.org/kernel/softirq.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/kernel/softirq.c	2004-08-26 20:32:58.204762408 +0900
@@ -314,6 +314,38 @@
 
 EXPORT_SYMBOL(tasklet_kill);
 
+struct tasklet_head saved_tasklet;
+
+void dump_clear_tasklet(void)
+{
+	saved_tasklet.list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+}
+
+EXPORT_SYMBOL(dump_clear_tasklet);
+
+void dump_run_tasklet(void)
+{
+	struct tasklet_struct *list;
+
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+
+	while (list) {
+		struct tasklet_struct *t = list;
+		list = list->next;
+
+		if (!atomic_read(&t->count) &&
+		    (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)))
+				t->func(t->data);
+
+		t->next = __get_cpu_var(tasklet_vec).list;
+		__get_cpu_var(tasklet_vec).list = t;
+	}
+}
+
+EXPORT_SYMBOL(dump_run_tasklet);
+
 void __init softirq_init(void)
 {
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
diff -Nur linux-2.6.8.1.org/kernel/timer.c linux-2.6.8.1/kernel/timer.c
--- linux-2.6.8.1.org/kernel/timer.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/kernel/timer.c	2004-08-26 20:32:58.205738971 +0900
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -423,8 +424,9 @@
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
+	unsigned long flags;
 
-	spin_lock_irq(&base->lock);
+	spin_lock_irqsave(&base->lock, flags);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -453,14 +455,14 @@
 			set_running_timer(base, timer);
 			smp_wmb();
 			timer->base = NULL;
-			spin_unlock_irq(&base->lock);
+			spin_unlock_irqrestore(&base->lock, flags);
 			fn(data);
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
 	}
 	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->lock);
+	spin_unlock_irqrestore(&base->lock, flags);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -1105,6 +1107,12 @@
 	struct timer_list timer;
 	unsigned long expire;
 
+	if (crashdump_mode()) {
+		mdelay(timeout);
+		set_current_state(TASK_RUNNING);
+		return timeout;
+	}
+
 	switch (timeout)
 	{
 	case MAX_SCHEDULE_TIMEOUT:
@@ -1308,7 +1316,7 @@
 	return 0;
 }
 
-static void __devinit init_timers_cpu(int cpu)
+static void /* __devinit */ init_timers_cpu(int cpu)
 {
 	int j;
 	tvec_base_t *base;
@@ -1327,6 +1335,27 @@
 	base->timer_jiffies = jiffies;
 }
 
+static tvec_base_t saved_tvec_base;
+
+void dump_clear_timers(void)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
+
+	memcpy(&saved_tvec_base, base, sizeof(saved_tvec_base));
+	init_timers_cpu(smp_processor_id());
+}
+
+EXPORT_SYMBOL(dump_clear_timers);
+
+void dump_run_timers(void)
+{
+	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+
+	__run_timers(base);
+}
+
+EXPORT_SYMBOL(dump_run_timers);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
 {
diff -Nur linux-2.6.8.1.org/kernel/workqueue.c linux-2.6.8.1/kernel/workqueue.c
--- linux-2.6.8.1.org/kernel/workqueue.c	2004-08-25 15:55:50.000000000 +0900
+++ linux-2.6.8.1/kernel/workqueue.c	2004-08-26 20:32:58.206715533 +0900
@@ -424,6 +424,37 @@
 
 }
 
+static struct cpu_workqueue_struct saved_cwq;
+
+void dump_clear_workqueue(void)
+{
+	int cpu = smp_processor_id();
+	struct cpu_workqueue_struct *cwq = keventd_wq->cpu_wq + cpu;
+
+	memcpy(&saved_cwq, cwq, sizeof(saved_cwq));
+	spin_lock_init(&cwq->lock);
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+}
+
+void dump_run_workqueue(void)
+{
+	struct cpu_workqueue_struct *cwq;
+
+	cwq = keventd_wq->cpu_wq + smp_processor_id();
+	while (!list_empty(&cwq->worklist)) {
+		struct work_struct *work = list_entry(cwq->worklist.next,
+						struct work_struct, entry);
+		void (*f) (void *) = work->func;
+		void *data = work->data;
+
+		list_del_init(cwq->worklist.next);
+		clear_bit(0, &work->pending);
+		f(data);
+	}
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /* Take the work from this (downed) CPU. */
 static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
@@ -507,3 +538,6 @@
 EXPORT_SYMBOL(schedule_delayed_work);
 EXPORT_SYMBOL(flush_scheduled_work);
 
+EXPORT_SYMBOL(dump_clear_workqueue);
+EXPORT_SYMBOL(dump_run_workqueue);
+
