Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJEWrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJEWrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUJEWrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:47:00 -0400
Received: from fmr04.intel.com ([143.183.121.6]:62156 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266271AbUJEWqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:46:54 -0400
Message-Id: <200410052246.i95MkV630776@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: RE: bug in sched.c:activate_task()
Date: Tue, 5 Oct 2004 15:46:39 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqs+eaeeVK4lKVQXW75lmRZGOjgwATt1ZgAAqLDEA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> Update p->timestamp to "now" in activate_task() doesn't look right to
> me at all.  p->timestamp records last time it was running on a cpu.
> activate_task shouldn't update that variable when it queues a task on
> the runqueue.

Ingo Molnar wrote on Tuesday, October 05, 2004 1:19 AM
> it is being used for multiple purposes: measuring on-CPU time, measuring
> on-runqueue time (for interactivity) and measuring off-runqueue time
> (for interactivity). It is also used to measure cache-hotness, by the
> balancing code.
>
> now, this particular update of p->timestamp:
>
> > @@ -888,7 +888,6 @@ static void activate_task(task_t *p, run
>
> > -	p->timestamp = now;
>
> is important for the interactivity code that runs in schedule() - it
> wants to know how much time we spent on the runqueue without having run.
>
> but you are right that the task_hot() use of p->timestamp is incorrect
> for freshly woken up tasks - we want the balancer to be able to re-route
> tasks to another CPU, as long as the task has not hit the runqueue yet
> (which it hasnt where we consider it in the balancer).
>
> the clean solution is to separate the multiple uses of p->timestamp:
> with the patch below p->timestamp is purely used for the interactivity
> code, and p->last_ran is for the rebalancer. The patch is ontop of your
> task_hot() fix-patch. Does this work for your workload?


Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:45 AM
> I will take this for a spin and report back the result.

Confirmed that Ingo's latest patch does the right thing for the db workload.

- Ken


