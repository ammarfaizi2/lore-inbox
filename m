Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBEU64>; Mon, 5 Feb 2001 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbRBEU6q>; Mon, 5 Feb 2001 15:58:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:12226 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129130AbRBEU6n>;
	Mon, 5 Feb 2001 15:58:43 -0500
Date: Mon, 5 Feb 2001 20:54:29 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010205205429.V1167@redhat.com>
In-Reply-To: <E14Pr8G-0003zV-00@the-village.bc.nu> <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 05, 2001 at 11:28:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 11:28:17AM -0800, Linus Torvalds wrote:

> The _vectors_ are needed at the very lowest levels: the levels that do not
> necessarily have to worry at all about completion notification etc. You
> want the arbitrary scatter-gather vectors passed down to the stuff that
> sets up the SG arrays etc, the stuff that doesn't care AT ALL about the
> high-level semantics.

OK, this is exactly where we have a problem: I can see too many cases
where we *do* need to know about completion stuff at a fine
granularity when it comes to disk IO (unlike network IO, where we can
usually rely on a caller doing retransmit at some point in the stack).

If we are doing readahead, we want completion callbacks raised as soon
as possible on IO completions, no matter how many other IOs have been
merged with the current one.  More importantly though, when we are
merging multiple page or buffer_head IOs in a request, we want to know
exactly which buffer/page contents are valid and which are not once
the IO completes.

The current request struct's buffer_head list provides that quite
naturally, but is a hugely heavyweight way of performing large IOs.
What I'm really after is a way of sending IOs to make_request in such
a way that if the caller provides an array of buffer_heads, it gets
back completion information on each one, but if the IO is requested in
large chunks (eg. XFS's pagebufs or large kiobufs from raw IO), then
the request code can deal with it in those large chunks.

What worries me is things like the soft raid1/5 code: pretending that
we can skimp on the return information about which blocks were
transferred successfully and which were not sounds like a really bad
idea when you've got a driver which relies on that completion
information in order to do intelligent error recovery.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
