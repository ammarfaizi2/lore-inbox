Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbRGNKtM>; Sat, 14 Jul 2001 06:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbRGNKs5>; Sat, 14 Jul 2001 06:48:57 -0400
Received: from mons.uio.no ([129.240.130.14]:31362 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267612AbRGNKsh>;
	Sat, 14 Jul 2001 06:48:37 -0400
MIME-Version: 1.0
Message-ID: <15184.9082.90044.242609@charged.uio.no>
Date: Sat, 14 Jul 2001 12:48:26 +0200
To: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH/CFT] Fix NFS mmap problems w.r.t. page_launder() in 2.4.6...
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch addresses a problem with mmap() under NFS. In the
current code, mmap()ed files are always written back to the server
using the RPC credentials of the process that called writepage().

Normally, we try to flush out all pages when we close the file, hoping
that the process still has the correct RPC credentials (i.e. we hope
that current->fsuid and current->fsgid have not changed in such a way
that we don't have access to the file anymore).

The problem arises when memory pressure and page_launder() cause an
early flush of the file. Since these are not guaranteed to be run
using the credentials of the process that is actually mmapping the
file, and there is no way of locating those credentials, writepage()
can fail, and data will be lost.

The answer to this dilemma is to borrow the RPC credentials of
somebody that we know has write access to the file. There are 2
possibilities:
  1) fake the credentials of the owner of the file.
  2) cache the credentials of someone who has opened the file for
     writing in some place where the writepage() can find them.

Of these 2 options, the second is slightly preferable to the first
because it is not always possible to fake a credential.

Both options require some changes to the RPC authentication code. The
former needs an API in order to allow faking creds. The latter, it
turned out, needed some changes due to a race when unmounting (as
inodes have to be destroyed *after* the RPC system has cleaned up and
shut down).

The following patch therefore caches the credentials of the last
person to open a file for writes in the NFS-specific part of the
inode. It then uses these credentials in writepage().  In addition,
due to the above race, the RPC credential cache is rewritten so that
credentials can exist for the lifetime of the inode itself.
This means that we can throw out the code that flushes the dirty pages
on file close, and allow page_launder and/or bdflush to do this for
us.  Finally, since the above code touched struct nfs_inode, I did a
little spring cleaning, in order to ensure that we don't bloat the
size even further.

Comments/bugs/aob ???

Cheers,
   Trond

diff -u --recursive --new-file linux-2.4.6-file/arch/i386/kernel/i386_ksyms.c linux-2.4.6-mmap/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.6-file/arch/i386/kernel/i386_ksyms.c	Mon Jul  2 23:49:24 2001
+++ linux-2.4.6-mmap/arch/i386/kernel/i386_ksyms.c	Tue Jul 10 11:13:48 2001
@@ -161,3 +161,7 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+#ifdef CONFIG_HAVE_DEC_LOCK
+EXPORT_SYMBOL(atomic_dec_and_lock);
+#endif
diff -u --recursive --new-file linux-2.4.6-file/arch/sparc64/kernel/sparc64_ksyms.c linux-2.4.6-mmap/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.4.6-file/arch/sparc64/kernel/sparc64_ksyms.c	Tue Jun 12 04:15:27 2001
+++ linux-2.4.6-mmap/arch/sparc64/kernel/sparc64_ksyms.c	Tue Jul 10 11:16:13 2001
@@ -163,6 +163,7 @@
 /* Atomic counter implementation. */
 EXPORT_SYMBOL(__atomic_add);
 EXPORT_SYMBOL(__atomic_sub);
+EXPORT_SYMBOL(atomic_dec_and_lock);
 
 /* Atomic bit operations. */
 EXPORT_SYMBOL(___test_and_set_bit);
diff -u --recursive --new-file linux-2.4.6-file/fs/nfs/file.c linux-2.4.6-mmap/fs/nfs/file.c
--- linux-2.4.6-file/fs/nfs/file.c	Fri Jul  6 11:56:40 2001
+++ linux-2.4.6-mmap/fs/nfs/file.c	Fri Jul  6 11:57:30 2001
@@ -39,7 +39,6 @@
 static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
-static int  nfs_file_release(struct inode *, struct file *);
 
 struct file_operations nfs_file_operations = {
 	read:		nfs_file_read,
@@ -47,7 +46,7 @@
 	mmap:		nfs_file_mmap,
 	open:		nfs_open,
 	flush:		nfs_file_flush,
-	release:	nfs_file_release,
+	release:	nfs_release,
 	fsync:		nfs_fsync,
 	lock:		nfs_lock,
 };
@@ -86,13 +85,6 @@
 		file->f_error = 0;
 	}
 	return status;
-}
-
-static int
-nfs_file_release(struct inode *inode, struct file *file)
-{
-	filemap_fdatasync(inode->i_mapping);
-	return nfs_release(inode,file);
 }
 
 static ssize_t
diff -u --recursive --new-file linux-2.4.6-file/fs/nfs/inode.c linux-2.4.6-mmap/fs/nfs/inode.c
--- linux-2.4.6-file/fs/nfs/inode.c	Wed Jun 27 23:02:29 2001
+++ linux-2.4.6-mmap/fs/nfs/inode.c	Fri Jul  6 11:57:05 2001
@@ -48,6 +48,7 @@
 static void nfs_write_inode(struct inode *,int);
 static void nfs_delete_inode(struct inode *);
 static void nfs_put_super(struct super_block *);
+static void nfs_clear_inode(struct inode *);
 static void nfs_umount_begin(struct super_block *);
 static int  nfs_statfs(struct super_block *, struct statfs *);
 
@@ -57,6 +58,7 @@
 	delete_inode:	nfs_delete_inode,
 	put_super:	nfs_put_super,
 	statfs:		nfs_statfs,
+	clear_inode:	nfs_clear_inode,
 	umount_begin:	nfs_umount_begin,
 };
 
@@ -141,6 +143,21 @@
 	clear_inode(inode);
 }
 
+/*
+ * For the moment, the only task for the NFS clear_inode method is to
+ * release the mmap credential
+ */
+static void
+nfs_clear_inode(struct inode *inode)
+{
+	struct rpc_cred *cred = NFS_I(inode)->mm_cred;
+
+	if (cred) {
+		put_rpccred(cred);
+		NFS_I(inode)->mm_cred = 0;
+	}
+}
+
 void
 nfs_put_super(struct super_block *sb)
 {
@@ -600,7 +617,6 @@
 		inode->i_ctime = nfs_time_to_secs(fattr->ctime);
 		NFS_CACHE_CTIME(inode) = fattr->ctime;
 		NFS_CACHE_MTIME(inode) = fattr->mtime;
-		NFS_CACHE_ATIME(inode) = fattr->atime;
 		NFS_CACHE_ISIZE(inode) = fattr->size;
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
@@ -794,6 +810,20 @@
 }
 
 /*
+ * Ensure that mmap has a recent RPC credential for use when writing out
+ * shared pages
+ */
+static inline void
+nfs_set_mmcred(struct inode *inode, struct rpc_cred *cred)
+{
+	struct rpc_cred *oldcred = NFS_I(inode)->mm_cred;
+
+	NFS_I(inode)->mm_cred = get_rpccred(cred);
+	if (oldcred)
+		put_rpccred(oldcred);
+}
+
+/*
  * These are probably going to contain hooks for
  * allocating and releasing RPC credentials for
  * the file. I'll have to think about Tronds patch
@@ -808,20 +838,20 @@
 	auth = NFS_CLIENT(inode)->cl_auth;
 	cred = rpcauth_lookupcred(auth, 0);
 	filp->private_data = cred;
+	if (filp->f_mode & FMODE_WRITE)
+		nfs_set_mmcred(inode, cred);
 	unlock_kernel();
 	return 0;
 }
 
 int nfs_release(struct inode *inode, struct file *filp)
 {
-	struct rpc_auth *auth;
 	struct rpc_cred *cred;
 
 	lock_kernel();
-	auth = NFS_CLIENT(inode)->cl_auth;
 	cred = nfs_file_cred(filp);
 	if (cred)
-		rpcauth_releasecred(auth, cred);
+		put_rpccred(cred);
 	unlock_kernel();
 	return 0;
 }
@@ -976,7 +1006,6 @@
 	NFS_CACHE_CTIME(inode) = fattr->ctime;
 	inode->i_ctime = nfs_time_to_secs(fattr->ctime);
 
-	NFS_CACHE_ATIME(inode) = fattr->atime;
 	inode->i_atime = nfs_time_to_secs(fattr->atime);
 
 	NFS_CACHE_MTIME(inode) = new_mtime;
diff -u --recursive --new-file linux-2.4.6-file/fs/nfs/unlink.c linux-2.4.6-mmap/fs/nfs/unlink.c
--- linux-2.4.6-file/fs/nfs/unlink.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.6-mmap/fs/nfs/unlink.c	Fri Jul  6 11:57:05 2001
@@ -128,7 +128,7 @@
 	dir_i = dir->d_inode;
 	nfs_zap_caches(dir_i);
 	NFS_PROTO(dir_i)->unlink_done(dir, &task->tk_msg);
-	rpcauth_releasecred(task->tk_auth, data->cred);
+	put_rpccred(data->cred);
 	data->cred = NULL;
 	dput(dir);
 }
diff -u --recursive --new-file linux-2.4.6-file/fs/nfs/write.c linux-2.4.6-mmap/fs/nfs/write.c
--- linux-2.4.6-file/fs/nfs/write.c	Fri Jul  6 11:54:09 2001
+++ linux-2.4.6-mmap/fs/nfs/write.c	Fri Jul  6 11:57:05 2001
@@ -181,7 +181,9 @@
 
 
 	if (file)
-		cred = nfs_file_cred(file);
+		cred = get_rpccred(nfs_file_cred(file));
+	if (!cred)
+		cred = get_rpccred(NFS_I(inode)->mm_cred);
 
 	dprintk("NFS:      nfs_writepage_sync(%x/%Ld %d@%Ld)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode),
@@ -226,6 +228,8 @@
 
 io_error:
 	kunmap(page);
+	if (cred)
+		put_rpccred(cred);
 
 	return written? written : result;
 }
@@ -241,6 +245,9 @@
 	status = (IS_ERR(req)) ? PTR_ERR(req) : 0;
 	if (status < 0)
 		goto out;
+	if (!req->wb_cred)
+		req->wb_cred = get_rpccred(NFS_I(inode)->mm_cred);
+	nfs_unlock_request(req);
 	nfs_release_request(req);
 	nfs_strategy(inode);
  out:
@@ -557,13 +564,11 @@
 	req->wb_bytes   = count;
 	req->wb_file    = file;
 
-	/* If we have a struct file, use its cached credentials
-	 * else cache the current process' credentials. */
+	/* If we have a struct file, use its cached credentials */
 	if (file) {
 		get_file(file);
 		req->wb_cred	= nfs_file_cred(file);
-	} else
-		req->wb_cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
+	}
 	req->wb_inode   = inode;
 	req->wb_count   = 1;
 
@@ -608,8 +613,8 @@
 	/* Release struct file or cached credential */
 	if (req->wb_file)
 		fput(req->wb_file);
-	else
-		rpcauth_releasecred(NFS_CLIENT(inode)->cl_auth, req->wb_cred);
+	else if (req->wb_cred)
+		put_rpccred(req->wb_cred);
 	page_cache_release(page);
 	nfs_page_free(req);
 	/* wake up anyone waiting to allocate a request */
@@ -927,8 +932,6 @@
 	if (end > rqend)
 		req->wb_bytes = end - req->wb_offset;
 
-	nfs_unlock_request(req);
-
 	return req;
 }
 
@@ -1049,6 +1052,7 @@
 		goto done;
 
 	status = 0;
+	nfs_unlock_request(req);
 	/* If we wrote past the end of the page.
 	 * Call the strategy routine so it can send out a bunch
 	 * of requests.
diff -u --recursive --new-file linux-2.4.6-file/include/linux/nfs_fs.h linux-2.4.6-mmap/include/linux/nfs_fs.h
--- linux-2.4.6-file/include/linux/nfs_fs.h	Wed Jul  4 00:43:37 2001
+++ linux-2.4.6-mmap/include/linux/nfs_fs.h	Fri Jul  6 11:57:05 2001
@@ -63,6 +63,11 @@
  */
 #define NFS_SUPER_MAGIC			0x6969
 
+static inline struct nfs_inode_info *NFS_I(struct inode *inode)
+{
+	return &inode->u.nfs_i;
+}
+
 #define NFS_FH(inode)			(&(inode)->u.nfs_i.fh)
 #define NFS_SERVER(inode)		(&(inode)->i_sb->u.nfs_sb.s_server)
 #define NFS_CLIENT(inode)		(NFS_SERVER(inode)->client)
@@ -74,7 +79,6 @@
 #define NFS_READTIME(inode)		((inode)->u.nfs_i.read_cache_jiffies)
 #define NFS_CACHE_CTIME(inode)		((inode)->u.nfs_i.read_cache_ctime)
 #define NFS_CACHE_MTIME(inode)		((inode)->u.nfs_i.read_cache_mtime)
-#define NFS_CACHE_ATIME(inode)		((inode)->u.nfs_i.read_cache_atime)
 #define NFS_CACHE_ISIZE(inode)		((inode)->u.nfs_i.read_cache_isize)
 #define NFS_NEXTSCAN(inode)		((inode)->u.nfs_i.nextscan)
 #define NFS_CACHEINV(inode) \
diff -u --recursive --new-file linux-2.4.6-file/include/linux/nfs_fs_i.h linux-2.4.6-mmap/include/linux/nfs_fs_i.h
--- linux-2.4.6-file/include/linux/nfs_fs_i.h	Tue Feb 20 02:13:00 2001
+++ linux-2.4.6-mmap/include/linux/nfs_fs_i.h	Fri Jul  6 11:57:05 2001
@@ -45,7 +45,6 @@
 	unsigned long		read_cache_jiffies;
 	__u64			read_cache_ctime;
 	__u64			read_cache_mtime;
-	__u64			read_cache_atime;
 	__u64			read_cache_isize;
 	unsigned long		attrtimeo;
 	unsigned long		attrtimeo_timestamp;
@@ -73,6 +72,9 @@
 	struct inode		*hash_next,
 				*hash_prev;
 	unsigned long		nextscan;
+
+	/* Credentials for shared mmap */
+	struct rpc_cred		*mm_cred;
 };
 
 /*
diff -u --recursive --new-file linux-2.4.6-file/include/linux/sunrpc/auth.h linux-2.4.6-mmap/include/linux/sunrpc/auth.h
--- linux-2.4.6-file/include/linux/sunrpc/auth.h	Wed Jul  4 00:42:55 2001
+++ linux-2.4.6-mmap/include/linux/sunrpc/auth.h	Fri Jul  6 15:05:46 2001
@@ -14,6 +14,8 @@
 #include <linux/config.h>
 #include <linux/sunrpc/sched.h>
 
+#include <asm/atomic.h>
+
 /* size of the nodename buffer */
 #define UNX_MAXNODENAME	32
 
@@ -22,8 +24,10 @@
  */
 struct rpc_cred {
 	struct rpc_cred *	cr_next;	/* linked list */
+	struct rpc_auth *	cr_auth;
+	struct rpc_credops *	cr_ops;
 	unsigned long		cr_expire;	/* when to gc */
-	unsigned short		cr_count;	/* ref count */
+	atomic_t		cr_count;	/* ref count */
 	unsigned short		cr_flags;	/* various flags */
 #ifdef RPC_DEBUG
 	unsigned long		cr_magic;	/* 0x0f4aa4f0 */
@@ -71,6 +75,9 @@
 	void			(*destroy)(struct rpc_auth *);
 
 	struct rpc_cred *	(*crcreate)(int);
+};
+
+struct rpc_credops {
 	void			(*crdestroy)(struct rpc_cred *);
 
 	int			(*crmatch)(struct rpc_cred *, int);
@@ -92,8 +99,7 @@
 struct rpc_cred *	rpcauth_lookupcred(struct rpc_auth *, int);
 struct rpc_cred *	rpcauth_bindcred(struct rpc_task *);
 void			rpcauth_holdcred(struct rpc_task *);
-void			rpcauth_releasecred(struct rpc_auth *,
-					    struct rpc_cred *);
+void			put_rpccred(struct rpc_cred *);
 void			rpcauth_unbindcred(struct rpc_task *);
 int			rpcauth_matchcred(struct rpc_auth *,
 					  struct rpc_cred *, int);
@@ -106,6 +112,13 @@
 void			rpcauth_free_credcache(struct rpc_auth *);
 void			rpcauth_insert_credcache(struct rpc_auth *,
 						struct rpc_cred *);
+
+static inline
+struct rpc_cred *	get_rpccred(struct rpc_cred *cred)
+{
+	atomic_inc(&cred->cr_count);
+	return cred;
+}
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_AUTH_H */
diff -u --recursive --new-file linux-2.4.6-file/net/sunrpc/auth.c linux-2.4.6-mmap/net/sunrpc/auth.c
--- linux-2.4.6-file/net/sunrpc/auth.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.6-mmap/net/sunrpc/auth.c	Fri Jul  6 11:57:05 2001
@@ -81,42 +81,61 @@
 	auth->au_nextgc = jiffies + (auth->au_expire >> 1);
 }
 
+/*
+ * Destroy an unreferenced credential
+ */
 static inline void
-rpcauth_crdestroy(struct rpc_auth *auth, struct rpc_cred *cred)
+rpcauth_crdestroy(struct rpc_cred *cred)
 {
 #ifdef RPC_DEBUG
 	if (cred->cr_magic != RPCAUTH_CRED_MAGIC)
 		BUG();
 	cred->cr_magic = 0;
+	if (atomic_read(&cred->cr_count) || cred->cr_auth)
+		BUG();
 #endif
-	if (auth->au_ops->crdestroy)
-		auth->au_ops->crdestroy(cred);
-	else
-		rpc_free(cred);
+	cred->cr_ops->crdestroy(cred);
 }
 
 /*
- * Clear the RPC credential cache
+ * Destroy a list of credentials
+ */
+static inline
+void rpcauth_destroy_credlist(struct rpc_cred *head)
+{
+	struct rpc_cred *cred;
+
+	while ((cred = head) != NULL) {
+		head = cred->cr_next;
+		rpcauth_crdestroy(cred);
+	}
+}
+
+/*
+ * Clear the RPC credential cache, and delete those credentials
+ * that are not referenced.
  */
 void
 rpcauth_free_credcache(struct rpc_auth *auth)
 {
-	struct rpc_cred	**q, *cred;
-	void		(*destroy)(struct rpc_cred *);
+	struct rpc_cred	**q, *cred, *free = NULL;
 	int		i;
 
-	if (!(destroy = auth->au_ops->crdestroy))
-		destroy = (void (*)(struct rpc_cred *)) rpc_free;
-
 	spin_lock(&rpc_credcache_lock);
 	for (i = 0; i < RPC_CREDCACHE_NR; i++) {
 		q = &auth->au_credcache[i];
 		while ((cred = *q) != NULL) {
 			*q = cred->cr_next;
-			destroy(cred);
+			cred->cr_auth = NULL;
+			if (atomic_read(&cred->cr_count) == 0) {
+				cred->cr_next = free;
+				free = cred;
+			} else
+				cred->cr_next = NULL;
 		}
 	}
 	spin_unlock(&rpc_credcache_lock);
+	rpcauth_destroy_credlist(free);
 }
 
 /*
@@ -133,9 +152,10 @@
 	for (i = 0; i < RPC_CREDCACHE_NR; i++) {
 		q = &auth->au_credcache[i];
 		while ((cred = *q) != NULL) {
-			if (!cred->cr_count &&
+			if (!atomic_read(&cred->cr_count) &&
 			    time_before(cred->cr_expire, jiffies)) {
 				*q = cred->cr_next;
+				cred->cr_auth = NULL;
 				cred->cr_next = free;
 				free = cred;
 				continue;
@@ -144,10 +164,7 @@
 		}
 	}
 	spin_unlock(&rpc_credcache_lock);
-	while ((cred = free) != NULL) {
-		free = cred->cr_next;
-		rpcauth_crdestroy(auth, cred);
-	}
+	rpcauth_destroy_credlist(free);
 	auth->au_nextgc = jiffies + auth->au_expire;
 }
 
@@ -163,8 +180,8 @@
 	spin_lock(&rpc_credcache_lock);
 	cred->cr_next = auth->au_credcache[nr];
 	auth->au_credcache[nr] = cred;
-	cred->cr_count++;
-	cred->cr_expire = jiffies + auth->au_expire;
+	cred->cr_auth = auth;
+	get_rpccred(cred);
 	spin_unlock(&rpc_credcache_lock);
 }
 
@@ -187,7 +204,7 @@
 	q = &auth->au_credcache[nr];
 	while ((cred = *q) != NULL) {
 		if (!(cred->cr_flags & RPCAUTH_CRED_DEAD) &&
-		    auth->au_ops->crmatch(cred, taskflags)) {
+		    cred->cr_ops->crmatch(cred, taskflags)) {
 			*q = cred->cr_next;
 			break;
 		}
@@ -213,23 +230,23 @@
  * Remove cred handle from cache
  */
 static void
-rpcauth_remove_credcache(struct rpc_auth *auth, struct rpc_cred *cred)
+rpcauth_remove_credcache(struct rpc_cred *cred)
 {
+	struct rpc_auth *auth = cred->cr_auth;
 	struct rpc_cred	**q, *cr;
 	int		nr;
 
 	nr = (cred->cr_uid & RPC_CREDCACHE_MASK);
-	spin_lock(&rpc_credcache_lock);
 	q = &auth->au_credcache[nr];
 	while ((cr = *q) != NULL) {
 		if (cred == cr) {
 			*q = cred->cr_next;
 			cred->cr_next = NULL;
+			cred->cr_auth = NULL;
 			break;
 		}
 		q = &cred->cr_next;
 	}
-	spin_unlock(&rpc_credcache_lock);
 }
 
 struct rpc_cred *
@@ -258,7 +275,7 @@
 {
 	dprintk("RPC:     matching %s cred %d\n",
 		auth->au_ops->au_name, taskflags);
-	return auth->au_ops->crmatch(cred, taskflags);
+	return cred->cr_ops->crmatch(cred, taskflags);
 }
 
 void
@@ -266,26 +283,25 @@
 {
 	dprintk("RPC: %4d holding %s cred %p\n",
 		task->tk_pid, task->tk_auth->au_ops->au_name, task->tk_msg.rpc_cred);
-	if (task->tk_msg.rpc_cred) {
-		spin_lock(&rpc_credcache_lock);
-		task->tk_msg.rpc_cred->cr_count++;
-		task->tk_msg.rpc_cred->cr_expire = jiffies + task->tk_auth->au_expire;
-		spin_unlock(&rpc_credcache_lock);
-	}
+	if (task->tk_msg.rpc_cred)
+		get_rpccred(task->tk_msg.rpc_cred);
 }
 
 void
-rpcauth_releasecred(struct rpc_auth *auth, struct rpc_cred *cred)
+put_rpccred(struct rpc_cred *cred)
 {
-	spin_lock(&rpc_credcache_lock);
-	if (cred != NULL && cred->cr_count > 0) {
-		if (!--cred->cr_count && (cred->cr_flags & RPCAUTH_CRED_DEAD)) {
-			spin_unlock(&rpc_credcache_lock);
-			rpcauth_remove_credcache(auth, cred);
-			rpcauth_crdestroy(auth, cred);
-			return;
-		}
+	if (!atomic_dec_and_lock(&cred->cr_count, &rpc_credcache_lock))
+		return;
+
+	if (cred->cr_auth && cred->cr_flags & RPCAUTH_CRED_DEAD)
+		rpcauth_remove_credcache(cred);
+
+	if (!cred->cr_auth) {
+		spin_unlock(&rpc_credcache_lock);
+		rpcauth_crdestroy(cred);
+		return;
 	}
+	cred->cr_expire = jiffies + cred->cr_auth->au_expire;
 	spin_unlock(&rpc_credcache_lock);
 }
 
@@ -298,7 +314,7 @@
 	dprintk("RPC: %4d releasing %s cred %p\n",
 		task->tk_pid, auth->au_ops->au_name, cred);
 
-	rpcauth_releasecred(auth, cred);
+	put_rpccred(cred);
 	task->tk_msg.rpc_cred = NULL;
 }
 
@@ -306,10 +322,11 @@
 rpcauth_marshcred(struct rpc_task *task, u32 *p)
 {
 	struct rpc_auth	*auth = task->tk_auth;
+	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d marshaling %s cred %p\n",
-		task->tk_pid, auth->au_ops->au_name, task->tk_msg.rpc_cred);
-	return auth->au_ops->crmarshal(task, p,
+		task->tk_pid, auth->au_ops->au_name, cred);
+	return cred->cr_ops->crmarshal(task, p,
 				task->tk_flags & RPC_CALL_REALUID);
 }
 
@@ -317,20 +334,22 @@
 rpcauth_checkverf(struct rpc_task *task, u32 *p)
 {
 	struct rpc_auth	*auth = task->tk_auth;
+	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d validating %s cred %p\n",
-		task->tk_pid, auth->au_ops->au_name, task->tk_msg.rpc_cred);
-	return auth->au_ops->crvalidate(task, p);
+		task->tk_pid, auth->au_ops->au_name, cred);
+	return cred->cr_ops->crvalidate(task, p);
 }
 
 int
 rpcauth_refreshcred(struct rpc_task *task)
 {
 	struct rpc_auth	*auth = task->tk_auth;
+	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d refreshing %s cred %p\n",
-		task->tk_pid, auth->au_ops->au_name, task->tk_msg.rpc_cred);
-	task->tk_status = auth->au_ops->crrefresh(task);
+		task->tk_pid, auth->au_ops->au_name, cred);
+	task->tk_status = cred->cr_ops->crrefresh(task);
 	return task->tk_status;
 }
 
diff -u --recursive --new-file linux-2.4.6-file/net/sunrpc/auth_null.c linux-2.4.6-mmap/net/sunrpc/auth_null.c
--- linux-2.4.6-file/net/sunrpc/auth_null.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.6-mmap/net/sunrpc/auth_null.c	Fri Jul  6 11:57:05 2001
@@ -17,6 +17,8 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
+static struct rpc_credops	null_credops;
+
 static struct rpc_auth *
 nul_create(struct rpc_clnt *clnt)
 {
@@ -52,9 +54,10 @@
 
 	if (!(cred = (struct rpc_cred *) rpc_allocate(flags, sizeof(*cred))))
 		return NULL;
-	cred->cr_count = 0;
+	atomic_set(&cred->cr_count, 0);
 	cred->cr_flags = RPCAUTH_CRED_UPTODATE;
 	cred->cr_uid = current->uid;
+	cred->cr_ops = &null_credops;
 
 	return cred;
 }
@@ -124,7 +127,11 @@
 #endif
 	nul_create,
 	nul_destroy,
-	nul_create_cred,
+	nul_create_cred
+};
+
+static
+struct rpc_credops	null_credops = {
 	nul_destroy_cred,
 	nul_match,
 	nul_marshal,
diff -u --recursive --new-file linux-2.4.6-file/net/sunrpc/auth_unix.c linux-2.4.6-mmap/net/sunrpc/auth_unix.c
--- linux-2.4.6-file/net/sunrpc/auth_unix.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.6-mmap/net/sunrpc/auth_unix.c	Fri Jul  6 11:57:05 2001
@@ -33,6 +33,8 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
+static struct rpc_credops	unix_credops;
+
 static struct rpc_auth *
 unx_create(struct rpc_clnt *clnt)
 {
@@ -71,7 +73,7 @@
 	if (!(cred = (struct unx_cred *) rpc_allocate(flags, sizeof(*cred))))
 		return NULL;
 
-	cred->uc_count = 0;
+	atomic_set(&cred->uc_count, 0);
 	cred->uc_flags = RPCAUTH_CRED_UPTODATE;
 	if (flags & RPC_TASK_ROOTCREDS) {
 		cred->uc_uid = cred->uc_fsuid = 0;
@@ -91,6 +93,7 @@
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
+	cred->uc_base.cr_ops = &unix_credops;
 
 	return (struct rpc_cred *) cred;
 }
@@ -106,7 +109,7 @@
 	if (!(cred = (struct unx_cred *) rpc_malloc(task, sizeof(*cred))))
 		return NULL;
 
-	cred->uc_count = 1;
+	atomic_set(&cred->uc_count, 1);
 	cred->uc_flags = RPCAUTH_CRED_DEAD|RPCAUTH_CRED_UPTODATE;
 	cred->uc_uid   = uid;
 	cred->uc_gid   = gid;
@@ -236,7 +239,11 @@
 #endif
 	unx_create,
 	unx_destroy,
-	unx_create_cred,
+	unx_create_cred
+};
+
+static
+struct rpc_credops	unix_credops = {
 	unx_destroy_cred,
 	unx_match,
 	unx_marshal,
diff -u --recursive --new-file linux-2.4.6-file/net/sunrpc/sunrpc_syms.c linux-2.4.6-mmap/net/sunrpc/sunrpc_syms.c
--- linux-2.4.6-file/net/sunrpc/sunrpc_syms.c	Fri Jan 12 00:53:02 2001
+++ linux-2.4.6-mmap/net/sunrpc/sunrpc_syms.c	Fri Jul  6 11:57:05 2001
@@ -65,7 +65,7 @@
 EXPORT_SYMBOL(rpcauth_lookupcred);
 EXPORT_SYMBOL(rpcauth_bindcred);
 EXPORT_SYMBOL(rpcauth_matchcred);
-EXPORT_SYMBOL(rpcauth_releasecred);
+EXPORT_SYMBOL(put_rpccred);
 
 /* RPC server stuff */
 EXPORT_SYMBOL(svc_create);
