Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWBFAwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWBFAwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 19:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWBFAwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 19:52:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750829AbWBFAwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 19:52:37 -0500
Message-Id: <200602060052.k160qOZW020829@shell0.pdx.osdl.net>
Subject: + x86_64-fix-the-node-cpumask-of-a-cpu-going-down.patch added to -mm tree
To: linux-kernel@vger.kernel.org, ak@suse.de, alokk@calsoftinc.com,
       kiran@scalex86.org, shai@scalex86.org, mm-commits@vger.kernel.org
From: akpm@osdl.org
Date: Sun, 05 Feb 2006 16:52:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch titled

     x86_64: Fix the node cpumask of a cpu going down

has been added to the -mm tree.  Its filename is

     x86_64-fix-the-node-cpumask-of-a-cpu-going-down.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this


From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Ravikiran G Thirumalai <kiran@scalex86.org>

Currently, x86_64 and ia64 arches do not clear the corresponding bits in
the node's cpumask when a cpu goes down or cpu bring up is cancelled.  This
is buggy since there are pieces of common code where the cpumask is checked
in the cpu down code path to decide on things (like in the slab down path).
 PPC does the right thing, but x86_64 and ia64 don't (This was the reason
Sonny hit upon a slab bug during cpu offline on ppc and could not reproduce
on other arches).  This patch fixes it for x86_64.  I won't attempt ia64 as
I cannot test it.

Credit for spotting this should go to Alok.

(akpm: this was applied, then reverted.  But it's OK now because we now use
for_each_cpu() in the right places).

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/smpboot.c |    3 +++
 include/asm-x86_64/numa.h    |    7 +++++++
 2 files changed, 10 insertions(+)

diff -puN arch/x86_64/kernel/smpboot.c~x86_64-fix-the-node-cpumask-of-a-cpu-going-down arch/x86_64/kernel/smpboot.c
--- devel/arch/x86_64/kernel/smpboot.c~x86_64-fix-the-node-cpumask-of-a-cpu-going-down	2006-02-05 16:51:57.000000000 -0800
+++ devel-akpm/arch/x86_64/kernel/smpboot.c	2006-02-05 16:51:57.000000000 -0800
@@ -59,6 +59,7 @@
 #include <asm/nmi.h>
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
+#include <asm/numa.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -890,6 +891,7 @@ do_rest:
 	if (boot_error) {
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		clear_node_cpumask(cpu); /* was set by numa_add_cpu */
 		cpu_clear(cpu, cpu_present_map);
 		cpu_clear(cpu, cpu_possible_map);
 		x86_cpu_to_apicid[cpu] = BAD_APICID;
@@ -1187,6 +1189,7 @@ void remove_cpu_from_maps(void)
 	cpu_clear(cpu, cpu_callout_map);
 	cpu_clear(cpu, cpu_callin_map);
 	clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+	clear_node_cpumask(cpu);
 }
 
 int __cpu_disable(void)
diff -puN include/asm-x86_64/numa.h~x86_64-fix-the-node-cpumask-of-a-cpu-going-down include/asm-x86_64/numa.h
--- devel/include/asm-x86_64/numa.h~x86_64-fix-the-node-cpumask-of-a-cpu-going-down	2006-02-05 16:51:57.000000000 -0800
+++ devel-akpm/include/asm-x86_64/numa.h	2006-02-05 16:51:57.000000000 -0800
@@ -22,8 +22,15 @@ extern void numa_set_node(int cpu, int n
 extern unsigned char apicid_to_node[256];
 #ifdef CONFIG_NUMA
 extern void __init init_cpu_to_node(void);
+
+static inline void clear_node_cpumask(int cpu)
+{
+	clear_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
+}
+
 #else
 #define init_cpu_to_node() do {} while (0)
+#define clear_node_cpumask(cpu) do {} while (0)
 #endif
 
 #define NUMA_NO_NODE 0xff
_

Patches currently in -mm which might be from linux-kernel@vger.kernel.org are

x86_64-fix-the-node-cpumask-of-a-cpu-going-down.patch
reiser4-only.patch

