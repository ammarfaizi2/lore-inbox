Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTGCOL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTGCOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:11:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47547 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262577AbTGCOLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:11:25 -0400
Date: Thu, 3 Jul 2003 20:00:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, Benjamin LaHaise <bcrl@kvack.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.73-mm2] aio O_DIRECT no readahead
Message-ID: <20030703200030.A3131@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1057022391.22702.18.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1057022391.22702.18.camel@dell_ss5.pdx.osdl.net>; from daniel@osdl.org on Mon, Jun 30, 2003 at 06:19:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 06:19:51PM -0700, Daniel McNeil wrote:
> More testing on AIO with O_DIRECT and /dev/raw/.  Doing AIO reads was
> using a lot more cpu time than using dd on the raw partition even with
> the io_queue_wait patch.  Found out that aio is doing readahead even
> for O_DIRECT.  Here's a patch that fixes it.  Here are some output
> from time on reading a 90mb partition on a raw device with 32k i/o:

I'd have actually liked to move the readahead out from aio.c (avoid
the duplication and bugs like this one), and instead modify the
common read code to just readahead all the pages for a given 
request upfront, rather than in the loop where it waits for pages
to become up-to-date.

Does anyone foresee any issues with doing it this way ?

Something like the appended patch.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--- linux-2.5.73-mm1/fs/aio.c	Thu Jul  3 21:19:27 2003
+++ linux-2.5.73-mm1-aio/fs/aio.c	Thu Jul  3 21:44:07 2003
@@ -1379,19 +1379,8 @@ ssize_t aio_setup_iocb(struct kiocb *kio
 			kiocb->ki_left)))
 			break;
 		ret = -EINVAL;
-		if (file->f_op->aio_read) {
-			struct address_space *mapping = 
-				file->f_dentry->d_inode->i_mapping;
-			unsigned long index = kiocb->ki_pos >> PAGE_CACHE_SHIFT;
-			unsigned long end = (kiocb->ki_pos + kiocb->ki_left)
-				>> PAGE_CACHE_SHIFT; 
-			
-			for (; index < end; index++) {
-				page_cache_readahead(mapping, &file->f_ra, 
-					file, index);
-			}
+		if (file->f_op->aio_read) 
 			kiocb->ki_retry = aio_pread;
-		}
 		break;
 	case IOCB_CMD_PWRITE:
 		ret = -EBADF;
diff -pur -X dontdiff linux-2.5.73-mm1/include/linux/aio.h linux-2.5.73-mm1-aio/include/linux/aio.h
--- linux-2.5.73-mm1/include/linux/aio.h	Thu Jul  3 21:19:33 2003
+++ linux-2.5.73-mm1-aio/include/linux/aio.h	Thu Jul  3 19:38:43 2003
@@ -179,6 +180,9 @@ int FASTCALL(io_submit_one(struct kioctx
 	dump_stack(); \
 	}
 
+#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
+#define is_retried_kiocb(iocb) ((iocb)->ki_retried > 1)
+
 #include <linux/aio_abi.h>
 
 static inline struct kiocb *list_kiocb(struct list_head *h)
diff -pur -X dontdiff linux-2.5.73-mm1/mm/filemap.c linux-2.5.73-mm1-aio/mm/filemap.c
--- linux-2.5.73-mm1/mm/filemap.c	Thu Jul  3 21:19:34 2003
+++ linux-2.5.73-mm1-aio/mm/filemap.c	Thu Jul  3 21:21:41 2003
@@ -601,21 +601,39 @@ void do_generic_mapping_read(struct addr
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset;
+	unsigned long index, offset, last, end_index;
 	struct page *cached_page;
+	loff_t isize = i_size_read(inode);
 	int error;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
+	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
+	end_index = isize >> PAGE_CACHE_SHIFT;
+	if (last > end_index)
+		last = end_index;
+
+	/* Don't repeat the readahead if we are executing aio retries */
+	if (in_aio()) {
+		if (is_retried_kiocb(io_wait_to_kiocb(current->io_wait))) 
+			goto done_readahead;
+	}
+
+	/* 
+	 * Let the readahead logic know upfront about all 
+	 * the pages we'll need to satisfy this request
+	 */
+	for (; index < last; index++) 
+		page_cache_readahead(mapping, ra, filp, index);
+	index = *ppos >> PAGE_CACHE_SHIFT;
+
+done_readahead:
 	for (;;) {
 		struct page *page;
-		unsigned long end_index, nr, ret;
-		loff_t isize = i_size_read(inode);
+		unsigned long nr, ret;
 
-		end_index = isize >> PAGE_CACHE_SHIFT;
-			
 		if (index > end_index)
 			break;
 		nr = PAGE_CACHE_SIZE;
@@ -626,8 +644,6 @@ void do_generic_mapping_read(struct addr
 		}
 
 		cond_resched();
-		if (is_sync_wait(current->io_wait))
-			page_cache_readahead(mapping, ra, filp, index);
 
 		nr = nr - offset;
 find_page:
