Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbRE1H7v>; Mon, 28 May 2001 03:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbRE1H7l>; Mon, 28 May 2001 03:59:41 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:18117 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262999AbRE1H73>; Mon, 28 May 2001 03:59:29 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Jens Axboe <axboe@suse.de>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Message-ID: <C1256A5A.002BDE5F.00@d12mta05.de.ibm.com>
Date: Mon, 28 May 2001 09:59:08 +0200
Subject: loop.c: (rare) race condition
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

I think I've stumbled over a rare case where the way the loop device now
handles loopback to files.
What I did: for the things I want to test I need block devices that end up
using the same physical
storage. So I use losetup to connect 2 (or more) loop devices to the same
file an then go on working
with these block devices. This worked with kernel 2.4.0 (plus loop6.patch)
without problems. But now
(kernel 2.4.4) I got kernel-bug (in UnlockPage while doing the end_io
call).
It seems that the loop device driver changed the way it accesses files to
use the page cache. So
I compared the function lo_send() in loop.c with the generic_file_write()
in mm/filemap.c. In that function
writings are serialized using the i_sem semaphore. So I added taht to
lo_send and after that my setup
worked again. It seem that since each loop device has its own kernel
thread doing the read/writes it was
possible that both tried to update the same _page_ at the same time
(although I made sure that I never
write the same _sector_ at the same time).
I don't know whether that is the best solution to the problem but at least
it works. :) Maybe it also helps in
other situations I haven't thought of, too. Hopefully the patch below
survives our mailing system...

Stefan

--- linux-2.4.4/drivers/block/loop.c    Wed May  9 15:19:51 2001
+++ new/drivers/block/loop.c    Wed May 23 15:18:48 2001
@@ -176,6 +176,8 @@
        unsigned size, offset;
        int len;

+       down(&(file->f_dentry->d_inode->i_sem));
+
        index = pos >> PAGE_CACHE_SHIFT;
        offset = pos & (PAGE_CACHE_SIZE - 1);
        len = bh->b_size;
@@ -206,6 +208,7 @@
                deactivate_page(page);
                page_cache_release(page);
        }
+       up(&(file->f_dentry->d_inode->i_sem));
        return 0;

 write_fail:
@@ -217,6 +220,7 @@
        deactivate_page(page);
        page_cache_release(page);
 fail:
+       up(&(file->f_dentry->d_inode->i_sem));
        return -1;
 }


----------------------------------------------------------------------------------

  When all other means of communication fail, try words.


