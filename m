Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129451AbRBFALl>; Mon, 5 Feb 2001 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129611AbRBFALb>; Mon, 5 Feb 2001 19:11:31 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25536 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129451AbRBFALU>;
	Mon, 5 Feb 2001 19:11:20 -0500
Date: Tue, 6 Feb 2001 00:07:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206000704.F1167@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com> <20010205205429.V1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010205205429.V1167@redhat.com>; from sct@redhat.com on Mon, Feb 05, 2001 at 08:54:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, if we take a step back what does this look like:

On Mon, Feb 05, 2001 at 08:54:29PM +0000, Stephen C. Tweedie wrote:
> 
> If we are doing readahead, we want completion callbacks raised as soon
> as possible on IO completions, no matter how many other IOs have been
> merged with the current one.  More importantly though, when we are
> merging multiple page or buffer_head IOs in a request, we want to know
> exactly which buffer/page contents are valid and which are not once
> the IO completes.

This is the current situation.  If the page cache submits a 64K IO to
the block layer, it does so in pieces, and then expects to be told on
return exactly which pages succeeded and which failed.

That's where the mess of having multiple completion objects in a
single IO request comes from.  Can we just forbid this case?

That's the short cut that SGI's kiobuf block dev patches do when they
get kiobufs: they currently deal with either buffer_heads or kiobufs
in struct requests, but they don't merge kiobuf requests.  (XFS
already clusters the IOs for them in that case.)

Is that a realistic basis for a cleaned-up ll_rw_blk.c?

It implies that the caller has to do IO merging.  For read, that's not
much pain, as the most important case --- readahead --- is already
done in a generic way which could submit larger IOs relatively easily.
It would be harder for writes, but high-level write clustering code
has already been started.

It implies that for any IO, on IO failure you don't get told which
part of the IO failed.  That adds code to the caller: the page cache
would have to retry per-page to work out which pages are readable and
which are not.  It means that for soft raid, you don't get told which
blocks are bad if a stripe has an error anywhere.  Ingo, is that a
potential problem?

But it gives very, very simple semantics to the request layer: single
IOs go in (with a completion callback and a single scatter-gather
list), and results go back with success or failure.

With that change, it becomes _much_ more natural to push a simple sg
list down through the disk layers.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
