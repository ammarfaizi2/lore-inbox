Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWCVFGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCVFGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWCVFGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:06:33 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:36490 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750758AbWCVFGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:06:32 -0500
Message-ID: <4420DB55.60803@cosmosbay.com>
Date: Wed, 22 Mar 2006 06:06:29 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use __read_mostly on some hot fs variables
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org> <4417E047.70907@cosmosbay.com> <441EFE05.8040506@cosmosbay.com>
In-Reply-To: <441EFE05.8040506@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------050100030701070404090303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100030701070404090303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I discovered on oprofile hunting on a SMP platform that dentry lookups were 
slowed down because d_hash_mask, d_hash_shift and dentry_hashtable were in a 
cache line that contained inodes_stat. So each time inodes_stats is changed by 
a cpu, other cpus have to refill their cache line.

This patch moves some variables to the __read_mostly section, in order to 
avoid false sharing. RCU dentry lookups can go full speed.

Before someone asks, it is valid to declare a pointer as 'read mostly', even 
if the data pointed by the pointer is heavily modified. hash table pointers 
and kmem_cache pointers are setup at boot time, so they are perfect candidates 
  to 'read_mostly' section. Same apply for 'struct vfsmount *'

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------050100030701070404090303
Content-Type: text/plain;
 name="fs_readmostly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_readmostly.patch"

--- a/fs/dcache.c	2006-03-21 13:48:13.000000000 +0100
+++ b/fs/dcache.c	2006-03-21 13:55:00.000000000 +0100
@@ -36,7 +36,7 @@
 
 /* #define DCACHE_DEBUG 1 */
 
-int sysctl_vfs_cache_pressure = 100;
+int sysctl_vfs_cache_pressure __read_mostly = 100;
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(dcache_lock);
@@ -44,7 +44,7 @@
 
 EXPORT_SYMBOL(dcache_lock);
 
-static kmem_cache_t *dentry_cache; 
+static kmem_cache_t *dentry_cache __read_mostly;
 
 #define DNAME_INLINE_LEN (sizeof(struct dentry)-offsetof(struct dentry,d_iname))
 
@@ -59,9 +59,9 @@
 #define D_HASHBITS     d_hash_shift
 #define D_HASHMASK     d_hash_mask
 
-static unsigned int d_hash_mask;
-static unsigned int d_hash_shift;
-static struct hlist_head *dentry_hashtable;
+static unsigned int d_hash_mask __read_mostly;
+static unsigned int d_hash_shift __read_mostly;
+static struct hlist_head *dentry_hashtable __read_mostly;
 static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
@@ -1706,10 +1706,10 @@
 }
 
 /* SLAB cache for __getname() consumers */
-kmem_cache_t *names_cachep;
+kmem_cache_t *names_cachep __read_mostly;
 
 /* SLAB cache for file structures */
-kmem_cache_t *filp_cachep;
+kmem_cache_t *filp_cachep __read_mostly;
 
 EXPORT_SYMBOL(d_genocide);
 
--- a/fs/inode.c	2006-03-21 13:50:19.000000000 +0100
+++ b/fs/inode.c	2006-03-21 13:54:39.000000000 +0100
@@ -56,8 +56,8 @@
 #define I_HASHBITS	i_hash_shift
 #define I_HASHMASK	i_hash_mask
 
-static unsigned int i_hash_mask;
-static unsigned int i_hash_shift;
+static unsigned int i_hash_mask __read_mostly;
+static unsigned int i_hash_shift __read_mostly;
 
 /*
  * Each inode can be on two separate lists. One is
@@ -73,7 +73,7 @@
 
 LIST_HEAD(inode_in_use);
 LIST_HEAD(inode_unused);
-static struct hlist_head *inode_hashtable;
+static struct hlist_head *inode_hashtable __read_mostly;
 
 /*
  * A simple spinlock to protect the list manipulations.
@@ -98,7 +98,7 @@
  */
 struct inodes_stat_t inodes_stat;
 
-static kmem_cache_t * inode_cachep;
+static kmem_cache_t * inode_cachep __read_mostly;
 
 static struct inode *alloc_inode(struct super_block *sb)
 {
--- a/fs/namespace.c	2006-03-22 05:20:33.000000000 +0100
+++ b/fs/namespace.c	2006-03-22 05:23:40.000000000 +0100
@@ -43,9 +43,9 @@
 
 static int event;
 
-static struct list_head *mount_hashtable;
+static struct list_head *mount_hashtable __read_mostly;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
-static kmem_cache_t *mnt_cache;
+static kmem_cache_t *mnt_cache __read_mostly;
 static struct rw_semaphore namespace_sem;
 
 /* /sys/fs */
--- a/fs/dcookies.c	2006-03-22 05:35:46.000000000 +0100
+++ b/fs/dcookies.c	2006-03-22 05:36:55.000000000 +0100
@@ -37,9 +37,9 @@
 
 static LIST_HEAD(dcookie_users);
 static DECLARE_MUTEX(dcookie_sem);
-static kmem_cache_t * dcookie_cache;
-static struct list_head * dcookie_hashtable;
-static size_t hash_size;
+static kmem_cache_t * dcookie_cache __read_mostly;
+static struct list_head * dcookie_hashtable __read_mostly;
+static size_t hash_size __read_mostly;
 
 static inline int is_live(void)
 {
--- a/fs/fcntl.c	2006-03-22 05:37:40.000000000 +0100
+++ b/fs/fcntl.c	2006-03-22 05:43:49.000000000 +0100
@@ -413,7 +413,7 @@
 
 /* Table to convert sigio signal codes into poll band bitmaps */
 
-static long band_table[NSIGPOLL] = {
+static const long band_table[NSIGPOLL] = {
 	POLLIN | POLLRDNORM,			/* POLL_IN */
 	POLLOUT | POLLWRNORM | POLLWRBAND,	/* POLL_OUT */
 	POLLIN | POLLRDNORM | POLLMSG,		/* POLL_MSG */
@@ -532,7 +532,7 @@
 }
 
 static DEFINE_RWLOCK(fasync_lock);
-static kmem_cache_t *fasync_cache;
+static kmem_cache_t *fasync_cache __read_mostly;
 
 /*
  * fasync_helper() is used by some character device drivers (mainly mice)
--- a/fs/eventpoll.c	2006-03-22 05:39:06.000000000 +0100
+++ b/fs/eventpoll.c	2006-03-22 05:43:49.000000000 +0100
@@ -280,13 +280,13 @@
 static struct poll_safewake psw;
 
 /* Slab cache used to allocate "struct epitem" */
-static kmem_cache_t *epi_cache;
+static kmem_cache_t *epi_cache __read_mostly;
 
 /* Slab cache used to allocate "struct eppoll_entry" */
-static kmem_cache_t *pwq_cache;
+static kmem_cache_t *pwq_cache __read_mostly;
 
 /* Virtual fs used to allocate inodes for eventpoll files */
-static struct vfsmount *eventpoll_mnt;
+static struct vfsmount *eventpoll_mnt __read_mostly;
 
 /* File callbacks that implement the eventpoll file behaviour */
 static struct file_operations eventpoll_fops = {
--- a/fs/inotify.c	2006-03-22 05:40:44.000000000 +0100
+++ b/fs/inotify.c	2006-03-22 05:43:49.000000000 +0100
@@ -40,15 +40,15 @@
 static atomic_t inotify_cookie;
 static atomic_t inotify_watches;
 
-static kmem_cache_t *watch_cachep;
-static kmem_cache_t *event_cachep;
+static kmem_cache_t *watch_cachep __read_mostly;
+static kmem_cache_t *event_cachep __read_mostly;
 
-static struct vfsmount *inotify_mnt;
+static struct vfsmount *inotify_mnt __read_mostly;
 
 /* these are configurable via /proc/sys/fs/inotify/ */
-int inotify_max_user_instances;
-int inotify_max_user_watches;
-int inotify_max_queued_events;
+int inotify_max_user_instances __read_mostly;
+int inotify_max_user_watches __read_mostly;
+int inotify_max_queued_events __read_mostly;
 
 /*
  * Lock ordering:
--- a/fs/locks.c	2006-03-22 05:43:34.000000000 +0100
+++ b/fs/locks.c	2006-03-22 05:43:49.000000000 +0100
@@ -145,7 +145,7 @@
 
 static LIST_HEAD(blocked_list);
 
-static kmem_cache_t *filelock_cache;
+static kmem_cache_t *filelock_cache __read_mostly;
 
 /* Allocate an empty lock structure. */
 static struct file_lock *locks_alloc_lock(void)
--- a/fs/bio.c	2006-03-22 05:44:20.000000000 +0100
+++ b/fs/bio.c	2006-03-22 05:50:37.000000000 +0100
@@ -29,7 +29,7 @@
 
 #define BIO_POOL_SIZE 256
 
-static kmem_cache_t *bio_slab;
+static kmem_cache_t *bio_slab __read_mostly;
 
 #define BIOVEC_NR_POOLS 6
 
@@ -38,7 +38,7 @@
  * basically we just need to survive
  */
 #define BIO_SPLIT_ENTRIES 8	
-mempool_t *bio_split_pool;
+mempool_t *bio_split_pool __read_mostly;
 
 struct biovec_slab {
 	int nr_vecs;
--- a/fs/dnotify.c	2006-03-22 05:46:33.000000000 +0100
+++ b/fs/dnotify.c	2006-03-22 05:50:37.000000000 +0100
@@ -21,9 +21,9 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
-int dir_notify_enable = 1;
+int dir_notify_enable __read_mostly = 1;
 
-static kmem_cache_t *dn_cache;
+static kmem_cache_t *dn_cache __read_mostly;
 
 static void redo_inode_mask(struct inode *inode)
 {
--- a/fs/block_dev.c	2006-03-22 05:48:29.000000000 +0100
+++ b/fs/block_dev.c	2006-03-22 05:50:37.000000000 +0100
@@ -238,7 +238,7 @@
  */
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
-static kmem_cache_t * bdev_cachep;
+static kmem_cache_t * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
@@ -312,7 +312,7 @@
 	.kill_sb	= kill_anon_super,
 };
 
-static struct vfsmount *bd_mnt;
+static struct vfsmount *bd_mnt __read_mostly;
 struct super_block *blockdev_superblock;
 
 void __init bdev_cache_init(void)
--- a/fs/pipe.c	2006-03-22 05:51:16.000000000 +0100
+++ b/fs/pipe.c	2006-03-22 05:54:11.000000000 +0100
@@ -676,7 +676,7 @@
 	return NULL;
 }
 
-static struct vfsmount *pipe_mnt;
+static struct vfsmount *pipe_mnt __read_mostly;
 static int pipefs_delete_dentry(struct dentry *dentry)
 {
 	return 1;

--------------050100030701070404090303--
