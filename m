Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBLKKb>; Mon, 12 Feb 2001 05:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBLKKV>; Mon, 12 Feb 2001 05:10:21 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:7696 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129305AbRBLKKH>;
	Mon, 12 Feb 2001 05:10:07 -0500
Date: Mon, 12 Feb 2001 11:07:38 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010212110738.B21533@pcep-jamie.cern.ch>
In-Reply-To: <20010207012710.N1167@redhat.com> <Pine.LNX.4.10.10102061729470.2193-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102061729470.2193-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 05:40:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Absolutely. This is exactly what I mean by saying that low-level drivers
> may not actually be able to handle new cases that they've never been asked
> to do before - they just never saw anything like a 64kB request before or
> something that crossed its own alignment.
> 
> But the _higher_ levels are there. And there's absolutely nothing in the
> design that is a real problem. But there's no question that you might need
> to fix up more than one or two low-level drivers.
> 
> (The only drivers I know better are the IDE ones, and as far as I can tell
> they'd have no trouble at all with any of this. Most other normal drivers
> are likely to be in this same situation. But because I've not had a reason
> to test, I certainly won't guarantee even that).

PCI has dma_mask, which distinguishes different device capabilities.
This nice interface handles 64-bit capable devices, 32-bit ones, ISA
limitations (the old 16MB limit) and some other strange devices.

This mask appears in block devices one way or another so that bounce
buffers are used for high addresses.

How about a mask for block devices which indicates the kinds of
alignment and lengths that the driver can handle?  For old drivers that
can't be thoroughly tested, we assume the worst.  Some devices have
hardware limitations.  Newer, tested drivers can relax the limits.

It's probably not difficult to say, "this 64k request can't be handled
so split it into 1k requests".  It integrates naturally with the
decision to use bounce buffers -- alignment restrictions cause copying
just as high addresses causes copying.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
