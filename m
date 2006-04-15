Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWDOHFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWDOHFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWDOHFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 03:05:37 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:43664 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751577AbWDOHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 03:05:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sat, 15 Apr 2006 17:05:18 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604132151.22359.kernel@kolivas.org> <200604140616.33370.a1426z@gawab.com>
In-Reply-To: <200604140616.33370.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604151705.18786.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 13:16, Al Boldi wrote:
> Can you try the attached mem-eater passing it the number of kb to be eaten.
>
>         i.e. '# while :; do ./eatm 9999 ; done'
>
> This will print the number of bytes eaten and the timing in ms.
>
> Assuming timeslice=100, adjust the number of kb to be eaten such that the
> timing will be less than timeslice (something like 60ms).  Switch to
> another vt and start another eatm w/ the number of kb yielding more than
> timeslice (something like 140ms).  This eatm should starve completely after
> exceeding timeslice.
>
> This problem also exists in mainline, but it is able to break out of it to
> some extent.  Setting eatm kb to a timing larger than timeslice does not
> exhibit this problem.

Thanks for bringing this to my attention. A while back I had different 
management of forked tasks and merged it with PF_NONSLEEP. Since then I've 
changed the management of NONSLEEP tasks and didn't realise it had adversely 
affected the accounting of forking tasks. This patch should rectify it.

Thanks!
---
 include/linux/sched.h |    1 +
 kernel/sched.c        |    9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.16-ck5/include/linux/sched.h
===================================================================
--- linux-2.6.16-ck5.orig/include/linux/sched.h	2006-04-15 16:32:18.000000000 +1000
+++ linux-2.6.16-ck5/include/linux/sched.h	2006-04-15 16:34:36.000000000 +1000
@@ -961,6 +961,7 @@ static inline void put_task_struct(struc
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
 #define PF_NONSLEEP	0x02000000	/* Waiting on in kernel activity */
 #define PF_ISOREF	0x04000000	/* SCHED_ISO task has used up quota */
+#define PF_FORKED	0x08000000	/* Task just forked another process */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.16-ck5/kernel/sched.c
===================================================================
--- linux-2.6.16-ck5.orig/kernel/sched.c	2006-04-15 16:32:18.000000000 +1000
+++ linux-2.6.16-ck5/kernel/sched.c	2006-04-15 16:34:35.000000000 +1000
@@ -18,7 +18,7 @@
  *  2004-04-02	Scheduler domains code by Nick Piggin
  *  2006-04-02	Staircase scheduling policy by Con Kolivas with help
  *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
- *		Staircase v15
+ *		Staircase v15_test2
  */
 
 #include <linux/mm.h>
@@ -809,6 +809,9 @@ static inline void recalc_task_prio(task
 	else
 		sleep_time = 0;
 
+	if (unlikely(p->flags & PF_FORKED))
+		sleep_time = 0;
+
 	/*
 	 * If we sleep longer than our running total and have not set the
 	 * PF_NONSLEEP flag we gain a bonus.
@@ -847,7 +850,7 @@ static void activate_task(task_t *p, run
 	p->time_slice = p->slice % rr ? : rr;
 	if (!rt_task(p)) {
 		recalc_task_prio(p, now);
-		p->flags &= ~PF_NONSLEEP;
+		p->flags &= ~(PF_NONSLEEP | PF_FORKED);
 		p->systime = 0;
 		p->prio = effective_prio(p);
 	}
@@ -1464,7 +1467,7 @@ void fastcall wake_up_new_task(task_t *p
 
 	/* Forked process gets no bonus to prevent fork bombs. */
 	p->bonus = 0;
-	current->flags |= PF_NONSLEEP;
+	current->flags |= PF_FORKED;
 
 	if (likely(cpu == this_cpu)) {
 		activate_task(p, rq, 1);
-- 
-ck
