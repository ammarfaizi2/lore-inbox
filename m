Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSKDPzK>; Mon, 4 Nov 2002 10:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSKDPzD>; Mon, 4 Nov 2002 10:55:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14145 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264717AbSKDPy7>; Mon, 4 Nov 2002 10:54:59 -0500
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@codemonkey.org.uk>, boissiere@adiglobal.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
References: <Pine.LNX.3.95.1021104092931.11983B-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Nov 2002 08:58:59 -0700
In-Reply-To: <Pine.LNX.3.95.1021104092931.11983B-100000@chaos.analogic.com>
Message-ID: <m165vdgwcc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> The initial premise is fundamentally flawed. That being
> that the first error you get will be a single-bit error.

I did not say a single bit error I said a correctable error.  Which
can recover if a single chip on a pair of DIMMs goes bad.

What I have seen in practice is that during manufacturing it is pretty
random weather the first error from bad memory will be correctable
or uncorrectable.  Once the memory is running error free it is
quite likely the first error will be a correctable error.  Especially
when it is the RAM that is going bad.
> 
> Isolating a bad bit in RAM caused by bad RAM is not
> done by memory "scrubbing", it is done by having the
> NMI handler disable access to the bad RAM. 

Scrubbing is for making certain the correction is written back to the RAM.
Many chipsets will correct the data going to the processor, but will leave
it corrupted in RAM.  Allowing the possibility of errors to accumulate,
and making it hard to tell if multiple reports are from the same
error or a different error.

>In an ix86
> machine, that task is very difficult because the handler,
> unlike a page-fault handler, has no direct knowledge of
> the page being accessed when the NMI occurred. 

We are obviously working with quite different hardware.  Intel
chipsets routinely report an ECC error on the page level granularity.

> One could
> "inspect" the code leading up to the fault, and guess what
> memory access occurred but that access is quite likely
> in the .text segment which means the code isn't even
> correct to inspect.  

I have seen no NMI error that ever trigger a cpu exception
to be synchronous with the code, though that may be possible with
an Athlon, which does the ECC correction in the CPU.  In general the
errors come in asynchronously at some point after the error occured.
So even killing the task that is using the bad RAM is unreliable.
If the error is not correctable, on a server I panic the machine.

> This stuff is possible to do, and
> now that gigabytes of RAM are commonplace, it would
> probably be a welcome addition to the kernel because the
> probability of a single-bit error in ba-zillions of bits
> is quite high.
> 
> Any "memory scrubbing" routines are worthless and simply
> eat CPU cycles. 

Functional memory in practice does not have ECC errors, so 
ECC code does not run.  I only run the scrub routine on memory
that has reported a correctable error.  And I think
1200 machines with 4GB each, running processor intensive tasks is a
reasonable sample to make this conclusion with.

>Further, because of the well-established
> principle of locality-of-action, you can have multiple
> pages of trashed data in RAM, owned by all those sleeping
> processes, that won't be accessed until the next boot.
> If you want a reliable system, it's better to let sleeping
> dogs lie and not access that RAM. You certainly don't want
> to "scrub" it. That's like picking a scab. It will bleed.

I do not randomly scrub memory, though for the hardware that does
not do that I am  not be opposed to the idea of a daemon that does.
The biggest problem with doing that in the cpu is that you are likely
to trash your cache.

One of the bigger challenges to work through is that frequently leaves
a few ECC error after setting up RAM.  So a cpu scrubber might trigger
those.  Replacing the BIOS is a good way to be certain that doesn't
happen :)

Eric
