Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbRELVna>; Sat, 12 May 2001 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbRELVnK>; Sat, 12 May 2001 17:43:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:44283 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261321AbRELVnH>; Sat, 12 May 2001 17:43:07 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105122141.f4CLfH7G001009@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <01051122200102.01990@starship> "from Daniel Phillips at May 11,
 2001 10:20:01 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Sat, 12 May 2001 15:41:16 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> Oh yes, I'm well aware it, that's what I mean by the "bullet proofing" 
> item on my to-do list.  I don't quite agree with the idea of embedding 
> the checking of directory entry format inside the ext2_get_page 
> routine, it should be moved outside ext2_get_page, on basic principal.
> Never mind that this routine is only used to get pages of directory 
> files, it's still not nice.  Anyway, I think the thing to do is graft a 
> similar one-time check onto ext2_bread.  We can't use Al's PG_checked 
> mechanism because we might have read only one buffer out of several on 
> the page.

We could use the "buffer_uptodate" flag on the buffer to signal that
the block has been checked.  AFAIK, a new buffer will not be uptodate,
and once it is it will not be read from disk again...  However, if a
user-space process read the buffer would also mark it uptodate without
doing the check...  Maybe we should use a new BH_ pointer... Just need
to factor out the ext2_check_page() code so that it works on a generic
memory pointer and end pointer.

> > It turns out that in adding the checks for rec_len, I fixed my
> > original bug, but added another...  Please disregard my previous
> > patch.
> 
> In any event, I couldn't apply it due to patch giving a 'malformed' 
> error - did you edit it after diffing?  I'll wait for a revised patch - 
> there's quite a lot of stuff in there including formatting changes, 
> ext2 warnings, etc.

Yes, I think I had mentioned this in the patch, maybe not.  I removed
all of the INDEX flag changes I had made from the resulting diff, so
I probably screwed up somewhere...


...(later)... I had a look at pulling out the ext2_check_page() code
so that it can be used for both ext2_get_page() and ext2_bread(), but
one thing concerns me - if we do checking on the whole page/buffer at
once, then any error in the page/buffer will discard all of the dir
entries in that page.  In the old code, we would at least return all
of the entries up to the bad dir entry.  Comments on this?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
