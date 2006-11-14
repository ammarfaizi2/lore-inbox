Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755237AbWKNLYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbWKNLYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbWKNLYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:24:47 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:19507 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755237AbWKNLYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:24:46 -0500
Date: Tue, 14 Nov 2006 12:23:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: dm: possible recursive locking detected
Message-ID: <20061114112351.GD7091@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the git tree as of today I get the following:

=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc5-g0579e303-dirty #22
---------------------------------------------
kpartx/933 is trying to acquire lock:
 (&md->io_lock){----}, at: [<000000000023167e>] dm_request+0x52/0x25c

but task is already holding lock:
 (&md->io_lock){----}, at: [<000000000023167e>] dm_request+0x52/0x25c

other info that might help us debug this:
1 lock held by kpartx/933:
 #0:  (&md->io_lock){----}, at: [<000000000023167e>] dm_request+0x52/0x25c

stack backtrace:
0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 00000000003e2a42 00000000003e2a42 0000000000016272 
       040000000d437280 000000000071f408 0000000000000000 00000000004bd620 
       0000000000000000 000000000000000d 000000000d437380 000000000d4373f8 
       00000000003ab450 0000000000016272 000000000d437380 000000000d4373d0 
Call Trace:
([<00000000000161d8>] show_trace+0xc0/0xdc)
 [<0000000000016294>] show_stack+0xa0/0xd0
 [<00000000000162f2>] dump_stack+0x2e/0x3c
 [<000000000006326c>] __lock_acquire+0xa80/0xeac
 [<0000000000063c38>] lock_acquire+0x90/0xc0
 [<000000000005d568>] down_read+0x54/0x9c
 [<000000000023167e>] dm_request+0x52/0x25c
 [<00000000001b0364>] generic_make_request+0x174/0x1fc
 [<0000000000230fb2>] __map_bio+0x7e/0xec
 [<0000000000231608>] __split_bio+0x510/0x534
 [<0000000000231830>] dm_request+0x204/0x25c
 [<00000000001b0364>] generic_make_request+0x174/0x1fc
 [<00000000001b04ae>] submit_bio+0xc2/0x18c
 [<00000000000d72b4>] submit_bh+0x13c/0x1d8
 [<00000000000da210>] block_read_full_page+0x3f0/0x470
 [<00000000000dcb94>] blkdev_readpage+0x30/0x40
 [<000000000008320c>] __do_page_cache_readahead+0x190/0x300
 [<000000000008354a>] blockable_page_cache_readahead+0x7a/0x104
 [<0000000000083988>] page_cache_readahead+0x29c/0x328
 [<000000000007ad20>] do_generic_mapping_read+0x428/0x51c
 [<000000000007d4d0>] generic_file_aio_read+0x160/0x244
 [<00000000000a9560>] do_sync_read+0xd8/0x130
 [<00000000000a9660>] vfs_read+0xa8/0x188
 [<00000000000a9a4e>] sys_read+0x56/0x88
 [<0000000000020d40>] sysc_noemu+0x10/0x16
 [<000002000011fd18>] 0x2000011fd18

It probably just misses some annotation, but would be good to have this fixed
before 2.6.19.

Btw.: seeing these recursive calls again makes me remember that there is
still md-dm-reduce-stack-usage-with-stacked-block-devices.patch in the
-mm tree.
Any chance that that one will ever move to Linus' repository?
