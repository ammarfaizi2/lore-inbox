Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265783AbUFXXgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUFXXgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFXXgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:36:01 -0400
Received: from fmr04.intel.com ([143.183.121.6]:44765 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265783AbUFXXfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:35:08 -0400
Message-Id: <200406242333.i5ONXeY22955@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Direct I/O stomp over page->mapping for hugetlb page
Date: Thu, 24 Jun 2004 16:35:06 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRaQ+D/N743f53CTU+x1EakWgry1g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a kernel oops on 2.6.7 kernel when doing direct I/O to hugetlb page:

Unable to handle kernel paging request at virtual address 000010180401201d
a.out[1300]: Oops 8813272891392 [1]

Call Trace:
 [<a000000100025010>] die+0x1d0/0x280
 [<a000000100043880>] ia64_do_page_fault+0x380/0x980
 [<a00000010009f500>] set_page_dirty+0xc0/0x1a0
 [<a00000010009f650>] set_page_dirty_lock+0x70/0xa0
 [<a00000010012eec0>] dio_bio_complete+0x100/0x1a0
 [<a00000010012f000>] dio_await_completion+0xa0/0xe0
 [<a000000100130b30>] direct_io_worker+0x810/0x980
 [<a000000100131160>] __blockdev_direct_IO+0x4c0/0x500
 [<a0000001000efbb0>] blkdev_direct_IO+0x90/0xc0
 [<a000000100096eb0>] generic_file_direct_IO+0xd0/0x120
 [<a000000100093920>] __generic_file_aio_read+0x200/0x3c0
 [<a000000100093c60>] generic_file_read+0xc0/0x100
 [<a0000001000dcf70>] vfs_read+0x210/0x2c0
 [<a0000001000dd620>] sys_pread64+0x80/0xe0
 [<a00000010000e0c0>] ia64_ret_from_syscall+0x0/0x20

The destructor of compound page was moved into page->mapping since
2.6.6.  It got interfered with set_page_dirty() for hugetlb page:
an O_DIRECT read into first tail page of the compound page will
fool set_page_dirty() to deference page->mapping->a_ops and then
kernel oops.  Patch to fix the oops.  We do just like what
bio_set_pages_dirty() does.

--- linux/fs/direct-io.c.orig	2004-06-24 11:56:53.000000000 -0700
+++ linux/fs/direct-io.c	2004-06-24 15:24:02.000000000 -0700
@@ -395,7 +395,7 @@ static int dio_bio_complete(struct dio *
 		for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
 			struct page *page = bvec[page_no].bv_page;

-			if (dio->rw == READ)
+			if (dio->rw == READ && !PageCompound(page))
 				set_page_dirty_lock(page);
 			page_cache_release(page);
 		}



