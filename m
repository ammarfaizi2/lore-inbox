Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGFxj>; Wed, 7 Feb 2001 00:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129650AbRBGFxU>; Wed, 7 Feb 2001 00:53:20 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:18166 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129028AbRBGFxJ>; Wed, 7 Feb 2001 00:53:09 -0500
Date: Wed, 7 Feb 2001 03:52:58 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-mm@kvack.org
Subject: [PATCH] vm_enough_memory() & i/d cache
Message-ID: <Pine.LNX.4.21.0102070349010.1535-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan,

the attached patch makes vm_enough_memory() take the inode
and dentry cache memory into account so people will again
be able to start 300MB processes on their 384MB machine,
even after slocate has eaten up 100MB in inode and dentry
caches...

It doesn't even try to get the statistics absolutely right,
but in most cases it should be close enough. Please apply
this patch for your next pre-release.


This patch closes the following Linux-MM bugreport:
  http://distro.conectiva.com/bugzilla/show_bug.cgi?id=1174

  (http://www.linux-mm.org/bugzilla.shtml)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.2-pre1/fs/dcache.c.orig	Wed Feb  7 02:21:20 2001
+++ linux-2.4.2-pre1/fs/dcache.c	Wed Feb  7 03:24:54 2001
@@ -52,13 +52,8 @@
 static struct list_head *dentry_hashtable;
 static LIST_HEAD(dentry_unused);
 
-struct {
-	int nr_dentry;
-	int nr_unused;
-	int age_limit;		/* age in seconds */
-	int want_pages;		/* pages requested by system */
-	int dummy[2];
-} dentry_stat = {0, 0, 45, 0,};
+/* Statistics gathering. */
+struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
 /* no dcache_lock, please */
 static inline void d_free(struct dentry *dentry)
--- linux-2.4.2-pre1/fs/inode.c.orig	Wed Feb  7 02:21:26 2001
+++ linux-2.4.2-pre1/fs/inode.c	Wed Feb  7 03:17:42 2001
@@ -67,11 +67,7 @@
 /*
  * Statistics gathering..
  */
-struct {
-	int nr_inodes;
-	int nr_unused;
-	int dummy[5];
-} inodes_stat;
+struct inodes_stat_t inodes_stat;
 
 static kmem_cache_t * inode_cachep;
 
--- linux-2.4.2-pre1/kernel/sysctl.c.orig	Wed Feb  7 03:20:00 2001
+++ linux-2.4.2-pre1/kernel/sysctl.c	Wed Feb  7 03:20:56 2001
@@ -130,9 +130,6 @@
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
 
-extern int inodes_stat[];
-extern int dentry_stat[];
-
 /* The default sysctl tables: */
 
 static ctl_table root_table[] = {
--- linux-2.4.2-pre1/mm/mmap.c.orig	Tue Feb  6 19:20:27 2001
+++ linux-2.4.2-pre1/mm/mmap.c	Wed Feb  7 03:34:13 2001
@@ -12,6 +12,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/file.h>
+#include <linux/fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,15 @@
 	free += atomic_read(&page_cache_size);
 	free += nr_free_pages();
 	free += nr_swap_pages;
+	/*
+	 * The code below doesn't account for free space in the inode
+	 * and dentry slab cache, slab cache fragmentation, inodes and
+	 * dentries which will become freeable under VM load, etc.
+	 * Lets just hope all these (complex) factors balance out...
+	 */
+	free += (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
+	free += (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+
 	return free > pages;
 }
 
--- linux-2.4.2-pre1/include/linux/fs.h.orig	Wed Feb  7 03:08:11 2001
+++ linux-2.4.2-pre1/include/linux/fs.h	Wed Feb  7 03:24:16 2001
@@ -53,6 +53,14 @@
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
+
+struct inodes_stat_t {
+	int nr_inodes;
+	int nr_unused;
+	int dummy[5];
+};
+extern struct inodes_stat_t inodes_stat;
+
 extern int max_super_blocks, nr_super_blocks;
 extern int leases_enable, dir_notify_enable, lease_break_time;
 
--- linux-2.4.2-pre1/include/linux/dcache.h.orig	Wed Feb  7 03:08:19 2001
+++ linux-2.4.2-pre1/include/linux/dcache.h	Wed Feb  7 03:23:12 2001
@@ -27,6 +27,15 @@
 	unsigned int hash;
 };
 
+struct dentry_stat_t {
+	int nr_dentry;
+	int nr_unused;
+	int age_limit;          /* age in seconds */
+	int want_pages;         /* pages requested by system */
+	int dummy[2];
+};
+extern struct dentry_stat_t dentry_stat;
+
 /* Name hashing routines. Initial hash value */
 #define init_name_hash()		0
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
