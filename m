Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWG0UzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWG0UzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWG0UyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:54:12 -0400
Received: from mx2.redhat.com ([66.187.237.31]:7906 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1751017AbWG0Uxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:35 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 26/30] NFS: Use local caching [try #11]
Date: Thu, 27 Jul 2006 21:53:25 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205325.8443.50582.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes it possible for the NFS filesystem to make use of the
network filesystem local caching service (FS-Cache).

To be able to use this, an updated mount program is required.  This can be
obtained from:

	http://people.redhat.com/steved/cachefs/util-linux/

To mount an NFS filesystem to use caching, add an "fsc" option to the mount:

	mount warthog:/ /a -o fsc

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig                 |    7 +
 fs/nfs/Makefile            |    1 
 fs/nfs/client.c            |   11 +
 fs/nfs/file.c              |   33 +++
 fs/nfs/fscache.c           |  346 +++++++++++++++++++++++++++++++++
 fs/nfs/fscache.h           |  466 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/inode.c             |   22 ++
 fs/nfs/internal.h          |   32 +++
 fs/nfs/pagelist.c          |    3 
 fs/nfs/read.c              |   30 +++
 fs/nfs/super.c             |    1 
 fs/nfs/sysctl.c            |   43 ++++
 fs/nfs/write.c             |   11 +
 include/linux/nfs4_mount.h |    1 
 include/linux/nfs_fs.h     |    5 
 include/linux/nfs_fs_sb.h  |    5 
 include/linux/nfs_mount.h  |    1 
 17 files changed, 1010 insertions(+), 8 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index eecc0ed..36d0051 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1485,6 +1485,13 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_FSCACHE
+	bool "Provide NFS client caching support (EXPERIMENTAL)"
+	depends on NFS_FS && FSCACHE && EXPERIMENTAL
+	help
+	  Say Y here if you want NFS data to be cached locally on disc through
+	  the general filesystem cache manager
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files (EXPERIMENTAL)"
 	depends on NFS_FS && EXPERIMENTAL
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index f4580b4..2af6f22 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -16,4 +16,5 @@ nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4x
 			   nfs4namespace.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
 nfs-$(CONFIG_SYSCTL) += sysctl.o
+nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
 nfs-objs		:= $(nfs-y)
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 700bd58..a025e06 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -150,6 +150,8 @@ #ifdef CONFIG_NFS_V4
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 #endif
 
+	nfs_fscache_get_client_cookie(clp);
+
 	return clp;
 
 error_3:
@@ -187,6 +189,8 @@ #ifdef CONFIG_NFS_V4
 	}
 #endif
 
+	nfs_fscache_release_client_cookie(clp);
+
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
@@ -1363,7 +1367,7 @@ static int nfs_volume_list_show(struct s
 
 	/* display header on line 1 */
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "NV SERVER   PORT DEV     FSID\n");
+		seq_puts(m, "NV SERVER   PORT DEV     FSID              FSC\n");
 		return 0;
 	}
 	/* display one transport per line on subsequent lines */
@@ -1376,12 +1380,13 @@ static int nfs_volume_list_show(struct s
 	snprintf(fsid, 17, "%llx:%llx",
 		 server->fsid.major, server->fsid.minor);
 
-	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s\n",
+	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s %s\n",
 		   clp->cl_nfsversion,
 		   NIPQUAD(clp->cl_addr.sin_addr),
 		   ntohs(clp->cl_addr.sin_port),
 		   dev,
-		   fsid);
+		   fsid,
+		   nfs_server_fscache_state(server));
 
 	return 0;
 }
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 52f161d..855bb97 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -27,12 +27,14 @@ #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
 #include "delegation.h"
 #include "iostat.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_FILE
 
@@ -249,6 +251,10 @@ nfs_file_mmap(struct file * file, struct
 	status = nfs_revalidate_mapping(inode, file->f_mapping);
 	if (!status)
 		status = generic_file_mmap(file, vma);
+
+	if (status == 0)
+		nfs_fscache_install_vm_ops(inode, vma);
+
 	return status;
 }
 
@@ -308,13 +314,35 @@ static void nfs_invalidate_page(struct p
 	/* Cancel any unstarted writes on this page */
 	if (offset == 0)
 		nfs_sync_inode_wait(inode, page->index, 1, FLUSH_INVALIDATE);
+
+	nfs_fscache_invalidate_page(page, inode, offset);
+
+	/* we can do this here as the bits are only set with the page lock
+	 * held, and our caller is holding that */
+	if (!page->private)
+		ClearPagePrivate(page);
 }
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
-	return !nfs_wb_page(page->mapping->host, page);
+	int error = nfs_wb_page(page->mapping->host, page);
+
+	if (error == 0) {
+		nfs_fscache_release_page(page);
+
+		/* may have been set due to either caching or writing */
+		ClearPagePrivate(page);
+	}
+
+	/* releasepage() returns true/false */
+	return (error == 0) ? 1 : 0;
 }
 
+/*
+ * Since we use page->private for our own nefarious purposes when using
+ * fscache, we have to override extra address space ops to prevent fs/buffer.c
+ * from getting confused, even though we may not have asked its opinion
+ */
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -328,6 +356,9 @@ const struct address_space_operations nf
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+#ifdef CONFIG_NFS_FSCACHE
+	.sync_page	= block_sync_page,
+#endif
 };
 
 /* 
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
new file mode 100644
index 0000000..50d223a
--- /dev/null
+++ b/fs/nfs/fscache.c
@@ -0,0 +1,346 @@
+/* fscache.c: NFS filesystem cache interface
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
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_fs_sb.h>
+#include <linux/in6.h>
+
+#include "internal.h"
+
+/*
+ * Sysctl variables
+ */
+atomic_t nfs_fscache_to_pages;
+atomic_t nfs_fscache_from_pages;
+atomic_t nfs_fscache_uncache_page;
+int nfs_fscache_from_error;
+int nfs_fscache_to_error;
+
+#define NFSDBG_FACILITY		NFSDBG_FSCACHE
+
+/* the auxiliary data in the cache (used for coherency management) */
+struct nfs_fh_auxdata {
+	struct timespec	i_mtime;
+	struct timespec	i_ctime;
+	loff_t		i_size;
+};
+
+static struct fscache_netfs_operations nfs_cache_ops = {
+};
+
+struct fscache_netfs nfs_cache_netfs = {
+	.name			= "nfs",
+	.version		= 0,
+	.ops			= &nfs_cache_ops,
+};
+
+static const uint8_t nfs_cache_ipv6_wrapper_for_ipv4[12] = {
+	[0 ... 9]	= 0x00,
+	[10 ... 11]	= 0xff
+};
+
+struct nfs_server_key {
+	uint16_t nfsversion;
+	uint16_t port;
+	union {
+		struct {
+			uint8_t		ipv6wrapper[12];
+			struct in_addr	addr;
+		} ipv4_addr;
+		struct in6_addr ipv6_addr;
+	};
+};
+
+static uint16_t nfs_server_get_key(const void *cookie_netfs_data,
+				   void *buffer, uint16_t bufmax)
+{
+	const struct nfs_client *clp = cookie_netfs_data;
+	struct nfs_server_key *key = buffer;
+	uint16_t len = 0;
+
+	key->nfsversion = clp->cl_nfsversion;
+
+	switch (clp->cl_addr.sin_family) {
+	case AF_INET:
+		key->port = clp->cl_addr.sin_port;
+
+		memcpy(&key->ipv4_addr.ipv6wrapper,
+		       &nfs_cache_ipv6_wrapper_for_ipv4,
+		       sizeof(key->ipv4_addr.ipv6wrapper));
+		memcpy(&key->ipv4_addr.addr,
+		       &clp->cl_addr.sin_addr,
+		       sizeof(key->ipv4_addr.addr));
+		len = sizeof(struct nfs_server_key);
+		break;
+
+	case AF_INET6:
+		key->port = clp->cl_addr.sin_port;
+
+		memcpy(&key->ipv6_addr,
+		       &clp->cl_addr.sin_addr,
+		       sizeof(key->ipv6_addr));
+		len = sizeof(struct nfs_server_key);
+		break;
+
+	default:
+		len = 0;
+		printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
+			clp->cl_addr.sin_family);
+		break;
+	}
+
+	return len;
+}
+
+/*
+ * the root index for the filesystem is defined by nfsd IP address and ports
+ */
+struct fscache_cookie_def nfs_cache_server_index_def = {
+	.name		= "NFS.servers",
+	.type 		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= nfs_server_get_key,
+};
+
+static uint16_t nfs_fh_get_key(const void *cookie_netfs_data,
+		void *buffer, uint16_t bufmax)
+{
+	const struct nfs_inode *nfsi = cookie_netfs_data;
+	uint16_t nsize;
+
+	/* set the file handle */
+	nsize = nfsi->fh.size;
+	memcpy(buffer, nfsi->fh.data, nsize);
+	return nsize;
+}
+
+/*
+ * indication of pages that now have cache metadata retained
+ * - this function should mark the specified pages as now being cached
+ */
+static void nfs_fh_mark_pages_cached(void *cookie_netfs_data,
+				     struct address_space *mapping,
+				     struct pagevec *cached_pvec)
+{
+	struct nfs_inode *nfsi = cookie_netfs_data;
+	unsigned long loop;
+
+	dprintk("NFS: nfs_fh_mark_pages_cached: nfs_inode 0x%p pages %ld\n",
+		nfsi, cached_pvec->nr);
+
+	for (loop = 0; loop < cached_pvec->nr; loop++)
+		SetPageNfsCached(cached_pvec->pages[loop]);
+}
+
+/*
+ * get an extra reference on a read context
+ * - this function can be absent if the completion function doesn't
+ *   require a context
+ */
+static void nfs_fh_get_context(void *cookie_netfs_data, void *context)
+{
+	get_nfs_open_context(context);
+}
+
+/*
+ * release an extra reference on a read context
+ * - this function can be absent if the completion function doesn't
+ *   require a context
+ */
+static void nfs_fh_put_context(void *cookie_netfs_data, void *context)
+{
+	if (context)
+		put_nfs_open_context(context);
+}
+
+/*
+ * indication the cookie is no longer uncached
+ * - this function is called when the backing store currently caching a cookie
+ *   is removed
+ * - the netfs should use this to clean up any markers indicating cached pages
+ * - this is mandatory for any object that may have data
+ */
+static void nfs_fh_now_uncached(void *cookie_netfs_data)
+{
+	struct nfs_inode *nfsi = cookie_netfs_data;
+	struct pagevec pvec;
+	pgoff_t first;
+	int loop, nr_pages;
+
+	pagevec_init(&pvec, 0);
+	first = 0;
+
+	dprintk("NFS: nfs_fh_now_uncached: nfs_inode 0x%p\n", nfsi);
+
+	for (;;) {
+		/* grab a bunch of pages to clean */
+		nr_pages = pagevec_lookup(&pvec,
+					  nfsi->vfs_inode.i_mapping,
+					  first,
+					  PAGEVEC_SIZE - pagevec_count(&pvec));
+		if (!nr_pages)
+			break;
+
+		for (loop = 0; loop < nr_pages; loop++)
+			ClearPageNfsCached(pvec.pages[loop]);
+
+		first = pvec.pages[nr_pages - 1]->index + 1;
+
+		pvec.nr = nr_pages;
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+}
+
+/*
+ * get certain file attributes from the netfs data
+ * - this function can be absent for an index
+ * - not permitted to return an error
+ * - the netfs data from the cookie being used as the source is
+ *   presented
+ */
+static void nfs_fh_get_attr(const void *cookie_netfs_data, uint64_t *size)
+{
+	const struct nfs_inode *nfsi = cookie_netfs_data;
+
+	*size = nfsi->vfs_inode.i_size;
+}
+
+/*
+ * get the auxilliary data from netfs data
+ * - this function can be absent if the index carries no state data
+ * - should store the auxilliary data in the buffer
+ * - should return the amount of amount stored
+ * - not permitted to return an error
+ * - the netfs data from the cookie being used as the source is
+ *   presented
+ */
+static uint16_t nfs_fh_get_aux(const void *cookie_netfs_data,
+			       void *buffer, uint16_t bufmax)
+{
+	struct nfs_fh_auxdata auxdata;
+	const struct nfs_inode *nfsi = cookie_netfs_data;
+
+	auxdata.i_size = nfsi->vfs_inode.i_size;
+	auxdata.i_mtime = nfsi->vfs_inode.i_mtime;
+	auxdata.i_ctime = nfsi->vfs_inode.i_ctime;
+
+	if (bufmax > sizeof(auxdata))
+		bufmax = sizeof(auxdata);
+
+	memcpy(buffer, &auxdata, bufmax);
+	return bufmax;
+}
+
+/*
+ * consult the netfs about the state of an object
+ * - this function can be absent if the index carries no state data
+ * - the netfs data from the cookie being used as the target is
+ *   presented, as is the auxilliary data
+ */
+static fscache_checkaux_t nfs_fh_check_aux(void *cookie_netfs_data,
+					   const void *data, uint16_t datalen)
+{
+	struct nfs_fh_auxdata auxdata;
+	struct nfs_inode *nfsi = cookie_netfs_data;
+
+	if (datalen > sizeof(auxdata))
+		return FSCACHE_CHECKAUX_OBSOLETE;
+
+	auxdata.i_size = nfsi->vfs_inode.i_size;
+	auxdata.i_mtime = nfsi->vfs_inode.i_mtime;
+	auxdata.i_ctime = nfsi->vfs_inode.i_ctime;
+
+	if (memcmp(data, &auxdata, datalen) != 0)
+		return FSCACHE_CHECKAUX_OBSOLETE;
+
+	return FSCACHE_CHECKAUX_OKAY;
+}
+
+/*
+ * the primary index for each server is simply made up of a series of NFS file
+ * handles
+ */
+struct fscache_cookie_def nfs_cache_fh_index_def = {
+	.name			= "NFS.fh",
+	.type			= FSCACHE_COOKIE_TYPE_DATAFILE,
+	.get_key		= nfs_fh_get_key,
+	.get_attr		= nfs_fh_get_attr,
+	.get_aux		= nfs_fh_get_aux,
+	.check_aux		= nfs_fh_check_aux,
+	.get_context		= nfs_fh_get_context,
+	.put_context		= nfs_fh_put_context,
+	.mark_pages_cached	= nfs_fh_mark_pages_cached,
+	.now_uncached		= nfs_fh_now_uncached,
+};
+
+static int nfs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+}
+
+struct vm_operations_struct nfs_fs_vm_operations = {
+	.nopage		= filemap_nopage,
+	.populate	= filemap_populate,
+	.page_mkwrite	= nfs_file_page_mkwrite,
+};
+
+/*
+ * handle completion of a page being stored in the cache
+ */
+void nfs_readpage_to_fscache_complete(struct page *page, void *data, int error)
+{
+	dfprintk(FSCACHE,
+		"NFS:     readpage_to_fscache_complete (p:%p(i:%lx f:%lx)/%d)\n",
+		page, page->index, page->flags, error);
+
+	end_page_fs_misc(page);
+}
+
+/*
+ * handle completion of a page being read from the cache
+ * - called in process (keventd) context
+ */
+void nfs_readpage_from_fscache_complete(struct page *page,
+					void *context,
+					int error)
+{
+	dfprintk(FSCACHE,
+		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
+		 page, context, error);
+
+	/* if the read completes with an error, we just unlock the page and let
+	 * the VM reissue the readpage */
+	if (!error) {
+		SetPageUptodate(page);
+		unlock_page(page);
+	} else {
+		error = nfs_readpage_async(context, page->mapping->host, page);
+		if (error)
+			unlock_page(page);
+	}
+}
+
+/*
+ * handle completion of a page being read from the cache
+ * - really need to synchronise the end of writeback, probably using a page
+ *   flag, but for the moment we disable caching on writable files
+ */
+void nfs_writepage_to_fscache_complete(struct page *page,
+				       void *data,
+				       int error)
+{
+}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
new file mode 100644
index 0000000..69f0f40
--- /dev/null
+++ b/fs/nfs/fscache.h
@@ -0,0 +1,466 @@
+/* fscache.h: NFS filesystem cache interface definitions
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
+#ifndef _NFS_FSCACHE_H
+#define _NFS_FSCACHE_H
+
+#include <linux/nfs_fs.h>
+#include <linux/nfs_mount.h>
+#include <linux/nfs4_mount.h>
+
+#ifdef CONFIG_NFS_FSCACHE
+#include <linux/fscache.h>
+
+extern struct fscache_netfs nfs_cache_netfs;
+extern struct fscache_cookie_def nfs_cache_server_index_def;
+extern struct fscache_cookie_def nfs_cache_fh_index_def;
+extern struct vm_operations_struct nfs_fs_vm_operations;
+
+extern void nfs_invalidatepage(struct page *, unsigned long);
+extern int nfs_releasepage(struct page *, gfp_t);
+
+extern atomic_t nfs_fscache_to_pages;
+extern atomic_t nfs_fscache_from_pages;
+extern atomic_t nfs_fscache_uncache_page;
+extern int nfs_fscache_from_error;
+extern int nfs_fscache_to_error;
+
+/*
+ * register NFS for caching
+ */
+static inline int nfs_fscache_register(void)
+{
+	return fscache_register_netfs(&nfs_cache_netfs);
+}
+
+/*
+ * unregister NFS for caching
+ */
+static inline void nfs_fscache_unregister(void)
+{
+	fscache_unregister_netfs(&nfs_cache_netfs);
+}
+
+/*
+ * get the per-client index cookie for an NFS client if the appropriate mount
+ * flag was set
+ * - we always try and get an index cookie for the client, but get filehandle
+ *   cookies on a per-superblock basis, depending on the mount flags
+ */
+static inline void nfs_fscache_get_client_cookie(struct nfs_client *clp)
+{
+	/* create a cache index for looking up filehandles */
+	clp->fscache = fscache_acquire_cookie(nfs_cache_netfs.primary_index,
+					      &nfs_cache_server_index_def,
+					      clp);
+	dfprintk(FSCACHE,"NFS: get client cookie (0x%p/0x%p)\n",
+		 clp, clp->fscache);
+}
+
+/*
+ * dispose of a per-client cookie
+ */
+static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp)
+{
+	dfprintk(FSCACHE,"NFS: releasing client cookie (0x%p/0x%p)\n",
+		clp, clp->fscache);
+
+	fscache_relinquish_cookie(clp->fscache, 0);
+	clp->fscache = NULL;
+}
+
+/*
+ * indicate the client caching state as readable text
+ */
+static inline const char *nfs_server_fscache_state(struct nfs_server *server)
+{
+	if (server->nfs_client->fscache && (server->flags & NFS_MOUNT_FSCACHE))
+		return "yes";
+	return "no ";
+}
+
+/*
+ * get the per-filehandle cookie for an NFS inode
+ */
+static inline void nfs_fscache_get_fh_cookie(struct super_block *sb,
+					     struct nfs_inode *nfsi,
+					     int maycache)
+{
+	nfsi->fscache = NULL;
+	if (maycache && (NFS_SB(sb)->flags & NFS_MOUNT_FSCACHE)) {
+		nfsi->fscache = fscache_acquire_cookie(
+			NFS_SB(sb)->nfs_client->fscache,
+			&nfs_cache_fh_index_def,
+			nfsi);
+
+		fscache_set_i_size(nfsi->fscache, nfsi->vfs_inode.i_size);
+
+		dfprintk(FSCACHE, "NFS: get FH cookie (0x%p/0x%p/0x%p)\n",
+			 sb, nfsi, nfsi->fscache);
+	}
+}
+
+/*
+ * change the filesize associated with a per-filehandle cookie
+ */
+static inline void nfs_fscache_set_size(struct nfs_server *server,
+					struct nfs_inode *nfsi,
+					loff_t i_size)
+{
+	fscache_set_i_size(nfsi->fscache, i_size);
+}
+
+/*
+ * replace a per-filehandle cookie due to revalidation detecting a file having
+ * changed on the server
+ */
+static inline void nfs_fscache_renew_fh_cookie(struct nfs_server *server,
+					       struct nfs_inode *nfsi)
+{
+	struct fscache_cookie *old = nfsi->fscache;
+
+	if (nfsi->fscache) {
+		/* retire the current fscache cache and get a new one */
+		fscache_relinquish_cookie(nfsi->fscache, 1);
+
+		nfsi->fscache = fscache_acquire_cookie(
+			server->nfs_client->fscache,
+			&nfs_cache_fh_index_def,
+			nfsi);
+		fscache_set_i_size(nfsi->fscache, nfsi->vfs_inode.i_size);
+
+		dfprintk(FSCACHE,
+			 "NFS: revalidation new cookie (0x%p/0x%p/0x%p/0x%p)\n",
+			 server, nfsi, old, nfsi->fscache);
+	}
+}
+
+/*
+ * release a per-filehandle cookie
+ */
+static inline void nfs_fscache_release_fh_cookie(struct nfs_server *server,
+						 struct nfs_inode *nfsi)
+{
+	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n",
+		 nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 0);
+	nfsi->fscache = NULL;
+}
+
+/*
+ * retire a per-filehandle cookie, destroying the data attached to it
+ */
+static inline void nfs_fscache_zap_fh_cookie(struct nfs_server *server,
+					     struct nfs_inode *nfsi)
+{
+	dfprintk(FSCACHE,"NFS: zapping cookie (0x%p/0x%p)\n",
+		nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 1);
+	nfsi->fscache = NULL;
+}
+
+/*
+ * turn off the cache with regard to a filehandle cookie if opened for writing,
+ * invalidating all the pages in the page cache relating to the associated
+ * inode to clear the per-page caching
+ */
+static inline void nfs_fscache_disable_fh_cookie(struct inode *inode)
+{
+	if (NFS_I(inode)->fscache) {
+		dfprintk(FSCACHE,
+			 "NFS: nfsi 0x%p turning cache off\n", NFS_I(inode));
+
+		/* Need to invalided any mapped pages that were read in before
+		 * turning off the cache.
+		 */
+		if (inode->i_mapping && inode->i_mapping->nrpages)
+			invalidate_inode_pages2(inode->i_mapping);
+
+		nfs_fscache_zap_fh_cookie(NFS_SERVER(inode), NFS_I(inode));
+	}
+}
+
+/*
+ * install the VM ops for mmap() of an NFS file so that we can hold up writes
+ * to pages on shared writable mappings until the store to the cache is
+ * complete
+ */
+static inline void nfs_fscache_install_vm_ops(struct inode *inode,
+					      struct vm_area_struct *vma)
+{
+	if (NFS_I(inode)->fscache)
+		vma->vm_ops = &nfs_fs_vm_operations;
+}
+
+/*
+ * release the caching state associated with a page
+ */
+static void nfs_fscache_release_page(struct page *page)
+{
+	if (PageNfsCached(page)) {
+		struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+		BUG_ON(nfsi->fscache == NULL);
+
+		dfprintk(FSCACHE, "NFS: fscache releasepage (0x%p/0x%p/0x%p)\n",
+			 nfsi->fscache, page, nfsi);
+
+		wait_on_page_fs_misc(page);
+		fscache_uncache_page(nfsi->fscache, page);
+		atomic_inc(&nfs_fscache_uncache_page);
+		ClearPageNfsCached(page);
+	}
+}
+
+/*
+ * release the caching state associated with a page if undergoing complete page
+ * invalidation
+ */
+static inline void nfs_fscache_invalidate_page(struct page *page,
+					       struct inode *inode,
+					       unsigned long offset)
+{
+	if (PageNfsCached(page)) {
+		struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+		BUG_ON(!nfsi->fscache);
+
+		dfprintk(FSCACHE,
+			 "NFS: fscache invalidatepage (0x%p/0x%p/0x%p)\n",
+			 nfsi->fscache, page, nfsi);
+
+		if (offset == 0) {
+			BUG_ON(!PageLocked(page));
+			if (!PageWriteback(page))
+				nfs_fscache_release_page(page);
+		}
+	}
+}
+
+/*
+ * store a newly fetched page in fscache
+ */
+extern void nfs_readpage_to_fscache_complete(struct page *, void *, int);
+
+static inline void nfs_readpage_to_fscache(struct inode *inode,
+					   struct page *page,
+					   int sync)
+{
+	int ret;
+
+	if (PageNfsCached(page)) {
+		dfprintk(FSCACHE,
+			 "NFS: "
+			 "readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
+			 NFS_I(inode)->fscache, page, page->index, page->flags,
+			 sync);
+
+		if (TestSetPageFsMisc(page))
+			BUG();
+
+		ret = fscache_write_page(NFS_I(inode)->fscache, page,
+					 nfs_readpage_to_fscache_complete,
+					 NULL, GFP_KERNEL);
+		dfprintk(FSCACHE,
+			 "NFS:     "
+			 "readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
+			 page, page->index, page->flags, ret);
+
+		if (ret != 0) {
+			fscache_uncache_page(NFS_I(inode)->fscache, page);
+			atomic_inc(&nfs_fscache_uncache_page);
+			ClearPageNfsCached(page);
+			end_page_fs_misc(page);
+			nfs_fscache_to_error = ret;
+		} else {
+			atomic_inc(&nfs_fscache_to_pages);
+		}
+	}
+}
+
+/*
+ * retrieve a page from fscache
+ */
+extern void nfs_readpage_from_fscache_complete(struct page *, void *, int);
+
+static inline
+int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
+			      struct inode *inode,
+			      struct page *page)
+{
+	int ret;
+
+	if (!NFS_I(inode)->fscache)
+		return 1;
+
+	dfprintk(FSCACHE,
+		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
+		 NFS_I(inode)->fscache, page, page->index, page->flags, inode);
+
+	ret = fscache_read_or_alloc_page(NFS_I(inode)->fscache,
+					 page,
+					 nfs_readpage_from_fscache_complete,
+					 ctx,
+					 GFP_KERNEL);
+
+	switch (ret) {
+	case 0: /* read BIO submitted (page in fscache) */
+		dfprintk(FSCACHE,
+			 "NFS:    readpage_from_fscache: BIO submitted\n");
+		atomic_inc(&nfs_fscache_from_pages);
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE,
+			 "NFS:    readpage_from_fscache error %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
+		nfs_fscache_from_error = ret;
+	}
+	return ret;
+}
+
+/*
+ * retrieve a set of pages from fscache
+ */
+static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
+					     struct inode *inode,
+					     struct address_space *mapping,
+					     struct list_head *pages,
+					     unsigned *nr_pages)
+{
+	int ret, npages = *nr_pages;
+
+	if (!NFS_I(inode)->fscache)
+		return 1;
+
+	dfprintk(FSCACHE,
+		 "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
+		 NFS_I(inode)->fscache, *nr_pages, inode);
+
+	ret = fscache_read_or_alloc_pages(NFS_I(inode)->fscache,
+					  mapping, pages, nr_pages,
+					  nfs_readpage_from_fscache_complete,
+					  ctx,
+					  mapping_gfp_mask(mapping));
+
+
+	switch (ret) {
+	case 0: /* read BIO submitted (page in fscache) */
+		BUG_ON(!list_empty(pages));
+		BUG_ON(*nr_pages != 0);
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: BIO submitted\n");
+
+		atomic_add(npages, &nfs_fscache_from_pages);
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
+		nfs_fscache_from_error = ret;
+	}
+
+	return ret;
+}
+
+/*
+ * store an updated page in fscache
+ */
+extern void nfs_writepage_to_fscache_complete(struct page *page, void *data, int error);
+
+static inline void nfs_writepage_to_fscache(struct inode *inode,
+					    struct page *page)
+{
+	int error;
+
+	if (PageNfsCached(page) && NFS_I(inode)->fscache) {
+		dfprintk(FSCACHE,
+			 "NFS: writepage_to_fscache (0x%p/0x%p/0x%p)\n",
+			 NFS_I(inode)->fscache, page, inode);
+
+		error = fscache_write_page(NFS_I(inode)->fscache, page,
+					   nfs_writepage_to_fscache_complete,
+					   NULL, GFP_KERNEL);
+		if (error != 0) {
+			dfprintk(FSCACHE,
+				 "NFS:    fscache_write_page error %d\n",
+				 error);
+			fscache_uncache_page(NFS_I(inode)->fscache, page);
+		}
+	}
+}
+
+#else /* CONFIG_NFS_FSCACHE */
+static inline int nfs_fscache_register(void) { return 0; }
+static inline void nfs_fscache_unregister(void) {}
+static inline void nfs_fscache_get_client_cookie(struct nfs_client *clp) {}
+static inline void nfs4_fscache_get_client_cookie(struct nfs_client *clp) {}
+static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp) {}
+static inline const char *nfs_server_fscache_state(struct nfs_server *server) { return "no "; }
+
+static inline void nfs_fscache_get_fh_cookie(struct super_block *sb,
+					     struct nfs_inode *nfsi,
+					     int maycache)
+{
+}
+static inline void nfs_fscache_set_size(struct nfs_server *server,
+					struct nfs_inode *nfsi,
+					loff_t i_size)
+{
+}
+static inline void nfs_fscache_release_fh_cookie(struct nfs_server *server,
+						 struct nfs_inode *nfsi)
+{
+}
+static inline void nfs_fscache_zap_fh_cookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void nfs_fscache_renew_fh_cookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void nfs_fscache_disable_fh_cookie(struct inode *inode) {}
+static inline void nfs_fscache_install_vm_ops(struct inode *inode, struct vm_area_struct *vma) {}
+static inline void nfs_fscache_release_page(struct page *page) {}
+static inline void nfs_fscache_invalidate_page(struct page *page,
+					       struct inode *inode,
+					       unsigned long offset)
+{
+}
+static inline void nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync) {}
+static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
+					    struct inode *inode, struct page *page)
+{
+	return -ENOBUFS;
+}
+static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
+					     struct inode *inode,
+					     struct address_space *mapping,
+					     struct list_head *pages,
+					     unsigned *nr_pages)
+{
+	return -ENOBUFS;
+}
+
+static inline void nfs_writepage_to_fscache(struct inode *inode, struct page *page)
+{
+	BUG_ON(PageNfsCached(page));
+}
+
+#endif /* CONFIG_NFS_FSCACHE */
+#endif /* _NFS_FSCACHE_H */
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7665b73..dcf916b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -88,6 +88,8 @@ void nfs_clear_inode(struct inode *inode
 	cred = nfsi->cache_access.cred;
 	if (cred)
 		put_rpccred(cred);
+
+	nfs_fscache_release_fh_cookie(NFS_SERVER(inode), nfsi);
 	BUG_ON(atomic_read(&nfsi->data_updates) != 0);
 }
 
@@ -134,6 +136,8 @@ void nfs_zap_caches(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	nfs_zap_caches_locked(inode);
 	spin_unlock(&inode->i_lock);
+
+	nfs_fscache_zap_fh_cookie(NFS_SERVER(inode), NFS_I(inode));
 }
 
 static void nfs_zap_acl_cache(struct inode *inode)
@@ -212,6 +216,7 @@ nfs_fhget(struct super_block *sb, struct
 	};
 	struct inode *inode = ERR_PTR(-ENOENT);
 	unsigned long hash;
+	int maycache = 1;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -260,6 +265,7 @@ nfs_fhget(struct super_block *sb, struct
 				else
 					inode->i_op = &nfs_mountpoint_inode_operations;
 				inode->i_fop = NULL;
+				maycache = 0;
 			}
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
@@ -292,6 +298,8 @@ nfs_fhget(struct super_block *sb, struct
 		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->cache_access.cred = NULL;
 
+		nfs_fscache_get_fh_cookie(sb, nfsi, maycache);
+
 		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
@@ -374,6 +382,7 @@ void nfs_setattr_update_inode(struct ino
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		inode->i_size = attr->ia_size;
+		nfs_fscache_set_size(NFS_SERVER(inode), NFS_I(inode), inode->i_size);
 		vmtruncate(inode, attr->ia_size);
 	}
 }
@@ -556,6 +565,8 @@ int nfs_open(struct inode *inode, struct
 	ctx->mode = filp->f_mode;
 	nfs_file_set_open_context(filp, ctx);
 	put_nfs_open_context(ctx);
+	if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
+		nfs_fscache_disable_fh_cookie(inode);
 	return 0;
 }
 
@@ -694,6 +705,8 @@ int nfs_revalidate_mapping(struct inode 
 		}
 		spin_unlock(&inode->i_lock);
 
+		nfs_fscache_renew_fh_cookie(NFS_SERVER(inode), nfsi);
+
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
@@ -927,11 +940,13 @@ static int nfs_update_inode(struct inode
 			if (data_stable) {
 				inode->i_size = new_isize;
 				invalid |= NFS_INO_INVALID_DATA;
+				nfs_fscache_set_size(NFS_SERVER(inode), nfsi, inode->i_size);
 			}
 			invalid |= NFS_INO_INVALID_ATTR;
 		} else if (new_isize > cur_isize) {
 			inode->i_size = new_isize;
 			invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
+			nfs_fscache_set_size(NFS_SERVER(inode), nfsi, inode->i_size);
 		}
 		nfsi->cache_change_attribute = jiffies;
 		dprintk("NFS: isize change on server for file %s/%ld\n",
@@ -1144,6 +1159,10 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	err = nfs_fscache_register();
+	if (err < 0)
+		goto out6;
+
 	err = nfs_fs_proc_init();
 	if (err)
 		goto out5;
@@ -1190,6 +1209,8 @@ out3:
 out4:
 	nfs_fs_proc_exit();
 out5:
+	nfs_fscache_unregister();
+out6:
 	return err;
 }
 
@@ -1200,6 +1221,7 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_readpagecache();
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
+	nfs_fscache_unregister();
 #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
 #endif
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1a1312e..18febb4 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -4,6 +4,30 @@
 
 #include <linux/mount.h>
 
+#define NFS_PAGE_WRITING	0
+#define NFS_PAGE_CACHED		1
+
+#define PageNfsBit(bit, page)		test_bit(bit, &(page)->private)
+
+#define SetPageNfsBit(bit, page)		\
+do {						\
+	SetPagePrivate((page));			\
+	set_bit(bit, &(page)->private);		\
+} while(0)
+
+#define ClearPageNfsBit(bit, page)		\
+do {						\
+	clear_bit(bit, &(page)->private);	\
+} while(0)
+
+#define PageNfsWriting(page)		PageNfsBit(NFS_PAGE_WRITING, (page))
+#define SetPageNfsWriting(page)		SetPageNfsBit(NFS_PAGE_WRITING, (page))
+#define ClearPageNfsWriting(page)	ClearPageNfsBit(NFS_PAGE_WRITING, (page))
+
+#define PageNfsCached(page)		PageNfsBit(NFS_PAGE_CACHED, (page))
+#define SetPageNfsCached(page)		SetPageNfsBit(NFS_PAGE_CACHED, (page))
+#define ClearPageNfsCached(page)	ClearPageNfsBit(NFS_PAGE_CACHED, (page))
+
 struct nfs_string;
 struct nfs_mount_data;
 struct nfs4_mount_data;
@@ -27,6 +51,11 @@ struct nfs_clone_mount {
 	rpc_authflavor_t authflavor;
 };
 
+/*
+ * include filesystem caching stuff here
+ */
+#include "fscache.h"
+
 /* client.c */
 extern struct rpc_program nfs_program;
 
@@ -150,6 +179,9 @@ extern int nfs4_path_walk(struct nfs_ser
 			  const char *path);
 #endif
 
+/* read.c */
+extern int nfs_readpage_async(struct nfs_open_context *, struct inode *, struct page *);
+
 /*
  * Determine the device name as a string
  */
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 36e902a..c45f724 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -17,6 +17,7 @@ #include <linux/nfs4.h>
 #include <linux/nfs_page.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
+#include "internal.h"
 
 #define NFS_PARANOIA 1
 
@@ -84,7 +85,7 @@ nfs_create_request(struct nfs_open_conte
 	atomic_set(&req->wb_complete, 0);
 	req->wb_index	= page->index;
 	page_cache_get(page);
-	BUG_ON(PagePrivate(page));
+	BUG_ON(PageNfsWriting(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(page->mapping->host != inode);
 	req->wb_offset  = offset;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 3093527..13ff66a 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -26,11 +26,13 @@ #include <linux/pagemap.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
+#include <linux/nfs_mount.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
 
 #include "iostat.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -200,13 +202,18 @@ static int nfs_readpage_sync(struct nfs_
 		SetPageUptodate(page);
 	result = 0;
 
+	nfs_readpage_to_fscache(inode, page, 1);
+	unlock_page(page);
+
+	return result;
+
 io_error:
 	unlock_page(page);
 	nfs_readdata_free(rdata);
 	return result;
 }
 
-static int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
+int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
 		struct page *page)
 {
 	LIST_HEAD(one_request);
@@ -231,6 +238,11 @@ static int nfs_readpage_async(struct nfs
 
 static void nfs_readpage_release(struct nfs_page *req)
 {
+	struct inode *d_inode = req->wb_context->dentry->d_inode;
+
+	if (PageUptodate(req->wb_page))
+		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
+
 	unlock_page(req->wb_page);
 
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",
@@ -613,6 +625,10 @@ int nfs_readpage(struct file *file, stru
 		ctx = get_nfs_open_context((struct nfs_open_context *)
 				file->private_data);
 	if (!IS_SYNC(inode)) {
+		error = nfs_readpage_from_fscache(ctx, inode, page);
+		if (error == 0)
+			goto out;
+
 		error = nfs_readpage_async(ctx, inode, page);
 		goto out;
 	}
@@ -643,6 +659,7 @@ readpage_async_filler(void *data, struct
 	unsigned int len;
 
 	nfs_wb_page(inode, page);
+
 	len = nfs_page_length(inode, page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
@@ -682,6 +699,17 @@ int nfs_readpages(struct file *filp, str
 	} else
 		desc.ctx = get_nfs_open_context((struct nfs_open_context *)
 				filp->private_data);
+
+	/* attempt to read as many of the pages as possible from the cache
+	 * - this returns -ENOBUFS immediately if the cookie is negative
+	 */
+	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
+					 pages, &nr_pages);
+	if (ret == 0) {
+		put_nfs_open_context(desc.ctx);
+		return ret; /* all read */
+	}
+
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
 	if (!list_empty(&head)) {
 		int err = nfs_pagein_list(&head, server->rpages);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7b266b7..f54315e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -286,6 +286,7 @@ static void nfs_show_mount_options(struc
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", "" },
 		{ NFS_MOUNT_NOACL, ",noacl", "" },
+		{ NFS_MOUNT_FSCACHE, ",fsc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index 2fe3403..7a25a6d 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -14,6 +14,7 @@ #include <linux/nfs_idmap.h>
 #include <linux/nfs_fs.h>
 
 #include "callback.h"
+#include "internal.h"
 
 static const int nfs_set_port_min = 0;
 static const int nfs_set_port_max = 65535;
@@ -55,6 +56,48 @@ #endif
 		.proc_handler	= &proc_dointvec_jiffies,
 		.strategy	= &sysctl_jiffies,
 	},
+#ifdef CONFIG_NFS_FSCACHE
+	{
+		.ctl_name = CTL_UNNUMBERED,
+		.procname = "fscache_from_error",
+		.data = &nfs_fscache_from_error,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = &proc_dointvec,
+	},
+	{
+		.ctl_name = CTL_UNNUMBERED,
+		.procname = "fscache_to_error",
+		.data = &nfs_fscache_to_error,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = &proc_dointvec,
+	},
+	{
+		.ctl_name = CTL_UNNUMBERED,
+		.procname = "fscache_uncache_page",
+		.data = &nfs_fscache_uncache_page,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = &proc_dointvec,
+	},
+	{
+		.ctl_name = CTL_UNNUMBERED,
+		.procname = "fscache_to_pages",
+		.data = &nfs_fscache_to_pages,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = &proc_dointvec_minmax,
+	},
+	{
+		.ctl_name = CTL_UNNUMBERED,
+		.procname = "fscache_from_pages",
+		.data = &nfs_fscache_from_pages,
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index a3f3f04..cd8d972 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -63,6 +63,7 @@ #include <linux/smp_lock.h>
 
 #include "delegation.h"
 #include "iostat.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -163,6 +164,9 @@ static void nfs_grow_file(struct page *p
 		return;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 	i_size_write(inode, end);
+#ifdef FSCACHE_WRITE_SUPPORT
+	nfs_set_fscsize(NFS_SERVER(inode), NFS_I(inode), end);
+#endif
 }
 
 /* We can set the PG_uptodate flag if we see that a write request
@@ -342,6 +346,9 @@ do_it:
 		err = -EBADF;
 		goto out;
 	}
+
+	nfs_writepage_to_fscache(inode, page);
+
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
@@ -424,7 +431,7 @@ static int nfs_inode_add_request(struct 
 		if (nfs_have_delegation(inode, FMODE_WRITE))
 			nfsi->change_attr++;
 	}
-	SetPagePrivate(req->wb_page);
+	SetPageNfsWriting(req->wb_page);
 	nfsi->npages++;
 	atomic_inc(&req->wb_count);
 	return 0;
@@ -441,7 +448,7 @@ static void nfs_inode_remove_request(str
 	BUG_ON (!NFS_WBACK_BUSY(req));
 
 	spin_lock(&nfsi->req_lock);
-	ClearPagePrivate(req->wb_page);
+	ClearPageNfsWriting(req->wb_page);
 	radix_tree_delete(&nfsi->nfs_page_tree, req->wb_index);
 	nfsi->npages--;
 	if (!nfsi->npages) {
diff --git a/include/linux/nfs4_mount.h b/include/linux/nfs4_mount.h
index 26b4c83..15199cc 100644
--- a/include/linux/nfs4_mount.h
+++ b/include/linux/nfs4_mount.h
@@ -65,6 +65,7 @@ #define NFS4_MOUNT_INTR		0x0002	/* 1 */
 #define NFS4_MOUNT_NOCTO	0x0010	/* 1 */
 #define NFS4_MOUNT_NOAC		0x0020	/* 1 */
 #define NFS4_MOUNT_STRICTLOCK	0x1000	/* 1 */
+#define NFS4_MOUNT_FSCACHE	0x4000	/* 1 */
 #define NFS4_MOUNT_FLAGMASK	0xFFFF
 
 #endif
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b7b4371..71cf935 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -29,6 +29,7 @@ #include <linux/nfs_fs_sb.h>
 
 #include <linux/rwsem.h>
 #include <linux/mempool.h>
+#include <linux/fscache.h>
 
 /*
  * Enable debugging support for nfs client.
@@ -180,6 +181,9 @@ #ifdef CONFIG_NFS_V4
 	int			 delegation_state;
 	struct rw_semaphore	rwsem;
 #endif /* CONFIG_NFS_V4*/
+#ifdef CONFIG_NFS_FSCACHE
+	struct fscache_cookie	*fscache;
+#endif
 	struct inode		vfs_inode;
 };
 
@@ -582,6 +586,7 @@ #define NFSDBG_FILE		0x0040
 #define NFSDBG_ROOT		0x0080
 #define NFSDBG_CALLBACK		0x0100
 #define NFSDBG_CLIENT		0x0200
+#define NFSDBG_FSCACHE		0x0400
 #define NFSDBG_ALL		0xFFFF
 
 #ifdef __KERNEL__
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 6d0be0e..54221e0 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -3,6 +3,7 @@ #define _NFS_FS_SB
 
 #include <linux/list.h>
 #include <linux/backing-dev.h>
+#include <linux/fscache.h>
 
 struct nfs_iostats;
 
@@ -66,6 +67,10 @@ #ifdef CONFIG_NFS_V4
 	char			cl_ipaddr[16];
 	unsigned char		cl_id_uniquifier;
 #endif
+
+#ifdef CONFIG_NFS_FSCACHE
+	struct fscache_cookie	*fscache;	/* client index cache cookie */
+#endif
 };
 
 /*
diff --git a/include/linux/nfs_mount.h b/include/linux/nfs_mount.h
index 659c754..278bb4e 100644
--- a/include/linux/nfs_mount.h
+++ b/include/linux/nfs_mount.h
@@ -61,6 +61,7 @@ #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 
 #define NFS_MOUNT_NOACL		0x0800	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
+#define NFS_MOUNT_FSCACHE	0x4000
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
