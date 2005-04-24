Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVDXTBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVDXTBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVDXTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 15:01:22 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:2467 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262377AbVDXTAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 15:00:55 -0400
Subject: [patch 7/7] uml ubd: handle readonly status
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       axboe@suse.de
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:24 +0200
Message-Id: <20050424181924.EAFCB55D06@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Jens Axboe <axboe@suse.de>

Use the set_disk_ro() API when the backing file is read-only, to mark the disk
read-only, during the ->open(). The current hack does not work when doing a
mount -o remount.

Also, upgrade some warnings to WARN_ON(1) statements. They should actually
become BUG()s probably but I'll avoid that since I'm not so sure the change
works so well. I gave it only some limited testing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly arch/um/drivers/ubd_kern.c
--- linux-2.6.12/arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly	2005-04-24 20:17:06.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c	2005-04-24 20:17:06.000000000 +0200
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
@@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
+		WARN_ON(1); /* This should be impossible now */
 		end_request(req, 0);
 		return(1);
 	}
@@ -1252,6 +1258,7 @@ static int ubd_check_remapped(int fd, un
 			 */
 			printk("Write access to mapped page from readonly ubd "
 			       "device %d\n", i);
+			WARN_ON(1); /* This should be impossible now */
 			return(0);
 		}
 
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
