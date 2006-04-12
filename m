Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWDLCkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWDLCkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 22:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWDLCjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 22:39:43 -0400
Received: from fmr20.intel.com ([134.134.136.19]:11169 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751114AbWDLCjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 22:39:41 -0400
Subject: [PATCH 3/3] swsusp x86_64 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 10:38:22 +0800
Message-Id: <1144809502.2865.41.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pages (Reserved/ACPI NVS/ACPI Data) below end_pfn will
be saved/restored by S4 currently. We should mark 'Reserved'
pages not saveable.
Pages (Reserved/ACPI NVS/ACPI Data) above end_pfn will
not be saved/restored by S4 currently. We should save the
'ACPI NVS/ACPI Data' pages.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc1-root/arch/x86_64/kernel/setup.c |   95 +++++++++++++++++++++++
 1 files changed, 95 insertions(+)

diff -puN arch/x86_64/kernel/setup.c~swsusp_x86_64_save_pages arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc1/arch/x86_64/kernel/setup.c~swsusp_x86_64_save_pages	2006-04-11 08:09:25.000000000 +0800
+++ linux-2.6.17-rc1-root/arch/x86_64/kernel/setup.c	2006-04-11 08:26:37.000000000 +0800
@@ -47,6 +47,7 @@
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
 #include <linux/ctype.h>
+#include <linux/suspend.h>
 
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -582,6 +583,100 @@ static void __init reserve_ebda_region(v
 		reserve_bootmem_generic(addr, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static void __init mark_nosave_page_range(unsigned long start, unsigned long end)
+{
+	struct page *page;
+	while (start <= end) {
+		page = pfn_to_page(start);
+		SetPageNosave(page);
+		start++;
+	}
+}
+
+static void __init e820_nosave_reserved_pages(void)
+{
+	int i;
+	unsigned long r_start = 0, r_end = 0;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = round_down(ei->addr, PAGE_SIZE);
+		end = round_up(ei->addr + ei->size, PAGE_SIZE);
+		if (start >= end)
+			continue;
+		if (ei->type == E820_RESERVED)
+			continue;
+		r_end = start>>PAGE_SHIFT;
+		/* swsusp ignores invalid pfn, ignore these pages here */
+		if (r_end > end_pfn)
+			r_end = end_pfn;
+		if (r_end > r_start)
+			mark_nosave_page_range(r_start, r_end-1);
+		if (r_end >= end_pfn)
+			break;
+		r_start = end>>PAGE_SHIFT;
+	}
+}
+
+static void __init e820_save_acpi_pages(void)
+{
+	int i;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = round_down(ei->addr, PAGE_SIZE) >> PAGE_SHIFT;
+		end = round_up(ei->addr + ei->size, PAGE_SIZE) >> PAGE_SHIFT;
+		if (start >= end)
+			continue;
+		if (ei->type != E820_ACPI && ei->type != E820_NVS)
+			continue;
+		/*
+		 * If the region is below end_pfn, it will be
+		 * saved/restored by swsusp follow 'RAM' type.
+		 */
+		if (start < end_pfn)
+			start = end_pfn;
+		if (end > start)
+			swsusp_add_arch_pages(start, end - 1);
+	}
+}
+
+extern char __start_rodata, __end_rodata;
+/*
+ * BIOS reserved region/hole - no save/restore
+ * ACPI NVS - save/restore
+ * ACPI Data - this is a little tricky, the mem could be used by OS after OS
+ * reads tables from the region, but anyway save/restore the memory hasn't any
+ * side effect and Linux runtime module load/unload might use it.
+ * kernel rodata - no save/restore (kernel rodata isn't changed)
+ */
+static int __init mark_nosave_pages(void)
+{
+	unsigned long pfn_start, pfn_end;
+
+	/* BIOS reserved regions & holes */
+	e820_nosave_reserved_pages();
+
+	/* kernel rodata */
+	pfn_start = round_up(__pa_symbol(&__start_rodata), PAGE_SIZE) >> PAGE_SHIFT;
+	pfn_end = round_down(__pa_symbol(&__end_rodata), PAGE_SIZE) >> PAGE_SHIFT;
+	mark_nosave_page_range(pfn_start, pfn_end-1);
+
+	/* record ACPI Data/NVS as saveable */
+	e820_save_acpi_pages();
+
+	return 0;
+}
+core_initcall(mark_nosave_pages);
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
_


