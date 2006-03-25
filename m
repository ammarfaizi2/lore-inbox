Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWCYE3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWCYE3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWCYE2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:5821 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750822AbWCYE2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:14 -0500
Date: Fri, 24 Mar 2006 20:27:51 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mingo@elte.hu, anton@samba.org,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/20] fix scheduler deadlock
Message-ID: <20060325042751.GR21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-scheduler-deadlock.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Anton Blanchard <anton@samba.org>

We have noticed lockups during boot when stress testing kexec on ppc64. 
Two cpus would deadlock in scheduler code trying to grab already taken
spinlocks.

The double_rq_lock code uses the address of the runqueue to order the
taking of multiple locks.  This address is a per cpu variable:

	if (rq1 < rq2) {
		spin_lock(&rq1->lock);
		spin_lock(&rq2->lock);
	} else {
		spin_lock(&rq2->lock);
		spin_lock(&rq1->lock);
	}

On the other hand, the code in wake_sleeping_dependent uses the cpu id
order to grab locks:

	for_each_cpu_mask(i, sibling_map)
		spin_lock(&cpu_rq(i)->lock);

This means we rely on the address of per cpu data increasing as cpu ids
increase.  While this will be true for the generic percpu implementation it
may not be true for arch specific implementations.

One way to solve this is to always take runqueues in cpu id order. To do
this we add a cpu variable to the runqueue and check it in the
double runqueue locking functions.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 kernel/sched.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- linux-2.6.16.orig/kernel/sched.c
+++ linux-2.6.16/kernel/sched.c
@@ -237,6 +237,7 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
+	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1660,6 +1661,9 @@ unsigned long nr_iowait(void)
 /*
  * double_rq_lock - safely lock two runqueues
  *
+ * We must take them in cpu order to match code in
+ * dependent_sleeper and wake_dependent_sleeper.
+ *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
  */
@@ -1671,7 +1675,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
+		if (rq1->cpu < rq2->cpu) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1707,7 +1711,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
+		if (busiest->cpu < this_rq->cpu) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -6035,6 +6039,7 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 

--
