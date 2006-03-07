Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWCGLeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWCGLeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWCGLen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:34:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752169AbWCGLeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:34:19 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/6] Optimise d_find_alias() [try #6]
Date: Tue, 07 Mar 2006 11:34:04 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com>
References: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch optimises d_find_alias() to only take the spinlock if
there's anything in the the inode's alias list. If there isn't, it returns NULL
immediately.

With respect to the superblock sharing patch, this should reduce by one the
number of times the dcache_lock is taken by nfs_lookup() for ordinary
directory lookups.

Only in the case where there's already a dentry for particular directory inode
(such as might happen when another mountpoint is rooted at that dentry) will
the lock then be taken the extra time.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 97e1e44..32051ba 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -325,10 +325,13 @@ static struct dentry * __d_find_alias(st
 
 struct dentry * d_find_alias(struct inode *inode)
 {
-	struct dentry *de;
-	spin_lock(&dcache_lock);
-	de = __d_find_alias(inode, 0);
-	spin_unlock(&dcache_lock);
+	struct dentry *de = NULL;
+	smp_rmb();
+	if (!list_empty(&inode->i_dentry)) {
+		spin_lock(&dcache_lock);
+		de = __d_find_alias(inode, 0);
+		spin_unlock(&dcache_lock);
+	}
 	return de;
 }
 

