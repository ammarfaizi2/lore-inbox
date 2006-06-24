Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWFXASq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWFXASq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWFXASq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:18:46 -0400
Received: from ns1.suse.de ([195.135.220.2]:399 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751688AbWFXASp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:18:45 -0400
Date: Sat, 24 Jun 2006 02:18:43 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [5/82] i386/x86-64: Emulate CPUID4 on AMD
Message-ID: <449C84E3.mailCOA11ECCJ@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Intel systems report the cache level data from CPUID 4 in sysfs.
Add a CPUID 4 emulation for AMD CPUs to report the same 
information for them. This allows programs to read this
information in a uniform way.

The AMD way to report this is less flexible so some assumptions
are hardcoded (e.g. no L3) 

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/amd.c             |    2 
 arch/i386/kernel/cpu/intel_cacheinfo.c |  113 +++++++++++++++++++++++++++++----
 arch/x86_64/kernel/setup.c             |    3 
 include/asm-i386/processor.h           |    1 
 include/asm-x86_64/processor.h         |    1 
 5 files changed, 107 insertions(+), 13 deletions(-)

Index: linux/arch/i386/kernel/cpu/intel_cacheinfo.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ linux/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -4,6 +4,7 @@
  *      Changes:
  *      Venkatesh Pallipadi	: Adding cache identification through cpuid(4)
  *		Ashok Raj <ashok.raj@intel.com>: Work with CPU hotplug infrastructure.
+ *	Andi Kleen		: CPUID4 emulation on AMD.
  */
 
 #include <linux/init.h>
@@ -130,25 +131,111 @@ struct _cpuid4_info {
 	cpumask_t shared_cpu_map;
 };
 
-static unsigned short			num_cache_leaves;
+unsigned short			num_cache_leaves;
+
+/* AMD doesn't have CPUID4. Emulate it here to report the same
+   information to the user.  This makes some assumptions about the machine:
+   No L3, L2 not shared, no SMT etc. that is currently true on AMD CPUs.
+
+   In theory the TLBs could be reported as fake type (they are in "dummy").
+   Maybe later */
+union l1_cache {
+	struct {
+		unsigned line_size : 8;
+		unsigned lines_per_tag : 8;
+		unsigned assoc : 8;
+		unsigned size_in_kb : 8;
+	};
+	unsigned val;
+};
+
+union l2_cache {
+	struct {
+		unsigned line_size : 8;
+		unsigned lines_per_tag : 4;
+		unsigned assoc : 4;
+		unsigned size_in_kb : 16;
+	};
+	unsigned val;
+};
+
+static unsigned short assocs[] = {
+	[1] = 1, [2] = 2, [4] = 4, [6] = 8,
+	[8] = 16,
+	[0xf] = 0xffff // ??
+	};
+static unsigned char levels[] = { 1, 1, 2 };
+static unsigned char types[] = { 1, 2, 3 };
+
+static void __cpuinit amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
+		       union _cpuid4_leaf_ebx *ebx,
+		       union _cpuid4_leaf_ecx *ecx)
+{
+	unsigned dummy;
+	unsigned line_size, lines_per_tag, assoc, size_in_kb;
+	union l1_cache l1i, l1d;
+	union l2_cache l2;
+
+	eax->full = 0;
+	ebx->full = 0;
+	ecx->full = 0;
+
+	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
+	cpuid(0x80000006, &dummy, &dummy, &l2.val, &dummy);
+
+	if (leaf > 2 || !l1d.val || !l1i.val || !l2.val)
+		return;
+
+	eax->split.is_self_initializing = 1;
+	eax->split.type = types[leaf];
+	eax->split.level = levels[leaf];
+	eax->split.num_threads_sharing = 0;
+	eax->split.num_cores_on_die = current_cpu_data.x86_max_cores - 1;
+
+	if (leaf <= 1) {
+		union l1_cache *l1 = leaf == 0 ? &l1d : &l1i;
+		assoc = l1->assoc;
+		line_size = l1->line_size;
+		lines_per_tag = l1->lines_per_tag;
+		size_in_kb = l1->size_in_kb;
+	} else {
+		assoc = l2.assoc;
+		line_size = l2.line_size;
+		lines_per_tag = l2.lines_per_tag;
+		/* cpu_data has errata corrections for K7 applied */
+		size_in_kb = current_cpu_data.x86_cache_size;
+	}
+
+	if (assoc == 0xf)
+		eax->split.is_fully_associative = 1;
+	ebx->split.coherency_line_size = line_size - 1;
+	ebx->split.ways_of_associativity = assocs[assoc] - 1;
+	ebx->split.physical_line_partition = lines_per_tag - 1;
+	ecx->split.number_of_sets = (size_in_kb * 1024) / line_size /
+		(ebx->split.ways_of_associativity + 1) - 1;
+}
 
 static int __cpuinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
 {
-	unsigned int		eax, ebx, ecx, edx;
-	union _cpuid4_leaf_eax	cache_eax;
+	union _cpuid4_leaf_eax 	eax;
+	union _cpuid4_leaf_ebx 	ebx;
+	union _cpuid4_leaf_ecx 	ecx;
+	unsigned		edx;
 
-	cpuid_count(4, index, &eax, &ebx, &ecx, &edx);
-	cache_eax.full = eax;
-	if (cache_eax.split.type == CACHE_TYPE_NULL)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		amd_cpuid4(index, &eax, &ebx, &ecx);
+	else
+		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full,  &edx);
+	if (eax.split.type == CACHE_TYPE_NULL)
 		return -EIO; /* better error ? */
 
-	this_leaf->eax.full = eax;
-	this_leaf->ebx.full = ebx;
-	this_leaf->ecx.full = ecx;
-	this_leaf->size = (this_leaf->ecx.split.number_of_sets + 1) *
-		(this_leaf->ebx.split.coherency_line_size + 1) *
-		(this_leaf->ebx.split.physical_line_partition + 1) *
-		(this_leaf->ebx.split.ways_of_associativity + 1);
+	this_leaf->eax = eax;
+	this_leaf->ebx = ebx;
+	this_leaf->ecx = ecx;
+	this_leaf->size = (ecx.split.number_of_sets + 1) *
+		(ebx.split.coherency_line_size + 1) *
+		(ebx.split.physical_line_partition + 1) *
+		(ebx.split.ways_of_associativity + 1);
 	return 0;
 }
 
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -1071,6 +1071,9 @@ static int __init init_amd(struct cpuinf
 	if (c->extended_cpuid_level >= 0x80000008)
 		amd_detect_cmp(c);
 
+	/* Fix cpuid4 emulation for more */
+	num_cache_leaves = 3;
+
 	return r;
 }
 
Index: linux/include/asm-i386/processor.h
===================================================================
--- linux.orig/include/asm-i386/processor.h
+++ linux/include/asm-i386/processor.h
@@ -112,6 +112,7 @@ extern char ignore_fpu_irq;
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern unsigned short num_cache_leaves;
 
 #ifdef CONFIG_X86_HT
 extern void detect_ht(struct cpuinfo_x86 *c);
Index: linux/include/asm-x86_64/processor.h
===================================================================
--- linux.orig/include/asm-x86_64/processor.h
+++ linux/include/asm-x86_64/processor.h
@@ -96,6 +96,7 @@ extern char ignore_irq13;
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern unsigned short num_cache_leaves;
 
 /*
  * EFLAGS bits
Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -242,6 +242,8 @@ static void __init init_amd(struct cpuin
 	}
 #endif
 
+	if (cpuid_eax(0x80000000) >= 0x80000006)
+		num_cache_leaves = 3;
 }
 
 static unsigned int amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
