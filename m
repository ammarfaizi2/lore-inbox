Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262413AbRENTec>; Mon, 14 May 2001 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262417AbRENTeW>; Mon, 14 May 2001 15:34:22 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:47625 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262413AbRENTeK>; Mon, 14 May 2001 15:34:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Mon, 14 May 2001 21:29:34 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105141833.f4EIXrQs001765@webber.adilger.int>
In-Reply-To: <200105141833.f4EIXrQs001765@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051421293401.14979@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 20:33, Andreas Dilger wrote:
> Danie, you write:
> > This can go in ext2_bread, which already has dir-specific code in
> > it (readahead), and ext2_getblk remains generic, for what it's
> > worth.
>
> Note that the dir-specific code in ext2_bread() is not readahead, but
> rather directory block pre-allocation,

oops, yes that's what I meant.

> which would totally break
> indexed directory code (because the empty blocks would not be put
> into the index and would remain unreferenced thereafter).

The preallocation just does ext2_getblk, it doesn't increase i_size.  
The indexing code relies on i_size to append a new block, so this 
should work ok.

> For that matter, I'm not sure whether the dir-prealloc feature even
> works. The blocks are created/allocated, but are not initialized with
> the empty dirent data (i.e. set rec_len = blocksize), so it would
> just create a corrupt directory block.

I guess the lifetime of these blocks is the same as the lifetime of the 
directory's dcache entry, but I have to go spelunking to be sure.  If 
that's right then it's probably a good feature.  Having speculated 
about it, I should test this and see what happens.   

> > > ...(later)... I had a look at pulling out the ext2_check_page()
> > > code so that it can be used for both ext2_get_page() and
> > > ext2_bread(), but one thing concerns me - if we do checking on
> > > the whole page/buffer at once, then any error in the page/buffer
> > > will discard all of the dir entries in that page.  In the old
> > > code, we would at least return all of the entries up to the bad
> > > dir entry.  Comments on this?
> >
> > For a completely empty page that's the right thing to do, much
> > better than hanging as it does now.  We don't want to try to repair
> > damage on the fly do we?
>
> What do you mean by hanging?  You refer to new (indexed) code or old
> code?

I mean the new code, which just loops forever if it gets a zero 
rec_len.  It would be nice to get rid of this fragility without putting 
an extra check in the inner loop.  I think it's worth the effort, we 
are still cycling linearly through an average of roughly 128 directory 
entires on every directory operation.  I'll try fixing this by method 
related to what Al does, except instead of using the page flag, the 
place to do it is where the block gets mapped.

[...] No repair on the fly: Ack [...]

> > Now, if the check routine tells us how much good data it found we
> > could use that to set a limit for the dirent scan, thus keeping the
> > same robustness as the old code but without having all the checks
> > in the inner loop.  Or.  We could have separate loops for good
> > blocks and bad blocks, it's just a very small amount of code.
>
> Yes, I was thinking about both of those as well.  I think the latter
> would be easiest, because we only need to keep a single error bit per
> buffer.

Heh.  I was going to try the other one first.

By the way, all the code for the directory link limit enhancement was 
in fact in your last patch, and is included in the patch I uploaded 
yesterday.  I haven't tested it.  It would be nice to know how fast we 
can create 1,000,000 empty directories :-)

I noticed that Postfix creates an elaborate directory bucket structure 
that will be completely obsolete when the directory indexing becomes 
generally available.

--
Daniel
