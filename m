Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277531AbRJVS17>; Mon, 22 Oct 2001 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277554AbRJVS1u>; Mon, 22 Oct 2001 14:27:50 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:14720 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S277531AbRJVS1q> convert rfc822-to-8bit; Mon, 22 Oct 2001 14:27:46 -0400
From: Roberto Ragusa <robertoragusa@technologist.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: linux-kernel@vger.kernel.org
Date: Mon, 22 Oct 2001 20:16:09 +0200
Message-ID: <yam8695.480.153891320@mail.inwind.it>
X-Mailer: YAM 2.2 [060] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch
Subject: Re: [PATCH] A nicer nice scheduling
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

> Roberto Ragusa wrote: 
> > please consider including this patch in the main kernel. 
> > It was proposed on 11/04/2001 by Rik van Riel 
> > ([test-PATCH] Re: [QUESTION] 2.4.x nice level) 
> 
> I think it's simpler to change NICE_TO_TICKS() macro in sched.c 

I'm afraid it isn't.
We don't have enough resolution, if I understand sched.c correctly.

On 2.4.12 and with HZ=100 (common case) NICE_TO_TICKS gives:

nice | ticks
------------
 -20 |  11
 -19 |  10
 -18 |  10
 -17 |  10
 -16 |  10
 -15 |   9
 -14 |   9
 -13 |   9
 -12 |   9
 -11 |   8
 -10 |   8
 -9  |   8
 -8  |   8
 -7  |   7
 -6  |   7
 -5  |   7
 -4  |   7
 -3  |   6
 -2  |   6
 -1  |   6
  0  |   6
  1  |   5
  2  |   5
  3  |   5
  4  |   5
  5  |   4
  6  |   4
  7  |   4
  8  |   4
  9  |   3
 10  |   3
 11  |   3
 12  |   3
 13  |   2
 14  |   2
 15  |   2
 16  |   2
 17  |   1
 18  |   1
 19  |   1

So nice=19 vs. nice=0 has a 1:6 CPU ratio ( 14% - 86% ).

As we can't decrease 1 (n=19), we could increase 6 (n=0), with a more
aggressive linear dependence. But this way the time-slice would also
increase.

To balance this effect, we could also increase HZ (ref. TICK_SCALE).
But this way an n=19 process would run frequently and for a very little
time (with greater process switching overhead).

The right solution is IMHO to give an n=19 process less time and less
often than an n=0 process.
The patch from Rik gives:

nice | ticks | less often factor | equivalent ticks
---------------------------------------------------
 -20 |  11   |        1          |     11
 -19 |  10   |        1          |     10
 -18 |  10   |        1          |     10
 -17 |  10   |        1          |     10
 -16 |  10   |        1          |     10
 -15 |   9   |        1          |      9
 -14 |   9   |        1          |      9
 -13 |   9   |        1          |      9
 -12 |   9   |        1          |      9
 -11 |   8   |        1          |      8
 -10 |   8   |        1          |      8
 -9  |   8   |        1          |      8
 -8  |   8   |        1          |      8
 -7  |   7   |        1          |      7
 -6  |   7   |        1          |      7
 -5  |   7   |        1          |      7
 -4  |   7   |        1          |      7
 -3  |   6   |        1          |      6
 -2  |   6   |        1          |      6
 -1  |   6   |        1          |      6
  0  |   6   |        1          |      6
  1  |   5   |      19/20        |      4.75
  2  |   5   |      18/20        |      4.5 
  3  |   5   |      17/20        |      4.25
  4  |   5   |      16/20        |      4
  5  |   4   |      15/20        |      3
  6  |   4   |      14/20        |      2.8
  7  |   4   |      13/20        |      2.6
  8  |   4   |      12/20        |      2.4
  9  |   3   |      11/20        |      1.65
 10  |   3   |      10/20        |      1.5
 11  |   3   |       9/20        |      1.35
 12  |   3   |       8/20        |      1.2
 13  |   2   |       7/20        |      0.7
 14  |   2   |       6/20        |      0.6
 15  |   2   |       5/20        |      0.5
 16  |   2   |       4/20        |      0.4
 17  |   1   |       3/20        |      0.15
 18  |   1   |       2/20        |      0.1
 19  |   1   |       1/20        |      0.05

And we have a nice=19 vs. nice=0 ratio of 0.05:6 CPU
ratio ( 0.8% - 99.2% ).


So, this patch really solves the problem.
And yes, it is a problem: who wants dnetc/setiathome to slow
down (by 15%) apps like mozilla or gcc?

We don't want a "don't install dnetc on Linux 2.4.x, because it
does not multitask well" rumour around; that is true for MacOS 9
but should not for Linux. :-)

So, I think we should consider applying this patch (if noone
has some better solution).

Please CC to me any replies.


diff -urN linux-2.4.8-lmshsbrnc1/include/linux/sched.h linux-2.4.8-lmshsbrnc1_/include/linux/sched.h
--- linux-2.4.8-lmshsbrnc1/include/linux/sched.h    Sun Aug 12 10:18:03 2001
+++ linux-2.4.8-lmshsbrnc1_/include/linux/sched.h    Sun Aug 12 12:19:16 2001
@@ -305,7 +305,8 @@
  * the goodness() loop in schedule().
  */
     long counter;
-    long nice;
+    short nice_calc;
+    short nice;
     unsigned long policy;
     struct mm_struct *mm;
     int has_cpu, processor;
diff -urN linux-2.4.8-lmshsbrnc1/kernel/sched.c linux-2.4.8-lmshsbrnc1_/kernel/sched.c
--- linux-2.4.8-lmshsbrnc1/kernel/sched.c    Sun Aug 12 10:18:03 2001
+++ linux-2.4.8-lmshsbrnc1_/kernel/sched.c    Sun Aug 12 12:19:16 2001
@@ -680,8 +680,26 @@
         struct task_struct *p;
         spin_unlock_irq(&runqueue_lock);
         read_lock(&tasklist_lock);
-        for_each_task(p)
+        for_each_task(p) {
+            if (p->nice <= 0) {
+                /* The normal case... */
                 p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+            } else {
+                /*
+                 * Niced tasks get less CPU less often, leading to
+                 * the following distribution of CPU time:
+                 *
+                 * Nice    0    5   10   15   19
+                 * %CPU  100   56   25    6    1
+                 */
+                short prio = 20 - p->nice;
+                p->nice_calc += prio;
+                if (p->nice_calc >= 20) {
+                    p->nice_calc -= 20;
+                    p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+                }
+            }
+        }
         read_unlock(&tasklist_lock);
         spin_lock_irq(&runqueue_lock);
     }


-- 

            Roberto Ragusa   robertoragusa at technologist.com

