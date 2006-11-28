Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933390AbWK1B3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390AbWK1B3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758643AbWK1B2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:28:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58886 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758640AbWK1B2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:28:35 -0500
Date: Tue, 28 Nov 2006 02:28:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [2.6 patch] cleanup arch/i386/kernel/smpboot.c:smp_tune_scheduling()
Message-ID: <20061128012839.GU15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove the write-only local variable "bandwidth"
- don't set "max_cache_size" in the (cachesize < 0) case:
  that's already handled in kernel/sched.c:measure_migration_cost()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- 

 arch/i386/kernel/smpboot.c |   29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

--- linux-2.6.19-rc6-mm1/arch/i386/kernel/smpboot.c.old	2006-11-27 23:36:48.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/i386/kernel/smpboot.c	2006-11-27 23:48:16.000000000 +0100
@@ -1127,34 +1127,15 @@
 }
 #endif
 
-static void smp_tune_scheduling (void)
+static void smp_tune_scheduling(void)
 {
 	unsigned long cachesize;       /* kB   */
-	unsigned long bandwidth = 350; /* MB/s */
-	/*
-	 * Rough estimation for SMP scheduling, this is the number of
-	 * cycles it takes for a fully memory-limited process to flush
-	 * the SMP-local cache.
-	 *
-	 * (For a P5 this pretty much means we will choose another idle
-	 *  CPU almost always at wakeup time (this is due to the small
-	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
-	 *  the cache size)
-	 */
 
-	if (!cpu_khz) {
-		/*
-		 * this basically disables processor-affinity
-		 * scheduling on SMP without a TSC.
-		 */
-		return;
-	} else {
+	if (cpu_khz) {
 		cachesize = boot_cpu_data.x86_cache_size;
-		if (cachesize == -1) {
-			cachesize = 16; /* Pentiums, 2x8kB cache */
-			bandwidth = 100;
-		}
-		max_cache_size = cachesize * 1024;
+
+		if (cachesize > 0)
+			max_cache_size = cachesize * 1024;
 	}
 }
 

