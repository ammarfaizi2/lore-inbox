Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262459AbRENUGW>; Mon, 14 May 2001 16:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbRENUGO>; Mon, 14 May 2001 16:06:14 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:4092 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262459AbRENUGG>; Mon, 14 May 2001 16:06:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105142004.f4EK4oRr002055@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <01051400150902.02742@starship> "from Daniel Phillips at May 14,
 2001 00:15:09 am"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 14 May 2001 14:04:49 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> On Thursday 10 May 2001 09:21, Andreas Dilger wrote:
> > I have changed the code to do the following:
> > - If the COMPAT_DIR_INDEX flag is set at mount/remount time, set the
> >   INDEX mount option (the same as "mount -o index").  This removes
> >   the need to specify the "-o index" option each time for filesystems
> >   which already have indexed directories.
> 
> This applied fine.  The semantics are a little loose though: after 
> mounting -o index, the first directory that overflows its first block 
> will turn on 'sticky indexing' for that partition.

Maybe we can have a "noindex" mount option for this?  In any case, if
you have a kernel which supports indexed directories, no harm is done,
and it will be ignored by other kernels.  There is always the option
of doing "tune2fs -O ^dir_index" to turn off that bit.

> I was originally thinking we should give the admin the ability to 
> create a nonindexed directory if desired, and that's how it used to be 
> before we changed the setting of INDEX_FL from directory creation time 
> to later, when the first directory block overflows.

But you still got INDEX_FL on each new (unindexed) directory, which
didn't help much, IMHO.  You can always do "chattr -h <dir>" (or whatever
the flag will be called) for a directory which you don't want indexed,
and it will immediately cease to be an indexed directory (and the index
block will revert to a normal directory block).

The 'i' flag is already used for the immutable (unchangeable) property.
We could use 'I' for indexed directories, but sometimes you will make a
mistake and use 'i' and in _theory_ you cannot remove the immutable flag
from a file while in multi-user mode for security reasons, so it would
be a hassle to fix this.  Note I haven't sent a patch to Ted for the
hash_indexed flag for chattr, lsattr yet.

The only point of contention is what e2fsck will do in the case where
COMPAT_DIR_INDEX is set on a filesystem.  Does it index all multi-block
directories (and set INDEX_FL for all of them)?  That would be easiest,
but it breaks the ability to selectively turn on/off directory indexing.

If e2fsck doesn't index all multi-block directories, then how do you add
indexing to an existing directory?  Something (kludgy) like:

mkdir newdir
mv olddir/* newdir
rmdir olddir

or the following (the "<one filesystem block>" is the tricky part...)(*)

find <filesystem> -xdev -type d -size +<one filesystem block> | xargs chattr +h
umount
e2fsck <device>

In general, I can't see a good reason why you would NOT want indexing on
some directories and not others once you have chosen to use indexing on
a filesystem.  If people don't want to use indexing, they just shouldn't
turn it on.

Since indexing is a "zero information" feature, it is easy to turn the
flag on and off and have e2fsck fix it (assuming you have a version of
e2fsck that understands indexing).  Even so, you can turn off indexing
for old e2fsck (by using a backup superblock as it will suggest) and
your filesystem is totally OK.  When you later get a new e2fsck you can
re-enable indexing for the filesystem with no loss of information.

(*) This brings up a problem with the "is_dx(dir)" simply checking if the
    EXT2_INDEX_FL is set.  We need to be sure that the code will bail out
    to linear directory searching properly if there is no index present,
    so it is possible to set this flag from user space for later e2fsck.

> I broke out 'ext2_add_compat_feature' as a trial balloon.  It's not
> really very satisfying - it's annoying to have a great piece of
> machinery that's used in exactly one place.  I'd prefer to have
> 'ext2_add_feature' that takes the kind of compatibility as a parameter. 
> We can do this by treating the three ext2_super_block compatibility
> fields as an array, what do you think?  Then we'd get to use it in two
> places :-]

Actually, this is used a lot more in ext3, because we set the HAS_JOURNAL
flag, and set/unset the RECOVERY flag in several places, so it will be
useful there.

> The max link count logic in your previous patch didn't seem to be
> complete so I didn't put it in.  I'll wait for more from you on that.  I
> followed the ReseirFS thread on this but I'm not sure exactly what form
> you want this to take in ext2.

I'm not sure what you mean by incomplete (although I did have the
aforementioned testing problems, so I never did try > 64k subdirectories
in a single directory).  Basically, it works the same as reiserfs, with
the extra caveat that we limit ourselves to EXT2_LINK_MAX for non-indexed
directories (for performance/sanity reasons).  We keep link counts for
indexed directories until we overflow 64k subdirectories (as opposed
to the arbitrary 32000 limit of EXT2_LINK_MAX), after which we use "1"
as the directory link count.  I also want to make sure the code degrades
to the original (slightly simpler) code if CONFIG_EXT2_INDEX is not set.

> The index create code has been moved out of the non-indexed code path
> and into the scope of the indexed path.  This is with a view to cutting
> ext2_add_entry into pieces at some point, for aesthetic reasons.

Yes, I was hoping for something like this.  That function is just getting
way too long...

I'll hopefully get a chance to look at the new code soon.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
