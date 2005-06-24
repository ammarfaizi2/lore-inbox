Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbVFXRGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbVFXRGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbVFXREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:04:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60382 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263166AbVFXRB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:01:29 -0400
Date: Fri, 24 Jun 2005 19:01:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <20050624170112.GD6393@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51900000.1119622290@[10.10.2.4]>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> OK, still broken with the last 3 backed out, but works with the last 4 
> backed out. So I guess it's scheduler-cache-hot-autodetect.patch that 
> breaks it. Con just sent me something else to try to fix it in order 
> to run next ... will do that.

hm. Does it work if you disable migration-autodetect via passing in e.g.  
migration_cost=1000,2000,3000 on the boot line? Is it perhaps the 
excessive debugging that hurts.

or does it work if you undo the chunk below? Seemed harmless, but has 
CONFIG_NUMA relevance.

	Ingo

--- linux/arch/i386/kernel/timers/timer_tsc.c.orig
+++ linux/arch/i386/kernel/timers/timer_tsc.c
@@ -133,18 +133,15 @@ static unsigned long long monotonic_cloc
 
 /*
  * Scheduler clock - returns current time in nanosec units.
+ *
+ * it's not a problem if the TSC is unsynchronized,
+ * as the scheduler will carefully compensate for it.
  */
 unsigned long long sched_clock(void)
 {
 	unsigned long long this_offset;
 
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (!use_tsc)
-#endif
+	if (!cpu_has_tsc)
 		/* no locking but a rare wrong value is not a big deal */
 		return jiffies_64 * (1000000000 / HZ);
 
