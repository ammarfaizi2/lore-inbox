Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWC2DRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWC2DRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC2DRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:17:08 -0500
Received: from fmr17.intel.com ([134.134.136.16]:46553 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750717AbWC2DRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:17:08 -0500
Message-ID: <4429F5AC.4000103@linux.intel.com>
Date: Tue, 28 Mar 2006 18:49:16 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: pwil3058@bigpond.net.au
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: smpnice try to wakeup modification
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

If there is no load on this_cpu, (i.e. tl_per_task is 0), we will fail the  
"tl + target_load(cpu, idx) <= tl_per_task" check.  I think the original intention was
to put task on this_cpu if it has no load and when there's already one task on 
cpu. This helps spread tasks out for low load condition.

Thanks.

Tim

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

--- linux-2.6.16-mm2-a/kernel/sched.c	2006-03-28 16:00:37.091779904 -0800
+++ linux-2.6.16-mm2-b/kernel/sched.c	2006-03-28 16:09:08.237074008 -0800
@@ -1393,7 +1393,7 @@ static int try_to_wake_up(task_t *p, uns
 
 		if (this_sd->flags & SD_WAKE_AFFINE) {
 			unsigned long tl = this_load;
-			unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
+			unsigned long sl_per_task = cpu_avg_load_per_task(cpu);
 
 			/*
 			 * If sync wakeup then subtract the (maximum possible)
@@ -1404,7 +1404,7 @@ static int try_to_wake_up(task_t *p, uns
 				tl -= current->load_weight;
 
 			if ((tl <= load &&
-				tl + target_load(cpu, idx) <= tl_per_task) ||
+				tl + target_load(cpu, idx) <= sl_per_task) ||
 				100*(tl + p->load_weight) <= imbalance*load) {
 				/*
 				 * This domain has SD_WAKE_AFFINE and

