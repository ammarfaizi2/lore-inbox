Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936312AbWLDMpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936312AbWLDMpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936275AbWLDMoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:44:46 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:56286 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936312AbWLDMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:01 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 13/35] lookup_one_len_nd - lookup_one_len with nameidata argument
Date: Mon,  4 Dec 2006 07:30:46 -0500
Message-Id: <11652354701586-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
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
index 8a7b923..76de391 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1290,8 +1290,8 @@ static struct dentry *lookup_hash(struct
 	return __lookup_hash(&nd->last, nd->dentry, nd);
 }
 
-/* SMP-safe */
-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+struct dentry * lookup_one_len_nd(const char *name, struct dentry * base,
+				  int len, struct nameidata *nd)
 {
 	unsigned long hash;
 	struct qstr this;
@@ -1311,7 +1311,7 @@ struct dentry * lookup_one_len(const cha
 	}
 	this.hash = end_name_hash(hash);
 
-	return __lookup_hash(&this, base, NULL);
+	return __lookup_hash(&this, base, nd);
 access:
 	return ERR_PTR(-EACCES);
 }
@@ -2756,7 +2756,7 @@ EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(lookup_one_len_nd);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
 EXPORT_SYMBOL(page_readlink);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index d39a5a6..8551806 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,7 +81,15 @@ extern struct file *lookup_instantiate_f
 extern struct file *nameidata_to_filp(struct nameidata *nd, int flags);
 extern void release_open_intent(struct nameidata *);
 
-extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry * lookup_one_len_nd(const char *,
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
1.4.3.3

