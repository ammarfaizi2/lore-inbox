Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVAXI7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVAXI7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 03:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVAXI7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 03:59:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41871 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261153AbVAXI7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 03:59:34 -0500
Date: Mon, 24 Jan 2005 09:59:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050124085902.GA8059@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdl940ph.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

>   First, only SCHED_FIFO worked reliably in my tests.  In Con's tests
>   even that did not work.  My system is probably better tuned for low
>   latency than his.  Until we can determine why there were so many
>   xruns, it is premature to declare victory for either scheduler.
>   Preferably, we should compare them on a well-tuned low-latency
>   system running your Realtime Preemption kernel.

i didnt declare victory - the full range of latency fixes is in the -RT
tree. Merging of relevant bits is an ongoing process - in 2.6.10 you've
already seen some early results, but it's by no means complete. Nor did
i declare that nice--20 was suitable for audio priorities.

>   Second, the nice(-20) scheduler provides no clear way to support
>   multiple realtime priorities. [...]

why? You could use e.g. nice -20, -19 and -18. (see the patch below that
implements this.)

>   Third, your prototype denies SCHED_FIFO to privileged threads.  This
>   is a serious problem, even for testing (though perhaps easy to fix).

this is not a prototype, it's an 'API hack'. The real solution would
have none of these limitations of course. Just think of this patch as an
'easy way to use nice--20 without any jackd changes' - any API
limitation you sense is a fault of this hack, not a fault of the
concept.

Find below an updated version of the 'API hack', which, instead of
auto-mapping all RT priorities, extends sched_setscheduler() to allow
nonzero sched_priority values for SCHED_OTHER, which are interpreted as
nice values. E.g. to set a thread to nice--20, do this:

	struct sched_param param = { sched_priority: -19 };

	sched_setscheduler(pid, SCHED_OTHER, &param);

(obviously this is not complete because no permission checking is done,
but this could be combined with an rlimits solution to achieve safety.)

>   Most important, let's not forget that this long discussion started
>   because ordinary users need access to realtime scheduling.  Con's
>   scheduler provides a solution for that problem.  Your prototype does
>   not.

sorry, but that is not how the discussion started. The discussion
started about an API hack, the RT-LSM way to give ordinary users the
unfettered access to RT scheduling.

Then, after this approach was vetoed (rightfully IMO, because it has a
number of disadvantages), did the real discussion start: "how do we give
low latencies to audio applications (and other, soft-RT alike
applications), while not allowing them to lock up the system."

I happened to start that angle - until that point everyone was focused
on the wrong premise of 'how do we give RT privileges to ordinary
users'. We _dont_ give raw RT scheduling to ordinary users, period. The
discussion is still about how to give (audio) applications low
priorities, for which there are a number of solutions:

- SCHED_ISO is a possibility, and has nonzero costs to the scheduler.

- CKRM is another possibility, and has nonzero costs as well, but solves
  a wider range of problems.

- negative nice levels are the easiest shortterm solution and have zero
  cost. They have some disadvantages though.

I'm not 'against' SCHED_ISO at all:

  http://lkml.org/lkml/2004/11/2/114

> Being less entangled with SCHED_NORMAL makes me worry less about
> someone coming along later and messing it up while working on some
> unrelated problem. [...]

i think the real situation is somewhat the opposite: we much more often
broke RT scheduling than SCHED_NORMAL scheduling. RT scheduling is
rarely used, while SCHED_NORMAL (and negative/positive nice levels) are
used much more often than e.g. SCHED_FIFO or SCHED_RR.

> [...] Right now for example, mounting an encrypted filesystem starts a
> `loop0' kernel thread at nice -20.

this is not really a problem - there are other kernel subsystems that
start RT-priority kernel threads. We could easily move such threads to
the common nice -10 priority level or so.

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2245,10 +2245,10 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  * if a better static_prio task has expired:
  */
 #define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+	((task_nice(current) >= -15) && ((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
+			((rq)->curr->static_prio > (rq)->best_expired_prio)))
 
 /*
  * Do the virtual cpu time signal calculations.
@@ -3328,12 +3328,16 @@ static inline task_t *find_process_by_pi
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
 	BUG_ON(p->array);
+	if (policy == SCHED_NORMAL) {
+		p->policy = SCHED_NORMAL;
+		p->rt_priority = 0;
+		p->static_prio = NICE_TO_PRIO(prio);
+		p->prio = p->static_prio;
+		return;
+	}
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
-	else
-		p->prio = p->static_prio;
+	p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 }
 
 /**
@@ -3361,12 +3365,17 @@ recheck:
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
+	 *
+	 * Hack: allow SCHED_OTHER with nice levels of -20 ... +19
 	 */
-	if (param->sched_priority < 0 ||
-	    param->sched_priority > MAX_USER_RT_PRIO-1)
-		return -EINVAL;
-	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
-		return -EINVAL;
+	if (policy != SCHED_NORMAL) {
+		if (param->sched_priority < 0 ||
+		    param->sched_priority > MAX_USER_RT_PRIO-1)
+			return -EINVAL;
+	} else {
+		if (param->sched_priority < -20 || param->sched_priority > 19)
+			return -EINVAL;
+	}
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
 	    !capable(CAP_SYS_NICE))
