Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRDNAwB>; Fri, 13 Apr 2001 20:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDNAvw>; Fri, 13 Apr 2001 20:51:52 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:1012 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132281AbRDNAvj>; Fri, 13 Apr 2001 20:51:39 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104140050.f3E0ohpb014702@webber.adilger.int>
Subject: Re: Ext2 Directory Index - File Structure
In-Reply-To: <20010413205832Z92227-31791+16@humbolt.nl.linux.org>
 "from Daniel Phillips at Apr 13, 2001 10:58:28 pm"
To: Daniel Phillips <phillips@nl.linux.org>
Date: Fri, 13 Apr 2001 18:50:42 -0600 (MDT)
CC: adilger@turbolinux.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, you write:
> OK, I get it.  Nice article - it would sure be nice to see this
> incorporated Documentation/filesystems/ext2.txt.  I just checked my copy
> of Understanding the Linux Kernel and while existence of the compat
> fields in the super block is noted, there is nothing at all said about
> them. 
> 
> So then, the obvious candidate would be:
> 
> 	#define EXT2_FEATURE_RO_COMPAT_DIR_INDEX        0x0004
> 
> which was formerly EXT2_FEATURE_RO_COMPAT_BTREE_DIR.

Actually not.  We should go with "EXT2_FEATURE_COMPAT_DIR_INDEX 0x0008"
because the on-disk layout is 100% compatible with older kernels, so
no reason to force read-only for those systems.  I'm guessing Ted had
put RO_COMPAT_BTREE_DIR in there in anticipation, but it was never used.

> Other than declaring it, I gather I have to set this flag in the
> superblock every time I set the EXT2_INDEX_FL in an inode.  Is that it?

Yes.  If you do like the LARGE_FILE code, it may be worthwhile to check
whether it is already set to avoid writing out the superblock.  However,
in most cases the superblock is already dirty after block allocation, so
it is no extra overhead in those cases.

> Yes, I will mask of 8 bits of the block index and this will be more than
> enough to support the planned coalesce function.  I can't think of any
> other use for these bits than coalescing - can you?

Not at the moment, but then again, I probably couldn't have forseen any
of the other requirements either.  If we don't need them for indexed
directories, we may as well save them for a future (unspecified) use.
Start using them from the high bits down, so that we allow the directory
size to grow (if needed) in the future.

> > So then bailing out of index mode (on error) to go into linear search
> > mode is as easy as clearing the directory index flag and reading the
> > directory from the start.
> 
> Are you sure we want to clear the index flag?  The user has probably
> just booted the wrong kernel.  And yes, we are talking about a
> strategically placed goto here, after a little cleanup.

OK, no need to clear the index flag under normal circumstances.  We
simply fall back to linear search on unknown hash code, etc.  But
with the hash version byte and dx_root size we should _know_ when we
have bogus data.  Whether we clear the index flag or not in this case
is up for debate.  I was thinking that it would force us into the
"safer" code path of linear search.  However, clearing the index flag
may lose some state (if we decide to allow the admin to set un-indexed
but larger than 1 block directories).  In that case, how do we make
e2fsck create indexes for old filesystems when the DIR_INDEX compat flag
is turned on in the superblock?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
