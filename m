Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWHNVQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWHNVQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWHNVQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:16:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964880AbWHNVPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:15:25 -0400
From: David Howells <dhowells@redhat.com>
Subject: [RHEL5 PATCH 4/4] VFS: Fix 64-bit ino_t warning in CacheFiles facility
Date: Mon, 14 Aug 2006 22:15:14 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#,
       dhowells@redhat.com
Message-Id: <20060814211514.27190.90014.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the print format warnings that occur in CacheFiles when ino_t is made
unsigned long long.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-interface.c |    2 +-
 fs/cachefiles/cf-namei.c     |   14 +++++++-------
 fs/cachefiles/cf-xattr.c     |   16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index b5ca30f..37d8973 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -428,7 +428,7 @@ void cachefiles_read_copier_work(void *_
 	struct pagevec pagevec;
 	int error, max;
 
-	_enter("{ino=%lu}", object->backer->d_inode->i_ino);
+	_enter("{ino=%llu}", object->backer->d_inode->i_ino);
 
 	pagevec_init(&pagevec, 0);
 
diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 20db88a..76bf637 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -382,11 +382,11 @@ lookup_again:
 
 			fsnotify_mkdir(dir->d_inode, next);
 
-			_debug("mkdir -> %p{%p{ino=%lu}}",
+			_debug("mkdir -> %p{%p{ino=%llu}}",
 			       next, next->d_inode, next->d_inode->i_ino);
 
 		} else if (!S_ISDIR(next->d_inode->i_mode)) {
-			kerror("inode %lu is not a directory",
+			kerror("inode %llu is not a directory",
 			       next->d_inode->i_ino);
 			ret = -ENOBUFS;
 			goto error;
@@ -405,13 +405,13 @@ lookup_again:
 
 			fsnotify_create(dir->d_inode, next);
 
-			_debug("create -> %p{%p{ino=%lu}}",
+			_debug("create -> %p{%p{ino=%llu}}",
 			       next, next->d_inode, next->d_inode->i_ino);
 
 		} else if (!S_ISDIR(next->d_inode->i_mode) &&
 			   !S_ISREG(next->d_inode->i_mode)
 			   ) {
-			kerror("inode %lu is not a file or directory",
+			kerror("inode %llu is not a file or directory",
 			       next->d_inode->i_ino);
 			ret = -ENOBUFS;
 			goto error;
@@ -497,7 +497,7 @@ lookup_again:
 	current->fsgid = fsgid;
 	object->new = 0;
 
-	_leave(" = 0 [%lu]", object->dentry->d_inode->i_ino);
+	_leave(" = 0 [%llu]", object->dentry->d_inode->i_ino);
 	return 0;
 
 create_error:
@@ -615,7 +615,7 @@ struct dentry *cachefiles_get_directory(
 
 		fsnotify_mkdir(dir->d_inode, subdir);
 
-		_debug("mkdir -> %p{%p{ino=%lu}}",
+		_debug("mkdir -> %p{%p{ino=%llu}}",
 		       subdir,
 		       subdir->d_inode,
 		       subdir->d_inode->i_ino);
@@ -647,7 +647,7 @@ struct dentry *cachefiles_get_directory(
 	    !subdir->d_inode->i_op->unlink)
 		goto check_error;
 
-	_leave(" = [%lu]", subdir->d_inode->i_ino);
+	_leave(" = [%llu]", subdir->d_inode->i_ino);
 	return subdir;
 
 check_error:
diff --git a/fs/cachefiles/cf-xattr.c b/fs/cachefiles/cf-xattr.c
index 8952bf0..1baf4c8 100644
--- a/fs/cachefiles/cf-xattr.c
+++ b/fs/cachefiles/cf-xattr.c
@@ -57,7 +57,7 @@ int cachefiles_check_object_type(struct 
 	}
 
 	if (ret != -EEXIST) {
-		kerror("Can't set xattr on %*.*s [%lu] (err %d)",
+		kerror("Can't set xattr on %*.*s [%llu] (err %d)",
 		       dentry->d_name.len, dentry->d_name.len,
 		       dentry->d_name.name, dentry->d_inode->i_ino,
 		       -ret);
@@ -71,7 +71,7 @@ int cachefiles_check_object_type(struct 
 		if (ret == -ERANGE)
 			goto bad_type_length;
 
-		kerror("Can't read xattr on %*.*s [%lu] (err %d)",
+		kerror("Can't read xattr on %*.*s [%llu] (err %d)",
 		       dentry->d_name.len, dentry->d_name.len,
 		       dentry->d_name.name, dentry->d_inode->i_ino,
 		       -ret);
@@ -93,14 +93,14 @@ error:
 	return ret;
 
 bad_type_length:
-	kerror("Cache object %lu type xattr length incorrect",
+	kerror("Cache object %llu type xattr length incorrect",
 	       dentry->d_inode->i_ino);
 	ret = -EIO;
 	goto error;
 
 bad_type:
 	xtype[2] = 0;
-	kerror("Cache object %*.*s [%lu] type %s not %s",
+	kerror("Cache object %*.*s [%llu] type %s not %s",
 	       dentry->d_name.len, dentry->d_name.len,
 	       dentry->d_name.name, dentry->d_inode->i_ino,
 	       xtype, type);
@@ -184,7 +184,7 @@ int cachefiles_check_object_xattr(struct
 			goto bad_type_length;
 
 		cachefiles_io_error_obj(object,
-					"can't read xattr on %lu (err %d)",
+					"can't read xattr on %llu (err %d)",
 					dentry->d_inode->i_ino, -ret);
 		goto error;
 	}
@@ -237,7 +237,7 @@ int cachefiles_check_object_xattr(struct
 						      XATTR_REPLACE);
 		if (ret < 0) {
 			cachefiles_io_error_obj(object,
-						"Can't update xattr on %lu"
+						"Can't update xattr on %llu"
 						" (error %d)",
 						dentry->d_inode->i_ino, -ret);
 			goto error;
@@ -254,7 +254,7 @@ error:
 	return ret;
 
 bad_type_length:
-	kerror("Cache object %lu xattr length incorrect",
+	kerror("Cache object %llu xattr length incorrect",
 	       dentry->d_inode->i_ino);
 	ret = -EIO;
 	goto error;
@@ -285,7 +285,7 @@ int cachefiles_remove_object_xattr(struc
 			ret = 0;
 		else if (ret != -ENOMEM)
 			cachefiles_io_error(cache,
-					    "Can't remove xattr from %lu"
+					    "Can't remove xattr from %llu"
 					    " (error %d)",
 					    dentry->d_inode->i_ino, -ret);
 	}
