Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263519AbTC3FK7>; Sun, 30 Mar 2003 00:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263520AbTC3FK7>; Sun, 30 Mar 2003 00:10:59 -0500
Received: from [12.47.58.124] ([12.47.58.124]:52716 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263519AbTC3FK6>; Sun, 30 Mar 2003 00:10:58 -0500
Date: Sat, 29 Mar 2003 21:23:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Message-Id: <20030329212330.225a96b6.akpm@digeo.com>
In-Reply-To: <1048996723.3058.41.camel@iso-8590-lx.zeusinc.com>
References: <3E8610EA.8080309@telia.com>
	<1048987260.679.7.camel@teapot>
	<1048989922.13757.20.camel@localhost>
	<200303301233.03803.kernel@kolivas.org>
	<1048992365.13757.23.camel@localhost>
	<1048996723.3058.41.camel@iso-8590-lx.zeusinc.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2003 05:22:10.0091 (UTC) FILETIME=[50270FB0:01C2F67C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler <ttsig@tuxyturvy.com> wrote:
>
> On my system I get a starvation issue with just about any CPU intensive
> task.  For example if create a bzip'd tar file from the linux kernel
> source with the command:
> 
> tar cvp linux | bzip2 -9 > linux.tar.bz2
> 

Ingo has determined that Linus's backboost trick is causing at least some
of these problems. Please test and report upon the below patch.

I have another workload which is showing starvation with or without this
patch - it is the bitkeeper verification step in a `bk clone' on a
uniprocessor kernel.  Still poking at that one.






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

