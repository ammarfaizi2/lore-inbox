Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDMU7F>; Fri, 13 Apr 2001 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDMU64>; Fri, 13 Apr 2001 16:58:56 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:9340 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S131809AbRDMU6i>; Fri, 13 Apr 2001 16:58:38 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: adilger@turbolinux.com, phillips@nl.linux.org
Subject: Re: Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010413205832Z92227-31791+16@humbolt.nl.linux.org>
Date: Fri, 13 Apr 2001 22:58:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Daniel writes:
> > > Are you going to go to a COMPAT flag before final release?  This is
> > > pretty much needed for e2fsck to be able to detect/correct indexes.
> >
> > I will if I know what the exact semantics are.  I have only an
> > approximate idea of how this works and I'd appreciate a more precise
> > definition.
>
> OK, on ext2 the {,RO_,IN_}COMPAT flags work as follows for the kernel:
>
> COMPAT:    Means that the on-disk format is 100% compatible with older
> on-disk formats, so a kernel which didn't know anything about this feature
> could read/write the filesystem without corrupting the filesystem. This is
> essentially just a flag which says "this filesystem has a (hidden) feature"
> for e2fsck (more on e2fsck later).  The ext3 HAS_JOURNAL is a COMPAT
> feature, because the journal is simply a regular file with data blocks in
> it, nothing special.  DIR_PREALLOC is a COMPAT feature, since all it does
> is pre-allocate empty directory blocks for directories growing over 1 block.
>
> RO_COMPAT: Means the on-disk format is 100% compatible with older on-disk
>          formats for reading (i.e. the feature does not change the
>          visible on-disk format).  However, an old kernel writing to such a
> 	   filesystem would/could corrupt the filesystem, so this is
> 	   prevented(*).  SPARSE_SUPER is such a feature, because sparse
> 	   groups allow data blocks where superblock/GDT backups used to
> 	   live, and the old ext2_free_blocks() would refuse to free these
> 	   blocks, leading to inconsistent bitmaps.  Old ext2_free_blocks()
> 	   would also get an error if a series of blocks crossed a group
> 	   boundary.
> INCOMPAT:  Means the on-disk format has changed in some way that makes it
>          unreadable by older kernels.  FILETYPE is this because older
> 	   kernels would think the directory name_len was > 256, so that
> 	   would be bad.  COMPRESSION is obvious - you would just get
> 	   garbage back from read().  The ext3 RECOVER flag is needed to
> 	   prevent ext2 from mounting the filesystem without replaying the
> 	   journal.  In most cases, an unrecovered ext3 filesystem is in
> 	   no worse a state than an unchecked ext2 filesystem (so at one
> 	   time I wanted an RO_COMPAT_RECOVER flag to at least allow you
> 	   to mount an ext3 filesystem as ext2 for e3fsck), but a lot
> 	   more inconsistencies can accumulate in the journal than was
> 	   previously possible so that was shot down.
>
> Now for e2fsck, slightly different semantics are needed.  Basically, if
> a filesystem has ANY unsupported feature (COMPAT, RO_COMPAT, INCOMPAT),
> it will refuse to run on the filesystem, because it doesn't know how to
> deal with the feature.  For example, ext3 COMPAT_HAS_JOURNAL is not
> supported by older e2fsck, because it is possible for ext3 to use a
> reserved inode (number 8) to hold the journal, so this would fail.  It also
> didn't know what was a valid or invalid ext3 journal, so allowing an old
> e2fsck to pass on an ext3 filesystem would be a false sense of security.
>
> Because (with the change to dx_root_info), an indexed filesystem is 100%
> safe to write into even for kernels that know nothing about the directory
> indexes, it could be a COMPAT flag in the superblock.  This would force
> users to have an updated e2fsck to verify that the directory indexes
> are valid.  Otherwise, the indexes could (somehow) become corrupt and an
> old e2fsck would not detect this because it would just think the index
> blocks were empty directory blocks.
>
> (*) kernels before 2.4.0 didn't check RO_COMPAT on remount, so root could
>     be mounted RO with an RO_COMPAT feature, and then be remounted RW.  I
>     submitted a patch for this which made it into 2.4.0, but it is still
>     not in 2.2.19.  We also didn't check *COMPAT flags for rev 0 ext2
>     filesystems (i.e. those created by default with mke2fs 1.15 or earlier,
>     and still may be around), so COMPAT flags were totally ignored in this
>     case.  My patch also fixed that for 2.4.0.  Alan has said he will put
>     it into 2.2.20-pre1.

OK, I get it.  Nice article - it would sure be nice to see this
incorporated Documentation/filesystems/ext2.txt.  I just checked my copy
of Understanding the Linux Kernel and while existence of the compat
fields in the super block is noted, there is nothing at all said about
them. 

So then, the obvious candidate would be:

	#define EXT2_FEATURE_RO_COMPAT_DIR_INDEX        0x0004

which was formerly EXT2_FEATURE_RO_COMPAT_BTREE_DIR.

Other than declaring it, I gather I have to set this flag in the
superblock every time I set the EXT2_INDEX_FL in an inode.  Is that it?

> > > For that matter, I'm not even sure if ext2 supports directory files
> > > larger than 2GB?  Anyone?  I'm not 100% sure, but it may be that e2fsck
> > > considers directories >2GB as invalid.
>
> Actually, as I think about this more, it is currently invalid for
> directories to become > 2GB.  The i_size_high field in the inode is
> actually the i_dir_acl pointer, so this is only "available" for regular
> files and not directories.  Given that the ext2 EA/ACL code does not use
> this field, we may allow this in the future, but for now we are limited
> to 2GB directories.  Should be enough for now.

Yes, I will mask of 8 bits of the block index and this will be more than
enough to support the planned coalesce function.  I can't think of any
other use for these bits than coalescing - can you?

As you point out, we can't have directories bigger than 2 (4?) GB at the
moment, and if we ever can then we could revisit the maximum size
question.  I'm pretty sure that one day, not even very far in the
future, 16 GB will be too small a directory for some applications.  On
the other hand, it's possible that none of these applications will be
using Ext2.

> > > Have you been testing this with different kinds of input for filenames,
> > > or only synthetic input data?
> >
> > Because I'm not relying on any particular properties of coherence of
> > names, i.e., my hash function is as random as I can make it, I think the
> > sequential names are a pretty good test, except that they are all of
> > similar length.
>
> You could try "bonnie++ -s 0 -n 1000 -d /mnt/index_filesystem"
>
> to create 1M (zero length) files in a single directory.  The files have
> semi-random names and different lengths.  Basically a fixed-length number
> with random length characters added to the end.  Since bonnie++ is also
> a standard filesystem performance test, it will at least give some
> useful numbers to compare with.

OK, that sounds ideal.

> > > The fallback to a linear search is pretty much a requirement anyways,
> > > isn't it?
> >
> > Yes, in the sense that the new code also has to be able to handle
> > nonindexed directories, which it does now.  As far as falling back to a
> > linear search after somebody has done something boneheaded - I think
> > it's better to fail and kprint a suggestion to run fsck, which can
> > easily fix the problem instead of allowing it to go unnoticed and
> > perhaps adversely affect system performance.  The problem here is that
> > most users do not check their log files unless something doesn't work.
> > In this case, failing instead of pressing on constitutes helping, not
> > hurting.
>
> I would have to disagree.  In the case of unsupported/corrupt/bad index
> data, there _is_ a meaningful fallback, which is linear directory search.
> Calling ext2_error() will mark the filesystem in error (for the next
> e2fsck to clean up), and the sysadmin has the option of mounting with
> "errors=remount-ro" or "errors=panic" if this is desirable.  It should be
> up to the sysadmin to decide they want their box to crash or not, if there
> is a reasonable solution.
>
> We should definitely also clear the index flag on that directory, so we
> don't keep getting the same error.  The rest of the ext2 code will deal
> with the case if the actual directory data is corrupt.
>
> Also, I'm sure that if the system has a large directory (thousands of
> files), they will notice that it has become very slow.  If they don't
> notice (and e2fsck cleans it up after reboot), then that is just as well.

You win and I will put it on the to-do list.  As you say, it's not a lot
of work, but of course that's not the point - the point is to be
consistent with current behaviour.  Marking the filesystem in error
takes care of my objection, and the user gets to press on bravely in
this circumstance.  

> > > What happens with an existing directory larger than a single block
> > > when you are mounting "-o index"?  You can't index it after-the-fact,
> > > so you need to linear search.
> >
> > This works now.
>
> So then bailing out of index mode (on error) to go into linear search
> mode is as easy as clearing the directory index flag and reading the
> directory from the start.

Are you sure we want to clear the index flag?  The user has probably
just booted the wrong kernel.  And yes, we are talking about a
strategically placed goto here, after a little cleanup.
--
Daniel
