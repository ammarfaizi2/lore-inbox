Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUHBRnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUHBRnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUHBRnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:43:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266677AbUHBRnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:43:06 -0400
Date: Mon, 2 Aug 2004 17:56:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:40:55PM +0530, Ravikiran G Thirumalai wrote:
> Here is a patchset to eliminate taking struct files_struct.file_lock on 
> reader side using rcu and rcu based refcounting.  These patches
> extend the kref api to include kref_lf_xxx api and kref_lf_get_rcu to
> do lockfree refcounting, and use the same.  As posted earlier, since fd
> lookups (struct files_struct.fd[]) will be lock free with these patches, 
> threaded workloads doing lots of io should see performance benefits 
> due to this patchset.  I have observed 13-15% improvement with tiobench 
> on a 4 way xeon with this patchset.

How about this for comparison?  That's just a dumb "convert to rwlock"
patch; we can be smarter in e.g. close_on_exec handling, but that's a
separate story.

diff -urN RC8-rc2-bk12/arch/mips/kernel/irixioctl.c RC8-rc2-bk12-current/arch/mips/kernel/irixioctl.c
--- RC8-rc2-bk12/arch/mips/kernel/irixioctl.c	2004-03-17 15:29:37.000000000 -0500
+++ RC8-rc2-bk12-current/arch/mips/kernel/irixioctl.c	2004-08-02 12:24:00.000000000 -0400
@@ -33,7 +33,7 @@
 	struct file *filp;
 	struct tty_struct *ttyp = NULL;
 
-	spin_lock(&current->files->file_lock);
+	read_lock(&current->files->file_lock);
 	filp = fcheck(fd);
 	if(filp && filp->private_data) {
 		ttyp = (struct tty_struct *) filp->private_data;
@@ -41,7 +41,7 @@
 		if(ttyp->magic != TTY_MAGIC)
 			ttyp =NULL;
 	}
-	spin_unlock(&current->files->file_lock);
+	read_unlock(&current->files->file_lock);
 	return ttyp;
 }
 
diff -urN RC8-rc2-bk12/arch/sparc64/solaris/ioctl.c RC8-rc2-bk12-current/arch/sparc64/solaris/ioctl.c
--- RC8-rc2-bk12/arch/sparc64/solaris/ioctl.c	2004-08-02 12:19:34.000000000 -0400
+++ RC8-rc2-bk12-current/arch/sparc64/solaris/ioctl.c	2004-08-02 12:24:23.000000000 -0400
@@ -294,15 +294,15 @@
 {
 	struct inode *ino;
 	/* I wonder which of these tests are superfluous... --patrik */
-	spin_lock(&current->files->file_lock);
+	read_lock(&current->files->file_lock);
 	if (! current->files->fd[fd] ||
 	    ! current->files->fd[fd]->f_dentry ||
 	    ! (ino = current->files->fd[fd]->f_dentry->d_inode) ||
 	    ! ino->i_sock) {
-		spin_unlock(&current->files->file_lock);
+		read_unlock(&current->files->file_lock);
 		return TBADF;
 	}
-	spin_unlock(&current->files->file_lock);
+	read_unlock(&current->files->file_lock);
 	
 	switch (cmd & 0xff) {
 	case 109: /* SI_SOCKPARAMS */
diff -urN RC8-rc2-bk12/drivers/char/tty_io.c RC8-rc2-bk12-current/drivers/char/tty_io.c
--- RC8-rc2-bk12/drivers/char/tty_io.c	2004-08-02 12:19:35.000000000 -0400
+++ RC8-rc2-bk12-current/drivers/char/tty_io.c	2004-08-02 12:24:52.139649424 -0400
@@ -1978,7 +1978,7 @@
 		}
 		task_lock(p);
 		if (p->files) {
-			spin_lock(&p->files->file_lock);
+			read_lock(&p->files->file_lock);
 			for (i=0; i < p->files->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
 				if (!filp)
@@ -1992,7 +1992,7 @@
 					break;
 				}
 			}
-			spin_unlock(&p->files->file_lock);
+			read_unlock(&p->files->file_lock);
 		}
 		task_unlock(p);
 	}
diff -urN RC8-rc2-bk12/fs/exec.c RC8-rc2-bk12-current/fs/exec.c
--- RC8-rc2-bk12/fs/exec.c	2004-08-02 12:19:36.000000000 -0400
+++ RC8-rc2-bk12-current/fs/exec.c	2004-08-02 12:40:31.000000000 -0400
@@ -762,7 +762,7 @@
 {
 	long j = -1;
 
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	for (;;) {
 		unsigned long set, i;
 
@@ -774,16 +774,16 @@
 		if (!set)
 			continue;
 		files->close_on_exec->fds_bits[j] = 0;
-		spin_unlock(&files->file_lock);
+		write_unlock(&files->file_lock);
 		for ( ; set ; i++,set >>= 1) {
 			if (set & 1) {
 				sys_close(i);
 			}
 		}
-		spin_lock(&files->file_lock);
+		write_lock(&files->file_lock);
 
 	}
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 }
 
 int flush_old_exec(struct linux_binprm * bprm)
diff -urN RC8-rc2-bk12/fs/fcntl.c RC8-rc2-bk12-current/fs/fcntl.c
--- RC8-rc2-bk12/fs/fcntl.c	2004-07-18 09:08:41.000000000 -0400
+++ RC8-rc2-bk12-current/fs/fcntl.c	2004-08-02 12:39:55.000000000 -0400
@@ -22,21 +22,21 @@
 void fastcall set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (flag)
 		FD_SET(fd, files->close_on_exec);
 	else
 		FD_CLR(fd, files->close_on_exec);
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 }
 
 static inline int get_close_on_exec(unsigned int fd)
 {
 	struct files_struct *files = current->files;
 	int res;
-	spin_lock(&files->file_lock);
+	read_lock(&files->file_lock);
 	res = FD_ISSET(fd, files->close_on_exec);
-	spin_unlock(&files->file_lock);
+	read_unlock(&files->file_lock);
 	return res;
 }
 
@@ -133,15 +133,15 @@
 	struct files_struct * files = current->files;
 	int fd;
 
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	fd = locate_fd(files, file, start);
 	if (fd >= 0) {
 		FD_SET(fd, files->open_fds);
 		FD_CLR(fd, files->close_on_exec);
-		spin_unlock(&files->file_lock);
+		write_unlock(&files->file_lock);
 		fd_install(fd, file);
 	} else {
-		spin_unlock(&files->file_lock);
+		write_unlock(&files->file_lock);
 		fput(file);
 	}
 
@@ -154,7 +154,7 @@
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
 
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (!(file = fcheck(oldfd)))
 		goto out_unlock;
 	err = newfd;
@@ -185,7 +185,7 @@
 	files->fd[newfd] = file;
 	FD_SET(newfd, files->open_fds);
 	FD_CLR(newfd, files->close_on_exec);
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 
 	if (tofree)
 		filp_close(tofree, files);
@@ -193,11 +193,11 @@
 out:
 	return err;
 out_unlock:
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	goto out;
 
 out_fput:
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	fput(file);
 	goto out;
 }
diff -urN RC8-rc2-bk12/fs/file.c RC8-rc2-bk12-current/fs/file.c
--- RC8-rc2-bk12/fs/file.c	2004-07-18 09:08:41.000000000 -0400
+++ RC8-rc2-bk12-current/fs/file.c	2004-08-02 12:30:35.000000000 -0400
@@ -65,7 +65,7 @@
 		goto out;
 
 	nfds = files->max_fds;
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 
 	/* 
 	 * Expand to the max in easy steps, and keep expanding it until
@@ -89,7 +89,7 @@
 
 	error = -ENOMEM;
 	new_fds = alloc_fd_array(nfds);
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (!new_fds)
 		goto out;
 
@@ -110,15 +110,15 @@
 			memset(&new_fds[i], 0,
 			       (nfds-i) * sizeof(struct file *)); 
 
-			spin_unlock(&files->file_lock);
+			write_unlock(&files->file_lock);
 			free_fd_array(old_fds, i);
-			spin_lock(&files->file_lock);
+			write_lock(&files->file_lock);
 		}
 	} else {
 		/* Somebody expanded the array while we slept ... */
-		spin_unlock(&files->file_lock);
+		write_unlock(&files->file_lock);
 		free_fd_array(new_fds, nfds);
-		spin_lock(&files->file_lock);
+		write_lock(&files->file_lock);
 	}
 	error = 0;
 out:
@@ -167,7 +167,7 @@
 		goto out;
 
 	nfds = files->max_fdset;
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 
 	/* Expand to the max in easy steps */
 	do {
@@ -183,7 +183,7 @@
 	error = -ENOMEM;
 	new_openset = alloc_fdset(nfds);
 	new_execset = alloc_fdset(nfds);
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (!new_openset || !new_execset)
 		goto out;
 
@@ -208,21 +208,21 @@
 		nfds = xchg(&files->max_fdset, nfds);
 		new_openset = xchg(&files->open_fds, new_openset);
 		new_execset = xchg(&files->close_on_exec, new_execset);
-		spin_unlock(&files->file_lock);
+		write_unlock(&files->file_lock);
 		free_fdset (new_openset, nfds);
 		free_fdset (new_execset, nfds);
-		spin_lock(&files->file_lock);
+		write_lock(&files->file_lock);
 		return 0;
 	} 
 	/* Somebody expanded the array while we slept ... */
 
 out:
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	if (new_openset)
 		free_fdset(new_openset, nfds);
 	if (new_execset)
 		free_fdset(new_execset, nfds);
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	return error;
 }
 
diff -urN RC8-rc2-bk12/fs/file_table.c RC8-rc2-bk12-current/fs/file_table.c
--- RC8-rc2-bk12/fs/file_table.c	2004-05-10 00:23:35.000000000 -0400
+++ RC8-rc2-bk12-current/fs/file_table.c	2004-08-02 12:31:01.000000000 -0400
@@ -197,11 +197,11 @@
 	struct file *file;
 	struct files_struct *files = current->files;
 
-	spin_lock(&files->file_lock);
+	read_lock(&files->file_lock);
 	file = fcheck_files(files, fd);
 	if (file)
 		get_file(file);
-	spin_unlock(&files->file_lock);
+	read_unlock(&files->file_lock);
 	return file;
 }
 
@@ -223,13 +223,13 @@
 	if (likely((atomic_read(&files->count) == 1))) {
 		file = fcheck_files(files, fd);
 	} else {
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
 		if (file) {
 			get_file(file);
 			*fput_needed = 1;
 		}
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 	}
 	return file;
 }
diff -urN RC8-rc2-bk12/fs/open.c RC8-rc2-bk12-current/fs/open.c
--- RC8-rc2-bk12/fs/open.c	2004-06-16 10:26:24.000000000 -0400
+++ RC8-rc2-bk12-current/fs/open.c	2004-08-02 12:33:29.000000000 -0400
@@ -841,7 +841,7 @@
 	int fd, error;
 
   	error = -EMFILE;
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 
 repeat:
  	fd = find_next_zero_bit(files->open_fds->fds_bits, 
@@ -890,7 +890,7 @@
 	error = fd;
 
 out:
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	return error;
 }
 
@@ -906,9 +906,9 @@
 void fastcall put_unused_fd(unsigned int fd)
 {
 	struct files_struct *files = current->files;
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	__put_unused_fd(files, fd);
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 }
 
 EXPORT_SYMBOL(put_unused_fd);
@@ -929,11 +929,11 @@
 void fastcall fd_install(unsigned int fd, struct file * file)
 {
 	struct files_struct *files = current->files;
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (unlikely(files->fd[fd] != NULL))
 		BUG();
 	files->fd[fd] = file;
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 }
 
 EXPORT_SYMBOL(fd_install);
@@ -1024,7 +1024,7 @@
 	struct file * filp;
 	struct files_struct *files = current->files;
 
-	spin_lock(&files->file_lock);
+	write_lock(&files->file_lock);
 	if (fd >= files->max_fds)
 		goto out_unlock;
 	filp = files->fd[fd];
@@ -1033,11 +1033,11 @@
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	return filp_close(filp, files);
 
 out_unlock:
-	spin_unlock(&files->file_lock);
+	write_unlock(&files->file_lock);
 	return -EBADF;
 }
 
diff -urN RC8-rc2-bk12/fs/proc/base.c RC8-rc2-bk12-current/fs/proc/base.c
--- RC8-rc2-bk12/fs/proc/base.c	2004-07-18 09:08:42.000000000 -0400
+++ RC8-rc2-bk12-current/fs/proc/base.c	2004-08-02 12:55:13.630740688 -0400
@@ -191,16 +191,16 @@
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
 		if (file) {
 			*mnt = mntget(file->f_vfsmnt);
 			*dentry = dget(file->f_dentry);
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 			put_files_struct(files);
 			return 0;
 		}
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 		put_files_struct(files);
 	}
 	return -ENOENT;
@@ -805,7 +805,7 @@
 			files = get_files_struct(p);
 			if (!files)
 				goto out;
-			spin_lock(&files->file_lock);
+			read_lock(&files->file_lock);
 			for (fd = filp->f_pos-2;
 			     fd < files->max_fds;
 			     fd++, filp->f_pos++) {
@@ -813,7 +813,7 @@
 
 				if (!fcheck_files(files, fd))
 					continue;
-				spin_unlock(&files->file_lock);
+				read_unlock(&files->file_lock);
 
 				j = NUMBUF;
 				i = fd;
@@ -825,12 +825,12 @@
 
 				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
 				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
-					spin_lock(&files->file_lock);
+					read_lock(&files->file_lock);
 					break;
 				}
-				spin_lock(&files->file_lock);
+				read_lock(&files->file_lock);
 			}
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 			put_files_struct(files);
 	}
 out:
@@ -1003,9 +1003,9 @@
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 		if (fcheck_files(files, fd)) {
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 			put_files_struct(files);
 			if (task_dumpable(task)) {
 				inode->i_uid = task->euid;
@@ -1017,7 +1017,7 @@
 			security_task_to_inode(task, inode);
 			return 1;
 		}
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 		put_files_struct(files);
 	}
 	d_drop(dentry);
@@ -1109,7 +1109,7 @@
 	if (!files)
 		goto out_unlock;
 	inode->i_mode = S_IFLNK;
-	spin_lock(&files->file_lock);
+	read_lock(&files->file_lock);
 	file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
@@ -1117,7 +1117,7 @@
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
-	spin_unlock(&files->file_lock);
+	read_unlock(&files->file_lock);
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -1127,7 +1127,7 @@
 	return NULL;
 
 out_unlock2:
-	spin_unlock(&files->file_lock);
+	read_unlock(&files->file_lock);
 	put_files_struct(files);
 out_unlock:
 	iput(inode);
diff -urN RC8-rc2-bk12/fs/select.c RC8-rc2-bk12-current/fs/select.c
--- RC8-rc2-bk12/fs/select.c	2003-10-09 17:34:47.000000000 -0400
+++ RC8-rc2-bk12-current/fs/select.c	2004-08-02 12:34:06.000000000 -0400
@@ -184,9 +184,9 @@
 	int retval, i;
 	long __timeout = *timeout;
 
- 	spin_lock(&current->files->file_lock);
+ 	read_lock(&current->files->file_lock);
 	retval = max_select_fd(n, fds);
-	spin_unlock(&current->files->file_lock);
+	read_unlock(&current->files->file_lock);
 
 	if (retval < 0)
 		return retval;
diff -urN RC8-rc2-bk12/include/linux/file.h RC8-rc2-bk12-current/include/linux/file.h
--- RC8-rc2-bk12/include/linux/file.h	2004-05-10 00:23:41.000000000 -0400
+++ RC8-rc2-bk12-current/include/linux/file.h	2004-08-02 12:35:52.374278504 -0400
@@ -21,7 +21,7 @@
  */
 struct files_struct {
         atomic_t count;
-        spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
+        rwlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
         int max_fds;
         int max_fdset;
         int next_fd;
diff -urN RC8-rc2-bk12/include/linux/init_task.h RC8-rc2-bk12-current/include/linux/init_task.h
--- RC8-rc2-bk12/include/linux/init_task.h	2004-07-18 09:08:44.000000000 -0400
+++ RC8-rc2-bk12-current/include/linux/init_task.h	2004-08-02 12:35:37.000000000 -0400
@@ -6,7 +6,7 @@
 #define INIT_FILES \
 { 							\
 	.count		= ATOMIC_INIT(1), 		\
-	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+	.file_lock	= RW_LOCK_UNLOCKED, 		\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
 	.max_fdset	= __FD_SETSIZE, 		\
 	.next_fd	= 0, 				\
diff -urN RC8-rc2-bk12/kernel/fork.c RC8-rc2-bk12-current/kernel/fork.c
--- RC8-rc2-bk12/kernel/fork.c	2004-08-02 12:19:37.000000000 -0400
+++ RC8-rc2-bk12-current/kernel/fork.c	2004-08-02 12:37:08.000000000 -0400
@@ -680,7 +680,7 @@
 
 	atomic_set(&newf->count, 1);
 
-	newf->file_lock	    = SPIN_LOCK_UNLOCKED;
+	newf->file_lock	    = RW_LOCK_UNLOCKED;
 	newf->next_fd	    = 0;
 	newf->max_fds	    = NR_OPEN_DEFAULT;
 	newf->max_fdset	    = __FD_SETSIZE;
@@ -693,13 +693,13 @@
 	size = oldf->max_fdset;
 	if (size > __FD_SETSIZE) {
 		newf->max_fdset = 0;
-		spin_lock(&newf->file_lock);
+		write_lock(&newf->file_lock);
 		error = expand_fdset(newf, size-1);
-		spin_unlock(&newf->file_lock);
+		write_unlock(&newf->file_lock);
 		if (error)
 			goto out_release;
 	}
-	spin_lock(&oldf->file_lock);
+	read_lock(&oldf->file_lock);
 
 	open_files = count_open_files(oldf, size);
 
@@ -710,15 +710,15 @@
 	 */
 	nfds = NR_OPEN_DEFAULT;
 	if (open_files > nfds) {
-		spin_unlock(&oldf->file_lock);
+		read_unlock(&oldf->file_lock);
 		newf->max_fds = 0;
-		spin_lock(&newf->file_lock);
+		write_lock(&newf->file_lock);
 		error = expand_fd_array(newf, open_files-1);
-		spin_unlock(&newf->file_lock);
+		write_unlock(&newf->file_lock);
 		if (error) 
 			goto out_release;
 		nfds = newf->max_fds;
-		spin_lock(&oldf->file_lock);
+		read_lock(&oldf->file_lock);
 	}
 
 	old_fds = oldf->fd;
@@ -733,7 +733,7 @@
 			get_file(f);
 		*new_fds++ = f;
 	}
-	spin_unlock(&oldf->file_lock);
+	read_unlock(&oldf->file_lock);
 
 	/* compute the remainder to be cleared */
 	size = (newf->max_fds - open_files) * sizeof(struct file *);
diff -urN RC8-rc2-bk12/net/ipv4/netfilter/ipt_owner.c RC8-rc2-bk12-current/net/ipv4/netfilter/ipt_owner.c
--- RC8-rc2-bk12/net/ipv4/netfilter/ipt_owner.c	2004-07-18 09:08:45.000000000 -0400
+++ RC8-rc2-bk12-current/net/ipv4/netfilter/ipt_owner.c	2004-08-02 12:37:58.000000000 -0400
@@ -35,17 +35,17 @@
 		task_lock(p);
 		files = p->files;
 		if(files) {
-			spin_lock(&files->file_lock);
+			read_lock(&files->file_lock);
 			for (i=0; i < files->max_fds; i++) {
 				if (fcheck_files(files, i) ==
 				    skb->sk->sk_socket->file) {
-					spin_unlock(&files->file_lock);
+					read_unlock(&files->file_lock);
 					task_unlock(p);
 					read_unlock(&tasklist_lock);
 					return 1;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
@@ -67,17 +67,17 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 		for (i=0; i < files->max_fds; i++) {
 			if (fcheck_files(files, i) ==
 			    skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+				read_unlock(&files->file_lock);
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 	}
 	task_unlock(p);
 out:
@@ -101,14 +101,14 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			read_lock(&files->file_lock);
 			for (i=0; i < files->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 		}
 		task_unlock(p);
 		if (found)
diff -urN RC8-rc2-bk12/net/ipv6/netfilter/ip6t_owner.c RC8-rc2-bk12-current/net/ipv6/netfilter/ip6t_owner.c
--- RC8-rc2-bk12/net/ipv6/netfilter/ip6t_owner.c	2004-07-18 09:08:45.000000000 -0400
+++ RC8-rc2-bk12-current/net/ipv6/netfilter/ip6t_owner.c	2004-08-02 12:38:12.000000000 -0400
@@ -34,16 +34,16 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 		for (i=0; i < files->max_fds; i++) {
 			if (fcheck_files(files, i) == skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+				read_unlock(&files->file_lock);
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 	}
 	task_unlock(p);
 out:
@@ -67,14 +67,14 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			read_lock(&files->file_lock);
 			for (i=0; i < files->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			read_unlock(&files->file_lock);
 		}
 		task_unlock(p);
 		if (found)
diff -urN RC8-rc2-bk12/security/selinux/hooks.c RC8-rc2-bk12-current/security/selinux/hooks.c
--- RC8-rc2-bk12/security/selinux/hooks.c	2004-08-02 12:19:37.000000000 -0400
+++ RC8-rc2-bk12-current/security/selinux/hooks.c	2004-08-02 12:39:03.000000000 -0400
@@ -1794,7 +1794,7 @@
 
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 
-	spin_lock(&files->file_lock);
+	read_lock(&files->file_lock);
 	for (;;) {
 		unsigned long set, i;
 		int fd;
@@ -1806,7 +1806,7 @@
 		set = files->open_fds->fds_bits[j];
 		if (!set)
 			continue;
-		spin_unlock(&files->file_lock);
+		read_unlock(&files->file_lock);
 		for ( ; set ; i++,set >>= 1) {
 			if (set & 1) {
 				file = fget(i);
@@ -1838,10 +1838,10 @@
 				fput(file);
 			}
 		}
-		spin_lock(&files->file_lock);
+		read_lock(&files->file_lock);
 
 	}
-	spin_unlock(&files->file_lock);
+	read_unlock(&files->file_lock);
 }
 
 static void selinux_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
