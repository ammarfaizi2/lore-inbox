Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKQHoi>; Fri, 17 Nov 2000 02:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKQHo2>; Fri, 17 Nov 2000 02:44:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60073 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129094AbQKQHoO>;
	Fri, 17 Nov 2000 02:44:14 -0500
Date: Fri, 17 Nov 2000 02:14:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs_may_remount_ro()/fput() race fix and ->f_dentry cleanups
Message-ID: <Pine.GSO.4.21.0011170153490.14822-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* fs_may_remount_ro() used the wrong check for skipping the
files being in the middle of final fput(). NULL ->f_dentry is
possible here (after all references to file are gone, etc.), NULL
->f_dentry->d_inode isn't. I.e. check in
        file_list_lock();
        for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
                struct file *file = list_entry(p, struct file, f_list);
                struct inode *inode = file->f_dentry->d_inode;
                if (!inode)
                        continue;
		....
is not only useless, it's an oopsable SMP race.
	Fix: check for the right thing.

	* when we own the reference on opened file neither ->f_dentry nor
->f_dentry->d_inode may be NULL. Majority of bogus checks had been killed
back in Spring, but some had crawled back. Exterminated.

	* if foo_readdir() occurs only in foo_dir_operations and
foo_dir_operations is assigned only to ->i_fops of directories, it's
pointless to check whether the passed file is a directory. It is. Honest.
Again, most of that junk had been killed, but some creatures had resurfaced.
Exterminated.

	* ->readdir() never gets a file with negative dentry. Ditto for
->read() and ->write(). Same story.

Patch follows. Please, apply it.
							Cheers,
								Al

diff -urN rc11-pre6/arch/ia64/ia32/sys_ia32.c rc11-6-f_dentry/arch/ia64/ia32/sys_ia32.c
--- rc11-pre6/arch/ia64/ia32/sys_ia32.c	Thu Nov  2 22:38:13 2000
+++ rc11-6-f_dentry/arch/ia64/ia32/sys_ia32.c	Fri Nov 17 04:19:20 2000
@@ -3392,7 +3392,7 @@
 	}
 
 	inode = file->f_dentry->d_inode;
-	if (!inode || !inode->i_sock || !socki_lookup(inode))
+	if (!inode->i_sock || !socki_lookup(inode))
 	{
 		*err = -ENOTSOCK;
 		fput(file);
diff -urN rc11-pre6/arch/sparc64/kernel/sys_sunos32.c rc11-6-f_dentry/arch/sparc64/kernel/sys_sunos32.c
--- rc11-pre6/arch/sparc64/kernel/sys_sunos32.c	Mon Aug 28 21:14:42 2000
+++ rc11-6-f_dentry/arch/sparc64/kernel/sys_sunos32.c	Fri Nov 17 04:22:08 2000
@@ -601,7 +601,6 @@
 	int    try_port;
 	int    ret;
 	struct socket *socket;
-	struct dentry *dentry;
 	struct inode  *inode;
 	struct file   *file;
 
@@ -609,8 +608,7 @@
 	if(!file)
 		return 0;
 
-	dentry = file->f_dentry;
-	inode = dentry->d_inode;
+	inode = file->f_dentry->d_inode;
 
 	socket = &inode->u.socket_i;
 	local.sin_family = AF_INET;
diff -urN rc11-pre6/arch/sparc64/solaris/ioctl.c rc11-6-f_dentry/arch/sparc64/solaris/ioctl.c
--- rc11-pre6/arch/sparc64/solaris/ioctl.c	Sat Aug  5 05:50:26 2000
+++ rc11-6-f_dentry/arch/sparc64/solaris/ioctl.c	Fri Nov 17 04:23:05 2000
@@ -464,8 +464,8 @@
         struct sol_socket_struct *sock;
         struct module_info *mi;
 
-        if (! (ino = filp->f_dentry->d_inode) ||
-	    ! ino->i_sock)
+        ino = filp->f_dentry->d_inode;
+        if (! ino->i_sock)
 		return -EBADF;
         sock = filp->private_data;
         if (! sock) {
diff -urN rc11-pre6/arch/sparc64/solaris/socket.c rc11-6-f_dentry/arch/sparc64/solaris/socket.c
--- rc11-pre6/arch/sparc64/solaris/socket.c	Mon Aug 28 21:14:42 2000
+++ rc11-6-f_dentry/arch/sparc64/solaris/socket.c	Fri Nov 17 04:23:17 2000
@@ -265,7 +265,7 @@
 	}
 
 	inode = file->f_dentry->d_inode;
-	if (!inode || !inode->i_sock || !socki_lookup(inode)) {
+	if (!inode->i_sock || !socki_lookup(inode)) {
 		*err = -ENOTSOCK;
 		fput(file);
 		return NULL;
diff -urN rc11-pre6/drivers/block/loop.c rc11-6-f_dentry/drivers/block/loop.c
--- rc11-pre6/drivers/block/loop.c	Fri Nov 17 02:22:37 2000
+++ rc11-6-f_dentry/drivers/block/loop.c	Fri Nov 17 04:24:30 2000
@@ -411,10 +411,6 @@
 
 	error = -EINVAL;
 	inode = file->f_dentry->d_inode;
-	if (!inode) {
-		printk(KERN_ERR "loop_set_fd: NULL inode?!?\n");
-		goto out_putf;
-	}
 
 	if (S_ISBLK(inode->i_mode)) {
 		/* dentry will be wired, so... */
diff -urN rc11-pre6/fs/devfs/base.c rc11-6-f_dentry/fs/devfs/base.c
--- rc11-pre6/fs/devfs/base.c	Fri Nov 17 02:23:19 2000
+++ rc11-6-f_dentry/fs/devfs/base.c	Fri Nov 17 05:32:45 2000
@@ -2416,11 +2416,6 @@
     struct devfs_entry *parent, *de;
     struct inode *inode = file->f_dentry->d_inode;
 
-    if (inode == NULL)
-    {
-	printk ("%s: readdir(): NULL inode\n", DEVFS_NAME);
-	return -EBADF;
-    }
     if ( !S_ISDIR (inode->i_mode) )
     {
 	printk ("%s: readdir(): inode is not a directory\n", DEVFS_NAME);
diff -urN rc11-pre6/fs/dquot.c rc11-6-f_dentry/fs/dquot.c
--- rc11-pre6/fs/dquot.c	Wed Oct  4 03:44:53 2000
+++ rc11-6-f_dentry/fs/dquot.c	Fri Nov 17 04:33:23 2000
@@ -679,8 +679,6 @@
 		if (!filp->f_dentry)
 			continue;
 		inode = filp->f_dentry->d_inode;
-		if (!inode)
-			continue;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
diff -urN rc11-pre6/fs/efs/dir.c rc11-6-f_dentry/fs/efs/dir.c
--- rc11-pre6/fs/efs/dir.c	Mon Aug 28 21:15:15 2000
+++ rc11-6-f_dentry/fs/efs/dir.c	Fri Nov 17 04:42:38 2000
@@ -28,9 +28,6 @@
 	int			slot, namelen;
 	char			*nameptr;
 
-	if (!inode || !S_ISDIR(inode->i_mode))
-		return -EBADF;
-
 	if (inode->i_size & (EFS_DIRBSIZE-1))
 		printk(KERN_WARNING "EFS: WARNING: readdir(): directory size not a multiple of EFS_DIRBSIZE\n");
 
diff -urN rc11-pre6/fs/file_table.c rc11-6-f_dentry/fs/file_table.c
--- rc11-pre6/fs/file_table.c	Wed Oct  4 03:44:54 2000
+++ rc11-6-f_dentry/fs/file_table.c	Fri Nov 17 04:38:17 2000
@@ -176,9 +176,12 @@
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
 		struct file *file = list_entry(p, struct file, f_list);
-		struct inode *inode = file->f_dentry->d_inode;
-		if (!inode)
+		struct inode *inode;
+
+		if (!file->f_dentry)
 			continue;
+
+		inode = file->f_dentry->d_inode;
 
 		/* File with pending delete? */
 		if (inode->i_nlink == 0)
diff -urN rc11-pre6/fs/ncpfs/file.c rc11-6-f_dentry/fs/ncpfs/file.c
--- rc11-pre6/fs/ncpfs/file.c	Wed Oct  4 03:44:55 2000
+++ rc11-6-f_dentry/fs/ncpfs/file.c	Fri Nov 17 04:45:39 2000
@@ -120,11 +120,6 @@
 	DPRINTK("ncp_file_read: enter %s/%s\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 
-	error = -EINVAL;
-	if (inode == NULL) {
-		DPRINTK("ncp_file_read: inode = NULL\n");
-		goto out;
-	}
 	error = -EIO;
 	if (!ncp_conn_valid(NCP_SERVER(inode)))
 		goto out;
@@ -210,10 +205,6 @@
 
 	DPRINTK("ncp_file_write: enter %s/%s\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
-	if (inode == NULL) {
-		DPRINTK("ncp_file_write: inode = NULL\n");
-		return -EINVAL;
-	}
 	errno = -EIO;
 	if (!ncp_conn_valid(NCP_SERVER(inode)))
 		goto out;
diff -urN rc11-pre6/fs/proc/generic.c rc11-6-f_dentry/fs/proc/generic.c
--- rc11-pre6/fs/proc/generic.c	Wed Oct  4 03:44:57 2000
+++ rc11-6-f_dentry/fs/proc/generic.c	Fri Nov 17 04:55:55 2000
@@ -396,8 +396,6 @@
 		if (dentry->d_op != &proc_dentry_operations)
 			continue;
 		inode = dentry->d_inode;
-		if (!inode)
-			continue;
 		if (inode->u.generic_ip != de)
 			continue;
 		fops_put(filp->f_op);
diff -urN rc11-pre6/fs/udf/dir.c rc11-6-f_dentry/fs/udf/dir.c
--- rc11-pre6/fs/udf/dir.c	Mon Aug 28 21:15:19 2000
+++ rc11-6-f_dentry/fs/udf/dir.c	Fri Nov 17 04:54:52 2000
@@ -86,12 +86,6 @@
 	struct inode *dir = filp->f_dentry->d_inode;
 	int result;
 
-	if (!dir)
-	   return -EBADF;
-
- 	if (!S_ISDIR(dir->i_mode))
-	   return -ENOTDIR;
-
 	if ( filp->f_pos == 0 ) 
 	{
 		if (filldir(dirent, ".", 1, filp->f_pos, dir->i_ino, DT_DIR))
diff -urN rc11-pre6/mm/filemap.c rc11-6-f_dentry/mm/filemap.c
--- rc11-pre6/mm/filemap.c	Fri Nov 17 02:23:30 2000
+++ rc11-6-f_dentry/mm/filemap.c	Fri Nov 17 04:53:20 2000
@@ -1208,8 +1208,6 @@
 	if (!out_file->f_op || !out_file->f_op->write)
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
-	if (!out_inode)
-		goto fput_out;
 	retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
 	if (retval)
 		goto fput_out;
diff -urN rc11-pre6/net/khttpd/datasending.c rc11-6-f_dentry/net/khttpd/datasending.c
--- rc11-pre6/net/khttpd/datasending.c	Fri Nov 17 02:23:36 2000
+++ rc11-6-f_dentry/net/khttpd/datasending.c	Fri Nov 17 04:51:53 2000
@@ -114,7 +114,7 @@
 			
 			inode = CurrentRequest->filp->f_dentry->d_inode;
 			
-			if (inode && inode->i_mapping->a_ops->readpage) {
+			if (inode->i_mapping->a_ops->readpage) {
 				/* This does the actual transfer using sendfile */		
 				read_descriptor_t desc;
 				loff_t *ppos;
diff -urN rc11-pre6/net/socket.c rc11-6-f_dentry/net/socket.c
--- rc11-pre6/net/socket.c	Fri Nov 17 02:23:36 2000
+++ rc11-6-f_dentry/net/socket.c	Fri Nov 17 04:51:17 2000
@@ -405,7 +405,7 @@
 	}
 
 	inode = file->f_dentry->d_inode;
-	if (!inode || !inode->i_sock || !(sock = socki_lookup(inode)))
+	if (!inode->i_sock || !(sock = socki_lookup(inode)))
 	{
 		*err = -ENOTSOCK;
 		fput(file);
diff -urN rc11-pre6/net/unix/garbage.c rc11-6-f_dentry/net/unix/garbage.c
--- rc11-pre6/net/unix/garbage.c	Mon Jul 31 16:30:21 2000
+++ rc11-6-f_dentry/net/unix/garbage.c	Fri Nov 17 04:52:37 2000
@@ -100,7 +100,7 @@
 	/*
 	 *	Socket ?
 	 */
-	if (inode && inode->i_sock) {
+	if (inode->i_sock) {
 		struct socket * sock = &inode->u.socket_i;
 		struct sock * s = sock->sk;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
