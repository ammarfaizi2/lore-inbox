Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVFGPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVFGPAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVFGPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:00:47 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:15258 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261896AbVFGOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:51:09 -0400
Message-Id: <200506071450.j57Eo5e1010741@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue,  7 Jun 2005 09:49:43 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] v9fs: transport modules (2.0)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [6/7] of the v9fs-2.0 patch against Linux 2.6.

This part of the patch contains transport routines.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 mux.c        |  452 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mux.h        |   37 ++++
 trans_sock.c |  272 +++++++++++++++++++++++++++++++++++
 transport.h  |   43 +++++
 4 files changed, 804 insertions(+)

 ----------

--- /dev/null
+++ b/fs/9p/mux.h
@@ -0,0 +1,37 @@
+/*
+ * linux/fs/9p/mux.h
+ *
+ * Multiplexer Definitions
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/* structure to manage each RPC transaction */
+
+struct v9fs_rpcreq {
+	struct v9fs_fcall *tcall;
+	struct v9fs_fcall *rcall;
+
+	/* XXX - could we put scatter/gather buffers here? */
+
+	struct list_head next;
+};
+
+int v9fs_mux_init(struct v9fs_session_info *v9ses, const char *dev_name);
+long v9fs_mux_rpc(struct v9fs_session_info *v9ses,
+		  struct v9fs_fcall *tcall, struct v9fs_fcall **rcall);
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/mux.c
@@ -0,0 +1,452 @@
+/*
+ * linux/fs/9p/mux.c
+ *
+ * Protocol Multiplexer
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2004 by Latchesar Ionkov <lucho@ionkov.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kthread.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "transport.h"
+#include "conv.h"
+#include "mux.h"
+
+/**
+ * dprintcond - print condition of session info
+ * @v9ses: session info structure
+ * @req: RPC request structure 
+ *
+ */
+
+static inline int
+dprintcond(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+{
+	dprintk(DEBUG_MUX, "condition: %d, %p\n", v9ses->transport->status,
+		req->rcall);
+	return 0;
+}
+
+/**
+ * xread - force read of a certain number of bytes
+ * @v9ses: session info structure
+ * @ptr: pointer to buffer
+ * @sz: number of bytes to read
+ *
+ * Chuck Cranor CS-533 project1
+ */
+
+static int xread(struct v9fs_session_info *v9ses, void *ptr, unsigned long sz)
+{
+	int rd = 0;
+	int ret = 0;
+	while (rd < sz) {
+		ret = v9ses->transport->read(v9ses->transport, ptr, sz - rd);
+		if (ret <= 0) {
+			dprintk(DEBUG_ERROR, "xread errno %d\n", ret);
+			return ret;
+		}
+		rd += ret;
+		ptr += ret;
+	}
+	return (rd);
+}
+
+/**
+ * read_message - read a full 9P2000 fcall packet
+ * @v9ses: session info structure
+ * @rcall: fcall structure to read into
+ * @rcalllen: size of fcall buffer
+ *
+ */
+
+static int
+read_message(struct v9fs_session_info *v9ses,
+	     struct v9fs_fcall *rcall, int rcalllen)
+{
+	unsigned char buf[4];
+	void *data;
+	int size = 0;
+	int res = 0;
+
+	res = xread(v9ses, buf, sizeof(buf));
+	if (res < 0) {
+		dprintk(DEBUG_ERROR,
+			"Reading of count field failed returned: %d\n", res);
+		return res;
+	}
+
+	if (res < 4) {
+		dprintk(DEBUG_ERROR,
+			"Reading of count field failed returned: %d\n", res);
+		return -EIO;
+	}
+
+	size = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
+	dprintk(DEBUG_MUX, "got a packet count: %d\n", size);	
+
+	/* adjust for the four bytes of size */
+	size -= 4;
+
+	if (size > v9ses->maxdata) {
+		dprintk(DEBUG_ERROR, "packet too big: %d\n", size);
+		return -E2BIG;
+	}
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data) {
+		eprintk(KERN_WARNING, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	res = xread(v9ses, data, size);
+	if (res < size) {
+		dprintk(DEBUG_ERROR, "Reading of fcall failed returned: %d\n",
+			res);
+		kfree(data);
+		return res;
+	}
+
+	/* we now have an in-memory string that is the reply. 
+	 * deserialize it. There is very little to go wrong at this point
+	 * save for v9fs_alloc errors. 
+	 */
+	res = v9fs_deserialize_fcall(v9ses, size, data, v9ses->maxdata,
+				     rcall, rcalllen);
+
+	kfree(data);
+
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+
+/**
+ * v9fs_recv - receive an RPC response for a particular tag
+ * @v9ses: session info structure
+ * @req: RPC request structure
+ *
+ */
+
+static int v9fs_recv(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+{
+	int ret = 0;
+
+	dprintk(DEBUG_MUX, "waiting for response: %d\n", req->tcall->tag);
+	ret = wait_event_interruptible_timeout(v9ses->read_wait,
+		       ((v9ses->transport->status != Connected) || 
+			(req->rcall != 0) || dprintcond(v9ses, req)),
+		       msecs_to_jiffies(v9ses->timeout));
+
+	dprintk(DEBUG_MUX, "got it: rcall %p\n", req->rcall);
+	if (v9ses->transport->status == Disconnected)
+		return -ECONNRESET;
+
+	if (ret >= 0) {
+		spin_lock(&v9ses->muxlock);
+		list_del(&req->next);
+		spin_unlock(&v9ses->muxlock);
+	}
+	if (ret == 0) {		/* timeout */
+		dprintk(DEBUG_MUX, "Connection timeout after %u (%u)\n",
+			v9ses->timeout,
+			(unsigned int)msecs_to_jiffies(v9ses->timeout));
+		v9ses->session_hung = 1;
+		v9ses->transport->status = Hung;
+		return -ETIMEDOUT;
+	} else {
+		ret = 0;	/* reset return code */
+	}
+
+	return ret;
+}
+
+/**
+ * v9fs_send - send a 9P request
+ * @v9ses: session info structure
+ * @req: RPC request to send
+ *
+ */
+
+static int v9fs_send(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+{
+	int ret = -1;
+	void *data = NULL;
+	struct v9fs_fcall *tcall = req->tcall;
+
+	data = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	tcall->size = 0;	/* enforce size recalculation */
+	ret =
+	    v9fs_serialize_fcall(v9ses, tcall, data,
+				 v9ses->maxdata + V9FS_IOHDRSZ);
+	if (ret < 0) 
+		goto free_data;
+
+	spin_lock(&v9ses->muxlock);
+	list_add(&req->next, &v9ses->mux_fcalls);
+	spin_unlock(&v9ses->muxlock);
+
+	dprintk(DEBUG_MUX, "sending message: tag %d size %d\n", tcall->tag,
+		tcall->size);
+	ret = v9ses->transport->write(v9ses->transport, data, tcall->size);
+
+	if (ret != tcall->size) {
+		spin_lock(&v9ses->muxlock);
+		list_del(&req->next);
+		kfree(req->rcall);
+
+		spin_unlock(&v9ses->muxlock);
+		if (ret >= 0)
+			ret = -EREMOTEIO;
+	} else
+		ret = 0;
+
+      free_data:
+	kfree(data);
+	return ret;
+}
+
+/**
+ * v9fs_mux_rpc - send a request, receive a response
+ * @v9ses: session info structure
+ * @tcall: fcall to send
+ * @rcall: buffer to place response into
+ *
+ */
+
+long
+v9fs_mux_rpc(struct v9fs_session_info *v9ses, struct v9fs_fcall *tcall,
+	     struct v9fs_fcall **rcall)
+{
+	int tid = -1;
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_rpcreq req;
+	int ret = -1;
+
+	if (!v9ses)
+		return -EINVAL;
+
+	if (rcall)
+		*rcall = NULL;
+
+	if (tcall->id != TVERSION) {
+		tid = v9fs_get_idpool(&v9ses->tidpool);
+		if (tid < 0)
+			return -ENOMEM;
+	}
+
+	tcall->tag = tid;
+
+	req.tcall = tcall;
+	req.rcall = NULL;
+
+	ret = v9fs_send(v9ses, &req);
+
+	if (ret < 0) {
+		v9fs_put_idpool(tid, &v9ses->tidpool);
+		dprintk(DEBUG_MUX, "error %d\n", ret);
+		return ret;
+	}
+
+	ret = v9fs_recv(v9ses, &req);
+
+	fcall = req.rcall;
+
+	dprintk(DEBUG_MUX, "received: tag=%x, ret=%d\n", tcall->tag, ret);
+	if (ret == -ERESTARTSYS) {
+		if (v9ses->transport->status != Disconnected
+		    && tcall->id != TFLUSH) {
+			unsigned long flags;
+
+			dprintk(DEBUG_MUX, "flushing the tag: %d\n",
+				tcall->tag);
+			clear_thread_flag(TIF_SIGPENDING);
+			v9fs_t_flush(v9ses, tcall->tag);
+			spin_lock_irqsave(&current->sighand->siglock, flags);
+			recalc_sigpending();
+			spin_unlock_irqrestore(&current->sighand->siglock,
+					       flags);
+			dprintk(DEBUG_MUX, "flushing done\n");
+		}
+
+		goto release_req;
+	} else if (ret < 0)
+		goto release_req;
+
+	if (!fcall)
+		ret = -EIO;
+	else {
+		if (fcall->id == RERROR) {
+			ret = v9fs_errstr2errno(fcall->params.rerror.error);
+			if (ret == 0) {	/* string match failed */
+				if (fcall->params.rerror.errno)
+					ret = -(fcall->params.rerror.errno);
+				else
+					ret = -ESERVERFAULT;
+			}
+		} else if (fcall->id != tcall->id + 1) {
+			dprintk(DEBUG_ERROR,
+				"fcall mismatch: expected %d, got %d\n",
+				tcall->id + 1, fcall->id);
+			ret = -EIO;
+		}
+	}
+
+      release_req:
+	v9fs_put_idpool(tid, &v9ses->tidpool);
+	if (rcall)
+		*rcall = fcall;
+	else
+		kfree(fcall);
+
+	return ret;
+}
+
+/**
+ * v9fs_recvproc - kproc to handle demultiplexing responses
+ * @data: session info structure
+ *
+ */
+
+static int v9fs_recvproc(void *data)
+{
+	struct v9fs_session_info *v9ses = (struct v9fs_session_info *)data;
+	struct v9fs_fcall *rcall = NULL;
+	struct list_head *rptr;
+	struct list_head *rrptr;
+	struct v9fs_rpcreq *req = NULL;
+	int err = 0;
+
+	allow_signal(SIGKILL);
+	set_current_state(TASK_INTERRUPTIBLE);
+	complete(&v9ses->proccmpl);
+	while (!kthread_should_stop() && err >= 0) {
+		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
+		if(!rcall) {
+			eprintk(KERN_ERR, "no memory for buffers\n");
+			break;
+		}
+			
+		dprintk(DEBUG_MUX, "waiting for message\n");
+		err = read_message(v9ses, rcall, v9ses->maxdata + V9FS_IOHDRSZ);
+		if (err < 0) {
+			kfree(rcall);
+			break;
+		}
+
+		spin_lock(&v9ses->muxlock);
+		list_for_each_safe(rptr, rrptr, &v9ses->mux_fcalls) {
+			struct v9fs_rpcreq *rreq =
+			    list_entry(rptr, struct v9fs_rpcreq, next);
+
+			if (rreq->tcall->tag == rcall->tag) {
+				req = rreq;
+				req->rcall = rcall;
+				break;
+			}
+		}
+
+		if (req && (req->tcall->id == TFLUSH)) {
+			list_for_each_safe(rptr, rrptr, &v9ses->mux_fcalls) {
+				struct v9fs_rpcreq *treq =
+				    list_entry(rptr, struct v9fs_rpcreq, next);
+
+				if (treq->tcall->tag ==
+				    req->tcall->params.tflush.oldtag) {
+					list_del(rptr);
+					kfree(treq->rcall);
+					break;
+				}
+			}
+		}
+
+		spin_unlock(&v9ses->muxlock);
+
+		if (!req) {
+			dprintk(DEBUG_ERROR,
+				"unexpected response: id %d tag %d\n",
+				rcall->id, rcall->tag);
+
+			kfree(rcall);
+		}
+
+		wake_up_all(&v9ses->read_wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+
+	/* Inform all pending processes about the failure */
+	wake_up_all(&v9ses->read_wait);
+
+	if (signal_pending(current))
+		complete(&v9ses->proccmpl);
+
+	dprintk(DEBUG_MUX, "recvproc: end\n");
+	v9ses->recvproc = NULL;
+
+	return err >= 0;
+}
+
+/**
+ * v9fs_mux_init - initialize multiplexer (spawn kproc)
+ * @v9ses: session info structure
+ * @dev_name: mount device information (to create unique kproc)
+ * 
+ */
+
+int v9fs_mux_init(struct v9fs_session_info *v9ses, const char *dev_name)
+{
+	char procname[60];
+
+	strncpy(procname, dev_name, sizeof(procname));
+	procname[sizeof(procname) - 1] = 0;
+
+	init_waitqueue_head(&v9ses->read_wait);
+	init_completion(&v9ses->fcread);
+	init_completion(&v9ses->proccmpl);
+	spin_lock_init(&v9ses->muxlock);
+	INIT_LIST_HEAD(&v9ses->mux_fcalls);
+	v9ses->recvproc = NULL;
+	v9ses->curfcall = NULL;
+
+	v9ses->recvproc = kthread_create(v9fs_recvproc, v9ses,
+					 "v9fs_recvproc %s", procname);
+
+	if (IS_ERR(v9ses->recvproc)) {
+		eprintk(KERN_ERR, "cannot create receiving thread\n");
+		v9fs_session_close(v9ses);
+		return -ECONNABORTED;
+	}
+
+	wake_up_process(v9ses->recvproc);
+	wait_for_completion(&v9ses->proccmpl);
+
+	return 0;
+}
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
new file mode 100644
--- /dev/null
+++ b/fs/9p/transport.h
@@ -0,0 +1,43 @@
+/*
+ * linux/fs/9p/transport.h
+ *
+ * Transport Definition
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+enum v9fs_transport_status {
+	Connected,
+	Disconnected,
+	Hung,
+};
+
+struct v9fs_transport {
+	enum v9fs_transport_status status;
+	struct semaphore writelock;
+	struct semaphore readlock;
+	void *priv;
+
+	int (*init) (struct v9fs_session_info *, const char *, char *);
+	int (*write) (struct v9fs_transport *, void *, int);
+	int (*read) (struct v9fs_transport *, void *, int);
+	void (*close) (struct v9fs_transport *);
+};
+
+extern struct v9fs_transport v9fs_trans_tcp;
+extern struct v9fs_transport v9fs_trans_unix;
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/trans_sock.c
@@ -0,0 +1,272 @@
+/*
+ * linux/fs/9p/trans_socket.c
+ *
+ * Socket Transport Layer
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
+ *  Copyright (C) 1995, 1996 by Olaf Kirch <okir@monad.swb.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/ipv6.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/un.h>
+#include <asm/uaccess.h>
+#include <linux/inet.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "transport.h"
+
+#define V9FS_PORT 564
+
+struct v9fs_trans_sock {
+	struct socket *s;
+};
+
+/**
+ * v9fs_sock_recv - receive from a socket
+ * @v9ses: session information 
+ * @v: buffer to receive data into
+ * @len: size of receive buffer
+ *
+ */
+
+static int v9fs_sock_recv(struct v9fs_transport *trans, void *v, int len)
+{
+	struct msghdr msg;
+	struct kvec iov;
+	int result;
+	mm_segment_t oldfs;
+	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+
+	if (trans->status == Disconnected)
+		return -EREMOTEIO;
+
+	result = -EINVAL;
+
+	oldfs = get_fs();
+	set_fs(get_ds());
+
+	iov.iov_base = v;
+	iov.iov_len = len;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_iovlen = 1;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_namelen = 0;
+	msg.msg_flags = MSG_NOSIGNAL;
+
+	result = kernel_recvmsg(ts->s, &msg, &iov, 1, len, 0);
+
+	dprintk(DEBUG_TRANS, "socket state %d\n", ts->s->state);
+	set_fs(oldfs);
+
+	if (result <= 0) {
+		if (result != -ERESTARTSYS)
+			trans->status = Disconnected;
+	}
+
+	return result;
+}
+
+/**
+ * v9fs_sock_send - send to a socket
+ * @v9ses: session information 
+ * @v: buffer to send data from
+ * @len: size of send buffer
+ *
+ */
+
+static int v9fs_sock_send(struct v9fs_transport *trans, void *v, int len)
+{
+	struct kvec iov;
+	struct msghdr msg;
+	int result = -1;
+	mm_segment_t oldfs;
+	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+
+	dprintk(DEBUG_TRANS, "Sending packet size %d (%x)\n", len, len);
+	dump_data(v, len);
+
+	down(&trans->writelock);
+
+	oldfs = get_fs();
+	set_fs(get_ds());
+	iov.iov_base = v;
+	iov.iov_len = len;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_iovlen = 1;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_namelen = 0;
+	msg.msg_flags = MSG_NOSIGNAL;
+	result = kernel_sendmsg(ts->s, &msg, &iov, 1, len);
+	set_fs(oldfs);
+
+	if (result < 0) {
+		if (result != -ERESTARTSYS)
+			trans->status = Disconnected;
+	}
+
+	up(&trans->writelock);
+	return result;
+}
+
+/**
+ * v9fs_tcp_init - initialize TCP socket
+ * @v9ses: session information 
+ * @addr: address of server to mount
+ * @data: mount options
+ *
+ */
+
+static int
+v9fs_tcp_init(struct v9fs_session_info *v9ses, const char *addr, char *data)
+{
+	struct socket *csocket = NULL;
+	struct sockaddr_in sin_server;
+	int rc = 0;
+	struct v9fs_trans_sock *ts = NULL;
+	struct v9fs_transport *trans = v9ses->transport;
+
+	sema_init(&trans->writelock, 1);
+	sema_init(&trans->readlock, 1);
+
+	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
+
+	if (!ts)
+		return -ENOMEM;
+
+	trans->priv = ts;
+	ts->s = NULL;
+
+	if (!addr)
+		return -EINVAL;
+
+	dprintk(DEBUG_TRANS, "Connecting to %s\n", addr);
+
+	sin_server.sin_family = AF_INET;
+	sin_server.sin_addr.s_addr = in_aton(addr);
+	sin_server.sin_port = htons(v9ses->port);
+	sock_create_kern(PF_INET, SOCK_STREAM, IPPROTO_TCP, &csocket);
+	rc = csocket->ops->connect(csocket,
+				   (struct sockaddr *)&sin_server,
+				   sizeof(struct sockaddr_in), 0);
+	if (rc < 0) {
+		eprintk(KERN_ERR,
+			"v9fs_trans_tcp: problem connecting socket to %s\n",
+			addr);
+		return rc;
+	}
+	csocket->sk->sk_allocation = GFP_NOIO;
+	ts->s = csocket;
+	trans->status = Connected;
+
+	return 0;
+}
+
+/**
+ * v9fs_unix_init - initialize UNIX domain socket
+ * @v9ses: session information
+ * @dev_name: path to named pipe
+ * @data: mount options
+ *
+ */
+
+static int
+v9fs_unix_init(struct v9fs_session_info *v9ses, const char *dev_name,
+	       char *data)
+{
+	struct socket *csocket = NULL;
+	struct sockaddr_un sun_server;
+	struct v9fs_transport *trans = v9ses->transport;
+	int rc = 0;
+
+	struct v9fs_trans_sock *ts =
+	    kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
+
+	if (!ts)
+		return -ENOMEM;
+
+	trans->priv = ts;
+	ts->s = NULL;
+
+	sema_init(&trans->writelock, 1);
+	sema_init(&trans->readlock, 1);
+
+	sun_server.sun_family = PF_UNIX;
+	strcpy(sun_server.sun_path, dev_name);
+	sock_create_kern(PF_UNIX, SOCK_STREAM, 0, &csocket);
+	rc = csocket->ops->connect(csocket,
+				   (struct sockaddr *)&sun_server,
+				   sizeof(struct sockaddr_un), 0);
+	if (rc < 0) {
+		eprintk(KERN_ERR,
+			"v9fs_trans_unix: problem connecting socket: %s: %d\n",
+			dev_name, rc);
+		return rc;
+	}
+	csocket->sk->sk_allocation = GFP_NOIO;
+	ts->s = csocket;
+	trans->status = Connected;
+
+	return 0;
+}
+
+/**
+ * v9fs_sock_close - shutdown socket
+ * @trans: private socket structure
+ *
+ */
+
+static void v9fs_sock_close(struct v9fs_transport *trans)
+{
+	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+
+	if ((ts) && (ts->s)) {
+		dprintk(DEBUG_TRANS, "closing the socket %p\n", ts->s);
+		sock_release(ts->s);
+		ts->s = NULL;
+		trans->status = Disconnected;
+		dprintk(DEBUG_TRANS, "socket closed\n");
+	}
+
+	kfree(ts);
+}
+
+struct v9fs_transport v9fs_trans_tcp = {
+	.init = v9fs_tcp_init,
+	.write = v9fs_sock_send,
+	.read = v9fs_sock_recv,
+	.close = v9fs_sock_close,
+};
+
+struct v9fs_transport v9fs_trans_unix = {
+	.init = v9fs_unix_init,
+	.write = v9fs_sock_send,
+	.read = v9fs_sock_recv,
+	.close = v9fs_sock_close,
+};
