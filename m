Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWJJUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWJJUsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWJJUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:48:36 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:63708 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030337AbWJJUsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:48:35 -0400
Subject: Re: [patch 1/2] round_jiffies infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20061010115652.4ef068bd.akpm@osdl.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	 <1160496210.3000.310.camel@laptopd505.fenrus.org>
	 <20061010115652.4ef068bd.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 22:48:00 +0200
Message-Id: <1160513281.3000.333.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> c'mon Arjan.  If we're going to create new, kernel-wide,
> exported-to-modules infrastructure then it deserves slightly more than zero
> documentation.

ok I had a weak moment; updated patch below
(lightly tested because current 2.6.19-rc1-git6 dies on x86_64 with an
interrupt issue within a few minutes even unpatched on my machines)


From: Arjan van de Ven <arjan@linux.intel.com>
Subject: round_jiffies infrastructure

This patch introduces a round_jiffies() function as well as a
round_jiffies_relative() function. These functions round a jiffies value
to the next whole second. The primary purpose of this rounding is to
cause all "we don't care exactly when" timers to happen at the same
jiffy.
This avoids multiple timers to fire within the second for no real
reason; with dynamic ticks these extra timers cause wakeups from deep
sleep CPU sleep states and thus waste power. 

The exact wakeup moment is skewed by the cpu number, to avoid all
cpus from waking up at the exact same time (and hitting the same 
lock/cachelines there)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>




Index: linux-2.6.19-rc1-git6/include/linux/timer.h
===================================================================
--- linux-2.6.19-rc1-git6.orig/include/linux/timer.h
+++ linux-2.6.19-rc1-git6/include/linux/timer.h
@@ -98,4 +98,10 @@ extern void run_local_timers(void);
 struct hrtimer;
 extern int it_real_fn(struct hrtimer *);
 
+unsigned long __round_jiffies(unsigned long j, int cpu);
+unsigned long __round_jiffies_relative(unsigned long j, int cpu);
+unsigned long round_jiffies(unsigned long j);
+unsigned long round_jiffies_relative(unsigned long j);
+
+
 #endif
Index: linux-2.6.19-rc1-git6/kernel/timer.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/kernel/timer.c
+++ linux-2.6.19-rc1-git6/kernel/timer.c
@@ -80,6 +80,139 @@ tvec_base_t boot_tvec_bases;
 EXPORT_SYMBOL(boot_tvec_bases);
 static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = &boot_tvec_bases;
 
+/**
+ * __round_jiffies - function to round jiffies to a full second
+ * @j: the time in (absolute) jiffies that should be rounded
+ * @cpu: the processor number on which the timeout will happen
+ *
+ * __round_jiffies rounds an absolute time in the future (in jiffies)
+ * up or down to (approximately) full seconds. This is useful for timers
+ * for which the exact time they fire does not matter too much, as long as
+ * they fire approximately every X seconds.
+ *
+ * By rounding these timers to whole seconds, all such timers will fire
+ * at the same time, rather than at various times spread out. The goal
+ * of this is to have the CPU wake up less, which saves power.
+ *
+ * The exact rounding is skewed for each processor to avoid all
+ * processors firing at the exact same time, which could lead
+ * to lock contention or spurious cache line bouncing.
+ *
+ * The return value is the rounded version of the "j" parameter.
+ */
+unsigned long __round_jiffies(unsigned long j, int cpu)
+{
+	int rem;
+	int original  = j;
+
+	/*
+	 * We don't want all cpus firing their timers at once hitting the
+	 * same lock or cachelines, so we skew each extra cpu with an extra
+	 * 3 jiffies. This 3 jiffies came originally from the mm/ code which
+	 * already did this.
+	 * The skew is done by adding 3*cpunr, then round, then subtract this
+	 * extra offset again.
+	 */
+	j += cpu * 3;
+
+	rem = j % HZ;
+
+	/*
+	 * If the target jiffie is just after a whole second (which can happen
+	 * due to delays of the timer irq, long irq off times etc etc) then
+	 * we should round down to the whole second, not up. Use 1/4th second
+	 * as cutoff for this rounding as an extreme upper bound for this.
+	 */
+	if (rem < HZ/4) /* round down */
+		j = j - rem;
+	else /* round up */
+		j = j - rem + HZ;
+
+	/* now that we have rounded, subtract the extra skew again */
+	j -= cpu * 3;
+
+	if (j <= jiffies) /* rounding ate our timeout entirely; */
+		return original;
+	return j;
+}
+EXPORT_SYMBOL_GPL(__round_jiffies);
+
+/**
+ * __round_jiffies_relative - function to round jiffies to a full second
+ * @j: the time in (relative) jiffies that should be rounded
+ * @cpu: the processor number on which the timeout will happen
+ *
+ * __round_jiffies_relative rounds a time delta  in the future (in jiffies)
+ * up or down to (approximately) full seconds. This is useful for timers
+ * for which the exact time they fire does not matter too much, as long as
+ * they fire approximately every X seconds.
+ *
+ * By rounding these timers to whole seconds, all such timers will fire
+ * at the same time, rather than at various times spread out. The goal
+ * of this is to have the CPU wake up less, which saves power.
+ *
+ * The exact rounding is skewed for each processor to avoid all
+ * processors firing at the exact same time, which could lead
+ * to lock contention or spurious cache line bouncing.
+ *
+ * The return value is the rounded version of the "j" parameter.
+ */
+unsigned long __round_jiffies_relative(unsigned long j, int cpu)
+{
+	/*
+	 * In theory the following code can skip a jiffy in case jiffies
+	 * increments right between the addition and the later subtraction.
+	 * However since the entire point of this function is to use approximate
+	 * timeouts, it's entirely ok to not handle that.
+	 */
+	return  __round_jiffies(j + jiffies, cpu) - jiffies;
+}
+EXPORT_SYMBOL_GPL(__round_jiffies_relative);
+
+/**
+ * round_jiffies - function to round jiffies to a full second
+ * @j: the time in (absolute) jiffies that should be rounded
+ *
+ * round_jiffies rounds an absolute time in the future (in jiffies)
+ * up or down to (approximately) full seconds. This is useful for timers
+ * for which the exact time they fire does not matter too much, as long as
+ * they fire approximately every X seconds.
+ *
+ * By rounding these timers to whole seconds, all such timers will fire
+ * at the same time, rather than at various times spread out. The goal
+ * of this is to have the CPU wake up less, which saves power.
+ *
+ * The return value is the rounded version of the "j" parameter.
+ */
+unsigned long round_jiffies(unsigned long j)
+{
+	return __round_jiffies(j, raw_smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(round_jiffies);
+
+/**
+ * round_jiffies_relative - function to round jiffies to a full second
+ * @j: the time in (relative) jiffies that should be rounded
+ *
+ * round_jiffies_relative rounds a time delta  in the future (in jiffies)
+ * up or down to (approximately) full seconds. This is useful for timers
+ * for which the exact time they fire does not matter too much, as long as
+ * they fire approximately every X seconds.
+ *
+ * By rounding these timers to whole seconds, all such timers will fire
+ * at the same time, rather than at various times spread out. The goal
+ * of this is to have the CPU wake up less, which saves power.
+ *
+ * The return value is the rounded version of the "j" parameter.
+ */
+unsigned long round_jiffies_relative(unsigned long j)
+{
+	return __round_jiffies_relative(j, raw_smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(round_jiffies_relative);
+
+
+
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {

