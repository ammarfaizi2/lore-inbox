Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFSXi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFSXi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 19:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFSXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 19:38:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21517 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261342AbVFSXiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 19:38:17 -0400
Date: Mon, 20 Jun 2005 01:38:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/fscache/: cleanups
Message-ID: <20050619233803.GX21393@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- main.c: remove the unused global variable fscache_debug

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2005

 fs/fscache/cookie.c      |   19 +++++++++++++++----
 fs/fscache/fscache-int.h |   11 -----------
 fs/fscache/main.c        |    2 --
 3 files changed, 15 insertions(+), 17 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/fscache/fscache-int.h.old	2005-04-23 02:53:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/fscache/fscache-int.h	2005-04-23 02:55:11.000000000 +0200
@@ -22,17 +22,6 @@
 
 extern void fscache_cookie_init_once(void *_cookie, kmem_cache_t *cachep, unsigned long flags);
 
-extern void __fscache_cookie_put(struct fscache_cookie *cookie);
-
-static inline void fscache_cookie_put(struct fscache_cookie *cookie)
-{
-	BUG_ON(atomic_read(&cookie->usage) <= 0);
-
-	if (atomic_dec_and_test(&cookie->usage))
-		__fscache_cookie_put(cookie);
-
-}
-
 /*****************************************************************************/
 /*
  * debug tracing
--- linux-2.6.12-rc2-mm3-full/fs/fscache/cookie.c.old	2005-04-23 02:53:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/fscache/cookie.c	2005-04-23 02:55:39.000000000 +0200
@@ -12,14 +12,25 @@
 #include <linux/module.h>
 #include "fscache-int.h"
 
-LIST_HEAD(fscache_netfs_list);
-LIST_HEAD(fscache_cache_list);
-DECLARE_RWSEM(fscache_addremove_sem);
+static LIST_HEAD(fscache_netfs_list);
+static LIST_HEAD(fscache_cache_list);
+static DECLARE_RWSEM(fscache_addremove_sem);
 
 kmem_cache_t *fscache_cookie_jar;
 
 static void fscache_withdraw_node(struct fscache_cache *cache,
 				  struct fscache_node *node);
+static void __fscache_cookie_put(struct fscache_cookie *cookie);
+
+
+static inline void fscache_cookie_put(struct fscache_cookie *cookie)
+{
+	BUG_ON(atomic_read(&cookie->usage) <= 0);
+
+	if (atomic_dec_and_test(&cookie->usage))
+		__fscache_cookie_put(cookie);
+
+}
 
 /*****************************************************************************/
 /*
@@ -925,7 +936,7 @@
 /*
  * destroy a cookie
  */
-void __fscache_cookie_put(struct fscache_cookie *cookie)
+static void __fscache_cookie_put(struct fscache_cookie *cookie)
 {
 	struct fscache_search_result *srch;
 
--- linux-2.6.12-rc2-mm3-full/fs/fscache/main.c.old	2005-04-23 02:55:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/fscache/main.c	2005-04-23 02:56:22.000000000 +0200
@@ -16,8 +16,6 @@
 #include <linux/slab.h>
 #include "fscache-int.h"
 
-int fscache_debug = 0;
-
 static int fscache_init(void);
 static void fscache_exit(void);
 

