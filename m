Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSLBUUR>; Mon, 2 Dec 2002 15:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSLBUUR>; Mon, 2 Dec 2002 15:20:17 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:45250 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S264976AbSLBUUM>; Mon, 2 Dec 2002 15:20:12 -0500
Date: Mon, 2 Dec 2002 21:27:21 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues, 2.5.50
In-Reply-To: <3DEA27D6.4000501@colorfullife.com>
Message-ID: <Pine.GSO.4.40.0212021437180.1566-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Manfred Spraul wrote:

> The bad thing is that you use __add_wait_queue() and call the wait queue
> locking functions yourself. This is not needed. The only function that
> was permitted to do that is sleep_on(), and that will die soon. I've
> quoted sleep_on as a reminder to kill that code in kernel/sched.c.
> Just use add_wait_queue() instead of the internal functions. Or
> prepare_to_wait/finish_wait, that has a slighly lower locking overhead.

Some more explanation. Originally I used sleep_on(). But when it occurred
to not work well on SMP I just make my own version of it with queue-wide
semaphore protecting whole code. Then it started to work, but it was ugly,
again I agree. Now I've made my own function taking wait_event() as a
template: I've removed checking for condition and add process to wait
queue with EXCLUSIVE flag. On uniprocessor it works well - but on SMP I
just a moment before had the same race - (wq were corrupted). When I added
sem IN this function it started to work ok. Why (I mean why it didn't
worked previously - in such a case I can imagine that wait_event would
also produce some races) ?

Now it looks like this:

+void inline wait_exclusive(wait_queue_head_t *wq)
+{
+       wait_queue_t wait;
+       init_waitqueue_entry(&wait, current);
+
+       add_wait_queue_exclusive(wq, &wait);
+       set_current_state(TASK_UNINTERRUPTIBLE);
+
++	up(&queue_sem)
+       schedule();
++	down(&queue_sem);
+
+       current->state = TASK_RUNNING;
+       remove_wait_queue(wq, &wait);
+}

I hope it is acceptable (?)


>
> Btw, could you explain how your message priority implementation works?
>
> If I understand it correctly, wq_add maintains a priority sorted linked
> list. wq_sleep() waits until the process becomes the first entry in the
> priority queue.
> - You use the pid value as the thread identifier - why? Usually the task
> struct pointer is used within the kernel.

Ups :-). Yes it will let me remove one extra field from struct.

> -  Is it correct that wq_wakeup wakes up all processes that sleep in
> wq_send, and then the highest priority process continues? What about
> waking up just the highest priority process? Look at the wakeup code in
> ipc/msg.c - it implement message types that way. The sender looks
> through the list of waiting receivers, and directly sends the message to
> the right receiver [pipelined_send()]

Yes it was correct, but useless. Now I wakeup only one process. But note
that we use different algorithm then in msg.c: we haven't "pipelined" s&r.

I have applied previous suggestions & made some improvements - it works
well.

If you have some further notices please send (especially about first
case).


Thanks again

Krzysiek Benedyczak



