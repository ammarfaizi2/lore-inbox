Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271303AbUJVNPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271303AbUJVNPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271271AbUJVNNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:13:14 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:40894 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271320AbUJVNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:08:22 -0400
Message-ID: <4179063C.9020504@yahoo.com.au>
Date: Fri, 22 Oct 2004 23:08:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Hawkes <hawkes@oss.sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, jbarnes@sgi.com,
       hawkes@sgi.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
References: <200410201936.i9KJa4FF026174@oss.sgi.com>
In-Reply-To: <200410201936.i9KJa4FF026174@oss.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------080003010803080502060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080003010803080502060405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

John Hawkes wrote:
> A large number of processes that are pinned to a single CPU results in
> every other CPU's load_balance() seeing this overloaded CPU as "busiest",
> yet move_tasks() never finds a task to pull-migrate.  This condition
> occurs during module unload, but can also occur as a denial-of-service
> using sys_sched_setaffinity().  Several hundred CPUs performing this
> fruitless load_balance() will livelock on the busiest CPU's runqueue
> lock.  A smaller number of CPUs will livelock if the pinned task count
> gets high.  This simple patch remedies the more common first problem:
> after a move_tasks() failure to migrate anything, the balance_interval
> increments.  Using a simple increment, vs.  the more dramatic doubling of
> the balance_interval, is conservative and yet also effective.
> 
> John Hawkes
> 

John and I also discussed a slightly more sophisticated algorithm
for this that would try to be a bit smarter about the reason for
balance failures (described in the changelog).

John, this works quite well here, would you have any objections
using it instead? Does it cure your problems there?


--------------080003010803080502060405
Content-Type: text/x-patch;
 name="sched-lb-pinned.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-lb-pinned.patch"



John Hawkes explained the problem best:
	A large number of processes that are pinned to a single CPU results
	in every other CPU's load_balance() seeing this overloaded CPU as
	"busiest", yet move_tasks() never finds a task to pull-migrate.  This
	condition occurs during module unload, but can also occur as a
	denial-of-service using sys_sched_setaffinity().  Several hundred
	CPUs performing this fruitless load_balance() will livelock on the
	busiest CPU's runqueue lock.  A smaller number of CPUs will livelock
	if the pinned task count gets high.
	
Expanding slightly on John's patch, this one attempts to work out
whether the balancing failure has been due to too many tasks pinned
on the runqueue. This allows it to be basically invisible to the
regular blancing paths (ie. when there are no pinned tasks). We can
use this extra knowledge to shut down the balancing faster, and ensure
the migration threads don't start running which is another problem
observed in the wild.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/kernel/sched.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff -puN kernel/sched.c~sched-lb-pinned kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-lb-pinned	2004-10-22 22:36:05.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-10-22 22:36:05.000000000 +1000
@@ -1626,7 +1626,7 @@ void pull_task(runqueue_t *src_rq, prio_
  */
 static inline
 int can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
-		     struct sched_domain *sd, enum idle_type idle)
+		     struct sched_domain *sd, enum idle_type idle, int *pinned)
 {
 	/*
 	 * We do not migrate tasks that are:
@@ -1636,8 +1636,10 @@ int can_migrate_task(task_t *p, runqueue
 	 */
 	if (task_running(rq, p))
 		return 0;
-	if (!cpu_isset(this_cpu, p->cpus_allowed))
+	if (!cpu_isset(this_cpu, p->cpus_allowed)) {
+		*pinned++;
 		return 0;
+	}
 
 	/* Aggressive migration if we've failed balancing */
 	if (idle == NEWLY_IDLE ||
@@ -1658,11 +1660,11 @@ int can_migrate_task(task_t *p, runqueue
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
 		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle)
+		      enum idle_type idle, int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0;
+	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
@@ -1706,7 +1708,7 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle)) {
+	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1732,6 +1734,9 @@ skip_queue:
 		goto skip_bitmap;
 	}
 out:
+	*all_pinned = 0;
+	if (unlikely(pinned >= max_nr_move) && pulled == 0)
+		*all_pinned = 1;
 	return pulled;
 }
 
@@ -1906,7 +1911,7 @@ static int load_balance(int this_cpu, ru
 	struct sched_group *group;
 	runqueue_t *busiest;
 	unsigned long imbalance;
-	int nr_moved;
+	int nr_moved, all_pinned;
 
 	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -1945,11 +1950,16 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-						imbalance, sd, idle);
+						imbalance, sd, idle,
+						&all_pinned);
 		spin_unlock(&busiest->lock);
 	}
-	spin_unlock(&this_rq->lock);
+	/* All tasks on this runqueue were pinned by CPU affinity */
+	if (unlikely(all_pinned))
+		goto out_balanced;
 
+	spin_unlock(&this_rq->lock);
+	
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[idle]);
 		sd->nr_balance_failed++;
@@ -2004,7 +2014,7 @@ static int load_balance_newidle(int this
 	struct sched_group *group;
 	runqueue_t *busiest = NULL;
 	unsigned long imbalance;
-	int nr_moved = 0;
+	int nr_moved = 0, all_pinned;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
@@ -2024,7 +2034,7 @@ static int load_balance_newidle(int this
 
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					imbalance, sd, NEWLY_IDLE);
+			imbalance, sd, NEWLY_IDLE, &all_pinned);
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 
@@ -2085,6 +2095,7 @@ static void active_load_balance(runqueue
 	do {
 		runqueue_t *rq;
 		int push_cpu = 0;
+		int all_pinned;
 
 		if (group == busy_group)
 			goto next_group;
@@ -2106,7 +2117,8 @@ static void active_load_balance(runqueue
 		if (unlikely(busiest == rq))
 			goto next_group;
 		double_lock_balance(busiest, rq);
-		if (move_tasks(rq, push_cpu, busiest, 1, sd, SCHED_IDLE)) {
+		if (move_tasks(rq, push_cpu, busiest, 1,
+					sd, SCHED_IDLE, &all_pinned)) {
 			schedstat_inc(busiest, alb_lost);
 			schedstat_inc(rq, alb_gained);
 		} else {

_

--------------080003010803080502060405--
