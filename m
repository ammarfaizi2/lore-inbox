Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753187AbWKOKNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbWKOKNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbWKOKNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:13:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41353 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753187AbWKOKNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:13:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: jmorris@namei.org, torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 20/19] CacheFiles: Use secid not sid lest confusion arise with session IDs
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 10:10:59 +0000
Message-ID: <6851.1163585459@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use "secid" not "sid" to refer to security IDs lest confusion arise with
session IDs.  Also condense the saved security state into a single structure.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c      |   10 ++++------
 fs/cachefiles/cf-daemon.c    |   16 ++++++----------
 fs/cachefiles/cf-interface.c |   40 +++++++++++++++-------------------------
 fs/cachefiles/cf-security.c  |   26 +++++++++++++-------------
 fs/cachefiles/internal.h     |   36 +++++++++++++++++++++++-------------
 5 files changed, 61 insertions(+), 67 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 1d1fd14..3daf140 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -85,13 +85,11 @@ int cachefiles_daemon_bind(struct cachef
  */
 static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_object *fsdef;
 	struct nameidata nd;
 	struct kstatfs stats;
 	struct dentry *graveyard, *cachedir, *root;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 	int ret;
 
 	_enter("");
@@ -101,7 +99,7 @@ static int cachefiles_daemon_add_cache(s
 	if (ret < 0)
 		return ret;
 
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 
 	/* allocate the root index object */
 	ret = -ENOMEM;
@@ -240,7 +238,7 @@ static int cachefiles_daemon_add_cache(s
 
 	/* check how much space the cache has */
 	cachefiles_has_space(cache, 0, 0);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 	return 0;
 
 error_add_cache:
@@ -255,7 +253,7 @@ error_unsupported:
 error_open_root:
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 	kerror("Failed to register: %d", ret);
 	return ret;
 }
diff --git a/fs/cachefiles/cf-daemon.c b/fs/cachefiles/cf-daemon.c
index ee07865..86cf23b 100644
--- a/fs/cachefiles/cf-daemon.c
+++ b/fs/cachefiles/cf-daemon.c
@@ -517,11 +517,9 @@ static int cachefiles_daemon_tag(struct 
  */
 static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 {
+	struct cachefiles_secctx secctx;
 	struct dentry *dir;
 	struct file *dirfile;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 	int dirfd, fput_needed, ret;
 
 	_enter(",%s", args);
@@ -564,9 +562,9 @@ static int cachefiles_daemon_cull(struct
 	if (!S_ISDIR(dir->d_inode->i_mode))
 		goto notdir;
 
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	ret = cachefiles_cull(cache, dir, args);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 
 	dput(dir);
 	_leave(" = %d", ret);
@@ -611,11 +609,9 @@ inval:
  */
 static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 {
+	struct cachefiles_secctx secctx;
 	struct dentry *dir;
 	struct file *dirfile;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 	int dirfd, fput_needed, ret;
 
 	_enter(",%s", args);
@@ -658,9 +654,9 @@ static int cachefiles_daemon_inuse(struc
 	if (!S_ISDIR(dir->d_inode->i_mode))
 		goto notdir;
 
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	ret = cachefiles_check_in_use(cache, dir, args);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 
 	dput(dir);
 	_leave(" = %d", ret);
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index 7a3d085..e96e63a 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -29,15 +29,13 @@ static struct fscache_object *cachefiles
 	struct fscache_object *_parent,
 	struct fscache_cookie *cookie)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_object *parent, *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_xattr *auxdata;
 	unsigned keylen, auxlen;
-	uid_t fsuid;
-	gid_t fsgid;
 	void *buffer;
 	char *key;
-	u32 fscreatesid;
 	int ret;
 
 	ASSERT(_parent);
@@ -95,9 +93,9 @@ static struct fscache_object *cachefiles
 	auxdata->type = cookie->def->type;
 
 	/* look up the key, creating any missing bits */
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	ret = cachefiles_walk_to_object(parent, object, key, auxdata);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 	if (ret < 0)
 		goto lookup_failed;
 
@@ -179,20 +177,18 @@ static void cachefiles_unlock_object(str
  */
 static void cachefiles_update_object(struct fscache_object *_object)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 
 	_enter("%p", _object);
 
 	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
 
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	//cachefiles_tree_update_object(super, object);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 }
 
 /*
@@ -200,11 +196,9 @@ static void cachefiles_update_object(str
  */
 static void cachefiles_put_object(struct fscache_object *_object)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 
 	ASSERT(_object);
 
@@ -230,9 +224,9 @@ #endif
 	    _object != cache->cache.fsdef
 	    ) {
 		_debug("- retire object %p", object);
-		cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+		cachefiles_begin_secure(cache, &secctx);
 		cachefiles_delete_object(cache, object);
-		cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+		cachefiles_end_secure(cache, &secctx);
 	}
 
 	/* close the filesystem stuff attached to the object */
@@ -265,10 +259,8 @@ #endif
  */
 static void cachefiles_sync_cache(struct fscache_cache *_cache)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_cache *cache;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 	int ret;
 
 	_enter("%p", _cache);
@@ -277,9 +269,9 @@ static void cachefiles_sync_cache(struct
 
 	/* make sure all pages pinned by operations on behalf of the netfs are
 	 * written to disc */
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	ret = fsync_super(cache->mnt->mnt_sb);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 
 	if (ret == -EIO)
 		cachefiles_io_error(cache,
@@ -293,12 +285,10 @@ static void cachefiles_sync_cache(struct
  */
 static int cachefiles_set_i_size(struct fscache_object *_object, loff_t i_size)
 {
+	struct cachefiles_secctx secctx;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct iattr newattrs;
-	uid_t fsuid;
-	gid_t fsgid;
-	u32 fscreatesid;
 	int ret;
 
 	_enter("%p,%llu", _object, i_size);
@@ -318,11 +308,11 @@ static int cachefiles_set_i_size(struct 
 	newattrs.ia_size = i_size;
 	newattrs.ia_valid = ATTR_SIZE;
 
-	cachefiles_begin_secure(cache, &fsuid, &fsgid, &fscreatesid);
+	cachefiles_begin_secure(cache, &secctx);
 	mutex_lock(&object->backer->d_inode->i_mutex);
 	ret = notify_change(object->backer, &newattrs);
 	mutex_unlock(&object->backer->d_inode->i_mutex);
-	cachefiles_end_secure(cache, fsuid, fsgid, fscreatesid);
+	cachefiles_end_secure(cache, &secctx);
 
 	if (ret == -EIO) {
 		cachefiles_io_error_obj(object, "Size set failed");
diff --git a/fs/cachefiles/cf-security.c b/fs/cachefiles/cf-security.c
index d7c1473..c142172 100644
--- a/fs/cachefiles/cf-security.c
+++ b/fs/cachefiles/cf-security.c
@@ -19,36 +19,36 @@ #include "internal.h"
 int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 {
 	char *seclabel;
-	u32 seclen, daemon_sid;
+	u32 seclen, daemon_secid;
 	int ret;
 
 	_enter("");
 
-	cache->access_sid = 0;
+	cache->access_secid = 0;
 
 	/* ask the security policy to tell us what security ID we should be
 	 * using to access the cache, given the security ID that our daemon is
 	 * using */
-	security_task_getsecid(current, &daemon_sid);
+	security_task_getsecid(current, &daemon_secid);
 
-	ret = security_secid_to_secctx(daemon_sid, &seclabel, &seclen);
+	ret = security_secid_to_secctx(daemon_secid, &seclabel, &seclen);
 	if (ret < 0)
 		goto error;
-	_debug("Cache Daemon SID: %x '%s'", daemon_sid, seclabel);
+	_debug("Cache Daemon SecID: %x '%s'", daemon_secid, seclabel);
 	kfree(seclabel);
 
-	ret = security_cachefiles_get_secid(daemon_sid, &cache->access_sid);
+	ret = security_cachefiles_get_secid(daemon_secid, &cache->access_secid);
 	if (ret < 0) {
 		printk(KERN_ERR "CacheFiles:"
-		       " Security can't provide module SID: error %d",
+		       " Security can't provide module SecID: error %d",
 		       ret);
 		goto error;
 	}
 
-	ret = security_secid_to_secctx(cache->access_sid, &seclabel, &seclen);
+	ret = security_secid_to_secctx(cache->access_secid, &seclabel, &seclen);
 	if (ret < 0)
 		goto error;
-	_debug("Cache Module SID: %x '%s'", cache->access_sid, seclabel);
+	_debug("Cache Module SecID: %x '%s'", cache->access_secid, seclabel);
 	kfree(seclabel);
 
 error:
@@ -71,14 +71,14 @@ int cachefiles_check_security(struct cac
 
 	_enter("");
 
-	/* use the cache root dir's security ID as the SID with which to create
+	/* use the cache root dir's security ID as the SECID with which to create
 	 * files */
-	cache->cache_sid = security_inode_get_secid(root->d_inode);
+	cache->cache_secid = security_inode_get_secid(root->d_inode);
 
-	ret = security_secid_to_secctx(cache->cache_sid, &seclabel, &seclen);
+	ret = security_secid_to_secctx(cache->cache_secid, &seclabel, &seclen);
 	if (ret < 0)
 		goto error;
-	_debug("Cache SID: %x '%s'", cache->cache_sid, seclabel);
+	_debug("Cache SecID: %x '%s'", cache->cache_secid, seclabel);
 	kfree(seclabel);
 
 	/* check that we have permission to create files and directories with
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1b7ada2..90590de 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -81,8 +81,8 @@ struct cachefiles_cache {
 	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
 	rwlock_t			active_lock;	/* lock for active_nodes */
 	atomic_t			gravecounter;	/* graveyard uniquifier */
-	u32				access_sid;	/* cache access SID */
-	u32				cache_sid;	/* cache fs object SID */
+	u32				access_secid;	/* cache access security ID */
+	u32				cache_secid;	/* cache fs object security ID */
 	unsigned			frun_percent;	/* when to stop culling (% files) */
 	unsigned			fcull_percent;	/* when to start culling (% files) */
 	unsigned			fstop_percent;	/* when to stop allocating (% files) */
@@ -198,26 +198,36 @@ #define cachefiles_get_security_ID(cache
 #define cachefiles_check_security(cache, root) (0)
 #endif
 
+struct cachefiles_secctx {
+	uid_t	fsuid;			/* save for current->fsuid */
+	gid_t	fsgid;			/* save for current->fsgid */
+#ifdef CONFIG_SECURITY
+	u32	fscreate_secid;		/* save for current fscreate security ID */
+#endif
+};
+
 static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
-					   uid_t *fsuid, gid_t *fsgid,
-					   u32 *fscreatesid)
+					   struct cachefiles_secctx *ctx)
 {
-	security_act_as_secid(cache->access_sid);
-	*fscreatesid = security_set_fscreate_secid(cache->cache_sid);
-	*fsuid = current->fsuid;
-	*fsgid = current->fsgid;
+#ifdef CONFIG_SECURITY
+	security_act_as_secid(cache->access_secid);
+	ctx->fscreate_secid = security_set_fscreate_secid(cache->cache_secid);
+#endif
+	ctx->fsuid = current->fsuid;
+	ctx->fsgid = current->fsgid;
 	current->fsuid = 0;
 	current->fsgid = 0;
 }
 
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
-					 uid_t fsuid, gid_t fsgid,
-					 u32 fscreatesid)
+					 const struct cachefiles_secctx *ctx)
 {
-	current->fsuid = fsuid;
-	current->fsgid = fsgid;
-	security_set_fscreate_secid(fscreatesid);
+	current->fsuid = ctx->fsuid;
+	current->fsgid = ctx->fsgid;
+#ifdef CONFIG_SECURITY
+	security_set_fscreate_secid(ctx->fscreate_secid);
 	security_act_as_self();
+#endif
 }
 
 /*
