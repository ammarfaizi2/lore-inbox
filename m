Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRCUHIi>; Wed, 21 Mar 2001 02:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCUHI2>; Wed, 21 Mar 2001 02:08:28 -0500
Received: from linuxcare.com.au ([203.29.91.49]:61704 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131221AbRCUHIW>; Wed, 21 Mar 2001 02:08:22 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 21 Mar 2001 18:06:07 +1100
To: linux-kernel@vger.kernel.org
Subject: spinlock usage - ext2_get_block, lru_list_lock
Message-ID: <20010321180607.A11941@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I ported lockmeter to PPC and ran a few dbench runs on a quad CPU F50 here.
These runs were made to never hit the disk. The full results can be found
here:

http://samba.org/~anton/ppc/lockmeter/2.4.3-pre3_hacked/

It was not surprising the BKL was one of the main offenders. Looking at the
stats ext2_get_block was the bad guy (UTIL is % of time lock was busy for,
WAIT is time spent waiting for lock):

SPINLOCKS         HOLD           WAIT
  UTIL  CON    MEAN(  MAX )  MEAN(  MAX )( %CPU)   TOTAL NAME
 38.8% 41.0%  7.6us(  31ms)  15us(  18ms)( 7.7%) 1683368 kernel_flag
 0.87%  9.1%   13ms(  31ms) 129us( 231us)(0.00%)      22  do_exit+0x120
  2.6% 21.6%   45us(2103us)  79us(  18ms)(0.25%)   19240  ext2_delete_inode+0x34
 0.32% 24.8%  1.2us(  46us)  14us( 992us)(0.25%)   92415  ext2_discard_prealloc+0x34

 29.2% 50.9%   10us( 400us)  15us( 892us)( 5.4%)  957740  ext2_get_block+0x64

 0.40% 32.8%   18us( 208us)  31us(  11ms)(0.06%)    7435  lookup_hash+0xb0
 0.09% 17.3%   11us( 139us)  17us( 237us)(0.01%)    2560  notify_change+0x8c
 0.01% 17.3%   34us( 138us) 912us(  11ms)(0.01%)      81  real_lookup+0x94
 0.02% 39.5%   34us( 344us)  47us( 331us)(0.00%)     172  schedule+0x4fc
 0.00% 15.4%   11us(  37us)  14us(  22us)(0.00%)      26  sys_ioctl+0x50
  1.1% 28.7%  0.7us( 131us)  12us( 910us)( 1.5%)  559700  sys_lseek+0x90
 0.56% 25.8%   48us( 245us)  12us( 162us)(0.01%)    3900  sys_rename+0x1fc
 0.03% 25.0%   24us(  43us)  64us(1004us)(0.00%)     400  tty_read+0xd4
 0.07% 24.1%   31us(  64us)  17us( 293us)(0.00%)     776  tty_write+0x234
  2.0% 32.5%   35us( 267us)  13us( 504us)(0.06%)   19220  vfs_create+0xd0
 0.29% 76.5%  437us( 533us)  25us( 456us)(0.00%)     221  vfs_mkdir+0xd0
 0.05% 19.2%   65us( 285us) 460us(9017us)(0.02%)     240  vfs_rmdir+0x208
  1.1% 23.2%   19us( 236us)  17us( 819us)(0.06%)   19220  vfs_unlink+0x188

It can be also seen that do_exit grabbed the BKL for way too long. Another
large waster of cpu time was the lru_list_lock:

SPINLOCKS         HOLD           WAIT
  UTIL  CON    MEAN(  MAX )  MEAN(  MAX )( %CPU)   TOTAL NAME
 25.8% 27.0%  1.6us( 169us) 8.9us( 446us)( 9.5%) 5281025 lru_list_lock
 0.07% 33.0%  2.9us(  34us)  11us( 293us)(0.02%)    8051  __bforget+0x20
  1.7% 14.6%  0.3us(  44us) 5.2us( 265us)( 1.1%) 1870792  buffer_insert_inode_queue+0x24
  7.3% 13.6%  1.9us( 169us) 5.5us( 278us)(0.70%) 1239163  getblk+0x28
 0.00% 58.8%  1.0us( 4.5us)  13us( 142us)(0.00%)     221  invalidate_inode_buffers+0x20
 10.0% 45.5%  1.7us( 134us)  10us( 446us)( 6.6%) 1920438  refile_buffer+0x20
  6.7% 45.2%  9.2us( 149us)  14us( 330us)( 1.2%)  242360  try_to_free_buffers+0x44

I began smashing up lru_list_lock but found a few problems. With a name
like lru_list_lock, you would expect it to only synchronise operations to
lru_list[]. However I find things like:

int inode_has_buffers(struct inode *inode)
{
        int ret;

        spin_lock(&lru_list_lock);
        ret = !list_empty(&inode->i_dirty_buffers);
        spin_unlock(&lru_list_lock);

        return ret;
}

It also looks to be protecting some of the items in the buffer_head struct.
Is the lru_list_lock spinlock usage documented anywhere?

Cheers,
Anton
