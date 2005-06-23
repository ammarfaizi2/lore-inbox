Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVFWNay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVFWNay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVFWN2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:28:19 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:31715 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262418AbVFWNYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:24:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] fix SMT scheduler latency bug
Date: Thu, 23 Jun 2005 23:24:30 +1000
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       William Weston <weston@sysex.net>
References: <20050622102541.GA10043@elte.hu> <20050622233254.GA11486@elte.hu> <200506231003.31084.kernel@kolivas.org>
In-Reply-To: <200506231003.31084.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PgruC/51esjJaN/"
Message-Id: <200506232324.31156.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PgruC/51esjJaN/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 23 Jun 2005 10:03, Con Kolivas wrote:
> About the only scenario I can envision a high priority task being delayed
> with the code as it currently is in 2.6.12-mm1 is with a high priority task
> being on the expired array and a low priority task being delayed on the
> active array. This still should not create large latencies unless array
> swapping is significantly delayed. I considered adding a check for this
> originally but it seemed to be unnecessary extra complexity since an
> expired task by design is expected to be delayed more anyway.

BTW if this is an issue it would only require a patch like this.

Cheers,
Con

--Boundary-00=_PgruC/51esjJaN/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-smt_nice_check_expired_array.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sched-smt_nice_check_expired_array.patch"

Index: linux-2.6.12-mm1/kernel/sched.c
===================================================================
--- linux-2.6.12-mm1.orig/kernel/sched.c	2005-06-23 00:10:22.000000000 +1000
+++ linux-2.6.12-mm1/kernel/sched.c	2005-06-23 23:19:35.000000000 +1000
@@ -2784,7 +2784,8 @@ static inline int dependent_sleeper(int 
 					ret = 1;
 		} else
 			if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
-				100) > task_timeslice(p)))
+				100) > task_timeslice(p)) &&
+				p->static_prio <= this_rq->best_expired_prio)
 					ret = 1;
 
 check_smt_task:
@@ -2807,7 +2808,8 @@ check_smt_task:
 					resched_task(smt_curr);
 		} else {
 			if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
-				task_timeslice(smt_curr))
+				task_timeslice(smt_curr) &&
+				smt_curr->static_prio <= smt_rq->best_expired_prio)
 					resched_task(smt_curr);
 			else
 				wakeup_busy_runqueue(smt_rq);

--Boundary-00=_PgruC/51esjJaN/--
