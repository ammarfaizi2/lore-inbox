Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSEXNzp>; Fri, 24 May 2002 09:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSEXNzo>; Fri, 24 May 2002 09:55:44 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:12810 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S314381AbSEXNzn>;
	Fri, 24 May 2002 09:55:43 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205241328.OAA27164@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Fri, 24 May 2002 14:28:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel), alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
In-Reply-To: <200205241143.g4OBh1332485@oboe.it.uc3m.es> from "Peter T. Breuer" at May 24, 2002 01:43:01 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> "Steven Whitehouse wrote:"
> (and ptb wrote, at a bit of quoting distance)
> > > > Assuming that we are still talking kernel nbd here and not enbd, I think
> > > 
> > > Yes.
> > > 
> > > > you've got that backwards. nbd_send_req() is called from do_nbd_request()
> > > > which is the block device request function and can therefore be called
> > > > from any thread running the disk task queue, which I think would normally
> > > 
> > > The disk task queue is called in the i/o context.
> > > 
> > I'm not sure what you mean by that. It runs in the context of whatever called
> > run_task_queue(&tq_disk); which is always some process or other waiting on
> > I/O so far as I can tell.
> 
> I mean that it is called with the i/o spinlock held, and with interrupts
> disabled.  Plus that run_task_queue (on the tq_disk) is NOT generally called
> from a process context.  It's called when the scheduler and his
> brother fred feels it ought to be called.
> 
Ok. I see now.

[snip]
> > > It maybe is or it maybe is not, but it's not in a process context in
> > > any sense that I recognise at that point! The request function for any
> > > block device driver is normally called when the device is unplugged,
> > > which happens exactly when the unplug task comes to be scheduled.
> > > Normally, user requests land somewhere in make request, which will
> > > discover a plugged queue and add the new requests somewhere to the
> > > queue, and go away happy. The driver request function will run sometime
> > > later (when the queue decides to unplug itself).
> > > 
> > By process context, I mean "not in an interrupt and not in a bottom 
> > half/tasklet/softirq context". In otherwords, its a context where its
> > legal to block under the normal rules for blocking processes.
> 
> You may not block while running the device request function.  The kernel
> expects you to return immediately.  The io lock is held, so if you
> block, everything dies.  If you schedule with the lock, everything else
> dies even more horribly, because nobody else is planning on releasing
> the lock, and you're sleeping.
> 
Agreed, thats just the standard rule about don't schedule whilst holding
a spinlock.

> 
> > > Devices are plugged as soon as the queue is drained, and the unplug
> > > task is scheduled for later at that point.
> > > 
> > > > The loop that the ioctl runs only does network receives and thus doesn't
> > > 
> > > The ioctl does both sends and recieves. It runs a loop waiting for
> > No it doesn't. The ioctl() only deals with receives from the network. Sends 
> > are all done by the thread which calls the request function for nbd.
> 
> If so, this is a recent change, and it is heap ungood. One should not
Its not that recent. Its been like that since before I started working
on nbd.

> attempt anything that may block in the request function.  If pavel has
> it, it is potential death, death, death, ...  ah, I see, he does have
> it, and is worried:
> 
>                 blkdev_dequeue_request(req);
>                 spin_unlock_irq(&io_request_lock);
> 
>                 down (&lo->queue_lock);
>                 list_add(&req->queue, &lo->queue_head);
>                 nbd_send_req(lo->sock, req);    /* Why does this block?  */
>                 up (&lo->queue_lock);
> 
>                 spin_lock_irq(&io_request_lock);
>                 continue;
> 
> so we see him briefly releasing the io lock and trying to send. Uh
> uh. No goodeee. The kernel is running through various drivers
> at this point, as a result of unplugging them (and calling the request
> function). Blocking one of them will block the rest from even running.
> 
> I apologise. You are right. Nowadays kernel nbd does do the send from
> the request function, instead of from the ioctl. In my opinion that is
> dangerous.
> 
Well I think I've been kind of assuming that it was ok since the lock was
dropped there. In the light of your comments I'm going to go back and
check the assumptions about how whether blocking is allowed here to
convince myself of the reasons or otherwise for doing this.

[snip]
> 
> > If we get to that state, we are well and truely stuck so we need to avoid it
> > at all costs.
> 
> There is no avoiding it except by reserving memory for the socket.
> 
Agreed. Or alternatively limiting the amount of non-freeable memory assigned to
other uses (page cache etc.).

> > > > server (we can tell from the socket queue lengths) and we know that we
> > > > can still ping clients which are otherwise dead due to the deadlock. I
> > > > don't think that at the moment there is any problem on the receive side.
> > > 
> > > If so, it's because the implementation uses the receive buffer as a
> > > stack :-). Nothing else qould account for it.
> > > 
> > I'm not sure quite what you are getting at here ...
> 
> That the tcp receive buffer used to accumulate and order fragments is exactly
> the final distination.
> 
Ok. I see now.

[snip]
> 
> > I think it would tend to hide the problem for some people and I'd rather not
> > do that until we have a general solution.
> > 
> > I'm going to try and come up with some more ideas to test in the next few days
> > so I'm still hopeful that it can be solved in a reasonably simple way,
> 
> If you can manage to reserve memory for a socket, that should be it.
> 
> 
> Peter
> 

I'd like to do that if I can, on the otherhand, thats going to be rather
a tricky one. We are not going to know which process called run_task_queue()
so that we can't use the local pages list as a hackish way of doing this
easily (I looked into that). If we did all sends from one process though
it becomes more of a possibility, there are problems with that though....

I've wondered before about changing the request function so that it just
puts the request on the local queue and wakes up the thread for sending
data. That would solve the blocking problem, but also mean that we had to
schedule for every request that comes in which I'd rather avoid for
performance reasons (not that I've actually done the experiment to work out
what we'd loose, but I suspect it would make a difference).

Also there is the possibility of combining the sending thread with the
receiving thread. This has complications because we'd have to poll()
the socket and be prepared to do non-blocking read or write on it as
required. Obviously by no means impossible, but certainly more complicated
than the current code.

This would prevent blocking in the request function, but I still don't know
how we can ensure that there is enough memory available. In some ways I
feel that we ought to be able to make use of the local pages list for the
process to (ab)use for this, but if the net stack frees any memory from
interrupt context that was allocated in process context, that idea won't
work,

Steve.

