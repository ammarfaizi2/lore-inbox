Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWJTJMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWJTJMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWJTJMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932233AbWJTJMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:12:08 -0400
Subject: [PATCH 8/8] [GFS2] gfs2_dir_read_data(): fix uninitialized
	variable usage
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:19:07 +0100
Message-Id: <1161335947.27980.195.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b7d8ac3e1779c30ddef0a8f38042076c5007a23d Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 19 Oct 2006 16:02:07 +0200
Subject: [GFS2] gfs2_dir_read_data(): fix uninitialized variable usage

In the "if (extlen)" case, "bh" was used uninitialized.

This patch changes the code to what seems to have been intended.

Spotted by the Coverity checker.

This patch also removes a pointless "bh = NULL" asignment (the variable
is never accessed again after this point).

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index ead7df0..e24af28 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -315,8 +315,7 @@ static int gfs2_dir_read_data(struct gfs
 			if (!ra)
 				extlen = 1;
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
-		}
-		if (!bh) {
+		} else {
 			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, &bh);
 			if (error)
 				goto fail;
@@ -330,7 +329,6 @@ static int gfs2_dir_read_data(struct gfs
 		extlen--;
 		memcpy(buf, bh->b_data + o, amount);
 		brelse(bh);
-		bh = NULL;
 		buf += amount;
 		copied += amount;
 		lblock++;
-- 
1.4.1



