Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSGTTjw>; Sat, 20 Jul 2002 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSGTTjw>; Sat, 20 Jul 2002 15:39:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51216 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317473AbSGTTjr>; Sat, 20 Jul 2002 15:39:47 -0400
Date: Sat, 20 Jul 2002 16:40:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Ed Tomlinson <tomlins@cam.org>
Subject: [PATCH][1/2] return values shrink_dcache_memory etc
Message-ID: <Pine.LNX.4.44L.0207201639500.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch, against current 2.5.27, builds on the patch that let
kmem_cache_shrink return the number of pages freed. This value
is used as the return value for shrink_dcache_memory and friends.

This is useful not just for more accurate OOM detection, but also as
a preparation for putting these reclaimable slab pages on the LRU list.
This change was originally done by Ed Tomlinson.

please apply,
thank you,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

 fs/dcache.c |    3 +--
 fs/dquot.c  |    3 +--
 fs/inode.c  |    3 +--
 mm/vmscan.c |    6 +++---
 4 files changed, 6 insertions(+), 9 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.661
#	         fs/dcache.c	1.29    -> 1.30
#	          fs/dquot.c	1.43    -> 1.44
#	         mm/vmscan.c	1.85    -> 1.86
#	          fs/inode.c	1.66    -> 1.67
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/19	riel@imladris.surriel.com	1.661
# use the return values from shrink_dcache_memory, shrink_icache_memory
# and shrink_dqcache_memory (thanks to Ed Tomlinson)
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Jul 19 18:22:35 2002
+++ b/fs/dcache.c	Fri Jul 19 18:22:35 2002
@@ -603,8 +603,7 @@
 	count = dentry_stat.nr_unused / priority;

 	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	return kmem_cache_shrink(dentry_cache);
 }

 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Fri Jul 19 18:22:35 2002
+++ b/fs/dquot.c	Fri Jul 19 18:22:35 2002
@@ -498,8 +498,7 @@
 	count = dqstats.free_dquots / priority;
 	prune_dqcache(count);
 	unlock_kernel();
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return kmem_cache_shrink(dquot_cachep);
 }

 /*
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Jul 19 18:22:35 2002
+++ b/fs/inode.c	Fri Jul 19 18:22:35 2002
@@ -431,8 +431,7 @@
 	count = inodes_stat.nr_unused / priority;

 	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	return kmem_cache_shrink(inode_cachep);
 }

 /*
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Jul 19 18:22:35 2002
+++ b/mm/vmscan.c	Fri Jul 19 18:22:35 2002
@@ -389,12 +389,12 @@

 	wakeup_bdflush();

-	shrink_dcache_memory(priority, gfp_mask);
+	nr_pages += shrink_dcache_memory(priority, gfp_mask);

 	/* After shrinking the dcache, get rid of unused inodes too .. */
-	shrink_icache_memory(1, gfp_mask);
+	nr_pages += shrink_icache_memory(1, gfp_mask);
 #ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
+	nr_pages += shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif

 	return nr_pages;


