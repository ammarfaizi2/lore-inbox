Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155913-26601>; Wed, 21 Oct 1998 03:14:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2589 "EHLO math.psu.edu" ident: "root") by vger.rutgers.edu with ESMTP id <160087-26601>; Wed, 21 Oct 1998 00:55:02 -0400
Date: Wed, 21 Oct 1998 14:42:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: ralf@gnu.ai.mit.edu
cc: linux-kernel@vger.rutgers.edu
Subject: [Fix] Assorted races on MIPS.
Message-ID: <Pine.SOL.3.95.981021143959.942C-100000@albert.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

sysirix.c: races in irix_fstatfs, irix_mmap32, irix_fstatvfs,
irix_fstatvfs64, irix_ngetdents, irix_getdents64,
irix_ngetdents64
	They are akin to ones fixed in Bill Hawes' patch (c. 2.1.88).

In the irix_fstatfs, irix_fstatvfs we did extra dput(). Removed.

If, by any chance, current->files->fd[fd] will contract NULL f_dentry we
are screwed anyway - mmap, close, lseek, etc. will choke on it. Any such
case is bug in kernel and deserves oops. I've removed tests for NULL
f_dentry from sysirix.c (and IMHO someday it should be done in fs/open.c).
Better die early and give better chance to find the reason of screwup;
process willn't survive anyway.

Pretty cosmetical change in irixioctl.c

--- arch/mips/kernel/sysirix.c.orig	Tue Oct 20 08:08:13 1998
+++ arch/mips/kernel/sysirix.c	Tue Oct 20 11:21:43 1998
@@ -23,6 +23,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/utsname.h>
+#include <linux/file.h>
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
@@ -777,7 +778,6 @@
 
 asmlinkage int irix_fstatfs(unsigned int fd, struct irix_statfs *buf)
 {
-	struct dentry *dentry;
 	struct inode *inode;
 	struct statfs kbuf;
 	mm_segment_t old_fs;
@@ -788,25 +788,22 @@
 	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statfs));
 	if (error)
 		goto out;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd])) {
+	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
 	}
-	if (!(dentry = file->f_dentry)) {
-		error = -ENOENT;
-		goto out;
-	}
-	if (!(inode = dentry->d_inode)) {
+
+	if (!(inode = file->f_dentry->d_inode)) {
 		error = -ENOENT;
-		goto out;
+		goto out_f;
 	}
 	if (!inode->i_sb) {
 		error = -ENODEV;
-		goto out;
+		goto out_f;
 	}
 	if (!inode->i_sb->s_op->statfs) {
 		error = -ENOSYS;
-		goto out;
+		goto out_f;
 	}
 
 	old_fs = get_fs(); set_fs(get_ds());
@@ -814,7 +811,7 @@
 	                                  sizeof(struct statfs));
 	set_fs(old_fs);
 	if (error)
-		goto out;
+		goto out_f;
 
 	__put_user(kbuf.f_type, &buf->f_type);
 	__put_user(kbuf.f_bsize, &buf->f_bsize);
@@ -829,7 +826,8 @@
 	}
 	error = 0;
 
-	dput(dentry);
+out_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
@@ -1116,7 +1114,7 @@
 
 	lock_kernel();
 	if(!(flags & MAP_ANONYMOUS)) {
-		if(fd >= NR_OPEN || !(file = current->files->fd[fd])) {
+		if(!(file = fget(fd))) {
 			retval = -EBADF;
 			goto out;
 		}
@@ -1136,6 +1134,8 @@
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
 	retval = do_mmap(file, addr, len, prot, flags, offset);
+	if (file)
+		fput(file);
 
 out:
 	unlock_kernel();
@@ -1574,7 +1574,6 @@
 
 asmlinkage int irix_fstatvfs(int fd, struct irix_statvfs *buf)
 {
-	struct dentry *dentry;
 	struct inode *inode;
 	mm_segment_t old_fs;
 	struct statfs kbuf;
@@ -1588,21 +1587,17 @@
 	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));
 	if (error)
 		goto out;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd])) {
+	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
 	}
-	if (!(dentry = file->f_dentry)) {
-		error = -ENOENT;
-		goto out;
-	}
-	if (!(inode = dentry->d_inode)) {
+	if (!(inode = file->f_dentry->d_inode)) {
 		error = -ENOENT;
-		goto out;
+		goto out_f;
 	}
 	if (!inode->i_sb->s_op->statfs) {
 		error = -ENOSYS;
-		goto out;
+		goto out_f;
 	}
 
 	old_fs = get_fs(); set_fs(get_ds());
@@ -1610,7 +1605,7 @@
 	                                  sizeof(struct statfs));
 	set_fs(old_fs);
 	if (error)
-		goto out;
+		goto out_f;
 
 	__put_user(kbuf.f_bsize, &buf->f_bsize);
 	__put_user(kbuf.f_frsize, &buf->f_frsize);
@@ -1634,7 +1629,8 @@
 
 	error = 0;
 
-	dput(dentry);
+out_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
@@ -1822,7 +1818,7 @@
 	}
 
 	if(!(flags & MAP_ANONYMOUS)) {
-		if(fd >= NR_OPEN || !(file = current->files->fd[fd])) {
+		if(!(file = fcheck(fd))) {
 			error = -EBADF;
 			goto out;
 		}
@@ -1960,7 +1956,6 @@
 
 asmlinkage int irix_fstatvfs64(int fd, struct irix_statvfs *buf)
 {
-	struct dentry *dentry;
 	struct inode *inode;
 	mm_segment_t old_fs;
 	struct statfs kbuf;
@@ -1974,21 +1969,17 @@
 	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));
 	if (error)
 		goto out;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd])) {
+	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
 	}
-	if (!(dentry = file->f_dentry)) {
-		error = -ENOENT;
-		goto out;
-	}
-	if (!(inode = dentry->d_inode)) {
+	if (!(inode = file->f_dentry->d_inode)) {
 		error = -ENOENT;
-		goto out;
+		goto out_f;
 	}
 	if (!inode->i_sb->s_op->statfs) {
 		error = -ENOSYS;
-		goto out;
+		goto out_f;
 	}
 
 	old_fs = get_fs(); set_fs(get_ds());
@@ -1996,7 +1987,7 @@
 	                                  sizeof(struct statfs));
 	set_fs(old_fs);
 	if (error)
-		goto out;
+		goto out_f;
 
 	__put_user(kbuf.f_bsize, &buf->f_bsize);
 	__put_user(kbuf.f_frsize, &buf->f_frsize);
@@ -2020,7 +2011,8 @@
 
 	error = 0;
 
-	dput(dentry);
+out_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
@@ -2123,7 +2115,6 @@
 asmlinkage int irix_ngetdents(unsigned int fd, void * dirent, unsigned int count, int *eob)
 {
 	struct file *file;
-	struct dentry *dentry;
 	struct inode *inode;
 	struct irix_dirent32 *lastdirent;
 	struct irix_dirent32_callback buf;
@@ -2135,25 +2126,22 @@
 	       current->pid, fd, dirent, count, eob);
 #endif
 	error = -EBADF;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd]))
+	if (!(file = fget(fd)))
 		goto out;
 
-	dentry = file->f_dentry;
-	if (!dentry)
-		goto out;
-
-	inode = dentry->d_inode;
+	/* Shouldn't it be ENOENT? */
+	inode = file->f_dentry->d_inode;
 	if (!inode)
-		goto out;
+		goto out_f;
 
 	error = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
-		goto out;
+		goto out_f;
 
 	error = -EFAULT;
 	if(!access_ok(VERIFY_WRITE, dirent, count) ||
 	   !access_ok(VERIFY_WRITE, eob, sizeof(*eob)))
-		goto out;
+		goto out_f;
 
 	__put_user(0, eob);
 	buf.current_dir = (struct irix_dirent32 *) dirent;
@@ -2163,11 +2151,11 @@
 
 	error = file->f_op->readdir(file, &buf, irix_filldir32);
 	if (error < 0)
-		goto out;
+		goto out_f;
 	lastdirent = buf.previous;
 	if (!lastdirent) {
 		error = buf.error;
-		goto out;
+		goto out_f;
 	}
 	lastdirent->d_off = (u32) file->f_pos;
 #ifdef DEBUG_GETDENTS
@@ -2175,6 +2163,8 @@
 #endif
 	error = count - buf.count;
 
+outf_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
@@ -2234,7 +2224,6 @@
 asmlinkage int irix_getdents64(int fd, void *dirent, int cnt)
 {
 	struct file *file;
-	struct dentry *dentry;
 	struct inode *inode;
 	struct irix_dirent64 *lastdirent;
 	struct irix_dirent64_callback buf;
@@ -2246,28 +2235,24 @@
 	       current->pid, fd, dirent, cnt);
 #endif
 	error = -EBADF;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd]))
-		goto out;
-
-	dentry = file->f_dentry;
-	if (!dentry)
+	if (!(file = fget(fd)))
 		goto out;
 
-	inode = dentry->d_inode;
+	inode = file->f_dentry->d_inode;
 	if (!inode)
-		goto out;
+		goto out_f;
 
 	error = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
-		goto out;
+		goto out_f;
 
 	error = -EFAULT;
 	if(!access_ok(VERIFY_WRITE, dirent, cnt))
-		goto out;
+		goto out_f;
 
 	error = -EINVAL;
 	if(cnt < (sizeof(struct irix_dirent64) + 255))
-		goto out;
+		goto out_f;
 
 	buf.curr = (struct irix_dirent64 *) dirent;
 	buf.previous = NULL;
@@ -2275,11 +2260,11 @@
 	buf.error = 0;
 	error = file->f_op->readdir(file, &buf, irix_filldir64);
 	if (error < 0)
-		goto out;
+		goto out_f;
 	lastdirent = buf.previous;
 	if (!lastdirent) {
 		error = buf.error;
-		goto out;
+		goto out_f;
 	}
 	lastdirent->d_off = (u64) file->f_pos;
 #ifdef DEBUG_GETDENTS
@@ -2287,6 +2272,8 @@
 #endif
 	error = cnt - buf.count;
 
+out_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
@@ -2295,7 +2282,6 @@
 asmlinkage int irix_ngetdents64(int fd, void *dirent, int cnt, int *eob)
 {
 	struct file *file;
-	struct dentry *dentry;
 	struct inode *inode;
 	struct irix_dirent64 *lastdirent;
 	struct irix_dirent64_callback buf;
@@ -2307,29 +2293,25 @@
 	       current->pid, fd, dirent, cnt);
 #endif
 	error = -EBADF;
-	if (fd >= NR_OPEN || !(file = current->files->fd[fd]))
+	if (!(file = fget(fd)))
 		goto out;
 
-	dentry = file->f_dentry;
-	if (!dentry)
-		goto out;
-
-	inode = dentry->d_inode;
+	inode = file->f_dentry->d_inode;
 	if (!inode)
-		goto out;
+		goto out_f;
 
 	error = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
-		goto out;
+		goto out_f;
 
 	error = -EFAULT;
 	if(!access_ok(VERIFY_WRITE, dirent, cnt) ||
 	   !access_ok(VERIFY_WRITE, eob, sizeof(*eob)))
-		goto out;
+		goto out_f;
 
 	error = -EINVAL;
 	if(cnt < (sizeof(struct irix_dirent64) + 255))
-		goto out;
+		goto out_f;
 
 	*eob = 0;
 	buf.curr = (struct irix_dirent64 *) dirent;
@@ -2338,11 +2320,11 @@
 	buf.error = 0;
 	error = file->f_op->readdir(file, &buf, irix_filldir64);
 	if (error < 0)
-		goto out;
+		goto out_f;
 	lastdirent = buf.previous;
 	if (!lastdirent) {
 		error = buf.error;
-		goto out;
+		goto out_f;
 	}
 	lastdirent->d_off = (u64) file->f_pos;
 #ifdef DEBUG_GETDENTS
@@ -2350,6 +2332,8 @@
 #endif
 	error = cnt - buf.count;
 
+out_f:
+	fput(file);
 out:
 	unlock_kernel();
 	return error;
--- arch/mips/kernel/irixioctl.c.orig	Tue Oct 20 11:53:53 1998
+++ arch/mips/kernel/irixioctl.c	Tue Oct 20 11:59:11 1998
@@ -33,7 +33,7 @@
 {
 	struct file *filp;
 
-	if(fd >= NR_OPEN || !(filp = current->files->fd[fd]))
+	if(!(filp = fcheck(fd)))
 		return ((struct tty_struct *) 0);
 	if(filp->private_data) {
 		struct tty_struct *ttyp = (struct tty_struct *) filp->private_data;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
