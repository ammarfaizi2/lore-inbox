Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbRBEVLu>; Mon, 5 Feb 2001 16:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRBEVLk>; Mon, 5 Feb 2001 16:11:40 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:48617 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129146AbRBEVLb>; Mon, 5 Feb 2001 16:11:31 -0500
Date: Mon, 5 Feb 2001 13:08:17 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010205205429.V1167@redhat.com>
Message-ID: <Pine.LNX.4.31.0102051304090.3916-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so you have two concepts in one here

1. SG items that can be more then a single page

2. a container for #1 that includes details for completion callbacks, etc

it looks like Linus is objecting to having both in the same structure and
then using that structure as your generic low-level bucket.

define these as two seperate structures, the #1 structure may now be
lightweight enough to be used for networking and other functions, and when
you go to use it with disk IO you then wrap it in the #2 structure. this
still lets you have the completion callbacks at as low a level as you
want, you just have to explicitly add this layer when it makes sense.

David Lang



On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:

> Date: Mon, 5 Feb 2001 20:54:29 +0000
> From: Stephen C. Tweedie <sct@redhat.com>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen C. Tweedie <sct@redhat.com>,
>      Manfred Spraul <manfred@colorfullife.com>,
>      Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
>      linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
> Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
>
> Hi,
>
> On Mon, Feb 05, 2001 at 11:28:17AM -0800, Linus Torvalds wrote:
>
> > The _vectors_ are needed at the very lowest levels: the levels that do not
> > necessarily have to worry at all about completion notification etc. You
> > want the arbitrary scatter-gather vectors passed down to the stuff that
> > sets up the SG arrays etc, the stuff that doesn't care AT ALL about the
> > high-level semantics.
>
> OK, this is exactly where we have a problem: I can see too many cases
> where we *do* need to know about completion stuff at a fine
> granularity when it comes to disk IO (unlike network IO, where we can
> usually rely on a caller doing retransmit at some point in the stack).
>
> If we are doing readahead, we want completion callbacks raised as soon
> as possible on IO completions, no matter how many other IOs have been
> merged with the current one.  More importantly though, when we are
> merging multiple page or buffer_head IOs in a request, we want to know
> exactly which buffer/page contents are valid and which are not once
> the IO completes.
>
> The current request struct's buffer_head list provides that quite
> naturally, but is a hugely heavyweight way of performing large IOs.
> What I'm really after is a way of sending IOs to make_request in such
> a way that if the caller provides an array of buffer_heads, it gets
> back completion information on each one, but if the IO is requested in
> large chunks (eg. XFS's pagebufs or large kiobufs from raw IO), then
> the request code can deal with it in those large chunks.
>
> What worries me is things like the soft raid1/5 code: pretending that
> we can skimp on the return information about which blocks were
> transferred successfully and which were not sounds like a really bad
> idea when you've got a driver which relies on that completion
> information in order to do intelligent error recovery.
>
> Cheers,
>  Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
