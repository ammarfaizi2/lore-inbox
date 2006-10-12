Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJLRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJLRNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJLRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:13:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750975AbWJLRNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:13:32 -0400
Subject: [PATCH 1/7] [GFS2] Fix a size calculation error
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:18:52 +0100
Message-Id: <1160673532.11901.817.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 52ae7b7935a079aaba25da98fe90772d04109f26 Mon Sep 17 00:00:00 2001
From: Russell Cattelan <cattelan@redhat.com>
Date: Mon, 9 Oct 2006 12:11:54 -0500
Subject: [GFS2] Fix a size calculation error

Fix a size calculation error.
The size was incorrect being computed as a
negative length and then being passed to an
unsigned parameter.

This in turn would cause the allocator to
think it needed enough meta data to store
a gigabyte file for every file created.

Signed-off-by: Russell Cattelan <cattelan@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_address.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 4fb743f..bdf56cf 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -370,15 +370,17 @@ static int gfs2_prepare_write(struct fil
 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + from;
 	loff_t end = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	struct gfs2_alloc *al;
+	unsigned int write_len = to - from;
+
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|GL_AOP, &ip->i_gh);
 	error = gfs2_glock_nq_m_atime(1, &ip->i_gh);
 	if (error)
 		goto out_uninit;
 
-	gfs2_write_calc_reserv(ip, to - from, &data_blocks, &ind_blocks);
+	gfs2_write_calc_reserv(ip, write_len, &data_blocks, &ind_blocks);
 
-	error = gfs2_write_alloc_required(ip, pos, from - to, &alloc_required);
+	error = gfs2_write_alloc_required(ip, pos, write_len, &alloc_required);
 	if (error)
 		goto out_unlock;
 
-- 
1.4.1



