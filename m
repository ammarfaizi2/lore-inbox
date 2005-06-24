Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263289AbVFXVI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbVFXVI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVFXVIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:08:16 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:30124 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262601AbVFXVEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:04:46 -0400
Message-Id: <200506242104.j5OL4aH9005358@ms-smtp-01-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Fri, 24 Jun 2005 16:03:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] v9fs: fix timeout segfault corner case
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for problem reported by DEac- in which a recursive traversal through
a single threaded server times out and then crashes the system when the
single threaded server unblocks and sends the packet that was timed out.

Problem was caused by a pointer which needed to be initialized every time
through the event loop in recv proc, but was previously only intialized prior 
to entering the loop.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit f341153ff8705bbe54f8bb652e856f75712b0c52
tree c0c749a66b02dcc43ec6a4c3a299feb815789e49
parent 3a232d10ca42ca692f4fa6c07ce1508ad1cca933
author Eric Van Hensbergen <ericvh@gmail.com> Fri, 24 Jun 2005 12:33:49 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Fri, 24 Jun 2005 12:33:49 -0500

 fs/9p/mux.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -175,7 +175,7 @@ static int v9fs_recv(struct v9fs_session
 		spin_unlock(&v9ses->muxlock);
 	}
 	if (ret == 0) {		/* timeout */
-		dprintk(DEBUG_MUX, "Connection timeout after %u (%u)\n",
+			dprintk(DEBUG_ERROR, "Connection timeout after %u (%u)\n",
 			v9ses->timeout,
 			(unsigned int)msecs_to_jiffies(v9ses->timeout));
 		v9ses->session_hung = 1;
@@ -344,26 +344,26 @@ static int v9fs_recvproc(void *data)
 	struct v9fs_fcall *rcall = NULL;
 	struct list_head *rptr;
 	struct list_head *rrptr;
-	struct v9fs_rpcreq *req = NULL;
+	struct v9fs_rpcreq *req;
 	int err = 0;
 
 	allow_signal(SIGKILL);
 	set_current_state(TASK_INTERRUPTIBLE);
 	complete(&v9ses->proccmpl);
 	while (!kthread_should_stop() && err >= 0) {
+		req = NULL;
+
 		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
 		if(!rcall) {
 			eprintk(KERN_ERR, "no memory for buffers\n");
 			break;
 		}
 
-		dprintk(DEBUG_MUX, "waiting for message\n");
 		err = read_message(v9ses, rcall, v9ses->maxdata + V9FS_IOHDRSZ);
 		if (err < 0) {
 			kfree(rcall);
 			break;
 		}
-
 		spin_lock(&v9ses->muxlock);
 		list_for_each_safe(rptr, rrptr, &v9ses->mux_fcalls) {
 			struct v9fs_rpcreq *rreq =
