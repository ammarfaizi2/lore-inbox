Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWEFTOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWEFTOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWEFTOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:14:23 -0400
Received: from 70-56-217-91.albq.qwest.net ([70.56.217.91]:54978 "EHLO
	moria.ionkov.net") by vger.kernel.org with ESMTP id S932066AbWEFTOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:14:22 -0400
Date: Sat, 6 May 2006 13:14:45 -0600
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: Twalk memory leak
Message-ID: <20060506191445.GA8063@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs leaks memory if the file server responds with Rerror to a Twalk
message. The patch fixes the leak.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit d0ea523deb849227892c3359227219a260390dec
tree da70110e3a0691dd0a30d037b6456b9372c20f51
parent ebf34c9b6fcd22338ef764b039b3ac55ed0e297b
author Latchesar Ionkov <lucho@ionkov.net> Tue, 02 May 2006 16:42:24 -0600
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 02 May 2006 16:42:24 -0600

 fs/9p/fcall.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/9p/fcall.c b/fs/9p/fcall.c
index 71742ba..6f26178 100644
--- a/fs/9p/fcall.c
+++ b/fs/9p/fcall.c
@@ -98,23 +98,20 @@ v9fs_t_attach(struct v9fs_session_info *
 static void v9fs_t_clunk_cb(void *a, struct v9fs_fcall *tc,
 	struct v9fs_fcall *rc, int err)
 {
-	int fid;
+	int fid, id;
 	struct v9fs_session_info *v9ses;
 
-	if (err)
-		return;
-
+	id = 0;
 	fid = tc->params.tclunk.fid;
-	kfree(tc);
-
-	if (!rc)
-		return;
-
-	v9ses = a;
-	if (rc->id == RCLUNK)
-		v9fs_put_idpool(fid, &v9ses->fidpool);
+	if (rc)
+		id = rc->id;
 
+	kfree(tc);
 	kfree(rc);
+	if (id == RCLUNK) {
+		v9ses = a;
+		v9fs_put_idpool(fid, &v9ses->fidpool);
+	}
 }
 
 /**

