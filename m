Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUDJX1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDJX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 19:27:13 -0400
Received: from waste.org ([209.173.204.2]:51590 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262119AbUDJX1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 19:27:11 -0400
Date: Sat, 10 Apr 2004 18:27:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] shrink hash sizes on small machines, take 2
Message-ID: <20040410232707.GU6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following attempts to cleanly address the low end of the problem,
something like my calc_hash_order or Marcelo's approach should be used
to attack the upper end of the problem.

8<

Shrink hashes on small systems

Base hash sizes on available memory rather than total memory. An
additional 50% above current used memory is considered reserved for
the purposes of hash sizing to compensate for the hashes themselves
and the remainder of kernel and userspace initialization.

Index: tiny/fs/dcache.c
===================================================================
--- tiny.orig/fs/dcache.c	2004-03-25 13:36:09.000000000 -0600
+++ tiny/fs/dcache.c	2004-04-10 18:14:42.000000000 -0500
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
+#include <linux/swap.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -1619,13 +1620,21 @@
 
 void __init vfs_caches_init(unsigned long mempages)
 {
-	names_cachep = kmem_cache_create("names_cache", 
-			PATH_MAX, 0, 
+	unsigned long reserve;
+
+	/* Base hash sizes on available memory, with a reserve equal to
+           150% of current kernel size */
+
+	reserve = (mempages - nr_free_pages()) * 3/2;
+	mempages -= reserve;
+
+	names_cachep = kmem_cache_create("names_cache",
+			PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!names_cachep)
 		panic("Cannot create names SLAB cache");
 
-	filp_cachep = kmem_cache_create("filp", 
+	filp_cachep = kmem_cache_create("filp",
 			sizeof(struct file), 0,
 			SLAB_HWCACHE_ALIGN, filp_ctor, filp_dtor);
 	if(!filp_cachep)
@@ -1633,7 +1642,7 @@
 
 	dcache_init(mempages);
 	inode_init(mempages);
-	files_init(mempages); 
+	files_init(mempages);
 	mnt_init(mempages);
 	bdev_cache_init();
 	chrdev_init();

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
