Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTGRKZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270201AbTGRKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:25:24 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:37285
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270200AbTGRKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:25:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wiktor Wodecki <wodecki@gmx.net>, Wiktor Wodecki <wodecki@gmx.de>,
       Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Date: Fri, 18 Jul 2003 20:43:05 +1000
User-Agent: KMail/1.5.2
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <20030718103105.GE622@gmx.de>
In-Reply-To: <20030718103105.GE622@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307182043.06029.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 20:31, Wiktor Wodecki wrote:
> On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
> > That _might_ (add salt) be priorities of kernel threads dropping too low.
> >
> > I'm also seeing occasional total stalls under heavy I/O in the order of
> > 10-12 seconds (even the disk stops).  I have no idea if that's something
> > in mm or the scheduler changes though, as I've yet to do any isolation
> > and/or tinkering.  All I know at this point is that I haven't seen it in
> > stock yet.
>
> I've seen this too while doing a huge nfs transfer from a 2.6 machine to
> a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
> which were recently, might be the scheduler, tho. Ah, and it is fully
> reproducable.

Well I didn't want to post this yet because I'm not sure if it's a good 
workaround yet but it looks like a reasonable compromise, and since you have a 
testcase it will be interesting to see if it addresses it. It's possible that 
a task is being requeued every millisecond, and this is a little smarter. It 
allows cpu hogs to run for 100ms before being round robinned, but shorter for 
interactive tasks. Can you try this O7 which applies on top of O6.1 please:

available here:
http://kernel.kolivas.org/2.5

and here:

--- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-17 19:59:16.000000000 +1000
+++ linux-2.6.0-testck1/kernel/sched.c	2003-07-18 00:10:55.000000000 +1000
@@ -1310,10 +1310,12 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
-	} else if (p->prio < effective_prio(p)){
+	} else if (!((task_timeslice(p) - p->time_slice) %
+		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG)))){
 		/*
-		 * Tasks that have lowered their priority are put to the end
-		 * of the active array with their remaining timeslice
+		 * Running tasks get requeued with their remaining timeslice
+		 * after a period proportional to how cpu intensive they are to
+		 * minimise the duration one interactive task can starve another
 		 */
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);

