Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272996AbRIIRgJ>; Sun, 9 Sep 2001 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272995AbRIIRf7>; Sun, 9 Sep 2001 13:35:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272996AbRIIRfp>; Sun, 9 Sep 2001 13:35:45 -0400
Date: Sun, 9 Sep 2001 10:31:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909001715.B27237@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109091019460.14365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andreas Dilger wrote:
>
> I think this fits in with your overall strategy as well - remove the buffer
> as a "cache" object, and only use it as an I/O object, right?  With this
> change, all of the cache functionality is in the page cache, and the buffers
> are only used as handles for I/O.

Absolutely. It would be wonderful to get rid of the buffer hashes, and
just replace them with walking the page hash instead (plus walking the
per-page bh list if we have non-page-sized buffers at non-zero offset). It
would also clearly make the page cache be the allocation unit and VM
entity.

The interesting thing is that once you remove the buffer hash entries,
there's not a lot inside "struct buffer_head" that isn't required for IO
anyway. Maybe we could do without bh->b_count, but it is at least
currently required for backwards compatibility with all the code that
thinks buffer heads are autonomous entities. But I actually suspect it
makes a lot of sense even for a stand-alone IO entity (I'm a firm believer
in reference counting as a way to avoid memory management trouble).

The LRU list and page list is needed for VM stuff, and could be cleanly
separated out (nothing to do with actual IO). Same goes for b_inode and
b_inode_buffers.

And b_data could be removed, as the information is implied in b_page and
the position there-in, but at the same time it's probably useful enough
for low-level IO to leave.

So I'd like to see this kind of cleanup, especially as it would apparently
both clean up a higher-level memory management issue _and_ make it much
easier to make the transition to a page-cache for the user accesses (which
is just _required_ for mmap and friends to work on physical devices).

Dan, how much of this do you have?

		Linus

