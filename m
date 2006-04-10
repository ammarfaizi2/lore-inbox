Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWDJGpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWDJGpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWDJGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:45:35 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:55960 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750997AbWDJGpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:45:35 -0400
Message-ID: <4439FF0C.8030407@bigpond.net.au>
Date: Mon, 10 Apr 2006 16:45:32 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: move enough load to balance average load per task
Content-Type: multipart/mixed;
 boundary="------------050005090304000402060309"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 10 Apr 2006 06:45:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005090304000402060309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

The current implementation of find_busiest_group() recognizes that 
approximately equal average loads per task for each group/queue are 
desirable (e.g. this condition will increase the probability that the 
top N highest priority tasks on an N CPU system will be on different 
CPUs) by being slightly more aggressive when *imbalance is small but the 
average load per task in "busiest" group is more than that in "this" 
group.  Unfortunately, the amount moved from "busiest" to "this" is too 
small to reduce the average load per task on "busiest" (at best there 
will be no change and at worst it will get bigger).

Solution:

Increase the amount of load moved from "busiest" to "this" in these 
circumstances while making sure that the amount of load moved won't 
increase the (absolute) difference in the two groups' total weighted 
loads.  A task with a weighted load greater than the average needs to be 
moved to cause the average to be reduced.

NB This makes no difference to load balancing for the case where all 
tasks have nice==0.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050005090304000402060309
Content-Type: text/plain;
 name="smpnice-help-balance-avg-loads"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-help-balance-avg-loads"

Index: MM-2.6.17-rc1-mm2/kernel/sched.c
===================================================================
--- MM-2.6.17-rc1-mm2.orig/kernel/sched.c	2006-04-10 10:46:53.000000000 +1000
+++ MM-2.6.17-rc1-mm2/kernel/sched.c	2006-04-10 14:16:32.000000000 +1000
@@ -2258,16 +2258,20 @@ find_busiest_group(struct sched_domain *
 	if (*imbalance < busiest_load_per_task) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
-		unsigned int imbn = 2;
 
-		if (this_nr_running) {
+		if (this_nr_running)
 			this_load_per_task /= this_nr_running;
-			if (busiest_load_per_task > this_load_per_task)
-				imbn = 1;
-		} else
+		else
 			this_load_per_task = SCHED_LOAD_SCALE;
 
-		if (max_load - this_load >= busiest_load_per_task * imbn) {
+		if (busiest_load_per_task > this_load_per_task) {
+			unsigned long dld = max_load - this_load;
+
+			if (dld > busiest_load_per_task) {
+				*imbalance = (dld + busiest_load_per_task) / 2;
+				return busiest;
+			}
+		} else if (max_load - this_load >= busiest_load_per_task * 2) {
 			*imbalance = busiest_load_per_task;
 			return busiest;
 		}

--------------050005090304000402060309--
