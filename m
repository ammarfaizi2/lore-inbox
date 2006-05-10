Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWEJQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWEJQEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWEJQC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:02:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18345 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750880AbWEJQBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:54 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/14] FS-Cache: Make kAFS use FS-Cache [try #8]
Date: Wed, 10 May 2006 17:01:44 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160143.9058.78894.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the kAFS filesystem in fs/afs/ use FS-Cache, and
through it any attached caches.  The kAFS filesystem will use caching
automatically if it's available.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig         |    7 +
 fs/afs/cache.h     |   27 ------
 fs/afs/cell.c      |  109 ++++++++++++++---------
 fs/afs/cell.h      |   16 +--
 fs/afs/cmservice.c |    2 
 fs/afs/dir.c       |   10 +-
 fs/afs/file.c      |  237 +++++++++++++++++++++++++++++++++-----------------
 fs/afs/fsclient.c  |    4 +
 fs/afs/inode.c     |   43 ++++++---
 fs/afs/internal.h  |   24 ++---
 fs/afs/main.c      |   24 ++---
 fs/afs/mntpt.c     |   12 +--
 fs/afs/proc.c      |    1 
 fs/afs/server.c    |    3 -
 fs/afs/vlocation.c |  179 +++++++++++++++++++++++---------------
 fs/afs/vnode.c     |  248 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/afs/vnode.h     |   10 +-
 fs/afs/volume.c    |   78 ++++++----------
 fs/afs/volume.h    |   28 +-----
 19 files changed, 654 insertions(+), 408 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 66acf29..6c95e58 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1816,6 +1816,13 @@ # for fs/nls/Config.in
 
 	  If unsure, say N.
 
+config AFS_FSCACHE
+	bool "Provide AFS client caching support"
+	depends on AFS_FS && FSCACHE && EXPERIMENTAL
+	help
+	  Say Y here if you want AFS data to be cached locally on through the
+	  generic filesystem cache manager
+
 config RXRPC
 	tristate
 
diff --git a/fs/afs/cache.h b/fs/afs/cache.h
deleted file mode 100644
index 9eb7722..0000000
--- a/fs/afs/cache.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* cache.h: AFS local cache management interface
- *
- * Copyright (C) 2002 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _LINUX_AFS_CACHE_H
-#define _LINUX_AFS_CACHE_H
-
-#undef AFS_CACHING_SUPPORT
-
-#include <linux/mm.h>
-#ifdef AFS_CACHING_SUPPORT
-#include <linux/cachefs.h>
-#endif
-#include "types.h"
-
-#ifdef __KERNEL__
-
-#endif /* __KERNEL__ */
-
-#endif /* _LINUX_AFS_CACHE_H */
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 009a9ae..93a0846 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -31,17 +31,21 @@ static DEFINE_RWLOCK(afs_cells_lock);
 static DECLARE_RWSEM(afs_cells_sem); /* add/remove serialisation */
 static struct afs_cell *afs_cell_root;
 
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_cell_cache_match(void *target,
-						const void *entry);
-static void afs_cell_cache_update(void *source, void *entry);
-
-struct cachefs_index_def afs_cache_cell_index_def = {
-	.name			= "cell_ix",
-	.data_size		= sizeof(struct afs_cache_cell),
-	.keys[0]		= { CACHEFS_INDEX_KEYS_ASCIIZ, 64 },
-	.match			= afs_cell_cache_match,
-	.update			= afs_cell_cache_update,
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_cell_cache_get_key(const void *cookie_netfs_data,
+				       void *buffer, uint16_t buflen);
+static uint16_t afs_cell_cache_get_aux(const void *cookie_netfs_data,
+				       void *buffer, uint16_t buflen);
+static fscache_checkaux_t afs_cell_cache_check_aux(void *cookie_netfs_data,
+						   const void *buffer,
+						   uint16_t buflen);
+
+static struct fscache_cookie_def afs_cell_cache_index_def = {
+	.name		= "AFS cell",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= afs_cell_cache_get_key,
+	.get_aux	= afs_cell_cache_get_aux,
+	.check_aux	= afs_cell_cache_check_aux,
 };
 #endif
 
@@ -115,12 +119,11 @@ int afs_cell_create(const char *name, ch
 	if (ret < 0)
 		goto error;
 
-#ifdef AFS_CACHING_SUPPORT
-	/* put it up for caching */
-	cachefs_acquire_cookie(afs_cache_netfs.primary_index,
-			       &afs_vlocation_cache_index_def,
-			       cell,
-			       &cell->cache);
+#ifdef CONFIG_AFS_FSCACHE
+	/* put it up for caching (this never returns an error) */
+	cell->cache = fscache_acquire_cookie(afs_cache_netfs.primary_index,
+					     &afs_cell_cache_index_def,
+					     cell);
 #endif
 
 	/* add to the cell lists */
@@ -345,8 +348,8 @@ static void afs_cell_destroy(struct afs_
 	list_del_init(&cell->proc_link);
 	up_write(&afs_proc_cells_sem);
 
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_relinquish_cookie(cell->cache, 0);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_relinquish_cookie(cell->cache, 0);
 #endif
 
 	up_write(&afs_cells_sem);
@@ -526,44 +529,62 @@ void afs_cell_purge(void)
 
 /*****************************************************************************/
 /*
- * match a cell record obtained from the cache
+ * set the key for the index entry
  */
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_cell_cache_match(void *target,
-						const void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_cell_cache_get_key(const void *cookie_netfs_data,
+				       void *buffer, uint16_t bufmax)
 {
-	const struct afs_cache_cell *ccell = entry;
-	struct afs_cell *cell = target;
+	const struct afs_cell *cell = cookie_netfs_data;
+	uint16_t klen;
 
-	_enter("{%s},{%s}", ccell->name, cell->name);
+	_enter("%p,%p,%u", cell, buffer, bufmax);
 
-	if (strncmp(ccell->name, cell->name, sizeof(ccell->name)) == 0) {
-		_leave(" = SUCCESS");
-		return CACHEFS_MATCH_SUCCESS;
-	}
+	klen = strlen(cell->name);
+	if (klen > bufmax)
+		return 0;
+
+	memcpy(buffer, cell->name, klen);
+	return klen;
 
-	_leave(" = FAILED");
-	return CACHEFS_MATCH_FAILED;
-} /* end afs_cell_cache_match() */
+} /* end afs_cell_cache_get_key() */
 #endif
 
 /*****************************************************************************/
 /*
- * update a cell record in the cache
+ * provide new auxilliary cache data
  */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_cell_cache_update(void *source, void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_cell_cache_get_aux(const void *cookie_netfs_data,
+				       void *buffer, uint16_t bufmax)
 {
-	struct afs_cache_cell *ccell = entry;
-	struct afs_cell *cell = source;
+	const struct afs_cell *cell = cookie_netfs_data;
+	uint16_t dlen;
 
-	_enter("%p,%p", source, entry);
+	_enter("%p,%p,%u", cell, buffer, bufmax);
 
-	strncpy(ccell->name, cell->name, sizeof(ccell->name));
+	dlen = cell->vl_naddrs * sizeof(cell->vl_addrs[0]);
+	dlen = min(dlen, bufmax);
+	dlen &= ~(sizeof(cell->vl_addrs[0]) - 1);
 
-	memcpy(ccell->vl_servers,
-	       cell->vl_addrs,
-	       min(sizeof(ccell->vl_servers), sizeof(cell->vl_addrs)));
+	memcpy(buffer, cell->vl_addrs, dlen);
+
+	return dlen;
+
+} /* end afs_cell_cache_get_aux() */
+#endif
+
+/*****************************************************************************/
+/*
+ * check that the auxilliary data indicates that the entry is still valid
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static fscache_checkaux_t afs_cell_cache_check_aux(void *cookie_netfs_data,
+						   const void *buffer,
+						   uint16_t buflen)
+{
+	_leave(" = OKAY");
+	return FSCACHE_CHECKAUX_OKAY;
 
-} /* end afs_cell_cache_update() */
+} /* end afs_cell_cache_check_aux() */
 #endif
diff --git a/fs/afs/cell.h b/fs/afs/cell.h
index 4834910..d670502 100644
--- a/fs/afs/cell.h
+++ b/fs/afs/cell.h
@@ -13,7 +13,7 @@ #ifndef _LINUX_AFS_CELL_H
 #define _LINUX_AFS_CELL_H
 
 #include "types.h"
-#include "cache.h"
+#include <linux/fscache.h>
 
 #define AFS_CELL_MAX_ADDRS 15
 
@@ -21,16 +21,6 @@ extern volatile int afs_cells_being_purg
 
 /*****************************************************************************/
 /*
- * entry in the cached cell catalogue
- */
-struct afs_cache_cell
-{
-	char			name[64];	/* cell name (padded with NULs) */
-	struct in_addr		vl_servers[15];	/* cached cell VL servers */
-};
-
-/*****************************************************************************/
-/*
  * AFS cell record
  */
 struct afs_cell
@@ -39,8 +29,8 @@ struct afs_cell
 	struct list_head	link;		/* main cell list link */
 	struct list_head	proc_link;	/* /proc cell list link */
 	struct proc_dir_entry	*proc_dir;	/* /proc dir for this cell */
-#ifdef AFS_CACHING_SUPPORT
-	struct cachefs_cookie	*cache;		/* caching cookie */
+#ifdef CONFIG_AFS_FSCACHE
+	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
 
 	/* server record management */
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 3d097fd..f87d5a7 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -24,7 +24,7 @@ #include "cmservice.h"
 #include "internal.h"
 
 static unsigned afscm_usage;		/* AFS cache manager usage count */
-static struct rw_semaphore afscm_sem;	/* AFS cache manager start/stop semaphore */
+static DECLARE_RWSEM(afscm_sem);	/* AFS cache manager start/stop semaphore */
 
 static int afscm_new_call(struct rxrpc_call *call);
 static void afscm_attention(struct rxrpc_call *call);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c23de2b..b8e7c32 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -145,7 +145,7 @@ #endif
 	qty /= sizeof(union afs_dir_block);
 
 	/* check them */
-	dbuf = page_address(page);
+	dbuf = kmap_atomic(page, KM_USER0);
 	for (tmp = 0; tmp < qty; tmp++) {
 		if (dbuf->blocks[tmp].pagehdr.magic != AFS_DIR_MAGIC) {
 			printk("kAFS: %s(%lu): bad magic %d/%d is %04hx\n",
@@ -154,10 +154,12 @@ #endif
 			goto error;
 		}
 	}
+	kunmap_atomic(dbuf, KM_USER0);
 
 	return;
 
  error:
+	kunmap_atomic(dbuf, KM_USER0);
 	SetPageError(page);
 
 } /* end afs_dir_check_page() */
@@ -168,7 +170,6 @@ #endif
  */
 static inline void afs_dir_put_page(struct page *page)
 {
-	kunmap(page);
 	page_cache_release(page);
 
 } /* end afs_dir_put_page() */
@@ -188,7 +189,6 @@ static struct page *afs_dir_get_page(str
 			       NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
-		kmap(page);
 		if (!PageUptodate(page))
 			goto fail;
 		afs_dir_check_page(dir, page);
@@ -356,7 +356,7 @@ static int afs_dir_iterate(struct inode 
 
 		limit = blkoff & ~(PAGE_SIZE - 1);
 
-		dbuf = page_address(page);
+		dbuf = kmap_atomic(page, KM_USER0);
 
 		/* deal with the individual blocks stashed on this page */
 		do {
@@ -365,6 +365,7 @@ static int afs_dir_iterate(struct inode 
 			ret = afs_dir_iterate_block(fpos, dblock, blkoff,
 						    cookie, filldir);
 			if (ret != 1) {
+				kunmap_atomic(dbuf, KM_USER0);
 				afs_dir_put_page(page);
 				goto out;
 			}
@@ -373,6 +374,7 @@ static int afs_dir_iterate(struct inode 
 
 		} while (*fpos < dir->i_size && blkoff < limit);
 
+		kunmap_atomic(dbuf, KM_USER0);
 		afs_dir_put_page(page);
 		ret = 0;
 	}
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 7bb7168..21e45bb 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -16,12 +16,15 @@ #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/buffer_head.h>
 #include "volume.h"
 #include "vnode.h"
 #include <rxrpc/call.h>
 #include "internal.h"
 
+#define list_to_page(head) (list_entry((head)->prev, struct page, lru))
+
 #if 0
 static int afs_file_open(struct inode *inode, struct file *file);
 static int afs_file_release(struct inode *inode, struct file *file);
@@ -30,30 +33,68 @@ #endif
 static int afs_file_readpage(struct file *file, struct page *page);
 static void afs_file_invalidatepage(struct page *page, unsigned long offset);
 static int afs_file_releasepage(struct page *page, gfp_t gfp_flags);
+static int afs_file_mmap(struct file * file, struct vm_area_struct * vma);
+
+#ifdef CONFIG_AFS_FSCACHE
+static int afs_file_readpages(struct file *filp, struct address_space *mapping,
+			      struct list_head *pages, unsigned nr_pages);
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page);
+#endif
 
 struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_inode_getattr,
 };
 
+struct file_operations afs_file_file_operations = {
+	.read		= generic_file_read,
+	.mmap		= afs_file_mmap,
+};
+
 struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
+#ifdef CONFIG_AFS_FSCACHE
+	.readpages	= afs_file_readpages,
+#endif
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
 };
 
+static struct vm_operations_struct afs_fs_vm_operations = {
+	.nopage		= filemap_nopage,
+	.populate	= filemap_populate,
+#ifdef CONFIG_AFS_FSCACHE
+	.page_mkwrite	= afs_file_page_mkwrite,
+#endif
+};
+
+/*****************************************************************************/
+/*
+ * set up a memory mapping on an AFS file
+ * - we set our own VMA ops so that we can catch the page becoming writable for
+ *   userspace for shared-writable mmap
+ */
+static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	_enter("");
+
+	file_accessed(file);
+	vma->vm_ops = &afs_fs_vm_operations;
+	return 0;
+
+} /* end afs_file_mmap() */
+
 /*****************************************************************************/
 /*
  * deal with notification that a page was read from the cache
  */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_file_readpage_read_complete(void *cookie_data,
-					    struct page *page,
+#ifdef CONFIG_AFS_FSCACHE
+static void afs_file_readpage_read_complete(struct page *page,
 					    void *data,
 					    int error)
 {
-	_enter("%p,%p,%p,%d", cookie_data, page, data, error);
+	_enter("%p,%p,%d", page, data, error);
 
 	if (error)
 		SetPageError(page);
@@ -68,15 +109,16 @@ #endif
 /*
  * deal with notification that a page was written to the cache
  */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_file_readpage_write_complete(void *cookie_data,
-					     struct page *page,
+#ifdef CONFIG_AFS_FSCACHE
+static void afs_file_readpage_write_complete(struct page *page,
 					     void *data,
 					     int error)
 {
-	_enter("%p,%p,%p,%d", cookie_data, page, data, error);
+	_enter("%p,%p,%d", page, data, error);
 
-	unlock_page(page);
+	/* note that the page has been written to the cache and can now be
+	 * modified */
+	end_page_fs_misc(page);
 
 } /* end afs_file_readpage_write_complete() */
 #endif
@@ -88,16 +130,13 @@ #endif
 static int afs_file_readpage(struct file *file, struct page *page)
 {
 	struct afs_rxfs_fetch_descriptor desc;
-#ifdef AFS_CACHING_SUPPORT
-	struct cachefs_page *pageio;
-#endif
 	struct afs_vnode *vnode;
 	struct inode *inode;
 	int ret;
 
 	inode = page->mapping->host;
 
-	_enter("{%lu},{%lu}", inode->i_ino, page->index);
+	_enter("{%lu},%p{%lu}", inode->i_ino, page, page->index);
 
 	vnode = AFS_FS_I(inode);
 
@@ -107,13 +146,9 @@ #endif
 	if (vnode->flags & AFS_VNODE_DELETED)
 		goto error;
 
-#ifdef AFS_CACHING_SUPPORT
-	ret = cachefs_page_get_private(page, &pageio, GFP_NOIO);
-	if (ret < 0)
-		goto error;
-
+#ifdef CONFIG_AFS_FSCACHE
 	/* is it cached? */
-	ret = cachefs_read_or_alloc_page(vnode->cache,
+	ret = fscache_read_or_alloc_page(vnode->cache,
 					 page,
 					 afs_file_readpage_read_complete,
 					 NULL,
@@ -123,18 +158,20 @@ #else
 #endif
 
 	switch (ret) {
-		/* read BIO submitted and wb-journal entry found */
-	case 1:
-		BUG(); // TODO - handle wb-journal match
-
 		/* read BIO submitted (page in cache) */
 	case 0:
 		break;
 
-		/* no page available in cache */
-	case -ENOBUFS:
+		/* page not yet cached */
 	case -ENODATA:
+		_debug("cache said ENODATA");
+		goto go_on;
+
+		/* page will not be cached */
+	case -ENOBUFS:
+		_debug("cache said ENOBUFS");
 	default:
+	go_on:
 		desc.fid	= vnode->fid;
 		desc.offset	= page->index << PAGE_CACHE_SHIFT;
 		desc.size	= min((size_t) (inode->i_size - desc.offset),
@@ -148,34 +185,40 @@ #endif
 		ret = afs_vnode_fetch_data(vnode, &desc);
 		kunmap(page);
 		if (ret < 0) {
-			if (ret==-ENOENT) {
-				_debug("got NOENT from server"
+			if (ret == -ENOENT) {
+				kdebug("got NOENT from server"
 				       " - marking file deleted and stale");
 				vnode->flags |= AFS_VNODE_DELETED;
 				ret = -ESTALE;
 			}
 
-#ifdef AFS_CACHING_SUPPORT
-			cachefs_uncache_page(vnode->cache, page);
+#ifdef CONFIG_AFS_FSCACHE
+			fscache_uncache_page(vnode->cache, page);
+			ClearPagePrivate(page);
 #endif
 			goto error;
 		}
 
 		SetPageUptodate(page);
 
-#ifdef AFS_CACHING_SUPPORT
-		if (cachefs_write_page(vnode->cache,
-				       page,
-				       afs_file_readpage_write_complete,
-				       NULL,
-				       GFP_KERNEL) != 0
-		    ) {
-			cachefs_uncache_page(vnode->cache, page);
-			unlock_page(page);
+		/* send the page to the cache */
+#ifdef CONFIG_AFS_FSCACHE
+		if (PagePrivate(page)) {
+			if (TestSetPageFsMisc(page))
+				BUG();
+			if (fscache_write_page(vnode->cache,
+					       page,
+					       afs_file_readpage_write_complete,
+					       NULL,
+					       GFP_KERNEL) != 0
+			    ) {
+				fscache_uncache_page(vnode->cache, page);
+				ClearPagePrivate(page);
+				end_page_fs_misc(page);
+			}
 		}
-#else
-		unlock_page(page);
 #endif
+		unlock_page(page);
 	}
 
 	_leave(" = 0");
@@ -192,20 +235,63 @@ #endif
 
 /*****************************************************************************/
 /*
- * get a page cookie for the specified page
+ * read a set of pages
  */
-#ifdef AFS_CACHING_SUPPORT
-int afs_cache_get_page_cookie(struct page *page,
-			      struct cachefs_page **_page_cookie)
+#ifdef CONFIG_AFS_FSCACHE
+static int afs_file_readpages(struct file *filp, struct address_space *mapping,
+			      struct list_head *pages, unsigned nr_pages)
 {
-	int ret;
+	struct afs_vnode *vnode;
+#if 0
+	struct pagevec lru_pvec;
+	unsigned page_idx;
+#endif
+	int ret = 0;
 
-	_enter("");
-	ret = cachefs_page_get_private(page,_page_cookie, GFP_NOIO);
+	_enter(",{%lu},,%d", mapping->host->i_ino, nr_pages);
 
-	_leave(" = %d", ret);
+	vnode = AFS_FS_I(mapping->host);
+	if (vnode->flags & AFS_VNODE_DELETED) {
+		_leave(" = -ESTALE");
+		return -ESTALE;
+	}
+
+	/* attempt to read as many of the pages as possible */
+	ret = fscache_read_or_alloc_pages(vnode->cache,
+					  mapping,
+					  pages,
+					  &nr_pages,
+					  afs_file_readpage_read_complete,
+					  NULL,
+					  mapping_gfp_mask(mapping));
+
+	switch (ret) {
+		/* all pages are being read from the cache */
+	case 0:
+		BUG_ON(!list_empty(pages));
+		BUG_ON(nr_pages != 0);
+		_leave(" = 0 [reading all]");
+		return 0;
+
+		/* there were pages that couldn't be read from the cache */
+	case -ENODATA:
+	case -ENOBUFS:
+		break;
+
+		/* other error */
+	default:
+		_leave(" = %d", ret);
+		return ret;
+	}
+
+	/* load the missing pages from the network */
+	ret = read_cache_pages(mapping, pages,
+			       (void *) afs_file_readpage, NULL);
+
+	_leave(" = %d [netting]", ret);
 	return ret;
-} /* end afs_cache_get_page_cookie() */
+
+} /* end afs_file_readpages() */
 #endif
 
 /*****************************************************************************/
@@ -214,35 +300,22 @@ #endif
  */
 static void afs_file_invalidatepage(struct page *page, unsigned long offset)
 {
-	int ret = 1;
-
 	_enter("{%lu},%lu", page->index, offset);
 
 	BUG_ON(!PageLocked(page));
 
 	if (PagePrivate(page)) {
-#ifdef AFS_CACHING_SUPPORT
-		struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-		cachefs_uncache_page(vnode->cache,page);
-#endif
-
 		/* We release buffers only if the entire page is being
 		 * invalidated.
 		 * The get_block cached value has been unconditionally
 		 * invalidated, so real IO is not possible anymore.
 		 */
-		if (offset == 0) {
-			BUG_ON(!PageLocked(page));
-
-			ret = 0;
-			if (!PageWriteback(page))
-				ret = page->mapping->a_ops->releasepage(page,
-									0);
-			/* possibly should BUG_ON(!ret); - neilb */
-		}
+		if (offset == 0 && !PageWriteback(page))
+			page->mapping->a_ops->releasepage(page, 0);
 	}
 
-	_leave(" = %d", ret);
+	_leave("");
+
 } /* end afs_file_invalidatepage() */
 
 /*****************************************************************************/
@@ -251,23 +324,29 @@ #endif
  */
 static int afs_file_releasepage(struct page *page, gfp_t gfp_flags)
 {
-	struct cachefs_page *pageio;
-
 	_enter("{%lu},%x", page->index, gfp_flags);
 
-	if (PagePrivate(page)) {
-#ifdef AFS_CACHING_SUPPORT
-		struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-		cachefs_uncache_page(vnode->cache, page);
+#ifdef CONFIG_AFS_FSCACHE
+	wait_on_page_fs_misc(page);
+	fscache_uncache_page(AFS_FS_I(page->mapping->host)->cache, page);
+	ClearPagePrivate(page);
 #endif
 
-		pageio = (struct cachefs_page *) page_private(page);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-
-		kfree(pageio);
-	}
-
 	_leave(" = 0");
 	return 0;
+
 } /* end afs_file_releasepage() */
+
+/*****************************************************************************/
+/*
+ * wait for the disc cache to finish writing before permitting modification of
+ * our page in the page cache
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+
+} /* end afs_file_page_mkwrite() */
+#endif
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 61bc371..c88c41a 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -398,6 +398,8 @@ int afs_rxfs_fetch_file_status(struct af
 		bp++; /* spare6 */
 	}
 
+	_debug("Data Version %llx\n", vnode->status.version);
+
 	/* success */
 	ret = 0;
 
@@ -408,7 +410,7 @@ int afs_rxfs_fetch_file_status(struct af
  out_put_conn:
 	afs_server_release_callslot(server, &callslot);
  out:
-	_leave("");
+	_leave(" = %d", ret);
 	return ret;
 
  abort:
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 4ebb30a..d188380 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -65,6 +65,11 @@ static int afs_inode_map_status(struct a
 		return -EBADMSG;
 	}
 
+#ifdef CONFIG_AFS_FSCACHE
+	if (vnode->status.size != inode->i_size)
+		fscache_set_i_size(vnode->cache, vnode->status.size);
+#endif
+
 	inode->i_nlink		= vnode->status.nlink;
 	inode->i_uid		= vnode->status.owner;
 	inode->i_gid		= 0;
@@ -101,13 +106,33 @@ static int afs_inode_fetch_status(struct
 	struct afs_vnode *vnode;
 	int ret;
 
+	_enter("");
+
 	vnode = AFS_FS_I(inode);
 
 	ret = afs_vnode_fetch_status(vnode);
 
-	if (ret == 0)
+	if (ret == 0) {
+#ifdef CONFIG_AFS_FSCACHE
+		if (vnode->cache == FSCACHE_NEGATIVE_COOKIE) {
+			vnode->cache =
+				fscache_acquire_cookie(vnode->volume->cache,
+						       &afs_vnode_cache_index_def,
+						       vnode);
+			if (!vnode->cache)
+				printk("Negative\n");
+		}
+#endif
 		ret = afs_inode_map_status(vnode);
+#ifdef CONFIG_AFS_FSCACHE
+		if (ret < 0) {
+			fscache_relinquish_cookie(vnode->cache, 0);
+			vnode->cache = FSCACHE_NEGATIVE_COOKIE;
+		}
+#endif
+	}
 
+	_leave(" = %d", ret);
 	return ret;
 
 } /* end afs_inode_fetch_status() */
@@ -122,6 +147,7 @@ static int afs_iget5_test(struct inode *
 
 	return inode->i_ino == data->fid.vnode &&
 		inode->i_version == data->fid.unique;
+
 } /* end afs_iget5_test() */
 
 /*****************************************************************************/
@@ -179,20 +205,11 @@ inline int afs_iget(struct super_block *
 		return ret;
 	}
 
-#ifdef AFS_CACHING_SUPPORT
-	/* set up caching before reading the status, as fetch-status reads the
-	 * first page of symlinks to see if they're really mntpts */
-	cachefs_acquire_cookie(vnode->volume->cache,
-			       NULL,
-			       vnode,
-			       &vnode->cache);
-#endif
-
 	/* okay... it's a new inode */
 	inode->i_flags |= S_NOATIME;
 	vnode->flags |= AFS_VNODE_CHANGED;
 	ret = afs_inode_fetch_status(inode);
-	if (ret<0)
+	if (ret < 0)
 		goto bad_inode;
 
 	/* success */
@@ -278,8 +295,8 @@ void afs_clear_inode(struct inode *inode
 
 	afs_vnode_give_up_callback(vnode);
 
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_relinquish_cookie(vnode->cache, 0);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_relinquish_cookie(vnode->cache, 0);
 	vnode->cache = NULL;
 #endif
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 72febdf..0bddcdf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -16,15 +16,17 @@ #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/fscache.h>
 
 /*
  * debug tracing
  */
-#define kenter(FMT, a...)	printk("==> %s("FMT")\n",__FUNCTION__ , ## a)
-#define kleave(FMT, a...)	printk("<== %s()"FMT"\n",__FUNCTION__ , ## a)
-#define kdebug(FMT, a...)	printk(FMT"\n" , ## a)
-#define kproto(FMT, a...)	printk("### "FMT"\n" , ## a)
-#define knet(FMT, a...)		printk(FMT"\n" , ## a)
+#define __kdbg(FMT, a...)	printk("[%05d] "FMT"\n", current->pid , ## a)
+#define kenter(FMT, a...)	__kdbg("==> %s("FMT")", __FUNCTION__ , ## a)
+#define kleave(FMT, a...)	__kdbg("<== %s()"FMT, __FUNCTION__ , ## a)
+#define kdebug(FMT, a...)	__kdbg(FMT , ## a)
+#define kproto(FMT, a...)	__kdbg("### "FMT , ## a)
+#define knet(FMT, a...)		__kdbg(FMT , ## a)
 
 #ifdef __KDEBUG
 #define _enter(FMT, a...)	kenter(FMT , ## a)
@@ -56,9 +58,6 @@ static inline void afs_discard_my_signal
  */
 extern struct rw_semaphore afs_proc_cells_sem;
 extern struct list_head afs_proc_cells;
-#ifdef AFS_CACHING_SUPPORT
-extern struct cachefs_index_def afs_cache_cell_index_def;
-#endif
 
 /*
  * dir.c
@@ -72,11 +71,6 @@ extern const struct file_operations afs_
 extern struct address_space_operations afs_fs_aops;
 extern struct inode_operations afs_file_inode_operations;
 
-#ifdef AFS_CACHING_SUPPORT
-extern int afs_cache_get_page_cookie(struct page *page,
-				     struct cachefs_page **_page_cookie);
-#endif
-
 /*
  * inode.c
  */
@@ -97,8 +91,8 @@ #endif
 /*
  * main.c
  */
-#ifdef AFS_CACHING_SUPPORT
-extern struct cachefs_netfs afs_cache_netfs;
+#ifdef CONFIG_AFS_FSCACHE
+extern struct fscache_netfs afs_cache_netfs;
 #endif
 
 /*
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 913c689..5840bb2 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -1,6 +1,6 @@
 /* main.c: AFS client file system
  *
- * Copyright (C) 2002 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2002,5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -14,11 +14,11 @@ #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/fscache.h>
 #include <rxrpc/rxrpc.h>
 #include <rxrpc/transport.h>
 #include <rxrpc/call.h>
 #include <rxrpc/peer.h>
-#include "cache.h"
 #include "cell.h"
 #include "server.h"
 #include "fsclient.h"
@@ -51,12 +51,11 @@ static struct rxrpc_peer_ops afs_peer_op
 struct list_head afs_cb_hash_tbl[AFS_CB_HASH_COUNT];
 DEFINE_SPINLOCK(afs_cb_hash_lock);
 
-#ifdef AFS_CACHING_SUPPORT
-static struct cachefs_netfs_operations afs_cache_ops = {
-	.get_page_cookie	= afs_cache_get_page_cookie,
+#ifdef CONFIG_AFS_FSCACHE
+static struct fscache_netfs_operations afs_cache_ops = {
 };
 
-struct cachefs_netfs afs_cache_netfs = {
+struct fscache_netfs afs_cache_netfs = {
 	.name			= "afs",
 	.version		= 0,
 	.ops			= &afs_cache_ops,
@@ -83,10 +82,9 @@ static int __init afs_init(void)
 	if (ret < 0)
 		return ret;
 
-#ifdef AFS_CACHING_SUPPORT
+#ifdef CONFIG_AFS_FSCACHE
 	/* we want to be able to cache */
-	ret = cachefs_register_netfs(&afs_cache_netfs,
-				     &afs_cache_cell_index_def);
+	ret = fscache_register_netfs(&afs_cache_netfs);
 	if (ret < 0)
 		goto error;
 #endif
@@ -137,8 +135,8 @@ #ifdef CONFIG_KEYS_TURNED_OFF
 	afs_key_unregister();
  error_cache:
 #endif
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_unregister_netfs(&afs_cache_netfs);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_unregister_netfs(&afs_cache_netfs);
  error:
 #endif
 	afs_cell_purge();
@@ -167,8 +165,8 @@ static void __exit afs_exit(void)
 #ifdef CONFIG_KEYS_TURNED_OFF
 	afs_key_unregister();
 #endif
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_unregister_netfs(&afs_cache_netfs);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_unregister_netfs(&afs_cache_netfs);
 #endif
 	afs_proc_cleanup();
 
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 7b6dc03..9be8289 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -82,7 +82,7 @@ int afs_mntpt_check_symlink(struct afs_v
 
 	ret = -EIO;
 	wait_on_page_locked(page);
-	buf = kmap(page);
+	buf = kmap_atomic(page, KM_USER0);
 	if (!PageUptodate(page))
 		goto out_free;
 	if (PageError(page))
@@ -105,7 +105,7 @@ int afs_mntpt_check_symlink(struct afs_v
 	ret = 0;
 
  out_free:
-	kunmap(page);
+	kunmap_atomic(buf, KM_USER0);
 	page_cache_release(page);
  out:
 	_leave(" = %d", ret);
@@ -195,9 +195,9 @@ static struct vfsmount *afs_mntpt_do_aut
 	if (!PageUptodate(page) || PageError(page))
 		goto error;
 
-	buf = kmap(page);
+	buf = kmap_atomic(page, KM_USER0);
 	memcpy(devname, buf, size);
-	kunmap(page);
+	kunmap_atomic(buf, KM_USER0);
 	page_cache_release(page);
 	page = NULL;
 
@@ -276,12 +276,12 @@ static void *afs_mntpt_follow_link(struc
  */
 static void afs_mntpt_expiry_timed_out(struct afs_timer *timer)
 {
-	kenter("");
+//	kenter("");
 
 	mark_mounts_for_expiry(&afs_vfsmounts);
 
 	afs_kafstimod_add_timer(&afs_mntpt_expiry_timer,
 				afs_mntpt_expiry_timeout * HZ);
 
-	kleave("");
+//	kleave("");
 } /* end afs_mntpt_expiry_timed_out() */
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 101d21b..db58488 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -177,6 +177,7 @@ int afs_proc_init(void)
  */
 void afs_proc_cleanup(void)
 {
+	remove_proc_entry("rootcell", proc_afs);
 	remove_proc_entry("cells", proc_afs);
 
 	remove_proc_entry("fs/afs", NULL);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 62b093a..7103e10 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -377,7 +377,6 @@ int afs_server_request_callslot(struct a
 	else if (list_empty(&server->fs_callq)) {
 		/* no one waiting */
 		server->fs_conn_cnt[nconn]++;
-		spin_unlock(&server->fs_lock);
 	}
 	else {
 		/* someone's waiting - dequeue them and wake them up */
@@ -395,9 +394,9 @@ int afs_server_request_callslot(struct a
 		}
 		pcallslot->ready = 1;
 		wake_up_process(pcallslot->task);
-		spin_unlock(&server->fs_lock);
 	}
 
+	spin_unlock(&server->fs_lock);
 	rxrpc_put_connection(callslot->conn);
 	callslot->conn = NULL;
 
diff --git a/fs/afs/vlocation.c b/fs/afs/vlocation.c
index eced206..cfab969 100644
--- a/fs/afs/vlocation.c
+++ b/fs/afs/vlocation.c
@@ -59,17 +59,21 @@ static LIST_HEAD(afs_vlocation_update_pe
 static struct afs_vlocation *afs_vlocation_update;	/* VL currently being updated */
 static DEFINE_SPINLOCK(afs_vlocation_update_lock); /* lock guarding update queue */
 
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_vlocation_cache_match(void *target,
-						     const void *entry);
-static void afs_vlocation_cache_update(void *source, void *entry);
-
-struct cachefs_index_def afs_vlocation_cache_index_def = {
-	.name		= "vldb",
-	.data_size	= sizeof(struct afs_cache_vlocation),
-	.keys[0]	= { CACHEFS_INDEX_KEYS_ASCIIZ, 64 },
-	.match		= afs_vlocation_cache_match,
-	.update		= afs_vlocation_cache_update,
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vlocation_cache_get_key(const void *cookie_netfs_data,
+					    void *buffer, uint16_t buflen);
+static uint16_t afs_vlocation_cache_get_aux(const void *cookie_netfs_data,
+					    void *buffer, uint16_t buflen);
+static fscache_checkaux_t afs_vlocation_cache_check_aux(void *cookie_netfs_data,
+							const void *buffer,
+							uint16_t buflen);
+
+static struct fscache_cookie_def afs_vlocation_cache_index_def = {
+	.name		= "AFS.vldb",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= afs_vlocation_cache_get_key,
+	.get_aux	= afs_vlocation_cache_get_aux,
+	.check_aux	= afs_vlocation_cache_check_aux,
 };
 #endif
 
@@ -300,13 +304,12 @@ int afs_vlocation_lookup(struct afs_cell
 
 	list_add_tail(&vlocation->link, &cell->vl_list);
 
-#ifdef AFS_CACHING_SUPPORT
+#ifdef CONFIG_AFS_FSCACHE
 	/* we want to store it in the cache, plus it might already be
 	 * encached */
-	cachefs_acquire_cookie(cell->cache,
-			       &afs_volume_cache_index_def,
-			       vlocation,
-			       &vlocation->cache);
+	vlocation->cache = fscache_acquire_cookie(cell->cache,
+						  &afs_vlocation_cache_index_def,
+						  vlocation);
 
 	if (vlocation->valid)
 		goto found_in_cache;
@@ -341,7 +344,7 @@ #endif
  active:
 	active = 1;
 
-#ifdef AFS_CACHING_SUPPORT
+#ifdef CONFIG_AFS_FSCACHE
  found_in_cache:
 #endif
 	/* try to look up a cached volume in the cell VL databases by ID */
@@ -423,9 +426,9 @@ #endif
 
 	afs_kafstimod_add_timer(&vlocation->upd_timer, 10 * HZ);
 
-#ifdef AFS_CACHING_SUPPORT
+#ifdef CONFIG_AFS_FSCACHE
 	/* update volume entry in local cache */
-	cachefs_update_cookie(vlocation->cache);
+	fscache_update_cookie(vlocation->cache);
 #endif
 
 	*_vlocation = vlocation;
@@ -439,8 +442,8 @@ #endif
 		}
 		else {
 			list_del(&vlocation->link);
-#ifdef AFS_CACHING_SUPPORT
-			cachefs_relinquish_cookie(vlocation->cache, 0);
+#ifdef CONFIG_AFS_FSCACHE
+			fscache_relinquish_cookie(vlocation->cache, 0);
 #endif
 			afs_put_cell(vlocation->cell);
 			kfree(vlocation);
@@ -538,8 +541,8 @@ void afs_vlocation_do_timeout(struct afs
 	}
 
 	/* we can now destroy it properly */
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_relinquish_cookie(vlocation->cache, 0);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_relinquish_cookie(vlocation->cache, 0);
 #endif
 	afs_put_cell(cell);
 
@@ -890,65 +893,103 @@ static void afs_vlocation_update_discard
 
 /*****************************************************************************/
 /*
- * match a VLDB record stored in the cache
- * - may also load target from entry
+ * set the key for the index entry
  */
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_vlocation_cache_match(void *target,
-						     const void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vlocation_cache_get_key(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax)
 {
-	const struct afs_cache_vlocation *vldb = entry;
-	struct afs_vlocation *vlocation = target;
+	const struct afs_vlocation *vlocation = cookie_netfs_data;
+	uint16_t klen;
 
-	_enter("{%s},{%s}", vlocation->vldb.name, vldb->name);
+	_enter("{%s},%p,%u", vlocation->vldb.name, buffer, bufmax);
 
-	if (strncmp(vlocation->vldb.name, vldb->name, sizeof(vldb->name)) == 0
-	    ) {
-		if (!vlocation->valid ||
-		    vlocation->vldb.rtime == vldb->rtime
-		    ) {
-			vlocation->vldb = *vldb;
-			vlocation->valid = 1;
-			_leave(" = SUCCESS [c->m]");
-			return CACHEFS_MATCH_SUCCESS;
-		}
-		/* need to update cache if cached info differs */
-		else if (memcmp(&vlocation->vldb, vldb, sizeof(*vldb)) != 0) {
-			/* delete if VIDs for this name differ */
-			if (memcmp(&vlocation->vldb.vid,
-				   &vldb->vid,
-				   sizeof(vldb->vid)) != 0) {
-				_leave(" = DELETE");
-				return CACHEFS_MATCH_SUCCESS_DELETE;
-			}
+	klen = strnlen(vlocation->vldb.name, sizeof(vlocation->vldb.name));
+	if (klen > bufmax)
+		return 0;
 
-			_leave(" = UPDATE");
-			return CACHEFS_MATCH_SUCCESS_UPDATE;
-		}
-		else {
-			_leave(" = SUCCESS");
-			return CACHEFS_MATCH_SUCCESS;
-		}
-	}
+	memcpy(buffer, vlocation->vldb.name, klen);
+
+	_leave(" = %u", klen);
+	return klen;
 
-	_leave(" = FAILED");
-	return CACHEFS_MATCH_FAILED;
-} /* end afs_vlocation_cache_match() */
+} /* end afs_vlocation_cache_get_key() */
 #endif
 
 /*****************************************************************************/
 /*
- * update a VLDB record stored in the cache
+ * provide new auxilliary cache data
  */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_vlocation_cache_update(void *source, void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vlocation_cache_get_aux(const void *cookie_netfs_data,
+					    void *buffer, uint16_t bufmax)
 {
-	struct afs_cache_vlocation *vldb = entry;
-	struct afs_vlocation *vlocation = source;
+	const struct afs_vlocation *vlocation = cookie_netfs_data;
+	uint16_t dlen;
 
-	_enter("");
+	_enter("{%s},%p,%u", vlocation->vldb.name, buffer, bufmax);
+
+	dlen = sizeof(struct afs_cache_vlocation);
+	dlen -= offsetof(struct afs_cache_vlocation, nservers);
+	if (dlen > bufmax)
+		return 0;
+
+	memcpy(buffer, (uint8_t *)&vlocation->vldb.nservers, dlen);
+
+	_leave(" = %u", dlen);
+	return dlen;
+
+} /* end afs_vlocation_cache_get_aux() */
+#endif
+
+/*****************************************************************************/
+/*
+ * check that the auxilliary data indicates that the entry is still valid
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static fscache_checkaux_t afs_vlocation_cache_check_aux(void *cookie_netfs_data,
+							const void *buffer,
+							uint16_t buflen)
+{
+	const struct afs_cache_vlocation *cvldb;
+	struct afs_vlocation *vlocation = cookie_netfs_data;
+	uint16_t dlen;
+
+	_enter("{%s},%p,%u", vlocation->vldb.name, buffer, buflen);
+
+	/* check the size of the data is what we're expecting */
+	dlen = sizeof(struct afs_cache_vlocation);
+	dlen -= offsetof(struct afs_cache_vlocation, nservers);
+	if (dlen != buflen)
+		return FSCACHE_CHECKAUX_OBSOLETE;
+
+	cvldb = container_of(buffer, struct afs_cache_vlocation, nservers);
+
+	/* if what's on disk is more valid than what's in memory, then use the
+	 * VL record from the cache */
+	if (!vlocation->valid || vlocation->vldb.rtime == cvldb->rtime) {
+		memcpy((uint8_t *)&vlocation->vldb.nservers, buffer, dlen);
+		vlocation->valid = 1;
+		_leave(" = SUCCESS [c->m]");
+		return FSCACHE_CHECKAUX_OKAY;
+	}
+
+	/* need to update the cache if the cached info differs */
+	if (memcmp(&vlocation->vldb, buffer, dlen) != 0) {
+		/* delete if the volume IDs for this name differ */
+		if (memcmp(&vlocation->vldb.vid, &cvldb->vid,
+			   sizeof(cvldb->vid)) != 0
+		    ) {
+			_leave(" = OBSOLETE");
+			return FSCACHE_CHECKAUX_OBSOLETE;
+		}
+
+		_leave(" = UPDATE");
+		return FSCACHE_CHECKAUX_NEEDS_UPDATE;
+	}
 
-	*vldb = vlocation->vldb;
+	_leave(" = OKAY");
+	return FSCACHE_CHECKAUX_OKAY;
 
-} /* end afs_vlocation_cache_update() */
+} /* end afs_vlocation_cache_check_aux() */
 #endif
diff --git a/fs/afs/vnode.c b/fs/afs/vnode.c
index 9867fef..c380f66 100644
--- a/fs/afs/vnode.c
+++ b/fs/afs/vnode.c
@@ -29,17 +29,30 @@ struct afs_timer_ops afs_vnode_cb_timed_
 	.timed_out	= afs_vnode_cb_timed_out,
 };
 
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_vnode_cache_match(void *target,
-						 const void *entry);
-static void afs_vnode_cache_update(void *source, void *entry);
-
-struct cachefs_index_def afs_vnode_cache_index_def = {
-	.name		= "vnode",
-	.data_size	= sizeof(struct afs_cache_vnode),
-	.keys[0]	= { CACHEFS_INDEX_KEYS_BIN, 4 },
-	.match		= afs_vnode_cache_match,
-	.update		= afs_vnode_cache_update,
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vnode_cache_get_key(const void *cookie_netfs_data,
+					void *buffer, uint16_t buflen);
+static void afs_vnode_cache_get_attr(const void *cookie_netfs_data,
+				     uint64_t *size);
+static uint16_t afs_vnode_cache_get_aux(const void *cookie_netfs_data,
+					void *buffer, uint16_t buflen);
+static fscache_checkaux_t afs_vnode_cache_check_aux(void *cookie_netfs_data,
+						    const void *buffer,
+						    uint16_t buflen);
+static void afs_vnode_cache_mark_pages_cached(void *cookie_netfs_data,
+					      struct address_space *mapping,
+					      struct pagevec *cached_pvec);
+static void afs_vnode_cache_now_uncached(void *cookie_netfs_data);
+
+struct fscache_cookie_def afs_vnode_cache_index_def = {
+	.name			= "AFS.vnode",
+	.type			= FSCACHE_COOKIE_TYPE_DATAFILE,
+	.get_key		= afs_vnode_cache_get_key,
+	.get_attr		= afs_vnode_cache_get_attr,
+	.get_aux		= afs_vnode_cache_get_aux,
+	.check_aux		= afs_vnode_cache_check_aux,
+	.mark_pages_cached	= afs_vnode_cache_mark_pages_cached,
+	.now_uncached		= afs_vnode_cache_now_uncached,
 };
 #endif
 
@@ -189,6 +202,8 @@ int afs_vnode_fetch_status(struct afs_vn
 
 	if (vnode->update_cnt > 0) {
 		/* someone else started a fetch */
+		_debug("conflict");
+
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		add_wait_queue(&vnode->update_waitq, &myself);
 
@@ -220,6 +235,7 @@ int afs_vnode_fetch_status(struct afs_vn
 		spin_unlock(&vnode->lock);
 		set_current_state(TASK_RUNNING);
 
+		_leave(" [conflicted, %d", !!(vnode->flags & AFS_VNODE_DELETED));
 		return vnode->flags & AFS_VNODE_DELETED ? -ENOENT : 0;
 	}
 
@@ -342,54 +358,198 @@ int afs_vnode_give_up_callback(struct af
 
 /*****************************************************************************/
 /*
- * match a vnode record stored in the cache
+ * set the key for the index entry
  */
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_vnode_cache_match(void *target,
-						 const void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vnode_cache_get_key(const void *cookie_netfs_data,
+					void *buffer, uint16_t bufmax)
 {
-	const struct afs_cache_vnode *cvnode = entry;
-	struct afs_vnode *vnode = target;
+	const struct afs_vnode *vnode = cookie_netfs_data;
+	uint16_t klen;
 
-	_enter("{%x,%x,%Lx},{%x,%x,%Lx}",
-	       vnode->fid.vnode,
-	       vnode->fid.unique,
-	       vnode->status.version,
-	       cvnode->vnode_id,
-	       cvnode->vnode_unique,
-	       cvnode->data_version);
-
-	if (vnode->fid.vnode != cvnode->vnode_id) {
-		_leave(" = FAILED");
-		return CACHEFS_MATCH_FAILED;
+	_enter("{%x,%x,%Lx},%p,%u",
+	       vnode->fid.vnode, vnode->fid.unique, vnode->status.version,
+	       buffer, bufmax);
+
+	klen = sizeof(vnode->fid.vnode);
+	if (klen > bufmax)
+		return 0;
+
+	memcpy(buffer, &vnode->fid.vnode, sizeof(vnode->fid.vnode));
+
+	_leave(" = %u", klen);
+	return klen;
+
+} /* end afs_vnode_cache_get_key() */
+#endif
+
+/*****************************************************************************/
+/*
+ * provide an updated file attributes
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static void afs_vnode_cache_get_attr(const void *cookie_netfs_data,
+				     uint64_t *size)
+{
+	const struct afs_vnode *vnode = cookie_netfs_data;
+
+	_enter("{%x,%x,%Lx},",
+	       vnode->fid.vnode, vnode->fid.unique, vnode->status.version);
+
+	*size = i_size_read((struct inode *) &vnode->vfs_inode);
+
+} /* end afs_vnode_cache_get_attr() */
+#endif
+
+/*****************************************************************************/
+/*
+ * provide new auxilliary cache data
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_vnode_cache_get_aux(const void *cookie_netfs_data,
+					void *buffer, uint16_t bufmax)
+{
+	const struct afs_vnode *vnode = cookie_netfs_data;
+	uint16_t dlen;
+
+	_enter("{%x,%x,%Lx},%p,%u",
+	       vnode->fid.vnode, vnode->fid.unique, vnode->status.version,
+	       buffer, bufmax);
+
+	dlen = sizeof(vnode->fid.unique) + sizeof(vnode->status.version);
+	if (dlen > bufmax)
+		return 0;
+
+	memcpy(buffer, &vnode->fid.unique, sizeof(vnode->fid.unique));
+	buffer += sizeof(vnode->fid.unique);
+	memcpy(buffer, &vnode->status.version, sizeof(vnode->status.version));
+
+	_leave(" = %u", dlen);
+	return dlen;
+
+} /* end afs_vnode_cache_get_aux() */
+#endif
+
+/*****************************************************************************/
+/*
+ * check that the auxilliary data indicates that the entry is still valid
+ */
+#ifdef CONFIG_AFS_FSCACHE
+static fscache_checkaux_t afs_vnode_cache_check_aux(void *cookie_netfs_data,
+						    const void *buffer,
+						    uint16_t buflen)
+{
+	struct afs_vnode *vnode = cookie_netfs_data;
+	uint16_t dlen;
+
+	_enter("{%x,%x,%Lx},%p,%u",
+	       vnode->fid.vnode, vnode->fid.unique, vnode->status.version,
+	       buffer, buflen);
+
+	/* check the size of the data is what we're expecting */
+	dlen = sizeof(vnode->fid.unique) + sizeof(vnode->status.version);
+	if (dlen != buflen) {
+		_leave(" = OBSOLETE [len %hx != %hx]", dlen, buflen);
+		return FSCACHE_CHECKAUX_OBSOLETE;
 	}
 
-	if (vnode->fid.unique != cvnode->vnode_unique ||
-	    vnode->status.version != cvnode->data_version) {
-		_leave(" = DELETE");
-		return CACHEFS_MATCH_SUCCESS_DELETE;
+	if (memcmp(buffer,
+		   &vnode->fid.unique,
+		   sizeof(vnode->fid.unique)
+		   ) != 0
+	    ) {
+		unsigned unique;
+
+		memcpy(&unique, buffer, sizeof(unique));
+
+		_leave(" = OBSOLETE [uniq %x != %x]",
+		       unique, vnode->fid.unique);
+		return FSCACHE_CHECKAUX_OBSOLETE;
+	}
+
+	if (memcmp(buffer + sizeof(vnode->fid.unique),
+		   &vnode->status.version,
+		   sizeof(vnode->status.version)
+		   ) != 0
+	    ) {
+		afs_dataversion_t version;
+
+		memcpy(&version, buffer + sizeof(vnode->fid.unique),
+		       sizeof(version));
+
+		_leave(" = OBSOLETE [vers %llx != %llx]",
+		       version, vnode->status.version);
+		return FSCACHE_CHECKAUX_OBSOLETE;
 	}
 
 	_leave(" = SUCCESS");
-	return CACHEFS_MATCH_SUCCESS;
-} /* end afs_vnode_cache_match() */
+	return FSCACHE_CHECKAUX_OKAY;
+
+} /* end afs_vnode_cache_check_aux() */
 #endif
 
 /*****************************************************************************/
 /*
- * update a vnode record stored in the cache
+ * indication of pages that now have cache metadata retained
+ * - this function should mark the specified pages as now being cached
  */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_vnode_cache_update(void *source, void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static void afs_vnode_cache_mark_pages_cached(void *cookie_netfs_data,
+					      struct address_space *mapping,
+					      struct pagevec *cached_pvec)
 {
-	struct afs_cache_vnode *cvnode = entry;
-	struct afs_vnode *vnode = source;
+	unsigned long loop;
 
-	_enter("");
+	for (loop = 0; loop < cached_pvec->nr; loop++) {
+		struct page *page = cached_pvec->pages[loop];
 
-	cvnode->vnode_id	= vnode->fid.vnode;
-	cvnode->vnode_unique	= vnode->fid.unique;
-	cvnode->data_version	= vnode->status.version;
+		_debug("- mark %p{%lx}", page, page->index);
 
-} /* end afs_vnode_cache_update() */
+		SetPagePrivate(page);
+	}
+
+} /* end afs_vnode_cache_mark_pages_cached() */
 #endif
+
+/*****************************************************************************/
+/*
+ * indication the cookie is no longer uncached
+ * - this function is called when the backing store currently caching a cookie
+ *   is removed
+ * - the netfs should use this to clean up any markers indicating cached pages
+ * - this is mandatory for any object that may have data
+ */
+static void afs_vnode_cache_now_uncached(void *cookie_netfs_data)
+{
+	struct afs_vnode *vnode = cookie_netfs_data;
+	struct pagevec pvec;
+	pgoff_t first;
+	int loop, nr_pages;
+
+	_enter("{%x,%x,%Lx}",
+	       vnode->fid.vnode, vnode->fid.unique, vnode->status.version);
+
+	pagevec_init(&pvec, 0);
+	first = 0;
+
+	for (;;) {
+		/* grab a bunch of pages to clean */
+		nr_pages = pagevec_lookup(&pvec, vnode->vfs_inode.i_mapping,
+					  first,
+					  PAGEVEC_SIZE - pagevec_count(&pvec));
+		if (!nr_pages)
+			break;
+
+		for (loop = 0; loop < nr_pages; loop++)
+			ClearPagePrivate(pvec.pages[loop]);
+
+		first = pvec.pages[nr_pages - 1]->index + 1;
+
+		pvec.nr = nr_pages;
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+
+	_leave("");
+
+} /* end afs_vnode_cache_now_uncached() */
diff --git a/fs/afs/vnode.h b/fs/afs/vnode.h
index b86a971..3f0602d 100644
--- a/fs/afs/vnode.h
+++ b/fs/afs/vnode.h
@@ -13,9 +13,9 @@ #ifndef _LINUX_AFS_VNODE_H
 #define _LINUX_AFS_VNODE_H
 
 #include <linux/fs.h>
+#include <linux/fscache.h>
 #include "server.h"
 #include "kafstimod.h"
-#include "cache.h"
 
 #ifdef __KERNEL__
 
@@ -32,8 +32,8 @@ struct afs_cache_vnode
 	afs_dataversion_t	data_version;	/* data version */
 };
 
-#ifdef AFS_CACHING_SUPPORT
-extern struct cachefs_index_def afs_vnode_cache_index_def;
+#ifdef CONFIG_AFS_FSCACHE
+extern struct fscache_cookie_def afs_vnode_cache_index_def;
 #endif
 
 /*****************************************************************************/
@@ -47,8 +47,8 @@ struct afs_vnode
 	struct afs_volume	*volume;	/* volume on which vnode resides */
 	struct afs_fid		fid;		/* the file identifier for this inode */
 	struct afs_file_status	status;		/* AFS status info for this file */
-#ifdef AFS_CACHING_SUPPORT
-	struct cachefs_cookie	*cache;		/* caching cookie */
+#ifdef CONFIG_AFS_FSCACHE
+	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
 
 	wait_queue_head_t	update_waitq;	/* status fetch waitqueue */
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 0ff4b86..0bd5578 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -15,10 +15,10 @@ #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/fscache.h>
 #include "volume.h"
 #include "vnode.h"
 #include "cell.h"
-#include "cache.h"
 #include "cmservice.h"
 #include "fsclient.h"
 #include "vlclient.h"
@@ -28,18 +28,14 @@ #ifdef __KDEBUG
 static const char *afs_voltypes[] = { "R/W", "R/O", "BAK" };
 #endif
 
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_volume_cache_match(void *target,
-						  const void *entry);
-static void afs_volume_cache_update(void *source, void *entry);
-
-struct cachefs_index_def afs_volume_cache_index_def = {
-	.name		= "volume",
-	.data_size	= sizeof(struct afs_cache_vhash),
-	.keys[0]	= { CACHEFS_INDEX_KEYS_BIN, 1 },
-	.keys[1]	= { CACHEFS_INDEX_KEYS_BIN, 1 },
-	.match		= afs_volume_cache_match,
-	.update		= afs_volume_cache_update,
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_volume_cache_get_key(const void *cookie_netfs_data,
+					 void *buffer, uint16_t buflen);
+
+static struct fscache_cookie_def afs_volume_cache_index_def = {
+	.name		= "AFS.volume",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= afs_volume_cache_get_key,
 };
 #endif
 
@@ -214,11 +210,10 @@ int afs_volume_lookup(const char *name, 
 	}
 
 	/* attach the cache and volume location */
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_acquire_cookie(vlocation->cache,
-			       &afs_vnode_cache_index_def,
-			       volume,
-			       &volume->cache);
+#ifdef CONFIG_AFS_FSCACHE
+	volume->cache = fscache_acquire_cookie(vlocation->cache,
+					       &afs_volume_cache_index_def,
+					       volume);
 #endif
 
 	afs_get_vlocation(vlocation);
@@ -286,8 +281,8 @@ void afs_put_volume(struct afs_volume *v
 	up_write(&vlocation->cell->vl_sem);
 
 	/* finish cleaning up the volume */
-#ifdef AFS_CACHING_SUPPORT
-	cachefs_relinquish_cookie(volume->cache, 0);
+#ifdef CONFIG_AFS_FSCACHE
+	fscache_relinquish_cookie(volume->cache, 0);
 #endif
 	afs_put_vlocation(vlocation);
 
@@ -481,40 +476,25 @@ int afs_volume_release_fileserver(struct
 
 /*****************************************************************************/
 /*
- * match a volume hash record stored in the cache
+ * set the key for the index entry
  */
-#ifdef AFS_CACHING_SUPPORT
-static cachefs_match_val_t afs_volume_cache_match(void *target,
-						  const void *entry)
+#ifdef CONFIG_AFS_FSCACHE
+static uint16_t afs_volume_cache_get_key(const void *cookie_netfs_data,
+					void *buffer, uint16_t bufmax)
 {
-	const struct afs_cache_vhash *vhash = entry;
-	struct afs_volume *volume = target;
-
-	_enter("{%u},{%u}", volume->type, vhash->vtype);
+	const struct afs_volume *volume = cookie_netfs_data;
+	uint16_t klen;
 
-	if (volume->type == vhash->vtype) {
-		_leave(" = SUCCESS");
-		return CACHEFS_MATCH_SUCCESS;
-	}
-
-	_leave(" = FAILED");
-	return CACHEFS_MATCH_FAILED;
-} /* end afs_volume_cache_match() */
-#endif
+	_enter("{%u},%p,%u", volume->type, buffer, bufmax);
 
-/*****************************************************************************/
-/*
- * update a volume hash record stored in the cache
- */
-#ifdef AFS_CACHING_SUPPORT
-static void afs_volume_cache_update(void *source, void *entry)
-{
-	struct afs_cache_vhash *vhash = entry;
-	struct afs_volume *volume = source;
+	klen = sizeof(volume->type);
+	if (klen > bufmax)
+		return 0;
 
-	_enter("");
+	memcpy(buffer, &volume->type, sizeof(volume->type));
 
-	vhash->vtype = volume->type;
+	_leave(" = %u", klen);
+	return klen;
 
-} /* end afs_volume_cache_update() */
+} /* end afs_volume_cache_get_key() */
 #endif
diff --git a/fs/afs/volume.h b/fs/afs/volume.h
index bfdcf19..fc9895a 100644
--- a/fs/afs/volume.h
+++ b/fs/afs/volume.h
@@ -12,11 +12,11 @@
 #ifndef _LINUX_AFS_VOLUME_H
 #define _LINUX_AFS_VOLUME_H
 
+#include <linux/fscache.h>
 #include "types.h"
 #include "fsclient.h"
 #include "kafstimod.h"
 #include "kafsasyncd.h"
-#include "cache.h"
 
 typedef enum {
 	AFS_VLUPD_SLEEP,		/* sleeping waiting for update timer to fire */
@@ -45,24 +45,6 @@ #define AFS_VOL_VTM_BAK	0x04 /* backup v
 	time_t			rtime;		/* last retrieval time */
 };
 
-#ifdef AFS_CACHING_SUPPORT
-extern struct cachefs_index_def afs_vlocation_cache_index_def;
-#endif
-
-/*****************************************************************************/
-/*
- * volume -> vnode hash table entry
- */
-struct afs_cache_vhash
-{
-	afs_voltype_t		vtype;		/* which volume variation */
-	uint8_t			hash_bucket;	/* which hash bucket this represents */
-} __attribute__((packed));
-
-#ifdef AFS_CACHING_SUPPORT
-extern struct cachefs_index_def afs_volume_cache_index_def;
-#endif
-
 /*****************************************************************************/
 /*
  * AFS volume location record
@@ -73,8 +55,8 @@ struct afs_vlocation
 	struct list_head	link;		/* link in cell volume location list */
 	struct afs_timer	timeout;	/* decaching timer */
 	struct afs_cell		*cell;		/* cell to which volume belongs */
-#ifdef AFS_CACHING_SUPPORT
-	struct cachefs_cookie	*cache;		/* caching cookie */
+#ifdef CONFIG_AFS_FSCACHE
+	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
 	struct afs_cache_vlocation vldb;	/* volume information DB record */
 	struct afs_volume	*vols[3];	/* volume access record pointer (index by type) */
@@ -109,8 +91,8 @@ struct afs_volume
 	atomic_t		usage;
 	struct afs_cell		*cell;		/* cell to which belongs (unrefd ptr) */
 	struct afs_vlocation	*vlocation;	/* volume location */
-#ifdef AFS_CACHING_SUPPORT
-	struct cachefs_cookie	*cache;		/* caching cookie */
+#ifdef CONFIG_AFS_FSCACHE
+	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
 	afs_volid_t		vid;		/* volume ID */
 	afs_voltype_t		type;		/* type of volume */

