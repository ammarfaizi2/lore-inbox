Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRAIPlf>; Tue, 9 Jan 2001 10:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131575AbRAIPlZ>; Tue, 9 Jan 2001 10:41:25 -0500
Received: from kanga.kvack.org ([216.129.200.3]:30218 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S131153AbRAIPlL>;
	Tue, 9 Jan 2001 10:41:11 -0500
Date: Tue, 9 Jan 2001 10:38:30 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: Ingo Molnar <mingo@elte.hu>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091547520.4491-100000@e2>
Message-ID: <Pine.LNX.3.96.1010109103229.5051A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:

> 
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> 
> > > please study the networking portions of the zerocopy patch and you'll see
> > > why this is not desirable. An alloc_kiovec()/free_kiovec() is exactly the
> > > thing we cannot afford in a sendfile() operation. sendfile() is
> > > lightweight, the setup times of kiovecs are not.
> > >
> > Right.  However, kiobufs can be kept around for as long as you want
> > and can be reused easily, and even if allocating and freeing them is
> > more work than you want, populating an existing kiobuf is _very_
> > cheap.
> 
> we do have SLAB [which essentially caches structures, on a per-CPU basis]
> which i did take into account, but still, initializing a 600+ byte kiovec
> is probably more work than the rest of sending a packet! I mean i'd love
> to eliminate the 200+ bytes skb initialization as well, it shows up.

Do the math again: for transmitting a single page in a kiobuf only 64
bytes needs to be initialized.  If map_array is moved to the end of the
structure, that's all contiguous data and is a single cacheline.

What you're completely ignoring is that sendpages is lacking a huge amount
of functionality that is *needed*.  I can't implement clean async io on
top of sendpages -- it'll require keeping 1 task around per outstanding
io, which is exactly the bottleneck we're trying to work around.

> The fact that we're using single-page interfaces doesnt preclude us from
> having nicely clustered requests, this is what IO-plugging is about!

It does waste a significant amount of CPU cycles trying to reassemble io
requests and is not deterministic.  Unplugging the io queue is a real pain
with async io.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
