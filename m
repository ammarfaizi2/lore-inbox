Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936267AbWK3MNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936267AbWK3MNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936268AbWK3MNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936267AbWK3MNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:14 -0500
Subject: [GFS2] Fix crc32 calculation in recovery.c [8/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:49 +0000
Message-Id: <1164888829.3752.318.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2a2c98247b822db8df037a56c27201f9d716ac66 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 14:44:50 -0500
Subject: [PATCH] [GFS2] Fix crc32 calculation in recovery.c

Commit "[GFS2] split and annotate gfs2_log_head" resulted in an incorrect
checksum calculation for log headers. This patch corrects the
problem without resorting to copying the whole log header as
the previous code used to.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/recovery.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 4478162..4acf238 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -136,6 +136,7 @@ static int get_log_header(struct gfs2_jd
 {
 	struct buffer_head *bh;
 	struct gfs2_log_header_host lh;
+static const u32 nothing = 0;
 	u32 hash;
 	int error;
 
@@ -143,11 +144,11 @@ static int get_log_header(struct gfs2_jd
 	if (error)
 		return error;
 
-	memcpy(&lh, bh->b_data, sizeof(struct gfs2_log_header));	/* XXX */
-	lh.lh_hash = 0;
-	hash = gfs2_disk_hash((char *)&lh, sizeof(struct gfs2_log_header));
+	hash = crc32_le((u32)~0, bh->b_data, sizeof(struct gfs2_log_header) -
+					     sizeof(u32));
+	hash = crc32_le(hash, (unsigned char const *)&nothing, sizeof(nothing));
+	hash ^= (u32)~0;
 	gfs2_log_header_in(&lh, bh->b_data);
-
 	brelse(bh);
 
 	if (lh.lh_header.mh_magic != GFS2_MAGIC ||
-- 
1.4.1



