Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271339AbTGQCug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTGQCug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:50:36 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:45711 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271339AbTGQCuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:50:15 -0400
Message-ID: <3F161269.8040704@sbcglobal.net>
Date: Wed, 16 Jul 2003 22:05:13 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity
References: <200307170030.25934.kernel@kolivas.org>
In-Reply-To: <200307170030.25934.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is much better than 2.5.75-mm3 with your patch.  XMMS seems to work 
well, and applications in X are much more responsive which is more 
important to me anyway.  Part of the sluggishness with 2.5.75-mm3 was 
that the radeon DRM code apparently had problems.  X was using 20-30% of 
the CPU time which probably contributed to the laggy feeling.  Still 
even though 2.5.73-mm3 was crippled, this is also better than any of the 
other 2.5.7x patched kernels I've tried.

Windows are pretty slow to redraw under load though sometimes.  If I 
have gimp scaling an image on workspace 2 and then switch back to 1 it 
can take up to 7 seconds to redraw Mozilla or a terminal.  This seems to 
get better though the longer X has been running, once X has been up for 
~15 minutes I can't get it to occur anymore.

XMMS still skips when my xscreensaver changes to a different 
screensaver, but it's not as bad as before and I'm not expecting 
miracles.  I would rather a program start fast than take forever to 
start just to avoid stalling XMMS.

I'm running a K6-2 400 w/384MB.

I'll keep testing and let you know if I find any problems...

Thanks,

Wes

Con Kolivas wrote:

>O*int patches trying to improve the interactivity of the 2.5/6 scheduler for 
>desktops. It appears possible to do this without moving to nanosecond 
>resolution.
>
>This one makes a massive difference... Please test this to death.
>
>Changes:
>The big change is in the way sleep_avg is incremented. Any amount of sleep 
>will now raise you by at least one priority with each wakeup. This causes 
>massive differences to startup time, extremely rapid conversion to interactive 
>state, and recovery from non-interactive state rapidly as well (prevents X 
>stalling after thrashing around under high loads for many seconds).
>
>The sleep buffer was dropped to just 10ms. This has the effect of causing mild 
>round robinning of very interactive tasks if they run for more than 10ms. The 
>requeuing was changed from (unlikely()) to an ordinary if.. branch as this 
>will be hit much more now.
>
>MAX_BONUS as a #define was made easier to understand
>
>Idle tasks were made slightly less interactive to prevent cpu hogs from 
>becoming interactive on their very first wakeup.
>
>Con
>
>This patch-O6int-0307170012 applies on top of 2.6.0-test1-mm1 and can be found 
>here:
>http://kernel.kolivas.org/2.5
>
>and here:
>
>--- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-16 20:27:32.000000000 +1000
>+++ linux-2.6.0-testck1/kernel/sched.c	2003-07-17 00:13:24.000000000 +1000
>@@ -76,9 +76,9 @@
> #define MIN_SLEEP_AVG		(HZ)
> #define MAX_SLEEP_AVG		(10*HZ)
> #define STARVATION_LIMIT	(10*HZ)
>-#define SLEEP_BUFFER		(HZ/20)
>+#define SLEEP_BUFFER		(HZ/100)
> #define NODE_THRESHOLD		125
>-#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
>+#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
> 
> /*
>  * If a task is 'interactive' then we reinsert it in the active
>@@ -399,7 +399,7 @@ static inline void activate_task(task_t 
> 		 */
> 		if (sleep_time > MIN_SLEEP_AVG){
> 			p->avg_start = jiffies - MIN_SLEEP_AVG;
>-			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
>+			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
> 				MAX_BONUS;
> 		} else {
> 			/*
>@@ -413,14 +413,10 @@ static inline void activate_task(task_t 
> 			p->sleep_avg += sleep_time;
> 
> 			/*
>-			 * Give a bonus to tasks that wake early on to prevent
>-			 * the problem of the denominator in the bonus equation
>-			 * from continually getting larger.
>+			 * Processes that sleep get pushed to a higher priority
>+			 * each time they sleep
> 			 */
>-			if ((runtime - MIN_SLEEP_AVG) < MAX_SLEEP_AVG)
>-				p->sleep_avg += (runtime - p->sleep_avg) *
>-					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
>-					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
>+			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime / MAX_BONUS;
> 
> 			/*
> 			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
>@@ -1311,7 +1307,7 @@ void scheduler_tick(int user_ticks, int 
> 			enqueue_task(p, rq->expired);
> 		} else
> 			enqueue_task(p, rq->active);
>-	} else if (unlikely(p->prio < effective_prio(p))){
>+	} else if (p->prio < effective_prio(p)){
> 		/*
> 		 * Tasks that have lowered their priority are put to the end
> 		 * of the active array with their remaining timeslice
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

