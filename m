Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131731AbQLVCZk>; Thu, 21 Dec 2000 21:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbQLVCZd>; Thu, 21 Dec 2000 21:25:33 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:9225 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S131731AbQLVCZ0>; Thu, 21 Dec 2000 21:25:26 -0500
Date: Fri, 22 Dec 2000 02:49:33 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
Message-ID: <20001222024933.A979@gondor.com>
In-Reply-To: <20001222014810.A1419@gondor.com> <Pine.LNX.4.10.10012211659390.15507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012211659390.15507-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 21, 2000 at 05:01:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 05:01:00PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 22 Dec 2000, Jan Niehusmann wrote:
> > 
> > The test I did initially was the following:
> > 
> > if(!atomic_read(&bh->b_count) &&
> > 	(destroy_dirty_buffers || !buffer_dirty(bh))
> > 	&& ! (bh->b_page && bh->b_page->mapping)
> > 	)
> > 
> > That is, I was explicitely checking for a mapped page. It worked well, too.
> > Is this more reasonable?
> 
> I'd suggest just doing this instead (warning: cut-and-paste in xterm, so
> white-space damage):

> which just ignores mapped buffers entirely (and doesn't test for
> bh->b_page being non-NULL, because that shouldn't be allowed anyway).

Yes, looks good to me, and passes some tests. Here is a patch that has not
been cut and pasted:

--- linux/fs/buffer.c.orig	Thu Dec 21 20:30:03 2000
+++ linux/fs/buffer.c	Fri Dec 22 02:11:29 2000
@@ -643,7 +643,12 @@
 			continue;
 		for (i = nr_buffers_type[nlist]; i > 0 ; bh = bh_next, i--) {
 			bh_next = bh->b_next_free;
+
+			/* Another device? */
 			if (bh->b_dev != dev)
+				continue;
+			/* Part of a mapping? */
+			if (bh->b_page->mapping)
 				continue;
 			if (buffer_locked(bh)) {
 				atomic_inc(&bh->b_count);


I have one additional question: invalidate_buffers normally gets called if
someone wants to make sure that, after the call, read accesses to a device
really go to the device and don't get served by a cache. Is there some
mechanismn that does the same thing to mapped pages? 

Jan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
