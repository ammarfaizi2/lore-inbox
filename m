Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVGNSdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVGNSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbVGNSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:16 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:52420 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263084AbVGNSbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:45 -0400
Message-Id: <200507141830.j6EIUse1020719@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:56 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 6/7] v9fs: transport modules (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [6/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

This part of the patch contains transport routine changes related to
hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 fs/9p/trans_sock.c   |    2 +-
 fs/9p/mux.c          |   44 +++++++++++++++-----------------------------
 2 files changed, 16 insertions(+), 30 deletions(-)

 ----------

--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -29,9 +29,9 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kthread.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "transport.h"
@@ -160,30 +160,19 @@ static int v9fs_recv(struct v9fs_session
 	int ret = 0;
 
 	dprintk(DEBUG_MUX, "waiting for response: %d\n", req->tcall->tag);
-	ret = wait_event_interruptible_timeout(v9ses->read_wait,
+	ret = wait_event_interruptible(v9ses->read_wait,
 		       ((v9ses->transport->status != Connected) ||
-			(req->rcall != 0) || dprintcond(v9ses, req)),
-		       msecs_to_jiffies(v9ses->timeout));
+			(req->rcall != 0) || dprintcond(v9ses, req)));
 
 	dprintk(DEBUG_MUX, "got it: rcall %p\n", req->rcall);
 	if (v9ses->transport->status == Disconnected)
 		return -ECONNRESET;
 
-	if (ret >= 0) {
+	if (ret == 0) {
 		spin_lock(&v9ses->muxlock);
 		list_del(&req->next);
 		spin_unlock(&v9ses->muxlock);
 	}
-	if (ret == 0) {		/* timeout */
-			dprintk(DEBUG_ERROR, "Connection timeout after %u (%u)\n",
-			v9ses->timeout,
-			(unsigned int)msecs_to_jiffies(v9ses->timeout));
-		v9ses->session_hung = 1;
-		v9ses->transport->status = Hung;
-		return -ETIMEDOUT;
-	} else {
-		ret = 0;	/* reset return code */
-	}
 
 	return ret;
 }
@@ -273,7 +262,8 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	ret = v9fs_send(v9ses, &req);
 
 	if (ret < 0) {
-		v9fs_put_idpool(tid, &v9ses->tidpool);
+		if(tcall->id != TVERSION)
+			v9fs_put_idpool(tid, &v9ses->tidpool);
 		dprintk(DEBUG_MUX, "error %d\n", ret);
 		return ret;
 	}
@@ -323,7 +313,8 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	}
 
       release_req:
-	v9fs_put_idpool(tid, &v9ses->tidpool);
+	if(tcall->id != TVERSION)
+		v9fs_put_idpool(tid, &v9ses->tidpool);
 	if (rcall)
 		*rcall = fcall;
 	else
@@ -342,16 +333,16 @@ static int v9fs_recvproc(void *data)
 {
 	struct v9fs_session_info *v9ses = (struct v9fs_session_info *)data;
 	struct v9fs_fcall *rcall = NULL;
-	struct list_head *rptr;
-	struct list_head *rrptr;
+	struct v9fs_rpcreq *rptr;
 	struct v9fs_rpcreq *req;
+	struct v9fs_rpcreq *rreq;
 	int err = 0;
 
 	allow_signal(SIGKILL);
 	set_current_state(TASK_INTERRUPTIBLE);
 	complete(&v9ses->proccmpl);
 	while (!kthread_should_stop() && err >= 0) {
-		req = NULL;
+		req = rptr = rreq = NULL;
 
 		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
 		if(!rcall) {
@@ -365,10 +356,7 @@ static int v9fs_recvproc(void *data)
 			break;
 		}
 		spin_lock(&v9ses->muxlock);
-		list_for_each_safe(rptr, rrptr, &v9ses->mux_fcalls) {
-			struct v9fs_rpcreq *rreq =
-			    list_entry(rptr, struct v9fs_rpcreq, next);
-
+		list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
 			if (rreq->tcall->tag == rcall->tag) {
 				req = rreq;
 				req->rcall = rcall;
@@ -377,13 +365,11 @@ static int v9fs_recvproc(void *data)
 		}
 
 		if (req && (req->tcall->id == TFLUSH)) {
-			list_for_each_safe(rptr, rrptr, &v9ses->mux_fcalls) {
-				struct v9fs_rpcreq *treq =
-				    list_entry(rptr, struct v9fs_rpcreq, next);
-
+			struct v9fs_rpcreq *treq = NULL;
+			list_for_each_entry_safe(treq, rptr, &v9ses->mux_fcalls, next) {
 				if (treq->tcall->tag ==
 				    req->tcall->params.tflush.oldtag) {
-					list_del(rptr);
+					list_del(&rptr->next);
 					kfree(treq->rcall);
 					break;
 				}
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -34,9 +34,9 @@
 #include <linux/un.h>
 #include <asm/uaccess.h>
 #include <linux/inet.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "transport.h"
 
