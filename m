Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWCCE7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWCCE7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWCCE7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:59:50 -0500
Received: from hera.kernel.org ([140.211.167.34]:21646 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750842AbWCCE7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:59:49 -0500
Date: Thu, 2 Mar 2006 22:30:48 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603022230.k22MUmm4017480@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: consolidate trans_sock into trans_fd
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: consolidate trans_sock into trans_fd

From: Russ Cox <rsc@swtch.com>

here is a new trans_fd.c that replaces the current
trans_fd.c and trans_sock.c.  i haven't tested it but
the changes are pretty trivial.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/Makefile     |    1 
 fs/9p/trans_fd.c   |  295 ++++++++++++++++++++++++++++++----------------
 fs/9p/trans_sock.c |  334 ----------------------------------------------------
 3 files changed, 195 insertions(+), 435 deletions(-)
 delete mode 100644 fs/9p/trans_sock.c

030b86bd48d0575a0f52ca558b3fabe66882c80a
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index 2f4ce43..5db5af9 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -2,7 +2,6 @@ obj-$(CONFIG_9P_FS) := 9p2000.o
 
 9p2000-objs := \
 	trans_fd.o \
-	trans_sock.o \
 	mux.o \
 	9p.o \
 	conv.o \
diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
index 1a28ef9..9fd0f51 100644
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -1,10 +1,13 @@
 /*
  * linux/fs/9p/trans_fd.c
  *
- * File Descriptor Transport Layer
+ * Fd transport layer.  Includes deprecated socket layer.
  *
- *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
- *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2006 by Russ Cox <rsc@swtch.com>
+ *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
+ *  Copyright (C) 2004-2005 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
+ *  Copyright (C) 1995, 1996 by Olaf Kirch <okir@monad.swb.de>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -25,6 +28,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/in.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/ipv6.h>
@@ -40,88 +44,118 @@
 #include "v9fs.h"
 #include "transport.h"
 
+#define V9FS_PORT 564
+
 struct v9fs_trans_fd {
-	struct file *in_file;
-	struct file *out_file;
+	struct file *rd;
+	struct file *wr;
 };
 
 /**
- * v9fs_fd_recv - receive from a socket
+ * v9fs_fd_read- read from a fd
  * @v9ses: session information
  * @v: buffer to receive data into
  * @len: size of receive buffer
  *
  */
-
-static int v9fs_fd_recv(struct v9fs_transport *trans, void *v, int len)
+static int v9fs_fd_read(struct v9fs_transport *trans, void *v, int len)
 {
-	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
+	int ret;
+	struct v9fs_trans_fd *ts;
 
-	if (!trans || trans->status != Connected || !ts)
-		return -EIO;
+	if (!trans || trans->status == Disconnected || !(ts = trans->priv))
+		return -EREMOTEIO;
 
-	return kernel_read(ts->in_file, ts->in_file->f_pos, v, len);
+	if (!(ts->rd->f_flags & O_NONBLOCK))
+		dprintk(DEBUG_ERROR, "blocking read ...\n");
+
+	ret = kernel_read(ts->rd, ts->rd->f_pos, v, len);
+	if (ret <= 0 && ret != -ERESTARTSYS && ret != -EAGAIN)
+		trans->status = Disconnected;
+	return ret;
 }
 
 /**
- * v9fs_fd_send - send to a socket
+ * v9fs_fd_write - write to a socket
  * @v9ses: session information
  * @v: buffer to send data from
  * @len: size of send buffer
  *
  */
-
-static int v9fs_fd_send(struct v9fs_transport *trans, void *v, int len)
+static int v9fs_fd_write(struct v9fs_transport *trans, void *v, int len)
 {
-	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
-	mm_segment_t oldfs = get_fs();
-	int ret = 0;
+	int ret;
+	mm_segment_t oldfs;
+	struct v9fs_trans_fd *ts;
 
-	if (!trans || trans->status != Connected || !ts)
-		return -EIO;
+	if (!trans || trans->status == Disconnected || !(ts = trans->priv))
+		return -EREMOTEIO;
+
+	if (!(ts->wr->f_flags & O_NONBLOCK))
+		dprintk(DEBUG_ERROR, "blocking write ...\n");
 
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
-	ret = vfs_write(ts->out_file, (void __user *)v, len, &ts->out_file->f_pos);
+	ret = vfs_write(ts->wr, (void __user *)v, len, &ts->wr->f_pos);
 	set_fs(oldfs);
 
+	if (ret <= 0 && ret != -ERESTARTSYS && ret != -EAGAIN)
+		trans->status = Disconnected;
 	return ret;
 }
 
-/**
- * v9fs_fd_init - initialize file descriptor transport
- * @v9ses: session information
- * @addr: address of server to mount
- * @data: mount options
- *
- */
-
-static int
-v9fs_fd_init(struct v9fs_session_info *v9ses, const char *addr, char *data)
+static unsigned int
+v9fs_fd_poll(struct v9fs_transport *trans, struct poll_table_struct *pt)
 {
-	struct v9fs_trans_fd *ts = NULL;
-	struct v9fs_transport *trans = v9ses->transport;
+	int ret, n;
+	struct v9fs_trans_fd *ts;
+	mm_segment_t oldfs;
 
-	if((v9ses->wfdno == ~0) || (v9ses->rfdno == ~0)) {
-		printk(KERN_ERR "v9fs: Insufficient options for proto=fd\n");
-		return -ENOPROTOOPT;
-	}
+	if (!trans || trans->status != Connected || !(ts = trans->priv))
+		return -EREMOTEIO;
 
-	ts = kmalloc(sizeof(struct v9fs_trans_fd), GFP_KERNEL);
+	if (!ts->rd->f_op || !ts->rd->f_op->poll)
+		return -EIO;
 
-	if (!ts)
-		return -ENOMEM;
+	if (!ts->wr->f_op || !ts->wr->f_op->poll)
+		return -EIO;
+
+	oldfs = get_fs();
+	set_fs(get_ds());
+
+	ret = ts->rd->f_op->poll(ts->rd, pt);
+	if (ret < 0)
+		goto end;
 
-	ts->in_file = fget( v9ses->rfdno );
-	ts->out_file = fget( v9ses->wfdno );
+	if (ts->rd != ts->wr) {
+		n = ts->wr->f_op->poll(ts->wr, pt);
+		if (n < 0) {
+			ret = n;
+			goto end;
+		}
+		ret = (ret & ~POLLOUT) | (n & ~POLLIN);
+	}
 
-	if (!ts->in_file || !ts->out_file) {
-		if (ts->in_file)
-			fput(ts->in_file);
+      end:
+	set_fs(oldfs);
+	return ret;
+}
 
-		if (ts->out_file)
-			fput(ts->out_file);
+static int v9fs_fd_open(struct v9fs_session_info *v9ses, int rfd, int wfd)
+{
+	struct v9fs_transport *trans = v9ses->transport;
+	struct v9fs_trans_fd *ts = kmalloc(sizeof(struct v9fs_trans_fd),
+					   GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
 
+	ts->rd = fget(rfd);
+	ts->wr = fget(wfd);
+	if (!ts->rd || !ts->wr) {
+		if (ts->rd)
+			fput(ts->rd);
+		if (ts->wr)
+			fput(ts->wr);
 		kfree(ts);
 		return -EIO;
 	}
@@ -132,84 +166,145 @@ v9fs_fd_init(struct v9fs_session_info *v
 	return 0;
 }
 
-
-/**
- * v9fs_fd_close - shutdown file descriptor
- * @trans: private socket structure
- *
- */
-
-static void v9fs_fd_close(struct v9fs_transport *trans)
+static int v9fs_fd_init(struct v9fs_session_info *v9ses, const char *addr,
+			char *data)
 {
-	struct v9fs_trans_fd *ts;
-
-	if (!trans)
-		return;
+	if (v9ses->rfdno == ~0 || v9ses->wfdno == ~0) {
+		printk(KERN_ERR "v9fs: Insufficient options for proto=fd\n");
+		return -ENOPROTOOPT;
+	}
 
-	ts = xchg(&trans->priv, NULL);
+	return v9fs_fd_open(v9ses, v9ses->rfdno, v9ses->wfdno);
+}
 
-	if (!ts)
-		return;
+static int v9fs_socket_open(struct v9fs_session_info *v9ses,
+			    struct socket *csocket)
+{
+	int fd, ret;
 
-	trans->status = Disconnected;
-	if (ts->in_file)
-		fput(ts->in_file);
+	csocket->sk->sk_allocation = GFP_NOIO;
+	if ((fd = sock_map_fd(csocket)) < 0) {
+		eprintk(KERN_ERR, "v9fs_socket_open: failed to map fd\n");
+		ret = fd;
+	      release_csocket:
+		sock_release(csocket);
+		return ret;
+	}
 
-	if (ts->out_file)
-		fput(ts->out_file);
+	if ((ret = v9fs_fd_open(v9ses, fd, fd)) < 0) {
+		sockfd_put(csocket);
+		eprintk(KERN_ERR, "v9fs_socket_open: failed to open fd\n");
+		goto release_csocket;
+	}
 
-	kfree(ts);
+	((struct v9fs_trans_fd *)v9ses->transport->priv)->rd->f_flags |=
+	    O_NONBLOCK;
+	return 0;
 }
 
-static unsigned int
-v9fs_fd_poll(struct v9fs_transport *trans, struct poll_table_struct *pt)
+static int v9fs_tcp_init(struct v9fs_session_info *v9ses, const char *addr,
+			 char *data)
 {
-	int ret, n;
-	struct v9fs_trans_fd *ts;
-	mm_segment_t oldfs;
+	int ret;
+	struct socket *csocket = NULL;
+	struct sockaddr_in sin_server;
+
+	sin_server.sin_family = AF_INET;
+	sin_server.sin_addr.s_addr = in_aton(addr);
+	sin_server.sin_port = htons(v9ses->port);
+	sock_create_kern(PF_INET, SOCK_STREAM, IPPROTO_TCP, &csocket);
+
+	if (!csocket) {
+		eprintk(KERN_ERR, "v9fs_trans_tcp: problem creating socket\n");
+		return -1;
+	}
 
-	if (!trans)
-		return -EIO;
+	ret = csocket->ops->connect(csocket,
+				    (struct sockaddr *)&sin_server,
+				    sizeof(struct sockaddr_in), 0);
+	if (ret < 0) {
+		eprintk(KERN_ERR,
+			"v9fs_trans_tcp: problem connecting socket to %s\n",
+			addr);
+		return ret;
+	}
 
-	ts = trans->priv;
-	if (trans->status != Connected || !ts)
-		return -EIO;
+	return v9fs_socket_open(v9ses, csocket);
+}
 
-	oldfs = get_fs();
-	set_fs(get_ds());
+static int
+v9fs_unix_init(struct v9fs_session_info *v9ses, const char *addr, char *data)
+{
+	int ret;
+	struct socket *csocket;
+	struct sockaddr_un sun_server;
+
+	if (strlen(addr) > UNIX_PATH_MAX) {
+		eprintk(KERN_ERR, "v9fs_trans_unix: address too long: %s\n",
+			addr);
+		return -ENAMETOOLONG;
+	}
 
-	if (!ts->in_file->f_op || !ts->in_file->f_op->poll) {
-		ret = -EIO;
-		goto end;
+	sun_server.sun_family = PF_UNIX;
+	strcpy(sun_server.sun_path, addr);
+	sock_create_kern(PF_UNIX, SOCK_STREAM, 0, &csocket);
+	ret = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server, 
+			sizeof(struct sockaddr_un) - 1, 0);	
+	if (ret < 0) {
+		eprintk(KERN_ERR,
+			"v9fs_trans_unix: problem connecting socket: %s: %d\n",
+			addr, ret);
+		return ret;
 	}
 
-	ret = ts->in_file->f_op->poll(ts->in_file, pt);
+	return v9fs_socket_open(v9ses, csocket);
+}
 
-	if (ts->out_file != ts->in_file) {
-		if (!ts->out_file->f_op || !ts->out_file->f_op->poll) {
-			ret = -EIO;
-			goto end;
-		}
+/**
+ * v9fs_sock_close - shutdown socket
+ * @trans: private socket structure
+ *
+ */
+static void v9fs_fd_close(struct v9fs_transport *trans)
+{
+	struct v9fs_trans_fd *ts;
 
-		n = ts->out_file->f_op->poll(ts->out_file, pt);
+	if (!trans)
+		return;
 
-		ret &= ~POLLOUT;
-		n &= ~POLLIN;
+	ts = xchg(&trans->priv, NULL);	
 
-		ret |= n;
-	}
+	if (!ts)
+		return;
 
-end:
-	set_fs(oldfs);
-	return ret;
+	trans->status = Disconnected;
+	if (ts->rd)
+		fput(ts->rd);
+	if (ts->wr)
+		fput(ts->wr);
+	kfree(ts);
 }
 
-
 struct v9fs_transport v9fs_trans_fd = {
 	.init = v9fs_fd_init,
-	.write = v9fs_fd_send,
-	.read = v9fs_fd_recv,
+	.write = v9fs_fd_write,
+	.read = v9fs_fd_read,
 	.close = v9fs_fd_close,
 	.poll = v9fs_fd_poll,
 };
 
+struct v9fs_transport v9fs_trans_tcp = {
+	.init = v9fs_tcp_init,
+	.write = v9fs_fd_write,
+	.read = v9fs_fd_read,
+	.close = v9fs_fd_close,
+	.poll = v9fs_fd_poll,
+};
+
+struct v9fs_transport v9fs_trans_unix = {
+	.init = v9fs_unix_init,
+	.write = v9fs_fd_write,
+	.read = v9fs_fd_read,
+	.close = v9fs_fd_close,
+	.poll = v9fs_fd_poll,
+};
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
deleted file mode 100644
index 44e8306..0000000
--- a/fs/9p/trans_sock.c
+++ /dev/null
@@ -1,334 +0,0 @@
-/*
- * linux/fs/9p/trans_socket.c
- *
- * Socket Transport Layer
- *
- *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
- *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
- *  Copyright (C) 1995, 1996 by Olaf Kirch <okir@monad.swb.de>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to:
- *  Free Software Foundation
- *  51 Franklin Street, Fifth Floor
- *  Boston, MA  02111-1301  USA
- *
- */
-
-#include <linux/config.h>
-#include <linux/in.h>
-#include <linux/module.h>
-#include <linux/net.h>
-#include <linux/ipv6.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/un.h>
-#include <asm/uaccess.h>
-#include <linux/inet.h>
-#include <linux/idr.h>
-#include <linux/file.h>
-
-#include "debug.h"
-#include "v9fs.h"
-#include "transport.h"
-
-#define V9FS_PORT 564
-
-struct v9fs_trans_sock {
-	struct socket *s;
-	struct file *filp;
-};
-
-/**
- * v9fs_sock_recv - receive from a socket
- * @v9ses: session information
- * @v: buffer to receive data into
- * @len: size of receive buffer
- *
- */
-
-static int v9fs_sock_recv(struct v9fs_transport *trans, void *v, int len)
-{
-	int ret;
-	struct v9fs_trans_sock *ts;
-
-	if (!trans || trans->status == Disconnected) {
-		dprintk(DEBUG_ERROR, "disconnected ...\n");
-		return -EREMOTEIO;
-	}
-
-	ts = trans->priv;
-
-	if (!(ts->filp->f_flags & O_NONBLOCK))
-		dprintk(DEBUG_ERROR, "blocking read ...\n");
-
-	ret = kernel_read(ts->filp, ts->filp->f_pos, v, len);
-	if (ret <= 0) {
-		if (ret != -ERESTARTSYS && ret != -EAGAIN)
-			trans->status = Disconnected;
-	}
-
-	return ret;
-}
-
-/**
- * v9fs_sock_send - send to a socket
- * @v9ses: session information
- * @v: buffer to send data from
- * @len: size of send buffer
- *
- */
-
-static int v9fs_sock_send(struct v9fs_transport *trans, void *v, int len)
-{
-	int ret;
-	mm_segment_t oldfs;
-	struct v9fs_trans_sock *ts;
-
-	if (!trans || trans->status == Disconnected) {
-		dprintk(DEBUG_ERROR, "disconnected ...\n");
-		return -EREMOTEIO;
-	}
-
-	ts = trans->priv;
-	if (!ts) {
-		dprintk(DEBUG_ERROR, "no transport ...\n");
-		return -EREMOTEIO;
-	}
-
-	if (!(ts->filp->f_flags & O_NONBLOCK))
-		dprintk(DEBUG_ERROR, "blocking write ...\n");
-
-	oldfs = get_fs();
-	set_fs(get_ds());
-	ret = vfs_write(ts->filp, (void __user *)v, len, &ts->filp->f_pos);
-	set_fs(oldfs);
-
-	if (ret < 0) {
-		if (ret != -ERESTARTSYS)
-			trans->status = Disconnected;
-	}
-
-	return ret;
-}
-
-static unsigned int v9fs_sock_poll(struct v9fs_transport *trans,
-	struct poll_table_struct *pt) {
-
-	int ret;
-	struct v9fs_trans_sock *ts;
-	mm_segment_t oldfs;
-
-	if (!trans) {
-		dprintk(DEBUG_ERROR, "no transport\n");
-		return -EIO;
-	}
-
-	ts = trans->priv;
-	if (trans->status != Connected || !ts) {
-		dprintk(DEBUG_ERROR, "transport disconnected: %d\n", trans->status);
-		return -EIO;
-	}
-
-	oldfs = get_fs();
-	set_fs(get_ds());
-
-	if (!ts->filp->f_op || !ts->filp->f_op->poll) {
-		dprintk(DEBUG_ERROR, "no poll operation\n");
-		ret = -EIO;
-		goto end;
-	}
-
-	ret = ts->filp->f_op->poll(ts->filp, pt);
-
-end:
-	set_fs(oldfs);
-	return ret;
-}
-
-
-/**
- * v9fs_tcp_init - initialize TCP socket
- * @v9ses: session information
- * @addr: address of server to mount
- * @data: mount options
- *
- */
-
-static int
-v9fs_tcp_init(struct v9fs_session_info *v9ses, const char *addr, char *data)
-{
-	struct socket *csocket = NULL;
-	struct sockaddr_in sin_server;
-	int rc = 0;
-	struct v9fs_trans_sock *ts = NULL;
-	struct v9fs_transport *trans = v9ses->transport;
-	int fd;
-
-	trans->status = Disconnected;
-
-	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
-
-	if (!ts)
-		return -ENOMEM;
-
-	trans->priv = ts;
-	ts->s = NULL;
-	ts->filp = NULL;
-
-	if (!addr)
-		return -EINVAL;
-
-	dprintk(DEBUG_TRANS, "Connecting to %s\n", addr);
-
-	sin_server.sin_family = AF_INET;
-	sin_server.sin_addr.s_addr = in_aton(addr);
-	sin_server.sin_port = htons(v9ses->port);
-	sock_create_kern(PF_INET, SOCK_STREAM, IPPROTO_TCP, &csocket);
-	rc = csocket->ops->connect(csocket,
-				   (struct sockaddr *)&sin_server,
-				   sizeof(struct sockaddr_in), 0);
-	if (rc < 0) {
-		eprintk(KERN_ERR,
-			"v9fs_trans_tcp: problem connecting socket to %s\n",
-			addr);
-		return rc;
-	}
-	csocket->sk->sk_allocation = GFP_NOIO;
-
-	fd = sock_map_fd(csocket);
-	if (fd < 0) {
-		sock_release(csocket);
-		kfree(ts);
-		trans->priv = NULL;
-		return fd;
-	}
-
-	ts->s = csocket;
-	ts->filp = fget(fd);
-	ts->filp->f_flags |= O_NONBLOCK;
-	trans->status = Connected;
-
-	return 0;
-}
-
-/**
- * v9fs_unix_init - initialize UNIX domain socket
- * @v9ses: session information
- * @dev_name: path to named pipe
- * @data: mount options
- *
- */
-
-static int
-v9fs_unix_init(struct v9fs_session_info *v9ses, const char *dev_name,
-	       char *data)
-{
-	int rc, fd;
-	struct socket *csocket;
-	struct sockaddr_un sun_server;
-	struct v9fs_transport *trans;
-	struct v9fs_trans_sock *ts;
-
-	rc = 0;
-	csocket = NULL;
-	trans = v9ses->transport;
-
-	trans->status = Disconnected;
-
-	if (strlen(dev_name) > UNIX_PATH_MAX) {
-		eprintk(KERN_ERR, "v9fs_trans_unix: address too long: %s\n",
-			dev_name);
-		return -ENOMEM;
-	}
-
-	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
-
-	trans->priv = ts;
-	ts->s = NULL;
-	ts->filp = NULL;
-
-	sun_server.sun_family = PF_UNIX;
-	strcpy(sun_server.sun_path, dev_name);
-	sock_create_kern(PF_UNIX, SOCK_STREAM, 0, &csocket);
-	rc = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server,
-		sizeof(struct sockaddr_un) - 1, 0);	/* -1 *is* important */
-	if (rc < 0) {
-		eprintk(KERN_ERR,
-			"v9fs_trans_unix: problem connecting socket: %s: %d\n",
-			dev_name, rc);
-		return rc;
-	}
-	csocket->sk->sk_allocation = GFP_NOIO;
-
-	fd = sock_map_fd(csocket);
-	if (fd < 0) {
-		sock_release(csocket);
-		kfree(ts);
-		trans->priv = NULL;
-		return fd;
-	}
-
-	ts->s = csocket;
-	ts->filp = fget(fd);
-	ts->filp->f_flags |= O_NONBLOCK;
-	trans->status = Connected;
-
-	return 0;
-}
-
-/**
- * v9fs_sock_close - shutdown socket
- * @trans: private socket structure
- *
- */
-
-static void v9fs_sock_close(struct v9fs_transport *trans)
-{
-	struct v9fs_trans_sock *ts;
-
-	if (!trans)
-		return;
-
-	ts = trans->priv;
-
-	if ((ts) && (ts->filp)) {
-		fput(ts->filp);
-		ts->filp = NULL;
-		ts->s = NULL;
-		trans->status = Disconnected;
-	}
-
-	kfree(ts);
-
-	trans->priv = NULL;
-}
-
-struct v9fs_transport v9fs_trans_tcp = {
-	.init = v9fs_tcp_init,
-	.write = v9fs_sock_send,
-	.read = v9fs_sock_recv,
-	.close = v9fs_sock_close,
-	.poll = v9fs_sock_poll,
-};
-
-struct v9fs_transport v9fs_trans_unix = {
-	.init = v9fs_unix_init,
-	.write = v9fs_sock_send,
-	.read = v9fs_sock_recv,
-	.close = v9fs_sock_close,
-	.poll = v9fs_sock_poll,
-};
-- 
1.0.GIT
