Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUILD0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUILD0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 23:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268423AbUILD0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 23:26:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268421AbUILDZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 23:25:53 -0400
Date: Sat, 11 Sep 2004 20:25:25 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Patch for 3 ub bugs in 2.6.9-rc1-mm4
Message-Id: <20040911202525.1fd6c206@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg,

Actual users of ub quickly found problems, so here's a patch to address
some of them.

#1: An attempt to mount a CF card, pull the plug, then unmount causes a
message "getblk: bad sector size 512" and an oops. This is caused by
trying to do put_disk from disconnect instead of using a reference count.
The sd.c does it this way (it uses kref).

#2: The hald fills /var/log/messages with block device errors. It seems
that it happens because ub allowed opens of known offline devices, and
then partition checking produced those errors. I hope taking code from
sd.c should fix it.

Also I replaced usb_unlink_urb with usb_kill_urb.

-- Pete

diff -urp -X dontdiff linux-2.6.9-rc1-mm4/drivers/block/ub.c linux-2.6.9-rc1-mm4-ub/drivers/block/ub.c
--- linux-2.6.9-rc1-mm4/drivers/block/ub.c	2004-09-09 16:59:26.000000000 -0700
+++ linux-2.6.9-rc1-mm4-ub/drivers/block/ub.c	2004-09-11 20:10:10.760129160 -0700
@@ -490,6 +490,18 @@ static void ub_id_put(int id)
  */
 static void ub_cleanup(struct ub_dev *sc)
 {
+
+	/*
+	 * If we zero disk->private_data BEFORE put_disk, we have to check
+	 * for NULL all over the place in open, release, check_media and
+	 * revalidate, because the block level semaphore is well inside the
+	 * put_disk. But we cannot zero after the call, because *disk is gone.
+	 * The sd.c is blatantly racy in this area.
+	 */
+	/* disk->private_data = NULL; */
+	put_disk(sc->disk);
+	sc->disk = NULL;
+
 	ub_id_put(sc->id);
 	kfree(sc);
 }
@@ -1413,7 +1429,15 @@ static int ub_bd_open(struct inode *inod
 	if (sc->removable || sc->readonly)
 		check_disk_change(inode->i_bdev);
 
-	/* XXX sd.c and floppy.c bail on open if media is not present. */
+	/*
+	 * The sd.c considers ->media_present and ->changed not equivalent,
+	 * under some pretty murky conditions (a failure of READ CAPACITY).
+	 * We may need it one day.
+	 */
+	if (sc->removable && sc->changed && !(filp->f_flags & O_NDELAY)) {
+		rc = -ENOMEDIUM;
+		goto err_open;
+	}
 
 	if (sc->readonly && (filp->f_mode & FMODE_WRITE)) {
 		rc = -EROFS;
@@ -1498,8 +1522,11 @@ static int ub_bd_revalidate(struct gendi
 	printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
 	    sc->name, sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
 
+	/* XXX Support sector size switching like in sr.c */
+	// blk_queue_hardsect_size(q, sc->capacity.bsize);
 	set_capacity(disk, sc->capacity.nsec);
 	// set_disk_ro(sdkp->disk, sc->readonly);
+
 	return 0;
 }
 
@@ -1746,12 +1773,7 @@ static int ub_probe_clear_stall(struct u
 	wait_for_completion(&compl);
 
 	del_timer_sync(&timer);
-	/*
-	 * Most of the time, URB was done and dev set to NULL, and so
-	 * the unlink bounces out with ENODEV. We do not call usb_kill_urb
-	 * because we still think about a backport to 2.4.
-	 */
-	usb_unlink_urb(&sc->work_urb);
+	usb_kill_urb(&sc->work_urb);
 
 	/* reset the endpoint toggle */
 	usb_settoggle(sc->dev, endp, usb_pipeout(sc->last_pipe), 0);
@@ -2011,17 +2033,6 @@ static void ub_disconnect(struct usb_int
 		blk_cleanup_queue(q);
 
 	/*
-	 * If we zero disk->private_data BEFORE put_disk, we have to check
-	 * for NULL all over the place in open, release, check_media and
-	 * revalidate, because the block level semaphore is well inside the
-	 * put_disk. But we cannot zero after the call, because *disk is gone.
-	 * The sd.c is blatantly racy in this area.
-	 */
-	/* disk->private_data = NULL; */
-	put_disk(disk);
-	sc->disk = NULL;
-
-	/*
 	 * We really expect blk_cleanup_queue() to wait, so no amount
 	 * of paranoya is too much.
 	 *
