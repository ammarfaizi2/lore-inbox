Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTGBABO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTGBABN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:01:13 -0400
Received: from dm4-149.slc.aros.net ([66.219.220.149]:56214 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S263786AbTGBAAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:00:54 -0400
Message-ID: <3F022410.6020608@aros.net>
Date: Tue, 01 Jul 2003 18:15:12 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH] nbd driver for 2.5+: add compatibility with previous ioctl
 user interface
Content-Type: multipart/mixed;
 boundary="------------020905090705070303050705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020905090705070303050705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is the seventh patch to the NBD driver and it's meant to add 
backward compatibility with the previous ioctl user interface while 
maintaining the better resource locking (ie. make NBD_SET_SOCK, 
NBD_DO_IT, NBD_CLEAR_SOCK all functional again as they were before patch 
6). It also re-orders code more, adds a new ioctl called NBD_RUN_SOCK 
(to be used like NBD_DO_IT in and only in patch 6), and a few other 
things. This patch can be applied sequentially with my other patches 
against 2.5.73 or this patch can alternatively just solely be applied 
against Andrew's 2.5.73-mm2 sources.

Unfortunately, with this patch I've also realized some things that I'm 
not pleased about:

   1. I don't like compatibility enough in this case to justify it (even
      though I've implemented it).
   2. This patch adds some new uglies (albiet not so bad as without the
      resource locking fixes of patch 6).
   3. The previous nbd resource locking problems are too time consuming
      for me to properly explain.
   4. It's best going forward for me to entirely fork my work on the nbd
      driver rather than to try making so many little changes to the
      mainstream this quickly. This will allow tighter integration with
      any required user space tools and also facilitate concentrating on
      the changes I'm most interested in. If you'd like to follow my
      future forked work, please do so at
      <http://freshmeat.net/projects/anbd/>.








--------------020905090705070303050705
Content-Type: text/plain;
 name="nbd-patch7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch7"

diff -urN linux-2.5.73-p6.2/drivers/block/nbd.c linux-2.5.73-p7/drivers/block/nbd.c
--- linux-2.5.73-p6.2/drivers/block/nbd.c	2003-06-30 11:58:50.000000000 -0600
+++ linux-2.5.73-p7/drivers/block/nbd.c	2003-07-01 12:31:53.258728598 -0600
@@ -41,6 +41,8 @@
  *   require them to be updated. Actually, the linux 2.5 block layer redisign
  *   already required existing user tools to be updated to properly set the
  *   correct device size. <ldl@aros.net>
+ * 03-06-30 Added compatibility with previous ioctl user interface while
+ *   maintaining better resource locking. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -112,6 +114,8 @@
 static int requests_out;
 #endif
 
+static int backcompat = 1;
+
 #ifndef NDEBUG
 static const char *ioctl_cmd_to_ascii(int cmd)
 {
@@ -120,6 +124,7 @@
 	case NBD_SET_BLKSIZE: return "set-blksize";
 	case NBD_SET_SIZE: return "set-size";
 	case NBD_DO_IT: return "do-it";
+	case NBD_RUN_SOCK: return "run-sock";
 	case NBD_CLEAR_SOCK: return "clear-sock";
 	case NBD_CLEAR_QUE: return "clear-que";
 	case NBD_PRINT_DEBUG: return "print-debug";
@@ -400,32 +405,6 @@
 	return req;
 }
 
-static int nbd_clear_que(struct nbd_device *lo)
-{
-	struct request *req;
-
-	down(&lo->tx_lock);
-	if (lo->sock) {
-		up(&lo->tx_lock);
-		return -EBUSY;
-	}
-	do {
-		req = NULL;
-		spin_lock(&lo->queue_lock);
-		if (!list_empty(&lo->queue_head)) {
-			req = list_entry(lo->queue_head.next, struct request, queuelist);
-			list_del_init(&req->queuelist);
-		}
-		spin_unlock(&lo->queue_lock);
-		if (req) {
-			req->errors++;
-			request_end(req);
-		}
-	} while (req);
-	up(&lo->tx_lock);
-	return 0;
-}
-
 /*
  * We always wait for result of write, for now. It would be nice to make it optional
  * in future
@@ -533,16 +512,53 @@
 	return 0;
 }
 
-static int nbd_do_it(struct nbd_device *lo, unsigned int fd)
+static int nbd_set_sock(struct nbd_device *lo, int fd)
+{
+	struct file *file;
+
+	dprintk(DBG_IOCTL, "%s: %s[%d] called set-sock %d\n",
+			lo->disk->disk_name, current->comm, current->pid, fd);
+
+	/* give nbd-client way to check busy before NBD_DO_IT */
+	if (lo->sock)
+		return -EBUSY;
+
+	/* implement some checks for nbd-client */
+	file = fget(fd);
+	if (!file)
+		return backcompat? -EINVAL: -EBADF;
+	fput(file);
+
+	lo->file = fd;
+	return 0;
+}
+
+static int nbd_clear_sock(struct nbd_device *lo)
+{
+	dprintk(DBG_IOCTL, "%s: %s[%d] called clear-sock\n",
+			lo->disk->disk_name, current->comm, current->pid);
+
+	/* implement some checks for nbd-client */
+	if (lo->file == -1)
+		return backcompat? 0: -EINVAL;
+
+	lo->file = -1;
+	return 0;
+}
+
+static int nbd_run_sock(struct nbd_device *lo, int fd)
 {
 	struct file *file;
 	struct inode *inode;
 	struct socket *sock;
 	struct request *req;
 
+	dprintk(DBG_IOCTL, "%s: %s[%d] called run-sock %d\n",
+			lo->disk->disk_name, current->comm, current->pid, fd);
+
 	file = fget(fd);
 	if (!file)
-		return -EBADF;
+		return backcompat? -EINVAL: -EBADF;
 	inode = file->f_dentry->d_inode;
 	if (!inode->i_sock) {
 		fput(file);
@@ -563,28 +579,31 @@
 	lo->sock = sock;
 	up(&lo->tx_lock);
 
+	lo->harderror = 0;
 	/* no need for rx lock since here is the rx... */
-	dprintk(DBG_IOCTL, "%s: nbd_do_it: commencing read loop\n",
-			lo->disk->disk_name);
+	dprintk(DBG_IOCTL, "%s: commencing read loop\n", lo->disk->disk_name);
 	while ((req = nbd_read_stat(lo)) != NULL)
 		request_end(req);
-	dprintk(DBG_IOCTL, "%s: nbd_do_it: read loop finished\n",
-			lo->disk->disk_name);
+	dprintk(DBG_IOCTL, "%s: read loop finished\n", lo->disk->disk_name);
 
 	down(&lo->tx_lock);
 	lo->sock = NULL;
 	up(&lo->tx_lock);
 
+	/* In case shutdown occurred from disconnect, wake up disconnector */
+	wake_up(&lo->waiters);
+
 	fput(file);
 	return lo->harderror;
 }
 
 static int nbd_disconnect(struct nbd_device *lo)
 {
-	int error;
+	int sent;
 	struct request sreq;
 
-	printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
+	dprintk(DBG_IOCTL, "%s: %s[%d] called disconnect\n",
+			lo->disk->disk_name, current->comm, current->pid);
 
 	sreq.flags = REQ_SPECIAL;
 	nbd_cmd(&sreq) = NBD_CMD_DISC;
@@ -599,18 +618,30 @@
 
 	down(&lo->tx_lock);
 	if (lo->sock) {
-		error = 0;
 		nbd_send_req(lo, &sreq);
+		sent = 1;
 	}
 	else {
-		error = -ENOTCONN;
+		sent = 0;
 	}
 	up(&lo->tx_lock);
-	return error;
+
+	if (sent) {
+		/* Block till finished so no more user calls run till then */
+		dprintk(DBG_IOCTL, "%s: waiting till disconnect finished\n",
+				lo->disk->disk_name);
+		wait_event_interruptible(lo->waiters, lo->sock == NULL);
+		dprintk(DBG_IOCTL, "%s: disconnect all finished now\n",
+				lo->disk->disk_name);
+	}
+	return sent? 0: backcompat? -EINVAL: -ENOTCONN;
 }
 
 static int nbd_set_blksize(struct nbd_device *lo, unsigned long arg)
 {
+	dprintk(DBG_IOCTL, "%s: %s[%d] called set-blksize %lu\n",
+			lo->disk->disk_name, current->comm, current->pid, arg);
+
 	if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
 		return -EINVAL;
 	down(&lo->tx_lock);
@@ -627,6 +658,9 @@
 
 static int nbd_set_size(struct nbd_device *lo, unsigned long arg)
 {
+	dprintk(DBG_IOCTL, "%s: %s[%d] called set-size %lu\n",
+			lo->disk->disk_name, current->comm, current->pid, arg);
+
 	down(&lo->tx_lock);
 	if (lo->sock) {
 		up(&lo->tx_lock);
@@ -640,6 +674,9 @@
 
 static int nbd_set_size_blocks(struct nbd_device *lo, unsigned long arg)
 {
+	dprintk(DBG_IOCTL, "%s: %s[%d] called set-size-blocks %lu\n",
+			lo->disk->disk_name, current->comm, current->pid, arg);
+
 	down(&lo->tx_lock);
 	if (lo->sock) {
 		up(&lo->tx_lock);
@@ -651,28 +688,67 @@
 	return 0;
 }
 
+static int nbd_clear_que(struct nbd_device *lo)
+{
+	struct request *req;
+
+	dprintk(DBG_IOCTL, "%s: %s[%d] called clear-que\n",
+			lo->disk->disk_name, current->comm, current->pid);
+
+	down(&lo->tx_lock);
+	if (lo->sock) {
+		/*
+		 * Don't allow queue to be cleared while device is running!
+		 * Device must be stopped (disconnected) first. Otherwise
+		 * clearing is meaningless & can lock up processes: it's a
+		 * race with users who may queue up more requests after the
+		 * clearing is done that may then never be freed till the
+		 * system reboots or clear que is run again which just
+		 * opens the race yet again.
+		 */
+		up(&lo->tx_lock);
+		/* The original nbd-client expects 0 (always) */
+		return backcompat? 0: -EBUSY;
+	}
+	do {
+		req = NULL;
+		spin_lock(&lo->queue_lock);
+		if (!list_empty(&lo->queue_head)) {
+			req = list_entry(lo->queue_head.next, struct request, queuelist);
+			list_del_init(&req->queuelist);
+		}
+		spin_unlock(&lo->queue_lock);
+		if (req) {
+			req->errors++;
+			request_end(req);
+		}
+	} while (req);
+	up(&lo->tx_lock);
+	return 0;
+}
+
 static int nbd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct nbd_device *lo;
 
+	/* Anyone capable of this syscall can do *bad* things */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	lo = inode->i_bdev->bd_disk->private_data;
 #ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
 #endif
-	/* Anyone capable of this syscall can do *real bad* things */
-	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
-			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	switch (cmd) {
-	case NBD_CLEAR_SOCK: /* deprecated! */
-	case NBD_SET_SOCK: /* deprecated! */
-		printk(KERN_WARNING "%s: %s[%d] called deprecated ioctl %s\n",
-				lo->disk->disk_name,
-				current->comm, current->pid,
-				ioctl_cmd_to_ascii(cmd));
-		return -EINVAL;
+	case NBD_CLEAR_SOCK:
+		return nbd_clear_sock(lo);
+	case NBD_SET_SOCK:
+		return nbd_set_sock(lo, arg);
+	case NBD_DO_IT:
+		return nbd_run_sock(lo, lo->file);
+	case NBD_RUN_SOCK:
+		return nbd_run_sock(lo, arg);
 	case NBD_DISCONNECT:
 		return nbd_disconnect(lo);
 	case NBD_SET_BLKSIZE:
@@ -681,8 +757,6 @@
 		return nbd_set_size(lo, arg);
 	case NBD_SET_SIZE_BLOCKS:
 		return nbd_set_size_blocks(lo, arg);
-	case NBD_DO_IT:
-		return nbd_do_it(lo, arg);
 	case NBD_CLEAR_QUE:
 		return nbd_clear_que(lo);
 	case NBD_PRINT_DEBUG:
@@ -697,6 +771,9 @@
 #endif
 		return 0;
 	}
+	dprintk(DBG_IOCTL, "%s: %s[%d] unhandled-cmd=0x%x(%s) arg=%lu\n",
+			lo->disk->disk_name, current->comm, current->pid,
+			cmd, ioctl_cmd_to_ascii(cmd), arg);
 	return -EINVAL;
 }
 
@@ -751,6 +828,7 @@
 
 	printk(KERN_INFO "nbd: registered device at major %d\n", NBD_MAJOR);
 	dprintk(DBG_INIT, "nbd: debugflags=0x%x\n", debugflags);
+	dprintk(DBG_INIT, "nbd: backcompat=%d\n", backcompat);
 
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
@@ -765,6 +843,10 @@
 		init_MUTEX(&nbd_dev[i].tx_lock);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
+		nbd_dev[i].file = -1;
+		nbd_dev[i].sock = NULL;
+		nbd_dev[i].harderror = 0;
+		init_waitqueue_head(&nbd_dev[i].waiters);
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
@@ -814,3 +896,6 @@
 MODULE_PARM(debugflags, "i");
 MODULE_PARM_DESC(debugflags, "flags for controlling debug output");
 #endif
+
+MODULE_PARM(backcompat, "i");
+MODULE_PARM_DESC(backcompat, "boolean for better backward compatibility");
diff -urN linux-2.5.73-p6.2/include/linux/nbd.h linux-2.5.73-p7/include/linux/nbd.h
--- linux-2.5.73-p6.2/include/linux/nbd.h	2003-06-25 09:20:19.000000000 -0600
+++ linux-2.5.73-p7/include/linux/nbd.h	2003-07-01 11:48:06.868415543 -0600
@@ -8,9 +8,25 @@
  * 2003/06/24 Louis D. Langholtz <ldl@aros.net>
  *            Removed unneeded blksize_bits field from nbd_device struct.
  *            Cleanup PARANOIA usage & code.
- *            Removed unneeded file field from nbd_device struct & moved
- *              kernel specific stuff within __KERNEL__. The non-kernel stuff
- *              should probably be moved to its own file (someday).
+ *            Moved kernel specific stuff within __KERNEL__ and turned file
+ *              field into holder for descriptor instead of pointer to struct
+ *              file. The non-kernel stuff should probably be moved to its
+ *              own file (someday). The change to file field is so NBD_DO_IT()
+ *              ioctl handling can just use new NBD_RUN_SOCK(descriptor)
+ *              instead. With this new scheme, if NBD_SET_SOCK is called by
+ *              one process, and then NBD_DO_IT gets called by another
+ *              process (essentially willy-nilly calling of the NBD ioctls)
+ *              this change fails *gracefully* with an error. On the other
+ *              hand, with the previous implementation, if user processes call
+ *              the NBD ioctls willy-nilly, failure meant oops if you were
+ *              lucky, data corruption if not. Consequently, we can say a
+ *              user who can run the nbd ioctls can do bad things rather
+ *              than *really* bad things. So bad things are like root shutting
+ *              down the nbd device on users who weren't forewarned for which
+ *              we have precendence in just about every other driver etc.
+ *              Eventually NBD_SET_SOCK, NBD_CLEAR_SOCK, and NBD_DO_IT may
+ *              go away in favor of just the one NBD_RUN_SOCK ioctl and then
+ *              the file field can go away from the nbd_device struct too.
  */
 
 #ifndef LINUX_NBD_H
@@ -25,6 +41,7 @@
 #define NBD_PRINT_DEBUG	_IO( 0xab, 6 )
 #define NBD_SET_SIZE_BLOCKS	_IO( 0xab, 7 )
 #define NBD_DISCONNECT  _IO( 0xab, 8 )
+#define NBD_RUN_SOCK    _IO( 0xab, 9 )
 
 /* These are send over network in request/reply magic field */
 #define NBD_REQUEST_MAGIC 0x25609513
@@ -73,7 +90,8 @@
 	int harderror;		/* Code of hard error			*/
 #define NBD_READ_ONLY 0x0001
 #define NBD_WRITE_NOCHK 0x0002
-	struct socket * sock;
+	struct socket * sock;	/* If == NULL, device is not ready, yet */
+	int file; /* previously struct file *, descriptor now (see above) */
 #ifdef PARANOIA
 	int magic;		/* FIXME: not if debugging is off	*/
 #endif
@@ -83,6 +101,7 @@
 	struct gendisk *disk;
 	int blksize;
 	u64 bytesize;
+	wait_queue_head_t waiters;
 };
 
 #endif /* __KERNEL__ */

--------------020905090705070303050705--

