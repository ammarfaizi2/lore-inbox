Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWFBIbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWFBIbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFBIbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:31:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:10893 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751323AbWFBIbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:31:23 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45890096:sNHT25014465"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>
Cc: "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 01:31:23 -0700
Message-ID: <000101c6861e$eeb46b20$0b4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaF+GieWKnv9uneRk+Hdw+4ab8WGAAJbB3Q
In-Reply-To: <200606021355.23671.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Thursday, June 01, 2006 8:55 PM
> On Friday 02 June 2006 12:28, Con Kolivas wrote:
> > Actually looking even further, we only introduced the extra lookup of the
> > next task when we started unlocking the runqueue in schedule(). Since we
> > can get by without locking this_rq in schedule with this approach we can
> > simplify dependent_sleeper even further by doing the dependent sleeper
> > check after we have discovered what next is in schedule and avoid looking
> > it up twice. I'll hack something up to do that soon.
> 
> Something like this (sorry I couldn't help but keep hacking on it).
> ---
> It is not critical to functioning that dependent_sleeper() succeeds every
> time. We can significantly reduce the locking overhead and contention of
> dependent_sleeper by only doing trylock on the smt sibling runqueues. As
> we're only doing trylock it means we do not need to observe the normal
> locking order and we can get away without unlocking this_rq in schedule().
> This provides us with an opportunity to simplify the code further.


The code in wake_sleeping_dependent() is also quite wacky: it unlocks
current runqueue, then re-acquires ALL the sibling runqueue lock, only
to call wakeup_busy_runqueue() against the smt sibling runqueue other
than itself.  AFAICT, wakeup_busy_runqueue() does not require *ALL*
sibling lock to be held.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-06-02 01:57:28.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 02:19:37.000000000 -0700
@@ -2712,44 +2712,32 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
-static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static void wake_sleeping_dependent(int this_cpu)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
 	int i;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
+			break;
+		}
 
 	if (!sd)
 		return;
 
-	/*
-	 * Unlock the current runqueue because we have to lock in
-	 * CPU order to avoid deadlocks. Caller knows that we might
-	 * unlock. We keep IRQs disabled.
-	 */
-	spin_unlock(&this_rq->lock);
-
-	sibling_map = sd->span;
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	/*
-	 * We clear this CPU from the mask. This both simplifies the
-	 * inner loop and keps this_rq locked when we exit:
-	 */
-	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sd->span) {
+		runqueue_t *smt_rq;
 
-	for_each_cpu_mask(i, sibling_map) {
-		runqueue_t *smt_rq = cpu_rq(i);
+		if (i == this_cpu)
+			continue;
 
+		smt_rq = cpu_rq(i);
+		spin_lock(&smt_rq->lock);
 		wakeup_busy_runqueue(smt_rq);
+		spin_unlock(&smt_rq->lock);
 	}
 
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
 	/*
 	 * We exit with this_cpu's rq still held and IRQs
 	 * still disabled:
@@ -2857,7 +2845,7 @@ check_smt_task:
 	return ret;
 }
 #else
-static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static inline void wake_sleeping_dependent(int this_cpu)
 {
 }
 
@@ -2988,14 +2976,8 @@ need_resched_nonpreemptible:
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
-			wake_sleeping_dependent(cpu, rq);
-			/*
-			 * wake_sleeping_dependent() might have released
-			 * the runqueue, so break out if we got new
-			 * tasks meanwhile:
-			 */
-			if (!rq->nr_running)
-				goto switch_tasks;
+			wake_sleeping_dependent(cpu);
+			goto switch_tasks;
 		}
 	}
 
