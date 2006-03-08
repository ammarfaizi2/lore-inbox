Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWCHUbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCHUbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWCHUbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:31:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39845 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751003AbWCHUar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:30:47 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/6] 9p: Fix error handling on superblock alloc failure [try #7]
Date: Wed, 08 Mar 2006 20:30:21 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060308203021.25493.85005.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds error handling and cleanup in the case that sget()
fails, lest a memory leak occur.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/9p/vfs_super.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index bca1efb..17dee27 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -134,8 +134,11 @@ static int v9fs_get_sb(struct file_syste
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		v9fs_session_close(v9ses);
+		kfree(v9ses);
 		return PTR_ERR(sb);
+	}
 
 	v9fs_fill_super(sb, v9ses, flags);
 

