Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbRENWmF>; Mon, 14 May 2001 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262540AbRENWlz>; Mon, 14 May 2001 18:41:55 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:7952 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262543AbRENWlk>; Mon, 14 May 2001 18:41:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Tue, 15 May 2001 00:18:33 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105142004.f4EK4oRr002055@webber.adilger.int>
In-Reply-To: <200105142004.f4EK4oRr002055@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051500183301.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 22:04, Andreas Dilger wrote:
> Daniel writes:
> > I was originally thinking we should give the admin the ability to
> > create a nonindexed directory if desired, and that's how it used to
> > be before we changed the setting of INDEX_FL from directory
> > creation time to later, when the first directory block overflows.
>
> But you still got INDEX_FL on each new (unindexed) directory, which
> didn't help much, IMHO.  You can always do "chattr -h <dir>" (or
> whatever the flag will be called) for a directory which you don't
> want indexed, and it will immediately cease to be an indexed
> directory (and the index block will revert to a normal directory
> block).

This is my point.  The can't do that nicely because they have to wait 
for the directory to grow past one block.  I don't really want to go 
back to the original way of doing it - the new code is simpler.  But... 
as long as this sits fine with you, it's done.

> The 'i' flag is already used for the immutable (unchangeable)
> property. We could use 'I' for indexed directories, but sometimes you
> will make a mistake and use 'i' and in _theory_ you cannot remove the
> immutable flag from a file while in multi-user mode for security
> reasons, so it would be a hassle to fix this.  Note I haven't sent a
> patch to Ted for the hash_indexed flag for chattr, lsattr yet.

We still have lots of time.  I see "x" isn't taken.

> The only point of contention is what e2fsck will do in the case where
> COMPAT_DIR_INDEX is set on a filesystem.  Does it index all
> multi-block directories (and set INDEX_FL for all of them)?  That
> would be easiest, but it breaks the ability to selectively turn
> on/off directory indexing.
>
> If e2fsck doesn't index all multi-block directories, then how do you
> add indexing to an existing directory?  Something (kludgy) like:
>
> mkdir newdir
> mv olddir/* newdir
> rmdir olddir
>
> or the following (the "<one filesystem block>" is the tricky
> part...)(*)
>
> find <filesystem> -xdev -type d -size +<one filesystem block> | xargs
> chattr +h umount
> e2fsck <device>
>
> In general, I can't see a good reason why you would NOT want indexing
> on some directories and not others once you have chosen to use
> indexing on a filesystem.  If people don't want to use indexing, they
> just shouldn't turn it on.

"Always on" is so much simpler, given that they asked for it.

> Since indexing is a "zero information" feature, it is easy to turn
> the flag on and off and have e2fsck fix it (assuming you have a
> version of e2fsck that understands indexing).  Even so, you can turn
> off indexing for old e2fsck (by using a backup superblock as it will
> suggest) and your filesystem is totally OK.  When you later get a new
> e2fsck you can re-enable indexing for the filesystem with no loss of
> information.
>
> (*) This brings up a problem with the "is_dx(dir)" simply checking if
> the EXT2_INDEX_FL is set.  We need to be sure that the code will bail
> out to linear directory searching properly if there is no index
> present, so it is possible to set this flag from user space for later
> e2fsck.

You mean in the case that EXT2_INDEX_FL is set, but there isn't 
actually an index there, or it's corrupt?  It's on my list of things to 
do.

> > The max link count logic in your previous patch didn't seem to be
> > complete so I didn't put it in.  I'll wait for more from you on
> > that.  I followed the ReseirFS thread on this but I'm not sure
> > exactly what form you want this to take in ext2.
>
> I'm not sure what you mean by incomplete

I didn't mean that, I found the rest of the code (in the other patch) 
shortly after I wrote it and forgot to edit the mail.

> (although I did have the
> aforementioned testing problems, so I never did try > 64k
> subdirectories in a single directory).  Basically, it works the same
> as reiserfs, with the extra caveat that we limit ourselves to
> EXT2_LINK_MAX for non-indexed directories (for performance/sanity
> reasons).  We keep link counts for indexed directories until we
> overflow 64k subdirectories (as opposed to the arbitrary 32000 limit
> of EXT2_LINK_MAX), after which we use "1" as the directory link
> count.  I also want to make sure the code degrades to the original
> (slightly simpler) code if CONFIG_EXT2_INDEX is not set.
>
> > The index create code has been moved out of the non-indexed code
> > path and into the scope of the indexed path.  This is with a view
> > to cutting ext2_add_entry into pieces at some point, for aesthetic
> > reasons.
>
> Yes, I was hoping for something like this.  That function is just
> getting way too long...
>
> I'll hopefully get a chance to look at the new code soon.

There's more new code today, you can skip yesterday's :-)

--
Daniel
