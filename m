Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRAIPBc>; Tue, 9 Jan 2001 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbRAIPBL>; Tue, 9 Jan 2001 10:01:11 -0500
Received: from chiara.elte.hu ([157.181.150.200]:13580 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129562AbRAIPA5>;
	Tue, 9 Jan 2001 10:00:57 -0500
Date: Tue, 9 Jan 2001 16:00:34 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christoph Hellwig <hch@caldera.de>, "David S. Miller" <davem@redhat.com>,
        <riel@conectiva.com.br>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109142542.G4284@redhat.com>
Message-ID: <Pine.LNX.4.30.0101091547520.4491-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:

> > please study the networking portions of the zerocopy patch and you'll see
> > why this is not desirable. An alloc_kiovec()/free_kiovec() is exactly the
> > thing we cannot afford in a sendfile() operation. sendfile() is
> > lightweight, the setup times of kiovecs are not.
> >
> Right.  However, kiobufs can be kept around for as long as you want
> and can be reused easily, and even if allocating and freeing them is
> more work than you want, populating an existing kiobuf is _very_
> cheap.

we do have SLAB [which essentially caches structures, on a per-CPU basis]
which i did take into account, but still, initializing a 600+ byte kiovec
is probably more work than the rest of sending a packet! I mean i'd love
to eliminate the 200+ bytes skb initialization as well, it shows up.

> > another, more theoretical issue is that i think the kernel should not be
> > littered with multi-page interfaces, we should keep the one "struct page *
> > at a time" interfaces.
>
> Bad bad bad.  We already have SCSI devices optimised for bandwidth
> which don't approach decent performance until you are passing them 1MB
> IOs, [...]

The fact that we're using single-page interfaces doesnt preclude us from
having nicely clustered requests, this is what IO-plugging is about!

> and even in networking the 1.5K packet limit kills us in some cases
> and we need an interface capable of generating jumbograms.

which cases?

> Perhaps tcp can merge internal 4K requests, [...]

yes, because depending on the application to send properly sized requests
is a futile act IMO. So we do have intelligent buffering and clustering in
basically every kernel subsystem - and we'll continue to have it because
we have no choice - most of Linux's user-visible IO APIs have byte
granularity (which is good btw.). Adding a multi-page interface will IMO
mostly just complicate the design and the implementation. Do you have
empirical (or theoretical) proof which shows that single-page interfaces
cannot perform well?

> but if you're doing udp jumbograms (or STP or VIA), you do need an
> interface which can give the networking stack more than one page at
> once.

nothing prevents the introduction of specialized interfaces - if they feel
like they can get enough traction. I was talking about the normal Linux IO
APIs, read()/write()/sendfile(), which are byte granularity and invoke an
almost mandatory buffering/clustering mechanizm in every kernel subsystem
they deal with.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
