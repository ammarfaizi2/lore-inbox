Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWBMExr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWBMExr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 23:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWBMExr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 23:53:47 -0500
Received: from mail.gmx.de ([213.165.64.21]:3283 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751082AbWBMExr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 23:53:47 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139801975.2739.72.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
	 <1139752033.27408.20.camel@homer>  <1139771016.19342.253.camel@mindpipe>
	 <1139780193.7837.7.camel@homer>  <1139787578.2739.13.camel@mindpipe>
	 <1139800169.7595.24.camel@homer>  <1139801975.2739.72.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 05:59:21 +0100
Message-Id: <1139806761.25253.33.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 22:39 -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 04:09 +0100, MIke Galbraith wrote:
> > On Sun, 2006-02-12 at 18:39 -0500, Lee Revell wrote:

> > > Not only does this fix my "time ls" test case, it seems to drastically
> > > improve interactivity for my desktop apps.  I was really being plagued
> > > by weird stalls, it's much smoother now.
> > 
> > Yeah, but under load, that reluctance to release is fairly annoying...
> 
> This seems to manifest on my system as the mouse getting jerky under
> load.  Still, I don't mind - the overall feel is still smoother - as if
> the X server was getting too much CPU before.

Not only the X server, the interactivity boost in general is way too
severe.  It still needs work, but it's shaping up.  Who knows, it may
even get to the point of applying for inclusion.

Now, let's see if we can get your problem fixed with something that can
possibly go into 2.6.16 as a bugfix.  Can you please try the below?

This patch fixes two of what I would call thinkos in the interactivity
logic.  One, the requeuing of a freshly awakened task can lead to that
task losing it's slice of cpu upon preempt if it isn't alone in it's
queue.  Two, tasks which sleep for > INTERACTIVE_SLEEP(p), approximately
700ms, are treated as being idle, and prevented from slamming straight
to max dynamic priority for obvious reasons, yet a pure cpu hog that
sleeps for 100ms will fail the test, and subsequently have it's sleep
time multiplied by MAX_BONUS.

Just in case it does fix it for you, I'll even add a blame line.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-rc3/kernel/sched.c.org	2006-02-13 04:44:57.000000000 +0100
+++ linux-2.6.16-rc3/kernel/sched.c	2006-02-13 05:11:18.000000000 +0100
@@ -150,8 +150,11 @@
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
 #define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA((p)) + 1) / \
+	MAX_BONUS - 1), NS_MAX_SLEEP_AVG))
+
+#define BONUS_MULTIPLIER(p) \
+	((MAX_BONUS - CURRENT_BONUS(p)) ? : 1)
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -708,7 +711,7 @@
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
-		if (p->mm && p->activated != -1 &&
+		if (p->mm && p->activated != -1 && BONUS_MULTIPLIER(p) *
 			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
@@ -717,7 +720,7 @@
 			 * The lower the sleep avg a task has the more
 			 * rapidly it will rise with sleep time.
 			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+			sleep_time *= BONUS_MULTIPLIER(p);
 
 			/*
 			 * Tasks waking from uninterruptible sleep are
@@ -3009,8 +3012,7 @@
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);
-		} else
-			requeue_task(next, array);
+		}
 	}
 	next->activated = 0;
 switch_tasks:


