Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWAVVvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWAVVvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWAVVvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:51:55 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:10858 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751347AbWAVVvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:51:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pv+eEcHtDK6h6shgrEl2JVs2PXq08Bvy6W6k7bOSRnmlgzszdxNFUw3h5pQc2Co4y/CLyHXFeNeYjpaf5odVFdS+wdSAYqIEv+dsKcj5sfaCfno1i10R+snmid3G9R5A9rcmb6P8zuHVz0WVjYdSDO1XcBW4F+sqy0K6xVqxySo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide-tape: attempt to handle copy_*_user() failures   [take two]
Date: Sun, 22 Jan 2006 22:51:56 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601222251.56185.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt at this patch.

(
 noticed a small flaw in my first patch, this should be better.
 also noticed that Gadi Oxman seems unable to recieve mail at the address
 listed in MAINTAINERS, so put a few other (hopefully relevant) people on
 Cc instead
)


Attempt to handle copy_*_user() failures in
drivers/ide/ide-tape.c::idetape_copy_stage_*_user

drivers/ide/ide-tape.c:2663: warning: ignoring return value of opy_from_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c:2690: warning: ignoring return value of opy_to_user', declared with attribute warn_unused_result

Due to lack of hardware I'm unfortunately not able to test this patch
beyond making sure it compiles.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/ide-tape.c |   51 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 17 deletions(-)

--- linux-2.6.16-rc1-mm2-orig/drivers/ide/ide-tape.c	2006-01-20 21:50:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2/drivers/ide/ide-tape.c	2006-01-22 22:47:52.000000000 +0100
@@ -2646,21 +2646,23 @@ static idetape_stage_t *idetape_kmalloc_
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
-static void idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
+static unsigned long idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
+	unsigned long not_copied;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_from_user\n");
-			return;
+			return 0;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		not_copied = copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		count -= not_copied;
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2669,26 +2671,30 @@ static void idetape_copy_stage_from_user
 			if (bh)
 				atomic_set(&bh->b_count, 0);
 		}
+		if (not_copied)
+			return not_copied;
 	}
 	tape->bh = bh;
+	return 0;
 }
 
-static void idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
+static unsigned long idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
+	unsigned long not_copied;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
 		if (bh == NULL) {
 			printk(KERN_ERR "ide-tape: bh == NULL in "
 				"idetape_copy_stage_to_user\n");
-			return;
+			return 0;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
-		n -= count;
+		not_copied = copy_to_user(buf, tape->b_data, count);
+		n -= count - not_copied;
 		tape->b_data += count;
 		tape->b_count -= count;
 		buf += count;
@@ -2699,7 +2705,10 @@ static void idetape_copy_stage_to_user (
 				tape->b_count = atomic_read(&bh->b_count);
 			}
 		}
+		if (not_copied)
+			return not_copied;
 	}
+	return 0;
 }
 
 static void idetape_init_merge_stage (idetape_tape_t *tape)
@@ -3719,6 +3728,7 @@ static ssize_t idetape_chrdev_read (stru
 	struct ide_tape_obj *tape = ide_tape_f(file);
 	ide_drive_t *drive = tape->drive;
 	ssize_t bytes_read,temp, actually_read = 0, rc;
+	unsigned long not_copied;
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
@@ -3737,7 +3747,8 @@ static ssize_t idetape_chrdev_read (stru
 		return (0);
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
+		not_copied = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
+		actually_read -= not_copied;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
 		count -= actually_read;
@@ -3746,7 +3757,8 @@ static ssize_t idetape_chrdev_read (stru
 		bytes_read = idetape_add_chrdev_read_request(drive, tape->capabilities.ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read);
+		not_copied = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, bytes_read);
+		bytes_read -= not_copied;
 		buf += bytes_read;
 		count -= bytes_read;
 		actually_read += bytes_read;
@@ -3756,9 +3768,10 @@ static ssize_t idetape_chrdev_read (stru
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
-		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp);
+		not_copied = idetape_copy_stage_to_user(tape, buf, tape->merge_stage, temp);
+		temp -= not_copied;
 		actually_read += temp;
-		tape->merge_stage_size = bytes_read-temp;
+		tape->merge_stage_size = bytes_read - temp;
 	}
 finish:
 	if (!actually_read && test_bit(IDETAPE_FILEMARK, &tape->flags)) {
@@ -3778,6 +3791,7 @@ static ssize_t idetape_chrdev_write (str
 	struct ide_tape_obj *tape = ide_tape_f(file);
 	ide_drive_t *drive = tape->drive;
 	ssize_t retval, actually_written = 0;
+	unsigned long not_copied;
 
 	/* The drive is write protected. */
 	if (tape->write_prot)
@@ -3834,7 +3848,8 @@ static ssize_t idetape_chrdev_write (str
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		actually_written = min((unsigned int)(tape->stage_size - tape->merge_stage_size), (unsigned int)count);
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written);
+		not_copied = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, actually_written);
+		actually_written -= not_copied;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
 		count -= actually_written;
@@ -3847,17 +3862,19 @@ static ssize_t idetape_chrdev_write (str
 		}
 	}
 	while (count >= tape->stage_size) {
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size);
-		buf += tape->stage_size;
-		count -= tape->stage_size;
+		not_copied = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, tape->stage_size);
+		buf += tape->stage_size - not_copied;
+		count -= tape->stage_size - not_copied;
 		retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
-		actually_written += tape->stage_size;
+		actually_written += tape->stage_size - not_copied;
 		if (retval <= 0)
 			return (retval);
 	}
 	if (count) {
 		actually_written += count;
-		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
+		not_copied = idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
+		count -= not_copied;
+		actually_written -= not_copied;
 		tape->merge_stage_size += count;
 	}
 	return (actually_written);


