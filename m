Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129850AbRBGByR>; Tue, 6 Feb 2001 20:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRBGByI>; Tue, 6 Feb 2001 20:54:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:6596 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129850AbRBGBx4>;
	Tue, 6 Feb 2001 20:53:56 -0500
Date: Wed, 7 Feb 2001 01:49:28 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207014928.O1167@redhat.com>
In-Reply-To: <20010207003629.M1167@redhat.com> <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 04:50:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 04:50:19PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> > 
> > That gets us from 512-byte blocks to 4k, but no more (ll_rw_block
> > enforces a single blocksize on all requests but that relaxing that
> > requirement is no big deal).  Buffer_heads can't deal with data which
> > spans more than a page right now.
> 
> "struct buffer_head" can deal with pretty much any size: the only thing it
> cares about is bh->b_size.

Right now, anything larger than a page is physically non-contiguous,
and sorry if I didn't make that explicit, but I thought that was
obvious enough that I didn't need to.  We were talking about raw IO,
and as long as we're doing IO out of user anonymous data allocated
from individual pages, buffer_heads are limited to that page size in
this context.

> Have you ever spent even just 5 minutes actually _looking_ at the block
> device layer, before you decided that you think it needs to be completely
> re-done some other way? It appears that you never bothered to.

Yes.  We still have this fundamental property: if a user sends in a
128kB IO, we end up having to split it up into buffer_heads and doing
a separate submit_bh() on each single one.  Given our VM, PAGE_SIZE
(*not* PAGE_CACHE_SIZE) is the best granularity we can hope for in
this case.

THAT is the overhead that I'm talking about: having to split a large
IO into small chunks, each of which just ends up having to be merged
back again into a single struct request by the *make_request code.

A constructed IO request basically doesn't care about anything in the
buffer_head except for the data pointer and size, and the completion
status info and callback.  All of the physical IO description is in
the struct request by this point.  The chain of buffer_heads is
carrying around a huge amount of information which isn't used by the
IO, and if the caller is something like the raw IO driver which isn't
using the buffer cache, that extra buffer_head data is just overhead. 

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
