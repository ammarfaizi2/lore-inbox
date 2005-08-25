Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVHYIpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVHYIpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHYIpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:45:19 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:36273 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964878AbVHYIpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:45:18 -0400
Message-ID: <430D8518.8020502@cosmosbay.com>
Date: Thu, 25 Aug 2005 10:45:12 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] removes filp_count_lock and changes nr_files type to atomic_t
References: <20050824214610.GA3675@localhost.localdomain> <1124956563.3222.8.camel@laptopd505.fenrus.org>
In-Reply-To: <1124956563.3222.8.camel@laptopd505.fenrus.org>
Content-Type: multipart/mixed;
 boundary="------------000900090705070604090406"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 10:45:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900090705070604090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes filp_count_lock spinlock, used to protect files_stat.nr_files.

Just use atomic_t type and atomic_inc()/atomic_dec() operations.

This patch assumes that atomic_read() is a plain {return v->counter;} on all 
architectures. (keywords : sysctl, /proc/sys/fs/file-nr, proc_dointvec)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------000900090705070604090406
Content-Type: text/plain;
 name="patch_filp_count_lock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_filp_count_lock"

diff -Nru linux-2.6.13-rc7/fs/file_table.c linux-2.6.13-rc7-ed/fs/file_table.c
--- linux-2.6.13-rc7/fs/file_table.c	2005-08-24 05:39:14.000000000 +0200
+++ linux-2.6.13-rc7-ed/fs/file_table.c	2005-08-25 10:41:00.000000000 +0200
@@ -28,29 +28,21 @@
 /* public. Not pretty! */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
-static DEFINE_SPINLOCK(filp_count_lock);
 
 /* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
+ * context and must be fully threaded
  */
 void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
+		atomic_inc(&files_stat.nr_files);
 	}
 }
 
 void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
+	atomic_dec(&files_stat.nr_files);
 }
 
 static inline void file_free(struct file *f)
@@ -70,7 +62,7 @@
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files >= files_stat.max_files &&
+	if (atomic_read(&files_stat.nr_files) >= files_stat.max_files &&
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
@@ -94,10 +86,10 @@
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (atomic_read(&files_stat.nr_files) > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
-		old_max = files_stat.nr_files;
+		old_max = atomic_read(&files_stat.nr_files);
 	}
 	goto fail;
 
diff -Nru linux-2.6.13-rc7/fs/xfs/linux-2.6/xfs_linux.h linux-2.6.13-rc7-ed/fs/xfs/linux-2.6/xfs_linux.h
--- linux-2.6.13-rc7/fs/xfs/linux-2.6/xfs_linux.h	2005-08-24 05:39:14.000000000 +0200
+++ linux-2.6.13-rc7-ed/fs/xfs/linux-2.6/xfs_linux.h	2005-08-25 10:41:00.000000000 +0200
@@ -242,7 +242,7 @@
 
 /* IRIX uses the current size of the name cache to guess a good value */
 /* - this isn't the same but is a good enough starting point for now. */
-#define DQUOT_HASH_HEURISTIC	files_stat.nr_files
+#define DQUOT_HASH_HEURISTIC	atomic_read(&files_stat.nr_files)
 
 /* IRIX inodes maintain the project ID also, zero this field on Linux */
 #define DEFAULT_PROJID	0
diff -Nru linux-2.6.13-rc7/include/linux/fs.h linux-2.6.13-rc7-ed/include/linux/fs.h
--- linux-2.6.13-rc7/include/linux/fs.h	2005-08-24 05:39:14.000000000 +0200
+++ linux-2.6.13-rc7-ed/include/linux/fs.h	2005-08-25 10:41:00.000000000 +0200
@@ -30,7 +30,7 @@
 
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
-	int nr_files;		/* read only */
+	atomic_t nr_files;		/* read only */
 	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
 };

--------------000900090705070604090406--
