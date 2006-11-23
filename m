Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756418AbWKWUQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbWKWUQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757453AbWKWUQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:16:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756418AbWKWUQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:16:48 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 29/19] CacheFiles: Remove old obsolete cull function
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 20:13:32 +0000
Message-ID: <27093.1164312812@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CacheFiles: Remove old obsolete cull function

From: David Howells <dhowells@redhat.com>

Remove the old cachefiles_cull() function that was obsolete and #if'd out.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-namei.c |  110 ----------------------------------------------
 1 files changed, 0 insertions(+), 110 deletions(-)

diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index d0db9b3..9e6dd9f 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -524,116 +524,6 @@ nomem_d_alloc:
 	return ERR_PTR(-ENOMEM);
 }
 
-#if 0
-/*
- * cull an object if it's not in use
- * - called only by cache manager daemon
- */
-int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
-		    char *filename)
-{
-	struct cachefiles_object *object;
-	struct rb_node *_n;
-	struct dentry *victim;
-	int ret;
-
-	_enter(",%*.*s/,%s",
-	       dir->d_name.len, dir->d_name.len, dir->d_name.name, filename);
-
-	/* look up the victim */
-	mutex_lock(&dir->d_inode->i_mutex);
-
-	victim = lookup_one_len(filename, dir, strlen(filename));
-	if (IS_ERR(victim))
-		goto lookup_error;
-
-	_debug("victim -> %p %s",
-	       victim, victim->d_inode ? "positive" : "negative");
-
-	/* if the object is no longer there then we probably retired the object
-	 * at the netfs's request whilst the cull was in progress
-	 */
-	if (!victim->d_inode) {
-		mutex_unlock(&dir->d_inode->i_mutex);
-		dput(victim);
-		_leave(" = -ENOENT [absent]");
-		return -ENOENT;
-	}
-
-	/* check to see if we're using this object */
-	read_lock(&cache->active_lock);
-
-	_n = cache->active_nodes.rb_node;
-
-	while (_n) {
-		object = rb_entry(_n, struct cachefiles_object, active_node);
-
-		if (object->dentry > victim)
-			_n = _n->rb_left;
-		else if (object->dentry < victim)
-			_n = _n->rb_right;
-		else
-			goto object_in_use;
-	}
-
-	read_unlock(&cache->active_lock);
-
-	/* okay... the victim is not being used so we can cull it
-	 * - start by marking it as stale
-	 */
-	_debug("victim is cullable");
-
-	ret = cachefiles_remove_object_xattr(cache, victim);
-	if (ret < 0)
-		goto error_unlock;
-
-	/*  actually remove the victim (drops the dir mutex) */
-	_debug("bury");
-
-	ret = cachefiles_bury_object(cache, dir, victim);
-	if (ret < 0)
-		goto error;
-
-	dput(victim);
-	_leave(" = 0");
-	return 0;
-
-
-object_in_use:
-	read_unlock(&cache->active_lock);
-	mutex_unlock(&dir->d_inode->i_mutex);
-	dput(victim);
-	_leave(" = -EBUSY [in use]");
-	return -EBUSY;
-
-lookup_error:
-	mutex_unlock(&dir->d_inode->i_mutex);
-	ret = PTR_ERR(victim);
-	if (ret == -EIO)
-		cachefiles_io_error(cache, "Lookup failed");
-	goto choose_error;
-
-error_unlock:
-	mutex_unlock(&dir->d_inode->i_mutex);
-error:
-	dput(victim);
-choose_error:
-	if (ret == -ENOENT) {
-		/* file or dir now absent - probably retired by netfs */
-		_leave(" = -ESTALE [absent]");
-		return -ESTALE;
-	}
-
-	if (ret != -ENOMEM) {
-		kerror("Internal error: %d", ret);
-		ret = -EIO;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-#endif
-
 /*
  * find out if an object is in use or not
  * - if finds object and it's not in use:
