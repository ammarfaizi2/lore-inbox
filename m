Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291089AbSAaOf6>; Thu, 31 Jan 2002 09:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291091AbSAaOfs>; Thu, 31 Jan 2002 09:35:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56434 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291089AbSAaOff>; Thu, 31 Jan 2002 09:35:35 -0500
Date: Thu, 31 Jan 2002 15:36:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131153607.C1309@athlon.random>
In-Reply-To: <20020131033345.X1309@athlon.random> <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Jan 31, 2002 at 11:58:10AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:58:10AM -0200, Rik van Riel wrote:
> On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> 
> > So I wouldn't merge it, at least until some math is done for the memory
> > consumation with 500k inodes with only 1 page in them each, and on the
> > number of heights/levels that must be walked during the tree lookup,
> > during a access at offset 10G (or worst case in general [biggest
> > height]) of an inode with 10G just allocated in pagecache.
> 
> Ummm, I don't see how this worst case is any more realistic
> as the worst case for the hash table (where all pages live
> in very few hash buckets and we have really deep chains).

Mathematically the hashtable complexity is O(N). But probabilistically
with the tuning we do on the hashtable size, the collisions will be
nearly zero for most buckets for of most workloads. Despite the worst
case is with all the pagecache and swapcache queued in a single linked
list :).

So in short math is wrong about O(N) being bad, hashtable is infact the
only way we can get an effective O(1) by just paying RAM. We pay with
RAM and we get performance back to us.

but with the radix tree (please correct me if I'm wrong) the height will
increase eventually, no matter what (so it won't be an effective O(1)
like the hashtable provides in real life, not the worst case, the common
case). With the hashtable the height won't increase instead.

In short to get the same performance with the radix tree, you'd need to
waste an huge amount of ram per inode, the hashtable is instead global
so we pay only once for all the pages in the system. At least this is my
understanding, I'm not a radix tree guru though, so I may be missing
something.

> 
> People just don't go around caching a single page each for
> all of their 10 GB files and even if they _wanted to_ they
> couldn't because of the readahead code.
> 
> I suspect that for large files we'll always have around
> min_readahead logically contiguous pages cached, if not more.

readahead really doesn't matter at all. consider all the data just in
cache, assume you wrote it and you will never ever need to read it once
again because you've 64G of ram and only 20G of disk.

I/O on large files can and must run as fast as I/O on small files, at
the pagecache level. If the fs doesn't support extents or it's
inefficient with large files that's an enterly different problem, and
the underlying fs doesn't matter any longer once the data is in cache.
pagecache must not slowdown on big files.

Otherwise for an unix fs developer usage (the small files ala dbench)
the rbtree was much nicer data structure than the hash in first place
(and it eats less ram than the radix tree if only one page is queued
etc...).

Andrea
