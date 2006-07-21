Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWGULuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWGULuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWGULuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:50:15 -0400
Received: from outmx021.isp.belgacom.be ([195.238.4.202]:54478 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161049AbWGULuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:50:12 -0400
Date: Fri, 21 Jul 2006 13:50:55 +0200
To: linux-kernel@vger.kernel.org
Cc: rathamahata@php4.ru, sfrench@samba.org, jffs-dev@axis.com,
       shaggy@austin.ibm.com, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com, raven@themaw.net
Subject: [PATCH] fs: Memory allocation cleanups
Message-ID: <20060721115055.GA12329@issaris.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: takis@issaris.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

- Remove useless casts from k(m|z)alloc and vmallocs
- One conversion of kmalloc+memset to kzalloc

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 fs/autofs4/inode.c      |    4 +---
 fs/befs/btree.c         |    2 +-
 fs/befs/debug.c         |    6 +++---
 fs/binfmt_misc.c        |    2 +-
 fs/binfmt_som.c         |    2 +-
 fs/cifs/cifssmb.c       |    3 +--
 fs/cifs/misc.c          |    8 ++------
 fs/file.c               |    8 ++++----
 fs/jffs/inode-v23.c     |    4 ++--
 fs/jffs/intrep.c        |   14 +++++++-------
 fs/jfs/jfs_dtree.c      |   14 ++++----------
 fs/jfs/jfs_imap.c       |    2 +-
 fs/lockd/svcshare.c     |    3 +--
 fs/nfs/nfs4proc.c       |    2 +-
 fs/reiserfs/xattr_acl.c |    3 +--
 15 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index fde78b1..8e40bc1 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -305,13 +305,11 @@ int autofs4_fill_super(struct super_bloc
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 
-	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
 	DPRINTK("starting up, sbi = %p",sbi);
 
-	memset(sbi, 0, sizeof(*sbi));
-
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->root = NULL;
diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 76e2197..8ac2126 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -261,7 +261,7 @@ befs_btree_find(struct super_block *sb, 
 		goto error;
 	}
 
-	this_node = (befs_btree_node *) kmalloc(sizeof (befs_btree_node),
+	this_node = kmalloc(sizeof (befs_btree_node),
 						GFP_NOFS);
 	if (!this_node) {
 		befs_error(sb, "befs_btree_find() failed to allocate %u "
diff --git a/fs/befs/debug.c b/fs/befs/debug.c
index 875cc0a..2f4ba6c 100644
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -29,7 +29,7 @@ void
 befs_error(const struct super_block *sb, const char *fmt, ...)
 {
 	va_list args;
-	char *err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+	char *err_buf = kmalloc(ERRBUFSIZE, GFP_KERNEL);
 	if (err_buf == NULL) {
 		printk(KERN_ERR "could not allocate %d bytes\n", ERRBUFSIZE);
 		return;
@@ -47,7 +47,7 @@ void
 befs_warning(const struct super_block *sb, const char *fmt, ...)
 {
 	va_list args;
-	char *err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+	char *err_buf = kmalloc(ERRBUFSIZE, GFP_KERNEL);
 	if (err_buf == NULL) {
 		printk(KERN_ERR "could not allocate %d bytes\n", ERRBUFSIZE);
 		return;
@@ -71,7 +71,7 @@ #ifdef CONFIG_BEFS_DEBUG
 	char *err_buf = NULL;
 
 	if (BEFS_SB(sb)->mount_opts.debug) {
-		err_buf = (char *) kmalloc(ERRBUFSIZE, GFP_KERNEL);
+		err_buf = kmalloc(ERRBUFSIZE, GFP_KERNEL);
 		if (err_buf == NULL) {
 			printk(KERN_ERR "could not allocate %d bytes\n",
 				ERRBUFSIZE);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 34ebbc1..1178403 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -313,7 +313,7 @@ static Node *create_entry(const char __u
 
 	err = -ENOMEM;
 	memsize = sizeof(Node) + count + 8;
-	e = (Node *) kmalloc(memsize, GFP_USER);
+	e = kmalloc(memsize, GFP_USER);
 	if (!e)
 		goto out;
 
diff --git a/fs/binfmt_som.c b/fs/binfmt_som.c
index 32b5d62..cc5ef99 100644
--- a/fs/binfmt_som.c
+++ b/fs/binfmt_som.c
@@ -208,7 +208,7 @@ load_som_binary(struct linux_binprm * bp
 	size = som_ex->aux_header_size;
 	if (size > SOM_PAGESIZE)
 		goto out;
-	hpuxhdr = (struct som_exec_auxhdr *) kmalloc(size, GFP_KERNEL);
+	hpuxhdr = kmalloc(size, GFP_KERNEL);
 	if (!hpuxhdr)
 		goto out;
 
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 19678c5..aaa68a1 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4788,8 +4788,7 @@ int CIFSSMBNotify(const int xid, struct 
 	} else {
 		/* Add file to outstanding requests */
 		/* BB change to kmem cache alloc */	
-		dnotify_req = (struct dir_notify_req *) kmalloc(
-						sizeof(struct dir_notify_req),
+		dnotify_req = kmalloc(sizeof(struct dir_notify_req),
 						 GFP_KERNEL);
 		if(dnotify_req) {
 			dnotify_req->Pid = pSMB->hdr.Pid;
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 22c937e..9675820 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -71,9 +71,7 @@ sesInfoAlloc(void)
 {
 	struct cifsSesInfo *ret_buf;
 
-	ret_buf =
-	    (struct cifsSesInfo *) kzalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsSesInfo), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&sesInfoAllocCount);
@@ -109,9 +107,7 @@ struct cifsTconInfo *
 tconInfoAlloc(void)
 {
 	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kzalloc(sizeof (struct cifsTconInfo),
-					    GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsTconInfo), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&tconInfoAllocCount);
diff --git a/fs/file.c b/fs/file.c
index b3c6b82..4158c37 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -44,9 +44,9 @@ struct file ** alloc_fd_array(int num)
 	int size = num * sizeof(struct file *);
 
 	if (size <= PAGE_SIZE)
-		new_fds = (struct file **) kmalloc(size, GFP_KERNEL);
+		new_fds = kmalloc(size, GFP_KERNEL);
 	else 
-		new_fds = (struct file **) vmalloc(size);
+		new_fds = vmalloc(size);
 	return new_fds;
 }
 
@@ -213,9 +213,9 @@ fd_set * alloc_fdset(int num)
 	int size = num / 8;
 
 	if (size <= PAGE_SIZE)
-		new_fdset = (fd_set *) kmalloc(size, GFP_KERNEL);
+		new_fdset = kmalloc(size, GFP_KERNEL);
 	else
-		new_fdset = (fd_set *) vmalloc(size);
+		new_fdset = vmalloc(size);
 	return new_fdset;
 }
 
diff --git a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
index 9306869..ac831aa 100644
--- a/fs/jffs/inode-v23.c
+++ b/fs/jffs/inode-v23.c
@@ -819,7 +819,7 @@ jffs_mkdir(struct inode *dir, struct den
 
 	D1({
 	        int len = dentry->d_name.len;
-		char *_name = (char *) kmalloc(len + 1, GFP_KERNEL);
+		char *_name = kmalloc(len + 1, GFP_KERNEL);
 		memcpy(_name, dentry->d_name.name, len);
 		_name[len] = '\0';
 		printk("***jffs_mkdir(): dir = 0x%p, name = \"%s\", "
@@ -965,7 +965,7 @@ jffs_remove(struct inode *dir, struct de
 	D1({
 		int len = dentry->d_name.len;
 		const char *name = dentry->d_name.name;
-		char *_name = (char *) kmalloc(len + 1, GFP_KERNEL);
+		char *_name = kmalloc(len + 1, GFP_KERNEL);
 		memcpy(_name, name, len);
 		_name[len] = '\0';
 		printk("***jffs_remove(): file = \"%s\", ino = %ld\n", _name, dentry->d_inode->i_ino);
diff --git a/fs/jffs/intrep.c b/fs/jffs/intrep.c
index 9000f1e..fd637e9 100644
--- a/fs/jffs/intrep.c
+++ b/fs/jffs/intrep.c
@@ -435,7 +435,7 @@ jffs_checksum_flash(struct mtd_info *mtd
 	int i, length;
 
 	/* Allocate read buffer */
-	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+	read_buf = kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
 	if (!read_buf) {
 		printk(KERN_NOTICE "kmalloc failed in jffs_checksum_flash()\n");
 		return -ENOMEM;
@@ -747,11 +747,11 @@ #define READ_AHEAD_BYTES        4096 /* 
 
 
 	/* Allocate read buffers */
-	read_buf1 = (__u8 *) kmalloc (sizeof(__u8) * READ_AHEAD_BYTES, GFP_KERNEL);
+	read_buf1 = kmalloc (sizeof(__u8) * READ_AHEAD_BYTES, GFP_KERNEL);
 	if (!read_buf1)
 		return -ENOMEM;
 
-	read_buf2 = (__u8 *) kmalloc (sizeof(__u8) * READ_AHEAD_BYTES, GFP_KERNEL);
+	read_buf2 = kmalloc (sizeof(__u8) * READ_AHEAD_BYTES, GFP_KERNEL);
 	if (!read_buf2) {
 		kfree(read_buf1);
 		return -ENOMEM;
@@ -879,7 +879,7 @@ #define NUMFREEALLOWED     2        /* 2
 	}
 
 	/* Allocate read buffer */
-	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+	read_buf = kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
 	if (!read_buf) {
 		flash_safe_release(fmc->mtd);
 		return -ENOMEM;
@@ -1466,7 +1466,7 @@ jffs_insert_node(struct jffs_control *c,
 			kfree(f->name);
 			DJM(no_name--);
 		}
-		if (!(f->name = (char *) kmalloc(raw_inode->nsize + 1,
+		if (!(f->name = kmalloc(raw_inode->nsize + 1,
 						 GFP_KERNEL))) {
 			return -ENOMEM;
 		}
@@ -1740,7 +1740,7 @@ jffs_find_child(struct jffs_file *dir, c
 		printk("jffs_find_child(): Found \"%s\".\n", f->name);
 	}
 	else {
-		char *copy = (char *) kmalloc(len + 1, GFP_KERNEL);
+		char *copy = kmalloc(len + 1, GFP_KERNEL);
 		if (copy) {
 			memcpy(copy, name, len);
 			copy[len] = '\0';
@@ -2630,7 +2630,7 @@ jffs_print_tree(struct jffs_file *first_
 		return;
 	}
 
-	if (!(space = (char *) kmalloc(indent + 1, GFP_KERNEL))) {
+	if (!(space = kmalloc(indent + 1, GFP_KERNEL))) {
 		printk("jffs_print_tree(): Out of memory!\n");
 		return;
 	}
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 6c3f083..1458291 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -592,9 +592,7 @@ int dtSearch(struct inode *ip, struct co
 	struct component_name ciKey;
 	struct super_block *sb = ip->i_sb;
 
-	ciKey.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
-				GFP_NOFS);
+	ciKey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t), GFP_NOFS);
 	if (ciKey.name == 0) {
 		rc = -ENOMEM;
 		goto dtSearch_Exit2;
@@ -957,9 +955,7 @@ static int dtSplitUp(tid_t tid,
 	smp = split->mp;
 	sp = DT_PAGE(ip, smp);
 
-	key.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t),
-				GFP_NOFS);
+	key.name = kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t), GFP_NOFS);
 	if (key.name == 0) {
 		DT_PUTPAGE(smp);
 		rc = -ENOMEM;
@@ -3777,13 +3773,11 @@ static int ciGetLeafPrefixKey(dtpage_t *
 	struct component_name lkey;
 	struct component_name rkey;
 
-	lkey.name = (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
-					GFP_KERNEL);
+	lkey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t), GFP_KERNEL);
 	if (lkey.name == NULL)
 		return -ENOSPC;
 
-	rkey.name = (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
-					GFP_KERNEL);
+	rkey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t), GFP_KERNEL);
 	if (rkey.name == NULL) {
 		kfree(lkey.name);
 		return -ENOSPC;
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ccbe60a..6f6f566 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -120,7 +120,7 @@ int diMount(struct inode *ipimap)
 	 * allocate/initialize the in-memory inode map control structure
 	 */
 	/* allocate the in-memory inode map control structure. */
-	imap = (struct inomap *) kmalloc(sizeof(struct inomap), GFP_KERNEL);
+	imap = kmalloc(sizeof(struct inomap), GFP_KERNEL);
 	if (imap == NULL) {
 		jfs_err("diMount: kmalloc returned NULL!");
 		return -ENOMEM;
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 27288c8..0603638 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -39,8 +39,7 @@ nlmsvc_share_file(struct nlm_host *host,
 			return nlm_lck_denied;
 	}
 
-	share = (struct nlm_share *) kmalloc(sizeof(*share) + oh->len,
-						GFP_KERNEL);
+	share = kmalloc(sizeof(*share) + oh->len, GFP_KERNEL);
 	if (share == NULL)
 		return nlm_lck_denied_nolocks;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6ee97f..64efe59 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1960,7 +1960,7 @@ static int nfs4_proc_unlink_setup(struct
 	struct nfs_server *server = NFS_SERVER(dir->d_inode);
 	struct unlink_desc *up;
 
-	up = (struct unlink_desc *) kmalloc(sizeof(*up), GFP_KERNEL);
+	up = kmalloc(sizeof(*up), GFP_KERNEL);
 	if (!up)
 		return -ENOMEM;
 	
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index 97ae1b9..657f1a5 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -135,8 +135,7 @@ static void *posix_acl_to_disk(const str
 	int n;
 
 	*size = reiserfs_acl_size(acl->a_count);
-	ext_acl = (reiserfs_acl_header *) kmalloc(sizeof(reiserfs_acl_header) +
-						  acl->a_count *
+	ext_acl = kmalloc(sizeof(reiserfs_acl_header) + acl->a_count *
 						  sizeof(reiserfs_acl_entry),
 						  GFP_NOFS);
 	if (!ext_acl)
-- 
1.4.2.rc1.ge7a0-dirty

