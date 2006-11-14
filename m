Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966328AbWKNUNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966328AbWKNUNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966317AbWKNUJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966313AbWKNUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:17 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/19] CacheFiles: Permit daemon to probe inuseness of a cache file
Date: Tue, 14 Nov 2006 20:07:02 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200702.12943.39624.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Permit the daemon to probe to see whether a cache file is in use by a netfs or
not.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-daemon.c |   73 +++++++++++++++++++
 fs/cachefiles/cf-namei.c  |  170 +++++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h  |    3 +
 3 files changed, 246 insertions(+), 0 deletions(-)

diff --git a/fs/cachefiles/cf-daemon.c b/fs/cachefiles/cf-daemon.c
index ae82685..ee07865 100644
--- a/fs/cachefiles/cf-daemon.c
+++ b/fs/cachefiles/cf-daemon.c
@@ -38,6 +38,7 @@ static int cachefiles_daemon_cull(struct
 static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args);
 static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args);
 static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args);
+static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args);
 
 static unsigned long cachefiles_open;
 
@@ -66,6 +67,7 @@ static const struct cachefiles_daemon_cm
 	{ "frun",	cachefiles_daemon_frun	},
 	{ "fcull",	cachefiles_daemon_fcull	},
 	{ "fstop",	cachefiles_daemon_fstop	},
+	{ "inuse",	cachefiles_daemon_inuse	},
 	{ "tag",	cachefiles_daemon_tag	},
 	{ "",		NULL			}
 };
@@ -602,3 +604,74 @@ inval:
 	kerror("debug command requires mask");
 	return -EINVAL;
 }
+
+/*
+ * find out whether an object is in use or not
+ * - command: "inuse <dirfd> <name>"
+ */
+static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
+{
+	struct dentry *dir;
+	struct file *dirfile;
+	uid_t fsuid;
+	gid_t fsgid;
+	u32 fscreatesid;
+	int dirfd, fput_needed, ret;
+
+	_enter(",%s", args);
+
+	dirfd = simple_strtoul(args, &args, 0);
+
+	if (!isspace(*args))
+		goto inval;
+
+	while (isspace(*args))
+		args++;
+
+	if (!*args)
+		goto inval;
+
+	if (strchr(args, '/'))
+		goto inval;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
+		kerror("inuse applied to unready cache");
+		return -EIO;
+	}
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		kerror("inuse applied to dead cache");
+		return -EIO;
+	}
+
+	/* extract the directory dentry from the fd */
+	dirfile = fget_light(dirfd, &fput_needed);
+	if (!dirfile) {
+		kerror("cull dirfd not open");
+		return -EBADF;
+	}
+
+	dir = dget(dirfile->f_dentry);
+	fput_light(dirfile, fput_needed);
+	dirfile = NULL;
+
+	if (!S_ISDIR(dir->d_inode->i_mode))
+		goto notdir;
+
+	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	ret = cachefiles_check_in_use(cache, dir, args);
+	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+
+	dput(dir);
+	_leave(" = %d", ret);
+	return ret;
+
+notdir:
+	dput(dir);
+	kerror("inuse command requires dirfd to be a directory");
+	return -ENOTDIR;
+
+inval:
+	kerror("inuse command requires dirfd and filename");
+	return -EINVAL;
+}
diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index a3df94a..d0db9b3 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -524,6 +524,7 @@ nomem_d_alloc:
 	return ERR_PTR(-ENOMEM);
 }
 
+#if 0
 /*
  * cull an object if it's not in use
  * - called only by cache manager daemon
@@ -631,3 +632,172 @@ choose_error:
 	_leave(" = %d", ret);
 	return ret;
 }
+#endif
+
+/*
+ * find out if an object is in use or not
+ * - if finds object and it's not in use:
+ *   - returns a pointer to the object and a reference on it
+ *   - returns with the directory locked
+ */
+static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
+					      struct dentry *dir,
+					      char *filename)
+{
+	struct cachefiles_object *object;
+	struct rb_node *_n;
+	struct dentry *victim;
+	int ret;
+
+	_enter(",%*.*s/,%s",
+	       dir->d_name.len, dir->d_name.len, dir->d_name.name, filename);
+
+	/* look up the victim */
+	mutex_lock(&dir->d_inode->i_mutex);
+
+	victim = lookup_one_len(filename, dir, strlen(filename));
+	if (IS_ERR(victim))
+		goto lookup_error;
+
+	_debug("victim -> %p %s",
+	       victim, victim->d_inode ? "positive" : "negative");
+
+	/* if the object is no longer there then we probably retired the object
+	 * at the netfs's request whilst the cull was in progress
+	 */
+	if (!victim->d_inode) {
+		mutex_unlock(&dir->d_inode->i_mutex);
+		dput(victim);
+		_leave(" = -ENOENT [absent]");
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* check to see if we're using this object */
+	read_lock(&cache->active_lock);
+
+	_n = cache->active_nodes.rb_node;
+
+	while (_n) {
+		object = rb_entry(_n, struct cachefiles_object, active_node);
+
+		if (object->dentry > victim)
+			_n = _n->rb_left;
+		else if (object->dentry < victim)
+			_n = _n->rb_right;
+		else
+			goto object_in_use;
+	}
+
+	read_unlock(&cache->active_lock);
+
+	_leave(" = %p", victim);
+	return victim;
+
+object_in_use:
+	read_unlock(&cache->active_lock);
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(victim);
+	_leave(" = -EBUSY [in use]");
+	return ERR_PTR(-EBUSY);
+
+lookup_error:
+	mutex_unlock(&dir->d_inode->i_mutex);
+	ret = PTR_ERR(victim);
+	if (ret == -ENOENT) {
+		/* file or dir now absent - probably retired by netfs */
+		_leave(" = -ESTALE [absent]");
+		return ERR_PTR(-ESTALE);
+	}
+
+	if (ret == -EIO) {
+		cachefiles_io_error(cache, "Lookup failed");
+	} else if (ret != -ENOMEM) {
+		kerror("Internal error: %d", ret);
+		ret = -EIO;
+	}
+
+	_leave(" = %d", ret);
+	return ERR_PTR(ret);
+}
+
+/*
+ * cull an object if it's not in use
+ * - called only by cache manager daemon
+ */
+int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
+		    char *filename)
+{
+	struct dentry *victim;
+	int ret;
+
+	_enter(",%*.*s/,%s",
+	       dir->d_name.len, dir->d_name.len, dir->d_name.name, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	_debug("victim -> %p %s",
+	       victim, victim->d_inode ? "positive" : "negative");
+
+	/* okay... the victim is not being used so we can cull it
+	 * - start by marking it as stale
+	 */
+	_debug("victim is cullable");
+
+	ret = cachefiles_remove_object_xattr(cache, victim);
+	if (ret < 0)
+		goto error_unlock;
+
+	/*  actually remove the victim (drops the dir mutex) */
+	_debug("bury");
+
+	ret = cachefiles_bury_object(cache, dir, victim);
+	if (ret < 0)
+		goto error;
+
+	dput(victim);
+	_leave(" = 0");
+	return 0;
+
+error_unlock:
+	mutex_unlock(&dir->d_inode->i_mutex);
+error:
+	dput(victim);
+	if (ret == -ENOENT) {
+		/* file or dir now absent - probably retired by netfs */
+		_leave(" = -ESTALE [absent]");
+		return -ESTALE;
+	}
+
+	if (ret != -ENOMEM) {
+		kerror("Internal error: %d", ret);
+		ret = -EIO;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * find out if an object is in use or not
+ * - called only by cache manager daemon
+ * - returns -EBUSY or 0 to indicate whether an object is in use or not
+ */
+int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
+			    char *filename)
+{
+	struct dentry *victim;
+
+	_enter(",%*.*s/,%s",
+	       dir->d_name.len, dir->d_name.len, dir->d_name.name, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(victim);
+	_leave(" = 0");
+	return 0;
+}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d56b443..1b7ada2 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -183,6 +183,9 @@ extern struct dentry *cachefiles_get_dir
 extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 			   char *filename);
 
+extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
+				   struct dentry *dir, char *filename);
+
 /*
  * cf-security.c
  */
