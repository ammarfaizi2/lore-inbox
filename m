Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSEWNVW>; Thu, 23 May 2002 09:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSEWNVV>; Thu, 23 May 2002 09:21:21 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:10764 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316637AbSEWNVU>;
	Thu, 23 May 2002 09:21:20 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205231321.g4NDL1E17401@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205170844.JAA30049@gw.chygwyn.com> from Steven Whitehouse at
 "May 17, 2002 09:44:51 am"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Thu, 23 May 2002 15:21:01 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry .. I didn't see this earlier. I was on a trip. Just to clear up a
couple of thinsg ...

"A month of sundays ago Steven Whitehouse wrote:"
> > Sorry I didn't pick this up earlier ..
> > "Steven Whitehouse wrote:"
> > > we don't want to alter that. The "priority inversion" that I mentioned occurs
> > > when you get processes without PF_MEMALLOC set calling nbd_send_req() as when
> > 
> > There aren't any processes that call nbd_send_req except the unique
> > nbd client process stuck in the protocol loop in the kernel ioctl
> > that it entered at startup.
> > 
> Assuming that we are still talking kernel nbd here and not enbd, I think

Yes.

> you've got that backwards. nbd_send_req() is called from do_nbd_request()
> which is the block device request function and can therefore be called
> from any thread running the disk task queue, which I think would normally

The disk task queue is called in the i/o context.

> mean that its a thread waiting for I/O as in buffer.c:__wait_on_buffer()

It maybe is or it maybe is not, but it's not in a process context in
any sense that I recognise at that point! The request function for any
block device driver is normally called when the device is unplugged,
which happens exactly when the unplug task comes to be scheduled.
Normally, user requests land somewhere in make request, which will
discover a plugged queue and add the new requests somewhere to the
queue, and go away happy. The driver request function will run sometime
later (when the queue decides to unplug itself).

Devices are plugged as soon as the queue is drained, and the unplug
task is scheduled for later at that point.

> The loop that the ioctl runs only does network receives and thus doesn't

The ioctl does both sends and recieves. It runs a loop waiting for
requests to appear on the internal device queue (the request function
puts them there, after taking them off the kernel queue). When
one appears it sends it over the net. If it's a write, it also sends
data. Then it waits for the ack from the net. If the request is a read,
the ack will also be followed by data. That's the cycle.

> do any allocations of any kind itself. The only worry on the receive side
> is that buffers are not available in the network device driver, but this
> doesn't seem to be a problem. There are no backed up replies in the

Well, I imagine it is a fact. Yes, we can starve tcp of receive buffers
too. But that doesn't matter, does it? Nobody will die from not being
able to read stuff for a little while? Userspace will block a bit ...
and yes, maybe the net could time out.

I think we could starve the net to death while nbd is trying to read
from it, if tcp can't get buffers because of i/o competition.

> server (we can tell from the socket queue lengths) and we know that we
> can still ping clients which are otherwise dead due to the deadlock. I
> don't think that at the moment there is any problem on the receive side.

If so, it's because the implementation uses the receive buffer as a
stack :-). Nothing else qould account for it.

> > So I think that your PF_MEMALLOC idea does revert the inversion.
> > 
> > Would it also be good to prevent other processes running? or is it too
> > late. Yes, I think it is too late to do any good, by the time we feel
> > this pressure.

> The mechanism works fine for block devices which do not need to allocate
> memory in their write out paths. Since we know there is a maximum amount
> of memory required by nbd and bounded by the maximum request size plus the
> small header per request, it would seem reasonable that to avoid deadlock
> we simply need to raise the amount of memory reserved for low memory
> situations until we've provided what nbd needs,

That is precisely max_sectors.

Peter
