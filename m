Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967246AbWKZDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967246AbWKZDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967248AbWKZDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 22:01:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967246AbWKZDBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 22:01:07 -0500
Date: Sat, 25 Nov 2006 22:00:45 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Larry Woodman <lwoodman@redhat.com>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-ID: <20061126030045.GA29656@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>,
	Larry Woodman <lwoodman@redhat.com>
References: <4568AFB1.3050500@mbligh.org> <20061125132828.16a01762.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125132828.16a01762.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 01:28:28PM -0800, Andrew Morton wrote:
 > On Sat, 25 Nov 2006 13:03:45 -0800
 > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
 > 
 > > On 2.6.18-rc7 and later during LTP:
 > > http://test.kernel.org/abat/48393/debug/console.log
 > 
 > The traces are a bit confusing, but I don't actually see anything wrong
 > there.  The machine has used up all swap, has used up all memory and has
 > correctly gone and killed things.  After that, there's free memory again.

We covered this a month or two back.  For RHEL5, we've ended up
reintroducing the oom killer prevention logic that we had up until
circa 2.6.10.   It seemed that there exist circumstances where
given a little more time, some memory hogging apps will run to completion
allowing other allocators to succeed instead of being killed.

For reference, here's the patch that Larry Woodman came up with
for RHEL5.  The 'rhts' test suite that is mentioned below was
actually failing when it got to LTP iirc, which matches Martins experience.

		Dave


Dave, this patch includes the upstream OOM kill changes so that RHEL5 is 
in sync
with the latest 2.6.19 kernel, as well as the out_of_memory() change so 
that it must
be called more than 10 times within a 5 second window before it actually 
kills a
process.  I think this gives us the best of everything, we have all the 
upstream code
plus one small change that gets us to pass the RHTS test suite.

--- linux-2.6.18.noarch/mm/oom_kill.c.larry
+++ linux-2.6.18.noarch/mm/oom_kill.c
@@ -58,6 +58,12 @@ unsigned long badness(struct task_struct
 	}
 
 	/*
+	 * swapoff can easily use up all memory, so kill those first.
+	 */
+	if (p->flags & PF_SWAPOFF)
+		return ULONG_MAX;
+
+	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = mm->total_vm;
@@ -127,6 +133,14 @@ unsigned long badness(struct task_struct
 		points /= 4;
 
 	/*
+	 * If p's nodes don't overlap ours, it may still help to kill p
+	 * because p may have allocated or otherwise mapped memory on
+	 * this node before. However it will be less likely.
+	 */
+	if (!cpuset_excl_nodes_overlap(p))
+		points /= 8;
+
+	/*
 	 * Adjust the score by oomkilladj.
 	 */
 	if (p->oomkilladj) {
@@ -191,25 +205,38 @@ static struct task_struct *select_bad_pr
 		unsigned long points;
 		int releasing;
 
+		/* skip kernel threads */
+		if (!p->mm)
+			continue;
+
 		/* skip the init task with pid == 1 */
 		if (p->pid == 1)
 			continue;
-		if (p->oomkilladj == OOM_DISABLE)
-			continue;
-		/* If p's nodes don't overlap ours, it won't help to kill p. */
-		if (!cpuset_excl_nodes_overlap(p))
-			continue;
-
 		/*
 		 * This is in the process of releasing memory so wait for it
 		 * to finish before killing some other task by mistake.
+		 *
+		 * However, if p is the current task, we allow the 'kill' to
+		 * go ahead if it is exiting: this will simply set TIF_MEMDIE,
+		 * which will allow it to gain access to memory reserves in
+		 * the process of exiting and releasing its resources.
+		 * Otherwise we could get an OOM deadlock.
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && !(p->flags & PF_DEAD))
+		if (releasing) {
+			/* PF_DEAD tasks have already released their mm */
+			if (p->flags & PF_DEAD)
+				continue;
+			if (p->flags & PF_EXITING && p == current) {
+				chosen = p;
+				*ppoints = ULONG_MAX;
+				break;
+			}
 			return ERR_PTR(-1UL);
-		if (p->flags & PF_SWAPOFF)
-			return p;
+		}
+		if (p->oomkilladj == OOM_DISABLE)
+			continue;
 
 		points = badness(p, uptime.tv_sec);
 		if (points > *ppoints || !chosen) {
@@ -241,7 +268,8 @@ static void __oom_kill_task(struct task_
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "%s: Killed process %d (%s).\n",
+	if (message) 
+		printk(KERN_ERR "%s: Killed process %d (%s).\n",
 				message, p->pid, p->comm);
 
 	/*
@@ -293,8 +321,15 @@ static int oom_kill_process(struct task_
 	struct task_struct *c;
 	struct list_head *tsk;
 
-	printk(KERN_ERR "Out of Memory: Kill process %d (%s) score %li and "
-		"children.\n", p->pid, p->comm, points);
+	/*
+	 * If the task is already exiting, don't alarm the sysadmin or kill
+	 * its children or threads, just set TIF_MEMDIE so it can die quickly
+	 */
+	if (p->flags & PF_EXITING) {
+		__oom_kill_task(p, NULL);
+		return 0;
+	}
+
 	/* Try to kill a child first */
 	list_for_each(tsk, &p->children) {
 		c = list_entry(tsk, struct task_struct, sibling);
@@ -306,6 +341,69 @@ static int oom_kill_process(struct task_
 	return oom_kill_task(p, message);
 }
 
+int should_oom_kill(void)
+{
+	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long first, last, count, lastkill;
+	unsigned long now, since;
+	int ret = 0;
+
+	spin_lock(&oom_lock);
+	now = jiffies;
+	since = now - last;
+	last = now;
+
+	/*
+	 * If it's been a long time since last failure,
+	 * we're not oom.
+	 */
+	if (since > 5*HZ)
+		goto reset;
+
+	/*
+	 * If we haven't tried for at least one second,
+	 * we're not really oom.
+	 */
+	since = now - first;
+	if (since < HZ)
+		goto out_unlock;
+
+	/*
+	 * If we have gotten only a few failures,
+	 * we're not really oom.
+	 */
+	if (++count < 10)
+		goto out_unlock;
+
+	/*
+	 * If we just killed a process, wait a while
+	 * to give that task a chance to exit. This
+	 * avoids killing multiple processes needlessly.
+	 */
+	since = now - lastkill;
+	if (since < HZ*5)
+		goto out_unlock;
+
+	/*
+	 * Ok, really out of memory. Kill something.
+	 */
+	lastkill = now;
+	ret = 1;
+
+reset:
+/*
+ * We dropped the lock above, so check to be sure the variable
+ * first only ever increases to prevent false OOM's.
+ */
+	if (time_after(now, first))
+		first = now;
+	count = 0;
+
+out_unlock:
+	spin_unlock(&oom_lock);
+	return ret;
+}
+
 /**
  * out_of_memory - kill the "best" process when we run out of memory
  *
@@ -320,12 +418,16 @@ void out_of_memory(struct zonelist *zone
 	unsigned long points = 0;
 
 	if (printk_ratelimit()) {
-		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
-			gfp_mask, order);
+		printk(KERN_WARNING "%s invoked oom-killer: "
+		"gfp_mask=0x%x, order=%d, oomkilladj=%d\n",
+		current->comm, gfp_mask, order, current->oomkilladj);
 		dump_stack();
 		show_mem();
 	}
 
+	if (!should_oom_kill())
+		return;
+
 	cpuset_lock();
 	read_lock(&tasklist_lock);
 
--- linux-2.6.18.noarch/mm/vmscan.c.larry
+++ linux-2.6.18.noarch/mm/vmscan.c
@@ -62,6 +62,8 @@ struct scan_control {
 	int swap_cluster_max;
 
 	int swappiness;
+
+	int all_unreclaimable;
 };
 
 /*
@@ -695,6 +697,11 @@ done:
 	return nr_reclaimed;
 }
 
+static inline int zone_is_near_oom(struct zone *zone)
+{
+	return zone->pages_scanned >= (zone->nr_active + zone->nr_inactive)*3;
+}
+
 /*
  * This moves pages from the active list to the inactive list.
  *
@@ -730,6 +737,9 @@ static void shrink_active_list(unsigned 
 		long distress;
 		long swap_tendency;
 
+		if (zone_is_near_oom(zone))
+			goto force_reclaim_mapped;
+
 		/*
 		 * `distress' is a measure of how much trouble we're having
 		 * reclaiming pages.  0 -> no problems.  100 -> great trouble.
@@ -765,6 +775,7 @@ static void shrink_active_list(unsigned 
 		 * memory onto the inactive list.
 		 */
 		if (swap_tendency >= 100)
+force_reclaim_mapped:
 			reclaim_mapped = 1;
 	}
 
@@ -925,6 +936,7 @@ static unsigned long shrink_zones(int pr
 	unsigned long nr_reclaimed = 0;
 	int i;
 
+	sc->all_unreclaimable = 1;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
@@ -941,6 +953,8 @@ static unsigned long shrink_zones(int pr
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
+		sc->all_unreclaimable = 0;
+
 		nr_reclaimed += shrink_zone(priority, zone, sc);
 	}
 	return nr_reclaimed;
@@ -1021,6 +1035,10 @@ unsigned long try_to_free_pages(struct z
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
+	/* top priority shrink_caches still had more to do? don't OOM, then */
+	if (!sc.all_unreclaimable || nr_reclaimed)
+		ret = 1;
+
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
@@ -1153,7 +1171,7 @@ scan:
 			if (zone->all_unreclaimable)
 				continue;
 			if (nr_slab == 0 && zone->pages_scanned >=
-				    (zone->nr_active + zone->nr_inactive) * 4)
+				    (zone->nr_active + zone->nr_inactive) * 6)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and

-- 
http://www.codemonkey.org.uk
