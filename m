Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbREMCfi>; Sat, 12 May 2001 22:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbREMCf2>; Sat, 12 May 2001 22:35:28 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:4871 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261366AbREMCfR>; Sat, 12 May 2001 22:35:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Sun, 13 May 2001 04:34:45 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105122141.f4CLfH7G001009@webber.adilger.int>
In-Reply-To: <200105122141.f4CLfH7G001009@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051304344501.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 May 2001 23:41, Andreas Dilger wrote:
> Daniel writes:
> > Oh yes, I'm well aware it, that's what I mean by the "bullet
> > proofing" item on my to-do list.  I don't quite agree with the idea
> > of embedding the checking of directory entry format inside the
> > ext2_get_page routine, it should be moved outside ext2_get_page, on
> > basic principal. Never mind that this routine is only used to get
> > pages of directory files, it's still not nice.  Anyway, I think the
> > thing to do is graft a similar one-time check onto ext2_bread.  We
> > can't use Al's PG_checked mechanism because we might have read only
> > one buffer out of several on the page.
>
> We could use the "buffer_uptodate" flag on the buffer to signal that
> the block has been checked.  AFAIK, a new buffer will not be
> uptodate, and once it is it will not be read from disk again... 
> However, if a user-space process read the buffer would also mark it
> uptodate without doing the check...  Maybe we should use a new BH_
> pointer... Just need to factor out the ext2_check_page() code so that
> it works on a generic memory pointer and end pointer.

Yes, exactly what I had in mind.  In other words, do the check when a 
!uptodate buffer is read.  This can go in ext2_bread, which already has 
dir-specific code in it (readahead), and ext2_getblk remains generic, 
for what it's worth.

> > > It turns out that in adding the checks for rec_len, I fixed my
> > > original bug, but added another...  Please disregard my previous
> > > patch.
> >
> > In any event, I couldn't apply it due to patch giving a 'malformed'
> > error - did you edit it after diffing?  I'll wait for a revised
> > patch - there's quite a lot of stuff in there including formatting
> > changes, ext2 warnings, etc.
>
> Yes, I think I had mentioned this in the patch, maybe not.  I removed
> all of the INDEX flag changes I had made from the resulting diff, so
> I probably screwed up somewhere...

I went through your patch and distilled out the stylistic changes you 
made.  I simplified the INDEX_FL handling along the lines you suggested 
and factored out a ext2_add_compat_feature routine among other 
incremental improvements.  I'll post the update tomorrow.

I did not attempt to address the check_ issue this time round.

> ...(later)... I had a look at pulling out the ext2_check_page() code
> so that it can be used for both ext2_get_page() and ext2_bread(), but
> one thing concerns me - if we do checking on the whole page/buffer at
> once, then any error in the page/buffer will discard all of the dir
> entries in that page.  In the old code, we would at least return all
> of the entries up to the bad dir entry.  Comments on this?

For a completely empty page that's the right thing to do, much better 
than hanging as it does now.  We don't want to try to repair damage on 
the fly do we?

Now, if the check routine tells us how much good data it found we could 
use that to set a limit for the dirent scan, thus keeping the same 
robustness as the old code but without having all the checks in the 
inner loop.  Or.  We could have separate loops for good blocks and bad 
blocks, it's just a very small amount of code.

--
Daniel
