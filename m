Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264682AbSKDOao>; Mon, 4 Nov 2002 09:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSKDOao>; Mon, 4 Nov 2002 09:30:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35971 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264682AbSKDOam>; Mon, 4 Nov 2002 09:30:42 -0500
Date: Mon, 4 Nov 2002 09:31:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@codemonkey.org.uk>, boissiere@adiglobal.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
In-Reply-To: <m1adksgo4a.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1021104092931.11983B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2002, Eric W. Biederman wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > On 1 Nov 2002, Alan Cox wrote:
> > 
> > > On Fri, 2002-11-01 at 14:05, Eric W. Biederman wrote:
> > > > When you have a correctable ECC error on a page you need to rewrite the
> > > > memory to remove the error.  This prevents the correctable error from
> > becoming
> > 
> > > > an uncorrectable error if another bit goes bad.  Also if you have a
> > > > working software memory scrub routine you can be certain multiple
> > > > errors from the same address are actually distinct.  As opposed to
> > > > multiple reports of the same error.
> > > 
> > > Note that this area has some extremely "interesting" properties. For one
> > > you have to be very careful what operation you use to scrub and its
> > > platform specific. On x86 for example you want to do something like lock
> > > addl $0, mem. A simple read/write isnt safe because if the memory area
> > > is a DMA target your read then write just corrupted data and made the
> > > problem worse not better!
> 
> yep lock addl $0, mem  with the appropriate kmaps so it will work on any system
> I use.  It isn't rocket science but since it is using kmap_atomic that function
> at least should probably get in the kernel.
> 
> > The correctable ECC is supposed to be just that (correctable). It's
> > supposed to be entirely transparent to the CPU/Software. An additional
> > read of the affected error produces the same correction so the CPU
> > will never even know. The x86 CPU/Software is only notified on an
> > uncorrectable error. I don't know of any SDRAM controller that
> > generates an interrupt upon a correctable error. Some store "logging"
> > information internally, very difficult to get at on a running system.
> 
> Polling the memory controller periodically isn't hard, and you can usually
> get an interrupt as well.  Though I have not explored the whole interrupt
> territory.  Finding out when you have a corrected error is extremely useful
> as it gives a warning that your memory is going bad.  Just like with a disk
> getting a bunch of errors means it is time to be replaced, but you still
> have a little time left.
> 
> > Given that, "scrubbing" RAM seems to be somewhat useless on a
> > running system. The next write to the affected area will fix the
> > ECC bits, that't what is supposed to clear up the condition.
> 
> If it is your kernel text space that is getting the error there will
> be no next write.
> 
> Beyond that if you are trying to see if the multiple correctable errors
> you have are a single error, or an actual problem software scrubbing helps.
> Because then you know the second report was because the problem reoccured.
> Making it likely you have a bad bit in your DIMM.
> 
> Eric
> 

The initial premise is fundamentally flawed. That being
that the first error you get will be a single-bit error.

Memory is not a bunch of randomly spaced bits that get
coalesced into bites/shorts/longs when accessed. Instead,
all the bits in a word are in the same general area. This
means that a nuclear event will alter several. In fact,
a nuclear event will likely put an "electronic hole" in
a physical area of memory. This area may cross several
memory "block" boundaries. These blocks are not usually
related to physical pages at all. These blocks have
different bit-densities depending upon the type and
manufacturer.  Typical bit-densities are 16, 64, 128,
and 256 megabits.  They are organized into banks so
they can be addressed in rows and columns, minimizing
the hardware. The result of a nuclear event may look
like this:

Base
         _______________________________________
0x1000   | Bank 1 |  Bank 2 |  Bank 3 | Bank 4 |
0x8000   |        |         | /       |        |
0x10000  |--------|---------/---------|--------|
0x18000  | Bank 5 |  Bank / |  Bank 7 | Bank 8 |
0x20000  |        |     /   |         |        |
0x0000   -------------/-------------------------
                    /
Particle trail---->

In this case, the event altered bits in bank 6 and
bank 3. It may have altered bits in 2 and 7 also.
The hits altered bits at many memory addresses as
the diagram shows. The bits that got altered are
in the hundreds of thousands (of bits). If you read
these areas, without disabling ECC, you will get
a NMI. If you read these areas with modern ECC
hardware, the read, just like a write, will correct
the ECC bits.  Therefore, you have "fixed" corrupt
memory data.  This is not good.

Isolating a bad bit in RAM caused by bad RAM is not
done by memory "scrubbing", it is done by having the
NMI handler disable access to the bad RAM. In an ix86
machine, that task is very difficult because the handler,
unlike a page-fault handler, has no direct knowledge of
the page being accessed when the NMI occurred. One could
"inspect" the code leading up to the fault, and guess what
memory access occurred but that access is quite likely
in the .text segment which means the code isn't even
correct to inspect.  This stuff is possible to do, and
now that gigabytes of RAM are commonplace, it would
probably be a welcome addition to the kernel because the
probability of a single-bit error in ba-zillions of bits
is quite high.

Any "memory scrubbing" routines are worthless and simply
eat CPU cycles. Further, because of the well-established
principle of locality-of-action, you can have multiple
pages of trashed data in RAM, owned by all those sleeping
processes, that won't be accessed until the next boot.
If you want a reliable system, it's better to let sleeping
dogs lie and not access that RAM. You certainly don't want
to "scrub" it. That's like picking a scab. It will bleed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


