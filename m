Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSG1PYW>; Sun, 28 Jul 2002 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSG1PXg>; Sun, 28 Jul 2002 11:23:36 -0400
Received: from mons.uio.no ([129.240.130.14]:57490 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316878AbSG1PXB>;
	Sun, 28 Jul 2002 11:23:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3351.16720.393606@charged.uio.no>
Date: Sun, 28 Jul 2002 17:26:15 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [4/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add support for positive lookups using the READDIRPLUS cached
information. Both new lookups and lookup revalidation is supported.

Use READDIRPLUS instead of READDIR on NFSv3 directories with lengths
shorter than 8*PAGE_SIZE.

Note that inode attribute information is only updated if it is seen to
be more recent than any existing cached information.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-rdplus3/fs/nfs/dir.c linux-2.5.29-rdplus4/fs/nfs/dir.c
--- linux-2.5.29-rdplus3/fs/nfs/dir.c	Sat Jul 27 18:58:30 2002
+++ linux-2.5.29-rdplus4/fs/nfs/dir.c	Sat Jul 27 19:15:50 2002
@@ -37,6 +37,8 @@
 
 static int nfs_readdir(struct file *, void *, filldir_t);
 static struct dentry *nfs_lookup(struct inode *, struct dentry *);
+static int nfs_cached_lookup(struct inode *, struct dentry *,
+				struct nfs_fh *, struct nfs_fattr *);
 static int nfs_create(struct inode *, struct dentry *, int);
 static int nfs_mkdir(struct inode *, struct dentry *, int);
 static int nfs_rmdir(struct inode *, struct dentry *);
@@ -504,6 +506,15 @@
 		goto out_valid;
 	}
 
+	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	if (!error) {
+		if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
+			goto out_bad;
+		if (nfs_lookup_verify_inode(inode))
+			goto out_bad;
+		goto out_valid_renew;
+	}
+
 	if (NFS_STALE(inode))
 		goto out_bad;
 
@@ -515,6 +526,7 @@
 	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
 		goto out_bad;
 
+ out_valid_renew:
 	nfs_renew_times(dentry);
  out_valid:
 	unlock_kernel();
@@ -578,7 +590,7 @@
 
 static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry)
 {
-	struct inode *inode;
+	struct inode *inode = NULL;
 	int error;
 	struct nfs_fh fhandle;
 	struct nfs_fattr fattr;
@@ -594,8 +606,19 @@
 	dentry->d_op = &nfs_dentry_operations;
 
 	lock_kernel();
+	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	if (!error) {
+		error = -EACCES;
+		inode = nfs_fhget(dentry, &fhandle, &fattr);
+		if (inode) {
+			d_add(dentry, inode);
+			nfs_renew_times(dentry);
+			error = 0;
+		}
+		goto out;
+	}
+
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
-	inode = NULL;
 	if (error == -ENOENT)
 		goto no_entry;
 	if (!error) {
@@ -613,6 +636,79 @@
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
+		if (PageUptodate(page)) {
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
diff -u --recursive --new-file linux-2.5.29-rdplus3/fs/nfs/inode.c linux-2.5.29-rdplus4/fs/nfs/inode.c
--- linux-2.5.29-rdplus3/fs/nfs/inode.c	Sat Jul 27 18:53:18 2002
+++ linux-2.5.29-rdplus4/fs/nfs/inode.c	Sat Jul 27 19:03:43 2002
@@ -644,6 +644,9 @@
 	return __nfs_fhget(sb, fhandle, fattr);
 }
 
+/* Don't use READDIRPLUS on directories that we believe are too large */
+#define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
+
 /*
  * Look up the inode by super block and fattr->fileid.
  */
@@ -692,6 +695,9 @@
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = &nfs_dir_inode_operations;
 			inode->i_fop = &nfs_dir_operations;
+			if (nfs_server_capable(inode, NFS_CAP_READDIRPLUS)
+			    && fattr->size <= NFS_LIMIT_READDIRPLUS)
+				NFS_FLAGS(inode) |= NFS_INO_ADVISE_RDPLUS;
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
 		else
