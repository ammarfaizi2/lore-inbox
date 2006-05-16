Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWEPUX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWEPUX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWEPUX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:23:56 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:13480 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750778AbWEPUXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:23:54 -0400
Date: Tue, 16 May 2006 13:23:33 -0700
Message-Id: <200605162023.k4GKNXxV006238@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] updated idetape gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another idetape fixup attempt.

In both the read and write cases it will return an error if copy_{from/to}_user
faults. However, I let the driver try to read/write as much as it can just
as it normally would , then finally it returns an error if there was one.
This was the most straight forward way to handle the error , since there
isn't a clear way to clean up the buffers on error .

I moved retval in idetape_chrdev_write() down into the actual code blocks
since it's really once used there, and it conflicted with my ret variable. 

Fixes the following warning,

drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_from_user’:
drivers/ide/ide-tape.c:2662: warning: ignoring return value of ‘copy_from_user’, declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_to_user’:
drivers/ide/ide-tape.c:2689: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/ide/ide-tape.c
===================================================================
--- linux-2.6.16.orig/drivers/ide/ide-tape.c
+++ linux-2.6.16/drivers/ide/ide-tape.c
@@ -2646,21 +2646,23 @@ static idetape_stage_t *idetape_kmalloc_
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
-static void idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
+static int idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
+	int ret = 0;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_from_user\n");
-			return;
+			return 1;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
+			ret = 1;
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2671,23 +2673,26 @@ static void idetape_copy_stage_from_user
 		}
 	}
 	tape->bh = bh;
+	return ret;
 }
 
-static void idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
+static int idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
+	int ret = 0;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_to_user\n");
-			return;
+			return 1;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
+		if  (copy_to_user(buf, tape->b_data, count))
+			ret = 1;
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;
@@ -2700,6 +2705,7 @@ static void idetape_copy_stage_to_user (
 			}
 		}
 	}
+	return ret;
 }
 
 static void idetape_init_merge_stage (idetape_tape_t *tape)
@@ -3719,6 +3725,7 @@ static ssize_t idetape_chrdev_read (stru
 	struct ide_tape_obj *tape = ide_tape_f(file);
 	ide_drive_t *drive = tape->drive;
 	ssize_t bytes_read,temp, actually_read = 0, rc;
+	ssize_t ret = 0;
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
@@ -3737,7 +3744,8 @@ static ssize_t idetape_chrdev_read (stru
 		return (0);
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read))
+			ret = -EFAULT;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
 		count -= actually_read;
@@ -3746,7 +3754,8 @@ static ssize_t idetape_chrdev_read (stru
 		bytes_read = idetape_add_chrdev_read_request(drive, tape->capabilities.ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read))
+			ret = -EFAULT;
 		buf += bytes_read;
 		count -= bytes_read;
 		actually_read += bytes_read;
@@ -3756,7 +3765,8 @@ static ssize_t idetape_chrdev_read (stru
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp))
+			ret = -EFAULT;
 		actually_read += temp;
 		tape->merge_stage_size = bytes_read-temp;
 	}
@@ -3769,7 +3779,8 @@ finish:
 		idetape_space_over_filemarks(drive, MTFSF, 1);
 		return 0;
 	}
-	return actually_read;
+
+	return (ret) ? ret : actually_read;
 }
 
 static ssize_t idetape_chrdev_write (struct file *file, const char __user *buf,
@@ -3777,7 +3788,8 @@ static ssize_t idetape_chrdev_write (str
 {
 	struct ide_tape_obj *tape = ide_tape_f(file);
 	ide_drive_t *drive = tape->drive;
-	ssize_t retval, actually_written = 0;
+	ssize_t actually_written = 0;
+	ssize_t ret = 0;
 
 	/* The drive is write protected. */
 	if (tape->write_prot)
@@ -3813,7 +3825,7 @@ static ssize_t idetape_chrdev_write (str
 		 *	some drives (Seagate STT3401A) will return an error.
 		 */
 		if (drive->dsc_overlap) {
-			retval = idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, tape->merge_stage->bh);
+			ssize_t retval = idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, tape->merge_stage->bh);
 			if (retval < 0) {
 				__idetape_kfree_stage(tape->merge_stage);
 				tape->merge_stage = NULL;
@@ -3834,12 +3846,14 @@ static ssize_t idetape_chrdev_write (str
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		actually_written = min((unsigned int)(tape->stage_size - tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written);
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written))
+				ret = -EFAULT;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
 		count -= actually_written;
 
 		if (tape->merge_stage_size == tape->stage_size) {
+			ssize_t retval;
 			tape->merge_stage_size = 0;
 			retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
 			if (retval <= 0)
@@ -3847,7 +3861,9 @@ static ssize_t idetape_chrdev_write (str
 		}
 	}
 	while (count >= tape->stage_size) {
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size);
+		ssize_t retval;
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size))
+			ret = -EFAULT;
 		buf += tape->stage_size;
 		count -= tape->stage_size;
 		retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
@@ -3857,10 +3873,11 @@ static ssize_t idetape_chrdev_write (str
 	}
 	if (count) {
 		actually_written += count;
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count))
+			ret = -EFAULT;
 		tape->merge_stage_size += count;
 	}
-	return (actually_written);
+	return (ret) ? ret : actually_written;
 }
 
 static int idetape_write_filemark (ide_drive_t *drive)
