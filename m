Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbRE3QfX>; Wed, 30 May 2001 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbRE3QfM>; Wed, 30 May 2001 12:35:12 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:3083 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S261487AbRE3Qey>;
	Wed, 30 May 2001 12:34:54 -0400
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200105301639.RAA21383@gw.chygwyn.com>
Subject: Zerocopy NBD
To: linux-kernel@vger.kernel.org
Date: Wed, 30 May 2001 17:39:58 +0100 (BST)
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a patch I came up with recently to do add zerocopy support to
NBD for writes. I'm not intending that this should go into the kernel
before at least 2.5, I'm just sending it here in case it is useful to anyone.

I wrote it is a simple way to experiment with the new zerocopy code
rather than in a bid to improve the efficiency NBD dramatically. I'm
currently preparing a paper for the UKUUG Linux Conference which will
present some results obtained with the patch and discuss it in more
detail. The paper will be available on the web too nearer the time.

If anyone does try this patch out (or finds any bugs), then I'd be 
interested to know,

Thanks,

Steve.

---------------------------------------------------------------------------

diff -Nru linux-2.4.5/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.4.5/drivers/block/nbd.c	Sat May 26 19:47:49 2001
+++ linux/drivers/block/nbd.c	Mon May 28 11:07:45 2001
@@ -24,6 +24,7 @@
  * 01-3-11 Make nbd work with new Linux block layer code. It now supports
  *   plugging like all the other block devices. Also added in MSG_MORE to
  *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
+ * 01-5-27 Zerocopy support for data sending. <steve@chygwyn.com>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -86,6 +87,7 @@
 	return 0;
 }
 
+
 /*
  *  Send or receive packet.
  */
@@ -95,19 +97,10 @@
 	int result;
 	struct msghdr msg;
 	struct iovec iov;
-	unsigned long flags;
-	sigset_t oldset;
 
 	oldfs = get_fs();
 	set_fs(get_ds());
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
-	oldset = current->blocked;
-	sigfillset(&current->blocked);
-	recalc_sigpending(current);
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
-
-
 	do {
 		sock->sk->allocation = GFP_BUFFER;
 		iov.iov_base = buf;
@@ -124,35 +117,54 @@
 		if (send)
 			result = sock_sendmsg(sock, &msg, size);
 		else
-			result = sock_recvmsg(sock, &msg, size, 0);
+			result = sock_recvmsg(sock, &msg, size, msg.msg_flags);
 
-		if (result <= 0) {
-#ifdef PARANOIA
-			printk(KERN_ERR "NBD: %s - sock=%ld at buf=%ld, size=%d returned %d.\n",
-			       send ? "send" : "receive", (long) sock, (long) buf, size, result);
-#endif
+		if (result <= 0) 
 			break;
-		}
+
 		size -= result;
 		buf += result;
 	} while (size > 0);
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
-	current->blocked = oldset;
-	recalc_sigpending(current);
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
-
 	set_fs(oldfs);
 	return result;
 }
 
-#define FAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); goto error_out; }
+/*
+ * Send data (without copying if possible)
+ */
+static int nbd_zc_xmit(struct socket *sock, struct buffer_head *bh, int msg_flags)
+{
+	struct page *page = bh->b_page;
+	size_t size = bh->b_size;
+	int offset;
+	int result;
+
+	msg_flags |= MSG_NOSIGNAL;
+
+	if (PageHighMem(page))
+		offset = (int)bh->b_data;
+	else
+		offset = (int)bh->b_data - (int)page_address(page);
+
+	do {
+		result = sock->ops->sendpage(sock, page, offset, size, msg_flags);
+		if (result <= 0)
+			break;
+		size -= result;
+		offset += result;
+	} while(size > 0);
+
+	return result;
+}
 
 void nbd_send_req(struct socket *sock, struct request *req)
 {
 	int result;
 	struct nbd_request request;
 	unsigned long size = req->nr_sectors << 9;
+	sigset_t oldset;
+	unsigned long flags;
 
 	DEBUG("NBD: sending control, ");
 	request.magic = htonl(NBD_REQUEST_MAGIC);
@@ -161,66 +173,98 @@
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	oldset = current->blocked;
+	sigfillset(&current->blocked);
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), req->cmd == WRITE ? MSG_MORE : 0);
 	if (result <= 0)
-		FAIL("Sendmsg failed for control.");
+		goto out;
 
+	result = 1;
 	if (req->cmd == WRITE) {
 		struct buffer_head *bh = req->bh;
 		DEBUG("data, ");
 		do {
-			result = nbd_xmit(1, sock, bh->b_data, bh->b_size, bh->b_reqnext == NULL ? 0 : MSG_MORE);
+			int flags = bh->b_reqnext ? MSG_MORE : 0;
+			result = nbd_zc_xmit(sock, bh, flags);
 			if (result <= 0)
-				FAIL("Send data failed.");
+				goto out;
 			bh = bh->b_reqnext;
 		} while(bh);
 	}
-	return;
+out:
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	current->blocked = oldset;
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+
+	/* REMOVEME: Not needed when failover is supported */
+	if (result <= 0)
+		req->errors++;
 
-      error_out:
-	req->errors++;
+	return;
 }
 
-#define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
 struct request *nbd_read_stat(struct nbd_device *lo)
-		/* NULL returned = something went wrong, inform userspace       */ 
 {
 	int result;
 	struct nbd_reply reply;
-	struct request *xreq, *req;
+	struct request *xreq, *req = NULL;
+	sigset_t oldset;
+	unsigned long flags;
+
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	oldset = current->blocked;
+	sigfillset(&current->blocked);
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
 	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0)
-		HARDFAIL("Recv control failed.");
+		goto out;
+
 	memcpy(&xreq, reply.handle, sizeof(xreq));
 	req = blkdev_entry_prev_request(&lo->queue_head);
 
+	result = -ESRCH;
 	if (xreq != req)
-		FAIL("Unexpected handle received.\n");
+		goto out;
 
 	DEBUG("ok, ");
+	result = -EINVAL;
 	if (ntohl(reply.magic) != NBD_REPLY_MAGIC)
-		HARDFAIL("Not enough magic.");
-	if (ntohl(reply.error))
-		FAIL("Other side returned error.");
+		goto out;
+	result = ntohl(reply.error);
+	if (result < 0)
+		goto out;
+
+	result = 1;
 	if (req->cmd == READ) {
 		struct buffer_head *bh = req->bh;
 		DEBUG("data, ");
 		do {
 			result = nbd_xmit(0, lo->sock, bh->b_data, bh->b_size, MSG_WAITALL);
 			if (result <= 0)
-				HARDFAIL("Recv data failed.");
+				goto out;
 			bh = bh->b_reqnext;
 		} while(bh);
 	}
 	DEBUG("done.\n");
-	return req;
+out:
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	current->blocked = oldset;
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+
+	/* REMOVEME: Not needed when failover is supported */
+	if (result <= 0 && req)
+		req->errors++;
 
-/* Can we get here? Yes, if other side returns error */
-      error_out:
-	req->errors++;
 	return req;
 }
 
