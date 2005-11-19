Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVKSWez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVKSWez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVKSWez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:34:55 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:43271 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750969AbVKSWey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:34:54 -0500
Date: Sun, 20 Nov 2005 09:34:19 +1100
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: + nbd-fix-tx-rx-race-condition.patch added to -mm tree
Message-ID: <20051119223419.GA1751@gondor.apana.org.au>
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <437F4C85.3070108@steeleye.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 19, 2005 at 11:02:13AM -0500, Paul Clements wrote:
> 
> Thanks for this. It looks correct, for the most part, and seems to deal 
> with the various race conditions well (probably more cleanly than we 
> were doing before). There is one problem with this patch, though. You 
> have removed the acquiring of queue_lock from nbd_clear_que. I don't 
> know if that was intentional or not, but the queue_lock must be taken 
> when the queue is being modified. For instance, if nbd-client -d 
> (disconnect) gets called on an active nbd device, then you'll have a 
> race between requests being completed and pulled off the queue 
> (nbd_find_request) and nbd-client -d (which calls nbd_clear_que).

This is intentional actually.  nbd_clear_queue never races against
nbd_find_request because the ioctl is protected by the BKL.  If it
weren't, then we have much worse problems to worry about (e.g.,
while you're clearing the queue someone else could have set the
socket again and started queueing requests).

> >+	/*
> >+	 * lo->sock == NULL guarantees that the queue will not grow beyond 
> >the
> >+	 * current active request.
> >+	 */

This comment is why we can do without the locking.  The only other
function that modifies the list (apart from nbd_find_request and
nbd_clear_queueis) is nbd_do_request.

When we enter nbd_clear_queue, lo->sock must have been set to NULL.
In fact, we always take the tx_lock while setting lo->sock.  So we
have two possibilities:

CPU0						CPU1
						nbd_do_request
down(tx_lock)
lo->sock = NULL
up(tx_lock)
							down(tx_lock)
							bail as lo->sock is
								NULL
							up(tx_lock)
	nbd_clear_queue

If any request occurs after the setting, then clearly the list will not
be modified.


CPU0						CPU1
						nbd_do_request
							down(tx_lock)
							add req to list
							up(tx_lock)
down(tx_lock)
lo->sock = NULL
up(tx_lock)
	nbd_clear_queue

If any request occurs before the setting, the list has been modified
already.  The up/down also gives us the required memory barriers so
that we can operate on the list safely.

In fact, I just realised that for the same reason active_req must be
NULL as well.  So here is an updated patch which removes the active_req
wait in nbd_clear_queue and the associated memory barrier.

I've also clarified this in the comment.


[NBD] Fix TX/RX race condition

Janos Haar of First NetCenter Bt.  reported numerous crashes involving the
NBD driver.  With his help, this was tracked down to bogus bio vectors
which in turn was the result of a race condition between the
receive/transmit routines in the NBD driver.

The bug manifests itself like this:

CPU0                            CPU1
do_nbd_request
        add req to queuelist
        nbd_send_request
                send req head
                for each bio
                        kmap
                        send
                                nbd_read_stat
                                        nbd_find_request
                                        nbd_end_request
                        kunmap

When CPU1 finishes nbd_end_request, the request and all its associated
bio's are freed.  So when CPU0 calls kunmap whose argument is derived from
the last bio, it may crash.

Under normal circumstances, the race occurs only on the last bio.  However,
if an error is encountered on the remote NBD server (such as an incorrect
magic number in the request), or if there were a bug in the server, it is
possible for the nbd_end_request to occur any time after the request's
addition to the queuelist.

The following patch fixes this problem by making sure that requests are not
added to the queuelist until after they have been completed transmission.

In order for the receiving side to be ready for responses involving
requests still being transmitted, the patch introduces the concept of the
active request.

When a response matches the current active request, its processing is
delayed until after the tranmission has come to a stop.

This has been tested by Janos and it has been successful in curing this
race condition.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -54,11 +54,15 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/ioctl.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
 #include <net/sock.h>
 
 #include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
+#include <asm/system.h>
 #include <asm/types.h>
 
 #include <linux/nbd.h>
@@ -230,14 +234,6 @@ static int nbd_send_req(struct nbd_devic
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
-	down(&lo->tx_lock);
-
-	if (!sock || !lo->sock) {
-		printk(KERN_ERR "%s: Attempted send on closed socket\n",
-				lo->disk->disk_name);
-		goto error_out;
-	}
-
 	dprintk(DBG_TX, "%s: request %p: sending control (%s@%llu,%luB)\n",
 			lo->disk->disk_name, req,
 			nbdcmd_to_ascii(nbd_cmd(req)),
@@ -276,11 +272,9 @@ static int nbd_send_req(struct nbd_devic
 			}
 		}
 	}
-	up(&lo->tx_lock);
 	return 0;
 
 error_out:
-	up(&lo->tx_lock);
 	return 1;
 }
 
@@ -289,9 +283,14 @@ static struct request *nbd_find_request(
 	struct request *req;
 	struct list_head *tmp;
 	struct request *xreq;
+	int err;
 
 	memcpy(&xreq, handle, sizeof(xreq));
 
+	err = wait_event_interruptible(lo->active_wq, lo->active_req != xreq);
+	if (unlikely(err))
+		goto out;
+
 	spin_lock(&lo->queue_lock);
 	list_for_each(tmp, &lo->queue_head) {
 		req = list_entry(tmp, struct request, queuelist);
@@ -302,7 +301,11 @@ static struct request *nbd_find_request(
 		return req;
 	}
 	spin_unlock(&lo->queue_lock);
-	return NULL;
+
+	err = -ENOENT;
+
+out:
+	return ERR_PTR(err);
 }
 
 static inline int sock_recv_bvec(struct socket *sock, struct bio_vec *bvec)
@@ -331,7 +334,11 @@ static struct request *nbd_read_stat(str
 		goto harderror;
 	}
 	req = nbd_find_request(lo, reply.handle);
-	if (req == NULL) {
+	if (unlikely(IS_ERR(req))) {
+		result = PTR_ERR(req);
+		if (result != -ENOENT)
+			goto harderror;
+
 		printk(KERN_ERR "%s: Unexpected reply (%p)\n",
 				lo->disk->disk_name, reply.handle);
 		result = -EBADR;
@@ -395,19 +402,24 @@ static void nbd_clear_que(struct nbd_dev
 
 	BUG_ON(lo->magic != LO_MAGIC);
 
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
-			nbd_end_request(req);
-		}
-	} while (req);
+	/*
+	 * Because we have set lo->sock to NULL under the tx_lock, all
+	 * modifications to the list must have completed by now.  For
+	 * the same reason, the active_req must be NULL.
+	 *
+	 * As a consequence, we don't need to take the spin lock while
+	 * purging the list here.
+	 */
+	BUG_ON(lo->sock);
+	BUG_ON(lo->active_req);
+
+	while (!list_empty(&lo->queue_head)) {
+		req = list_entry(lo->queue_head.next, struct request,
+				 queuelist);
+		list_del_init(&req->queuelist);
+		req->errors++;
+		nbd_end_request(req);
+	}
 }
 
 /*
@@ -435,11 +447,6 @@ static void do_nbd_request(request_queue
 
 		BUG_ON(lo->magic != LO_MAGIC);
 
-		if (!lo->file) {
-			printk(KERN_ERR "%s: Request when not-ready\n",
-					lo->disk->disk_name);
-			goto error_out;
-		}
 		nbd_cmd(req) = NBD_CMD_READ;
 		if (rq_data_dir(req) == WRITE) {
 			nbd_cmd(req) = NBD_CMD_WRITE;
@@ -453,32 +460,34 @@ static void do_nbd_request(request_queue
 		req->errors = 0;
 		spin_unlock_irq(q->queue_lock);
 
-		spin_lock(&lo->queue_lock);
-
-		if (!lo->file) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "%s: failed between accept and semaphore, file lost\n",
-					lo->disk->disk_name);
+		down(&lo->tx_lock);
+		if (unlikely(!lo->sock)) {
+			up(&lo->tx_lock);
+			printk(KERN_ERR "%s: Attempted send on closed socket\n",
+			       lo->disk->disk_name);
 			req->errors++;
 			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
 			continue;
 		}
 
-		list_add(&req->queuelist, &lo->queue_head);
-		spin_unlock(&lo->queue_lock);
+		lo->active_req = req;
 
 		if (nbd_send_req(lo, req) != 0) {
 			printk(KERN_ERR "%s: Request send failed\n",
 					lo->disk->disk_name);
-			if (nbd_find_request(lo, (char *)&req) != NULL) {
-				/* we still own req */
-				req->errors++;
-				nbd_end_request(req);
-			} else /* we're racing with nbd_clear_que */
-				printk(KERN_DEBUG "nbd: can't find req\n");
+			req->errors++;
+			nbd_end_request(req);
+		} else {
+			spin_lock(&lo->queue_lock);
+			list_add(&req->queuelist, &lo->queue_head);
+			spin_unlock(&lo->queue_lock);
 		}
 
+		lo->active_req = NULL;
+		up(&lo->tx_lock);
+		wake_up_all(&lo->active_wq);
+
 		spin_lock_irq(q->queue_lock);
 		continue;
 
@@ -529,17 +538,10 @@ static int nbd_ioctl(struct inode *inode
 		down(&lo->tx_lock);
 		lo->sock = NULL;
 		up(&lo->tx_lock);
-		spin_lock(&lo->queue_lock);
 		file = lo->file;
 		lo->file = NULL;
-		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
-		spin_lock(&lo->queue_lock);
-		if (!list_empty(&lo->queue_head)) {
-			printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
-			error = -EBUSY;
-		}
-		spin_unlock(&lo->queue_lock);
+		BUG_ON(!list_empty(&lo->queue_head));
 		if (file)
 			fput(file);
 		return error;
@@ -598,24 +600,19 @@ static int nbd_ioctl(struct inode *inode
 			lo->sock = NULL;
 		}
 		up(&lo->tx_lock);
-		spin_lock(&lo->queue_lock);
 		file = lo->file;
 		lo->file = NULL;
-		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
 		printk(KERN_WARNING "%s: queue cleared\n", lo->disk->disk_name);
 		if (file)
 			fput(file);
 		return lo->harderror;
 	case NBD_CLEAR_QUE:
-		down(&lo->tx_lock);
-		if (lo->sock) {
-			up(&lo->tx_lock);
-			return 0; /* probably should be error, but that would
-				   * break "nbd-client -d", so just return 0 */
-		}
-		up(&lo->tx_lock);
-		nbd_clear_que(lo);
+		/*
+		 * This is for compatibility only.  The queue is always cleared
+		 * by NBD_DO_IT or NBD_CLEAR_SOCK.
+		 */
+		BUG_ON(!lo->sock && !list_empty(&lo->queue_head));
 		return 0;
 	case NBD_PRINT_DEBUG:
 		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
@@ -688,6 +685,7 @@ static int __init nbd_init(void)
 		spin_lock_init(&nbd_dev[i].queue_lock);
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
 		init_MUTEX(&nbd_dev[i].tx_lock);
+		init_waitqueue_head(&nbd_dev[i].active_wq);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].bytesize = 0x7ffffc00ULL << 10; /* 2TB */
 		disk->major = NBD_MAJOR;
diff --git a/include/linux/nbd.h b/include/linux/nbd.h
--- a/include/linux/nbd.h
+++ b/include/linux/nbd.h
@@ -37,18 +37,26 @@ enum {
 /* userspace doesn't need the nbd_device structure */
 #ifdef __KERNEL__
 
+#include <linux/wait.h>
+
 /* values for flags field */
 #define NBD_READ_ONLY 0x0001
 #define NBD_WRITE_NOCHK 0x0002
 
+struct request;
+
 struct nbd_device {
 	int flags;
 	int harderror;		/* Code of hard error			*/
 	struct socket * sock;
 	struct file * file; 	/* If == NULL, device is not ready, yet	*/
 	int magic;
+
 	spinlock_t queue_lock;
 	struct list_head queue_head;/* Requests are added here...	*/
+	struct request *active_req;
+	wait_queue_head_t active_wq;
+
 	struct semaphore tx_lock;
 	struct gendisk *disk;
 	int blksize;

--nFreZHaLTZJo0R7j--
