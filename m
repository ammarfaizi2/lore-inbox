Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQKSXl4>; Sun, 19 Nov 2000 18:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbQKSXlp>; Sun, 19 Nov 2000 18:41:45 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:12805 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129145AbQKSXlb>; Sun, 19 Nov 2000 18:41:31 -0500
Date: Sun, 19 Nov 2000 23:11:20 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Remove tq_scheduler
In-Reply-To: <3A15FD94.F19DA5F0@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0011192248200.31586-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000, Andrew Morton wrote:

>
> This patch removes tq_scheduler from the kernel.  All uses of
> tq_scheduler are migrated over to use schedule_task().
>
> Notes:
> - If anyone sleeps in a callback, then all other users of
>   schedule_task() also sleep.  But there's nothing new here.  Kinda
>   makes one wonder why schedule_task exists.  But what-hey, it's neat.

Because you're only supposed to use it if the task that is scheduled:
	A) Doesn't care about a reasonable delay
	B) Doesn't sleep for an unreasonable amount of time.

As long as there's some value of 'reasonable' to match the set of tasks
which you are using schedule_task() for at any given moment, you should be
fine.

If it's really necessary in 2.5, we can consider using multiple queues to
get round this problem - either a task per subsystem or a pool of worker
threads. Hopefully it won't be necessary though. We'll see.

> - Note the careful massaging of module reference counts.
>
>   Yes my friends, much usage of task queues in modules is racy wrt
>   module removal.  This patch fixes some of them.

Cool. I was going to look into that. I had figured we should fix it
completely or not at all, though, which is why I didn't do the trick with
use counts. I probably should have done, though.

While you're in maintenance mode, do you feel like fixing up stuff to use
up_and_exit() for killing kernel threads? I started on net/sunrpc/sched.c
but it made my head hurt so I gave up and started hacking PCMCIA
instead :)

Also, drivers/usb/hub.c can probably use schedule_task() now instead of
its own kernel thread.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
