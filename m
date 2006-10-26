Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423459AbWJZMcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423459AbWJZMcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423462AbWJZMcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:32:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:24124 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423459AbWJZMcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:32:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150975901:sNHT22510971"
Message-ID: <4540AAC6.5000508@intel.com>
Date: Thu, 26 Oct 2006 20:32:06 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] i386 create e820.c to handle find_max_pfn function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves find_max_pfn relative function from setup.c to e820.c,
staic declaration about this function is removed and add extern
declaration in header file.

Signed-off-by: bibo,mao <bibo.mao@intel.com>


 arch/i386/kernel/e820.c  |   52 +++++++++++++++++
 arch/i386/kernel/setup.c |   55 -------------------
 include/asm-i386/e820.h  |    1
 3 files changed, 53 insertions(+), 55 deletions(-)
----------------------------------------------------

diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c 2.6.19-rc2-mm2/arch/i386/kernel/e820.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c	2006-10-26 13:10:22.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/e820.c	2006-10-26 16:08:49.000000000 +0800
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
+#include <linux/pfn.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -539,3 +540,54 @@ int __init copy_e820_map(struct e820entr
 	return 0;
 }
 
+/*
+ * Callback for efi_memory_walk.
+ */
+static int __init
+efi_find_max_pfn(unsigned long start, unsigned long end, void *arg)
+{
+	unsigned long *max_pfn = arg, pfn;
+
+	if (start < end) {
+		pfn = PFN_UP(end -1);
+		if (pfn > *max_pfn)
+			*max_pfn = pfn;
+	}
+	return 0;
+}
+
+static int __init
+efi_memory_present_wrapper(unsigned long start, unsigned long end, void *arg)
+{
+	memory_present(0, start, end);
+	return 0;
+}
+
+/*
+ * Find the highest page frame number we have available
+ */
+void __init find_max_pfn(void)
+{
+	int i;
+
+	max_pfn = 0;
+	if (efi_enabled) {
+		efi_memmap_walk(efi_find_max_pfn, &max_pfn);
+		efi_memmap_walk(efi_memory_present_wrapper, NULL);
+		return;
+	}
+
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long start, end;
+		/* RAM? */
+		if (e820.map[i].type != E820_RAM)
+			continue;
+		start = PFN_UP(e820.map[i].addr);
+		end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+		if (start >= end)
+			continue;
+		if (end > max_pfn)
+			max_pfn = end;
+		memory_present(0, start, end);
+	}
+}
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c 2.6.19-rc2-mm2/arch/i386/kernel/setup.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c	2006-10-26 13:10:22.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/setup.c	2006-10-26 16:08:49.000000000 +0800
@@ -63,9 +63,6 @@
 #include <setup_arch.h>
 #include <bios_ebda.h>
 
-/* Forward Declaration. */
-void __init find_max_pfn(void);
-
 /* This value is set up by the early boot code to point to the value
    immediately after the boot time page tables.  It contains a *physical*
    address, and must not be in the .bss segment! */
@@ -392,29 +389,6 @@ static int __init parse_reservetop(char 
 }
 early_param("reservetop", parse_reservetop);
 
-/*
- * Callback for efi_memory_walk.
- */
-static int __init
-efi_find_max_pfn(unsigned long start, unsigned long end, void *arg)
-{
-	unsigned long *max_pfn = arg, pfn;
-
-	if (start < end) {
-		pfn = PFN_UP(end -1);
-		if (pfn > *max_pfn)
-			*max_pfn = pfn;
-	}
-	return 0;
-}
-
-static int __init
-efi_memory_present_wrapper(unsigned long start, unsigned long end, void *arg)
-{
-	memory_present(0, start, end);
-	return 0;
-}
-
  /*
   * This function checks if the entire range <start,end> is mapped with type.
   *
@@ -448,35 +422,6 @@ e820_all_mapped(unsigned long s, unsigne
 }
 
 /*
- * Find the highest page frame number we have available
- */
-void __init find_max_pfn(void)
-{
-	int i;
-
-	max_pfn = 0;
-	if (efi_enabled) {
-		efi_memmap_walk(efi_find_max_pfn, &max_pfn);
-		efi_memmap_walk(efi_memory_present_wrapper, NULL);
-		return;
-	}
-
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long start, end;
-		/* RAM? */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		start = PFN_UP(e820.map[i].addr);
-		end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
-		if (start >= end)
-			continue;
-		if (end > max_pfn)
-			max_pfn = end;
-		memory_present(0, start, end);
-	}
-}
-
-/*
  * Determine low and high memory ranges:
  */
 unsigned long __init find_max_low_pfn(void)
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/include/asm-i386/e820.h 2.6.19-rc2-mm2/include/asm-i386/e820.h
--- 2.6.19-rc2-mm2.org/include/asm-i386/e820.h	2006-10-25 14:59:33.000000000 +0800
+++ 2.6.19-rc2-mm2/include/asm-i386/e820.h	2006-10-26 16:09:29.000000000 +0800
@@ -38,6 +38,7 @@ extern struct e820map e820;
 
 extern int e820_all_mapped(unsigned long start, unsigned long end,
 			   unsigned type);
+extern void find_max_pfn(void);
 
 #endif/*!__ASSEMBLY__*/
 
