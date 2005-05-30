Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVE3LDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVE3LDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVE3LDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:03:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51605 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261403AbVE3K65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:58:57 -0400
Date: Mon, 30 May 2005 16:27:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc: patch 3/6] Break up files struct
Message-ID: <20050530105704.GD5534@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050530105042.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530105042.GA5534@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In order for the RCU to work, the file table array, sets and their
sizes must be updated atomically. Instead of ensuring this
through too many memory barriers, we put the arrays and their
sizes in a separate structure. This patch takes the first
step of putting the file table elements in a separate
structure fdtable that is embedded withing files_struct.
It also changes all the users to refer to the file table
using files_fdtable() macro. Subsequent applciation of
RCU becomes easier after this.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 arch/alpha/kernel/osf_sys.c     |    4 +
 arch/sparc64/solaris/ioctl.c    |    8 ++-
 drivers/char/tty_io.c           |    4 +
 fs/compat.c                     |    9 ++--
 fs/exec.c                       |    8 ++-
 fs/fcntl.c                      |   46 +++++++++++++---------
 fs/file.c                       |   42 ++++++++++++--------
 fs/locks.c                      |    8 ++-
 fs/open.c                       |   41 +++++++++++---------
 fs/proc/array.c                 |    5 +-
 fs/proc/base.c                  |    4 +
 fs/select.c                     |   12 ++++-
 include/linux/file.h            |   23 +++++++----
 include/linux/init_task.h       |   13 ++++--
 kernel/exit.c                   |   21 ++++++----
 kernel/fork.c                   |   82 ++++++++++++++++++++++++----------------
 net/ipv4/netfilter/ipt_owner.c  |   12 ++++-
 net/ipv6/netfilter/ip6t_owner.c |    8 ++-
 security/selinux/hooks.c        |    6 +-
 19 files changed, 225 insertions(+), 131 deletions(-)

diff -puN arch/alpha/kernel/osf_sys.c~break-up-files-struct arch/alpha/kernel/osf_sys.c
--- linux-2.6.12-rc5-fd/arch/alpha/kernel/osf_sys.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/arch/alpha/kernel/osf_sys.c	2005-05-29 18:54:07.000000000 +0530
@@ -974,6 +974,7 @@ osf_select(int n, fd_set __user *inp, fd
 	size_t size;
 	long timeout;
 	int ret = -EINVAL;
+	struct fdtable *fdt;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -995,7 +996,8 @@ osf_select(int n, fd_set __user *inp, fd
 		}
 	}
 
-	if (n < 0 || n > current->files->max_fdset)
+	fdt = files_fdtable(current->files);
+	if (n < 0 || n > fdt->max_fdset)
 		goto out_nofds;
 
 	/*
diff -puN arch/sparc64/solaris/ioctl.c~break-up-files-struct arch/sparc64/solaris/ioctl.c
--- linux-2.6.12-rc5-fd/arch/sparc64/solaris/ioctl.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/arch/sparc64/solaris/ioctl.c	2005-05-29 18:54:07.000000000 +0530
@@ -293,11 +293,13 @@ static struct module_info {
 static inline int solaris_sockmod(unsigned int fd, unsigned int cmd, u32 arg)
 {
 	struct inode *ino;
+	struct fdtable *fdt;
 	/* I wonder which of these tests are superfluous... --patrik */
 	spin_lock(&current->files->file_lock);
-	if (! current->files->fd[fd] ||
-	    ! current->files->fd[fd]->f_dentry ||
-	    ! (ino = current->files->fd[fd]->f_dentry->d_inode) ||
+	fdt = files_fdtable(current->files);
+	if (! fdt->fd[fd] ||
+	    ! fdt->fd[fd]->f_dentry ||
+	    ! (ino = fdt->fd[fd]->f_dentry->d_inode) ||
 	    ! S_ISSOCK(ino->i_mode)) {
 		spin_unlock(&current->files->file_lock);
 		return TBADF;
diff -puN drivers/char/tty_io.c~break-up-files-struct drivers/char/tty_io.c
--- linux-2.6.12-rc5-fd/drivers/char/tty_io.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/drivers/char/tty_io.c	2005-05-29 18:54:07.000000000 +0530
@@ -2415,6 +2415,7 @@ static void __do_SAK(void *arg)
 	int		i;
 	struct file	*filp;
 	struct tty_ldisc *disc;
+	struct fdtable *fdt;
 	
 	if (!tty)
 		return;
@@ -2441,7 +2442,8 @@ static void __do_SAK(void *arg)
 		task_lock(p);
 		if (p->files) {
 			spin_lock(&p->files->file_lock);
-			for (i=0; i < p->files->max_fds; i++) {
+			fdt = files_fdtable(p->files);
+			for (i=0; i < fdt->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
 				if (!filp)
 					continue;
diff -puN fs/compat.c~break-up-files-struct fs/compat.c
--- linux-2.6.12-rc5-fd/fs/compat.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/compat.c	2005-05-29 18:54:07.000000000 +0530
@@ -1694,7 +1694,8 @@ compat_sys_select(int n, compat_ulong_t 
 	fd_set_bits fds;
 	char *bits;
 	long timeout;
-	int size, max_fdset, ret = -EINVAL;
+	int size, ret = -EINVAL;
+	struct fdtable *fdt;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -1720,9 +1721,9 @@ compat_sys_select(int n, compat_ulong_t 
 		goto out_nofds;
 
 	/* max_fdset can increase, so grab it once to avoid race */
-	max_fdset = current->files->max_fdset;
-	if (n > max_fdset)
-		n = max_fdset;
+	fdt = files_fdtable(current->files);
+	if (n > fdt->max_fdset)
+		n = fdt->max_fdset;
 
 	/*
 	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
diff -puN fs/exec.c~break-up-files-struct fs/exec.c
--- linux-2.6.12-rc5-fd/fs/exec.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/exec.c	2005-05-29 18:54:07.000000000 +0530
@@ -787,6 +787,7 @@ no_thread_group:
 static inline void flush_old_files(struct files_struct * files)
 {
 	long j = -1;
+	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
 	for (;;) {
@@ -794,12 +795,13 @@ static inline void flush_old_files(struc
 
 		j++;
 		i = j * __NFDBITS;
-		if (i >= files->max_fds || i >= files->max_fdset)
+		fdt = files_fdtable(files);
+		if (i >= fdt->max_fds || i >= fdt->max_fdset)
 			break;
-		set = files->close_on_exec->fds_bits[j];
+		set = fdt->close_on_exec->fds_bits[j];
 		if (!set)
 			continue;
-		files->close_on_exec->fds_bits[j] = 0;
+		fdt->close_on_exec->fds_bits[j] = 0;
 		spin_unlock(&files->file_lock);
 		for ( ; set ; i++,set >>= 1) {
 			if (set & 1) {
diff -puN fs/fcntl.c~break-up-files-struct fs/fcntl.c
--- linux-2.6.12-rc5-fd/fs/fcntl.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/fcntl.c	2005-05-29 18:54:07.000000000 +0530
@@ -24,20 +24,24 @@
 void fastcall set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
+	struct fdtable *fdt;
 	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
 	if (flag)
-		FD_SET(fd, files->close_on_exec);
+		FD_SET(fd, fdt->close_on_exec);
 	else
-		FD_CLR(fd, files->close_on_exec);
+		FD_CLR(fd, fdt->close_on_exec);
 	spin_unlock(&files->file_lock);
 }
 
 static inline int get_close_on_exec(unsigned int fd)
 {
 	struct files_struct *files = current->files;
+	struct fdtable *fdt;
 	int res;
 	spin_lock(&files->file_lock);
-	res = FD_ISSET(fd, files->close_on_exec);
+	fdt = files_fdtable(files);
+	res = FD_ISSET(fd, fdt->close_on_exec);
 	spin_unlock(&files->file_lock);
 	return res;
 }
@@ -54,24 +58,26 @@ static int locate_fd(struct files_struct
 	unsigned int newfd;
 	unsigned int start;
 	int error;
+	struct fdtable *fdt;
 
 	error = -EINVAL;
 	if (orig_start >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
+	fdt = files_fdtable(files);
 repeat:
 	/*
 	 * Someone might have closed fd's in the range
-	 * orig_start..files->next_fd
+	 * orig_start..fdt->next_fd
 	 */
 	start = orig_start;
-	if (start < files->next_fd)
-		start = files->next_fd;
+	if (start < fdt->next_fd)
+		start = fdt->next_fd;
 
 	newfd = start;
-	if (start < files->max_fdset) {
-		newfd = find_next_zero_bit(files->open_fds->fds_bits,
-			files->max_fdset, start);
+	if (start < fdt->max_fdset) {
+		newfd = find_next_zero_bit(fdt->open_fds->fds_bits,
+			fdt->max_fdset, start);
 	}
 	
 	error = -EMFILE;
@@ -89,8 +95,8 @@ repeat:
 	if (error)
 		goto repeat;
 
-	if (start <= files->next_fd)
-		files->next_fd = newfd + 1;
+	if (start <= fdt->next_fd)
+		fdt->next_fd = newfd + 1;
 	
 	error = newfd;
 	
@@ -101,13 +107,15 @@ out:
 static int dupfd(struct file *file, unsigned int start)
 {
 	struct files_struct * files = current->files;
+	struct fdtable *fdt;
 	int fd;
 
 	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
 	fd = locate_fd(files, file, start);
 	if (fd >= 0) {
-		FD_SET(fd, files->open_fds);
-		FD_CLR(fd, files->close_on_exec);
+		FD_SET(fd, fdt->open_fds);
+		FD_CLR(fd, fdt->close_on_exec);
 		spin_unlock(&files->file_lock);
 		fd_install(fd, file);
 	} else {
@@ -123,6 +131,7 @@ asmlinkage long sys_dup2(unsigned int ol
 	int err = -EBADF;
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
+	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
 	if (!(file = fcheck(oldfd)))
@@ -148,13 +157,14 @@ asmlinkage long sys_dup2(unsigned int ol
 
 	/* Yes. It's a race. In user space. Nothing sane to do */
 	err = -EBUSY;
-	tofree = files->fd[newfd];
-	if (!tofree && FD_ISSET(newfd, files->open_fds))
+	fdt = files_fdtable(files);
+	tofree = fdt->fd[newfd];
+	if (!tofree && FD_ISSET(newfd, fdt->open_fds))
 		goto out_fput;
 
-	files->fd[newfd] = file;
-	FD_SET(newfd, files->open_fds);
-	FD_CLR(newfd, files->close_on_exec);
+	fdt->fd[newfd] = file;
+	FD_SET(newfd, fdt->open_fds);
+	FD_CLR(newfd, fdt->close_on_exec);
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
diff -puN fs/file.c~break-up-files-struct fs/file.c
--- linux-2.6.12-rc5-fd/fs/file.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/file.c	2005-05-29 18:54:07.000000000 +0530
@@ -59,13 +59,15 @@ static int expand_fd_array(struct files_
 {
 	struct file **new_fds;
 	int error, nfds;
+	struct fdtable *fdt;
 
 	
 	error = -EMFILE;
-	if (files->max_fds >= NR_OPEN || nr >= NR_OPEN)
+	fdt = files_fdtable(files);
+	if (fdt->max_fds >= NR_OPEN || nr >= NR_OPEN)
 		goto out;
 
-	nfds = files->max_fds;
+	nfds = fdt->max_fds;
 	spin_unlock(&files->file_lock);
 
 	/* 
@@ -95,13 +97,14 @@ static int expand_fd_array(struct files_
 		goto out;
 
 	/* Copy the existing array and install the new pointer */
+	fdt = files_fdtable(files);
 
-	if (nfds > files->max_fds) {
+	if (nfds > fdt->max_fds) {
 		struct file **old_fds;
 		int i;
 		
-		old_fds = xchg(&files->fd, new_fds);
-		i = xchg(&files->max_fds, nfds);
+		old_fds = xchg(&fdt->fd, new_fds);
+		i = xchg(&fdt->max_fds, nfds);
 
 		/* Don't copy/clear the array if we are creating a new
 		   fd array for fork() */
@@ -164,12 +167,14 @@ static int expand_fdset(struct files_str
 {
 	fd_set *new_openset = NULL, *new_execset = NULL;
 	int error, nfds = 0;
+	struct fdtable *fdt;
 
 	error = -EMFILE;
-	if (files->max_fdset >= NR_OPEN || nr >= NR_OPEN)
+	fdt = files_fdtable(files);
+	if (fdt->max_fdset >= NR_OPEN || nr >= NR_OPEN)
 		goto out;
 
-	nfds = files->max_fdset;
+	nfds = fdt->max_fdset;
 	spin_unlock(&files->file_lock);
 
 	/* Expand to the max in easy steps */
@@ -193,24 +198,25 @@ static int expand_fdset(struct files_str
 	error = 0;
 	
 	/* Copy the existing tables and install the new pointers */
-	if (nfds > files->max_fdset) {
-		int i = files->max_fdset / (sizeof(unsigned long) * 8);
-		int count = (nfds - files->max_fdset) / 8;
+	fdt = files_fdtable(files);
+	if (nfds > fdt->max_fdset) {
+		int i = fdt->max_fdset / (sizeof(unsigned long) * 8);
+		int count = (nfds - fdt->max_fdset) / 8;
 		
 		/* 
 		 * Don't copy the entire array if the current fdset is
 		 * not yet initialised.  
 		 */
 		if (i) {
-			memcpy (new_openset, files->open_fds, files->max_fdset/8);
-			memcpy (new_execset, files->close_on_exec, files->max_fdset/8);
+			memcpy (new_openset, fdt->open_fds, fdt->max_fdset/8);
+			memcpy (new_execset, fdt->close_on_exec, fdt->max_fdset/8);
 			memset (&new_openset->fds_bits[i], 0, count);
 			memset (&new_execset->fds_bits[i], 0, count);
 		}
 		
-		nfds = xchg(&files->max_fdset, nfds);
-		new_openset = xchg(&files->open_fds, new_openset);
-		new_execset = xchg(&files->close_on_exec, new_execset);
+		nfds = xchg(&fdt->max_fdset, nfds);
+		new_openset = xchg(&fdt->open_fds, new_openset);
+		new_execset = xchg(&fdt->close_on_exec, new_execset);
 		spin_unlock(&files->file_lock);
 		free_fdset (new_openset, nfds);
 		free_fdset (new_execset, nfds);
@@ -237,13 +243,15 @@ out:
 int expand_files(struct files_struct *files, int nr)
 {
 	int err, expand = 0;
+	struct fdtable *fdt;
 
-	if (nr >= files->max_fdset) {
+	fdt = files_fdtable(files);
+	if (nr >= fdt->max_fdset) {
 		expand = 1;
 		if ((err = expand_fdset(files, nr)))
 			goto out;
 	}
-	if (nr >= files->max_fds) {
+	if (nr >= fdt->max_fds) {
 		expand = 1;
 		if ((err = expand_fd_array(files, nr)))
 			goto out;
diff -puN fs/locks.c~break-up-files-struct fs/locks.c
--- linux-2.6.12-rc5-fd/fs/locks.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/locks.c	2005-05-29 18:54:07.000000000 +0530
@@ -2175,21 +2175,23 @@ void steal_locks(fl_owner_t from)
 {
 	struct files_struct *files = current->files;
 	int i, j;
+	struct fdtable *fdt;
 
 	if (from == files)
 		return;
 
 	lock_kernel();
 	j = 0;
+	fdt = files_fdtable(files);
 	for (;;) {
 		unsigned long set;
 		i = j * __NFDBITS;
-		if (i >= files->max_fdset || i >= files->max_fds)
+		if (i >= fdt->max_fdset || i >= fdt->max_fds)
 			break;
-		set = files->open_fds->fds_bits[j++];
+		set = fdt->open_fds->fds_bits[j++];
 		while (set) {
 			if (set & 1) {
-				struct file *file = files->fd[i];
+				struct file *file = fdt->fd[i];
 				if (file)
 					__steal_locks(file, from);
 			}
diff -puN fs/open.c~break-up-files-struct fs/open.c
--- linux-2.6.12-rc5-fd/fs/open.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/open.c	2005-05-29 18:54:07.000000000 +0530
@@ -839,14 +839,16 @@ int get_unused_fd(void)
 {
 	struct files_struct * files = current->files;
 	int fd, error;
+	struct fdtable *fdt;
 
   	error = -EMFILE;
 	spin_lock(&files->file_lock);
 
 repeat:
- 	fd = find_next_zero_bit(files->open_fds->fds_bits, 
-				files->max_fdset, 
-				files->next_fd);
+	fdt = files_fdtable(files);
+ 	fd = find_next_zero_bit(fdt->open_fds->fds_bits, 
+				fdt->max_fdset, 
+				fdt->next_fd);
 
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
@@ -869,14 +871,14 @@ repeat:
 		goto repeat;
 	}
 
-	FD_SET(fd, files->open_fds);
-	FD_CLR(fd, files->close_on_exec);
-	files->next_fd = fd + 1;
+	FD_SET(fd, fdt->open_fds);
+	FD_CLR(fd, fdt->close_on_exec);
+	fdt->next_fd = fd + 1;
 #if 1
 	/* Sanity check */
-	if (files->fd[fd] != NULL) {
+	if (fdt->fd[fd] != NULL) {
 		printk(KERN_WARNING "get_unused_fd: slot %d not NULL!\n", fd);
-		files->fd[fd] = NULL;
+		fdt->fd[fd] = NULL;
 	}
 #endif
 	error = fd;
@@ -890,9 +892,10 @@ EXPORT_SYMBOL(get_unused_fd);
 
 static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
-	__FD_CLR(fd, files->open_fds);
-	if (fd < files->next_fd)
-		files->next_fd = fd;
+	struct fdtable *fdt = files_fdtable(files);
+	__FD_CLR(fd, fdt->open_fds);
+	if (fd < fdt->next_fd)
+		fdt->next_fd = fd;
 }
 
 void fastcall put_unused_fd(unsigned int fd)
@@ -921,10 +924,12 @@ EXPORT_SYMBOL(put_unused_fd);
 void fastcall fd_install(unsigned int fd, struct file * file)
 {
 	struct files_struct *files = current->files;
+	struct fdtable *fdt;
 	spin_lock(&files->file_lock);
-	if (unlikely(files->fd[fd] != NULL))
+	fdt = files_fdtable(files);
+	if (unlikely(fdt->fd[fd] != NULL))
 		BUG();
-	files->fd[fd] = file;
+	fdt->fd[fd] = file;
 	spin_unlock(&files->file_lock);
 }
 
@@ -1015,15 +1020,17 @@ asmlinkage long sys_close(unsigned int f
 {
 	struct file * filp;
 	struct files_struct *files = current->files;
+	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
-	if (fd >= files->max_fds)
+	fdt = files_fdtable(files);
+	if (fd >= fdt->max_fds)
 		goto out_unlock;
-	filp = files->fd[fd];
+	filp = fdt->fd[fd];
 	if (!filp)
 		goto out_unlock;
-	files->fd[fd] = NULL;
-	FD_CLR(fd, files->close_on_exec);
+	fdt->fd[fd] = NULL;
+	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
 	return filp_close(filp, files);
diff -puN fs/proc/array.c~break-up-files-struct fs/proc/array.c
--- linux-2.6.12-rc5-fd/fs/proc/array.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/proc/array.c	2005-05-29 18:54:07.000000000 +0530
@@ -159,6 +159,7 @@ static inline char * task_state(struct t
 {
 	struct group_info *group_info;
 	int g;
+	struct fdtable *fdt = NULL;
 
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
@@ -179,10 +180,12 @@ static inline char * task_state(struct t
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
 	task_lock(p);
+	if (p->files)
+		fdt = files_fdtable(p->files);
 	buffer += sprintf(buffer,
 		"FDSize:\t%d\n"
 		"Groups:\t",
-		p->files ? p->files->max_fds : 0);
+		fdt ? fdt->max_fds : 0);
 
 	group_info = p->group_info;
 	get_group_info(group_info);
diff -puN fs/proc/base.c~break-up-files-struct fs/proc/base.c
--- linux-2.6.12-rc5-fd/fs/proc/base.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/proc/base.c	2005-05-29 18:54:07.000000000 +0530
@@ -978,6 +978,7 @@ static int proc_readfd(struct file * fil
 	int retval;
 	char buf[NUMBUF];
 	struct files_struct * files;
+	struct fdtable *fdt;
 
 	retval = -ENOENT;
 	if (!pid_alive(p))
@@ -1001,8 +1002,9 @@ static int proc_readfd(struct file * fil
 			if (!files)
 				goto out;
 			spin_lock(&files->file_lock);
+			fdt = files_fdtable(files);
 			for (fd = filp->f_pos-2;
-			     fd < files->max_fds;
+			     fd < fdt->max_fds;
 			     fd++, filp->f_pos++) {
 				unsigned int i,j;
 
diff -puN fs/select.c~break-up-files-struct fs/select.c
--- linux-2.6.12-rc5-fd/fs/select.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/fs/select.c	2005-05-29 18:54:07.000000000 +0530
@@ -132,11 +132,13 @@ static int max_select_fd(unsigned long n
 	unsigned long *open_fds;
 	unsigned long set;
 	int max;
+	struct fdtable *fdt;
 
 	/* handle last in-complete long-word first */
 	set = ~(~0UL << (n & (__NFDBITS-1)));
 	n /= __NFDBITS;
-	open_fds = current->files->open_fds->fds_bits+n;
+	fdt = files_fdtable(current->files);
+	open_fds = fdt->open_fds->fds_bits+n;
 	max = 0;
 	if (set) {
 		set &= BITS(fds, n);
@@ -299,6 +301,7 @@ sys_select(int n, fd_set __user *inp, fd
 	char *bits;
 	long timeout;
 	int ret, size, max_fdset;
+	struct fdtable *fdt;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -326,7 +329,8 @@ sys_select(int n, fd_set __user *inp, fd
 		goto out_nofds;
 
 	/* max_fdset can increase, so grab it once to avoid race */
-	max_fdset = current->files->max_fdset;
+	fdt = files_fdtable(current->files);
+	max_fdset = fdt->max_fdset;
 	if (n > max_fdset)
 		n = max_fdset;
 
@@ -464,9 +468,11 @@ asmlinkage long sys_poll(struct pollfd _
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
+	struct fdtable *fdt;
 
 	/* Do a sanity check on nfds ... */
-	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
+	fdt = files_fdtable(current->files);
+	if (nfds > fdt->max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
 	if (timeout) {
diff -puN include/linux/file.h~break-up-files-struct include/linux/file.h
--- linux-2.6.12-rc5-fd/include/linux/file.h~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/include/linux/file.h	2005-05-29 18:54:07.000000000 +0530
@@ -16,23 +16,29 @@
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
 
+struct fdtable {
+	int max_fds;
+	int max_fdset;
+	int next_fd;
+	struct file ** fd;      /* current fd array */
+	fd_set *close_on_exec;
+	fd_set *open_fds;
+};
+
 /*
  * Open file table structure
  */
 struct files_struct {
         atomic_t count;
         spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
-        int max_fds;
-        int max_fdset;
-        int next_fd;
-        struct file ** fd;      /* current fd array */
-        fd_set *close_on_exec;
-        fd_set *open_fds;
+	struct fdtable fdtab;
         fd_set close_on_exec_init;
         fd_set open_fds_init;
         struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
+#define files_fdtable(files) (&(files)->fdtab)
+
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
 
@@ -63,9 +69,10 @@ extern int expand_files(struct files_str
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {
 	struct file * file = NULL;
+	struct fdtable *fdt = files_fdtable(files);
 
-	if (fd < files->max_fds)
-		file = files->fd[fd];
+	if (fd < fdt->max_fds)
+		file = fdt->fd[fd];
 	return file;
 }
 
diff -puN include/linux/init_task.h~break-up-files-struct include/linux/init_task.h
--- linux-2.6.12-rc5-fd/include/linux/init_task.h~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/include/linux/init_task.h	2005-05-29 18:54:07.000000000 +0530
@@ -3,16 +3,21 @@
 
 #include <linux/file.h>
 
-#define INIT_FILES \
-{ 							\
-	.count		= ATOMIC_INIT(1), 		\
-	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+#define INIT_FDTABLE \
+{							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
 	.max_fdset	= __FD_SETSIZE, 		\
 	.next_fd	= 0, 				\
 	.fd		= &init_files.fd_array[0], 	\
 	.close_on_exec	= &init_files.close_on_exec_init, \
 	.open_fds	= &init_files.open_fds_init, 	\
+}
+
+#define INIT_FILES \
+{ 							\
+	.count		= ATOMIC_INIT(1), 		\
+	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+	.fdtab		= INIT_FDTABLE,			\
 	.close_on_exec_init = { { 0, } }, 		\
 	.open_fds_init	= { { 0, } }, 			\
 	.fd_array	= { NULL, } 			\
diff -puN kernel/exit.c~break-up-files-struct kernel/exit.c
--- linux-2.6.12-rc5-fd/kernel/exit.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/kernel/exit.c	2005-05-29 18:54:07.000000000 +0530
@@ -363,17 +363,19 @@ EXPORT_SYMBOL(daemonize);
 static inline void close_files(struct files_struct * files)
 {
 	int i, j;
+	struct fdtable *fdt;
 
 	j = 0;
+	fdt = files_fdtable(files);
 	for (;;) {
 		unsigned long set;
 		i = j * __NFDBITS;
-		if (i >= files->max_fdset || i >= files->max_fds)
+		if (i >= fdt->max_fdset || i >= fdt->max_fds)
 			break;
-		set = files->open_fds->fds_bits[j++];
+		set = fdt->open_fds->fds_bits[j++];
 		while (set) {
 			if (set & 1) {
-				struct file * file = xchg(&files->fd[i], NULL);
+				struct file * file = xchg(&fdt->fd[i], NULL);
 				if (file)
 					filp_close(file, files);
 			}
@@ -398,16 +400,19 @@ struct files_struct *get_files_struct(st
 
 void fastcall put_files_struct(struct files_struct *files)
 {
+	struct fdtable *fdt;
+
 	if (atomic_dec_and_test(&files->count)) {
 		close_files(files);
 		/*
 		 * Free the fd and fdset arrays if we expanded them.
 		 */
-		if (files->fd != &files->fd_array[0])
-			free_fd_array(files->fd, files->max_fds);
-		if (files->max_fdset > __FD_SETSIZE) {
-			free_fdset(files->open_fds, files->max_fdset);
-			free_fdset(files->close_on_exec, files->max_fdset);
+		fdt = files_fdtable(files);
+		if (fdt->fd != &files->fd_array[0])
+			free_fd_array(fdt->fd, fdt->max_fds);
+		if (fdt->max_fdset > __FD_SETSIZE) {
+			free_fdset(fdt->open_fds, fdt->max_fdset);
+			free_fdset(fdt->close_on_exec, fdt->max_fdset);
 		}
 		kmem_cache_free(files_cachep, files);
 	}
diff -puN kernel/fork.c~break-up-files-struct kernel/fork.c
--- linux-2.6.12-rc5-fd/kernel/fork.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/kernel/fork.c	2005-05-29 18:54:07.000000000 +0530
@@ -562,21 +562,47 @@ static inline int copy_fs(unsigned long 
 static int count_open_files(struct files_struct *files, int size)
 {
 	int i;
+	struct fdtable *fdt;
 
 	/* Find the last open fd */
+	fdt = files_fdtable(files);
 	for (i = size/(8*sizeof(long)); i > 0; ) {
-		if (files->open_fds->fds_bits[--i])
+		if (fdt->open_fds->fds_bits[--i])
 			break;
 	}
 	i = (i+1) * 8 * sizeof(long);
 	return i;
 }
 
+static struct files_struct *alloc_files(void)
+{
+	struct files_struct *newf;
+	struct fdtable *fdt;
+
+	newf = kmem_cache_alloc(files_cachep, SLAB_KERNEL);
+	if (!newf) 
+		goto out;
+
+	atomic_set(&newf->count, 1);
+
+	spin_lock_init(&newf->file_lock);
+	fdt = files_fdtable(newf);
+	fdt->next_fd = 0;
+	fdt->max_fds = NR_OPEN_DEFAULT;
+	fdt->max_fdset = __FD_SETSIZE;
+	fdt->close_on_exec = &newf->close_on_exec_init;
+	fdt->open_fds = &newf->open_fds_init;
+	fdt->fd = &newf->fd_array[0];
+out:
+	return newf;
+}
+
 static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct files_struct *oldf, *newf;
 	struct file **old_fds, **new_fds;
 	int open_files, size, i, error = 0, expand;
+	struct fdtable *old_fdt, *new_fdt;
 
 	/*
 	 * A background process may not have any files ...
@@ -597,35 +623,27 @@ static int copy_files(unsigned long clon
 	 */
 	tsk->files = NULL;
 	error = -ENOMEM;
-	newf = kmem_cache_alloc(files_cachep, SLAB_KERNEL);
-	if (!newf) 
+	newf = alloc_files();
+	if (!newf)
 		goto out;
 
-	atomic_set(&newf->count, 1);
-
-	spin_lock_init(&newf->file_lock);
-	newf->next_fd	    = 0;
-	newf->max_fds	    = NR_OPEN_DEFAULT;
-	newf->max_fdset	    = __FD_SETSIZE;
-	newf->close_on_exec = &newf->close_on_exec_init;
-	newf->open_fds	    = &newf->open_fds_init;
-	newf->fd	    = &newf->fd_array[0];
-
 	spin_lock(&oldf->file_lock);
-
-	open_files = count_open_files(oldf, oldf->max_fdset);
+	old_fdt = files_fdtable(oldf);
+	new_fdt = files_fdtable(newf);
+	size = old_fdt->max_fdset;
+	open_files = count_open_files(oldf, old_fdt->max_fdset);
 	expand = 0;
 
 	/*
 	 * Check whether we need to allocate a larger fd array or fd set.
 	 * Note: we're not a clone task, so the open count won't  change.
 	 */
-	if (open_files > newf->max_fdset) {
-		newf->max_fdset = 0;
+	if (open_files > new_fdt->max_fdset) {
+		new_fdt->max_fdset = 0;
 		expand = 1;
 	}
-	if (open_files > newf->max_fds) {
-		newf->max_fds = 0;
+	if (open_files > new_fdt->max_fds) {
+		new_fdt->max_fds = 0;
 		expand = 1;
 	}
 
@@ -640,11 +658,11 @@ static int copy_files(unsigned long clon
 		spin_lock(&oldf->file_lock);
 	}
 
-	old_fds = oldf->fd;
-	new_fds = newf->fd;
+	old_fds = old_fdt->fd;
+	new_fds = new_fdt->fd;
 
-	memcpy(newf->open_fds->fds_bits, oldf->open_fds->fds_bits, open_files/8);
-	memcpy(newf->close_on_exec->fds_bits, oldf->close_on_exec->fds_bits, open_files/8);
+	memcpy(new_fdt->open_fds->fds_bits, old_fdt->open_fds->fds_bits, open_files/8);
+	memcpy(new_fdt->close_on_exec->fds_bits, old_fdt->close_on_exec->fds_bits, open_files/8);
 
 	for (i = open_files; i != 0; i--) {
 		struct file *f = *old_fds++;
@@ -657,24 +675,24 @@ static int copy_files(unsigned long clon
 			 * is partway through open().  So make sure that this
 			 * fd is available to the new process.
 			 */
-			FD_CLR(open_files - i, newf->open_fds);
+			FD_CLR(open_files - i, new_fdt->open_fds);
 		}
 		*new_fds++ = f;
 	}
 	spin_unlock(&oldf->file_lock);
 
 	/* compute the remainder to be cleared */
-	size = (newf->max_fds - open_files) * sizeof(struct file *);
+	size = (new_fdt->max_fds - open_files) * sizeof(struct file *);
 
 	/* This is long word aligned thus could use a optimized version */ 
 	memset(new_fds, 0, size); 
 
-	if (newf->max_fdset > open_files) {
-		int left = (newf->max_fdset-open_files)/8;
+	if (new_fdt->max_fdset > open_files) {
+		int left = (new_fdt->max_fdset-open_files)/8;
 		int start = open_files / (8 * sizeof(unsigned long));
 
-		memset(&newf->open_fds->fds_bits[start], 0, left);
-		memset(&newf->close_on_exec->fds_bits[start], 0, left);
+		memset(&new_fdt->open_fds->fds_bits[start], 0, left);
+		memset(&new_fdt->close_on_exec->fds_bits[start], 0, left);
 	}
 
 	tsk->files = newf;
@@ -683,9 +701,9 @@ out:
 	return error;
 
 out_release:
-	free_fdset (newf->close_on_exec, newf->max_fdset);
-	free_fdset (newf->open_fds, newf->max_fdset);
-	free_fd_array(newf->fd, newf->max_fds);
+	free_fdset (new_fdt->close_on_exec, new_fdt->max_fdset);
+	free_fdset (new_fdt->open_fds, new_fdt->max_fdset);
+	free_fd_array(new_fdt->fd, new_fdt->max_fds);
 	kmem_cache_free(files_cachep, newf);
 	goto out;
 }
diff -puN net/ipv4/netfilter/ipt_owner.c~break-up-files-struct net/ipv4/netfilter/ipt_owner.c
--- linux-2.6.12-rc5-fd/net/ipv4/netfilter/ipt_owner.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/net/ipv4/netfilter/ipt_owner.c	2005-05-29 18:54:07.000000000 +0530
@@ -25,6 +25,7 @@ match_comm(const struct sk_buff *skb, co
 {
 	struct task_struct *g, *p;
 	struct files_struct *files;
+	struct fdtable *fdt;
 	int i;
 
 	read_lock(&tasklist_lock);
@@ -36,7 +37,8 @@ match_comm(const struct sk_buff *skb, co
 		files = p->files;
 		if(files) {
 			spin_lock(&files->file_lock);
-			for (i=0; i < files->max_fds; i++) {
+			fdt = files_fdtable(files);
+			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) ==
 				    skb->sk->sk_socket->file) {
 					spin_unlock(&files->file_lock);
@@ -58,6 +60,7 @@ match_pid(const struct sk_buff *skb, pid
 {
 	struct task_struct *p;
 	struct files_struct *files;
+	struct fdtable *fdt;
 	int i;
 
 	read_lock(&tasklist_lock);
@@ -68,7 +71,8 @@ match_pid(const struct sk_buff *skb, pid
 	files = p->files;
 	if(files) {
 		spin_lock(&files->file_lock);
-		for (i=0; i < files->max_fds; i++) {
+		fdt = files_fdtable(files);
+		for (i=0; i < fdt->max_fds; i++) {
 			if (fcheck_files(files, i) ==
 			    skb->sk->sk_socket->file) {
 				spin_unlock(&files->file_lock);
@@ -90,6 +94,7 @@ match_sid(const struct sk_buff *skb, pid
 {
 	struct task_struct *g, *p;
 	struct file *file = skb->sk->sk_socket->file;
+	struct fdtable *fdt;
 	int i, found=0;
 
 	read_lock(&tasklist_lock);
@@ -102,7 +107,8 @@ match_sid(const struct sk_buff *skb, pid
 		files = p->files;
 		if (files) {
 			spin_lock(&files->file_lock);
-			for (i=0; i < files->max_fds; i++) {
+			fdt = files_fdtable(files);
+			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
diff -puN net/ipv6/netfilter/ip6t_owner.c~break-up-files-struct net/ipv6/netfilter/ip6t_owner.c
--- linux-2.6.12-rc5-fd/net/ipv6/netfilter/ip6t_owner.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/net/ipv6/netfilter/ip6t_owner.c	2005-05-29 18:54:07.000000000 +0530
@@ -25,6 +25,7 @@ match_pid(const struct sk_buff *skb, pid
 {
 	struct task_struct *p;
 	struct files_struct *files;
+	struct fdtable *fdt;
 	int i;
 
 	read_lock(&tasklist_lock);
@@ -35,7 +36,8 @@ match_pid(const struct sk_buff *skb, pid
 	files = p->files;
 	if(files) {
 		spin_lock(&files->file_lock);
-		for (i=0; i < files->max_fds; i++) {
+		fdt = files_fdtable(files);
+		for (i=0; i < fdt->max_fds; i++) {
 			if (fcheck_files(files, i) == skb->sk->sk_socket->file) {
 				spin_unlock(&files->file_lock);
 				task_unlock(p);
@@ -61,6 +63,7 @@ match_sid(const struct sk_buff *skb, pid
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		struct files_struct *files;
+		struct fdtable *fdt;
 		if (p->signal->session != sid)
 			continue;
 
@@ -68,7 +71,8 @@ match_sid(const struct sk_buff *skb, pid
 		files = p->files;
 		if (files) {
 			spin_lock(&files->file_lock);
-			for (i=0; i < files->max_fds; i++) {
+			fdt = files_fdtable(files);
+			for (i=0; i < fdt->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
diff -puN security/selinux/hooks.c~break-up-files-struct security/selinux/hooks.c
--- linux-2.6.12-rc5-fd/security/selinux/hooks.c~break-up-files-struct	2005-05-29 18:54:07.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/security/selinux/hooks.c	2005-05-29 18:54:07.000000000 +0530
@@ -1672,6 +1672,7 @@ static inline void flush_unauthorized_fi
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
 	struct tty_struct *tty = current->signal->tty;
+	struct fdtable *fdt;
 	long j = -1;
 
 	if (tty) {
@@ -1705,9 +1706,10 @@ static inline void flush_unauthorized_fi
 
 		j++;
 		i = j * __NFDBITS;
-		if (i >= files->max_fds || i >= files->max_fdset)
+		fdt = files_fdtable(files);
+		if (i >= fdt->max_fds || i >= fdt->max_fdset)
 			break;
-		set = files->open_fds->fds_bits[j];
+		set = fdt->open_fds->fds_bits[j];
 		if (!set)
 			continue;
 		spin_unlock(&files->file_lock);

_
