Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEWHLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEWHLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEWHLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:11:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6126 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261841AbVEWHL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:11:28 -0400
Date: Mon, 23 May 2005 09:11:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chen Shang <shangcs@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, rml@tech9.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Message-ID: <20050523071103.GA30016@elte.hu>
References: <855e4e4605051909561f47351@mail.gmail.com> <855e4e46050520001215be7cde@mail.gmail.com> <20050520094909.GA16923@elte.hu> <200505202040.51329.kernel@kolivas.org> <20050520113448.GA20486@elte.hu> <855e4e460505212141105e6b43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855e4e460505212141105e6b43@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen Shang <shangcs@gmail.com> wrote:

> /*===== ISSUE ====*/
> My second version of patch has a defect.
> 
> +  if (unlikely(old_prio != next->prio))             {
> +      dequeue_task(next, array);  --> ### dequeue should against
> old_prio, NOT next->prio ###
> +      enqueue_task(next, array);
> +  }

indeed...

> unforunately, dequeue_task does not accept the third parameter to make
> adjustment. Personally, I feel it's good to add extra function as my
> first version of patch to combine dequeue and enqueue together.
> Reasons as following:
> 1) adding the third parameter to dequeue_task() would cause other
> places' code change;
> 2) for schedule functions, performance is the first consideration.
> Notice both dequeue_task() and enqueue_task() are NOT inline.
> Combining those two in one saves one function call overhead;

the real problem comes from recalc_task_prio() having a side-effect, 
which makes requeueing of tasks harder. The solution is to return the 
prio from recalc_task_prio() - see the tested patch below. Agreed?

	Ingo

--

micro-optimize task requeueing in schedule() & clean up 
recalc_task_prio().

From: Chen Shang <shangcs@gmail.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -675,7 +675,7 @@ static inline void __activate_idle_task(
 	rq->nr_running++;
 }
 
-static void recalc_task_prio(task_t *p, unsigned long long now)
+static int recalc_task_prio(task_t *p, unsigned long long now)
 {
 	/* Caller must always ensure 'now >= p->timestamp' */
 	unsigned long long __sleep_time = now - p->timestamp;
@@ -734,7 +734,7 @@ static void recalc_task_prio(task_t *p, 
 		}
 	}
 
-	p->prio = effective_prio(p);
+	return effective_prio(p);
 }
 
 /*
@@ -757,7 +757,7 @@ static void activate_task(task_t *p, run
 	}
 #endif
 
-	recalc_task_prio(p, now);
+	p->prio = recalc_task_prio(p, now);
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task
@@ -2751,7 +2751,7 @@ asmlinkage void __sched schedule(void)
 	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu, idx, new_prio;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2873,9 +2873,14 @@ go_idle:
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
-		dequeue_task(next, array);
-		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+		new_prio = recalc_task_prio(next, next->timestamp + delta);
+
+		if (unlikely(next->prio != new_prio)) {
+			dequeue_task(next, array);
+			next->prio = new_prio;
+			enqueue_task(next, array);
+		} else
+			requeue_task(next, array);
 	}
 	next->activated = 0;
 switch_tasks:
