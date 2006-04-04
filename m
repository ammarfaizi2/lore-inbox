Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWDDGTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWDDGTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWDDGTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:19:21 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:47353 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751464AbWDDGTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:19:20 -0400
Message-ID: <44320FE5.5080309@bigpond.net.au>
Date: Tue, 04 Apr 2006 16:19:17 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: improve smpnice load balancing when load per task
 imbalanced
Content-Type: multipart/mixed;
 boundary="------------010201010900090207050609"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 06:19:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201010900090207050609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

2 CPU system: if the cpu-0 has two high priority and cpu-1 has one 
normal priority task, how can the current code detect this imbalance 
because imbalance will be always < busiest_load_per_task and max_load - 
this_load will be < 2 * busiest_load_per_task and pwr_move will be <= 
pwr_now.

Solution:

Modify the assessment of small imbalances to take into account the 
relative sizes of busiest_load_per_task and this_load_per_task.  This is 
exploiting the fact that if the difference between the loads is greater 
than busiest_load_per_task and busiest_load_per_task is greater than 
this_load_per_task then moving busiest_load_per_task worth of load from 
busiest to this will be an improvement in the distribution of weighted load.

Required patches:

sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
sched-improve-stability-of-smpnice-load-balancing.patch

Note: This patch makes no change to load balancing in the case where all 
tasks are nice==0.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
   -- Ambrose Bierce


--------------010201010900090207050609
Content-Type: text/plain;
 name="smpnice-handle-unbalanced-load-per-task"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-handle-unbalanced-load-per-task"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-04-04 15:18:19.000000000 +1000
+++ MM-2.6.X/kernel/sched.c	2006-04-04 15:53:48.000000000 +1000
@@ -2252,8 +2252,16 @@ find_busiest_group(struct sched_domain *
 	if (*imbalance < busiest_load_per_task) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
+		unsigned int imbn = 2;
 
-		if (max_load - this_load >= busiest_load_per_task*2) {
+		if (this_nr_running) {
+			this_load_per_task /= this_nr_running;
+			if (busiest_load_per_task > this_load_per_task)
+				imbn = 1;
+		} else
+			this_load_per_task = SCHED_LOAD_SCALE;
+
+		if (max_load - this_load >= busiest_load_per_task * imbn) {
 			*imbalance = busiest_load_per_task;
 			return busiest;
 		}
@@ -2266,10 +2274,6 @@ find_busiest_group(struct sched_domain *
 
 		pwr_now += busiest->cpu_power *
 			min(busiest_load_per_task, max_load);
-		if (this_nr_running)
-			this_load_per_task /= this_nr_running;
-		else
-			this_load_per_task = SCHED_LOAD_SCALE;
 		pwr_now += this->cpu_power *
 			min(this_load_per_task, this_load);
 		pwr_now /= SCHED_LOAD_SCALE;

--------------010201010900090207050609--
