Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVDMD5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVDMD5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVDLTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:15:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:43465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262206AbVDLKcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:33 -0400
Message-Id: <200504121032.j3CAWECJ005541@shell0.pdx.osdl.net>
Subject: [patch 101/198] x86_64: Rename the extended cpuid level field
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, mingo@elte.hu,
       rusty@rustcorp.com.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

It was confusingly named.

Signed-off-by: Andi Kleen <ak@suse.de>
DESC
x86_64: Switch SMP bootup over to new CPU hotplug state machine
EDESC
From: "Andi Kleen" <ak@suse.de>

This will allow hotplug CPU in the future and in general cleans up a lot of
crufty code.  It also should plug some races that the old hackish way
introduces.  Remove one old race workaround in NMI watchdog setup that is not
needed anymore.

I removed the old total sum of bogomips reporting code.  The brag value of
BogoMips has been greatly devalued in the last years on the open market.

Real CPU hotplug will need some more work, but the infrastructure for it is
there now.

One drawback: the new TSC sync algorithm is less accurate than before.  The
old way of zeroing TSCs is too intrusive to do later.  Instead the TSC of the
BP is duplicated now, which is less accurate.

Cc: <rusty@rustcorp.com.au>
Cc: <mingo@elte.hu>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/setup.c     |   13 ++++++-------
 25-akpm/include/asm-x86_64/processor.h |    2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff -puN arch/x86_64/kernel/setup.c~x86_64-rename-the-extended-cpuid-level-field arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-rename-the-extended-cpuid-level-field	2005-04-12 03:21:27.159008104 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:27.165007192 -0700
@@ -673,7 +673,7 @@ static int __init get_model_name(struct 
 {
 	unsigned int *v;
 
-	if (c->x86_cpuid_level < 0x80000004)
+	if (c->extended_cpuid_level < 0x80000004)
 		return 0;
 
 	v = (unsigned int *) c->x86_model_id;
@@ -689,7 +689,7 @@ static void __init display_cacheinfo(str
 {
 	unsigned int n, dummy, eax, ebx, ecx, edx;
 
-	n = c->x86_cpuid_level;
+	n = c->extended_cpuid_level;
 
 	if (n >= 0x80000005) {
 		cpuid(0x80000005, &dummy, &ebx, &ecx, &edx);
@@ -781,7 +781,7 @@ static int __init init_amd(struct cpuinf
 	} 
 	display_cacheinfo(c);
 
-	if (c->x86_cpuid_level >= 0x80000008) {
+	if (c->extended_cpuid_level >= 0x80000008) {
 		c->x86_num_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
 		if (c->x86_num_cores & (c->x86_num_cores - 1))
 			c->x86_num_cores = 1;
@@ -841,7 +841,6 @@ static void __init detect_ht(struct cpui
 		if (smp_num_siblings & (smp_num_siblings - 1))
 			index_msb++;
 
-		/* RED-PEN surely this must run in the non HT case too! -AK */
 		cpu_core_id[cpu] = phys_pkg_id(index_msb);
 
 		if (c->x86_num_cores > 1)
@@ -878,7 +877,7 @@ static void __init init_intel(struct cpu
 	unsigned n;
 
 	init_intel_cacheinfo(c);
-	n = c->x86_cpuid_level;
+	n = c->extended_cpuid_level;
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
 		c->x86_virt_bits = (eax >> 8) & 0xff;
@@ -927,7 +926,7 @@ void __init early_identify_cpu(struct cp
 	c->x86_cache_alignment = c->x86_clflush_size;
 	c->x86_num_cores = 1;
 	c->x86_apicid = c == &boot_cpu_data ? 0 : c - cpu_data;
-	c->x86_cpuid_level = 0;
+	c->extended_cpuid_level = 0;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
 	/* Get vendor name */
@@ -974,7 +973,7 @@ void __init identify_cpu(struct cpuinfo_
 
 	/* AMD-defined flags: level 0x80000001 */
 	xlvl = cpuid_eax(0x80000000);
-	c->x86_cpuid_level = xlvl;
+	c->extended_cpuid_level = xlvl;
 	if ((xlvl & 0xffff0000) == 0x80000000) {
 		if (xlvl >= 0x80000001) {
 			c->x86_capability[1] = cpuid_edx(0x80000001);
diff -puN include/asm-x86_64/processor.h~x86_64-rename-the-extended-cpuid-level-field include/asm-x86_64/processor.h
--- 25/include/asm-x86_64/processor.h~x86_64-rename-the-extended-cpuid-level-field	2005-04-12 03:21:27.161007800 -0700
+++ 25-akpm/include/asm-x86_64/processor.h	2005-04-12 03:21:27.165007192 -0700
@@ -64,7 +64,7 @@ struct cpuinfo_x86 {
 	__u8	x86_num_cores;
 	__u8	x86_apicid;
         __u32   x86_power; 	
-	__u32   x86_cpuid_level;	/* Max CPUID function supported */
+	__u32   extended_cpuid_level;	/* Max extended CPUID function supported */
 	unsigned long loops_per_jiffy;
 } ____cacheline_aligned;
 
_
