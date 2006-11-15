Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966862AbWKONxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966862AbWKONxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966864AbWKONxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:53:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61345 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966862AbWKONxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:53:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <XMMS.LNX.4.64.0611141618300.25022@d.namei> 
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 13:50:44 +0000
Message-ID: <24555.1163598644@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> The ability to set this needs to be mediated via MAC policy.

Something like this, you mean?

David
---

 security/selinux/hooks.c     |   12 +++-
 security/dummy.c             |    2 -
 include/linux/security.h     |    9 ++-
 fs/cachefiles/cf-bind.c      |    3 +
 fs/cachefiles/cf-daemon.c    |   16 +++--
 fs/cachefiles/cf-interface.c |   40 ++++++++-----
 fs/cachefiles/cf-security.c  |   36 +++++++++++
 fs/cachefiles/cf-security.h  |  134 ++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h     |   61 +------------------
 9 files changed, 225 insertions(+), 88 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3a52698..5bfae9b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4559,13 +4559,19 @@ static u32 selinux_get_fscreate_secid(vo
 	return tsec->create_sid;
 }
 
-static u32 selinux_set_fscreate_secid(u32 secid)
+static int selinux_set_fscreate_secid(u32 secid, u32 *oldsecid)
 {
 	struct task_security_struct *tsec = current->security;
-	u32 oldsid = tsec->create_sid;
+	int error;
+
+	error = task_has_perm(current, current, PROCESS__SETFSCREATE);
+	if (error < 0)
+		return error;
 
+	if (oldsecid)
+		*oldsecid = tsec->create_sid;
 	tsec->create_sid = secid;
-	return oldsid;
+	return 0;
 }
 
 static u32 selinux_act_as_secid(u32 secid)
diff --git a/security/dummy.c b/security/dummy.c
index 30096ec..471b369 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -937,7 +937,7 @@ static u32 dummy_get_fscreate_secid(void
 	return 0;
 }
 
-static u32 dummy_set_fscreate_secid(u32 secid)
+static int dummy_set_fscreate_secid(u32 secid, u32 *oldsecid)
 {
 	return 0;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 8cfeefc..7aa86a3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1160,6 +1160,7 @@ #ifdef CONFIG_SECURITY
  * @set_fscreate_secid:
  *	Set the current FS security ID.
  *	@secid contains the security ID to set.
+ *	@oldsecid points to where the old security ID will be placed (or NULL).
  *
  * @act_as_secid:
  *	Set the security ID as which to act, returning the security ID as which
@@ -1363,7 +1364,7 @@ struct security_operations {
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
 	u32 (*get_fscreate_secid)(void);
-	u32 (*set_fscreate_secid)(u32 secid);
+	int (*set_fscreate_secid)(u32 secid, u32 *oldsecid);
 	u32 (*act_as_secid)(u32 secid);
 	u32 (*act_as_self)(void);
 	int (*cachefiles_get_secid)(u32 secid, u32 *modsecid);
@@ -2174,9 +2175,9 @@ static inline u32 security_get_fscreate_
 	return security_ops->get_fscreate_secid();
 }
 
-static inline u32 security_set_fscreate_secid(u32 secid)
+static inline int security_set_fscreate_secid(u32 secid, u32 *oldsecid)
 {
-	return security_ops->set_fscreate_secid(secid);
+	return security_ops->set_fscreate_secid(secid, oldsecid);
 }
 
 static inline u32 security_act_as_secid(u32 secid)
@@ -2884,7 +2885,7 @@ static inline u32 security_get_fscreate_
 	return 0;
 }
 
-static inline u32 security_set_fscreate_secid(u32 secid)
+static inline int security_set_fscreate_secid(u32 secid, u32 *oldsecid)
 {
 	return 0;
 }
diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 0c055a9..c8e68a4 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -226,6 +226,8 @@ static int cachefiles_daemon_add_cache(s
 			   MAJOR(fsdef->dentry->d_sb->s_dev),
 			   MINOR(fsdef->dentry->d_sb->s_dev));
 
+	set_bit(CACHEFILES_FSCACHE_INITED, &cache->flags);
+
 	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
 	if (ret < 0)
 		goto error_add_cache;
@@ -273,6 +275,7 @@ void cachefiles_daemon_unbind(struct cac
 		       cache->cache.identifier);
 
 		fscache_withdraw_cache(&cache->cache);
+		clear_bit(CACHEFILES_FSCACHE_INITED, &cache->flags);
 	}
 
 	if (cache->cache.fsdef)
diff --git a/fs/cachefiles/cf-daemon.c b/fs/cachefiles/cf-daemon.c
index 86cf23b..a1888ee 100644
--- a/fs/cachefiles/cf-daemon.c
+++ b/fs/cachefiles/cf-daemon.c
@@ -562,9 +562,11 @@ static int cachefiles_daemon_cull(struct
 	if (!S_ISDIR(dir->d_inode->i_mode))
 		goto notdir;
 
-	cachefiles_begin_secure(cache, &secctx);
-	ret = cachefiles_cull(cache, dir, args);
-	cachefiles_end_secure(cache, &secctx);
+	ret = cachefiles_begin_secure(cache, &secctx);
+	if (ret == 0) {
+		ret = cachefiles_cull(cache, dir, args);
+		cachefiles_end_secure(cache, &secctx);
+	}
 
 	dput(dir);
 	_leave(" = %d", ret);
@@ -654,9 +656,11 @@ static int cachefiles_daemon_inuse(struc
 	if (!S_ISDIR(dir->d_inode->i_mode))
 		goto notdir;
 
-	cachefiles_begin_secure(cache, &secctx);
-	ret = cachefiles_check_in_use(cache, dir, args);
-	cachefiles_end_secure(cache, &secctx);
+	ret = cachefiles_begin_secure(cache, &secctx);
+	if (ret == 0) {
+		ret = cachefiles_check_in_use(cache, dir, args);
+		cachefiles_end_secure(cache, &secctx);
+	}
 
 	dput(dir);
 	_leave(" = %d", ret);
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index e96e63a..6ce14f5 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -93,7 +93,9 @@ static struct fscache_object *cachefiles
 	auxdata->type = cookie->def->type;
 
 	/* look up the key, creating any missing bits */
-	cachefiles_begin_secure(cache, &secctx);
+	ret = cachefiles_begin_secure(cache, &secctx);
+	if (ret < 0)
+		goto lookup_failed;
 	ret = cachefiles_walk_to_object(parent, object, key, auxdata);
 	cachefiles_end_secure(cache, &secctx);
 	if (ret < 0)
@@ -186,9 +188,10 @@ static void cachefiles_update_object(str
 	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
 
-	cachefiles_begin_secure(cache, &secctx);
-	//cachefiles_tree_update_object(super, object);
-	cachefiles_end_secure(cache, &secctx);
+	if (cachefiles_begin_secure(cache, &secctx) == 0) {
+		//cachefiles_tree_update_object(super, object);
+		cachefiles_end_secure(cache, &secctx);
+	}
 }
 
 /*
@@ -199,6 +202,7 @@ static void cachefiles_put_object(struct
 	struct cachefiles_secctx secctx;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
+	int ret;
 
 	ASSERT(_object);
 
@@ -224,9 +228,11 @@ #endif
 	    _object != cache->cache.fsdef
 	    ) {
 		_debug("- retire object %p", object);
-		cachefiles_begin_secure(cache, &secctx);
-		cachefiles_delete_object(cache, object);
-		cachefiles_end_secure(cache, &secctx);
+		ret = cachefiles_begin_secure(cache, &secctx);
+		if (ret == 0) {
+			cachefiles_delete_object(cache, object);
+			cachefiles_end_secure(cache, &secctx);
+		}
 	}
 
 	/* close the filesystem stuff attached to the object */
@@ -269,9 +275,11 @@ static void cachefiles_sync_cache(struct
 
 	/* make sure all pages pinned by operations on behalf of the netfs are
 	 * written to disc */
-	cachefiles_begin_secure(cache, &secctx);
-	ret = fsync_super(cache->mnt->mnt_sb);
-	cachefiles_end_secure(cache, &secctx);
+	ret = cachefiles_begin_secure(cache, &secctx);
+	if (ret == 0) {
+		ret = fsync_super(cache->mnt->mnt_sb);
+		cachefiles_end_secure(cache, &secctx);
+	}
 
 	if (ret == -EIO)
 		cachefiles_io_error(cache,
@@ -308,11 +316,13 @@ static int cachefiles_set_i_size(struct 
 	newattrs.ia_size = i_size;
 	newattrs.ia_valid = ATTR_SIZE;
 
-	cachefiles_begin_secure(cache, &secctx);
-	mutex_lock(&object->backer->d_inode->i_mutex);
-	ret = notify_change(object->backer, &newattrs);
-	mutex_unlock(&object->backer->d_inode->i_mutex);
-	cachefiles_end_secure(cache, &secctx);
+	ret = cachefiles_begin_secure(cache, &secctx);
+	if (ret == 0) {
+		mutex_lock(&object->backer->d_inode->i_mutex);
+		ret = notify_change(object->backer, &newattrs);
+		mutex_unlock(&object->backer->d_inode->i_mutex);
+		cachefiles_end_secure(cache, &secctx);
+	}
 
 	if (ret == -EIO) {
 		cachefiles_io_error_obj(object, "Size set failed");
diff --git a/fs/cachefiles/cf-security.c b/fs/cachefiles/cf-security.c
index e070bb3..6d294da 100644
--- a/fs/cachefiles/cf-security.c
+++ b/fs/cachefiles/cf-security.c
@@ -105,3 +105,39 @@ error:
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * deal with failure to change the file creation security ID
+ */
+int cachefiles_begin_secure_failed(struct cachefiles_cache *cache, int ret)
+{
+	kerror("Unable to enter secure region in process %d (error %d)",
+	       current->pid, ret);
+
+	if (test_bit(CACHEFILES_FSCACHE_INITED, &cache->flags))
+		fscache_io_error(&cache->cache);
+	set_bit(CACHEFILES_DEAD, &cache->flags);
+	security_act_as_self();
+	return ret;
+}
+
+/*
+ * deal with failure to restore the file creation security ID
+ */
+void cachefiles_end_secure_failed(struct cachefiles_cache *cache,
+				  const struct cachefiles_secctx *ctx,
+				  int ret)
+{
+	printk(KERN_ERR "CacheFiles: ERROR:"
+	       " Failed to restore file creation security ID %x on process %d"
+	       " (error %d)\n",
+	       ctx->fscreate_secid, current->pid, ret);
+	printk(KERN_ERR "CacheFiles: Killing process %d\n", current->pid);
+
+	if (test_bit(CACHEFILES_FSCACHE_INITED, &cache->flags))
+		fscache_io_error(&cache->cache);
+	set_bit(CACHEFILES_DEAD, &cache->flags);
+
+	/* this process cannot be allowed to continue */
+	force_sig(SIGKILL, current);
+}
diff --git a/fs/cachefiles/cf-security.h b/fs/cachefiles/cf-security.h
new file mode 100644
index 0000000..a1dd74c
--- /dev/null
+++ b/fs/cachefiles/cf-security.h
@@ -0,0 +1,134 @@
+/* LSM security context manipulation
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * saved security context
+ */
+struct cachefiles_secctx {
+	uid_t	fsuid;			/* save for current->fsuid */
+	gid_t	fsgid;			/* save for current->fsgid */
+#ifdef CONFIG_SECURITY
+	u32	fscreate_secid;		/* save for current fscreate security ID */
+#endif
+};
+
+#ifndef CONFIG_SECURITY
+#define cachefiles_get_security_ID(cache) (0)
+#define cachefiles_determine_cache_secid(cache, root) (0)
+#define cachefiles_set_fscreate_secid(cache) do {} while(0)
+
+/*
+ * attempt to enter the cachefiles security context
+ */
+static inline int cachefiles_begin_secure(struct cachefiles_cache *cache,
+					   struct cachefiles_secctx *ctx)
+{
+	ctx->fsuid = current->fsuid;
+	ctx->fsgid = current->fsgid;
+	current->fsuid = 0;
+	current->fsgid = 0;
+	return 0;
+}
+
+#define cachefiles_begin_secure_nofs(cache, ctx) \
+	cachefiles_begin_secure(cache, ctx)
+
+/*
+ * attempt to leave the cachefiles security context
+ */
+static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
+					 const struct cachefiles_secctx *ctx)
+{
+	current->fsuid = ctx->fsuid;
+	current->fsgid = ctx->fsgid;
+}
+
+#else /* !CONFIG_SECURITY */
+
+extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
+extern int cachefiles_determine_cache_secid(struct cachefiles_cache *cache,
+					    struct dentry *root);
+extern int cachefiles_begin_secure_failed(struct cachefiles_cache *cache,
+					  int ret);
+extern void cachefiles_end_secure_failed(struct cachefiles_cache *cache,
+					 const struct cachefiles_secctx *ctx,
+					 int ret);
+
+/*
+ * attempt to set the file creation security ID
+ */
+static inline int cachefiles_set_fscreate_secid(struct cachefiles_cache *cache)
+{
+	int ret;
+
+	ret = security_set_fscreate_secid(cache->cache_secid, NULL);
+	if (unlikely(ret < 0))
+		return cachefiles_begin_secure_failed(cache, ret);
+	return 0;
+}
+
+/*
+ * enter the cachefiles security context without changing the file creation
+ * security ID
+ */
+static inline void cachefiles_begin_secure_nofs(struct cachefiles_cache *cache,
+						struct cachefiles_secctx *ctx)
+{
+	security_act_as_secid(cache->access_secid);
+	ctx->fscreate_secid = security_get_fscreate_secid();
+	ctx->fsuid = current->fsuid;
+	ctx->fsgid = current->fsgid;
+	current->fsuid = 0;
+	current->fsgid = 0;
+}
+
+/*
+ * attempt to enter the cachefiles security context
+ */
+static inline int cachefiles_begin_secure(struct cachefiles_cache *cache,
+					  struct cachefiles_secctx *ctx)
+{
+	int ret;
+
+	security_act_as_secid(cache->access_secid);
+	ret = security_set_fscreate_secid(cache->cache_secid,
+					  &ctx->fscreate_secid);
+	if (unlikely(ret < 0))
+		return cachefiles_begin_secure_failed(cache, ret);
+
+	ctx->fsuid = current->fsuid;
+	ctx->fsgid = current->fsgid;
+	current->fsuid = 0;
+	current->fsgid = 0;
+	return 0;
+}
+
+/*
+ * attempt to leave the cachefiles security context
+ */
+static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
+					 const struct cachefiles_secctx *ctx)
+{
+	int ret;
+
+	current->fsuid = ctx->fsuid;
+	current->fsgid = ctx->fsgid;
+
+	/* restoring the file creation security ID might fail, but there's
+	 * nothing we can do about it if it does */
+	ret = security_set_fscreate_secid(ctx->fscreate_secid, NULL);
+	if (unlikely(ret < 0))
+		cachefiles_end_secure_failed(cache, ctx, ret);
+
+	security_act_as_self();
+}
+
+#endif /* !CONFIG_SECURITY */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4715de5..16727fc 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -102,6 +102,7 @@ #define CACHEFILES_READY		0	/* T if cach
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_FSCACHE_INITED	4	/* T if fscache_init_cache() has been called */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*tag;		/* cache binding tag */
 };
@@ -189,65 +190,7 @@ extern int cachefiles_check_in_use(struc
 /*
  * cf-security.c
  */
-#ifdef CONFIG_SECURITY
-extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
-extern int cachefiles_determine_cache_secid(struct cachefiles_cache *cache,
-					    struct dentry *root);
-static inline
-void cachefiles_set_fscreate_secid(struct cachefiles_cache *cache)
-{
-	security_set_fscreate_secid(cache->cache_secid);
-}
-#else
-#define cachefiles_get_security_ID(cache) (0)
-#define cachefiles_determine_cache_secid(cache, root) (0)
-#define cachefiles_set_fscreate_secid(cache) do {} while(0)
-#endif
-
-struct cachefiles_secctx {
-	uid_t	fsuid;			/* save for current->fsuid */
-	gid_t	fsgid;			/* save for current->fsgid */
-#ifdef CONFIG_SECURITY
-	u32	fscreate_secid;		/* save for current fscreate security ID */
-#endif
-};
-
-static inline void cachefiles_begin_secure_nofs(struct cachefiles_cache *cache,
-						struct cachefiles_secctx *ctx)
-{
-#ifdef CONFIG_SECURITY
-	security_act_as_secid(cache->access_secid);
-	ctx->fscreate_secid = security_get_fscreate_secid();
-#endif
-	ctx->fsuid = current->fsuid;
-	ctx->fsgid = current->fsgid;
-	current->fsuid = 0;
-	current->fsgid = 0;
-}
-
-static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
-					   struct cachefiles_secctx *ctx)
-{
-#ifdef CONFIG_SECURITY
-	security_act_as_secid(cache->access_secid);
-	ctx->fscreate_secid = security_set_fscreate_secid(cache->cache_secid);
-#endif
-	ctx->fsuid = current->fsuid;
-	ctx->fsgid = current->fsgid;
-	current->fsuid = 0;
-	current->fsgid = 0;
-}
-
-static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
-					 const struct cachefiles_secctx *ctx)
-{
-	current->fsuid = ctx->fsuid;
-	current->fsgid = ctx->fsgid;
-#ifdef CONFIG_SECURITY
-	security_set_fscreate_secid(ctx->fscreate_secid);
-	security_act_as_self();
-#endif
-}
+#include "cf-security.h"
 
 /*
  * cf-xattr.c
