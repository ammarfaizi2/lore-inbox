Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWEJR75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWEJR75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWEJR75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:59:57 -0400
Received: from homer.mvista.com ([63.81.120.158]:41280 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932434AbWEJR74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:59:56 -0400
Date: Wed, 10 May 2006 10:59:43 -0700
Message-Id: <200605101759.k4AHxhUI005075@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] updated idetape gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added returns for failures .. I would hope that this doesn't break anything in
userspace , but I'll confess that I have no way to determin that for certain . 

Hows that Alan?

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
@@ -2645,7 +2645,7 @@ static idetape_stage_t *idetape_kmalloc_
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
-static void idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
+static int idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2655,11 +2655,12 @@ static void idetape_copy_stage_from_user
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
+			return 1;
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2670,9 +2671,10 @@ static void idetape_copy_stage_from_user
 		}
 	}
 	tape->bh = bh;
+	return 0;
 }
 
-static void idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
+static int idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2682,11 +2684,12 @@ static void idetape_copy_stage_to_user (
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
+			return 1;
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;
@@ -2699,6 +2702,7 @@ static void idetape_copy_stage_to_user (
 			}
 		}
 	}
+	return 0;
 }
 
 static void idetape_init_merge_stage (idetape_tape_t *tape)
@@ -3736,7 +3740,8 @@ static ssize_t idetape_chrdev_read (stru
 		return (0);
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read))
+			return -EFAULT;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
 		count -= actually_read;
@@ -3745,7 +3750,8 @@ static ssize_t idetape_chrdev_read (stru
 		bytes_read = idetape_add_chrdev_read_request(drive, tape->capabilities.ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read))
+			return -EFAULT;
 		buf += bytes_read;
 		count -= bytes_read;
 		actually_read += bytes_read;
@@ -3755,7 +3761,8 @@ static ssize_t idetape_chrdev_read (stru
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp);
+		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp))
+			return -EFAULT;
 		actually_read += temp;
 		tape->merge_stage_size = bytes_read-temp;
 	}
@@ -3833,7 +3840,8 @@ static ssize_t idetape_chrdev_write (str
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		actually_written = min((unsigned int)(tape->stage_size - tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written);
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written))
+				return -EFAULT;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
 		count -= actually_written;
@@ -3846,7 +3854,8 @@ static ssize_t idetape_chrdev_write (str
 		}
 	}
 	while (count >= tape->stage_size) {
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size);
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size))
+			return -EFAULT;
 		buf += tape->stage_size;
 		count -= tape->stage_size;
 		retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
@@ -3856,7 +3865,8 @@ static ssize_t idetape_chrdev_write (str
 	}
 	if (count) {
 		actually_written += count;
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
+		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count))
+			return -EFAULT;
 		tape->merge_stage_size += count;
 	}
 	return (actually_written);
