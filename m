Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVISTOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVISTOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVISTOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:14:44 -0400
Received: from fmr22.intel.com ([143.183.121.14]:32217 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932589AbVISTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:14:44 -0400
Date: Mon, 19 Sep 2005 12:14:35 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: [patch] intel_cacheinfo: remove MAX_CACHE_LEAVES limit
Message-ID: <20050919121435.A10231@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the MAX_CACHE_LEAVES limit from the routine which calculates the
number of cache levels using cpuid(4)

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

--- linux-2.6.13/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13~/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-19 10:37:58.329447344 -0700
@@ -117,7 +117,6 @@ struct _cpuid4_info {
 	cpumask_t shared_cpu_map;
 };
 
-#define MAX_CACHE_LEAVES		4
 static unsigned short			num_cache_leaves;
 
 static int __devinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
@@ -144,20 +143,15 @@ static int __init find_num_cache_leaves(
 {
 	unsigned int		eax, ebx, ecx, edx;
 	union _cpuid4_leaf_eax	cache_eax;
-	int 			i;
-	int 			retval;
+	int 			i = -1;
 
-	retval = MAX_CACHE_LEAVES;
-	/* Do cpuid(4) loop to find out num_cache_leaves */
-	for (i = 0; i < MAX_CACHE_LEAVES; i++) {
+	do {
+		++i;
+		/* Do cpuid(4) loop to find out num_cache_leaves */
 		cpuid_count(4, i, &eax, &ebx, &ecx, &edx);
 		cache_eax.full = eax;
-		if (cache_eax.split.type == CACHE_TYPE_NULL) {
-			retval = i;
-			break;
-		}
-	}
-	return retval;
+	} while (cache_eax.split.type != CACHE_TYPE_NULL);
+	return i;
 }
 
 unsigned int __devinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
