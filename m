Return-Path: <linux-kernel-owner+w=401wt.eu-S1030524AbXAHEVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbXAHEVD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbXAHEU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:20:59 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50471 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030532AbXAHETd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:19:33 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 02/24] lookup_one_len_nd - lookup_one_len with nameidata argument
Date: Sun,  7 Jan 2007 23:12:54 -0500
Message-Id: <1168229596433-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch renames lookup_one_len to lookup_one_len_nd, and adds a nameidata
argument. An inline function, lookup_one_len (which calls lookup_one_len_nd
with nd == NULL) preserves original behavior.

The following Unionfs patches depend on this one.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---
 fs/namei.c            |    8 ++++----
 include/linux/namei.h |   10 +++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e4f108f..5a2e89a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1292,8 +1292,8 @@ static struct dentry *lookup_hash(struct nameidata *nd)
 	return __lookup_hash(&nd->last, nd->dentry, nd);
 }
 
-/* SMP-safe */
-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+struct dentry *lookup_one_len_nd(const char *name, struct dentry *base,
+				  int len, struct nameidata *nd)
 {
 	unsigned long hash;
 	struct qstr this;
@@ -1313,7 +1313,7 @@ struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
 	}
 	this.hash = end_name_hash(hash);
 
-	return __lookup_hash(&this, base, NULL);
+	return __lookup_hash(&this, base, nd);
 access:
 	return ERR_PTR(-EACCES);
 }
@@ -2757,7 +2757,7 @@ EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(lookup_one_len_nd);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
 EXPORT_SYMBOL(page_readlink);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index d39a5a6..941be96 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,7 +81,15 @@ extern struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry
 extern struct file *nameidata_to_filp(struct nameidata *nd, int flags);
 extern void release_open_intent(struct nameidata *);
 
-extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len_nd(const char *,
+			struct dentry *, int, struct nameidata *);
+
+/* SMP-safe */
+static inline struct dentry *lookup_one_len(const char *name,
+			struct dentry *dir, int len)
+{
+	return lookup_one_len_nd(name, dir, len, NULL);
+}
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
-- 
1.4.4.2

