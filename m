Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWKQTUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWKQTUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbWKQTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:20:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:58893 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1750890AbWKQTUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:20:37 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="163201398:sNHT104741889"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Mike Galbraith'" <efault@gmx.de>
Cc: <nickpiggin@yahoo.com.au>, "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [rfc patch] Re: sched: incorrect argument used in task_hot()
Date: Fri, 17 Nov 2006 11:20:27 -0800
Message-ID: <000301c70a7d$70bcce40$2880030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccKaUiBbkuJEm1wRiWgJBIcuauSOQAExC3w
In-Reply-To: <1163782610.22574.59.camel@Homer.simpson.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote on Friday, November 17, 2006 8:57 AM
> On Tue, 2006-11-14 at 15:00 -0800, Chen, Kenneth W wrote:
> > The argument used for task_hot in can_migrate_task() looks wrong:
> > 
> > int can_migrate_task()
> > { ...
> >        if (task_hot(p, rq->timestamp_last_tick, sd))
> >                 return 0;
> >         return 1;
> > }
> > 
> > [....]
> > 
> > So back to the first observation on not enough l-b at HT domain because
> > of inaccurate time calculation, what would be the best solution to fix
> > this?
> 
> One way to improve granularity, and eliminate the possibility of
> p->last_run being > rq->timestamp_tast_tick, and thereby short
> circuiting the evaluation of cache_hot_time, is to cache the last return
> of sched_clock() at both tick and sched times, and use that value as our
> reference instead of the absolute time of the tick.  It won't totally
> eliminate skew, but it moves the reference point closer to the current
> time on the remote cpu.
> 
> Comments?


I like it and think it might do it.  Just for the record, we are tinkering
with the following patch.  The thinking is that logical CPUs in HT and
multi-core domain are usually on the same CPU package, and it is likely that
the tsc are synchronized, so we can take current time stamp and use it
directly to compare with p->last_ran.  I'm planning on running a couple of
experiments with both patches.


--- ./kernel/sched.c.orig	2006-11-07 18:24:20.000000000 -0800
+++ ./kernel/sched.c	2006-11-15 16:01:39.000000000 -0800
@@ -2068,6 +2068,8 @@ int can_migrate_task(struct task_struct 
 		     struct sched_domain *sd, enum idle_type idle,
 		     int *all_pinned)
 {
+	unsigned long long now;
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) running (obviously), or
@@ -2090,7 +2092,12 @@ int can_migrate_task(struct task_struct 
 	if (sd->nr_balance_failed > sd->cache_nice_tries)
 		return 1;
 
-	if (task_hot(p, rq->timestamp_last_tick, sd))
+	if (sd->flags & (SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES))
+		now = sched_clock();
+	else
+		now = rq->timestamp_last_tick;
+
+	if (task_hot(p, now, sd))
 		return 0;
 	return 1;
 }
