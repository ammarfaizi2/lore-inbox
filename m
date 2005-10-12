Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVJLVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVJLVlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVJLVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:41:13 -0400
Received: from fmr24.intel.com ([143.183.121.16]:33933 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932456AbVJLVlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:41:11 -0400
Date: Wed, 12 Oct 2005 14:41:03 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [Patch 2/2] x86, x86_64: fix Intel cache detection code assumption about threads sharing
Message-ID: <20051012144103.C29292@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <20051007095200.GL6642@verdi.suse.de> <20051007175240.A2354@unix-os.sc.intel.com> <200510081228.39492.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510081228.39492.ak@suse.de>; from ak@suse.de on Sat, Oct 08, 2005 at 12:28:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Please apply.

thanks,
suresh
--

Fix the Intel cache detection code assumption that number of threads sharing the
cache will either be equal to number of HT or core siblings.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c linux/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-10-07 16:27:37.708580280 -0700
@@ -303,29 +303,45 @@ static struct _cpuid4_info *cpuid4_info[
 #ifdef CONFIG_SMP
 static void __devinit cache_shared_cpu_map_setup(unsigned int cpu, int index)
 {
-	struct _cpuid4_info	*this_leaf;
+	struct _cpuid4_info	*this_leaf, *sibling_leaf;
 	unsigned long num_threads_sharing;
-#ifdef CONFIG_X86_HT
-	struct cpuinfo_x86 *c = cpu_data + cpu;
-#endif
+	int index_msb, i;
+	struct cpuinfo_x86 *c = cpu_data;
 
 	this_leaf = CPUID4_INFO_IDX(cpu, index);
 	num_threads_sharing = 1 + this_leaf->eax.split.num_threads_sharing;
 
 	if (num_threads_sharing == 1)
 		cpu_set(cpu, this_leaf->shared_cpu_map);
-#ifdef CONFIG_X86_HT
-	else if (num_threads_sharing == smp_num_siblings)
-		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
-	else if (num_threads_sharing == (c->x86_num_cores * smp_num_siblings))
-		this_leaf->shared_cpu_map = cpu_core_map[cpu];
-	else
-		printk(KERN_DEBUG "Number of CPUs sharing cache didn't match "
-				"any known set of CPUs\n");
-#endif
+	else {
+		index_msb = get_count_order(num_threads_sharing);
+
+		for_each_online_cpu(i) {
+			if (c[i].apicid >> index_msb ==
+			    c[cpu].apicid >> index_msb) {
+				cpu_set(i, this_leaf->shared_cpu_map);
+				if (i != cpu && cpuid4_info[i])  {
+					sibling_leaf = CPUID4_INFO_IDX(i, index);
+					cpu_set(cpu, sibling_leaf->shared_cpu_map);
+				}
+			}
+		}
+	}
+}
+static void __devinit cache_remove_shared_cpu_map(unsigned int cpu, int index)
+{
+	struct _cpuid4_info	*this_leaf, *sibling_leaf;
+	int sibling;
+
+	this_leaf = CPUID4_INFO_IDX(cpu, index);
+	for_each_cpu_mask(sibling, this_leaf->shared_cpu_map) {
+		sibling_leaf = CPUID4_INFO_IDX(sibling, index);	
+		cpu_clear(cpu, sibling_leaf->shared_cpu_map);
+	}
 }
 #else
 static void __init cache_shared_cpu_map_setup(unsigned int cpu, int index) {}
+static void __init cache_remove_shared_cpu_map(unsigned int cpu, int index) {}
 #endif
 
 static void free_cache_attributes(unsigned int cpu)
@@ -584,8 +600,10 @@ static int __devexit cache_remove_dev(st
 	unsigned int cpu = sys_dev->id;
 	unsigned long i;
 
-	for (i = 0; i < num_cache_leaves; i++)
+	for (i = 0; i < num_cache_leaves; i++) {
+		cache_remove_shared_cpu_map(cpu, i);
 		kobject_unregister(&(INDEX_KOBJECT_PTR(cpu,i)->kobj));
+	}
 	kobject_unregister(cache_kobject[cpu]);
 	cpuid4_cache_sysfs_exit(cpu);
 	return 0;
