Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936311AbWK3MSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936311AbWK3MSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936329AbWK3MSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936311AbWK3MSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:18:38 -0500
Subject: [GFS2] Fix race in logging code [36/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:18:48 +0000
Message-Id: <1164889128.3752.376.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 7020933156ac2a8a7386314933e49948bf0438f7 Mon Sep 17 00:00:00 2001
From: Russell Cattelan <cattelan@redhat.com>
Date: Thu, 9 Nov 2006 11:28:08 -0500
Subject: [PATCH] [GFS2] Fix race in logging code

The log lock is dropped prior to io submittion, but
this exposes a hole in which the log data structures
may be going away due to a truncate.
Store the buffer head in a local pointer prior to
dropping the lock and relay on the buffer_head lock
for consitency on the buffer head.

Signed-Off-By: Russell Cattelan <cattelan@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/lops.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 8a654cd..4d7f94d 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -509,7 +509,7 @@ static void databuf_lo_before_commit(str
 {
 	LIST_HEAD(started);
 	struct gfs2_bufdata *bd1 = NULL, *bd2, *bdt;
-	struct buffer_head *bh = NULL;
+	struct buffer_head *bh = NULL,*bh1 = NULL;
 	unsigned int offset = sizeof(struct gfs2_log_descriptor);
 	struct gfs2_log_descriptor *ld;
 	unsigned int limit;
@@ -537,8 +537,13 @@ static void databuf_lo_before_commit(str
 		list_for_each_entry_safe_continue(bd1, bdt,
 						  &sdp->sd_log_le_databuf,
 						  bd_le.le_list) {
+			/* store off the buffer head in a local ptr since
+			 * gfs2_bufdata might change when we drop the log lock
+			 */
+			bh1 = bd1->bd_bh;
+
 			/* An ordered write buffer */
-			if (bd1->bd_bh && !buffer_pinned(bd1->bd_bh)) {
+			if (bh1 && !buffer_pinned(bh1)) {
 				list_move(&bd1->bd_le.le_list, &started);
 				if (bd1 == bd2) {
 					bd2 = NULL;
@@ -547,20 +552,21 @@ static void databuf_lo_before_commit(str
 							bd_le.le_list);
 				}
 				total_dbuf--;
-				if (bd1->bd_bh) {
-					get_bh(bd1->bd_bh);
-					if (buffer_dirty(bd1->bd_bh)) {
+				if (bh1) {
+					if (buffer_dirty(bh1)) {
+						get_bh(bh1);
+
 						gfs2_log_unlock(sdp);
-						wait_on_buffer(bd1->bd_bh);
-						ll_rw_block(WRITE, 1,
-							    &bd1->bd_bh);
+
+						ll_rw_block(SWRITE, 1, &bh1);
+						brelse(bh1);
+
 						gfs2_log_lock(sdp);
 					}
-					brelse(bd1->bd_bh);
 					continue;
 				}
 				continue;
-			} else if (bd1->bd_bh) { /* A journaled buffer */
+			} else if (bh1) { /* A journaled buffer */
 				int magic;
 				gfs2_log_unlock(sdp);
 				if (!bh) {
@@ -582,16 +588,16 @@ static void databuf_lo_before_commit(str
 					ld->ld_data2 = cpu_to_be32(0);
 					memset(ld->ld_reserved, 0, sizeof(ld->ld_reserved));
 				}
-				magic = gfs2_check_magic(bd1->bd_bh);
-				*ptr++ = cpu_to_be64(bd1->bd_bh->b_blocknr);
+				magic = gfs2_check_magic(bh1);
+				*ptr++ = cpu_to_be64(bh1->b_blocknr);
 				*ptr++ = cpu_to_be64((__u64)magic);
-				clear_buffer_escaped(bd1->bd_bh);
+				clear_buffer_escaped(bh1);
 				if (unlikely(magic != 0))
-					set_buffer_escaped(bd1->bd_bh);
+					set_buffer_escaped(bh1);
 				gfs2_log_lock(sdp);
 				if (n++ > num)
 					break;
-			} else if (!bd1->bd_bh) {
+			} else if (!bh1) {
 				total_dbuf--;
 				sdp->sd_log_num_databuf--;
 				list_del_init(&bd1->bd_le.le_list);
-- 
1.4.1



