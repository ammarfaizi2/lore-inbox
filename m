Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132758AbRDISfr>; Mon, 9 Apr 2001 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRDISfh>; Mon, 9 Apr 2001 14:35:37 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:42997 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132758AbRDISf2>; Mon, 9 Apr 2001 14:35:28 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104091835.f39IZHxl007263@webber.adilger.int>
Subject: Re: [RFC] Ext2 Directory Index - File Structure
In-Reply-To: <20010409104037Z92164-22358+7@humbolt.nl.linux.org>
 "from Daniel Phillips at Apr 9, 2001 12:40:35 pm"
To: Daniel Phillips <phillips@nl.linux.org>
Date: Mon, 9 Apr 2001 12:35:16 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, you write:
> For the past several weeks I have been developing a directory index
> facility for Ext2, with good results so far.  This note describes the
> on-disk format of the new index.

Finally starting to test your last release, and you make a new one... ;-)

> Needless to say, the new code no longer clears this bit but uses it as
> it was intended, to flag the presence of an index on a directory.  If a
> partition has been mounted with the -o index[2] option enabled then each
> new directory is created with the EXT2_INDEX_FL set.

Are you going to go to a COMPAT flag before final release?  This is
pretty much needed for e2fsck to be able to detect/correct indexes.

> 	struct dx_root
> 	{
> 		struct dx_root_info
> 		{
> 			struct fake_dirent fake1;
> 			char dot1[4];
> 			struct fake_dirent fake2;
> 			char dot2[4];
> 			u8 info_length; /* 8 */
> 			u8 hash_version; /* 0 */
> 			u8 indirect_levels
> 			u8 unused_flags;
> 			le_u32 reserved_zero;
> 		}
> 		info;
> 		struct dx_entry	entries[0];
> 	};

One thing I was thinking about the root entry - for compatibility with 2.0
and earlier kernels (which don't clear INDEX_FL) there is a simple solution:

- deleted dirents do not pose any problems, because a hash index is no
  guarantee that a specific dirent exists, only a range of possible entries
- adding a dirent will _always_ go into the first empty block (which is the
  index root block), and overwrite the dx_root_info data after "." and ".."

In the latter case (and also in the case of data corruption), it is useful
to have some sort of integrity check within dx_root_info.  If a dirent
overwrote the root index block, the first 4 bytes of the dirent after
"." and ".." would be an inode number, this could be anything and is not
very useful for detecting if it is a valid number or not.  However, if you
put the "reserved_zero" field first and swap the order of "hash_version"
and "info_length", then "info_length" and "hash_version" will overlap with
the "rec_len" field of a new dirent.  If (hash_version & 3) is always true,
a valid "rec_len" is always a multiple of 4, so it is possible to detect if
the dx_root_info has been overwritten by an old version of ext2 code.  So:

 		struct dx_root_info {
 			struct fake_dirent fake1;
 			char dot1[4];
 			struct fake_dirent fake2;
 			char dot2[4];
/* __u32 inode; */	le_u32 reserved_zero;
/* __u16 rec_len lo */	u8 hash_version; /* 1, or 2, or 3, but not 0 or 4 */
/* __u16 rec_len hi */	u8 info_length;  /* 8 */
 			u8 indirect_levels
 			u8 unused_flags;
 		} info;

It will also be easy to detect if reserved_zero is changed, because zero is
not a valid inode number.  We can't rely on fake2's rec_len in case a dir
entry was added and then deleted (corrupting dx_root_info, but leaving
fake1 and fake2 as they should be).

> The high four bits of the block pointer field are reserved for use by
> a coalesce-on-delete feature which may be implemented in the future. 
> The remaining 28 bits are capable of indexing up to 1TB per directory
> file.  (Perhaps I should coopt 8 bits instead of 4.)

Might be worthwhile, even if you don't use all of the bits for coalesce
flags.  Nothing better than having free space for future expansion.  Even
for a 1kB block filesystem, this would give us directories up to 16GB, at
worst case about 32M 256-character entries, average case 595M 9-to-12-character
names.  Having 24 bits for 4kB block (64GB) directories gives us worst-case
117M 256-character entries, and average case 2.2B 9-to-12 character names.
Assumes 50% full leaf blocks for worst case, 70% full for average case.

For that matter, I'm not even sure if ext2 supports directory files larger
than 2GB?  Anyone?  I'm not 100% sure, but it may be that e2fsck considers
directories >2GB as invalid.

> Thus, directory leafs will average no more than 75% full and typically
> a few points less than that since the hash function never produces a
> perfectly uniform distribution.  (The better the hash function, the
> closer we get to 75%; we are currently at 71%.) 

Have you been testing this with different kinds of input for filenames,
or only synthetic input data?  One interesting dataset would be to get
the filename generation code from sendmail (for /var/spool/mqueue) and/or
inn and/or squid to see how those names are hashed.  These are legitimate
applications which tend to store lots of files in a single directory.

> It is quite likely that the hash function will be improved in the
> future, therefore a hash function version field is included in the root
> header.  If the current code sees a nonzero hash function version it
> will fail the directory operation gracefully.  Thus, the worst possible
> effect of adding a new hash function in the future is that old versions
> of ext2 will not be able to access a directory created with the new hash
> function.  (Alternatively, we could arrange a fallback to a linear
> search.) 

The fallback to a linear search is pretty much a requirement anyways, isn't
it?  What happens with an existing directory larger than a single block
when you are mounting "-o index"?  You can't index it after-the-fact, so
you need to linear search.  This also needs to be the case if you detect
bogus data in the index blocks.  If there is any erronous data in the index
blocks, you basically need to turn off the INDEX flag, mark the filesystem
in error, and revert to linear searching for that directory (leaving it to
e2fsck to fix (based on a COMPAT flag).

> To Do
> -----
> 
>   - Finalize hash function
>   - Test/debug big endian
>   - Convert to page cache
> 
> Future Work
> -----------
> 
>   - Fail gracefully on random data
>   - Defer index creation until 1st block full

I would consider both of these in the "To Do" category before it goes into
the kernel.  Otherwise, in 99% of the normal directories, you are doubling
the space needed for a directory, which means you will need to weigh on a
filesystem-by-filesystem basis whether to use indexing.  I would rather be
able to turn it on for all filesystems.

> [1] The index tree could have been made finer-grained than one block,
> but not without sacrificing the desireable property of forward
> compatibility with older Linux versions (because the directory block
> format would have had to have been changed) and it is not clear that a
> finer-grained index would perform better.

Interestingly, I was reading on the reiserfs list that they are looking
at (for performance reasons) using linear hash searching for under about
100 because of reduced overhead.  Whether this goes into the code or not
will obviously be determined by their testing, it does make some sense.
If we had sub-block indexing, then we would need to keep the index entries
sorted to a finer resolution, adding more overhead to each entry.

> [4] The test for directory size could be eliminated if we are willing to
> accept that indexing be used on all new directories.  In that case the
> index flag would be set on any directory larger than a block.  A
> decision was made to err on the side of more control by the
> administrator, who can now be offered the option of specifying which 
> directories should be indexed and which not.

I'm not sure I follow this.  Isn't this the case already (or at least the
same as "only add the index after we grow past 1 block")?  Namely, don't
all directories get an index block (especially those growing larger than
1 block), or do you need to "chattr" each directory which will get an index?
If e2fsck gets into the picture with a COMPAT flag, I would think it will
build an index for any directory larger than 1 block (to free the kernel from
having to do this on existing filesystems).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
