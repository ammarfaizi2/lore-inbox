Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLXAt3>; Sat, 23 Dec 2000 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbQLXAtT>; Sat, 23 Dec 2000 19:49:19 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:56062 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129595AbQLXAtJ>; Sat, 23 Dec 2000 19:49:09 -0500
Message-ID: <3A454205.D33090A8@uow.edu.au>
Date: Sun, 24 Dec 2000 11:23:33 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>,
		<3A444CAA.4C5A7A89@uow.edu.au>; from andrewm@uow.edu.au on Sat, Dec 23, 2000 at 05:56:42PM +1100 <20001223191159.B29450@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sat, Dec 23, 2000 at 05:56:42PM +1100, Andrew Morton wrote:
> > If we elect to not address this problem in 2.2 and to rely upon the network
> 
> I see. There are two races:
> 
> 1)      race inside __wake_up when it's run on the same waitqueue: 2.2.19pre3
>         is affected as well as 2.2.18aa2, and 2.4.x is affected
>         as well when #defining USE_RW_WAIT_QUEUE_SPINLOCK to 1.

mm...  I think we should kill the USE_RW_WAIT_QUEUE_SPINLOCK option.

> 2)      race between two parallel __wake_up running on different waitqueues
>         (both 2.2.x and 2.4.x are affected)
> 
> 1) could be fixed trivially by making the waitqueue_lock a spinlock, but
> this way doesn't solve 2). And if we solve 2) properly than 1) gets fixed as
> well.

I don't understand the problem with 2) in 2.2?  Every task on both waitqueues
gets woken up.  Won't it sort itself out OK?

For 2.4, 2) is an issue because we can have tasks on two waitqueues at the
same time, with a mix of exclusive and non.  Putting a global spinlock
into __wake_up_common would fix it, but was described as "horrid" by
you-know-who :)

> I agree the right fix for 2) (and in turn for 1) ) is to count the number of
> exclusive wake_up_process that moves the task in the runqueue, if the task was
> just in the runqueue we must not consider it as an exclusive wakeup (so in turn
> we'll try again to wakeup the next exclusive-wakeup waiter). This will
> fix both races. Since the fix is self contained in __wake_up it's fine
> for 2.2.19pre3 as well and we can keep using a read_write lock then.

I really like this approach.  It fixes another problem in 2.4:

Example:

static struct request *__get_request_wait(request_queue_t *q, int rw)
{
        register struct request *rq;
        DECLARE_WAITQUEUE(wait, current);

        add_wait_queue_exclusive(&q->wait_for_request, &wait);
        for (;;) {
                __set_current_state(TASK_UNINTERRUPTIBLE);
	/* WINDOW HERE */
                spin_lock_irq(&io_request_lock);
                rq = get_request(q, rw);
                spin_unlock_irq(&io_request_lock);
                if (rq)
                        break;
                generic_unplug_device(q);
                schedule();
        }
        remove_wait_queue(&q->wait_for_request, &wait);
        current->state = TASK_RUNNING;
        return rq;
}

If this task enters the schedule() and is then woken, and another
wakeup is sent to the waitqueue while this task is executing in
the marked window, __wake_up_common() will try to wake this
task a second time and will then stop looking for tasks to wake.

The outcome: two wakeups sent to the queue, but only one task woken.

I haven't thought about it super-hard, but I think that if
__wake_up_common's exclusive-mode handling were changed
as you describe, so that it keeps on scanning the queue until it has
*definitely* moved a task onto the runqueue then this
problem goes away.

> Those races of course are orthogonal with the issue we discussed previously
> in this thread: a task registered in two waitqueues and wanting an exclusive
> wakeup from one waitqueue and a wake-all from the other waitqueue (for
> addressing that we need to move the wake-one information from the task struct
> to the waitqueue_head and I still think that shoudln't be addressed in 2.2.x,
> 2.2.x is fine with a per-task-struct wake-one information)

OK by me, as long as people don't uncautiously start using the
capability for other things.

> Should I take care of the 2.2.x fix, or will you take care of it? I'm not using
> the wake-one patch in 2.2.19pre3 because I don't like it (starting from the
> useless wmb() in accept) so if you want to take care of 2.2.19pre3 yourself I'd
> suggest to apply the wake-one patch against 2.2.19pre3 in my ftp-patch area
> first.  Otherwise give me an ack and I'll extend myself my wake-one patch to
> ignore the wake_up_process()es that doesn't move the task in the runqueue.

ack.

I'll take another look at the 2.4 patch and ask you to review that
when I've finished with the netdevice wetworks, if that's
OK.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
