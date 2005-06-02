Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFBHtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFBHtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFBHtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:49:10 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:18184 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261603AbVFBHsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:48:54 -0400
Date: Thu, 02 Jun 2005 14:48:24 -0400
To: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: [PATCH] VFS mpage.c:mpage_end_io_read wrong behavior when I/O failure occurs
References: <opsrq9wqlser1mdp@coolq>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       iscas-linaccident@intellilink.co.jp
From: "fs@ercist.iscas.ac.cn" <fs@ercist.iscas.ac.cn>
Organization: iscas
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsrraiyt18b2kfj@coolq>
In-Reply-To: <opsrq9wqlser1mdp@coolq>
User-Agent: Opera M2/7.54 (Linux, build 751)
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Related FS:
      JFS

Related files:
      fs/mpage.c

Bug description:
      Make a partition in USB storage HDD, create a test file with
any contents.
      Write a program, do: open(O_RDWR) - write - fsync - close.
After each operation, pause for a while, such as 3 seconds. Between
open and fsync, unplug USB wire to force an I/O error. fsync will
return OK instead of EIO.

Bug analysis:
sys_fsync does 3 jobs:
    1)submit all pages taged with PAGECACHE_TAG_DIRTY to disk I/O,
    2)do file-system related fsync operations
    3)wait all pages taged with PAGECACHE_TAG_WRITEBACK to complete.
Here, all disk I/O are asynchronous, when finished, mpage_end_io_write
will remove page from mapping's PAGECACHE_TAG_WRITEBACK tree. If I/O
fails, it will also set PG_error flag, but it FORGET to set the
mapping->flags AS_EIO flag. So in step 3, sys_fsync won't notice these
pages, then no error returns.
static int mpage_end_io_write(...)
{
	...
		if (!uptodate)
			SetPageError(page);<-- Not set mapping->flags
	...
}

static int wait_on_page_writeback_range(struct address_space *mapping,
				pgoff_t start, pgoff_t end)
{
          ...
	int ret = 0;
	...	

	while ((index <= end) && <-- For I/O error page, no loop here
		(nr_pages = pagevec_lookup_tag(&pvec, mapping,  &index,
		PAGECACHE_TAG_WRITEBACK,
		min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
			...
	}

	if (test_and_clear_bit(AS_ENOSPC, &mapping->flags))
		ret = -ENOSPC;
	if (test_and_clear_bit(AS_EIO, &mapping->flags)) <-- Not set
		ret = -EIO;

	return ret; <-- return 0
}

Way around:
Set AS_EIO to mapping->flags if I/O error happens.

Patch:
diff -uNp linux-2.6.11.11-orig/fs/mpage.c linux-2.6.11.11-new/fs/mpage.c
--- linux-2.6.11.11-orig/fs/mpage.c	2005-05-27 01:06:46.000000000 -0400
+++ linux-2.6.11.11-new/fs/mpage.c	2005-06-02 14:29:42.264334920 -0400
@@ -79,8 +79,11 @@ static int mpage_end_io_write(struct bio
   		if (--bvec >= bio->bi_io_vec)
   			prefetchw(&bvec->bv_page->flags);

-		if (!uptodate)
+		if (!uptodate){
   			SetPageError(page);
+			if(page->mapping)
+				set_bit(AS_EIO, &page->mapping->flags);
+		}
   		end_page_writeback(page);
   	} while (bvec >= bio->bi_io_vec);
   	bio_put(bio);


Signed-off-by: Qu Fuping<fs@ercist.iscas.ac.cn>

