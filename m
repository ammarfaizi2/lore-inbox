Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATRPi>; Sat, 20 Jan 2001 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRATRP2>; Sat, 20 Jan 2001 12:15:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8202 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129444AbRATRPJ>; Sat, 20 Jan 2001 12:15:09 -0500
Date: Sat, 20 Jan 2001 13:24:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Hellwig <hch@caldera.de>
cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
In-Reply-To: <200101201557.QAA14088@ns.caldera.de>
Message-ID: <Pine.LNX.4.21.0101201301050.6579-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jan 2001, Christoph Hellwig wrote:

<snip>

> I think there is a big disadvantage of this appropeach:
> To find out which pages are clusterable, we need do do bmap/get_block,
> that means we have to go through the block-allocation functions, which
> is rather expensive, and then we have to do it again in writepage, for
> the pages that are actually clustered bt the VM.

In case the metadata was not already cached before ->cluster() (in this
case there is no disk IO at all), ->cluster() will cache it avoiding
further disk accesses by writepage (or writepages()).

> Another thing I dislike is that the flushing gets more complicated with
> yout VM-level clustering.  Now (and with my appropeach I'll describe
> below) flushing is write it out now and do whatever you else want,
> with you design it is 'find out pages beside this page in write out
> a bunch of them' - much more complicated.  I'd like it abstracted out.

I dont see your point here. What I'm missing?

> > The idea is to work with delayed allocated pages, too. A filesystem which
> > has this feature can, at its "cluster" operation, allocate delayed pages
> > contiguously on disk, and then return to the VM code which now can
> > potentially write a bunch of dirty pages in a few big IO operations.
> 
> That does also work nicely together with ->writepage level IO clustering.
> 
> > I'm sure that a bit of tuning to know the optimal cluster size will be
> > needed. Also some fs locking problems will appear.
> 
> Sure, but again that's an issue for every kind of IO clustering...
>
> 
> No my proposal.  I prefer doing it in writepage, as stated above.
> Writepage loops over the MAX_CLUSTERED_PAGES/2 dirty pages before and
> behind the initial page, it first uses test wether the page should be
> clustered (a callback from vm, highly 'balanceable'...), then does
> a bmap/get_block to check wether it is contingous.
>
> Finally the IO is submitted using a submit_bh loop, or when using a
> kiobuf-based IO path all clustered pages are passed down to ll_rw_kio
> in one piece.
> As you see the easy integration with the new bulk-IO mechanisms is also
> an advantage of this proposal, without the need a new multi-page a_op.

IMHO replicating the code is the worst thing. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
