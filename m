Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbQLAMAJ>; Fri, 1 Dec 2000 07:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLAL77>; Fri, 1 Dec 2000 06:59:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32896 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129434AbQLAL7o>;
	Fri, 1 Dec 2000 06:59:44 -0500
Date: Fri, 1 Dec 2000 06:28:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [CFT][RFC] ext2_new_inode() fixes and cleanup
In-Reply-To: <200012010827.eB18R0u22296@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0012010529171.22427-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Dec 2000, Andreas Dilger wrote:

> Alexander, Ted,
> I was taking a hard look at the proposed changes.  In load_inode_bitmap()
> we shouldn't be cacheing the I/O error case (this was in the old code too).

I know. I left it in place since I don't like the idea of putting many
not-absolutely-trivial changes into one chunk...

> We should probably reconcile the changes here with load_block_bitmap(),
> or for that matter, we should make a single function and pass in a
> pointer to s_{block,inode}_bitmap and s_{block,inode}_bitmap_number
> arrays and save the duplicate code maintenance (even if inline).

The former - definitely yes (I just don't want to deal with changes in
too many places at once), the latter... I'm not sure that it's a right
thing. Generic manipulations of LRU - sure, but let's make it a helper
function and lets take the actual loading of the bitmaps into its
(2) callers.

> If we have a generic function like so:
> 
> struct buffer_head *load_bitmap(struct super_block *sb,
> 				unsigned int block_group,
> 				unsigned long *bitmap_number,
> 				struct buffer_head *bitmap,
> 				size_t gdt_offset)

Too many arguments. Exposed to all callers...

BTW, I would actually start with initializing the caches with NULLs and
forgetting about the counters (->s_loaded_foo_bitmap). That would allow
to shrink the load_foo_bitmap quite seriously - look at the code and
you'll see. Then code duplication becomes almost a non-issue.

> Comments/changes are enclosed below, with sh style # comments by me.
> PS - discussion on this should probably move to ext2-devel or fsdevel.
 
> > +		if (sbi->s_inode_bitmap_number[slot] == slot)
> > +			goto found;
> 		/* FIXME: when online shrinking we may go from case B to A */
	Keeps the behaviour of old code.

> > +		ext2_panic (sb, "load_inode_bitmap",
> > +			    "block_group != inode_bitmap_number");
 
> # Need to fix callers of load_inode_bitmap() to check for NULL return

If you do the return NULL instead of return ERR_PTR(...). OTOH, right
now we only do ERR_PTR(-EIO), so we might pass NULL just fine. I'm
not sure that we'll never want other error values, though...

> # In find_cg_other() we should probably should also check for free blocks,
> # to give inode a chance to be close to any blocks it will likely soon
> # allocate.  Don't need to byte swap to test non-zeroness...  It would be
> # nice to use "gdt" instead of "cg", to keep it consistent with the rest
> # of the ext2 code... Maybe find_group_dir() and find_group_other()?

<shrug> History. It used to be called "cylinder group" in FFS.

> # In ext2_new_inode() you removed the case where the bit was set between
> # time we searched and the time we set it.  This probably can't happen
> # while we hold the superblock lock.  It may be worth keeping for when we
> # go to per-group locks.

No, it isn't. Notice that find_cg_foo() updates the per-group counters.
So nobody can take the last free bit from us.

> 	/* With the superblock lock we are safe here, but not once it's gone.
> 	if (ext2_set_bit(j, bh->b_data)) {
> 		ext2_warning(sb, __FUNCTION__,
> 			     "bit already set for inode %d", j);
> 		goto repeat;
> 	}

No. Sorry, but "goto repeat" is a very loud "we have a race here" alarm.
Doing that after you've found and fixed recoverable error is OK. Using
that to deal with races is a recipe for big trouble. Protect the
search-and-set with a spinlock and that's it. In any case, if we do the
"goto repeat" variant we should not do ext2_warning() (it _is_ bogus)
and we should return only to ext2_find_first_zero_bit() - we had already
reserved an empty inode in the counter and repeating the whole search
for appropriate group is a huge overkill.

> 	*/
> 
> # Need to check that we got a good gdp back here...
> > +fail2:
> > +	gdp = ext2_get_group_desc (sb, i, &bh2);

Why? ext2_get_group_desc() can't fail, since we've already called it with
that argument and ->s_group_desc[] is not cleaned. If you are thinking about
resize - let's add a resize_sem and make current users of lock_super() do
down_read() and resizer do down_write() - no additional contention for normal
case and you really don't want to do resize while allocating. Notice that
as soon as we start removing elements from ->s_group_desc[] we are in for
a major PITA - brelse() on a buffer_head * that can be in use right now...
Not nice.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
