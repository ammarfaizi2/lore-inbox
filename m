Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSEXLnM>; Fri, 24 May 2002 07:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSEXLnL>; Fri, 24 May 2002 07:43:11 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:64009 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S314327AbSEXLnH>;
	Fri, 24 May 2002 07:43:07 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205241143.g4OBh1332485@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205241011.LAA26311@gw.chygwyn.com> from Steven Whitehouse at
 "May 24, 2002 11:11:22 am"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Fri, 24 May 2002 13:43:01 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven Whitehouse wrote:"
(and ptb wrote, at a bit of quoting distance)
> > > Assuming that we are still talking kernel nbd here and not enbd, I think
> > 
> > Yes.
> > 
> > > you've got that backwards. nbd_send_req() is called from do_nbd_request()
> > > which is the block device request function and can therefore be called
> > > from any thread running the disk task queue, which I think would normally
> > 
> > The disk task queue is called in the i/o context.
> > 
> I'm not sure what you mean by that. It runs in the context of whatever called
> run_task_queue(&tq_disk); which is always some process or other waiting on
> I/O so far as I can tell.

I mean that it is called with the i/o spinlock held, and with interrupts
disabled.  Plus that run_task_queue (on the tq_disk) is NOT generally called
from a process context.  It's called when the scheduler and his
brother fred feels it ought to be called.

Look in some of the block drivers, floppy.c or loop.c.  These do call
the task queue, even though that's only as an aid to the rest of the
kernel, because they know they can help at that point, and it's not at
all clear what context they're in.  Perhaps it's best to look in
floppy.c, which runs the task queue in its init routine!  I mean to say
that conceptually, there is no process associated with running tq_disk.
It happens when it happens.

> > > mean that its a thread waiting for I/O as in buffer.c:__wait_on_buffer()

Wait_on_buffer is merely responsible for scheduling itself out so that
somebody else can free up a few buffers if we get stuck without any in
make request. It makes some minor attempts to help, but it might as
well just wait as anything else (ok, it would be slower).

> > It maybe is or it maybe is not, but it's not in a process context in
> > any sense that I recognise at that point! The request function for any
> > block device driver is normally called when the device is unplugged,
> > which happens exactly when the unplug task comes to be scheduled.
> > Normally, user requests land somewhere in make request, which will
> > discover a plugged queue and add the new requests somewhere to the
> > queue, and go away happy. The driver request function will run sometime
> > later (when the queue decides to unplug itself).
> > 
> By process context, I mean "not in an interrupt and not in a bottom 
> half/tasklet/softirq context". In otherwords, its a context where its
> legal to block under the normal rules for blocking processes.

You may not block while running the device request function.  The kernel
expects you to return immediately.  The io lock is held, so if you
block, everything dies.  If you schedule with the lock, everything else
dies even more horribly, because nobody else is planning on releasing
the lock, and you're sleeping.


> > Devices are plugged as soon as the queue is drained, and the unplug
> > task is scheduled for later at that point.
> > 
> > > The loop that the ioctl runs only does network receives and thus doesn't
> > 
> > The ioctl does both sends and recieves. It runs a loop waiting for
> No it doesn't. The ioctl() only deals with receives from the network. Sends 
> are all done by the thread which calls the request function for nbd.

If so, this is a recent change, and it is heap ungood. One should not
attempt anything that may block in the request function.  If pavel has
it, it is potential death, death, death, ...  ah, I see, he does have
it, and is worried:

                blkdev_dequeue_request(req);
                spin_unlock_irq(&io_request_lock);

                down (&lo->queue_lock);
                list_add(&req->queue, &lo->queue_head);
                nbd_send_req(lo->sock, req);    /* Why does this block?  */
                up (&lo->queue_lock);

                spin_lock_irq(&io_request_lock);
                continue;

so we see him briefly releasing the io lock and trying to send. Uh
uh. No goodeee. The kernel is running through various drivers
at this point, as a result of unplugging them (and calling the request
function). Blocking one of them will block the rest from even running.

I apologise. You are right. Nowadays kernel nbd does do the send from
the request function, instead of from the ioctl. In my opinion that is
dangerous.

> > > do any allocations of any kind itself. The only worry on the receive side
> > > is that buffers are not available in the network device driver, but this
> > > doesn't seem to be a problem. There are no backed up replies in the
> > 
> > Well, I imagine it is a fact. Yes, we can starve tcp of receive buffers
> > too. But that doesn't matter, does it? Nobody will die from not being
> > able to read stuff for a little while? Userspace will block a bit ...
> > and yes, maybe the net could time out.
> > 
> > I think we could starve the net to death while nbd is trying to read
> > from it, if tcp can't get buffers because of i/o competition.
> > 
> Since I wrote this I've gained more evidence. Reports suggest that if we mark
> the send thread PF_MEMALLOC during the writeout, we land up completely
> starving everything else of memory in low memory situations. If we run out

Well, that's fine. We need it more than anybody else.

> of buffers for network receives we are equally stuck because no acknowledgements
> get through resulting in no buffers ever being marked as finished with I/O.

Yes.

> If we get to that state, we are well and truely stuck so we need to avoid it
> at all costs.

There is no avoiding it except by reserving memory for the socket.

> > > server (we can tell from the socket queue lengths) and we know that we
> > > can still ping clients which are otherwise dead due to the deadlock. I
> > > don't think that at the moment there is any problem on the receive side.
> > 
> > If so, it's because the implementation uses the receive buffer as a
> > stack :-). Nothing else qould account for it.
> > 
> I'm not sure quite what you are getting at here ...

That the tcp receive buffer used to accumulate and order fragments is exactly
the final distination.

> > > > So I think that your PF_MEMALLOC idea does revert the inversion.
> > > > 
> > > > Would it also be good to prevent other processes running? or is it too
> > > > late. Yes, I think it is too late to do any good, by the time we feel
> > > > this pressure.
> > 
> > > The mechanism works fine for block devices which do not need to allocate
> > > memory in their write out paths. Since we know there is a maximum amount
> > > of memory required by nbd and bounded by the maximum request size plus the
> > > small header per request, it would seem reasonable that to avoid deadlock
> > > we simply need to raise the amount of memory reserved for low memory
> > > situations until we've provided what nbd needs,
> > 
> > That is precisely max_sectors.
> > 
> Well there is extra overhead in allocating the skbs etc., but broadly yes, it
> is bounded by the amount of I/O that we want to do.
> 
> I do still have my zerocopy patch which should help greatly in the writeout
> path for those with suitable hardware, but I've been keeping it back because

Should do indeed.

> I think it would tend to hide the problem for some people and I'd rather not
> do that until we have a general solution.
> 
> I'm going to try and come up with some more ideas to test in the next few days
> so I'm still hopeful that it can be solved in a reasonably simple way,

If you can manage to reserve memory for a socket, that should be it.


Peter
