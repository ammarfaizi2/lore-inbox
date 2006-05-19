Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWESPsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWESPsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWESPr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:47:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932375AbWESPrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:47:45 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/14] NFS: Use local caching [try #10]
Date: Fri, 19 May 2006 16:47:14 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060519154714.11791.96608.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
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

 fs/Kconfig                   |    7 +
 fs/cachefiles/cf-bind.c      |    2 
 fs/cachefiles/cf-interface.c |    2 
 fs/nfs/Makefile              |    1 
 fs/nfs/client.c              |   18 +++
 fs/nfs/file.c                |   31 +++++
 fs/nfs/inode.c               |   26 +++++
 fs/nfs/internal.h            |   10 ++
 fs/nfs/nfs-fscache.c         |  191 +++++++++++++++++++++++++++++++++
 fs/nfs/nfs-fscache.h         |  169 +++++++++++++++++++++++++++++
 fs/nfs/pagelist.c            |    3 -
 fs/nfs/read.c                |  241 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/super.c               |   21 ++++
 fs/nfs/sysctl.c              |   43 +++++++
 fs/nfs/write.c               |   54 +++++++++
 include/linux/nfs4_mount.h   |    1 
 include/linux/nfs_fs.h       |    5 +
 include/linux/nfs_fs_sb.h    |    5 +
 include/linux/nfs_mount.h    |    1 
 19 files changed, 824 insertions(+), 7 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 9ef9f14..683d96f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1424,6 +1424,13 @@ config NFS_V4
 
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
diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index c963ee9..0c14c37 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -155,7 +155,7 @@ static int cachefiles_proc_add_cache(str
 		goto error_unsupported;
 
 	/* get the cache size and blocksize */
-	ret = root->d_sb->s_op->statfs(cache->mnt, &stats);
+	ret = root->d_sb->s_op->statfs(root, &stats);
 	if (ret < 0)
 		goto error_unsupported;
 
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index 5076e87..ee503a6 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -339,7 +339,7 @@ int cachefiles_has_space(struct cachefil
 	/* find out how many pages of blockdev are available */
 	memset(&stats, 0, sizeof(stats));
 
-	ret = cache->mnt->mnt_sb->s_op->statfs(cache->mnt, &stats);
+	ret = cache->mnt->mnt_sb->s_op->statfs(cache->mnt->mnt_root, &stats);
 	if (ret < 0) {
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "statfs failed");
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index f4580b4..9334293 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -16,4 +16,5 @@ nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4x
 			   nfs4namespace.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
 nfs-$(CONFIG_SYSCTL) += sysctl.o
+nfs-$(CONFIG_NFS_FSCACHE) += nfs-fscache.o
 nfs-objs		:= $(nfs-y)
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d2bf7f5..e503a0e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -42,6 +42,7 @@ #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
 #include "iostat.h"
+#include "nfs-fscache.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
@@ -182,6 +183,8 @@ #endif
 
 	dprintk("--> nfs_free_client()\n");
 
+	nfs_kill_fscookie(clp);
+
 	/* -EIO all pending I/O */
 	rpc = clp->client;
 	if (!IS_ERR(rpc))
@@ -497,6 +500,9 @@ #endif
 	clp->acdirmin = data->acdirmin * HZ;
 	clp->acdirmax = data->acdirmax * HZ;
 
+	if (clp->flags & NFS_MOUNT_FSCACHE)
+		nfs_fill_fscookie(clp);
+
 	/* Start lockd here, before we might error out */
 	if (!(clp->flags & NFS_MOUNT_NONLM)) {
 		error = lockd_up();
@@ -831,6 +837,9 @@ static int nfs4_create_client(struct nfs
 	clp->retrans_timeo = timeparms.to_initval;
 	clp->retrans_count = timeparms.to_retries;
 
+	if (clp->flags & NFS4_MOUNT_FSCACHE)
+		nfs4_fill_fscookie(clp);
+
 	/* Start lockd here, before we might error out */
 	if (!(clp->flags & NFS_MOUNT_NONLM)) {
 		error = lockd_up();
@@ -1221,7 +1230,7 @@ static int nfs_client_list_show(struct s
 
 	/* display header on line 1 */
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "NV SERVER   PORT USE AUTH HOSTNAME\n");
+		seq_puts(m, "NV SERVER   PORT USE AUTH FSC HOSTNAME\n");
 		return 0;
 	}
 
@@ -1233,12 +1242,17 @@ static int nfs_client_list_show(struct s
 	    nfs_auth_flavours[clp->authflavour])
 		auth = nfs_auth_flavours[clp->authflavour];
 
-	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %3d %s %s\n",
+	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %3d %s %s %s\n",
 		   clp->nfsversion,
 		   NIPQUAD(clp->addr.sin_addr),
 		   ntohs(clp->addr.sin_port),
 		   atomic_read(&clp->usage),
 		   auth,
+#ifdef CONFIG_NFS_FSCACHE
+		   clp->fscache ? "yes" : "no ",
+#else
+		   "no ",
+#endif
 		   clp->hostname);
 
 	return 0;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8a89a70..4ce3e69 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -27,9 +27,11 @@ #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include "nfs-fscache.h"
 
 #include "delegation.h"
 #include "iostat.h"
@@ -253,6 +255,19 @@ nfs_file_sendfile(struct file *filp, lof
 	return res;
 }
 
+#ifdef CONFIG_NFS_FSCACHE
+static int nfs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+}
+static struct vm_operations_struct nfs_fs_vm_operations = {
+	.nopage			= filemap_nopage,
+	.populate		= filemap_populate,
+	.page_mkwrite   = nfs_file_page_mkwrite,
+};
+#endif
+
 static int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
@@ -266,6 +281,12 @@ nfs_file_mmap(struct file * file, struct
 	status = nfs_revalidate_file(inode, file);
 	if (!status)
 		status = generic_file_mmap(file, vma);
+
+#ifdef CONFIG_NFS_FSCACHE
+	if (NFS_I(inode)->fscache != NULL)
+		vma->vm_ops = &nfs_fs_vm_operations;
+#endif
+
 	return status;
 }
 
@@ -328,6 +349,11 @@ static int nfs_release_page(struct page 
 	return !nfs_wb_page(page->mapping->host, page);
 }
 
+/*
+ * since we use page->private for our own nefarious purposes when using fscache, we have to
+ * override extra address space ops to prevent fs/buffer.c from getting confused, even though we
+ * may not have asked its opinion
+ */
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -341,6 +367,11 @@ struct address_space_operations nfs_file
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+#ifdef CONFIG_NFS_FSCACHE
+	.sync_page	= block_sync_page,
+	.releasepage	= nfs_releasepage,
+	.invalidatepage	= nfs_invalidatepage,
+#endif
 };
 
 /* 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 16d6ae6..54c8378 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -48,6 +48,8 @@ #include "delegation.h"
 #include "iostat.h"
 #include "internal.h"
 
+#include "nfs-fscache.h"
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
@@ -103,6 +105,8 @@ void nfs_clear_inode(struct inode *inode
 	cred = nfsi->cache_access.cred;
 	if (cred)
 		put_rpccred(cred);
+
+	nfs_clear_fscookie(NFS_SERVER(inode), nfsi);
 	BUG_ON(atomic_read(&nfsi->data_updates) != 0);
 }
 
@@ -149,6 +153,8 @@ void nfs_zap_caches(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	nfs_zap_caches_locked(inode);
 	spin_unlock(&inode->i_lock);
+
+	nfs_zap_fscookie(NFS_SERVER(inode), NFS_I(inode));
 }
 
 static void nfs_zap_acl_cache(struct inode *inode)
@@ -227,6 +233,7 @@ nfs_fhget(struct super_block *sb, struct
 	};
 	struct inode *inode = ERR_PTR(-ENOENT);
 	unsigned long hash;
+	int maycache = 1;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -275,6 +282,7 @@ nfs_fhget(struct super_block *sb, struct
 				else
 					inode->i_op = &nfs_mountpoint_inode_operations;
 				inode->i_fop = NULL;
+				maycache = 0;
 			}
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
@@ -307,6 +315,12 @@ nfs_fhget(struct super_block *sb, struct
 		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->cache_access.cred = NULL;
 
+#ifdef CONFIG_NFS_FSCACHE
+		nfsi->fscache = NULL;
+#endif
+		if (maycache)
+			nfs_fhget_fscookie(sb, nfsi);
+
 		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
@@ -389,6 +403,7 @@ void nfs_setattr_update_inode(struct ino
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		inode->i_size = attr->ia_size;
+		nfs_set_fscsize(NFS_SERVER(inode), NFS_I(inode), inode->i_size);
 		vmtruncate(inode, attr->ia_size);
 	}
 }
@@ -704,6 +719,8 @@ void nfs_revalidate_mapping(struct inode
 		}
 		spin_unlock(&inode->i_lock);
 
+		nfs_renew_fscookie(NFS_SERVER(inode), nfsi);
+
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
@@ -943,11 +960,13 @@ static int nfs_update_inode(struct inode
 			if (data_stable) {
 				inode->i_size = new_isize;
 				invalid |= NFS_INO_INVALID_DATA;
+				nfs_set_fscsize(NFS_SERVER(inode), nfsi, inode->i_size);
 			}
 			invalid |= NFS_INO_INVALID_ATTR;
 		} else if (new_isize > cur_isize) {
 			inode->i_size = new_isize;
 			invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
+			nfs_set_fscsize(NFS_SERVER(inode), nfsi, inode->i_size);
 		}
 		nfsi->cache_change_attribute = jiffies;
 		dprintk("NFS: isize change on server for file %s/%ld\n",
@@ -1162,6 +1181,10 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	err = nfs_register_fscache();
+	if (err < 0)
+		goto out6;
+
 	err = nfs_fs_proc_init();
 	if (err)
 		goto out5;
@@ -1208,6 +1231,8 @@ out3:
 out4:
 	nfs_fs_proc_exit();
 out5:
+	nfs_unregister_fscache();
+out6:
 	return err;
 }
 
@@ -1218,6 +1243,7 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_readpagecache();
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
+	nfs_unregister_fscache();
 #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
 #endif
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d52a273..677b42e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -4,6 +4,16 @@
 
 #include <linux/mount.h>
 
+#define NFS_PAGE_WRITING	0
+
+#define PageNfsWriting(page)		test_bit(NFS_PAGE_WRITING, &(page)->private)
+#define SetPageNfsWriting(page)		set_bit(NFS_PAGE_WRITING, &(page)->private)
+#define ClearPageNfsWriting(page)	clear_bit(NFS_PAGE_WRITING, &(page)->private)
+
+#define PageNfsCached(page)		PagePrivate(page)
+#define SetPageNfsCached(page)		SetPagePrivate(page)
+#define ClearPageNfsCached(page)	ClearPagePrivate(page)
+
 struct nfs_string;
 struct nfs_mount_data;
 struct nfs4_mount_data;
diff --git a/fs/nfs/nfs-fscache.c b/fs/nfs/nfs-fscache.c
new file mode 100644
index 0000000..83a30cc
--- /dev/null
+++ b/fs/nfs/nfs-fscache.c
@@ -0,0 +1,191 @@
+/* nfs-fscache.c: NFS filesystem cache interface
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
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_fs_sb.h>
+#include <linux/in6.h>
+
+#include "nfs-fscache.h"
+#include "internal.h"
+
+/*
+ * Sysctl variables
+ */
+int nfs_fscache_to_pages;
+int nfs_fscache_from_pages;
+int nfs_fscache_uncache_page;
+int nfs_fscache_from_error;
+int nfs_fscache_to_error;
+
+#define NFSDBG_FACILITY		NFSDBG_FSCACHE
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
+	key->nfsversion = clp->nfsversion;
+
+	switch (clp->addr.sin_family) {
+	case AF_INET:
+		key->port = clp->addr.sin_port;
+		
+		memcpy(&key->ipv4_addr.ipv6wrapper,
+		       &nfs_cache_ipv6_wrapper_for_ipv4,
+		       sizeof(key->ipv4_addr.ipv6wrapper));
+		memcpy(&key->ipv4_addr.addr,
+		       &clp->addr.sin_addr,
+		       sizeof(key->ipv4_addr.addr));
+		len = sizeof(struct nfs_server_key);
+		break;
+
+	case AF_INET6:
+		key->port = clp->addr.sin_port;
+
+		memcpy(&key->ipv6_addr,
+		       &clp->addr.sin_addr,
+		       sizeof(key->ipv6_addr));
+		len = sizeof(struct nfs_server_key);
+		break;
+
+	default:
+		len = 0;
+		printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
+			clp->addr.sin_family);
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
+//printk("nfs_fh_get_key: nfsi 0x%p nsize %d\n", nfsi, nsize);
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
+ * the primary index for each server is simply made up of a series of NFS file
+ * handles
+ */
+struct fscache_cookie_def nfs_cache_fh_index_def = {
+	.name			= "NFS.fh",
+	.type			= FSCACHE_COOKIE_TYPE_DATAFILE,
+	.get_key		= nfs_fh_get_key,
+	.mark_pages_cached	= nfs_fh_mark_pages_cached,
+	.now_uncached		= nfs_fh_now_uncached,
+};
diff --git a/fs/nfs/nfs-fscache.h b/fs/nfs/nfs-fscache.h
new file mode 100644
index 0000000..d7fccb3
--- /dev/null
+++ b/fs/nfs/nfs-fscache.h
@@ -0,0 +1,169 @@
+/* nfs-fscache.h: NFS filesystem cache interface definitions
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
+
+extern void nfs_invalidatepage(struct page *, unsigned long);
+extern int nfs_releasepage(struct page *, gfp_t);
+extern int nfs_mkwrite(struct page *);
+
+extern int nfs_fscache_to_pages;
+extern int nfs_fscache_from_pages;
+extern int nfs_fscache_uncache_page;
+extern int nfs_fscache_from_error;
+extern int nfs_fscache_to_error;
+
+static inline
+void nfs4_fill_fscookie(struct nfs_client *clp)
+{
+	if (!(clp->flags & NFS_MOUNT_FSCACHE)) {
+		clp->fscache = NULL;
+		return;
+	}
+
+	/* create a cache index for looking up filehandles */
+	clp->fscache = fscache_acquire_cookie(nfs_cache_netfs.primary_index,
+			       &nfs_cache_server_index_def, clp);
+	if (!clp->fscache) {
+		clp->flags &= ~NFS_MOUNT_FSCACHE;
+		printk(KERN_WARNING
+		       "NFS4: No Fscache cookie. Turning Fscache off!\n");
+	} else {
+		dfprintk(FSCACHE,"NFS: nfs4 cookie (0x%p/0x%p)\n",
+			 clp, clp->fscache);
+	}
+}
+
+static inline
+void nfs_fill_fscookie(struct nfs_client *clp)
+{
+	clp->fscache = NULL;
+	if (clp->flags & NFS_MOUNT_FSCACHE) {
+		/* create a cache index for looking up filehandles */
+		clp->fscache = fscache_acquire_cookie(nfs_cache_netfs.primary_index,
+						      &nfs_cache_server_index_def, clp);
+		if (!clp->fscache) {
+			clp->flags &= ~NFS_MOUNT_FSCACHE;
+			printk(KERN_WARNING "NFS: No Fscache cookie. Turning "
+			       "Fscache off!\n");
+		}
+	}
+		
+	dfprintk(FSCACHE,"NFS: cookie (0x%p/0x%p)\n", clp, clp->fscache);
+}
+
+static inline
+void nfs_fhget_fscookie(struct super_block *sb, struct nfs_inode *nfsi)
+{
+	struct nfs_client *clp = NFS_SB(sb)->nfs_client;
+
+	nfsi->fscache = fscache_acquire_cookie(clp->fscache,
+		&nfs_cache_fh_index_def, nfsi);
+	fscache_set_i_size(nfsi->fscache, nfsi->vfs_inode.i_size);
+
+	dfprintk(FSCACHE, "NFS: fhget new cookie (0x%p/0x%p/0x%p)\n",
+		sb, nfsi, nfsi->fscache);
+}
+
+static inline
+void nfs_kill_fscookie(struct nfs_client *clp)
+{
+	dfprintk(FSCACHE,"NFS: killing cookie (0x%p/0x%p)\n",
+		clp, clp->fscache);
+
+	fscache_relinquish_cookie(clp->fscache, 0);
+	clp->fscache = NULL;
+}
+
+static inline
+void nfs_set_fscsize(struct nfs_server *server, struct nfs_inode *nfsi, loff_t i_size)
+{
+	fscache_set_i_size(nfsi->fscache, i_size);
+}
+
+static inline
+void nfs_renew_fscookie(struct nfs_server *server, struct nfs_inode *nfsi)
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
+static inline
+void nfs_clear_fscookie(struct nfs_server *server, struct nfs_inode *nfsi)
+{
+	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n",
+			nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 0);
+	nfsi->fscache = NULL;
+}
+
+static inline
+void nfs_zap_fscookie(struct nfs_server *server, struct nfs_inode *nfsi)
+{
+	dfprintk(FSCACHE,"NFS: zapping cookie (0x%p/0x%p)\n",
+		nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 1);
+	nfsi->fscache = NULL;
+}
+
+static inline int nfs_register_fscache(void)
+{
+	return fscache_register_netfs(&nfs_cache_netfs);
+}
+
+static inline void nfs_unregister_fscache(void)
+{
+	fscache_unregister_netfs(&nfs_cache_netfs);
+}
+#else
+static inline void nfs_fill_fscookie(struct nfs_client *clp) {}
+static inline void nfs4_fill_fscookie(struct nfs_client *clp) {}
+static inline void nfs_kill_fscookie(struct nfs_client *clp) {}
+static inline void nfs_fhget_fscookie(struct super_block *sb, struct nfs_inode *nfsi) {}
+static inline void nfs_set_fscsize(struct nfs_server *server, struct nfs_inode *nfsi, loff_t i_size) {}
+static inline void nfs_clear_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void nfs_zap_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void nfs_renew_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline int nfs_register_netfs(void) { return 0; }
+static inline void nfs_unregister_netfs(void) {}
+static inline int nfs_register_fscache(void) { return 0; }
+static inline void nfs_unregister_fscache(void) { }
+
+#endif
+#endif /* _NFS_FSCACHE_H */
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 4077e42..e397fb1 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -18,6 +18,7 @@ #include <linux/nfs4.h>
 #include <linux/nfs_page.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
+#include "internal.h"
 
 #define NFS_PARANOIA 1
 
@@ -85,7 +86,7 @@ nfs_create_request(struct nfs_open_conte
 	atomic_set(&req->wb_complete, 0);
 	req->wb_index	= page->index;
 	page_cache_get(page);
-	BUG_ON(PagePrivate(page));
+	BUG_ON(PageNfsWriting(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(page->mapping->host != inode);
 	req->wb_offset  = offset;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 58f3444..16f2348 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -27,11 +27,15 @@ #include <linux/pagemap.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
+#include <linux/nfs_mount.h>
 #include <linux/smp_lock.h>
 
+#include "nfs-fscache.h"
+
 #include <asm/system.h>
 
 #include "iostat.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -101,6 +105,53 @@ int nfs_return_empty_page(struct page *p
 	return 0;
 }
 
+#ifdef CONFIG_NFS_FSCACHE
+/*
+ * store a newly fetched page in fscache
+ */
+static void
+nfs_readpage_to_fscache_complete(struct page *page, void *data, int error)
+{
+	dfprintk(FSCACHE, 
+		"NFS:     readpage_to_fscache_complete (p:%p(i:%lx f:%lx)/%d)\n", 
+		page, page->index, page->flags, error);
+
+	end_page_fs_misc(page);
+}
+
+static inline void
+nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+{
+	int ret;
+
+	dfprintk(FSCACHE, "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
+		NFS_I(inode)->fscache, page, page->index, page->flags, sync);
+
+	if (TestSetPageFsMisc(page))
+		BUG();
+	ret = fscache_write_page(NFS_I(inode)->fscache, page,
+		nfs_readpage_to_fscache_complete, NULL, GFP_KERNEL);
+	dfprintk(FSCACHE, 
+		"NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n", 
+			page, page->index, page->flags, ret);
+	if (ret != 0) {
+		fscache_uncache_page(NFS_I(inode)->fscache, page);
+		nfs_fscache_uncache_page++;
+		ClearPageNfsCached(page);
+		end_page_fs_misc(page);
+		nfs_fscache_to_error = ret;
+	} else
+		nfs_fscache_to_pages++;
+}
+#else
+static inline void
+nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+{
+	BUG();
+}
+#endif
+
+
 /*
  * Read a page synchronously.
  */
@@ -181,6 +232,14 @@ static int nfs_readpage_sync(struct nfs_
 		ClearPageError(page);
 	result = 0;
 
+#ifdef CONFIG_NFS_FSCACHE
+	if (PageNfsCached(page))
+		nfs_readpage_to_fscache(inode, page, 1);
+#endif
+	unlock_page(page);
+
+	return result;
+
 io_error:
 	unlock_page(page);
 	nfs_readdata_free(rdata);
@@ -212,6 +271,12 @@ static int nfs_readpage_async(struct nfs
 
 static void nfs_readpage_release(struct nfs_page *req)
 {
+#ifdef CONFIG_NFS_FSCACHE
+	struct inode *d_inode = req->wb_context->dentry->d_inode;
+
+	if (PageNfsCached(req->wb_page) && PageUptodate(req->wb_page))
+		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
+#endif
 	unlock_page(req->wb_page);
 
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",
@@ -535,6 +600,118 @@ int nfs_readpage_result(struct rpc_task 
 	return 0;
 }
 
+
+/*
+ * Read a page through the on-disc cache if possible
+ */
+#ifdef CONFIG_NFS_FSCACHE
+static void
+nfs_readpage_from_fscache_complete(struct page *page, void *data, int error)
+{
+	dfprintk(FSCACHE, 
+		"NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
+		page, data, error);
+
+	if (error)
+		SetPageError(page);
+	else
+		SetPageUptodate(page);
+
+	unlock_page(page);
+}
+
+static inline int
+nfs_readpage_from_fscache(struct inode *inode, struct page *page)
+{
+	int ret;
+
+	if (!NFS_I(inode)->fscache)
+		return 1;
+
+	dfprintk(FSCACHE, 
+		"NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
+		NFS_I(inode)->fscache, page, page->index, page->flags, inode);
+
+	ret = fscache_read_or_alloc_page(NFS_I(inode)->fscache,
+					 page,
+					 nfs_readpage_from_fscache_complete,
+					 NULL,
+					 GFP_KERNEL);
+
+	switch (ret) {
+	case 0: /* read BIO submitted (page in fscache) */
+		dfprintk(FSCACHE, 
+			"NFS:    readpage_from_fscache: BIO submitted\n");
+		nfs_fscache_from_pages++;
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE, 
+			"NFS:    readpage_from_fscache error %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
+		nfs_fscache_from_error = ret;
+	}
+    return ret;
+}
+
+static inline
+int nfs_getpages_from_fscache(struct inode *inode,
+	struct address_space *mapping,
+	struct list_head *pages,
+	unsigned *nr_pages)
+{
+	int ret, npages = *nr_pages;
+
+	if (!NFS_I(inode)->fscache)
+		return 1;
+
+	dfprintk(FSCACHE, 
+		"NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
+		NFS_I(inode)->fscache, *nr_pages, inode);
+
+	ret = fscache_read_or_alloc_pages(NFS_I(inode)->fscache,
+	  	mapping, pages, nr_pages, 
+	  	nfs_readpage_from_fscache_complete,
+	  	NULL, mapping_gfp_mask(mapping));
+
+
+	switch (ret) {
+	case 0: /* read BIO submitted (page in fscache) */
+		BUG_ON(!list_empty(pages));
+		BUG_ON(*nr_pages != 0);
+		dfprintk(FSCACHE, 
+			"NFS: nfs_getpages_from_fscache: BIO submitted\n");
+
+		nfs_fscache_from_pages += npages;
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE, 
+			"NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, 
+			"NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
+		nfs_fscache_from_error = ret;
+	}
+
+	return ret;
+}
+#else
+static inline
+int nfs_getpages_from_fscache(struct inode *inode,
+	struct address_space *mapping,
+	struct list_head *pages,
+	unsigned *nr_pages)
+{ return 1; }
+#endif
+
 /*
  * Read a page over NFS.
  * We read the page synchronously in the following case:
@@ -571,6 +748,15 @@ int nfs_readpage(struct file *file, stru
 		ctx = get_nfs_open_context((struct nfs_open_context *)
 				file->private_data);
 	if (!IS_SYNC(inode)) {
+#ifdef CONFIG_NFS_FSCACHE
+		error = nfs_readpage_from_fscache(inode, page);
+#if 0
+		if (error < 0)
+			goto out_error;
+#endif
+		if (error == 0)
+			goto out;
+#endif
 		error = nfs_readpage_async(ctx, inode, page);
 		goto out;
 	}
@@ -601,6 +787,7 @@ readpage_async_filler(void *data, struct
 	unsigned int len;
 
 	nfs_wb_page(inode, page);
+
 	len = nfs_page_length(inode, page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
@@ -633,6 +820,15 @@ int nfs_readpages(struct file *filp, str
 			nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
+#ifdef CONFIG_NFS_FSCACHE
+	/* attempt to read as many of the pages as possible from the cache
+	 * - this returns -ENOBUFS immediately if the cookie is negative
+	 */
+	ret = nfs_getpages_from_fscache(inode, mapping, pages, &nr_pages);
+	if (ret == 0)
+		return ret; /* all read */
+#endif
+
 	if (filp == NULL) {
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (desc.ctx == NULL)
@@ -674,3 +870,48 @@ void __exit nfs_destroy_readpagecache(vo
 	if (kmem_cache_destroy(nfs_rdata_cachep))
 		printk(KERN_INFO "nfs_read_data: not all structures were freed\n");
 }
+
+#ifdef CONFIG_NFS_FSCACHE
+void nfs_invalidatepage(struct page *page, unsigned long offset)
+{
+	BUG_ON(!PageLocked(page));
+
+	if (PageNfsCached(page)) {
+		struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+		BUG_ON(nfsi->fscache == NULL);
+
+		dfprintk(FSCACHE,
+			"NFS: fscache invalidatepage (0x%p/0x%p/0x%p)\n",
+			 nfsi->fscache, page, nfsi);
+
+		if (offset == 0) {
+			BUG_ON(!PageLocked(page));
+			if (!PageWriteback(page))
+				page->mapping->a_ops->releasepage(page, 0);
+		}
+	}
+}
+
+int nfs_releasepage(struct page *page, gfp_t gfp_flags)
+{
+	struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+	BUG_ON(nfsi->fscache == NULL);
+
+	dfprintk(FSCACHE, "NFS: fscache releasepage (0x%p/0x%p/0x%p)\n",
+		 nfsi->fscache, page, nfsi);
+
+	wait_on_page_fs_misc(page);
+	fscache_uncache_page(nfsi->fscache, page);
+	nfs_fscache_uncache_page++;
+	ClearPageNfsCached(page);
+	return 0;
+}
+
+int nfs_mkwrite(struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+}
+#endif
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 06b5a2a..55be40b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -295,6 +295,7 @@ static void nfs_show_mount_options(struc
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", "" },
 		{ NFS_MOUNT_NOACL, ",noacl", "" },
+		{ NFS_MOUNT_FSCACHE, ",fsc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
@@ -512,6 +513,16 @@ #endif /* CONFIG_NFS_V3 */
 		memset(mntfh->data + mntfh->size, 0,
 		       sizeof(mntfh->data) - mntfh->size);
 
+	/* if filesystem caching isn't compiled in, then requesting its use is
+	 * invalid */
+#ifndef CONFIG_NFS_FSCACHE
+	if (data->flags & NFS_MOUNT_FSCACHE) {
+		printk(KERN_WARNING
+		       "NFS: kernel not compiled with CONFIG_NFS_FSCACHE\n");
+		return -EINVAL;
+	}
+#endif
+
 	return 0;
 }
 
@@ -821,6 +832,16 @@ static int nfs4_get_sb(struct file_syste
 		return -EINVAL;
 	}
 
+	/* if filesystem caching isn't compiled in, then requesting its use is
+	 * invalid */
+#ifndef CONFIG_NFS_FSCACHE
+	if (data->flags & NFS_MOUNT_FSCACHE) {
+		printk(KERN_WARNING
+		       "NFS: kernel not compiled with CONFIG_NFS_FSCACHE\n");
+		return -EINVAL;
+	}
+#endif
+
 	/* We now require that the mount process passes the remote address */
 	if (data->host_addrlen != sizeof(addr))
 		return -EINVAL;
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index db61e51..5f020b1 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -15,6 +15,7 @@ #include <linux/nfs_idmap.h>
 #include <linux/nfs_fs.h>
 
 #include "callback.h"
+#include "nfs-fscache.h"
 
 static const int nfs_set_port_min = 0;
 static const int nfs_set_port_max = 65535;
@@ -56,6 +57,48 @@ #endif
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
index 6a90ccc..31a80a5 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -65,6 +65,9 @@ #include <linux/smp_lock.h>
 #include "delegation.h"
 #include "iostat.h"
 
+#include "nfs-fscache.h"
+#include "internal.h"
+
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
 #define MIN_POOL_WRITE		(32)
@@ -164,6 +167,9 @@ static void nfs_grow_file(struct page *p
 		return;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 	i_size_write(inode, end);
+#ifdef FSCACHE_WRITE_SUPPORT
+	nfs_set_fscsize(NFS_SERVER(inode), NFS_I(inode), end);
+#endif
 }
 
 /* We can set the PG_uptodate flag if we see that a write request
@@ -296,6 +302,47 @@ static int wb_priority(struct writeback_
 }
 
 /*
+ * store an updated page in fscache
+ */
+#ifdef CONFIG_NFS_FSCACHE
+static void
+nfs_writepage_to_fscache_complete(struct page *page, void *data, int error)
+{
+	/* really need to synchronise the end of writeback, probably using a page flag */
+}
+static inline void
+nfs_writepage_to_fscache(struct inode *inode, struct page *page)
+{
+	int ret; 
+
+	if (!NFS_I(inode)->fscache)
+		return;
+
+	if (PageNfsCached(page)) {
+		dfprintk(FSCACHE,
+			"NFS: writepage_to_fscache (0x%p/0x%p/0x%p)\n",
+			NFS_I(inode)->fscache, page, inode);
+
+		ret = fscache_write_page(NFS_I(inode)->fscache, page,
+					 nfs_writepage_to_fscache_complete,
+					 NULL, GFP_KERNEL);
+		if (ret != 0) {
+			dfprintk(FSCACHE,
+				"NFS:    fscache_write_page error %d\n", ret);
+				fscache_uncache_page(NFS_I(inode)->fscache, 
+				page);
+		}
+	}
+}
+#else
+static inline void
+nfs_writepage_to_fscache(struct inode *inode, struct page *page)
+{
+	BUG_ON(PageNfsCached(page));
+}
+#endif
+
+/*
  * Write an mmapped page to the server.
  */
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -343,6 +390,9 @@ do_it:
 		err = -EBADF;
 		goto out;
 	}
+#ifdef FSCACHE_WRITE_SUPPORT
+	nfs_writepage_to_fscache(inode, page);
+#endif
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
@@ -425,7 +475,7 @@ static int nfs_inode_add_request(struct 
 		if (nfs_have_delegation(inode, FMODE_WRITE))
 			nfsi->change_attr++;
 	}
-	SetPagePrivate(req->wb_page);
+	SetPageNfsWriting(req->wb_page);
 	nfsi->npages++;
 	atomic_inc(&req->wb_count);
 	return 0;
@@ -442,7 +492,7 @@ static void nfs_inode_remove_request(str
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
index c39538e..6050fe0 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -30,6 +30,7 @@ #include <linux/nfs_fs_sb.h>
 
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
 
@@ -579,6 +583,7 @@ #define NFSDBG_FILE		0x0040
 #define NFSDBG_ROOT		0x0080
 #define NFSDBG_CALLBACK		0x0100
 #define NFSDBG_CLIENT		0x0200
+#define NFSDBG_FSCACHE		0x0400
 #define NFSDBG_ALL		0xFFFF
 
 #ifdef __KERNEL__
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index f99dd66..e20189f 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -3,6 +3,7 @@ #define _NFS_FS_SB
 
 #include <linux/list.h>
 #include <linux/backing-dev.h>
+#include <linux/fscache.h>
 
 struct nfs_iostats;
 
@@ -86,6 +87,10 @@ #ifdef CONFIG_NFS_V4
 	 */
 	char			ip_addr[16];
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

