Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVHMLie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVHMLie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 07:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHMLie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 07:38:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31893 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932149AbVHMLid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 07:38:33 -0400
Date: Sat, 13 Aug 2005 17:07:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, schwidefsky@de.ibm.com, george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050813113717.GB4550@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508131135.46558.kernel@kolivas.org> <200508131651.08809.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508131651.08809.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 04:51:07PM +1000, Con Kolivas wrote:
> I'm sorry to say this doesn't appear to skip any ticks on my single P4 with 
> SMP/SMT enabled.

Con,
	I had enabled skipping ticks only in default_idle routine. So if
you have a different idle route (which I suspect is the case), it will not
skip ticks (since dyn_tick_reprogram_timer will not be called).
Can you try this patch?


---

 linux-2.6.13-rc6-root/arch/i386/kernel/process.c |    7 ++++---
 linux-2.6.13-rc6-root/kernel/dyn-tick.c          |    8 ++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff -puN kernel/dyn-tick.c~dynamic-tick-smp-fix kernel/dyn-tick.c
--- linux-2.6.13-rc6/kernel/dyn-tick.c~dynamic-tick-smp-fix	2005-08-13 15:53:56.000000000 +0530
+++ linux-2.6.13-rc6-root/kernel/dyn-tick.c	2005-08-13 15:56:12.000000000 +0530
@@ -37,16 +37,18 @@ spinlock_t dyn_tick_lock;
 
 /*
  * Arch independent code needed to reprogram next timer interrupt.
- * Gets called with IRQs disabled from cpu_idle() before entering idle loop.
+ * Gets called from cpu_idle() before entering idle loop.
  */
 unsigned long dyn_tick_reprogram_timer(void)
 {
 	int cpu = smp_processor_id();
-	unsigned long delta;
+	unsigned long delta, flags;
 
 	if (!DYN_TICK_IS_SET(DYN_TICK_ENABLED))
 		return 0;
 
+	local_irq_save(flags);
+
 	if (rcu_pending(cpu) || local_softirq_pending())
 		return 0;
 
@@ -76,6 +78,8 @@ unsigned long dyn_tick_reprogram_timer(v
 
 	write_sequnlock(&xtime_lock);
 
+	local_irq_restore(flags);
+
 	return delta;
 }
 
diff -puN arch/i386/kernel/process.c~dynamic-tick-smp-fix arch/i386/kernel/process.c
--- linux-2.6.13-rc6/arch/i386/kernel/process.c~dynamic-tick-smp-fix	2005-08-13 15:53:56.000000000 +0530
+++ linux-2.6.13-rc6-root/arch/i386/kernel/process.c	2005-08-13 15:55:20.000000000 +0530
@@ -104,10 +104,9 @@ void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		local_irq_disable();
-		if (!need_resched()) {
-			dyn_tick_reprogram_timer();
+		if (!need_resched())
 			safe_halt();
-		} else
+		else
 			local_irq_enable();
 	} else {
 		cpu_relax();
@@ -202,6 +201,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
+			dyn_tick_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
_

I have tested this patch on my Laptop (P4) that HZ goes down to ~25 with
dyn-ticks enabled (but Power consumption goes _up_ as Ted had noted earlier
- I need to try some of the ACPI patches that were pointed out in the thread).

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
