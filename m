Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWAXCBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWAXCBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWAXCBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:01:39 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:37368 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030297AbWAXCBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:01:38 -0500
Date: Mon, 23 Jan 2006 21:03:47 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: fix corner cases when flushing request
Message-ID: <20060124020347.GB26367@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When v9fs_mux_rpc sends a 9P message, it may be put in the queue of unsent
request. If the user process receives a signal, v9fs_mux_rpc sets the
request error to ERREQFLUSH and assigns NULL to request's send message. If
the message was still in the unsent queue, v9fs_write_work would produce an
oops while processing it.

The patch makes sure that requests that are being flushed are moved to the
pending requests queue safely.

If a request is being flushed, don't remove it from the list of pending
requests even if it receives a reply before the flush is acknoledged. The
request will be removed during from the Rflush handler (v9fs_mux_flush_cb).

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 8e60a35994c30c4440e45be756123dbeff309ad5
tree e92fb9d7758402a98d3914f52dddbc2430762f5c
parent 7d47de04b78b23c3d516cb9510681e740c476dba
author Latchesar Ionkov <lucho@ionkov.net> Mon, 23 Jan 2006 20:54:57 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Mon, 23 Jan 2006 20:54:57 -0500

 fs/9p/mux.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 945cb36..ea1134e 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -471,10 +471,13 @@ static void v9fs_write_work(void *a)
 		}
 
 		spin_lock(&m->lock);
-		req =
-		    list_entry(m->unsent_req_list.next, struct v9fs_req,
+again:
+		req = list_entry(m->unsent_req_list.next, struct v9fs_req,
 			       req_list);
 		list_move_tail(&req->req_list, &m->req_list);
+		if (req->err == ERREQFLUSH)
+			goto again;
+
 		m->wbuf = req->tcall->sdata;
 		m->wsize = req->tcall->size;
 		m->wpos = 0;
@@ -525,7 +528,7 @@ static void process_request(struct v9fs_
 	struct v9fs_str *ename;
 
 	tag = req->tag;
-	if (req->rcall->id == RERROR && !req->err) {
+	if (!req->err && req->rcall->id == RERROR) {
 		ecode = req->rcall->params.rerror.errno;
 		ename = &req->rcall->params.rerror.error;
 
@@ -551,7 +554,10 @@ static void process_request(struct v9fs_
 			req->err = -EIO;
 	}
 
-	if (req->cb && req->err != ERREQFLUSH) {
+	if (req->err == ERREQFLUSH)
+		return;
+
+	if (req->cb) {
 		dprintk(DEBUG_MUX, "calling callback tcall %p rcall %p\n",
 			req->tcall, req->rcall);
 
@@ -812,6 +818,7 @@ v9fs_mux_rpc_cb(void *a, struct v9fs_fca
 	struct v9fs_mux_rpc *r;
 
 	if (err == ERREQFLUSH) {
+		kfree(rc);
 		dprintk(DEBUG_MUX, "err req flush\n");
 		return;
 	}
