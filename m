Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbRATP60>; Sat, 20 Jan 2001 10:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbRATP6Q>; Sat, 20 Jan 2001 10:58:16 -0500
Received: from ns.caldera.de ([212.34.180.1]:22534 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129982AbRATP6L>;
	Sat, 20 Jan 2001 10:58:11 -0500
Date: Sat, 20 Jan 2001 16:57:58 +0100
Message-Id: <200101201557.QAA14088@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.21.0101192142060.6167-100000@freak.distro.conectiva>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0101192142060.6167-100000@freak.distro.conectiva> you wrote:
> The write clustering issue has already been discussed (mainly at Miami)
> and the agreement, AFAIK, was to implement the write clustering at the
> per-address-space writepage() operation.

> IMO there are some problems if we implement the write clustering in this
> level:

>   - The filesystem does not have information (and should not have) about
>     limiting cluster size depending on memory shortage.

Agreed.

>   - By doing the write clustering at a higher level, we avoid a ton of
>     filesystems duplicating the code.

Most filesystems share their writepage-implementation, and most
others have special requirements on write clustering anyway.

For example extent-based filesystems (xfs, jfs) usually want to write out
more pages even if the VM doesn't see a need, just for effiecy reasons.

Network-based filesystems also need special care vs. writeclustering,
because the network behaves different from a typical disk...

> So what I suggest is to add a "cluster" operation to struct address_space
> which can be used by the VM code to know the optimal IO transfer unit in
> the storage device. Something like this (maybe we need an async flag but
> thats a minor detail now):

>         int (*cluster)(struct page *, unsigned long *boffset, 
> 		unsigned long *poffset);

> "page" is from where the filesystem code should start its search for
> contiguous pages. boffset and poffset are passed by the VM code to know
> the logical "backwards offset" (number of contiguous pages going backwards
> from "page") and "forward offset" (cont pages going forward from
> "page") in the inode.

I think there is a big disadvantage of this appropeach:
To find out which pages are clusterable, we need do do bmap/get_block,
that means we have to go through the block-allocation functions, which
is rather expensive, and then we have to do it again in writepage, for
the pages that are actually clustered bt the VM.

Another thing I dislike is that the flushing gets more complicated with
yout VM-level clustering.  Now (and with my appropeach I'll describe
below) flushing is write it out now and do whatever you else want,
with you design it is 'find out pages beside this page in write out
a bunch of them' - much more complicated.  I'd like it abstracted out.

> The idea is to work with delayed allocated pages, too. A filesystem which
> has this feature can, at its "cluster" operation, allocate delayed pages
> contiguously on disk, and then return to the VM code which now can
> potentially write a bunch of dirty pages in a few big IO operations.

That does also work nicely together with ->writepage level IO clustering.

> I'm sure that a bit of tuning to know the optimal cluster size will be
> needed. Also some fs locking problems will appear.

Sure, but again that's an issue for every kind of IO clustering...

No my proposal.  I prefer doing it in writepage, as stated above.
Writepage loops over the MAX_CLUSTERED_PAGES/2 dirty pages before and
behind the initial page, it first uses test wether the page should be
clustered (a callback from vm, highly 'balanceable'...), then does
a bmap/get_block to check wether it is contingous.

Finally the IO is submitted using a submit_bh loop, or when using a
kiobuf-based IO path all clustered pages are passed down to ll_rw_kio
in one piece.
As you see the easy integration with the new bulk-IO mechanisms is also
an advantage of this proposal, without the need a new multi-page a_op.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
