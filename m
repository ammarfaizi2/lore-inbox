Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWJLROd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWJLROd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWJLROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:14:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751427AbWJLROY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:14:24 -0400
Subject: [PATCH 4/7] [GFS2] Fix bug where lock not held
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:28 +0100
Message-Id: <1160673569.11901.828.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From fe1a698ffef5af546dd4a8cd6a1f2f202491c4ef Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 11 Oct 2006 13:34:59 -0400
Subject: [GFS2] Fix bug where lock not held

The log lock needs to be held when manipulating the counter
for the number of free journal blocks.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/log.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 554fe5b..72eec65 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -569,16 +569,15 @@ void gfs2_log_flush(struct gfs2_sbd *sdp
 	else if (sdp->sd_log_tail != current_tail(sdp) && !sdp->sd_log_idle)
 		log_write_header(sdp, 0, PULL);
 	lops_after_commit(sdp, ai);
-	sdp->sd_log_head = sdp->sd_log_flush_head;
 
+	gfs2_log_lock(sdp);
+	sdp->sd_log_head = sdp->sd_log_flush_head;
 	sdp->sd_log_blks_free -= sdp->sd_log_num_hdrs;
-
 	sdp->sd_log_blks_reserved = 0;
 	sdp->sd_log_commited_buf = 0;
 	sdp->sd_log_num_hdrs = 0;
 	sdp->sd_log_commited_revoke = 0;
 
-	gfs2_log_lock(sdp);
 	if (!list_empty(&ai->ai_ail1_list)) {
 		list_add(&ai->ai_list, &sdp->sd_ail1_list);
 		ai = NULL;
-- 
1.4.1



