Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936335AbWK3MWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936335AbWK3MWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936368AbWK3MV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:21:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64397 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936365AbWK3MVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:53 -0500
Subject: [GFS2] Fix glock ordering on inode creation [54/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:21:43 +0000
Message-Id: <1164889303.3752.413.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 28626e2078571c4b776a17eaa486bbd2b7dfe2cd Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 22 Nov 2006 11:13:21 -0500
Subject: [PATCH] [GFS2] Fix glock ordering on inode creation

The lock order here should be parent -> child rather than
numeric order.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c |   31 ++++---------------------------
 1 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index ce7f833..d122074 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -870,33 +870,10 @@ struct inode *gfs2_createi(struct gfs2_h
 	if (error)
 		goto fail_gunlock;
 
-	if (inum.no_addr < dip->i_num.no_addr) {
-		gfs2_glock_dq(ghs);
-
-		error = gfs2_glock_nq_num(sdp, inum.no_addr,
-					  &gfs2_inode_glops, LM_ST_EXCLUSIVE,
-					  GL_SKIP, ghs + 1);
-		if (error) {
-			return ERR_PTR(error);
-		}
-
-		gfs2_holder_reinit(LM_ST_EXCLUSIVE, 0, ghs);
-		error = gfs2_glock_nq(ghs);
-		if (error) {
-			gfs2_glock_dq_uninit(ghs + 1);
-			return ERR_PTR(error);
-		}
-
-		error = create_ok(dip, name, mode);
-		if (error)
-			goto fail_gunlock2;
-	} else {
-		error = gfs2_glock_nq_num(sdp, inum.no_addr,
-					  &gfs2_inode_glops, LM_ST_EXCLUSIVE,
-					  GL_SKIP, ghs + 1);
-		if (error)
-			goto fail_gunlock;
-	}
+	error = gfs2_glock_nq_num(sdp, inum.no_addr, &gfs2_inode_glops,
+				  LM_ST_EXCLUSIVE, GL_SKIP, ghs + 1);
+	if (error)
+		goto fail_gunlock;
 
 	error = make_dinode(dip, ghs[1].gh_gl, mode, &inum, &generation, dev);
 	if (error)
-- 
1.4.1



