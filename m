Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290646AbSBLNBG>; Tue, 12 Feb 2002 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSBLNA6>; Tue, 12 Feb 2002 08:00:58 -0500
Received: from mons.uio.no ([129.240.130.14]:6793 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S290646AbSBLNAs>;
	Tue, 12 Feb 2002 08:00:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15465.4591.583673.960874@charged.uio.no>
Date: Tue, 12 Feb 2002 14:00:31 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add support for NFSv3 READDIRPLUS...
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In addition to the standard NFS LOOKUP() routine for retrieving the
filehandle etc, NFSv3 adds a further refinement for speeding up 'find'
style programs. When reading the directory, the client can request the
alternative 'READDIRPLUS' call, in which each directory entry info
includes filehandle, + attributes.

The following patch allows the Linux NFSv3 client to make use of this
information. It ensures that for 'short' directories (defined as one
for which inode->i_size < NFS_LIMIT_READDIRPLUS) we call READDIRPLUS
rather than READDIR.
When the client tries to lookup a file from that directory, it then
first scans the cached directory info via the new function
nfs_cached_lookup() for the new filehandle, saving us from a LOOKUP
RPC call.

Since the directory pagecache gets cleared every time the directory is
seen to change, we are protected from picking up stale filehandles.
One question which does arise, however, is that of how to treat the
attributes. Since we don't know when the readdirplus call that filled
this particular pagecache entry was issued, we don't know how old the
attributes are. The most conservative estimate is to timestamp the
attributes as being no older than the last time we set the mtime
on the directory, and so this is what is done.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.4-rpc_bkl/fs/nfs/dir.c linux-2.5.4-rdplus/fs/nfs/dir.c
--- linux-2.5.4-rpc_bkl/fs/nfs/dir.c	Mon Feb 11 02:50:17 2002
+++ linux-2.5.4-rdplus/fs/nfs/dir.c	Tue Feb 12 11:50:58 2002
@@ -36,6 +36,8 @@
 
 static int nfs_readdir(struct file *, void *, filldir_t);
 static struct dentry *nfs_lookup(struct inode *, struct dentry *);
+static int nfs_cached_lookup(struct inode *, struct dentry *,
+				struct nfs_fh *, struct nfs_fattr *);
 static int nfs_create(struct inode *, struct dentry *, int);
 static int nfs_mkdir(struct inode *, struct dentry *, int);
 static int nfs_rmdir(struct inode *, struct dentry *);
@@ -108,13 +110,15 @@
 	error = NFS_PROTO(inode)->readdir(inode, cred, desc->entry->cookie, buffer,
 					  NFS_SERVER(inode)->dtsize, desc->plus);
 	/* We requested READDIRPLUS, but the server doesn't grok it */
-	if (desc->plus && error == -ENOTSUPP) {
-		NFS_FLAGS(inode) &= ~NFS_INO_ADVISE_RDPLUS;
-		desc->plus = 0;
-		goto again;
-	}
-	if (error < 0)
+	if (error < 0) {
+		if (error == -ENOTSUPP && desc->plus) {
+			NFS_SERVER(inode)->caps &= ~NFS_CAP_READDIRPLUS;
+			NFS_FLAGS(inode) &= ~NFS_INO_ADVISE_RDPLUS;
+			desc->plus = 0;
+			goto again;
+		}
 		goto error;
+	}
 	SetPageUptodate(page);
 	kunmap(page);
 	/* Ensure consistent page alignment of the data.
@@ -195,7 +199,6 @@
 
 	dfprintk(VFS, "NFS: find_dirent_page() searching directory page %ld\n", desc->page_index);
 
-	desc->plus = NFS_USE_READDIRPLUS(inode);
 	page = read_cache_page(&inode->i_data, desc->page_index,
 			       (filler_t *)nfs_readdir_filler, desc);
 	if (IS_ERR(page)) {
@@ -247,6 +250,24 @@
 	return res;
 }
 
+static unsigned int nfs_type2dtype[] = {
+	DT_UNKNOWN,
+	DT_REG,
+	DT_DIR,
+	DT_BLK,
+	DT_CHR,
+	DT_LNK,
+	DT_SOCK,
+	DT_UNKNOWN,
+	DT_FIFO
+};
+
+static inline
+unsigned int nfs_type_to_d_type(enum nfs_ftype type)
+{
+	return nfs_type2dtype[type];
+}
+
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
@@ -263,11 +284,17 @@
 	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)desc->target);
 
 	for(;;) {
+		unsigned d_type = DT_UNKNOWN;
 		/* Note: entry->prev_cookie contains the cookie for
 		 *	 retrieving the current dirent on the server */
 		fileid = nfs_fileid_to_ino_t(entry->ino);
+
+		/* Use readdirplus info */
+		if (desc->plus && (entry->fattr->valid & NFS_ATTR_FATTR))
+			d_type = nfs_type_to_d_type(entry->fattr->type);
+
 		res = filldir(dirent, entry->name, entry->len, 
-			      entry->prev_cookie, fileid, DT_UNKNOWN);
+			      entry->prev_cookie, fileid, d_type);
 		if (res < 0)
 			break;
 		file->f_pos = desc->target = entry->cookie;
@@ -334,7 +361,8 @@
 	/* Reset read descriptor so it searches the page cache from
 	 * the start upon the next call to readdir_search_pagecache() */
 	desc->page_index = 0;
-	memset(desc->entry, 0, sizeof(*desc->entry));
+	desc->entry->cookie = desc->entry->prev_cookie = 0;
+	desc->entry->eof = 0;
  out:
 	dfprintk(VFS, "NFS: uncached_readdir() returns %d\n", status);
 	return status;
@@ -353,9 +381,11 @@
 	nfs_readdir_descriptor_t my_desc,
 			*desc = &my_desc;
 	struct nfs_entry my_entry;
+	struct nfs_fh	fh;
+	struct nfs_fattr fattr;
 	long		res;
 
-	res = nfs_revalidate(dentry);
+	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (res < 0)
 		return res;
 
@@ -366,12 +396,16 @@
 	 * itself.
 	 */
 	memset(desc, 0, sizeof(*desc));
-	memset(&my_entry, 0, sizeof(my_entry));
-
 	desc->file = filp;
 	desc->target = filp->f_pos;
-	desc->entry = &my_entry;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
+	desc->plus = NFS_USE_READDIRPLUS(inode);
+
+	my_entry.cookie = my_entry.prev_cookie = 0;
+	my_entry.eof = 0;
+	my_entry.fh = &fh;
+	my_entry.fattr = &fattr;
+	desc->entry = &my_entry;
 
 	while(!desc->entry->eof) {
 		res = readdir_search_pagecache(desc);
@@ -494,6 +528,15 @@
 		goto out_valid;
 	}
 
+	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	if (!error) {
+		if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
+			goto out_bad;
+		if (nfs_lookup_verify_inode(inode, flags))
+			goto out_bad;
+		goto out_valid_renew;
+	}
+
 	if (NFS_STALE(inode))
 		goto out_bad;
 
@@ -505,6 +548,7 @@
 	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
 		goto out_bad;
 
+ out_valid_renew:
 	nfs_renew_times(dentry);
  out_valid:
 	unlock_kernel();
@@ -579,6 +623,20 @@
 	error = -ENOMEM;
 	dentry->d_op = &nfs_dentry_operations;
 
+	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	if (!error) {
+		error = -EACCES;
+		inode = nfs_fhget(dentry, &fhandle, &fattr);
+		if (inode) {
+			if (!(NFS_SERVER(dir)->flags & NFS_MOUNT_NOCTO))
+				NFS_CACHEINV(inode);
+			d_add(dentry, inode);
+			nfs_renew_times(dentry);
+			error = 0;
+		}
+		goto out;
+	}
+
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	inode = NULL;
 	if (error == -ENOENT)
@@ -597,6 +655,79 @@
 	return ERR_PTR(error);
 }
 
+static inline
+int find_dirent_name(nfs_readdir_descriptor_t *desc, struct page *page, struct dentry *dentry)
+{
+	struct nfs_entry *entry = desc->entry;
+	int		 status;
+
+	while((status = dir_decode(desc)) == 0) {
+		if (entry->len != dentry->d_name.len)
+			continue;
+		if (memcmp(entry->name, dentry->d_name.name, entry->len))
+			continue;
+		if (!(entry->fattr->valid & NFS_ATTR_FATTR))
+			continue;
+		break;
+	}
+	return status;
+}
+
+/*
+ * Use the cached Readdirplus results in order to avoid a LOOKUP call
+ * whenever we believe that the parent directory has not changed.
+ *
+ * We assume that any file creation/rename changes the directory mtime.
+ * As this results in a page cache invalidation whenever it occurs,
+ * we don't require any other tests for cache coherency.
+ */
+static
+int nfs_cached_lookup(struct inode *dir, struct dentry *dentry,
+			struct nfs_fh *fh, struct nfs_fattr *fattr)
+{
+	nfs_readdir_descriptor_t desc;
+	struct nfs_server *server;
+	struct nfs_entry entry;
+	struct page *page;
+	unsigned long timestamp = NFS_MTIME_UPDATE(dir);
+	int res;
+
+	if (!NFS_USE_READDIRPLUS(dir))
+		return -ENOENT;
+	server = NFS_SERVER(dir);
+	if (server->flags & NFS_MOUNT_NOAC)
+		return -ENOENT;
+	nfs_revalidate_inode(server, dir);
+
+	entry.fh = fh;
+	entry.fattr = fattr;
+
+	desc.decode = NFS_PROTO(dir)->decode_dirent;
+	desc.entry = &entry;
+	desc.page_index = 0;
+	desc.plus = 1;
+
+	for(;(page = find_get_page(&dir->i_data, desc.page_index)); desc.page_index++) {
+
+		res = -EIO;
+		if (Page_Uptodate(page)) {
+			desc.ptr = kmap(page);
+			res = find_dirent_name(&desc, page, dentry);
+			kunmap(page);
+		}
+		page_cache_release(page);
+
+		if (res == 0)
+			goto out_found;
+		if (res != -EAGAIN)
+			break;
+	}
+	return -ENOENT;
+ out_found:
+	fattr->timestamp = timestamp;
+	return 0;
+}
+
 /*
  * Code common to create, mkdir, and mknod.
  */
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/fs/nfs/inode.c linux-2.5.4-rdplus/fs/nfs/inode.c
--- linux-2.5.4-rpc_bkl/fs/nfs/inode.c	Tue Feb 12 09:32:18 2002
+++ linux-2.5.4-rdplus/fs/nfs/inode.c	Tue Feb 12 11:54:53 2002
@@ -326,6 +326,7 @@
 #ifdef CONFIG_NFS_V3
 		server->rpc_ops = &nfs_v3_clientops;
 		version = 3;
+		server->caps |= NFS_CAP_READDIRPLUS;
 		if (data->version < 4) {
 			printk(KERN_NOTICE "NFS: NFSv3 not supported by mount program.\n");
 			goto out_unlock;
@@ -677,6 +678,9 @@
 	return __nfs_fhget(sb, fhandle, fattr);
 }
 
+/* Don't use READDIRPLUS on directories that we believe are too large */
+#define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
+
 /*
  * Look up the inode by super block and fattr->fileid.
  */
@@ -721,6 +725,9 @@
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = &nfs_dir_inode_operations;
 			inode->i_fop = &nfs_dir_operations;
+			if (nfs_server_capable(inode, NFS_CAP_READDIRPLUS)
+			    && fattr->size <= NFS_LIMIT_READDIRPLUS)
+				NFS_FLAGS(inode) |= NFS_INO_ADVISE_RDPLUS;
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
 		else
@@ -731,7 +738,7 @@
 		new_isize = nfs_size_to_loff_t(fattr->size);
 		new_atime = nfs_time_to_secs(fattr->atime);
 
-		NFS_READTIME(inode) = jiffies;
+		NFS_READTIME(inode) = fattr->timestamp;
 		NFS_CACHE_CTIME(inode) = fattr->ctime;
 		inode->i_ctime = nfs_time_to_secs(fattr->ctime);
 		inode->i_atime = new_atime;
@@ -1038,6 +1045,9 @@
 		goto out_err;
 	}
 
+	/* Throw out obsolete READDIRPLUS attributes */
+	if (time_before(fattr->timestamp, NFS_READTIME(inode)))
+		return 0;
 	/*
 	 * Make sure the inode's type hasn't changed.
 	 */
@@ -1057,7 +1067,7 @@
 	/*
 	 * Update the read time so we don't revalidate too often.
 	 */
-	NFS_READTIME(inode) = jiffies;
+	NFS_READTIME(inode) = fattr->timestamp;
 
 	/*
 	 * Note: NFS_CACHE_ISIZE(inode) reflects the state of the cache.
@@ -1106,7 +1116,7 @@
 	inode->i_atime = new_atime;
 
 	if (NFS_CACHE_MTIME(inode) != new_mtime) {
-		NFS_MTIME_UPDATE(inode) = jiffies;
+		NFS_MTIME_UPDATE(inode) = fattr->timestamp;
 		NFS_CACHE_MTIME(inode) = new_mtime;
 		inode->i_mtime = nfs_time_to_secs(new_mtime);
 	}
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/fs/nfs/nfs2xdr.c linux-2.5.4-rdplus/fs/nfs/nfs2xdr.c
--- linux-2.5.4-rpc_bkl/fs/nfs/nfs2xdr.c	Mon Feb 11 02:50:14 2002
+++ linux-2.5.4-rdplus/fs/nfs/nfs2xdr.c	Tue Feb 12 11:50:58 2002
@@ -132,6 +132,7 @@
 		fattr->mode = (fattr->mode & ~S_IFMT) | S_IFIFO;
 		fattr->rdev = 0;
 	}
+	fattr->timestamp = jiffies;
 	return p;
 }
 
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/fs/nfs/nfs3xdr.c linux-2.5.4-rdplus/fs/nfs/nfs3xdr.c
--- linux-2.5.4-rpc_bkl/fs/nfs/nfs3xdr.c	Mon Feb 11 02:50:17 2002
+++ linux-2.5.4-rdplus/fs/nfs/nfs3xdr.c	Tue Feb 12 11:50:59 2002
@@ -195,6 +195,7 @@
 
 	/* Update the mode bits */
 	fattr->valid |= (NFS_ATTR_FATTR | NFS_ATTR_FATTR_V3);
+	fattr->timestamp = jiffies;
 	return p;
 }
 
@@ -660,21 +661,19 @@
 	p = xdr_decode_hyper(p, &entry->cookie);
 
 	if (plus) {
-		p = xdr_decode_post_op_attr(p, &entry->fattr);
+		entry->fattr->valid = 0;
+		p = xdr_decode_post_op_attr(p, entry->fattr);
 		/* In fact, a post_op_fh3: */
 		if (*p++) {
-			p = xdr_decode_fhandle(p, &entry->fh);
+			p = xdr_decode_fhandle(p, entry->fh);
 			/* Ugh -- server reply was truncated */
 			if (p == NULL) {
 				dprintk("NFS: FH truncated\n");
 				*entry = old;
 				return ERR_PTR(-EAGAIN);
 			}
-		} else {
-			/* If we don't get a file handle, the attrs
-			 * aren't worth a lot. */
-			entry->fattr.valid = 0;
-		}
+		} else
+			memset((u8*)(entry->fh), 0, sizeof(*entry->fh));
 	}
 
 	entry->eof = !p[0] && p[1];
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/include/linux/nfs_fs.h linux-2.5.4-rdplus/include/linux/nfs_fs.h
--- linux-2.5.4-rpc_bkl/include/linux/nfs_fs.h	Tue Feb 12 11:14:21 2002
+++ linux-2.5.4-rdplus/include/linux/nfs_fs.h	Tue Feb 12 11:50:59 2002
@@ -205,8 +205,15 @@
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 
-/* Inode Flags */
-#define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
+static inline int nfs_server_capable(struct inode *inode, int cap)
+{
+	return NFS_SERVER(inode)->caps & cap;
+}
+
+static inline int NFS_USE_READDIRPLUS(struct inode *inode)
+{
+	return NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS;
+}
 
 static inline
 loff_t page_offset(struct page *page)
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/include/linux/nfs_fs_sb.h linux-2.5.4-rdplus/include/linux/nfs_fs_sb.h
--- linux-2.5.4-rpc_bkl/include/linux/nfs_fs_sb.h	Tue Feb 12 10:30:52 2002
+++ linux-2.5.4-rdplus/include/linux/nfs_fs_sb.h	Tue Feb 12 11:50:59 2002
@@ -10,6 +10,7 @@
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
 	int			flags;		/* various flags */
+	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
@@ -36,4 +37,8 @@
 	struct nfs_server	s_server;
 };
 
+/* Server capabilities */
+#define NFS_CAP_READDIRPLUS	1
+
+
 #endif
diff -u --recursive --new-file linux-2.5.4-rpc_bkl/include/linux/nfs_xdr.h linux-2.5.4-rdplus/include/linux/nfs_xdr.h
--- linux-2.5.4-rpc_bkl/include/linux/nfs_xdr.h	Mon Feb 11 02:50:13 2002
+++ linux-2.5.4-rdplus/include/linux/nfs_xdr.h	Tue Feb 12 11:50:59 2002
@@ -30,6 +30,7 @@
 	__u64			atime;
 	__u64			mtime;
 	__u64			ctime;
+	unsigned long		timestamp;
 };
 
 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
@@ -112,8 +113,8 @@
 	const char *		name;
 	unsigned int		len;
 	int			eof;
-	struct nfs_fh		fh;
-	struct nfs_fattr	fattr;
+	struct nfs_fh		*fh;
+	struct nfs_fattr	*fattr;
 };
 
 /*
