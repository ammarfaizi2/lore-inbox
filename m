Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVASOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVASOki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVASOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:40:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16554 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261734AbVASOk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:40:26 -0500
Date: Wed, 19 Jan 2005 15:39:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050119143927.GA11950@elte.hu>
References: <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu> <87pt02pt0r.fsf@sulphur.joq.us> <20050119082433.GE29037@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119082433.GE29037@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i'm not suggesting that this is the way to go, it's just to test how
> nice--20 tasks would perform (on the hacked kernel). We still dont
> have this data, because in the other tests you tried, some
> non-highprio threads got nice--20 priority as well, which can (and
> apparently do) interfere with the highprio threads.

to make it easier to test, i've written an API hack: with the kernel
patch below setscheduler() will set the task to nice --20 if you use
SCHED_FIFO and sched_priority of 1. I.e. all you need to do is to run
Jack with -R and use an RT priority of 1 - all the highprio threads
should then become nice --20. If you use RT prio 2 (or higher) it should
be SCHED_FIFO again. Just apply the patch to 2.6.11-rc1 (2.6.10 might
work too) and it will work automatically. (the hack also includes the
earlier 'no starvation for nice--20 tasks' hack.)

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2245,10 +2245,10 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  * if a better static_prio task has expired:
  */
 #define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+	((task_nice(current) > -20) && ((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
+			((rq)->curr->static_prio > (rq)->best_expired_prio)))
 
 /*
  * Do the virtual cpu time signal calculations.
@@ -3211,6 +3211,12 @@ static inline task_t *find_process_by_pi
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
 	BUG_ON(p->array);
+	if (prio == 1 && policy != SCHED_NORMAL) {
+		p->policy = SCHED_NORMAL;
+		p->static_prio = NICE_TO_PRIO(-20);
+		p->prio = p->static_prio;
+		return;
+	}
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
