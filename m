Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbREaTqa>; Thu, 31 May 2001 15:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263189AbREaTqU>; Thu, 31 May 2001 15:46:20 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:17660 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263193AbREaTqH>; Thu, 31 May 2001 15:46:07 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105311944.f4VJiIrK016421@webber.adilger.int>
Subject: Re: [Ext2-devel] [UPDATE] Directory index for ext2
In-Reply-To: <0105311813431J.06233@starship> "from Daniel Phillips at May 31,
 2001 06:13:43 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Thu, 31 May 2001 13:44:18 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, you write:
>   - Fall back to linear search in case of corrupted index

OK, I have _some_ of the code needed to do this, but in one case I'm
not sure of what your intention was - in dx_probe() you check for
"unused_flags & 1" to signal a bad/unsupported index.  Why only check
the low bit instead of the whole thing?  I currently have:

	if (dir->i_size < dir->i_sb->s_blocksize * 2)
                goto fail;	// bad EXT2_INDEX_FL set, clear?
        if (IS_ERR(bh = ext2_bread (dir, 0, 0)))
                goto fail;      // FIXME error message?
        root = (struct dx_root *) bh->b_data;

	// use the following for production once hash_version is 1
        // if (root->info.hash_version & 3 == 0 || root->info.unused_flags)
        if (root->info.hash_version > 0 || root->info.unused_flags & 1)
                goto fail2;	// unsupported hash format
        if ((indirect = root->info.indirect_levels) > 1)
                goto fail2;	// unsupported hash format
        if (root->info.reserved_zero.v ||
            root->info.info_length < sizeof(root->info))
                goto fail2;	// bad root node data
	...
	if (dx_get_limit(entries) != dx_root_limit(dir, root->info.info_length))
                goto fail2;	// bad root node data
	...
		if (dx_get_limit(entries) != dx_node_limit (dir))
                        goto fail3;     // bad index node data

On lookup it is OK to fall back to linear search, but if we add an entry
via linear we would then overwrite the root index.  We probably want extra
logic so that if we have a bad interior node we overwrite that (or another
leaf instead of killing the root index).  We probably also want to make a
distinction between I/O errors and bad data (currently I just return NULL
for both).  I think Al's idea of doing the validation once on the initial
read is a good one.

Instead of keeping reserved_zero as zero and using it to detect if an
inode number was written there, we could write a magic number there to
signal a valid hash.  Alternately, instead of using hash_version to mark
the hash type, we could leave that unused and make the above magic
number the hash value, which is the hash of some fixed string, e.g.

HASH_V0 := dx_hack_hash("Daniel Phillips", 15) // constant value
HASH_V1 := dx_new_hash("Daniel Phillips", 15)  // constant value

struct dx_root
{
        struct fake_dirent dot;
        char dot_name[4];
        struct fake_dirent dotdot;
        char dotdot_name[4];
        struct dx_root_info {
                le_u32 hash_magic;
                u8 unused;
                u8 info_length; /* 8 */
                u8 indirect_levels;
                u8 unused_flags;
        } info;
        struct dx_entry entries[0];
};

/*
 * Hash value depends on existing hash type, so it is calculated here.
 * For new directories we never use this function, and simply pick the
 * default hash function when creating the new dx_root.
 */
static inline dx_frame *dx_probe(inode *dir, dentry *dentry, u32 *hash)
				 dx_frame *frame)
{
	struct dx_root *root;

	if (IS_ERR(bh = ext2_bread (dir, 0, 0)))
                goto fail;	// return error code
	root = (struct dx_root *) bh->b_data;

	switch (le32_to_cpu(root->info.hash_magic.v)) {
	case HASH_V0:
		// hash-specific dx_root validation here
		*hash = dx_hack_hash(dentry->d_name.name, dentry->d_name.len);
		return dx_probe_hash(dir, hash, frame, bh);
	case HASH_V1:
		// hash-specific dx_root validation here
		*hash = dx_new_hash(dentry->d_name.name, dentry->d_name.len);
		return dx_probe_hash(dir, hash, frame, bh);
	default: printk("unsupported hash %u in directory %lu\n",
			root->info.hash_magic, dir->i_ino);
		brelse(bh);
		*hash = 0;
	}
fail:
	return NULL;
}



>   - Finalize hash function

I noticed something interesting when running "mongo" with debugging on.
It is adding filenames which are only sequential numbers, and the hash
code is basically adding to only two blocks until those blocks are full,
at which point (I guess) the blocks split and we add to two other blocks.

I haven't looked at it closely, but for _example_ it something like:

65531 to block 113
65532 to block 51
65533 to block 51
65534 to block 113
65535 to block 113
(repeats)
65600 to block 21
65601 to block 96
65602 to block 96
65603 to block 21
65604 to block 21
(repeats)

I will have to recompile and run with debugging on again to get actual
output.

To me this would _seem_ bad, as it indicates the hash is not uniformly
distributing the files across the hash space.  However, skewed hashing
may not necessarily be the bad for performance.  It may even be that
because we never have to rebalance the hash index structure that as long
as we don't get large numbers of identical hashes it is just fine if
similar filenames produce similar hash values.  We just keep splitting
the leaf blocks until the hash moves over to a different "range".  For a
balanced tree-based structure a skewed hash would be bad, because you
would have to do full-tree rebalancing very often then.



> No known bugs, please test, thanks in advance.

Running mongo has shown up another bug, I see, but haven't had a chance to
look into yet.  It involves not being able to delete files from an indexed
directory:

rm: cannot remove `/mnt/tmp/testdir1-0-0/d0/d1/d2/d3/509.r': Input/output error

This is after the files had been renamed (.r suffix).  Do we re-hash
directory entries if the file is renamed?  If not, then that would
explain this problem.  It _looks_ like we do the right thing, but the
mongo testing wipes out the filesystem after each test, and the above
message is from a logfile only.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
