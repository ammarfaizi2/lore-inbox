Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281940AbRKZRgb>; Mon, 26 Nov 2001 12:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281937AbRKZRgW>; Mon, 26 Nov 2001 12:36:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281697AbRKZRgP>; Mon, 26 Nov 2001 12:36:15 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Scalable page cache
Date: Mon, 26 Nov 2001 17:29:51 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9ttu6f$9ve$1@penguin.transmeta.com>
In-Reply-To: <87elml4ssx.fsf@fadata.bg> <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
X-Trace: palladium.transmeta.com 1006796130 32182 127.0.0.1 (26 Nov 2001 17:35:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Nov 2001 17:35:30 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>,
Ingo Molnar  <mingo@elte.hu> wrote:
>
>it gets rid of the pagecache lock without introducing a tree.
>
>while reducing memory footprint is a goal we want to achieve, the
>pagecache hash is such a critical piece of data structure that we want
>O(1)-type search properties, not a tree. The pagetable hash takes up 0.2%
>of RAM currently. (but we could cut the size of the hash in half i think,
>it's a bit over-sized currently - it has as many entries.)

I actually considered a tree a long time ago, but I was thinking more
along the lines of the page table tree - with the optimization of being
able to perhaps map sub-trees _directly_ into the address space. 

it's a cool idea, especially if done right (ie try to share the
functions between the VM trees and the "page cache tree"), but I was too
lazy to try it out (it's a _lot_ of work to do right).  And I suspect
that it would optimize all the wrong cases, ie on x86 you could mmap
4MB-aligned areas at 4MB offsets with "zero cost", but in real life
that's not a very common situation.

Tree's _do_ have advantages over hashes, though, in having both better
cache locality and better locking locality. 

I don't think a binary tree (even if it is self-balancing) is the proper
format, though.  Binary trees have bad cache characteristics, and as
Ingo points out, with large files (and many performance-critical things
like databases have _huge_ files) you get bad behaviour on lookup with a
binary tree. 

A indexed tree (like the page tables) has much better characteristics,
and can be looked up in O(1), and might be worth looking into. The
locality of a indexed tree means that it's MUCH easier to efficiently
fill in (or get rid of) large contiguous chunks of page cache than it is
with hashes. This can be especially useful for doing swapping, where you
don't have to look up adjacent pages - they're right there, adjacent to
your entry.

Anybody interested?

		Linus
