Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVDLOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVDLOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVDLOJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:09:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262379AbVDLOFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:05:09 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org, steved@redhat.com
cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH] FS-Cache: Fix bug in error handling
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 12 Apr 2005 15:04:51 +0100
Message-ID: <3919.1113314691@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes a bug in the in __fscache_acquire_cookie()'s error
handling and tidies the code up a bit.

What was happening was the dead cookie was being released in the bit governed
by the error: label, and then an attempt was made to release the cookie's
semaphore when that fell through into the done: bit.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 fscache-nullptr-fix-2612rc2mm1.diff
 fs/fscache/cookie.c |   49 ++++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 23 deletions(-)

diff -uNr linux-2.6.12-rc2-mm1/fs/fscache/cookie.c linux-2.6.12-rc2-mm1-cachefs/fs/fscache/cookie.c
--- linux-2.6.12-rc2-mm1/fs/fscache/cookie.c	2005-04-06 13:48:23.000000000 +0100
+++ linux-2.6.12-rc2-mm1-cachefs/fs/fscache/cookie.c	2005-04-06 18:28:47.000000000 +0100
@@ -743,7 +743,7 @@
 
 	if (list_empty(&fscache_cache_list)) {
 		up_read(&fscache_addremove_sem);
-		_leave(" [no caches]");
+		_leave(" = %p [no caches]", cookie);
 		return cookie;
 	}
 
@@ -765,38 +765,41 @@
 		}
 	}
 
-	/* if the object is a cookie then we need do nothing more here - we
+	/* if the object is an index then we need do nothing more here - we
 	 * create indexes on disc when we need them as an index may exist in
 	 * multiple caches */
-	if (cookie->idef)
-		goto done;
+	if (!cookie->idef) {
+		/* the object is a file - we need to select a cache in which to
+		 * store it */
+		cache = fscache_select_cache_for_file();
+		if (!cache)
+			goto no_cache; /* couldn't decide on a cache */
+
+		/* create a file index entry on disc, along with all the
+		 * indexes required to find it again later */
+		ret = fscache_instantiate_object(cookie, cache);
+		if (ret < 0)
+			goto error;
+	}
 
-	/* the object is a file - we need to select a cache in which to store
-	 * it */
-	ret = -ENOMEDIUM;
-	cache = fscache_select_cache_for_file();
-	if (!cache)
-		goto error; /* couldn't decide on a cache */
-
-	/* create a file index entry on disc, along with all the indexes
-	 * required to find it again later */
-	ret = fscache_instantiate_object(cookie, cache);
-	if (ret == 0)
-		goto done;
+	up_write(&cookie->sem);
+out:
+	up_read(&fscache_addremove_sem);
+	_leave(" = %p", cookie);
+	return cookie;
 
- error:
-	printk("FS-Cache: error from cache fs: %d\n", ret);
+no_cache:
+	ret = -ENOMEDIUM;
+error:
+	printk("FS-Cache: error from cache: %d\n", ret);
 	if (cookie) {
+		up_write(&cookie->sem);
 		__fscache_cookie_put(cookie);
 		cookie = FSCACHE_NEGATIVE_COOKIE;
 		atomic_dec(&iparent->children);
 	}
 
- done:
-	up_write(&cookie->sem);
-	up_read(&fscache_addremove_sem);
-	_leave(" = %p", cookie);
-	return cookie;
+	goto out;
 
 } /* end __fscache_acquire_cookie() */
 
