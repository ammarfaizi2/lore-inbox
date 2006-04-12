Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDLCjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDLCjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 22:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWDLCjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 22:39:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:10913 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751100AbWDLCjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 22:39:41 -0400
Subject: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 10:38:21 +0800
Message-Id: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pages (Reserved/ACPI NVS/ACPI Data) below max_low_pfn will be
saved/restored by S4 currently. We should mark 'Reserved' pages
not saveable.
Pages (Reserved/ACPI NVS/ACPI Data) above max_low_pfn will not be
saved/restored by S4 currently. We should save the
'ACPI NVS/ACPI Data' pages.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc1-root/arch/i386/kernel/setup.c |  106 +++++++++++++++++++++++++
 1 files changed, 106 insertions(+)

diff -puN arch/i386/kernel/setup.c~swsusp_i386_save_pages arch/i386/kernel/setup.c
--- linux-2.6.17-rc1/arch/i386/kernel/setup.c~swsusp_i386_save_pages	2006-04-11 08:04:23.000000000 +0800
+++ linux-2.6.17-rc1-root/arch/i386/kernel/setup.c	2006-04-11 08:08:12.000000000 +0800
@@ -48,6 +48,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dmi.h>
 #include <linux/pfn.h>
+#include <linux/suspend.h>
 
 #include <video/edid.h>
 
@@ -1400,6 +1401,111 @@ static void set_mca_bus(int x)
 static void set_mca_bus(int x) { }
 #endif
 
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
+		start = PFN_DOWN(ei->addr);
+		end = PFN_UP(ei->addr + ei->size);
+		if (start >= end)
+			continue;
+		if (ei->type == E820_RESERVED)
+			continue;
+		r_end = start;
+		/*
+		 * Highmem 'Reserved' pages are marked as reserved, swsusp
+		 * will not save/restore them, so we ignore these pages here.
+		 */
+		if (r_end > max_low_pfn)
+			r_end = max_low_pfn;
+		if (r_end > r_start)
+			mark_nosave_page_range(r_start, r_end-1);
+		if (r_end >= max_low_pfn)
+			break;
+		r_start = end;
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
+		start = PFN_DOWN(ei->addr);
+		end = PFN_UP(ei->addr + ei->size);
+		if (start >= end)
+			continue;
+		if (ei->type != E820_ACPI && ei->type != E820_NVS)
+			continue;
+		/*
+		 * If the region is below max_low_pfn, it will be
+		 * saved/restored by swsusp follow 'RAM' type.
+		 */
+		if (start < max_low_pfn)
+			start = max_low_pfn;
+		/*
+		 * Highmem pages (ACPI NVS/Data) are reserved, but swsusp
+		 * highmem save/restore will not save/restore them. We marked
+		 * them as arch saveable pages here
+		 */
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
+	/* FIXME: provide a version for efi BIOS */
+	if (efi_enabled)
+		return 0;
+	/* BIOS reserved regions & holes */
+	e820_nosave_reserved_pages();
+
+	/* kernel rodata */
+	pfn_start = PFN_UP(virt_to_phys(&__start_rodata));
+	pfn_end = PFN_DOWN(virt_to_phys(&__end_rodata));
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
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
_


