Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWCUVgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWCUVgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWCUVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:35:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25551 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932460AbWCUVf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:35:56 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org
Subject: [PATCH][RFC] Network filesystem caching on local cache files
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 21 Mar 2006 21:35:32 +0000
Message-ID: <8237.1142976932@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've now prototyped a module to do local caching of network filesystems using
files on an already mounted filesystem (such as using EXT3 files to cache NFS
files).

Currently the module is activated like this:

	insmod cachefiles.ko root=/var/fscache

The cache is then filed in the directory specified as the root. I don't really
like the idea of passing it on the insmod command line, but it's handy for
development. cachefiles requires extended attributes and bmap to be available
on the underlying filesystem.

The cachefiles module requires fscache.ko to be loaded first, as does NFS.

NFS is then told to use fscache by:

	/root/mount warthog:/warthog /warthog -o fsc

I have some performance numbers for this:

 (1) Lookup performance (1KB ext3 blocks):

     Doing a "find" over a 20442 file kernel tree:

	No cache:			10s
	Cold cache:			23s
	Warm cache:			14s

     Note that this is with dir_index and user_xattrs turned on on the
     EXT3 filesystem. Without dir_index, this is really slow.

 (2) Read performance:

     Reading a 100MB file (1KB ext3 blocks):

	No cache:			26s
	Cold cache:			44s
	Warm cache:			19s
	Read cachefile:			15s
	dd /dev/zero to disk file:	14s
	dd disk file to /dev/null:	12s
	dd blockdev to /dev/null:	11s

     Reading a 100MB file (4KB ext3 blocks):

	Cold cache:			35s
	Warm cache:			14s
	Read cachefile:			14s
	dd /dev/zero to disk file:	7s
	dd disk file to /dev/null:	12s

     Reading a 100MB file (freshly prepared CacheFS)

	Cold cache:			27s
	Warm cache:			11s

     Reading a 200MB file (1KB ext3 blocks):

	No cache:			46s
	Cold cache:			79s
	Warm cache:			37s
	Read cachefile:			32s
	dd /dev/zero to disk file:	29s
	dd disk file to /dev/null:	30s
	dd blockdev to /dev/null:	22s

     Reading a 200MB file (4KB ext3 blocks):

	Cold cache:			62s
	Warm cache:			29s
	Read cachefile:			25s
	dd /dev/zero to disk file:	22s
	dd disk file to /dev/null:	23s

     Reading a 200MB file (freshly prepared CacheFS)

	Cold cache:			47s
	Warm cache:			23s

     Or to put it another way:


			       100MB File	       200MB File
			=======================	=======================
			1K Ext3	4K Ext3	CacheFS	1K Ext3	4K Ext3	CacheFS	
			=======	=======	=======	=======	=======	=======	
	No Cache	26	26	26	46	46	46
	Cold Cache	44	35	27	79	62	47
	Warm Cache	19	14	11	37	29	23
	-
	Read Cachefile	15	14	-	32	25	-
	Write Disk File	14	7	-	29	22	-
	Read Disk File	12	12	-	30	23	-
	-
	Read Blockdev	11	11	11	22	22	22


     Note that the 100MB file read could, theoretically, fit entirely within
     the pagecache on my test machine as the machine has 128MB of RAM.
     However, CacheFiles on EXT3 doubles the number of pages required because
     it has separate pages for EXT3 and for NFS and copies between them.


So, having a cold cache on EXT3 is going to affect performance quite a lot.  I
can't contrast CacheFS find performance with CacheFiles yet until I've fixed
using NFS with CacheFS.

A large part of the problem is probably that I'm having to copy all the data
from the NFS pages into the EXT3 pages and back again. I've looked at doing
page stealing, but that's only possible in a tiny set of cases, and in any
case does not help with cold-cache performance. CacheFS almost certainly wins
here since it submits BIOs that run directly to and from the NFS pages.

Note that CacheFS has a problem with fragmentation, and its warm cache
performance degrades over time, and can wind up taking as much as twice as
long to read from disk as to read over the network. Cold cache performance
doesn't seem to be much affected.

These numbers are made with the data being copied from the NFS page to the
EXT3 page inside of the write-to-cache routine (cachefiles_write_page) before
we return to NFS's readpage completion routine. If I defer the copy and have
keventd do it instead, this costs about 2s/100MB. I wonder if this is because
the NFS page is entirely contained within the cache on the CPU at the time
cachefiles_write_page() is called, but that it's been evicted by the time
keventd is scheduled to deal with it.

Note that the attached patch only does the I/O side of things. It does not yet
do cache limit maintenance and culling (much of which will probably be done in
userspace).

The full set of patches can be retrieved from:

	http://people.redhat.com/~dhowells/cachefs/

They are based on Trond's nfs-2.6 git tree.

David


---

 fs/Kconfig                   |   12 
 fs/Makefile                  |    1 
 fs/cachefiles/Makefile       |   13 +
 fs/cachefiles/cf-interface.c | 1034 ++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/cf-main.c      |  245 ++++++++++
 fs/cachefiles/cf-pathwalk.c  |  235 ++++++++++
 fs/cachefiles/cf-xattr.c     |  109 ++++
 fs/cachefiles/internal.h     |  210 +++++++++
 fs/fscache/page.c            |    4 
 fs/nfs/nfs-fscache.c         |    6 
 include/linux/fs.h           |    1 
 include/linux/pagemap.h      |    6 
 mm/filemap.c                 |  102 ++++
 13 files changed, 1972 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 8e74709..787e934 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -526,8 +526,8 @@ config CACHEFS
 	depends on FSCACHE
 	help
 	  This filesystem acts as a cache for other filesystems - primarily
-	  networking filesystems - rather than thus allowing fast local disc to
-	  enhance the speed of slower devices.
+	  networking filesystems - thus allowing fast local disk to enhance the
+	  speed of slower devices.
 
 	  It is a filesystem so that raw block devices can be made use of more
 	  efficiently, without suffering any overhead from intermediary
@@ -540,6 +540,14 @@ config CACHEFS
 
 	  See Documentation/filesystems/caching/cachefs.txt for more information.
 
+config CACHEFILES
+	tristate "Filesystem caching on files"
+	depends on FSCACHE
+	help
+	  This permits use of a mounted filesystem as a cache for other
+	  filesystems - primarily networking filesystems - thus allowing fast
+	  local disk to enhance the speed of slower devices.
+
 endmenu
 
 menu "CD-ROM/DVD Filesystems"
diff --git a/fs/Makefile b/fs/Makefile
index ba610a5..499ef07 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_CACHEFS)		+= cachefs/
+obj-$(CONFIG_CACHEFILES)	+= cachefiles/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
new file mode 100644
index 0000000..683166f
--- /dev/null
+++ b/fs/cachefiles/Makefile
@@ -0,0 +1,13 @@
+#
+# Makefile for caching in a mounted filesystem
+#
+
+#CFLAGS += -finstrument-functions
+
+cachefiles-objs := \
+	cf-xattr.o \
+	cf-interface.o \
+	cf-main.o \
+	cf-pathwalk.o
+
+obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
new file mode 100644
index 0000000..b85533a
--- /dev/null
+++ b/fs/cachefiles/cf-interface.c
@@ -0,0 +1,1034 @@
+/* cf-interface.c: CacheFiles to FS-Cache interface
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include "internal.h"
+
+#define list_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define log2(n) ffz(~(n))
+
+static const char cachefiles_charmap[64] =
+	"0123456789"			/* 0 - 9 */
+	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
+	"_-"				/* 62 - 63 */
+	;
+
+/*****************************************************************************/
+/*
+ * turn the raw key into something cooked
+ * - the key may be up to 514 bytes in length (including the length word)
+ *   - "base64" encode the key, mapping 3 bytes of raw to four of cooked
+ *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
+ */
+static char *cachefiles_cook_key(const u8 *raw, int keylen)
+{
+	unsigned char csum;
+	unsigned int acc;
+	char *key;
+	int loop, len, max, seg;
+
+	_enter(",%d", keylen);
+
+	csum = 0;
+	for (loop = 0; loop < keylen; loop++)
+		csum += raw[loop];
+
+	/* calculate the maximum length of the cooked key */
+	keylen = (keylen + 2) / 3;
+
+	max = keylen * 4;
+	max += 3;	/* checksum/ */
+	max += 2 * 3;	/* maximum number of segment dividers ("+/")
+			 * is ((514 + 188) / 189) = 3
+			 */
+	max += 1;	/* NUL on end */
+
+	_debug("max: %d", max);
+
+	key = kmalloc(max, GFP_KERNEL);
+	if (!key)
+		return NULL;
+
+	len = 0;
+
+	/* build the cooked key */
+	len = 3;
+	sprintf(key, "%02x/", (unsigned) csum);
+
+	seg = 252;
+	for (loop = keylen; loop > 0; loop--) {
+		if (seg <= 0) {
+			key[len++] = '+';
+			key[len++] = '/';
+			seg = 252;
+		}
+
+		acc = *raw++;
+		acc |= *raw++ << 8;
+		acc |= *raw++ << 16;
+
+		_debug("acc: %06x", acc);
+
+		key[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		key[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		key[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		key[len++] = cachefiles_charmap[acc & 63];
+
+		BUG_ON(len >= max);
+	}
+
+	key[len] = 0;
+
+	_leave(" = %p %d:[%s]", key, len, key);
+	return key;
+
+} /* end cachefiles_cook_key() */
+
+/*****************************************************************************/
+/*
+ * look up the nominated node in this cache, creating it if necessary
+ */
+static struct fscache_object *cachefiles_lookup_object(
+	struct fscache_cache *_cache,
+	struct fscache_object *_parent,
+	struct fscache_cookie *cookie)
+{
+	struct cachefiles_object *parent, *object;
+	struct cachefiles_cache *cache;
+	unsigned keylen;
+	void *raw_key;
+	char *key;
+	int ret;
+
+	ASSERT(_parent);
+
+	cache = container_of(_cache, struct cachefiles_cache, cache);
+	parent = container_of(_parent, struct cachefiles_object, fscache);
+
+	//printk("\n");
+	_enter("{%s},%p,%p", cache->cache.identifier, parent, cookie);
+
+	/* create a new object record and a temporary leaf image */
+	object = kmem_cache_alloc(cachefiles_object_jar, SLAB_KERNEL);
+	if (!object)
+		goto nomem_object;
+
+	atomic_set(&object->usage, 1);
+	atomic_set(&object->fscache_usage, 1);
+
+	fscache_object_init(&object->fscache);
+	object->fscache.cookie = cookie;
+	object->fscache.cache = parent->fscache.cache;
+
+	object->type = cookie->def->type;
+
+	/* get hold of the raw key
+	 * - stick the length on the front and leave space on the back for the
+	 *   encoder
+	 */
+	raw_key = kmalloc((512 + 2) + 3, GFP_KERNEL);
+	if (!raw_key)
+		goto nomem_raw_key;
+
+	keylen = cookie->def->get_key(cookie->netfs_data, raw_key + 2, 512);
+	ASSERTCMP(keylen, <, 512);
+
+	*(uint16_t *)raw_key = keylen;
+	((char *)raw_key)[keylen + 2] = 0;
+	((char *)raw_key)[keylen + 3] = 0;
+	((char *)raw_key)[keylen + 4] = 0;
+
+	/* turn the raw key into something that can work with as a filename */
+	key = cachefiles_cook_key(raw_key, keylen + 2);
+	if (!key)
+		goto nomem_key;
+
+	/* look up the key, creating any missing bits */
+	ret = cachefiles_walk_to_object(parent, object, key);
+	if (ret < 0)
+		goto lookup_failed;
+
+	kfree(raw_key);
+	kfree(key);
+	_leave(" = %p", &object->fscache);
+	return &object->fscache;
+
+lookup_failed:
+	kmem_cache_free(cachefiles_object_jar, object);
+	kfree(raw_key);
+	kfree(key);
+	kleave(" = %d", ret);
+	return ERR_PTR(ret);
+
+nomem_key:
+	kfree(raw_key);
+nomem_raw_key:
+	kmem_cache_free(cachefiles_object_jar, object);
+nomem_object:
+	kleave(" = -ENOMEM");
+	return ERR_PTR(-ENOMEM);
+
+} /* end cachefiles_lookup_object() */
+
+/*****************************************************************************/
+/*
+ * increment the usage count on an inode object (may fail if unmounting)
+ */
+static struct fscache_object *cachefiles_grab_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+
+	_enter("%p", _object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->fscache_usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	atomic_inc(&object->fscache_usage);
+	return &object->fscache;
+
+} /* end cachefiles_grab_object() */
+
+/*****************************************************************************/
+/*
+ * lock the semaphore on an object object
+ */
+static void cachefiles_lock_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+
+	_enter("%p", _object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->fscache_usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	down_write(&object->sem);
+
+} /* end cachefiles_lock_object() */
+
+/*****************************************************************************/
+/*
+ * unlock the semaphore on an object object
+ */
+static void cachefiles_unlock_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+
+	_enter("%p", _object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	up_write(&object->sem);
+
+} /* end cachefiles_unlock_object() */
+
+/*****************************************************************************/
+/*
+ * update the auxilliary data for an object object on disk
+ */
+static void cachefiles_update_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	kenter("%p", _object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
+
+	//cachefiles_tree_update_object(super, object);
+
+} /* end cachefiles_update_object() */
+
+/*****************************************************************************/
+/*
+ * dispose of a reference to an object object
+ */
+static void cachefiles_put_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	ASSERT(_object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	_enter("%p{%d}", object, atomic_read(&object->usage));
+
+	ASSERT(object);
+
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->fscache_usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	if (!atomic_dec_and_test(&object->fscache_usage))
+		return;
+
+	_debug("- kill object %p", object);
+
+	/* delete retired objects */
+	if (test_bit(FSCACHE_OBJECT_RECYCLING, &object->fscache.flags) &&
+	    _object != cache->cache.fsdef
+	    ) {
+		kdebug("- retire object %p", object);
+		//cachefiles_tree_delete(cache, object);
+	}
+
+	/* close the filesystem stuff attached to the object */
+	if (object->backer) {
+		if (object->backer->f_op &&
+		    object->backer->f_op->flush)
+			object->backer->f_op->flush(object->backer);
+		fput(object->backer);
+		object->backer = NULL;
+	}
+
+	dput(object->dentry);
+	object->dentry = NULL;
+
+	/* then dispose of the object */
+	kmem_cache_free(cachefiles_object_jar, object);
+
+	_leave("");
+
+} /* end cachefiles_put_object() */
+
+/*****************************************************************************/
+/*
+ * sync a cache
+ */
+static void cachefiles_sync_cache(struct fscache_cache *cache)
+{
+	kenter("%p", cache);
+
+	/* make sure all pages pinned by operations on behalf of the netfs are
+	 * written to disc */
+	//cachefiles_sync(container_of(cache, struct cachefiles_cache, cache), 1, 0);
+
+} /* end cachefiles_sync_cache() */
+
+/*****************************************************************************/
+/*
+ * set the data size on an object
+ */
+static int cachefiles_set_i_size(struct fscache_object *_object, loff_t i_size)
+{
+	struct cachefiles_object *object;
+	struct iattr newattrs;
+	int ret;
+
+	_enter("%p,%llu", _object, i_size);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+	if (i_size == object->i_size)
+		return 0;
+
+	if (!object->backer)
+		return -ENOBUFS;
+
+	ASSERT(S_ISREG(object->backer->f_dentry->d_inode->i_mode));
+
+	newattrs.ia_size = i_size;
+	newattrs.ia_file = object->backer;
+	newattrs.ia_valid = ATTR_SIZE | ATTR_FILE;
+
+	mutex_lock(&object->backer->f_dentry->d_inode->i_mutex);
+	ret = notify_change(object->backer->f_dentry, &newattrs);
+	mutex_unlock(&object->backer->f_dentry->d_inode->i_mutex);
+
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end cachefiles_set_i_size() */
+
+/*****************************************************************************/
+/*
+ * read a page from the cache or allocate a block in which to store it
+ * - cache withdrawal is prevented by the caller
+ * - returns -EINTR if interrupted
+ * - returns -ENOMEM if ran out of memory
+ * - returns -ENOBUFS if no buffers can be made available
+ * - returns -ENOBUFS if page is beyond EOF
+ * - if the page is backed by a block in the cache:
+ *   - the page record will be left attached to the object
+ *   - a read will be started which will call the callback on completion
+ *   - 0 will be returned
+ * - else if the page is unbacked:
+ *   - the metadata will be retained
+ *   - -ENODATA will be returned
+ */
+static int cachefiles_read_or_alloc_page(struct fscache_object *_object,
+					 struct page *page,
+					 fscache_rw_complete_t callback_func,
+					 void *callback_data,
+					 unsigned long gfp)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
+
+	kenter("{%p},{%lx},,,", object, page->index);
+	return -ENOBUFS;
+
+} /* end cachefiles_read_or_alloc_page() */
+
+/*****************************************************************************/
+/*
+ * waiting reading backing files
+ */
+static int cachefiles_read_waiter(wait_queue_t *wait, unsigned mode,
+				  int sync, void *_key)
+{
+	struct cachefiles_one_read *monitor =
+		container_of(wait, struct cachefiles_one_read, monitor);
+	struct wait_bit_key *key = _key;
+	struct page *page = wait->private;
+
+	ASSERT(key);
+
+	_enter("{%lu},%u,%d,{%p,%u}",
+	       monitor->netfs_page->index, mode, sync,
+	       key->flags, key->bit_nr);
+
+	if (key->flags != &page->flags ||
+	    key->bit_nr != PG_locked)
+		return 0;
+
+	_debug("--- monitor ---");
+
+	/* remove from the waitqueue */
+	list_del(&wait->task_list);
+
+	/* move onto the action list and queue for keventd */
+	ASSERT(monitor->object);
+
+	spin_lock(&monitor->object->work_lock);
+	list_move(&monitor->obj_link, &monitor->object->read_list);
+	spin_unlock(&monitor->object->work_lock);
+
+	schedule_work(&monitor->object->read_work);
+
+	return 0;
+
+} /* end cachefiles_read_waiter() */
+
+/*****************************************************************************/
+/*
+ * let keventd drive the copying of pages
+ */
+void cachefiles_read_copier_work(void *_object)
+{
+	struct cachefiles_one_read *monitor;
+	struct cachefiles_object *object = _object;
+	struct fscache_cookie *cookie = object->fscache.cookie;
+	struct pagevec pagevec;
+	void *netdata, *backdata;
+	int error, max;
+
+	_enter("{ino=%lu}", object->backer->f_dentry->d_inode->i_ino);
+
+	pagevec_init(&pagevec, 0);
+
+	max = 8;
+	spin_lock_irq(&object->work_lock);
+
+	while (!list_empty(&object->read_list)) {
+		monitor = list_entry(object->read_list.next,
+				     struct cachefiles_one_read, obj_link);
+		list_del(&monitor->obj_link);
+
+		spin_unlock_irq(&object->work_lock);
+
+		_debug("- copy {%lu}", monitor->back_page->index);
+
+		error = -EIO;
+		if (PageUptodate(monitor->back_page)) {
+			backdata = kmap_atomic(monitor->back_page, KM_USER0);
+			netdata = kmap_atomic(monitor->netfs_page, KM_USER1);
+			copy_page(netdata, backdata);
+			kunmap_atomic(netdata, KM_USER1);
+			kunmap_atomic(backdata, KM_USER0);
+
+			pagevec_add(&pagevec, monitor->netfs_page);
+			cookie->def->mark_pages_cached(
+				cookie->netfs_data,
+				monitor->netfs_page->mapping,
+				&pagevec);
+			pagevec_reinit(&pagevec);
+
+			error = 0;
+		}
+
+		page_cache_release(monitor->back_page);
+
+		monitor->callback_func(monitor->netfs_page,
+				       monitor->callback_data, error);
+
+		page_cache_release(monitor->netfs_page);
+		kfree(monitor);
+
+		/* let keventd have some air occasionally */
+		max--;
+		if (max < 0 || need_resched()) {
+			if (!list_empty(&object->read_list))
+				schedule_work(&object->read_work);
+			_leave(" [maxed out]");
+			return;
+		}
+
+		spin_lock_irq(&object->work_lock);
+	}
+
+	spin_unlock_irq(&object->work_lock);
+
+	_leave("");
+
+} /* end cachefiles_read_copier_work() */
+
+/*****************************************************************************/
+/*
+ * read the corresponding pages to the given set from the backing file
+ * - any uncertain pages are simply discarded, to be tried again another time
+ */
+static noinline
+int cachefiles_read_backing_file(struct cachefiles_object *object,
+				 fscache_rw_complete_t callback_func,
+				 void *callback_data,
+				 struct address_space *mapping,
+				 struct list_head *list,
+				 struct pagevec *lru_pvec)
+{
+	struct cachefiles_one_read *monitor = NULL;
+	struct address_space *bmapping = object->backer->f_mapping;
+	struct page *newpage = NULL, *netpage, *_n, *backpage = NULL;
+	void *netdata, *backdata;
+	int ret = 0;
+
+	_enter("");
+
+	ASSERTCMP(pagevec_count(lru_pvec), ==, 0);
+	pagevec_reinit(lru_pvec);
+
+	list_for_each_entry_safe(netpage, _n, list, lru) {
+		list_del(&netpage->lru);
+
+		_debug("read back %p{%lu,%d}",
+		       netpage, netpage->index, page_count(netpage));
+
+		if (!monitor) {
+			monitor = kzalloc(sizeof(*monitor), GFP_KERNEL);
+			if (!monitor)
+				goto nomem;
+
+			init_waitqueue_func_entry(&monitor->monitor,
+						  cachefiles_read_waiter);
+			monitor->object = object;
+			monitor->callback_func = callback_func;
+			monitor->callback_data = callback_data;
+		}
+
+		for (;;) {
+			backpage = find_get_page(bmapping, netpage->index);
+			if (backpage)
+				goto backing_page_already_present;
+
+			if (!newpage) {
+				newpage = page_cache_alloc_cold(bmapping);
+				if (!newpage)
+					goto nomem;
+			}
+
+			ret = add_to_page_cache(newpage, bmapping,
+						netpage->index, GFP_KERNEL);
+			if (ret == 0)
+				goto installed_new_backing_page;
+			if (ret != -EEXIST)
+				goto nomem;
+		}
+
+		/* we've installed a new backing page, so now we need to add it
+		 * to the LRU list and start it reading */
+	installed_new_backing_page:
+		_debug("- new %p", newpage);
+
+		backpage = newpage;
+		newpage = NULL;
+
+		page_cache_get(backpage);
+		if (!pagevec_add(lru_pvec, backpage))
+			__pagevec_lru_add(lru_pvec);
+
+		ret = bmapping->a_ops->readpage(object->backer, backpage);
+		if (ret < 0)
+			goto read_error;
+
+		/* add the netfs page to the pagecache and LRU, and set the
+		 * monitor to transfer the data across */
+	monitor_backing_page:
+		_debug("- monitor add");
+
+		ret = add_to_page_cache(netpage, mapping, netpage->index,
+					GFP_KERNEL);
+		if (ret < 0) {
+			if (ret == -EEXIST) {
+				page_cache_release(netpage);
+				continue;
+			}
+			goto nomem;
+		}
+
+		page_cache_get(netpage);
+		if (!pagevec_add(lru_pvec, netpage))
+			__pagevec_lru_add(lru_pvec);
+
+		/* install a monitor */
+		page_cache_get(netpage);
+		monitor->netfs_page = netpage;
+
+		page_cache_get(backpage);
+		monitor->back_page = backpage;
+
+		spin_lock_irq(&object->work_lock);
+		list_add_tail(&monitor->obj_link, &object->read_pend_list);
+		spin_unlock_irq(&object->work_lock);
+
+		monitor->monitor.private = backpage;
+		install_page_waitqueue_monitor(backpage, &monitor->monitor);
+		monitor = NULL;
+
+		/* but the page may have been read before the monitor was
+		 * installed, so the monitor may miss the event - so we have to
+		 * ensure that we do get one in such a case */
+		if (!TestSetPageLocked(backpage))
+			unlock_page(backpage);
+
+		page_cache_release(backpage);
+		backpage = NULL;
+
+		page_cache_release(netpage);
+		netpage = NULL;
+		continue;
+
+		/* if the backing page is already present, it can be in one of
+		 * three states: read in progress, read failed or read okay */
+	backing_page_already_present:
+		_debug("- present");
+
+		if (PageError(backpage))
+			goto io_error;
+
+		if (PageUptodate(backpage))
+			goto backing_page_already_uptodate;
+
+		goto monitor_backing_page;
+
+		/* the backing page is already up to date, attach the netfs
+		 * page to the pagecache and LRU and copy the data across */
+	backing_page_already_uptodate:
+		_debug("- uptodate");
+
+		ret = add_to_page_cache(netpage, mapping, netpage->index,
+					GFP_KERNEL);
+		if (ret < 0) {
+			if (ret == -EEXIST) {
+				page_cache_release(netpage);
+				continue;
+			}
+			goto nomem;
+		}
+
+		backdata = kmap_atomic(backpage, KM_USER0);
+		netdata = kmap_atomic(netpage, KM_USER1);
+		copy_page(netdata, backdata);
+		kunmap_atomic(netdata, KM_USER1);
+		kunmap_atomic(backdata, KM_USER0);
+
+		page_cache_release(backpage);
+		backpage = NULL;
+
+		page_cache_get(netpage);
+		if (!pagevec_add(lru_pvec, netpage))
+			__pagevec_lru_add(lru_pvec);
+
+		callback_func(netpage, callback_data, 0);
+
+		page_cache_release(netpage);
+		netpage = NULL;
+		continue;
+	}
+
+	netpage = NULL;
+
+	_debug("out");
+
+out:
+	/* tidy up */
+	pagevec_lru_add(lru_pvec);
+
+	if (newpage)
+		page_cache_release(newpage);
+	if (netpage)
+		page_cache_release(netpage);
+	if (backpage)
+		page_cache_release(backpage);
+	kfree(monitor);
+
+	list_for_each_entry_safe(netpage, _n, list, lru) {
+		list_del(&netpage->lru);
+		page_cache_release(netpage);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+
+nomem:
+	_debug("nomem");
+	ret = -ENOMEM;
+	goto out;
+
+read_error:
+	_debug("read error %d", ret);
+	if (ret == -ENOMEM)
+		goto out;
+io_error:
+	_debug("I/O error");
+	ret = -EIO;
+	goto out;
+
+} /* end cachefiles_read_backing_file() */
+
+/*****************************************************************************/
+/*
+ * read a list of pages from the cache or allocate blocks in which to store
+ * them
+ */
+static int cachefiles_read_or_alloc_pages(struct fscache_object *_object,
+					  struct address_space *mapping,
+					  struct list_head *pages,
+					  unsigned *nr_pages,
+					  fscache_rw_complete_t callback_func,
+					  void *callback_data,
+					  unsigned long gfp)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct fscache_cookie *cookie;
+	struct list_head e3pages;
+	struct pagevec pagevec;
+	struct inode *inode;
+	struct page *page, *_n;
+	unsigned shift, e3nrpages;
+	int ret, ret2;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache, struct cachefiles_cache, cache);
+
+	_enter("{%p},,%d,,", object, *nr_pages);
+
+	if (!object->backer)
+		return -ENOBUFS;
+
+	inode = object->backer->f_dentry->d_inode;
+	ASSERT(S_ISREG(inode->i_mode));
+	ASSERT(inode->i_mapping->a_ops->bmap);
+	ASSERT(inode->i_mapping->a_ops->readpages);
+
+	/* calculate the shift required to use bmap */
+	if (inode->i_sb->s_blocksize > PAGE_SIZE)
+		return -ENOBUFS;
+
+	shift = log2(PAGE_SIZE / inode->i_sb->s_blocksize);
+
+	pagevec_init(&pagevec, 0);
+
+	cookie = object->fscache.cookie;
+
+	INIT_LIST_HEAD(&e3pages);
+	e3nrpages = 0;
+
+	list_for_each_entry_safe(page, _n, pages, lru) {
+		sector_t block0, e3block;
+
+		/* we assume the absence or presence of the first block is a
+		 * good enough indication for the page as a whole
+		 * - TODO: don't use bmap() for this as it is _not_ actually
+		 *   good enough for this as it doesn't indicate errors, but
+		 *   it's all we've got for the moment
+		 */
+		block0 = page->index;
+		block0 <<= shift;
+
+		e3block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
+							block0);
+		_debug("%llx -> %llx", block0, e3block);
+
+		if (e3block) {
+			/* we have data - add it to the list to give to the
+			 * backing fs */
+			list_move(&page->lru, &e3pages);
+			(*nr_pages)--;
+			e3nrpages++;
+		}
+		else if (pagevec_add(&pagevec, page) == 0) {
+			cookie->def->mark_pages_cached(cookie->netfs_data,
+						       mapping, &pagevec);
+			pagevec_reinit(&pagevec);
+		}
+	}
+
+	if (pagevec_count(&pagevec) > 0) {
+		cookie->def->mark_pages_cached(cookie->netfs_data,
+					       mapping, &pagevec);
+		pagevec_reinit(&pagevec);
+	}
+
+	ret = -ENODATA;
+	if (list_empty(pages))
+		ret = 0;
+
+	/* submit the apparently valid pages to the backing fs to be read from disk */
+	if (e3nrpages > 0) {
+		ret2 = cachefiles_read_backing_file(object,
+						    callback_func,
+						    callback_data,
+						    mapping,
+						    &e3pages,
+						    &pagevec);
+
+		ASSERTCMP(pagevec_count(&pagevec), ==, 0);
+
+		if (ret2 == -ENOMEM || ret2 == -EINTR)
+			ret = ret2;
+	}
+
+	_leave(" = %d [nr=%u%s]",
+	       ret, *nr_pages, list_empty(pages) ? " empty" : "");
+	return ret;
+
+} /* end cachefiles_read_or_alloc_pages() */
+
+/*****************************************************************************/
+/*
+ * read a page from the cache or allocate a block in which to store it
+ * - cache withdrawal is prevented by the caller
+ * - returns -EINTR if interrupted
+ * - returns -ENOMEM if ran out of memory
+ * - returns -ENOBUFS if no buffers can be made available
+ * - returns -ENOBUFS if page is beyond EOF
+ * - otherwise:
+ *   - the metadata will be retained
+ *   - 0 will be returned
+ */
+static int cachefiles_allocate_page(struct fscache_object *_object,
+				    struct page *page,
+				    unsigned long gfp)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	_enter("%p,{%lx},,,", object, page->index);
+	return -ENOBUFS;
+
+} /* end cachefiles_allocate_page() */
+
+/*****************************************************************************/
+/*
+ * page storer
+ */
+void cachefiles_write_work(void *_object)
+{
+	struct cachefiles_one_write *writer;
+	struct cachefiles_object *object = _object;
+	int ret, max;
+
+	_enter("%p", object);
+
+	ASSERT(!irqs_disabled());
+	
+	spin_lock_irq(&object->work_lock);
+	max = 8;
+
+	while (!list_empty(&object->write_list)) {
+		writer = list_entry(object->write_list.next,
+				    struct cachefiles_one_write, obj_link);
+		list_del(&writer->obj_link);
+
+		spin_unlock_irq(&object->work_lock);
+
+		_debug("- store {%lu}", writer->netfs_page->index);
+
+		ret = generic_file_buffered_write_one_kernel_page(
+			object->backer,
+			writer->netfs_page->index,
+			writer->netfs_page);
+
+		if (ret == -ENOSPC)
+			ret = -ENOBUFS;
+
+		_debug("- callback");
+		writer->callback_func(writer->netfs_page,
+				      writer->callback_data, ret);
+
+		_debug("- put net");
+		page_cache_release(writer->netfs_page);
+		kfree(writer);
+
+		/* let keventd have some air occasionally */
+		max--;
+		if (max < 0 || need_resched()) {
+			if (!list_empty(&object->write_list))
+				schedule_work(&object->write_work);
+			_leave(" [maxed out]");
+			return;
+		}
+
+		_debug("- next");
+		spin_lock_irq(&object->work_lock);
+	}
+
+	spin_unlock_irq(&object->work_lock);
+	_leave("");
+
+} /* end cachefiles_write_work() */
+
+/*****************************************************************************/
+/*
+ * request a page be stored in the cache
+ * - cache withdrawal is prevented by the caller
+ * - this request may be ignored if there's no cache block available, in which
+ *   case -ENOBUFS will be returned
+ * - if the op is in progress, 0 will be returned
+ */
+static int cachefiles_write_page(struct fscache_object *_object,
+				 struct page *page,
+				 fscache_rw_complete_t callback_func,
+				 void *callback_data,
+				 unsigned long gfp)
+{
+	struct cachefiles_one_write *writer;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	int ret;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	_enter("%p,%p{%lx},,,", object, page, page->index);
+
+	if (!object->backer)
+		return -ENOBUFS;
+
+	ASSERT(S_ISREG(object->backer->f_dentry->d_inode->i_mode));
+
+#if 0 // set to 1 for deferred writing
+	/* queue the operation for deferred processing by keventd */
+	writer = kzalloc(sizeof(*writer), GFP_KERNEL);
+	if (!writer)
+		return -ENOMEM;
+
+	page_cache_get(page);
+	writer->netfs_page = page;
+	writer->object = object;
+	writer->callback_func = callback_func;
+	writer->callback_data = callback_data;
+
+	spin_lock_irq(&object->work_lock);
+	list_add_tail(&writer->obj_link, &object->write_list);
+	spin_unlock_irq(&object->work_lock);
+
+	schedule_work(&object->write_work);
+	ret = 0;
+
+#else
+	/* copy the page to ext3 and let it store it in its own time */
+	ret = generic_file_buffered_write_one_kernel_page(object->backer,
+							  page->index,
+							  page);
+
+	if (ret != 0)
+		ret = -ENOBUFS;
+
+	callback_func(page, callback_data, ret);
+#endif
+
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end cachefiles_write_page() */
+
+/*****************************************************************************/
+/*
+ * detach a backing block from a page
+ * - cache withdrawal is prevented by the caller
+ */
+static void cachefiles_uncache_pages(struct fscache_object *_object,
+				     struct pagevec *pagevec)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	_enter("%p,{%lu,%lx},,,",
+	       object, pagevec->nr, pagevec->pages[0]->index);
+
+} /* end cachefiles_uncache_pages() */
+
+/*****************************************************************************/
+/*
+ * dissociate a cache from all the pages it was backing
+ */
+static void cachefiles_dissociate_pages(struct fscache_cache *cache)
+{
+	_enter("");
+
+} /* end cachefiles_dissociate_pages() */
+
+struct fscache_cache_ops cachefiles_cache_ops = {
+	.name			= "cachefiles",
+	.lookup_object		= cachefiles_lookup_object,
+	.grab_object		= cachefiles_grab_object,
+	.lock_object		= cachefiles_lock_object,
+	.unlock_object		= cachefiles_unlock_object,
+	.update_object		= cachefiles_update_object,
+	.put_object		= cachefiles_put_object,
+	.sync_cache		= cachefiles_sync_cache,
+	.set_i_size		= cachefiles_set_i_size,
+	.read_or_alloc_page	= cachefiles_read_or_alloc_page,
+	.read_or_alloc_pages	= cachefiles_read_or_alloc_pages,
+	.allocate_page		= cachefiles_allocate_page,
+	.write_page		= cachefiles_write_page,
+	.uncache_pages		= cachefiles_uncache_pages,
+	.dissociate_pages	= cachefiles_dissociate_pages,
+};
diff --git a/fs/cachefiles/cf-main.c b/fs/cachefiles/cf-main.c
new file mode 100644
index 0000000..624ea75
--- /dev/null
+++ b/fs/cachefiles/cf-main.c
@@ -0,0 +1,245 @@
+/* cf-main.c: network filesystem caching backend to use cache files on a
+ *            premounted filesystem
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include "internal.h"
+
+int cachefiles_debug = 0;
+
+static int cachefiles_init(void);
+static void cachefiles_exit(void);
+
+fs_initcall(cachefiles_init);
+module_exit(cachefiles_exit);
+
+MODULE_DESCRIPTION("Mounted filesystem-based cache");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+static char cachefiles_root_dirname[PATH_MAX];
+static char cachefiles_tag[256] = "CacheFiles";
+
+module_param_string(root, cachefiles_root_dirname, PATH_MAX, 0);
+MODULE_PARM_DESC(cachefiles_root_dirname, "Root directory for cache files tree");
+
+module_param_string(tag, cachefiles_tag, sizeof(cachefiles_tag), 0);
+MODULE_PARM_DESC(cachefiles_tag, "FS-Cache tag for this cache");
+
+
+static struct cachefiles_cache cachefiles_cache;
+kmem_cache_t *cachefiles_object_jar;
+
+static void cachefiles_object_init_once(void *_object, kmem_cache_t *cachep,
+					unsigned long flags)
+{
+	struct cachefiles_object *object = _object;
+
+	switch (flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) {
+	case SLAB_CTOR_CONSTRUCTOR:
+		memset(object, 0, sizeof(*object));
+		fscache_object_init(&object->fscache);
+		init_rwsem(&object->sem);
+		spin_lock_init(&object->work_lock);
+		INIT_LIST_HEAD(&object->read_list);
+		INIT_LIST_HEAD(&object->read_pend_list);
+		INIT_WORK(&object->read_work, &cachefiles_read_copier_work,
+			  object);
+		INIT_LIST_HEAD(&object->write_list);
+		INIT_WORK(&object->write_work, &cachefiles_write_work, object);
+		break;
+	default:
+		break;
+	}
+}
+
+/*****************************************************************************/
+/*
+ * initialise the fs caching module
+ */
+static int cachefiles_init(void)
+{
+	struct cachefiles_object *fsdef;
+	struct nameidata nd;
+	int ret;
+
+	printk("\n");
+	printk("\n");
+	printk("----------------------------------------------------------------------\n");
+	printk("\n");
+
+	if (!cachefiles_root_dirname[0]) {
+		printk(KERN_ERR "CacheFiles: no cache directory specified\n");
+		return -EINVAL;
+	}
+
+	if (!cachefiles_tag[0]) {
+		printk(KERN_ERR "CacheFiles: empty tag specified\n");
+		return -EINVAL;
+	}
+
+	/* create an object jar */
+	ret = -ENOMEM;
+
+	cachefiles_object_jar =
+		kmem_cache_create("cachefiles_object_jar",
+				  sizeof(struct cachefiles_object),
+				  0,
+				  SLAB_HWCACHE_ALIGN,
+				  cachefiles_object_init_once,
+				  NULL);
+	if (!cachefiles_object_jar) {
+		printk(KERN_NOTICE
+		       "CacheFiles: Failed to allocate an object jar\n");
+		goto error_object_jar;
+	}
+
+	/* allocate the root index object */
+	fsdef = kmem_cache_alloc(cachefiles_object_jar, SLAB_KERNEL);
+	if (!fsdef)
+		goto error_root_object;
+
+	atomic_set(&fsdef->usage, 1);
+	atomic_set(&fsdef->fscache_usage, 1);
+	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
+
+	_debug("- fsdef %p", fsdef);
+
+	/* open the caching directory */
+	cachefiles_cache.rootdirname = cachefiles_root_dirname;
+
+	memset(&nd, 0, sizeof(nd));
+
+	ret = path_lookup(cachefiles_cache.rootdirname, LOOKUP_DIRECTORY, &nd);
+	if (ret < 0)
+		goto error_open_root;
+
+	cachefiles_cache.mnt = mntget(nd.mnt);
+	fsdef->dentry = dget(nd.dentry);
+	path_release(&nd);
+
+	if (!fsdef->dentry->d_inode ||
+	    !fsdef->dentry->d_inode->i_op ||
+	    !fsdef->dentry->d_inode->i_op->mkdir ||
+	    !fsdef->dentry->d_inode->i_op->setxattr ||
+	    !fsdef->dentry->d_inode->i_op->getxattr
+	    ) {
+		ret = -EOPNOTSUPP;
+		goto error_unsupported;
+	}
+
+	/* check the type of the cache */
+	ret = cachefiles_check_object_type(fsdef);
+	if (ret < 0)
+		goto error_unsupported;
+
+	/* publish the cache */
+	fscache_init_cache(&cachefiles_cache.cache,
+			   &cachefiles_cache_ops,
+			   "%02x:%02x",
+			   MAJOR(fsdef->dentry->d_sb->s_dev),
+			   MINOR(fsdef->dentry->d_sb->s_dev)
+			   );
+
+	ret = fscache_add_cache(&cachefiles_cache.cache,
+				&fsdef->fscache,
+				cachefiles_tag);
+	if (ret < 0)
+		goto error_add_cache;
+
+	/* done */
+	printk(KERN_INFO
+	       "CacheFiles: general fs caching (cachefiles) registered\n");
+	return 0;
+
+error_add_cache:
+error_unsupported:
+	mntput(cachefiles_cache.mnt);
+	dput(fsdef->dentry);
+error_open_root:
+	kmem_cache_free(cachefiles_object_jar, fsdef);
+error_root_object:
+	kmem_cache_destroy(cachefiles_object_jar);
+error_object_jar:
+	printk(KERN_ERR "CacheFiles: failed to register: %d\n", ret);
+	return ret;
+
+} /* end cachefiles_init() */
+
+/*****************************************************************************/
+/*
+ * clean up on module removal
+ */
+static void __exit cachefiles_exit(void)
+{
+	printk(KERN_INFO
+	       "CacheFiles: general fs caching (cachefiles) unregistering\n");
+
+	fscache_withdraw_cache(&cachefiles_cache.cache);
+	cachefiles_cache.cache.ops->put_object(cachefiles_cache.cache.fsdef);
+	mntput(cachefiles_cache.mnt);
+
+	kmem_cache_destroy(cachefiles_object_jar);
+
+} /* end cachefiles_exit() */
+
+/*****************************************************************************/
+/*
+ * clear the dead space between task_struct and kernel stack
+ * - called by supplying -finstrument-functions to gcc
+ */
+#if 0
+void __cyg_profile_func_enter (void *this_fn, void *call_site)
+__attribute__((no_instrument_function));
+
+void __cyg_profile_func_enter (void *this_fn, void *call_site)
+{
+       asm volatile("  movl    %%esp,%%edi     \n"
+                    "  andl    %0,%%edi        \n"
+                    "  addl    %1,%%edi        \n"
+                    "  movl    %%esp,%%ecx     \n"
+                    "  subl    %%edi,%%ecx     \n"
+                    "  shrl    $2,%%ecx        \n"
+                    "  movl    $0xedededed,%%eax     \n"
+                    "  rep stosl               \n"
+                    :
+                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
+                    : "eax", "ecx", "edi", "memory", "cc"
+                    );
+}
+
+void __cyg_profile_func_exit(void *this_fn, void *call_site)
+__attribute__((no_instrument_function));
+
+void __cyg_profile_func_exit(void *this_fn, void *call_site)
+{
+       asm volatile("  movl    %%esp,%%edi     \n"
+                    "  andl    %0,%%edi        \n"
+                    "  addl    %1,%%edi        \n"
+                    "  movl    %%esp,%%ecx     \n"
+                    "  subl    %%edi,%%ecx     \n"
+                    "  shrl    $2,%%ecx        \n"
+                    "  movl    $0xdadadada,%%eax     \n"
+                    "  rep stosl               \n"
+                    :
+                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
+                    : "eax", "ecx", "edi", "memory", "cc"
+                    );
+}
+#endif
diff --git a/fs/cachefiles/cf-pathwalk.c b/fs/cachefiles/cf-pathwalk.c
new file mode 100644
index 0000000..8ab0e8e
--- /dev/null
+++ b/fs/cachefiles/cf-pathwalk.c
@@ -0,0 +1,235 @@
+/* cf-pathwalk.c: CacheFiles pathwalk
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/quotaops.h>
+#include <linux/xattr.h>
+#include <linux/mount.h>
+#include "internal.h"
+
+/*****************************************************************************/
+/*
+ * walk from the parent object to the child object through the backing
+ * filesystem, creating directories as we go
+ */
+int cachefiles_walk_to_object(struct cachefiles_object *parent,
+			      struct cachefiles_object *object,
+			      char *key)
+{
+	struct cachefiles_cache *cache;
+	struct dentry *dir, *next = NULL, *new;
+	struct file *file;
+	struct qstr name;
+	int ret;
+
+	_enter("{%p}", parent->dentry);
+
+	ASSERT(parent->dentry);
+	ASSERT(parent->dentry->d_inode);
+
+	if (!(S_ISDIR(parent->dentry->d_inode->i_mode))) {
+		// TODO: convert file to dir
+		kleave("looking up in none directory");
+		return -ENOBUFS;
+	}
+
+	dir = dget(parent->dentry);
+
+advance:
+	/* attempt to transit the first directory component */
+	name.name = key;
+	key = strchr(key, '/');
+	if (key) {
+		name.len = key - (char *) name.name;
+		*key++ = 0;
+	}
+	else {
+		name.len = strlen(name.name);
+	}
+
+	/* hash the name */
+	name.hash = full_name_hash(name.name, name.len);
+
+	if (dir->d_op && dir->d_op->d_hash) {
+		ret = dir->d_op->d_hash(dir, &name);
+		if (ret < 0) {
+			dput(dir);
+			kleave(" = %d", ret);
+			return ret;
+		}
+	}
+
+	/* search the current directory for the element name */
+	_debug("lookup '%s' %x", name.name, name.hash);
+
+	mutex_lock(&dir->d_inode->i_mutex);
+
+	next = d_lookup(dir, &name);
+	if (!next) {
+		_debug("not found");
+
+		new = d_alloc(dir, &name);
+		if (!new)
+			goto nomem_d_alloc;
+
+		ASSERT(dir->d_inode->i_op);
+		ASSERT(dir->d_inode->i_op->lookup);
+
+		next = dir->d_inode->i_op->lookup(dir->d_inode, new, NULL);
+		if (IS_ERR(next))
+			goto lookup_error;
+
+		if (!next)
+			next = new;
+		else
+			dput(new);
+
+		if (next->d_inode) {
+			ret = -EPERM;
+			if (!next->d_inode->i_op ||
+			    !next->d_inode->i_op->setxattr ||
+			    !next->d_inode->i_op->getxattr)
+				goto error;
+
+			if (key && (!next->d_inode->i_op->mkdir ||
+				    !next->d_inode->i_op->create))
+				goto error;
+		}
+	}
+
+	_debug("next -> %p %s", next, next->d_inode ? "positive" : "negative");
+
+	/* we need to create the object if it's negative */
+	if (object->type == FSCACHE_COOKIE_TYPE_INDEX || key) {
+		/* index objects and intervening tree levels must be subdirs */
+		if (!next->d_inode) {
+			DQUOT_INIT(dir);
+			ret = dir->d_inode->i_op->mkdir(dir->d_inode, next, 0);
+			if (ret < 0)
+				goto error;
+
+			ASSERT(next->d_inode);
+
+			fsnotify_mkdir(dir->d_inode, next->d_name.name);
+
+			_debug("mkdir -> %p{%p{ino=%lu}}",
+			       next, next->d_inode, next->d_inode->i_ino);
+		}
+		/* we need to make sure a positive match found a directory */
+		else if (!S_ISDIR(next->d_inode->i_mode)) {
+			printk(KERN_ERR
+			       "CacheFiles: inode %lu is not a directory\n",
+			       next->d_inode->i_ino);
+			ret = -ENOBUFS;
+			goto error;
+		}
+	}
+	else {
+		/* non-index objects start out life as files */
+		if (!next->d_inode) {
+			DQUOT_INIT(dir);
+			ret = dir->d_inode->i_op->create(dir->d_inode, next,
+							 S_IFREG, NULL);
+			if (ret < 0)
+				goto error;
+
+			ASSERT(next->d_inode);
+
+			fsnotify_create(dir->d_inode, next->d_name.name);
+
+			_debug("create -> %p{%p{ino=%lu}}",
+			       next, next->d_inode, next->d_inode->i_ino);
+		}
+		/* we need to make sure a positive match found a directory or a
+		 * file */
+		else if (!S_ISDIR(next->d_inode->i_mode) &&
+			 !S_ISREG(next->d_inode->i_mode)
+			 ) {
+			printk(KERN_ERR
+			       "CacheFiles:"
+			       " inode %lu is not a file or directory\n",
+			       next->d_inode->i_ino);
+			ret = -ENOBUFS;
+			goto error;
+		}
+	}
+
+	/* process the next component */
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(dir);
+
+	if (key) {
+		_debug("advance");
+		dir = next;
+		next = NULL;
+		goto advance;
+	}
+
+	dir = NULL;
+
+	/* we've found the object we were looking for */
+	object->dentry = next;
+
+	ret = cachefiles_check_object_type(object);
+	if (ret < 0)
+		goto check_error;
+
+	/* open a file interface onto a data file */
+	if (object->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		if (S_ISREG(object->dentry->d_inode->i_mode)) {
+			cache = container_of(object->fscache.cache,
+					     struct cachefiles_cache, cache);
+
+			file = dentry_open(dget(object->dentry),
+					   mntget(cache->mnt), 0);
+			if (IS_ERR(file))
+				goto open_error;
+
+			object->backer = file;
+		}
+		else {
+			BUG(); // TODO: open file in data-class subdir
+		}
+	}
+
+	_leave(" = 0 [%lu]", object->dentry->d_inode->i_ino);
+	return 0;
+
+open_error:
+	ret = PTR_ERR(file);
+check_error:
+	dput(object->dentry);
+	object->dentry = NULL;
+	goto error_out;
+
+lookup_error:
+	kdebug("lookup error %ld", PTR_ERR(next));
+
+	dput(new);
+	ret = PTR_ERR(next);
+	next = NULL;
+	goto error;
+
+nomem_d_alloc:
+	ret = -ENOMEM;
+error:
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(next);
+	dput(dir);
+error_out:
+	kleave(" = ret");
+	return ret;
+
+} /* end cachefiles_walk_to_object() */
diff --git a/fs/cachefiles/cf-xattr.c b/fs/cachefiles/cf-xattr.c
new file mode 100644
index 0000000..0112818
--- /dev/null
+++ b/fs/cachefiles/cf-xattr.c
@@ -0,0 +1,109 @@
+/* cf-xattr.c: CacheFiles extended attribute management
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/quotaops.h>
+#include <linux/xattr.h>
+#include "internal.h"
+
+static const char cachefiles_xattr_type[] = XATTR_USER_PREFIX "CacheFiles.type";
+static const char cachefiles_xattr_netfs[] = XATTR_USER_PREFIX "CacheFiles.netfs";
+
+/*****************************************************************************/
+/*
+ * check the type label on an object
+ * - done using xattrs
+ */
+int cachefiles_check_object_type(struct cachefiles_object *object)
+{
+	struct dentry *dentry = object->dentry;
+	char type[3], xtype[3];
+	int ret;
+
+	ASSERT(dentry);
+	ASSERT(dentry->d_inode);
+	ASSERT(dentry->d_inode->i_op);
+	ASSERT(dentry->d_inode->i_op->setxattr);
+	ASSERT(dentry->d_inode->i_op->getxattr);
+
+	if (!object->fscache.cookie)
+		strcpy(type, "C3");
+	else
+		snprintf(type, 3, "%02x", object->fscache.cookie->def->type);
+
+	_enter("%p{%s}", object, type);
+
+	mutex_lock(&dentry->d_inode->i_mutex);
+
+	/* attempt to install a type label directly */
+	ret = dentry->d_inode->i_op->setxattr(dentry, cachefiles_xattr_type,
+					      type, 2, XATTR_CREATE);
+	if (ret == 0) {
+		_debug("SET");
+		fsnotify_xattr(dentry);
+		mutex_unlock(&dentry->d_inode->i_mutex);
+		goto error;
+	}
+
+	if (ret != -EEXIST) {
+		printk(KERN_ERR
+		       "CacheFiles: can't set xattr on %lu (err %d)\n",
+		       dentry->d_inode->i_ino, -ret);
+		goto error;
+	}
+
+	/* read the current type label */
+	ret = dentry->d_inode->i_op->getxattr(dentry, cachefiles_xattr_type,
+					      xtype, 3);
+	if (ret < 0) {
+		if (ret == -ERANGE)
+			goto bad_type_length;
+
+		printk(KERN_ERR
+		       "CacheFiles: can't read xattr on %lu (err %d)\n",
+		       dentry->d_inode->i_ino, -ret);
+		goto error;
+	}
+
+	/* check the type is what we're expecting */
+	if (ret != 2)
+		goto bad_type_length;
+
+	if (xtype[0] != type[0] || xtype[1] != type[1])
+		goto bad_type;
+
+	ret = 0;
+
+error:
+	mutex_unlock(&dentry->d_inode->i_mutex);
+	_leave(" = %d", ret);
+	return ret;
+
+bad_type_length:
+	printk(KERN_ERR
+	       "CacheFiles: cache object %lu type xattr length incorrect\n",
+	       dentry->d_inode->i_ino);
+	ret = -EIO;
+	goto error;
+
+bad_type:
+	xtype[2] = 0;
+	printk(KERN_ERR
+	       "CacheFiles: cache object %lu type %s not %s\n",
+	       dentry->d_inode->i_ino, xtype, type);
+	ret = -EIO;
+	goto error;
+
+} /* end cachefiles_check_object_type() */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
new file mode 100644
index 0000000..1ac4f63
--- /dev/null
+++ b/fs/cachefiles/internal.h
@@ -0,0 +1,210 @@
+/* internal.h: general netfs cache on cache files internal defs
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * CacheFiles layout:
+ *
+ *	/..../CacheDir/
+ *		index
+ *		0/
+ *		1/
+ *		2/
+ *		  index
+ *		  0/
+ *		  1/
+ *		  2/
+ *		    index
+ *		    0
+ *		    1
+ *		    2
+ */
+
+#include <linux/fscache-cache.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+extern int cachefiles_debug;
+extern struct fscache_cache_ops cachefiles_cache_ops;
+
+/*****************************************************************************/
+/*
+ * node records
+ */
+struct cachefiles_object {
+	struct fscache_object		fscache;	/* fscache handle */
+	struct dentry			*dentry;	/* the directory representing this object */
+	struct file			*backer;	/* backing file */
+	loff_t				i_size;		/* object size */
+	atomic_t			usage;		/* basic object usage count */
+	atomic_t			fscache_usage;	/* FSDEF object usage count */
+	uint8_t				type;		/* object type */
+	spinlock_t			work_lock;
+	struct rw_semaphore		sem;
+	struct work_struct		read_work;	/* read page copier */
+	struct list_head		read_list;	/* pages to copy */
+	struct list_head		read_pend_list;	/* pages to pending read from backer */
+	struct work_struct		write_work;	/* page writer */
+	struct list_head		write_list;	/* pages to store */
+};
+
+extern kmem_cache_t *cachefiles_object_jar;
+
+extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
+				     struct cachefiles_object *object,
+				     char *key);
+
+extern int cachefiles_check_object_type(struct cachefiles_object *object);
+extern void cachefiles_read_copier_work(void *_object);
+extern void cachefiles_write_work(void *_object);
+
+/*****************************************************************************/
+/*
+ * Cache files cache definition
+ */
+struct cachefiles_cache {
+	struct fscache_cache		cache;		/* FS-Cache record */
+	struct cachefiles_object	fsdef_node;	/* fs definition index node */
+	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	char				*rootdirname;	/* name of cache root directory */
+};
+
+/*****************************************************************************/
+/*
+ * backing file read tracking
+ */
+struct cachefiles_one_read {
+	wait_queue_t			monitor;	/* link into monitored waitqueue */
+	struct page			*back_page;	/* backing file page we're waiting for */
+	struct page			*netfs_page;	/* netfs page we're going to fill */
+	struct cachefiles_object	*object;
+	struct list_head		obj_link;	/* link in object's lists */
+	fscache_rw_complete_t		callback_func;
+	void				*callback_data;
+};
+
+/*****************************************************************************/
+/*
+ * backing file write tracking
+ */
+struct cachefiles_one_write {
+	struct page			*netfs_page;	/* netfs page to copy */
+	struct cachefiles_object	*object;
+	struct list_head		obj_link;	/* link in object's lists */
+	fscache_rw_complete_t		callback_func;
+	void				*callback_data;
+};
+
+/*****************************************************************************/
+/*
+ * debug tracing
+ */
+#define dbgprintk(FMT,...) \
+	printk("[%-6.6s] "FMT"\n",current->comm ,##__VA_ARGS__)
+#define _dbprintk(FMT,...) do { } while(0)
+
+#define kenter(FMT,...)	dbgprintk("==> %s("FMT")",__FUNCTION__ ,##__VA_ARGS__)
+#define kleave(FMT,...)	dbgprintk("<== %s()"FMT"",__FUNCTION__ ,##__VA_ARGS__)
+#define kdebug(FMT,...)	dbgprintk(FMT ,##__VA_ARGS__)
+
+#define kjournal(FMT,...) _dbprintk(FMT ,##__VA_ARGS__)
+
+#define dbgfree(ADDR)  _dbprintk("%p:%d: FREEING %p",__FILE__,__LINE__,ADDR)
+
+#define dbgpgalloc(PAGE)						\
+do {									\
+	_dbprintk("PGALLOC %s:%d: %p {%lx,%lu}\n",			\
+		  __FILE__,__LINE__,					\
+		  (PAGE),(PAGE)->mapping->host->i_ino,(PAGE)->index	\
+		  );							\
+} while(0)
+
+#define dbgpgfree(PAGE)						\
+do {								\
+	if ((PAGE))						\
+		_dbprintk("PGFREE %s:%d: %p {%lx,%lu}\n",	\
+			  __FILE__,__LINE__,			\
+			  (PAGE),				\
+			  (PAGE)->mapping->host->i_ino,		\
+			  (PAGE)->index				\
+			  );					\
+} while(0)
+
+#ifdef __KDEBUG
+#define _enter(FMT,...)	kenter(FMT,##__VA_ARGS__)
+#define _leave(FMT,...)	kleave(FMT,##__VA_ARGS__)
+#define _debug(FMT,...)	kdebug(FMT,##__VA_ARGS__)
+#else
+#define _enter(FMT,...)	do { } while(0)
+#define _leave(FMT,...)	do { } while(0)
+#define _debug(FMT,...)	do { } while(0)
+#endif
+
+#if 1 // defined(__KDEBUGALL)
+
+#define ASSERT(X)							\
+do {									\
+	if (unlikely(!(X))) {						\
+		printk(KERN_ERR "\n");					\
+		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while(0)
+
+#define ASSERTCMP(X, OP, Y)						\
+do {									\
+	if (unlikely(!((X) OP (Y)))) {					\
+		printk(KERN_ERR "\n");					\
+		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
+		printk(KERN_ERR "%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while(0)
+
+#define ASSERTIF(C, X)							\
+do {									\
+	if (unlikely((C) && !(X))) {					\
+		printk(KERN_ERR "\n");					\
+		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while(0)
+
+#define ASSERTIFCMP(C, X, OP, Y)					\
+do {									\
+	if (unlikely((C) && !((X) OP (Y)))) {				\
+		printk(KERN_ERR "\n");					\
+		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
+		printk(KERN_ERR "%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while(0)
+
+#else
+
+#define ASSERT(X)				\
+do {						\
+} while(0)
+
+#define ASSERTCMP(X, OP, Y)			\
+do {						\
+} while(0)
+
+#define ASSERTIF(C, X)				\
+do {						\
+} while(0)
+
+#define ASSERTIFCMP(C, X, OP, Y)		\
+do {						\
+} while(0)
+
+#endif
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 1a5edf2..927008f 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -397,7 +397,7 @@ int __fscache_write_pages(struct fscache
 	struct fscache_object *object;
 	int ret;
 
-	_enter("%p,{%d},", cookie, pagevec->nr);
+	_enter("%p,{%ld},", cookie, pagevec->nr);
 
 	/* not supposed to use this for indexes */
 	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
@@ -484,7 +484,7 @@ void __fscache_uncache_pages(struct fsca
 {
 	struct fscache_object *object;
 
-	_enter(",{%d}", pagevec->nr);
+	_enter(",{%ld}", pagevec->nr);
 
 	BUG_ON(pagevec->nr <= 0);
 	BUG_ON(!pagevec->pages[0]);
diff --git a/fs/nfs/nfs-fscache.c b/fs/nfs/nfs-fscache.c
index 97efe89..ab237fe 100644
--- a/fs/nfs/nfs-fscache.c
+++ b/fs/nfs/nfs-fscache.c
@@ -64,12 +64,13 @@ static uint16_t nfs_server_get_key(const
 		break;
 
 	default:
-		len =0;
+		len = 0;
 		printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
 			server->addr.sin_family);
 		break;
 	}
 
+//	printk("nfs_server_get_key() = %hu\n", len);
 	return len;
 }
 
@@ -91,7 +92,8 @@ static uint16_t nfs_fh_get_key(const voi
 	/* set the file handle */
 	nsize = nfsi->fh.size;
 	memcpy(buffer, nfsi->fh.data, nsize);
-//printk("nfs_fh_get_key: nfsi 0x%p nsize %d\n", nfsi, nsize);
+
+//	printk("nfs_fh_get_key: nfsi 0x%p nsize %hd\n", nfsi, nsize);
 	return nsize;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 074d776..cc9ecc0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1572,6 +1572,7 @@ extern ssize_t generic_file_direct_write
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern int generic_file_buffered_write_one_kernel_page(struct file *, pgoff_t, struct page *);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4873f3e..91fe228 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -215,6 +215,12 @@ static inline void wait_on_page_fs_misc(
 extern void fastcall end_page_fs_misc(struct page *page);
 
 /*
+ * permit installation of a state change monitor in the queue for a page
+ */
+extern void install_page_waitqueue_monitor(struct page *page,
+					   wait_queue_t *monitor);
+
+/*
  * Fault a userspace page into pagetables.  Return non-zero on a fault.
  *
  * This assumes that two userspace pages are always sufficient.  That's
diff --git a/mm/filemap.c b/mm/filemap.c
index 4216dfd..1420fa2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -494,6 +494,18 @@ void fastcall wait_on_page_bit(struct pa
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
+void install_page_waitqueue_monitor(struct page *page, wait_queue_t *monitor)
+{
+	wait_queue_head_t *q = page_waitqueue(page);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__add_wait_queue(q, monitor);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(install_page_waitqueue_monitor);
+
 /**
  * unlock_page() - unlock a locked page
  *
@@ -2112,6 +2124,96 @@ generic_file_buffered_write(struct kiocb
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
 
+int
+generic_file_buffered_write_one_kernel_page(struct file *file,
+					    pgoff_t index,
+					    struct page *src)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct address_space_operations *a_ops = mapping->a_ops;
+	struct pagevec	lru_pvec;
+	struct page *page, *cached_page = NULL;
+	void *from, *to;
+	long status = 0;
+
+	pagevec_init(&lru_pvec, 0);
+
+	page = __grab_cache_page(mapping, index, &cached_page, &lru_pvec);
+	if (!page) {
+		BUG_ON(cached_page);
+		return -ENOMEM;
+	}
+
+	status = a_ops->prepare_write(file, page, 0, PAGE_CACHE_SIZE);
+	if (unlikely(status)) {
+		loff_t isize = i_size_read(mapping->host);
+
+		if (status != AOP_TRUNCATED_PAGE)
+			unlock_page(page);
+		page_cache_release(page);
+		if (status == AOP_TRUNCATED_PAGE)
+			goto sync;
+
+		/* prepare_write() may have instantiated a few blocks outside
+		 * i_size.  Trim these off again.
+		 */
+		if ((1ULL << (index + 1)) > isize)
+			vmtruncate(mapping->host, isize);
+		goto sync;
+	}
+
+	from = kmap_atomic(src, KM_USER0);
+	to = kmap_atomic(page, KM_USER1);
+	copy_page(to, from);
+	kunmap_atomic(from, KM_USER0);
+	kunmap_atomic(to, KM_USER1);
+	flush_dcache_page(page);
+
+	status = a_ops->commit_write(file, page, 0, PAGE_CACHE_SIZE);
+	if (status == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto sync;
+	}
+
+	if (status > 0)
+		status = 0;
+
+	unlock_page(page);
+	mark_page_accessed(page);
+	page_cache_release(page);
+	if (status < 0)
+		return status;
+
+	balance_dirty_pages_ratelimited(mapping);
+	cond_resched();
+
+sync:
+	if (cached_page)
+		page_cache_release(cached_page);
+
+	/*
+	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
+	 */
+	if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(mapping->host))) {
+		if (!a_ops->writepage)
+			status = generic_osync_inode(
+				mapping->host, mapping,
+				OSYNC_METADATA | OSYNC_DATA);
+  	}
+	
+	/*
+	 * If we get here for O_DIRECT writes then we must have fallen through
+	 * to buffered writes (block instantiation inside i_size).  So we sync
+	 * the file data here, to try to honour O_DIRECT expectations.
+	 */
+	if (unlikely(file->f_flags & O_DIRECT))
+		status = filemap_write_and_wait(mapping);
+
+	pagevec_lru_add(&lru_pvec);
+	return status;
+}
+EXPORT_SYMBOL(generic_file_buffered_write_one_kernel_page);
+
 static ssize_t
 __generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
