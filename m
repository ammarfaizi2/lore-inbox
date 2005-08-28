Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVH1SVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVH1SVD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVH1SVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:21:03 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:49318 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750736AbVH1SVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:21:02 -0400
Subject: [PATCH 2.6.13-rc6-mm2] v9fs: fix handling of malformed 9P messages
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Undisclosed-Recipient:;
Content-Type: text/plain
Date: Sun, 28 Aug 2005 13:20:44 -0500
Message-Id: <1125253244.17501.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: fix handling of malformed 9P messages

This patch attempts to do a better job of cleaning up after detecting
errors on the transport.  This should also improve error reporting on
broken connections to servers.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 97bc19b509356dda0145cd19fb9768ac3c88ecda
tree f12a9e827c949f386cca42b718bac63405e9192d
parent 2b2ebf0cea451ad876ab29159162571b5291f8b7
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 13:11:33
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
13:11:33 -0500

 fs/9p/error.h      |    1 +
 fs/9p/mux.c        |   53
+++++++++++++++++++++++++++++++++-------------------
 fs/9p/mux.h        |    1 +
 fs/9p/trans_sock.c |   12 ++++++++++--
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/fs/9p/error.h b/fs/9p/error.h
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -47,6 +47,7 @@ static struct errormap errmap[] = {
 	{"Operation not permitted", EPERM},
 	{"wstat prohibited", EPERM},
 	{"No such file or directory", ENOENT},
+	{"directory entry not found", ENOENT},
 	{"file not found", ENOENT},
 	{"Interrupted system call", EINTR},
 	{"Input/output error", EIO},
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -162,18 +162,21 @@ static int v9fs_recv(struct v9fs_session
 	dprintk(DEBUG_MUX, "waiting for response: %d\n", req->tcall->tag);
 	ret = wait_event_interruptible(v9ses->read_wait,
 		       ((v9ses->transport->status != Connected) ||
-			(req->rcall != 0) || dprintcond(v9ses, req)));
+			(req->rcall != 0) || (req->err < 0) || 
+			dprintcond(v9ses, req)));
 
 	dprintk(DEBUG_MUX, "got it: rcall %p\n", req->rcall);
+
+	spin_lock(&v9ses->muxlock);
+	list_del(&req->next);
+	spin_unlock(&v9ses->muxlock);
+
+	if (req->err < 0)
+		return req->err;
+
 	if (v9ses->transport->status == Disconnected)
 		return -ECONNRESET;
 
-	if (ret == 0) {
-		spin_lock(&v9ses->muxlock);
-		list_del(&req->next);
-		spin_unlock(&v9ses->muxlock);
-	}
-
 	return ret;
 }
 
@@ -245,6 +248,9 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	if (!v9ses)
 		return -EINVAL;
 
+	if (!v9ses->transport || v9ses->transport->status != Connected)
+		return -EIO;
+
 	if (rcall)
 		*rcall = NULL;
 
@@ -257,6 +263,7 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	tcall->tag = tid;
 
 	req.tcall = tcall;
+	req.err = 0;
 	req.rcall = NULL;
 
 	ret = v9fs_send(v9ses, &req);
@@ -351,16 +358,21 @@ static int v9fs_recvproc(void *data)
 		}
 
 		err = read_message(v9ses, rcall, v9ses->maxdata + V9FS_IOHDRSZ);
-		if (err < 0) {
-			kfree(rcall);
-			break;
-		}
 		spin_lock(&v9ses->muxlock);
-		list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
-			if (rreq->tcall->tag == rcall->tag) {
-				req = rreq;
-				req->rcall = rcall;
-				break;
+		if (err < 0) {
+			list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
+				rreq->err = err;
+			}
+			if(err != -ERESTARTSYS)
+				eprintk(KERN_ERR, 
+					"Transport error while reading message %d\n", err);
+		} else {
+			list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
+				if (rreq->tcall->tag == rcall->tag) {
+					req = rreq;
+					req->rcall = rcall;
+					break;
+				}
 			}
 		}
 
@@ -379,9 +391,10 @@ static int v9fs_recvproc(void *data)
 		spin_unlock(&v9ses->muxlock);
 
 		if (!req) {
-			dprintk(DEBUG_ERROR,
-				"unexpected response: id %d tag %d\n",
-				rcall->id, rcall->tag);
+			if (err >= 0)
+				dprintk(DEBUG_ERROR,
+					"unexpected response: id %d tag %d\n",
+					rcall->id, rcall->tag);
 
 			kfree(rcall);
 		}
@@ -390,6 +403,8 @@ static int v9fs_recvproc(void *data)
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 
+	v9ses->transport->close(v9ses->transport);
+
 	/* Inform all pending processes about the failure */
 	wake_up_all(&v9ses->read_wait);
 
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -28,6 +28,7 @@
 struct v9fs_rpcreq {
 	struct v9fs_fcall *tcall;
 	struct v9fs_fcall *rcall;
+	int err;	/* error code if response failed */
 
 	/* XXX - could we put scatter/gather buffers here? */
 
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -246,7 +246,12 @@ v9fs_unix_init(struct v9fs_session_info 
 
 static void v9fs_sock_close(struct v9fs_transport *trans)
 {
-	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+	struct v9fs_trans_sock *ts;
+
+	if (!trans)
+		return;
+
+	ts = trans->priv;
 
 	if ((ts) && (ts->s)) {
 		dprintk(DEBUG_TRANS, "closing the socket %p\n", ts->s);
@@ -256,7 +261,10 @@ static void v9fs_sock_close(struct v9fs_
 		dprintk(DEBUG_TRANS, "socket closed\n");
 	}
 
-	kfree(ts);
+	if (ts)
+		kfree(ts);
+
+	trans->priv = NULL;
 }
 
 struct v9fs_transport v9fs_trans_tcp = {


