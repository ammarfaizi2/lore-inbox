Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRA3TMl>; Tue, 30 Jan 2001 14:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbRA3TMc>; Tue, 30 Jan 2001 14:12:32 -0500
Received: from pat.uio.no ([129.240.130.16]:21979 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132219AbRA3TMZ>;
	Tue, 30 Jan 2001 14:12:25 -0500
Message-ID: <14967.4623.607923.974341@charged.uio.no>
Date: Tue, 30 Jan 2001 20:12:15 +0100 (CET)
To: NFS maillist <nfs@lists.sourceforge.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CFT] Fix for the `getdents() cookie bug' in the 2.4.1 NFS client
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  I've set up a tentative fix for the problem we have against some NFS
servers that use cookies that don't fit into 32-bits signed. So far
reports have mainly involved IRIX servers (which use unsigned 64-bit
cookies by default on NFSv3 and in particular use (~0) to signify end
of directory) but there may be others out there.

  The appended patch adds a cookie dictionary on top of the existing
NFS directory code, to catch these cases. Essentially the idea is that
we cache all cookies on a more or less permanent basis (until the
inode disappears from cache). We then use the lookup index to the
cookies in our cache as the signed 32-bit value that is passed up to
userland.

  Could people who have noted this problem please give the appended
patch a whirl to see if it fixes their condition?

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.1/fs/nfs/dir.c linux-2.4.1-dir/fs/nfs/dir.c
--- linux-2.4.1/fs/nfs/dir.c	Sun Dec 10 18:55:48 2000
+++ linux-2.4.1-dir/fs/nfs/dir.c	Tue Jan 30 19:11:35 2001
@@ -68,6 +68,147 @@
 	setattr:	nfs_notify_change,
 };
 
+#define COOKIE_MAXDICTS		128
+#define COOKIE_SHIFT		6
+#define NCOOKIES		(1 << COOKIE_SHIFT)
+#define COOKIE_MASK		(NCOOKIES - 1)
+#define COOKIE_DICT(x)		((x) >> COOKIE_SHIFT)
+#define COOKIE_IDX(x)		((x) & COOKIE_MASK)
+#define COOKIE_HASH(x,y)	(((x) << COOKIE_SHIFT) + ((y) & COOKIE_MASK))
+
+struct nfs_cookiedict {
+	struct nfs_cookiedict	*next;
+	unsigned int		index;
+	unsigned int		nr;
+	u64			cookies[NCOOKIES];
+};
+
+static kmem_cache_t	*nfs_cookie_cachep;
+
+int nfs_init_cookiecache(void)
+{
+	nfs_cookie_cachep = kmem_cache_create("nfs_cookies",
+					      sizeof(struct nfs_cookiedict),
+					      0, SLAB_HWCACHE_ALIGN,
+					      NULL, NULL);
+	if (!nfs_cookie_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void nfs_destroy_cookiecache(void)
+{
+	if (kmem_cache_destroy(nfs_cookie_cachep))
+		printk(KERN_INFO "nfs_cookies: not all structures were freed\n");
+}
+
+static inline struct nfs_cookiedict* alloc_cookiedict(unsigned int index)
+{
+	struct nfs_cookiedict	*dict;
+
+	if (!(dict = kmem_cache_alloc(nfs_cookie_cachep, SLAB_KERNEL)))
+		return ERR_PTR(-ENOMEM);
+	dict->next = NULL;
+	dict->index = index;
+	dict->nr = 0;
+	return dict;
+}
+
+static inline void free_cookiedicts(struct nfs_cookiedict *dict)
+{
+	struct nfs_cookiedict	*freeme;
+
+	while ((freeme = dict) != NULL) {
+		dict = dict->next;
+		kmem_cache_free(nfs_cookie_cachep, freeme);
+	}
+}
+
+void nfs_zap_cookies(struct inode *inode)
+{
+	free_cookiedicts(inode->u.nfs_i.cookies);
+	inode->u.nfs_i.cookies = NULL;
+}
+
+/*
+ * Add a cookie to a directory cookie cache.
+ * Note: The limit on the number of cache structures
+ *	 we can have per inode. If we reach more than 8192
+ *	 (== COOKIE_MAXDICTS * NCOOKIES) entries, then the
+ *	 cache is cleared and we start afresh.
+ */
+static int nfs_add_cookie(struct inode *inode, u64 cookie)
+{
+	struct nfs_cookiedict	**q, *dict;
+	int			new_idx = 1, idx;
+
+	q = &inode->u.nfs_i.cookies;
+	for (;;) {
+		if (!(dict = *q)) {
+			if (new_idx > COOKIE_MAXDICTS) {
+				nfs_zap_cookies(inode);
+				new_idx = 1;
+			}
+			dict = alloc_cookiedict(new_idx);
+			if (IS_ERR(dict))
+				return PTR_ERR(dict);
+			*q = dict;
+		}
+		if (dict->nr < NCOOKIES)
+			break;
+		q = &dict->next;
+		new_idx = dict->index + 1;
+	}
+	idx = dict->nr++;
+	dict->cookies[idx] = cookie;
+	return COOKIE_HASH(dict->index,idx);
+}
+
+/*
+ * Provide a means of caching 64-bit NFS directory cookies,
+ * and translating them into signed integers (as expected
+ * by filldir).
+ */
+static int nfs_hashcookie(struct inode *inode, u64 cookie)
+{
+	struct nfs_cookiedict	*dict;
+	int			idx;
+
+	/* Null cookies are special */
+	if (!cookie)
+		return 0;
+	for (dict = inode->u.nfs_i.cookies; dict; dict = dict->next) {
+		for (idx = 0; idx < dict->nr; idx++) {
+			if (dict->cookies[idx] == cookie)
+				return COOKIE_HASH(dict->index, idx);
+		}
+	}
+	return nfs_add_cookie(inode, cookie);
+}
+
+/*
+ * Translate signed integers back into cached NFS cookies.
+ */
+static u64 nfs_getcookie(const struct inode *inode, int hash)
+{
+	struct nfs_cookiedict	*dict = inode->u.nfs_i.cookies;
+	int			idx_dict = COOKIE_DICT(hash);
+	int			idx = COOKIE_IDX(hash);
+
+	if (hash < 0)
+		return -EINVAL;
+	if (!hash || !dict)
+		return 0;
+	while (dict->next && dict->index < idx_dict)
+		dict = dict->next;
+	if (dict->nr <= idx) {
+		if (dict->next)
+			return dict->next->cookies[0];
+		idx = dict->nr - 1;
+	}
+	return dict->cookies[idx];
+}
+
 typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
 typedef struct {
 	struct file	*file;
@@ -252,24 +393,34 @@
 		   filldir_t filldir)
 {
 	struct file	*file = desc->file;
+	struct inode	*inode = file->f_dentry->d_inode;
 	struct nfs_entry *entry = desc->entry;
 	char		*start = kmap(desc->page),
 			*p = start + desc->page_offset;
-	unsigned long	fileid;
+	ino_t		fileid;
+	off_t		offset;
 	int		loop_count = 0,
 			res = 0;
 
 	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)desc->target);
 
+	offset = nfs_hashcookie(inode, entry->prev_cookie);
+	if (offset < 0)
+		return offset;
+
 	for(;;) {
 		/* Note: entry->prev_cookie contains the cookie for
 		 *	 retrieving the current dirent on the server */
 		fileid = nfs_fileid_to_ino_t(entry->ino);
 		res = filldir(dirent, entry->name, entry->len, 
-			      entry->prev_cookie, fileid, DT_UNKNOWN);
+			      offset, fileid, DT_UNKNOWN);
 		if (res < 0)
 			break;
-		file->f_pos = desc->target = entry->cookie;
+		desc->target = entry->cookie;
+		offset = nfs_hashcookie(inode, entry->cookie);
+		if (offset < 0)
+			return offset;
+		file->f_pos = offset;
 		p = (char *)desc->decode((u32 *)p, entry, desc->plus);
 		if (IS_ERR(p)) {
 			if (PTR_ERR(p) == -EAGAIN) {
@@ -384,7 +535,7 @@
 	memset(&my_entry, 0, sizeof(my_entry));
 
 	desc->file = filp;
-	desc->target = filp->f_pos;
+	desc->target = nfs_getcookie(inode, filp->f_pos);
 	desc->entry = &my_entry;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 
diff -u --recursive --new-file linux-2.4.1/fs/nfs/inode.c linux-2.4.1-dir/fs/nfs/inode.c
--- linux-2.4.1/fs/nfs/inode.c	Tue Jan 30 11:35:53 2001
+++ linux-2.4.1-dir/fs/nfs/inode.c	Tue Jan 30 16:05:59 2001
@@ -108,6 +108,7 @@
 	inode->u.nfs_i.ndirty = 0;
 	inode->u.nfs_i.ncommit = 0;
 	inode->u.nfs_i.npages = 0;
+	inode->u.nfs_i.cookies = NULL;
 	NFS_CACHEINV(inode);
 	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
@@ -124,6 +125,10 @@
 	if (nfs_have_writebacks(inode) || nfs_have_read(inode)) {
 		printk(KERN_ERR "nfs_delete_inode: inode %ld has pending RPC requests\n", inode->i_ino);
 	}
+	/*
+	 * Don't forget to zap directory cookies.
+	 */
+	nfs_zap_cookies(inode);
 
 	clear_inode(inode);
 }
@@ -1059,6 +1064,8 @@
 extern void nfs_destroy_nfspagecache(void);
 extern int nfs_init_readpagecache(void);
 extern int nfs_destroy_readpagecache(void);
+extern int nfs_init_cookiecache(void);
+extern int nfs_destroy_cookiecache(void);
 
 /*
  * Initialize NFS
@@ -1076,6 +1083,10 @@
 	if (err)
 		return err;
 
+	err = nfs_init_cookiecache();
+	if (err)
+		return err;
+
 #ifdef CONFIG_PROC_FS
 	rpc_proc_register(&nfs_rpcstat);
 #endif
@@ -1100,6 +1111,7 @@
 void
 cleanup_module(void)
 {
+	nfs_destroy_cookiecache();
 	nfs_destroy_readpagecache();
 	nfs_destroy_nfspagecache();
 #ifdef CONFIG_PROC_FS
diff -u --recursive --new-file linux-2.4.1/include/linux/nfs_fs.h linux-2.4.1-dir/include/linux/nfs_fs.h
--- linux-2.4.1/include/linux/nfs_fs.h	Tue Jan 30 11:44:12 2001
+++ linux-2.4.1-dir/include/linux/nfs_fs.h	Tue Jan 30 19:22:57 2001
@@ -176,6 +176,8 @@
 extern struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
 
+extern void   nfs_zap_cookies(struct inode *);
+
 /*
  * linux/fs/nfs/symlink.c
  */
diff -u --recursive --new-file linux-2.4.1/include/linux/nfs_fs_i.h linux-2.4.1-dir/include/linux/nfs_fs_i.h
--- linux-2.4.1/include/linux/nfs_fs_i.h	Tue Jan 30 11:43:55 2001
+++ linux-2.4.1-dir/include/linux/nfs_fs_i.h	Tue Jan 30 19:22:39 2001
@@ -50,6 +50,9 @@
 	unsigned long		attrtimeo;
 	unsigned long		attrtimeo_timestamp;
 
+	/* Readdir cookie cache */
+	struct nfs_cookiedict	*cookies;
+
 	/*
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
