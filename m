Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVGGAXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGGAXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVGFUDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:03:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47603 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262436AbVGFRcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:32:14 -0400
Date: Wed, 6 Jul 2005 23:01:34 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050706173134.GA24636@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au> <20050630124711.GC17928@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630124711.GC17928@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 06:17:11PM +0530, Srivatsa Vaddagiri wrote:
> Digging further revealed that this max time was restricted by 
> various timers kernel uses. Mostly it was found to be because of
> the slab allocator reap timer (it requests a timer every ~2sec on
> every CPU) and machine_check timer (MCE_RATE in arch/i386/kernel/cpu/mcheck/
> non-fatal.c ).

I modified the slab allocator to do a slightly better job of handling timers.
(instead of blindly increasing the reap timeout to 20 sec as I did in my last 
run).  The patch below is merely a hack meant to see what kind of benefits we 
can possibly hope to get by reworking the reap timer.  A good solution would 
probably increase/decrease the reap periods based on memory pressure and 
idleness of the system. Anyway the patch I tried out is:


---

 linux-2.6.13-rc1-root/mm/slab.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff -puN mm/slab.c~vst-slab mm/slab.c
--- linux-2.6.13-rc1/mm/slab.c~vst-slab	2005-07-05 16:36:03.000000000 +0530
+++ linux-2.6.13-rc1-root/mm/slab.c	2005-07-06 18:01:28.000000000 +0530
@@ -371,6 +371,8 @@ struct kmem_cache_s {
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
 #define REAPTIMEOUT_LIST3	(4*HZ)
+#define MAX_REAP_TIMEOUT	(30*HZ)
+#define MAX_DRAIN_COUNT		2
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -569,6 +571,7 @@ static enum {
 } g_cpucache_up;
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
+static DEFINE_PER_CPU(unsigned long, last_timeout);
 
 static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
@@ -883,8 +886,10 @@ static int __init cpucache_init(void)
 	 * pages to gfp.
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
+			per_cpu(last_timeout, cpu) = REAPTIMEOUT_CPUC + cpu;
 			start_cpu_timer(cpu);
+		}
 	}
 
 	return 0;
@@ -1543,7 +1548,7 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void drain_array_locked(kmem_cache_t* cachep,
+static int drain_array_locked(kmem_cache_t* cachep,
 				struct array_cache *ac, int force);
 
 static void do_drain(void *arg)
@@ -2753,10 +2758,10 @@ static void enable_cpucache(kmem_cache_t
 					cachep->name, -err);
 }
 
-static void drain_array_locked(kmem_cache_t *cachep,
+static int drain_array_locked(kmem_cache_t *cachep,
 				struct array_cache *ac, int force)
 {
-	int tofree;
+	int tofree = 1;
 
 	check_spinlock_acquired(cachep);
 	if (ac->touched && !force) {
@@ -2771,6 +2776,8 @@ static void drain_array_locked(kmem_cach
 		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
 					sizeof(void*)*ac->avail);
 	}
+
+	return tofree;
 }
 
 /**
@@ -2787,17 +2794,20 @@ static void drain_array_locked(kmem_cach
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
+	int drain_count = 0, freed_slab_count = 0;
+	unsigned long timeout = __get_cpu_var(last_timeout);
+	int cpu = smp_processor_id();
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+		schedule_delayed_work(&__get_cpu_var(reap_work), timeout);
 		return;
 	}
 
 	list_for_each(walk, &cache_chain) {
 		kmem_cache_t *searchp;
 		struct list_head* p;
-		int tofree;
+		int tofree, count;
 		struct slab *slabp;
 
 		searchp = list_entry(walk, kmem_cache_t, next);
@@ -2809,7 +2819,9 @@ static void cache_reap(void *unused)
 
 		spin_lock_irq(&searchp->spinlock);
 
-		drain_array_locked(searchp, ac_data(searchp), 0);
+		count = drain_array_locked(searchp, ac_data(searchp), 0);
+		if (count > drain_count)
+			drain_count = count;
 
 		if(time_after(searchp->lists.next_reap, jiffies))
 			goto next_unlock;
@@ -2825,6 +2837,9 @@ static void cache_reap(void *unused)
 		}
 
 		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
+		if (tofree > freed_slab_count)
+			freed_slab_count = tofree;
+
 		do {
 			p = list3_data(searchp)->slabs_free.next;
 			if (p == &(list3_data(searchp)->slabs_free))
@@ -2854,7 +2869,16 @@ next:
 	up(&cache_chain_sem);
 	drain_remote_pages();
 	/* Setup the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+#ifdef CONFIG_NO_IDLE_HZ
+	if (drain_count < MAX_DRAIN_COUNT && !freed_slab_count) {
+		if (timeout * 2 < MAX_REAP_TIMEOUT)
+			timeout *= 2;
+	} else
+#endif
+		timeout = REAPTIMEOUT_CPUC + cpu;
+
+	__get_cpu_var(last_timeout) = timeout;
+	schedule_delayed_work(&__get_cpu_var(reap_work), timeout);
 }
 
 #ifdef CONFIG_PROC_FS
_

The results with this patch on a 8way Intel box are:

CPU#   # of       Mean          Std Dev     Max                 Min
       samples


1:      31       4124.742     4331.914      14317.000          0.000
2:      35       3603.600     3792.050      12556.000         14.000
3:    2585         49.458        4.207         50.000          2.000
4:     151        847.682      329.343       1139.000         15.000
5:      23       5432.652     3461.856      12024.000        120.000
6:      19       6229.158     5641.813      15000.000        169.000
7:      67       1865.672     1528.343       5000.000         19.000


Note that the best average is around ~6sec (with max being 15 sec).

Given, this do you still advocate that we restrict idle CPUs to wakeup
every 100ms and check for imbalance? IMO, we should let them sleep
much longer (few seconds) ..What are the consequences on load balancing
if idle CPUs sleep that long? Does it mean that system can remain unresponsive
for few seconds under some circumstances (when there is a burst of activity and
at that time idle CPUs are sleeping)?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
