Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUJDUre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUJDUre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUJDUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:47:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268482AbUJDUnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:43:23 -0400
Message-ID: <4161B664.70109@RedHat.com>
Date: Mon, 04 Oct 2004 16:45:24 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS using CacheFS
Content-Type: multipart/mixed;
 boundary="------------010302040005050904090208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302040005050904090208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hey Trond,

Here here is the first stab at having NFS use the CacheFS that is currently
in the -mm tree. As you know CacheFS is a caching filesystem that allows
network filesystems, such as AFS and now NFS, to cache data pages on
the local disk. This is a big win (especially with read-only filesystems)
since it drastically cuts down on the amount of data read across the
network. Plus the cached data survives umounts and reboots (since CacheFS
journals the data). So when a client comes back up or  the filesystem is 
remounted,
all that is needed is a few small getattrs  to insure the data is still 
valid. If it is,
NFS reads are turned into local disk reads.... A Huge gain in 
performance!!!!

I have structured that patch so CacheFS is a mount option. I figured
this was the safest way to introduce CacheFS and not completely
break NFS.... And if for some reason, NFS is not able to get an
initial Cachefs cookie (i.e. it can't use CacheFS) , NFS will dynamically
turn off the mount option, disabling the use of the cache..

But as usual there are some issues....
1) NFS aliasing. The fact that:

mount hades:/hades /a
mount hades:/hades/xxx /b

creates separate super blocks causes problems for
CacheFS. With the current -mm code, these type of mount
actual causes CacheFS to crash (although I do have a proposed
patch that David is looking at).

2) NFS4 is not supported. I simply have not had time to get this working.
    But I will!!

3) There is no user level support. I realize this is extremely cheesy
     but I noticed that the NFS posix mount  option (in the 2.6 kernel)
     was no longer being used, so I high jacked it.  Which means
     to make NFS to used CacheFS you need to use the posix option:

     mount -o posix server:/export/home /mnt/server/home

Comments?

SteveD.

PS. The new CacheFS mailing that have been set up is at
http://www.redhat.com/mailman/listinfo/linux-cachefs
I encourage you and anybody else interested in this
type of technology to subscribe....




--------------010302040005050904090208
Content-Type: text/x-patch;
 name="linux-2.6.9-rc3-mm2-cachefs-nfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.9-rc3-mm2-cachefs-nfs.patch"

--- 2.6.9-rc3-mm2/include/linux/nfs_fs.h.orig	2004-10-04 09:32:24.883031000 -0400
+++ 2.6.9-rc3-mm2/include/linux/nfs_fs.h	2004-10-04 11:02:34.664243000 -0400
@@ -30,6 +30,7 @@
 #include <linux/nfs_xdr.h>
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
+#include <linux/cachefs.h>
 
 /*
  * Enable debugging support for nfs client.
@@ -189,6 +190,10 @@ struct nfs_inode {
 	struct rw_semaphore	rwsem;
 #endif /* CONFIG_NFS_V4*/
 
+#ifdef CONFIG_NFS_CACHEFS
+	struct cachefs_cookie	*cachefs;
+#endif
+
 	struct inode		vfs_inode;
 };
 
--- 2.6.9-rc3-mm2/include/linux/nfs_fs_sb.h.orig	2004-10-04 09:32:24.890033000 -0400
+++ 2.6.9-rc3-mm2/include/linux/nfs_fs_sb.h	2004-10-04 11:02:34.694245000 -0400
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/backing-dev.h>
+#include <linux/cachefs.h>
 
 /*
  * NFS client parameters stored in the superblock.
@@ -46,6 +47,10 @@ struct nfs_server {
 						   that are supported on this
 						   filesystem */
 #endif
+
+#ifdef CONFIG_NFS_CACHEFS
+	struct cachefs_cookie	*cachefs;	/* cache cookie */
+#endif
 };
 
 /* Server capabilities */
--- 2.6.9-rc3-mm2/include/linux/nfs_mount.h.orig	2004-08-14 06:54:47.000000000 -0400
+++ 2.6.9-rc3-mm2/include/linux/nfs_mount.h	2004-10-04 11:02:34.724245000 -0400
@@ -60,6 +60,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
+#define NFS_MOUNT_CACHEFS		NFS_MOUNT_POSIX
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
--- 2.6.9-rc3-mm2/fs/nfs/file.c.orig	2004-10-04 09:32:20.529019000 -0400
+++ 2.6.9-rc3-mm2/fs/nfs/file.c	2004-10-04 11:02:34.729243000 -0400
@@ -27,9 +27,11 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include "nfs-cachefs.h"
 
 #include "delegation.h"
 
@@ -240,6 +242,69 @@ static int nfs_commit_write(struct file 
 	return status;
 }
 
+#ifdef CONFIG_NFS_CACHEFS
+static int nfs_invalidatepage(struct page *page, unsigned long offset)
+{
+	int ret = 1;
+	struct nfs_server *server = NFS_SERVER(page->mapping->host);
+
+	BUG_ON(!PageLocked(page));
+
+	if (server->flags & NFS_MOUNT_CACHEFS) {
+		if (PagePrivate(page)) {
+			struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+			dfprintk(PAGECACHE,"NFS: cachefs invalidatepage (0x%p/0x%p/0x%p)\n",
+				nfsi->cachefs, page, nfsi);
+
+			cachefs_uncache_page(nfsi->cachefs, page);
+
+			if (offset == 0) {
+				BUG_ON(!PageLocked(page));
+				ret = 0;
+				if (!PageWriteback(page))
+					ret = page->mapping->a_ops->releasepage(page, 0);
+			}
+		}
+	} else
+		ret = 0;
+
+	return ret;
+}
+static int nfs_releasepage(struct page *page, int gfp_flags)
+{
+	struct cachefs_page *pageio;
+	struct nfs_server *server = NFS_SERVER(page->mapping->host);
+
+	if (server->flags & NFS_MOUNT_CACHEFS && PagePrivate(page)) {
+		struct nfs_inode *nfsi = NFS_I(page->mapping->host);
+
+		dfprintk(PAGECACHE,"NFS: cachefs releasepage (0x%p/0x%p/0x%p)\n",
+			nfsi->cachefs, page, nfsi);
+
+		cachefs_uncache_page(nfsi->cachefs, page);
+		pageio = (struct cachefs_page *) page->private;
+		page->private = 0;
+		ClearPagePrivate(page);
+
+		if (pageio)
+			kfree(pageio);
+	}
+
+	return 0;
+}
+static int nfs_mkwrite(struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+}
+#endif
+
+/*
+ * since we use page->private for our own nefarious purposes when using cachefs, we have to
+ * override extra address space ops to prevent fs/buffer.c from getting confused, even though we
+ * may not have asked its opinion
+ */
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -251,6 +316,12 @@ struct address_space_operations nfs_file
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+#ifdef CONFIG_NFS_CACHEFS
+	.sync_page		= block_sync_page,
+	.releasepage		= nfs_releasepage,
+	.invalidatepage		= nfs_invalidatepage,
+	.page_mkwrite	= nfs_mkwrite,
+#endif
 };
 
 /* 
--- 2.6.9-rc3-mm2/fs/nfs/inode.c.orig	2004-10-04 09:32:20.538020000 -0400
+++ 2.6.9-rc3-mm2/fs/nfs/inode.c	2004-10-04 11:02:34.740244000 -0400
@@ -41,6 +41,8 @@
 
 #include "delegation.h"
 
+#include "nfs-cachefs.h"
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
@@ -140,7 +142,7 @@ nfs_delete_inode(struct inode * inode)
 
 /*
  * For the moment, the only task for the NFS clear_inode method is to
- * release the mmap credential
+ * release the mmap credential and release the inode's on-disc cache
  */
 static void
 nfs_clear_inode(struct inode *inode)
@@ -153,6 +155,16 @@ nfs_clear_inode(struct inode *inode)
 	cred = nfsi->cache_access.cred;
 	if (cred)
 		put_rpccred(cred);
+
+#ifdef CONFIG_NFS_CACHEFS
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS) {
+		dfprintk(PAGECACHE, "NFS: relinquish cookie (0x%p/0x%p)\n", 
+			nfsi, nfsi->cachefs);
+		cachefs_relinquish_cookie(nfsi->cachefs, 0);
+		nfsi->cachefs = NULL;
+	}
+#endif
+
 	BUG_ON(atomic_read(&nfsi->data_updates) != 0);
 }
 
@@ -462,6 +474,21 @@ nfs_fill_super(struct super_block *sb, s
 			server->namelen = NFS2_MAXNAMLEN;
 	}
 
+#ifdef CONFIG_NFS_CACHEFS
+	/* create a cache index for looking up filehandles */
+	server->cachefs = NULL;
+	if (server->flags & NFS_MOUNT_CACHEFS) {
+		server->cachefs = cachefs_acquire_cookie(nfs_cache_netfs.primary_index,
+			       &nfs_cache_fh_index_def, server);
+		if (server->cachefs == NULL) {
+			server->flags &= ~NFS_MOUNT_CACHEFS;
+			printk(KERN_WARNING "NFS: No CacheFS cookie. Turning CacheFS off!\n");
+		}
+		dfprintk(PAGECACHE,"NFS: cookie (0x%p/0x%p/0x%p)\n", 
+			sb, server, server->cachefs);
+	}
+#endif
+
 	sb->s_op = &nfs_sops;
 	return nfs_sb_init(sb, authflavor);
 }
@@ -518,7 +545,7 @@ static int nfs_show_options(struct seq_f
 	} nfs_info[] = {
 		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
 		{ NFS_MOUNT_INTR, ",intr", "" },
-		{ NFS_MOUNT_POSIX, ",posix", "" },
+		{ NFS_MOUNT_POSIX, ",cachefs", "" },
 		{ NFS_MOUNT_TCP, ",tcp", ",udp" },
 		{ NFS_MOUNT_NOCTO, ",nocto", "" },
 		{ NFS_MOUNT_NOAC, ",noac", "" },
@@ -568,6 +595,17 @@ nfs_zap_caches(struct inode *inode)
 		nfsi->flags |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
 	else
 		nfsi->flags |= NFS_INO_INVALID_ATTR;
+
+#ifdef CONFIG_NFS_CACHEFS
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS) {
+		dfprintk(PAGECACHE,"NFS: zapping cookie (0x%p/0x%p/0x%p)\n",
+			inode, nfsi, nfsi->cachefs);
+
+		cachefs_relinquish_cookie(nfsi->cachefs, 1);
+		nfsi->cachefs = NULL;
+	}
+#endif
+
 }
 
 /*
@@ -705,6 +743,17 @@ nfs_fhget(struct super_block *sb, struct
 		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->cache_access.cred = NULL;
 
+#ifdef CONFIG_NFS_CACHEFS
+{
+		struct nfs_server *server = NFS_SB(sb);
+		if (server->flags & NFS_MOUNT_CACHEFS) {
+			nfsi->cachefs = cachefs_acquire_cookie(server->cachefs, NULL, nfsi);
+			/* XXX: Add warning when NULL is returned */
+			dprintk("NFS: fhget new cookie (0x%p/0x%p/0x%p)\n", 
+				sb, nfsi, nfsi->cachefs);
+		}
+}
+#endif
 		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
@@ -1009,6 +1058,19 @@ __nfs_revalidate_inode(struct nfs_server
 				(long long)NFS_FILEID(inode));
 		/* This ensures we revalidate dentries */
 		nfsi->cache_change_attribute++;
+
+#ifdef CONFIG_NFS_CACHEFS
+		if (server->flags & NFS_MOUNT_CACHEFS) {
+			struct cachefs_cookie *old =  nfsi->cachefs;
+
+			/* retire the current cachefs cache and get a new one */
+			cachefs_relinquish_cookie(nfsi->cachefs, 1);
+			nfsi->cachefs = cachefs_acquire_cookie(server->cachefs, NULL, nfsi);
+			dfprintk(PAGECACHE,
+				"NFS: revalidation new cookie (0x%p/0x%p/0x%p/0x%p)\n",
+				server, nfsi, old, nfsi->cachefs);
+		}
+#endif
 	}
 	dfprintk(PAGECACHE, "NFS: (%s/%Ld) revalidation complete\n",
 		inode->i_sb->s_id,
@@ -1417,6 +1479,14 @@ static struct super_block *nfs_get_sb(st
 		return ERR_PTR(-EINVAL);
 	}
 
+#ifndef CONFIG_NFS_CACHEFS
+	if (data->flags & NFS_MOUNT_CACHEFS) {
+		printk(KERN_WARNING "NFS: kernel not compiled with CONFIG_NFS_CACHEFS\n");
+		kfree(server);
+		return ERR_PTR(-EINVAL);
+	}
+#endif
+
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
 
 	if (IS_ERR(s) || s->s_root) {
@@ -1449,6 +1519,14 @@ static void nfs_kill_super(struct super_
 
 	kill_anon_super(s);
 
+#ifdef CONFIG_NFS_CACHEFS
+	if (server->flags & NFS_MOUNT_CACHEFS) {
+		dfprintk(PAGECACHE,"NFS: killing cookie (0x%p/0x%p/0x%p)\n",
+			NFS_SB(s), server, server->cachefs);
+		cachefs_relinquish_cookie(server->cachefs, 0);
+	}
+#endif
+
 	nfs4_renewd_prepare_shutdown(server);
 
 	if (server->client != NULL && !IS_ERR(server->client))
@@ -1768,6 +1846,20 @@ static struct super_block *nfs4_get_sb(s
 		s = ERR_PTR(-EIO);
 		goto out_free;
 	}
+#ifdef CONFIG_NFS_CACHEFS
+	/* create a cache index for looking up filehandles */
+	server->cachefs = NULL;
+	if (server->flags & NFS_MOUNT_CACHEFS) {
+		server->cachefs = cachefs_acquire_cookie(nfs_cache_netfs.primary_index,
+			       &nfs_cache_fh_index_def, server);
+		if (server->cachefs == NULL) {
+			server->flags &= ~NFS_MOUNT_CACHEFS;
+			printk(KERN_WARNING "NFS: No CacheFS cookie. Turning CacheFS off!\n");
+		}
+		dfprintk(PAGECACHE,"NFS: nfs4 cookie (0x%p/0x%p/0x%p)\n", 
+			s, server, server->cachefs);
+	}
+#endif
 
 	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
@@ -1888,6 +1980,14 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+#ifdef CONFIG_NFS_CACHEFS
+	/* we want to be able to cache */
+	err = cachefs_register_netfs(&nfs_cache_netfs,
+				     &nfs_cache_server_index_def);
+	if (err < 0)
+		goto out5;
+#endif
+
 	err = nfs_init_nfspagecache();
 	if (err)
 		goto out4;
@@ -1923,6 +2023,10 @@ out2:
 out3:
 	nfs_destroy_nfspagecache();
 out4:
+#ifdef CONFIG_NFS_CACHEFS
+	cachefs_unregister_netfs(&nfs_cache_netfs);
+out5:
+#endif
 	return err;
 }
 
@@ -1932,6 +2036,9 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_readpagecache();
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
+#ifdef CONFIG_NFS_CACHEFS
+	cachefs_unregister_netfs(&nfs_cache_netfs);
+#endif
 #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
 #endif
--- 2.6.9-rc3-mm2/fs/nfs/Makefile.orig	2004-10-04 09:32:20.491019000 -0400
+++ 2.6.9-rc3-mm2/fs/nfs/Makefile	2004-10-04 11:02:34.783245000 -0400
@@ -12,4 +12,5 @@ nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4x
 			   delegation.o idmap.o \
 			   callback.o callback_xdr.o callback_proc.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
+nfs-$(CONFIG_NFS_CACHEFS) += nfs-cachefs.o
 nfs-objs		:= $(nfs-y)
--- /dev/null	2004-02-23 16:02:56.000000000 -0500
+++ 2.6.9-rc3-mm2/fs/nfs/nfs-cachefs.c	2004-10-04 11:02:34.793243000 -0400
@@ -0,0 +1,193 @@
+/* nfs-cachefs.c: NFS CacheFS interface
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
+
+#include "nfs-cachefs.h"
+
+#define NFS_CACHE_FH_INDEX_SIZE sizeof(struct nfs_fh)
+
+/*
+ * the root index is
+ */
+static struct cachefs_page *nfs_cache_get_page_cookie(struct page *page);
+
+static struct cachefs_netfs_operations nfs_cache_ops = {
+	.get_page_cookie	= nfs_cache_get_page_cookie,
+};
+
+struct cachefs_netfs nfs_cache_netfs = {
+	.name			= "nfs",
+	.version		= 0,
+	.ops			= &nfs_cache_ops,
+};
+
+/*
+ * the root index for the filesystem is defined by nfsd IP address and ports
+ */
+static cachefs_match_val_t nfs_cache_server_match(void *target,
+						  const void *entry);
+static void nfs_cache_server_update(void *source, void *entry);
+
+struct cachefs_index_def nfs_cache_server_index_def = {
+	.name			= "server",
+	.data_size		= 18,
+	.keys[0]		= { CACHEFS_INDEX_KEYS_IPV6ADDR, 16 },
+	.keys[1]		= { CACHEFS_INDEX_KEYS_BIN, 2 },
+	.match			= nfs_cache_server_match,
+	.update			= nfs_cache_server_update,
+};
+
+/*
+ * the primary index for each server is simply made up of a series of NFS file
+ * handles
+ */
+static cachefs_match_val_t nfs_cache_fh_match(void *target, const void *entry);
+static void nfs_cache_fh_update(void *source, void *entry);
+
+struct cachefs_index_def nfs_cache_fh_index_def = {
+	.name			= "fh",
+	.data_size		= NFS_CACHE_FH_INDEX_SIZE,
+	.keys[0]		= { CACHEFS_INDEX_KEYS_BIN,
+				    sizeof(struct nfs_fh) },
+	.match			= nfs_cache_fh_match,
+	.update			= nfs_cache_fh_update,
+};
+
+/*
+ * get a page cookie for the specified page
+ * - the cookie will be attached to page->private and PG_private will be set on
+ *   the page
+ */
+static struct cachefs_page *nfs_cache_get_page_cookie(struct page *page)
+{
+	struct cachefs_page *page_cookie;
+
+	page_cookie =  cachefs_page_get_private(page, GFP_NOIO);
+
+	return page_cookie;
+}
+
+static const uint8_t nfs_cache_ipv6_wrapper_for_ipv4[12] = {
+	[0 ... 9]	= 0x00,
+	[10 ... 11]	= 0xff
+};
+
+/*
+ * match a server record obtained from the cache
+ */
+static cachefs_match_val_t nfs_cache_server_match(void *target,
+						  const void *entry)
+{
+	struct nfs_server *server = target;
+	const uint8_t *data = entry;
+
+	switch (server->addr.sin_family) {
+	case AF_INET:
+		if (memcmp(data + 0,
+			   &nfs_cache_ipv6_wrapper_for_ipv4,
+			   12) != 0)
+			return CACHEFS_MATCH_FAILED;
+
+		if (memcmp(data + 12, &server->addr.sin_addr, 4) != 0)
+			return CACHEFS_MATCH_FAILED;
+
+		if (memcmp(data + 16, &server->addr.sin_port, 2) != 0)
+			return CACHEFS_MATCH_FAILED;
+
+		return CACHEFS_MATCH_SUCCESS;
+
+	case AF_INET6:
+		if (memcmp(data + 0, &server->addr.sin_addr, 16) != 0)
+			return CACHEFS_MATCH_FAILED;
+
+		if (memcmp(data + 16, &server->addr.sin_port, 2) != 0)
+			return CACHEFS_MATCH_FAILED;
+
+		return CACHEFS_MATCH_SUCCESS;
+
+	default:
+		return CACHEFS_MATCH_FAILED;
+	}
+}
+
+/*
+ * update a server record in the cache
+ */
+static void nfs_cache_server_update(void *source, void *entry)
+{
+	struct nfs_server *server = source;
+	uint8_t *data = entry;
+
+	switch (server->addr.sin_family) {
+	case AF_INET:
+		memcpy(data + 0, &nfs_cache_ipv6_wrapper_for_ipv4, 12);
+		memcpy(data + 12, &server->addr.sin_addr, 4);
+		memcpy(data + 16, &server->addr.sin_port, 2);
+		return;
+
+	case AF_INET6:
+		memcpy(data + 0, &server->addr.sin_addr, 16);
+		memcpy(data + 16, &server->addr.sin_port, 2);
+		return;
+
+	default:
+		return;
+	}
+}
+
+/*
+ * match a file handle record obtained from the cache
+ */
+static cachefs_match_val_t nfs_cache_fh_match(void *target, const void *entry)
+{
+	struct nfs_inode *nfsi = target;
+	const uint8_t *data = entry;
+	int loop;
+
+	/* check the file handle matches */
+	if (memcmp(data, &nfsi->fh, sizeof(nfsi->fh)) == 0) {
+
+		/* check the auxilliary data matches (if any) */
+		for (loop = sizeof(nfsi->fh);
+		     loop < NFS_CACHE_FH_INDEX_SIZE;
+		     loop++)
+			if (data[loop])
+				return CACHEFS_MATCH_FAILED;
+
+		return CACHEFS_MATCH_SUCCESS;
+	}
+
+	return CACHEFS_MATCH_FAILED;
+}
+
+/*
+ * update a fh record in the cache
+ */
+static void nfs_cache_fh_update(void *source, void *entry)
+{
+	struct nfs_inode *nfsi = source;
+	uint8_t *data = entry;
+
+	/* set the file handle */
+	memcpy(data, &nfsi->fh, sizeof(nfsi->fh));
+
+	/* just clear the auxilliary data for now */
+	memset(data + sizeof(nfsi->fh),
+	       0,
+	       NFS_CACHE_FH_INDEX_SIZE - sizeof(nfsi->fh));
+}
--- /dev/null	2004-02-23 16:02:56.000000000 -0500
+++ 2.6.9-rc3-mm2/fs/nfs/nfs-cachefs.h	2004-10-04 11:02:34.802243000 -0400
@@ -0,0 +1,27 @@
+/* nfs-cachefs.h: NFS CacheFS interface definitions
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
+#ifndef _NFS_CACHEFS_H
+#define _NFS_CACHEFS_H
+
+#include <linux/cachefs.h>
+
+#ifdef CONFIG_NFS_CACHEFS
+#ifndef CONFIG_CACHEFS
+#error "CONFIG_NFS_CACHEFS is defined but not CONFIG_CACHEFS"
+#endif
+
+extern struct cachefs_netfs nfs_cache_netfs;
+extern struct cachefs_index_def nfs_cache_server_index_def;
+extern struct cachefs_index_def nfs_cache_fh_index_def;
+
+#endif
+#endif /* _NFS_CACHEFS_H */
--- 2.6.9-rc3-mm2/fs/nfs/read.c.orig	2004-10-04 09:32:20.619019000 -0400
+++ 2.6.9-rc3-mm2/fs/nfs/read.c	2004-10-04 11:02:34.810243000 -0400
@@ -28,6 +28,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
+#include <linux/nfs_mount.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
@@ -88,6 +89,47 @@ int nfs_return_empty_page(struct page *p
 	return 0;
 }
 
+#ifdef CONFIG_NFS_CACHEFS
+/*
+ * Store a newly fetched page in cachefs
+ */
+static void
+nfs_readpage_to_cachefs_complete(void *cookie_data, struct page *page, void *data, int error)
+{
+	dprintk("NFS:     readpage_to_cachefs_complete (%p/%p/%p/%d)\n",
+		cookie_data, page, data, error);
+
+	end_page_fs_misc(page);
+}
+
+static inline void
+nfs_readpage_to_cachefs(struct inode *inode, struct page *page, int sync)
+{
+	int ret;
+
+	dprintk("NFS: readpage_to_cachefs(0x%p/0x%p/0x%p/%d)\n", 
+		NFS_I(inode)->cachefs, page, inode, sync);
+
+	SetPageFsMisc(page);
+	ret = cachefs_write_page(NFS_I(inode)->cachefs, page, 
+		nfs_readpage_to_cachefs_complete, NULL, GFP_KERNEL);
+	if (ret != 0) {
+		dprintk("NFS:     readpage_to_cachefs: error %d\n", ret);
+		cachefs_uncache_page(NFS_I(inode)->cachefs, page);
+		ClearPageFsMisc(page);
+	}
+
+	unlock_page(page);
+}
+#else
+static inline void
+nfs_readpage_to_cachefs(struct inode *inode, struct page *page, int sync)
+{
+	BUG();
+}
+#endif
+
+
 /*
  * Read a page synchronously.
  */
@@ -164,6 +206,13 @@ static int nfs_readpage_sync(struct nfs_
 		ClearPageError(page);
 	result = 0;
 
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS)
+		nfs_readpage_to_cachefs(inode, page, 1);
+	else
+		unlock_page(page);
+
+	return result;
+
 io_error:
 	unlock_page(page);
 	nfs_readdata_free(rdata);
@@ -196,7 +245,13 @@ static int nfs_readpage_async(struct nfs
 
 static void nfs_readpage_release(struct nfs_page *req)
 {
-	unlock_page(req->wb_page);
+	struct inode *d_inode = req->wb_context->dentry->d_inode;
+
+	if ((NFS_SERVER(d_inode)->flags & NFS_MOUNT_CACHEFS) && 
+			PageUptodate(req->wb_page))
+		nfs_readpage_to_cachefs(d_inode, req->wb_page, 0);
+	else
+		unlock_page(req->wb_page);
 
 	nfs_clear_request(req);
 	nfs_release_request(req);
@@ -494,6 +549,64 @@ void nfs_readpage_result(struct rpc_task
 	data->complete(data, status);
 }
 
+
+/*
+ * Read a page through the on-disc cache if possible
+ */
+#ifdef CONFIG_NFS_CACHEFS
+static void
+nfs_readpage_from_cachefs_complete(void *cookie_data, struct page *page, void *data, int error)
+{
+	dprintk("NFS: readpage_from_cachefs_complete (0x%p/0x%p/0x%p/%d)\n", 
+		cookie_data, page, data, error);
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
+nfs_readpage_from_cachefs(struct inode *inode, struct page *page)
+{
+	struct cachefs_page *pageio;
+	int ret;
+
+	dprintk("NFS: readpage_from_cachefs(0x%p/0x%p/0x%p)\n", 
+		NFS_I(inode)->cachefs, page, inode);
+
+	pageio = cachefs_page_get_private(page, GFP_NOIO);
+	if (IS_ERR(pageio)) {
+		dprintk("NFS:     cachefs_page_get_private error %ld\n", PTR_ERR(pageio));
+		return PTR_ERR(pageio);
+	}
+
+	ret = cachefs_read_or_alloc_page(NFS_I(inode)->cachefs,
+					 page,
+					 nfs_readpage_from_cachefs_complete,
+					 NULL,
+					 GFP_KERNEL);
+
+	switch (ret) {
+	case 1: /* read BIO submitted and wb-journal entry found */
+		BUG();
+		
+	case 0: /* read BIO submitted (page in cachefs) */
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dprintk("NFS:     cachefs_read_or_alloc_page error %d\n", ret);
+		return 1;
+
+	default:
+		return ret;
+	}
+}
+#endif
+
 /*
  * Read a page over NFS.
  * We read the page synchronously in the following case:
@@ -527,6 +640,13 @@ int nfs_readpage(struct file *file, stru
 		ctx = get_nfs_open_context((struct nfs_open_context *)
 				file->private_data);
 	if (!IS_SYNC(inode)) {
+		if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS) {
+			error = nfs_readpage_from_cachefs(inode, page);
+			if (error < 0)
+				goto out_error;
+			if (error == 0) /* found it */
+				return error;
+		}
 		error = nfs_readpage_async(ctx, inode, page);
 		goto out;
 	}
@@ -555,8 +675,21 @@ readpage_async_filler(void *data, struct
 	struct inode *inode = page->mapping->host;
 	struct nfs_page *new;
 	unsigned int len;
+	int error;
 
 	nfs_wb_page(inode, page);
+
+#ifdef CONFIG_NFS_CACHEFS
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS) {
+		error = nfs_readpage_from_cachefs(inode, page);
+		if (error < 0)
+			return error;
+		if (error == 0) {
+			return error;
+		}
+	}
+#endif
+
 	len = nfs_page_length(inode, page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
--- 2.6.9-rc3-mm2/fs/nfs/write.c.orig	2004-10-04 09:32:20.629020000 -0400
+++ 2.6.9-rc3-mm2/fs/nfs/write.c	2004-10-04 11:02:34.820244000 -0400
@@ -273,6 +273,38 @@ static int wb_priority(struct writeback_
 }
 
 /*
+ * store an updated page in cachefs
+ */
+#ifdef CONFIG_NFS_CACHEFS
+static void
+nfs_writepage_to_cachefs_complete(void *cookie_data, struct page *page, void *data, int error)
+{
+	/* really need to synchronise the end of writeback, probably using a page flag */
+}
+static inline void
+nfs_writepage_to_cachefs(struct inode *inode, struct page *page)
+{
+	int ret;
+
+	dprintk("NFS: writepage_to_cachefs (0x%p/0x%p/0x%p)\n", 
+		NFS_I(inode)->cachefs, page, inode);
+
+	ret = cachefs_write_page(NFS_I(inode)->cachefs, page,
+		nfs_writepage_to_cachefs_complete, NULL, GFP_KERNEL);
+	if (ret != 0 ) {
+		dprintk("NFS:    cachefs_write_page error %d\n", ret);
+		cachefs_uncache_page(NFS_I(inode)->cachefs, page);
+	}
+}
+#else
+static inline void
+nfs_writepage_to_cachefs(struct inode *inode, struct page *page)
+{
+	BUG();
+}
+#endif
+
+/*
  * Write an mmapped page to the server.
  */
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -317,6 +349,10 @@ do_it:
 		err = -EBADF;
 		goto out;
 	}
+
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_CACHEFS)
+		nfs_writepage_to_cachefs(inode, page);
+
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
@@ -1322,6 +1358,7 @@ nfs_commit_done(struct rpc_task *task)
 			(long long)NFS_FILEID(req->wb_context->dentry->d_inode),
 			req->wb_bytes,
 			(long long)req_offset(req));
+
 		if (task->tk_status < 0) {
 			req->wb_context->error = task->tk_status;
 			nfs_inode_remove_request(req);
--- 2.6.9-rc3-mm2/fs/Kconfig.orig	2004-10-04 09:32:57.727132000 -0400
+++ 2.6.9-rc3-mm2/fs/Kconfig	2004-10-04 11:02:34.836246000 -0400
@@ -1482,6 +1482,13 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_CACHEFS
+	bool "Provide NFS client caching support through CacheFS"
+	depends on NFS_FS && CACHEFS && EXPERIMENTAL
+	help
+		Say Y here if you want NFS data to be cached locally on disc through
+		the CacheFS filesystem.
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files (EXPERIMENTAL)"
 	depends on NFS_FS && EXPERIMENTAL

--------------010302040005050904090208--
