Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTBTWjj>; Thu, 20 Feb 2003 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBTWjj>; Thu, 20 Feb 2003 17:39:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22290 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267041AbTBTWjh>; Thu, 20 Feb 2003 17:39:37 -0500
Date: Thu, 20 Feb 2003 14:45:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201438150.1671-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201442500.1671-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:
> 
> Yeah, don't bother to tell me it doesn't work. We need the task pointer to
> include information on _both_ "I'm still using it" (the task itself) _and_
> the "I'm waiting for it" case. So it's not just a matter of moving the
> put_task() thing around, it needs to get the accounting right..

And the way to get the accounting right (I think) is actually truly 
trivial: we should initialize the task count to _two_ at process creation 
time, since we have two users (the parent who will do the wait, and our 
own usage).

This should mean that we'd actually have the process count right, and 
wouldn't need the games we play right now. Ie the patch should be 
something like the appended (which again is totally untested, it might 
easily have serious problems, that's not really the point. The point is 
that reference counting is the only sane memory management policy, and we 
did it wrong).

		Linus

---
===== kernel/fork.c 1.106 vs edited =====
--- 1.106/kernel/fork.c	Tue Feb 18 13:54:44 2003
+++ edited/kernel/fork.c	Thu Feb 20 14:42:25 2003
@@ -217,7 +217,9 @@
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
-	atomic_set(&tsk->usage,1);
+
+	/* One for us, one for whoever does the "release_task()" (usually parent) */
+	atomic_set(&tsk->usage,2);
 	return tsk;
 }
 
===== kernel/sched.c 1.160 vs edited =====
--- 1.160/kernel/sched.c	Thu Feb 20 05:42:54 2003
+++ edited/kernel/sched.c	Thu Feb 20 14:27:23 2003
@@ -581,6 +581,8 @@
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
+	if (prev->state & TASK_DEAD)
+		put_task_struct(prev);
 }
 
 /**

