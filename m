Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUJELwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUJELwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268999AbUJELwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:52:15 -0400
Received: from mx01.netapp.com ([198.95.226.53]:36787 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S268995AbUJELvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:51:55 -0400
Message-ID: <41628ACA.2020205@netapp.com>
Date: Tue, 05 Oct 2004 07:51:38 -0400
From: David Wysochanski <davidw@netapp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: akpm@osdl.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI diskIO
References: <4154372C.7070506@netapp.com> <1096937103.6679.4.camel@watt.suse.com>
In-Reply-To: <1096937103.6679.4.camel@watt.suse.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> On Fri, 2004-09-24 at 11:03 -0400, David Wysochanski wrote:
>  > I can reproduce this pretty easily with local disk.
>  >
>  > Here's some details about my setup (attached is the
>  > full kernel config):
>  > - dell 2650 (dual xeon, hyperthreading disabled)
>  > - 1 local SCSI disk (root volume)
>  > - 2 local SCSI disks (data), each with 10 partitions
>  > of 100MB each, 6 of them reiserfs filesystems, 3 of them
>  > ext3, and 3 of them ext2 (total of 20 unique filesystems)
>  > - one instance of test program running on each of the
>  > 20 filesystems
>  >
>  > Sorry, but at this time I can't share the test program itself
>  > (I'm working on that).  Let me try to describe it though.
> 
> I think this is a bug in how reiserfs deals with small filesystems.
> There are a few different cases where it will try to use bitmap #2 even
> when there is only 1 bitmap.  Each of your test filesystems will need
> only 1 bitmap for reiserfs, so while it is a valid bug, it's not the one
> you were originally trying to reproduce.
> 
> This patch should do it (against 2.6.9-rc3).  Thanks to Jan Kara for
> finding this bug.
> 
> -chris
> 
> On small filesystems (<128M), make sure not to reference bitmap blocks that
> don't exist.
> 
> Index: linux.269rc3/fs/reiserfs/bitmap.c
> ===================================================================
> --- linux.269rc3.orig/fs/reiserfs/bitmap.c      2004-08-18 
> 09:38:50.000000000 -0400
> +++ linux.269rc3/fs/reiserfs/bitmap.c   2004-10-04 20:19:42.000000000 -0400
> @@ -236,6 +236,9 @@ static int bmap_hash_id(struct super_blo
>         if (!bm)
>             bm = 1;
>      }
> +    /* this can only be true when SB_BMAP_NR = 1 */
> +    if (bm >= SB_BMAP_NR(s))
> +       bm = 0;
>      return bm;
>  }
>  
> @@ -293,6 +296,10 @@ static int scan_bitmap (struct reiserfs_
>  
>      get_bit_address (s, *start, &bm, &off);
>      get_bit_address (s, finish, &end_bm, &end_off);
> +    if (bm > SB_BMAP_NR(s))
> +        return 0;
> +    if (end_bm > SB_BMAP_NR(s))
> +        end_bm = SB_BMAP_NR(s);
>  
>      /* When the bitmap is more than 10% free, anyone can allocate.
>       * When it's less than 10% free, only files that already use the
> @@ -313,6 +320,7 @@ static int scan_bitmap (struct reiserfs_
>             if (nr_allocated)
>                 goto ret;
>          }
> +       /* we know from above that start is a reasonable number */
>         get_bit_address (s, *start, &bm, &off);
>      }
>  
> @@ -1050,9 +1058,10 @@ int reiserfs_allocate_blocknrs(reiserfs_
>  {
>      int initial_amount_needed = amount_needed;
>      int ret;
> +    struct super_block *s = hint->th->t_super;
>  
>      /* Check if there is enough space, taking into account reserved 
> space */
> -    if ( SB_FREE_BLOCKS(hint->th->t_super) - 
> REISERFS_SB(hint->th->t_super)->reserved_blocks <
> +    if ( SB_FREE_BLOCKS(s) - REISERFS_SB(s)->reserved_blocks <
>          amount_needed - reserved_by_us)
>          return NO_DISK_SPACE;
>      /* should this be if !hint->inode &&  hint->preallocate? */
> @@ -1072,6 +1081,8 @@ int reiserfs_allocate_blocknrs(reiserfs_
>  
>      /* find search start and save it in hint structure */
>      determine_search_start(hint, amount_needed);
> +    if (hint->search_start >= SB_BLOCK_COUNT(s))
> +        hint->search_start = SB_BLOCK_COUNT(s) - 1;
>  
>      /* allocation itself; fill new_blocknrs and preallocation arrays */
>      ret = blocknrs_and_prealloc_arrays_from_search_start
> 
> 
> 
> 

Thanks - will try this patch and let you know.


