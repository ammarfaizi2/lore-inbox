Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQJ3VDM>; Mon, 30 Oct 2000 16:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQJ3VDC>; Mon, 30 Oct 2000 16:03:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129112AbQJ3VCn>; Mon, 30 Oct 2000 16:02:43 -0500
Date: Mon, 30 Oct 2000 13:02:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301505590.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010301256491.848-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Alexander Viro wrote:
> 
> Unfortunately, it doesn't fix the thing. ->sync_page() is called when we
> do not own the page lock and nfs_sync_page() uses page->mapping. Yes, we
> check it before calling the bloody thing, but we don't own the lock.

Good catch.

> Problem only for NFS, but I'm not sure what to do about it - the whole
> point of ->sync_page() seems to be (if I understood Trond's intentions
> right) in forcing the ->readpage() in progress.

How about just changing ->sync_page() semantics to own the page lock? That
sound slike the right thing anyway, no?

> Another place you've missed is in read_cache_page(). That one is easy - we've
> just locked the page and we should just repeat the whole thing if it's out
> of cache.

I didn't actually miss it, I just looked at the users and decided that it
looks like they should never have this issue. But I might have missed
something. As far as I can tell, "read_cache_page()" is only used for
meta-data like things that cannot be truncated.

But you're right, we should do it for consistency.

> One more is in filemap_swapout() - dunno, I just shifted the check to
> filemap_write_page().

I'd really like to do these in the thing that locks the page, and make the
rule be that the page locker needs to do the work. That's why I'd prefer
to let the test be in the _caller_ of filemap_write_page(), as that's the
point where we got the lock.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
