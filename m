Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317565AbSFMJh4>; Thu, 13 Jun 2002 05:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSFMJhz>; Thu, 13 Jun 2002 05:37:55 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:22913 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317565AbSFMJhy>; Thu, 13 Jun 2002 05:37:54 -0400
Date: Wed, 12 Jun 2002 22:13:17 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: roland@topspin.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Message-id: <3D0829ED.1020809@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <3D075739.7010506@pacbell.net> <52zny049r7.fsf@topspin.com>
 <3D079D44.4000701@pacbell.net> <20020612.154628.65960832.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: David Brownell <david-b@pacbell.net>
>    Date: Wed, 12 Jun 2002 12:13:08 -0700
> 
>    > The current USB driver design seems pretty reasonable: only the HCD
>    > drivers need to know about DMA mappings, and other USB drivers just
>    > pass buffer addresses.  I don't think you would get much support for
>    > forcing every driver to handle its own DMA mapping.
>    
>    Me either.  But I suspect that it'd be good to have that as an option;
>    maybe just add a transfer_dma field to the URB, and have the HCD use
>    that, instead of creating a mapping, when transfer_buffer is null.
>    That'd certainly be a better approach for supporting sglist in the
>    usb-storage code than the alternatives I've heard so far.
> 
> Another solution for the "small chunks" issue is to in fact keep all
> of the real DMA buffers in the host controller driver.  Ie. a pool
> of tiny consitent DMA memory bounce buffers.  That is an idea for 
> discussion, I have no particular preference.

Interesting idea.  I'd rather have the "hcd framework" layer
manage such stuff than have each of N host controller drivers
trying to do the same thing though ... less likely to turn
into bug heaven.


> This could actually improve performance for things like the input
> layer USB drivers.  On several systems multiple cache lines are
> fetched when a keyboard key is typed, and this is because we use
> streaming buffers instead of consistent ones for these transfers.

And that's exactly the problem scenario, since it uses the "automagic
resubmit" model with interrupt transfers.  Each of the HCDs needs to
handle that differently -- different behaviors, different bugs, yeech.
I won't go into it now, but a queued transfer model would work a lot
better.


> We have two problems we want to solve, the DMA alignment stuff and
> using consistent memory for these small buffers.  Therefore moving to
> consistent memory (by whatever mechanism the USB desires to implement
> this) is the way to go.

Right, the alignment stuff is a correctness issue, the consistent
memory issue is a performance concern.  I like to think that 2.5
will have a lot less correctness issues in the USB stack, so it
can start to pay more attention to performance concerns.

- Dave




