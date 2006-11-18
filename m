Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756100AbWKRAZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbWKRAZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbWKRAZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:25:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:34705 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1756102AbWKRAZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:25:33 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,436,1157353200"; 
   d="scan'208"; a="163335981:sNHT18274214"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Mike Galbraith'" <efault@gmx.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [rfc patch] Re: sched: incorrect argument used in task_hot()
Date: Fri, 17 Nov 2006 16:25:09 -0800
Message-ID: <000501c70aa8$01bc4e50$2880030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccKliWzwHiwh3FYQWmFmOHHJ88AWQADjB+w
In-Reply-To: <1163801933.23357.33.camel@Homer.simpson.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote on Friday, November 17, 2006 2:19 PM
> > And a changelog, then we're all set!
> > 
> > Oh.  And a patch, too.
> 
> Co-opt rq->timestamp_last_tick to maintain a cache_hot_time evaluation
> reference timestamp at both tick and sched times to prevent said
> reference, formerly rq->timestamp_last_tick, from being behind
> task->last_ran at evaluation time, and to move said reference closer to
> current time on the remote processor, intent being to improve cache hot
> evaluation and timestamp adjustment accuracy for task migration.
> 
> Fix minor sched_time double accounting error which occurs when a task
> passing through schedule() does not schedule off, and takes the next
> timer tick.
> 
> [....]
> 
> @@ -2206,7 +2207,7 @@ skip_queue:
>  	}
>  
>  #ifdef CONFIG_SCHEDSTATS
> -	if (task_hot(tmp, busiest->timestamp_last_tick, sd))
> +	if (task_hot(tmp, busiest->most_recent_timestamp, sd))
>  		schedstat_inc(sd, lb_hot_gained[idle]);
>  #endif


While we at it, let's clean up this hunk.  task_hot is evaluated twice in
the more common case of nr_balance_failed <= cache_nice_tries. We should
only test/increment relevant stats for forced migration.
Patch on top of yours.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./kernel/sched.c.orig	2006-11-17 13:37:46.000000000 -0800
+++ ./kernel/sched.c	2006-11-17 14:20:34.000000000 -0800
@@ -2088,8 +2088,13 @@ int can_migrate_task(struct task_struct 
 	 * 2) too many balance attempts have failed.
 	 */
 
-	if (sd->nr_balance_failed > sd->cache_nice_tries)
+	if (sd->nr_balance_failed > sd->cache_nice_tries) {
+		#ifdef CONFIG_SCHEDSTATS
+		if (task_hot(p, rq->most_recent_timestamp, sd))
+			schedstat_inc(sd, lb_hot_gained[idle]);
+		#endif
 		return 1;
+	}
 
 	if (task_hot(p, rq->most_recent_timestamp, sd))
 		return 0;
@@ -2189,11 +2194,6 @@ skip_queue:
 		goto skip_bitmap;
 	}
 
-#ifdef CONFIG_SCHEDSTATS
-	if (task_hot(tmp, busiest->most_recent_timestamp, sd))
-		schedstat_inc(sd, lb_hot_gained[idle]);
-#endif
-
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
 	rem_load_move -= tmp->load_weight;
