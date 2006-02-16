Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWBPD52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWBPD52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBPD52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:57:28 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:13208 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932243AbWBPD51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:57:27 -0500
Message-ID: <43F3F824.3020901@bigpond.net.au>
Date: Thu, 16 Feb 2006 14:57:24 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
References: <200602140312.k1E3CWg17620@unix-os.sc.intel.com> <43F196B9.8080407@yahoo.com.au>
In-Reply-To: <43F196B9.8080407@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050704060002010501060105"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 16 Feb 2006 03:57:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704060002010501060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Chen, Kenneth W wrote:
> 
>> Revert commit d7102e95b7b9c00277562c29aad421d2d521c5f6,
>> which causes more than 10% performance regression with aim7.
>>
> 
> Just to be sure, what kernel did you test with? In particular,
> did it have the smpnice patch reverted (as -rc3 does).
> 

Analysis of the smpnice code indicates that it could cause anomalous cpu 
selection decisions in try_to_wake_up() if there is a skew in the 
distribution of nice among the tasks on the cpus under consideration. 
Attached for review is a proposed patch to address problem. In 
particular, I request comments on the following issues:

1. Is this potential problem worth worrying about?
2. Do you agree with my decision to replace SCHED_LOAD_SCALE with the 
average load per task for this_cpu in the if statement in 
try_to_wake_up() or should I be using the average load per task for the 
tasks current cpu in one or both places?

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050704060002010501060105
Content-Type: text/plain;
 name="fix-smpnice-try-to-wake-up"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-smpnice-try-to-wake-up"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-16 12:39:30.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-16 14:36:24.000000000 +1100
@@ -1061,6 +1061,18 @@ static inline unsigned long target_load(
 }
 
 /*
+ * Return the average load per task on the cpu's run queue
+ */
+static inline unsigned long cpu_avg_load_per_task(int cpu)
+{
+	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long n = rq->nr_running;
+	unsigned long load = weighted_load(rq->prio_bias);
+
+	return n ? load / n : load;
+}
+
+/*
  * find_idlest_group finds and returns the least busy CPU group within the
  * domain.
  */
@@ -1309,6 +1321,7 @@ static int try_to_wake_up(task_t *p, uns
 
 		if (this_sd->flags & SD_WAKE_AFFINE) {
 			unsigned long tl = this_load;
+			unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
 			/*
 			 * If sync wakeup then subtract the (maximum possible)
 			 * effect of the currently running task from the load
@@ -1318,8 +1331,8 @@ static int try_to_wake_up(task_t *p, uns
 				tl -= weighted_load(p->bias_prio);
 
 			if ((tl <= load &&
-				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
-				100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
+				tl + target_load(cpu, idx) <= tl_per_task) ||
+				100*(tl + tl_per_task) <= imbalance*load) {
 				/*
 				 * This domain has SD_WAKE_AFFINE and
 				 * p is cache cold in this domain, and

--------------050704060002010501060105--
