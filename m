Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936409AbWK3M1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936409AbWK3M1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936373AbWK3MWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:22:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936371AbWK3MWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:23 -0500
Subject: [GFS2] Move gfs2_meta_syncfs() into log.c [57/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:00 +0000
Message-Id: <1164889320.3752.419.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a25311c8e0b7071b129ca9a9e49e22eeaf620864 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 23 Nov 2006 11:06:35 -0500
Subject: [PATCH] [GFS2] Move gfs2_meta_syncfs() into log.c

By moving gfs2_meta_syncfs() into log.c, gfs2_ail1_start()
can be made static.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/log.c     |   21 ++++++++++++++++++++-
 fs/gfs2/log.h     |    2 +-
 fs/gfs2/meta_io.c |   17 -----------------
 fs/gfs2/meta_io.h |    1 -
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 6456fc3..7713d59 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -15,6 +15,7 @@ #include <linux/buffer_head.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/crc32.h>
 #include <linux/lm_interface.h>
+#include <linux/delay.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -142,7 +143,7 @@ static int gfs2_ail1_empty_one(struct gf
 	return list_empty(&ai->ai_ail1_list);
 }
 
-void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags)
+static void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags)
 {
 	struct list_head *head = &sdp->sd_ail1_list;
 	u64 sync_gen;
@@ -689,3 +690,21 @@ void gfs2_log_shutdown(struct gfs2_sbd *
 	up_write(&sdp->sd_log_flush_lock);
 }
 
+
+/**
+ * gfs2_meta_syncfs - sync all the buffers in a filesystem
+ * @sdp: the filesystem
+ *
+ */
+
+void gfs2_meta_syncfs(struct gfs2_sbd *sdp)
+{
+	gfs2_log_flush(sdp, NULL);
+	for (;;) {
+		gfs2_ail1_start(sdp, DIO_ALL);
+		if (gfs2_ail1_empty(sdp, DIO_ALL))
+			break;
+		msleep(10);
+	}
+}
+
diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index 7f5737d..8e7aa0f 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -48,7 +48,6 @@ static inline void gfs2_log_pointers_ini
 unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct,
 			    unsigned int ssize);
 
-void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags);
 int gfs2_ail1_empty(struct gfs2_sbd *sdp, int flags);
 
 int gfs2_log_reserve(struct gfs2_sbd *sdp, unsigned int blks);
@@ -61,5 +60,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp
 void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
 
 void gfs2_log_shutdown(struct gfs2_sbd *sdp);
+void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
 
 #endif /* __LOG_DOT_H__ */
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 939a09f..fbeba81 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -574,20 +574,3 @@ out:
 	return first_bh;
 }
 
-/**
- * gfs2_meta_syncfs - sync all the buffers in a filesystem
- * @sdp: the filesystem
- *
- */
-
-void gfs2_meta_syncfs(struct gfs2_sbd *sdp)
-{
-	gfs2_log_flush(sdp, NULL);
-	for (;;) {
-		gfs2_ail1_start(sdp, DIO_ALL);
-		if (gfs2_ail1_empty(sdp, DIO_ALL))
-			break;
-		msleep(10);
-	}
-}
-
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 3ec939e..e037425 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -67,7 +67,6 @@ static inline int gfs2_meta_inode_buffer
 }
 
 struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen);
-void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
 
 #define buffer_busy(bh) \
 ((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock) | (1ul << BH_Pinned)))
-- 
1.4.1



