Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLAI5q>; Fri, 1 Dec 2000 03:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLAI5g>; Fri, 1 Dec 2000 03:57:36 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:8436 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129248AbQLAI53>; Fri, 1 Dec 2000 03:57:29 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012010827.eB18R0u22296@webber.adilger.net>
Subject: Re: [CFT][RFC] ext2_new_inode() fixes and cleanup
In-Reply-To: <Pine.GSO.4.21.0011301652130.21891-100000@weyl.math.psu.edu>
 "from Alexander Viro at Nov 30, 2000 05:13:27 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 1 Dec 2000 01:27:00 -0700 (MST)
CC: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander, Ted,
I was taking a hard look at the proposed changes.  In load_inode_bitmap()
we shouldn't be cacheing the I/O error case (this was in the old code too).
It means we don't have to check for NULL bh in the table cache each time
through, and for (s_groups_count < MAX_GROUPS_LOADED) case there are 3 less
comparisons and 1 less assignment before we return (the other fast path
is still 4 comparisons)...  Also, a NULL return for an I/O error is good
for 1 less comparison per call (need to change callers to test for NULL
instead of IS_ERR()) and the callers have no more work than before...

We should probably reconcile the changes here with load_block_bitmap(),
or for that matter, we should make a single function and pass in a
pointer to s_{block,inode}_bitmap and s_{block,inode}_bitmap_number
arrays and save the duplicate code maintenance (even if inline).

If we have a generic function like so:

struct buffer_head *load_bitmap(struct super_block *sb,
				unsigned int block_group,
				unsigned long *bitmap_number,
				struct buffer_head *bitmap,
				size_t gdt_offset)

And we call the load_bitmap() function like either:

	bh = load_bitmap(sb, block_group,
			 sbi->s_inode_bitmap_number,
			 sbi->s_inode_bitmap,
			 offsetof(ext2_group_desc, bg_inode_bitmap));
or
	bh = load_bitmap(sb, block_group,
			 sbi->s_block_bitmap_number,
			 sbi->s_block_bitmap,
			 offsetof(ext2_group_desc, bg_block_bitmap));

We use the gdt_offset when calling a generic read_bitmap() function,
which uses the gdt_offset (rather than have function pointers, which
are overkill here) to determine which bitmap to load (my pointer math
may be a bit off here, but the idea is valid):

	bh = bread(sb->s_dev,
		   le32_to_cpu(*((__u32 *)((void *)gdp + gdt_offset))),
		   sb->s_blocksize);


Now that I look at load_block_bitmap(), I see we use block_group to
dereference bitmap arrays, but we don't check it until later, and it
is much more complex than the load_inode_bitmap() now is.  We need to
audit the callers of load_{block,inode}_bitmap() (a quick check shows
it is impossible to call load_inode_bitmap() with a bad group number),
and then we can simply remove the block_group check from here entirely.

I think with Al's proposed changes this will be relatively easy, but
I would rather do it _after_ his changes have been accepted.  Would
anyone be interested in a real patch that does this?


Comments/changes are enclosed below, with sh style # comments by me.
PS - discussion on this should probably move to ext2-devel or fsdevel.


 *
 * Return the buffer head of the bitmap, or NULL on error.
 */
static struct buffer_head *load_inode_bitmap (struct super_block * sb,
                                              unsigned int block_group)
{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
	struct buffer_head *bh;
> +	int i, slot = 0;
> +
> +	if (block_group >= sbi->s_groups_count)
> +		ext2_panic(sb, __FUNCTION,
> +			   "block_group >= groups_count - "
> +			   "block_group = %d, groups_count = %lu",
> +			   block_group, sbi->s_groups_count);
> +
	/* Case A: we can fit all blocks in cache - keep in group order. */
> +	if (sbi->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
> +		slot = block_group;
> +		bh = sbi->s_inode_bitmap[slot];
> +		if (!bh)
> +			goto read_it;
> +		if (sbi->s_inode_bitmap_number[slot] == slot)
> +			goto found;
		/* FIXME: when online shrinking we may go from case B to A */
> +		ext2_panic (sb, "load_inode_bitmap",
> +			    "block_group != inode_bitmap_number");
# no need for return on panic
> +	}
> +
> +	bh = sbi->s_inode_bitmap[0];
	/*
	 * We haven't loaded any bitmaps yet, or last one was an I/O error.
	 * No need to cache the I/O error case, so just overwrite it.
	 */
	if (!bh)
		goto read_it;
	/*
	 * Case B: we keep LRU cache of accessed bitmaps (0 = most recent).
	 * Fast path - we are using the same bitmap as last time.
	 */
	if (sbi->s_inode_bitmap_number[0] == block_group)
		goto found;
> +
# can start at 1, because we already checked bitmap[0]
	for (i = 1; i < sbi->s_loaded_inode_bitmaps &&
> +		    sbi->s_inode_bitmap_number[i] != block_group;
> +	     i++)
> +		;
> +	if (i < sbi->s_loaded_inode_bitmaps) {
> +		int j;
> +		unsigned long nr = sbi->s_inode_bitmap_number[i];
> +		bh = sbi->s_inode_bitmap[i];
> +		for (j = i; j > 0; j--) {
> +			sbi->s_inode_bitmap_number[j] =
> +				sbi->s_inode_bitmap_number[j - 1];
> +			sbi->s_inode_bitmap[j] =
> +				sbi->s_inode_bitmap[j - 1];
> +		}
> +		sbi->s_inode_bitmap_number[0] = nr;
> +		sbi->s_inode_bitmap[0] = bh;
		/* Only when online growing (case A to B) can bh be NULL
		if (bh) */
> +		goto found;
> +	} else {
> +		int j;
> +		if (sbi->s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
> +			sbi->s_loaded_inode_bitmaps++;
> +		else
> +			brelse(sbi->s_inode_bitmap[EXT2_MAX_GROUP_LOADED - 1]);
> +		for (j = sbi->s_loaded_inode_bitmaps - 1; j > 0; j--) {
> +			sbi->s_inode_bitmap_number[j] =
> +				sbi->s_inode_bitmap_number[j - 1];
> +			sbi->s_inode_bitmap[j] =
> +				sbi->s_inode_bitmap[j - 1];
> +		}
> +	}
> +
> +read_it:
> +	bh = read_inode_bitmap(sb, block_group);
> +	/*
	 * On I/O error, just leave a NULL in the cache's block pointer
	 * for this group.  The IO will be retried next time.
> +	 */
> +	sbi->s_inode_bitmap[slot] = bh;
> +	sbi->s_inode_bitmap_number[slot] = block_group;
> +found:
> +	return bh;
> +}


# Need to fix callers of load_inode_bitmap() to check for NULL return
> 	}
> 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
> 	bit = (ino - 1) % EXT2_INODES_PER_GROUP(sb);
> +	bh = load_inode_bitmap (sb, block_group);
	if (!bh)
		goto error_return;




# In find_cg_other() we should probably should also check for free blocks,
# to give inode a chance to be close to any blocks it will likely soon
# allocate.  Don't need to byte swap to test non-zeroness...  It would be
# nice to use "gdt" instead of "cg", to keep it consistent with the rest
# of the ext2 code... Maybe find_group_dir() and find_group_other()?

> +	 * Try to place the inode in its parent directory
> +	 */
	i = dir_group;
	gdt = ext2_get_group_desc(sb, i, &bh);
	if (gdt && gdt->bg_free_inodes_count && gdt->bh_free_blocks_count)
		goto found;

# Same here - only allocate an inode in a group with free blocks, and no
# byte swapping needed to check non-zeroness...  We leave a few blocks
# free in each group for use by inodes that already exist there...
> +	/*
> +	 * Use a quadratic hash to find a group with a
	 * free inode and some free blocks
> +	 */
> +	for (j = 1; j < ngroups; j <<= 1) {
> +		i += j;
> +		if (i >= ngroups)
> +			i -= ngroups;
		gdt = ext2_get_group_desc(sb, i, &bh);
		if (gdt && gdt->bg_free_inodes_count &&
		    dt->bh_free_blocks_count >= 32)
			goto found;


# Now we have to search all groups for a free inode in this next loop
# (2 more than with old code).  This is only less efficient in the case
# we are creating lots of zero length files, or if we failed in the
# second stage because the groups are all (nearly) full...
# In either case, the inode may not be in a group with (m)any free blocks.
# I'd rather optimize for the normal case of files with blocks (more
# inode/block locality).
> +	/*
> +	 * That failed: try linear search for a free inode
> +	 */
	i = dir_group;
	for (j = 0; j < ngroups; j++, i++) {
		if (i >= ngroups)
> +			i = 0;
		gdt = ext2_get_group_desc(sb, i, &bh);
		if (gdt && gdt->bg_free_inodes_count)
> +			goto found;
> +	}





# In ext2_new_inode() you removed the case where the bit was set between
# time we searched and the time we set it.  This probably can't happen
# while we hold the superblock lock.  It may be worth keeping for when we
# go to per-group locks.
>  repeat:
> +	if (S_ISDIR(mode)) 
> +		i = find_cg_dir(sb, dir->u.ext2_i.i_block_group);
>  	else 
> +		i = find_cg_other(sb, dir->u.ext2_i.i_block_group);
>  
> +	err = -ENOSPC;
> +	if (i == -1)
> +		goto fail;
> +
> +	err = -EIO;
> +	bh = load_inode_bitmap (sb, i);
> +	if (IS_ERR(bh))
> +		goto fail2;
> +
> +	j = ext2_find_first_zero_bit ((unsigned long *) bh->b_data,
> +					      EXT2_INODES_PER_GROUP(sb));
> +	if (j >= EXT2_INODES_PER_GROUP(sb))
> +		goto bad_count;
	/* With the superblock lock we are safe here, but not once it's gone.
	if (ext2_set_bit(j, bh->b_data)) {
		ext2_warning(sb, __FUNCTION__,
			     "bit already set for inode %d", j);
		goto repeat;
	}
	*/

# Need to check that we got a good gdp back here...
> +fail2:
> +	gdp = ext2_get_group_desc (sb, i, &bh2);
	if (!gdp)
		goto fail;
> +	gdp->bg_free_inodes_count =
> +		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) + 1);
> +	if (S_ISDIR(mode))
> +		gdp->bg_used_dirs_count =
> +			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) - 1);
> +	mark_buffer_dirty(bh2);
> +fail:
> +	unlock_super(sb);
> +	iput(inode);
> +	return ERR_PTR(err);


Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
