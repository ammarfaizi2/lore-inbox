Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWCCLae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWCCLae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCCLae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:30:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751229AbWCCLad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:30:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/5] Optimise d_find_alias()
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 11:30:08 +0000
Message-ID: <25676.1141385408@warthog.cambridge.redhat.com>
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

 fs/dcache.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 97e1e44..e7613d3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -325,10 +325,12 @@ static struct dentry * __d_find_alias(st
 
 struct dentry * d_find_alias(struct inode *inode)
 {
-	struct dentry *de;
-	spin_lock(&dcache_lock);
-	de = __d_find_alias(inode, 0);
-	spin_unlock(&dcache_lock);
+	struct dentry *de = NULL;
+	if (!list_empty(&inode->i_dentry)) {
+		spin_lock(&dcache_lock);
+		de = __d_find_alias(inode, 0);
+		spin_unlock(&dcache_lock);
+	}
 	return de;
 }
 
