Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJGSCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbTJGSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:02:52 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28178
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262497AbTJGSCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:02:48 -0400
Subject: Badness in get_io_context
From: Robert Love <rml@tech9.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065549763.690.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Tue, 07 Oct 2003 14:02:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test6-mm4.  UP.  as-iosched.

I got the following today when I tried to send SIGTERM to a GNOME
application:

Badness in get_io_context at drivers/block/ll_rw_blk.c:2677
Call Trace:
[<c0205bbe>] get_io_context+0xce/0xd0
[<c02041bb>] get_request+0x2b/0x2a0
[<c0204c2b>] __make_request+0x10b/0x5a0
[<c02051c5>] generic_make_request+0x105/0x190
[<c011bd30>] autoremove_wake_function+0x0/0x50
[<c020528d>] submit_bio+0x3d/0x80
[<c01709f3>] mpage_bio_submit+0x23/0x40
[<c0170cd6>] do_mpage_readpage+0x196/0x3b0
[<c0177f94>] load_elf_binary+0x524/0xba0
[<c0132bb0>] add_to_page_cache+0x70/0x100
[<c017103e>] mpage_readpages+0x14e/0x1a0
[<c01874e0>] ext3_get_block+0x0/0xa0
[<c0117d69>] pgd_alloc+0x19/0x20
[<c011bf05>] mm_init+0x95/0xd0
[<c0139882>] read_pages+0x162/0x170
[<c01874e0>] ext3_get_block+0x0/0xa0
[<c013740f>] __alloc_pages+0xbf/0x360
[<c0139b91>] do_page_cache_readahead+0x101/0x180
[<c0134192>] filemap_nopage+0x122/0x330
[<c0141779>] do_no_page+0xc9/0x370
[<c0141c20>] handle_mm_fault+0xe0/0x180
[<c011845c>] do_page_fault+0x34c/0x550
[<c02f830b>] error_code+0x2f/0x38

Send SIGTERM to it again:

Badness in get_io_context at drivers/block/ll_rw_blk.c:2677
Call Trace:
[<c0205bbe>] get_io_context+0xce/0xd0
[<c02041bb>] get_request+0x2b/0x2a0
[<c0204c2b>] __make_request+0x10b/0x5a0
[<c02051c5>] generic_make_request+0x105/0x190
[<c0152573>] __find_get_block+0x73/0xf0
[<c0154d97>] bio_alloc+0xd7/0x1d0
[<c020528d>] submit_bio+0x3d/0x80
[<c0152353>] __bread_slow_wq+0x53/0x100
[<c01526ee>] __bread+0x3e/0x50
[<c0188f2b>] ext3_free_branches+0xab/0x270
[<c01895fb>] ext3_truncate+0x50b/0x620
[<c0191fcd>] journal_start+0xad/0xe0
[<c0186703>] start_transaction+0x23/0x60
[<c01868a8>] ext3_delete_inode+0xc8/0x120
[<c01867e0>] ext3_delete_inode+0x0/0x120
[<c0169b4a>] generic_delete_inode+0x6a/0x110
[<c0169de3>] iput+0x63/0x90
[<c0166b9b>] dput+0x12b/0x280
[<c01508b9>] __fput+0x79/0xc0
[<c0144405>] exit_mmap+0x165/0x190
[<c011bffa>] mmput+0x7a/0xf0
(I missed the rest, sorry)

Another GNOME application:

Badness in alloc_as_io_context at drivers/block/as-iosched.c:202
Call Trace:
[<c0208d7a>] alloc_as_io_context+0xca/0xd0
[<c0208db5>] as_get_io_context+0x35/0x50
[<c020a41e>] as_add_request+0x3e/0x210
[<c0202099>] __elv_add_request+0x29/0x40
[<c0204dfe>] __make_request+0x2de/0x5a0
[<c02051c5>] generic_make_request+0x105/0x190
[<c0152573>] __find_get_block+0x73/0xf0
[<c0154d97>] bio_alloc+0xd7/0x1d0
[<c020528d>] submit_bio+0x3d/0x80
[<c0152353>] __bread_slow_wq+0x53/0x100
[<c01526ee>] __bread+0x3e/0x50
[<c0188f2b>] ext3_free_branches+0xab/0x270
[<c01895fb>] ext3_truncate+0x50b/0x620
[<c0191fcd>] journal_start+0xad/0xe0
[<c0186703>] start_transaction+0x23/0x60
[<c01868a8>] ext3_delete_inode+0xc8/0x120
[<c01867e0>] ext3_delete_inode+0x0/0x120
[<c0169b4a>] generic_delete_inode+0x6a/0x110
[<c0169de3>] iput+0x63/0x90
[<c0166b9b>] dput+0x12b/0x280
[<c01508b9>] __fput+0x79/0xc0
[<c0144405>] exit_mmap+0x165/0x190
[<c011bffa>] mmput+0x7a/0xf0
[<c011fc75>] do_exit+0xd5/0x360
[<c011ffaa>] do_group_exit+0x3a/0xb0
[<c01290cb>] get_signal_to_deliver+0x25b/0x360
[<c010b29f>] do_signal+0x8f/0x110
[<c016306a>] do_poll+0x6a/0xd0
[<c0162534>] poll_freewait+0x44/0x50
[<c0163352>] sys_poll+0x282/0x2d0
[<c0162540>] __pollwait+0x0/0xd0
[<c010b357>] do_notify_resume+0x37/0x40
[<c02f814a>] work_notifysig+0x13/0x15



