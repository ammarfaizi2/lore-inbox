Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbQKPNEA>; Thu, 16 Nov 2000 08:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbQKPNDu>; Thu, 16 Nov 2000 08:03:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10400 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130152AbQKPNDi>;
	Thu, 16 Nov 2000 08:03:38 -0500
Date: Thu, 16 Nov 2000 07:33:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get_empty_inode() cleanup
Message-ID: <Pine.GSO.4.21.0011160723060.11017-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Almost all (== all filesystem and then some) callers of
get_empty_inode() follow it with
	inode->i_sb = some_sb;
	inode->i_dev = some_sb->s_dev;
Some of them do it twice for no good reason (assign the same value,
even though neither ->i_sb nor ->i_dev could change in interval).
Some of them duplicate the initializations already done by get_empty_inode()
(e.g. ->i_size to 0, ->i_nlink to 1, etc.).

	Patch below adds an inlined function
struct inode *new_inode(struct super_block *sb)
{
	struct inode *inode = get_empty_inode();
	if (inode) {
		inode->i_sb = sb;
		inode->i_dev = sb->s_dev;
	}
	return inode;
}
and converts the aforementioned callers of get_empty_inode() to new_inode().
It also removes duplicate initializations. fs/ntfs/inode.c:new_inode() had
been renamed to ntfs_new_inode() to avoid (the only) name conflict.
Could you apply it?
							Cheers,
								Al
diff -urN rc11-pre5/fs/adfs/inode.c rc11-5-new_inode/fs/adfs/inode.c
--- rc11-pre5/fs/adfs/inode.c	Wed Oct  4 03:44:52 2000
+++ rc11-5-new_inode/fs/adfs/inode.c	Tue Nov 14 22:18:47 2000
@@ -245,13 +245,11 @@
 {
 	struct inode *inode;
 
-	inode = get_empty_inode();
+	inode = new_inode(sb);
 	if (!inode)
 		goto out;
 
 	inode->i_version = ++event;
-	inode->i_sb	 = sb;
-	inode->i_dev	 = sb->s_dev;
 	inode->i_uid	 = sb->u.adfs_sb.s_uid;
 	inode->i_gid	 = sb->u.adfs_sb.s_gid;
 	inode->i_ino	 = obj->file_id;
diff -urN rc11-pre5/fs/affs/inode.c rc11-5-new_inode/fs/affs/inode.c
--- rc11-pre5/fs/affs/inode.c	Tue Sep 12 09:10:34 2000
+++ rc11-5-new_inode/fs/affs/inode.c	Tue Nov 14 22:18:20 2000
@@ -306,18 +306,19 @@
 	struct super_block	*sb;
 	s32			 block;
 
-	if (!dir || !(inode = get_empty_inode()))
+	if (!dir)
 		return NULL;
 
 	sb = dir->i_sb;
-	inode->i_sb    = sb;
+	inode = new_inode(sb);
+	if (!inode)
+		return NULL;
 
 	if (!(block = affs_new_header((struct inode *)dir))) {
 		iput(inode);
 		return NULL;
 	}
 
-	inode->i_dev     = sb->s_dev;
 	inode->i_uid     = current->fsuid;
 	inode->i_gid     = current->fsgid;
 	inode->i_ino     = block;
diff -urN rc11-pre5/fs/autofs4/inode.c rc11-5-new_inode/fs/autofs4/inode.c
--- rc11-pre5/fs/autofs4/inode.c	Thu Apr 27 22:09:53 2000
+++ rc11-5-new_inode/fs/autofs4/inode.c	Tue Nov 14 22:17:29 2000
@@ -292,14 +292,12 @@
 struct inode *autofs4_get_inode(struct super_block *sb,
 				struct autofs_info *inf)
 {
-	struct inode *inode = get_empty_inode();
+	struct inode *inode = new_inode(sb);
 
 	if (inode == NULL)
 		return NULL;
 
 	inf->inode = inode;
-	inode->i_sb = sb;
-	inode->i_dev = sb->s_dev;
 	inode->i_mode = inf->mode;
 	if (sb->s_root) {
 		inode->i_uid = sb->s_root->d_inode->i_uid;
@@ -308,13 +306,9 @@
 		inode->i_uid = 0;
 		inode->i_gid = 0;
 	}
-	inode->i_size = 0;
 	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_rdev = 0;
-	inode->i_nlink = 1;
-	inode->i_op = NULL;
-	inode->i_fop = NULL;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 
 	if (S_ISDIR(inf->mode)) {
diff -urN rc11-pre5/fs/bfs/dir.c rc11-5-new_inode/fs/bfs/dir.c
--- rc11-pre5/fs/bfs/dir.c	Thu Nov  2 22:38:56 2000
+++ rc11-5-new_inode/fs/bfs/dir.c	Tue Nov 14 22:14:34 2000
@@ -80,10 +80,9 @@
 	struct super_block * s = dir->i_sb;
 	unsigned long ino;
 
-	inode = get_empty_inode();
+	inode = new_inode(s);
 	if (!inode)
 		return -ENOSPC;
-	inode->i_sb = s;
 	ino = find_first_zero_bit(s->su_imap, s->su_lasti);
 	if (ino > s->su_lasti) {
 		iput(inode);
@@ -91,7 +90,6 @@
 	}
 	set_bit(ino, s->su_imap);	
 	s->su_freei--;
-	inode->i_dev = s->s_dev;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
diff -urN rc11-pre5/fs/cramfs/inode.c rc11-5-new_inode/fs/cramfs/inode.c
--- rc11-pre5/fs/cramfs/inode.c	Thu Nov  2 22:38:56 2000
+++ rc11-5-new_inode/fs/cramfs/inode.c	Tue Nov 14 22:13:12 2000
@@ -34,7 +34,7 @@
 
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
-	struct inode * inode = get_empty_inode();
+	struct inode * inode = new_inode(sb);
 
 	if (inode) {
 		inode->i_mode = cramfs_inode->mode;
@@ -42,14 +42,10 @@
 		inode->i_size = cramfs_inode->size;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
-		inode->i_nlink = 1; /* arguably wrong for directories,
-				       but it's the best we can do
-				       without reading the directory
-				       contents.  1 yields the right
-				       result in GNU find, even
-				       without -noleaf option. */
+		/* inode->i_nlink is left 1 - arguably wrong for directories,
+		   but it's the best we can do without reading the directory
+	           contents.  1 yields the right result in GNU find, even
+		   without -noleaf option. */
 		insert_inode_hash(inode);
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &generic_ro_fops;
diff -urN rc11-pre5/fs/devpts/inode.c rc11-5-new_inode/fs/devpts/inode.c
--- rc11-pre5/fs/devpts/inode.c	Thu Jul 27 09:35:58 2000
+++ rc11-5-new_inode/fs/devpts/inode.c	Tue Nov 14 22:13:54 2000
@@ -140,14 +140,11 @@
 		goto fail_free;
 	}
 
-	inode = get_empty_inode();
+	inode = new_inode(s);
 	if (!inode)
 		goto fail_free;
-	inode->i_sb = s;
-	inode->i_dev = s->s_dev;
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_size = 0;
 	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
 	inode->i_uid = inode->i_gid = 0;
@@ -192,11 +189,9 @@
 	if ( sbi->inodes[number] )
 		return; /* Already registered, this does happen */
 		
-	inode = get_empty_inode();
+	inode = new_inode(sb);
 	if (!inode)
 		return;
-	inode->i_sb = sb;
-	inode->i_dev = sb->s_dev;
 	inode->i_ino = number+2;
 	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
diff -urN rc11-pre5/fs/ext2/ialloc.c rc11-5-new_inode/fs/ext2/ialloc.c
--- rc11-pre5/fs/ext2/ialloc.c	Wed Oct  4 03:44:54 2000
+++ rc11-5-new_inode/fs/ext2/ialloc.c	Tue Nov 14 22:06:08 2000
@@ -274,15 +274,13 @@
 		return NULL;
 	}
 
-	inode = get_empty_inode ();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode) {
 		*err = -ENOMEM;
 		return NULL;
 	}
 
-	sb = dir->i_sb;
-	inode->i_sb = sb;
-	inode->i_flags = 0;
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
 repeat:
@@ -430,9 +428,6 @@
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	inode->i_mode = mode;
-	inode->i_sb = sb;
-	inode->i_nlink = 1;
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
diff -urN rc11-pre5/fs/fat/inode.c rc11-5-new_inode/fs/fat/inode.c
--- rc11-pre5/fs/fat/inode.c	Tue Sep 12 09:10:37 2000
+++ rc11-5-new_inode/fs/fat/inode.c	Tue Nov 14 22:15:24 2000
@@ -138,13 +138,11 @@
 	inode = fat_iget(sb, ino);
 	if (inode)
 		goto out;
-	inode = get_empty_inode();
+	inode = new_inode(sb);
 	*res = -ENOMEM;
 	if (!inode)
 		goto out;
 	*res = 0;
-	inode->i_sb = sb;
-	inode->i_dev = sb->s_dev;
 	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
 	fat_fill_inode(inode, de);
 	fat_attach(inode, ino);
@@ -658,11 +656,9 @@
 	if (! sbi->nls_io)
 		sbi->nls_io = load_nls_default();
 
-	root_inode=get_empty_inode();
+	root_inode=new_inode(sb);
 	if (!root_inode)
 		goto out_unload_nls;
-	root_inode->i_sb = sb;
-	root_inode->i_dev = sb->s_dev;
 	root_inode->i_ino = MSDOS_ROOT_INO;
 	fat_read_root(root_inode);
 	insert_inode_hash(root_inode);
diff -urN rc11-pre5/fs/jffs/inode-v23.c rc11-5-new_inode/fs/jffs/inode-v23.c
--- rc11-pre5/fs/jffs/inode-v23.c	Tue Sep 12 09:10:39 2000
+++ rc11-5-new_inode/fs/jffs/inode-v23.c	Thu Nov 16 08:37:00 2000
@@ -327,17 +327,15 @@
 	struct inode * inode;
 	struct jffs_control *c;
 
-	inode = get_empty_inode();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode) {
 		*err = -ENOMEM;
 		return NULL;
 	}
 
-	sb = dir->i_sb;
 	c = (struct jffs_control *)sb->u.generic_sbp;
 
-	inode->i_sb = sb;
-	inode->i_dev = sb->s_dev;
 	inode->i_ino = raw_inode->ino;
 	inode->i_mode = raw_inode->mode;
 	inode->i_nlink = raw_inode->nlink;
diff -urN rc11-pre5/fs/minix/bitmap.c rc11-5-new_inode/fs/minix/bitmap.c
--- rc11-pre5/fs/minix/bitmap.c	Thu Nov  2 22:38:58 2000
+++ rc11-5-new_inode/fs/minix/bitmap.c	Tue Nov 14 22:08:39 2000
@@ -224,14 +224,12 @@
 	struct buffer_head * bh;
 	int i,j;
 
-	inode = get_empty_inode();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode) {
 		*error = -ENOMEM;
 		return NULL;
 	}
-	sb = dir->i_sb;
-	inode->i_sb = sb;
-	inode->i_flags = 0;
 	j = 8192;
 	bh = NULL;
 	*error = -ENOSPC;
@@ -259,8 +257,6 @@
 		unlock_super(sb);
 		return NULL;
 	}
-	inode->i_nlink = 1;
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_ino = j;
diff -urN rc11-pre5/fs/ncpfs/inode.c rc11-5-new_inode/fs/ncpfs/inode.c
--- rc11-pre5/fs/ncpfs/inode.c	Sat Jul 29 12:19:48 2000
+++ rc11-5-new_inode/fs/ncpfs/inode.c	Thu Nov 16 08:37:22 2000
@@ -214,13 +214,11 @@
 		return NULL;
 	}
 
-	inode = get_empty_inode();
+	inode = new_inode(sb);
 	if (inode) {
 		init_MUTEX(&NCP_FINFO(inode)->open_sem);
 		atomic_set(&NCP_FINFO(inode)->opened, info->opened);
 
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
 		inode->i_ino = info->ino;
 		ncp_set_attr(inode, info);
 		if (S_ISREG(inode->i_mode)) {
diff -urN rc11-pre5/fs/nfs/inode.c rc11-5-new_inode/fs/nfs/inode.c
--- rc11-pre5/fs/nfs/inode.c	Wed Oct  4 03:44:56 2000
+++ rc11-5-new_inode/fs/nfs/inode.c	Thu Nov 16 08:37:44 2000
@@ -720,11 +720,9 @@
 	if ((dentry->d_parent->d_inode->u.nfs_i.flags & NFS_IS_SNAPSHOT) ||
 	    (dentry->d_name.len == 9 &&
 	     memcmp(dentry->d_name.name, ".snapshot", 9) == 0)) {
-		struct inode *inode = get_empty_inode();
+		struct inode *inode = new_inode(sb);
 		if (!inode)
-			goto out;	
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
+			goto out;
 		inode->i_flags = 0;
 		inode->i_ino = nfs_fattr_to_ino_t(fattr);
 		nfs_read_inode(inode);
diff -urN rc11-pre5/fs/ntfs/fs.c rc11-5-new_inode/fs/ntfs/fs.c
--- rc11-pre5/fs/ntfs/fs.c	Thu Nov  2 22:38:59 2000
+++ rc11-5-new_inode/fs/ntfs/fs.c	Thu Nov 16 08:38:51 2000
@@ -428,7 +428,7 @@
 	int error=0;
 	ntfs_attribute *si;
 
-	r=get_empty_inode();
+	r=new_inode(dir->i_sb);
 	if(!r){
 		error=ENOMEM;
 		goto fail;
@@ -456,8 +456,6 @@
 
 	r->i_uid=vol->uid;
 	r->i_gid=vol->gid;
-	r->i_nlink=1;
-	r->i_sb=dir->i_sb;
 	/* FIXME: dirty? dev? */
 	/* get the file modification times from the standard information */
 	si=ntfs_find_attr(ino,vol->at_standard_information,NULL);
@@ -502,7 +500,7 @@
 		goto out;
 
 	error = EIO;
-	r = get_empty_inode();
+	r = new_inode(dir->i_sb);
 	if (!r)
 		goto out;
 	
@@ -522,8 +520,6 @@
 		goto out;
 	r->i_uid = vol->uid;
 	r->i_gid = vol->gid;
-	r->i_nlink = 1;
-	r->i_sb = dir->i_sb;
 	si = ntfs_find_attr(ino,vol->at_standard_information,NULL);
 	if(si){
 		char *attr = si->d.data;
diff -urN rc11-pre5/fs/pipe.c rc11-5-new_inode/fs/pipe.c
--- rc11-pre5/fs/pipe.c	Thu Nov  2 22:38:59 2000
+++ rc11-5-new_inode/fs/pipe.c	Thu Nov 16 08:44:01 2000
@@ -608,14 +608,12 @@
 
 static struct super_block * pipefs_read_super(struct super_block *sb, void *data, int silent)
 {
-	struct inode *root = get_empty_inode();
+	struct inode *root = new_inode(sb);
 	if (!root)
 		return NULL;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
 	root->i_uid = root->i_gid = 0;
 	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
-	root->i_sb = sb;
-	root->i_dev = sb->s_dev;
 	sb->s_blocksize = 1024;
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = PIPEFS_MAGIC;
diff -urN rc11-pre5/fs/proc/base.c rc11-5-new_inode/fs/proc/base.c
--- rc11-pre5/fs/proc/base.c	Tue Nov 14 20:26:38 2000
+++ rc11-5-new_inode/fs/proc/base.c	Thu Nov 16 08:39:27 2000
@@ -626,14 +626,12 @@
 
 	/* We need a new inode */
 	
-	inode = get_empty_inode();
+	inode = new_inode(sb);
 	if (!inode)
 		goto out;
 
 	/* Common stuff */
 
-	inode->i_sb = sb;
-	inode->i_dev = sb->s_dev;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
 
@@ -918,11 +916,9 @@
 	name = dentry->d_name.name;
 	len = dentry->d_name.len;
 	if (len == 4 && !memcmp(name, "self", 4)) {
-		inode = get_empty_inode();
+		inode = new_inode(dir->i_sb);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		inode->i_sb = dir->i_sb;
-		inode->i_dev = dir->i_sb->s_dev;
 		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		inode->i_ino = fake_ino(0, PROC_PID_INO);
 		inode->u.proc_i.file = NULL;
diff -urN rc11-pre5/fs/ramfs/inode.c rc11-5-new_inode/fs/ramfs/inode.c
--- rc11-pre5/fs/ramfs/inode.c	Tue Nov 14 20:26:38 2000
+++ rc11-5-new_inode/fs/ramfs/inode.c	Tue Nov 14 22:11:37 2000
@@ -109,21 +109,15 @@
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev)
 {
-	struct inode * inode = get_empty_inode();
+	struct inode * inode = new_inode(sb);
 
 	if (inode) {
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
 		inode->i_gid = current->fsgid;
-		inode->i_size = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = to_kdev_t(dev);
-		inode->i_nlink = 1;
-		inode->i_op = NULL;
-		inode->i_fop = NULL;
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
diff -urN rc11-pre5/fs/smbfs/inode.c rc11-5-new_inode/fs/smbfs/inode.c
--- rc11-pre5/fs/smbfs/inode.c	Wed Oct  4 03:44:58 2000
+++ rc11-5-new_inode/fs/smbfs/inode.c	Thu Nov 16 08:39:45 2000
@@ -78,11 +78,9 @@
 
 	DEBUG1("smb_iget: %p\n", fattr);
 
-	result = get_empty_inode();
+	result = new_inode(sb);
 	if (!result)
 		return result;
-	result->i_sb = sb;
-	result->i_dev = sb->s_dev;
 	result->i_ino = fattr->f_ino;
 	memset(&(result->u.smbfs_i), 0, sizeof(result->u.smbfs_i));
 	smb_set_inode_attr(result, fattr);
diff -urN rc11-pre5/fs/sysv/ialloc.c rc11-5-new_inode/fs/sysv/ialloc.c
--- rc11-pre5/fs/sysv/ialloc.c	Tue Sep 12 09:10:44 2000
+++ rc11-5-new_inode/fs/sysv/ialloc.c	Tue Nov 14 22:10:03 2000
@@ -91,10 +91,12 @@
 	struct sysv_inode * raw_inode;
 	int i,j,ino,block;
 
-	if (!dir || !(inode = get_empty_inode()))
+	if (!dir)
 		return NULL;
 	sb = dir->i_sb;
-	inode->i_sb = sb;
+	inode = new_inode(sb);
+	if (!inode)
+		return NULL;
 	lock_super(sb);		/* protect against task switches */
 	if ((*sb->sv_sb_fic_count == 0)
 	    || (*sv_sb_fic_inode(sb,(*sb->sv_sb_fic_count)-1) == 0) /* Applies only to SystemV2 FS */
@@ -131,7 +133,6 @@
 	mark_buffer_dirty(sb->sv_bh1); /* super-block has been modified */
 	if (sb->sv_bh1 != sb->sv_bh2) mark_buffer_dirty(sb->sv_bh2);
 	sb->s_dirt = 1; /* and needs time stamp */
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_ino = ino;
diff -urN rc11-pre5/fs/udf/ialloc.c rc11-5-new_inode/fs/udf/ialloc.c
--- rc11-pre5/fs/udf/ialloc.c	Wed Oct  4 03:44:58 2000
+++ rc11-5-new_inode/fs/udf/ialloc.c	Thu Nov 16 08:40:27 2000
@@ -77,14 +77,13 @@
 	int block;
 	Uint32 start = UDF_I_LOCATION(dir).logicalBlockNum;
 
-	inode = get_empty_inode();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode)
 	{
 		*err = -ENOMEM;
 		return NULL;
 	}
-	sb = dir->i_sb;
-	inode->i_sb = sb;
 	inode->i_flags = 0;
 	*err = -ENOSPC;
 
@@ -115,9 +114,6 @@
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	inode->i_mode = mode;
-	inode->i_sb = sb;
-	inode->i_nlink = 1;
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
diff -urN rc11-pre5/fs/ufs/ialloc.c rc11-5-new_inode/fs/ufs/ialloc.c
--- rc11-pre5/fs/ufs/ialloc.c	Wed Oct  4 03:44:58 2000
+++ rc11-5-new_inode/fs/ufs/ialloc.c	Tue Nov 14 22:07:43 2000
@@ -161,19 +161,16 @@
 		*err = -EPERM;
 		return NULL;
 	}
-	inode = get_empty_inode ();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode) {
 		*err = -ENOMEM;
 		return NULL;
 	}
-	sb = dir->i_sb;
 	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 
-	inode->i_sb = sb;
-	inode->i_flags = 0;
-	
 	lock_super (sb);
 
 	*err = -ENOSPC;
@@ -261,9 +258,6 @@
 	sb->s_dirt = 1;
 
 	inode->i_mode = mode;
-	inode->i_sb = sb;
-	inode->i_nlink = 1;
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
diff -urN rc11-pre5/include/linux/fs.h rc11-5-new_inode/include/linux/fs.h
--- rc11-pre5/include/linux/fs.h	Tue Nov 14 20:26:43 2000
+++ rc11-5-new_inode/include/linux/fs.h	Tue Nov 14 22:01:11 2000
@@ -1149,6 +1149,15 @@
 
 extern void clear_inode(struct inode *);
 extern struct inode * get_empty_inode(void);
+static inline struct inode * new_inode(struct super_block *sb)
+{
+	struct inode *inode = get_empty_inode();
+	if (inode) {
+		inode->i_sb = sb;
+		inode->i_dev = sb->s_dev;
+	}
+	return inode;
+}
 
 extern void insert_inode_hash(struct inode *);
 extern void remove_inode_hash(struct inode *);
diff -urN rc11-pre5/net/socket.c rc11-5-new_inode/net/socket.c
--- rc11-pre5/net/socket.c	Thu Nov  2 22:39:11 2000
+++ rc11-5-new_inode/net/socket.c	Thu Nov 16 08:47:01 2000
@@ -277,14 +277,12 @@
 
 static struct super_block * sockfs_read_super(struct super_block *sb, void *data, int silent)
 {
-	struct inode *root = get_empty_inode();
+	struct inode *root = new_inode(sb);
 	if (!root)
 		return NULL;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
 	root->i_uid = root->i_gid = 0;
 	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
-	root->i_sb = sb;
-	root->i_dev = sb->s_dev;
 	sb->s_blocksize = 1024;
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = SOCKFS_MAGIC;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
