Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbRFGN7l>; Thu, 7 Jun 2001 09:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbRFGN7a>; Thu, 7 Jun 2001 09:59:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62886 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262575AbRFGN70>;
	Thu, 7 Jun 2001 09:59:26 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: andrea@suse.de
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A64.00497F3E.00@d12mta05.de.ibm.com>
Date: Thu, 7 Jun 2001 15:22:45 +0200
Subject: PATCH: enable stacked end_io hooks in buffer.c
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,


I'd like to hook into the end_io reporting chain by replacing the b_end_io
function pointer by an own end_io
function that restores the original values and calls the previous end_io
function after io.
Unfortunatly if the previous function was end_buffer_io_async it unlocks
the bh->b_page too early since
it checks for the b_end_io == end_buffer_io_async.
With the following patch that works but it maybe isn't the best way to do
it. Comments are highly welcome...

Stefan

------------------------
diff -ruN old/fs/buffer.c new/fs/buffer.c
--- old/fs/buffer.c     Thu Jun  7 14:25:57 2001
+++ new/fs/buffer.c     Thu Jun  7 14:31:00 2001
@@ -807,7 +807,7 @@
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
@@ -839,6 +839,7 @@

 void set_buffer_async_io(struct buffer_head *bh) {
     bh->b_end_io = end_buffer_io_async ;
+               set_bit(BH_Async, &bh->b_state);
 }

 /*
@@ -1531,6 +1532,7 @@
        do {
                lock_buffer(bh);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
                set_bit(BH_Uptodate, &bh->b_state);
                clear_bit(BH_Dirty, &bh->b_state);
@@ -1732,6 +1734,7 @@
                struct buffer_head * bh = arr[i];
                lock_buffer(bh);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
        }

@@ -2178,6 +2181,7 @@
                bh->b_blocknr = *(b++);
                set_bit(BH_Mapped, &bh->b_state);
                bh->b_end_io = end_buffer_io_async;
+               set_bit(BH_Async, &bh->b_state);
                atomic_inc(&bh->b_count);
                bh = bh->b_this_page;
        } while (bh != head);
diff -ruN old/include/linux/fs.h new/include/linux/fs.h
--- old/include/linux/fs.h      Thu Jun  7 14:26:09 2001
+++ new/include/linux/fs.h      Thu Jun  7 14:25:28 2001
@@ -207,6 +207,7 @@
 #define BH_Mapped      4       /* 1 if the buffer has a disk mapping */
 #define BH_New         5       /* 1 if the buffer is new and not yet
written out */
 #define BH_Protected   6       /* 1 if the buffer is protected */
+#define BH_Async 7 /* 1 if the buffer is used for asyncronous io */

 /*
  * Try to keep the most commonly used fields in single cache lines (16
-----------------

IBM Development, Boeblingen, Germany
Linux for eServer development
Stefan.Bader@de.ibm.com
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.


