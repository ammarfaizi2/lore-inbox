Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbREOBfj>; Mon, 14 May 2001 21:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbREOBf2>; Mon, 14 May 2001 21:35:28 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:13573 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262597AbREOBfM>; Mon, 14 May 2001 21:35:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Getting FS access events
Date: Tue, 15 May 2001 02:42:16 +0200
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200105140515.f4E5FwP10245@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.31.0105141301120.22874-100000@penguin.transmeta.com> <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <01051502421603.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 01:19, Richard Gooch wrote:
> Linus Torvalds writes:
> > On Sun, 13 May 2001, Richard Gooch wrote:
> > > So, why can't the page cache check if a block is in the buffer
> > > cache?
> >
> > Because it would make the damn thing slower.
> >
> > The whole point of the page cache is to be FAST FAST FAST. The
> > reason we _have_ a page cache is that the buffer cache is slow and
> > inefficient, and it will always remain so.
>
> Is there some fundamental reason why a buffer cache can't ever be
> fast?

Just looking at getblk, it takes one more lock than read_cache_page 
(these are noops in UP) and otherwise has very nearly the same sequence 
of operations.  This can't be the slowness he's talking about.

I know of three ways the buffer cache earned its reputation for 
slowness:  1) There used to be a copy from the buffer cache to page 
cache on every write, to keep the two in sync 2) Having the same data 
in both the buffer and page cache created extra memory pressure 3) To 
get at file data through the buffer cache you have to traverse all the 
index blocks every time, whereas with the logically-indexed page cache 
you go straight to the page data, if it's there, and in theory[1], only 
up as many levels of index as you have to.

Once you have looked into the page cache and know the page isn't there 
you know you are going to have to read it.  At this point, the overhead 
of hashing into, say, the buffer cache to see if the block is there is 
trivial.  Just one saved read by doing that will be worth hundreds of 
hash lookups.  But why use the buffer cache?  The page cache will work 
perfectly well for this.

There's a big saving in using a block cache for readahead instead of 
file-oriented readahead: if we guess wrong and don't actually need the 
readahead blocks then we paid less to get them - we didn't call into 
the filesystem to map each one.  Additionally, a block cache can do 
things that file readahead can't, as you showed in your example:

> - inode at block N
> - indirect block at N+k+j
> - data block at N+k

Another example is where you have blocks from two different files mixed 
together, and you read both of those files.

Note that your scsi disk controller is keeping a cache for you over on 
its side of the bus.  This erodes the benefit of the block cache 
somewhat, but the same argument applies to file readahead.  For all 
people who don't have scsi the block cache would be a big win.

[1] This remains theoretical until we get the indirect blocks into the 
page cache.

--
Daniel

