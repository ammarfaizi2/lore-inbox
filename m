Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936312AbWK3MRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936312AbWK3MRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936304AbWK3MRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:17:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936314AbWK3MRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:17:18 -0500
Subject: [GFS2] Don't copy meta_header for rgrp in and out [30/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:17:10 +0000
Message-Id: <1164889030.3752.364.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From f6e58f01e8dc869803b9f73b2aa9d5bc3f32ca05 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 7 Nov 2006 15:14:58 -0500
Subject: [PATCH] [GFS2] Don't copy meta_header for rgrp in and out

The meta_header for an ondisk rgrp never changes, so there is no point
copying it in and back out to disk. Also there is no reason to keep
a copy for each rgrp in memory.

The code already checks to ensure that the header is correct before
it calls the routine to copy the data in, so that we don't even need
to check whether its correct on disk in the functions in ondisk.c

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ondisk.c            |   11 -----------
 include/linux/gfs2_ondisk.h |    2 --
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index b2baba5..f2495f1 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -65,15 +65,6 @@ static void gfs2_meta_header_in(struct g
 	mh->mh_format = be32_to_cpu(str->mh_format);
 }
 
-static void gfs2_meta_header_out(const struct gfs2_meta_header_host *mh, void *buf)
-{
-	struct gfs2_meta_header *str = buf;
-
-	str->mh_magic = cpu_to_be32(mh->mh_magic);
-	str->mh_type = cpu_to_be32(mh->mh_type);
-	str->mh_format = cpu_to_be32(mh->mh_format);
-}
-
 void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf)
 {
 	const struct gfs2_sb *str = buf;
@@ -119,7 +110,6 @@ void gfs2_rgrp_in(struct gfs2_rgrp_host 
 {
 	const struct gfs2_rgrp *str = buf;
 
-	gfs2_meta_header_in(&rg->rg_header, buf);
 	rg->rg_flags = be32_to_cpu(str->rg_flags);
 	rg->rg_free = be32_to_cpu(str->rg_free);
 	rg->rg_dinodes = be32_to_cpu(str->rg_dinodes);
@@ -130,7 +120,6 @@ void gfs2_rgrp_out(const struct gfs2_rgr
 {
 	struct gfs2_rgrp *str = buf;
 
-	gfs2_meta_header_out(&rg->rg_header, buf);
 	str->rg_flags = cpu_to_be32(rg->rg_flags);
 	str->rg_free = cpu_to_be32(rg->rg_free);
 	str->rg_dinodes = cpu_to_be32(rg->rg_dinodes);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 536575e..8b7e4c1 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -213,8 +213,6 @@ struct gfs2_rgrp {
 };
 
 struct gfs2_rgrp_host {
-	struct gfs2_meta_header_host rg_header;
-
 	__u32 rg_flags;
 	__u32 rg_free;
 	__u32 rg_dinodes;
-- 
1.4.1



