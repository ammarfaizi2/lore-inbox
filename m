Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291702AbSBNPRk>; Thu, 14 Feb 2002 10:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBNPRa>; Thu, 14 Feb 2002 10:17:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291702AbSBNPRQ>; Thu, 14 Feb 2002 10:17:16 -0500
Date: Thu, 14 Feb 2002 16:17:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gerd Knorr <kraxel@bytesex.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020214161728.O7940@athlon.random>
In-Reply-To: <20020214141028.M7940@athlon.random> <Pine.LNX.4.21.0202141335430.1033-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202141335430.1033-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 02:01:36PM +0000, Hugh Dickins wrote:
> On Thu, 14 Feb 2002, Andrea Arcangeli wrote:
> > On Thu, Feb 14, 2002 at 12:10:37PM +0100, Gerd Knorr wrote:
> > > 
> > > I've recently changed the code to make it *not* call unmap_kiobuf/vfree
> > > from irq context.  Instead bttv 0.8.x doesn't allow you to close the
> > > device with DMA xfers in flight.  If you try this the release() fops
> > > handler will block until the transfer is done, then unmap_kiobuf from
> > > process context, then return.
> > 
> > perfect, that's the right fix for 2.4 (waiting DMA to complete at
> > ->release looks also much saner). unmap_kiobuf wasn't supposed to be run
> > from irq handlers. Everything dealing with userspace mappings cannot run
> > from irq handlers, tlb flushes, VM, swapping etc...  everything must run
> > from normal kernel context. If you obey this rule, my previous email to
> > this thread will still apply. I wasn't aware of bttv running
> > unmap_kiobuf from irq.
> 
> It's good that Gerd has made his change, but we don't know who else
> might have been doing similar.  unmap_kiobuf does not involve unmapping
> virtual address space: it used to be safe run from irq handlers, now not.
> 
> We don't have to make a change for 2.4.18, but we really should add some
> kind of safety check there in 2.4.soon: either of the "it's a BUG()"
> kind I first suggested (which may embarrass us by firing too often),
> or of the "we can handle that" kind which I last suggested.

I think your BUG patch is good and it should go in.

Also note that such BUG() cannot trigger in mainline, and this is not an
hope, we know this for sure. It cannot happen even with bttv, because
the bttv-driver in mainline is using remap_page_range and it doesn't
allow read/write zerocopy. Such BUG can trigger only if you patch
mainline or if you use drivers not part of the maineline kernel, so as
usual it's a matter of the driver maintainers to provide a driver that
functions correctly on top of a certain mainline kernel. So I really
wouldn't worry to change this for 2.4 (as said, unless/until we're
forced to ship aio on top of 2.4).

Andrea
