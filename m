Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUF1IIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUF1IIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUF1IIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:08:34 -0400
Received: from holomorphy.com ([207.189.100.168]:7584 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264886AbUF1IIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:08:04 -0400
Date: Mon, 28 Jun 2004 01:08:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       davem@redhat.com
Subject: kiocb->private is too large for kiocb's on-stack
Message-ID: <20040628080801.GO21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@oss.sgi.com, akpm@osdl.org, davem@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(struct kiocb) is dangerously large for a structure commonly
allocated on-stack. This patch converts the 24*sizeof(long) field,
->private, to a void pointer for use by file_operations entrypoints.
A ->dtor() method is added to the kiocb in order to support the release
of dynamically allocated structures referred to by ->private.

The sole in-tree users of ->private are async network read/write,
which are not, in fact, async, and so need not handle preallocated
->private as they would need to if ->ki_retry were ever used. The sole
truly async operations are direct IO pread()/pwrite() which do not
now use ->ki_retry(). All they would need to do in that case is to
check for ->private already being allocated for async kiocbs.

This rips 88B off the stack on 32-bit in the common case.

vs. 2.6.7-mm3

Index: mm3-2.6.7/include/net/sock.h
===================================================================
--- mm3-2.6.7.orig/include/net/sock.h	2004-06-27 15:44:42.365168400 -0700
+++ mm3-2.6.7/include/net/sock.h	2004-06-27 15:50:40.651700568 -0700
@@ -617,17 +617,17 @@
 	struct scm_cookie	*scm;
 	struct msghdr		*msg, async_msg;
 	struct iovec		async_iov;
+	struct kiocb		*kiocb;
 };
 
 static inline struct sock_iocb *kiocb_to_siocb(struct kiocb *iocb)
 {
-	BUG_ON(sizeof(struct sock_iocb) > KIOCB_PRIVATE_SIZE);
 	return (struct sock_iocb *)iocb->private;
 }
 
 static inline struct kiocb *siocb_to_kiocb(struct sock_iocb *si)
 {
-	return container_of((void *)si, struct kiocb, private);
+	return si->kiocb;
 }
 
 struct socket_alloc {
Index: mm3-2.6.7/include/linux/aio.h
===================================================================
--- mm3-2.6.7.orig/include/linux/aio.h	2004-06-15 22:18:54.000000000 -0700
+++ mm3-2.6.7/include/linux/aio.h	2004-06-27 15:50:40.654700112 -0700
@@ -23,8 +23,6 @@
 
 #define KIOCB_SYNC_KEY		(~0U)
 
-#define KIOCB_PRIVATE_SIZE	(24 * sizeof(long))
-
 /* ki_flags bits */
 #define KIF_LOCKED		0
 #define KIF_KICKED		1
@@ -55,6 +53,7 @@
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
 	long			(*ki_retry)(struct kiocb *);
+	void			(*ki_dtor)(struct kiocb *);
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -65,8 +64,7 @@
 	} ki_obj;
 	__u64			ki_user_data;	/* user's data for completion */
 	loff_t			ki_pos;
-
-	char			private[KIOCB_PRIVATE_SIZE];
+	void			*private;
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
@@ -79,6 +77,7 @@
 		(x)->ki_filp = (filp);			\
 		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
 		(x)->ki_cancel = NULL;			\
+		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
 	} while (0)
 
Index: mm3-2.6.7/net/socket.c
===================================================================
--- mm3-2.6.7.orig/net/socket.c	2004-06-15 22:19:13.000000000 -0700
+++ mm3-2.6.7/net/socket.c	2004-06-27 15:50:40.662698896 -0700
@@ -548,9 +548,11 @@
 int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct kiocb iocb;
+	struct sock_iocb siocb;
 	int ret;
 
 	init_sync_kiocb(&iocb, NULL);
+	iocb.private = &siocb;
 	ret = __sock_sendmsg(&iocb, sock, msg, size);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&iocb);
@@ -581,15 +583,22 @@
 		 size_t size, int flags)
 {
 	struct kiocb iocb;
+	struct sock_iocb siocb;
 	int ret;
 
         init_sync_kiocb(&iocb, NULL);
+	iocb.private = &siocb;
 	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&iocb);
 	return ret;
 }
 
+static void sock_aio_dtor(struct kiocb *iocb)
+{
+	kfree(iocb->private);
+}
+
 /*
  *	Read data from a socket. ubuf is a user mode pointer. We make sure the user
  *	area ubuf...ubuf+size-1 is writable before asking the protocol.
@@ -598,7 +607,7 @@
 static ssize_t sock_aio_read(struct kiocb *iocb, char __user *ubuf,
 			 size_t size, loff_t pos)
 {
-	struct sock_iocb *x = kiocb_to_siocb(iocb);
+	struct sock_iocb *x, siocb;
 	struct socket *sock;
 	int flags;
 
@@ -607,6 +616,16 @@
 	if (size==0)		/* Match SYS5 behaviour */
 		return 0;
 
+	if (is_sync_kiocb(iocb))
+		x = &siocb;
+	else {
+		x = kmalloc(sizeof(struct sock_iocb), GFP_KERNEL);
+		if (!x)
+			return -ENOMEM;
+		iocb->ki_dtor = sock_aio_dtor;
+	}
+	iocb->private = x;
+	x->kiocb = iocb;
 	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
@@ -631,7 +650,7 @@
 static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *ubuf,
 			  size_t size, loff_t pos)
 {
-	struct sock_iocb *x = kiocb_to_siocb(iocb);
+	struct sock_iocb *x, siocb;
 	struct socket *sock;
 	
 	if (pos != 0)
@@ -639,6 +658,16 @@
 	if(size==0)		/* Match SYS5 behaviour */
 		return 0;
 
+	if (is_sync_kiocb(iocb))
+		x = &siocb;
+	else {
+		x = kmalloc(sizeof(struct sock_iocb), GFP_KERNEL);
+		if (!x)
+			return -ENOMEM;
+		iocb->ki_dtor = sock_aio_dtor;
+	}
+	iocb->private = x;
+	x->kiocb = iocb;
 	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
Index: mm3-2.6.7/fs/aio.c
===================================================================
--- mm3-2.6.7.orig/fs/aio.c	2004-06-27 15:44:54.278357320 -0700
+++ mm3-2.6.7/fs/aio.c	2004-06-27 15:50:40.667698136 -0700
@@ -396,6 +396,8 @@
 	req->ki_cancel = NULL;
 	req->ki_retry = NULL;
 	req->ki_obj.user = NULL;
+	req->ki_dtor = NULL;
+	req->private = NULL;
 
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
@@ -436,9 +438,13 @@
 
 static inline void really_put_req(struct kioctx *ctx, struct kiocb *req)
 {
+	if (req->ki_dtor)
+		req->ki_dtor(req);
 	req->ki_ctx = NULL;
 	req->ki_filp = NULL;
 	req->ki_obj.user = NULL;
+	req->ki_dtor = NULL;
+	req->private = NULL;
 	kmem_cache_free(kiocb_cachep, req);
 	ctx->reqs_active--;
 
