Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVKNXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVKNXsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKNXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:48:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932244AbVKNXsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:48:11 -0500
Message-ID: <43792217.7030102@RedHat.com>
Date: Mon, 14 Nov 2005 18:47:35 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] FS-Cache: Make NFS use FS-Cache
References: <dhowells1132005277@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------000202010001030507030403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202010001030507030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000202010001030507030403
Content-Type: text/x-patch;
 name="linux-2.6.14-mm2-fscache-nfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.14-mm2-fscache-nfs.patch"

Here is a NFS patch that incorporates the FS-Cache hooks. The
caching is done on a per filesystem bases using the new 
-o fsc mount flag (i.e mount -o fsc server:/export /mnt/export)

Note: the util-linux rpm that support this option are currently 
available at people.redhat.com/steved/cachefs/util-linux but 
will also be available in the upcoming Fedora Core release

Note2: FSCACHE_WRITE_SUPPORT is not defined which means,
for now, only read side caching is support. This does NOT means 
filesystems have to be mounted read only. What it does mean
is only reads will be cached locally, writes will not.

Signed-Off-By: Steve Dickson <steved@redhat.com>
---------------------------------------------

--- 2.6.14-mm2/fs/nfs/write.c.nfs	2005-11-14 18:09:56.000000000 -0500
+++ 2.6.14-mm2/fs/nfs/write.c	2005-11-14 18:28:45.000000000 -0500
@@ -64,6 +64,8 @@
 
 #include "delegation.h"
 
+#include "nfs-fscache.h"
+
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
 #define MIN_POOL_WRITE		(32)
@@ -123,6 +125,9 @@ static void nfs_grow_file(struct page *p
 	if (i_size >= end)
 		return;
 	i_size_write(inode, end);
+#ifdef FSCACHE_WRITE_SUPPORT
+	nfs_set_fscsize(NFS_SERVER(inode), NFS_I(inode), end);
+#endif
 }
 
 /* We can set the PG_uptodate flag if we see that a write request
@@ -255,6 +260,47 @@ static int wb_priority(struct writeback_
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
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_FSCACHE))
+		return;
+
+	if (PagePrivate(page)) {
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
+	BUG_ON(PagePrivate(page));
+}
+#endif
+
+/*
  * Write an mmapped page to the server.
  */
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -299,6 +345,9 @@ do_it:
 		err = -EBADF;
 		goto out;
 	}
+#ifdef FSCACHE_WRITE_SUPPORT
+	nfs_writepage_to_fscache(inode, page);
+#endif
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
--- 2.6.14-mm2/fs/nfs/file.c.nfs	2005-11-14 18:09:56.000000000 -0500
+++ 2.6.14-mm2/fs/nfs/file.c	2005-11-14 18:26:31.000000000 -0500
@@ -27,9 +27,11 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include "nfs-fscache.h"
 
 #include "delegation.h"
 
@@ -252,6 +254,19 @@ nfs_file_sendfile(struct file *filp, lof
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
@@ -265,6 +280,12 @@ nfs_file_mmap(struct file * file, struct
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
 
@@ -316,6 +337,11 @@ static int nfs_commit_write(struct file 
 	return status;
 }
 
+/*
+ * since we use page->private for our own nefarious purposes when using fscache, we have to
+ * override extra address space ops to prevent fs/buffer.c from getting confused, even though we
+ * may not have asked its opinion
+ */
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -327,6 +353,11 @@ struct address_space_operations nfs_file
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
--- 2.6.14-mm2/fs/nfs/inode.c.nfs	2005-11-14 18:09:56.000000000 -0500
+++ 2.6.14-mm2/fs/nfs/inode.c	2005-11-14 18:14:09.000000000 -0500
@@ -42,6 +42,8 @@
 #include "nfs4_fs.h"
 #include "delegation.h"
 
+#include "nfs-fscache.h"
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
@@ -171,6 +173,8 @@ nfs_clear_inode(struct inode *inode)
 	cred = nfsi->cache_access.cred;
 	if (cred)
 		put_rpccred(cred);
+
+	nfs_clear_fscookie(NFS_SERVER(inode), nfsi);
 	BUG_ON(atomic_read(&nfsi->data_updates) != 0);
 }
 
@@ -524,6 +528,9 @@ nfs_fill_super(struct super_block *sb, s
 			server->namelen = NFS2_MAXNAMLEN;
 	}
 
+	if (server->flags & NFS_MOUNT_FSCACHE)
+		nfs_fill_fscookie(sb);
+
 	sb->s_op = &nfs_sops;
 	return nfs_sb_init(sb, authflavor);
 }
@@ -599,6 +606,7 @@ static int nfs_show_options(struct seq_f
 		{ NFS_MOUNT_NOAC, ",noac", "" },
 		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
 		{ NFS_MOUNT_NOACL, ",noacl", "" },
+		{ NFS_MOUNT_FSCACHE, ",fsc", "" },
 		{ 0, NULL, NULL }
 	};
 	struct proc_nfs_info *nfs_infop;
@@ -661,6 +669,8 @@ nfs_zap_caches(struct inode *inode)
 		nfsi->cache_validity |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ACL|NFS_INO_REVAL_PAGECACHE;
 
 	spin_unlock(&inode->i_lock);
+
+	nfs_zap_fscookie(NFS_SERVER(inode), nfsi);
 }
 
 static void nfs_zap_acl_cache(struct inode *inode)
@@ -811,6 +821,8 @@ nfs_fhget(struct super_block *sb, struct
 		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->cache_access.cred = NULL;
 
+		nfs_fhget_fscookie(sb, nfsi);
+
 		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
@@ -892,6 +904,7 @@ void nfs_setattr_update_inode(struct ino
 	}
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
 		inode->i_size = attr->ia_size;
+		nfs_set_fscsize(NFS_SERVER(inode), NFS_I(inode), inode->i_size);
 		vmtruncate(inode, attr->ia_size);
 	}
 }
@@ -1207,6 +1220,8 @@ void nfs_revalidate_mapping(struct inode
 		}
 		spin_unlock(&inode->i_lock);
 
+		nfs_renew_fscookie(NFS_SERVER(inode), nfsi);
+
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
@@ -1444,11 +1459,13 @@ static int nfs_update_inode(struct inode
 			if (time_after_eq(verifier,  nfsi->cache_change_attribute)) {
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
 		dprintk("NFS: isize change on server for file %s/%ld\n",
 				inode->i_sb->s_id, inode->i_ino);
@@ -1647,6 +1664,15 @@ static struct super_block *nfs_get_sb(st
 		goto out_err;
 	}
 
+#ifndef CONFIG_NFS_FSCACHE
+	if (data->flags & NFS_MOUNT_FSCACHE) {
+		printk(KERN_WARNING \
+			"NFS: kernel not compiled with CONFIG_NFS_FSCACHE\n");
+		kfree(server);
+		return ERR_PTR(-EINVAL);
+	}
+#endif
+
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
 	if (IS_ERR(s) || s->s_root)
 		goto out_rpciod_down;
@@ -1674,6 +1700,8 @@ static void nfs_kill_super(struct super_
 
 	kill_anon_super(s);
 
+	nfs_kill_fscookie(server);
+
 	if (!IS_ERR(server->client))
 		rpc_shutdown_client(server->client);
 	if (!IS_ERR(server->client_sys))
@@ -1867,6 +1895,9 @@ static int nfs4_fill_super(struct super_
 	}
 
 	sb->s_time_gran = 1;
+	
+	if (server->flags & NFS4_MOUNT_FSCACHE)
+		nfs4_fill_fscookie(sb);
 
 	sb->s_op = &nfs4_sops;
 	err = nfs_sb_init(sb, authflavour);
@@ -2011,6 +2042,8 @@ static void nfs4_kill_super(struct super
 
 	nfs4_renewd_prepare_shutdown(server);
 
+	nfs_kill_fscookie(NFS_SB(sb));
+
 	if (server->client != NULL && !IS_ERR(server->client))
 		rpc_shutdown_client(server->client);
 	rpciod_down();		/* release rpciod */
@@ -2126,6 +2159,11 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	/* we want to be able to cache */
+	err = nfs_register_netfs();
+	if (err < 0)
+		goto out5;
+
 	err = nfs_init_nfspagecache();
 	if (err)
 		goto out4;
@@ -2173,6 +2211,9 @@ out2:
 out3:
 	nfs_destroy_nfspagecache();
 out4:
+	nfs_unregister_netfs();
+out5:
+
 	return err;
 }
 
@@ -2185,6 +2226,7 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_readpagecache();
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
+	nfs_unregister_netfs();
 #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
 #endif
--- 2.6.14-mm2/fs/nfs/Makefile.nfs	2005-10-27 20:02:08.000000000 -0400
+++ 2.6.14-mm2/fs/nfs/Makefile	2005-11-14 18:14:09.000000000 -0500
@@ -13,4 +13,5 @@ nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4x
 			   delegation.o idmap.o \
 			   callback.o callback_xdr.o callback_proc.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
+nfs-$(CONFIG_NFS_FSCACHE) += nfs-fscache.o
 nfs-objs		:= $(nfs-y)
--- /dev/null	2005-11-14 02:17:40.732565424 -0500
+++ 2.6.14-mm2/fs/nfs/nfs-fscache.h	2005-11-14 18:26:48.000000000 -0500
@@ -0,0 +1,208 @@
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
+#include <linux/nfs_mount.h>
+#include <linux/nfs4_mount.h>
+#include <linux/fscache.h>
+
+#ifdef CONFIG_NFS_FSCACHE
+
+extern struct fscache_netfs nfs_cache_netfs;
+extern struct fscache_cookie_def nfs_cache_server_index_def;
+extern struct fscache_cookie_def nfs_cache_fh_index_def;
+
+extern int nfs_invalidatepage(struct page *, unsigned long);
+extern int nfs_releasepage(struct page *, int);
+extern int nfs_mkwrite(struct page *);
+
+static inline void
+nfs_set_fscsize(struct nfs_server *server, 
+	struct nfs_inode *nfsi, loff_t i_size)
+{
+	if (!(server->flags & NFS_MOUNT_FSCACHE))
+		return;
+
+	fscache_set_i_size(nfsi->fscache, i_size);
+
+	return;
+}
+static inline void
+nfs_renew_fscookie(struct nfs_server *server, struct nfs_inode *nfsi)
+{
+	struct fscache_cookie *old =  nfsi->fscache;
+
+	if (!(server->flags & NFS_MOUNT_FSCACHE)) {
+		nfsi->fscache = NULL;
+		return;
+	}
+
+	/* retire the current fscache cache and get a new one */
+	fscache_relinquish_cookie(nfsi->fscache, 1);
+	nfsi->fscache = fscache_acquire_cookie(server->fscache, 
+		&nfs_cache_fh_index_def, nfsi);
+	fscache_set_i_size(nfsi->fscache, nfsi->vfs_inode.i_size);
+
+	dfprintk(FSCACHE,
+		"NFS: revalidation new cookie (0x%p/0x%p/0x%p/0x%p)\n",
+		server, nfsi, old, nfsi->fscache);
+
+	return;
+}
+
+static inline void nfs4_fill_fscookie(struct super_block *sb)
+{
+	struct nfs_server *server = NFS_SB(sb);
+
+	if (!(server->flags & NFS4_MOUNT_FSCACHE)) {
+		server->fscache = NULL;
+		return;
+	}
+
+	/* create a cache index for looking up filehandles */
+	server->fscache = fscache_acquire_cookie(nfs_cache_netfs.primary_index,
+			       &nfs_cache_server_index_def, server);
+	if (server->fscache == NULL) {
+		printk(KERN_WARNING "NFS4: No Fscache cookie. Turning "
+				"Fscache off!\n");
+	} else {
+		/* reuse the NFS mount option */
+		server->flags |= NFS_MOUNT_FSCACHE;
+	}
+
+	dfprintk(FSCACHE,"NFS: nfs4 cookie (0x%p,0x%p/0x%p)\n",
+		sb, server, server->fscache);
+
+	return;
+}
+
+static inline void nfs_fill_fscookie(struct super_block *sb)
+{
+	struct nfs_server *server = NFS_SB(sb);
+
+	if (!(server->flags & NFS_MOUNT_FSCACHE)) {
+		server->fscache = NULL;
+		return;
+	}
+
+	/* create a cache index for looking up filehandles */
+	server->fscache = fscache_acquire_cookie(nfs_cache_netfs.primary_index,
+			&nfs_cache_server_index_def, server);
+	if (server->fscache == NULL) {
+		server->flags &= ~NFS_MOUNT_FSCACHE;
+		printk(KERN_WARNING "NFS: No Fscache cookie. Turning "
+			"Fscache off!\n");
+	}
+	dfprintk(FSCACHE,"NFS: cookie (0x%p/0x%p/0x%p)\n",
+		sb, server, server->fscache);
+
+	return;
+}
+
+static inline void
+nfs_fhget_fscookie(struct super_block *sb, struct nfs_inode *nfsi)
+{
+	struct nfs_server *server = NFS_SB(sb);
+
+	if (!(server->flags & NFS_MOUNT_FSCACHE)) {
+		nfsi->fscache = NULL;
+		return;
+	}
+
+	nfsi->fscache = fscache_acquire_cookie(server->fscache, 
+		&nfs_cache_fh_index_def, nfsi);
+	if (server->fscache == NULL)
+		printk(KERN_WARNING "NFS: NULL FScache cookie: "
+				"sb 0x%p nfsi 0x%p\n", sb, nfsi);
+	fscache_set_i_size(nfsi->fscache, nfsi->vfs_inode.i_size);
+
+	dfprintk(FSCACHE, "NFS: fhget new cookie (0x%p/0x%p/0x%p)\n",
+		sb, nfsi, nfsi->fscache);
+
+	return;
+}
+
+static inline void nfs_kill_fscookie(struct nfs_server *server)
+{
+	if (!(server->flags & NFS_MOUNT_FSCACHE))
+		return;
+
+	dfprintk(FSCACHE,"NFS: killing cookie (0x%p/0x%p)\n",
+		server, server->fscache);
+
+	fscache_relinquish_cookie(server->fscache, 0);
+	server->fscache = NULL;
+
+	return;
+}
+
+static inline void nfs_clear_fscookie(
+	struct nfs_server *server, struct nfs_inode *nfsi)
+{
+	if (!(server->flags & NFS_MOUNT_FSCACHE))
+		return;
+
+	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n",
+			nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 0);
+	nfsi->fscache = NULL;
+
+	return;
+}
+
+static inline void nfs_zap_fscookie(
+	struct nfs_server *server, struct nfs_inode *nfsi)
+{
+	if (!(server->flags & NFS_MOUNT_FSCACHE))
+		return;
+
+	dfprintk(FSCACHE,"NFS: zapping cookie (0x%p/0x%p)\n",
+		nfsi, nfsi->fscache);
+
+	fscache_relinquish_cookie(nfsi->fscache, 1);
+	nfsi->fscache = NULL;
+
+	return;
+}
+
+static inline int nfs_register_netfs(void)
+{
+	int err;
+
+	err = fscache_register_netfs(&nfs_cache_netfs);
+
+	return err;
+}
+
+static inline void nfs_unregister_netfs(void)
+{
+	fscache_unregister_netfs(&nfs_cache_netfs);
+
+	return;
+}
+#else
+static inline void nfs_set_fscsize(struct nfs_server *server, struct nfs_inode *nfsi, loff_t i_size) {}
+static inline void nfs_fill_fscookie(struct super_block *sb) {}
+static inline void nfs_fhget_fscookie(struct super_block *sb, struct nfs_inode *nfsi) {}
+static inline void nfs4_fill_fscookie(struct super_block *sb) {}
+static inline void nfs_kill_fscookie(struct nfs_server *server) {}
+static inline void nfs_clear_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void nfs_zap_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline void
+	nfs_renew_fscookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
+static inline int nfs_register_netfs(void) { return 0; }
+static inline void nfs_unregister_netfs(void) {}
+
+#endif
+#endif /* _NFS_FSCACHE_H */
--- 2.6.14-mm2/fs/nfs/read.c.nfs	2005-11-14 18:09:56.000000000 -0500
+++ 2.6.14-mm2/fs/nfs/read.c	2005-11-14 18:26:57.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
+#include <linux/nfs_mount.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
@@ -73,6 +74,50 @@ int nfs_return_empty_page(struct page *p
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
+		ClearPagePrivate(page);
+		end_page_fs_misc(page);
+	}
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
@@ -151,6 +196,14 @@ static int nfs_readpage_sync(struct nfs_
 		ClearPageError(page);
 	result = 0;
 
+#ifdef CONFIG_NFS_FSCACHE
+	if (PagePrivate(page))
+		nfs_readpage_to_fscache(inode, page, 1);
+#endif
+	unlock_page(page);
+
+	return result;
+
 io_error:
 	unlock_page(page);
 	nfs_readdata_free(rdata);
@@ -182,6 +235,12 @@ static int nfs_readpage_async(struct nfs
 
 static void nfs_readpage_release(struct nfs_page *req)
 {
+#ifdef CONFIG_NFS_FSCACHE
+	struct inode *d_inode = req->wb_context->dentry->d_inode;
+
+	if (PagePrivate(req->wb_page) && PageUptodate(req->wb_page))
+		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
+#endif
 	unlock_page(req->wb_page);
 
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",
@@ -481,6 +540,109 @@ void nfs_readpage_result(struct rpc_task
 	data->complete(data, status);
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
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_FSCACHE))
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
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: BIO submitted\n");
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache error %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
+		return ret;
+	}
+}
+
+static inline
+int nfs_getpages_from_fscache(struct inode *inode,
+	struct address_space *mapping,
+	struct list_head *pages,
+	unsigned *nr_pages)
+{
+	int ret;
+
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_FSCACHE))
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
+		dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache: BIO submitted\n");
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache: error %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
+		return ret;
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
@@ -514,6 +676,11 @@ int nfs_readpage(struct file *file, stru
 		ctx = get_nfs_open_context((struct nfs_open_context *)
 				file->private_data);
 	if (!IS_SYNC(inode)) {
+		error = nfs_readpage_from_fscache(inode, page);
+		if (error < 0)
+			goto out_error;
+		if (error == 0)
+			return error;
 		error = nfs_readpage_async(ctx, inode, page);
 		goto out;
 	}
@@ -544,6 +711,7 @@ readpage_async_filler(void *data, struct
 	unsigned int len;
 
 	nfs_wb_page(inode, page);
+
 	len = nfs_page_length(inode, page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
@@ -575,6 +743,15 @@ int nfs_readpages(struct file *filp, str
 			(long long)NFS_FILEID(inode),
 			nr_pages);
 
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
@@ -617,3 +794,51 @@ void nfs_destroy_readpagecache(void)
 	if (kmem_cache_destroy(nfs_rdata_cachep))
 		printk(KERN_INFO "nfs_read_data: not all structures were freed\n");
 }
+
+#ifdef CONFIG_NFS_FSCACHE
+int nfs_invalidatepage(struct page *page, unsigned long offset)
+{
+	int ret = 1;
+
+	BUG_ON(!PageLocked(page));
+
+	if (PagePrivate(page)) {
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
+			ret = 0;
+			if (!PageWriteback(page))
+				ret = page->mapping->a_ops->releasepage(page, 0);
+		}
+	} else
+		ret = 0;
+
+	return ret;
+}
+int nfs_releasepage(struct page *page, int gfp_flags)
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
+	ClearPagePrivate(page);
+	return 0;
+}
+int nfs_mkwrite(struct page *page)
+{
+	wait_on_page_fs_misc(page);
+	return 0;
+}
+#endif
--- /dev/null	2005-11-14 02:17:40.732565424 -0500
+++ 2.6.14-mm2/fs/nfs/nfs-fscache.c	2005-11-14 18:14:10.000000000 -0500
@@ -0,0 +1,154 @@
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
+
+#include "nfs-fscache.h"
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
+static uint16_t nfs_server_get_key(const void *cookie_netfs_data,
+		void *buffer, uint16_t bufmax)
+{
+	const struct nfs_server *server = cookie_netfs_data;
+	uint16_t len = 0;
+
+	switch (server->addr.sin_family) {
+	case AF_INET:
+		memcpy(buffer + 0, &nfs_cache_ipv6_wrapper_for_ipv4, 12);
+		memcpy(buffer + 12, &server->addr.sin_addr, 4);
+		memcpy(buffer + 16, &server->addr.sin_port, 2);
+		len = 18;
+		break;
+
+	case AF_INET6:
+		memcpy(buffer + 0, &server->addr.sin_addr, 16);
+		memcpy(buffer + 16, &server->addr.sin_port, 2);
+		len = 18;
+		break;
+
+	default:
+		len =0;
+		printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
+			server->addr.sin_family);
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
+	unsigned long loop;
+
+	dprintk("NFS: nfs_fh_mark_pages_cached: nfs_inode 0x%p pages %ld\n", 
+		(struct nfs_inode *)cookie_netfs_data, cached_pvec->nr);
+
+	for (loop = 0; loop < cached_pvec->nr; loop++)
+		SetPagePrivate(cached_pvec->pages[loop]);
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
+		nr_pages = find_get_pages(nfsi->vfs_inode.i_mapping, first,
+					  PAGEVEC_SIZE, pvec.pages);
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
--- 2.6.14-mm2/fs/Kconfig.nfs	2005-11-14 18:12:05.000000000 -0500
+++ 2.6.14-mm2/fs/Kconfig	2005-11-14 18:14:10.000000000 -0500
@@ -1492,6 +1492,13 @@ config NFS_V4
 
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
--- 2.6.14-mm2/include/linux/nfs_fs_sb.h.nfs	2005-10-27 20:02:08.000000000 -0400
+++ 2.6.14-mm2/include/linux/nfs_fs_sb.h	2005-11-14 18:14:10.000000000 -0500
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/backing-dev.h>
+#include <linux/fscache.h>
 
 /*
  * NFS client parameters stored in the superblock.
@@ -47,6 +48,10 @@ struct nfs_server {
 						   that are supported on this
 						   filesystem */
 #endif
+
+#ifdef CONFIG_NFS_FSCACHE
+	struct fscache_cookie	*fscache;	/* cache cookie */
+#endif
 };
 
 /* Server capabilities */
--- 2.6.14-mm2/include/linux/nfs_mount.h.nfs	2005-10-27 20:02:08.000000000 -0400
+++ 2.6.14-mm2/include/linux/nfs_mount.h	2005-11-14 18:14:10.000000000 -0500
@@ -61,6 +61,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_NOACL		0x0800	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
+#define NFS_MOUNT_FSCACHE	0x4000
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
--- 2.6.14-mm2/include/linux/nfs4_mount.h.nfs	2005-10-27 20:02:08.000000000 -0400
+++ 2.6.14-mm2/include/linux/nfs4_mount.h	2005-11-14 18:14:10.000000000 -0500
@@ -65,6 +65,7 @@ struct nfs4_mount_data {
 #define NFS4_MOUNT_NOCTO	0x0010	/* 1 */
 #define NFS4_MOUNT_NOAC		0x0020	/* 1 */
 #define NFS4_MOUNT_STRICTLOCK	0x1000	/* 1 */
+#define NFS4_MOUNT_FSCACHE	0x2000	/* 1 */
 #define NFS4_MOUNT_FLAGMASK	0xFFFF
 
 #endif
--- 2.6.14-mm2/include/linux/nfs_fs.h.nfs	2005-11-14 18:09:58.000000000 -0500
+++ 2.6.14-mm2/include/linux/nfs_fs.h	2005-11-14 18:14:10.000000000 -0500
@@ -29,6 +29,7 @@
 #include <linux/nfs_xdr.h>
 #include <linux/rwsem.h>
 #include <linux/mempool.h>
+#include <linux/fscache.h>
 
 /*
  * Enable debugging support for nfs client.
@@ -188,6 +189,9 @@ struct nfs_inode {
 	int			 delegation_state;
 	struct rw_semaphore	rwsem;
 #endif /* CONFIG_NFS_V4*/
+#ifdef CONFIG_NFS_FSCACHE
+	struct fscache_cookie	*fscache;
+#endif
 	struct inode		vfs_inode;
 };
 
@@ -587,6 +591,7 @@ extern void * nfs_root_data(void);
 #define NFSDBG_FILE		0x0040
 #define NFSDBG_ROOT		0x0080
 #define NFSDBG_CALLBACK		0x0100
+#define NFSDBG_FSCACHE		0x0200
 #define NFSDBG_ALL		0xFFFF
 
 #ifdef __KERNEL__

--------------000202010001030507030403--
