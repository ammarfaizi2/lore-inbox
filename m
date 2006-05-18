Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWERFwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWERFwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWERFwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:52:47 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:26538 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751222AbWERFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:52:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 15:52:19 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4t16i2$142pji@orsmga001.jf.intel.com> <200605181138.26399.kernel@kolivas.org> <1147931064.7514.39.camel@homer>
In-Reply-To: <1147931064.7514.39.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181552.19868.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 15:44, Mike Galbraith wrote:
> On Thu, 2006-05-18 at 11:38 +1000, Con Kolivas wrote:
> > I just want to formalise the relationship between the ceiling, nice
> > value and INTERACTIVE_SLEEP and make the comment clear enough to be
> > understood.
>
> Oh yeah, that reminded me...
>
> INTERACTIVE_SLEEP(p) for nice(>=16) tasks is > NS_MAX_SLEEP_AVG.
> CURRENT_BONUS(p) if it took the long sleep path can end up being 11,
> which will lead to Ka-[fword]-BOOM in scheduler_tick() for an SMP box.
> See TIMESLICE_GRANULARITY(p).  (btdt;)

Thanks. This updated one fixes that and clears up the remaining mystery of
why the ceiling is the size it is in the comments.

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
 kernel/sched.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

Index: linux-2.6.17-rc4-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-05-17 15:57:49.000000000 +1000
+++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-18 15:48:47.000000000 +1000
@@ -905,19 +905,18 @@ static int recalc_task_prio(task_t *p, u
 
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
-		 * level that makes them just interactive priority to stay
-		 * active yet prevent them suddenly becoming cpu hogs and
-		 * starving other processes.
+		 * This ceiling is set to the lowest priority that would allow
+		 * a task to be reinserted into the active array on timeslice
+		 * completion.
 		 */
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
@@ -925,12 +924,12 @@ static int recalc_task_prio(task_t *p, u
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
 
@@ -944,9 +943,9 @@ static int recalc_task_prio(task_t *p, u
 			 */
 			p->sleep_avg += sleep_time;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
 		}
+		if (p->sleep_avg > NS_MAX_SLEEP_AVG)
+			p->sleep_avg = NS_MAX_SLEEP_AVG;
 	}
 
 	return effective_prio(p);

-- 
-ck
