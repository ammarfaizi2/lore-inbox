Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317685AbSFKPLb>; Tue, 11 Jun 2002 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317686AbSFKPLa>; Tue, 11 Jun 2002 11:11:30 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:689 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317685AbSFKPL3>; Tue, 11 Jun 2002 11:11:29 -0400
Date: Tue, 11 Jun 2002 08:12:35 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D061363.70500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <3D058B41.6010601@pacbell.net>
 <20020610.224401.13280464.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    One question is whether to support only one of them, or allow both.
>    In either case the DMA-mapping.txt will need to touch on the issue.
> 
> Another important issue is from where do these issues originate?
> 
> This stuff rarely happens most of the time because block buffers and
> networking buffers are what are fed to the chip.

I think the examples Oliver found related mostly to device control
and status tracking.


> I still think it is crucial that we not put this alignment garbage
> into the drivers themselves.  Driver writers are going to get it
> wrong or be confused by it.

I guess I don't see a way around exposing some of it.  Do you?

Even the (b) option requires drivers to know they can't pass pointers
to the inside of a structure, AND that memory right after the end of
an I/O buffer is unavailable.  That exposes the issue.  Although it
doesn't provide help to manage it, as (a) does, or detect it.

Should the dma mapping APIs try to detect the "DMA buffer starts in
middle of non-coherent cacheline" case, and fail?  That might be
worth checking, catching some of these errors, even if it ignores
the corresponding "ends in middle of non-coherent cacheline" case.
And it'd handle that "it's a runtime issue on some HW" concern.

Or then there's David Woodhouse's option (disable caching on those
pages while the DMA mapping is active) which seems good, except for
the fact that this issue is most common for buffers that are a lot
smaller than one page ... so lots of otherwise cacheable data would
suddenly get very slow. :)

- Dave

