Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSFLTL4>; Wed, 12 Jun 2002 15:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317768AbSFLTLz>; Wed, 12 Jun 2002 15:11:55 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48101 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317767AbSFLTLy>; Wed, 12 Jun 2002 15:11:54 -0400
Date: Wed, 12 Jun 2002 12:13:08 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@redhat.com>, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org
Message-id: <3D079D44.4000701@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
 <20020611173347.21348@smtp.adsl.oleane.com>
 <20020612.024224.60294929.davem@redhat.com> <3D075739.7010506@pacbell.net>
 <52zny049r7.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's go back to the beginning of this discussion since I think we're
> losing sight of the original problem.

I think actually a couple were unearthed, but you're right to focus.


>  In general I certainly support
> the idea of making the DMA mapping stuff device generic instead of
> tied to PCI.  

PCI was a good place to start (focus ... :) but clearly it shouldn't
be the only bus architecture with such support.  Note that there are
actually two related approaches in the DMA-mapping.txt APIs ... one is
DMA mapping, the other is "consistent memory".  Both should be made
generic rather than PCI-specific, not just mapping APIs.


> However, this discussion started when I fixed some problems I was
> having with USB on my IBM PowerPC 440GP system (which is not cache
> coherent).  

... which basically led to discussion of options I summarized a while
back as (a) expose the issues to drivers via macros, or (b) expose
them through some other API.

And DaveM wanted to focus on (b) options that involve exposing
consistent memory to drivers as buffers (sized in multiples of
cachelines, where that matters) rather than DMA-mapping them.

Based on the discussion, I think the answer for now is to go with
the (b) variant you had originally started with, using kmalloc for
the buffers.  The __dma_buffer style macro didn't seem popular;
though I agree that it's not clear kmalloc() really solves it
today.  (Given DaveM's SPARC example, the minimum size value it
returns would need to be 128 bytes ... which clearly isn't so.)


> The current USB driver design seems pretty reasonable: only the HCD
> drivers need to know about DMA mappings, and other USB drivers just
> pass buffer addresses.  I don't think you would get much support for
> forcing every driver to handle its own DMA mapping.

Me either.  But I suspect that it'd be good to have that as an option;
maybe just add a transfer_dma field to the URB, and have the HCD use
that, instead of creating a mapping, when transfer_buffer is null.
That'd certainly be a better approach for supporting sglist in the
usb-storage code than the alternatives I've heard so far.


> I would like to see both dev_map_xxx etc. and something like
> __dma_buffer go into the kernel.  I think they both have their uses.

Got Patch?  Actually, I know you do, I shouldn't ask.  :)

- Dave




