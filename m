Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbREMWXV>; Sun, 13 May 2001 18:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbREMWXL>; Sun, 13 May 2001 18:23:11 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:29704 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261933AbREMWW7>; Sun, 13 May 2001 18:22:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Mon, 14 May 2001 00:15:09 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105100721.f4A7LoN9021455@webber.adilger.int>
In-Reply-To: <200105100721.f4A7LoN9021455@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051400150902.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 May 2001 09:21, Andreas Dilger wrote:
> I previously wrote:
> > I was looking at the new patch, and I saw something that puzzles
> > me. Why do you set the EXT2_INDEX_FL on a new (empty) directory,
> > rather than only setting it when the dx_root index is created?
> >
> > Setting the flag earlier than that makes it mostly useless, since
> > it will be set on basically every directory.  Not setting it would
> > also make your is_dx() check simply a check for the EXT2_INDEX_FL
> > bit (no need to also check size).
> >
> > Also no need to set EXT2_COMPAT_DIR_INDEX until such a time that we
> > have a (real) directory with an index, to avoid gratuitous
> > incompatibility with e2fsck.

This is fixed in today's patch.

> I have changed the code to do the following:
> - If the COMPAT_DIR_INDEX flag is set at mount/remount time, set the
>   INDEX mount option (the same as "mount -o index").  This removes
>   the need to specify the "-o index" option each time for filesystems
>   which already have indexed directories.

This applied fine.  The semantics are a little loose though: after 
mounting -o index, the first directory that overflows its first block 
will turn on 'sticky indexing' for that partition.

I was originally thinking we should give the admin the ability to 
create a nonindexed directory if desired, and that's how it used to be 
before we changed the setting of INDEX_FL from directory creation time 
to later, when the first directory block overflows.

You are probably right on both counts, but it's something to think 
about.

> - New directories NEVER have the INDEX flag set on them.
> - If the INDEX mount option is set, then when directories grow past 1
>   block (and have the index added) they will get the directory INDEX
>   flag set and turn on the superblock COMPAT_DIR_INDEX flag (if off).

It works this way now.

> This means that you can have common code for indexed and non-indexed
> ext2 filesystems, and the admin either needs to explicitly set
> COMPAT_DIR_INDEX in the superblock or mount with "-o index" (and
> create a directory > 1 block).

Actually, I've had common code for indexed and non-indexed right from 
the first prototype, I hope there isn't any misunderstanding there.

> I have also added some tricks to ext2_inc_count() and
> ext2_dec_count() so that indexed directories are not subject to the
> EXT2_LINK_MAX.  I've done the same as reiserfs, and set i_nlink = 1
> if we overflow EXT2_LINK_MAX (which has been increased to 65500 for
> indexed directories). Apparently i_nlink = 1 is the right think to do
> w.r.t. find and other user tools.
>
> Patches need some light testing before being posted.

Today's Patch
-----------

The main change in today's patch is the simplified handling of the index
creation.  Besides that there are quite a few incremental improvements
and most, but not all of your recent patch set is in.

I broke out 'ext2_add_compat_feature' as a trial balloon.  It's not
really very satisfying - it's annoying to have a great piece of
machinery that's used in exactly one place.  I'd prefer to have
'ext2_add_feature' that takes the kind of compatibility as a parameter. 
We can do this by treating the three ext2_super_block compatibility
fields as an array, what do you think?  Then we'd get to use it in two
places :-]

I wrote ext2_append as a wrapper on ext2_bread, mainly to bury the
i_size handling.  Its function is to append a single block to a file.  
I pass back the block number of the appended block via a pointer, which 
is clumsy but the only other choice is to calculate the block number 
every time outside the function, which just leaves more things to get 
out of sync.

I found a real bug in the continued-hash handling - instead of advancing
to the next index block the same block would be reread.  Nobody hit this
because even with a million file directory the error condition would
exist for less than 1 in 250 million entries.  Still, correct is
correct.  Having to deal with such rare conditions is the price we have
to pay for the benefits of hashed keys.

The max link count logic in your previous patch didn't seem to be
complete so I didn't put it in.  I'll wait for more from you on that.  I
followed the ReseirFS thread on this but I'm not sure exactly what form
you want this to take in ext2.

I followed your recommendation and simplified the index creation and
INDEX_FL flag interpretation.  Now the index is created for any
directory that grows over a block, whereas before the condition was 'any
new directory created with indexing enabled that later grows over one
block'.

The index create code has been moved out of the non-indexed code path
and into the scope of the indexed path.  This is with a view to cutting
ext2_add_entry into pieces at some point, for aesthetic reasons.

The one place where I'm relying on a newly-created block to be contain
zeros got a comment.

I was unable to apply your patch all at once, and of course, I'd hacked
on the code some more in the meantime, but I went through by hand and
mined out the gold.  Please check, I'm sure I missed some.

I haven't done anything about the block checking code yet.

The patch is at:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-5

As before, this is applied on top of Al's patch, available at:

   ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz

To apply:

    cd source/tree
    zcat ext2-dir-patch-S4.gz | patch -p1
    cat dx.pcache-2.4.4-4 | patch -p0

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo

--
Daniel
