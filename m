Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbREPDe4>; Tue, 15 May 2001 23:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbREPDeq>; Tue, 15 May 2001 23:34:46 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:16905 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261782AbREPDeg>; Tue, 15 May 2001 23:34:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Wed, 16 May 2001 05:11:50 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105141833.f4EIXrQs001765@webber.adilger.int> <01051423505900.24410@starship>
In-Reply-To: <01051423505900.24410@starship>
MIME-Version: 1.0
Message-Id: <01051605115004.00406@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I couldn't  think of any good flames that haven't already been 
posted so I thought I'd be boring and post some code. ;-)

On Monday 14 May 2001 23:50, Daniel Phillips wrote:
> On Monday 14 May 2001 20:33, Andreas Dilger wrote:
> > Daniel, you write:
> > > Now, if the check routine tells us how much good data it found we
> > > could use that to set a limit for the dirent scan, thus keeping
> > > the same robustness as the old code but without having all the
> > > checks in the inner loop.  Or.  We could have separate loops for
> > > good blocks and bad blocks, it's just a very small amount of
> > > code.
> >
> > Yes, I was thinking about both of those as well.  I think the
> > latter would be easiest, because we only need to keep a single
> > error bit per buffer.
>
> Today's patch has the first part of that fix:
>
>     http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-6

And today's has the second part of that mechanism.  This is the 
strategy:

  - When a directory block is first called for via ext2_bread,
     !create, and is !uptodate, ext2_check_dirents is called to
     go through and sniff anally for anything that might not
     be right.  This check only happens once per block's
     cache lifetime.

  - If check_dirents returns failure, ext2_bread sets the
     PG_error bit in the buffer's page flags.

  - Just before we do the lowlevel scan of a directory leaf we
     check the page error bit, and if it's set call check_dirents, this 
     time asking it to tell us how much of the block is good.  That 
     value is used to set the limit for the lowlevel scan.

This recovers the old behaviour where the user continues to see
all the directory entries up to the first bad one.  Is it really 
important to do this?  Now at least we can decide whether that's the 
behaviour we want instead of worrying about how it can be implemented 
efficiently.

This high level of paranoia costs practically nothing; there are no 
extra checks to slow down the inner loop.  Thanks to Al Viro for the 
inspiration.

I only implemented this check in one place,  line  807 in 
ext2_find_entry on the nonindexed path.  If the approach looks ok  I'll 
go and add it in the other places.

Extending the idea to do an equally paranoid check on the directory 
index structure will add a little messiness because check_dirents can't 
tell that a given block is actually an index block, it has to be told.  
I'll just let this sit and age a little before I uglify the code in 
that way.

On another front,  I've changed to a new COMPAT flag so that Andreas 
Gruenbacher's ACL users can stick with the flag Andreas is already 
using.  I haven't heard a definitive ruling from Ted on this yet, but I 
gather this is the one I'm now supposed to use:

  #define EXT2_FEATURE_COMPAT_DIR_INDEX          0x0020

The current patch uses this, pending Ted's approval.  I'll repeat my 
warning that any partition with an indexed directory will need to be 
mke2fsed, until the patch gets to official alpha.

The patch is at:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-7

This is hardly tested at all, it's for comment.

--
Daniel
