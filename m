Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTH1MT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTH1MT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:19:58 -0400
Received: from nice-1-a7-62-147-77-216.dial.proxad.net ([62.147.77.216]:6406
	"EHLO monpc") by vger.kernel.org with ESMTP id S263954AbTH1MTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:19:53 -0400
From: Guillaume Chazarain <guichaz@yahoo.fr>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2003 14:23:45 +0200
X-Priority: 3 (Normal)
Message-Id: <3ZVFAMJ08VU5ZOUPLICZU53ON641.3f4df451@monpc>
Subject: Re: [PATCH]O18.1int
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con (and linux-kernel),

I noticed a regression wrt 2.6.0-test4 and 2.4.22 with this
big context-switcher:

#include <unistd.h>

#define COUNT (1024 * 1024)

int main(void)
{
    char buffer = 0;
    int fd[2], i;

    pipe(fd);

    if (fork()) {
        for (i = 0; i < COUNT; i++)
            write(fd[1], &buffer, 1);
    } else {
        for (i = 0; i < COUNT; i++)
            read(fd[0], &buffer, 1);
    }

    return 0;
}


Here are the timing results on my Pentium3 450:
Nothing else is running, no X.
vmstat(1) shows 200000 context-switchs per second.

2.4.22:
User time (seconds): 0.42
System time (seconds): 1.04
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.89
Minor (reclaiming a frame) page faults: 15

2.6.0-test4:
User time (seconds): 0.45
System time (seconds): 1.70
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:04.30
Minor (reclaiming a frame) page faults: 17

2.6.0-test4-nobonus:
User time (seconds): 0.42
System time (seconds): 1.26
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:03.24
Minor (reclaiming a frame) page faults: 17

2.6.0-test4-O18.1:
User time (seconds): 0.49
System time (seconds): 2.67
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:06.24
Minor (reclaiming a frame) page faults: 17

2.6.0-test4-O18.1-nobonus:
User time (seconds): 0.40
System time (seconds): 1.22
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:03.18
Minor (reclaiming a frame) page faults: 17

With -nobonus I mean this dumb patch that keeps the scheduling
overhead but not the computed bonus:

--- linux-2.6.0-test4-ck/kernel/sched.c.old
+++ linux-2.6.0-test4-ck/kernel/sched.c
@@ -349,6 +349,9 @@ static int effective_prio(task_t *p)
 
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
+	if (p->pid > 100)
+		bonus = 0;
+
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;



And the top(1) results are:

2.6.0-test4:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  586 g         23   0  1336  260 1308 R 51.2  0.1   0:02.85 a.out (writer)
  587 g         25   0  1336  260 1308 R 47.3  0.1   0:02.74 a.out (reader)

2.6.0-test4-ck:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  717 g         16   0  1336  260 1308 S 50.6  0.1   0:02.49 a.out (writer)
  718 g         25   0  1336  260 1308 R 49.6  0.1   0:02.51 a.out (reader)



My conclusion is that the regression is not because of an increased
overhead but because of wrong scheduling decisions in this case.
It runs at full speed when the reader and writer are at the same
priority.
Maybe this is also the case in the volano benchmark?

Anyway, we could reduce the overhead in schedule() by doing the sched_clock()
stuff only in the (prev != next) case.


BTW I am also interested in the patch below that prevents C-Z'ed processes
from gaining interactivity bonus.

--- linux-2.6.0-test4-ck/kernel/sched.c.old
+++ linux-2.6.0-test4-ck/kernel/sched.c
@@ -449,8 +449,10 @@ static void recalc_task_prio(task_t *p, 
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long long now = sched_clock();
+	int sleeping = p->state & (TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE);
 
-	recalc_task_prio(p, now);
+	if (likely(sleeping))
+		recalc_task_prio(p, now);
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task




Thanks for reading.

Guillaume






