Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272137AbTHNCoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTHNCoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:44:12 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:19057 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272137AbTHNCoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:44:02 -0400
Message-ID: <3F3AF781.2090007@sbcglobal.net>
Date: Wed, 13 Aug 2003 21:44:17 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O15int for interactivity
References: <200308122226.11557.kernel@kolivas.org>
In-Reply-To: <200308122226.11557.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some pretty bad starvation on 2.6.0-test3-mm1...

Let's say I'm compiling something on one of the consoles and then I 
decide to boot into KDE.  Well, I haven't bothered to fix it yet, but 
xosview is in my session, and it doesn't work with the new kernel.  So 
it just sits and hogs the CPU.  That's not a real problem, but with this 
kernel it really does hog the CPU.  At first, I have blocks of 5 seconds 
or so where I can't do anything (the mouse won't move and the screen 
won't redraw in X [and I can't get to a terminal during those busy 
times]), and then everything goes real smooth again.  If I let xosview 
do whatever it's doing and don't kill it, the machine will become 
unresponsive in under one minute from launching xosview.  At that point, 
I have to wait (I didn't time it precisely) a minute or more for the 
machine to show any signs of life.  When the screen starts redrawing, it 
processes a few of my keystrokes, draws a little bit of the windows and 
then locks up again for another minute.  If I'm lucky, I can get to a 
terminal to kill xosview, but the first time I just rebooted by hitting 
the power button.  I have acpid setup to reboot when it gets the power 
button event.  It seems compiling and then starting xosview makes this 
worse, it doesn't seem to be that bad unless I'm doing something else 
that's CPU-intensive.  It still jerks around, but not bad and it seems 
to get better the longer xosview runs (if it can be called that ;-).

It's not just X that is slow either, if I manage to get back to the 
console I find that a running configure is at the same spot it was when 
xosview started.  In fact, the stopping configures have reminded me 
several times that xosview had started so I could kill it before 
switching to vt7.  Typing is equally difficult and I can expect to wait 
30-45 seconds for even parts of my typing appear on the screen.  
Luckily, there are periods of time every minute or so when other 
processes get at the CPU...for 10-20 seconds, which happens to be just 
enough time to kill it from a console.   But it takes a long time for an 
xterm start under these conditions....and I don't always make it out of 
X on the first try.

I haven't ever let it get to the point I needed to resort to the power 
button since, but it took three minutes before the computer even beeped 
indicating that the shutdown had started and another four before X 
finally closed.  Even then by the time I finally got to the console all 
I got to see was the "killing <mumble>...", and then "rebooting now" (or 
whatever the kernel flashes before a reboot) messages. 

This didn't happen on 2.6.0-test2-mm1, but...I compiled test3 with gcc 
3.3.1, and the earlier kernels with 2.95.3.  I don't know if that would 
cause this problem...

I'll try this patch and see if it makes any difference.  If not, I 
probably should try compiling 2.6.0-test2-mm1 with 3.3.1 and see if that 
causes the same behavior.  I'll let you know how it goes.

Earlier versions of your patch were smoother, but besides this problem, 
it's pretty good.

-Wes

Con Kolivas wrote:

>This patch addresses the problem of tasks that preempt their children when 
>they're forking, wasting cpu cycles until they get demoted to a priority where 
>they no longer preempt their child. Although this has been said to be a design 
>flaw in the applications, it can cause sustained periods of starvation due to 
>this coding problem, and the more I looked, the more examples I found of this 
>happening.
>
>Tasks now cannot preempt their own children. This speeds up the startup of 
>child applications (eg pgp signed email).
>
>This change has allowed tasks to stay at higher priority for much longer so 
>the sleep avg decay of high credit tasks has been changed to match the rate of 
>rise during periods of sleep (which I wanted to do originally but was limited 
>by the first problem). This makes for much more sustained interactivity at 
>extreme loads, and much less X jerkiness.
>
>Con
>
>Patch against 2.6.0-test3-mm1:
>
>--- linux-2.6.0-test3-mm1-O14.1/kernel/sched.c	2003-08-12 22:04:13.000000000 +1000
>+++ linux-2.6.0-test3-mm1/kernel/sched.c	2003-08-12 22:03:47.000000000 +1000
>@@ -620,8 +620,13 @@ repeat_lock_task:
> 				__activate_task(p, rq);
> 			else {
> 				activate_task(p, rq);
>-				if (TASK_PREEMPTS_CURR(p, rq))
>-					resched_task(rq->curr);
>+				/*
>+				 * Parents are not allowed to preempt their
>+				 * children
>+				 */
>+				if (TASK_PREEMPTS_CURR(p, rq) &&
>+					p != rq->curr->parent)
>+						resched_task(rq->curr);
> 			}
> 			success = 1;
> 		}
>@@ -1124,7 +1129,7 @@ static inline void pull_task(runqueue_t 
> 	 * Note that idle threads have a prio of MAX_PRIO, for this test
> 	 * to be always true for them.
> 	 */
>-	if (TASK_PREEMPTS_CURR(p, this_rq))
>+	if (TASK_PREEMPTS_CURR(p, this_rq) && p != this_rq->curr->parent)
> 		set_need_resched();
> }
> 
>@@ -1493,9 +1498,8 @@ need_resched:
> 	 * priority bonus
> 	 */
> 	if (HIGH_CREDIT(prev))
>-		run_time /= (MAX_BONUS + 1 -
>-			(NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
>-			MAX_SLEEP_AVG));
>+		run_time /= ((NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
>+				MAX_SLEEP_AVG) ? : 1);
> 
> 	spin_lock_irq(&rq->lock);
> 
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

