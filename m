Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUKWU6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUKWU6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKWUvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:51:41 -0500
Received: from bender.bawue.de ([193.7.176.20]:60895 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261232AbUKWUsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:48:41 -0500
Date: Tue, 23 Nov 2004 21:48:32 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Phil Dier <phil@dier.us>
Subject: Re: oops with dual xeon 2.8ghz 4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041123204832.GA11644@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Phil Dier <phil@dier.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I'm setting up a storage array with Linux, software RAID, LVM, and XFS,
>but I keep getting oopses during heavy I/O. I've been able to reproduce
>this with 2.6.6, 2.6.8.1, 2.6.9, and 2.6.10-rc2-bk4. I have dual xeon
>2.8s with 4gb of ram. I'm using adaptec and a fusion mpt scsi devices
>(more details in the following link). Connected are 2 ultra160 scsi
>jbods w/ 2 disks apiece. I'm using raid 10 (or should it be 01?) mirrored 
>stripes.

This looks very interesting.  My setup is somehow similar:
linux 2.6.9-ac8, SMP (2 x Athlon), Adaptec 2940UW + Promise SATA150 TX4,
4K stacks, software RAID, LVM and XFS.  The symptoms are different,
however.  When creating snapshots I get sometimes errors like this,
(which I'm unable to reproduce):

Nov 21 03:00:48 bear kernel:  [__alloc_pages+457/912] __alloc_pages+0x1c9/0x390
Nov 21 03:00:48 bear kernel:  [check_poison_obj+47/480] check_poison_obj+0x2f/0x1e0
Nov 21 03:00:48 bear kernel:  [__get_free_pages+37/64] __get_free_pages+0x25/0x40
Nov 21 03:00:48 bear kernel:  [kmem_getpages+33/208] kmem_getpages+0x21/0xd0
Nov 21 03:00:48 bear kernel:  [dbg_redzone1+21/48] dbg_redzone1+0x15/0x30
Nov 21 03:00:48 bear kernel:  [cache_grow+176/352] cache_grow+0xb0/0x160
Nov 21 03:00:48 bear kernel:  [cache_alloc_refill+428/640] cache_alloc_refill+0x1ac/0x280
Nov 21 03:00:48 bear kernel:  [__kmalloc+188/240] __kmalloc+0xbc/0xf0
Nov 21 03:00:48 bear kernel:  [mempool_resize+156/416] mempool_resize+0x9c/0x1a0
Nov 21 03:00:48 bear kernel:  [resize_pool+100/224] resize_pool+0x64/0xe0
Nov 21 03:00:48 bear kernel:  [dm_create_persistent+40/320] dm_create_persistent+0x28/0x140
Nov 21 03:00:48 bear kernel:  [snapshot_ctr+804/912] snapshot_ctr+0x324/0x390
Nov 21 03:00:48 bear kernel:  [dm_table_add_target+262/432] dm_table_add_target+0x106/0x1b0
Nov 21 03:00:48 bear kernel:  [populate_table+130/224] populate_table+0x82/0xe0
Nov 21 03:00:48 bear kernel:  [table_load+104/320] table_load+0x68/0x140
Nov 21 03:00:48 bear kernel:  [ctl_ioctl+241/336] ctl_ioctl+0xf1/0x150
Nov 21 03:00:48 bear kernel:  [table_load+0/320] table_load+0x0/0x140
Nov 21 03:00:48 bear kernel:  [sys_ioctl+253/640] sys_ioctl+0xfd/0x280
Nov 21 03:00:48 bear kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 21 03:00:48 bear kernel: device-mapper: : Couldn't create exception store
Nov 21 03:00:48 bear kernel:
Nov 21 03:00:48 bear kernel: device-mapper: error adding target to table

When I tried the sample script (modified according to the size of the
FS) nothing happened at first.  But creating snapshots in parallel
locked up the system after a while. (Hard lockup, no diagnostic data
available.)

I switched to 8K stacks then. Running the sample and creating snapshots
didn't lock up, but resulted in a similar error as shown above:

Nov 23 20:46:33 bear kernel: lvcreate: page allocation failure. order:0, mode:0xd0
Nov 23 20:46:33 bear kernel:  [__alloc_pages+457/912] __alloc_pages+0x1c9/0x390
Nov 23 20:46:33 bear kernel:  [__get_free_pages+37/64] __get_free_pages+0x25/0x40
Nov 23 20:46:33 bear kernel:  [kmem_getpages+33/208] kmem_getpages+0x21/0xd0
Nov 23 20:46:33 bear kernel:  [cache_grow+176/352] cache_grow+0xb0/0x160
Nov 23 20:46:33 bear kernel:  [check_slabp+24/240] check_slabp+0x18/0xf0
Nov 23 20:46:33 bear kernel:  [cache_alloc_refill+428/640] cache_alloc_refill+0x1ac/0x280
Nov 23 20:46:33 bear kernel:  [dbg_redzone1+21/48] dbg_redzone1+0x15/0x30
Nov 23 20:46:33 bear kernel:  [cache_alloc_debugcheck_after+65/368] cache_alloc_debugcheck_after+0x41/0x170
Nov 23 20:46:33 bear kernel:  [kmem_cache_alloc+149/192] kmem_cache_alloc+0x95/0xc0
Nov 23 20:46:33 bear kernel:  [alloc_io+34/48] alloc_io+0x22/0x30
Nov 23 20:46:33 bear kernel:  [alloc_io+34/48] alloc_io+0x22/0x30
Nov 23 20:46:33 bear kernel:  [mempool_resize+284/416] mempool_resize+0x11c/0x1a0
Nov 23 20:46:34 bear kernel:  [resize_pool+100/224] resize_pool+0x64/0xe0
Nov 23 20:46:34 bear kernel:  [kcopyd_client_create+134/208] kcopyd_client_create+0x86/0xd0
Nov 23 20:46:34 bear kernel:  [snapshot_ctr+700/912] snapshot_ctr+0x2bc/0x390
Nov 23 20:46:34 bear kernel:  [dm_table_add_target+262/432] dm_table_add_target+0x106/0x1b0
Nov 23 20:46:34 bear kernel:  [populate_table+130/224] populate_table+0x82/0xe0
Nov 23 20:46:34 bear kernel:  [table_load+104/320] table_load+0x68/0x140
Nov 23 20:46:34 bear kernel:  [ctl_ioctl+241/336] ctl_ioctl+0xf1/0x150
Nov 23 20:46:34 bear kernel:  [table_load+0/320] table_load+0x0/0x140
Nov 23 20:46:35 bear kernel:  [sys_ioctl+253/640] sys_ioctl+0xfd/0x280
Nov 23 20:46:36 bear kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Maybe these issues are not related.  If they are I'd be glad to support
with some additional testing.

-jo

