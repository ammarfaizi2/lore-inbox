Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBZWqu>; Mon, 26 Feb 2001 17:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbRBZWql>; Mon, 26 Feb 2001 17:46:41 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:13832 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129212AbRBZWqb>;
	Mon, 26 Feb 2001 17:46:31 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 26 Feb 2001 22:46:06 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Chris Mason <mason@suse.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        reiserfs-list@namesys.com
Subject: Re: [PATCH] Re: reiserfs: still problems with tail conversion
In-Reply-To: <1136530000.983155244@tiny>
Message-ID: <Pine.LNX.4.21.0102262244330.13559-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, 
 it works nicely here (i586, 32Mb, Red Hat's gcc-2.96-69). Thanks.
  Ken

On Sun, 25 Feb 2001, Chris Mason wrote:

> 
> Hi guys,
> 
> This patch should take care of the other cause for null bytes
> in small files.  It has been through a few hours of testing,
> with some of the usual load programs + Erik's code concurrently.
> 
> I'll let things run overnight to try and find more bugs.  The
> patch is against 2.4.2, and does a few things:
> 
> don't dirty the direct->indirect target until all direct items
> have been copied in.  Before it was dirtied for each direct item.
> 
> make the target up to date before dirtying (it was done after).
> 
> don't try to zero the unused part of the target until all bytes
> have been copied.  This was the big bug, it was zeroing previously
> copied bytes.
> 
> Any testing on non-production machines would be appreciated,
> I'll forward to Linus/Alan once I've gotten more feedback.
> 
> -chris
> 
> diff -ur diff/linux/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
> --- diff/linux/fs/reiserfs/inode.c	Tue Jan 16 14:14:22 2001
> +++ linux/fs/reiserfs/inode.c	Sun Feb 25 16:25:31 2001
> @@ -771,6 +771,7 @@
>  	    ** flush unbh before the transaction commits
>  	    */
>  	    reiserfs_add_page_to_flush_list(&th, inode, unbh) ;
> +	    mark_buffer_dirty(unbh) ;
>  		  
>  	    //inode->i_blocks += inode->i_sb->s_blocksize / 512;
>  	    //mark_tail_converted (inode);
> diff -ur diff/linux/fs/reiserfs/stree.c linux/fs/reiserfs/stree.c
> --- diff/linux/fs/reiserfs/stree.c	Mon Jan 15 18:31:19 2001
> +++ linux/fs/reiserfs/stree.c	Sun Feb 25 16:25:31 2001
> @@ -1438,7 +1438,6 @@
>  
>      if ( p_s_un_bh )  {
>  	int off;
> -        int block_off ;
>          char *data ;
>  
>  	/* We are in direct2indirect conversion, so move tail contents
> @@ -1452,7 +1451,8 @@
>  	** the unformatted node, which might schedule, meaning we'd have to
>  	** loop all the way back up to the start of the while loop.
>  	**
> -	** The unformatted node is prepared and logged after the do_balance.
> +	** The unformatted node must be dirtied later on.  We can't be
> +	** sure here if the entire tail has been deleted yet.
>          **
>          ** p_s_un_bh is from the page cache (all unformatted nodes are
>          ** from the page cache) and might be a highmem page.  So, we
> @@ -1463,24 +1463,12 @@
>  
>          data = page_address(p_s_un_bh->b_page) ;
>  	off = ((le_ih_k_offset (&s_ih) - 1) & (PAGE_CACHE_SIZE - 1));
> -        block_off = off & (p_s_un_bh->b_size - 1) ;
>  	memcpy(data + off,
>  	       B_I_PITEM(PATH_PLAST_BUFFER(p_s_path), &s_ih), n_ret_value);
> -
> -	/* clear out the rest of the block past the end of the file. */
> -	if (block_off + n_ret_value < p_s_un_bh->b_size) {
> -	    memset(data + off + n_ret_value, 0, 
> -		   p_s_un_bh->b_size - block_off - n_ret_value) ;
> -	}
>      }
>  
>      /* Perform balancing after all resources have been collected at once. */ 
>      do_balance(&s_del_balance, NULL, NULL, M_DELETE);
> -
> -    /* see comment above for why this is after the do_balance */
> -    if (p_s_un_bh) {
> -        mark_buffer_dirty(p_s_un_bh) ;
> -    }
>  
>      /* Return deleted body length */
>      return n_ret_value;
> diff -ur diff/linux/fs/reiserfs/tail_conversion.c linux/fs/reiserfs/tail_conversion.c
> --- diff/linux/fs/reiserfs/tail_conversion.c	Mon Feb 19 13:07:32 2001
> +++ linux/fs/reiserfs/tail_conversion.c	Sun Feb 25 19:42:54 2001
> @@ -32,6 +32,7 @@
>      struct super_block * sb = inode->i_sb;
>      struct buffer_head *up_to_date_bh ;
>      struct item_head * p_le_ih = PATH_PITEM_HEAD (path);
> +    unsigned long total_tail = 0 ;
>      struct cpu_key end_key;  /* Key to search for the last byte of the
>  				converted item. */
>      struct item_head ind_ih; /* new indirect item to be inserted or
> @@ -121,10 +122,19 @@
>  	n_retval = reiserfs_delete_item (th, path, &end_key, inode, 
>  	                                 up_to_date_bh) ;
>  
> +	total_tail += n_retval ;
>  	if (tail_size == n_retval)
>  	    // done: file does not have direct items anymore
>  	    break;
>  
> +    }
> +    /* if we've copied bytes from disk into the page, we need to zero
> +    ** out the unused part of the block (it was not up to date before)
> +    ** the page is still kmapped (by whoever called reiserfs_get_block)
> +    */
> +    if (up_to_date_bh) {
> +        unsigned pgoff = (tail_offset + total_tail - 1) & (PAGE_CACHE_SIZE - 1);
> +	memset(page_address(unbh->b_page) + pgoff, 0, n_blk_size - total_tail) ;
>      }
>  
>      inode->u.reiserfs_i.i_first_direct_byte = U32_MAX;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

