Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936401AbWK3M0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936401AbWK3M0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936375AbWK3MYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:24:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936370AbWK3MYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:24:06 -0500
Subject: [GFS2] Mount problem with the GFS2 code [68/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Srinivasa DS <srinivasa@in.ibm.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:23:51 +0000
Message-Id: <1164889431.3752.445.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 0da3585e1ef650d3224b4d6f9799558d1d99fa1e Mon Sep 17 00:00:00 2001
From: Srinivasa Ds <srinivasa@in.ibm.com>
Date: Thu, 30 Nov 2006 15:04:55 +0530
Subject: [PATCH] [GFS2] Mount problem with the GFS2 code

  While mounting the gfs2 filesystem,our test team had a problem and we
got this error message.
=======================================================

GFS2: fsid=: Trying to join cluster "lock_nolock", "dasde1"
GFS2: fsid=dasde1.0: Joined cluster. Now mounting FS...
GFS2: not a GFS2 filesystem
GFS2: fsid=dasde1.0: can't read superblock: -22

==========================================================================
On debugging further we found that problem is while reading the super
block(gfs2_read_super) and comparing the magic number in it.
When I  replace the submit_bio() call(present in gfs2_read_super) with
the sb_getblk() and ll_rw_block(), mount operation succeded.
On further analysis we found that before calling submit_bio(),
bio->bi_sector was set to "sector" variable. This "sector" variable has
the same value of bh->b_blocknr(block number). Hence there is a need to
multiply this valuwith (blocksize >> 9)(9 because,sector size
2^9,samething happens in ll_rw_block also, before calling submit_bio()).
So I have developed the patch which solves this problem. Please let me
know your comments.
================================================================

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 1408c5f..3b22727 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -199,7 +199,7 @@ struct page *gfs2_read_super(struct supe
 		return NULL;
 	}
 
-	bio->bi_sector = sector;
+	bio->bi_sector = sector * (sb->s_blocksize >> 9);
 	bio->bi_bdev = sb->s_bdev;
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 
-- 
1.4.1



