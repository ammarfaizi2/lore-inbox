Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932267AbWFDVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWFDVt6 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWFDVt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:49:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64436 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932267AbWFDVt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:49:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=ubZ07YkoF+HUnXi3NR3vQPelRB7Ze/SvkQoXMdzjDox3nfL+CE9Y5fqghfRX+H+dTdBDkeRvpJfVk1SNLN1HKy8aXqIgy16pJkRc01fkzfFaKCXGMP3sWza2NfybVskGO2hKVXqkiycEnitQqJL8xGL9l3G5pztMcvraYQk6klQ=
Date: Sun, 4 Jun 2006 23:50:07 +0100 (BST)
X-X-Sender: simlo@localhost
To: Steven Rostedt <rostedt@kihontech.com>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 4/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
In-Reply-To: <1149370230.13993.161.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606041835010.9391@localhost>
References: <20060602165336.147812000@localhost>  <Pine.LNX.4.64.0606022322140.9307@localhost>
 <1149370230.13993.161.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006, Steven Rostedt wrote:

> On Fri, 2006-06-02 at 23:23 +0100, Esben Nielsen wrote:
>> Makes it possible for the 8250 serial driver to have it's interrupt handler
>> in both hard-irq and threaded context under PREEMPT_RT.
>>
>> Index: linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
>> ===================================================================
>> --- linux-2.6.16-rt23.spin_mutex.orig/drivers/serial/8250.c
>> +++ linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
>> @@ -140,7 +140,7 @@ struct uart_8250_port {
>>   };
>>
>>   struct irq_info {
>> -	spinlock_t		lock;
>> +	spin_mutex_t		lock;
>>   	struct list_head	*head;
>>   };
>>
>> @@ -1287,6 +1287,47 @@ serial8250_handle_port(struct uart_8250_
>>   	spin_unlock(&up->port.lock);
>>   }
>>
>> +
>> +static int serial8250_change_context(int irq, void *dev_id,
>> +				     enum change_context_cmd cmd)
>> +{
>> +	struct irq_info *i = dev_id;
>> +	struct list_head *l;
>> +
>> +	switch(cmd) {
>> +	case IRQ_TO_HARDIRQ:
>> +		/* Spin mutexes not available: */
>> +		if(!spin_mutexes_can_spin())
>> +			return -ENOSYS;
>> +
>> +		/* First do the inner locks */
>> +		l = i->head;
>> +		do {
>> +			struct uart_8250_port *up;
>> +			up = list_entry(l, struct uart_8250_port, list);
>> +			spin_mutex_to_spin(&up->port.lock);
>> +			l = l->next;
>> +		} while(l != i->head && l != NULL);
>
> Now this shows the flaw in your whole design.  Don't get me wrong, I'm
> very impressed that you got this working for you.  But for this to be
> accepted, it can't be too intrusive.  It is also very error prone since
> you must know not only the locks in the handlers, but also the locks in
> all the functions that you call. And each device must update them.
>
> Two things:
>
> 1) What if you have two serials, and one is threaded and one is not.  It
> might mutex a lock that should be a spin.
>
> 2) You forgot to update sysrq_key_table_lock.  That can be called from
> the serial interrupt as well.  So even just working with two devices
> it's not trivial to get things right.  Imagine what it would take for
> the whole kernel.  Not to mention the maintenance nightmare it would
> cause.

I imagine the change would be done by those people using the drivers in a 
RT context. If they want to change a handler to run in hard-IRQ context 
they will have to identify all the locks anyway. Then can just as well do 
it this way and then submit it to the main-line kernel. If they just 
change them to raw_spin_lock_t it can't be submitted.

I considered making a system where the right lock form could be chosen 
compiletime. Then the drivers would have an suboption "threaded irq" or 
"hard irq" and from that choice the right lock types where chosen.
But then came the problem up on the list about shared interrupts. Then the 
ability to change the context runtime would be usefull.


>
> I do give you an A+ for effort, but I'm not sure if this is the
> solution.  Frankly, it scares me, unless you can find a sure fire way to
> update all the locks properly, that would not cause problems elsewhere.

Well, you will very soon hit a BUG: scheduling while in atomic if you miss 
some. Ofcourse, I did miss some, and I didn't get that because I didn't 
use that subsystem in my tests.

>
> Maybe the -rt way can introduce a new paradigm.  Maybe we shouldn't have
> top halves at all, but instead a way to register threads to devices.
> Think about it, the big picture, what are interrupts for?  They are to
> tell us that an event happened, and if there is nothing waiting for that
> event, then it was worthless.  So really, what we could do (and this
> would perhaps also be good for mainline, although it would be very hard
> to get accepted) is to have registering functions for each device.
>
> So when a thread waits on a device, it is registered with the irq that
> the device has, instead of a wait queue.  So each interrupt would have a
> priority sorted list of threads that are waiting for that interrupt.
> When the interrupt happens, the highest priority thread would wake up to
> handle it, instead of an interrupt handler. If the interrupt belonged to
> another thread, the one that was woken up would pass it off to the
> thread waiting and go back to sleep.
>
> This also allows the interrupt handlers to schedule and even write to
> user space, once it finds out that the thread working on the interrupt
> is the thread in question.
>
> Let's say that we have a network card, which are commonly shared with
> other devices, and it also has to do a lot before it knows what process
> it is working on for.  And lets just say it is shared (uncommonly) with
> a IDE device.
>
> Now an interrupt comes in on this line.  There's a list of all the
> highest priority tasks waiting on each device (not all tasks, just the
> highest for each device, like the pi_list in the rt code).  So the
> highest priority tasks for each device is woken up (the highest for the
> network card and the highest for the IDE) and the interrupt handler
> would return (not unlike the irq threads of the current -rt, except, we
> wouldn't have irq threads but tasks that are waiting on them).  These
> tasks would be in the registering function of the device, which would
> know how to handle the interrupt.  Now if the current process is higher
> in priority, then it wont be preempted by this interrupt. But if a
> higher priority process is waiting, then the current process is
> preempted.  So this is like interrupt handlers inheriting priorities of
> processes waiting.
>
> So the process now checks to see if the interrupt belongs to it, and if
> it does, then simply handle the case.  Otherwise, if it does not belong
> to the device, simply go back to sleep and wait again.  If this belongs
> to the device, but for another waiter, using our example, the network
> card, the process realized that it belonged to another process on
> another port, it could wake up that process and pass information on how
> much work the first process has done, so that the other process doesn't
> repeat the work.
>
> I'm just making this up as I go, but it really looks like this can be
> examined more in an academic arena.  Perhaps it would even lead to less
> context switches, since the process waiting would already be woken up on
> interrupt.  The above idea is based on what interrupts are for.  They
> don't happen for no reasons, but there's almost always someone waiting
> for it.
>

I must say I am not sure how this idea _really_ differs from the present 
setup, but then again, I don't really understand where you are going. The 
only major difference is that every "interrupt handler" runs in it's own 
thread even though they share the same interrupt line. That again leads to 
the usual problem: When should the interrupt be reenabled?

As long as interrupts can be shared, all handlers of the same interrupt 
has to be handled before the it can be reinabled. Sure, you can sort it 
out in a way such that the high priority handler runs first, but the worst 
case lantency is still set by the lower priority handler, because the 
system simply can't reenable the interrupt after a handler has handled it.
So if the high priority event happens just after the low priority one, but 
after the high priority handler has run, the system has to wait for the 
low priority handler to handle it's work, reenable the interrupt, see the 
high priority event and then call that handler.

I can't see no matter how you split it up in threads is going to solve 
this problem.  Actually, having them in one thread makes more sense,
because when the latency will depend on the lowest priority anyway they 
all should have the same priority.


> -- Steve

If you really want to change stuff I have had another idea:

Make a pool of non-running threads. In the low level assembly code 
handling interrupts, take one out of the pool and move the stack-pointer 
to the buttom of the stack. Now jump to the generic irq system using 
that stack instead of the stack of the task running when the interrupt occured.
If an interrupt handler wants to run preemptible: Switch on interrupts and 
let the scheduler handle the rest. That way there isn't really 
any task switch, no wait queue or other "expensive" things to get the 
interrupts preemptible. The only thing I can think of being expensive is 
that you need to fix up the stack on the task running when the interrupt 
occuring, such that a schedule() can pick it up cleanly and take the 
interrupt thread in and out of the run queue - but that might even be 
defered to the case where it in fact is preempted.

By doing that we might get rid of hard-irq context all together, as 
the interrupt gets "threaded" allready within the low level generic 
code (although the interrupts will still be off at that point).

Esben


>
>> +		spin_mutex_to_spin(&i->lock);
>> +		break;
>> +	case IRQ_CAN_THREAD:
>> +		break;
>> +	case IRQ_TO_THREADED:
>> +		spin_mutex_to_mutex(&i->lock);2A
>> +		l = i->head;
>> +
>> +		do {
>> +			struct uart_8250_port *up;
>> +			up = list_entry(l, struct uart_8250_port, list);
>> +			spin_mutex_to_mutex(&up->port.lock);
>> +			l = l->next;
>> +		} while(l != i->head && l != NULL);
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * This is the serial driver's interrupt routine.
>>    *
>> @@ -1393,8 +1434,10 @@ static int serial_link_irq_chain(struct
>>   		i->head = &up->list;
>>   		spin_unlock_irq(&i->lock);
>>
>> -		ret = request_irq(up->port.irq, serial8250_interrupt,
>> -				  irq_flags, "serial", i);
>> +		ret = request_irq2(up->port.irq, serial8250_interrupt,
>> +				   irq_flags | SA_MUST_THREAD_RT,
>> +				   "serial", i,
>> +				   serial8250_change_context);
>>   		if (ret < 0)
>>   			serial_do_unlink(i, up);
>>   	}
>> Index: linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
>> ===================================================================
>> --- linux-2.6.16-rt23.spin_mutex.orig/include/linux/serial_core.h
>> +++ linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
>> @@ -206,7 +206,7 @@ struct uart_icount {
>>   typedef unsigned int __bitwise__ upf_t;
>>
>>   struct uart_port {
>> -	spinlock_t		lock;			/* port lock */
>> +	spin_mutex_t		lock;			/* port lock */
>>   	unsigned int		iobase;			/* in/out[bwl] */
>>   	unsigned char __iomem	*membase;		/* read/write[bwl] */
>>   	unsigned int		irq;			/* irq number */
>>
>> --
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> Steven Rostedt
> Senior Programmer
> Kihon Technologies
> (607)786-4830
>
