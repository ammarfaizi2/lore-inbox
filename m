Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRDJTTq>; Tue, 10 Apr 2001 15:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbRDJTT1>; Tue, 10 Apr 2001 15:19:27 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:6649 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131873AbRDJTTV>; Tue, 10 Apr 2001 15:19:21 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104101918.f3AJIWXI031567@webber.adilger.int>
Subject: Re: Ext2 Directory Index - File Structure
In-Reply-To: <20010410165316Z92272-3053+23@humbolt.nl.linux.org>
 "from Daniel Phillips at Apr 10, 2001 06:53:15 pm"
To: Daniel Phillips <phillips@nl.linux.org>
Date: Tue, 10 Apr 2001 13:18:32 -0600 (MDT)
CC: adilger@turbolinux.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> > Are you going to go to a COMPAT flag before final release?  This is
> > pretty much needed for e2fsck to be able to detect/correct indexes.
> 
> I will if I know what the exact semantics are.  I have only an
> approximate idea of how this works and I'd appreciate a more precise
> definition.

OK, on ext2 the {,RO_,IN_}COMPAT flags work as follows for the kernel:

COMPAT:    Means that the on-disk format is 100% compatible with older on-disk
           formats, so a kernel which didn't know anything about this feature
	   could read/write the filesystem without corrupting the filesystem.
	   This is essentially just a flag which says "this filesystem has a
	   (hidden) feature" for e2fsck (more on e2fsck later).  The ext3
	   HAS_JOURNAL is a COMPAT feature, because the journal is simply a
	   regular file with data blocks in it, nothing special.  DIR_PREALLOC
	   is a COMPAT feature, since all it does is pre-allocate empty
	   directory blocks for directories growing over 1 block.
RO_COMPAT: Means the on-disk format is 100% compatible with older on-disk
           formats for reading (i.e. the feature does not change the visible
	   on-disk format).  However, an old kernel writing to such a
	   filesystem would/could corrupt the filesystem, so this is
	   prevented(*).  SPARSE_SUPER is such a feature, because sparse
	   groups allow data blocks where superblock/GDT backups used to
	   live, and the old ext2_free_blocks() would refuse to free these
	   blocks, leading to inconsistent bitmaps.  Old ext2_free_blocks()
	   would also get an error if a series of blocks crossed a group
	   boundary.
INCOMPAT:  Means the on-disk format has changed in some way that makes it
           unreadable by older kernels.  FILETYPE is this because older
	   kernels would think the directory name_len was > 256, so that
	   would be bad.  COMPRESSION is obvious - you would just get
	   garbage back from read().  The ext3 RECOVER flag is needed to
	   prevent ext2 from mounting the filesystem without replaying the
	   journal.  In most cases, an unrecovered ext3 filesystem is in
	   no worse a state than an unchecked ext2 filesystem (so at one
	   time I wanted an RO_COMPAT_RECOVER flag to at least allow you
	   to mount an ext3 filesystem as ext2 for e3fsck), but a lot
	   more inconsistencies can accumulate in the journal than was
	   previously possible so that was shot down.

Now for e2fsck, slightly different semantics are needed.  Basically, if
a filesystem has ANY unsupported feature (COMPAT, RO_COMPAT, INCOMPAT),
it will refuse to run on the filesystem, because it doesn't know how to
deal with the feature.  For example, ext3 COMPAT_HAS_JOURNAL is not supported
by older e2fsck, because it is possible for ext3 to use a reserved inode
(number 8) to hold the journal, so this would fail.  It also didn't know
what was a valid or invalid ext3 journal, so allowing an old e2fsck to pass
on an ext3 filesystem would be a false sense of security.

Because (with the change to dx_root_info), an indexed filesystem is 100%
safe to write into even for kernels that know nothing about the directory
indexes, it could be a COMPAT flag in the superblock.  This would force
users to have an updated e2fsck to verify that the directory indexes
are valid.  Otherwise, the indexes could (somehow) become corrupt and an
old e2fsck would not detect this because it would just think the index
blocks were empty directory blocks.

(*) kernels before 2.4.0 didn't check RO_COMPAT on remount, so root could
    be mounted RO with an RO_COMPAT feature, and then be remounted RW.  I
    submitted a patch for this which made it into 2.4.0, but it is still
    not in 2.2.19.  We also didn't check *COMPAT flags for rev 0 ext2
    filesystems (i.e. those created by default with mke2fs 1.15 or earlier,
    and still may be around), so COMPAT flags were totally ignored in this
    case.  My patch also fixed that for 2.4.0.  Alan has said he will put
    it into 2.2.20-pre1.
    
> > For that matter, I'm not even sure if ext2 supports directory files larger
> > than 2GB?  Anyone?  I'm not 100% sure, but it may be that e2fsck considers
> > directories >2GB as invalid.

Actually, as I think about this more, it is currently invalid for
directories to become > 2GB.  The i_size_high field in the inode is
actually the i_dir_acl pointer, so this is only "available" for regular
files and not directories.  Given that the ext2 EA/ACL code does not use
this field, we may allow this in the future, but for now we are limited
to 2GB directories.  Should be enough for now.

> > Have you been testing this with different kinds of input for filenames,
> > or only synthetic input data?
> 
> Because I'm not relying on any particular properties of coherence of
> names, i.e., my hash function is as random as I can make it, I think the
> sequential names are a pretty good test, except that they are all of
> similar length.

You could try "bonnie++ -s 0 -n 1000 -d /mnt/index_filesystem"

to create 1M (zero length) files in a single directory.  The files have
semi-random names and different lengths.  Basically a fixed-length number
with random length characters added to the end.  Since bonnie++ is also
a standard filesystem performance test, it will at least give some
useful numbers to compare with.

> > The fallback to a linear search is pretty much a requirement anyways, isn't
> > it?
> 
> Yes, in the sense that the new code also has to be able to handle
> nonindexed directories, which it does now.  As far as falling back to a
> linear search after somebody has done something boneheaded - I think
> it's better to fail and kprint a suggestion to run fsck, which can
> easily fix the problem instead of allowing it to go unnoticed and
> perhaps adversely affect system performance.  The problem here is that
> most users do not check their log files unless something doesn't work.
> In this case, failing instead of pressing on constitutes helping, not
> hurting.

I would have to disagree.  In the case of unsupported/corrupt/bad index
data, there _is_ a meaningful fallback, which is linear directory search.
Calling ext2_error() will mark the filesystem in error (for the next
e2fsck to clean up), and the sysadmin has the option of mounting with
"errors=remount-ro" or "errors=panic" if this is desirable.  It should be
up to the sysadmin to decide they want their box to crash or not, if there
is a reasonable solution.

We should definitely also clear the index flag on that directory, so we
don't keep getting the same error.  The rest of the ext2 code will deal
with the case if the actual directory data is corrupt.

Also, I'm sure that if the system has a large directory (thousands of
files), they will notice that it has become very slow.  If they don't
notice (and e2fsck cleans it up after reboot), then that is just as well.

> > What happens with an existing directory larger than a single block
> > when you are mounting "-o index"?  You can't index it after-the-fact, so
> > you need to linear search.
> 
> This works now.

So then bailing out of index mode (on error) to go into linear search
mode is as easy as clearing the directory index flag and reading the
directory from the start.

> Another possibility is that we're seeing real disk corruption because of
> faultly hardware or a kernel bug.  In that case, we really don't want to
> continue, we want to deal with it.

We should leave it up to the mount options and sysadmin whether they would
like to run in degraded mode rather than just fail.  If the directory data
itself is also bad, the code will already deal with this.

> > If e2fsck gets into the picture with a COMPAT flag, I would think it
> > will build an index for any directory larger than 1 block (to free the
> > kernel from having to do this on existing filesystems).
> 
> That makes sense to me.  There probably should be some way to suppress
> the automatic index addition, for example, when a user has a partition
> that's 100% full.

Yes, I was basically thinking that index creation would be done after the
rest of the filesystem had already been checked and was in a valid state.
This is really the only safe time to do it.  I suppose the index checking
itself could be done at that time as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
