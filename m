Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWGXRuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWGXRuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWGXRuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:50:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50111 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932248AbWGXRue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:50:34 -0400
Message-ID: <44C50865.3000403@us.ibm.com>
Date: Mon, 24 Jul 2006 10:50:29 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, hch@lst.de, miklos@szeredi.hu, nathans@sgi.com,
       reiser@namesys.com, swhiteho@redhat.com, vs@namesys.com
Subject: [PATCH -mm only] Pass IO size to batch_write() address space operation
References: <200607091208.k69C8umv021827@shell0.pdx.osdl.net>
In-Reply-To: <200607091208.k69C8umv021827@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------060905060007010400090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905060007010400090506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is the patch to pass size of the remaining IO to batch_write() 
interface.
I would like to use it ext3/ext4 to allocate in chunks. Currently its 
passing
only the size of the current buffer (in the vector entry).

Comments ? Flames ? Looks reasonable ?

Thanks,
Badari



--------------060905060007010400090506
Content-Type: text/plain;
 name="pass_io_size_to_batch_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pass_io_size_to_batch_write.patch"

Pass remaining size of this IO to batch_write(). This
way filesystems could choose to allocate for the entire IO,
instead of current buffer size.

I would like to use this for setting ext3 reservation window
or allocating entire extent (ext4).


Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

---
 include/linux/fs.h |    2 ++
 mm/filemap.c       |    1 +
 2 files changed, 3 insertions(+)

Index: linux-2.6.18-rc1/include/linux/fs.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/fs.h	2006-07-24 10:12:18.000000000 -0700
+++ linux-2.6.18-rc1/include/linux/fs.h	2006-07-24 10:35:51.000000000 -0700
@@ -356,6 +356,7 @@ struct writeback_control;
  * struct write_descriptor - set of write arguments
  * @pos: offset from the start of the file to write to
  * @count: number of bytes to write
+ * @iosize: remaining number of bytes in the IO
  * @buf: pointer to data to be written
  * @lru_pvec: multipage container to batch adding pages to LRU list
  * @cached_page: allocated but not used on previous call
@@ -366,6 +367,7 @@ struct writeback_control;
 struct write_descriptor {
 	loff_t pos;
 	size_t count;
+	size_t iosize;
 	char __user *buf;
 	struct page *cached_page;
 	struct pagevec *lru_pvec;
Index: linux-2.6.18-rc1/mm/filemap.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/filemap.c	2006-07-24 10:12:20.000000000 -0700
+++ linux-2.6.18-rc1/mm/filemap.c	2006-07-24 10:36:44.000000000 -0700
@@ -2278,6 +2278,7 @@ generic_file_buffered_write(struct kiocb
 	do {
 		/* do not walk over current segment */
 		desc.buf = cur_iov->iov_base + iov_base;
+		desc.iosize = count;
 		desc.count = min(count, cur_iov->iov_len - iov_base);
 		if (desc.count > 0)
 			status = (*batch_write)(file, &desc, &copied);

--------------060905060007010400090506--

