Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSHJMjl>; Sat, 10 Aug 2002 08:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSHJMjk>; Sat, 10 Aug 2002 08:39:40 -0400
Received: from dsl-213-023-020-194.arcor-ip.net ([213.23.20.194]:40596 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316996AbSHJMjk>;
	Sat, 10 Aug 2002 08:39:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Sat, 10 Aug 2002 14:44:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dVbb-0001Y6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 August 2002 09:25, Linus Torvalds wrote:
> Example tricks: we can, if we want to, do a read() with no copy for a
> common case by adding a COW-bit to the page cache, and if you do aligned
> reads into a page that will fault on write, you can just map in the page
> cache page directly, mark it COW in the page cache (assuming the page
> count tells us we're the only user, of course), and mark it COW in the
> mapping.
> 
> The nice thing is, this actually works correctly even if the user re-uses
> the area for reading multiple times (because the read() will trap not
> because the page isn't mapped, but because it is mapped COW on something
> that will write to user space). The unmapped case is better, though, since
> we don't need to do TLB invalidates for that case (which makes this
> potentially worthwhile even on SMP).
> 
> I don't know if this is common, but it _would_ make read() have definite
> advantages over mmap() on files that are seldom written to or mmap'ed in a
> process (which is most of them, gut feel). In particular, once you fault 
> for _one_ page, you can just map in as many pages as the read() tried to 
> read in one go - so you can avoid any future work as well.
> 
> Imagine doing a
> 
> 	fstat(fd..)
> 	buf = aligned_malloc(st->st_size)
> 	read(fd, buf, st->st_size);
> 
> and having it magically populate the VM directly with the whole file
> mapping, with _one_ failed page fault. And the above is actually a fairly
> common thing. See how many people have tried to optimize using mmap vs
> read, and what they _all_ really wanted was this "populate the pages in
> one go" thing. 
> 
> Is it a good idea? I don't know. But it would seem to fall very cleanly
> out of the atomic kmap path - without affecting the fast path at _all_.

Sorry, this connection is too subtle for me.  I see why we want to do
this, and in fact I've been researching how to do it for the last few
weeks, but I don't see how it's related to the atomic kmap path.  Could
you please explain, in words of one syllable?

While I'm feeling disoriented, what exactly is the deadlock path for a
write from a mmaped, not uptodate page, to the same page?  And why does
__get_user need to touch the page in *two* places to instantiate it?
Also, how do we know the page won't get evicted before grab_cache_page
gets to it?

-- 
Daniel
