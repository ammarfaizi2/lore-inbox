Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbTDGBNC (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDGBNC (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:13:02 -0400
Received: from [12.47.58.55] ([12.47.58.55]:22228 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263165AbTDGBNA (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 21:13:00 -0400
Date: Sun, 6 Apr 2003 18:24:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
Message-Id: <20030406182435.5a243297.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 01:24:29.0930 (UTC) FILETIME=[6FBD2CA0:01C2FCA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> This was not reproduceable with 2.4.18-3 nor with 2.5.66 and the 
> following patch applied;
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/sched-interactivity-backboost-revert.patch
> 

There have been multiple reports of this patch fixing starvation problems.

We need to either apply it or fix up the problem by other means.



From: Ingo Molnar <mingo@elte.hu>

the patch below fixes George's setiathome problems (as expected).  It
essentially turns off Linus' improvement, but i dont think it can be fixed
sanely.

the problem with setiathome is that it displays something every now and
then - so it gets a backboost from X, and hovers at a relatively high
priority.



 kernel/sched.c |   13 +------------
 1 files changed, 1 insertion(+), 12 deletions(-)

diff -puN kernel/sched.c~sched-interactivity-backboost-revert kernel/sched.c
--- 25/kernel/sched.c~sched-interactivity-backboost-revert	2003-03-28 22:30:08.000000000 -0800
+++ 25-akpm/kernel/sched.c	2003-03-28 22:30:08.000000000 -0800
@@ -379,19 +379,8 @@ static inline int activate_task(task_t *
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG) {
-			if (!in_interrupt()) {
-				sleep_avg += current->sleep_avg - MAX_SLEEP_AVG;
-				if (sleep_avg > MAX_SLEEP_AVG)
-					sleep_avg = MAX_SLEEP_AVG;
-
-				if (current->sleep_avg != sleep_avg) {
-					current->sleep_avg = sleep_avg;
-					requeue_waker = 1;
-				}
-			}
+		if (sleep_avg > MAX_SLEEP_AVG)
 			sleep_avg = MAX_SLEEP_AVG;
-		}
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
 			p->prio = effective_prio(p);

_

