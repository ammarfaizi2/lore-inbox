Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVFQSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVFQSFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVFQSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:05:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262037AbVFQSE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:04:56 -0400
Date: Fri, 17 Jun 2005 11:07:20 -0700
From: Nick Wilson <njw@osdl.org>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: fix client oops when debugging is on
Message-ID: <20050617180720.GB21143@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nfs_readpage_release() causes an oops while accessing a file with NFS
debugging turned on (echo 32767 > /proc/sys/sunrpc/nfs_debug) and a
kernel built with CONFIG_DEBUG_SLAB.

This patch moves the debugging statement above nfs_release_request() to
avoid accessing freed memory.

Signed-off-by: Nick Wilson <njw@osdl.org>
---

 fs/nfs/read.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc6-dev.orig/fs/nfs/read.c	2005-06-16 20:34:30.000000000 -0700
+++ linux-2.6.12-rc6-dev/fs/nfs/read.c	2005-06-16 21:42:40.000000000 -0700
@@ -183,15 +183,15 @@ static void nfs_readpage_release(struct 
 {
 	unlock_page(req->wb_page);
 
-	nfs_clear_request(req);
-	nfs_release_request(req);
-	nfs_unlock_request(req);
-
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",
 			req->wb_context->dentry->d_inode->i_sb->s_id,
 			(long long)NFS_FILEID(req->wb_context->dentry->d_inode),
 			req->wb_bytes,
 			(long long)req_offset(req));
+
+	nfs_clear_request(req);
+	nfs_release_request(req);
+	nfs_unlock_request(req);
 }
 
 /*
_
