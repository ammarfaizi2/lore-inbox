Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265486AbUEZL23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbUEZL23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUEZL23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:28:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46246 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265486AbUEZL21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:28:27 -0400
Date: Wed, 26 May 2004 13:27:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: torvalds@osdl.org, Ashok Raj <ashok.raj@intel.com>,
       nickpiggin@yahoo.com.au, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [CPU Hotplug PATCH] Restore Idle task's priority during CPU_DEAD notification
Message-ID: <20040526112726.GA8499@elte.hu>
References: <A28EFEDC5416054BA1026D892753E9AF059A50EC@orsmsx404.amr.corp.intel.com> <1085537205.2639.61.camel@bach> <20040526061613.GA18314@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526061613.GA18314@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> @@ -3569,6 +3569,7 @@ static int migration_call(struct notifie
>  		rq = task_rq_lock(rq->idle, &flags);
>  		deactivate_task(rq->idle, rq);
>  		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
> +		rq->idle->prio = MAX_PRIO;
>  		task_rq_unlock(rq, &flags);
>   		BUG_ON(rq->nr_running != 0);

Looks good. A small nit: while your patch creates a perfectly correct
idle thread too, i'd prefer the modified variant below. The
__setscheduler() call is (technically) incorrect because in the
SCHED_NORMAL case the prio should be zero. So it's a bit cleaner to set
up the static priority to MAX_PRIO and then revert the policy to
SCHED_NORMAL via __setscheduler(). Ok?

	Ingo

From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -3566,7 +3566,8 @@ static int migration_call(struct notifie
 		/* Idle task back to normal (off runqueue, low prio) */
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
-		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+		rq->idle->static_prio = MAX_PRIO;
+		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		task_rq_unlock(rq, &flags);
  		BUG_ON(rq->nr_running != 0);
 
