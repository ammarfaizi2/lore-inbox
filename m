Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDEJTu>; Fri, 5 Apr 2002 04:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSDEJTb>; Fri, 5 Apr 2002 04:19:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312417AbSDEJTK>;
	Fri, 5 Apr 2002 04:19:10 -0500
Message-ID: <3CAD6BE2.40ADC2B4@zip.com.au>
Date: Fri, 05 Apr 2002 01:18:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: the oom killer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

Marcelo would prefer that the VM retain the oom killer.  The thinking
is that if try_to_free_pages fails, then we're better off making a
deliberate selection of the process to kill rather than the random(ish)
selection which we make by failing the allocation.

One example is at

http://marc.theaimsgroup.com/?l=linux-kernel&m=101405688319160&w=2

That failure was with vm-24, which I think had the less aggressive
i/dcache shrink code.  We do need to robustly handle the no-swap-left
situation.

So I have resurrected the oom killer.  The patch is below.

During testing of this, a problem cropped up.  The machine has 64 megs
of memory, no swap.  The workload consisted of running `make -j0
bzImage' in parallel with `usemem 40'.  usemem will malloc a 40
megabyte chunk, memset it and exit.

The kernel livelocked.  What appeared to be happening was that ZONE_DMA
was short on free pages, but ZONE_NORMAL was not.  So this check:

	if (!check_classzone_need_balance(classzone))
        	break;

in try_to_free_pages() was seeing that ZONE_NORMAL had some headroom
and was causing a return to __alloc_pages().

__alloc_pages has this logic:

	min = 1UL << order;
	for (;;) {
		zone_t *z = *(zone++);
		if (!z)
			break;

		min += z->pages_min;
		if (z->free_pages > min) {
			page = rmqueue(z, order);
			if (page)
				return page;
		}
	}


On the first pass through this loop, `min' gets the value
zone_dma.pages_min + 1.  On the second pass through the loop it gets
the value zone_dma.pages_min + 1 + zone_normal.pages_min.  And this is
greater than zone_normal.free_pages! So alloc_pages() gets stuck in an
infinite loop.

This logic surrounding `min' is pretty weird - it's repeated several
times in __alloc_pages.  Is it correct?  What is it intended to do?

Anyway.  "fixing" the `min' logic in that part of __alloc_pages()
prevented the lockup.  The page allocator successfully takes a page
from ZONE_NORMAL (as check_classzone_need_balance() said it could) and
returns.

I have incorporated the oom killer into try_to_free_pages(), along with
a tunable which defines how hard we work before killing something.  It
is *extremely* conservative.  As it should be.  The VM will spin madly
for five or ten seconds before giving up and calling the oom killer. 
And then another five seconds elapses before the oom killer decides to
actually kill something.  It works.

Some adjustments have been made to the oom killer to make really sure
that it doesn't kill init, and to not bother looking at processes which
have called daemonize().

Your comments would be appreciated, thanks.

The entire patch series is at

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre6/aa1/


--- 2.4.19-pre6/mm/oom_kill.c~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/mm/oom_kill.c	Fri Apr  5 01:08:14 2002
@@ -21,8 +21,6 @@
 #include <linux/swapctl.h>
 #include <linux/timex.h>
 
-#if 0		/* Nothing in this file is used */
-
 /* #define DEBUG */
 
 /**
@@ -125,7 +123,10 @@ static struct task_struct * select_bad_p
 
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
-		if (p->pid) {
+		/*
+		 * Don't kill init, swapper or kernel threads
+		 */
+		if (p->pid > 1 && p->mm) {
 			int points = badness(p);
 			if (points > maxpoints) {
 				chosen = p;
@@ -141,8 +142,9 @@ static struct task_struct * select_bad_p
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
+ * Returns true if the caller has committed suicide.
  */
-void oom_kill_task(struct task_struct *p)
+int oom_kill_task(struct task_struct *p)
 {
 	printk(KERN_ERR "Out of Memory: Process %d (%s) "
 			"killed process %d (%s).\n",
@@ -163,6 +165,7 @@ void oom_kill_task(struct task_struct *p
 	} else {
 		force_sig(SIGKILL, p);
 	}
+	return p == current;
 }
 
 /**
@@ -173,9 +176,10 @@ void oom_kill_task(struct task_struct *p
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
  */
-static void oom_kill(void)
+static int oom_kill(void)
 {
 	struct task_struct *p = select_bad_process(), *q;
+	int ret = 0;
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (p == NULL)
@@ -184,7 +188,8 @@ static void oom_kill(void)
 	/* kill all processes that share the ->mm (i.e. all threads) */
 	read_lock(&tasklist_lock);
 	for_each_task(q) {
-		if(q->mm == p->mm) oom_kill_task(q);
+		if(q->mm == p->mm)
+			ret |= oom_kill_task(q);
 	}
 	read_unlock(&tasklist_lock);
 
@@ -195,22 +200,23 @@ static void oom_kill(void)
 	 */
 	current->policy |= SCHED_YIELD;
 	schedule();
-	return;
+	return ret;
 }
 
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+int out_of_memory(void)
 {
 	static unsigned long first, last, count;
 	unsigned long now, since;
+	int ret = 0;
 
 	/*
 	 * Enough swap space left?  Not OOM.
 	 */
 	if (nr_swap_pages > 0)
-		return;
+		goto out;
 
 	now = jiffies;
 	since = now - last;
@@ -230,23 +236,24 @@ void out_of_memory(void)
 	 */
 	since = now - first;
 	if (since < HZ)
-		return;
+		goto out;;
 
 	/*
 	 * If we have gotten only a few failures,
 	 * we're not really oom. 
 	 */
 	if (++count < 10)
-		return;
+		goto out;
 
 	/*
 	 * Ok, really out of memory. Kill something.
 	 */
-	oom_kill();
+	ret = oom_kill();
 
 reset:
 	first = now;
 	count = 0;
+out:
+	return ret;
 }
 
-#endif	/* Unused file */
--- 2.4.19-pre6/mm/vmscan.c~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/mm/vmscan.c	Fri Apr  5 01:08:11 2002
@@ -62,6 +62,14 @@ int vm_lru_balance_ratio = 2;
 int vm_vfs_scan_ratio = 6;
 
 /*
+ * "vm_oom_kill_passes" specifies how hard the VM will try to reclaim
+ * memory before it gives up, and invokes the out-of-memory killer.
+ * Higher values of vm_oom_kill_passes will make the VM more reluctant
+ * to kill a process.
+ */
+int vm_oom_kill_passes = 3;
+
+/*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
  * It returns zero if it couldn't do anything,
@@ -623,6 +631,8 @@ static int check_classzone_need_balance(
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
+	int pass = 0;
+
 	gfp_mask = pf_gfp_mask(gfp_mask);
 
 	for (;;) {
@@ -645,15 +655,22 @@ int try_to_free_pages(zone_t *classzone,
 				failed_swapout = !swap_out(classzone);
 		} while (--tries);
 
-		if (likely(current->pid != 1))
-			break;
 		if (!check_classzone_need_balance(classzone))
 			break;
 		current->policy |= SCHED_YIELD;
 		__set_current_state(TASK_RUNNING);
 		schedule();
+		if (pass++ >= vm_oom_kill_passes) {
+			if (out_of_memory())
+				goto killed_self;
+			/* Where's yield()? */
+			current->policy |= SCHED_YIELD;
+			__set_current_state(TASK_RUNNING);
+			schedule();
+			pass = 0;
+		}
 	}
-
+killed_self:
 	return 0;
 }
 
--- 2.4.19-pre6/include/linux/sysctl.h~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/include/linux/sysctl.h	Fri Apr  5 01:07:54 2002
@@ -149,6 +149,7 @@ enum
 	VM_GFP_DEBUG=17,	/* debug GFP failures */
 	VM_CACHE_SCAN_RATIO=18,	/* part of the inactive cache list to scan */
 	VM_MAPPED_RATIO=19,	/* amount of unfreeable pages that triggers swapout */
+	VM_OOM_KILL_PASSES=20,	/* Number of try_to_free_pages loops before oomkill */
 };
 
 
--- 2.4.19-pre6/kernel/sysctl.c~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/kernel/sysctl.c	Fri Apr  5 01:07:54 2002
@@ -31,6 +31,7 @@
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
 #include <linux/swap.h>
+#include <linux/mm.h>
 
 #include <asm/uaccess.h>
 
@@ -290,6 +291,8 @@ static ctl_table vm_table[] = {
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_MAP_COUNT, "max_map_count",
 	 &max_map_count, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_OOM_KILL_PASSES, "oom_kill_passes",
+	 &vm_oom_kill_passes, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
--- 2.4.19-pre6/include/linux/mm.h~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/include/linux/mm.h	Fri Apr  5 01:08:14 2002
@@ -116,6 +116,9 @@ struct vm_area_struct {
 extern int vm_min_readahead;
 extern int vm_max_readahead;
 
+/* oom killer threshold */
+extern int vm_oom_kill_passes;
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
--- 2.4.19-pre6/mm/page_alloc.c~aa-122-oom_kill	Fri Apr  5 01:07:54 2002
+++ 2.4.19-pre6-akpm/mm/page_alloc.c	Fri Apr  5 01:08:14 2002
@@ -411,13 +411,12 @@ rebalance:
 		return page;
 
 	zone = zonelist->zones;
-	min = 1UL << order;
 	for (;;) {
 		zone_t *z = *(zone++);
 		if (!z)
 			break;
 
-		min += z->pages_min;
+		min = (1UL << order) + z->pages_min;
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
 			if (page)

-
