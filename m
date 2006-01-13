Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWAMBNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWAMBNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWAMBNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:13:37 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:24216 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030288AbWAMBNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:13:36 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Fri, 13 Jan 2006 12:13:11 +1100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20051227190918.65c2abac@localhost> <200512281027.00252.kernel@kolivas.org> <20051230145221.301faa40@localhost>
In-Reply-To: <20051230145221.301faa40@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1906553.S6PcMfZ0j7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601131213.14832.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1906553.S6PcMfZ0j7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 31 December 2005 00:52, Paolo Ornati wrote:
> WAS: [SCHED] Totally WRONG prority calculation with specific test-case
> (since 2.6.10-bk12)
> http://lkml.org/lkml/2005/12/27/114/index.html
>
> On Wed, 28 Dec 2005 10:26:58 +1100
>
> Con Kolivas <kernel@kolivas.org> wrote:
> > The issue is that the scheduler interactivity estimator is a state
> > machine and can be fooled to some degree, and a cpu intensive task that
> > just happens to sleep a little bit gets significantly better priority
> > than one that is fully cpu bound all the time. Reverting that change is
> > not a solution because it can still be fooled by the same process
> > sleeping lots for a few seconds or so at startup and then changing to t=
he
> > cpu mostly-sleeping slightly behaviour. This "fluctuating" behaviour is
> > in my opinion worse which is why I removed it.
>
> Trying to find a "as simple as possible" test case for this problem
> (that I consider a BUG in priority calculation) I've come up with this
> very simple program:

Hi Paolo.

Can you try the following patch on 2.6.15 please? I'm interested in how
adversely this affects interactive performance as well as whether it helps
your test case.

Thanks,
Con



=2D--
 include/linux/sched.h |    9 +++++-
 kernel/sched.c        |   72 ++++++++++++++++++++++-----------------------=
=2D----
 2 files changed, 41 insertions(+), 40 deletions(-)

Index: linux-2.6.15/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/include/linux/sched.h
+++ linux-2.6.15/include/linux/sched.h
@@ -683,6 +683,13 @@ static inline void prefetch_stack(struct
 struct audit_context;		/* See audit.c */
 struct mempolicy;
=20
+enum sleep_type {
+	SLEEP_NORMAL,
+	SLEEP_NONINTERACTIVE,
+	SLEEP_INTERACTIVE,
+	SLEEP_INTERRUPTED,
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -704,7 +711,7 @@ struct task_struct {
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
=2D	int activated;
+	enum sleep_type sleep_type;
=20
 	unsigned long policy;
 	cpumask_t cpus_allowed;
Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -751,31 +751,22 @@ static int recalc_task_prio(task_t *p, u
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
=2D		if (p->mm && p->activated !=3D -1 &&
+		if (p->mm && p->sleep_type !=3D SLEEP_NONINTERACTIVE &&
 			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
 		} else {
+
 			/*
 			 * The lower the sleep avg a task has the more
=2D			 * rapidly it will rise with sleep time.
+			 * rapidly it will rise with sleep time. This enables
+			 * tasks to rapidly recover to a low latency priority.
+			 * If a task was sleeping with the noninteractive
+			 * label do not apply this non-linear boost
 			 */
=2D			sleep_time *=3D (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
=2D
=2D			/*
=2D			 * Tasks waking from uninterruptible sleep are
=2D			 * limited in their sleep_avg rise as they
=2D			 * are likely to be waiting on I/O
=2D			 */
=2D			if (p->activated =3D=3D -1 && p->mm) {
=2D				if (p->sleep_avg >=3D INTERACTIVE_SLEEP(p))
=2D					sleep_time =3D 0;
=2D				else if (p->sleep_avg + sleep_time >=3D
=2D						INTERACTIVE_SLEEP(p)) {
=2D					p->sleep_avg =3D INTERACTIVE_SLEEP(p);
=2D					sleep_time =3D 0;
=2D				}
=2D			}
+			if (p->sleep_type !=3D SLEEP_NONINTERACTIVE || p->mm)
+				sleep_time *=3D
+					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
=20
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -818,11 +809,7 @@ static void activate_task(task_t *p, run
 	if (!rt_task(p))
 		p->prio =3D recalc_task_prio(p, now);
=20
=2D	/*
=2D	 * This checks to make sure it's not an uninterruptible task
=2D	 * that is now waking up.
=2D	 */
=2D	if (!p->activated) {
+	if (p->sleep_type !=3D SLEEP_NONINTERACTIVE) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -831,13 +818,13 @@ static void activate_task(task_t *p, run
 		 * on a CPU, first time around:
 		 */
 		if (in_interrupt())
=2D			p->activated =3D 2;
+			p->sleep_type =3D SLEEP_INTERRUPTED;
 		else {
 			/*
 			 * Normal first-time wakeups get a credit too for
 			 * on-runqueue time, but it will be weighted down:
 			 */
=2D			p->activated =3D 1;
+			p->sleep_type =3D SLEEP_INTERACTIVE;
 		}
 	}
 	p->timestamp =3D now;
@@ -1356,22 +1343,23 @@ out_activate:
 	if (old_state =3D=3D TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
=2D		 * Tasks on involuntary sleep don't earn
=2D		 * sleep_avg beyond just interactive state.
+		 * Tasks waking from uninterruptible sleep are likely
+		 * to be sleeping involuntarily on I/O and are otherwise
+		 * cpu bound so label them as noninteractive.
 		 */
=2D		p->activated =3D -1;
=2D	}
+		p->sleep_type =3D SLEEP_NONINTERACTIVE;
+	} else
=20
 	/*
 	 * Tasks that have marked their sleep as noninteractive get
=2D	 * woken up without updating their sleep average. (i.e. their
=2D	 * sleep is handled in a priority-neutral manner, no priority
=2D	 * boost and no penalty.)
+	 * woken up with their sleep average not weighted in an
+	 * interactive way.
 	 */
=2D	if (old_state & TASK_NONINTERACTIVE)
=2D		__activate_task(p, rq);
=2D	else
=2D		activate_task(p, rq, cpu =3D=3D this_cpu);
+		if (old_state & TASK_NONINTERACTIVE)
+			p->sleep_type =3D SLEEP_NONINTERACTIVE;
+
+
+	activate_task(p, rq, cpu =3D=3D this_cpu);
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
@@ -2938,6 +2926,12 @@ EXPORT_SYMBOL(sub_preempt_count);
=20
 #endif
=20
+static inline int interactive_sleep(enum sleep_type sleep_type)
+{
+	return (sleep_type =3D=3D SLEEP_INTERACTIVE ||
+		sleep_type =3D=3D SLEEP_INTERRUPTED);
+}
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -3063,12 +3057,12 @@ go_idle:
 	queue =3D array->queue + idx;
 	next =3D list_entry(queue->next, task_t, run_list);
=20
=2D	if (!rt_task(next) && next->activated > 0) {
+	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
 		unsigned long long delta =3D now - next->timestamp;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta =3D 0;
=20
=2D		if (next->activated =3D=3D 1)
+		if (next->sleep_type =3D=3D SLEEP_INTERACTIVE)
 			delta =3D delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
=20
 		array =3D next->array;
@@ -3081,7 +3075,7 @@ go_idle:
 		} else
 			requeue_task(next, array);
 	}
=2D	next->activated =3D 0;
+	next->sleep_type =3D SLEEP_NORMAL;
 switch_tasks:
 	if (next =3D=3D rq->idle)
 		schedstat_inc(rq, sched_goidle);

--nextPart1906553.S6PcMfZ0j7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDxv6qZUg7+tp6mRURAhUfAJ4lU6Tq6gl3EEBg7Lf2QIka6lGmMwCeOKxZ
AvZfeSoPDFDaJdyZ210O4Cw=
=OQZ7
-----END PGP SIGNATURE-----

--nextPart1906553.S6PcMfZ0j7--
