Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHaMqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHaMqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWHaMqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:46:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932191AbWHaMqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:46:16 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CacheFiles: Inode count maintenance
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 13:46:03 +0100
Message-ID: <15232.1157028363@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maintain a certain amount of free inode/file space in addition to free disk
space.

The problem is that although CacheFiles makes sure that it leaves a certain
amount of disk space free, and will shrink the cache if necessary, it will
happily eat all the possible inodes on the backing filesystem and will
otherwise sit there doing nothing, despite there being lots of free space and
no free inodes.

This can be tested by setting up a very small cache, for example with:

	dd if=/dev/zero of=/root/fakedisc bs=10240 count=1024
	mke2fs -j /root/fakedisc 
	tune2fs -o user_xattr /root/fakedisc 
	mount -o loop /root/fakedisc /var/fscache/
	cachefilesd

And then running a "find" over a few thousand NFS files on an NFS share that's
mounted with "-o fsc".  This will eventually run the cache out of free inodes,
and ENOSPC will be returned by Ext3 preventing further creation.

As long as there is sufficient free disk space (which there should be), the
cachefiles facility will just sit there rejecting all new requests without
initiating culling.  Once this patch is applied, it will actively begin culling
to reduce the number of inodes it is consuming.

Note that the documentation in the cachefilesd package (now v0.6) has also been
updated to reflect the fact that there are now three new configuration options.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/cachefiles.txt |   36 +++++---
 fs/cachefiles/cf-bind.c                          |   24 +++++
 fs/cachefiles/cf-interface.c                     |   40 ++++++---
 fs/cachefiles/cf-namei.c                         |   12 +++
 fs/cachefiles/cf-proc.c                          |  100 +++++++++++++++++++++-
 fs/cachefiles/internal.h                         |   15 ++-
 6 files changed, 192 insertions(+), 35 deletions(-)

diff --git a/Documentation/filesystems/caching/cachefiles.txt b/Documentation/filesystems/caching/cachefiles.txt
index 37b6385..1aeacf3 100644
--- a/Documentation/filesystems/caching/cachefiles.txt
+++ b/Documentation/filesystems/caching/cachefiles.txt
@@ -77,9 +77,15 @@ set up cache ready for use.  The followi
  (*) brun <N>%
  (*) bcull <N>%
  (*) bstop <N>%
+ (*) frun <N>%
+ (*) fcull <N>%
+ (*) fstop <N>%
 
 	Configure the culling limits.  Optional.  See the section on culling
-	The defaults are 7%, 5% and 1% respectively.
+	The defaults are 7% (run), 5% (cull) and 1% (stop) respectively.
+
+	The commands beginning with a 'b' are file space (block) limits, those
+	beginning with an 'f' are file count limits.
 
  (*) dir <path>
 
@@ -168,31 +174,37 @@ discarding objects from the cache that h
 anything else.  Culling is based on the access time of data objects.  Empty
 directories are culled if not in use.
 
-Cache culling is done on the basis of the percentage of blocks available in the
-underlying filesystem.  There are three "limits":
+Cache culling is done on the basis of the percentage of blocks and the
+percentage of files available in the underlying filesystem.  There are six
+"limits":
 
  (*) brun
+ (*) frun
 
-     If the amount of available space in the cache rises above this limit, then
-     culling is turned off.
+     If the amount of free space and the number of available files in the cache
+     rises above both these limits, then culling is turned off.
 
  (*) bcull
+ (*) fcull
 
-     If the amount of available space in the cache falls below this limit, then
-     culling is started.
+     If the amount of available space or the number of available files in the
+     cache falls below either of these limits, then culling is started.
 
  (*) bstop
+ (*) fstop
 
-     If the amount of available space in the cache falls below this limit, then
-     no further allocation of disk space is permitted until culling has raised
-     the amount above this limit again.
+     If the amount of available space or the number of available files in the
+     cache falls below either of these limits, then no further allocation of
+     disk space or files is permitted until culling has raised things above
+     these limits again.
 
 These must be configured thusly:
 
 	0 <= bstop < bcull < brun < 100
+	0 <= fstop < fcull < frun < 100
 
-Note that these are percentages of available space, and do _not_ appear as 100
-minus the percentage displayed by the "df" program.
+Note that these are percentages of available space and available files, and do
+_not_ appear as 100 minus the percentage displayed by the "df" program.
 
 The userspace daemon scans the cache to build up a table of cullable objects.
 These are then culled in least recently used order.  A new scan of the cache is
diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 5325719..783ff79 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -33,13 +33,21 @@ static int cachefiles_proc_add_cache(str
  */
 int cachefiles_proc_bind(struct cachefiles_cache *cache, char *args)
 {
-	_enter("{%u,%u,%u},%s",
+	_enter("{%u,%u,%u,%u,%u,%u},%s",
+	       cache->frun_percent,
+	       cache->fcull_percent,
+	       cache->fstop_percent,
 	       cache->brun_percent,
 	       cache->bcull_percent,
 	       cache->bstop_percent,
 	       args);
 
 	/* start by checking things over */
+	ASSERT(cache->fstop_percent >= 0 &&
+	       cache->fstop_percent < cache->fcull_percent &&
+	       cache->fcull_percent < cache->frun_percent &&
+	       cache->frun_percent  < 100);
+
 	ASSERT(cache->bstop_percent >= 0 &&
 	       cache->bstop_percent < cache->bcull_percent &&
 	       cache->bcull_percent < cache->brun_percent &&
@@ -178,13 +186,23 @@ static int cachefiles_proc_add_cache(str
 	       (unsigned long long) stats.f_bavail);
 
 	/* set up caching limits */
+	do_div(stats.f_files, 100);
+	cache->fstop = stats.f_files * cache->fstop_percent;
+	cache->fcull = stats.f_files * cache->fcull_percent;
+	cache->frun  = stats.f_files * cache->frun_percent;
+
+	_debug("limits {%llu,%llu,%llu} files",
+	       (unsigned long long) cache->frun,
+	       (unsigned long long) cache->fcull,
+	       (unsigned long long) cache->fstop);
+
 	stats.f_blocks >>= cache->bshift;
 	do_div(stats.f_blocks, 100);
 	cache->bstop = stats.f_blocks * cache->bstop_percent;
 	cache->bcull = stats.f_blocks * cache->bcull_percent;
 	cache->brun  = stats.f_blocks * cache->brun_percent;
 
-	_debug("limits {%llu,%llu,%llu}",
+	_debug("limits {%llu,%llu,%llu} blocks",
 	       (unsigned long long) cache->brun,
 	       (unsigned long long) cache->bcull,
 	       (unsigned long long) cache->bstop);
@@ -232,7 +250,7 @@ static int cachefiles_proc_add_cache(str
 	       cache->cache.identifier);
 
 	/* check how much space the cache has */
-	cachefiles_has_space(cache, 0);
+	cachefiles_has_space(cache, 0, 0);
 
 	return 0;
 
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index 4c0eb31..25fbfab 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -315,18 +315,23 @@ static int cachefiles_set_i_size(struct 
 
 /*****************************************************************************/
 /*
- * see if we have space for a number of pages in the cache
+ * see if we have space for a number of pages and/or a number of files in the
+ * cache
  */
-int cachefiles_has_space(struct cachefiles_cache *cache, unsigned nr)
+int cachefiles_has_space(struct cachefiles_cache *cache,
+			 unsigned fnr, unsigned bnr)
 {
 	struct kstatfs stats;
 	int ret;
 
-	_enter("{%llu,%llu,%llu},%d",
+	_enter("{%llu,%llu,%llu,%llu,%llu,%llu},%u,%u",
+	       (unsigned long long) cache->frun,
+	       (unsigned long long) cache->fcull,
+	       (unsigned long long) cache->fstop,
 	       (unsigned long long) cache->brun,
 	       (unsigned long long) cache->bcull,
 	       (unsigned long long) cache->bstop,
-	       nr);
+	       fnr, bnr);
 
 	/* find out how many pages of blockdev are available */
 	memset(&stats, 0, sizeof(stats));
@@ -340,20 +345,33 @@ int cachefiles_has_space(struct cachefil
 
 	stats.f_bavail >>= cache->bshift;
 
-	_debug("avail %llu", (unsigned long long) stats.f_bavail);
+	_debug("avail %llu,%llu",
+	       (unsigned long long) stats.f_ffree,
+	       (unsigned long long) stats.f_bavail);
 
 	/* see if there is sufficient space */
-	stats.f_bavail -= nr;
+	if (stats.f_ffree > fnr)
+		stats.f_ffree -= fnr;
+	else
+		stats.f_ffree = 0;
+
+	if (stats.f_bavail > bnr)
+		stats.f_bavail -= bnr;
+	else
+		stats.f_bavail = 0;
 
 	ret = -ENOBUFS;
-	if (stats.f_bavail < cache->bstop)
+	if (stats.f_ffree < cache->fstop ||
+	    stats.f_bavail < cache->bstop)
 		goto begin_cull;
 
 	ret = 0;
-	if (stats.f_bavail < cache->bcull)
+	if (stats.f_ffree < cache->fcull ||
+	    stats.f_bavail < cache->bcull)
 		goto begin_cull;
 
 	if (test_bit(CACHEFILES_CULLING, &cache->flags) &&
+	    stats.f_ffree >= cache->frun &&
 	    stats.f_bavail >= cache->brun
 	    ) {
 		if (test_and_clear_bit(CACHEFILES_CULLING, &cache->flags)) {
@@ -731,7 +749,7 @@ static int cachefiles_read_or_alloc_page
 						       page,
 						       &pagevec);
 		ret = 0;
-	} else if (cachefiles_has_space(cache, 1) == 0) {
+	} else if (cachefiles_has_space(cache, 0, 1) == 0) {
 		/* there's space in the cache we can use */
 		pagevec_add(&pagevec, page);
 		cookie->def->mark_pages_cached(cookie->netfs_data,
@@ -1009,7 +1027,7 @@ static int cachefiles_read_or_alloc_page
 		return -ENOBUFS;
 
 	space = 1;
-	if (cachefiles_has_space(cache, *nr_pages) < 0)
+	if (cachefiles_has_space(cache, 0, *nr_pages) < 0)
 		space = 0;
 
 	inode = object->backer->d_inode;
@@ -1118,7 +1136,7 @@ static int cachefiles_allocate_page(stru
 
 	_enter("%p,{%lx},,,", object, page->index);
 
-	return cachefiles_has_space(cache, 1);
+	return cachefiles_has_space(cache, 0, 1);
 
 }
 
diff --git a/fs/cachefiles/cf-namei.c b/fs/cachefiles/cf-namei.c
index 202b89b..570059d 100644
--- a/fs/cachefiles/cf-namei.c
+++ b/fs/cachefiles/cf-namei.c
@@ -373,6 +373,10 @@ lookup_again:
 	if (key || object->type == FSCACHE_COOKIE_TYPE_INDEX) {
 		/* index objects and intervening tree levels must be subdirs */
 		if (!next->d_inode) {
+			ret = cachefiles_has_space(cache, 1, 0);
+			if (ret < 0)
+				goto create_error;
+
 			DQUOT_INIT(dir->d_inode);
 			ret = dir->d_inode->i_op->mkdir(dir->d_inode, next, 0);
 			if (ret < 0)
@@ -395,6 +399,10 @@ lookup_again:
 	} else {
 		/* non-index objects start out life as files */
 		if (!next->d_inode) {
+			ret = cachefiles_has_space(cache, 1, 0);
+			if (ret < 0)
+				goto create_error;
+
 			DQUOT_INIT(dir->d_inode);
 			ret = dir->d_inode->i_op->create(dir->d_inode, next,
 							 S_IFREG, NULL);
@@ -611,6 +619,10 @@ struct dentry *cachefiles_get_directory(
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (!subdir->d_inode) {
+		ret = cachefiles_has_space(cache, 1, 0);
+		if (ret < 0)
+			goto mkdir_error;
+
 		DQUOT_INIT(dir->d_inode);
 		ret = dir->d_inode->i_op->mkdir(dir->d_inode, subdir, 0700);
 		if (ret < 0)
diff --git a/fs/cachefiles/cf-proc.c b/fs/cachefiles/cf-proc.c
index cf246a3..d1635a5 100644
--- a/fs/cachefiles/cf-proc.c
+++ b/fs/cachefiles/cf-proc.c
@@ -28,6 +28,9 @@ static int cachefiles_proc_open(struct i
 static int cachefiles_proc_release(struct inode *, struct file *);
 static ssize_t cachefiles_proc_read(struct file *, char __user *, size_t, loff_t *);
 static ssize_t cachefiles_proc_write(struct file *, const char __user *, size_t, loff_t *);
+static int cachefiles_proc_frun(struct cachefiles_cache *cache, char *args);
+static int cachefiles_proc_fcull(struct cachefiles_cache *cache, char *args);
+static int cachefiles_proc_fstop(struct cachefiles_cache *cache, char *args);
 static int cachefiles_proc_brun(struct cachefiles_cache *cache, char *args);
 static int cachefiles_proc_bcull(struct cachefiles_cache *cache, char *args);
 static int cachefiles_proc_bstop(struct cachefiles_cache *cache, char *args);
@@ -60,6 +63,9 @@ static const struct cachefiles_proc_cmd 
 	{ "cull",	cachefiles_proc_cull	},
 	{ "debug",	cachefiles_proc_debug	},
 	{ "dir",	cachefiles_proc_dir	},
+	{ "frun",	cachefiles_proc_frun	},
+	{ "fcull",	cachefiles_proc_fcull	},
+	{ "fstop",	cachefiles_proc_fstop	},
 	{ "tag",	cachefiles_proc_tag	},
 	{ "",		NULL			}
 };
@@ -94,10 +100,13 @@ static int cachefiles_proc_open(struct i
 	rwlock_init(&cache->active_lock);
 
 	/* set default caching limits
-	 * - limit at 1% free space
-	 * - cull below 5% free space
-	 * - cease culling above 7% free space
+	 * - limit at 1% free space and/or free files
+	 * - cull below 5% free space and/or free files
+	 * - cease culling above 7% free space and/or free files
 	 */
+	cache->frun_percent = 7;
+	cache->fcull_percent = 5;
+	cache->fstop_percent = 1;
 	cache->brun_percent = 7;
 	cache->bcull_percent = 5;
 	cache->bstop_percent = 1;
@@ -153,15 +162,21 @@ static ssize_t cachefiles_proc_read(stru
 		return 0;
 
 	/* check how much space the cache has */
-	cachefiles_has_space(cache, 0);
+	cachefiles_has_space(cache, 0, 0);
 
 	/* summarise */
 	n = snprintf(buffer, sizeof(buffer),
 		     "cull=%c"
+		     " frun=%llx"
+		     " fcull=%llx"
+		     " fstop=%llx"
 		     " brun=%llx"
 		     " bcull=%llx"
 		     " bstop=%llx",
 		     test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
+		     (unsigned long long) cache->frun,
+		     (unsigned long long) cache->fcull,
+		     (unsigned long long) cache->fstop,
 		     (unsigned long long) cache->brun,
 		     (unsigned long long) cache->bcull,
 		     (unsigned long long) cache->bstop
@@ -269,13 +284,88 @@ found_command:
 static int cachefiles_proc_range_error(struct cachefiles_cache *cache, char *args)
 {
 	kerror("Free space limits must be in range"
-	       " 0%%<=bstop<bcull<brun<100%%");
+	       " 0%%<=stop<cull<run<100%%");
 
 	return -EINVAL;
 }
 
 /*****************************************************************************/
 /*
+ * set the percentage of files at which to stop culling
+ * - command: "frun <N>%"
+ */
+static int cachefiles_proc_frun(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long frun;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	frun = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (frun <= cache->fcull_percent || frun >= 100)
+		return cachefiles_proc_range_error(cache, args);
+
+	cache->frun_percent = frun;
+	return 0;
+}
+
+/*****************************************************************************/
+/*
+ * set the percentage of files at which to start culling
+ * - command: "fcull <N>%"
+ */
+static int cachefiles_proc_fcull(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long fcull;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	fcull = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
+		return cachefiles_proc_range_error(cache, args);
+
+	cache->fcull_percent = fcull;
+	return 0;
+}
+
+/*****************************************************************************/
+/*
+ * set the percentage of files at which to stop allocating
+ * - command: "fstop <N>%"
+ */
+static int cachefiles_proc_fstop(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long fstop;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	fstop = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (fstop < 0 || fstop >= cache->fcull_percent)
+		return cachefiles_proc_range_error(cache, args);
+
+	cache->fstop_percent = fstop;
+	return 0;
+}
+
+/*****************************************************************************/
+/*
  * set the percentage of blocks at which to stop culling
  * - command: "brun <N>%"
  */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index edda6e7..dad2dfb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -80,11 +80,17 @@ struct cachefiles_cache {
 	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
 	rwlock_t			active_lock;	/* lock for active_nodes */
 	atomic_t			gravecounter;	/* graveyard uniquifier */
-	unsigned			brun_percent;	/* when to stop culling (%) */
-	unsigned			bcull_percent;	/* when to start culling (%) */
-	unsigned			bstop_percent;	/* when to stop allocating (%) */
+	unsigned			frun_percent;	/* when to stop culling (% files) */
+	unsigned			fcull_percent;	/* when to start culling (% files) */
+	unsigned			fstop_percent;	/* when to stop allocating (% files) */
+	unsigned			brun_percent;	/* when to stop culling (% blocks) */
+	unsigned			bcull_percent;	/* when to start culling (% blocks) */
+	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
 	unsigned			bsize;		/* cache's block size */
 	unsigned			bshift;		/* min(log2 (PAGE_SIZE / bsize), 0) */
+	uint64_t			frun;		/* when to stop culling */
+	uint64_t			fcull;		/* when to start culling */
+	uint64_t			fstop;		/* when to stop allocating */
 	sector_t			brun;		/* when to stop culling */
 	sector_t			bcull;		/* when to start culling */
 	sector_t			bstop;		/* when to stop allocating */
@@ -140,7 +146,8 @@ extern void cachefiles_proc_unbind(struc
 /* cf-interface.c */
 extern void cachefiles_read_copier_work(void *_object);
 extern void cachefiles_write_work(void *_object);
-extern int cachefiles_has_space(struct cachefiles_cache *cache, unsigned nr);
+extern int cachefiles_has_space(struct cachefiles_cache *cache,
+				unsigned fnr, unsigned bnr);
 
 /* cf-key.c */
 extern char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type);
