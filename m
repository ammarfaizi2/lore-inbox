Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137125AbREKNFq>; Fri, 11 May 2001 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137129AbREKNFg>; Fri, 11 May 2001 09:05:36 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:34829 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S137125AbREKNF3>; Fri, 11 May 2001 09:05:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Fri, 11 May 2001 15:02:03 +0200
X-Mailer: KMail [version 1.2]
Cc: phillips@bonn-fries.net,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
In-Reply-To: <200105110710.f4B7ArA9001543@webber.adilger.int>
In-Reply-To: <200105110710.f4B7ArA9001543@webber.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01051115020302.01913@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 May 2001 09:10, Andreas Dilger wrote:
> and previously wrote:
> > OK, here are the patches described above.
> >
> > Unfortunately, they haven't been tested.  I've given them several
> > eyeballings and they appear OK, but when I try to run the ext2
> > index code (even without "-o index" mount option) my system
> > deadlocks somwhere inside my ext2i module (tight loop, but SysRQ
> > still works).  I doubt it is due to these patches, but possibly
> > because I am also working on ext3 code in the same kernel.  I'm
> > just in the process of getting kdb installed into that kernel so I
> > can find out just where it is looping.
>
> I've tested again, now with kdb, and the system loops in
> ext2_find_entry() or ext2_add_link(), because there is a directory
> with a zero rec_len. While the actual cause of this problem is
> elsewhere, the fact that ext2_next_entry() will loop forever with a
> bad rec_len is a bug not in the old ext2 code.
>
> I have changed ext2_next_entry() to verify rec_len >
> EXT2_DIR_REC_LEN(0), and added a helper function ext2_next_empty()
> which is nearly the same, but it follows the de links until it finds
> one with enough space for a new entry (used in ext2_add_link()).  The
> former is useful for both Al and Daniel's code, while the latter may
> only be useful for Daniel's.

Al already answered this, but I'll amplify.  Al keeps a bit in the page 
state that tells you if a page in the page cache has been 'checked' 
since it was entered into the cache, allowing his code to carry out a 
careful, expensive check that is performed only once per cache page 
lifetime.  This will pick up bad data coming from disk, and we assume 
that newly created entries have been created correctly.  It's an 
interesting idea, but note his comment that 'this should die early'.  
I'm torn on that, it's hard to think of a cuter way of doing this.

We could use the same strategy in ext2_getblk, and in fact use the same
check_page code, providing the PG_checked bit is going to stay.

> However, the way that I currently fixed ext2_next_entry() is probably
> not very safe.  If it detects a bad rec_len, we should probably not
> touch that block anymore, but it currently just makes it look like
> the block is empty.  That may lead to deleting the rest of the
> directory entries in the block, although this is what e2fsck does
> anyways...  I at least need to set the error flag in the
> superblock...  Next patch.

We can set the PG_error flag on the page, then we get the complaint 
just once per mount (typically, unless you have cache pressure, then 
you probably want to get lots of complaints).

> I spotted another bug, namely that when allocating a new directory
> page it sets rec_len to blocksize, but does not zero the inode
> field...  This would imply that we would skip a bogus directory entry
> at the start of a new page.

The block is supposed to be zeroed when created.  I think I did that 
correctly in ext2_getblk.  This at least deserves a comment.

> As yet I haven't found the cause of the real bug, but at least now my
> kernel doesn't lock up on (relatively common) bogus data.

Yep, this counts as 'bullet proofing'.

--
Daniel

