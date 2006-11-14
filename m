Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966325AbWKNUKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966325AbWKNUKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966307AbWKNUJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966306AbWKNUJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:23 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/19] CacheFiles: Use the VFS wrappers for inode ops
Date: Tue, 14 Nov 2006 20:06:58 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200658.12943.87850.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CacheFiles use the appropriate VFS wrappers for inode operations (such as
vfs_mkdir()) rather than calling through the ops table directly.  This was
being done to bypass security, but now that the cachefiles module has its own
security label and the means to act as that on behalf of another process, this
is no longer necessary.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c      |    2 +
 fs/cachefiles/cf-interface.c |    3 +-
 fs/cachefiles/cf-namei.c     |   44 +++++-------------------------
 fs/cachefiles/cf-security.c  |    9 ++----
 fs/cachefiles/cf-xattr.c     |   61 ++++++++++++------------------------------
 5 files changed, 31 insertions(+), 88 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 0ac3a6b..1d1fd14 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -151,7 +151,7 @@ static int cachefiles_daemon_add_cache(s
 		goto error_unsupported;
 
 	/* get the cache size and blocksize */
-	ret = root->d_sb->s_op->statfs(root, &stats);
+	ret = vfs_statfs(root, &stats);
 	if (ret < 0)
 		goto error_unsupported;
 
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index f467058..7a3d085 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -355,10 +355,11 @@ int cachefiles_has_space(struct cachefil
 	/* find out how many pages of blockdev are available */
 	memset(&stats, 0, sizeof(stats));
 
-	ret = cache->mnt->mnt_sb->s_op->statfs(cache->mnt->mnt_root, &stats);
+	ret = vfs_statfs(cache->mnt->mnt_root, &stats);
 	if (ret < 0) {
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "statfs failed");
+		_leave(" = %d", ret);
 		return ret;
 	}
 
diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 80c9b66..5508fa2 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -72,7 +72,6 @@ static int cachefiles_bury_object(struct
 {
 	struct dentry *grave, *alt, *trap;
 	struct qstr name;
-	const char *old_name;
 	char nbuffer[8 + 8 + 1];
 	int ret;
 
@@ -83,16 +82,12 @@ static int cachefiles_bury_object(struct
 	/* non-directories can just be unlinked */
 	if (!S_ISDIR(rep->d_inode->i_mode)) {
 		_debug("unlink stale object");
-		ret = dir->d_inode->i_op->unlink(dir->d_inode, rep);
+		ret = vfs_unlink(dir->d_inode, rep);
 
 		mutex_unlock(&dir->d_inode->i_mutex);
 
-		if (ret == 0) {
-			_debug("d_delete");
-			d_delete(rep);
-		} else if (ret == -EIO) {
+		if (ret == -EIO)
 			cachefiles_io_error(cache, "Unlink failed");
-		}
 
 		_leave(" = %d", ret);
 		return ret;
@@ -213,24 +208,9 @@ try_again:
 	}
 
 	/* attempt the rename */
-	DQUOT_INIT(dir->d_inode);
-	DQUOT_INIT(cache->graveyard->d_inode);
-
-	old_name = fsnotify_oldname_init(rep->d_name.name);
-
-	ret = dir->d_inode->i_op->rename(dir->d_inode, rep,
-					 cache->graveyard->d_inode, grave);
-
-	if (ret == 0) {
-		d_move(rep, grave);
-		fsnotify_move(dir->d_inode, cache->graveyard->d_inode,
-			      old_name, rep->d_name.name, 1,
-			      grave->d_inode, rep->d_inode);
-	} else if (ret != -ENOMEM) {
+	ret = vfs_rename(dir->d_inode, rep, cache->graveyard->d_inode, grave);
+	if (ret != -ENOMEM)
 		cachefiles_io_error(cache, "Rename failed with error %d", ret);
-	}
-
-	fsnotify_oldname_free(old_name);
 
 	unlock_rename(cache->graveyard, dir);
 	dput(grave);
@@ -372,15 +352,12 @@ lookup_again:
 			if (ret < 0)
 				goto create_error;
 
-			DQUOT_INIT(dir->d_inode);
-			ret = dir->d_inode->i_op->mkdir(dir->d_inode, next, 0);
+			ret = vfs_mkdir(dir->d_inode, next, 0);
 			if (ret < 0)
 				goto create_error;
 
 			ASSERT(next->d_inode);
 
-			fsnotify_mkdir(dir->d_inode, next);
-
 			_debug("mkdir -> %p{%p{ino=%lu}}",
 			       next, next->d_inode, next->d_inode->i_ino);
 
@@ -398,16 +375,12 @@ lookup_again:
 			if (ret < 0)
 				goto create_error;
 
-			DQUOT_INIT(dir->d_inode);
-			ret = dir->d_inode->i_op->create(dir->d_inode, next,
-							 S_IFREG, NULL);
+			ret = vfs_create(dir->d_inode, next, S_IFREG, NULL);
 			if (ret < 0)
 				goto create_error;
 
 			ASSERT(next->d_inode);
 
-			fsnotify_create(dir->d_inode, next);
-
 			_debug("create -> %p{%p{ino=%lu}}",
 			       next, next->d_inode, next->d_inode->i_ino);
 
@@ -605,15 +578,12 @@ struct dentry *cachefiles_get_directory(
 		if (ret < 0)
 			goto mkdir_error;
 
-		DQUOT_INIT(dir->d_inode);
-		ret = dir->d_inode->i_op->mkdir(dir->d_inode, subdir, 0700);
+		ret = vfs_mkdir(dir->d_inode, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
 
 		ASSERT(subdir->d_inode);
 
-		fsnotify_mkdir(dir->d_inode, subdir);
-
 		_debug("mkdir -> %p{%p{ino=%lu}}",
 		       subdir,
 		       subdir->d_inode,
diff --git a/fs/cachefiles/cf-security.c b/fs/cachefiles/cf-security.c
index 4c5f052..d7c1473 100644
--- a/fs/cachefiles/cf-security.c
+++ b/fs/cachefiles/cf-security.c
@@ -60,6 +60,7 @@ error:
 
 /*
  * check the security details of the on-disk cache
+ * - must be called with security imposed
  */
 int cachefiles_check_security(struct cachefiles_cache *cache,
 			      struct dentry *root)
@@ -82,14 +83,12 @@ int cachefiles_check_security(struct cac
 
 	/* check that we have permission to create files and directories with
 	 * the security ID we've been given */
-	security_act_as_secid(cache->access_sid);
-
 	ret = security_inode_mkdir(root->d_inode, root, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "CacheFiles:"
 		       " Security denies permission to make dirs: error %d",
 		       ret);
-		goto error2;
+		goto error;
 	}
 
 	ret = security_inode_create(root->d_inode, root, 0);
@@ -97,11 +96,9 @@ int cachefiles_check_security(struct cac
 		printk(KERN_ERR "CacheFiles:"
 		       " Security denies permission to create files: error %d",
 		       ret);
-		goto error2;
+		goto error;
 	}
 
-error2:
-	security_act_as_self();
 error:
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
diff --git a/fs/cachefiles/cf-xattr.c b/fs/cachefiles/cf-xattr.c
index 5017715..209b813 100644
--- a/fs/cachefiles/cf-xattr.c
+++ b/fs/cachefiles/cf-xattr.c
@@ -32,9 +32,6 @@ int cachefiles_check_object_type(struct 
 
 	ASSERT(dentry);
 	ASSERT(dentry->d_inode);
-	ASSERT(dentry->d_inode->i_op);
-	ASSERT(dentry->d_inode->i_op->setxattr);
-	ASSERT(dentry->d_inode->i_op->getxattr);
 
 	if (!object->fscache.cookie)
 		strcpy(type, "C3");
@@ -43,14 +40,11 @@ int cachefiles_check_object_type(struct 
 
 	_enter("%p{%s}", object, type);
 
-	mutex_lock(&dentry->d_inode->i_mutex);
-
 	/* attempt to install a type label directly */
-	ret = dentry->d_inode->i_op->setxattr(dentry, cachefiles_xattr_cache,
-					      type, 2, XATTR_CREATE);
+	ret = vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
+			   XATTR_CREATE);
 	if (ret == 0) {
 		_debug("SET"); /* we succeeded */
-		fsnotify_xattr(dentry);
 		goto error;
 	}
 
@@ -63,8 +57,7 @@ int cachefiles_check_object_type(struct 
 	}
 
 	/* read the current type label */
-	ret = dentry->d_inode->i_op->getxattr(dentry, cachefiles_xattr_cache,
-					      xtype, 3);
+	ret = vfs_getxattr(dentry, cachefiles_xattr_cache, xtype, 3);
 	if (ret < 0) {
 		if (ret == -ERANGE)
 			goto bad_type_length;
@@ -86,7 +79,6 @@ int cachefiles_check_object_type(struct 
 	ret = 0;
 
 error:
-	mutex_unlock(&dentry->d_inode->i_mutex);
 	_leave(" = %d", ret);
 	return ret;
 
@@ -117,26 +109,22 @@ int cachefiles_set_object_xattr(struct c
 
 	ASSERT(object->fscache.cookie);
 	ASSERT(dentry);
-	ASSERT(dentry->d_inode->i_op->setxattr);
 
 	_enter("%p,#%d", object, auxdata->len);
 
 	/* attempt to install the cache metadata directly */
-	mutex_lock(&dentry->d_inode->i_mutex);
-
 	_debug("SET %s #%u", object->fscache.cookie->def->name, auxdata->len);
 
-	ret = dentry->d_inode->i_op->setxattr(dentry, cachefiles_xattr_cache,
-					      &auxdata->type, auxdata->len,
-					      XATTR_CREATE);
-	if (ret == 0)
-		fsnotify_xattr(dentry);
-	else if (ret != -ENOMEM)
-		cachefiles_io_error_obj(object,
-					"Failed to set xattr with error %d",
-					ret);
+	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
+			   &auxdata->type, auxdata->len,
+			   XATTR_CREATE);
+	if (ret < 0) {
+		if (ret != -ENOMEM)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to set xattr with error %d", ret);
+	}
 
-	mutex_unlock(&dentry->d_inode->i_mutex);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -156,8 +144,6 @@ int cachefiles_check_object_xattr(struct
 
 	ASSERT(dentry);
 	ASSERT(dentry->d_inode);
-	ASSERT(dentry->d_inode->i_op->setxattr);
-	ASSERT(dentry->d_inode->i_op->getxattr);
 
 	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, GFP_KERNEL);
 	if (!auxbuf) {
@@ -165,11 +151,9 @@ int cachefiles_check_object_xattr(struct
 		return -ENOMEM;
 	}
 
-	mutex_lock(&dentry->d_inode->i_mutex);
-
 	/* read the current type label */
-	ret = dentry->d_inode->i_op->getxattr(dentry, cachefiles_xattr_cache,
-					      &auxbuf->type, 512 + 1);
+	ret = vfs_getxattr(dentry, cachefiles_xattr_cache,
+			   &auxbuf->type, 512 + 1);
 	if (ret < 0) {
 		if (ret == -ENODATA)
 			goto stale; /* no attribute - power went off
@@ -225,11 +209,9 @@ int cachefiles_check_object_xattr(struct
 		}
 
 		/* update the current label */
-		ret = dentry->d_inode->i_op->setxattr(dentry,
-						      cachefiles_xattr_cache,
-						      &auxdata->type,
-						      auxdata->len,
-						      XATTR_REPLACE);
+		ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
+				   &auxdata->type, auxdata->len,
+				   XATTR_REPLACE);
 		if (ret < 0) {
 			cachefiles_io_error_obj(object,
 						"Can't update xattr on %lu"
@@ -243,7 +225,6 @@ okay:
 	ret = 0;
 
 error:
-	mutex_unlock(&dentry->d_inode->i_mutex);
 	kfree(auxbuf);
 	_leave(" = %d", ret);
 	return ret;
@@ -267,13 +248,7 @@ int cachefiles_remove_object_xattr(struc
 {
 	int ret;
 
-	mutex_lock(&dentry->d_inode->i_mutex);
-
-	ret = dentry->d_inode->i_op->removexattr(dentry,
-						 cachefiles_xattr_cache);
-
-	mutex_unlock(&dentry->d_inode->i_mutex);
-
+	ret = vfs_removexattr(dentry, cachefiles_xattr_cache);
 	if (ret < 0) {
 		if (ret == -ENOENT || ret == -ENODATA)
 			ret = 0;
