Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSEUR4P>; Tue, 21 May 2002 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSEUR4O>; Tue, 21 May 2002 13:56:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20740 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315276AbSEUR4N>; Tue, 21 May 2002 13:56:13 -0400
Date: Tue, 21 May 2002 10:56:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
In-Reply-To: <3CEA7740.7060204@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205211041460.2634-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, Martin Dalecki wrote:
>
> But please consider the following points:
>
> 1. Layered devices.

Sure. But to the upper layers they _do_ have a single hardsector-size.
They look (by definition) like one device, and th eupper layers must not
know that the physical devices underneath may end up having different
sector sizes.

Which is why a md queue must have a sector size that is at least as large
as the largest sector size of any of the devices underneath it.

> The only reason this isn't biting us here right now is the
> simple fact that most disks just stick with the dreaded 512 byte sector
> addressing, but there are people out there esp. from Maxtor
> complaining about this...

Absolutely not. Even if Maxtor were to do a 2kB-sector disk, that only
means that the md layer would have to make a 2kB-sector md device.

We have the support for all of this already, as many (most?) SCSI CD-ROM's
are 2kB-only.

> 2. Removable media like CD-ROM contain already somehow inherently
> the property of needing to deal with different sector sizes.
> There are for example 1024 and 2048 byte modes for CD-ROMs.

Sure. We have allt he support for this, and the queue sector size can (and
does) change when you change a removable media.

I repeat: there is no design limitation in ll_rw_block().

> 3. I would love it to handle multiple sector transfers just as
> big hard-sector sizes :-)

That's up to _you_, the driver.

The driver can choose to consider 2 512-byte sectors to be equivalent to 1
1024-byte sector. The _only_ thing the "hardsector size" means is that the
driver _guarantees_ that it can handle any IO request of that size. It's
really a promise upwards toward higher layers, not a limitation on the
driver.

> Linus - recycling the same request queue would simplify the
> serialization issues by a significant amount.

I don't see that at ALL.

The ll_rw_blk code _explicitly_ has a spinlock pointer (instead of a plain
spinlock) in the queue structure _exactly_ because the code knows (and
expects) different devices to want to have common synchronization.

Any other synchronization is totally up to the driver: a driver can, at
any point, just stop doing requests and waiting until all of its requests
are done, if it wants to find some "idle point".

> We have already
> a mechanism for passing the spin lock to use to the upper
> layer (blk_init_queue()). It would be just natural if it was
> acting as kind of a true semaphore for overall request serialization. But
> currently it's just used to serialize the access to the corresponding
> queue lists, which doesn't buy us *anything*,

That's a load of baloney.

If you want a semaphore in the driver, you just add one. There is
absolutely _nothing_ in the upper layers that wants to have a semaphore,
never has been, and never will be. It's a internal driver issue, and as
such no such semaphore should ever be exposed to upper layers.

The upper layers do not care, and CANNOT care. They put requests on the
queue, and if the lower layer is serializing itself for some reason, the
upper layer has no reason to know - except by the fact that the results
don't come back, of course.

What would the upper layers do with the semaphore? Nothing.

> The other things which ll_rw_blk.c doesn't get right is the
> fact that the current merge functions don't respect hard sector
> sizes

They aren't there to be respected by the ll_rw_blk layer - if some layer
above it has created a request larger than the hard sector size, THAT is
the problem, and there is nothing ll_rw_blk can do (except maybe BUG() on
it, but I don't think we've ever really seen those kinds of bugs).

		Linus

