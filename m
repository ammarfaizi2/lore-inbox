Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWJBSlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWJBSlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWJBSlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:41:23 -0400
Received: from www.osadl.org ([213.239.205.134]:14785 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964796AbWJBSlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:41:23 -0400
Subject: [patch] dynticks core: Fix idle time accounting
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
	 <1159796582.1386.9.camel@localhost.localdomain>
	 <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 20:43:26 +0200
Message-Id: <1159814606.1386.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 14:25 -0400, Valdis.Kletnieks@vt.edu wrote:
> > > I'm also seeing gkrellm reporting about 25% CPU use when "near-idle" (X is up
> > > but not much is going on) when that's usually down around 5-6%.  I need to
> > > collect some oprofile numbers and investigate that as well.
> >
> > I look into the accounting fixups again.
> I still need to get oprofile runs of this and see what's going on.

The patch below fixes the accounting weirdness.

	tglx

----------------->
Subject: dynticks core: Fix idle time accounting
From: Thomas Gleixner <tglx@linutronix,de>

The extended sleeps during idle must be accounted to the idle thread.
The original accounting fixup was too naive. The time must be accounted
when the idle thread is interrupted and the jiffies update code has
forwarded jiffies. Otherwise the accounting is done on random targets.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--

 kernel/hrtimer.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-10-02 19:22:14.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-10-02 19:22:14.000000000 +0200
@@ -44,6 +44,7 @@
 #include <linux/profile.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/uaccess.h>
 
@@ -447,10 +448,11 @@ static const ktime_t nsec_per_hz = { .tv
  * want to wake up a complete idle cpu just to update jiffies, so we need
  * something more intellegent than a mere "do this only on CPUx".
  */
-static void update_jiffies64(ktime_t now)
+static unsigned long update_jiffies64(ktime_t now)
 {
 	unsigned long seq;
 	ktime_t delta;
+	unsigned long ticks = 0;
 
 	/* Preevaluate to avoid lock contention */
 	do {
@@ -459,14 +461,13 @@ static void update_jiffies64(ktime_t now
 	} while (read_seqretry(&xtime_lock, seq));
 
 	if (delta.tv64 < nsec_per_hz.tv64)
-		return;
+		return 0;
 
 	/* Reevalute with xtime_lock held */
 	write_seqlock(&xtime_lock);
 
 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta.tv64 >= nsec_per_hz.tv64) {
-		unsigned long ticks = 1;
 
 		delta = ktime_sub(delta, nsec_per_hz);
 		last_jiffies_update = ktime_add(last_jiffies_update,
@@ -480,11 +481,13 @@ static void update_jiffies64(ktime_t now
 
 			last_jiffies_update = ktime_add_ns(last_jiffies_update,
 							   incr * ticks);
-			ticks++;
 		}
+		ticks++;
 		do_timer(ticks);
 	}
 	write_sequnlock(&xtime_lock);
+
+	return ticks;
 }
 
 #ifdef CONFIG_NO_HZ
@@ -500,7 +503,7 @@ static void update_jiffies64(ktime_t now
 void hrtimer_update_jiffies(void)
 {
 	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
-	unsigned long flags;
+	unsigned long flags, ticks;
 	ktime_t now;
 
 	if (!cpu_base->tick_stopped || !cpu_base->hres_active)
@@ -509,7 +512,17 @@ void hrtimer_update_jiffies(void)
 	now = ktime_get();
 
 	local_irq_save(flags);
-	update_jiffies64(now);
+	ticks = update_jiffies64(now);
+	if (ticks) {
+		/*
+		 * We stopped the tick in idle and this function got called to
+		 * update jiffies. Update process times would randomly account
+		 * the time we slept to whatever the context of the next sched
+		 * tick is. Enforce that this is accounted to idle !
+		 */
+		account_system_time(current, HARDIRQ_OFFSET,
+				    jiffies_to_cputime(ticks));
+	}
 	local_irq_restore(flags);
 }
 
@@ -604,15 +617,6 @@ void hrtimer_restart_sched_tick(void)
 	local_irq_disable();
 	update_jiffies64(now);
 
-	/*
-	 * Update process times would randomly account the time we slept to
-	 * whatever the context of the next sched tick is.  Enforce that this
-	 * is accounted to idle !
-	 */
-	add_preempt_count(HARDIRQ_OFFSET);
-	update_process_times(0);
-	sub_preempt_count(HARDIRQ_OFFSET);
-
 	/* Account the idle time */
 	delta = ktime_sub(now, cpu_base->idle_entrytime);
 	cpu_base->idle_sleeptime = ktime_add(cpu_base->idle_sleeptime, delta);


