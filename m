Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274565AbRITROz>; Thu, 20 Sep 2001 13:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274567AbRITROp>; Thu, 20 Sep 2001 13:14:45 -0400
Received: from [208.129.208.52] ([208.129.208.52]:28430 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274565AbRITROc>;
	Thu, 20 Sep 2001 13:14:32 -0400
Message-ID: <XFMail.20010920101821.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA97155.4D2D53AC@distributopia.com>
Date: Thu, 20 Sep 2001 10:18:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-2001 Christopher K. St. John wrote:
> Davide Libenzi wrote:
>> 
>> Here are examples basic functions when used with
>> coroutines.
>>
>  
>  I think all might be made clear if you did a quick
> test harness that didn't use coroutines. I'm guessing
> the vast majority of potential users will not be using
> a coroutine library.
> 
>  On "nio-improve" page, you've got:
> 
>         for (;;) {
>           evp.ep_timeout = STD_SCHED_TIMEOUT;
>           evp.ep_resoff = 0;
>           nfds = ioctl(kdpfd, EP_POLL, &evp);
>           pfds = (struct pollfd *) (map + evp.ep_resoff);
>           for (ii = 0; ii < nfds; ii++, pfds++) {
>              ...
>           }
>         }

Coroutines or not, this does not change the picture.
All multiplexed servers have an IO driven scheduler that calls
code sections based on the fd.
Obviously if you've a one-thread-per-socket model, epoll is not your answer.



>  Assume your server is so overloaded that you need
> to avoid any unproductive calls to read() or write()
> or accept(). Assume that instead of many very fast
> connections coming in at a furious rate, you get a
> large steady current of very slow connections.

>>>> Sorry, bad editing, that should be:
>> Assume a large but bursty current of low bandwidth
>> high latency connections instead of a continuous steady
>> flood of high bandwidth low latency connections.

>  If you try to flesh out the above template with those
> goals in mind, I think you'll quickly see what I've
> been trying to get at with regard to the awkwardness
> of not getting back some indication of the initial
> state of the fd.
> 
>  The current situation isn't fatal, just awkward. And
> fixable. For the low low price of a tiny bit of
> idealogical purity...

Again, no.
If you need to request the current status of a socket you've to f_ops->poll the fd.
The cost of the extra read, done only for fds that are not "ready", is nothing
compared to the cost of a linear scan with HUGE numbers of fds.
You could implement a solution where the low level io functions goes directly to write
inside the mmapped fd set where the data buffer is empty or the out buffer is full.
This would be a way more intrusive patch whose perf gain won't match the cost.




- Davide

