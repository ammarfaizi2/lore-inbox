Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbRFUOkJ>; Thu, 21 Jun 2001 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264991AbRFUOkB>; Thu, 21 Jun 2001 10:40:01 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:47240 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264990AbRFUOjs>; Thu, 21 Jun 2001 10:39:48 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: torvalds@transmeta.com, andrea@suse.de
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A72.00507ECF.00@d12mta05.de.ibm.com>
Date: Thu, 21 Jun 2001 16:39:11 +0200
Subject: correction: fs/buffer.c underlocking async pages
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

I ran into some problems with buffer.c trying to unlock a page of async io
buffer heads more
than once.
IMHO end_buffer_io_async() shouldn't rely on the value of b_end_io to
decide if the whole
page can be unlocked. It would make it easier for other layers (well
remappers like md or
lvm) to create an end_io chain without the need of allocating new buffer
heads just for that.
Is the comparision on b_end_io really necessary? I would assume that all
bh on the same
page belong to async io.
Otherwise, could something like below be done instead?

Linux for eServer development
Stefan.Bader@de.ibm.com
Phone: +49 (7031) 16-2472
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.

--------------------------------------------
diff -ruN old/fs/buffer.c new/fs/buffer.c
--- old/fs/buffer.c     Thu Jun 21 09:47:20 2001
+++ new/fs/buffer.c     Thu Jun 21 10:44:01 2001
@@ -798,11 +798,12 @@
         * that unlock the page..
         */
        spin_lock_irqsave(&page_uptodate_lock, flags);
+       clear_bit(BH_Async, &bh->b_state);
        unlock_buffer(bh);
        atomic_dec(&bh->b_count);
        tmp = bh->b_this_page;
        while (tmp != bh) {
-               if (tmp->b_end_io == end_buffer_io_async &&
buffer_locked(tmp))
+               if (test_bit(BH_Async, &tmp->b_state) &&
buffer_locked(tmp))
                        goto still_busy;
                tmp = tmp->b_this_page;
        }
@@ -834,6 +835,7 @@

 void set_buffer_async_io(struct buffer_head *bh) {
     bh->b_end_io = end_buffer_io_async ;
+               set_bit(BH_Async, &bh->b_state);
 }

 /*
@@ -1535,6 +1537,7 @@
        do {
                lock_buffer(bh);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
                set_bit(BH_Uptodate, &bh->b_state);
                clear_bit(BH_Dirty, &bh->b_state);
@@ -1736,6 +1739,7 @@
                struct buffer_head * bh = arr[i];
                lock_buffer(bh);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
        }

@@ -2182,6 +2186,7 @@
                bh->b_blocknr = *(b++);
                set_bit(BH_Mapped, &bh->b_state);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
                bh = bh->b_this_page;
        } while (bh != head);
diff -ruN old/include/linux/fs.h new/include/linux/fs.h
--- old/include/linux/fs.h      Thu Jun 21 09:47:51 2001
+++ new/include/linux/fs.h      Thu Jun 21 09:48:20 2001
@@ -207,6 +207,7 @@
 #define BH_Mapped      4       /* 1 if the buffer has a disk mapping */
 #define BH_New         5       /* 1 if the buffer is new and not yet
written out */
 #define BH_Protected   6       /* 1 if the buffer is protected */
+#define BH_Async 7 /* 1 if the buffer is used for asyncronous io */

 /*
  * Try to keep the most commonly used fields in single cache lines (16
-------------------



