Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSE2N0B>; Wed, 29 May 2002 09:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSE2N0A>; Wed, 29 May 2002 09:26:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315264AbSE2NZ6>;
	Wed, 29 May 2002 09:25:58 -0400
Date: Wed, 29 May 2002 15:24:54 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Pavel Machek <pavel@suse.cz>, Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
Subject: Re: Kernel deadlock using nbd over acenic driver
Message-ID: <20020529132454.GO17674@suse.de>
In-Reply-To: <20020529112137.GA397@elf.ucw.cz> <200205291210.g4TCAgh32404@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29 2002, Peter T. Breuer wrote:
> "A month of sundays ago Pavel Machek wrote:"
> > > > Init routine is called from insmod context or at kernel bootup (from pid==1).
> > > 
> > > That's nitpicking!  
> > 
> > I did not want to be nitpicking. init() really is considered process
> 
> Well, OK.
> 
> > context, and it looks to me like unplug is *blocking* operation so it
> > really needs proceess context.
> 
> unplug unsets the plugged flag and calls the request function. The
> question is whether the request function is allowed to block. I argue
> that it is not, on several grounds:
> 
>     1) it's also - and principally - been called from various task
>     queues, which aren't really associated with a process context, and
>     certainly not with the process context that set the task

It's called from tq_disk only, which is in process context. So at least
on that ground lets say that it is at least not technically illegal to
block.

>     2) blocking is really bad news depending on how we got to the
>     request function, which is not a really predictable thing, since
>       i) it can change with every kernel version
>       ii) it depends on what somebody else does

I don't agree with that. You get there from an unplug, which happens
from process context as already established. If you get there from other
places, it means that you are calling your request_fn from elsewhere in
your driver (typically recalling request_fn from isr or bottom half to
queue more I/O), and in that case it's your own responsibility.

>    3) if we block against memory for buffers, in particular, the 
>    the system is now very likely to be dead, since VM just went
>    synchronous.

Of course that is a tricky area. You shouldn't be doing memory
allocations inside the request_fn, that's just bad design, period.

The one reason why blocking inside the request_fn is bad, is that it
prevents the following queues on the tq_disk list from being run. And
subsequent tq_disk runs will not unplug them, since run_task_queue()
clears the list prior to starting.

-- 
Jens Axboe

