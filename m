Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUK1QZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUK1QZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUK1QZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:25:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:27031 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261507AbUK1QXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:23:10 -0500
Date: Sun, 28 Nov 2004 17:32:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2/2] ide-tape: small cleanups - handle copy_to|from_user()
 failures
Message-ID: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ensures that copy_to|from_user() return values get checked and
dealt with by returning -EFAULT if they fail.
Aside from the fact that we really want to handle these failures, this 
patch also silences these warnings:
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
drivers/ide/ide-tape.c:2613: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function `idetape_copy_stage_to_user':
drivers/ide/ide-tape.c:2640: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c.old  linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c
--- linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c.old	2004-11-28 16:56:18.000000000 +0100
+++ linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c	2004-11-28 16:58:25.000000000 +0100
@@ -2596,7 +2596,7 @@
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
-static void idetape_copy_stage_from_user(idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
+static int idetape_copy_stage_from_user(idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2606,11 +2606,12 @@
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_from_user\n");
-			return;
+			return 0;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
+			return -EFAULT;
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2621,9 +2622,11 @@
 		}
 	}
 	tape->bh = bh;
+
+	return 0;
 }
 
-static void idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
+static int idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2633,11 +2636,12 @@
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_to_user\n");
-			return;
+			return 0;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
+		if (copy_to_user(buf, tape->b_data, count))
+			return -EFAULT;
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;
@@ -2650,6 +2654,8 @@
 			}
 		}
 	}
+	
+	return 0;
 }
 
 static void idetape_init_merge_stage(idetape_tape_t *tape)
@@ -3695,7 +3701,8 @@
 		return 0;
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
+		if ((rc = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read)) < 0)
+			return rc;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
 		count -= actually_read;
@@ -3704,7 +3711,8 @@
 		bytes_read = idetape_add_chrdev_read_request(drive, tape->capabilities.ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read);
+		if ((rc = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read)) < 0)
+			return rc;
 		buf += bytes_read;
 		count -= bytes_read;
 		actually_read += bytes_read;
@@ -3714,7 +3722,8 @@
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp);
+		if ((rc = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp)) < 0)
+			return rc;
 		actually_read += temp;
 		tape->merge_stage_size = bytes_read-temp;
 	}
@@ -3792,7 +3801,8 @@
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		actually_written = min((unsigned int)(tape->stage_size - tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written);
+		if ((retval = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written)) < 0)
+			return retval;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
 		count -= actually_written;
@@ -3805,7 +3815,8 @@
 		}
 	}
 	while (count >= tape->stage_size) {
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size);
+		if ((retval = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size)) < 0)
+			return retval;
 		buf += tape->stage_size;
 		count -= tape->stage_size;
 		retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
@@ -3815,7 +3826,8 @@
 	}
 	if (count) {
 		actually_written += count;
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
+		if ((retval = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count)) < 0)
+			return retval;
 		tape->merge_stage_size += count;
 	}
 	return actually_written;



