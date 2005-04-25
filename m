Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVDYT1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDYT1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVDYT1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:27:13 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:40667 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261737AbVDYTXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:23:54 -0400
Subject: [patch 1/1] uml ubd: handle readonly status
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       axboe@suse.de
From: blaisorblade@yahoo.it
Date: Mon, 25 Apr 2005 21:19:49 +0200
Message-Id: <20050425191949.E56D145EBB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Jens Axboe <axboe@suse.de>

Use the set_disk_ro() API when the backing file is read-only, to mark the disk
read-only, during the ->open(). The current hack does not work when doing a
mount -o remount.

Also, mark explicitly the code paths which should no more be triggerable (I've
removed the WARN_ON(1) things). They should actually become BUG()s probably
but I'll avoid that since I'm not so sure the change works so well. I gave it
only some limited testing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly arch/um/drivers/ubd_kern.c
--- linux-2.6.12/arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly	2005-04-25 21:16:03.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c	2005-04-25 21:16:47.000000000 +0200
@@ -156,6 +156,7 @@ static struct gendisk *fake_gendisk[MAX_
 static struct openflags global_openflags = OPEN_FLAGS;
 
 struct cow {
+	/* This is the backing file, actually */
 	char *file;
 	int fd;
 	unsigned long *bitmap;
@@ -927,10 +928,14 @@ static int ubd_open(struct inode *inode,
 		}
 	}
 	dev->count++;
-	if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
+	set_disk_ro(disk, !dev->openflags.w);
+
+	/* This should no more be needed. And it didn't work anyway to exclude
+	 * read-write remounting of filesystems.*/
+	/*if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
 	        if(--dev->count == 0) ubd_close(dev);
 	        err = -EROFS;
-	}
+	}*/
  out:
 	return(err);
 }
@@ -1096,6 +1101,7 @@ static int prepare_request(struct reques
 
 	if(req->rq_status == RQ_INACTIVE) return(1);
 
+	/* This should be impossible now */
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
@@ -1243,6 +1249,7 @@ static int ubd_check_remapped(int fd, un
 
 		/* It's a write to a ubd device */
 
+		/* This should be impossible now */
 		if(!dev->openflags.w){
 			/* It's a write access on a read-only device - probably
 			 * shouldn't happen.  If the kernel is trying to change
@@ -1605,8 +1612,7 @@ void do_io(struct io_thread_req *req)
 				}
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
-		}
-		else {
+		} else {
 			n = os_write_file(req->fds[bit], buf, len);
 			if(n != len){
 				printk("do_io - write failed err = %d "
_
