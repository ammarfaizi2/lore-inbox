Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGZEvr>; Fri, 26 Jul 2002 00:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGZEu3>; Fri, 26 Jul 2002 00:50:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60933 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316792AbSGZEuR>; Fri, 26 Jul 2002 00:50:17 -0400
Message-ID: <3D40AF6B.5040708@evision.ag>
Date: Fri, 26 Jul 2002 04:09:47 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: lkml <linux-kernel@vger.kernel.org>, axboe@suse.de, torvalds@transmeta.com
Subject: Re: IDE lockups with 2.5.28...
References: <218BBF1744@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Martin,
>    can you explain what local_irq_disable() in do_request in
> drivers/ide/ide.c should guard against? There is dozen (all unless I 
> missed something) of paths which do not local_irq_enable(), and neither 
> does the caller...

You are wellcome.

local_irq_disale() in do_request was supposed to prevent preemption
from unexpected IRQs. It's indeed not good for anything right now.
It was there before I disabled it at about 2.5.15 time to see what
happens and I reenabled it during tickeling with the code recently to
see the effects of the whole IRQ handling changes or supposedly to make
it safer, since I wasn't quite qure about the do_request() consumers
ata_irq_handler and ide_timer_expiry. It's gone again
now in my tree. But this time for ever.

> And what you meant with (endless) loop in ide_do_request?

You mean do_ide_request(). Well this is a hard and long story, s
please let me elaborate later about it. (See below.)

> And where do_request() callers obtain channel lock so that do_request()
> can release and reacquire it?

It's only called from within request_fn contents and the channel lock
is in reality the request queue lock taken already in the
generic BIO layer, where it's supposed to provied protection from
reentrancy withhin request queues. (Note: BIO mean block io for me.)

> My problem is that fsck reliable dies between 79.6 and 81% of its
> run - on UP machine with SMP kernel:

Yeep I know. And the reason this happens is that right now I'm in the
process of making the driver really per device request queue aware.
See below plese.

> while (!test_and_set_bit(IDE_BUSY, ch->active)) {
>   do_request(ch)
> }
> 
> looks very suspicious to me - it will loop here until the end of world,
> as there is nothing in queue, so do_request() will always exit
> with IDE_BUSY cleared.

Yes it should and IDE_BUSY is a real botch becouse this is relying on
IRQ handlers manipulating it during REQ finish time by calling
back to do_request(). (Other drivers do q->request_fn instead, which is
not nice as well.)

> Next question is: with this stack trace, where you obtained ch->lock,
> so that do_request() can do call to spin_unlock(ch->lock) ? It looks
> to me like that I should get 'unlocking unlocked spinlock' with
> appropriate debug.
> 
> What (probably) happened is that hardware finished request before 
> spin_lock_irq(ch->lock) (at line 749) was executed, we quit with
> IDE_BUSY cleared, and it was last thing we did... Maybe I should
> go back to IDE-98?

This wan't help much, since the problem is a bit more fundamental
as I think and the code should be equivalent. BTW. You will find
something similar in scsi_lib.c more precisely scsi_request_fn(). The
->host_busy is what they use for the same purpose IDE_BUSY is serving in
IDE code.

Keep this in mind please! And please look a bit closer at the code
if something below isn't entierly clear.  So now follows the longer
explanation:

1. Linux started to use per device request queues recently. This
change is good and all well, since it is allowing the software device
called elevator to do a lot of optimializations on the request
queue before they get send down to the actual device

2. The main problem with 1. is that requests get feed through a host 
controller to the actual target device. And since one host
controller can drive multiple devices on a single bus (channel in IDE)
this makes up a requirement for synchronization primitives between
multiple queues here. It's a natural thing and we should account for it.
(IDE_BUSY loop in ide.c and while (1==1) loop in scsi_lib.c).

3. The generic request queue handling found in ll_rw_blk.c provides
for this purpose a way of assigning an explicit lock to a request
queue attached to a device by using the blk_queue_assign_lock()
function. This is supposed to synchronize two queues on the
level of ll_rw_block.c if you provide the same lock to multiple queues.

4. Well unfortunately 3. is futile. It's buggy. We can
supply the same lock to two queues but this lock is basically only 
protecting the queues data structures not
the flow of requests. Both SCSI and ATA subsystem release this
lock in the strategy functions (queue->request_fn = do_ide_request = 
do_request = scsi_request_fn) for  good reasons: Trying to minimize the 
time the kernel can't be preempted and the need to release IRQ's
after request submission and before looping for the next pendig request 
on the queue. Keep in ming the  request_fn method is supposed to
work through a whole chain of pending requests!

And then both ATA and SCSI need to insert artificial request in to the
request queue. This is in esp. necessary to maintain proper execution
context out from the final IRQ signaling request processing finishment
as well as calling the end_request method.

(I have already abstracted it out from both SCSI and ATA in my code
tree.)

5. Further the whole implementation of the usage of this shared lock
is *buggy* in ll_rw_blk.c in first place. It's used in conjecture with
the QUEUE_FLAG_STOPPED flag. *But* and this is a BIG BUT! This flag 
isn't shared in the case that blk_queue_assign_lock() was applied to two
different queues. So this is what is causing the preemption
problems which you see on operation between master and slave
for example on a single IDE channel. Look here if you don't
belive me:

	/*
	 * various queue flags, see QUEUE_* below
	 */
	unsigned long		queue_flags;

	/*
	 * protects queue structures from reentrancy
	 */
	spinlock_t		*queue_lock;

	/*

queue_lock is the pointer optionally supplied by
blk_queue_assign_lock(). You see that the flags are not shared.
But here you see that they are needed:

void blk_start_queue(request_queue_t *q)
{
	if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
		unsigned long flags;

		spin_lock_irqsave(q->queue_lock, flags);
		if (!elv_queue_empty(q))
			q->request_fn(q);
		spin_unlock_irqrestore(q->queue_lock, flags);
	}
}

Same allies to blk_stop_queue().

6. I have already explained the even in the case of not shared
queues the QUEUE_FLAG_STOPPED isn't maintained in an consistant
manner. Look above for eample blk_start_queue is obviously racy.

Still wondering why you expirence SMP problems after I switched to
proper per device queues not running through a single big
ide_lock? I think its worth it to try to accomlish this. But of
course right now it's causing quite a lot of pain.

What I wan't to do about it is roughly the following:

First and foremost: blk_queue_assign_lock doesn't make *any* sense.
It's broken by concept. Since:

1. The discussion above shows that it doesn't do the job it
is supposed to do.

2. It's sidestepping the allockation of locks on the generic
level. Why should we callocate a third lock when we have
already two default queue locks waiting to be used?

It would make much more sense to have the following function:

blk_queue_set_synch(queue_new, queue_to_synchronize_with);

returning a pointer to the lock shared after such a flagging
during queue setup time in the device registration process.

Of course the usage of queue_flags has to be fixed.

I will do this by allowing to chaing queues together in
request_queue_t struct to flag for the synchronization.
In case of chained qeues it will be only the head queue where
the queue_flags field will matter.
This will be better then the *queue_lock pointer and allocation games
currently found there. It will make cheking before q->request_fn call 
times a bit more complicated. But that is for sure fine, since the chain
isn't the determining comlexity factor here. And this will allow
for a lot of simplification on behalf of the drivers using it.

I didn't even start to explain the in esp. stacked device
drivers are basically all reimplementing a whole request queueing
interface on they own just becouse they can synch properly
between the disks below them...

I have already abstracted out the scsi_insert_request_cmd
stuff out from scsi_lib.c. I use the same in ATA now.

I will use blk_stop_queue() and blk_start_queue() primitives
for the purpose of request order synchroniation then instead
of the ->host_busy, IDE_BUSY and explicite q->reuqest_fn() call
games played now. Its' f*cking hard to stall request queuest on
the bottom part -> every single driver, since there you have do
be basically in IRQ context when doing this -> which means
races and no possiblity to give up CPU time, since you can't
reschedule.

I'm there right now? Certainly not. In esp. since the preemption of
the kernel got far more aggressive and one has to be much more
carefull right now even in UP case. I'm working on it? Yes.
Can patches be expected soon? Yes but in chunks, since right now I'm 
still not at the finish line with it.

Finally I hope that I have explained myself enough here.


