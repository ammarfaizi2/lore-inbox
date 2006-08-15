Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWHOP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWHOP1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWHOP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:26:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752110AbWHOP0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:26:44 -0400
From: David Howells <dhowells@redhat.com>
Subject: [RHEL5 PATCH 2/2] NFS: Represent 64-bit fileids as 64-bit inode numbers on 32-bit systems [try #2]
Date: Tue, 15 Aug 2006 16:26:32 +0100
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no,
       aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org, dhowells@redhat.com
Message-Id: <20060815152632.29222.66333.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
References: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the previous patch that expanded the inode numbers in struct kstat
and filldir_t to an obligate 64-bits, make NFS represent 64-bit fileids as
64-bit inode numbers rather than compressing them down to 32-bits.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/dir.c           |    6 +++---
 fs/nfs/inode.c         |   21 ++++++++++-----------
 include/linux/nfs_fs.h |    9 ---------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9b496ef..e746ed1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -397,7 +397,7 @@ int nfs_do_filldir(nfs_readdir_descripto
 	struct file	*file = desc->file;
 	struct nfs_entry *entry = desc->entry;
 	struct dentry	*dentry = NULL;
-	unsigned long	fileid;
+	u64		fileid;
 	int		loop_count = 0,
 			res;
 
@@ -408,7 +408,7 @@ int nfs_do_filldir(nfs_readdir_descripto
 		unsigned d_type = DT_UNKNOWN;
 		/* Note: entry->prev_cookie contains the cookie for
 		 *	 retrieving the current dirent on the server */
-		fileid = nfs_fileid_to_ino_t(entry->ino);
+		fileid = entry->ino;
 
 		/* Get a dentry if we have one */
 		if (dentry != NULL)
@@ -418,7 +418,7 @@ int nfs_do_filldir(nfs_readdir_descripto
 		/* Use readdirplus info */
 		if (dentry != NULL && dentry->d_inode != NULL) {
 			d_type = dt_type(dentry->d_inode);
-			fileid = dentry->d_inode->i_ino;
+			fileid = NFS_FILEID(dentry->d_inode);
 		}
 
 		res = filldir(dirent, entry->name, entry->len, 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index eaa254b..a7b1e20 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -57,12 +57,6 @@ static void nfs_zap_acl_cache(struct ino
 
 static kmem_cache_t * nfs_inode_cachep;
 
-static inline unsigned long
-nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
-{
-	return nfs_fileid_to_ino_t(fattr->fileid);
-}
-
 int nfs_write_inode(struct inode *inode, int sync)
 {
 	int flags = sync ? FLUSH_SYNC : 0;
@@ -220,7 +214,9 @@ nfs_fhget(struct super_block *sb, struct
 		goto out_no_inode;
 	}
 
-	hash = nfs_fattr_to_ino_t(fattr);
+	hash = fattr->fileid;
+	if (sizeof(hash) < sizeof(u64))
+		hash ^= fattr->fileid >> (sizeof(u64) - sizeof(ino_t)) * 8;
 
 	inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc);
 	if (inode == NULL) {
@@ -231,9 +227,10 @@ nfs_fhget(struct super_block *sb, struct
 	if (inode->i_state & I_NEW) {
 		struct nfs_inode *nfsi = NFS_I(inode);
 
-		/* We set i_ino for the few things that still rely on it,
-		 * such as stat(2) */
-		inode->i_ino = hash;
+		/* We set i_ino for the few things that still rely on it, such
+		 * as printing messages; stat and filldir use the fileid
+		 * directly since i_ino may not be large enough */
+		inode->i_ino = fattr->fileid;
 
 		/* We can't support update_atime(), since the server will reset it */
 		inode->i_flags |= S_NOATIME|S_NOCMTIME;
@@ -442,8 +439,10 @@ int nfs_getattr(struct vfsmount *mnt, st
 		err = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	else
 		err = nfs_revalidate_inode(NFS_SERVER(inode), inode);
-	if (!err)
+	if (!err) {
 		generic_fillattr(inode, stat);
+		stat->ino = NFS_FILEID(inode);
+	}
 	return err;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 96d7bd9..b768c43 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -548,15 +548,6 @@ nfs_size_to_loff_t(__u64 size)
 	return (loff_t) size;
 }
 
-static inline ino_t
-nfs_fileid_to_ino_t(u64 fileid)
-{
-	ino_t ino = (ino_t) fileid;
-	if (sizeof(ino_t) < sizeof(u64))
-		ino ^= fileid >> (sizeof(u64)-sizeof(ino_t)) * 8;
-	return ino;
-}
-
 /* NFS root */
 
 extern void * nfs_root_data(void);
