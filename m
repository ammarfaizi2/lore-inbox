Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAIPhe>; Tue, 9 Jan 2001 10:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbRAIPhY>; Tue, 9 Jan 2001 10:37:24 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32232 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129884AbRAIPhH>;
	Tue, 9 Jan 2001 10:37:07 -0500
Date: Tue, 9 Jan 2001 15:27:02 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109152702.E9321@redhat.com>
In-Reply-To: <20010109142542.G4284@redhat.com> <Pine.LNX.4.30.0101091547520.4491-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0101091547520.4491-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 04:00:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 04:00:34PM +0100, Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> 
> we do have SLAB [which essentially caches structures, on a per-CPU basis]
> which i did take into account, but still, initializing a 600+ byte kiovec
> is probably more work than the rest of sending a packet! I mean i'd love
> to eliminate the 200+ bytes skb initialization as well, it shows up.

Reusing a kiobuf for a request involves setting up the length, offset
and maybe errno fields, and writing the struct page *'s into the
maplist[].  Nothing more.

> > Bad bad bad.  We already have SCSI devices optimised for bandwidth
> > which don't approach decent performance until you are passing them 1MB
> > IOs, [...]
> 
> The fact that we're using single-page interfaces doesnt preclude us from
> having nicely clustered requests, this is what IO-plugging is about!

We've already got measurements showing how insane this is.  Raw IO
requests, plus internal pagebuf contiguous requests from XFS, have to
get broken down into page-sized chunks by the current ll_rw_block()
API, only to get reassembled by the make_request code.  It's
*enormous* overhead, and the kiobuf-based disk IO code demonstrates
this clearly.  

We have already shown that the IO-plugging API sucks, I'm afraid.

> > and even in networking the 1.5K packet limit kills us in some cases
> > and we need an interface capable of generating jumbograms.
> 
> which cases?

Gig Ethernet, HIPPI...  It's not so bad with an intelligent
controller, admittedly.

> > but if you're doing udp jumbograms (or STP or VIA), you do need an
> > interface which can give the networking stack more than one page at
> > once.
> 
> nothing prevents the introduction of specialized interfaces - if they feel
> like they can get enough traction.

So you mean we'll introduce two separate APIs for general zero-copy,
just to get around the problems in the single-page-based on?

> I was talking about the normal Linux IO
> APIs, read()/write()/sendfile(), which are byte granularity and invoke an
> almost mandatory buffering/clustering mechanizm in every kernel subsystem
> they deal with.

Only tcp and ll_rw_block.  ll_rw_block has already been fixed in the
SGI patches, and gets _much_ better performance as a result.  udp
doesn't do any such clustering.  That leaves tcp.

The presence of terrible performance in the old ll_rw_block code is
NOT a good excuse for perpetuating that model.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
