Return-Path: <linux-kernel-owner+w=401wt.eu-S1422955AbWLVMW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWLVMW3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWLVMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:22:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49020 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964975AbWLVMW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:22:28 -0500
Date: Fri, 22 Dec 2006 13:19:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       suresh.b.siddha@intel.com, kenneth.w.chen@intel.com,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>
Subject: [patch] sched: improve sched_clock() on i686
Message-ID: <20061222121920.GA3809@elte.hu>
References: <20061222104306.GC1895@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222104306.GC1895@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephane Eranian <eranian@hpl.hp.com> wrote:

> The perfmon subsystems needs to compute per-CPU duration. It is using 
> sched_clock() to provide this information. However, it seems they are 
> big variations in the way sched_clock() is implemented for each 
> architectures, especially in the accuracy of the returned value (going 
> from TSC to jiffies).
> 
> Looking at the i386 implementation, it is not so clear to me what the 
> actual goal of the function is. I was under the impression that this 
> function was meant to compute per-CPU time deltas. This is how the 
> scheduler seems to use it.
> 
> The x86-64 and i386 implementations are quite different. The i386 
> comment about NUMA seems to contradict the initial goal of the 
> function. Why is that?

it's purely historic - the i686 sched_clock() implementation predates 
the scheduler's ability to deal with non-synchronous per-CPU clocks. I 
tried to fix that (a year ago) and it didnt work out - but i've reviewed 
my old patch and now realize what the mistake was - the patch below 
should work better.

	Ingo

---------------------->
Subject: [patch] sched: improve sched_clock() on i686
From: Ingo Molnar <mingo@elte.hu>

this patch cleans up sched_clock() on i686: it will use the TSC if 
available and falls back to jiffies only if the user asked for it to be 
disabled via notsc or the CPU calibration code didnt figure out the 
right cpu_khz.

this generally makes the scheduler timestamps more finegrained, on all 
hardware. (the current scheduler is pretty resistant against 
asynchronous sched_clock() values on different CPUs, it will allow at 
most up to a jiffy of jitter.)

also simplify sched_clock()'s check for TSC availability: propagate the 
desire and ability to use the TSC into the tsc_disable flag, previously 
this flag only indicated whether the notsc option was passed. This makes 
the rare low-res sched_clock() codepath a single branch off a 
read-mostly flag.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/tsc.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

Index: linux/arch/i386/kernel/tsc.c
===================================================================
--- linux.orig/arch/i386/kernel/tsc.c
+++ linux/arch/i386/kernel/tsc.c
@@ -108,13 +108,10 @@ unsigned long long sched_clock(void)
 	unsigned long long this_offset;
 
 	/*
-	 * in the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
+	 * Fall back to jiffies if there's no TSC available:
 	 */
-#ifndef CONFIG_NUMA
-	if (!cpu_khz || check_tsc_unstable())
-#endif
-		/* no locking but a rare wrong value is not a big deal */
+	if (unlikely(tsc_disable))
+		/* No locking but a rare wrong value is not a big deal: */
 		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 
 	/* read the Time Stamp Counter: */
@@ -194,13 +191,13 @@ EXPORT_SYMBOL(recalibrate_cpu_khz);
 void __init tsc_init(void)
 {
 	if (!cpu_has_tsc || tsc_disable)
-		return;
+		goto out_no_tsc;
 
 	cpu_khz = calculate_cpu_khz();
 	tsc_khz = cpu_khz;
 
 	if (!cpu_khz)
-		return;
+		goto out_no_tsc;
 
 	printk("Detected %lu.%03lu MHz processor.\n",
 				(unsigned long)cpu_khz / 1000,
@@ -208,6 +205,15 @@ void __init tsc_init(void)
 
 	set_cyc2ns_scale(cpu_khz);
 	use_tsc_delay();
+	return;
+
+out_no_tsc:
+	/*
+	 * Set the tsc_disable flag if there's no TSC support, this
+	 * makes it a fast flag for the kernel to see whether it
+	 * should be using the TSC.
+	 */
+	tsc_disable = 1;
 }
 
 #ifdef CONFIG_CPU_FREQ
