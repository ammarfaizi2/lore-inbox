Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSKGDwI>; Wed, 6 Nov 2002 22:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266319AbSKGDwI>; Wed, 6 Nov 2002 22:52:08 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:41857 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266318AbSKGDwG>;
	Wed, 6 Nov 2002 22:52:06 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 1/6: Fix illegal sleep in mbcache. 
From: tytso@mit.edu
Message-Id: <E189doa-0007GY-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:58:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix illegal sleep in mbcache.

This patch from Andreas Gruenbacher fixes an illegal sleep trace.

mbcache.c |   27 +++++++++++++++------------
1 files changed, 15 insertions(+), 12 deletions(-)

diff -Nru a/fs/mbcache.c b/fs/mbcache.c
--- a/fs/mbcache.c	Wed Nov  6 17:29:36 2002
+++ b/fs/mbcache.c	Wed Nov  6 17:29:36 2002
@@ -324,14 +324,6 @@
 		goto fail;
 
 	spin_lock(&mb_cache_spinlock);
-	if (list_empty(&mb_cache_list)) {
-		if (mb_shrinker) {
-			printk(KERN_ERR "%s: already have a shrinker!\n",
-					__FUNCTION__);
-			remove_shrinker(mb_shrinker);
-		}
-		mb_shrinker = set_shrinker(DEFAULT_SEEKS, mb_cache_shrink_fn);
-	}
 	list_add(&cache->c_cache_list, &mb_cache_list);
 	spin_unlock(&mb_cache_spinlock);
 	return cache;
@@ -414,10 +406,6 @@
 		}
 	}
 	list_del(&cache->c_cache_list);
-	if (list_empty(&mb_cache_list) && mb_shrinker) {
-		remove_shrinker(mb_shrinker);
-		mb_shrinker = 0;
-	}
 	spin_unlock(&mb_cache_spinlock);
 
 	l = free_list.prev;
@@ -700,3 +688,18 @@
 }
 
 #endif  /* !defined(MB_CACHE_INDEXES_COUNT) || (MB_CACHE_INDEXES_COUNT > 0) */
+
+static int __init init_mbcache(void)
+{
+	mb_shrinker = set_shrinker(DEFAULT_SEEKS, mb_cache_shrink_fn);
+	return 0;
+}
+
+static void __exit exit_mbcache(void)
+{
+	remove_shrinker(mb_shrinker);
+}
+
+module_init(init_mbcache)
+module_exit(exit_mbcache)
+
