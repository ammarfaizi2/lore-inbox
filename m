Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSLMVdA>; Fri, 13 Dec 2002 16:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSLMVdA>; Fri, 13 Dec 2002 16:33:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:48297 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265446AbSLMVc6>;
	Fri, 13 Dec 2002 16:32:58 -0500
Message-ID: <3DFA53DA.DE6788C1@digeo.com>
Date: Fri, 13 Dec 2002 13:40:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
References: <3DFA2D4F.3010301@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2002 21:40:42.0211 (UTC) FILETIME=[491A5B30:01C2A2F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> ..
>     These three changesets implement reiserfs_file_write.

What a big patch.

I'd be interested in testing it a bit.  Could you please
describe under what circumstances the new code paths are
executed?  Is it simply appending to a normal old file?  No
special mount options?


A few little comments, and maybe a security problem....


> +int reiserfs_can_fit_pages ( struct super_block *sb /* superblock of filesystem
> +						       to estimate space */ )
> +{
> +	unsigned long space;
> +
> +	spin_lock(&REISERFS_SB(sb)->bitmap_lock);
> +	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) / ( PAGE_CACHE_SIZE/sb->s_blocksize);
> +	spin_unlock(&REISERFS_SB(sb)->bitmap_lock);
> +
> +	return space;
>  }

Both of the divisions here can be replaced with shifts.  Divides are expensive.

The locking here is peculiar:

	spin_lock(lock);
	value = calculation();
	spin_unlock(lock);
	return value;

Surely, if the calculation relies on the lock then the returned value is invalidated
as soon as you drop the lock?

> -                    offset = le_ih_k_offset( ih ) + (old_len - tb->rbytes );
> +                    offset = le_ih_k_offset( ih ) + (old_len - tb->rbytes )*(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1);

Can use a shift.

> +			  if (is_indirect_le_key(version,B_N_PKEY(tb->R[0],0))){
> +			      temp_rem = (n_rem / UNFM_P_SIZE) * 
> +			                 tb->tb_sb->s_blocksize;

Shift by i_blkbits (all over the place)


> +/* this function from inode.c would be used here, too */
> +extern void restart_transaction(struct reiserfs_transaction_handle *th,
> +                                struct inode *inode, struct path *path);

This decl should be in a header file.

> +
> +/* I really do not want to play with memory shortage right now, so
> +   to simplify the code, we are not going to write more than this much pages at
> +   a time. This still should considerably improve performance compared to 4k
> +   at a time case. */
> +#define REISERFS_WRITE_PAGES_AT_A_TIME 32

Page sizes vary.  A better value may be

	(128 * 1024) / PAGE_CACHE_SIZE

so that consistent behaviour is seem on platforms which have page sizes larger
than 4k.

> +int reiserfs_allocate_blocks_for_region(
> ...
> +    b_blocknr_t allocated_blocks[blocks_to_allocate]; // Pointer to a place where allocated blocknumbers would be stored. Right now statically allocated, later that will change.

This is a variable-sized array (aka: alloca).  It's not a problem IMO, but
worth pointing out...

> +    reiserfs_blocknr_hint_t hint; // hint structure for block allocator.
> +    size_t res; // return value of various functions that we call.
> +    int curr_block; // current block used to keep track of unmapped blocks.
> +    int i; // loop counter
> +    int itempos; // position in item
> +    unsigned int from = (pos & (PAGE_CACHE_SIZE - 1)); // writing position in
> +						       // first page
> +    unsigned int to = ((pos + write_bytes - 1) & (PAGE_CACHE_SIZE - 1)) + 1; /* last modified byte offset in last page */
> +    __u64 hole_size ; // amount of blocks for a file hole, if it needed to be created.
> +    int modifying_this_item = 0; // Flag for items traversal code to keep track
> +				 // of the fact that we already prepared
> +				 // current block for journal

How much stack is this function using, worst-case?

> +    for ( i = 0; i < num_pages; i++) {
> +	prepared_pages[i] = grab_cache_page(mapping, index + i); // locks the page

OK.  But note that locking multiple pages here is only free from AB/BA deadlocks
because this is the only path which does it, and it is singly-threaded via i_sem.

> +	if ( from != 0 ) {/* First page needs to be partially zeroed */
> +	    char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
> +	    memset(kaddr, 0, from);
> +	    kunmap_atomic( kaddr, KM_USER0);
> +	    SetPageUptodate(prepared_pages[0]);
> +	}
> +	if ( to != PAGE_CACHE_SIZE ) { /* Last page needs to be partially zeroed */
> +	    char *kaddr = kmap_atomic(prepared_pages[num_pages-1], KM_USER0);
> +	    memset(kaddr+to, 0, PAGE_CACHE_SIZE - to);
> +	    kunmap_atomic( kaddr, KM_USER0);
> +	    SetPageUptodate(prepared_pages[num_pages-1]);
> +	}

This seems wrong.  This could be a newly-allocated pagecache page.  It is not
yet fully uptodate.  If (say) the subsequent copy_from_user gets a fault then
it appears that this now-uptodate pagecache page will leak uninitialised stuff?

> +			set_bit(BH_Uptodate, &bh->b_state);

set_buffer_uptodate(bh) is more conventional (two instances).

> +		/* We need to mark new file size in case this function will be
> +		   interrupted/aborted later on. And we may do this only for
> +		   holes. */
> +		inode->i_size += inode->i_sb->s_blocksize * blocks_needed;

64-bit multiply, should be a shift.
