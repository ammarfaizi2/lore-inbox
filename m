Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966309AbWKNUM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966309AbWKNUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966315AbWKNUJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966312AbWKNUJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:16 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 18/19] CacheFiles: Use VFS lookup services
Date: Tue, 14 Nov 2006 20:07:00 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200700.12943.92679.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CacheFiles use the VFS's lookup services for each step of path resolution
rather than doing the hashing, dcache lookup and calling the inode lookup op
itself.

This is possible now that CacheFiles can temporarily override the security
context set by SELinux.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-namei.c |  224 +++++++---------------------------------------
 1 files changed, 34 insertions(+), 190 deletions(-)

diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 5508fa2..a3df94a 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -70,8 +70,7 @@ static int cachefiles_bury_object(struct
 				  struct dentry *dir,
 				  struct dentry *rep)
 {
-	struct dentry *grave, *alt, *trap;
-	struct qstr name;
+	struct dentry *grave, *trap;
 	char nbuffer[8 + 8 + 1];
 	int ret;
 
@@ -103,23 +102,6 @@ try_again:
 		(uint32_t) xtime.tv_sec,
 		(uint32_t) atomic_inc_return(&cache->gravecounter));
 
-	name.name = nbuffer;
-	name.len = strlen(name.name);
-
-	/* hash the name */
-	name.hash = full_name_hash(name.name, name.len);
-
-	if (dir->d_op && dir->d_op->d_hash) {
-		ret = dir->d_op->d_hash(dir, &name);
-		if (ret < 0) {
-			if (ret == -EIO)
-				cachefiles_io_error(cache, "Hash failed");
-
-			_leave(" = %d", ret);
-			return ret;
-		}
-	}
-
 	/* do the multiway lock magic */
 	trap = lock_rename(cache->graveyard, dir);
 
@@ -150,38 +132,18 @@ try_again:
 		return -EIO;
 	}
 
-	/* see if there's a dentry already there for this name */
-	grave = d_lookup(cache->graveyard, &name);
-	if (!grave) {
-		_debug("not found");
+	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	if (IS_ERR(grave)) {
+		unlock_rename(cache->graveyard, dir);
 
-		grave = d_alloc(cache->graveyard, &name);
-		if (!grave) {
-			unlock_rename(cache->graveyard, dir);
+		if (PTR_ERR(grave) == -ENOMEM) {
 			_leave(" = -ENOMEM");
 			return -ENOMEM;
 		}
 
-		alt = cache->graveyard->d_inode->i_op->lookup(
-			cache->graveyard->d_inode, grave, NULL);
-		if (IS_ERR(alt)) {
-			unlock_rename(cache->graveyard, dir);
-			dput(grave);
-
-			if (PTR_ERR(alt) == -ENOMEM) {
-				_leave(" = -ENOMEM");
-				return -ENOMEM;
-			}
-
-			cachefiles_io_error(cache, "Lookup error %ld",
-					    PTR_ERR(alt));
-			return -EIO;
-		}
-
-		if (alt) {
-			dput(grave);
-			grave = alt;
-		}
+		cachefiles_io_error(cache, "Lookup error %ld",
+				    PTR_ERR(grave));
+		return -EIO;
 	}
 
 	if (grave->d_inode) {
@@ -253,9 +215,9 @@ int cachefiles_walk_to_object(struct cac
 			      struct cachefiles_xattr *auxdata)
 {
 	struct cachefiles_cache *cache;
-	struct dentry *dir, *next = NULL, *new;
-	struct qstr name;
-	int ret;
+	struct dentry *dir, *next = NULL;
+	char *name;
+	int ret, nlen;
 
 	_enter("{%p}", parent->dentry);
 
@@ -275,69 +237,24 @@ int cachefiles_walk_to_object(struct cac
 
 advance:
 	/* attempt to transit the first directory component */
-	name.name = key;
+	name = key;
 	key = strchr(key, '/');
 	if (key) {
-		name.len = key - (char *) name.name;
+		nlen = key - name;
 		*key++ = 0;
 	} else {
-		name.len = strlen(name.name);
-	}
-
-	/* hash the name */
-	name.hash = full_name_hash(name.name, name.len);
-
-	if (dir->d_op && dir->d_op->d_hash) {
-		ret = dir->d_op->d_hash(dir, &name);
-		if (ret < 0) {
-			cachefiles_io_error(cache, "Hash failed");
-			goto error_out2;
-		}
+		nlen = strlen(name);
 	}
 
 lookup_again:
 	/* search the current directory for the element name */
-	_debug("lookup '%s' %x", name.name, name.hash);
+	_debug("lookup '%s'", name);
 
 	mutex_lock(&dir->d_inode->i_mutex);
 
-	next = d_lookup(dir, &name);
-	if (!next) {
-		_debug("not found");
-
-		new = d_alloc(dir, &name);
-		if (!new)
-			goto nomem_d_alloc;
-
-		ASSERT(dir->d_inode->i_op);
-		ASSERT(dir->d_inode->i_op->lookup);
-
-		next = dir->d_inode->i_op->lookup(dir->d_inode, new, NULL);
-		if (IS_ERR(next))
-			goto lookup_error;
-
-		if (!next)
-			next = new;
-		else
-			dput(new);
-
-		if (next->d_inode) {
-			ret = -EPERM;
-			if (!next->d_inode->i_op ||
-			    !next->d_inode->i_op->setxattr ||
-			    !next->d_inode->i_op->getxattr ||
-			    !next->d_inode->i_op->removexattr)
-				goto error;
-
-			if (key && (!next->d_inode->i_op->lookup ||
-				    !next->d_inode->i_op->mkdir ||
-				    !next->d_inode->i_op->create ||
-				    !next->d_inode->i_op->rename ||
-				    !next->d_inode->i_op->rmdir ||
-				    !next->d_inode->i_op->unlink))
-				goto error;
-		}
-	}
+	next = lookup_one_len(name, dir, nlen);
+	if (IS_ERR(next))
+		goto lookup_error;
 
 	_debug("next -> %p %s", next, next->d_inode ? "positive" : "negative");
 
@@ -496,15 +413,10 @@ delete_error:
 
 lookup_error:
 	_debug("lookup error %ld", PTR_ERR(next));
-	dput(new);
 	ret = PTR_ERR(next);
 	if (ret == -EIO)
 		cachefiles_io_error(cache, "Lookup failed");
 	next = NULL;
-	goto error;
-
-nomem_d_alloc:
-	ret = -ENOMEM;
 error:
 	mutex_unlock(&dir->d_inode->i_mutex);
 	dput(next);
@@ -525,48 +437,19 @@ struct dentry *cachefiles_get_directory(
 					struct dentry *dir,
 					const char *dirname)
 {
-	struct dentry *subdir, *new;
-	struct qstr name;
+	struct dentry *subdir;
 	int ret;
 
-	_enter("");
-
-	/* set up the name */
-	name.name = dirname;
-	name.len = strlen(dirname);
-	name.hash = full_name_hash(name.name, name.len);
-
-	if (dir->d_op && dir->d_op->d_hash) {
-		ret = dir->d_op->d_hash(dir, &name);
-		if (ret < 0) {
-			if (ret == -EIO)
-				kerror("Hash failed");
-			_leave(" = %d", ret);
-			return ERR_PTR(ret);
-		}
-	}
+	_enter(",,%s", dirname);
 
 	/* search the current directory for the element name */
-	_debug("lookup '%s' %x", name.name, name.hash);
-
 	mutex_lock(&dir->d_inode->i_mutex);
 
-	subdir = d_lookup(dir, &name);
-	if (!subdir) {
-		_debug("not found");
-
-		new = d_alloc(dir, &name);
-		if (!new)
+	subdir = lookup_one_len(dirname, dir, strlen(dirname));
+	if (IS_ERR(subdir)) {
+		if (PTR_ERR(subdir) == -ENOMEM)
 			goto nomem_d_alloc;
-
-		subdir = dir->d_inode->i_op->lookup(dir->d_inode, new, NULL);
-		if (IS_ERR(subdir))
-			goto lookup_error;
-
-		if (!subdir)
-			subdir = new;
-		else
-			dput(new);
+		goto lookup_error;
 	}
 
 	_debug("subdir -> %p %s",
@@ -578,6 +461,8 @@ struct dentry *cachefiles_get_directory(
 		if (ret < 0)
 			goto mkdir_error;
 
+		_debug("attempt mkdir");
+
 		ret = vfs_mkdir(dir->d_inode, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
@@ -625,23 +510,18 @@ mkdir_error:
 	mutex_unlock(&dir->d_inode->i_mutex);
 	dput(subdir);
 	kerror("mkdir %s failed with error %d", dirname, ret);
-	goto error_out;
+	return ERR_PTR(ret);
 
 lookup_error:
 	mutex_unlock(&dir->d_inode->i_mutex);
-	dput(new);
 	ret = PTR_ERR(subdir);
 	kerror("Lookup %s failed with error %d", dirname, ret);
-	goto error_out;
+	return ERR_PTR(ret);
 
 nomem_d_alloc:
 	mutex_unlock(&dir->d_inode->i_mutex);
-	ret = -ENOMEM;
-	goto error_out;
-
-error_out:
-	_leave(" = %d", ret);
-	return ERR_PTR(ret);
+	_leave(" = -ENOMEM");
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -653,48 +533,18 @@ int cachefiles_cull(struct cachefiles_ca
 {
 	struct cachefiles_object *object;
 	struct rb_node *_n;
-	struct dentry *victim, *new;
-	struct qstr name;
+	struct dentry *victim;
 	int ret;
 
 	_enter(",%*.*s/,%s",
 	       dir->d_name.len, dir->d_name.len, dir->d_name.name, filename);
 
-	/* set up the name */
-	name.name = filename;
-	name.len = strlen(filename);
-	name.hash = full_name_hash(name.name, name.len);
-
-	if (dir->d_op && dir->d_op->d_hash) {
-		ret = dir->d_op->d_hash(dir, &name);
-		if (ret < 0) {
-			if (ret == -EIO)
-				cachefiles_io_error(cache, "Hash failed");
-			_leave(" = %d", ret);
-			return ret;
-		}
-	}
-
 	/* look up the victim */
 	mutex_lock(&dir->d_inode->i_mutex);
 
-	victim = d_lookup(dir, &name);
-	if (!victim) {
-		_debug("not found");
-
-		new = d_alloc(dir, &name);
-		if (!new)
-			goto nomem_d_alloc;
-
-		victim = dir->d_inode->i_op->lookup(dir->d_inode, new, NULL);
-		if (IS_ERR(victim))
-			goto lookup_error;
-
-		if (!victim)
-			victim = new;
-		else
-			dput(new);
-	}
+	victim = lookup_one_len(filename, dir, strlen(filename));
+	if (IS_ERR(victim))
+		goto lookup_error;
 
 	_debug("victim -> %p %s",
 	       victim, victim->d_inode ? "positive" : "negative");
@@ -755,14 +605,8 @@ object_in_use:
 	_leave(" = -EBUSY [in use]");
 	return -EBUSY;
 
-nomem_d_alloc:
-	mutex_unlock(&dir->d_inode->i_mutex);
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-
 lookup_error:
 	mutex_unlock(&dir->d_inode->i_mutex);
-	dput(new);
 	ret = PTR_ERR(victim);
 	if (ret == -EIO)
 		cachefiles_io_error(cache, "Lookup failed");
