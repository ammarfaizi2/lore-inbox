Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWC3AzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWC3AzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWC3AzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:55:12 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:30402 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751327AbWC3AzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:55:10 -0500
Message-ID: <442B2C5D.2020300@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:54:53 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 6/8] virtual cpu run time
References: <442B271D.10208@watson.ibm.com>
In-Reply-To: <442B271D.10208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-virtcpu.patch

Distinguish between "wall-clock" and "virtual" cpu run times and return
both, at per-task and per-tgid granularity.

Some architectures adjust tsk->utime+tsk->stime to reflect the time that
the kernel wasn't scheduled in hypervised environments and this is the
"wall-clock" cpu run time. "Virtual" cpu run time, on the other hand, does
not account for the kernel being descheduled.

This patch allows the most accurate "virtual" cpu run time, collected by
the schedstats code (now shared with delay accounting code), to be returned
to user space, in addition to the "wall-clock" cpu time that was being exported
earlier. Both these times are useful for workload management in different
situations.

In a non-virtualized environment, or on architectures which do not adjust
tsk->utime/stime, these will effectively be the same value but at different
granularities.


Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>

 include/linux/taskstats.h |   10 ++++++++--
 kernel/delayacct.c        |   12 +++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

Index: linux-2.6.16/include/linux/taskstats.h
===================================================================
--- linux-2.6.16.orig/include/linux/taskstats.h	2006-03-29 18:13:18.000000000 -0500
+++ linux-2.6.16/include/linux/taskstats.h	2006-03-29 18:13:20.000000000 -0500
@@ -46,8 +46,14 @@ struct taskstats {
 	__u64	swapin_count;
 	__u64	swapin_delay_total;	/* swapin page fault wait*/

-	__u64	cpu_run_total;		/* cpu running time
-					 * no count available/provided */
+	__u64	cpu_run_real_total;	/* cpu "wall-clock" running time
+					 * Potentially accounts for cpu
+					 * virtualization, on some arches
+					 */
+	__u64	cpu_run_virtual_total;	/* cpu "virtual" running time
+					 * Uses time intervals as seen by
+					 * the kernel
+					 */
 };


Index: linux-2.6.16/kernel/delayacct.c
===================================================================
--- linux-2.6.16.orig/kernel/delayacct.c	2006-03-29 18:13:18.000000000 -0500
+++ linux-2.6.16/kernel/delayacct.c	2006-03-29 18:13:20.000000000 -0500
@@ -123,17 +123,18 @@ int __delayacct_add_tsk(struct taskstats
 {
 	nsec_t tmp;
 	struct timespec ts;
-	unsigned long t1,t2;
+	unsigned long t1,t2,t3;

 	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */

-	tmp = (nsec_t)d->cpu_run_total ;
+	tmp = (nsec_t)d->cpu_run_real_total ;
 	tmp += (u64)(tsk->utime+tsk->stime)*TICK_NSEC;
-	d->cpu_run_total = (tmp < (nsec_t)d->cpu_run_total)? 0: tmp;
+	d->cpu_run_real_total = (tmp < (nsec_t)d->cpu_run_real_total)? 0: tmp;

 	/* No locking available for sched_info. Take snapshot first. */
 	t1 = tsk->sched_info.pcnt;
 	t2 = tsk->sched_info.run_delay;
+	t3 = tsk->sched_info.cpu_time;

 	d->cpu_count += t1;

@@ -141,6 +142,11 @@ int __delayacct_add_tsk(struct taskstats
 	tmp = (nsec_t)d->cpu_delay_total + timespec_to_ns(&ts);
 	d->cpu_delay_total = (tmp < (nsec_t)d->cpu_delay_total)? 0: tmp;

+	tmp = (nsec_t)d->cpu_run_virtual_total
+		+ (nsec_t)jiffies_to_usecs(t3) * 1000;
+	d->cpu_run_virtual_total = (tmp < (nsec_t)d->cpu_run_virtual_total) ?
+					0 : tmp;
+
 	spin_lock(&tsk->delays->lock);
 	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0: tmp;
