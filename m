Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317122AbSEXKiY>; Fri, 24 May 2002 06:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317125AbSEXKiX>; Fri, 24 May 2002 06:38:23 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:62729 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S317122AbSEXKiV>;
	Fri, 24 May 2002 06:38:21 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205241011.LAA26311@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Fri, 24 May 2002 11:11:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel), alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
In-Reply-To: <200205231321.g4NDL1E17401@oboe.it.uc3m.es> from "Peter T. Breuer" at May 23, 2002 03:21:01 PM
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
> Sorry .. I didn't see this earlier. I was on a trip. Just to clear up a
> couple of thinsg ...
> 
Thats ok. I'm only working on this problem part time anyway between various
other tasks.

> "A month of sundays ago Steven Whitehouse wrote:"
> > > Sorry I didn't pick this up earlier ..
> > > "Steven Whitehouse wrote:"
> > > > we don't want to alter that. The "priority inversion" that I mentioned occurs
> > > > when you get processes without PF_MEMALLOC set calling nbd_send_req() as when
> > > 
> > > There aren't any processes that call nbd_send_req except the unique
> > > nbd client process stuck in the protocol loop in the kernel ioctl
> > > that it entered at startup.
> > > 
> > Assuming that we are still talking kernel nbd here and not enbd, I think
> 
> Yes.
> 
> > you've got that backwards. nbd_send_req() is called from do_nbd_request()
> > which is the block device request function and can therefore be called
> > from any thread running the disk task queue, which I think would normally
> 
> The disk task queue is called in the i/o context.
> 
I'm not sure what you mean by that. It runs in the context of whatever called
run_task_queue(&tq_disk); which is always some process or other waiting on
I/O so far as I can tell.

> > mean that its a thread waiting for I/O as in buffer.c:__wait_on_buffer()
> 
> It maybe is or it maybe is not, but it's not in a process context in
> any sense that I recognise at that point! The request function for any
> block device driver is normally called when the device is unplugged,
> which happens exactly when the unplug task comes to be scheduled.
> Normally, user requests land somewhere in make request, which will
> discover a plugged queue and add the new requests somewhere to the
> queue, and go away happy. The driver request function will run sometime
> later (when the queue decides to unplug itself).
> 
By process context, I mean "not in an interrupt and not in a bottom 
half/tasklet/softirq context". In otherwords, its a context where its
legal to block under the normal rules for blocking processes.

> Devices are plugged as soon as the queue is drained, and the unplug
> task is scheduled for later at that point.
> 
> > The loop that the ioctl runs only does network receives and thus doesn't
> 
> The ioctl does both sends and recieves. It runs a loop waiting for
No it doesn't. The ioctl() only deals with receives from the network. Sends 
are all done by the thread which calls the request function for nbd.

[snip]
> 
> > do any allocations of any kind itself. The only worry on the receive side
> > is that buffers are not available in the network device driver, but this
> > doesn't seem to be a problem. There are no backed up replies in the
> 
> Well, I imagine it is a fact. Yes, we can starve tcp of receive buffers
> too. But that doesn't matter, does it? Nobody will die from not being
> able to read stuff for a little while? Userspace will block a bit ...
> and yes, maybe the net could time out.
> 
> I think we could starve the net to death while nbd is trying to read
> from it, if tcp can't get buffers because of i/o competition.
> 
Since I wrote this I've gained more evidence. Reports suggest that if we mark
the send thread PF_MEMALLOC during the writeout, we land up completely
starving everything else of memory in low memory situations. If we run out
of buffers for network receives we are equally stuck because no acknowledgements
get through resulting in no buffers ever being marked as finished with I/O.
If we get to that state, we are well and truely stuck so we need to avoid it
at all costs.

> > server (we can tell from the socket queue lengths) and we know that we
> > can still ping clients which are otherwise dead due to the deadlock. I
> > don't think that at the moment there is any problem on the receive side.
> 
> If so, it's because the implementation uses the receive buffer as a
> stack :-). Nothing else qould account for it.
> 
I'm not sure quite what you are getting at here ...

> > > So I think that your PF_MEMALLOC idea does revert the inversion.
> > > 
> > > Would it also be good to prevent other processes running? or is it too
> > > late. Yes, I think it is too late to do any good, by the time we feel
> > > this pressure.
> 
> > The mechanism works fine for block devices which do not need to allocate
> > memory in their write out paths. Since we know there is a maximum amount
> > of memory required by nbd and bounded by the maximum request size plus the
> > small header per request, it would seem reasonable that to avoid deadlock
> > we simply need to raise the amount of memory reserved for low memory
> > situations until we've provided what nbd needs,
> 
> That is precisely max_sectors.
> 
> Peter
> 
Well there is extra overhead in allocating the skbs etc., but broadly yes, it
is bounded by the amount of I/O that we want to do.

I do still have my zerocopy patch which should help greatly in the writeout
path for those with suitable hardware, but I've been keeping it back because
I think it would tend to hide the problem for some people and I'd rather not
do that until we have a general solution.

I'm going to try and come up with some more ideas to test in the next few days
so I'm still hopeful that it can be solved in a reasonably simple way,

Steve.

