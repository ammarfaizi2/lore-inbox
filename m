Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311485AbSCTD50>; Tue, 19 Mar 2002 22:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311486AbSCTD5J>; Tue, 19 Mar 2002 22:57:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:45325 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311485AbSCTD4t>; Tue, 19 Mar 2002 22:56:49 -0500
Message-ID: <3C980828.CF87080B@zip.com.au>
Date: Tue, 19 Mar 2002 19:55:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-020-sync_buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various changes to the dirty buffer flushing code.

The VM wants to throttle memory allocators down to match the disk's
ability to clean memory.  It does this by initiating and waiting on
I/O.  Also by waiting on I/O which is initiated by others.

In the current kernel, try_to_free_buffers() only waits on writeout
which try_to_free_buffers() started.  This patch allows
try_to_free_buffers() to also throttle on kupdate/bdflush writeout. 
Gives better throttling and avoids the situation where tasks (inside
the context of the page allocator) pointlessly traverse large numbers
of pages before finding one which is eligible for throttling.

This allows us to no longer have to account for locked buffers in
balance_dirty_state() - the "machine flooded with locked buffers"
problem doesn't occur, because we can throttle on all buffers.


I'm not completely sure that this is a good change.  It could have the
tendency to make all page allocators suffer because of a single writer.

It probably looks good on disk-intensive workloads, but there is a risk
that compute-intensive tasks which are allocating modest amounts of
memory will get less work done.  They'll spend more time in disk wait
and the CPU will be idle.

That being said, testing which was specifically designed to demonstrate
this effect failed to do so...


=====================================

--- 2.4.19-pre3/fs/buffer.c~aa-020-sync_buffers	Tue Mar 19 19:48:53 2002
+++ 2.4.19-pre3-akpm/fs/buffer.c	Tue Mar 19 19:49:17 2002
@@ -47,6 +47,7 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+#include <linux/compiler.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -122,7 +123,14 @@ int bdflush_max[N_PARAM] = {100,50000, 2
 void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit(BH_Wait_IO, &bh->b_state);
-	clear_bit(BH_launder, &bh->b_state);
+	clear_bit(BH_Launder, &bh->b_state);
+	/*
+	 * When a locked buffer is visible to the I/O layer BH_Launder
+	 * is set. This means before unlocking we must clear BH_Launder,
+	 * mb() on alpha and then clear BH_Lock, so no reader can see
+	 * BH_Launder set on an unlocked buffer and then risk to deadlock.
+	 */
+	smp_mb__after_clear_bit();
 	clear_bit(BH_Lock, &bh->b_state);
 	smp_mb__after_clear_bit();
 	if (waitqueue_active(&bh->b_wait))
@@ -1046,7 +1054,6 @@ static int balance_dirty_state(void)
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
-	dirty += size_buffers_type[BUF_LOCKED] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
 	dirty *= 100;
@@ -2595,20 +2602,24 @@ static int grow_buffers(kdev_t dev, unsi
 static int sync_page_buffers(struct buffer_head *head)
 {
 	struct buffer_head * bh = head;
-	int tryagain = 0;
+	int tryagain = 1;
 
 	do {
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
 			continue;
 
 		/* Don't start IO first time around.. */
-		if (!test_and_set_bit(BH_Wait_IO, &bh->b_state))
+		if (!test_and_set_bit(BH_Wait_IO, &bh->b_state)) {
+			tryagain = 0;
 			continue;
+		}
 
 		/* Second time through we start actively writing out.. */
 		if (test_and_set_bit(BH_Lock, &bh->b_state)) {
-			if (!test_bit(BH_launder, &bh->b_state))
+			if (unlikely(!buffer_launder(bh))) {
+				tryagain = 0;
 				continue;
+			}
 			wait_on_buffer(bh);
 			tryagain = 1;
 			continue;
@@ -2621,7 +2632,6 @@ static int sync_page_buffers(struct buff
 
 		__mark_buffer_clean(bh);
 		get_bh(bh);
-		set_bit(BH_launder, &bh->b_state);
 		bh->b_end_io = end_buffer_io_sync;
 		submit_bh(WRITE, bh);
 		tryagain = 0;
--- 2.4.19-pre3/include/linux/fs.h~aa-020-sync_buffers	Tue Mar 19 19:48:53 2002
+++ 2.4.19-pre3-akpm/include/linux/fs.h	Tue Mar 19 19:48:53 2002
@@ -217,7 +217,7 @@ enum bh_state_bits {
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
-	BH_launder,	/* 1 if we should throttle on this buffer */
+	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
@@ -279,6 +279,7 @@ void init_buffer(struct buffer_head *, b
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
+#define buffer_launder(bh)	__buffer_state(bh,Launder)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
@@ -1110,7 +1111,7 @@ extern struct file_operations rdwr_pipe_
 
 extern int fs_may_remount_ro(struct super_block *);
 
-extern int try_to_free_buffers(struct page *, unsigned int);
+extern int FASTCALL(try_to_free_buffers(struct page *, unsigned int));
 extern void refile_buffer(struct buffer_head * buf);
 extern void create_empty_buffers(struct page *, kdev_t, unsigned long);
 extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
