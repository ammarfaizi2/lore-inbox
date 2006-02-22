Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWBVUWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWBVUWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWBVUWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422660AbWBVUWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:10 -0500
Date: Wed, 22 Feb 2006 20:21:46 GMT
Message-Id: <200602222021.k1MKLkm4028349@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-fsdevel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 4/5] NFS: Add dentry materialisation op
In-Reply-To: <dhowells1140639702@warthog.cambridge.redhat.com>
References: <dhowells1140639702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a new directory cache management function that prepares
a disconnected anonymous function to be connected into the dentry tree. The
anonymous dentry is transferred the name and parentage from another dentry.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 materialise-dentry-2616rc4.diff
 fs/dcache.c            |   18 ++++++++++++++++++
 include/linux/dcache.h |    1 +
 2 files changed, 19 insertions(+)

diff -uNrp linux-2.6.16-rc4-getsb/include/linux/dcache.h linux-2.6.16-rc4-getsb-nfs/include/linux/dcache.h
--- linux-2.6.16-rc4-getsb/include/linux/dcache.h	2006-02-22 17:00:41.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/include/linux/dcache.h	2006-02-22 17:34:57.000000000 +0000
@@ -208,6 +208,7 @@ static inline int dname_external(struct 
 extern void d_instantiate(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern void d_delete(struct dentry *);
+extern void d_materialise_dentry(struct dentry *, struct dentry *);
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
diff -uNrp linux-2.6.16-rc4-getsb/fs/dcache.c linux-2.6.16-rc4-getsb-nfs/fs/dcache.c
--- linux-2.6.16-rc4-getsb/fs/dcache.c	2006-02-22 17:00:36.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/dcache.c	2006-02-22 17:34:57.000000000 +0000
@@ -1345,6 +1345,23 @@ already_unhashed:
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
+	switch_names(dentry, anon);
+	do_switch(dentry->d_name.len, anon->d_name.len);
+	do_switch(dentry->d_name.hash, anon->d_name.hash);
+	do_switch(dentry->d_parent, anon->d_parent);
+	anon->d_flags &= ~DCACHE_DISCONNECTED;
+}
+
+/**
  * d_path - return the path of a dentry
  * @dentry: dentry to report
  * @vfsmnt: vfsmnt to which the dentry belongs
@@ -1755,6 +1772,7 @@ EXPORT_SYMBOL(d_instantiate);
 EXPORT_SYMBOL(d_invalidate);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_move);
+EXPORT_SYMBOL_GPL(d_materialise_dentry);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(d_prune_aliases);
 EXPORT_SYMBOL(d_rehash);
