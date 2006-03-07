Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWCGEHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCGEHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 23:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCGEHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 23:07:37 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:31989 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932295AbWCGEHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 23:07:36 -0500
Message-ID: <440D06E9.1020901@cfl.rr.com>
Date: Mon, 06 Mar 2006 23:07:05 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, drepper@gmail.com, da-x@monatomic.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
References: <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net> <440CE336.3080504@cfl.rr.com> <20060306.190428.23731173.davem@davemloft.net>
In-Reply-To: <20060306.190428.23731173.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> You didn't google hard enough, my blog entry on the topic
> comes up as the first entry when you google for "Van Jacobson
> net channels".
> 

Thanks, I read the page... I find it to be a little extreme, and zero 
copy aio can get the same benefits without all that hassle.  Let me 
write this as a reply to the article itself:


> With SMP systems this "end host" concept really should be extended to
> the computing entities within the system, that being cpus and threads
> within the box.


I agree; all threads and cpus should be able to concurrently process 
network IO, and without wasting cpu cycles copying the data around 6 
times.  That does not, and should not mean moving the TCP/IP protocol to 
user space.


> So, given all that, how do you implement network packet receive
> properly? Well, first of all, you stop doing so much work in interrupt
> (both hard and soft) context. Jamal Hadi Salim and others understood
> this quite well, and NAPI is a direct consequence of that understanding.
> But what Van is trying to show in his presentation is that you can take
> this further, in fact a _lot_ further.


I agree; a minimum of work should be done in interrupt context. 
Specifically the interrupt handler should simply insert and remove 
packets from the queue and program the hardware registers for DMA access 
to the packet buffer memory.  If the hardware supports scatter/gather 
DMA, then the upper layers can enqueue packet buffers to send/recieve 
into/from and the interrupt handler just pulls packets off this queue 
when the hardware raises an interrupt to indicate it has completed the 
DMA transfer.


This is how NT and I believe BSD have been doing things for some time 
now, and the direction the Linux kernel is moving in.

> A Van Jacobson channel is a path for network packets. It is
> implemented as an array'd queue of packets. There is state for the
> producer and the consumer, and it all sits in different cache lines so
> that it is never the case that both the consumer and producer write to
> shared cache lines. Network cards want to know purely about packets, yet
> for years we've been enforcing an OS determined model and abstraction
> for network packets upon the drivers for such cards. This has come in
> the form of "mbufs" in BSD and "SKBs" under Linux, but the channels are
> designed so that this is totally unnecessary. Drivers no longer need to
> know about what the OS packet buffers look like, channels just contain
> pointers to packet data.

I must admit, I am a bit confused by this.  It sounds a lot like the pot 
calling the kettle black to me.  Aren't SKBs and mbufs already just a 
form of the very queue of packets being advocated here?  Don't they 
simply list memory ranges for the driver to transfer to the nic as a 
packet?

> The next step is to build channels to sockets. We need some
> intelligence in order to map packets to channels, and this comes in the
> form of a tiny packet classifier the drivers use on input. It reads the
> protocol, ports, and addresses to determine the flow ID and uses this to
> find a channel. If no matching flow is found, we fall back to the basic
> channel we created in the first step. As sockets are created, channel
> mappings are installed and thus the driver classifier can find them
> later. The socket wakes up, and does protocol input processing and
> copying into userspace directly out of the channel.

How is this any different from what we have now, other than bypassing 
the kernel buffer?  The tcp/ip layer looks at the incoming packet to 
decide what socket it goes with, and copies it to the waiting buffer. 
Right now that waiting buffer is a kernel buffer, because at the time 
the packet arrives, the kernel does not have any user buffers.

If the user process uses aio though, it can hand the kernel a few 
buffers to receive into ahead of time so when the packets have been 
classified, they can be copied directly to the user buffer.

> And in the next step you can have the socket ask for a channel ID
> (with a getsockopt or something like that), have it mmap() a receive
> ring buffer into user space, and the mapped channel just tosses the
> packet data into that mmap()'d area and wakes up the process. The
> process has a mini TCP receive engine in user space.

There is no need to use mmap() and burden the user code with 
implementing TCP itself ( which is quite a lot of work ).  It can hand 
the kernel buffers by queuing multiple O_DIRECT aio requests and the 
kernel can directly dump the data stream there after stripping off the 
headers.  When sending it can program the hardware to directly 
scatter/gather DMA from the user buffer attached to the aio request.

> And you can take this even further than that (think, remote systems).
> At each stage Van presents a table of profiled measurements for a normal
> bulk TCP data transfer. The final stage of channeling all the way to
> userspace is some 6 times faster than what we're doing today, yes I said
> 6 times faster that isn't a typo.


Yes, we can and should have a 6 times speed up, but as I've explained 
above, NT has had that for 10 years without having to push TCP into user 
space.

