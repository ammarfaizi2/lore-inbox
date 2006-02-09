Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBISzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBISzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWBISzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:55:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39817 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750713AbWBISy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:58 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:52 -0800
Message-Id: <20060209185452.8596.33015.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 07/07] cpuset memory spread slab cache hooks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Change the kmem_cache_create calls for certain slab caches to
support cpuset memory spreading.

See the previous patches, cpuset_mem_spread, for an explanation
of cpuset memory spreading, and cpuset_mem_spread_slab_cache
for the slab cache support for memory spreading.

The slag caches marked for now are: dentry_cache, inode_cache,
some xfs slab caches, and buffer_head.  This list may change
over time.  In particular, other file system types that are
used extensively on large NUMA systems may want to allow for
spreading their directory and inode slab cache entries.

Signed-off-by: Paul Jackson

---

 fs/buffer.c             |    7 +++++--
 fs/dcache.c             |    3 ++-
 fs/inode.c              |    9 +++++++--
 fs/xfs/linux-2.6/kmem.h |    2 +-
 4 files changed, 15 insertions(+), 6 deletions(-)

--- v2.6.16-rc2.orig/fs/dcache.c	2006-02-08 22:48:26.000000000 -0800
+++ v2.6.16-rc2/fs/dcache.c	2006-02-08 22:48:31.000000000 -0800
@@ -1682,7 +1682,8 @@ static void __init dcache_init(unsigned 
 	dentry_cache = kmem_cache_create("dentry_cache",
 					 sizeof(struct dentry),
 					 0,
-					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
+					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
+					 SLAB_MEM_SPREAD),
 					 NULL, NULL);
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
--- v2.6.16-rc2.orig/fs/inode.c	2006-02-08 22:48:26.000000000 -0800
+++ v2.6.16-rc2/fs/inode.c	2006-02-08 22:48:31.000000000 -0800
@@ -1375,8 +1375,13 @@ void __init inode_init(unsigned long mem
 	int loop;
 
 	/* inode slab cache */
-	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
-				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
+	inode_cachep = kmem_cache_create("inode_cache",
+					 sizeof(struct inode),
+					 0,
+					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
+					 SLAB_MEM_SPREAD),
+					 init_once,
+					 NULL);
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 
 	/* Hash may have been set up in inode_init_early */
--- v2.6.16-rc2.orig/fs/buffer.c	2006-02-08 22:48:26.000000000 -0800
+++ v2.6.16-rc2/fs/buffer.c	2006-02-08 22:48:31.000000000 -0800
@@ -3203,8 +3203,11 @@ void __init buffer_init(void)
 	int nrpages;
 
 	bh_cachep = kmem_cache_create("buffer_head",
-			sizeof(struct buffer_head), 0,
-			SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_buffer_head, NULL);
+					sizeof(struct buffer_head), 0,
+					(SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
+					SLAB_MEM_SPREAD),
+					init_buffer_head,
+					NULL);
 
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
--- v2.6.16-rc2.orig/fs/xfs/linux-2.6/kmem.h	2006-02-08 23:21:56.000000000 -0800
+++ v2.6.16-rc2/fs/xfs/linux-2.6/kmem.h	2006-02-08 23:38:05.000000000 -0800
@@ -102,7 +102,7 @@ extern void  kmem_free(void *, size_t);
 
 #define KM_ZONE_HWALIGN	SLAB_HWCACHE_ALIGN
 #define KM_ZONE_RECLAIM	SLAB_RECLAIM_ACCOUNT
-#define KM_ZONE_SPREAD	0
+#define KM_ZONE_SPREAD	SLAB_MEM_SPREAD
 
 #define kmem_zone	kmem_cache
 #define kmem_zone_t	struct kmem_cache

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
