Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVCQQbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVCQQbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVCQQbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:31:09 -0500
Received: from citi.umich.edu ([141.211.133.111]:16935 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261953AbVCQQ0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:26:15 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: [PATCH 2/2] NFS: add I/O performance counters
Message-Id: <20050317162615.815EA1BB95@citi.umich.edu>
Date: Thu, 17 Mar 2005 11:26:15 -0500 (EST)
From: cel@citi.umich.edu (Chuck Lever)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Add an extensible per-superblock performance counter facility to the NFS
 client.  This facility mimics the counters available for block devices and
 for networking.

 Expose these new counters via /proc/self/mountstats.

 Version: Mon, 14 Mar 2005 17:06:12 -0500
 
 Signed-off-by: Chuck Lever <cel@netapp.com>
---
 
 fs/nfs/dir.c               |    8 ++
 fs/nfs/direct.c            |    5 +
 fs/nfs/file.c              |   20 +++--
 fs/nfs/inode.c             |  126 +++++++++++++++++++++++++++++++++++--
 fs/nfs/pagelist.c          |   12 ++-
 fs/nfs/read.c              |    7 ++
 fs/nfs/write.c             |   10 ++
 include/linux/nfs_fs_sb.h  |    5 +
 include/linux/nfs_iostat.h |   80 +++++++++++++++++++++++
 9 files changed, 256 insertions(+), 17 deletions(-)
 
 
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/dir.c 02-nfs-iostat/fs/nfs/dir.c
--- 01-mountstats/fs/nfs/dir.c	2005-03-02 02:38:09.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/dir.c	2005-03-14 15:28:34.011484000 -0500
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_mount.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
@@ -428,6 +429,8 @@ static int nfs_readdir(struct file *filp
 
 	lock_kernel();
 
+	nfs_inc_stats(inode, NFS_VFS_GETDENTS);
+
 	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (res < 0) {
 		unlock_kernel();
@@ -584,6 +587,7 @@ static int nfs_lookup_revalidate(struct 
 	parent = dget_parent(dentry);
 	lock_kernel();
 	dir = parent->d_inode;
+	nfs_inc_stats(dir, NFS_DENTRY_REVALIDATE);
 	inode = dentry->d_inode;
 
 	if (nd && !(nd->flags & LOOKUP_CONTINUE) && (nd->flags & LOOKUP_OPEN))
@@ -712,6 +716,7 @@ static struct dentry *nfs_lookup(struct 
 
 	dfprintk(VFS, "NFS: lookup(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
+	nfs_inc_stats(dir, NFS_VFS_LOOKUP);
 
 	res = ERR_PTR(-ENAMETOOLONG);
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
@@ -1116,6 +1121,7 @@ static int nfs_sillyrename(struct inode 
 	dfprintk(VFS, "NFS: silly-rename(%s/%s, ct=%d)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name, 
 		atomic_read(&dentry->d_count));
+	nfs_inc_stats(dir, NFS_SILLY_RENAME);
 
 #ifdef NFS_PARANOIA
 if (!dentry->d_inode)
@@ -1500,6 +1506,8 @@ int nfs_permission(struct inode *inode, 
 	struct rpc_cred *cred;
 	int res;
 
+	nfs_inc_stats(inode, NFS_VFS_ACCESS);
+
 	if (mask == 0)
 		return 0;
 
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/direct.c 02-nfs-iostat/fs/nfs/direct.c
--- 01-mountstats/fs/nfs/direct.c	2005-03-02 02:38:25.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/direct.c	2005-03-14 15:26:16.401349000 -0500
@@ -47,6 +47,7 @@
 #include <linux/kref.h>
 
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_page.h>
 #include <linux/sunrpc/clnt.h>
 
@@ -354,6 +355,8 @@ static ssize_t nfs_direct_read_seg(struc
 	result = nfs_direct_read_wait(dreq, clnt->cl_intr);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
+	nfs_add_stats(inode, NFS_WIRE_READ_BYTES, result);
+	nfs_add_stats(inode, NFS_DIRECT_READ_BYTES, result);
 	return result;
 }
 
@@ -576,6 +579,8 @@ static ssize_t nfs_direct_write(struct i
 		if (result < size)
 			break;
 	}
+	nfs_add_stats(inode, NFS_WIRE_WRITTEN_BYTES, tot_bytes);
+	nfs_add_stats(inode, NFS_DIRECT_WRITTEN_BYTES, tot_bytes);
 	return tot_bytes;
 }
 
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/file.c 02-nfs-iostat/fs/nfs/file.c
--- 01-mountstats/fs/nfs/file.c	2005-03-02 02:38:38.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/file.c	2005-03-14 15:42:52.446804000 -0500
@@ -22,6 +22,7 @@
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_mount.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -86,18 +87,15 @@ static int nfs_check_flags(int flags)
 static int
 nfs_file_open(struct inode *inode, struct file *filp)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
-	int (*open)(struct inode *, struct file *);
 	int res;
 
 	res = nfs_check_flags(filp->f_flags);
 	if (res)
 		return res;
 
+	nfs_inc_stats(inode, NFS_VFS_OPEN);
 	lock_kernel();
-	/* Do NFSv4 open() call */
-	if ((open = server->rpc_ops->file_open) != NULL)
-		res = open(inode, filp);
+	res = NFS_SERVER(inode)->rpc_ops->file_open(inode, filp);
 	unlock_kernel();
 	return res;
 }
@@ -105,6 +103,7 @@ nfs_file_open(struct inode *inode, struc
 static int
 nfs_file_release(struct inode *inode, struct file *filp)
 {
+	nfs_inc_stats(inode, NFS_VFS_CLOSE);
 	return NFS_PROTO(inode)->file_release(inode, filp);
 }
 
@@ -123,6 +122,7 @@ nfs_file_flush(struct file *file)
 
 	if ((file->f_mode & FMODE_WRITE) == 0)
 		return 0;
+	nfs_inc_stats(inode, NFS_VFS_FLUSH);
 	lock_kernel();
 	/* Ensure that data+attribute caches are up to date after close() */
 	status = nfs_wb_all(inode);
@@ -155,6 +155,7 @@ nfs_file_read(struct kiocb *iocb, char _
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (!result)
 		result = generic_file_aio_read(iocb, buf, count, pos);
+	nfs_add_stats(inode, NFS_SYS_READ_BYTES, result);
 	return result;
 }
 
@@ -206,6 +207,7 @@ nfs_fsync(struct file *file, struct dent
 
 	dfprintk(VFS, "nfs: fsync(%s/%ld)\n", inode->i_sb->s_id, inode->i_ino);
 
+	nfs_inc_stats(inode, NFS_VFS_FSYNC);
 	lock_kernel();
 	status = nfs_wb_all(inode);
 	if (!status) {
@@ -284,6 +286,7 @@ nfs_file_write(struct kiocb *iocb, const
 		goto out;
 
 	result = generic_file_aio_write(iocb, buf, count, pos);
+	nfs_add_stats(inode, NFS_SYS_WRITTEN_BYTES, result);
 out:
 	return result;
 
@@ -406,13 +409,14 @@ nfs_lock(struct file *filp, int cmd, str
 {
 	struct inode * inode = filp->f_mapping->host;
 
+	if (!inode)
+		return -EINVAL;
+
 	dprintk("NFS: nfs_lock(f=%s/%ld, t=%x, fl=%x, r=%Ld:%Ld)\n",
 			inode->i_sb->s_id, inode->i_ino,
 			fl->fl_type, fl->fl_flags,
 			(long long)fl->fl_start, (long long)fl->fl_end);
-
-	if (!inode)
-		return -EINVAL;
+	nfs_inc_stats(inode, NFS_VFS_LOCK);
 
 	/* No mandatory locks over NFS */
 	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/inode.c 02-nfs-iostat/fs/nfs/inode.c
--- 01-mountstats/fs/nfs/inode.c	2005-03-02 02:38:17.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/inode.c	2005-03-14 15:35:06.780119000 -0500
@@ -27,6 +27,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/lockd/bind.h>
@@ -63,6 +64,7 @@ static void nfs_clear_inode(struct inode
 static void nfs_umount_begin(struct super_block *);
 static int  nfs_statfs(struct super_block *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
+static int  nfs_show_stats(struct seq_file *, struct vfsmount *);
 
 static struct super_operations nfs_sops = { 
 	.alloc_inode	= nfs_alloc_inode,
@@ -73,6 +75,7 @@ static struct super_operations nfs_sops 
 	.clear_inode	= nfs_clear_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
+	.show_stats	= nfs_show_stats,
 };
 
 /*
@@ -268,6 +271,12 @@ nfs_sb_init(struct super_block *sb, rpc_
 	}
 	sb->s_root->d_op = server->rpc_ops->dentry_ops;
 
+	server->io_stats = nfs_alloc_iostats();
+	if (!server->io_stats) {
+		no_root_error = -ENOMEM;
+		goto out_no_root;
+	}
+
 	/* Get some general file system info */
 	if (server->namelen == 0 &&
 	    server->rpc_ops->pathconf(server, &server->fh, &pathinfo) >= 0)
@@ -350,6 +359,9 @@ nfs_create_client(struct nfs_server *ser
 	if (!timeparms.to_retries)
 		timeparms.to_retries = 5;
 
+	server->retrans_timeo = timeparms.to_initval;
+	server->retrans_count = timeparms.to_retries;
+
 	/* create transport and client */
 	xprt = xprt_create_proto(tcp ? IPPROTO_TCP : IPPROTO_UDP,
 				 &server->addr, &timeparms);
@@ -566,6 +578,96 @@ static int nfs_show_options(struct seq_f
 	return 0;
 }
 
+static int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
+{
+	int i, cpu;
+	static struct proc_nfs_info {
+		int flag;
+		char *str;
+		char *nostr;
+	} nfs_info[] = {
+		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
+		{ NFS_MOUNT_INTR, ",intr", ",nointr" },
+		{ NFS_MOUNT_TCP, ",tcp", ",udp" },
+		{ NFS_MOUNT_NOCTO, ",nocto", ",cto" },
+		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
+		{ 0, NULL, NULL }
+	};
+	struct proc_nfs_info *nfs_infop;
+	struct nfs_server *nfss = NFS_SB(mnt->mnt_sb);
+	struct rpc_auth *auth = nfss->client->cl_auth;
+	struct nfs_iostats *stats = nfss->io_stats;
+	struct nfs_iostats totals = { };
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for (i = 0; i < __NFS_IOSTAT_COUNTS_MAX; i++)
+			totals.counts[i] += stats[cpu].counts[i];
+		for (i = 0; i < __NFS_IOSTAT_BYTES_MAX; i++)
+			totals.bytes[i] += stats[cpu].bytes[i];
+	}
+
+	seq_printf(m, "statvers=%s", NFS_IOSTAT_VERS);
+
+	/*
+	 * Display all mount option settings
+	 * need ro/rw, sync/async
+	 */
+	seq_printf(m, "\n\topts:\t");
+	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? "ro" : "rw");
+	seq_puts(m, mnt->mnt_sb->s_flags & MS_SYNCHRONOUS ? ",sync" : ",async");
+
+	seq_printf(m, ",vers=%d", nfss->rpc_ops->version);
+	seq_printf(m, ",rsize=%d", nfss->rsize);
+	seq_printf(m, ",wsize=%d", nfss->wsize);
+	seq_printf(m, ",acregmin=%d", nfss->acregmin/HZ);
+	seq_printf(m, ",acregmax=%d", nfss->acregmax/HZ);
+	seq_printf(m, ",acdirmin=%d", nfss->acdirmin/HZ);
+	seq_printf(m, ",acdirmax=%d", nfss->acdirmax/HZ);
+	seq_printf(m, ",timeo=%lu", 10U * nfss->retrans_timeo / HZ);
+	seq_printf(m, ",retrans=%u", nfss->retrans_count);
+	for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
+		if (nfss->flags & nfs_infop->flag)
+			seq_puts(m, nfs_infop->str);
+		else
+			seq_puts(m, nfs_infop->nostr);
+	}
+
+	seq_printf(m, "\n\tcaps:\t");
+	seq_printf(m, "caps=0x%x", nfss->caps);
+	seq_printf(m, ",wtmult=%d", nfss->wtmult);
+	seq_printf(m, ",dtsize=%d", nfss->dtsize);
+	seq_printf(m, ",bsize=%d", nfss->bsize);
+	seq_printf(m, ",namelen=%d", nfss->namelen);
+
+#ifdef CONFIG_NFS_V4
+	if (nfss->rpc_ops->version == 4) {
+		seq_printf(m, "\n\tnfsv4:\t");
+		seq_printf(m, "bm0=0x%x", nfss->attr_bitmask[0]);
+		seq_printf(m, ",bm1=0x%x", nfss->attr_bitmask[1]);
+		seq_printf(m, ",acl=0x%x", nfss->acl_bitmask);
+	}
+#endif
+
+	/*
+	 * Display security flavor in effect for this mount
+	 */
+	seq_printf(m, "\n\tsec:\tflavor=%d", auth->au_ops->au_flavor);
+	if (auth->au_flavor)
+		seq_printf(m, ",pseudoflavor=%d", auth->au_flavor);
+
+	/*
+	 * Display superblock I/O counters
+	 */
+	seq_printf(m, "\n\tcounts:\t");
+	for (i = 0; i < __NFS_IOSTAT_COUNTS_MAX; i++)
+		seq_printf(m, "%lu ", totals.counts[i]);
+	seq_printf(m, "\n\tbytes:\t");
+	for (i = 0; i < __NFS_IOSTAT_BYTES_MAX; i++)
+		seq_printf(m, "%Lu ", totals.bytes[i]);
+
+	return 0;
+}
+
 /*
  * Invalidate the local caches
  */
@@ -797,14 +899,17 @@ nfs_wait_on_inode(struct inode *inode, i
 {
 	struct rpc_clnt	*clnt = NFS_CLIENT(inode);
 	struct nfs_inode *nfsi = NFS_I(inode);
+	unsigned long start = jiffies;
+	int error = 0;
 
-	int error;
-	if (!(NFS_FLAGS(inode) & flag))
-		return 0;
-	atomic_inc(&inode->i_count);
-	error = nfs_wait_event(clnt, nfsi->nfs_i_wait,
+	if ((NFS_FLAGS(inode) & flag)) {
+		atomic_inc(&inode->i_count);
+		error = nfs_wait_event(clnt, nfsi->nfs_i_wait,
 				!(NFS_FLAGS(inode) & flag));
-	iput(inode);
+		nfs_add_stats(inode, NFS_WAIT_EVENT_JIFFIES, (jiffies - start));
+		nfs_inc_stats(inode, NFS_WAIT_EVENT);
+		iput(inode);
+	}
 	return error;
 }
 
@@ -934,6 +1039,7 @@ int nfs_open(struct inode *inode, struct
 
 int nfs_release(struct inode *inode, struct file *filp)
 {
+	nfs_inc_stats(inode, NFS_VFS_CLOSE);
 	if ((filp->f_mode & FMODE_WRITE) != 0)
 		nfs_end_data_update(inode);
 	nfs_file_clear_open_context(filp);
@@ -1017,6 +1123,7 @@ __nfs_revalidate_inode(struct nfs_server
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
+		nfs_inc_stats(inode, NFS_DATA_INVALIDATE);
 		/* This ensures we revalidate dentries */
 		nfsi->cache_change_attribute++;
 	}
@@ -1050,6 +1157,7 @@ int nfs_attribute_timeout(struct inode *
  */
 int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
+	nfs_inc_stats(inode, NFS_INODE_REVALIDATE);
 	if (!(NFS_FLAGS(inode) & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA))
 			&& !nfs_attribute_timeout(inode))
 		return NFS_STALE(inode) ? -ESTALE : 0;
@@ -1310,6 +1418,7 @@ static int nfs_update_inode(struct inode
 	if (invalid & NFS_INO_INVALID_ATTR) {
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = jiffies;
+		nfs_inc_stats(inode, NFS_ATTR_INVALIDATE);
 	} else if (time_after(jiffies, nfsi->attrtimeo_timestamp+nfsi->attrtimeo)) {
 		if ((nfsi->attrtimeo <<= 1) > NFS_MAXATTRTIMEO(inode))
 			nfsi->attrtimeo = NFS_MAXATTRTIMEO(inode);
@@ -1490,6 +1599,7 @@ static struct super_operations nfs4_sops
 	.clear_inode	= nfs4_clear_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
+	.show_stats	= nfs_show_stats,
 };
 
 /*
@@ -1574,6 +1684,9 @@ static int nfs4_fill_super(struct super_
 		return -EINVAL;
 	}
 
+	server->retrans_timeo = timeparms.to_initval;
+	server->retrans_count = timeparms.to_retries;
+
 	clp = nfs4_get_client(&server->addr.sin_addr);
 	if (!clp) {
 		printk(KERN_WARNING "NFS: failed to create NFS4 client.\n");
@@ -1783,6 +1896,7 @@ out_free:
 		kfree(server->mnt_path);
 	if (server->hostname)
 		kfree(server->hostname);
+	nfs_free_iostats(server->io_stats);
 	kfree(server);
 	return s;
 }
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/pagelist.c 02-nfs-iostat/fs/nfs/pagelist.c
--- 01-mountstats/fs/nfs/pagelist.c	2005-03-02 02:38:26.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/pagelist.c	2005-03-14 15:26:16.434350000 -0500
@@ -17,6 +17,7 @@
 #include <linux/nfs4.h>
 #include <linux/nfs_page.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_mount.h>
 
 #define NFS_PARANOIA 1
@@ -192,10 +193,15 @@ nfs_wait_on_request(struct nfs_page *req
 {
 	struct inode	*inode = req->wb_context->dentry->d_inode;
         struct rpc_clnt	*clnt = NFS_CLIENT(inode);
+	unsigned long start = jiffies;
+	int result = 0;
 
-	if (!NFS_WBACK_BUSY(req))
-		return 0;
-	return nfs_wait_event(clnt, req->wb_context->waitq, !NFS_WBACK_BUSY(req));
+	if (NFS_WBACK_BUSY(req)) {
+		result = nfs_wait_event(clnt, req->wb_context->waitq, !NFS_WBACK_BUSY(req));
+		nfs_add_stats(inode, NFS_WAIT_EVENT_JIFFIES, (jiffies - start));
+		nfs_inc_stats(inode, NFS_WAIT_EVENT);
+	}
+	return result;
 }
 
 /**
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/read.c 02-nfs-iostat/fs/nfs/read.c
--- 01-mountstats/fs/nfs/read.c	2005-03-02 02:37:30.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/read.c	2005-03-14 15:26:16.441349000 -0500
@@ -26,6 +26,7 @@
 #include <linux/pagemap.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_page.h>
 #include <linux/smp_lock.h>
 
@@ -134,6 +135,7 @@ static int nfs_readpage_sync(struct nfs_
 		}
 		count -= result;
 		rdata->args.pgbase += result;
+		nfs_add_stats(inode, NFS_WIRE_READ_BYTES, result);
 		/* Note: result == 0 should only happen if we're caching
 		 * a write that extends the file and punches a hole.
 		 */
@@ -464,6 +466,7 @@ void nfs_readpage_result(struct rpc_task
 
 	/* Is this a short read? */
 	if (task->tk_status >= 0 && resp->count < argp->count && !resp->eof) {
+		nfs_inc_stats(data->inode, NFS_SHORT_READ);
 		/* Has the server at least made some progress? */
 		if (resp->count != 0) {
 			/* Yes, so retry the read at the end of the data */
@@ -477,6 +480,7 @@ void nfs_readpage_result(struct rpc_task
 	}
 	NFS_FLAGS(data->inode) |= NFS_INO_INVALID_ATIME;
 	data->complete(data, status);
+	nfs_add_stats(data->inode, NFS_WIRE_READ_BYTES, resp->count);
 }
 
 /*
@@ -493,6 +497,8 @@ int nfs_readpage(struct file *file, stru
 
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_CACHE_SIZE, page->index);
+	nfs_inc_stats(inode, NFS_VFS_READPAGE);
+
 	/*
 	 * Try to flush any pending writes to the file..
 	 *
@@ -573,6 +579,7 @@ int nfs_readpages(struct file *filp, str
 			inode->i_sb->s_id,
 			(long long)NFS_FILEID(inode),
 			nr_pages);
+	nfs_inc_stats(inode, NFS_VFS_READPAGES);
 
 	if (filp == NULL) {
 		desc.ctx = nfs_find_open_context(inode, FMODE_READ);
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/fs/nfs/write.c 02-nfs-iostat/fs/nfs/write.c
--- 01-mountstats/fs/nfs/write.c	2005-03-02 02:38:17.000000000 -0500
+++ 02-nfs-iostat/fs/nfs/write.c	2005-03-14 15:26:16.452349000 -0500
@@ -57,6 +57,7 @@
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_iostat.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <asm/uaccess.h>
@@ -105,6 +106,7 @@ static void nfs_grow_file(struct page *p
 	end = ((loff_t)page->index << PAGE_CACHE_SHIFT) + ((loff_t)offset+count);
 	if (i_size >= end)
 		return;
+	nfs_inc_stats(inode, NFS_EXTEND_WRITE);
 	i_size_write(inode, end);
 }
 
@@ -193,6 +195,7 @@ static int nfs_writepage_sync(struct nfs
 	        wdata->args.pgbase += result;
 		written += result;
 		count -= result;
+		nfs_add_stats(inode, NFS_WIRE_WRITTEN_BYTES, result);
 	} while (count);
 	/* Update file length */
 	nfs_grow_file(page, offset, written);
@@ -251,6 +254,8 @@ int nfs_writepage(struct page *page, str
 	int priority = wb_priority(wbc);
 	int err;
 
+	nfs_inc_stats(inode, NFS_VFS_WRITEPAGE);
+
 	/*
 	 * Note: We need to ensure that we have a reference to the inode
 	 *       if we are to do asynchronous writes. If not, waiting
@@ -318,6 +323,8 @@ int nfs_writepages(struct address_space 
 	struct inode *inode = mapping->host;
 	int err;
 
+	nfs_inc_stats(inode, NFS_VFS_WRITEPAGES);
+
 	err = generic_writepages(mapping, wbc);
 	if (err)
 		return err;
@@ -1145,6 +1152,8 @@ void nfs_writeback_done(struct rpc_task 
 	if (task->tk_status >= 0 && resp->count < argp->count) {
 		static unsigned long    complain;
 
+		nfs_inc_stats(data->inode, NFS_SHORT_WRITE);
+
 		/* Has the server at least made some progress? */
 		if (resp->count != 0) {
 			/* Was this an NFSv2 write or an NFSv3 stable write? */
@@ -1176,6 +1185,7 @@ void nfs_writeback_done(struct rpc_task 
 	 * Process the nfs_page list
 	 */
 	data->complete(data, task->tk_status);
+	nfs_add_stats(data->inode, NFS_WIRE_WRITTEN_BYTES, resp->count);
 }
 
 
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/include/linux/nfs_fs_sb.h 02-nfs-iostat/include/linux/nfs_fs_sb.h
--- 01-mountstats/include/linux/nfs_fs_sb.h	2005-03-02 02:38:33.000000000 -0500
+++ 02-nfs-iostat/include/linux/nfs_fs_sb.h	2005-03-14 15:26:16.458349000 -0500
@@ -4,6 +4,8 @@
 #include <linux/list.h>
 #include <linux/backing-dev.h>
 
+struct nfs_iostats;
+
 /*
  * NFS client parameters stored in the superblock.
  */
@@ -11,6 +13,7 @@ struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
+	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
 	unsigned int		caps;		/* server capabilities */
@@ -25,6 +28,8 @@ struct nfs_server {
 	unsigned int		acregmax;
 	unsigned int		acdirmin;
 	unsigned int		acdirmax;
+	unsigned long		retrans_timeo;	/* retransmit timeout */
+	unsigned int		retrans_count;	/* number of retransmit tries */
 	unsigned int		namelen;
 	char *			hostname;	/* remote hostname */
 	struct nfs_fh		fh;
diff -X /home/cel/src/linux/dont-diff -Naurp 01-mountstats/include/linux/nfs_iostat.h 02-nfs-iostat/include/linux/nfs_iostat.h
--- 01-mountstats/include/linux/nfs_iostat.h	1969-12-31 19:00:00.000000000 -0500
+++ 02-nfs-iostat/include/linux/nfs_iostat.h	2005-03-14 15:41:34.346502000 -0500
@@ -0,0 +1,80 @@
+#ifndef _NFS_IOSTAT
+#define _NFS_IOSTAT
+
+#define NFS_IOSTAT_VERS		"1.0"
+
+enum {
+	NFS_WIRE_READ_BYTES = 0,
+	NFS_WIRE_WRITTEN_BYTES,
+	NFS_SYS_READ_BYTES,
+	NFS_SYS_WRITTEN_BYTES,
+	NFS_DIRECT_READ_BYTES,
+	NFS_DIRECT_WRITTEN_BYTES,
+	NFS_WAIT_EVENT_JIFFIES,
+	__NFS_IOSTAT_BYTES_MAX,
+};
+
+enum {
+	NFS_INODE_REVALIDATE = 0,
+	NFS_DENTRY_REVALIDATE,
+	NFS_DATA_INVALIDATE,
+	NFS_ATTR_INVALIDATE,
+	NFS_VFS_OPEN,
+	NFS_VFS_GETDENTS,
+	NFS_VFS_LOOKUP,
+	NFS_VFS_ACCESS,
+	NFS_VFS_READPAGE,
+	NFS_VFS_READPAGES,
+	NFS_VFS_WRITEPAGE,
+	NFS_VFS_WRITEPAGES,
+	NFS_VFS_FLUSH,
+	NFS_VFS_FSYNC,
+	NFS_VFS_LOCK,
+	NFS_VFS_CLOSE,
+	NFS_WAIT_EVENT,
+	NFS_SHORT_READ,
+	NFS_SHORT_WRITE,
+	NFS_SETATTR_TRUNC,
+	NFS_EXTEND_WRITE,
+	NFS_SILLY_RENAME,
+	__NFS_IOSTAT_COUNTS_MAX,
+};
+
+#ifdef __KERNEL__
+
+#include <linux/cache.h>
+#include <linux/slab.h>
+
+struct nfs_iostats {
+	unsigned long long	bytes[__NFS_IOSTAT_BYTES_MAX];
+	unsigned long		counts[__NFS_IOSTAT_COUNTS_MAX];
+} ____cacheline_aligned;
+
+static inline void nfs_inc_stats(struct inode *inode, unsigned int stat)
+{
+	struct nfs_iostats *iostats = NFS_SERVER(inode)->io_stats;
+	iostats[smp_processor_id()].counts[stat]++;
+}
+
+static inline void nfs_add_stats(struct inode *inode, unsigned int stat, unsigned long long addend)
+{
+	struct nfs_iostats *iostats = NFS_SERVER(inode)->io_stats;
+	iostats[smp_processor_id()].bytes[stat] += addend;
+}
+
+static inline struct nfs_iostats *nfs_alloc_iostats(void)
+{
+	struct nfs_iostats *new;
+	new = kmalloc(sizeof(struct nfs_iostats) * NR_CPUS, GFP_KERNEL);
+	if (new)
+		memset(new, 0, sizeof(struct nfs_iostats) * NR_CPUS);
+	return new;
+}
+
+static inline void nfs_free_iostats(struct nfs_iostats *stats)
+{
+	kfree(stats);
+}
+
+#endif
+#endif
