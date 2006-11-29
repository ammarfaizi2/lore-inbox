Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935774AbWK2QsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935774AbWK2QsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935846AbWK2QsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:48:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935774AbWK2QsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:48:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 30/19] CacheFiles: Fix the allocate_page() op
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 29 Nov 2006 16:47:51 +0000
Message-ID: <22845.1164818871@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix cachefiles_allocate_page() to mark the specified page as being retained if
it returns successfully.

Also fix the header comment on that function (it doesn't read data from the
disk).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-interface.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index e96e63a..a08831b 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -1108,7 +1108,7 @@ static int cachefiles_read_or_alloc_page
 }
 
 /*
- * read a page from the cache or allocate a block in which to store it
+ * allocate a block in the cache in which to store a page
  * - cache withdrawal is prevented by the caller
  * - returns -EINTR if interrupted
  * - returns -ENOMEM if ran out of memory
@@ -1124,6 +1124,9 @@ static int cachefiles_allocate_page(stru
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
+	struct fscache_cookie *cookie;
+	struct pagevec pagevec;
+	int ret;
 
 	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
@@ -1131,7 +1134,19 @@ static int cachefiles_allocate_page(stru
 
 	_enter("%p,{%lx},,,", object, page->index);
 
-	return cachefiles_has_space(cache, 0, 1);
+	ret = cachefiles_has_space(cache, 0, 1);
+	if (ret == 0) {
+		pagevec_init(&pagevec, 0);
+		pagevec_add(&pagevec, page);
+		cookie = object->fscache.cookie;
+		cookie->def->mark_pages_cached(cookie->netfs_data,
+					       page->mapping, &pagevec);
+	} else {
+		ret = -ENOBUFS;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
