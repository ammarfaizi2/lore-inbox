Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbTFVVJs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbTFVVJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:09:48 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:30593 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265893AbTFVVJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:09:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Mon, 23 Jun 2003 07:24:39 +1000
User-Agent: KMail/1.5.2
Cc: Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306230158.45201.kernel@kolivas.org> <1056298486.601.25.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056298486.601.25.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X6h9+CxoOWg2d7J"
Message-Id: <200306230724.39194.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_X6h9+CxoOWg2d7J
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 23 Jun 2003 02:14, Felipe Alfaro Solana wrote:
> On Sun, 2003-06-22 at 17:58, Con Kolivas wrote:
> > On Mon, 23 Jun 2003 01:40, Felipe Alfaro Solana wrote:
> > > On Sun, 2003-06-22 at 15:45, Con Kolivas wrote:
> > > > > Feel free to test it and comment. Things to look for - the dreaded
> > > > > audio skip under load, and X remaining interactive during sustain=
ed
> > > > > use under load.
> > >
> > > I must say this seems to be getting better, but I still prefer Mike's
> > > patches. With the latest sleep decay patch and 2.5.72-mm3, I can still
> > > easily starve XMMS audio for a long time (~5 seconds) on my 700Mhz
> > > Pentium III lapto=F1 (running RHL9 and KDE 3.1.2) simply by running
> > > "while true; do a=3D2; done" on a konsole window. Dragging a window f=
ast
> > > enough also starves XMMS for ~5 seconds just until the scheduler
> > > adjusts the priorities.
> > >
> > > XMMS is running with an effective priority of 15 (that's what top
> > > says). "while true; do a=3D2; done" starts with a priority of 15 (whi=
ch
> > > causes XMMS to stop playing sound), then it is detected as a CPU hog
> > > and every second its priority is increased by one. When its priority
> > > reaches 20, XMMS starts playing again.
> > >
> > > When I move windows around fast enough. the X server starts with a
> > > priority of 15, starving XMMS. If I keep moving windows around for a
> > > long time, X's priority starts increasing by one, until it reaches 20.
> > > At this moment, it stops disturbing XMMS audio playback.
> > >
> > > I've been playing with scheduler parameters, mainly by reducing
> > > MAX_SLEEP_AVG to (HZ) and STARVATION_LIMIT to (HZ). This seems to help
> > > a lot, although I can still make XMMS skip sound every once a bit.
> > > However, mplayer is a really hard one: I have been unable to make it
> > > skip sound yet.
> >
> > Yes Mike's patches are definitely better. My patches are designed for t=
he
> > 2.4-ck patchset which has other workarounds that augment this patch;
> > however these workarounds are harder to stomach for mainstream kernels
> > (read nasty hacks). I thought I'd offer the not so nasty sleep_decay
> > patch in 2.5 form for perusal and comments since people are more willing
> > to test 2.5 patches.
>
> Well, it's nice to know.
> I'm willing to test nearly any 2.5 patch. So, I'll gladly test any other
> ideas or patches you (or others) might have.

ANY?

Ok well I guess I have to give away my secret then. This is the change that=
=20
turns 2.5 into a desktop kernel. Note the very slight change to Ingo's addo=
n=20
;-)

Con

--Boundary-00=_X6h9+CxoOWg2d7J
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch-o1int-9396230721"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-o1int-9396230721"

diff -Naurp linux-2.5.72/include/linux/sched.h linux-2.5.72-test/include/linux/sched.h
--- linux-2.5.72/include/linux/sched.h	2003-06-18 22:47:19.000000000 +1000
+++ linux-2.5.72-test/include/linux/sched.h	2003-06-19 20:56:18.000000000 +1000
@@ -332,6 +332,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long best_sleep_avg;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
--- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-23 07:21:07.000000000 +1000
@@ -72,7 +72,8 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(2 * HZ)
+#define BEST_SLEEP_DECAY	(10)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -313,12 +314,22 @@ static inline void enqueue_task(struct t
  */
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int bonus, prio, scale = MAX_SLEEP_AVG / 2;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	bonus = p->best_sleep_avg/BEST_SLEEP_DECAY;
+	if (bonus > MAX_SLEEP_AVG) bonus = MAX_SLEEP_AVG;
+
+	bonus -= scale;
+	if (bonus < 0) neg_flag = -1;
+	bonus *= bonus;
+	bonus /= scale;
+	bonus *= neg_flag;
+	bonus += scale;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*bonus/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -371,6 +382,8 @@ static inline void activate_task(task_t 
 			sleep_avg = MAX_SLEEP_AVG;
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
+			if ((sleep_avg * BEST_SLEEP_DECAY) > p->best_sleep_avg)
+				p->best_sleep_avg = sleep_avg * (BEST_SLEEP_DECAY + 1) - 1;
 			p->prio = effective_prio(p);
 		}
 	}
@@ -551,6 +564,7 @@ void wake_up_forked_process(task_t * p)
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->best_sleep_avg = p->sleep_avg * (BEST_SLEEP_DECAY + 1) - 1;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -1200,6 +1214,8 @@ void scheduler_tick(int user_ticks, int 
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
+	if (p->best_sleep_avg)
+		p->best_sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1229,6 +1245,27 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else {
+		/*
+		 * Prevent a too long timeslice allowing a task to monopolize
+		 * the CPU. We do this by splitting up the timeslice into
+		 * smaller pieces.
+		 *
+		 * Note: this does not mean the task's timeslices expire or
+		 * get lost in any way, they just might be preempted by
+		 * another task of equal priority. (one with higher
+		 * priority would have preempted this task already.) We
+		 * requeue this task to the end of the list on this priority
+		 * level, which is in essence a round-robin of tasks with
+		 * equal priority.
+		 */
+		if (!(p->time_slice % MIN_TIMESLICE) &&
+			       		(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
 	}
 out_unlock:
 	spin_unlock(&rq->lock);

--Boundary-00=_X6h9+CxoOWg2d7J--

