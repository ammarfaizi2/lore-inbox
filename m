Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289645AbSAJT7V>; Thu, 10 Jan 2002 14:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289647AbSAJT7M>; Thu, 10 Jan 2002 14:59:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:38924 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289645AbSAJT7B>;
	Thu, 10 Jan 2002 14:59:01 -0500
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Mike Kravetz <kravetz@us.ibm.com>, Anton Blanchard <anton@samba.org>,
        george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 15:01:22 -0500
Message-Id: <1010692888.5338.319.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 09:19, Ingo Molnar wrote:

>  - Kevin O'Connor, Robert Love: fix locking order bug in set_cpus_allowed()
>    which bug is able to cause boot-time lockups on SMP systems.

Along the same lines as the above, note this code snippet from
try_to_wake_up:

	lock_task_rq(rq, p, flags);
	p->state = TASK_RUNNING;
	if (!p->array) {
		if (0 && !rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {
			spin_lock(&this_rq()->lock);
			p->cpu = smp_processor_id();
			activate_task(p, this_rq());
			spin_unlock(&this_rq()->lock);
		} else { ... }

First, H1 added the 0 there ... ???

Second, prior to the change, I wonder whether the
(smp_processor_id() < p->cpu)) is inverted.  We've already locked p's
runqueue above.  So this branch, if taken, will lock the current
runqueue -- but it checks if current's cpu id is _less_ then p's!  Thus
we lock greater to lesser.  Would a proper change be:

diff -urN linux-2.5.2-pre10-H1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.2-pre10-H1/kernel/sched.c	Thu Jan 10 14:56:06 2002
+++ linux/kernel/sched.c	Thu Jan 10 14:56:21 2002
@@ -383,7 +383,7 @@
 	lock_task_rq(rq, p, flags);
 	p->state = TASK_RUNNING;
 	if (!p->array) {
-		if (0 && !rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {
+		if (!rt_task(p) && synchronous && (smp_processor_id() > p->cpu)) {
 			spin_lock(&this_rq()->lock);
 			p->cpu = smp_processor_id();
 			activate_task(p, this_rq());

Note I removed the 0, which may or not be your intention (do you want
that code branch there at all?)  My point is swapping the
lesser-than-sign for a greater-than so that we now lock this_rq only if
it is _greater_ than p's.

Keep 'em coming ;)

	Robert Love

