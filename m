Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbQLVBcM>; Thu, 21 Dec 2000 20:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131521AbQLVBcC>; Thu, 21 Dec 2000 20:32:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131262AbQLVBbq>; Thu, 21 Dec 2000 20:31:46 -0500
Date: Thu, 21 Dec 2000 17:01:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Niehusmann <jan@gondor.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
In-Reply-To: <20001222014810.A1419@gondor.com>
Message-ID: <Pine.LNX.4.10.10012211659390.15507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Dec 2000, Jan Niehusmann wrote:
> 
> The test I did initially was the following:
> 
> if(!atomic_read(&bh->b_count) &&
> 	(destroy_dirty_buffers || !buffer_dirty(bh))
> 	&& ! (bh->b_page && bh->b_page->mapping)
> 	)
> 
> That is, I was explicitely checking for a mapped page. It worked well, too.
> Is this more reasonable?

I'd suggest just doing this instead (warning: cut-and-paste in xterm, so
white-space damage):

	--- linux/fs/buffer.c.old     Wed Dec 20 17:50:56 2000
	+++ linux/fs/buffer.c   Thu Dec 21 16:42:11 2000
	@@ -639,8 +639,13 @@
	                        continue;
	                for (i = nr_buffers_type[nlist]; i > 0 ; bh = bh_next, i--) {
	                        bh_next = bh->b_next_free;
	+
	+                       /* Another device? */
	                        if (bh->b_dev != dev)
	                                continue;
	+                       /* Part of a mapping? */
	+                       if (bh->b_page->mapping)
	+                               continue;
	                        if (buffer_locked(bh)) {
	                                atomic_inc(&bh->b_count);
	                                spin_unlock(&lru_list_lock);

which just ignores mapped buffers entirely (and doesn't test for
bh->b_page being non-NULL, because that shouldn't be allowed anyway).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
