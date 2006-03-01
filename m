Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWCARhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWCARhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWCARgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:36:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18384 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932390AbWCARgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:36:42 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/5] NFS: Add dentry materialisation op [try #2]
Date: Wed, 01 Mar 2006 17:36:29 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060301173629.16639.74630.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
References: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a new directory cache management function that prepares
a disconnected anonymous function to be connected into the dentry tree. The
anonymous dentry is transferred the name and parentage from another dentry.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c            |   25 +++++++++++++++++++++++++
 include/linux/dcache.h |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a173bba..97e1e44 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1345,6 +1345,30 @@ already_unhashed:
 }
 
 /**
+ * d_materialise_dentry - connect a disconnected dentry into the tree
+ * @dentry: dentry to replace
+ * @anon: dentry to place into the tree
+ *
+ * Prepare an anonymous dentry for life in the superblock's dentry tree as a
+ * named dentry in place of the dentry to be replaced.
+ */
+void d_materialise_dentry(struct dentry *dentry, struct dentry *anon)
+{
+	struct dentry *dparent, *aparent;
+
+	switch_names(dentry, anon);
+	do_switch(dentry->d_name.len, anon->d_name.len);
+	do_switch(dentry->d_name.hash, anon->d_name.hash);
+
+	dparent = dentry->d_parent;
+	aparent = anon->d_parent;
+	dentry->d_parent = (aparent == anon) ? dentry : aparent;
+	anon->d_parent = (dparent == dentry) ? anon : dparent;
+
+	anon->d_flags &= ~DCACHE_DISCONNECTED;
+}
+
+/**
  * d_path - return the path of a dentry
  * @dentry: dentry to report
  * @vfsmnt: vfsmnt to which the dentry belongs
@@ -1755,6 +1779,7 @@ EXPORT_SYMBOL(d_instantiate);
 EXPORT_SYMBOL(d_invalidate);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_move);
+EXPORT_SYMBOL_GPL(d_materialise_dentry);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(d_prune_aliases);
 EXPORT_SYMBOL(d_rehash);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4361f37..feb9d4b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ static inline int dname_external(struct 
 extern void d_instantiate(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern void d_delete(struct dentry *);
+extern void d_materialise_dentry(struct dentry *, struct dentry *);
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);

