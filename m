Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVEKHko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVEKHko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEKHkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:40:43 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:5388 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261919AbVEKHkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:40:02 -0400
Subject: [PATCH] VFS mmap wrong behavior when I/O failure occurs
From: fs <fs@ercist.iscas.ac.cn>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fsdevel@vger.kernel.org,
       iscas-linaccident <iscas-linaccident@intellilink.co.jp>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: iscas
Message-Id: <1115837231.3599.55.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 May 2005 14:47:11 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Related FS: 
    EXT2, EXT3, XFS

Related files: 
    fs/buffer.c mm/filemap.c

Bug description:
    Make a partition in USB storage HDD, create a 64M file.
    Write a program, do: open - mmap - read memory at offset 16M
(from disk) - munmap - close. After each operation, pause for a
while, such as 3 seconds. Between mmap and read memory, unplug a
USB wire to force a I/O error. The read memory will report no error
and get 0x00 back, while the right result is SIGBUS.

Bug analysis:
    When accessing a page mmaped, kernel calls 
do_no_page->..->filemap_nopage->mapping->a_ops->readpage to read a 
page from disk. In filemap_nopage(),  if !Uptodate(page) (i.e.:
readpage() fails) , it will ClearPageError(page) and try readpage()
again. Most FS will call mpage_readpage(). For EXT2/EXT3/XFS, 
it calls block_read_full_page().
 
1st readpage()->block_read_full_page(): 
get_block fails(because of I/O failure), 
			if (iblock < lblock) {
				if (get_block(inode, iblock, bh, 0))
					SetPageError(page);
			}
			if (!buffer_mapped(bh)) {
				void *kaddr = kmap_atomic(page, KM_USER0);
				memset(kaddr + i * blocksize, 0, blocksize);
				flush_dcache_page(page);
				kunmap_atomic(kaddr, KM_USER0);
				set_buffer_uptodate(bh); //NOTICE HERE
				continue;
			}
			...

Then ClearPageError(page);

2nd readpage()->block_read_full_page():
for every buffer:
		if (buffer_uptodate(bh))
			continue;
So at the end, the page/buffer is uptodate, no Error set.
filemap_nopage will happily return a page memset with 0 without any
error!

Way around:
A. do not set buffer uptodate
Or
B. do not call readpage() twice.

Patch:
Since the buffer is memset to 0, no need to set_buffer_uptodate.
diff -uNp linux-2.6.11.8-orig/fs/buffer.c linux-2.6.11.8/fs/buffer.c
--- linux-2.6.11.8-orig/fs/buffer.c     2005-05-11 14:41:03.000000000
-0400
+++ linux-2.6.11.8/fs/buffer.c  2005-05-11 14:38:55.000000000 -0400
@@ -2105,7 +2105,6 @@ int block_read_full_page(struct page *pa
                                memset(kaddr + i * blocksize, 0,
blocksize);
                                flush_dcache_page(page);
                                kunmap_atomic(kaddr, KM_USER0);
-                               set_buffer_uptodate(bh);
                                continue;
                        }
                        /*
Signed-off-by: Qu Fuping <fs@ercist.iscas.ac.cn>

----
Best Regards,
Qu Fuping


