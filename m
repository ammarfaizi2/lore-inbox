Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317632AbSGZJ5m>; Fri, 26 Jul 2002 05:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317634AbSGZJ5m>; Fri, 26 Jul 2002 05:57:42 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:62225 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317632AbSGZJ5g>;
	Fri, 26 Jul 2002 05:57:36 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Fri, 26 Jul 2002 12:00:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE lockups with 2.5.28...
CC: lkml <linux-kernel@vger.kernel.org>, axboe@suse.de, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <322E1A1760@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 02 at 4:09, Marcin Dalecki wrote:
> 
> > while (!test_and_set_bit(IDE_BUSY, ch->active)) {
> >   do_request(ch)
> > }
> > 
> > looks very suspicious to me - it will loop here until the end of world,
> > as there is nothing in queue, so do_request() will always exit
> > with IDE_BUSY cleared.
> 
> Yes it should and IDE_BUSY is a real botch becouse this is relying on
> IRQ handlers manipulating it during REQ finish time by calling
> back to do_request(). (Other drivers do q->request_fn instead, which is
> not nice as well.)
> 
> > Next question is: with this stack trace, where you obtained ch->lock,
> > so that do_request() can do call to spin_unlock(ch->lock) ? It looks
> > to me like that I should get 'unlocking unlocked spinlock' with
> > appropriate debug.
> > 
> > What (probably) happened is that hardware finished request before 
> > spin_lock_irq(ch->lock) (at line 749) was executed, we quit with
> > IDE_BUSY cleared, and it was last thing we did... Maybe I should
> > go back to IDE-98?
> 
> This wan't help much, since the problem is a bit more fundamental
> as I think and the code should be equivalent. BTW. You will find
> something similar in scsi_lib.c more precisely scsi_request_fn(). The
> ->host_busy is what they use for the same purpose IDE_BUSY is serving in
> IDE code.

I'll left other things for Jens, but... code is NOT equivalent.
Old code, before you moved IDE_BUSY loop one function above, used
break; to exit loop - note break, not continue. So when it found
queue empty, it exited do_request, and everything was fine. But with
your change it will loop here forever. Forever! You see?

I did not find anything simillar in scsi_lib - its scsi_request_fn
terminates when queue is plugged, or when queue is empty, and in
couple of other situations. Simple moving test_and_set_bit() loop
back into do_request, and replace returns with breaks will fix it. I think.
 
> Keep this in mind please! And please look a bit closer at the code
> if something below isn't entierly clear.  So now follows the longer
> explanation:
> 
> 2. The main problem with 1. is that requests get feed through a host 
> controller to the actual target device. And since one host
> controller can drive multiple devices on a single bus (channel in IDE)
> this makes up a requirement for synchronization primitives between
> multiple queues here. It's a natural thing and we should account for it.
> (IDE_BUSY loop in ide.c and while (1==1) loop in scsi_lib.c).

Well, no. Both of these loop have completely different terminating conditions.
You exit when IDE hardware is busy, while SCSI exits if hardware is busy,
or when there is nothing to do. Fundamental difference.
 
> 5. Further the whole implementation of the usage of this shared lock
> is *buggy* in ll_rw_blk.c in first place. It's used in conjecture with
> the QUEUE_FLAG_STOPPED flag. *But* and this is a BIG BUT! This flag 
> isn't shared in the case that blk_queue_assign_lock() was applied to two
> different queues. So this is what is causing the preemption
> problems which you see on operation between master and slave
> for example on a single IDE channel. Look here if you don't
> belive me:

Only problem is that I have only one harddisk in this machine, and
when fsck is running, I'm 100% sure that it even did not try to access
other /dev/hd* devices... 

> queue_lock is the pointer optionally supplied by
> blk_queue_assign_lock(). You see that the flags are not shared.
> But here you see that they are needed:
> 
> void blk_start_queue(request_queue_t *q)
> {
>     if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
>         unsigned long flags;
> 
>         spin_lock_irqsave(q->queue_lock, flags);
>         if (!elv_queue_empty(q))
>             q->request_fn(q);
>         spin_unlock_irqrestore(q->queue_lock, flags);
>     }
> }
> 
> Same allies to blk_stop_queue().

So your request_fn is invoked for each of queues which had pending
requests. Upper layer cannot expect that you are using two queues,
but hardware really wants to use only one. Shared queue_lock is there
for hardware which can start one request at a time (one set of
registers...), but can have requests to the different devices
in progress.
 
> First and foremost: blk_queue_assign_lock doesn't make *any* sense.
> It's broken by concept. Since:
> 
> 1. The discussion above shows that it doesn't do the job it
> is supposed to do.

Really? You can create one queue for each of SCSI devices you have,
and SCSI host adapter puts same lock to all queues. Each queue can
be stopped at will, and together their accesses to the host are serialized...
                                                 Petr Vandrovec
                                                 vandrove@vc.cvut.cz
                                                 
P.S.: I did not saw IDE 105. Does it exist?
                                                        
