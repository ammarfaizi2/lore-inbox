Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWCPCTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWCPCTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWCPCTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:19:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:52439 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751366AbWCPCTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:19:20 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 15 Mar 2006 18:19:16 -0800
Message-Id: <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 21:39 +0900, Takashi Sato wrote:
> Hi,
> 
> As a disk size tends to be larger, some disk storages get to have
> the capacity to supply more than multi-TB recently.  But now ext2/3
> can't support more than 8TB filesystem in 4K-blocksize.  And then I
> think the filesystem size of ext2/3 should be extended.
> 
> I'd like to extend the max filesystem size of ext2/3 from 8TB to 16TB
> by making the number of blocks on ext2/3 extend from 2G-1(2^31-1) to
> 4G-1(2^32-1) as below.

> The max number of blocks is restricted to 2G-1(2^31-1) on ext2/3
> because of the following problems.
> 
Hi Takashi, nice work and summary.

> - The number of blocks is treated as signed 4bytes variable on some
>   codes for ext2/3 in kernel.
> 

Yes, there are a number of places in the ext3/2 code to use int to
represent the block number on disk, especially in block allocation code
e.g. ext3_new_block() returns an int type value for the new allocated
block. It uses "-1" to indicates failure to the caller, and on success
it will return a positive value of int.

When the ext3 block reservation were made into mainline, it continues
uses int type variable for physical block numbers in several places. I
did thought about fix this limitation together with the reservation
change but never get a chance to really work on it.

You changed most of the affected variables from "int" to "unsigned int",
that seems allow block number to address 2^32. It probably a good thing
to consider change the variables to sector_t type, so when the time we
want to support for 64 bit block number, we don't have to re-do the
similar work again.  Laurent did very similar work on this before.


> - Assembler instructions which can't treat more than 2GB is used
>   on some functions related to bit manipulation, like ext2fs_set_bit()
>   and ext2fs_test_bit().  These functions are called through mke2fs
>   on x86 and mc68000 architecture.
> 
> - A block number and an inode number is output with the format
>   string(%d, %ld) in many places on both kernel and commands.
> 

 Besides these limitations, I think there is one more to limit ext3
filesystem size to 8TB

- The superblock format currently stores the number of block groups as a
16-bit integer, and because (on a 4 KB blocksize filesystem) the maximum
number of blocks in a block group is 32,768 , a combination of these
constraints limits the maximum size of the filesystem to 8 TB


> This patch set is composed of two parts, for the kernel and e2fsprogs.
> 
> [1/2] kernel(linux 2.6.16-rc6)
>  - Change signed 4bytes variables for a block number and a inode
>    number, to unsigned.
> 

I noticed that the first patch set combines changes to ext2 filesystem
and changes to ext3 filesystem. It would be nice to split the changes to
two different filesystems.

The changes you made to ext3_new_block() is okey, as the group_block is
a block number relative to the block group, not to the whole filesystem,
and since we will convert the ret_block to the filesystem wide block
number, so keep group_block it as int type is fine. 

But that doesn't fix all th problem. We still have places in ext3 block
reservation code that use int for system-wide block numbers. For e.g.,
alloc_new_reservation(), group_first_block, group_end_block, start_block
 are all filesystem wide block numbers, they need to be changed. I will
check the code more closely tomorrow to see if the changes will break
any assumptions.


Also, I noticed that in your first patch, you changed a few variables
for logical block number from "long" to "unsigned int". Just want to
point out that's a seperate issue- that's for enlarge the file size, not
for expand the max filesystem size.

> diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/inode.c linux-2.6.16-rc6-4g/fs/ext3/inode.c
> --- linux-2.6.16-rc6.org/fs/ext3/inode.c	2006-03-14 09:09:00.000000000 +0900
> +++ linux-2.6.16-rc6-4g/fs/ext3/inode.c	2006-03-14 09:29:01.000000000 +0900

> @@ -235,10 +235,10 @@ no_delete:
>  	clear_inode(inode);	/* We must guarantee clearing of inode... */
>  }
> 
> -static int ext3_alloc_block (handle_t *handle,
> -			struct inode * inode, unsigned long goal, int *err)
> +static unsigned int ext3_alloc_block (handle_t *handle,
> +			struct inode * inode, unsigned int goal, int *err)
>  {

I did some changes in the same code to support ext3 multiple block
allocation. Those patches removed this function ext3_alloc_block(). The
patches are sitting in mm tree now.

BTW, why we change from unsigned long back to unsigned int here?


>  	struct ext3_block_alloc_info *block_i =  EXT3_I(inode)->i_block_alloc_info;
> @@ -505,21 +505,21 @@ static unsigned long ext3_find_goal(stru
>  static int ext3_alloc_branch(handle_t *handle, struct inode *inode,
>  			     int num,
>  			     unsigned long goal,
> -			     int *offsets,
> +			     unsigned int *offsets,
>  			     Indirect *branch)

offsets[] array here store the index position within a indirect block,
where the physical block is stored. The indirect block takes a 4k block,
holds up to 1K entry of physical block numbers, so int type for the
index is good enough.


