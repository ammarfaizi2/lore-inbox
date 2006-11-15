Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWKOP5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWKOP5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWKOP5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:57:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:60901 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030565AbWKOP5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:57:36 -0500
Subject: pagefault in generic_file_buffered_write() causing deadlock
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, linux-mm <linux-mm@kvack.org>
Cc: ext4 <linux-ext4@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 07:57:45 -0800
Message-Id: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & MM experts,

We are looking at a customer situation (on 2.6.16-based distro) - where
system becomes almost useless while running some java & stress tests.

Root cause seems to be taking a pagefault in generic_file_buffered_write
() after calling prepare_write. I am wondering 

1) Why & How this can happen - since we made sure to fault the user
buffer before prepare write.

2) If this is already fixed in current mainline (I can't see how).

Ideas on what I can do to fix it ?

Thanks,
Badari

Here is the analysis & stacks:
===============================

Java thread doing mmap() holding for mmap_sem and waiting for
transaction to be unlocked:

java          D 000000000fed3ff4  7104  2447   2391          2448  2446
(NOTLB)
Call Trace:
[C00000002AC8F410] [C000000001315AC0] 0xc000000001315ac0 (unreliable)
[C00000002AC8F5E0] [C00000000000F0B4] .__switch_to+0x12c/0x150
[C00000002AC8F670] [C00000000039980C] .schedule+0xcec/0xe4c
[C00000002AC8F780] [C00000000017BC24] .start_this_handle+0x3b4/0x4ac
[C00000002AC8F8A0] [C00000000017BE08] .journal_start+0xec/0x140
[C00000002AC8F940] [C000000000171374] .ext3_journal_start_sb+0x58/0x78
[C00000002AC8F9C0] [C00000000016AB90] .ext3_dirty_inode+0x38/0xb0
[C00000002AC8FA50] [C0000000000F6820] .__mark_inode_dirty+0x60/0x1d4
[C00000002AC8FAF0] [C0000000000E9F60] .touch_atime+0xc8/0xe0
[C00000002AC8FB80] [C000000000093834] .generic_file_mmap+0x54/0x80
[C00000002AC8FC00] [C0000000000AC450] .do_mmap_pgoff+0x558/0x870
[C00000002AC8FD10] [C00000000000A9C0] .sys_mmap+0xdc/0x160
[C00000002AC8FDC0] [C000000000014258] .compat_sys_mmap2+0x14/0x28
[C00000002AC8FE30] [C00000000000871C] syscall_exit+0x0/0x40


kjournald locked the transaction and waiting for journal stop
(t_updates to go to zero):

kjournald     D 0000000000000000  8704  2167      1          2203  2028
(L-TLB)
Call Trace:
[C00000003514F980] [C0000000005257D8] amd74xx_pci_tbl+0x8/0x200 (unreliable)
[C00000003514FB50] [C00000000000F0B4] .__switch_to+0x12c/0x150
[C00000003514FBE0] [C00000000039980C] .schedule+0xcec/0xe4c
[C00000003514FCF0] [C00000000017DA58] .journal_commit_transaction+0x190/0x1448
[C00000003514FE50] [C000000000182F44] .kjournald+0xf0/0x27c
[C00000003514FF90] [C000000000025630] .kernel_thread+0x4c/0x68

Another java thread, did journal_start() in prepare_write() and
took a pagefault while copying. Now this is waiting for mmap_sem
to finish the fault :(

java          D 000000000ffd76f0  6384  2452   2391          2453  2451
(NOTLB)
Call Trace:
[C00000002ABBEE50] [C00000002ABBEEE0] 0xc00000002abbeee0 (unreliable)
[C00000002ABBF020] [C00000000000F0B4] .__switch_to+0x12c/0x150
[C00000002ABBF0B0] [C00000000039980C] .schedule+0xcec/0xe4c
[C00000002ABBF1C0] [C00000000039B688] .rwsem_down_read_failed
+0x284/0x2d0
[C00000002ABBF290] [C00000000039D58C] .do_page_fault+0x2e4/0x75c
[C00000002ABBF460] [C000000000004860] .handle_page_fault+0x20/0x54
--- Exception: 301 at .__copy_tofrom_user+0x11c/0x580
    LR = .generic_file_buffered_write+0x39c/0x7c8
[C00000002ABBF750] [C000000000095A94]
.generic_file_buffered_write+0x2c0/0x7c8 (
unreliable)
[C00000002ABBF8F0] [C0000000000962EC]
.__generic_file_aio_write_nolock+0x350/0x3
e0
[C00000002ABBFA20] [C000000000096908] .generic_file_aio_write+0x78/0x104
[C00000002ABBFAE0] [C0000000001649F0] .ext3_file_write+0x2c/0xd4
[C00000002ABBFB70] [C0000000000C5168] .do_sync_write+0xd4/0x130
[C00000002ABBFCF0] [C0000000000C5ED4] .vfs_write+0x128/0x20c
[C00000002ABBFD90] [C0000000000C664C] .sys_write+0x4c/0x8c
[C00000002ABBFE30] [C00000000000871C] syscall_exit+0x0/0x40


