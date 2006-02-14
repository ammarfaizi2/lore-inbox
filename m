Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWBNGvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWBNGvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWBNGvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:51:44 -0500
Received: from fmr20.intel.com ([134.134.136.19]:41882 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030500AbWBNGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:51:43 -0500
Subject: [PATCH] don't use cpuid.2 to determine cache info if cpuid.4 is
	supported
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 14:51:07 +0800
Message-Id: <1139899867.2750.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use cpuid.2 to determine cache info if cpuid.4 is supported. The
exception is P4 trace cache. We always use cpuid.2 to get trace cache
under P4.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.16-rc2-root/arch/i386/kernel/cpu/intel_cacheinfo.c |   63 +++++------
 1 files changed, 30 insertions(+), 33 deletions(-)

diff -puN arch/i386/kernel/cpu/intel_cacheinfo.c arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.16-rc2/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-02-10 09:54:21.000000000 +0800
+++ linux-2.6.16-rc2-root/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-02-13 11:44:07.000000000 +0800
@@ -170,8 +170,7 @@ static int __init find_num_cache_leaves(
 unsigned int __cpuinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
-	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
-	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
+	int i;
 
 	if (c->cpuid_level > 4) {
 		static int is_initialized;
@@ -197,16 +196,16 @@ unsigned int __cpuinit init_intel_cachei
 				    case 1:
 					if (this_leaf.eax.split.type ==
 							CACHE_TYPE_DATA)
-						new_l1d = this_leaf.size/1024;
+						l1d = this_leaf.size/1024;
 					else if (this_leaf.eax.split.type ==
 							CACHE_TYPE_INST)
-						new_l1i = this_leaf.size/1024;
+						l1i = this_leaf.size/1024;
 					break;
 				    case 2:
-					new_l2 = this_leaf.size/1024;
+					l2 = this_leaf.size/1024;
 					break;
 				    case 3:
-					new_l3 = this_leaf.size/1024;
+					l3 = this_leaf.size/1024;
 					break;
 				    default:
 					break;
@@ -214,11 +213,19 @@ unsigned int __cpuinit init_intel_cachei
 			}
 		}
 	}
-	if (c->cpuid_level > 1) {
+	/*
+	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
+	 * trace cache
+	 */
+	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int i, j, n;
 		int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
+		int only_trace = 0;
+
+		if (num_cache_leaves != 0 && c->x86 == 15)
+			only_trace = 1;
 
 		/* Number of times to iterate */
 		n = cpuid_eax(2) & 0xFF;
@@ -240,6 +247,8 @@ unsigned int __cpuinit init_intel_cachei
 				while (cache_table[k].descriptor != 0)
 				{
 					if (cache_table[k].descriptor == des) {
+						if (only_trace && cache_table[k].cache_type != LVL_TRACE)
+							break;
 						switch (cache_table[k].cache_type) {
 						case LVL_1_INST:
 							l1i += cache_table[k].size;
@@ -265,34 +274,22 @@ unsigned int __cpuinit init_intel_cachei
 				}
 			}
 		}
+	}
 
-		if (new_l1d)
-			l1d = new_l1d;
-
-		if (new_l1i)
-			l1i = new_l1i;
-
-		if (new_l2)
-			l2 = new_l2;
-
-		if (new_l3)
-			l3 = new_l3;
-
-		if ( trace )
-			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
-		else if ( l1i )
-			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
-		if ( l1d )
-			printk(", L1 D cache: %dK\n", l1d);
-		else
-			printk("\n");
-		if ( l2 )
-			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
-		if ( l3 )
-			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
+	if ( trace )
+		printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
+	else if ( l1i )
+		printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
+	if ( l1d )
+		printk(", L1 D cache: %dK\n", l1d);
+	else
+		printk("\n");
+	if ( l2 )
+		printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
+	if ( l3 )
+		printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
 
-		c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
-	}
+	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
 	return l2;
 }
_


