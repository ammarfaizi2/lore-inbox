Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267463AbUBSSS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSSS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:18:29 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:16146 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267463AbUBSSRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:17:55 -0500
Message-ID: <4034FDD0.33BC57AF@SteelEye.com>
Date: Thu, 19 Feb 2004 13:17:52 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nbd: remove PARANOIA and other cleanups
Content-Type: multipart/mixed;
 boundary="------------1609F71524B68E54AE91829A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1609F71524B68E54AE91829A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch removes the PARANOIA define (it was always defined anyway).
It also removes the requests_in/out counters (which weren't always
accurate, and are superfluous anyway, since the block layer keeps its
own in_flight counter). Also some minor cleanup of comments.

Thanks,
Paul
--------------1609F71524B68E54AE91829A
Content-Type: text/x-patch; charset=us-ascii;
 name="nbd_remove_paranoia.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_remove_paranoia.diff"

--- 2_6_3_rc2/include/linux/nbd.h.PRISTINE	Thu Feb 19 12:06:07 2004
+++ 2_6_3_rc2/include/linux/nbd.h	Thu Feb 19 12:34:35 2004
@@ -8,6 +8,8 @@
  * 2003/06/24 Louis D. Langholtz <ldl@aros.net>
  *            Removed unneeded blksize_bits field from nbd_device struct.
  *            Cleanup PARANOIA usage & code.
+ * 2004/02/19 Paul Clements
+ *            Removed PARANOIA, plus various cleanup and comments
  */
 
 #ifndef LINUX_NBD_H
@@ -32,22 +34,19 @@ enum {
 #define nbd_cmd(req) ((req)->cmd[0])
 #define MAX_NBD 128
 
-/* Define PARANOIA to include extra sanity checking code in here & driver */
-#define PARANOIA
-
 /* userspace doesn't need the nbd_device structure */
 #ifdef __KERNEL__
 
+/* values for flags field */
+#define NBD_READ_ONLY 0x0001
+#define NBD_WRITE_NOCHK 0x0002
+
 struct nbd_device {
 	int flags;
 	int harderror;		/* Code of hard error			*/
-#define NBD_READ_ONLY 0x0001
-#define NBD_WRITE_NOCHK 0x0002
 	struct socket * sock;
 	struct file * file; 	/* If == NULL, device is not ready, yet	*/
-#ifdef PARANOIA
-	int magic;		/* FIXME: not if debugging is off	*/
-#endif
+	int magic;
 	spinlock_t queue_lock;
 	struct list_head queue_head;/* Requests are added here...	*/
 	struct semaphore tx_lock;
@@ -58,16 +57,14 @@ struct nbd_device {
 
 #endif
 
-/* This now IS in some kind of include file...	*/
-
-/* These are send over network in request/reply magic field */
+/* These are sent over the network in the request/reply magic fields */
 
 #define NBD_REQUEST_MAGIC 0x25609513
 #define NBD_REPLY_MAGIC 0x67446698
 /* Do *not* use magics: 0x12560953 0x96744668. */
 
 /*
- * This is packet used for communication between client and
+ * This is the packet used for communication between client and
  * server. All data are in network byte order.
  */
 struct nbd_request {
@@ -82,6 +79,10 @@ struct nbd_request {
 #endif
 ;
 
+/*
+ * This is the reply packet that nbd-server sends back to the client after
+ * it has completed an I/O request (or an error occurs).
+ */
 struct nbd_reply {
 	u32 magic;
 	u32 error;		/* 0 = ok, else error	*/
--- 2_6_3_rc2/drivers/block/nbd.c.PROC_PARTITIONS_FIXES	Thu Feb 19 11:49:15 2004
+++ 2_6_3_rc2/drivers/block/nbd.c	Thu Feb 19 12:54:48 2004
@@ -36,7 +36,7 @@
  * 03-06-24 Remove unneeded blksize_bits field from nbd_device struct.
  *   <ldl@aros.net>
  * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
- *
+ * 04-02-19 Remove PARANOIA, plus various cleanups (Paul Clements)
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
  *          structure with userland
@@ -61,12 +61,9 @@
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
-/* Define PARANOIA in linux/nbd.h to turn on extra sanity checking */
 #include <linux/nbd.h>
 
-#ifdef PARANOIA
 #define LO_MAGIC 0x68797548
-#endif
 
 #ifdef NDEBUG
 #define dprintk(flags, fmt...)
@@ -97,11 +94,6 @@ static struct nbd_device nbd_dev[MAX_NBD
  */
 static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
 
-#ifdef PARANOIA
-static int requests_in;
-static int requests_out;
-#endif
-
 #ifndef NDEBUG
 static const char *ioctl_cmd_to_ascii(int cmd)
 {
@@ -153,9 +145,6 @@ static void nbd_end_request(struct reque
 	}
 	spin_unlock(&lo->queue_lock);
 
-#ifdef PARANOIA
-	requests_out++;
-#endif
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
 		end_that_request_last(req);
@@ -217,10 +206,6 @@ static int sock_xmit(struct socket *sock
 		}
 
 		if (result <= 0) {
-#ifdef PARANOIA
-			printk(KERN_ERR "nbd: %s - sock=%p at buf=%p, size=%d returned %d.\n",
-			       send? "send": "receive", sock, buf, size, result);
-#endif
 			if (result == 0)
 				result = -EPIPE; /* short read */
 			break;
@@ -414,9 +399,8 @@ void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
-#ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
-#endif
+
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
 	return;
@@ -426,9 +410,7 @@ void nbd_clear_que(struct nbd_device *lo
 {
 	struct request *req;
 
-#ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
-#endif
 
 	do {
 		req = NULL;
@@ -467,9 +449,9 @@ static void do_nbd_request(request_queue
 			goto error_out;
 
 		lo = req->rq_disk->private_data;
-#ifdef PARANOIA
+
 		BUG_ON(lo->magic != LO_MAGIC);
-#endif
+
 		if (!lo->file) {
 			printk(KERN_ERR "%s: Request when not-ready\n",
 					lo->disk->disk_name);
@@ -484,9 +466,6 @@ static void do_nbd_request(request_queue
 				goto error_out;
 			}
 		}
-#ifdef PARANOIA
-		requests_in++;
-#endif
 
 		req->errors = 0;
 		spin_unlock_irq(q->queue_lock);
@@ -527,7 +506,7 @@ static void do_nbd_request(request_queue
 		spin_lock_irq(q->queue_lock);
 		continue;
 
-	      error_out:
+error_out:
 		req->errors++;
 		spin_unlock(q->queue_lock);
 		nbd_end_request(req);
@@ -545,9 +524,9 @@ static int nbd_ioctl(struct inode *inode
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-#ifdef PARANOIA
+
 	BUG_ON(lo->magic != LO_MAGIC);
-#endif
+
 	/* Anyone capable of this syscall can do *real bad* things */
 	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
 			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
@@ -663,15 +642,10 @@ static int nbd_ioctl(struct inode *inode
 		nbd_clear_que(lo);
 		return 0;
 	case NBD_PRINT_DEBUG:
-#ifdef PARANOIA
-		printk(KERN_INFO "%s: next = %p, prev = %p. Global: in %d, out %d\n",
-			inode->i_bdev->bd_disk->disk_name, lo->queue_head.next,
-			lo->queue_head.prev, requests_in, requests_out);
-#else
-		printk(KERN_INFO "%s: next = %p, prev = %p\n",
+		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
 			inode->i_bdev->bd_disk->disk_name,
-			lo->queue_head.next, lo->queue_head.prev);
-#endif
+			lo->queue_head.next, lo->queue_head.prev,
+			&lo->queue_head);
 		return 0;
 	}
 	return -EINVAL;
@@ -693,12 +667,10 @@ static int __init nbd_init(void)
 	int err = -ENOMEM;
 	int i;
 
-#ifdef PARANOIA
 	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "nbd: Sizeof nbd_request needs to be 28 in order to work!\n" );
+		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
 		return -EIO;
 	}
-#endif
 
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = alloc_disk(1);
@@ -729,9 +701,7 @@ static int __init nbd_init(void)
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].file = NULL;
-#ifdef PARANOIA
 		nbd_dev[i].magic = LO_MAGIC;
-#endif
 		nbd_dev[i].flags = 0;
 		spin_lock_init(&nbd_dev[i].queue_lock);
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);

--------------1609F71524B68E54AE91829A--

