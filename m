Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWDMQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWDMQUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWDMQUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:20:36 -0400
Received: from thunk.org ([69.25.196.29]:37860 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750827AbWDMQUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:20:35 -0400
Date: Thu, 13 Apr 2006 12:20:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: sho@tnes.nec.co.jp
Cc: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Message-ID: <20060413162028.GA23452@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, sho@tnes.nec.co.jp,
	Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060413161227sho@rifu.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413161227sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:12:27PM +0900, sho@tnes.nec.co.jp wrote:
> Summary of this patch:
>   [15/21] change the type of variables which manipulate bitmap
>           - Change the type of 4byte variables manipulating bitmap
>             from signed to unsigned.

Generalized NACK.  We can't just blindly change function signatures of
pre-existing functions in libext2fs, since this breaks the ABI with
pre-existing applications linked with current shared libraries of
libext2fs.

We could bump the major version number, but what I'd much rather do is
to create new functions which use the 64-bit blk64_t (i.e.,
ext2fs_mark_block_bitmap2).  This will make the patches much bigger,
but it allows us to preserve backwards compatibility.

> --- e2fsprogs-1.39/lib/ext2fs/bitmaps.c	2005-09-06 18:40:14.000000000 +0900
> +++ e2fsprogs-1.39.tmp/lib/ext2fs/bitmaps.c	2006-04-12 13:27:56.000000000 +0900
>  errcode_t ext2fs_allocate_generic_bitmap(__u32 start,
>  					 __u32 end,
> -					 __u32 real_end,
> +					 __u64 real_end,
>  					 const char *descr,
>  					 ext2fs_generic_bitmap *ret)

Breaks the ABI

> @@ -181,7 +182,7 @@ errcode_t ext2fs_fudge_inode_bitmap_end(
>  }
>  
>  errcode_t ext2fs_fudge_block_bitmap_end(ext2fs_block_bitmap bitmap,
> -					blk_t end, blk_t *oend)
> +					blk64_t end, blk64_t *oend)

Breaks the ABI.

> --- e2fsprogs-1.39/lib/ext2fs/bitops.c	2005-09-06 18:40:14.000000000 +0900
> +++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.c	2006-04-12 13:27:56.000000000 +0900
> @@ -66,26 +66,26 @@ int ext2fs_test_bit(unsigned int nr, con
>  
>  #endif	/* !_EXT2_HAVE_ASM_BITOPS_ */
>  
> -void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
> +void ext2fs_warn_bitmap(errcode_t errcode, unsigned long long arg,

Breaks the ABI

>  void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
> -			    int code, unsigned long arg)
> +			    int code, unsigned long long arg)

Breaks the ABI

> diff -upNr e2fsprogs-1.39/lib/ext2fs/bitops.h e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h
> --- e2fsprogs-1.39/lib/ext2fs/bitops.h	2006-03-30 02:51:53.000000000 +0900
> +++ e2fsprogs-1.39.tmp/lib/ext2fs/bitops.h	2006-04-12 13:28:14.000000000 +0900
> @@ -52,15 +52,15 @@ extern const char *ext2fs_inode_string;
>  extern const char *ext2fs_mark_string;
>  extern const char *ext2fs_unmark_string;
>  extern const char *ext2fs_test_string;
> -extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
> +extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long long arg,
>  			       const char *description);

Breaks the ABI.

>  extern void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
> -				int code, unsigned long arg);
> +				int code, unsigned long long arg);
>  
> -extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
> +extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk64_t block);

Breaks the ABI.

>  extern int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
> -				       blk_t block);
> -extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
> +					blk64_t block);
> +extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk64_t block);
>  

Breaks the ABI.

>  extern int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap, ext2_ino_t inode);
>  extern int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
> @@ -68,11 +68,11 @@ extern int ext2fs_unmark_inode_bitmap(ex
>  extern int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap, ext2_ino_t inode);
>  
>  extern void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
> -					  blk_t block);
> +					  blk64_t block);
>  extern void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,

Breaks the ABI.


> -					    blk_t block);
> +					    blk64_t block);
>  extern int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
> -					 blk_t block);
> +					 blk64_t block);
>  

Breaks the ABI.

>  extern void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
>  					  ext2_ino_t inode);
> @@ -86,24 +86,24 @@ extern blk_t ext2fs_get_block_bitmap_end
>  extern ext2_ino_t ext2fs_get_inode_bitmap_end(ext2fs_inode_bitmap bitmap);
>  
>  extern void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -					   blk_t block, int num);
> +					   blk64_t block, int num);

Breaks the ABI.

>  extern void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -					     blk_t block, int num);
> +					     blk64_t block, int num);

Breaks the ABI.

>  extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -					  blk_t block, int num);
> +					  blk64_t block, int num);

Breaks the ABI.

>  extern void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -						blk_t block, int num);
> +						blk64_t block, int num);

Breaks the ABI.

>  extern void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -						  blk_t block, int num);
> +						  blk64_t block, int num);

Breaks the ABI.

>  extern int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
> -					       blk_t block, int num);
> +					       blk64_t block, int num);

Breaks the ABI.

>  extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
>  
>  /* These two routines moved to gen_bitmap.c */
>  extern int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
> -					 __u32 bitno);
> +					 __u64 bitno);

Breaks the ABI.

>  extern int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
> -					   blk_t bitno);
> +					   blk64_t bitno);

Breaks the ABI.

>  /*
>   * The inline routines themselves...
>   * 
> @@ -391,10 +391,10 @@ _INLINE_ int ext2fs_find_next_bit_set (v
>  #endif	
>  
>  _INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
> -					blk_t bitno);
> +					blk64_t bitno);
>  

Breaks the ABI.


etc....

