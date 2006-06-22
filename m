Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWFVVbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWFVVbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWFVVbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:31:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14793 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932655AbWFVVbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:31:22 -0400
Date: Thu, 22 Jun 2006 14:31:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Jens Axboe <axboe@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Dave Miller <davem@redhat.com>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20060622213107.32391.63249.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
References: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/4] Create files_init_early()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

files rcu optimization: Creates files_init_early()

This moves the creation of the filp cache into fs/file_table.c

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/include/linux/fs.h	2006-06-22 13:16:13.317087178 -0700
@@ -252,6 +252,7 @@ extern void __init inode_init(unsigned l
 extern void __init inode_init_early(void);
 extern void __init mnt_init(unsigned long);
 extern void __init files_init(unsigned long);
+extern void __init files_init_early(void);
 
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
Index: linux-2.6.17/fs/file_table.c
===================================================================
--- linux-2.6.17.orig/fs/file_table.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/file_table.c	2006-06-22 14:03:54.484771991 -0700
@@ -35,6 +35,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLO
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+void __init files_init_early(void)
+{
+	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+}
+
 static inline void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
Index: linux-2.6.17/fs/dcache.c
===================================================================
--- linux-2.6.17.orig/fs/dcache.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/dcache.c	2006-06-22 13:16:13.319040183 -0700
@@ -1751,9 +1751,7 @@ void __init vfs_caches_init(unsigned lon
 	names_cachep = kmem_cache_create("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-
+	files_init_early();
 	dcache_init(mempages);
 	inode_init(mempages);
 	files_init(mempages);
