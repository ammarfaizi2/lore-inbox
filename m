Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWJGGCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWJGGCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWJGFy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:54:57 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53424 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932584AbWJGFyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:54:53 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 23] lookup_one_len_nd - lookup_one_len with nameidata
	argument
Message-Id: <3104d077379c19c98510.1160197641@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:21 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch renames lookup_one_len to lookup_one_len_nd, and adds a nameidata
argument. An inline function, lookup_one_len (which calls lookup_one_len_nd
with nd == NULL) preserves original behavior.

The following Unionfs patches depend on this one.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 10 insertions(+), 5 deletions(-)
fs/namei.c            |    7 +++----
include/linux/namei.h |    8 +++++++-

diff -r 45185d249694 -r 3104d077379c fs/namei.c
--- a/fs/namei.c	Sat Oct 07 00:46:18 2006 -0400
+++ b/fs/namei.c	Sat Oct 07 00:46:18 2006 -0400
@@ -1295,8 +1295,7 @@ static struct dentry *lookup_hash(struct
 	return __lookup_hash(&nd->last, nd->dentry, nd);
 }
 
-/* SMP-safe */
-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+struct dentry * lookup_one_len_nd(const char *name, struct dentry * base, int len, struct nameidata *nd)
 {
 	unsigned long hash;
 	struct qstr this;
@@ -1316,7 +1315,7 @@ struct dentry * lookup_one_len(const cha
 	}
 	this.hash = end_name_hash(hash);
 
-	return __lookup_hash(&this, base, NULL);
+	return __lookup_hash(&this, base, nd);
 access:
 	return ERR_PTR(-EACCES);
 }
@@ -2761,7 +2760,7 @@ EXPORT_SYMBOL(get_write_access); /* binf
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(lookup_one_len_nd);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
 EXPORT_SYMBOL(page_readlink);
diff -r 45185d249694 -r 3104d077379c include/linux/namei.h
--- a/include/linux/namei.h	Sat Oct 07 00:46:18 2006 -0400
+++ b/include/linux/namei.h	Sat Oct 07 00:46:18 2006 -0400
@@ -76,7 +76,13 @@ extern struct file *nameidata_to_filp(st
 extern struct file *nameidata_to_filp(struct nameidata *nd, int flags);
 extern void release_open_intent(struct nameidata *);
 
-extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry * lookup_one_len_nd(const char *, struct dentry *, int, struct nameidata *);
+
+/* SMP-safe */
+static inline struct dentry *lookup_one_len(const char *name, struct dentry *dir, int len)
+{
+	return lookup_one_len_nd(name, dir, len, NULL);
+}
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);


