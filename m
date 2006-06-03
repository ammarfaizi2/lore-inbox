Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWFCVah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWFCVah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWFCVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:30:37 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30122 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751289AbWFCVag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:30:36 -0400
Subject: Re: [patch 4/5] [PREEMPT_RT] Changing interrupt handlers from
	running in thread to hardirq and back runtime.
From: Steven Rostedt <rostedt@kihontech.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0606022322140.9307@localhost>
References: <20060602165336.147812000@localhost>
	 <Pine.LNX.4.64.0606022322140.9307@localhost>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 17:30:30 -0400
Message-Id: <1149370230.13993.161.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 23:23 +0100, Esben Nielsen wrote:
> Makes it possible for the 8250 serial driver to have it's interrupt handler
> in both hard-irq and threaded context under PREEMPT_RT.
> 
> Index: linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
> ===================================================================
> --- linux-2.6.16-rt23.spin_mutex.orig/drivers/serial/8250.c
> +++ linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
> @@ -140,7 +140,7 @@ struct uart_8250_port {
>   };
> 
>   struct irq_info {
> -	spinlock_t		lock;
> +	spin_mutex_t		lock;
>   	struct list_head	*head;
>   };
> 
> @@ -1287,6 +1287,47 @@ serial8250_handle_port(struct uart_8250_
>   	spin_unlock(&up->port.lock);
>   }
> 
> +
> +static int serial8250_change_context(int irq, void *dev_id,
> +				     enum change_context_cmd cmd)
> +{
> +	struct irq_info *i = dev_id;
> +	struct list_head *l;
> +
> +	switch(cmd) {
> +	case IRQ_TO_HARDIRQ:
> +		/* Spin mutexes not available: */
> +		if(!spin_mutexes_can_spin())
> +			return -ENOSYS;
> +
> +		/* First do the inner locks */
> +		l = i->head;
> +		do {
> +			struct uart_8250_port *up;
> +			up = list_entry(l, struct uart_8250_port, list);
> +			spin_mutex_to_spin(&up->port.lock);
> +			l = l->next;
> +		} while(l != i->head && l != NULL);

Now this shows the flaw in your whole design.  Don't get me wrong, I'm
very impressed that you got this working for you.  But for this to be
accepted, it can't be too intrusive.  It is also very error prone since
you must know not only the locks in the handlers, but also the locks in
all the functions that you call. And each device must update them.

Two things:

1) What if you have two serials, and one is threaded and one is not.  It
might mutex a lock that should be a spin.

2) You forgot to update sysrq_key_table_lock.  That can be called from
the serial interrupt as well.  So even just working with two devices
it's not trivial to get things right.  Imagine what it would take for
the whole kernel.  Not to mention the maintenance nightmare it would
cause.

I do give you an A+ for effort, but I'm not sure if this is the
solution.  Frankly, it scares me, unless you can find a sure fire way to
update all the locks properly, that would not cause problems elsewhere.

Maybe the -rt way can introduce a new paradigm.  Maybe we shouldn't have
top halves at all, but instead a way to register threads to devices.
Think about it, the big picture, what are interrupts for?  They are to
tell us that an event happened, and if there is nothing waiting for that
event, then it was worthless.  So really, what we could do (and this
would perhaps also be good for mainline, although it would be very hard
to get accepted) is to have registering functions for each device.

So when a thread waits on a device, it is registered with the irq that
the device has, instead of a wait queue.  So each interrupt would have a
priority sorted list of threads that are waiting for that interrupt.
When the interrupt happens, the highest priority thread would wake up to
handle it, instead of an interrupt handler. If the interrupt belonged to
another thread, the one that was woken up would pass it off to the
thread waiting and go back to sleep.

This also allows the interrupt handlers to schedule and even write to
user space, once it finds out that the thread working on the interrupt
is the thread in question.

Let's say that we have a network card, which are commonly shared with
other devices, and it also has to do a lot before it knows what process
it is working on for.  And lets just say it is shared (uncommonly) with
a IDE device.

Now an interrupt comes in on this line.  There's a list of all the
highest priority tasks waiting on each device (not all tasks, just the
highest for each device, like the pi_list in the rt code).  So the
highest priority tasks for each device is woken up (the highest for the
network card and the highest for the IDE) and the interrupt handler
would return (not unlike the irq threads of the current -rt, except, we
wouldn't have irq threads but tasks that are waiting on them).  These
tasks would be in the registering function of the device, which would
know how to handle the interrupt.  Now if the current process is higher
in priority, then it wont be preempted by this interrupt. But if a
higher priority process is waiting, then the current process is
preempted.  So this is like interrupt handlers inheriting priorities of
processes waiting.

So the process now checks to see if the interrupt belongs to it, and if
it does, then simply handle the case.  Otherwise, if it does not belong
to the device, simply go back to sleep and wait again.  If this belongs
to the device, but for another waiter, using our example, the network
card, the process realized that it belonged to another process on
another port, it could wake up that process and pass information on how
much work the first process has done, so that the other process doesn't
repeat the work.

I'm just making this up as I go, but it really looks like this can be
examined more in an academic arena.  Perhaps it would even lead to less
context switches, since the process waiting would already be woken up on
interrupt.  The above idea is based on what interrupts are for.  They
don't happen for no reasons, but there's almost always someone waiting
for it.

-- Steve

> +		spin_mutex_to_spin(&i->lock);
> +		break;
> +	case IRQ_CAN_THREAD:
> +		break;
> +	case IRQ_TO_THREADED:
> +		spin_mutex_to_mutex(&i->lock);
> +		l = i->head;
> +
> +		do {
> +			struct uart_8250_port *up;
> +			up = list_entry(l, struct uart_8250_port, list);
> +			spin_mutex_to_mutex(&up->port.lock);
> +			l = l->next;
> +		} while(l != i->head && l != NULL);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * This is the serial driver's interrupt routine.
>    *
> @@ -1393,8 +1434,10 @@ static int serial_link_irq_chain(struct
>   		i->head = &up->list;
>   		spin_unlock_irq(&i->lock);
> 
> -		ret = request_irq(up->port.irq, serial8250_interrupt,
> -				  irq_flags, "serial", i);
> +		ret = request_irq2(up->port.irq, serial8250_interrupt,
> +				   irq_flags | SA_MUST_THREAD_RT,
> +				   "serial", i,
> +				   serial8250_change_context);
>   		if (ret < 0)
>   			serial_do_unlink(i, up);
>   	}
> Index: linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
> ===================================================================
> --- linux-2.6.16-rt23.spin_mutex.orig/include/linux/serial_core.h
> +++ linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
> @@ -206,7 +206,7 @@ struct uart_icount {
>   typedef unsigned int __bitwise__ upf_t;
> 
>   struct uart_port {
> -	spinlock_t		lock;			/* port lock */
> +	spin_mutex_t		lock;			/* port lock */
>   	unsigned int		iobase;			/* in/out[bwl] */
>   	unsigned char __iomem	*membase;		/* read/write[bwl] */
>   	unsigned int		irq;			/* irq number */
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Programmer
Kihon Technologies
(607)786-4830

