Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946328AbWBDHTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946328AbWBDHTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946330AbWBDHTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:19:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20362 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946328AbWBDHTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:19:38 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Fri, 03 Feb 2006 23:19:32 -0800
Message-Id: <20060204071932.10021.62411.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 5/5] cpuset memory spread slab cache hooks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Change the kmem_cache_create calls for certain slab caches to support
cpuset memory spreading.

See the previous patches, cpuset_mem_spread, for an explanation of
cpuset memory spreading, and cpuset_mem_spread_slab_cache for the
slab cache support for memory spreading.

The slag caches marked for now are: dentry_cache, inode_cache,
and buffer_head.  This list may change over time.

Signed-off-by: Paul Jackson

---

 fs/buffer.c |    7 +++++--
 fs/dcache.c |    3 ++-
 fs/inode.c  |    9 +++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

--- 2.6.16-rc1-mm5.orig/fs/dcache.c	2006-02-03 20:14:45.616310776 -0800
+++ 2.6.16-rc1-mm5/fs/dcache.c	2006-02-03 21:56:36.605864543 -0800
@@ -1683,7 +1683,8 @@ static void __init dcache_init(unsigned 
 	dentry_cache = kmem_cache_create("dentry_cache",
 					 sizeof(struct dentry),
 					 0,
-					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
+					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
+					 SLAB_MEM_SPREAD),
 					 NULL, NULL);
 	
 	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
--- 2.6.16-rc1-mm5.orig/fs/inode.c	2006-02-03 20:14:45.619240496 -0800
+++ 2.6.16-rc1-mm5/fs/inode.c	2006-02-03 21:56:36.606841116 -0800
@@ -1376,8 +1376,13 @@ void __init inode_init(unsigned long mem
 	struct shrinker *shrinker;
 
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
 	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 	kmem_set_shrinker(inode_cachep, shrinker);
 
--- 2.6.16-rc1-mm5.orig/fs/buffer.c	2006-02-03 20:14:32.642534053 -0800
+++ 2.6.16-rc1-mm5/fs/buffer.c	2006-02-03 21:56:36.608794263 -0800
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

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
