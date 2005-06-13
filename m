Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVFMXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVFMXcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVFMXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:30:38 -0400
Received: from fmr24.intel.com ([143.183.121.16]:3542 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261458AbVFMX30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:29:26 -0400
Date: Mon, 13 Jun 2005 16:29:16 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Handle CPU cores in CPU cache information
Message-ID: <20050613162916.A5178@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Handle the case of all the cores in a package sharing the cache,
in cache_shared_cpu_map_setup().

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c linux-2.6.12-rc4-mm2-cache/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-05-17 05:50:03.000000000 -0700
+++ linux-2.6.12-rc4-mm2-cache/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-06-11 04:53:59.749155936 -0700
@@ -305,6 +305,9 @@ static void __devinit cache_shared_cpu_m
 {
 	struct _cpuid4_info	*this_leaf;
 	unsigned long num_threads_sharing;
+#ifdef CONFIG_X86_HT
+	struct cpuinfo_x86 *c = cpu_data + cpu;
+#endif
 
 	this_leaf = CPUID4_INFO_IDX(cpu, index);
 	num_threads_sharing = 1 + this_leaf->eax.split.num_threads_sharing;
@@ -314,10 +317,12 @@ static void __devinit cache_shared_cpu_m
 #ifdef CONFIG_X86_HT
 	else if (num_threads_sharing == smp_num_siblings)
 		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
-#endif
+	else if (num_threads_sharing == (c->x86_num_cores * smp_num_siblings))
+		this_leaf->shared_cpu_map = cpu_core_map[cpu];
 	else
-		printk(KERN_INFO "Number of CPUs sharing cache didn't match "
+		printk(KERN_DEBUG "Number of CPUs sharing cache didn't match "
 				"any known set of CPUs\n");
+#endif
 }
 #else
 static void __init cache_shared_cpu_map_setup(unsigned int cpu, int index) {}
