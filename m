Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVKTWJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVKTWJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVKTWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:09:00 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:63243 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932086AbVKTWI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:08:59 -0500
Date: Mon, 21 Nov 2005 09:08:20 +1100
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NBD] Use per-device semaphore instead of BKL
Message-ID: <20051120220820.GA11920@gondor.apana.org.au>
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au> <20051120015807.GA3593@gondor.apana.org.au> <4380B015.9060005@steeleye.com> <20051120204325.GB11043@gondor.apana.org.au> <4380EDBF.7090107@steeleye.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <4380EDBF.7090107@steeleye.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 20, 2005 at 04:42:23PM -0500, Paul Clements wrote:
> 
> nbd-client -d (disconnect) is the main reason -- this functionality 
> would be broken if we didn't allow ioctls anymore

Good point.  In fact my initial patch missed a pair of locks around
this case as well.  Here is a patch to move NBD_DISCONNECT outside
the ioctl_lock and add a tx_lock around it.


[NBD] Use per-device semaphore instead of BKL

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

In order to preserve compatibility the ioctls NBD_DISCONNECT,
NBD_CLEAR_QUE and NBD_PRINT_DEBUG may be invoked without taking
the semaphore.

This patch also adds back the tx_lock for NBD_DISCONNECT that
went AWOL after the previous patch moved tx_lock outside of
nbd_send_req.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -275,7 +275,7 @@ static int nbd_send_req(struct nbd_devic
 	return 0;
 
 error_out:
-	return 1;
+	return result;
 }
 
 static struct request *nbd_find_request(struct nbd_device *lo, char *handle)
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
@@ -528,13 +528,39 @@ static int nbd_ioctl(struct inode *inode
 		 */
 		sreq.sector = 0;
 		sreq.nr_sectors = 0;
-                if (!lo->sock)
-			return -EINVAL;
-                nbd_send_req(lo, &sreq);
-                return 0;
+
+		error = down_interruptible(&lo->tx_lock);
+		if (error)
+			return error;
+
+		error = -EINVAL;
+		if (lo->sock)
+			error = nbd_send_req(lo, &sreq);
+
+		up(&lo->tx_lock);
+		return error;
+
+	case NBD_CLEAR_QUE:
+		/*
+		 * This is for compatibility only.  The queue is always cleared
+		 * by NBD_DO_IT or NBD_CLEAR_SOCK.
+		 */
+		return 0;
+
+	case NBD_PRINT_DEBUG:
+		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
+		       inode->i_bdev->bd_disk->disk_name,
+		       lo->queue_head.next, lo->queue_head.prev,
+		       &lo->queue_head);
+		return 0;
+	}
  
+	error = down_interruptible(&lo->ioctl_lock);
+	if (unlikely(error))
+		return error;
+
+	switch (cmd) {
 	case NBD_CLEAR_SOCK:
-		error = 0;
 		down(&lo->tx_lock);
 		lo->sock = NULL;
 		up(&lo->tx_lock);
@@ -544,10 +570,12 @@ static int nbd_ioctl(struct inode *inode
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
@@ -560,29 +588,34 @@ static int nbd_ioctl(struct inode *inode
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
@@ -606,28 +639,21 @@ static int nbd_ioctl(struct inode *inode
 		printk(KERN_WARNING "%s: queue cleared\n", lo->disk->disk_name);
 		if (file)
 			fput(file);
-		return lo->harderror;
-	case NBD_CLEAR_QUE:
-		/*
-		 * This is for compatibility only.  The queue is always cleared
-		 * by NBD_DO_IT or NBD_CLEAR_SOCK.
-		 */
-		BUG_ON(!lo->sock && !list_empty(&lo->queue_head));
-		return 0;
-	case NBD_PRINT_DEBUG:
-		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
-			inode->i_bdev->bd_disk->disk_name,
-			lo->queue_head.next, lo->queue_head.prev,
-			&lo->queue_head);
-		return 0;
+		error = lo->harderror;
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
@@ -685,6 +711,7 @@ static int __init nbd_init(void)
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

--dDRMvlgZJXvWKvBx--
