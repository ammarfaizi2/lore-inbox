Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWEJK2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWEJK2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWEJK2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:28:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:21402 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964896AbWEJK2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:28:01 -0400
Date: Wed, 10 May 2006 15:54:15 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: [PATCH][delayacct] Use better names in schedstats (was Re: [Patch 3/8] cpu delay collection via schedstats)
Message-ID: <20060510102415.GE29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061505.GN13962@in.ibm.com> <20060508142640.675665c7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508142640.675665c7.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:26:40PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +/*
> > + * Expects runqueue lock to be held for atomicity of update
> > + */
> > +static inline void rq_sched_info_arrive(struct runqueue *rq,
> > +						unsigned long diff)
> > +{
> > +	if (rq) {
> > +		rq->rq_sched_info.run_delay += diff;
> > +		rq->rq_sched_info.pcnt++;
> > +	}
> > +}
> > +
> > +/*
> > + * Expects runqueue lock to be held for atomicity of update
> > + */
> > +static inline void rq_sched_info_depart(struct runqueue *rq,
> > +						unsigned long diff)
> > +{
> > +	if (rq)
> > +		rq->rq_sched_info.cpu_time += diff;
> > +}
> 
> The kernel has many different units of time - jiffies, cpu ticks, ns, us,
> ms, etc.  So the reader of these functions doesn't have a clue what "diff"
> is.
> 
> A good way to remove all doubt in all cases is to include the units in the
> variable's name.  Something like delta_jiffies, perhaps.

Hi, Andrew

I have renamed all the "diff" to "delta_jiffies" to make it easier to
read the code as suggested in the review comments.

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Changelog
1. Clean up the usage of the names. Use names with units to make the code
   easier to read

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/sched.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff -puN kernel/sched.c~schedstats-use-better-names kernel/sched.c
--- linux-2.6.17-rc3/kernel/sched.c~schedstats-use-better-names	2006-05-10 14:48:54.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/sched.c	2006-05-10 14:56:09.000000000 +0530
@@ -473,10 +473,10 @@ struct file_operations proc_schedstat_op
  * Expects runqueue lock to be held for atomicity of update
  */
 static inline void rq_sched_info_arrive(struct runqueue *rq,
-						unsigned long diff)
+						unsigned long delta_jiffies)
 {
 	if (rq) {
-		rq->rq_sched_info.run_delay += diff;
+		rq->rq_sched_info.run_delay += delta_jiffies;
 		rq->rq_sched_info.pcnt++;
 	}
 }
@@ -485,17 +485,19 @@ static inline void rq_sched_info_arrive(
  * Expects runqueue lock to be held for atomicity of update
  */
 static inline void rq_sched_info_depart(struct runqueue *rq,
-						unsigned long diff)
+						unsigned long delta_jiffies)
 {
 	if (rq)
-		rq->rq_sched_info.cpu_time += diff;
+		rq->rq_sched_info.cpu_time += delta_jiffies;
 }
 # define schedstat_inc(rq, field)	do { (rq)->field++; } while (0)
 # define schedstat_add(rq, field, amt)	do { (rq)->field += (amt); } while (0)
 #else /* !CONFIG_SCHEDSTATS */
-static inline void rq_sched_info_arrive(struct runqueue *rq, unsigned long diff)
+static inline void rq_sched_info_arrive(struct runqueue *rq,
+						unsigned long delta_jiffies)
 {}
-static inline void rq_sched_info_depart(struct runqueue *rq, unsigned long diff)
+static inline void rq_sched_info_depart(struct runqueue *rq,
+						unsigned long delta_jiffies)
 {}
 # define schedstat_inc(rq, field)	do { } while (0)
 # define schedstat_add(rq, field, amt)	do { } while (0)
@@ -544,16 +546,16 @@ static inline void sched_info_dequeued(t
  */
 static void sched_info_arrive(task_t *t)
 {
-	unsigned long now = jiffies, diff = 0;
+	unsigned long now = jiffies, delta_jiffies = 0;
 
 	if (t->sched_info.last_queued)
-		diff = now - t->sched_info.last_queued;
+		delta_jiffies = now - t->sched_info.last_queued;
 	sched_info_dequeued(t);
-	t->sched_info.run_delay += diff;
+	t->sched_info.run_delay += delta_jiffies;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcnt++;
 
-	rq_sched_info_arrive(task_rq(t), diff);
+	rq_sched_info_arrive(task_rq(t), delta_jiffies);
 }
 
 /*
@@ -584,10 +586,10 @@ static inline void sched_info_queued(tas
  */
 static inline void sched_info_depart(task_t *t)
 {
-	unsigned long diff = jiffies - t->sched_info.last_arrival;
+	unsigned long delta_jiffies = jiffies - t->sched_info.last_arrival;
 
-	t->sched_info.cpu_time += diff;
-	rq_sched_info_depart(task_rq(t), diff);
+	t->sched_info.cpu_time += delta_jiffies;
+	rq_sched_info_depart(task_rq(t), delta_jiffies);
 }
 
 /*
_
