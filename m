Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWFZMJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWFZMJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFZMJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:09:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51108 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750807AbWFZMJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:09:22 -0400
Message-ID: <449FCEF7.5060202@in.ibm.com>
Date: Mon, 26 Jun 2006 17:41:35 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ReiserFS Mailing list <reiserfs-list@namesys.com>
Subject: Re: [PATCH 03/04] reiserfs: reorganize bitmap loading functions
References: <20060615014203.GA8216@locomotive.unixthugs.org>
In-Reply-To: <20060615014203.GA8216@locomotive.unixthugs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We hit a BUG while running fsstress tests on 2.6.17-mm1. It looks like 
the BUG was introduced with this code change.

kernel BUG at <bad filename>:50307!
invalid opcode: 0000 [#1]
8K_STACKS PREEMPT SMP DEBUG_PAGEALLOC
last sysfs file: /class/vc/vcsa3/dev
Modules linked in:
CPU:    2
EIP:    0060:[<c01ad42b>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-mm1 #1)
EIP is at reiserfs_cache_bitmap_metadata+0x91/0x9b
eax: ffffffff   ebx: f88061ec   ecx: f71e5000   edx: f7bf4f74
esi: 00001000   edi: 00000000   ebp: f5741b70   esp: f5741b60
ds: 007b   es: 007b   ss: 0068
Process dbench (pid: 12518, ti=f5740000 task=f52f2030 task.ti=f5740000)
Stack: 00000000 f7bf4f74 00001000 c5faea00 f5741b9c c01ad4e1 c5faea00 
f7bf4f74
        f88061ec 00001000 00000000 f88061ec 0000007b f5741c18 c5faea00 
f5741bd8
        c01ab7b6 c5faea00 0000007b 5ed54892 9464a485 542e1a94 00000800 
f88061ec
Call Trace:
  [<c01034c0>] show_stack_log_lvl+0xcc/0xdc
  [<c01036e5>] show_registers+0x1b7/0x22b
  [<c010392e>] die+0x152/0x264
  [<c0103abe>] do_trap+0x7e/0xb4
  [<c0103df4>] do_invalid_op+0xb5/0xbf
  [<c010315d>] error_code+0x39/0x40
  [<c01ad4e1>] reiserfs_read_bitmap_block+0xac/0xf5
  [<c01ab7b6>] scan_bitmap_block+0x56/0x2e0
  [<c01abc98>] scan_bitmap+0x143/0x23d
  [<c01acf9b>] reiserfs_allocate_blocknrs+0x192/0x4d4
  [<c01b9113>] reiserfs_allocate_blocks_for_region+0x227/0x164f
  [<c01bb987>] reiserfs_file_write+0x385/0x826
  [<c016b3f8>] vfs_write+0xc9/0x1a3
  [<c016b695>] sys_pwrite64+0x6d/0x7a
  [<c04a7bf9>] sysenter_past_esp+0x56/0x79
Code: 04 32 66 83 43 02 01 66 89 03 83 ea 01 79 e7 83 ef 01 83 6d f0 08 
83 c1 04
85 ff 7f c5 66 83 3b 00 74 08 83 c4 04 5b
EIP: [<c01ad42b>] reiserfs_cache_bitmap_metadata+0x91/0x9b SS:ESP 
0068:f5741b60


void reiserfs_cache_bitmap_metadata(struct super_block *sb,
                                     struct buffer_head *bh,
                                     struct reiserfs_bitmap_info *info)
{
         unsigned long *cur = (unsigned long *)bh->b_data;
         int i;

         for (i = sb->s_blocksize / sizeof (*cur); i > 0; i--, cur++) {
                 /* 0 and ~0 are special, we can optimize for them */
                 if (*cur == 0) {
                         info->first_zero_hint = i << 3;
                         info->free_count += sizeof (*cur) << 3;
                 } else if (*cur != ~0L) {       /* A mix, investigate */
                         int b;
                         for (b = sizeof (*cur) << 3; b >= 0; b--) {
                                 if (!reiserfs_test_le_bit(b, cur)) {
                                         info->first_zero_hint = (i << 
3) + b;
                                         info->free_count++;
                                 }
                         }
                 }
         }

         /* The first bit must ALWAYS be 1 */
         BUG_ON(info->first_zero_hint == 0); <----- BUG hit here !




Thanks,

Suzuki K P
Linux Technology Center,
IBM Software Labs.

Jeff Mahoney wrote:
>  This patch moves the bitmap loading code from super.c to bitmap.c
> 
>  The code is also restructured somewhat. The only difference between new
>  format bitmaps and old format bitmaps is where they are. That's a two liner
>  before loading the block to use the correct one. There's no need for
>  an entirely separate code path.
> 
>  The load path is generally the same, with the pattern being to throw out a
>  bunch of requests and then wait for them, then cache the metadata from
>  the contents.
> 
>  Again, like the previous patches, the purpose is to set up for later ones.
> 
>  Update: There was a bug in the previously posted version of this that
>  resulted in corruption. The problem was that bitmap 0 on new format file
>  systems must be treated specially, and wasn't. A stupid bug with an easy
>  fix.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> 
> --
>  fs/reiserfs/bitmap.c        |   86 +++++++++++++++++++++++++++++++++
>  fs/reiserfs/resize.c        |    1 
>  fs/reiserfs/super.c         |  114 --------------------------------------------
>  include/linux/reiserfs_fs.h |    4 +
>  4 files changed, 92 insertions(+), 113 deletions(-)
> 
> diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c
> --- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/bitmap.c	2006-05-01 19:46:09.000000000 -0400
> +++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/bitmap.c	2006-05-01 19:46:09.000000000 -0400
> @@ -10,6 +10,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/vmalloc.h>
>  #include <linux/reiserfs_fs_sb.h>
>  #include <linux/reiserfs_fs_i.h>
>  #include <linux/quotaops.h>
> @@ -1286,3 +1287,88 @@ int reiserfs_can_fit_pages(struct super_
>  
>  	return space > 0 ? space : 0;
>  }
> +
> +void reiserfs_cache_bitmap_metadata(struct super_block *sb,
> +                                    struct buffer_head *bh,
> +                                    struct reiserfs_bitmap_info *info)
> +{
> +	unsigned long *cur = (unsigned long *)bh->b_data;
> +	int i;
> +
> +	for (i = sb->s_blocksize / sizeof (*cur); i > 0; i--, cur++) {
> +		/* 0 and ~0 are special, we can optimize for them */
> +		if (*cur == 0) {
> +			info->first_zero_hint = i << 3;
> +			info->free_count += sizeof (*cur) << 3;
> +		} else if (*cur != ~0L) {       /* A mix, investigate */
> +			int b;
> +			for (b = sizeof (*cur) << 3; b >= 0; b--) {
> +				if (!reiserfs_test_le_bit(b, cur)) {
> +					info->first_zero_hint = (i << 3) + b;
> +					info->free_count++;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* The first bit must ALWAYS be 1 */
> +	BUG_ON(info->first_zero_hint == 0);
> +}
> +
> +struct buffer_head *reiserfs_read_bitmap_block(struct super_block *sb,
> +                                               unsigned int bitmap)
> +{
> +	b_blocknr_t block = (sb->s_blocksize << 3) * bitmap;
> +	struct buffer_head *bh;
> +
> +	/* Way old format filesystems had the bitmaps packed up front.
> +	 * I doubt there are any of these left, but just in case... */
> +	if (unlikely(test_bit(REISERFS_OLD_FORMAT,
> +	                      &(REISERFS_SB(sb)->s_properties))))
> +		block = REISERFS_SB(sb)->s_sbh->b_blocknr + 1 + bitmap;
> +	else if (bitmap == 0)
> +		block = (REISERFS_DISK_OFFSET_IN_BYTES >> sb->s_blocksize_bits) + 1;
> +
> +	bh = sb_getblk(sb, block);
> +	if (!buffer_uptodate(bh))
> +		ll_rw_block(READ, 1, &bh);
> +
> +	return bh;
> +}
> +
> +int reiserfs_init_bitmap_cache(struct super_block *sb)
> +{
> +	struct reiserfs_bitmap_info *bitmap;
> +	int i;
> +
> +	bitmap = vmalloc(sizeof (*bitmap) * SB_BMAP_NR(sb));
> +	if (bitmap == NULL)
> +		return -ENOMEM;
> +
> +	memset(bitmap, 0, sizeof (*bitmap) * SB_BMAP_NR(sb));
> +
> +	for (i = 0; i < SB_BMAP_NR(sb); i++)
> +		bitmap[i].bh = reiserfs_read_bitmap_block(sb, i);
> +
> +	/* make sure we have them all */
> +	for (i = 0; i < SB_BMAP_NR(sb); i++) {
> +		wait_on_buffer(bitmap[i].bh);
> +		if (!buffer_uptodate(bitmap[i].bh)) {
> +			reiserfs_warning(sb, "sh-2029: %s: "
> +					 "bitmap block (#%lu) reading failed",
> +			                 __FUNCTION__, bitmap[i].bh->b_blocknr);
> +			for (i = 0; i < SB_BMAP_NR(sb); i++)
> +				brelse(bitmap[i].bh);
> +			vfree(bitmap);
> +			return -EIO;
> +		}
> +	}
> +
> +	/* Cache the info on the bitmaps before we get rolling */
> +	for (i = 0; i < SB_BMAP_NR(sb); i++)
> +		reiserfs_cache_bitmap_metadata(sb, bitmap[i].bh, &bitmap[i]);
> +
> +	SB_AP_BITMAP(sb) = bitmap;
> +
> +	return 0;
> +}
> diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/resize.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/resize.c
> --- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/resize.c	2006-05-01 19:46:09.000000000 -0400
> +++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/resize.c	2006-05-01 19:46:09.000000000 -0400
> @@ -132,6 +132,7 @@ int reiserfs_resize(struct super_block *
>  			get_bh(bh);
>  			memset(bh->b_data, 0, sb_blocksize(sb));
>  			reiserfs_test_and_set_le_bit(0, bh->b_data);
> +			reiserfs_cache_bitmap_metadata(s, bh, bitmap + i);
>  
>  			set_buffer_uptodate(bh);
>  			mark_buffer_dirty(bh);
> diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c
> --- linux-2.6.17-rc3.orig-staging1/fs/reiserfs/super.c	2006-05-01 19:46:08.000000000 -0400
> +++ linux-2.6.17-rc3.orig-staging2/fs/reiserfs/super.c	2006-05-01 19:46:09.000000000 -0400
> @@ -1257,118 +1257,6 @@ static int reiserfs_remount(struct super
>  	return 0;
>  }
>  
> -/* load_bitmap_info_data - Sets up the reiserfs_bitmap_info structure from disk.
> - * @sb - superblock for this filesystem
> - * @bi - the bitmap info to be loaded. Requires that bi->bh is valid.
> - *
> - * This routine counts how many free bits there are, finding the first zero
> - * as a side effect. Could also be implemented as a loop of test_bit() calls, or
> - * a loop of find_first_zero_bit() calls. This implementation is similar to
> - * find_first_zero_bit(), but doesn't return after it finds the first bit.
> - * Should only be called on fs mount, but should be fairly efficient anyways.
> - *
> - * bi->first_zero_hint is considered unset if it == 0, since the bitmap itself
> - * will * invariably occupt block 0 represented in the bitmap. The only
> - * exception to this is when free_count also == 0, since there will be no
> - * free blocks at all.
> - */
> -
> -static void load_bitmap_info_data(struct super_block *sb,
> -				  struct reiserfs_bitmap_info *bi)
> -{
> -	unsigned long *cur = (unsigned long *)bi->bh->b_data;
> -
> -	while ((char *)cur < (bi->bh->b_data + sb->s_blocksize)) {
> -
> -		/* No need to scan if all 0's or all 1's.
> -		 * Since we're only counting 0's, we can simply ignore all 1's */
> -		if (*cur == 0) {
> -			if (bi->first_zero_hint == 0) {
> -				bi->first_zero_hint =
> -				    ((char *)cur - bi->bh->b_data) << 3;
> -			}
> -			bi->free_count += sizeof(unsigned long) * 8;
> -		} else if (*cur != ~0L) {
> -			int b;
> -			for (b = 0; b < sizeof(unsigned long) * 8; b++) {
> -				if (!reiserfs_test_le_bit(b, cur)) {
> -					bi->free_count++;
> -					if (bi->first_zero_hint == 0)
> -						bi->first_zero_hint =
> -						    (((char *)cur -
> -						      bi->bh->b_data) << 3) + b;
> -				}
> -			}
> -		}
> -		cur++;
> -	}
> -
> -#ifdef CONFIG_REISERFS_CHECK
> -// This outputs a lot of unneded info on big FSes
> -//    reiserfs_warning ("bitmap loaded from block %d: %d free blocks",
> -//                    bi->bh->b_blocknr, bi->free_count);
> -#endif
> -}
> -
> -static int read_bitmaps(struct super_block *s)
> -{
> -	int i, bmap_nr;
> -
> -	SB_AP_BITMAP(s) =
> -	    vmalloc(sizeof(struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
> -	if (SB_AP_BITMAP(s) == 0)
> -		return 1;
> -	memset(SB_AP_BITMAP(s), 0,
> -	       sizeof(struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
> -	for (i = 0, bmap_nr =
> -	     REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
> -	     i < SB_BMAP_NR(s); i++, bmap_nr = s->s_blocksize * 8 * i) {
> -		SB_AP_BITMAP(s)[i].bh = sb_getblk(s, bmap_nr);
> -		if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh))
> -			ll_rw_block(READ, 1, &SB_AP_BITMAP(s)[i].bh);
> -	}
> -	for (i = 0; i < SB_BMAP_NR(s); i++) {
> -		wait_on_buffer(SB_AP_BITMAP(s)[i].bh);
> -		if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
> -			reiserfs_warning(s, "sh-2029: reiserfs read_bitmaps: "
> -					 "bitmap block (#%lu) reading failed",
> -					 SB_AP_BITMAP(s)[i].bh->b_blocknr);
> -			for (i = 0; i < SB_BMAP_NR(s); i++)
> -				brelse(SB_AP_BITMAP(s)[i].bh);
> -			vfree(SB_AP_BITMAP(s));
> -			SB_AP_BITMAP(s) = NULL;
> -			return 1;
> -		}
> -		load_bitmap_info_data(s, SB_AP_BITMAP(s) + i);
> -	}
> -	return 0;
> -}
> -
> -static int read_old_bitmaps(struct super_block *s)
> -{
> -	int i;
> -	struct reiserfs_super_block *rs = SB_DISK_SUPER_BLOCK(s);
> -	int bmp1 = (REISERFS_OLD_DISK_OFFSET_IN_BYTES / s->s_blocksize) + 1;	/* first of bitmap blocks */
> -
> -	/* read true bitmap */
> -	SB_AP_BITMAP(s) =
> -	    vmalloc(sizeof(struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
> -	if (SB_AP_BITMAP(s) == 0)
> -		return 1;
> -
> -	memset(SB_AP_BITMAP(s), 0,
> -	       sizeof(struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
> -
> -	for (i = 0; i < sb_bmap_nr(rs); i++) {
> -		SB_AP_BITMAP(s)[i].bh = sb_bread(s, bmp1 + i);
> -		if (!SB_AP_BITMAP(s)[i].bh)
> -			return 1;
> -		load_bitmap_info_data(s, SB_AP_BITMAP(s) + i);
> -	}
> -
> -	return 0;
> -}
> -
>  static int read_super_block(struct super_block *s, int offset)
>  {
>  	struct buffer_head *bh;
> @@ -1750,7 +1638,7 @@ static int reiserfs_fill_super(struct su
>  	sbi->s_mount_state = SB_REISERFS_STATE(s);
>  	sbi->s_mount_state = REISERFS_VALID_FS;
>  
> -	if (old_format ? read_old_bitmaps(s) : read_bitmaps(s)) {
> +	if ((errval = reiserfs_init_bitmap_cache(s))) {
>  		SWARN(silent, s,
>  		      "jmacd-8: reiserfs_fill_super: unable to read bitmap");
>  		goto error;
> diff -ruNpX ../dontdiff linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs.h linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs.h
> --- linux-2.6.17-rc3.orig-staging1/include/linux/reiserfs_fs.h	2006-05-01 19:45:36.000000000 -0400
> +++ linux-2.6.17-rc3.orig-staging2/include/linux/reiserfs_fs.h	2006-05-01 19:46:09.000000000 -0400
> @@ -2081,6 +2081,10 @@ void reiserfs_init_alloc_options(struct 
>   */
>  __le32 reiserfs_choose_packing(struct inode *dir);
>  
> +int reiserfs_init_bitmap_cache(struct super_block *sb);
> +void reiserfs_free_bitmap_cache(struct super_block *sb);
> +void reiserfs_cache_bitmap_metadata(struct super_block *sb, struct buffer_head *bh, struct reiserfs_bitmap_info *info);
> +struct buffer_head *reiserfs_read_bitmap_block(struct super_block *sb, unsigned int bitmap);
>  int is_reusable(struct super_block *s, b_blocknr_t block, int bit_value);
>  void reiserfs_free_block(struct reiserfs_transaction_handle *th, struct inode *,
>  			 b_blocknr_t, int for_unformatted);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
