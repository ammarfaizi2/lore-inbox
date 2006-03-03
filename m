Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWCCKuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWCCKuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWCCKuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:50:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52610 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751121AbWCCKuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:50:07 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/5] 9p: Fix error handling on superblock alloc failure
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 10:49:49 +0000
Message-ID: <19741.1141382989@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds error handling and cleanup in the case that sget()
fails, lest a memory leak occur.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/9p/vfs_super.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index aedc97b..17dee27 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -135,7 +135,8 @@ static int v9fs_get_sb(struct file_syste
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
 	if (IS_ERR(sb)) {
-#error this should have error handling in case sget() fails
+		v9fs_session_close(v9ses);
+		kfree(v9ses);
 		return PTR_ERR(sb);
 	}
 
