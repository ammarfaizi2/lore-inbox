Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWBHGql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWBHGql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBHGnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30082 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161026AbWBHGnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:39 -0500
Message-Id: <20060208064852.371401000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Drokin <green@linuxhacker.ru>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/23] [PATCH] d_instantiate_unique / NFS inode leakage
Content-Disposition: inline; filename=d_instantiate_unique-nfs-inode-leakage.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

If we have found aliased dentry that we return, inode reference is not
dropped and inode is not attached anywhere, so it seems the reference to
inode is leaked in that case.

Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
Cc: <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/dcache.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.15.3/fs/dcache.c
===================================================================
--- linux-2.6.15.3.orig/fs/dcache.c
+++ linux-2.6.15.3/fs/dcache.c
@@ -808,10 +808,14 @@ void d_instantiate(struct dentry *entry,
  *
  * Fill in inode information in the entry. On success, it returns NULL.
  * If an unhashed alias of "entry" already exists, then we return the
- * aliased dentry instead.
+ * aliased dentry instead and drop one reference to inode.
  *
  * Note that in order to avoid conflicts with rename() etc, the caller
  * had better be holding the parent directory semaphore.
+ *
+ * This also assumes that the inode count has been incremented
+ * (or otherwise set) by the caller to indicate that it is now
+ * in use by the dcache.
  */
 struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
 {
@@ -838,6 +842,7 @@ struct dentry *d_instantiate_unique(stru
 		dget_locked(alias);
 		spin_unlock(&dcache_lock);
 		BUG_ON(!d_unhashed(alias));
+		iput(inode);
 		return alias;
 	}
 	list_add(&entry->d_alias, &inode->i_dentry);

--
