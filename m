Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbRBGAmW>; Tue, 6 Feb 2001 19:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRBGAmM>; Tue, 6 Feb 2001 19:42:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64261 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130695AbRBGAl6>; Tue, 6 Feb 2001 19:41:58 -0500
Date: Tue, 6 Feb 2001 16:41:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207002107.L1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061628440.2045-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> 
> On Tue, Feb 06, 2001 at 08:57:13PM +0100, Ingo Molnar wrote:
> > 
> > [overhead of 512-byte bhs in the raw IO code is an artificial problem of
> > the raw IO code.]
> 
> No, it is a problem of the ll_rw_block interface: buffer_heads need to
> be aligned on disk at a multiple of their buffer size.

Ehh.. True of ll_rw_block() and submit_bh(), which are meant for the
traditional block device setup, where "b_blocknr" is the "virtual
blocknumber" and that indeed is tied in to the block size.

That's the whole _point_ of ll_rw_block() and friends - they show the
device at a different "virtual blocking" level than the low-level physical
accesses necessarily are. Which very much means that if you have a 4kB
"view", of the device, you get a stream of 4kB blocks. Not 4kB sized
blocks at 512-byte offsets (or whatebver the hardware blocking size is).

This way the interfaces are independent of the hardware blocksize. Which
is logical and what you'd expect. You need to go to a lower level to see
those kinds of blocking issues.

But it is _not_ true of "generic_make_request()" and the block IO layer in
general. It obviously _cannot_ be true, because the block I/O layer has
always had the notion of merging consecutive blocks together - regardless
of whether the end result is even a power of two or antyhing like that in
size. You can make an IO request for pretty much any size, as long as it's
a multiple of the hardare blocksize (normally 512 bytes, but there are
certainly devices out there with other blocksizes).

The fact is, if you have problems like the above, then you don't
understand the interfaces. And it sounds like you designed kiobuf support
around the wrong set of interfaces.

If you want to get at the _sector_ level, then you do

	lock_bh();
	bh->b_rdev = device;
	bh->b_rsector = sector-number (where linux defines "sector" to be 512 bytes)
	bh->b_size = size in bytes (must be a multiple of 512);
	bh->b_data = pointer;
	bh->b_end_io = callback;
	generic_make_request(rw, bh);

which doesn't look all that complicated to me. What's the problem?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
