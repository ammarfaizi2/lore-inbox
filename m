Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbTGIKpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbTGIKpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:45:35 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:11782 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265877AbTGIKpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:45:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Guillaume Chazarain <gfc@altern.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Interactivity bits
Date: Wed, 9 Jul 2003 12:59:53 +0200
User-Agent: KMail/1.5.2
References: <TQSN931YHFWVTRY59375OJOMNJECA8.3f0be526@monpc>
In-Reply-To: <TQSN931YHFWVTRY59375OJOMNJECA8.3f0be526@monpc>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307091251.37208.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 11:49, Guillaume Chazarain wrote:

Hi Guillaume,

> --- linux-2.5.74-bk6/kernel/sched.c.old	2003-07-09 10:08:01.000000000 +0200
> +++ linux-2.5.74-bk6/kernel/sched.c	2003-07-09 11:27:23.000000000 +0200
> @@ -68,10 +68,10 @@
>   */
>  #define MIN_TIMESLICE		( 10 * HZ / 1000)
>  #define MAX_TIMESLICE		(200 * HZ / 1000)
> -#define CHILD_PENALTY		50
> -#define PARENT_PENALTY		100
> +#define CHILD_PENALTY		80
> +#define PARENT_PENALTY		90
>  #define EXIT_WEIGHT		3
> -#define PRIO_BONUS_RATIO	25
> +#define PRIO_BONUS_RATIO	45
>  #define INTERACTIVE_DELTA	2
>  #define MAX_SLEEP_AVG		(10*HZ)
>  #define STARVATION_LIMIT	(10*HZ)
> @@ -88,13 +88,13 @@
>   * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
>   * Here are a few examples of different nice levels:
>   *
> - *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
> - *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
> - *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
> - *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
> - *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
> + *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0]
> + *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]
> + *  TASK_INTERACTIVE(  0): [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0]
> + *  TASK_INTERACTIVE( 10): [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
> + *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
>   *
> - * (the X axis represents the possible -5 ... 0 ... +5 dynamic
> + * (the X axis represents the possible -9 ... 0 ... +9 dynamic
>   *  priority range a task can explore, a value of '1' means the
>   *  task is rated interactive.)
>   *
> @@ -303,9 +303,9 @@
>   * priority but is modified by bonuses/penalties.
>   *
>   * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
> - * into the -5 ... 0 ... +5 bonus/penalty range.
> + * into the -9 ... 0 ... +9 bonus/penalty range.
>   *
> - * We use 25% of the full 0...39 priority range so that:
> + * We use 50% of the full 0...39 priority range so that:
>   *
>   * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
>   * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
> @@ -347,9 +347,9 @@
>   */
>  static inline void activate_task(task_t *p, runqueue_t *rq)
>  {
> -	long sleep_time = jiffies - p->last_run - 1;
> +	long sleep_time = jiffies - p->last_run;
>
> -	if (sleep_time > 0) {
> +	if (p->state == TASK_INTERRUPTIBLE && sleep_time) {
>  		int sleep_avg;
>
>  		/*
>

I can't see & feel any good difference with this applied on top of .74-mm3 
(slightly modified to apply)


> --- linux-2.5.74-mm3/kernel/sched.c.old	2003-07-09 09:14:50.000000000 +0200
> +++ linux-2.5.74-mm3/kernel/sched.c	2003-07-09 11:39:56.000000000 +0200
> @@ -71,7 +71,7 @@
>  #define CHILD_PENALTY		80
>  #define PARENT_PENALTY		100
>  #define EXIT_WEIGHT		3
> -#define PRIO_BONUS_RATIO	25
> +#define PRIO_BONUS_RATIO	45
>  #define INTERACTIVE_DELTA	2
>  #define MIN_SLEEP_AVG		(HZ)
>  #define MAX_SLEEP_AVG		(10*HZ)
> @@ -386,9 +386,9 @@
>   */
>  static inline void activate_task(task_t *p, runqueue_t *rq)
>  {
> -	long sleep_time = jiffies - p->last_run - 1;
> +	long sleep_time = jiffies - p->last_run;
>
> -	if (sleep_time > 0) {
> +	if (p->state == TASK_INTERRUPTIBLE && sleep_time) {
>  		unsigned long runtime = jiffies - p->avg_start;
>
>  		/*
>

And I even cannot see and feel any good difference with that one ontop of 
.74-mm3.

It's more worse than w/o:

Before the patch: mplayer was able to play a movie in fullscreen w/o any 
framedrops while "make -j2 bzImage modules"

With the patch: mplayer stops for ~0.5 seconds every 5 seconds while "make -j2 
bzImage modules"

You said the "long sleep_time = jiffies - p->last_run;" change helps mplayer? 
Not in my case ;)

- Celeron 1,3GHz
- 512MB RAM
- 1GB SWAP (2 IDE disks, ~512MB on each disk)
- ATA100 Maxtor 60GB HDD
- ATA100 Fujitsu 40GB

ciao, Marc

