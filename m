Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWAZSpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWAZSpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWAZSpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:45:14 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4263 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751364AbWAZSpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:45:12 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060126184405.8550.77483.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 3/9] x86 - Specify amount of kernel memory at boot time
Date: Thu, 26 Jan 2006 18:44:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was originally written by Kamezawa Hiroyuki.

It should be possible for the administrator to specify at boot-time how much
memory should be used for the kernel and how much should go to ZONE_EASYRCLM.
After this patch is applied, the boot option kernelcore= can be used to
specify how much memory should be used by the kernel.

(Note that Kamezawa called this parameter coremem= . This was renamed because
of the way ppc64 parses command line arguments and would confuse coremem=
with mem=. The name was chosen that could be used across architectures)

The value of kernelcore is important. If it is too small, there will be more
pressure on ZONE_NORMAL and a potential loss of performance. If it is about
896MB, it means that ZONE_HIGHMEM will have a size of zero. Any differences in
tests will depend on whether CONFIG_HIGHPTE is set in the standard kernel or
not. With lots of memory, the ideal is to specify a kernelcore that gives
ZONE_NORMAL it's full size and a ZONE_HIGHMEM for PTEs. The right value
depends, like any tunable, on the workload.

It is also important to note that if kernelcore is less than the maximum
size of ZONE_NORMAL, GFP_HIGHMEM allocations will use ZONE_NORMAL, not the
reachable portion of ZONE_EASYRCLM.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.16-rc1-mm3-102_addzone/arch/i386/kernel/setup.c linux-2.6.16-rc1-mm3-103_x86coremem/arch/i386/kernel/setup.c
--- linux-2.6.16-rc1-mm3-102_addzone/arch/i386/kernel/setup.c	2006-01-25 13:42:41.000000000 +0000
+++ linux-2.6.16-rc1-mm3-103_x86coremem/arch/i386/kernel/setup.c	2006-01-26 18:09:48.000000000 +0000
@@ -121,6 +121,9 @@ int bootloader_type;
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
 
+/* user-defined easy-reclaim-size */
+static unsigned int core_mem_pages = -1;
+static unsigned int easyrclm_pages = 0;
 /*
  * Setup options
  */
@@ -921,6 +924,15 @@ static void __init parse_cmdline_early (
 		 */
 		else if (!memcmp(from, "vmalloc=", 8))
 			__VMALLOC_RESERVE = memparse(from+8, &from);
+		 /*
+		  * kernelcore=size sets the amount of memory for use for
+		  * kernel allocations that cannot be reclaimed easily.
+		  * The remaining memory is set aside for easy reclaim
+		  * for features like memory remove or huge page allocations
+		  */
+		else if (!memcmp(from, "kernelcore=",11)) {
+			core_mem_pages = memparse(from+11, &from) >> PAGE_SHIFT;
+		}
 
 	next_char:
 		c = *(from++);
@@ -990,6 +1002,17 @@ void __init find_max_pfn(void)
 	}
 }
 
+unsigned long  __init calculate_core_memory(unsigned long max_low_pfn)
+{
+	if (max_low_pfn < core_mem_pages) {
+		highmem_pages -= (core_mem_pages - max_low_pfn);
+	} else {
+		max_low_pfn = core_mem_pages;
+		highmem_pages = 0;
+	}
+	easyrclm_pages = max_pfn - core_mem_pages;
+	return max_low_pfn;
+}
 /*
  * Determine low and high memory ranges:
  */
@@ -1046,6 +1069,8 @@ unsigned long __init find_max_low_pfn(vo
 			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
 #endif
 	}
+	if (core_mem_pages != -1)
+		max_low_pfn = calculate_core_memory(max_low_pfn);
 	return max_low_pfn;
 }
 
@@ -1166,7 +1191,8 @@ void __init zone_sizes_init(void)
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
 #ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = highend_pfn - low;
+		zones_size[ZONE_HIGHMEM] = highend_pfn - low - easyrclm_pages;
+		zones_size[ZONE_EASYRCLM] = easyrclm_pages;
 #endif
 	}
 	free_area_init(zones_size);
