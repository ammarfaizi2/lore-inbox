Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbULBDgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbULBDgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 22:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbULBDgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 22:36:52 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:33440 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261547AbULBDgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 22:36:37 -0500
Date: Thu, 2 Dec 2004 04:36:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202033619.GA32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101938767.13353.62.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please test this? Perhaps it won't be as effective as the
hacks I nuked, but it fixed basic things for me in a quick test so I
like it more. It's important to use pages_high to avoid livelocks.

Thanks.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

Index: x/mm/oom_kill.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/oom_kill.c,v
retrieving revision 1.31
diff -u -p -r1.31 oom_kill.c
--- x/mm/oom_kill.c	14 Oct 2004 04:27:49 -0000	1.31
+++ x/mm/oom_kill.c	2 Dec 2004 03:34:05 -0000
@@ -229,72 +229,8 @@ retry:
  */
 void out_of_memory(int gfp_mask)
 {
-	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
-	 */
-	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
-	static unsigned long first, last, count, lastkill;
-	unsigned long now, since;
-
-	spin_lock(&oom_lock);
-	now = jiffies;
-	since = now - last;
-	last = now;
-
-	/*
-	 * If it's been a long time since last failure,
-	 * we're not oom.
-	 */
-	if (since > 5*HZ)
-		goto reset;
-
-	/*
-	 * If we haven't tried for at least one second,
-	 * we're not really oom.
-	 */
-	since = now - first;
-	if (since < HZ)
-		goto out_unlock;
-
-	/*
-	 * If we have gotten only a few failures,
-	 * we're not really oom. 
-	 */
-	if (++count < 10)
-		goto out_unlock;
-
-	/*
-	 * If we just killed a process, wait a while
-	 * to give that task a chance to exit. This
-	 * avoids killing multiple processes needlessly.
-	 */
-	since = now - lastkill;
-	if (since < HZ*5)
-		goto out_unlock;
-
-	/*
-	 * Ok, really out of memory. Kill something.
-	 */
-	lastkill = now;
-
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
+	dump_stack();
 	oom_kill();
-	spin_lock(&oom_lock);
-
-reset:
-	/*
-	 * We dropped the lock above, so check to be sure the variable
-	 * first only ever increases to prevent false OOM's.
-	 */
-	if (time_after(now, first))
-		first = now;
-	count = 0;
-
-out_unlock:
-	spin_unlock(&oom_lock);
 }
Index: x/mm/page_alloc.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/page_alloc.c,v
retrieving revision 1.236
diff -u -p -r1.236 page_alloc.c
--- x/mm/page_alloc.c	16 Nov 2004 03:53:53 -0000	1.236
+++ x/mm/page_alloc.c	2 Dec 2004 02:21:18 -0000
@@ -611,6 +611,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	int did_some_progress;
 
 	might_sleep_if(wait);
 
@@ -686,18 +687,19 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	try_to_free_pages(zones, gfp_mask, order);
+	did_some_progress = try_to_free_pages(zones, gfp_mask, order);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
-	/* go through the zonelist yet one more time */
+	/*
+	 * Go through the zonelist yet one more time, keep
+	 * very high watermark here, this is only to catch
+	 * a parallel oom killing, we must fail if we're still
+	 * under heavy pressure.
+	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
+		min = z->pages_high;
 		min += (1<<order) + z->protection[alloc_type];
 
 		if (z->free_pages < min)
@@ -708,6 +710,9 @@ rebalance:
 			goto got_pg;
 	}
 
+	if (unlikely(!did_some_progress) && (gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
+		out_of_memory(gfp_mask);
+
 	/*
 	 * Don't let big-order allocations loop unless the caller explicitly
 	 * requests that.  Wait for some write requests to complete then retry.
Index: x/mm/vmscan.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/vmscan.c,v
retrieving revision 1.225
diff -u -p -r1.225 vmscan.c
--- x/mm/vmscan.c	19 Nov 2004 22:54:22 -0000	1.225
+++ x/mm/vmscan.c	2 Dec 2004 01:56:50 -0000
@@ -935,8 +935,6 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
