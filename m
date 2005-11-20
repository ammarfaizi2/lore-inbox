Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVKTB6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKTB6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKTB6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:58:34 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:21000 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751139AbVKTB6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:58:33 -0500
Date: Sun, 20 Nov 2005 12:58:07 +1100
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [NBD] Use per-device semaphore instead of BKL
Message-ID: <20051120015807.GA3593@gondor.apana.org.au>
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20051119223419.GA1751@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 20, 2005 at 09:34:19AM +1100, herbert wrote:
> 
> This is intentional actually.  nbd_clear_queue never races against
> nbd_find_request because the ioctl is protected by the BKL.  If it
> weren't, then we have much worse problems to worry about (e.g.,
> while you're clearing the queue someone else could have set the
> socket again and started queueing requests).

Actually, we do have bigger problems :) The BKL is dropped every
time you sleep, and nbd_do_it is definitely a frequent sleeper :)

This isn't really an issue in practice though because the NBD
client program is single-threaded and doesn't share its file
descriptors with anyone else.

However, we shouldn't make it too easy for the user to shoot himself
in the foot.  If he's going to do that, let him at least pay for the
bullet :)

So here is a patch to use a per-device semaphore instead of the
BKL to protect the ioctl's against each other.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -500,9 +500,9 @@ error_out:
 	return;
 }
 
-static int nbd_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, unsigned long arg)
+static long nbd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	struct inode *inode = file->f_dentry->d_inode;
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
 	int error;
 	struct request sreq ;
@@ -516,6 +516,10 @@ static int nbd_ioctl(struct inode *inode
 	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
 			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
 
+	error = down_interruptible(&lo->ioctl_lock);
+	if (unlikely(error))
+		return error;
+
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
@@ -528,13 +532,14 @@ static int nbd_ioctl(struct inode *inode
 		 */
 		sreq.sector = 0;
 		sreq.nr_sectors = 0;
+		error = -EINVAL;
                 if (!lo->sock)
-			return -EINVAL;
+			break;
                 nbd_send_req(lo, &sreq);
-                return 0;
+		error = 0;
+		break;
  
 	case NBD_CLEAR_SOCK:
-		error = 0;
 		down(&lo->tx_lock);
 		lo->sock = NULL;
 		up(&lo->tx_lock);
@@ -544,10 +549,12 @@ static int nbd_ioctl(struct inode *inode
 		BUG_ON(!list_empty(&lo->queue_head));
 		if (file)
 			fput(file);
-		return error;
+		break;
+
 	case NBD_SET_SOCK:
+		error = -EBUSY;
 		if (lo->file)
-			return -EBUSY;
+			break;
 		error = -EINVAL;
 		file = fget(arg);
 		if (file) {
@@ -560,29 +567,34 @@ static int nbd_ioctl(struct inode *inode
 				fput(file);
 			}
 		}
-		return error;
+		break;
+
 	case NBD_SET_BLKSIZE:
 		lo->blksize = arg;
 		lo->bytesize &= ~(lo->blksize-1);
 		inode->i_bdev->bd_inode->i_size = lo->bytesize;
 		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
+		break;
+
 	case NBD_SET_SIZE:
 		lo->bytesize = arg & ~(lo->blksize-1);
 		inode->i_bdev->bd_inode->i_size = lo->bytesize;
 		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
+		break;
+
 	case NBD_SET_SIZE_BLOCKS:
 		lo->bytesize = ((u64) arg) * lo->blksize;
 		inode->i_bdev->bd_inode->i_size = lo->bytesize;
 		set_blocksize(inode->i_bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
-		return 0;
+		break;
+
 	case NBD_DO_IT:
+		error = -EINVAL;
 		if (!lo->file)
-			return -EINVAL;
+			break;
 		nbd_do_it(lo);
 		/* on return tidy up in case we have a signal */
 		/* Forcibly shutdown the socket causing all listeners
@@ -606,28 +618,36 @@ static int nbd_ioctl(struct inode *inode
 		printk(KERN_WARNING "%s: queue cleared\n", lo->disk->disk_name);
 		if (file)
 			fput(file);
-		return lo->harderror;
+		error = lo->harderror;
+		break;
+
 	case NBD_CLEAR_QUE:
 		/*
 		 * This is for compatibility only.  The queue is always cleared
 		 * by NBD_DO_IT or NBD_CLEAR_SOCK.
 		 */
 		BUG_ON(!lo->sock && !list_empty(&lo->queue_head));
-		return 0;
+		break;
+
 	case NBD_PRINT_DEBUG:
 		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
 			inode->i_bdev->bd_disk->disk_name,
 			lo->queue_head.next, lo->queue_head.prev,
 			&lo->queue_head);
-		return 0;
+		break;
+
+	default:
+		error = -EINVAL;
+		break;
 	}
-	return -EINVAL;
+
+	up(&lo->ioctl_lock);
+	return error;
 }
 
-static struct block_device_operations nbd_fops =
-{
-	.owner =	THIS_MODULE,
-	.ioctl =	nbd_ioctl,
+static struct block_device_operations nbd_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = nbd_ioctl,
 };
 
 /*
@@ -685,6 +705,7 @@ static int __init nbd_init(void)
 		spin_lock_init(&nbd_dev[i].queue_lock);
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
 		init_MUTEX(&nbd_dev[i].tx_lock);
+		init_MUTEX(&nbd_dev[i].ioctl_lock);
 		init_waitqueue_head(&nbd_dev[i].active_wq);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].bytesize = 0x7ffffc00ULL << 10; /* 2TB */
diff --git a/include/linux/nbd.h b/include/linux/nbd.h
--- a/include/linux/nbd.h
+++ b/include/linux/nbd.h
@@ -58,6 +58,8 @@ struct nbd_device {
 	wait_queue_head_t active_wq;
 
 	struct semaphore tx_lock;
+	struct semaphore ioctl_lock;
+
 	struct gendisk *disk;
 	int blksize;
 	u64 bytesize;

--cNdxnHkX5QqsyA0e--
