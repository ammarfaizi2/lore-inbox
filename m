Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbSKUXji>; Thu, 21 Nov 2002 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbSKUXji>; Thu, 21 Nov 2002 18:39:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:15327 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267184AbSKUXjf>;
	Thu, 21 Nov 2002 18:39:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 22 Nov 2002 00:46:40 +0100 (MET)
Message-Id: <UTC200211212346.gALNkem21004.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] kill i_dev
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This serves to decrease the size of struct inode a bit,
and makes sure that a later increase of sizeof(dev_t)
does not make struct inode bigger than it used to be.

The i_dev field is deleted and the few uses are replaced
by i_sb->s_dev.

There is a single side effect: a stat on a socket now sees
a nonzero st_dev. There is nothing against that - FreeBSD
has a nonzero value as well - but there is at least one
utility (fuser) that will need an update.

Andries


Patch against (vanilla) 2.5.48.

diff -u --recursive --new-file -X /linux/dontdiff a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
--- a/fs/coda/coda_linux.c	Mon Nov 18 10:57:19 2002
+++ b/fs/coda/coda_linux.c	Fri Nov 22 00:21:21 2002
@@ -100,7 +100,7 @@
 void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 {
         int inode_type;
-        /* inode's i_dev, i_flags, i_ino are set by iget 
+        /* inode's i_flags, i_ino are set by iget 
            XXX: is this all we need ??
            */
         switch (attr->va_type) {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Mon Nov 18 10:57:20 2002
+++ b/fs/inode.c	Fri Nov 22 00:21:21 2002
@@ -102,7 +102,6 @@
 		struct address_space * const mapping = &inode->i_data;
 
 		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
 		atomic_set(&inode->i_count, 1);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/intermezzo/presto.c b/fs/intermezzo/presto.c
--- a/fs/intermezzo/presto.c	Thu Oct 17 02:28:40 2002
+++ b/fs/intermezzo/presto.c	Fri Nov 22 00:21:21 2002
@@ -67,7 +67,7 @@
         CDEBUG(D_PSDEV, "\n");
         if ( !cache ) {
                 CERROR("PRESTO: BAD: cannot find cache for dev %d, ino %ld\n",
-                       inode->i_dev, inode->i_ino);
+                       inode->i_sb->s_dev, inode->i_ino);
                 EXIT;
                 return -1;
         }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/intermezzo/vfs.c b/fs/intermezzo/vfs.c
--- a/fs/intermezzo/vfs.c	Mon Nov 18 10:57:20 2002
+++ b/fs/intermezzo/vfs.c	Fri Nov 22 00:21:21 2002
@@ -182,7 +182,7 @@
 {
         int minor = presto_f2m(fset);
         int errorval = izo_channels[minor].uc_errorval;
-        kdev_t dev = to_kdev_t(fset->fset_dentry->d_inode->i_dev);
+        kdev_t dev = to_kdev_t(fset->fset_dentry->d_inode->i_sb->s_dev);
 
         if (errorval && errorval == (long)value && !is_read_only(dev)) {
                 CDEBUG(D_SUPER, "setting device %s read only\n", kdevname(dev));
@@ -763,7 +763,7 @@
                 goto exit_lock;
 
         error = -EXDEV;
-        if (dir->d_inode->i_dev != inode->i_dev)
+        if (dir->d_inode->i_sb->s_dev != inode->i_sb->s_dev)
                 goto exit_lock;
 
         /*
@@ -1820,7 +1820,7 @@
         if (error)
                 return error;
 
-        if (new_dir->i_dev != old_dir->i_dev)
+        if (new_dir->i_sb->s_dev != old_dir->i_sb->s_dev)
                 return -EXDEV;
 
         if (!new_dentry->d_inode)
@@ -1901,7 +1901,7 @@
         if (error)
                 return error;
 
-        if (new_dir->i_dev != old_dir->i_dev)
+        if (new_dir->i_sb->s_dev != old_dir->i_sb->s_dev)
                 return -EXDEV;
 
         if (!new_dentry->d_inode)
diff -u --recursive --new-file -X /linux/dontdiff a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Mon Nov 18 10:57:20 2002
+++ b/fs/locks.c	Fri Nov 22 00:21:21 2002
@@ -1766,7 +1766,7 @@
 #else
 	/* kdevname is a broken interface.  but we expose it to userspace */
 	out += sprintf(out, "%d %s:%ld ", fl->fl_pid,
-			inode ? kdevname(to_kdev_t(inode->i_dev)) : "<none>",
+			inode ? kdevname(to_kdev_t(inode->i_sb->s_dev)) : "<none>",
 			inode ? inode->i_ino : 0);
 #endif
 	if (IS_POSIX(fl)) {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
--- a/fs/nfsd/nfs3xdr.c	Mon Nov 18 10:57:20 2002
+++ b/fs/nfsd/nfs3xdr.c	Fri Nov 22 00:21:21 2002
@@ -226,7 +226,7 @@
 	    && (fhp->fh_export->ex_flags & NFSEXP_FSID))
 		p = xdr_encode_hyper(p, (u64) fhp->fh_export->ex_fsid);
 	else
-		p = xdr_encode_hyper(p, (u64) inode->i_dev);
+		p = xdr_encode_hyper(p, (u64) inode->i_sb->s_dev);
 	p = xdr_encode_hyper(p, (u64) inode->i_ino);
 	time.tv_sec = fhp->fh_post_atime; 
 	time.tv_nsec = 0;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c	Mon Nov 18 10:57:20 2002
+++ b/fs/nfsd/vfs.c	Fri Nov 22 00:21:21 2002
@@ -632,7 +632,7 @@
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_dev, inode->i_ino);
+	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
 	if (ra)
 		file.f_ra = ra->p_ra;
 
@@ -752,7 +752,7 @@
 		 */
 		if (EX_WGATHER(exp)) {
 			if (atomic_read(&inode->i_writecount) > 1
-			    || (last_ino == inode->i_ino && last_dev == inode->i_dev)) {
+			    || (last_ino == inode->i_ino && last_dev == inode->i_sb->s_dev)) {
 				dprintk("nfsd: write defer %d\n", current->pid);
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout((HZ+99)/100);
@@ -769,7 +769,7 @@
 #endif
 		}
 		last_ino = inode->i_ino;
-		last_dev = inode->i_dev;
+		last_dev = inode->i_sb->s_dev;
 	}
 
 	dprintk("nfsd: write complete err=%d\n", err);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Tue Nov  5 09:18:10 2002
+++ b/fs/proc/array.c	Fri Nov 22 00:21:21 2002
@@ -484,8 +484,9 @@
 	dev = 0;
 	ino = 0;
 	if (map->vm_file != NULL) {
-		dev = map->vm_file->f_dentry->d_inode->i_dev;
-		ino = map->vm_file->f_dentry->d_inode->i_ino;
+		struct inode *inode = map->vm_file->f_dentry->d_inode;
+		dev = inode->i_sb->s_dev;
+		ino = inode->i_ino;
 		line = d_path(map->vm_file->f_dentry,
 			      map->vm_file->f_vfsmnt,
 			      buf, PAGE_SIZE);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Mon Nov 18 10:57:22 2002
+++ b/fs/stat.c	Fri Nov 22 00:21:21 2002
@@ -18,7 +18,7 @@
 
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
-	stat->dev = inode->i_dev;
+	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/udf/inode.c b/fs/udf/inode.c
--- a/fs/udf/inode.c	Mon Nov 18 10:57:22 2002
+++ b/fs/udf/inode.c	Fri Nov 22 00:21:21 2002
@@ -920,7 +920,6 @@
 	 * Set defaults, but the inode is still incomplete!
 	 * Note: get_new_inode() sets the following on a new inode:
 	 *      i_sb = sb
-	 *      i_dev = sb->s_dev;
 	 *      i_no = ino
 	 *      i_flags = sb->s_flags
 	 *      i_state = 0
diff -u --recursive --new-file -X /linux/dontdiff a/fs/xfs/xfs_iget.c b/fs/xfs/xfs_iget.c
--- a/fs/xfs/xfs_iget.c	Thu Nov 14 17:10:30 2002
+++ b/fs/xfs/xfs_iget.c	Fri Nov 22 00:21:21 2002
@@ -247,8 +247,8 @@
 	/*
 	 * Read the disk inode attributes into a new inode structure and get
 	 * a new vnode for it.	Initialize the inode lock so we can idestroy
-	 * it soon if it's a dup.  This should also initialize i_dev, i_ino,
-	 * i_bno, i_mount, and i_index.
+	 * it soon if it's a dup.  This should also initialize i_ino, i_bno,
+	 * i_mount, and i_index.
 	 */
 	error = xfs_iread(mp, tp, ino, &ip, bno);
 	if (error) {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/xfs/xfsidbg.c b/fs/xfs/xfsidbg.c
--- a/fs/xfs/xfsidbg.c	Thu Nov 14 17:10:30 2002
+++ b/fs/xfs/xfsidbg.c	Fri Nov 22 00:21:21 2002
@@ -1639,7 +1639,7 @@
 
 	kdb_printf(" i_ino = %lu i_count = %u i_dev = 0x%x i_size %Ld\n",
 					ip->i_ino, atomic_read(&ip->i_count),
-					ip->i_dev, ip->i_size);
+					ip->i_sb->s_dev, ip->i_size);
 
 	kdb_printf(
 		" i_mode = 0x%x	 i_nlink = %d  i_rdev = 0x%x i_state = 0x%lx\n",
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Mon Nov 18 10:57:23 2002
+++ b/include/linux/fs.h	Fri Nov 22 00:21:21 2002
@@ -362,7 +362,6 @@
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
 	atomic_t		i_count;
-	dev_t			i_dev;
 	umode_t			i_mode;
 	unsigned int		i_nlink;
 	uid_t			i_uid;
diff -u --recursive --new-file -X /linux/dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	Mon Nov 18 10:57:24 2002
+++ b/net/socket.c	Fri Nov 22 00:21:46 2002
@@ -468,7 +468,6 @@
 	if (!inode)
 		return NULL;
 
-	inode->i_dev = 0;
 	sock = SOCKET_I(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
