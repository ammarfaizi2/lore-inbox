Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCSX5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCSX5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCSX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:57:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:23016 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261928AbVCSX5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:57:11 -0500
Date: Sun, 20 Mar 2005 00:58:47 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, cpufreq@lists.linux.org.uk,
       Ingo Molnar <mingo@redhat.com>, Richard Gooch <rgooch@atnf.csiro.au>,
       Zach Brown <zab@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] get rid of redundant NULL checks before kfree() in arch/i386/
Message-ID: <Pine.LNX.4.62.0503200047410.5507@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Checking a pointer for NULL before calling kfree() on it is redundant,
kfree() deals with NULL pointers just fine.
This patch removes such checks from files in arch/i386/

Since this is a fairly trivial change (and the same change made
everywhere) I've just made a single patch for all four files and CC all
authors/maintainers of those files I could find for comments. If spliting
this into one patch pr file is prefered, then I can easily do that as
well.

These are the files being modified :
	arch/i386/kernel/cpu/cpufreq/powernow-k7.c
	arch/i386/kernel/cpu/intel_cacheinfo.c
	arch/i386/kernel/cpu/mtrr/generic.c
	arch/i386/kernel/io_apic.c
	
(please CC me on replies to lists other than linux-kernel)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2005-03-16 15:45:02.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2005-03-20 00:41:27.000000000 +0100
@@ -643,9 +643,7 @@ static int powernow_cpu_exit (struct cpu
 	}
 #endif
 
-	if (powernow_table)
-		kfree(powernow_table);
-
+	kfree(powernow_table);
 	return 0;
 }
 
--- linux-2.6.11-mm4-orig/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-16 15:45:02.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-20 00:43:21.000000000 +0100
@@ -491,12 +491,9 @@ static int cpuid4_cache_sysfs_init(unsig
 
 err_out:
 	for (i = 0; i < NR_CPUS; i++) {
-		if(cpuid4_info[i])
-			kfree(cpuid4_info[i]);
-		if(cache_kobject[i])
-			kfree(cache_kobject[i]);
-		if(index_kobject[i])
-			kfree(index_kobject[i]);
+		kfree(cpuid4_info[i]);
+		kfree(cache_kobject[i]);
+		kfree(index_kobject[i]);
 
 		cpuid4_info[i] = NULL;
 		cache_kobject[i] = NULL;
@@ -508,12 +505,9 @@ err_out:
 
 static int cpuid4_cache_sysfs_exit(unsigned int i)
 {
-	if(cpuid4_info[i])
-		kfree(cpuid4_info[i]);
-	if(cache_kobject[i])
-		kfree(cache_kobject[i]);
-	if(index_kobject[i])
-		kfree(index_kobject[i]);
+	kfree(cpuid4_info[i]);
+	kfree(cache_kobject[i]);
+	kfree(index_kobject[i]);
 
 	cpuid4_info[i] = NULL;
 	cache_kobject[i] = NULL;
--- linux-2.6.11-mm4-orig/arch/i386/kernel/cpu/mtrr/generic.c	2005-03-16 15:45:02.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/kernel/cpu/mtrr/generic.c	2005-03-20 00:43:39.000000000 +0100
@@ -70,8 +70,7 @@ void __init get_mtrr_state(void)
 /*  Free resources associated with a struct mtrr_state  */
 void __init finalize_mtrr_state(void)
 {
-	if (mtrr_state.var_ranges)
-		kfree(mtrr_state.var_ranges);
+	kfree(mtrr_state.var_ranges);
 	mtrr_state.var_ranges = NULL;
 }
 
--- linux-2.6.11-mm4-orig/arch/i386/kernel/io_apic.c	2005-03-16 15:45:02.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/kernel/io_apic.c	2005-03-20 00:44:47.000000000 +0100
@@ -632,10 +632,8 @@ static int __init balanced_irq_init(void
 		printk(KERN_ERR "balanced_irq_init: failed to spawn balanced_irq");
 failed:
 	for (i = 0; i < NR_CPUS; i++) {
-		if(irq_cpu_data[i].irq_delta)
-			kfree(irq_cpu_data[i].irq_delta);
-		if(irq_cpu_data[i].last_irq)
-			kfree(irq_cpu_data[i].last_irq);
+		kfree(irq_cpu_data[i].irq_delta);
+		kfree(irq_cpu_data[i].last_irq);
 	}
 	return 0;
 }


