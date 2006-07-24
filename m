Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWGXV4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWGXV4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWGXV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:56:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:30131 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932269AbWGXV4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:56:37 -0400
Subject: [PATCH] [efs] Remove incorrect unlock_kernel from failure path in
	efs_symlink_readpage
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 14:56:38 -0700
Message-Id: <1153778198.4931.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If efs_symlink_readpage hits the -ENAMETOOLONG error path, it will call
unlock_kernel without ever having called lock_kernel(); fix this by creating
and jumping to a new label fail_notlocked rather than the fail label used
after calling lock_kernel().

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
This bug exists in the 2.4 kernel series as far back as 2.4.0, and this
patch should apply there as well.

 fs/efs/symlink.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index e249cf7..1d30d2f 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -22,7 +22,7 @@ static int efs_symlink_readpage(struct f
   
 	err = -ENAMETOOLONG;
 	if (size > 2 * EFS_BLOCKSIZE)
-		goto fail;
+		goto fail_notlocked;
   
 	lock_kernel();
 	/* read first 512 bytes of link target */
@@ -47,6 +47,7 @@ static int efs_symlink_readpage(struct f
 	return 0;
 fail:
 	unlock_kernel();
+fail_notlocked:
 	SetPageError(page);
 	kunmap(page);
 	unlock_page(page);


