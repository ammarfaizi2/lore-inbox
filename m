Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966841AbWKONTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966841AbWKONTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966845AbWKONTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:19:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966841AbWKONTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:19:32 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 21/19] CacheFiles: Set the file creation security ID whilst binding the cache
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 13:17:07 +0000
Message-ID: <21558.1163596627@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set the file create security ID whilst binding a cache.  Currently, though the
cachefiles_daemon_add_cache() functions calls cachefiles_begin_secure(), at
that point the file creation security ID is not known.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c     |   10 ++++++----
 fs/cachefiles/cf-security.c |    4 ++--
 fs/cachefiles/internal.h    |   25 ++++++++++++++++++++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 3daf140..0c055a9 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -99,7 +99,7 @@ static int cachefiles_daemon_add_cache(s
 	if (ret < 0)
 		return ret;
 
-	cachefiles_begin_secure(cache, &secctx);
+	cachefiles_begin_secure_nofs(cache, &secctx);
 
 	/* allocate the root index object */
 	ret = -ENOMEM;
@@ -142,12 +142,14 @@ static int cachefiles_daemon_add_cache(s
 	if (root->d_sb->s_flags & MS_RDONLY)
 		goto error_unsupported;
 
-	/* determine the security context within which we access the cache from
-	 * within the kernel */
-	ret = cachefiles_check_security(cache, root);
+	/* determine the security of the on-disk cache as this governs
+	 * security ID of files we create */
+	ret = cachefiles_determine_cache_secid(cache, root);
 	if (ret < 0)
 		goto error_unsupported;
 
+	cachefiles_set_fscreate_secid(cache);
+
 	/* get the cache size and blocksize */
 	ret = vfs_statfs(root, &stats);
 	if (ret < 0)
diff --git a/fs/cachefiles/cf-security.c b/fs/cachefiles/cf-security.c
index c142172..e070bb3 100644
--- a/fs/cachefiles/cf-security.c
+++ b/fs/cachefiles/cf-security.c
@@ -62,8 +62,8 @@ error:
  * check the security details of the on-disk cache
  * - must be called with security imposed
  */
-int cachefiles_check_security(struct cachefiles_cache *cache,
-			      struct dentry *root)
+int cachefiles_determine_cache_secid(struct cachefiles_cache *cache,
+				     struct dentry *root)
 {
 	char *seclabel;
 	u32 seclen;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 90590de..4715de5 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -191,11 +191,17 @@ extern int cachefiles_check_in_use(struc
  */
 #ifdef CONFIG_SECURITY
 extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
-extern int cachefiles_check_security(struct cachefiles_cache *cache,
-				     struct dentry *root);
+extern int cachefiles_determine_cache_secid(struct cachefiles_cache *cache,
+					    struct dentry *root);
+static inline
+void cachefiles_set_fscreate_secid(struct cachefiles_cache *cache)
+{
+	security_set_fscreate_secid(cache->cache_secid);
+}
 #else
 #define cachefiles_get_security_ID(cache) (0)
-#define cachefiles_check_security(cache, root) (0)
+#define cachefiles_determine_cache_secid(cache, root) (0)
+#define cachefiles_set_fscreate_secid(cache) do {} while(0)
 #endif
 
 struct cachefiles_secctx {
@@ -206,6 +212,19 @@ #ifdef CONFIG_SECURITY
 #endif
 };
 
+static inline void cachefiles_begin_secure_nofs(struct cachefiles_cache *cache,
+						struct cachefiles_secctx *ctx)
+{
+#ifdef CONFIG_SECURITY
+	security_act_as_secid(cache->access_secid);
+	ctx->fscreate_secid = security_get_fscreate_secid();
+#endif
+	ctx->fsuid = current->fsuid;
+	ctx->fsgid = current->fsgid;
+	current->fsuid = 0;
+	current->fsgid = 0;
+}
+
 static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 					   struct cachefiles_secctx *ctx)
 {
