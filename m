Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271575AbRIBEJZ>; Sun, 2 Sep 2001 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271577AbRIBEJP>; Sun, 2 Sep 2001 00:09:15 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34821 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271575AbRIBEJD>; Sun, 2 Sep 2001 00:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 06:16:05 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20010901202823.303eb0eb.skraw@ithnet.com> <20010902015023Z16303-32383+2910@humbolt.nl.linux.org> <200109020226.f822QCS18912@maile.telia.com>
In-Reply-To: <200109020226.f822QCS18912@maile.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902040918Z16303-32383+2931@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 04:21 am, Roger Larsson wrote:
> On Sunday den 2 September 2001 03:57, Daniel Phillips wrote:
> > In some sense, it's been good to have the issue
> > forced so that we must come up with ways to make atomic and higher order
> > allocations less fragile.
> 
> It might be that the elevator works now... :-)

You think it's the elevator?  It could be, but scanning policy seems much
more likely.

> You will only see it once there are no remaining free pages of an even
> higher order left - then you will start to fail...
> 
> Two things are required:
> 1) You have lots of memory.

Actually, the situation improves a little as you add memory.  I'll show that
mathematically tomorrow.

> 2) You have used it all at some point.

This is the normal case, except for startup and a few special situations such 
as after heavy file deletion or unmounting a volume.

> Another thing to do could be to add a order parameter to free.
> The pages allocated has to be freed sometime... if we make sure that
> they are freed together it could simplify things - no chance that the
> first part gets allocated directly...

We must be getting a little bit of avoidable fragmentation on freeing, but 
the real culprit is allocation, which tends to split up higher order 
allocations rapidly.

> Or/and we could remove the sources of higher order allocs, as an example:
> why is the SCSI layer allowed to allocate order 3 allocs (32 kB) several
> times per second? Will we really get a performance hit by not allowing
> higher order allocs in active driver code?

Yes, well, if we make it work properly that might not be necessary ;-)

I imagine a lot of higher order allocations could be removed without hurting 
performance, for example, where dma can handle non-physically-contiguous 
regions (i.e., scatter/gather).  On the other hand, leaving them just the way 
they are creates more incentive to fix the damn thing, not to mention 
providing the needed test cases.

--
Daniel
