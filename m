Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWCCE7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWCCE7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWCCE7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:59:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:21134 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750743AbWCCE7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:59:48 -0500
Date: Thu, 2 Mar 2006 22:33:33 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603022233.k22MXXAh018191@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: rename tids to tags to be consistent with Plan 9 documentation
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: rename tids to tags to be consistent with Plan 9 documentation

From: Russ Cox <rsc@swtch.com>

The code talks about these things called tids,
which I eventually figured out are tags.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/9p.c   |    2 +-
 fs/9p/mux.c  |   12 ++++++------
 fs/9p/v9fs.c |    2 +-
 fs/9p/v9fs.h |    3 ---
 4 files changed, 8 insertions(+), 11 deletions(-)

04dd472fe05de8922f85fac067278b543fe38482
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index 1a6d087..6323091 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -152,7 +152,7 @@ v9fs_t_clunk(struct v9fs_session_info *v
 /**
  * v9fs_v9fs_t_flush - flush a pending transaction
  * @v9ses: 9P2000 session information
- * @tag: tid to release
+ * @tag: tag to release
  *
  */
 
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index ea1134e..75718b9 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -69,7 +69,7 @@ struct v9fs_mux_data {
 	int msize;
 	unsigned char *extended;
 	struct v9fs_transport *trans;
-	struct v9fs_idpool tidpool;
+	struct v9fs_idpool tagpool;
 	int err;
 	wait_queue_head_t equeue;
 	struct list_head req_list;
@@ -279,8 +279,8 @@ struct v9fs_mux_data *v9fs_mux_init(stru
 	m->msize = msize;
 	m->extended = extended;
 	m->trans = trans;
-	idr_init(&m->tidpool.pool);
-	init_MUTEX(&m->tidpool.lock);
+	idr_init(&m->tagpool.pool);
+	init_MUTEX(&m->tagpool.lock);
 	m->err = 0;
 	init_waitqueue_head(&m->equeue);
 	INIT_LIST_HEAD(&m->req_list);
@@ -963,7 +963,7 @@ static u16 v9fs_mux_get_tag(struct v9fs_
 {
 	int tag;
 
-	tag = v9fs_get_idpool(&m->tidpool);
+	tag = v9fs_get_idpool(&m->tagpool);
 	if (tag < 0)
 		return V9FS_NOTAG;
 	else
@@ -972,6 +972,6 @@ static u16 v9fs_mux_get_tag(struct v9fs_
 
 static void v9fs_mux_put_tag(struct v9fs_mux_data *m, u16 tag)
 {
-	if (tag != V9FS_NOTAG && v9fs_check_idpool(tag, &m->tidpool))
-		v9fs_put_idpool(tag, &m->tidpool);
+	if (tag != V9FS_NOTAG && v9fs_check_idpool(tag, &m->tagpool))
+		v9fs_put_idpool(tag, &m->tagpool);
 }
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 6135249..daf623c 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -289,7 +289,7 @@ v9fs_session_init(struct v9fs_session_in
 	/* set global debug level */
 	v9fs_debug_level = v9ses->debug;
 
-	/* id pools that are session-dependent: FIDs and TIDs */
+	/* id pools that are session-dependent: fids and tags */
 	idr_init(&v9ses->fidpool.pool);
 	init_MUTEX(&v9ses->fidpool.lock);
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f337da7..9f63ab8 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -91,6 +91,3 @@ void v9fs_session_cancel(struct v9fs_ses
 #define V9FS_DEFUSER	"nobody"
 #define V9FS_DEFANAME	""
 
-/* inital pool sizes for fids and tags */
-#define V9FS_START_FIDS 8192
-#define V9FS_START_TIDS 256
-- 
1.0.GIT
