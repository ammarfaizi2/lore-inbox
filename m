Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291660AbSBNOAM>; Thu, 14 Feb 2002 09:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291666AbSBNN75>; Thu, 14 Feb 2002 08:59:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:51466 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291660AbSBNN7t>; Thu, 14 Feb 2002 08:59:49 -0500
Date: Thu, 14 Feb 2002 14:01:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Gerd Knorr <kraxel@bytesex.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <20020214141028.M7940@athlon.random>
Message-ID: <Pine.LNX.4.21.0202141335430.1033-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Andrea Arcangeli wrote:
> On Thu, Feb 14, 2002 at 12:10:37PM +0100, Gerd Knorr wrote:
> > 
> > I've recently changed the code to make it *not* call unmap_kiobuf/vfree
> > from irq context.  Instead bttv 0.8.x doesn't allow you to close the
> > device with DMA xfers in flight.  If you try this the release() fops
> > handler will block until the transfer is done, then unmap_kiobuf from
> > process context, then return.
> 
> perfect, that's the right fix for 2.4 (waiting DMA to complete at
> ->release looks also much saner). unmap_kiobuf wasn't supposed to be run
> from irq handlers. Everything dealing with userspace mappings cannot run
> from irq handlers, tlb flushes, VM, swapping etc...  everything must run
> from normal kernel context. If you obey this rule, my previous email to
> this thread will still apply. I wasn't aware of bttv running
> unmap_kiobuf from irq.

It's good that Gerd has made his change, but we don't know who else
might have been doing similar.  unmap_kiobuf does not involve unmapping
virtual address space: it used to be safe run from irq handlers, now not.

We don't have to make a change for 2.4.18, but we really should add some
kind of safety check there in 2.4.soon: either of the "it's a BUG()"
kind I first suggested (which may embarrass us by firing too often),
or of the "we can handle that" kind which I last suggested.

I don't disagree with Andrew's and your count-LRU approach,
but it does have slight drawbacks, as you noted.

> As said this should be a matter only for 2.5, now that Gerd recalls
> unmap_kiobuf from normal kernel context.

That's just a hope: you may be right, we simply don't know.

Hugh

