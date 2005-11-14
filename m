Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVKNV4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVKNV4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVKNVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60565 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751298AbVKNVzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:40 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELscjr007529@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 8/12] FS-Cache: Add generic filesystem cache core module
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a generic core to which both networking filesystems and
caches may bind. It transfers requests from networking filesystems to
appropriate caches if possible, or else gracefully denies them.

It also:

 (*) Adds a facility by which tags can be used to refer to caches, even if
     they're not mounted yet.

 (*) Keeps track of indexes.

 (*) Permits caches to be added and removed dynamically.

 (*) Permits network filesystems to annotate cache nodes that belong to them.

 (*) Permits cache nodes to be pinned and reservations to be made.

If this facility is disabled in the kernel configuration, then all its
operations will be trivially reducible to nothing by the compiler.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 fscache-core-2614mm2.diff
 fs/Kconfig                    |   13 
 fs/Makefile                   |    1 
 fs/fscache/Makefile           |   13 
 fs/fscache/cookie.c           | 1030 ++++++++++++++++++++++++++++++++++++++++++
 fs/fscache/fscache-int.h      |   71 ++
 fs/fscache/fsdef.c            |  113 ++++
 fs/fscache/main.c             |  112 ++++
 fs/fscache/page.c             |  521 +++++++++++++++++++++
 include/linux/fscache-cache.h |  216 ++++++++
 include/linux/fscache.h       |  484 +++++++++++++++++++
 10 files changed, 2574 insertions(+)

diff -uNrp linux-2.6.14-mm2/fs/Kconfig linux-2.6.14-mm2-cachefs/fs/Kconfig
--- linux-2.6.14-mm2/fs/Kconfig	2005-11-14 16:17:54.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/fs/Kconfig	2005-11-14 16:23:38.000000000 +0000
@@ -511,6 +511,19 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
+menu "Caches"
+
+config FSCACHE
+	tristate "General filesystem cache manager"
+	depends on EXPERIMENTAL
+	help
+	  This option enables a generic filesystem caching manager that can be
+	  used by various network and other filesystems to cache data
+	  locally. Different sorts of caches can be plugged in, depending on the
+	  resources available.
+
+	  See Documentation/filesystems/caching/fscache.txt for more information.
+
 menu "CD-ROM/DVD Filesystems"
 
 config ISO9660_FS
diff -uNrp linux-2.6.14-mm2/fs/Makefile linux-2.6.14-mm2-cachefs/fs/Makefile
--- linux-2.6.14-mm2/fs/Makefile	2005-11-14 16:17:54.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/fs/Makefile	2005-11-14 16:23:38.000000000 +0000
@@ -50,6 +50,7 @@ obj-y				+= devpts/
 obj-$(CONFIG_PROFILING)		+= dcookies.o
  
 # Do not add any filesystems before this line
+obj-$(CONFIG_FSCACHE)		+= fscache/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_REISER4_FS)	+= reiser4/
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
diff -uNrp linux-2.6.14-mm2/include/linux/fscache-cache.h linux-2.6.14-mm2-cachefs/include/linux/fscache-cache.h
--- linux-2.6.14-mm2/include/linux/fscache-cache.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/include/linux/fscache-cache.h	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,216 @@
+/* fscache-cache.h: general filesystem caching backing cache interface
+ *
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_FSCACHE_CACHE_H
+#define _LINUX_FSCACHE_CACHE_H
+
+#include <linux/fscache.h>
+
+#define NR_MAXCACHES BITS_PER_LONG
+
+struct fscache_cache;
+struct fscache_cache_ops;
+struct fscache_object;
+
+/*
+ * cache tag definition
+ */
+struct fscache_cache_tag {
+	struct list_head		link;
+	struct fscache_cache		*cache;		/* cache referred to by this tag */
+	atomic_t			usage;
+	char				name[0];	/* tag name */
+};
+
+/*
+ * cache definition
+ */
+struct fscache_cache {
+	struct fscache_cache_ops	*ops;
+	struct fscache_cache_tag	*tag;		/* tag representing this cache */
+	struct list_head		link;		/* link in list of caches */
+	struct rw_semaphore		withdrawal_sem;	/* withdrawal control sem */
+	size_t				max_index_size;	/* maximum size of index data */
+	char				identifier[32];	/* cache label */
+
+	/* node management */
+	struct list_head		object_list;	/* list of data/index objects */
+	spinlock_t			object_list_lock;
+	struct fscache_object		*fsdef;		/* object for the fsdef index */
+};
+
+extern void fscache_init_cache(struct fscache_cache *cache,
+			       struct fscache_cache_ops *ops,
+			       const char *idfmt,
+			       ...) __attribute__ ((format (printf,3,4)));
+
+extern int fscache_add_cache(struct fscache_cache *cache,
+			     struct fscache_object *fsdef,
+			     const char *tagname);
+extern void fscache_withdraw_cache(struct fscache_cache *cache);
+
+/*****************************************************************************/
+/*
+ * cache operations
+ */
+struct fscache_cache_ops {
+	/* name of cache provider */
+	const char *name;
+
+	/* look up the object for a cookie, creating it on disc if necessary */
+	struct fscache_object *(*lookup_object)(struct fscache_cache *cache,
+						struct fscache_object *parent,
+						struct fscache_cookie *cookie);
+
+	/* increment the usage count on this object (may fail if unmounting) */
+	struct fscache_object *(*grab_object)(struct fscache_object *object);
+
+	/* lock a semaphore on an object */
+	void (*lock_object)(struct fscache_object *object);
+
+	/* unlock a semaphore on an object */
+	void (*unlock_object)(struct fscache_object *object);
+
+	/* pin an object in the cache */
+	int (*pin_object)(struct fscache_object *object);
+
+	/* unpin an object in the cache */
+	void (*unpin_object)(struct fscache_object *object);
+
+	/* store the updated auxilliary data on an object */
+	void (*update_object)(struct fscache_object *object);
+
+	/* dispose of a reference to an object */
+	void (*put_object)(struct fscache_object *object);
+
+	/* sync a cache */
+	void (*sync_cache)(struct fscache_cache *cache);
+
+	/* set the data size of an object */
+	int (*set_i_size)(struct fscache_object *object, loff_t i_size);
+
+	/* reserve space for an object's data and associated metadata */
+	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+
+	/* request a backing block for a page be read or allocated in the
+	 * cache */
+	int (*read_or_alloc_page)(struct fscache_object *object,
+				  struct page *page,
+				  fscache_rw_complete_t end_io_func,
+				  void *end_io_data,
+				  unsigned long gfp);
+
+	/* request backing blocks for a list of pages be read or allocated in
+	 * the cache */
+	int (*read_or_alloc_pages)(struct fscache_object *object,
+				   struct address_space *mapping,
+				   struct list_head *pages,
+				   unsigned *nr_pages,
+				   fscache_rw_complete_t end_io_func,
+				   void *end_io_data,
+				   unsigned long gfp);
+
+	/* request a backing block for a page be allocated in the cache so that
+	 * it can be written directly */
+	int (*allocate_page)(struct fscache_object *object,
+			     struct page *page,
+			     unsigned long gfp);
+
+	/* write a page to its backing block in the cache */
+	int (*write_page)(struct fscache_object *object,
+			  struct page *page,
+			  fscache_rw_complete_t end_io_func,
+			  void *end_io_data,
+			  unsigned long gfp);
+
+	/* write several pages to their backing blocks in the cache */
+	int (*write_pages)(struct fscache_object *object,
+			   struct pagevec *pagevec,
+			   fscache_rw_complete_t end_io_func,
+			   void *end_io_data,
+			   unsigned long gfp);
+
+	/* detach backing block from a bunch of pages */
+	void (*uncache_pages)(struct fscache_object *object,
+			     struct pagevec *pagevec);
+
+	/* dissociate a cache from all the pages it was backing */
+	void (*dissociate_pages)(struct fscache_cache *cache);
+};
+
+/*****************************************************************************/
+/*
+ * data file or index object cookie
+ * - a file will only appear in one cache
+ * - a request to cache a file may or may not be honoured, subject to
+ *   constraints such as disc space
+ * - indexes files are created on disc just-in-time
+ */
+struct fscache_cookie {
+	atomic_t			usage;		/* number of users of this cookie */
+	atomic_t			children;	/* number of children of this cookie */
+	struct rw_semaphore		sem;		/* list creation vs scan lock */
+	struct hlist_head		backing_objects; /* object(s) backing this file/index */
+	struct fscache_cookie_def	*def;		/* definition */
+	struct fscache_cookie		*parent;	/* parent of this entry */
+	struct fscache_netfs		*netfs;		/* owner network fs definition */
+	void				*netfs_data;	/* back pointer to netfs */
+};
+
+extern struct fscache_cookie fscache_fsdef_index;
+
+/*****************************************************************************/
+/*
+ * on-disc cache file or index handle
+ */
+struct fscache_object {
+	unsigned long			flags;
+#define FSCACHE_OBJECT_RELEASING	0	/* T if object is being released */
+#define FSCACHE_OBJECT_RECYCLING	1	/* T if object is being retired */
+#define FSCACHE_OBJECT_WITHDRAWN	2	/* T if object has been withdrawn */
+
+	struct list_head		cache_link;	/* link in cache->object_list */
+	struct hlist_node		cookie_link;	/* link in cookie->backing_objects */
+	struct fscache_cache		*cache;		/* cache that supplied this object */
+	struct fscache_cookie		*cookie;	/* netfs's file/index object */
+};
+
+static inline
+void fscache_object_init(struct fscache_object *object)
+{
+	object->flags = 0;
+	INIT_LIST_HEAD(&object->cache_link);
+	INIT_HLIST_NODE(&object->cookie_link);
+	object->cache = NULL;
+	object->cookie = NULL;
+}
+
+/* find the parent index object for a object */
+static inline
+struct fscache_object *fscache_find_parent_object(struct fscache_object *object)
+{
+	struct fscache_object *parent;
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_cache *cache = object->cache;
+	struct hlist_node *_p;
+
+	hlist_for_each_entry(parent, _p,
+			     &cookie->parent->backing_objects,
+			     cookie_link
+			     ) {
+		if (parent->cache == cache)
+			return parent;
+	}
+
+	return NULL;
+}
+
+#endif /* _LINUX_FSCACHE_CACHE_H */
diff -uNrp linux-2.6.14-mm2/include/linux/fscache.h linux-2.6.14-mm2-cachefs/include/linux/fscache.h
--- linux-2.6.14-mm2/include/linux/fscache.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/include/linux/fscache.h	2005-11-14 16:40:44.000000000 +0000
@@ -0,0 +1,484 @@
+/* fscache.h: general filesystem caching interface
+ *
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_FSCACHE_H
+#define _LINUX_FSCACHE_H
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+
+#ifdef CONFIG_FSCACHE_MODULE
+#define CONFIG_FSCACHE
+#endif
+
+struct pagevec;
+struct fscache_cache_tag;
+struct fscache_cookie;
+struct fscache_netfs;
+struct fscache_netfs_operations;
+
+#define FSCACHE_NEGATIVE_COOKIE ((struct fscache_cookie *) NULL)
+
+typedef void (*fscache_rw_complete_t)(struct page *page,
+				      void *data,
+				      int error);
+
+/* result of index entry consultation */
+typedef enum {
+	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
+	FSCACHE_CHECKAUX_NEEDS_UPDATE,	/* entry requires update */
+	FSCACHE_CHECKAUX_OBSOLETE,	/* entry requires deletion */
+} fscache_checkaux_t;
+
+/*****************************************************************************/
+/*
+ * fscache cookie definition
+ */
+struct fscache_cookie_def
+{
+	/* name of cookie type */
+	char name[16];
+
+	/* cookie type */
+	uint8_t type;
+#define FSCACHE_COOKIE_TYPE_INDEX	0
+#define FSCACHE_COOKIE_TYPE_DATAFILE	1
+
+	/* select the cache into which to insert an entry in this index
+	 * - optional
+	 * - should return a cache identifier or NULL to cause the cache to be
+	 *   inherited from the parent if possible or the first cache picked
+	 *   for a non-index file if not
+	 */
+	struct fscache_cache_tag *(*select_cache)(const void *parent_netfs_data,
+						  const void *cookie_netfs_data);
+
+	/* get an index key
+	 * - should store the key data in the buffer
+	 * - should return the amount of amount stored
+	 * - not permitted to return an error
+	 * - the netfs data from the cookie being used as the source is
+	 *   presented
+	 */
+	uint16_t (*get_key)(const void *cookie_netfs_data,
+			    void *buffer,
+			    uint16_t bufmax);
+
+	/* get certain file attributes from the netfs data
+	 * - this function can be absent for an index
+	 * - not permitted to return an error
+	 * - the netfs data from the cookie being used as the source is
+	 *   presented
+	 */
+	void (*get_attr)(const void *cookie_netfs_data, uint64_t *size);
+
+	/* get the auxilliary data from netfs data
+	 * - this function can be absent if the index carries no state data
+	 * - should store the auxilliary data in the buffer
+	 * - should return the amount of amount stored
+	 * - not permitted to return an error
+	 * - the netfs data from the cookie being used as the source is
+	 *   presented
+	 */
+	uint16_t (*get_aux)(const void *cookie_netfs_data,
+			    void *buffer,
+			    uint16_t bufmax);
+
+	/* consult the netfs about the state of an object
+	 * - this function can be absent if the index carries no state data
+	 * - the netfs data from the cookie being used as the target is
+	 *   presented, as is the auxilliary data
+	 */
+	fscache_checkaux_t (*check_aux)(void *cookie_netfs_data,
+					const void *data,
+					uint16_t datalen);
+
+	/* indicate pages that now have cache metadata retained
+	 * - this function should mark the specified pages as now being cached
+	 */
+	void (*mark_pages_cached)(void *cookie_netfs_data,
+				  struct address_space *mapping,
+				  struct pagevec *cached_pvec);
+
+	/* indicate the cookie is no longer uncached
+	 * - this function is called when the backing store currently caching
+	 *   a cookie is removed
+	 * - the netfs should use this to clean up any markers indicating
+	 *   cached pages
+	 * - this is mandatory for any object that may have data
+	 */
+	void (*now_uncached)(void *cookie_netfs_data);
+};
+
+/* pattern used to fill dead space in an index entry */
+#define FSCACHE_INDEX_DEADFILL_PATTERN 0x79
+
+#ifdef CONFIG_FSCACHE
+extern struct fscache_cookie *__fscache_acquire_cookie(struct fscache_cookie *parent,
+						       struct fscache_cookie_def *def,
+						       void *netfs_data);
+
+extern void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
+					int retire);
+
+extern void __fscache_update_cookie(struct fscache_cookie *cookie);
+#endif
+
+static inline
+struct fscache_cookie *fscache_acquire_cookie(struct fscache_cookie *parent,
+					      struct fscache_cookie_def *def,
+					      void *netfs_data)
+{
+#ifdef CONFIG_FSCACHE
+	if (parent != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_acquire_cookie(parent, def, netfs_data);
+#endif
+	return FSCACHE_NEGATIVE_COOKIE;
+}
+
+static inline
+void fscache_relinquish_cookie(struct fscache_cookie *cookie,
+			       int retire)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		__fscache_relinquish_cookie(cookie, retire);
+#endif
+}
+
+static inline
+void fscache_update_cookie(struct fscache_cookie *cookie)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		__fscache_update_cookie(cookie);
+#endif
+}
+
+/*****************************************************************************/
+/*
+ * pin or unpin a cookie in a cache
+ * - only available for data cookies
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_pin_cookie(struct fscache_cookie *cookie);
+extern void __fscache_unpin_cookie(struct fscache_cookie *cookie);
+#endif
+
+static inline
+int fscache_pin_cookie(struct fscache_cookie *cookie)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_pin_cookie(cookie);
+#endif
+	return -ENOBUFS;
+}
+
+static inline
+void fscache_unpin_cookie(struct fscache_cookie *cookie)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		__fscache_unpin_cookie(cookie);
+#endif
+}
+
+/*****************************************************************************/
+/*
+ * fscache cached network filesystem type
+ * - name, version and ops must be filled in before registration
+ * - all other fields will be set during registration
+ */
+struct fscache_netfs
+{
+	uint32_t			version;	/* indexing version */
+	const char			*name;		/* filesystem name */
+	struct fscache_cookie		*primary_index;
+	struct fscache_netfs_operations	*ops;
+	struct list_head		link;		/* internal link */
+};
+
+struct fscache_netfs_operations
+{
+};
+
+#ifdef CONFIG_FSCACHE
+extern int __fscache_register_netfs(struct fscache_netfs *netfs);
+extern void __fscache_unregister_netfs(struct fscache_netfs *netfs);
+#endif
+
+static inline
+int fscache_register_netfs(struct fscache_netfs *netfs)
+{
+#ifdef CONFIG_FSCACHE
+	return __fscache_register_netfs(netfs);
+#else
+	return 0;
+#endif
+}
+
+static inline
+void fscache_unregister_netfs(struct fscache_netfs *netfs)
+{
+#ifdef CONFIG_FSCACHE
+	__fscache_unregister_netfs(netfs);
+#endif
+}
+
+/*****************************************************************************/
+/*
+ * look up a cache tag
+ * - cache tags are used to select specific caches in which to cache indexes
+ */
+#ifdef CONFIG_FSCACHE
+extern struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name);
+extern void __fscache_release_cache_tag(struct fscache_cache_tag *tag);
+#endif
+
+static inline
+struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name)
+{
+#ifdef CONFIG_FSCACHE
+	return __fscache_lookup_cache_tag(name);
+#else
+	return NULL;
+#endif
+}
+
+static inline
+void fscache_release_cache_tag(struct fscache_cache_tag *tag)
+{
+#ifdef CONFIG_FSCACHE
+	__fscache_release_cache_tag(tag);
+#endif
+}
+
+/*****************************************************************************/
+/*
+ * set the data size on a cached object
+ * - no pages beyond the end of the object will be accessible
+ * - returns -ENOBUFS if the file is not backed
+ * - returns -ENOSPC if a pinned file of that size can't be stored
+ * - returns 0 if okay
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_set_i_size(struct fscache_cookie *cookie, loff_t i_size);
+#endif
+
+static inline
+int fscache_set_i_size(struct fscache_cookie *cookie, loff_t i_size)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_set_i_size(cookie, i_size);
+#endif
+	return -ENOBUFS;
+}
+
+/*****************************************************************************/
+/*
+ * reserve data space for a cached object
+ * - returns -ENOBUFS if the file is not backed
+ * - returns -ENOSPC if there isn't enough space to honour the reservation
+ * - returns 0 if okay
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_reserve_space(struct fscache_cookie *cookie, loff_t size);
+#endif
+
+static inline
+int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_reserve_space(cookie, size);
+#endif
+	return -ENOBUFS;
+}
+
+/*****************************************************************************/
+/*
+ * read a page from the cache or allocate a block in which to store it
+ * - if the page is not backed by a file:
+ *   - -ENOBUFS will be returned and nothing more will be done
+ * - else if the page is backed by a block in the cache:
+ *   - a read will be started which will call end_io_func on completion
+ * - else if the page is unbacked:
+ *   - a block will be allocated
+ *   - -ENODATA will be returned
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_read_or_alloc_page(struct fscache_cookie *cookie,
+					struct page *page,
+					fscache_rw_complete_t end_io_func,
+					void *end_io_data,
+					gfp_t gfp);
+#endif
+
+static inline
+int fscache_read_or_alloc_page(struct fscache_cookie *cookie,
+			       struct page *page,
+			       fscache_rw_complete_t end_io_func,
+			       void *end_io_data,
+			       gfp_t gfp)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_read_or_alloc_page(cookie, page, end_io_func,
+						    end_io_data, gfp);
+#endif
+	return -ENOBUFS;
+}
+
+#ifdef CONFIG_FSCACHE
+extern int __fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
+					 struct address_space *mapping,
+					 struct list_head *pages,
+					 unsigned *nr_pages,
+					 fscache_rw_complete_t end_io_func,
+					 void *end_io_data,
+					 gfp_t gfp);
+#endif
+
+static inline
+int fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
+				struct address_space *mapping,
+				struct list_head *pages,
+				unsigned *nr_pages,
+				fscache_rw_complete_t end_io_func,
+				void *end_io_data,
+				gfp_t gfp)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_read_or_alloc_pages(cookie, mapping, pages,
+						     nr_pages, end_io_func,
+						     end_io_data, gfp);
+#endif
+	return -ENOBUFS;
+}
+
+/*
+ * allocate a block in which to store a page
+ * - if the page is not backed by a file:
+ *   - -ENOBUFS will be returned and nothing more will be done
+ * - else
+ *   - a block will be allocated if there isn't one
+ *   - 0 will be returned
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_alloc_page(struct fscache_cookie *cookie,
+				struct page *page,
+				gfp_t gfp);
+#endif
+
+static inline
+int fscache_alloc_page(struct fscache_cookie *cookie,
+		       struct page *page,
+		       gfp_t gfp)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_alloc_page(cookie, page, gfp);
+#endif
+	return -ENOBUFS;
+}
+
+/*
+ * request a page be stored in the cache
+ * - this request may be ignored if no cache block is currently allocated, in
+ *   which case it:
+ *   - returns -ENOBUFS
+ * - if a cache block was already allocated:
+ *   - a BIO will be dispatched to write the page (end_io_func will be called
+ *     from the completion function)
+ *   - returns 0
+ */
+#ifdef CONFIG_FSCACHE
+extern int __fscache_write_page(struct fscache_cookie *cookie,
+				struct page *page,
+				fscache_rw_complete_t end_io_func,
+				void *end_io_data,
+				gfp_t gfp);
+
+extern int __fscache_write_pages(struct fscache_cookie *cookie,
+				 struct pagevec *pagevec,
+				 fscache_rw_complete_t end_io_func,
+				 void *end_io_data,
+				 gfp_t gfp);
+#endif
+
+static inline
+int fscache_write_page(struct fscache_cookie *cookie,
+		       struct page *page,
+		       fscache_rw_complete_t end_io_func,
+		       void *end_io_data,
+		       gfp_t gfp)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_write_page(cookie, page, end_io_func,
+					    end_io_data, gfp);
+#endif
+	return -ENOBUFS;
+}
+
+static inline
+int fscache_write_pages(struct fscache_cookie *cookie,
+			struct pagevec *pagevec,
+			fscache_rw_complete_t end_io_func,
+			void *end_io_data,
+			gfp_t gfp)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		return __fscache_write_pages(cookie, pagevec, end_io_func,
+					     end_io_data, gfp);
+#endif
+	return -ENOBUFS;
+}
+
+/*
+ * indicate that caching is no longer required on a page
+ * - note: cannot cancel any outstanding BIOs between this page and the cache
+ */
+#ifdef CONFIG_FSCACHE
+extern void __fscache_uncache_page(struct fscache_cookie *cookie,
+				   struct page *page);
+extern void __fscache_uncache_pages(struct fscache_cookie *cookie,
+				    struct pagevec *pagevec);
+#endif
+
+static inline
+void fscache_uncache_page(struct fscache_cookie *cookie,
+			  struct page *page)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		__fscache_uncache_page(cookie, page);
+#endif
+}
+
+static inline
+void fscache_uncache_pagevec(struct fscache_cookie *cookie,
+			     struct pagevec *pagevec)
+{
+#ifdef CONFIG_FSCACHE
+	if (cookie != FSCACHE_NEGATIVE_COOKIE)
+		__fscache_uncache_pages(cookie, pagevec);
+#endif
+}
+
+#endif /* _LINUX_FSCACHE_H */
diff -uNrp linux-2.6.14-mm2/fs/fscache/cookie.c linux-2.6.14-mm2-cachefs/fs/fscache/cookie.c
--- linux-2.6.14-mm2/fs/fscache/cookie.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/cookie.c	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,1030 @@
+/* cookie.c: general filesystem cache cookie management
+ *
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include "fscache-int.h"
+
+static LIST_HEAD(fscache_cache_tag_list);
+static LIST_HEAD(fscache_cache_list);
+static LIST_HEAD(fscache_netfs_list);
+static DECLARE_RWSEM(fscache_addremove_sem);
+static struct fscache_cache_tag fscache_nomem_tag;
+
+kmem_cache_t *fscache_cookie_jar;
+
+static void fscache_withdraw_object(struct fscache_cache *cache,
+				    struct fscache_object *object);
+
+static void __fscache_cookie_put(struct fscache_cookie *cookie);
+
+static inline void fscache_cookie_put(struct fscache_cookie *cookie)
+{
+#ifdef CONFIG_DEBUG_SLAB
+	BUG_ON((atomic_read(&cookie->usage) & 0xffff0000) == 0x6b6b0000);
+#endif
+
+	BUG_ON(atomic_read(&cookie->usage) <= 0);
+
+	if (atomic_dec_and_test(&cookie->usage))
+		__fscache_cookie_put(cookie);
+
+}
+
+/*****************************************************************************/
+/*
+ * look up a cache tag
+ */
+struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
+{
+	struct fscache_cache_tag *tag, *xtag;
+
+	/* firstly check for the existence of the tag under read lock */
+	down_read(&fscache_addremove_sem);
+
+	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
+		if (strcmp(tag->name, name) == 0) {
+			atomic_inc(&tag->usage);
+			up_read(&fscache_addremove_sem);
+			return tag;
+		}
+	}
+
+	up_read(&fscache_addremove_sem);
+
+	/* the tag does not exist - create a candidate */
+	xtag = kmalloc(sizeof(*tag) + strlen(name) + 1, GFP_KERNEL);
+	if (!xtag) {
+		/* return a dummy tag if out of memory */
+		up_read(&fscache_addremove_sem);
+		return &fscache_nomem_tag;
+	}
+
+	atomic_set(&tag->usage, 1);
+	strcpy(tag->name, name);
+
+	/* write lock, search again and add if still not present */
+	down_write(&fscache_addremove_sem);
+
+	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
+		if (strcmp(tag->name, name) == 0) {
+			atomic_inc(&tag->usage);
+			up_write(&fscache_addremove_sem);
+			kfree(xtag);
+			return tag;
+		}
+	}
+
+	list_add_tail(&xtag->link, &fscache_cache_tag_list);
+	up_write(&fscache_addremove_sem);
+	return xtag;
+
+} /* end __fscache_lookup_cache_tag() */
+
+/*****************************************************************************/
+/*
+ * release a reference to a cache tag
+ */
+void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
+{
+	if (tag != &fscache_nomem_tag) {
+		down_write(&fscache_addremove_sem);
+
+		if (atomic_dec_and_test(&tag->usage))
+			list_del_init(&tag->link);
+		else
+			tag = NULL;
+
+		up_write(&fscache_addremove_sem);
+
+		kfree(tag);
+	}
+
+} /* end __fscache_release_cache_tag() */
+
+/*****************************************************************************/
+/*
+ * register a network filesystem for caching
+ */
+int __fscache_register_netfs(struct fscache_netfs *netfs)
+{
+	struct fscache_netfs *ptr;
+	int ret;
+
+	_enter("{%s}", netfs->name);
+
+	INIT_LIST_HEAD(&netfs->link);
+
+	/* allocate a cookie for the primary index */
+	netfs->primary_index =
+		kmem_cache_alloc(fscache_cookie_jar, SLAB_KERNEL);
+
+	if (!netfs->primary_index) {
+		_leave(" = -ENOMEM");
+		return -ENOMEM;
+	}
+
+	/* initialise the primary index cookie */
+	memset(netfs->primary_index, 0, sizeof(*netfs->primary_index));
+
+	atomic_set(&netfs->primary_index->usage, 1);
+	atomic_set(&netfs->primary_index->children, 0);
+
+	netfs->primary_index->def		= &fscache_fsdef_netfs_def;
+	netfs->primary_index->parent		= &fscache_fsdef_index;
+	netfs->primary_index->netfs		= netfs;
+	netfs->primary_index->netfs_data	= netfs;
+
+	atomic_inc(&netfs->primary_index->parent->usage);
+	atomic_inc(&netfs->primary_index->parent->children);
+
+	init_rwsem(&netfs->primary_index->sem);
+	INIT_HLIST_HEAD(&netfs->primary_index->backing_objects);
+
+	/* check the netfs type is not already present */
+	down_write(&fscache_addremove_sem);
+
+	ret = -EEXIST;
+	list_for_each_entry(ptr, &fscache_netfs_list, link) {
+		if (strcmp(ptr->name, netfs->name) == 0)
+			goto already_registered;
+	}
+
+	list_add(&netfs->link, &fscache_netfs_list);
+	ret = 0;
+
+	printk("FS-Cache: netfs '%s' registered for caching\n", netfs->name);
+
+already_registered:
+	up_write(&fscache_addremove_sem);
+
+	if (ret < 0) {
+		netfs->primary_index->parent = NULL;
+		__fscache_cookie_put(netfs->primary_index);
+		netfs->primary_index = NULL;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_register_netfs() */
+
+EXPORT_SYMBOL(__fscache_register_netfs);
+
+/*****************************************************************************/
+/*
+ * unregister a network filesystem from the cache
+ * - all cookies must have been released first
+ */
+void __fscache_unregister_netfs(struct fscache_netfs *netfs)
+{
+	_enter("{%s.%u}", netfs->name, netfs->version);
+
+	down_write(&fscache_addremove_sem);
+
+	list_del(&netfs->link);
+	fscache_relinquish_cookie(netfs->primary_index, 0);
+
+	up_write(&fscache_addremove_sem);
+
+	printk("FS-Cache: netfs '%s' unregistered from caching\n",
+	       netfs->name);
+
+	_leave("");
+
+} /* end __fscache_unregister_netfs() */
+
+EXPORT_SYMBOL(__fscache_unregister_netfs);
+
+/*****************************************************************************/
+/*
+ * initialise a cache record
+ */
+void fscache_init_cache(struct fscache_cache *cache,
+			struct fscache_cache_ops *ops,
+			const char *idfmt,
+			...)
+{
+	va_list va;
+
+	memset(cache, 0, sizeof(*cache));
+
+	cache->ops = ops;
+
+	va_start(va, idfmt);
+	vsnprintf(cache->identifier, sizeof(cache->identifier), idfmt, va);
+	va_end(va);
+
+	INIT_LIST_HEAD(&cache->link);
+	INIT_LIST_HEAD(&cache->object_list);
+	spin_lock_init(&cache->object_list_lock);
+	init_rwsem(&cache->withdrawal_sem);
+
+} /* end fscache_init_cache() */
+
+EXPORT_SYMBOL(fscache_init_cache);
+
+/*****************************************************************************/
+/*
+ * declare a mounted cache as being open for business
+ */
+int fscache_add_cache(struct fscache_cache *cache,
+		      struct fscache_object *ifsdef,
+		      const char *tagname)
+{
+	struct fscache_cache_tag *tag;
+
+	BUG_ON(!cache->ops);
+	BUG_ON(!ifsdef);
+
+	if (!tagname)
+		tagname = cache->identifier;
+
+	BUG_ON(!tagname[0]);
+
+	_enter("{%s.%s},,%s", cache->ops->name, cache->identifier, tagname);
+
+	if (!cache->ops->grab_object(ifsdef))
+		BUG();
+
+	ifsdef->cookie = &fscache_fsdef_index;
+	ifsdef->cache = cache;
+	cache->fsdef = ifsdef;
+
+	down_write(&fscache_addremove_sem);
+
+	/* instantiate or allocate a cache tag */
+	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
+		if (strcmp(tag->name, tagname) == 0) {
+			if (tag->cache) {
+				printk(KERN_ERR
+				       "FS-Cache: cache tag '%s' already in use\n",
+				       tagname);
+				up_write(&fscache_addremove_sem);
+				return -EEXIST;
+			}
+
+			atomic_inc(&tag->usage);
+			goto found_cache_tag;
+		}
+	}
+
+	tag = kmalloc(sizeof(*tag) + strlen(tagname) + 1, GFP_KERNEL);
+	if (!tag) {
+		up_write(&fscache_addremove_sem);
+		return -ENOMEM;
+	}
+
+	atomic_set(&tag->usage, 1);
+	strcpy(tag->name, tagname);
+	list_add_tail(&tag->link, &fscache_cache_tag_list);
+
+found_cache_tag:
+	tag->cache = cache;
+	cache->tag = tag;
+
+	/* add the cache to the list */
+	list_add(&cache->link, &fscache_cache_list);
+
+	/* add the cache's netfs definition index object to the cache's
+	 * list */
+	spin_lock(&cache->object_list_lock);
+	list_add_tail(&ifsdef->cache_link, &cache->object_list);
+	spin_unlock(&cache->object_list_lock);
+
+	/* add the cache's netfs definition index object to the top level index
+	 * cookie as a known backing object */
+	down_write(&fscache_fsdef_index.sem);
+
+	hlist_add_head(&ifsdef->cookie_link,
+		       &fscache_fsdef_index.backing_objects);
+
+	atomic_inc(&fscache_fsdef_index.usage);
+
+	/* done */
+	up_write(&fscache_fsdef_index.sem);
+	up_write(&fscache_addremove_sem);
+
+	printk(KERN_NOTICE
+	       "FS-Cache: Cache \"%s\" added (type %s)\n",
+	       cache->tag->name, cache->ops->name);
+
+	_leave(" = 0 [%s]", cache->identifier);
+	return 0;
+
+} /* end fscache_add_cache() */
+
+EXPORT_SYMBOL(fscache_add_cache);
+
+/*****************************************************************************/
+/*
+ * withdraw an unmounted cache from the active service
+ */
+void fscache_withdraw_cache(struct fscache_cache *cache)
+{
+	struct fscache_object *object;
+
+	_enter("");
+
+	printk(KERN_NOTICE
+	       "FS-Cache: Withdrawing cache \"%s\"\n",
+	       cache->tag->name);
+
+	/* make the cache unavailable for cookie acquisition */
+	down_write(&cache->withdrawal_sem);
+
+	down_write(&fscache_addremove_sem);
+	list_del_init(&cache->link);
+	cache->tag->cache = NULL;
+	up_write(&fscache_addremove_sem);
+
+	/* mark all objects as being withdrawn */
+	spin_lock(&cache->object_list_lock);
+	list_for_each_entry(object, &cache->object_list, cache_link) {
+		set_bit(FSCACHE_OBJECT_WITHDRAWN, &object->flags);
+	}
+	spin_unlock(&cache->object_list_lock);
+
+	/* make sure all pages pinned by operations on behalf of the netfs are
+	 * written to disc */
+	cache->ops->sync_cache(cache);
+
+	/* dissociate all the netfs pages backed by this cache from the block
+	 * mappings in the cache */
+	cache->ops->dissociate_pages(cache);
+
+	/* we now have to destroy all the active objects pertaining to this
+	 * cache */
+	spin_lock(&cache->object_list_lock);
+
+	while (!list_empty(&cache->object_list)) {
+		object = list_entry(cache->object_list.next,
+				    struct fscache_object, cache_link);
+		list_del_init(&object->cache_link);
+		spin_unlock(&cache->object_list_lock);
+
+		_debug("withdraw %p", object->cookie);
+
+		/* we've extracted an active object from the tree - now dispose
+		 * of it */
+		fscache_withdraw_object(cache, object);
+
+		spin_lock(&cache->object_list_lock);
+	}
+
+	spin_unlock(&cache->object_list_lock);
+
+	fscache_release_cache_tag(cache->tag);
+	cache->tag = NULL;
+
+	_leave("");
+
+} /* end fscache_withdraw_cache() */
+
+EXPORT_SYMBOL(fscache_withdraw_cache);
+
+/*****************************************************************************/
+/*
+ * withdraw an object from active service at the behest of the cache
+ * - need break the links to a cached object cookie
+ * - called under two situations:
+ *   (1) recycler decides to reclaim an in-use object
+ *   (2) a cache is unmounted
+ * - have to take care as the cookie can be being relinquished by the netfs
+ *   simultaneously
+ * - the active object is pinned by the caller holding a refcount on it
+ */
+static void fscache_withdraw_object(struct fscache_cache *cache,
+				    struct fscache_object *object)
+{
+	struct fscache_cookie *cookie, *xcookie = NULL;
+
+	_enter(",%p", object);
+
+	/* first of all we have to break the links between the object and the
+	 * cookie
+	 * - we have to hold both semaphores BUT we have to get the cookie sem
+	 *   FIRST
+	 */
+	cache->ops->lock_object(object);
+
+	cookie = object->cookie;
+	if (cookie) {
+		/* pin the cookie so that is doesn't escape */
+		atomic_inc(&cookie->usage);
+
+		/* re-order the locks to avoid deadlock */
+		cache->ops->unlock_object(object);
+		down_write(&cookie->sem);
+		cache->ops->lock_object(object);
+
+		/* erase references from the object to the cookie */
+		hlist_del_init(&object->cookie_link);
+
+		xcookie = object->cookie;
+		object->cookie = NULL;
+
+		up_write(&cookie->sem);
+	}
+
+	cache->ops->unlock_object(object);
+
+	/* we've broken the links between cookie and object */
+	if (xcookie) {
+		fscache_cookie_put(xcookie);
+		cache->ops->put_object(object);
+	}
+
+	/* unpin the cookie */
+	if (cookie) {
+		if (cookie->def && cookie->def->now_uncached)
+			cookie->def->now_uncached(cookie->netfs_data);
+		fscache_cookie_put(cookie);
+	}
+
+	_leave("");
+
+} /* end fscache_withdraw_object() */
+
+/*****************************************************************************/
+/*
+ * select a cache on which to store an object
+ * - the cache addremove semaphore must be at least read-locked by the caller
+ * - the object will never be an index
+ */
+static struct fscache_cache *fscache_select_cache_for_object(struct fscache_cookie *cookie)
+{
+	struct fscache_cache_tag *tag;
+	struct fscache_object *object;
+	struct fscache_cache *cache;
+
+	_enter("");
+
+	if (list_empty(&fscache_cache_list)) {
+		_leave(" = NULL [no cache]");
+		return NULL;
+	}
+
+	/* we check the parent to determine the cache to use */
+	down_read(&cookie->parent->sem);
+
+	/* the first in the parent's backing list should be the preferred
+	 * cache */
+	if (!hlist_empty(&cookie->parent->backing_objects)) {
+		object = hlist_entry(cookie->parent->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		cache = object->cache;
+		up_read(&cookie->parent->sem);
+		_leave(" = %p [parent]", cache);
+		return cache;
+	}
+
+	/* the parent is unbacked */
+	if (cookie->parent->def->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		/* parent not an index and is unbacked */
+		up_read(&cookie->parent->sem);
+		_leave(" = NULL [parent ubni]");
+		return NULL;
+	}
+
+	up_read(&cookie->parent->sem);
+
+	if (!cookie->parent->def->select_cache)
+		goto no_preference;
+
+	/* ask the netfs for its preference */
+	tag = cookie->parent->def->select_cache(
+		cookie->parent->parent->netfs_data,
+		cookie->parent->netfs_data);
+
+	if (!tag)
+		goto no_preference;
+
+	if (tag == &fscache_nomem_tag) {
+		_leave(" = NULL [nomem tag]");
+		return NULL;
+	}
+
+	if (!tag->cache) {
+		_leave(" = NULL [unbacked tag]");
+		return NULL;
+	}
+
+	_leave(" = %p [specific]", tag->cache);
+	return tag->cache;
+
+no_preference:
+	/* netfs has no preference - just select first cache */
+	cache = list_entry(fscache_cache_list.next,
+			   struct fscache_cache, link);
+	_leave(" = %p [first]", cache);
+	return cache;
+
+} /* end fscache_select_cache_for_object() */
+
+/*****************************************************************************/
+/*
+ * get a backing object for a cookie from the chosen cache
+ * - the cookie must be write-locked by the caller
+ * - all parent indexes will be obtained recursively first
+ */
+static struct fscache_object *fscache_lookup_object(struct fscache_cookie *cookie,
+						    struct fscache_cache *cache)
+{
+	struct fscache_cookie *parent = cookie->parent;
+	struct fscache_object *pobject, *object;
+	struct hlist_node *_p;
+
+	_enter("{%s/%s},",
+	       parent && parent->def ? parent->def->name : "",
+	       cookie->def ? (char *) cookie->def->name : "<file>");
+
+	/* see if we have the backing object for this cookie + cache immediately
+	 * to hand
+	 */
+	object = NULL;
+	hlist_for_each_entry(object, _p,
+			     &cookie->backing_objects, cookie_link
+			     ) {
+		if (object->cache == cache)
+			break;
+	}
+
+	if (object) {
+		_leave(" = %p [old]", object);
+		return object;
+	}
+
+	BUG_ON(!parent); /* FSDEF entries don't have a parent */
+
+	/* we don't have a backing cookie, so we need to consult the object's
+	 * parent index in the selected cache and maybe insert an entry
+	 * therein; so the first thing to do is make sure that the parent index
+	 * is represented on disc
+	 */
+	down_read(&parent->sem);
+
+	pobject = NULL;
+	hlist_for_each_entry(pobject, _p,
+			     &parent->backing_objects, cookie_link
+			     ) {
+		if (pobject->cache == cache)
+			break;
+	}
+
+	if (!pobject) {
+		/* we don't know about the parent object */
+		up_read(&parent->sem);
+		down_write(&parent->sem);
+
+		pobject = fscache_lookup_object(parent, cache);
+		if (IS_ERR(pobject)) {
+			up_write(&parent->sem);
+			_leave(" = %ld [no ipobj]", PTR_ERR(pobject));
+			return pobject;
+		}
+
+		_debug("pobject=%p", pobject);
+
+		BUG_ON(pobject->cookie != parent);
+
+		downgrade_write(&parent->sem);
+	}
+
+	/* now we can attempt to look up this object in the parent, possibly
+	 * creating a representation on disc when we do so
+	 */
+	object = cache->ops->lookup_object(cache, pobject, cookie);
+	up_read(&parent->sem);
+
+	if (IS_ERR(object)) {
+		_leave(" = %ld [no obj]", PTR_ERR(object));
+		return object;
+	}
+
+	/* keep track of it */
+	cache->ops->lock_object(object);
+
+	BUG_ON(!hlist_unhashed(&object->cookie_link));
+
+	/* attach to the cache's object list */
+	if (list_empty(&object->cache_link)) {
+		spin_lock(&cache->object_list_lock);
+		list_add(&object->cache_link, &cache->object_list);
+		spin_unlock(&cache->object_list_lock);
+	}
+
+	/* attach to the cookie */
+	object->cookie = cookie;
+	atomic_inc(&cookie->usage);
+	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
+
+	/* done */
+	cache->ops->unlock_object(object);
+	_leave(" = %p [new]", object);
+	return object;
+
+} /* end fscache_lookup_object() */
+
+/*****************************************************************************/
+/*
+ * request a cookie to represent an object (index, datafile, xattr, etc)
+ * - parent specifies the parent object
+ *   - the top level index cookie for each netfs is stored in the fscache_netfs
+ *     struct upon registration
+ * - idef points to the definition
+ * - the netfs_data will be passed to the functions pointed to in *def
+ * - all attached caches will be searched to see if they contain this object
+ * - index objects aren't stored on disk until there's a dependent file that
+ *   needs storing
+ * - other objects are stored in a selected cache immediately, and all the
+ *   indexes forming the path to it are instantiated if necessary
+ * - we never let on to the netfs about errors
+ *   - we may set a negative cookie pointer, but that's okay
+ */
+struct fscache_cookie *__fscache_acquire_cookie(struct fscache_cookie *parent,
+						struct fscache_cookie_def *def,
+						void *netfs_data)
+{
+	struct fscache_cookie *cookie;
+	struct fscache_cache *cache;
+	struct fscache_object *object;
+	int ret = 0;
+
+	BUG_ON(!def);
+
+	_enter("{%s},{%s},%p",
+	       parent ? (char *) parent->def->name : "<no-parent>",
+	       def->name, netfs_data);
+
+	/* if there's no parent cookie, then we don't create one here either */
+	if (parent == FSCACHE_NEGATIVE_COOKIE) {
+		_leave(" [no parent]");
+		return FSCACHE_NEGATIVE_COOKIE;
+	}
+
+	/* validate the definition */
+	BUG_ON(!def->get_key);
+	BUG_ON(!def->name[0]);
+
+	BUG_ON(def->type == FSCACHE_COOKIE_TYPE_INDEX &&
+	       parent->def->type != FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* allocate and initialise a cookie */
+	cookie = kmem_cache_alloc(fscache_cookie_jar, SLAB_KERNEL);
+	if (!cookie) {
+		_leave(" [ENOMEM]");
+		return FSCACHE_NEGATIVE_COOKIE;
+	}
+
+	atomic_set(&cookie->usage, 1);
+	atomic_set(&cookie->children, 0);
+
+	atomic_inc(&parent->usage);
+	atomic_inc(&parent->children);
+
+	cookie->def		= def;
+	cookie->parent		= parent;
+	cookie->netfs		= parent->netfs;
+	cookie->netfs_data	= netfs_data;
+
+	/* now we need to see whether the backing objects for this cookie yet
+	 * exist, if not there'll be nothing to search */
+	down_read(&fscache_addremove_sem);
+
+	if (list_empty(&fscache_cache_list)) {
+		up_read(&fscache_addremove_sem);
+		_leave(" = %p [no caches]", cookie);
+		return cookie;
+	}
+
+	/* if the object is an index then we need do nothing more here - we
+	 * create indexes on disk when we need them as an index may exist in
+	 * multiple caches */
+	if (cookie->def->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		down_write(&cookie->sem);
+
+		/* the object is a file - we need to select a cache in which to
+		 * store it */
+		cache = fscache_select_cache_for_object(cookie);
+		if (!cache)
+			goto no_cache; /* couldn't decide on a cache */
+
+		/* create a file index entry on disc, along with all the
+		 * indexes required to find it again later */
+		object = fscache_lookup_object(cookie, cache);
+		if (IS_ERR(object)) {
+			ret = PTR_ERR(object);
+			goto error;
+		}
+
+		up_write(&cookie->sem);
+	}
+out:
+	up_read(&fscache_addremove_sem);
+	_leave(" = %p", cookie);
+	return cookie;
+
+no_cache:
+	ret = -ENOMEDIUM;
+error:
+	printk(KERN_ERR "FS-Cache: error from cache: %d\n", ret);
+	if (cookie) {
+		up_write(&cookie->sem);
+		__fscache_cookie_put(cookie);
+		cookie = FSCACHE_NEGATIVE_COOKIE;
+		atomic_dec(&parent->children);
+	}
+
+	goto out;
+
+} /* end __fscache_acquire_cookie() */
+
+EXPORT_SYMBOL(__fscache_acquire_cookie);
+
+/*****************************************************************************/
+/*
+ * release a cookie back to the cache
+ * - the object will be marked as recyclable on disc if retire is true
+ * - all dependents of this cookie must have already been unregistered
+ *   (indexes/files/pages)
+ */
+void __fscache_relinquish_cookie(struct fscache_cookie *cookie, int retire)
+{
+	struct fscache_cache *cache;
+	struct fscache_object *object;
+	struct hlist_node *_p;
+
+	if (cookie == FSCACHE_NEGATIVE_COOKIE) {
+		_leave(" [no cookie]");
+		return;
+	}
+
+	_enter("%p{%s},%d", cookie, cookie->def->name, retire);
+
+	if (atomic_read(&cookie->children) != 0) {
+		printk("FS-Cache: cookie still has children\n");
+		BUG();
+	}
+
+	/* detach pointers back to the netfs */
+	down_write(&cookie->sem);
+
+	cookie->netfs_data	= NULL;
+	cookie->def		= NULL;
+
+	/* mark retired objects for recycling */
+	if (retire) {
+		hlist_for_each_entry(object, _p,
+				     &cookie->backing_objects,
+				     cookie_link
+				     ) {
+			set_bit(FSCACHE_OBJECT_RECYCLING, &object->flags);
+		}
+	}
+
+	/* break links with all the active objects */
+	while (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object,
+				     cookie_link);
+
+		/* detach each cache object from the object cookie */
+		set_bit(FSCACHE_OBJECT_RELEASING, &object->flags);
+
+		hlist_del_init(&object->cookie_link);
+
+		cache = object->cache;
+		cache->ops->lock_object(object);
+		object->cookie = NULL;
+		cache->ops->unlock_object(object);
+
+		if (atomic_dec_and_test(&cookie->usage))
+			/* the cookie refcount shouldn't be reduced to 0 yet */
+			BUG();
+
+		spin_lock(&cache->object_list_lock);
+		list_del_init(&object->cache_link);
+		spin_unlock(&cache->object_list_lock);
+
+		cache->ops->put_object(object);
+	}
+
+	up_write(&cookie->sem);
+
+	if (cookie->parent) {
+#ifdef CONFIG_DEBUG_SLAB
+		BUG_ON((atomic_read(&cookie->parent->children) & 0xffff0000) == 0x6b6b0000);
+#endif
+		atomic_dec(&cookie->parent->children);
+	}
+
+	/* finally dispose of the cookie */
+	fscache_cookie_put(cookie);
+
+	_leave("");
+
+} /* end __fscache_relinquish_cookie() */
+
+EXPORT_SYMBOL(__fscache_relinquish_cookie);
+
+/*****************************************************************************/
+/*
+ * update the index entries backing a cookie
+ */
+void __fscache_update_cookie(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+	struct hlist_node *_p;
+
+	if (cookie == FSCACHE_NEGATIVE_COOKIE) {
+		_leave(" [no cookie]");
+		return;
+	}
+
+	_enter("{%s}", cookie->def->name);
+
+	BUG_ON(!cookie->def->get_aux);
+
+	down_write(&cookie->sem);
+	down_read(&cookie->parent->sem);
+
+	/* update the index entry on disc in each cache backing this cookie */
+	hlist_for_each_entry(object, _p,
+			     &cookie->backing_objects, cookie_link
+			     ) {
+		object->cache->ops->update_object(object);
+	}
+
+	up_read(&cookie->parent->sem);
+	up_write(&cookie->sem);
+	_leave("");
+
+} /* end __fscache_update_cookie() */
+
+EXPORT_SYMBOL(__fscache_update_cookie);
+
+/*****************************************************************************/
+/*
+ * destroy a cookie
+ */
+static void __fscache_cookie_put(struct fscache_cookie *cookie)
+{
+	struct fscache_cookie *parent;
+
+	_enter("%p", cookie);
+
+	for (;;) {
+		parent = cookie->parent;
+		BUG_ON(!hlist_empty(&cookie->backing_objects));
+		kmem_cache_free(fscache_cookie_jar, cookie);
+
+		if (!parent)
+			break;
+
+		cookie = parent;
+		BUG_ON(atomic_read(&cookie->usage) <= 0);
+		if (!atomic_dec_and_test(&cookie->usage))
+			break;
+	}
+
+	_leave("");
+
+} /* end __fscache_cookie_put() */
+
+/*****************************************************************************/
+/*
+ * initialise an cookie jar slab element prior to any use
+ */
+void fscache_cookie_init_once(void *_cookie, kmem_cache_t *cachep,
+			      unsigned long flags)
+{
+	struct fscache_cookie *cookie = _cookie;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		memset(cookie, 0, sizeof(*cookie));
+		init_rwsem(&cookie->sem);
+		INIT_HLIST_HEAD(&cookie->backing_objects);
+	}
+
+} /* end fscache_cookie_init_once() */
+
+/*****************************************************************************/
+/*
+ * pin an object into the cache
+ */
+int __fscache_pin_cookie(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p", cookie);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" = -ENOBUFS");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it and exclude
+	 * read and write attempts on pages
+	 */
+	down_write(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		if (!object->cache->ops->pin_object) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->pin_object(object);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+out:
+	up_write(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_pin_cookie() */
+
+EXPORT_SYMBOL(__fscache_pin_cookie);
+
+/*****************************************************************************/
+/*
+ * unpin an object into the cache
+ */
+void __fscache_unpin_cookie(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p", cookie);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" [no obj]");
+		return;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it and exclude
+	 * read and write attempts on pages
+	 */
+	down_write(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and unpin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		if (!object->cache->ops->unpin_object)
+			goto out;
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				object->cache->ops->unpin_object(object);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+out:
+	up_write(&cookie->sem);
+	_leave("");
+
+} /* end __fscache_unpin_cookie() */
+
+EXPORT_SYMBOL(__fscache_unpin_cookie);
diff -uNrp linux-2.6.14-mm2/fs/fscache/fscache-int.h linux-2.6.14-mm2-cachefs/fs/fscache/fscache-int.h
--- linux-2.6.14-mm2/fs/fscache/fscache-int.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/fscache-int.h	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,71 @@
+/* fscache-int.h: internal definitions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _FSCACHE_INT_H
+#define _FSCACHE_INT_H
+
+#include <linux/fscache-cache.h>
+#include <linux/timer.h>
+#include <linux/bio.h>
+
+extern kmem_cache_t *fscache_cookie_jar;
+
+extern struct fscache_cookie fscache_fsdef_index;
+extern struct fscache_cookie_def fscache_fsdef_netfs_def;
+
+extern void fscache_cookie_init_once(void *_cookie, kmem_cache_t *cachep, unsigned long flags);
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
+#endif /* _FSCACHE_INT_H */
diff -uNrp linux-2.6.14-mm2/fs/fscache/fsdef.c linux-2.6.14-mm2-cachefs/fs/fscache/fsdef.c
--- linux-2.6.14-mm2/fs/fscache/fsdef.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/fsdef.c	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,113 @@
+/* fsdef.c: filesystem index definition
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include "fscache-int.h"
+
+static uint16_t fscache_fsdef_netfs_get_key(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax);
+
+static uint16_t fscache_fsdef_netfs_get_aux(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax);
+
+static fscache_checkaux_t fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
+							const void *data,
+							uint16_t datalen);
+
+struct fscache_cookie_def fscache_fsdef_netfs_def = {
+	.name		= "FSDEF.netfs",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= fscache_fsdef_netfs_get_key,
+	.get_aux	= fscache_fsdef_netfs_get_aux,
+	.check_aux	= fscache_fsdef_netfs_check_aux,
+};
+
+struct fscache_cookie fscache_fsdef_index = {
+	.usage		= ATOMIC_INIT(1),
+	.def		= NULL,
+	.sem		= __RWSEM_INITIALIZER(fscache_fsdef_index.sem),
+	.backing_objects = HLIST_HEAD_INIT,
+};
+
+EXPORT_SYMBOL(fscache_fsdef_index);
+
+/*****************************************************************************/
+/*
+ * get the key data for an FSDEF index record
+ */
+static uint16_t fscache_fsdef_netfs_get_key(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax)
+{
+	const struct fscache_netfs *netfs = cookie_netfs_data;
+	unsigned klen;
+
+	_enter("{%s.%u},", netfs->name, netfs->version);
+
+	klen = strlen(netfs->name);
+	if (klen > bufmax)
+		return 0;
+
+	memcpy(buffer, netfs->name, klen);
+	return klen;
+
+} /* end fscache_fsdef_netfs_get_key() */
+
+/*****************************************************************************/
+/*
+ * get the auxilliary data for an FSDEF index record
+ */
+static uint16_t fscache_fsdef_netfs_get_aux(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax)
+{
+	const struct fscache_netfs *netfs = cookie_netfs_data;
+	unsigned dlen;
+
+	_enter("{%s.%u},", netfs->name, netfs->version);
+
+	dlen = sizeof(uint32_t);
+	if (dlen > bufmax)
+		return 0;
+
+	memcpy(buffer, &netfs->version, dlen);
+	return dlen;
+
+} /* end fscache_fsdef_netfs_get_aux() */
+
+/*****************************************************************************/
+/*
+ * check that the version stored in the auxilliary data is correct
+ */
+static fscache_checkaux_t fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
+							const void *data,
+							uint16_t datalen)
+{
+	struct fscache_netfs *netfs = cookie_netfs_data;
+	uint32_t version;
+
+	_enter("{%s},,%hu", netfs->name, datalen);
+
+	if (datalen != sizeof(version)) {
+		_leave(" = OBSOLETE [dl=%d v=%d]",
+		       datalen, sizeof(version));
+		return FSCACHE_CHECKAUX_OBSOLETE;
+	}
+
+	memcpy(&version, data, sizeof(version));
+	if (version != netfs->version) {
+		_leave(" = OBSOLETE [ver=%x net=%x]",
+		       version, netfs->version);
+		return FSCACHE_CHECKAUX_OBSOLETE;
+	}
+
+	_leave(" = OKAY");
+	return FSCACHE_CHECKAUX_OKAY;
+
+} /* end fscache_fsdef_netfs_check_aux() */
diff -uNrp linux-2.6.14-mm2/fs/fscache/main.c linux-2.6.14-mm2-cachefs/fs/fscache/main.c
--- linux-2.6.14-mm2/fs/fscache/main.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/main.c	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,112 @@
+/* main.c: general filesystem caching manager
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
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
+#include "fscache-int.h"
+
+int fscache_debug = 0;
+
+static int fscache_init(void);
+static void fscache_exit(void);
+
+fs_initcall(fscache_init);
+module_exit(fscache_exit);
+
+MODULE_DESCRIPTION("FS Cache Manager");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+/*****************************************************************************/
+/*
+ * initialise the fs caching module
+ */
+static int fscache_init(void)
+{
+	fscache_cookie_jar =
+		kmem_cache_create("fscache_cookie_jar",
+				  sizeof(struct fscache_cookie),
+				  0,
+				  0,
+				  fscache_cookie_init_once,
+				  NULL);
+
+	if (!fscache_cookie_jar) {
+		printk(KERN_NOTICE
+		       "FS-Cache: Failed to allocate a cookie jar\n");
+		return -ENOMEM;
+	}
+
+	printk(KERN_NOTICE "FS-Cache: Loaded\n");
+	return 0;
+
+} /* end fscache_init() */
+
+/*****************************************************************************/
+/*
+ * clean up on module removal
+ */
+static void __exit fscache_exit(void)
+{
+	_enter("");
+
+	kmem_cache_destroy(fscache_cookie_jar);
+	printk(KERN_NOTICE "FS-Cache: unloaded\n");
+
+} /* end fscache_exit() */
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
diff -uNrp linux-2.6.14-mm2/fs/fscache/Makefile linux-2.6.14-mm2-cachefs/fs/fscache/Makefile
--- linux-2.6.14-mm2/fs/fscache/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/Makefile	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,13 @@
+#
+# Makefile for general filesystem caching code
+#
+
+#CFLAGS += -finstrument-functions
+
+fscache-objs := \
+	cookie.o \
+	fsdef.o \
+	main.o \
+	page.o
+
+obj-$(CONFIG_FSCACHE) := fscache.o
diff -uNrp linux-2.6.14-mm2/fs/fscache/page.c linux-2.6.14-mm2-cachefs/fs/fscache/page.c
--- linux-2.6.14-mm2/fs/fscache/page.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/fs/fscache/page.c	2005-11-14 16:41:41.000000000 +0000
@@ -0,0 +1,521 @@
+/* page.c: general filesystem cache cookie management
+ *
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/fscache-cache.h>
+#include <linux/buffer_head.h>
+#include <linux/pagevec.h>
+#include "fscache-int.h"
+
+/*****************************************************************************/
+/*
+ * set the data file size on an object in the cache
+ */
+int __fscache_set_i_size(struct fscache_cookie *cookie, loff_t i_size)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,%llu,", cookie, i_size);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" = -ENOBUFS");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it and exclude
+	 * read and write attempts on pages
+	 */
+	down_write(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (object->cache->ops->set_i_size &&
+		    down_read_trylock(&object->cache->withdrawal_sem)
+		    ) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->set_i_size(object,
+								     i_size);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_write(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_set_i_size() */
+
+EXPORT_SYMBOL(__fscache_set_i_size);
+
+/*****************************************************************************/
+/*
+ * reserve space for an object
+ */
+int __fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,%llu,", cookie, size);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" = -ENOBUFS");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it and exclude
+	 * read and write attempts on pages
+	 */
+	down_write(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		if (!object->cache->ops->reserve_space) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->reserve_space(object,
+									size);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+out:
+	up_write(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_reserve_space() */
+
+EXPORT_SYMBOL(__fscache_reserve_space);
+
+/*****************************************************************************/
+/*
+ * read a page from the cache or allocate a block in which to store it
+ * - we return:
+ *   -ENOMEM	- out of memory, nothing done
+ *   -EINTR	- interrupted
+ *   -ENOBUFS	- no backing object available in which to cache the block
+ *   -ENODATA	- no data available in the backing object for this block
+ *   0		- dispatched a read - it'll call end_io_func() when finished
+ */
+int __fscache_read_or_alloc_page(struct fscache_cookie *cookie,
+				 struct page *page,
+				 fscache_rw_complete_t end_io_func,
+				 void *end_io_data,
+				 gfp_t gfp)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,{%lu},", cookie, page->index);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" -ENOBUFS [no backing objects]");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it */
+	down_read(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->read_or_alloc_page(
+					object,
+					page,
+					end_io_func,
+					end_io_data,
+					gfp);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_read_or_alloc_page() */
+
+EXPORT_SYMBOL(__fscache_read_or_alloc_page);
+
+/*****************************************************************************/
+/*
+ * read a list of page from the cache or allocate a block in which to store
+ * them
+ * - we return:
+ *   -ENOMEM	- out of memory, some pages may be being read
+ *   -EINTR	- interrupted, some pages may be being read
+ *   -ENOBUFS	- no backing object or space available in which to cache any
+ *                pages not being read
+ *   -ENODATA	- no data available in the backing object for some or all of
+ *                the pages
+ *   0		- dispatched a read on all pages
+ *
+ * end_io_func() will be called for each page read from the cache as it is
+ * finishes being read
+ *
+ * any pages for which a read is dispatched will be removed from pages and
+ * nr_pages
+ */
+int __fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
+				  struct address_space *mapping,
+				  struct list_head *pages,
+				  unsigned *nr_pages,
+				  fscache_rw_complete_t end_io_func,
+				  void *end_io_data,
+				  gfp_t gfp)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,,%d,,,", cookie, *nr_pages);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" -ENOBUFS [no backing objects]");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+	BUG_ON(list_empty(pages));
+	BUG_ON(*nr_pages <= 0);
+
+	/* prevent the file from being uncached whilst we access it */
+	down_read(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->read_or_alloc_pages(
+					object,
+					mapping,
+					pages,
+					nr_pages,
+					end_io_func,
+					end_io_data,
+					gfp);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_read_or_alloc_pages() */
+
+EXPORT_SYMBOL(__fscache_read_or_alloc_pages);
+
+/*****************************************************************************/
+/*
+ * allocate a block in the cache on which to store a page
+ * - we return:
+ *   -ENOMEM	- out of memory, nothing done
+ *   -EINTR	- interrupted
+ *   -ENOBUFS	- no backing object available in which to cache the block
+ *   0		- block allocated
+ */
+int __fscache_alloc_page(struct fscache_cookie *cookie,
+			 struct page *page,
+			 gfp_t gfp)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,{%lu},", cookie, page->index);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" -ENOBUFS [no backing objects]");
+		return -ENOBUFS;
+	}
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from being uncached whilst we access it */
+	down_read(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		/* get and pin the backing object */
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			if (object->cache->ops->grab_object(object)) {
+				/* ask the cache to honour the operation */
+				ret = object->cache->ops->allocate_page(object,
+									page,
+									gfp);
+
+				object->cache->ops->put_object(object);
+			}
+
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_alloc_page() */
+
+EXPORT_SYMBOL(__fscache_alloc_page);
+
+/*****************************************************************************/
+/*
+ * request a page be stored in the cache
+ * - returns:
+ *   -ENOMEM	- out of memory, nothing done
+ *   -EINTR	- interrupted
+ *   -ENOBUFS	- no backing object available in which to cache the page
+ *   0		- dispatched a write - it'll call end_io_func() when finished
+ */
+int __fscache_write_page(struct fscache_cookie *cookie,
+			 struct page *page,
+			 fscache_rw_complete_t end_io_func,
+			 void *end_io_data,
+			 gfp_t gfp)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,{%lu},", cookie, page->index);
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from been uncached whilst we deal with it */
+	down_read(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			/* ask the cache to honour the operation */
+			ret = object->cache->ops->write_page(object,
+							     page,
+							     end_io_func,
+							     end_io_data,
+							     gfp);
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_write_page() */
+
+EXPORT_SYMBOL(__fscache_write_page);
+
+/*****************************************************************************/
+/*
+ * request several pages be stored in the cache
+ * - returns:
+ *   -ENOMEM	- out of memory, nothing done
+ *   -EINTR	- interrupted
+ *   -ENOBUFS	- no backing object available in which to cache the page
+ *   0		- dispatched a write - it'll call end_io_func() when finished
+ */
+int __fscache_write_pages(struct fscache_cookie *cookie,
+			  struct pagevec *pagevec,
+			  fscache_rw_complete_t end_io_func,
+			  void *end_io_data,
+			  gfp_t gfp)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%p,{%d},", cookie, pagevec->nr);
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	/* prevent the file from been uncached whilst we deal with it */
+	down_read(&cookie->sem);
+
+	ret = -ENOBUFS;
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			/* ask the cache to honour the operation */
+			ret = object->cache->ops->write_pages(object,
+							      pagevec,
+							      end_io_func,
+							      end_io_data,
+							      gfp);
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+	_leave(" = %d", ret);
+	return ret;
+
+} /* end __fscache_write_pages() */
+
+EXPORT_SYMBOL(__fscache_write_pages);
+
+/*****************************************************************************/
+/*
+ * remove a page from the cache
+ */
+void __fscache_uncache_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct fscache_object *object;
+	struct pagevec pagevec;
+
+	_enter(",{%lu}", page->index);
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" [no backing]");
+		return;
+	}
+
+	pagevec_init(&pagevec, 0);
+	pagevec_add(&pagevec, page);
+
+	/* ask the cache to honour the operation */
+	down_read(&cookie->sem);
+
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			object->cache->ops->uncache_pages(object, &pagevec);
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+
+	_leave("");
+	return;
+
+} /* end __fscache_uncache_page() */
+
+EXPORT_SYMBOL(__fscache_uncache_page);
+
+/*****************************************************************************/
+/*
+ * remove a bunch of pages from the cache
+ */
+void __fscache_uncache_pages(struct fscache_cookie *cookie,
+			     struct pagevec *pagevec)
+{
+	struct fscache_object *object;
+
+	_enter(",{%d}", pagevec->nr);
+
+	BUG_ON(pagevec->nr <= 0);
+	BUG_ON(!pagevec->pages[0]);
+
+	/* not supposed to use this for indexes */
+	BUG_ON(cookie->def->type == FSCACHE_COOKIE_TYPE_INDEX);
+
+	if (hlist_empty(&cookie->backing_objects)) {
+		_leave(" [no backing]");
+		return;
+	}
+
+	/* ask the cache to honour the operation */
+	down_read(&cookie->sem);
+
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		/* prevent the cache from being withdrawn */
+		if (down_read_trylock(&object->cache->withdrawal_sem)) {
+			object->cache->ops->uncache_pages(object, pagevec);
+			up_read(&object->cache->withdrawal_sem);
+		}
+	}
+
+	up_read(&cookie->sem);
+
+	_leave("");
+	return;
+
+} /* end __fscache_uncache_pages() */
+
+EXPORT_SYMBOL(__fscache_uncache_pages);
