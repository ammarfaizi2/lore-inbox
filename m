Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVIZWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVIZWAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVIZWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:00:20 -0400
Received: from fmr21.intel.com ([143.183.121.13]:38870 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932334AbVIZWAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:00:19 -0400
Date: Mon, 26 Sep 2005 14:59:56 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] When L3 is present show its size in /proc/cpuinfo
Message-ID: <20050926145956.B15625@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code that prints the cache size assumes that L3 always lives in chipset and
is shared across CPUs. Which is not really true.

I think all the cachesizes reported by cpuid are in the processor itself. The
attached patch changes the code to reflect that.

Dave, any idea where that original comment in the code came from? Are there any
systems which reports the L3 cache size in cpuid, when L3 sits in northbridge?

Thanks,
Venki

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.12/arch/i386/kernel/cpu/intel_cacheinfo.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-08-31 14:46:40.474386680 -0700
+++ linux-2.6.12/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-12 11:47:06.639700640 -0700
@@ -284,13 +284,7 @@
 		if ( l3 )
 			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
 
-		/*
-		 * This assumes the L3 cache is shared; it typically lives in
-		 * the northbridge.  The L1 caches are included by the L2
-		 * cache, and so should not be included for the purpose of
-		 * SMP switching weights.
-		 */
-		c->x86_cache_size = l2 ? l2 : (l1i+l1d);
+		c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 	}
 
 	return l2;
