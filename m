Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWCHUax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWCHUax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWCHUav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:30:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750855AbWCHUap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:30:45 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/6] Optimise d_find_alias() [try #7]
Date: Wed, 08 Mar 2006 20:30:31 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060308203031.25493.43777.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch optimises d_find_alias() to only take the spinlock if
there's anything in the the inode's alias list. If there isn't, it returns NULL
immediately.

The following changes were made in [try #7]:

 (*) The memory barrier was removed.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9eb2698..bb309f5 100644
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
 

