Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSI2SeF>; Sun, 29 Sep 2002 14:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSI2SeF>; Sun, 29 Sep 2002 14:34:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261715AbSI2SeC>;
	Sun, 29 Sep 2002 14:34:02 -0400
Message-ID: <3D9748BA.5010704@pobox.com>
Date: Sun, 29 Sep 2002 14:38:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>, akpm@zip.com.au
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Basically with the removal of TIMER_BH i think the time is right to get
> rid of old BHs forever, and to do a massive cleanup of all related fields.
> The following five basic 'execution context' abstractions are supported by
> the kernel:
> 
>   - hardirq
>   - softirq
>   - tasklet
>   - keventd-driven task-queues
>   - process contexts

To be pedantic (and perhaps more clear), I think keventd can really be 
considered with process context, because that's schedule_task()'s main 
purpose - to provide a process context for code that otherwise may have 
not one reliably.

And to tangent a bit, there are three improvements in this area that 
(IMO) are worth considering:

1) keventd's worth is diminished, I think, due to what I see as an open 
question about its usage:  it provides a process context, and that's why 
most code uses it.  And the main reason why people want process context 
is to potentially sleep.  So by extension, one really doesn't know how 
long a schedule_task() will wait before it is issued.

At least in driver code I see common patterns -- especially error 
handling paths -- which could benefit from some code in interrupt 
context saying "run my error handling path in process context."  This is 
a one-shot task that's perfect for keventd... if it weren't for the fact 
that worst case, you don't really know if your error handling path will 
even get called in the next 5 minutes.

I have a suggested solution, but it seems heavyweight to me and easily 
shoot-down-able:  have a keventd manager that manages the keventd queue. 
  a second thread actually does the work of providing a process context. 
  third, fourth, etc. threads are created if work starts piling up 
because earlier work threads are taking a long time to complete.  Cap 
the number of threads at a maximum, and kill off idle threads [i.e. 
maintain a thread pool].

But in any case, I think keventd has a lot of utility, and is very 
under-utilized at present.


2) Given the above, I think a better driver interface is to simply pass 
in a function pointer, and a user data pointer.  No need for any special 
task queue structure.  Drivers call
	schedule_task(my_func, my_context_specific_data);
and the driver's callback looks like
	void my_func(void *data)

3) Maybe this is an improvement worth considering, maybe not:  I think 
it would be useful to have "process context timers."  What I mean by 
this is, make it easier to implement code that can be boiled down to:
	run in process context
	sleep for a little while
Sure I can do this by implementing a timer that does nothing more than 
call schedule_task(), but that seems a little redundant if done in 
multiple places :)

Ethernet link state machines, pcmcia-16's multi-stage state machine, 
etc. are examples of this.  Ethernet link state machines are often 
handled via the standard timers, and I would prefer to be able to sleep 
and do process-context-y stuff instead.  Talking to ethernet phys often 
takes quite a while...

I think these improvements would also serve to encourage coders to use 
process context whenever possible (not only is it the most flexible, 
it's easy too!), which is always a good thing.

Comments anyone?


> i believe task-queues should not be removed from the kernel altogether.
> It's true that they were written as a candidate replacement for BHs
> originally, but they do make sense in a different way: it's perhaps the
> easiest interface to do deferred processing from IRQ context, in
> performance-uncritical code areas. They are easier to use than tasklets.

I have a theory that most if not all "task queues" can be boiled down 
into keventd-tasks, which allows for further [if minor] simplifications 
as the function calling simplification in #2 above.


> i have moved all the taskqueue handling code into kernel/context.c, and
> only kept the basic 'queue a task' definitions in include/linux/tqueue.h.
> I've converted three of the most commonly used BH_IMMEDIATE users:
> tty_io.c, floppy.c and random.c. [random.c might need more thought
> though.]

makes sense


> scalable timers: i've further improved the patch ported to 2.5 by wli and
> Dipankar. There is only one pending issue i can see, the question of
> whether to migrate timers in mod_timer() or not. I'm quite convinced that
> they should be migrated, but i might be wrong. It's a 10 lines change to
> switch between migrating and non-migrating timers, we can do performance
> tests later on.

As an aside, most drivers seem the use mod_timer()

Regards,

	Jeff




