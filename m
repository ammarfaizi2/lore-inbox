Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSHJHUZ>; Sat, 10 Aug 2002 03:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHJHUZ>; Sat, 10 Aug 2002 03:20:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59915 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316621AbSHJHUY>; Sat, 10 Aug 2002 03:20:24 -0400
Date: Sat, 10 Aug 2002 00:25:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D54AED6.708F247F@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Andrew Morton wrote:
> 
> What would be nice is a way of formalising the prefault, to pin
> the mm's pages across the copy_*_user() in some manner, perhaps?

Too easy to create a DoS-type attack with any trivial implementation.

However, I don't think pinning is worthwhile, since even if the page goes 
away, the prefaulting was just a performance optimization. The code should 
work fine without it. In fact, it would probably be good to _not_ prefault 
for a development kernel, and verify that the code works without it. That 
way we can sleep safe in the knowledge that there isn't some race through 
code that requires the prefaulting..

I agree that if you could guarantee pinning the out-of-line code would be 
a bit simpler, but since we have to handle the EFAULT case anyway, I doubt 
that it is _that_ much simpler.

Also, there are actually advantages to doing it the "hard" way. If we ever 
want to, we can actually play clever tricks that avoid doing the copy at 
all with the slow path. 

Example tricks: we can, if we want to, do a read() with no copy for a
common case by adding a COW-bit to the page cache, and if you do aligned
reads into a page that will fault on write, you can just map in the page
cache page directly, mark it COW in the page cache (assuming the page
count tells us we're the only user, of course), and mark it COW in the
mapping.

The nice thing is, this actually works correctly even if the user re-uses
the area for reading multiple times (because the read() will trap not
because the page isn't mapped, but because it is mapped COW on something
that will write to user space). The unmapped case is better, though, since
we don't need to do TLB invalidates for that case (which makes this
potentially worthwhile even on SMP).

I don't know if this is common, but it _would_ make read() have definite
advantages over mmap() on files that are seldom written to or mmap'ed in a
process (which is most of them, gut feel). In particular, once you fault 
for _one_ page, you can just map in as many pages as the read() tried to 
read in one go - so you can avoid any future work as well.

Imagine doing a

	fstat(fd..)
	buf = aligned_malloc(st->st_size)
	read(fd, buf, st->st_size);

and having it magically populate the VM directly with the whole file
mapping, with _one_ failed page fault. And the above is actually a fairly
common thing. See how many people have tried to optimize using mmap vs
read, and what they _all_ really wanted was this "populate the pages in
one go" thing. 

Is it a good idea? I don't know. But it would seem to fall very cleanly
out of the atomic kmap path - without affecting the fast path at _all_. It
would be a very specific and localized optimization, with no impact on the
rest of the system, since it's using the same fixup() logic that we have
to have anyway.

(Yeah, the COW bit on the page cache is special, and it would need page 
mapping and obviously file writing to do something like

	..
	if (page->flags & PAGE_COW) {
		page->flags &= ~PAGE_COW;
		if (page->count > 1) {
			remove-and-reinsert-new-page();
		}
	}
	..

by hand before mapping it writable or writing to it. And the read()  
optimization would _only_ work if nobody is using mmap() on the file at
the same time for those pages).

This would definitely be 2.7.x material, I'm just explaining why I like 
the flexibility of the approach (as opposed to a very static "memcpy-only- 
special-case" thing).

		Linus

