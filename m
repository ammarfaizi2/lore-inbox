Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbTGIJcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268103AbTGIJcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:32:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14978 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268102AbTGIJcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:32:11 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 09 Jul 2003 11:49:26 +0200
X-Priority: 3 (Normal)
Message-Id: <TQSN931YHFWVTRY59375OJOMNJECA8.3f0be526@monpc>
Subject: Re: [PATCH] Interactivity bits
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08/07/03 23:13:22, Davide Libenzi <davidel@xmailserver.org> wrote:

>On Tue, 8 Jul 2003, Guillaume Chazarain wrote:
>
>> Hello,
>>
>> Currently the interactive points a process can have are in a [-5, 5] range,
>> that is, 25% of the [0, 39] range. Two reasons are mentionned:
>>
>> 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
>> 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
>>
>> But, using 50% of the range, instead of 25% the interactivity points are better
>> spread and both rules are still respected.  Having a larger range for
>> interactivity points it's easier to choose between two interactive tasks.
>>
>> So, why not changing PRIO_BONUS_RATIO to 50 instead of 25?
>> Actually it should be in the [45, 49] range to maximize the bonus points
>> range and satisfy both rules due to integer arithmetic.
>
>I believe these are the bits that broke the scheduler, that was working
>fine during the very first shots in 2.5. IIRC Ingo was hit by ppl
>complains about those 'nice' rules and he had to fix it. It'd be
>interesting bring back a more generous interactive bonus and see how the
>scheduler behave.

Thanks for the info.
Before being 25% the interactivity range was 70%, thus breaking the rules. So
I am now more convinced that a 50% range could be a good thing.

Here is the patch I currently use and am very happy with it.

--- linux-2.5.74-bk6/kernel/sched.c.old	2003-07-09 10:08:01.000000000 +0200
+++ linux-2.5.74-bk6/kernel/sched.c	2003-07-09 11:27:23.000000000 +0200
@@ -68,10 +68,10 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
+#define CHILD_PENALTY		80
+#define PARENT_PENALTY		90
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
+#define PRIO_BONUS_RATIO	45
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
@@ -88,13 +88,13 @@
  * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
  * Here are a few examples of different nice levels:
  *
- *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
- *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
- *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0]
+ *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE(  0): [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 10): [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
+ *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  *
- * (the X axis represents the possible -5 ... 0 ... +5 dynamic
+ * (the X axis represents the possible -9 ... 0 ... +9 dynamic
  *  priority range a task can explore, a value of '1' means the
  *  task is rated interactive.)
  *
@@ -303,9 +303,9 @@
  * priority but is modified by bonuses/penalties.
  *
  * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
+ * into the -9 ... 0 ... +9 bonus/penalty range.
  *
- * We use 25% of the full 0...39 priority range so that:
+ * We use 50% of the full 0...39 priority range so that:
  *
  * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
  * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
@@ -347,9 +347,9 @@
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	long sleep_time = jiffies - p->last_run;
 
-	if (sleep_time > 0) {
+	if (p->state == TASK_INTERRUPTIBLE && sleep_time) {
 		int sleep_avg;
 
 		/*


The following change:
-	long sleep_time = jiffies - p->last_run - 1;
+	long sleep_time = jiffies - p->last_run;
helps mplayer become interactive. Otherwise, it uses just a little fraction of the CPU,
and is considered a CPU hog.


My workload may not be representative of ordinary desktop use, so I'd like to have some
feedback on these simple changes.  Of course these changes can be put on top of Con's work
in -mm3 with this patch.

--- linux-2.5.74-mm3/kernel/sched.c.old	2003-07-09 09:14:50.000000000 +0200
+++ linux-2.5.74-mm3/kernel/sched.c	2003-07-09 11:39:56.000000000 +0200
@@ -71,7 +71,7 @@
 #define CHILD_PENALTY		80
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
+#define PRIO_BONUS_RATIO	45
 #define INTERACTIVE_DELTA	2
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
@@ -386,9 +386,9 @@
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	long sleep_time = jiffies - p->last_run;
 
-	if (sleep_time > 0) {
+	if (p->state == TASK_INTERRUPTIBLE && sleep_time) {
 		unsigned long runtime = jiffies - p->avg_start;
 
 		/*




Thanks.
Guillaume





