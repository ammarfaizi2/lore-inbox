Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288245AbSACHzP>; Thu, 3 Jan 2002 02:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288241AbSACHzF>; Thu, 3 Jan 2002 02:55:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63754 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288245AbSACHyz>; Thu, 3 Jan 2002 02:54:55 -0500
Message-ID: <3C340D45.32E1D88B@zip.com.au>
Date: Wed, 02 Jan 2002 23:50:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [PATCH] expanding truncate
In-Reply-To: <20020103102128.A2625@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
>     This patch makes sure that indirect pointers for holes are correctly filled in by zeroes at
>     hole-creation time. (Author is Chris Mason. fs/buffer.c part (generic_cont_expand) were written by
>     Alexander Viro)
> 
>     Please apply.
> 
> ...
> 

Please.  Do not add new library functions to the kernel with
no descriptive commentary at all.  We really need to get past
that stage.

What is this function supposed to do?  It appears that if
the page at `size' is not in cache, we write uninitialised
data into the file.


--- linux-2.4.18-pre1/fs/buffer.c.orig  Thu Jan  3 10:02:03 2002
+++ linux-2.4.18-pre1/fs/buffer.c       Thu Jan  3 10:09:24 2002
@@ -1760,6 +1760,46 @@
        return 0;
 }
 
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+       struct address_space *mapping = inode->i_mapping;
+       struct page *page;
+       unsigned long index, offset, limit;
+       int err;
+
+       limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+       if (limit != RLIM_INFINITY) {
+               if (size > limit) {
+                       send_sig(SIGXFSZ, current, 0);
+                       size = limit;
+               }
+       }
+       offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
+
+       /* ugh.  in prepare/commit_write, if from==to==start of block, we 
+       ** skip the prepare.  make sure we never send an offset for the start
+       ** of a block
+       */
+       if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
+           offset++ ;
+       }
+       index = size >> PAGE_CACHE_SHIFT;
+       err = -ENOMEM;
+       page = grab_cache_page(mapping, index);
+       if (!page)
+               goto out;
+       err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
+       if (!err) {
+               err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+       }
+       UnlockPage(page);
+       page_cache_release(page);
+       if (err > 0)
+               err = 0;
+out:
+       return err;
+}
+
