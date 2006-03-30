Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWC3UP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWC3UP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWC3UP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:15:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:38876 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750800AbWC3UP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:15:56 -0500
Subject: Re: [Ext2-devel] [RFC] [PATCH] fs-wide dirty bit + reservations +
	multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@linux.intel.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060324140507.GA14508@goober>
References: <20060324140507.GA14508@goober>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 30 Mar 2006 12:14:42 -0800
Message-Id: <1143749682.3896.55.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 06:05 -0800, Valerie Henson wrote:
> The fs-wide dirty bit patch is now functional - crashing the system
> while the file system is marked clean results in a clean fsck.  This
> is mostly the result of porting Mingming's reservations and multiple
> block allocation patches to ext2.  Changes since last patch:
> 
> * Remove old preallocation code, replace with reservations
> * ext2 port of multiple block allocations

It seems that you will need to port back part of ext3_get_blocks() back
to ext2, to make use of the ext2_new_blocks() you just ported below, for
multiple block allocation. And also probably check ext2/3_direct_IO()
code, as it is the user of ext2/3 multiple block allocations.

> You probably also need to port
> * Use kthread API, fsync_super() (thanks, Andrew!)
> * Coding style fixes
> * Actual working-ness
> 
> Next on my plate:
> 
> * Finish OLS paper :)
> * Test on non-UML
> * Performance tests
> * Fix at least two known unlocked regions
> * Various patch monkey type items
> * Pay Arjan $10
> 
> Thanks to everyone who reviewed and commented.
> 
> Patch is still against 2.6.16-rc5-mm3.
> 
> -VAL
> 
> diff -x '*~' -uNr vanilla-linux/fs/ext2/balloc.c uml-clean/fs/ext2/balloc.c
> --- vanilla-linux/fs/ext2/balloc.c	2006-03-24 01:47:33.000000000 -0800
> +++ uml-clean/fs/ext2/balloc.c	2006-03-24 05:23:17.000000000 -0800
> @@ -95,41 +95,6 @@
>  	return bh;
>  }
>  
> -/*
> - * Set sb->s_dirt here because the superblock was "logically" altered.  We
> - * need to recalculate its free blocks count and flush it out.
> - */
> -static int reserve_blocks(struct super_block *sb, int count)
> -{
> -	struct ext2_sb_info *sbi = EXT2_SB(sb);
> -	struct ext2_super_block *es = sbi->s_es;
> -	unsigned free_blocks;
> -	unsigned root_blocks;
> -
> -	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
> -	root_blocks = le32_to_cpu(es->s_r_blocks_count);
> -
> -	if (free_blocks < count)
> -		count = free_blocks;
> -
> -	if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
> -	    sbi->s_resuid != current->fsuid &&
> -	    (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
> -		/*
> -		 * We are too close to reserve and we are not privileged.
> -		 * Can we allocate anything at all?
> -		 */
> -		if (free_blocks > root_blocks)
> -			count = free_blocks - root_blocks;
> -		else
> -			return 0;
> -	}
> -
> -	percpu_counter_mod(&sbi->s_freeblocks_counter, -count);
> -	sb->s_dirt = 1;
> -	return count;
> -}
> -
>  static void release_blocks(struct super_block *sb, int count)
>  {
>  	if (count) {
> @@ -140,24 +105,6 @@
>  	}
>  }
>  
> -static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
> -	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
> -{
> -	unsigned free_blocks;
> -
> -	if (!desc->bg_free_blocks_count)
> -		return 0;
> -
> -	spin_lock(sb_bgl_lock(sbi, group_no));
> -	free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
> -	if (free_blocks < count)
> -		count = free_blocks;
> -	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
> -	spin_unlock(sb_bgl_lock(sbi, group_no));
> -	mark_buffer_dirty(bh);
> -	return count;
> -}
> -
>  static void group_release_blocks(struct super_block *sb, int group_no,
>  	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
>  {
> @@ -170,10 +117,222 @@
>  		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
>  		spin_unlock(sb_bgl_lock(sbi, group_no));
>  		sb->s_dirt = 1;
> +		ext2_mark_fs_dirty(sb);
>  		mark_buffer_dirty(bh);
>  	}
>  }
>  
> +/*
> + * The reservation window structure operations
> + * --------------------------------------------
> + * Operations include:
> + * dump, find, add, remove, is_empty, find_next_reservable_window, etc.
> + *
> + * We use sorted double linked list for the per-filesystem reservation
> + * window list. (like in vm_region).
> + *
> + * Initially, we keep those small operations in the abstract functions,
> + * so later if we need a better searching tree than double linked-list,
> + * we could easily switch to that without changing too much
> + * code.
> + */
> +#if 0
> +static void __rsv_window_dump(struct rb_root *root, int verbose,
> +			      const char *fn)
> +{
> +	struct rb_node *n;
> +	struct ext2_reserve_window_node *rsv, *prev;
> +	int bad;
> +
> +restart:
> +	n = rb_first(root);
> +	bad = 0;
> +	prev = NULL;
> +
> +	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
> +	while (n) {
> +		rsv = list_entry(n, struct ext2_reserve_window_node, rsv_node);
> +		if (verbose)
> +			printk("reservation window 0x%p "
> +			       "start:  %d, end:  %d\n",
> +			       rsv, rsv->rsv_start, rsv->rsv_end);
> +		if (rsv->rsv_start && rsv->rsv_start >= rsv->rsv_end) {
> +			printk("Bad reservation %p (start >= end)\n",
> +			       rsv);
> +			bad = 1;
> +		}
> +		if (prev && prev->rsv_end >= rsv->rsv_start) {
> +			printk("Bad reservation %p (prev->end >= start)\n",
> +			       rsv);
> +			bad = 1;
> +		}
> +		if (bad) {
> +			if (!verbose) {
> +				printk("Restarting reservation walk in verbose mode\n");
> +				verbose = 1;
> +				goto restart;
> +			}
> +		}
> +		n = rb_next(n);
> +		prev = rsv;
> +	}
> +	printk("Window map complete.\n");
> +	if (bad)
> +		BUG();
> +}
> +#define rsv_window_dump(root, verbose) \
> +	__rsv_window_dump((root), (verbose), __FUNCTION__)
> +#else
> +#define rsv_window_dump(root, verbose) do {} while (0)
> +#endif
> +
> +static int
> +goal_in_my_reservation(struct ext2_reserve_window *rsv, int goal,
> +			unsigned int group, struct super_block * sb)
> +{
> +	unsigned long group_first_block, group_last_block;
> +
> +	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
> +				group * EXT2_BLOCKS_PER_GROUP(sb);
> +	group_last_block = group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
> +
> +	if ((rsv->_rsv_start > group_last_block) ||
> +	    (rsv->_rsv_end < group_first_block))
> +		return 0;
> +	if ((goal >= 0) && ((goal + group_first_block < rsv->_rsv_start)
> +		|| (goal + group_first_block > rsv->_rsv_end)))
> +		return 0;
> +	return 1;
> +}
> +
> +/*
> + * Find the reserved window which includes the goal, or the previous one
> + * if the goal is not in any window.
> + * Returns NULL if there are no windows or if all windows start after the goal.
> + */
> +static struct ext2_reserve_window_node *
> +search_reserve_window(struct rb_root *root, unsigned long goal)
> +{
> +	struct rb_node *n = root->rb_node;
> +	struct ext2_reserve_window_node *rsv;
> +
> +	if (!n)
> +		return NULL;
> +
> +	do {
> +		rsv = rb_entry(n, struct ext2_reserve_window_node, rsv_node);
> +
> +		if (goal < rsv->rsv_start)
> +			n = n->rb_left;
> +		else if (goal > rsv->rsv_end)
> +			n = n->rb_right;
> +		else
> +			return rsv;
> +	} while (n);
> +	/*
> +	 * We've fallen off the end of the tree: the goal wasn't inside
> +	 * any particular node.  OK, the previous node must be to one
> +	 * side of the interval containing the goal.  If it's the RHS,
> +	 * we need to back up one.
> +	 */
> +	if (rsv->rsv_start > goal) {
> +		n = rb_prev(&rsv->rsv_node);
> +		rsv = rb_entry(n, struct ext2_reserve_window_node, rsv_node);
> +	}
> +	return rsv;
> +}
> +
> +void ext2_rsv_window_add(struct super_block *sb,
> +		    struct ext2_reserve_window_node *rsv)
> +{
> +	struct rb_root *root = &EXT2_SB(sb)->s_rsv_window_root;
> +	struct rb_node *node = &rsv->rsv_node;
> +	unsigned int start = rsv->rsv_start;
> +
> +	struct rb_node ** p = &root->rb_node;
> +	struct rb_node * parent = NULL;
> +	struct ext2_reserve_window_node *this;
> +
> +	while (*p)
> +	{
> +		parent = *p;
> +		this = rb_entry(parent, struct ext2_reserve_window_node, rsv_node);
> +
> +		if (start < this->rsv_start)
> +			p = &(*p)->rb_left;
> +		else if (start > this->rsv_end)
> +			p = &(*p)->rb_right;
> +		else
> +			BUG();
> +	}
> +
> +	rb_link_node(node, parent, p);
> +	rb_insert_color(node, root);
> +}
> +
> +static void rsv_window_remove(struct super_block *sb,
> +			      struct ext2_reserve_window_node *rsv)
> +{
> +	rsv->rsv_start = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +	rsv->rsv_end = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +	rsv->rsv_alloc_hit = 0;
> +	rb_erase(&rsv->rsv_node, &EXT2_SB(sb)->s_rsv_window_root);
> +}
> +
> +static inline int rsv_is_empty(struct ext2_reserve_window *rsv)
> +{
> +	/* a valid reservation end block could not be 0 */
> +	return (rsv->_rsv_end == EXT2_RESERVE_WINDOW_NOT_ALLOCATED);
> +}
> +
> +void ext2_init_block_alloc_info(struct inode *inode)
> +{
> +	struct ext2_inode_info *ei = EXT2_I(inode);
> +	struct ext2_block_alloc_info *block_i = ei->i_block_alloc_info;
> +	struct super_block *sb = inode->i_sb;
> +
> +	block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
> +	if (block_i) {
> +		struct ext2_reserve_window_node *rsv = &block_i->rsv_window_node;
> +
> +		rsv->rsv_start = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +		rsv->rsv_end = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +
> +	 	/*
> +		 * if filesystem is mounted with NORESERVATION, the goal
> +		 * reservation window size is set to zero to indicate
> +		 * block reservation is off
> +		 */
> +		if (!test_opt(sb, RESERVATION))
> +			rsv->rsv_goal_size = 0;
> +		else
> +			rsv->rsv_goal_size = EXT2_DEFAULT_RESERVE_BLOCKS;
> +		rsv->rsv_alloc_hit = 0;
> +		block_i->last_alloc_logical_block = 0;
> +		block_i->last_alloc_physical_block = 0;
> +	}
> +	ei->i_block_alloc_info = block_i;
> +}
> +
> +void ext2_discard_reservation(struct inode *inode)
> +{
> +	struct ext2_inode_info *ei = EXT2_I(inode);
> +	struct ext2_block_alloc_info *block_i = ei->i_block_alloc_info;
> +	struct ext2_reserve_window_node *rsv;
> +	spinlock_t *rsv_lock = &EXT2_SB(inode->i_sb)->s_rsv_window_lock;
> +
> +	if (!block_i)
> +		return;
> +
> +	rsv = &block_i->rsv_window_node;
> +	if (!rsv_is_empty(&rsv->rsv_window)) {
> +		spin_lock(rsv_lock);
> +		if (!rsv_is_empty(&rsv->rsv_window))
> +			rsv_window_remove(inode->i_sb, rsv);
> +		spin_unlock(rsv_lock);
> +	}
> +}
> +
>  /* Free given blocks, update quota and i_blocks field */
>  void ext2_free_blocks (struct inode * inode, unsigned long block,
>  		       unsigned long count)
> @@ -245,6 +404,7 @@
>  		}
>  	}
>  
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bitmap_bh);
>  	if (sb->s_flags & MS_SYNCHRONOUS)
>  		sync_dirty_buffer(bitmap_bh);
> @@ -263,16 +423,31 @@
>  	DQUOT_FREE_BLOCK(inode, freed);
>  }
>  
> -static int grab_block(spinlock_t *lock, char *map, unsigned size, int goal)
> +static int
> +bitmap_search_next_usable_block(int start, struct buffer_head *bh,
> +					int maxblocks)
>  {
> -	int k;
> -	char *p, *r;
> +	int next;
>  
> -	if (!ext2_test_bit(goal, map))
> -		goto got_it;
> +	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> +	if (next >= maxblocks)
> +		return -1;
> +	return next;
> +}
>  
> -repeat:
> -	if (goal) {
> +/*
> + * Find an allocatable block in a bitmap.  We perform the "most
> + * appropriate allocation" algorithm of looking for a free block near
> + * the initial goal; then for a free byte somewhere in the bitmap;
> + * then for any free bit in the bitmap.
> + */
> +static int
> +find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
> +{
> +	int here, next;
> +	char *p, *r;
> +
> +	if (start > 0) {
>  		/*
>  		 * The goal was occupied; search forward for a free 
>  		 * block within the next XX blocks.
> @@ -281,244 +456,746 @@
>  		 * less than EXT2_BLOCKS_PER_GROUP. Aligning up to the
>  		 * next 64-bit boundary is simple..
>  		 */
> -		k = (goal + 63) & ~63;
> -		goal = ext2_find_next_zero_bit(map, k, goal);
> -		if (goal < k)
> -			goto got_it;
> +		int end_goal = (start + 63) & ~63;
> +		if (end_goal > maxblocks)
> +			end_goal = maxblocks;
> +		here = ext2_find_next_zero_bit(bh->b_data, end_goal, start);
> +		if (here < end_goal)
> +			return here;
> +		ext2_debug("Bit not found near goal\n");
> +	}
> +
> +	here = start;
> +	if (here < 0)
> +		here = 0;
> +
> +	p = ((char *)bh->b_data) + (here >> 3);
> +	r = memscan(p, 0, (maxblocks - here + 7) >> 3);
> +	next = (r - ((char *)bh->b_data)) << 3;
> +
> +	if (next < maxblocks && next >= here)
> +		return next;
> +
> +	here = bitmap_search_next_usable_block(here, bh, maxblocks);
> +	return here;
> +}
> +
> +/*
> + * If we failed to allocate the desired block then we may end up crossing to a
> + * new bitmap.
> + */
> +static int
> +ext2_try_to_allocate(struct super_block *sb, int group,
> +			struct buffer_head *bitmap_bh, int goal,
> +			unsigned long *count, struct ext2_reserve_window *my_rsv)
> +{
> +	int group_first_block, start, end;
> +	unsigned long num = 0;
> +
> +	/* we do allocation within the reservation window if we have a window */
> +	if (my_rsv) {
> +		group_first_block =
> +			le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
> +			group * EXT2_BLOCKS_PER_GROUP(sb);
> +		if (my_rsv->_rsv_start >= group_first_block)
> +			start = my_rsv->_rsv_start - group_first_block;
> +		else
> +			/* reservation window cross group boundary */
> +			start = 0;
> +		end = my_rsv->_rsv_end - group_first_block + 1;
> +		if (end > EXT2_BLOCKS_PER_GROUP(sb))
> +			/* reservation window crosses group boundary */
> +			end = EXT2_BLOCKS_PER_GROUP(sb);
> +		if ((start <= goal) && (goal < end))
> +			start = goal;
> +		else
> +			goal = -1;
> +	} else {
> +		if (goal > 0)
> +			start = goal;
> +		else
> +			start = 0;
> +		end = EXT2_BLOCKS_PER_GROUP(sb);
> +	}
> +
> +	BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
> +
> +repeat:
> +	if (goal < 0) {
> +		goal = find_next_usable_block(start, bitmap_bh, end);
> +		if (goal < 0)
> +			goto fail_access;
> +		if (!my_rsv) {
> +			int i;
> +
> +			for (i = 0; i < 7 && goal > start &&
> +				     !ext2_test_bit(goal - 1, bitmap_bh->b_data);
> +			     i++, goal--)
> +				;
> +		}
> +	}
> +	start = goal;
> +
> +	if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), goal, bitmap_bh->b_data)) {
> +		/*
> +		 * The block was allocated by another thread, or it was
> +		 * allocated and then freed by another thread
> +		 */
> +		start++;
> +		goal++;
> +		if (start >= end)
> +			goto fail_access;
> +		goto repeat;
> +	}
> +	num++;
> +	goal++;
> +	while (num < *count && goal < end
> +		&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), goal, bitmap_bh->b_data)) {
> +		num++;
> +		goal++;
> +	}
> +	*count = num;
> +	return goal - num;
> +fail_access:
> +	*count = num;
> +	return -1;
> +}
> +
> +/**
> + * 	find_next_reservable_window():
> + *		find a reservable space within the given range.
> + *		It does not allocate the reservation window for now:
> + *		alloc_new_reservation() will do the work later.
> + *
> + * 	@search_head: the head of the searching list;
> + *		This is not necessarily the list head of the whole filesystem
> + *
> + *		We have both head and start_block to assist the search
> + *		for the reservable space. The list starts from head,
> + *		but we will shift to the place where start_block is,
> + *		then start from there, when looking for a reservable space.
> + *
> + * 	@size: the target new reservation window size
> + *
> + * 	@group_first_block: the first block we consider to start
> + *			the real search from
> + *
> + * 	@last_block:
> + *		the maximum block number that our goal reservable space
> + *		could start from. This is normally the last block in this
> + *		group. The search will end when we found the start of next
> + *		possible reservable space is out of this boundary.
> + *		This could handle the cross boundary reservation window
> + *		request.
> + *
> + * 	basically we search from the given range, rather than the whole
> + * 	reservation double linked list, (start_block, last_block)
> + * 	to find a free region that is of my size and has not
> + * 	been reserved.
> + *
> + */
> +static int find_next_reservable_window(
> +				struct ext2_reserve_window_node *search_head,
> +				struct ext2_reserve_window_node *my_rsv,
> +				struct super_block * sb, int start_block,
> +				int last_block)
> +{
> +	struct rb_node *next;
> +	struct ext2_reserve_window_node *rsv, *prev;
> +	int cur;
> +	int size = my_rsv->rsv_goal_size;
> +
> +	/* TODO: make the start of the reservation window byte-aligned */
> +	/* cur = *start_block & ~7;*/
> +	cur = start_block;
> +	rsv = search_head;
> +	if (!rsv)
> +		return -1;
> +
> +	while (1) {
> +		if (cur <= rsv->rsv_end)
> +			cur = rsv->rsv_end + 1;
> +
> +		/* TODO?
> +		 * in the case we could not find a reservable space
> +		 * that is what is expected, during the re-search, we could
> +		 * remember what's the largest reservable space we could have
> +		 * and return that one.
> +		 *
> +		 * For now it will fail if we could not find the reservable
> +		 * space with expected-size (or more)...
> +		 */
> +		if (cur > last_block)
> +			return -1;		/* fail */
> +
> +		prev = rsv;
> +		next = rb_next(&rsv->rsv_node);
> +		rsv = list_entry(next,struct ext2_reserve_window_node,rsv_node);
> +
> +		/*
> +		 * Reached the last reservation, we can just append to the
> +		 * previous one.
> +		 */
> +		if (!next)
> +			break;
> +
> +		if (cur + size <= rsv->rsv_start) {
> +			/*
> +			 * Found a reserveable space big enough.  We could
> +			 * have a reservation across the group boundary here
> +		 	 */
> +			break;
> +		}
> +	}
> +	/*
> +	 * we come here either :
> +	 * when we reach the end of the whole list,
> +	 * and there is empty reservable space after last entry in the list.
> +	 * append it to the end of the list.
> +	 *
> +	 * or we found one reservable space in the middle of the list,
> +	 * return the reservation window that we could append to.
> +	 * succeed.
> +	 */
> +
> +	if ((prev != my_rsv) && (!rsv_is_empty(&my_rsv->rsv_window)))
> +		rsv_window_remove(sb, my_rsv);
> +
> +	/*
> +	 * Let's book the whole avaliable window for now.  We will check the
> +	 * disk bitmap later and then, if there are free blocks then we adjust
> +	 * the window size if it's larger than requested.
> +	 * Otherwise, we will remove this node from the tree next time
> +	 * call find_next_reservable_window.
> +	 */
> +	my_rsv->rsv_start = cur;
> +	my_rsv->rsv_end = cur + size - 1;
> +	my_rsv->rsv_alloc_hit = 0;
> +
> +	if (prev != my_rsv)
> +		ext2_rsv_window_add(sb, my_rsv);
> +
> +	return 0;
> +}
> +
> +/**
> + * 	alloc_new_reservation()--allocate a new reservation window
> + *
> + *		To make a new reservation, we search part of the filesystem
> + *		reservation list (the list that inside the group). We try to
> + *		allocate a new reservation window near the allocation goal,
> + *		or the beginning of the group, if there is no goal.
> + *
> + *		We first find a reservable space after the goal, then from
> + *		there, we check the bitmap for the first free block after
> + *		it. If there is no free block until the end of group, then the
> + *		whole group is full, we failed. Otherwise, check if the free
> + *		block is inside the expected reservable space, if so, we
> + *		succeed.
> + *		If the first free block is outside the reservable space, then
> + *		start from the first free block, we search for next available
> + *		space, and go on.
> + *
> + *	on succeed, a new reservation will be found and inserted into the list
> + *	It contains at least one free block, and it does not overlap with other
> + *	reservation windows.
> + *
> + *	failed: we failed to find a reservation window in this group
> + *
> + *	@rsv: the reservation
> + *
> + *	@goal: The goal (group-relative).  It is where the search for a
> + *		free reservable space should start from.
> + *		if we have a goal(goal >0 ), then start from there,
> + *		no goal(goal = -1), we start from the first block
> + *		of the group.
> + *
> + *	@sb: the super block
> + *	@group: the group we are trying to allocate in
> + *	@bitmap_bh: the block group block bitmap
> + *
> + */
> +static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
> +		int goal, struct super_block *sb,
> +		unsigned int group, struct buffer_head *bitmap_bh)
> +{
> +	struct ext2_reserve_window_node *search_head;
> +	int group_first_block, group_end_block, start_block;
> +	int first_free_block;
> +	struct rb_root *fs_rsv_root = &EXT2_SB(sb)->s_rsv_window_root;
> +	unsigned long size;
> +	int ret;
> +	spinlock_t *rsv_lock = &EXT2_SB(sb)->s_rsv_window_lock;
> +
> +	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
> +				group * EXT2_BLOCKS_PER_GROUP(sb);
> +	group_end_block = group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
> +
> +	if (goal < 0)
> +		start_block = group_first_block;
> +	else
> +		start_block = goal + group_first_block;
> +
> +	size = my_rsv->rsv_goal_size;
> +
> +	if (!rsv_is_empty(&my_rsv->rsv_window)) {
>  		/*
> -		 * Search in the remainder of the current group.
> +		 * if the old reservation is cross group boundary
> +		 * and if the goal is inside the old reservation window,
> +		 * we will come here when we just failed to allocate from
> +		 * the first part of the window. We still have another part
> +		 * that belongs to the next group. In this case, there is no
> +		 * point to discard our window and try to allocate a new one
> +		 * in this group(which will fail). we should
> +		 * keep the reservation window, just simply move on.
> +		 *
> +		 * Maybe we could shift the start block of the reservation
> +		 * window to the first block of next group.
>  		 */
> +
> +		if ((my_rsv->rsv_start <= group_end_block) &&
> +				(my_rsv->rsv_end > group_end_block) &&
> +				(start_block >= my_rsv->rsv_start))
> +			return -1;
> +
> +		if ((my_rsv->rsv_alloc_hit >
> +		     (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
> +			/*
> +			 * if we previously allocation hit ration is greater than half
> +			 * we double the size of reservation window next time
> +			 * otherwise keep the same
> +			 */
> +			size = size * 2;
> +			if (size > EXT2_MAX_RESERVE_BLOCKS)
> +				size = EXT2_MAX_RESERVE_BLOCKS;
> +			my_rsv->rsv_goal_size= size;
> +		}
> +	}
> +
> +	spin_lock(rsv_lock);
> +	/*
> +	 * shift the search start to the window near the goal block
> +	 */
> +	search_head = search_reserve_window(fs_rsv_root, start_block);
> +
> +	/*
> +	 * find_next_reservable_window() simply finds a reservable window
> +	 * inside the given range(start_block, group_end_block).
> +	 *
> +	 * To make sure the reservation window has a free bit inside it, we
> +	 * need to check the bitmap after we found a reservable window.
> +	 */
> +retry:
> +	ret = find_next_reservable_window(search_head, my_rsv, sb,
> +						start_block, group_end_block);
> +
> +	if (ret == -1) {
> +		if (!rsv_is_empty(&my_rsv->rsv_window))
> +			rsv_window_remove(sb, my_rsv);
> +		spin_unlock(rsv_lock);
> +		return -1;
>  	}
>  
> -	p = map + (goal >> 3);
> -	r = memscan(p, 0, (size - goal + 7) >> 3);
> -	k = (r - map) << 3;
> -	if (k < size) {
> -		/* 
> -		 * We have succeeded in finding a free byte in the block
> -		 * bitmap.  Now search backwards to find the start of this
> -		 * group of free blocks - won't take more than 7 iterations.
> +	/*
> +	 * On success, find_next_reservable_window() returns the
> +	 * reservation window where there is a reservable space after it.
> +	 * Before we reserve this reservable space, we need
> +	 * to make sure there is at least a free block inside this region.
> +	 *
> +	 * searching the first free bit on the block bitmap and copy of
> +	 * last committed bitmap alternatively, until we found a allocatable
> +	 * block. Search start from the start block of the reservable space
> +	 * we just found.
> +	 */
> +	spin_unlock(rsv_lock);
> +	first_free_block = bitmap_search_next_usable_block(
> +			my_rsv->rsv_start - group_first_block,
> +			bitmap_bh, group_end_block - group_first_block + 1);
> +
> +	if (first_free_block < 0) {
> +		/*
> +		 * no free block left on the bitmap, no point
> +		 * to reserve the space. return failed.
>  		 */
> -		for (goal = k; goal && !ext2_test_bit (goal - 1, map); goal--)
> -			;
> -		goto got_it;
> +		spin_lock(rsv_lock);
> +		if (!rsv_is_empty(&my_rsv->rsv_window))
> +			rsv_window_remove(sb, my_rsv);
> +		spin_unlock(rsv_lock);
> +		return -1;		/* failed */
>  	}
>  
> -	k = ext2_find_next_zero_bit ((u32 *)map, size, goal);
> -	if (k < size) {
> -		goal = k;
> -		goto got_it;
> +	start_block = first_free_block + group_first_block;
> +	/*
> +	 * check if the first free block is within the
> +	 * free space we just reserved
> +	 */
> +	if (start_block >= my_rsv->rsv_start && start_block < my_rsv->rsv_end)
> +		return 0;		/* success */
> +	/*
> +	 * if the first free bit we found is out of the reservable space
> +	 * continue search for next reservable space,
> +	 * start from where the free block is,
> +	 * we also shift the list head to where we stopped last time
> +	 */
> +	search_head = my_rsv;
> +	spin_lock(rsv_lock);
> +	goto retry;
> +}
> +
> +static void try_to_extend_reservation(struct ext2_reserve_window_node *my_rsv,
> +			struct super_block *sb, int size)
> +{
> +	struct ext2_reserve_window_node *next_rsv;
> +	struct rb_node *next;
> +	spinlock_t *rsv_lock = &EXT2_SB(sb)->s_rsv_window_lock;
> +
> +	printk("req. rsv size %d\n", size);
> +
> +	if (!spin_trylock(rsv_lock))
> +		return;
> +
> +	next = rb_next(&my_rsv->rsv_node);
> +
> +	if (!next)
> +		my_rsv->rsv_end += size;
> +	else {
> +		next_rsv = list_entry(next, struct ext2_reserve_window_node, rsv_node);
> +
> +		if ((next_rsv->rsv_start - my_rsv->rsv_end - 1) >= size)
> +			my_rsv->rsv_end += size;
> +		else
> +			my_rsv->rsv_end = next_rsv->rsv_start - 1;
>  	}
> -	return -1;
> -got_it:
> -	if (ext2_set_bit_atomic(lock, goal, (void *) map)) 
> -		goto repeat;	
> -	return goal;
> +	spin_unlock(rsv_lock);
>  }
>  
>  /*
> - * ext2_new_block uses a goal block to assist allocation.  If the goal is
> + * This is the main function used to allocate a new block and its reservation
> + * window.
> + *
> + * Each time when a new block allocation is need, first try to allocate from
> + * its own reservation.  If it does not have a reservation window, instead of
> + * looking for a free bit on bitmap first, then look up the reservation list to
> + * see if it is inside somebody else's reservation window, we try to allocate a
> + * reservation window for it starting from the goal first. Then do the block
> + * allocation within the reservation window.
> + *
> + * This will avoid keeping on searching the reservation list again and
> + * again when somebody is looking for a free block (without
> + * reservation), and there are lots of free blocks, but they are all
> + * being reserved.
> + *
> + * We use a sorted double linked list for the per-filesystem reservation list.
> + * The insert, remove and find a free space(non-reserved) operations for the
> + * sorted double linked list should be fast.
> + *
> + */
> +static int
> +ext2_try_to_allocate_with_rsv(struct super_block *sb, 
> +			unsigned int group, struct buffer_head *bitmap_bh,
> +			int goal, struct ext2_reserve_window_node * my_rsv,
> +			unsigned long *count)
> +{
> +	unsigned long group_first_block;
> +	int ret = 0;
> +	unsigned long num = *count;
> +
> +	/*
> +	 * we don't deal with reservation when
> +	 * filesystem is mounted without reservation
> +	 * or the file is not a regular file
> +	 * or last attempt to allocate a block with reservation turned on failed
> +	 */
> +	if (my_rsv == NULL ) {
> +		return ext2_try_to_allocate(sb, group, bitmap_bh,
> +						goal, count, NULL);
> +	}
> +	/*
> +	 * goal is a group relative block number (if there is a goal)
> +	 * 0 < goal < EXT2_BLOCKS_PER_GROUP(sb)
> +	 * first block is a filesystem wide block number
> +	 * first block is the block number of the first block in this group
> +	 */
> +	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
> +			group * EXT2_BLOCKS_PER_GROUP(sb);
> +
> +	/*
> +	 * Basically we will allocate a new block from inode's reservation
> +	 * window.
> +	 *
> +	 * We need to allocate a new reservation window, if:
> +	 * a) inode does not have a reservation window; or
> +	 * b) last attempt to allocate a block from existing reservation
> +	 *    failed; or
> +	 * c) we come here with a goal and with a reservation window
> +	 *
> +	 * We do not need to allocate a new reservation window if we come here
> +	 * at the beginning with a goal and the goal is inside the window, or
> +	 * we don't have a goal but already have a reservation window.
> +	 * then we could go to allocate from the reservation window directly.
> +	 */
> +	while (1) {
> +		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
> +			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
> +			if (my_rsv->rsv_goal_size < *count)
> +				my_rsv->rsv_goal_size = *count;
> +			ret = alloc_new_reservation(my_rsv, goal, sb,
> +							group, bitmap_bh);
> +			if (ret < 0)
> +				break;			/* failed */
> +
> +			if (!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb))
> +				goal = -1;
> +		} else if (goal > 0 && (my_rsv->rsv_end-goal+1) < *count)
> +			try_to_extend_reservation(my_rsv, sb,
> +					*count-my_rsv->rsv_end + goal - 1);
> +
> +		if ((my_rsv->rsv_start >= group_first_block + EXT2_BLOCKS_PER_GROUP(sb))
> +		    || (my_rsv->rsv_end < group_first_block))
> +			BUG();
> +		ret = ext2_try_to_allocate(sb, group, bitmap_bh, goal,
> +					   &num, &my_rsv->rsv_window);
> +		if (ret >= 0) {
> +			my_rsv->rsv_alloc_hit += num;
> +			*count = num;
> +			break;				/* succeed */
> +		}
> +		num = *count;
> +	}
> +	return ret;
> +}
> +
> +static int ext2_has_free_blocks(struct ext2_sb_info *sbi)
> +{
> +	int free_blocks, root_blocks;
> +
> +	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
> +	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
> +	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
> +		sbi->s_resuid != current->fsuid &&
> +		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +/*
> + * ext2_new_blocks uses a goal block to assist allocation.  If the goal is
>   * free, or there is a free block within 32 blocks of the goal, that block
>   * is allocated.  Otherwise a forward search is made for a free block; within 
>   * each block group the search first looks for an entire free byte in the block
>   * bitmap, and then for any free bit if that fails.
>   * This function also updates quota and i_blocks field.
>   */
> -int ext2_new_block(struct inode *inode, unsigned long goal,
> -			u32 *prealloc_count, u32 *prealloc_block, int *err)
> +int ext2_new_blocks(struct inode *inode, unsigned long goal,
> +		    unsigned long *count, int *errp)
>  {
>  	struct buffer_head *bitmap_bh = NULL;
> -	struct buffer_head *gdp_bh;	/* bh2 */
> -	struct ext2_group_desc *desc;
> -	int group_no;			/* i */
> -	int ret_block;			/* j */
> -	int group_idx;			/* k */
> -	int target_block;		/* tmp */
> -	int block = 0;
> -	struct super_block *sb = inode->i_sb;
> -	struct ext2_sb_info *sbi = EXT2_SB(sb);
> -	struct ext2_super_block *es = sbi->s_es;
> -	unsigned group_size = EXT2_BLOCKS_PER_GROUP(sb);
> -	unsigned prealloc_goal = es->s_prealloc_blocks;
> -	unsigned group_alloc = 0, es_alloc, dq_alloc;
> -	int nr_scanned_groups;
> -
> -	if (!prealloc_goal--)
> -		prealloc_goal = EXT2_DEFAULT_PREALLOC_BLOCKS - 1;
> -	if (!prealloc_count || *prealloc_count)
> -		prealloc_goal = 0;
> -
> -	if (DQUOT_ALLOC_BLOCK(inode, 1)) {
> -		*err = -EDQUOT;
> -		goto out;
> +	struct buffer_head *gdp_bh;
> +	int group_no;
> +	int goal_group;
> +	int ret_block;
> +	int bgi;			/* blockgroup iteration index */
> +	int target_block;
> +	int performed_allocation = 0;
> +	int free_blocks;
> +	struct super_block *sb;
> +	struct ext2_group_desc *gdp;
> +	struct ext2_super_block *es;
> +	struct ext2_sb_info *sbi;
> +	struct ext2_reserve_window_node *my_rsv = NULL;
> +	struct ext2_block_alloc_info *block_i;
> +	unsigned short windowsz = 0;
> +	unsigned long ngroups;
> +	unsigned long num = *count;
> +
> +	*errp = -ENOSPC;
> +	sb = inode->i_sb;
> +	if (!sb) {
> +		printk("ext2_new_blocks: nonexistent device");
> +		return 0;
>  	}
>  
> -	while (prealloc_goal && DQUOT_PREALLOC_BLOCK(inode, prealloc_goal))
> -		prealloc_goal--;
> +	/*
> +	 * Check quota for allocation of this block.
> +	 */
> +	if (DQUOT_ALLOC_BLOCK(inode, num)) {
> +		*errp = -EDQUOT;
> +		return 0;
> +	}
>  
> -	dq_alloc = prealloc_goal + 1;
> -	es_alloc = reserve_blocks(sb, dq_alloc);
> -	if (!es_alloc) {
> -		*err = -ENOSPC;
> -		goto out_dquot;
> +	sbi = EXT2_SB(sb);
> +	es = EXT2_SB(sb)->s_es;
> +	ext2_debug("goal=%lu.\n", goal);
> +	/*
> +	 * Allocate a block from reservation only when
> +	 * filesystem is mounted with reservation(default,-o reservation), and
> +	 * it's a regular file, and
> +	 * the desired window size is greater than 0 (One could use ioctl
> +	 * command EXT2_IOC_SETRSVSZ to set the window size to 0 to turn off
> +	 * reservation on that particular file)
> +	 */
> +	block_i = EXT2_I(inode)->i_block_alloc_info;
> +	if (block_i && ((windowsz = block_i->rsv_window_node.rsv_goal_size) > 0)) {
> +		my_rsv = &block_i->rsv_window_node;
>  	}
>  
> -	ext2_debug ("goal=%lu.\n", goal);
> +	if (!ext2_has_free_blocks(sbi)) {
> +		*errp = -ENOSPC;
> +		goto out;
> +	}
>  
> +	/*
> +	 * First, test whether the goal block is free.
> +	 */
>  	if (goal < le32_to_cpu(es->s_first_data_block) ||
>  	    goal >= le32_to_cpu(es->s_blocks_count))
>  		goal = le32_to_cpu(es->s_first_data_block);
> -	group_no = (goal - le32_to_cpu(es->s_first_data_block)) / group_size;
> -	desc = ext2_get_group_desc (sb, group_no, &gdp_bh);
> -	if (!desc) {
> -		/*
> -		 * gdp_bh may still be uninitialised.  But group_release_blocks
> -		 * will not touch it because group_alloc is zero.
> -		 */
> +	group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
> +			EXT2_BLOCKS_PER_GROUP(sb);
> +	gdp = ext2_get_group_desc(sb, group_no, &gdp_bh);
> +	if (!gdp)
>  		goto io_error;
> -	}
>  
> -	group_alloc = group_reserve_blocks(sbi, group_no, desc,
> -					gdp_bh, es_alloc);
> -	if (group_alloc) {
> +	goal_group = group_no;
> +retry:
> +	free_blocks = le16_to_cpu(gdp->bg_free_blocks_count);
> +	/*
> +	 * if there is not enough free blocks to make a new resevation
> +	 * turn off reservation for this allocation
> +	 */
> +	if (my_rsv && (free_blocks < windowsz)
> +		&& (rsv_is_empty(&my_rsv->rsv_window)))
> +		my_rsv = NULL;
> +
> +	if (free_blocks > 0) {
>  		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
> -					group_size);
> -		brelse(bitmap_bh);
> +				EXT2_BLOCKS_PER_GROUP(sb));
>  		bitmap_bh = read_block_bitmap(sb, group_no);
>  		if (!bitmap_bh)
>  			goto io_error;
> -		
> -		ext2_debug("goal is at %d:%d.\n", group_no, ret_block);
> -
> -		ret_block = grab_block(sb_bgl_lock(sbi, group_no),
> -				bitmap_bh->b_data, group_size, ret_block);
> +		ret_block = ext2_try_to_allocate_with_rsv(sb, group_no,
> +					bitmap_bh, ret_block, my_rsv, &num);
>  		if (ret_block >= 0)
> -			goto got_block;
> -		group_release_blocks(sb, group_no, desc, gdp_bh, group_alloc);
> -		group_alloc = 0;
> +			goto allocated;
>  	}
>  
> -	ext2_debug ("Bit not found in block group %d.\n", group_no);
> +	ngroups = EXT2_SB(sb)->s_groups_count;
> +	smp_rmb();
>  
>  	/*
>  	 * Now search the rest of the groups.  We assume that 
> -	 * i and desc correctly point to the last group visited.
> +	 * i and gdp correctly point to the last group visited.
>  	 */
> -	nr_scanned_groups = 0;
> -retry:
> -	for (group_idx = 0; !group_alloc &&
> -			group_idx < sbi->s_groups_count; group_idx++) {
> +	for (bgi = 0; bgi < ngroups; bgi++) {
>  		group_no++;
> -		if (group_no >= sbi->s_groups_count)
> +		if (group_no >= ngroups)
>  			group_no = 0;
> -		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
> -		if (!desc)
> -			goto io_error;
> -		group_alloc = group_reserve_blocks(sbi, group_no, desc,
> -						gdp_bh, es_alloc);
> -	}
> -	if (!group_alloc) {
> -		*err = -ENOSPC;
> -		goto out_release;
> -	}
> -	brelse(bitmap_bh);
> -	bitmap_bh = read_block_bitmap(sb, group_no);
> -	if (!bitmap_bh)
> -		goto io_error;
> -
> -	ret_block = grab_block(sb_bgl_lock(sbi, group_no), bitmap_bh->b_data,
> -				group_size, 0);
> -	if (ret_block < 0) {
> -		/*
> -		 * If a free block counter is corrupted we can loop inifintely.
> -		 * Detect that here.
> -		 */
> -		nr_scanned_groups++;
> -		if (nr_scanned_groups > 2 * sbi->s_groups_count) {
> -			ext2_error(sb, "ext2_new_block",
> -				"corrupted free blocks counters");
> -			goto io_error;
> +		gdp = ext2_get_group_desc(sb, group_no, &gdp_bh);
> +		if (!gdp) {
> +			*errp = -EIO;
> +			goto out;
>  		}
> +		free_blocks = le16_to_cpu(gdp->bg_free_blocks_count);
>  		/*
> -		 * Someone else grabbed the last free block in this blockgroup
> -		 * before us.  Retry the scan.
> +		 * skip this group if the number of
> +		 * free blocks is less than half of the reservation
> +		 * window size.
>  		 */
> -		group_release_blocks(sb, group_no, desc, gdp_bh, group_alloc);
> -		group_alloc = 0;
> +		if (free_blocks <= (windowsz/2))
> +			continue;
> +
> +		brelse(bitmap_bh);
> +		bitmap_bh = read_block_bitmap(sb, group_no);
> +		if (!bitmap_bh)
> +			goto io_error;
> +		ret_block = ext2_try_to_allocate_with_rsv(sb, group_no,
> +					bitmap_bh, -1, my_rsv, &num);
> +		if (ret_block >= 0) 
> +			goto allocated;
> +	}
> +	/*
> +	 * We may end up a bogus ealier ENOSPC error due to
> +	 * filesystem is "full" of reservations, but
> +	 * there maybe indeed free blocks avaliable on disk
> +	 * In this case, we just forget about the reservations
> +	 * just do block allocation as without reservations.
> +	 */
> +	if (my_rsv) {
> +		my_rsv = NULL;
> +		group_no = goal_group;
>  		goto retry;
>  	}
> +	/* No space left on the device */
> +	*errp = -ENOSPC;
> +	goto out;
> +
> +allocated:
>  
> -got_block:
>  	ext2_debug("using block group %d(%d)\n",
> -		group_no, desc->bg_free_blocks_count);
> +			group_no, gdp->bg_free_blocks_count);
>  
> -	target_block = ret_block + group_no * group_size +
> -			le32_to_cpu(es->s_first_data_block);
> +	target_block = ret_block + group_no * EXT2_BLOCKS_PER_GROUP(sb)
> +				+ le32_to_cpu(es->s_first_data_block);
>  
> -	if (target_block == le32_to_cpu(desc->bg_block_bitmap) ||
> -	    target_block == le32_to_cpu(desc->bg_inode_bitmap) ||
> -	    in_range(target_block, le32_to_cpu(desc->bg_inode_table),
> -		      sbi->s_itb_per_group))
> -		ext2_error (sb, "ext2_new_block",
> +	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), target_block, num) ||
> +	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), target_block, num) ||
> +	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
> +		      EXT2_SB(sb)->s_itb_per_group) ||
> +	    in_range(target_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
> +		      EXT2_SB(sb)->s_itb_per_group))
> +		ext2_error(sb, "ext2_new_blocks",
>  			    "Allocating block in system zone - "
> -			    "block = %u", target_block);
> +			    "blocks from %u, length %lu", target_block, num);
> +
> +	performed_allocation = 1;
>  
> -	if (target_block >= le32_to_cpu(es->s_blocks_count)) {
> -		ext2_error (sb, "ext2_new_block",
> +
> +	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
> +	ret_block = target_block;
> +
> +	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
> +		ext2_error(sb, "ext2_new_blocks",
>  			    "block(%d) >= blocks count(%d) - "
>  			    "block_group = %d, es == %p ", ret_block,
>  			le32_to_cpu(es->s_blocks_count), group_no, es);
> -		goto io_error;
> +		goto out;
>  	}
> -	block = target_block;
>  
> -	/* OK, we _had_ allocated something */
> -	ext2_debug("found bit %d\n", ret_block);
> -
> -	dq_alloc--;
> -	es_alloc--;
> -	group_alloc--;
> -
> -	/*
> -	 * Do block preallocation now if required.
> -	 */
> -	write_lock(&EXT2_I(inode)->i_meta_lock);
> -	if (group_alloc && !*prealloc_count) {
> -		unsigned n;
> -
> -		for (n = 0; n < group_alloc && ++ret_block < group_size; n++) {
> -			if (ext2_set_bit_atomic(sb_bgl_lock(sbi, group_no),
> -						ret_block,
> -						(void*) bitmap_bh->b_data))
> - 				break;
> -		}
> -		*prealloc_block = block + 1;
> -		*prealloc_count = n;
> -		es_alloc -= n;
> -		dq_alloc -= n;
> -		group_alloc -= n;
> -	}
> -	write_unlock(&EXT2_I(inode)->i_meta_lock);
> +	spin_lock(sb_bgl_lock(sbi, group_no));
> +	gdp->bg_free_blocks_count =
> +			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - num);
> +	spin_unlock(sb_bgl_lock(sbi, group_no));
> +	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
>  
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bitmap_bh);
>  	if (sb->s_flags & MS_SYNCHRONOUS)
>  		sync_dirty_buffer(bitmap_bh);
>  
> -	ext2_debug ("allocating block %d. ", block);
> +	*errp = 0;
> +	brelse(bitmap_bh);
> +	DQUOT_FREE_BLOCK(inode, *count-num);
> +	*count = num;
> +	return ret_block;
>  
> -	*err = 0;
> -out_release:
> -	group_release_blocks(sb, group_no, desc, gdp_bh, group_alloc);
> -	release_blocks(sb, es_alloc);
> -out_dquot:
> -	DQUOT_FREE_BLOCK(inode, dq_alloc);
> +io_error:
> +	*errp = -EIO;
>  out:
> +	/*
> +	 * Undo the block allocation
> +	 */
> +	if (!performed_allocation)
> +		DQUOT_FREE_BLOCK(inode, *count);
>  	brelse(bitmap_bh);
> -	return block;
> +	return 0;
> +}
>  
> -io_error:
> -	*err = -EIO;
> -	goto out_release;
> +int ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
> +{
> +	unsigned long count = 1;
> +
> +	return ext2_new_blocks(inode, goal, &count, errp);
>  }
>  
>  unsigned long ext2_count_free_blocks (struct super_block * sb)
> diff -x '*~' -uNr vanilla-linux/fs/ext2/dir.c uml-clean/fs/ext2/dir.c
> --- vanilla-linux/fs/ext2/dir.c	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/dir.c	2006-03-08 16:21:30.000000000 -0800
> @@ -67,6 +67,7 @@
>  	struct inode *dir = page->mapping->host;
>  	int err = 0;
>  	dir->i_version++;
> +	ext2_mark_fs_dirty(dir->i_sb);
>  	page->mapping->a_ops->commit_write(NULL, page, from, to);
>  	if (IS_DIRSYNC(dir))
>  		err = write_one_page(page, 1);
> diff -x '*~' -uNr vanilla-linux/fs/ext2/ext2.h uml-clean/fs/ext2/ext2.h
> --- vanilla-linux/fs/ext2/ext2.h	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/ext2.h	2006-03-24 04:06:12.000000000 -0800
> @@ -33,22 +33,9 @@
>  	 */
>  	__u32	i_block_group;
>  
> -	/*
> -	 * i_next_alloc_block is the logical (file-relative) number of the
> -	 * most-recently-allocated block in this file.  Yes, it is misnamed.
> -	 * We use this for detecting linearly ascending allocation requests.
> -	 */
> -	__u32	i_next_alloc_block;
> +	/* block reservation info */
> +	struct ext2_block_alloc_info *i_block_alloc_info;
>  
> -	/*
> -	 * i_next_alloc_goal is the *physical* companion to i_next_alloc_block.
> -	 * it the the physical block number of the block which was most-recently
> -	 * allocated to this file.  This give us the goal (target) for the next
> -	 * allocation when we detect linearly ascending requests.
> -	 */
> -	__u32	i_next_alloc_goal;
> -	__u32	i_prealloc_block;
> -	__u32	i_prealloc_count;
>  	__u32	i_dir_start_lookup;
>  #ifdef CONFIG_EXT2_FS_XATTR
>  	/*
> @@ -66,6 +53,7 @@
>  #endif
>  	rwlock_t i_meta_lock;
>  	struct inode	vfs_inode;
> +	struct list_head i_orphan;	/* unlinked but open inodes */
>  };
>  
>  /*
> @@ -91,8 +79,8 @@
>  /* balloc.c */
>  extern int ext2_bg_has_super(struct super_block *sb, int group);
>  extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
> -extern int ext2_new_block (struct inode *, unsigned long,
> -			   __u32 *, __u32 *, int *);
> +extern int ext2_new_block (struct inode *, unsigned long, int *);
> +extern int ext2_new_blocks (struct inode *, unsigned long, unsigned long *, int *);
>  extern void ext2_free_blocks (struct inode *, unsigned long,
>  			      unsigned long);
>  extern unsigned long ext2_count_free_blocks (struct super_block *);
> @@ -101,6 +89,10 @@
>  extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
>  						    unsigned int block_group,
>  						    struct buffer_head ** bh);
> +extern void ext2_discard_reservation (struct inode *);
> +extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
> +extern void ext2_init_block_alloc_info(struct inode *);
> +extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
>  
>  /* dir.c */
>  extern int ext2_add_link (struct dentry *, struct inode *);
> @@ -128,7 +120,6 @@
>  extern void ext2_put_inode (struct inode *);
>  extern void ext2_delete_inode (struct inode *);
>  extern int ext2_sync_inode (struct inode *);
> -extern void ext2_discard_prealloc (struct inode *);
>  extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
>  extern void ext2_truncate (struct inode *);
>  extern int ext2_setattr (struct dentry *, struct iattr *);
> @@ -148,6 +139,14 @@
>  	__attribute__ ((format (printf, 3, 4)));
>  extern void ext2_update_dynamic_rev (struct super_block *sb);
>  extern void ext2_write_super (struct super_block *);
> +extern void ext2_prepare_super (struct super_block *);
> +extern void __ext2_mark_fs_clean (struct super_block *);
> +extern void ext2_mark_fs_dirty (struct super_block *);
> +extern void ext2_mark_inode_dirty (struct inode *);
> +extern void ext2_orphan_add(struct inode *);
> +extern void ext2_orphan_del(struct inode *);
> +/* XXX Gross */
> +#define mark_inode_dirty(x) ext2_mark_inode_dirty(x)
>  
>  /*
>   * Inodes and files operations
> @@ -173,3 +172,6 @@
>  /* symlink.c */
>  extern struct inode_operations ext2_fast_symlink_inode_operations;
>  extern struct inode_operations ext2_symlink_inode_operations;
> +
> +/* state.c */
> +extern int ext2_dirtyd(void *);
> diff -x '*~' -uNr vanilla-linux/fs/ext2/file.c uml-clean/fs/ext2/file.c
> --- vanilla-linux/fs/ext2/file.c	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/file.c	2006-03-22 01:44:56.000000000 -0800
> @@ -31,7 +31,7 @@
>  static int ext2_release_file (struct inode * inode, struct file * filp)
>  {
>  	if (filp->f_mode & FMODE_WRITE)
> -		ext2_discard_prealloc (inode);
> +		ext2_discard_reservation (inode);
>  	return 0;
>  }
>  
> diff -x '*~' -uNr vanilla-linux/fs/ext2/ialloc.c uml-clean/fs/ext2/ialloc.c
> --- vanilla-linux/fs/ext2/ialloc.c	2006-03-24 01:47:33.000000000 -0800
> +++ uml-clean/fs/ext2/ialloc.c	2006-03-24 04:45:43.000000000 -0800
> @@ -85,6 +85,7 @@
>  	if (dir)
>  		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
>  	sb->s_dirt = 1;
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bh);
>  }
>  
> @@ -154,6 +155,7 @@
>  			      "bit already cleared for inode %lu", ino);
>  	else
>  		ext2_release_inode(sb, block_group, is_directory);
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bitmap_bh);
>  	if (sb->s_flags & MS_SYNCHRONOUS)
>  		sync_dirty_buffer(bitmap_bh);
> @@ -528,6 +530,7 @@
>  	err = -ENOSPC;
>  	goto fail;
>  got:
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bitmap_bh);
>  	if (sb->s_flags & MS_SYNCHRONOUS)
>  		sync_dirty_buffer(bitmap_bh);
> @@ -562,6 +565,7 @@
>  	spin_unlock(sb_bgl_lock(sbi, group));
>  
>  	sb->s_dirt = 1;
> +	ext2_mark_fs_dirty(sb);
>  	mark_buffer_dirty(bh2);
>  	inode->i_uid = current->fsuid;
>  	if (test_opt (sb, GRPID))
> @@ -591,11 +595,8 @@
>  	ei->i_file_acl = 0;
>  	ei->i_dir_acl = 0;
>  	ei->i_dtime = 0;
> +	ei->i_block_alloc_info = NULL;
>  	ei->i_block_group = group;
> -	ei->i_next_alloc_block = 0;
> -	ei->i_next_alloc_goal = 0;
> -	ei->i_prealloc_block = 0;
> -	ei->i_prealloc_count = 0;
>  	ei->i_dir_start_lookup = 0;
>  	ei->i_state = EXT2_STATE_NEW;
>  	ext2_set_inode_flags(inode);
> diff -x '*~' -uNr vanilla-linux/fs/ext2/inode.c uml-clean/fs/ext2/inode.c
> --- vanilla-linux/fs/ext2/inode.c	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/inode.c	2006-03-24 04:47:34.000000000 -0800
> @@ -54,19 +54,6 @@
>  }
>  
>  /*
> - * Called at each iput().
> - *
> - * The inode may be "bad" if ext2_read_inode() saw an error from
> - * ext2_get_inode(), so we need to check that to avoid freeing random disk
> - * blocks.
> - */
> -void ext2_put_inode(struct inode *inode)
> -{
> -	if (!is_bad_inode(inode))
> -		ext2_discard_prealloc(inode);
> -}
> -
> -/*
>   * Called at the last iput() if i_nlink is zero.
>   */
>  void ext2_delete_inode (struct inode * inode)
> @@ -75,6 +62,7 @@
>  
>  	if (is_bad_inode(inode))
>  		goto no_delete;
> +	ext2_orphan_del(inode);
>  	EXT2_I(inode)->i_dtime	= get_seconds();
>  	mark_inode_dirty(inode);
>  	ext2_update_inode(inode, inode_needs_sync(inode));
> @@ -89,61 +77,6 @@
>  	clear_inode(inode);	/* We must guarantee clearing of inode... */
>  }
>  
> -void ext2_discard_prealloc (struct inode * inode)
> -{
> -#ifdef EXT2_PREALLOCATE
> -	struct ext2_inode_info *ei = EXT2_I(inode);
> -	write_lock(&ei->i_meta_lock);
> -	if (ei->i_prealloc_count) {
> -		unsigned short total = ei->i_prealloc_count;
> -		unsigned long block = ei->i_prealloc_block;
> -		ei->i_prealloc_count = 0;
> -		ei->i_prealloc_block = 0;
> -		write_unlock(&ei->i_meta_lock);
> -		ext2_free_blocks (inode, block, total);
> -		return;
> -	} else
> -		write_unlock(&ei->i_meta_lock);
> -#endif
> -}
> -
> -static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
> -{
> -#ifdef EXT2FS_DEBUG
> -	static unsigned long alloc_hits, alloc_attempts;
> -#endif
> -	unsigned long result;
> -
> -
> -#ifdef EXT2_PREALLOCATE
> -	struct ext2_inode_info *ei = EXT2_I(inode);
> -	write_lock(&ei->i_meta_lock);
> -	if (ei->i_prealloc_count &&
> -	    (goal == ei->i_prealloc_block || goal + 1 == ei->i_prealloc_block))
> -	{
> -		result = ei->i_prealloc_block++;
> -		ei->i_prealloc_count--;
> -		write_unlock(&ei->i_meta_lock);
> -		ext2_debug ("preallocation hit (%lu/%lu).\n",
> -			    ++alloc_hits, ++alloc_attempts);
> -	} else {
> -		write_unlock(&ei->i_meta_lock);
> -		ext2_discard_prealloc (inode);
> -		ext2_debug ("preallocation miss (%lu/%lu).\n",
> -			    alloc_hits, ++alloc_attempts);
> -		if (S_ISREG(inode->i_mode))
> -			result = ext2_new_block (inode, goal, 
> -				 &ei->i_prealloc_count,
> -				 &ei->i_prealloc_block, err);
> -		else
> -			result = ext2_new_block(inode, goal, NULL, NULL, err);
> -	}
> -#else
> -	result = ext2_new_block (inode, goal, 0, 0, err);
> -#endif
> -	return result;
> -}
> -
>  typedef struct {
>  	__le32	*p;
>  	__le32	key;
> @@ -228,7 +161,8 @@
>  		ext2_warning (inode->i_sb, "ext2_block_to_path", "block > big");
>  	}
>  	if (boundary)
> -		*boundary = (i_block & (ptrs - 1)) == (final - 1);
> +		*boundary = final - 1 - (i_block & (ptrs - 1));
> +
>  	return n;
>  }
>  
> @@ -355,39 +289,129 @@
>   *	@block:  block we want
>   *	@chain:  chain of indirect blocks
>   *	@partial: pointer to the last triple within a chain
> - *	@goal:	place to store the result.
>   *
> - *	Normally this function find the prefered place for block allocation,
> - *	stores it in *@goal and returns zero. If the branch had been changed
> - *	under us we return -EAGAIN.
> + *	Returns preferred place for a block (the goal).
>   */
>  
>  static inline int ext2_find_goal(struct inode *inode,
>  				 long block,
>  				 Indirect chain[4],
> -				 Indirect *partial,
> -				 unsigned long *goal)
> +				 Indirect *partial)
>  {
> -	struct ext2_inode_info *ei = EXT2_I(inode);
> -	write_lock(&ei->i_meta_lock);
> -	if ((block == ei->i_next_alloc_block + 1) && ei->i_next_alloc_goal) {
> -		ei->i_next_alloc_block++;
> -		ei->i_next_alloc_goal++;
> -	} 
> -	if (verify_chain(chain, partial)) {
> -		/*
> -		 * try the heuristic for sequential allocation,
> -		 * failing that at least try to get decent locality.
> -		 */
> -		if (block == ei->i_next_alloc_block)
> -			*goal = ei->i_next_alloc_goal;
> -		if (!*goal)
> -			*goal = ext2_find_near(inode, partial);
> -		write_unlock(&ei->i_meta_lock);
> -		return 0;
> +	struct ext2_block_alloc_info *block_i;
> +
> +	block_i = EXT2_I(inode)->i_block_alloc_info;
> +
> +	/*
> +	 * try the heuristic for sequential allocation,
> +	 * failing that at least try to get decent locality.
> +	 */
> +	if (block_i && (block == block_i->last_alloc_logical_block + 1)
> +		&& (block_i->last_alloc_physical_block != 0)) {
> +		return block_i->last_alloc_physical_block + 1;
> +	}
> +
> +	return ext2_find_near(inode, partial);
> +}
> +
> +/**
> + *	ext2_blks_to_allocate: Look up the block map and count the number
> + *	of direct blocks need to be allocated for the given branch.
> + *
> + * 	@branch: chain of indirect blocks
> + *	@k: number of blocks need for indirect blocks
> + *	@blks: number of data blocks to be mapped.
> + *	@blocks_to_boundary:  the offset in the indirect block
> + *
> + *	return the total number of blocks to be allocate, including the
> + *	direct and indirect blocks.
> + */
> +static int
> +ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
> +		int blocks_to_boundary)
> +{
> +	unsigned long count = 0;
> +
> +	/*
> +	 * Simple case, [t,d]Indirect block(s) has not allocated yet
> +	 * then it's clear blocks on that path have not allocated
> +	 */
> +	if (k > 0) {
> +		/* right now don't hanel cross boundary allocation */
> +		if (blks < blocks_to_boundary + 1)
> +			count += blks;
> +		else
> +			count += blocks_to_boundary + 1;
> +		return count;
> +	}
> +
> +	count++;
> +	while (count < blks && count <= blocks_to_boundary
> +		&& le32_to_cpu(*(branch[0].p + count)) == 0) {
> +		count++;
> +	}
> +	return count;
> +}
> +
> +/**
> + *	ext2_alloc_blocks: multiple allocate blocks needed for a branch
> + *	@indirect_blks: the number of blocks need to allocate for indirect
> + *			blocks
> + *
> + *	@new_blocks: on return it will store the new block numbers for
> + *	the indirect blocks(if needed) and the first direct block,
> + *	@blks:	on return it will store the total number of allocated
> + *		direct blocks
> + */
> +static int ext2_alloc_blocks(struct inode *inode,
> +			unsigned long goal, int indirect_blks, int blks,
> +			unsigned long long new_blocks[4], int *err)
> +{
> +	int target, i;
> +	unsigned long count = 0;
> +	int index = 0;
> +	unsigned long current_block = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * Here we try to allocate the requested multiple blocks at once,
> +	 * on a best-effort basis.
> +	 * To build a branch, we should allocate blocks for
> +	 * the indirect blocks(if not allocated yet), and at least
> +	 * the first direct block of this branch.  That's the
> +	 * minimum number of blocks need to allocate(required)
> +	 */
> +	target = blks + indirect_blks;
> +
> +	while (1) {
> +		count = target;
> +		/* allocating blocks for indirect blocks and direct blocks */
> +		current_block = ext2_new_blocks(inode,goal,&count,err);
> +		if (*err)
> +			goto failed_out;
> +
> +		target -= count;
> +		/* allocate blocks for indirect blocks */
> +		while (index < indirect_blks && count) {
> +			new_blocks[index++] = current_block++;
> +			count--;
> +		}
> +
> +		if (count > 0)
> +			break;
>  	}
> -	write_unlock(&ei->i_meta_lock);
> -	return -EAGAIN;
> +
> +	/* save the new block number for the first direct block */
> +	new_blocks[index] = current_block;
> +
> +	/* total number of blocks allocated for direct blocks */
> +	ret = count;
> +	*err = 0;
> +	return ret;
> +failed_out:
> +	for (i = 0; i <index; i++)
> +		ext2_free_blocks(inode, new_blocks[i], 1);
> +	return ret;
>  }
>  
>  /**
> @@ -416,41 +440,52 @@
>   */
>  
>  static int ext2_alloc_branch(struct inode *inode,
> -			     int num,
> -			     unsigned long goal,
> -			     int *offsets,
> -			     Indirect *branch)
> +			int indirect_blks, int *blks, unsigned long goal,
> +			int *offsets, Indirect *branch)
>  {
>  	int blocksize = inode->i_sb->s_blocksize;
> -	int n = 0;
> -	int err;
> -	int i;
> -	int parent = ext2_alloc_block(inode, goal, &err);
> +	int i, n = 0;
> +	int err = 0;
> +	struct buffer_head *bh;
> +	int num;
> +	unsigned long long new_blocks[4];
> +	unsigned long long current_block;
>  
> -	branch[0].key = cpu_to_le32(parent);
> -	if (parent) for (n = 1; n < num; n++) {
> -		struct buffer_head *bh;
> -		/* Allocate the next block */
> -		int nr = ext2_alloc_block(inode, parent, &err);
> -		if (!nr)
> -			break;
> -		branch[n].key = cpu_to_le32(nr);
> +	num = ext2_alloc_blocks(inode, goal, indirect_blks,
> +				*blks, new_blocks, &err);
> +	if (err)
> +		return err;
> +
> +	branch[0].key = cpu_to_le32(new_blocks[0]);
> +	/*
> +	 * metadata blocks and data blocks are allocated.
> +	 */
> +	for (n = 1; n <= indirect_blks;  n++) {
>  		/*
> -		 * Get buffer_head for parent block, zero it out and set 
> -		 * the pointer to new one, then send parent to disk.
> +		 * Get buffer_head for parent block, zero it out
> +		 * and set the pointer to new one, then send
> +		 * parent to disk.
>  		 */
> -		bh = sb_getblk(inode->i_sb, parent);
> -		if (!bh) {
> -			err = -EIO;
> -			break;
> -		}
> +		bh = sb_getblk(inode->i_sb, new_blocks[n-1]);
> +		branch[n].bh = bh;
>  		lock_buffer(bh);
>  		memset(bh->b_data, 0, blocksize);
> -		branch[n].bh = bh;
>  		branch[n].p = (__le32 *) bh->b_data + offsets[n];
> +		branch[n].key = cpu_to_le32(new_blocks[n]);
>  		*branch[n].p = branch[n].key;
> +		if ( n == indirect_blks) {
> +			current_block = new_blocks[n];
> +			/*
> +			 * End of chain, update the last new metablock of
> +			 * the chain to point to the new allocated
> +			 * data blocks numbers
> +			 */
> +			for (i=1; i < num; i++)
> +				*(branch[n].p + i) = cpu_to_le32(++current_block);
> +		}
>  		set_buffer_uptodate(bh);
>  		unlock_buffer(bh);
> +		ext2_mark_fs_dirty(inode->i_sb);
>  		mark_buffer_dirty_inode(bh, inode);
>  		/* We used to sync bh here if IS_SYNC(inode).
>  		 * But we now rely upon generic_osync_inode()
> @@ -458,77 +493,68 @@
>  		 */
>  		if (S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode))
>  			sync_dirty_buffer(bh);
> -		parent = nr;
>  	}
> -	if (n == num)
> -		return 0;
> -
> -	/* Allocation failed, free what we already allocated */
> -	for (i = 1; i < n; i++)
> -		bforget(branch[i].bh);
> -	for (i = 0; i < n; i++)
> -		ext2_free_blocks(inode, le32_to_cpu(branch[i].key), 1);
> +	*blks = num;
>  	return err;
>  }
>  
>  /**
> - *	ext2_splice_branch - splice the allocated branch onto inode.
> - *	@inode: owner
> - *	@block: (logical) number of block we are adding
> - *	@chain: chain of indirect blocks (with a missing link - see
> - *		ext2_alloc_branch)
> - *	@where: location of missing link
> - *	@num:   number of blocks we are adding
> - *
> - *	This function verifies that chain (up to the missing link) had not
> - *	changed, fills the missing link and does all housekeeping needed in
> - *	inode (->i_blocks, etc.). In case of success we end up with the full
> - *	chain to new block and return 0. Otherwise (== chain had been changed)
> - *	we free the new blocks (forgetting their buffer_heads, indeed) and
> - *	return -EAGAIN.
> + * ext2_splice_branch - splice the allocated branch onto inode.
> + * @inode: owner
> + * @block: (logical) number of block we are adding
> + * @chain: chain of indirect blocks (with a missing link - see
> + *	ext2_alloc_branch)
> + * @where: location of missing link
> + * @num:   number of indirect blocks we are adding
> + * @blks:  number of direct blocks we are adding
> + *
> + * This function fills the missing link and does all housekeeping needed in
> + * inode (->i_blocks, etc.). In case of success we end up with the full
> + * chain to new block and return 0.
>   */
> -
> -static inline int ext2_splice_branch(struct inode *inode,
> -				     long block,
> -				     Indirect chain[4],
> -				     Indirect *where,
> -				     int num)
> +static void ext2_splice_branch(struct inode *inode,
> +			long block, Indirect *where, int num, int blks)
>  {
> -	struct ext2_inode_info *ei = EXT2_I(inode);
>  	int i;
> +	struct ext2_block_alloc_info *block_i;
> +	unsigned long current_block;
>  
> -	/* Verify that place we are splicing to is still there and vacant */
> -
> -	write_lock(&ei->i_meta_lock);
> -	if (!verify_chain(chain, where-1) || *where->p)
> -		goto changed;
> +	block_i = EXT2_I(inode)->i_block_alloc_info;
>  
> +	/* XXX LOCKING probably should have i_meta_lock ?*/
>  	/* That's it */
>  
>  	*where->p = where->key;
> -	ei->i_next_alloc_block = block;
> -	ei->i_next_alloc_goal = le32_to_cpu(where[num-1].key);
>  
> -	write_unlock(&ei->i_meta_lock);
> +	/*
> +	 * Update the host buffer_head or inode to point to more just allocated
> +	 * direct blocks blocks
> +	 */
> +	if (num == 0 && blks > 1) {
> +		current_block = le32_to_cpu(where->key + 1);
> +		for (i = 1; i < blks; i++)
> +			*(where->p + i ) = cpu_to_le32(current_block++);
> +	}
> +
> +	/*
> +	 * update the most recently allocated logical & physical block
> +	 * in i_block_alloc_info, to assist find the proper goal block for next
> +	 * allocation
> +	 */
> +	if (block_i) {
> +		block_i->last_alloc_logical_block = block + blks - 1;
> +		block_i->last_alloc_physical_block =
> +				le32_to_cpu(where[num].key + blks - 1);
> +	}
>  
>  	/* We are done with atomic stuff, now do the rest of housekeeping */
>  
> -	inode->i_ctime = CURRENT_TIME_SEC;
> -
>  	/* had we spliced it onto indirect block? */
>  	if (where->bh)
>  		mark_buffer_dirty_inode(where->bh, inode);
>  
> +	inode->i_ctime = CURRENT_TIME_SEC;
>  	mark_inode_dirty(inode);
> -	return 0;
> -
> -changed:
> -	write_unlock(&ei->i_meta_lock);
> -	for (i = 1; i < num; i++)
> -		bforget(where[i].bh);
> -	for (i = 0; i < num; i++)
> -		ext2_free_blocks(inode, le32_to_cpu(where[i].key), 1);
> -	return -EAGAIN;
>  }
>  
>  /*
> @@ -542,62 +568,91 @@
>   * That has a nice additional property: no special recovery from the failed
>   * allocations is needed - we simply release blocks and do not touch anything
>   * reachable from inode.
> + *
> + * `handle' can be NULL if create == 0.
> + *
> + * The BKL may not be held on entry here.  Be sure to take it early.
> + * return > 0, # of blocks mapped or allocated.
> + * return = 0, if plain lookup failed.
> + * return < 0, error case.
>   */
> -
> -int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
> +int ext2_get_blocks(struct inode *inode,
> +		sector_t iblock, unsigned long maxblocks,
> +		struct buffer_head *bh_result,
> +		int create)
>  {
>  	int err = -EIO;
>  	int offsets[4];
>  	Indirect chain[4];
>  	Indirect *partial;
>  	unsigned long goal;
> -	int left;
> -	int boundary = 0;
> -	int depth = ext2_block_to_path(inode, iblock, offsets, &boundary);
> +	int indirect_blks;
> +	int blocks_to_boundary = 0;
> +	int depth;
> +	struct ext2_inode_info *ei = EXT2_I(inode);
> +	int count = 0;
> +	unsigned long first_block = 0;
>  
> -	if (depth == 0)
> -		goto out;
> +	depth = ext2_block_to_path(inode,iblock,offsets,&blocks_to_boundary);
>  
> +	if (depth == 0)
> +		return (err);
>  reread:
>  	partial = ext2_get_branch(inode, depth, offsets, chain, &err);
>  
>  	/* Simplest case - block found, no allocation needed */
>  	if (!partial) {
> -got_it:
> -		map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
> -		if (boundary)
> -			set_buffer_boundary(bh_result);
> -		/* Clean up and exit */
> -		partial = chain+depth-1; /* the whole chain */
> -		goto cleanup;
> +		first_block = chain[depth - 1].key;
> +		clear_buffer_new(bh_result); /* What's this do? */
> +		count++;
> +		/*map more blocks*/
> +		while (count < maxblocks && count <= blocks_to_boundary) {
> +			if (!verify_chain(chain, partial)) {
> +				/*
> +				 * Indirect block might be removed by
> +				 * truncate while we were reading it.
> +				 * Handling of that case: forget what we've
> +				 * got now, go to reread.
> +				 */
> +				count = 0;
> +				goto changed;
> +			}
> +			if (le32_to_cpu(*(chain[depth-1].p+count) ==
> +					(first_block + count)))
> +				count++;
> +			else
> +				break;
> +		}
> +		goto got_it;
>  	}
>  
>  	/* Next simple case - plain lookup or failed read of indirect block */
> -	if (!create || err == -EIO) {
> -cleanup:
> -		while (partial > chain) {
> -			brelse(partial->bh);
> -			partial--;
> -		}
> -out:
> -		return err;
> -	}
> +	if (!create || err == -EIO)
> +		goto cleanup;
>  
>  	/*
> -	 * Indirect block might be removed by truncate while we were
> -	 * reading it. Handling of that case (forget what we've got and
> -	 * reread) is taken out of the main path.
> +	 * Okay, we need to do block allocation.  Lazily initialize the block
> +	 * allocation info here if necessary
> +	*/
> +	if (S_ISREG(inode->i_mode) && (!ei->i_block_alloc_info))
> +		ext2_init_block_alloc_info(inode);
> +
> +	goal = ext2_find_goal(inode, iblock, chain, partial);
> +
> +	/* the number of blocks need to allocate for [d,t]indirect blocks */
> +	indirect_blks = (chain + depth) - partial - 1;
> +	/*
> +	 * Next look up the indirect map to count the totoal number of
> +	 * direct blocks to allocate for this branch.
>  	 */
> -	if (err == -EAGAIN)
> -		goto changed;
> +	count = ext2_blks_to_allocate(partial, indirect_blks,
> +					maxblocks, blocks_to_boundary);
> +	/*
> +	 * XXX ???? Block out ext2_truncate while we alter the tree
> +	 */
> +	err = ext2_alloc_branch(inode, indirect_blks, &count, goal,
> +				offsets + (partial - chain), partial);
>  
> -	goal = 0;
> -	if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
> -		goto changed;
> -
> -	left = (chain + depth) - partial;
> -	err = ext2_alloc_branch(inode, left, goal,
> -					offsets+(partial-chain), partial);
>  	if (err)
>  		goto cleanup;
>  
> @@ -611,12 +666,22 @@
>  			goto cleanup;
>  	}
>  
> -	if (ext2_splice_branch(inode, iblock, chain, partial, left) < 0)
> -		goto changed;
> +	ext2_splice_branch(inode, iblock, partial, indirect_blks, count);
>  
>  	set_buffer_new(bh_result);
> -	goto got_it;
> -
> +got_it:
> +	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
> +	if (blocks_to_boundary == 0)
> +		set_buffer_boundary(bh_result);
> +	err = count;
> +	/* Clean up and exit */
> +	partial = chain + depth - 1;	/* the whole chain */
> +cleanup:
> +	while (partial > chain) {
> +		brelse(partial->bh);
> +		partial--;
> +	}
> +	return err;
>  changed:
>  	while (partial > chain) {
>  		brelse(partial->bh);
> @@ -625,6 +690,19 @@
>  	goto reread;
>  }
>  
> +int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
> +{
> +	unsigned max_blocks = bh_result->b_size >> inode->i_blkbits;
> +	int ret = ext2_get_blocks(inode, iblock, max_blocks,
> +			      bh_result, create);
> +	if (ret > 0) {
> +		bh_result->b_size = (ret << inode->i_blkbits);
> +		ret = 0;
> +	}
> +	return ret;
> +
> +}
> +
>  static int ext2_writepage(struct page *page, struct writeback_control *wbc)
>  {
>  	return block_write_full_page(page, ext2_get_block, wbc);
> @@ -916,8 +994,6 @@
>  	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
>  		return;
>  
> -	ext2_discard_prealloc(inode);
> -
>  	blocksize = inode->i_sb->s_blocksize;
>  	iblock = (inode->i_size + blocksize-1)
>  					>> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
> @@ -943,10 +1019,12 @@
>  	partial = ext2_find_shared(inode, n, offsets, chain, &nr);
>  	/* Kill the top of shared branch (already detached) */
>  	if (nr) {
> -		if (partial == chain)
> +		if (partial == chain) {
>  			mark_inode_dirty(inode);
> -		else
> +		} else {
> +			ext2_mark_fs_dirty(inode->i_sb);
>  			mark_buffer_dirty_inode(partial->bh, inode);
> +		}
>  		ext2_free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
>  	}
>  	/* Clear the ends of indirect blocks on the shared branch */
> @@ -955,6 +1033,7 @@
>  				   partial->p + 1,
>  				   (__le32*)partial->bh->b_data+addr_per_block,
>  				   (chain+n-1) - partial);
> +		ext2_mark_fs_dirty(inode->i_sb);
>  		mark_buffer_dirty_inode(partial->bh, inode);
>  		brelse (partial->bh);
>  		partial--;
> @@ -986,9 +1065,13 @@
>  		case EXT2_TIND_BLOCK:
>  			;
>  	}
> +
> +	ext2_discard_reservation(inode);
> +
>  	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
>  	if (inode_needs_sync(inode)) {
>  		sync_mapping_buffers(inode->i_mapping);
> +		ext2_mark_fs_dirty(inode->i_sb);
>  		ext2_sync_inode (inode);
>  	} else {
>  		mark_inode_dirty(inode);
> @@ -1067,6 +1150,8 @@
>  	ei->i_acl = EXT2_ACL_NOT_CACHED;
>  	ei->i_default_acl = EXT2_ACL_NOT_CACHED;
>  #endif
> +	ei->i_block_alloc_info = NULL;
> +
>  	if (IS_ERR(raw_inode))
>   		goto bad_inode;
>  
> @@ -1109,9 +1194,6 @@
>  	ei->i_dtime = 0;
>  	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
>  	ei->i_state = 0;
> -	ei->i_next_alloc_block = 0;
> -	ei->i_next_alloc_goal = 0;
> -	ei->i_prealloc_count = 0;
>  	ei->i_block_group = (ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
>  	ei->i_dir_start_lookup = 0;
>  
> @@ -1121,6 +1203,7 @@
>  	 */
>  	for (n = 0; n < EXT2_N_BLOCKS; n++)
>  		ei->i_data[n] = raw_inode->i_block[n];
> +	INIT_LIST_HEAD(&ei->i_orphan);
>  
>  	if (S_ISREG(inode->i_mode)) {
>  		inode->i_op = &ext2_file_inode_operations;
> diff -x '*~' -uNr vanilla-linux/fs/ext2/ioctl.c uml-clean/fs/ext2/ioctl.c
> --- vanilla-linux/fs/ext2/ioctl.c	2006-03-24 01:47:33.000000000 -0800
> +++ uml-clean/fs/ext2/ioctl.c	2006-03-22 17:49:49.000000000 -0800
> @@ -20,6 +20,7 @@
>  {
>  	struct ext2_inode_info *ei = EXT2_I(inode);
>  	unsigned int flags;
> +	unsigned short rsv_window_size;
>  
>  	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
>  
> @@ -76,6 +77,48 @@
>  		inode->i_ctime = CURRENT_TIME_SEC;
>  		mark_inode_dirty(inode);
>  		return 0;
> +	case EXT2_IOC_GETRSVSZ:
> +		if (test_opt(inode->i_sb, RESERVATION)
> +			&& S_ISREG(inode->i_mode)
> +			&& ei->i_block_alloc_info) {
> +			rsv_window_size = ei->i_block_alloc_info->rsv_window_node.rsv_goal_size;
> +			return put_user(rsv_window_size, (int __user *)arg);
> +		}
> +		return -ENOTTY;
> +	case EXT2_IOC_SETRSVSZ: {
> +
> +		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
> +			return -ENOTTY;
> +
> +		if (IS_RDONLY(inode))
> +			return -EROFS;
> +
> +		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
> +			return -EACCES;
> +
> +		if (get_user(rsv_window_size, (int __user *)arg))
> +			return -EFAULT;
> +
> +		if (rsv_window_size > EXT2_MAX_RESERVE_BLOCKS)
> +			rsv_window_size = EXT2_MAX_RESERVE_BLOCKS;
> +
> +		/*
> +		 * need to allocate reservation structure for this inode
> +		 * before set the window size
> +		 */
> +		/*
> +		 * XXX What lock should protect the rsv_goal_size?
> +		 * Accessed in ext2_get_block only.  ext3 uses i_truncate.
> +		 */
> +		if (!ei->i_block_alloc_info)
> +			ext2_init_block_alloc_info(inode);
> +
> +		if (ei->i_block_alloc_info){
> +			struct ext2_reserve_window_node *rsv = &ei->i_block_alloc_info->rsv_window_node;
> +			rsv->rsv_goal_size = rsv_window_size;
> +		}
> +		return 0;
> +	}
>  	default:
>  		return -ENOTTY;
>  	}
> diff -x '*~' -uNr vanilla-linux/fs/ext2/Makefile uml-clean/fs/ext2/Makefile
> --- vanilla-linux/fs/ext2/Makefile	2006-01-02 19:21:10.000000000 -0800
> +++ uml-clean/fs/ext2/Makefile	2006-03-16 22:16:47.000000000 -0800
> @@ -5,7 +5,7 @@
>  obj-$(CONFIG_EXT2_FS) += ext2.o
>  
>  ext2-y := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
> -	  ioctl.o namei.o super.o symlink.o
> +	  ioctl.o namei.o super.o symlink.o state.o
>  
>  ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
>  ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
> diff -x '*~' -uNr vanilla-linux/fs/ext2/namei.c uml-clean/fs/ext2/namei.c
> --- vanilla-linux/fs/ext2/namei.c	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/namei.c	2006-03-10 01:23:52.000000000 -0800
> @@ -267,6 +267,8 @@
>  
>  	inode->i_ctime = dir->i_ctime;
>  	inode_dec_link_count(inode);
> +	if (!inode->i_nlink)
> +		ext2_orphan_add(inode);
>  	err = 0;
>  out:
>  	return err;
> @@ -328,6 +330,8 @@
>  		if (dir_de)
>  			new_inode->i_nlink--;
>  		inode_dec_link_count(new_inode);
> +		if (!new_inode->i_nlink)
> +			ext2_orphan_add(new_inode);
>  	} else {
>  		if (dir_de) {
>  			err = -EMLINK;
> diff -x '*~' -uNr vanilla-linux/fs/ext2/state.c uml-clean/fs/ext2/state.c
> --- vanilla-linux/fs/ext2/state.c	1969-12-31 16:00:00.000000000 -0800
> +++ uml-clean/fs/ext2/state.c	2006-03-24 04:36:00.000000000 -0800
> @@ -0,0 +1,109 @@
> +/*
> + * Kernel thread to keep track of clean/dirty state of ext2 file system
> + */
> +#include <linux/buffer_head.h>
> +#include <linux/kthread.h>
> +#include "ext2.h"
> +
> +#define EXT2_DIRTY_TIMEOUT 1	/* Time in secs to check for dirty */
> +#define EXT2_DIRTY_JIFFIES (EXT2_DIRTY_TIMEOUT * HZ)
> +
> +/*
> + * ext2_update_state runs periodically to check to see if the file
> + * system has any ongoing write traffic.  If no one has written to the
> + * file system recently, then we sync the file system and check if any
> + * metadata writes occurred while we were doing the sync.  If no
> + * writes occurred, we go ahead and mark the file system clean.  Any
> + * operation that changes the metadata must first mark the file system
> + * dirty (via ext2_mark_fs_dirty()) before any other writes hit disk.
> + *
> + * For debugging and measurement, we are keeping some statistics on
> + * how often the file system is dirty/clean in any given period in the
> + * superblock.  They will go away if this hits production.
> + *
> + */
> +
> +static void ext2_update_state(struct super_block *sb)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
> +
> +	lock_super(sb);
> +	sb->s_dirt = 1;
> +	if (sbi->s_dirty_lately == EXT2_FS_DIRTY) {
> +		es->s_dirty_count =
> +			cpu_to_le32(le32_to_cpu(es->s_dirty_count) + 1);
> +		/* Reset our dirty flag for the next interval */
> +		sbi->s_dirty_lately = EXT2_FS_CLEAN;
> +	} else {
> +		es->s_clean_count =
> +			cpu_to_le32(le32_to_cpu(es->s_clean_count) + 1);
> +		/*
> +		 * This fs has not been written to recently.  If it is
> +		 * currently marked dirty, sync all outstanding writes
> +		 * and see if we are still clean.  If so, mark the fs
> +		 * clean.
> +		 */
> +		if (es->s_fs_dirty != EXT2_FS_CLEAN) {
> +			unlock_super(sb);
> +			/* Sync all outstanding writes to file system */
> +			/* XXX need to export below for moduleness */
> +			fsync_super(sb);
> +			lock_super(sb);
> +			/* New writes may have occurred during the
> +			 * sync, recheck */
> +			if (sbi->s_dirty_lately == EXT2_FS_CLEAN)
> +				__ext2_mark_fs_clean(sb);
> +			else
> +				printk(KERN_DEBUG "fs dirtied during sync\n");
> +		}
> +		/*
> +		 * We don't flush the superblock if the file system
> +		 * was already marked clean.  Otherwise we'll be
> +		 * writing to the disk continuously while the file
> +		 * system is idle.  This means the stats won't
> +		 * necessarily get written to disk until the fs is
> +		 * unmounted.
> +		 */
> +	}
> +	unlock_super(sb);
> +}
> +
> +static void ext2_print_stats(struct super_block *sb)
> +{
> +	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
> +	unsigned int clean, dirty, total, percent;
> +
> +	clean = le32_to_cpu(es->s_clean_count);
> +	dirty = le32_to_cpu(es->s_dirty_count);
> +	total = dirty + clean;
> +
> +	if (total == 0)
> +		percent = 0;
> +	else
> +		percent = (clean * 100) / total;
> +	/* XXX add fs mount point */
> +	printk(KERN_DEBUG "ext2: dirty:%u clean:%u total:%u percent clean: %u\n",
> +	       dirty, clean, total, percent);
> +}
> +
> +int ext2_dirtyd(void *arg)
> +{
> +	struct super_block *sb = (struct super_block *) arg;
> +
> +	printk(KERN_INFO "ext2_dirtyd starting, interval %d seconds\n",
> +	       EXT2_DIRTY_TIMEOUT);
> +	ext2_print_stats(sb);
> +
> +	while (1) {
> +		schedule_timeout_interruptible(EXT2_DIRTY_JIFFIES);
> +		if (kthread_should_stop())
> +			break;
> +		if (freezing(current))
> +			refrigerator();
> +		ext2_update_state(sb);
> +	} 
> +
> +	ext2_print_stats(sb);
> +	return 0;
> +}
> diff -x '*~' -uNr vanilla-linux/fs/ext2/super.c uml-clean/fs/ext2/super.c
> --- vanilla-linux/fs/ext2/super.c	2006-03-24 01:48:18.000000000 -0800
> +++ uml-clean/fs/ext2/super.c	2006-03-24 05:20:08.000000000 -0800
> @@ -30,6 +30,7 @@
>  #include <linux/vfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/mount.h>
> +#include <linux/kthread.h>
>  #include <asm/uaccess.h>
>  #include "ext2.h"
>  #include "xattr.h"
> @@ -113,6 +114,7 @@
>  	int i;
>  	struct ext2_sb_info *sbi = EXT2_SB(sb);
>  
> +	kthread_stop(sbi->s_dirtyd);
>  	ext2_xattr_put_super(sb);
>  	if (!(sb->s_flags & MS_RDONLY)) {
>  		struct ext2_super_block *es = sbi->s_es;
> @@ -129,6 +131,7 @@
>  	percpu_counter_destroy(&sbi->s_freeblocks_counter);
>  	percpu_counter_destroy(&sbi->s_freeinodes_counter);
>  	percpu_counter_destroy(&sbi->s_dirs_counter);
> +	kfree(sbi->s_esp);
>  	brelse (sbi->s_sbh);
>  	sb->s_fs_info = NULL;
>  	kfree(sbi);
> @@ -164,6 +167,7 @@
>  	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
>  	    SLAB_CTOR_CONSTRUCTOR) {
>  		rwlock_init(&ei->i_meta_lock);
> +		INIT_LIST_HEAD(&ei->i_orphan);
>  #ifdef CONFIG_EXT2_FS_XATTR
>  		init_rwsem(&ei->xattr_sem);
>  #endif
> @@ -191,6 +195,7 @@
>  
>  static void ext2_clear_inode(struct inode *inode)
>  {
> +	struct ext2_block_alloc_info *rsv = EXT2_I(inode)->i_block_alloc_info;
>  #ifdef CONFIG_EXT2_FS_POSIX_ACL
>  	struct ext2_inode_info *ei = EXT2_I(inode);
>  
> @@ -203,6 +208,9 @@
>  		ei->i_default_acl = EXT2_ACL_NOT_CACHED;
>  	}
>  #endif
> +	ext2_discard_reservation(inode);
> +	EXT2_I(inode)->i_block_alloc_info = NULL;
> +	kfree(rsv);
>  }
>  
>  static int ext2_show_options(struct seq_file *seq, struct vfsmount *vfs)
> @@ -240,7 +248,6 @@
>  	.destroy_inode	= ext2_destroy_inode,
>  	.read_inode	= ext2_read_inode,
>  	.write_inode	= ext2_write_inode,
> -	.put_inode	= ext2_put_inode,
>  	.delete_inode	= ext2_delete_inode,
>  	.put_super	= ext2_put_super,
>  	.write_super	= ext2_write_super,
> @@ -289,7 +296,7 @@
>  	Opt_err_ro, Opt_nouid32, Opt_nocheck, Opt_debug,
>  	Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
>  	Opt_acl, Opt_noacl, Opt_xip, Opt_ignore, Opt_err, Opt_quota,
> -	Opt_usrquota, Opt_grpquota
> +	Opt_usrquota, Opt_grpquota, Opt_reservation, Opt_noreservation
>  };
>  
>  static match_table_t tokens = {
> @@ -321,6 +328,8 @@
>  	{Opt_ignore, "noquota"},
>  	{Opt_quota, "quota"},
>  	{Opt_usrquota, "usrquota"},
> +	{Opt_reservation, "reservation"},
> +	{Opt_noreservation, "noreservation"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -448,6 +457,14 @@
>  			break;
>  #endif
>  
> +		case Opt_reservation:
> +			set_opt(sbi->s_mount_opt, RESERVATION);
> +			printk("reservations ON\n");
> +			break;
> +		case Opt_noreservation:
> +			clear_opt(sbi->s_mount_opt, RESERVATION);
> +			printk("reservations OFF\n");
> +			break;
>  		case Opt_ignore:
>  			break;
>  		default:
> @@ -649,9 +666,23 @@
>  	/*
>  	 * Note: s_es must be initialized as soon as possible because
>  	 *       some ext2 macro-instructions depend on its value
> +	 *
> +	 * We used to operate on the on-disk superblock directly
> +	 * inside the buffer in the superblock bh.  However, now that
> +	 * we need to do an asynchronous write of the superblock, we
> +	 * have to allocate a separate in-memory buffer for the
> +	 * superblock.  For simplicity, we allocate a buffer that is
> +	 * as large as device block size and then set the sbi->s_es
> +	 * pointer to the beginning of the superblock inside the
> +	 * buffer. -VAL
>  	 */
> -	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
> -	sbi->s_es = es;
> +	sbi->s_esp = kmalloc(bh->b_size, GFP_KERNEL);
> +	if (!sbi->s_esp)
> +		goto failed_sbi;
> +	memcpy(sbi->s_esp, bh->b_data, bh->b_size);
> +	sbi->s_es = (struct ext2_super_block *) sbi->s_esp + offset;
> +	es = sbi->s_es;
> +
>  	sb->s_magic = le16_to_cpu(es->s_magic);
>  
>  	if (sb->s_magic != EXT2_SUPER_MAGIC)
> @@ -678,6 +709,8 @@
>  	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
>  	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
>  	
> +	set_opt(sbi->s_mount_opt, RESERVATION);
> +
>  	if (!parse_options ((char *) data, sbi))
>  		goto failed_mount;
>  
> @@ -726,6 +759,7 @@
>  	/* If the blocksize doesn't match, re-read the thing.. */
>  	if (sb->s_blocksize != blocksize) {
>  		brelse(bh);
> +		kfree(sbi->s_esp);
>  
>  		if (!sb_set_blocksize(sb, blocksize)) {
>  			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
> @@ -740,8 +774,13 @@
>  			       "2nd try.\n");
>  			goto failed_sbi;
>  		}
> -		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
> -		sbi->s_es = es;
> +		sbi->s_esp = kmalloc(bh->b_size, GFP_KERNEL);
> +		if (!sbi->s_esp)
> +			goto failed_sbi;
> +		memcpy(sbi->s_esp, bh->b_data, bh->b_size);
> +		sbi->s_es = (struct ext2_super_block *) sbi->s_esp + offset;
> +		es = sbi->s_es;
> +
>  		if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
>  			printk ("EXT2-fs: Magic mismatch, very weird !\n");
>  			goto failed_mount;
> @@ -865,6 +904,19 @@
>  	sbi->s_gdb_count = db_count;
>  	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
>  	spin_lock_init(&sbi->s_next_gen_lock);
> +	/* per fileystem reservation list head & lock */
> +	spin_lock_init(&sbi->s_rsv_window_lock);
> +	sbi->s_rsv_window_root = RB_ROOT;
> +	/* Add a single, static dummy reservation to the start of the
> +	 * reservation window list --- it gives us a placeholder for
> +	 * append-at-start-of-list which makes the allocation logic
> +	 * _much_ simpler. */
> +	sbi->s_rsv_window_head.rsv_start = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +	sbi->s_rsv_window_head.rsv_end = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
> +	sbi->s_rsv_window_head.rsv_alloc_hit = 0;
> +	sbi->s_rsv_window_head.rsv_goal_size = 0;
> +	ext2_rsv_window_add(sb, &sbi->s_rsv_window_head);
> +
>  	/*
>  	 * set up enough so that it can read an inode
>  	 */
> @@ -894,6 +946,9 @@
>  				ext2_count_free_inodes(sb));
>  	percpu_counter_mod(&sbi->s_dirs_counter,
>  				ext2_count_dirs(sb));
> +	INIT_LIST_HEAD(&sbi->s_orphan);
> +	/* XXX be smarter about starting/stopping */
> +	sbi->s_dirtyd = kthread_run(ext2_dirtyd, sb, "ext2dirtyd");
>  	return 0;
>  
>  cantfind_ext2:
> @@ -910,27 +965,79 @@
>  	kfree(sbi->s_debts);
>  failed_mount:
>  	brelse(bh);
> +	kfree(sbi->s_esp);
>  failed_sbi:
>  	sb->s_fs_info = NULL;
>  	kfree(sbi);
>  	return -EINVAL;
>  }
>  
> +/*
> + * Helper function to copy the in-memory superblock into the buffer
> + * used to write it to disk.
> + */
> +
> +void ext2_prepare_super(struct super_block * sb)
> +{
> +	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
> +	char *esp = EXT2_SB(sb)->s_esp;
> +
> +	lock_buffer(bh);
> +	memcpy(bh->b_data, esp, bh->b_size);
> +	unlock_buffer(bh);
> +}
> +
>  static void ext2_commit_super (struct super_block * sb,
>  			       struct ext2_super_block * es)
>  {
> +	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
> +
>  	es->s_wtime = cpu_to_le32(get_seconds());
> -	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
> +	ext2_prepare_super(sb);
> +	mark_buffer_dirty(bh);
>  	sb->s_dirt = 0;
>  }
>  
> +static void ext2_end_async_io(struct buffer_head *bh, int uptodate)
> +{
> +	/* XXX Deal with failed write of dirty fs bit? */
> +	if (uptodate)
> +		set_buffer_uptodate(bh);
> +	else
> +		clear_buffer_uptodate(bh);
> +	unlock_buffer(bh);
> +}
> +
> +/*
> + * Submit the superblock for writing, but don't wait - we only need a
> + * write barrier here (has to hit disk after previous writes and
> + * before any subsequent writes).
> + */
> +static 
> +void ext2_write_super_async(struct super_block *sb, struct ext2_super_block *es)
> +{
> +	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
> +	char *esp = EXT2_SB(sb)->s_esp;
> +
> +	lock_buffer(bh);
> +	bh->b_end_io = ext2_end_async_io;
> +	clear_buffer_dirty(bh);
> +	memcpy(bh->b_data, esp, bh->b_size);
> +	submit_bh(WRITE_BARRIER, bh);
> +	sb->s_dirt = 0;
> +	/* bh unlocked in end io function */
> +}
> +	
>  static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
>  {
> +	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
> +
>  	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
>  	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
>  	es->s_wtime = cpu_to_le32(get_seconds());
> -	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
> -	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
> +	ext2_prepare_super(sb);
> +	mark_buffer_dirty(bh);
> +	sync_dirty_buffer(bh);
>  	sb->s_dirt = 0;
>  }
>  
> @@ -943,12 +1050,19 @@
>   * flags to 0.  We need to set this flag to 0 since the fs
>   * may have been checked while mounted and e2fsck may have
>   * set s_state to EXT2_VALID_FS after some corrections.
> + *
> + * Now we are keeping a copy of the superblock elsewhere in memory
> + * (pointed to by sbi->s_es, and copying it into the buffer on need
> + * (see ext2_prepare_super()).  This is so we can use the superblock
> + * to contain the fs-wide dirty bit.  We need to be able to submit an
> + * asynchronous I/O to update this bit without having the superblock
> + * information change while it is in flight. -VAL
>   */
>  
>  void ext2_write_super (struct super_block * sb)
>  {
>  	struct ext2_super_block * es;
> -	lock_kernel();
> +	lock_kernel(); /* XXX Need to lock_kernel() when writing sb?? */
>  	if (!(sb->s_flags & MS_RDONLY)) {
>  		es = EXT2_SB(sb)->s_es;
>  
> @@ -956,8 +1070,10 @@
>  			ext2_debug ("setting valid to 0\n");
>  			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
>  						  ~EXT2_VALID_FS);
> -			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
> -			es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
> +			es->s_free_blocks_count =
> +				cpu_to_le32(ext2_count_free_blocks(sb));
> +			es->s_free_inodes_count =
> +				cpu_to_le32(ext2_count_free_inodes(sb));
>  			es->s_mtime = cpu_to_le32(get_seconds());
>  			ext2_sync_super(sb, es);
>  		} else
> @@ -967,6 +1083,183 @@
>  	unlock_kernel();
>  }
>  
> +/*
> + * Functions for marking fs as dirty or clean with respect to ongoing
> + * write activity.  Note this is different from the fs valid bit,
> + * which determines whether the fs has been cleanly unmounted.
> + *
> + * sb->s_lock MUST be held while calling this function.
> + */
> +
> +static void __ext2_mark_super(struct super_block *sb, int state)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_super_block *es = sbi->s_es;
> +
> +	if (sb->s_flags & MS_RDONLY)
> +		return;
> +	if (es->s_fs_dirty == state)
> +		return;
> +
> +	es->s_fs_dirty = state;
> +	es->s_wtime = cpu_to_le32(get_seconds());
> +	/*
> +	 * If it's dirty, don't update free block/inode counts -
> +	 * that's expensive, and we have to rebuild them anyway.
> +	 *
> +	 * If it's clean, update the free block/inode counts, they
> +	 * have to be correct now.
> +	 */
> +	if (state == EXT2_FS_DIRTY) {
> +		printk(KERN_DEBUG "marking fs dirty\n");
> +		sbi->s_dirty_lately = EXT2_FS_DIRTY;
> +	} else {
> +		printk(KERN_DEBUG "marking fs clean\n");
> +		es->s_free_blocks_count =
> +			cpu_to_le32(ext2_count_free_blocks(sb));
> +		es->s_free_inodes_count =
> +			cpu_to_le32(ext2_count_free_inodes(sb));
> +		/* We only reset the dirty_lately flag in ext2_update_state */
> +	}
> +	ext2_write_super_async(sb, es);
> +}
> +
> +static void __ext2_mark_fs_dirty(struct super_block *sb)
> +{
> +	__ext2_mark_super(sb, EXT2_FS_DIRTY);
> +}
> +	
> +void __ext2_mark_fs_clean(struct super_block *sb)
> +{
> +	__ext2_mark_super(sb, EXT2_FS_CLEAN);
> +}
> +	
> +/*
> + * This function must be called every time we modify file system
> + * metadata, and must be called BEFORE any write I/O is scheduled.
> + */
> +
> +void ext2_mark_fs_dirty(struct super_block *sb)
> +{
> +	/* XXX get around locking super every write ? */
> +	lock_super(sb);
> +	__ext2_mark_super(sb, EXT2_FS_DIRTY);
> +	unlock_super(sb);
> +}
> +	
> +/*
> + * Whenever we mark an inode dirty, we must also mark the file system
> + * dirty.
> + *
> + * XXX Currently mark_inode_dirty() is #defined as
> + * ext2_mark_inode_dirty(), hence the bogus use of
> + * __mark_inode_dirty().  I don't want to replace all instances of
> + * mark_inode_dirty until I'm sure this is what I want to do.
> + */
> +
> +static void __ext2_mark_inode_dirty(struct inode *inode)
> +{
> +	__ext2_mark_fs_dirty(inode->i_sb);
> +	__mark_inode_dirty(inode, I_DIRTY);
> +}
> +
> +void ext2_mark_inode_dirty(struct inode *inode)
> +{
> +	ext2_mark_fs_dirty(inode->i_sb);
> +	__mark_inode_dirty(inode, I_DIRTY);
> +}
> +
> +/*
> + * orphan inode stuff, stolen from ext3
> + *
> + */
> +
> +#ifdef EXT2FS_DEBUG
> +static inline struct inode *orphan_list_entry(struct list_head *l)
> +{
> +	return &list_entry(l, struct ext2_inode_info, i_orphan)->vfs_inode;
> +}
> +
> +static void dump_orphan_list(struct super_block *sb, struct ext2_sb_info *sbi)
> +{
> +	struct list_head *l;
> +	printk(KERN_DEBUG "sb_info orphan list:\n");
> +	list_for_each(l, &sbi->s_orphan) {
> +		struct inode *inode = orphan_list_entry(l);
> +		printk(KERN_DEBUG "  "
> +		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
> +		       inode->i_sb->s_id, inode->i_ino, inode,
> +		       inode->i_mode, inode->i_nlink, 
> +		       NEXT_ORPHAN(inode));
> +	}
> +}
> +#endif
> +/*
> + * ext2_orphan_add() links an unlinked inode into a list of such
> + * inodes, starting at the superblock, in case we crash before the
> + * file is closed and deleted.
> + *
> + * We depend on the ext3 orphan recovery code in fsck to clean up.
> + */
> +void ext2_orphan_add(struct inode *inode)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_super_block *es = sbi->s_es;
> +
> +	lock_super(sb);
> +	if (!list_empty(&EXT2_I(inode)->i_orphan)) {
> +		unlock_super(sb);
> +		return;
> +	}
> +	/* Insert this inode at the head of the on-disk orphan list... */
> +	NEXT_ORPHAN(inode) = le32_to_cpu(es->s_last_orphan);
> +	es->s_last_orphan = cpu_to_le32(inode->i_ino);
> +	/* Add to in-memory list */
> +	list_add(&EXT2_I(inode)->i_orphan, &EXT2_SB(sb)->s_orphan);
> +	__ext2_mark_inode_dirty(inode);
> +	unlock_super(sb);
> +	return;
> +}
> +
> +/*
> + * ext2_orphan_del() removes an unlinked inode from the list of such
> + * inodes stored on disk, because it is finally being cleaned up.
> + */
> +void ext2_orphan_del(struct inode *inode)
> +{
> +	struct list_head *prev;
> +	struct super_block *sb = inode->i_sb;
> +	struct ext2_inode_info *ei = EXT2_I(inode);
> +	struct ext2_sb_info *sbi;
> +	unsigned long ino_next;
> +
> +	lock_super(sb);
> +	if (list_empty(&ei->i_orphan)) {
> +		unlock_super(sb);
> +		return;
> +	}
> +
> +	ino_next = NEXT_ORPHAN(inode);
> +	prev = ei->i_orphan.prev;
> +	sbi = EXT2_SB(sb);
> +
> +	list_del_init(&ei->i_orphan);
> +
> +	if (prev == &sbi->s_orphan) {
> +		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
> +	} else {
> +		struct inode *i_prev =
> +			&list_entry(prev, struct ext2_inode_info,
> +				    i_orphan)->vfs_inode;
> +		NEXT_ORPHAN(i_prev) = ino_next;
> +		__ext2_mark_inode_dirty(i_prev);
> +	}
> +	__ext2_mark_inode_dirty(inode);
> +	unlock_super(sb);
> +	return;
> +}
> +
>  static int ext2_remount (struct super_block * sb, int * flags, char * data)
>  {
>  	struct ext2_sb_info * sbi = EXT2_SB(sb);
> @@ -993,6 +1286,10 @@
>  	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
>  		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
>  
> +	/* Superblock may have changed on disk, reread into memory copy */
> +
> +	memcpy(sbi->s_esp, sbi->s_sbh->b_data, sbi->s_sbh->b_size);
> +
>  	es = sbi->s_es;
>  	if (((sbi->s_mount_opt & EXT2_MOUNT_XIP) !=
>  	    (old_mount_opt & EXT2_MOUNT_XIP)) &&
> @@ -1125,7 +1422,7 @@
>  
>  		tmp_bh.b_state = 0;
>  		err = ext2_get_block(inode, blk, &tmp_bh, 0);
> -		if (err)
> +		if (err < 0)
>  			return err;
>  		if (!buffer_mapped(&tmp_bh))	/* A hole? */
>  			memset(data, 0, tocopy);
> @@ -1164,7 +1461,7 @@
>  
>  		tmp_bh.b_state = 0;
>  		err = ext2_get_block(inode, blk, &tmp_bh, 1);
> -		if (err)
> +		if (err < 0)
>  			goto out;
>  		if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
>  			bh = sb_bread(sb, tmp_bh.b_blocknr);
> diff -x '*~' -uNr vanilla-linux/fs/ext2/xattr.c uml-clean/fs/ext2/xattr.c
> --- vanilla-linux/fs/ext2/xattr.c	2006-03-24 01:47:33.000000000 -0800
> +++ uml-clean/fs/ext2/xattr.c	2006-03-24 03:01:33.000000000 -0800
> @@ -345,6 +345,7 @@
>  	lock_super(sb);
>  	EXT2_SB(sb)->s_es->s_feature_compat |=
>  		cpu_to_le32(EXT2_FEATURE_COMPAT_EXT_ATTR);
> +	ext2_prepare_super(sb);
>  	sb->s_dirt = 1;
>  	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
>  	unlock_super(sb);
> @@ -688,6 +689,7 @@
>  			
>  			ext2_xattr_update_super_block(sb);
>  		}
> +		ext2_mark_fs_dirty(sb);
>  		mark_buffer_dirty(new_bh);
>  		if (IS_SYNC(inode)) {
>  			sync_dirty_buffer(new_bh);
> @@ -741,6 +743,7 @@
>  			if (ce)
>  				mb_cache_entry_release(ce);
>  			DQUOT_FREE_BLOCK(inode, 1);
> +			ext2_mark_fs_dirty(sb);
>  			mark_buffer_dirty(old_bh);
>  			ea_bdebug(old_bh, "refcount now=%d",
>  				le32_to_cpu(HDR(old_bh)->h_refcount));
> @@ -801,6 +804,7 @@
>  		ea_bdebug(bh, "refcount now=%d",
>  			le32_to_cpu(HDR(bh)->h_refcount));
>  		unlock_buffer(bh);
> +		ext2_mark_fs_dirty(inode->i_sb);
>  		mark_buffer_dirty(bh);
>  		if (IS_SYNC(inode))
>  			sync_dirty_buffer(bh);
> diff -x '*~' -uNr vanilla-linux/include/linux/ext2_fs.h uml-clean/include/linux/ext2_fs.h
> --- vanilla-linux/include/linux/ext2_fs.h	2006-01-02 19:21:10.000000000 -0800
> +++ uml-clean/include/linux/ext2_fs.h	2006-03-24 04:34:00.000000000 -0800
> @@ -29,11 +29,12 @@
>  #undef EXT2FS_DEBUG
>  
>  /*
> - * Define EXT2_PREALLOCATE to preallocate data blocks for expanding files
> + * Define EXT2_RESERVATION to reserve data blocks for expanding files
>   */
> -#define EXT2_PREALLOCATE
> -#define EXT2_DEFAULT_PREALLOC_BLOCKS	8
> -
> +#define EXT2_DEFAULT_RESERVE_BLOCKS     8
> +/*max window size: 1024(direct blocks) + 3([t,d]indirect blocks) */
> +#define EXT2_MAX_RESERVE_BLOCKS         1027
> +#define EXT2_RESERVE_WINDOW_NOT_ALLOCATED 0
>  /*
>   * The second extended file system version
>   */
> @@ -117,6 +118,12 @@
>  #endif
>  
>  /*
> + * Macro for dealing with orphan inode list
> + */
> +
> +#define NEXT_ORPHAN(inode) EXT2_I(inode)->i_dtime
> +
> +/*
>   * Macro-instructions used to manage fragments
>   */
>  #define EXT2_MIN_FRAG_SIZE		1024
> @@ -204,6 +211,8 @@
>  #define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
>  #define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
>  #define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
> +#define	EXT2_IOC_GETRSVSZ		_IOR('f', 5, long)
> +#define	EXT2_IOC_SETRSVSZ		_IOW('f', 6, long)
>  
>  /*
>   * Structure of an inode on the disk
> @@ -296,6 +305,15 @@
>   */
>  #define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
>  #define	EXT2_ERROR_FS			0x0002	/* Errors detected */
> +/*
> + * Bits defining whether the file system is currently clean or not.
> + * Note that in file systems created by old code, the bit would be set
> + * to 0.  To be safe, we must define 0 as dirty and 1 as clean.
> + *
> + * XXX Should convert to state bits, but need to fix fsck first.
> + */
> +#define EXT2_FS_CLEAN			1
> +#define EXT2_FS_DIRTY			0
>  
>  /*
>   * Mount flags
> @@ -313,8 +331,9 @@
>  #define EXT2_MOUNT_XATTR_USER		0x004000  /* Extended user attributes */
>  #define EXT2_MOUNT_POSIX_ACL		0x008000  /* POSIX Access Control Lists */
>  #define EXT2_MOUNT_XIP			0x010000  /* Execute in place */
> -#define EXT2_MOUNT_USRQUOTA		0x020000 /* user quota */
> -#define EXT2_MOUNT_GRPQUOTA		0x040000 /* group quota */
> +#define EXT2_MOUNT_USRQUOTA		0x020000  /* user quota */
> +#define EXT2_MOUNT_GRPQUOTA		0x040000  /* group quota */
> +#define EXT2_MOUNT_RESERVATION		0x080000  /* Preallocation */
>  
> 
>  #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
> @@ -407,7 +426,12 @@
>  	__u16	s_reserved_word_pad;
>  	__le32	s_default_mount_opts;
>   	__le32	s_first_meta_bg; 	/* First metablock block group */
> -	__u32	s_reserved[190];	/* Padding to the end of the block */
> +	__u32	s_journal_reserved[18];	/* Used by ext3 journaling */
> +	__u8	s_fs_dirty;		/* Fs-wide dirty bit */
> +	__u8	s_bytes_reserved[3];	/* Padding */
> +	__u32	s_clean_count;		/* Intervals in which fs was clean */
> +	__u32	s_dirty_count;		/* Intervals in which fs was dirty */
> +	__u32	s_reserved[169];	/* Padding to the end of the block */
>  };
>  
>  /*
> diff -x '*~' -uNr vanilla-linux/include/linux/ext2_fs_sb.h uml-clean/include/linux/ext2_fs_sb.h
> --- vanilla-linux/include/linux/ext2_fs_sb.h	2006-01-02 19:21:10.000000000 -0800
> +++ uml-clean/include/linux/ext2_fs_sb.h	2006-03-24 04:00:53.000000000 -0800
> @@ -18,6 +18,44 @@
>  
>  #include <linux/blockgroup_lock.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/rbtree.h>
> +
> +/* XXX Here for now... not interested in restructing headers JUST now */
> +
> +struct ext2_reserve_window {
> +	__u32			_rsv_start;	/* First byte reserved */
> +	__u32			_rsv_end;	/* Last byte reserved or 0 */
> +};
> +
> +struct ext2_reserve_window_node {
> +	struct rb_node	 	rsv_node;
> +	__u32			rsv_goal_size;
> +	__u32			rsv_alloc_hit;
> +	struct ext2_reserve_window	rsv_window;
> +};
> +
> +struct ext2_block_alloc_info {
> +	/* information about reservation window */
> +	struct ext2_reserve_window_node	rsv_window_node;
> +	/*
> +	 * was i_next_alloc_block in ext2_inode_info
> +	 * is the logical (file-relative) number of the
> +	 * most-recently-allocated block in this file.
> +	 * We use this for detecting linearly ascending allocation requests.
> +	 */
> +	__u32                   last_alloc_logical_block;
> +	/*
> +	 * Was i_next_alloc_goal in ext2_inode_info
> +	 * is the *physical* companion to i_next_alloc_block.
> +	 * it the the physical block number of the block which was most-recentl
> +	 * allocated to this file.  This give us the goal (target) for the next
> +	 * allocation when we detect linearly ascending requests.
> +	 */
> +	__u32                   last_alloc_physical_block;
> +};
> +
> +#define rsv_start rsv_window._rsv_start
> +#define rsv_end rsv_window._rsv_end
>  
>  /*
>   * second extended-fs super-block data in memory
> @@ -34,7 +72,11 @@
>  	unsigned long s_desc_per_block;	/* Number of group descriptors per block */
>  	unsigned long s_groups_count;	/* Number of groups in the fs */
>  	struct buffer_head * s_sbh;	/* Buffer containing the super block */
> -	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
> +	struct ext2_super_block * s_es;	/* Pointer to the in memory super block */
> +	char * s_esp;			/* Pointer to kmalloc'd memory
> +					 * containing ext2_super_block
> +					 * - might be offset inside
> +					 * buffer */
>  	struct buffer_head ** s_group_desc;
>  	unsigned long  s_mount_opt;
>  	uid_t s_resuid;
> @@ -53,6 +95,15 @@
>  	struct percpu_counter s_freeinodes_counter;
>  	struct percpu_counter s_dirs_counter;
>  	struct blockgroup_lock s_blockgroup_lock;
> +	/* root of the per fs reservation window tree */
> +	spinlock_t s_rsv_window_lock;
> +	struct rb_root s_rsv_window_root;
> +	struct ext2_reserve_window_node s_rsv_window_head;
> +
> +	wait_queue_head_t s_wait;
> +	struct list_head s_orphan; /* For quick access to orphan inodes */
> +	int s_dirty_lately;
> +	struct task_struct *s_dirtyd; /* task pointer for dirty thread */
>  };
>  
>  #endif	/* _LINUX_EXT2_FS_SB */
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

