Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUHaQBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUHaQBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUHaQBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:01:04 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:42972 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268755AbUHaQA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:00:56 -0400
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: roland@redhat.com, Andrew Morton OSDL <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093967964.434.7086.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Aug 2004 11:59:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath writes:

> diff -rBzpu linux-2.6.9/fs/proc/array.c linux-2.6-ptracefix/fs/proc/array.c
> --- linux-2.6.9/fs/proc/array.c 2004-08-30 20:10:50.000000000 -0700
> +++ linux-2.6-ptracefix/fs/proc/array.c 2004-08-30 18:43:29.000000000 -0700
> @@ -130,8 +130,9 @@ static const char *task_state_array[] = 
>   "S (sleeping)",  /*  1 */
>   "D (disk sleep)", /*  2 */
>   "T (stopped)",  /*  4 */
> - "Z (zombie)",  /*  8 */
> - "X (dead)"  /* 16 */
> + "T (tracing stop)", /*  8 */
> + "Z (zombie)",  /* 16 */
> + "X (dead)"  /* 32 */
>  };

For TASK_DEAD and TASK_TRACED, might you be hiding some
underlying state? I want to display stuff like:

T    stopped (not traced)
TX   stopped, and being traced
RX   running or runnable, and being traced
ZE   zombie, and trying to exit
RXE  running, trying to exit, and traced

It's troubling the way TASK_DEAD and TASK_TRACED show up as
actual states and hide any other stuff. I'd much prefer them
to be flags of some sort.

> diff -rBzpu linux-2.6.9/kernel/power/process.c linux-2.6-ptracefix/kernel/power/process.c
> --- linux-2.6.9/kernel/power/process.c 2004-08-30 20:10:51.000000000 -0700
> +++ linux-2.6-ptracefix/kernel/power/process.c 2004-08-30 18:20:05.000000000 -0700
> @@ -25,7 +25,8 @@ static inline int freezeable(struct task
>       (p->flags & PF_NOFREEZE) ||
>       (p->state == TASK_ZOMBIE) ||
>       (p->state == TASK_DEAD) ||
> -     (p->state == TASK_STOPPED))
> +     (p->state == TASK_STOPPED) ||
> +     (p->state == TASK_TRACED))

(p->state & (TASK_ZOMBIE|TASK_DEAD|TASK_STOPPED|TASK_TRACED))

> @@ -70,6 +71,7 @@ int freeze_processes(void)
>     if (!freezeable(p))
>      continue;
>     if ((p->flags & PF_FROZEN) ||
> +       (p->state == TASK_TRACED) ||
>         (p->state == TASK_STOPPED))
>      continue;

(p->state & (TASK_TRACED|TASK_STOPPED))

> @@ -3670,7 +3670,7 @@ static void show_task(task_t * p)
>   task_t *relative;
>   unsigned state;
>   unsigned long free = 0;
> - static const char *stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
> + static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };

The 't' doesn't match what you do elsewhere. Try "TX" for that.
I think "ZX" would be right for an exiting process.



