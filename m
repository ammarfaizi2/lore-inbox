Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWEQIXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWEQIXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEQIXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:23:51 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:693 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932481AbWEQIXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:23:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tim.c.chen@linux.intel.com
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Wed, 17 May 2006 18:23:23 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       Mike Galbraith <efault@gmx.de>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com> <200605160945.13157.kernel@kolivas.org> <1147822331.4859.37.camel@localhost.localdomain>
In-Reply-To: <1147822331.4859.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2156
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200605171823.24476.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 09:32, Tim Chen wrote:
> On Tue, 2006-05-16 at 09:45 +1000, Con Kolivas wrote:
> > Yes it's only designed to detect something that has been asleep for an
> > arbitrary long time and "categorised as idle"; it is not supposed to be a
> > priority stepping stone for everything, in this case at MAX_BONUS-1. Mike
> > proposed doing this instead, but it was never my intent.
>
> It seems like just one sleep longer than INTERACTIVE_SLEEP is needed
> kick the priority of a process all the way to MAX_BONUS-1 and boost the
> sleep_avg, regardless of what the prior sleep_avg was.
>
> So if there is a cpu hog that has long sleeps occasionally, once it woke
> up, its priority will get boosted close to maximum, likely starving out
> other processes for a while till its sleep_avg gets reduced.  This
> behavior seems like something to avoid according to the original code
> comment.  Are we boosting the priority too quickly?

Two things strike me here. I'll explain them in the patch below.

How's this look?
---
The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
and not explicit enough. The sleep boost is not supposed to be any larger
than without this code and the comment is not clear enough about what exactly
it does, just the reason it does it.

There is a ceiling to the priority beyond which tasks that only ever sleep
for very long periods cannot surpass.

Opportunity to micro-optimise and re-use the ceiling variable.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

Index: linux-2.6.17-rc4-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-05-17 15:57:49.000000000 +1000
+++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-17 18:19:29.000000000 +1000
@@ -904,20 +904,14 @@ static int recalc_task_prio(task_t *p, u
 	}
 
 	if (likely(sleep_time > 0)) {
-		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
-		 * level that makes them just interactive priority to stay
-		 * active yet prevent them suddenly becoming cpu hogs and
-		 * starving other processes.
-		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
+		unsigned long ceiling = INTERACTIVE_SLEEP(p);
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
+		if (p->mm && sleep_time > ceiling && p->sleep_avg < ceiling) {
+			/*
+			 * Prevents user tasks from achieving best priority
+			 * with one single large enough sleep.
+			 */
+			p->sleep_avg = ceiling;
 		} else {
 			/*
 			 * Tasks waking from uninterruptible sleep are
@@ -925,12 +919,12 @@ static int recalc_task_prio(task_t *p, u
 			 * are likely to be waiting on I/O
 			 */
 			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
+				if (p->sleep_avg >= ceiling)
 					sleep_time = 0;
 				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
+					 ceiling) {
+						p->sleep_avg = ceiling;
+						sleep_time = 0;
 				}
 			}
 
-- 
-ck
