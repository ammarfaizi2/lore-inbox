Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946026AbWGOLRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946026AbWGOLRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 07:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWGOLRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 07:17:35 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24480 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932506AbWGOLRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 07:17:34 -0400
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@linux.intel.com>, dm-devel@redhat.com
Subject: lockdep warning when nesting dm devices
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2006 13:17:29 +0200
Message-ID: <m34pxj6rsm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I run this as root:

# dd if=/dev/zero of=tmpfile bs=1M count=10
# /sbin/losetup -f ./tmpfile
# echo "0 10000 linear /dev/loop0 0" | /sbin/dmsetup create test
# echo "0 10000 linear /dev/mapper/test 0" | /sbin/dmsetup create test2

I get the following warning from the lockdep validator.

Btw, is there a limit on how many dm devices can be chained? I guess
there will be a kernel stack overflow if you try to chain together too
many devices.

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
vol_id/2468 is trying to acquire lock:
 (&md->io_lock){----}, at: [<e08475b6>] dm_request+0x23/0x158 [dm_mod]

but task is already holding lock:
 (&md->io_lock){----}, at: [<e08475b6>] dm_request+0x23/0x158 [dm_mod]

other info that might help us debug this:
1 lock held by vol_id/2468:
 #0:  (&md->io_lock){----}, at: [<e08475b6>] dm_request+0x23/0x158 [dm_mod]

stack backtrace:
 [<c01041bc>] show_trace_log_lvl+0x133/0x14d
 [<c01048e4>] show_trace+0x1b/0x1d
 [<c01049b2>] dump_stack+0x26/0x28
 [<c0134b92>] __lock_acquire+0x8aa/0xd29
 [<c013535e>] lock_acquire+0x68/0x83
 [<c01314ff>] down_read+0x50/0x60
 [<e08475b6>] dm_request+0x23/0x158 [dm_mod]
 [<c01e02e8>] generic_make_request+0x94/0x322
 [<e084649a>] __map_bio+0x75/0x130 [dm_mod]
 [<e08472e0>] __split_bio+0x382/0x3c1 [dm_mod]
 [<e0847670>] dm_request+0xdd/0x158 [dm_mod]
 [<c01e02e8>] generic_make_request+0x94/0x322
 [<c01e2a3b>] submit_bio+0x6f/0x112
 [<c01647a1>] submit_bh+0xce/0x11f
 [<c0167902>] block_read_full_page+0x26c/0x2e2
 [<c016a74a>] blkdev_readpage+0x19/0x1b
 [<c014c5ba>] __do_page_cache_readahead+0x1bf/0x28a
 [<c014c6e2>] blockable_page_cache_readahead+0x5d/0xc4
 [<c014c961>] page_cache_readahead+0x176/0x1bc
 [<c01466c7>] do_generic_mapping_read+0x49d/0x50d
 [<c0147084>] __generic_file_aio_read+0xfd/0x22c
 [<c0148491>] generic_file_read+0x9e/0xbe
 [<c0163460>] vfs_read+0x98/0x115
 [<c0163869>] sys_read+0x47/0x6e
 [<c0103069>] sysenter_past_esp+0x56/0x8d
 [<b7f79410>] 0xb7f79410

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
