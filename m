Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRJRGgX>; Thu, 18 Oct 2001 02:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277325AbRJRGgP>; Thu, 18 Oct 2001 02:36:15 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:29358 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275790AbRJRGgE>; Thu, 18 Oct 2001 02:36:04 -0400
Date: Thu, 18 Oct 2001 12:11:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chip Salzenberg <chip@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011018121124.L11266@in.ibm.com>
Reply-To: maneesh@in.ibm.com
In-Reply-To: <20011017113245.A3849@perlsupport.com> <20011017204204.C2380@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017204204.C2380@athlon.random>; from andrea@suse.de on Wed, Oct 17, 2001 at 08:42:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 08:42:04PM +0200, Andrea Arcangeli wrote:
> On Wed, Oct 17, 2001 at 11:32:45AM -0700, Chip Salzenberg wrote:
> > In 2.4.13pre3aa1, expand_fdset() in fs/file.c has a couple of
> > execution paths that call kfree() on a pointer that hasn't yet been
> > initialized.  A minimal patch is attached.
> 
> Good spotting! Thanks for the fix!! applied.
> 
> CC'ed Maneesh since he's maintaining the rcu_fdset patch AFIK.
> 
> > -- 
> > Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
> >  "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
> 
> > 
> > Index: linux/fs/file.c
> > --- linux/fs/file.c.old	Tue Oct 16 23:28:16 2001
> > +++ linux/fs/file.c	Wed Oct 17 00:29:43 2001
> > @@ -203,5 +203,5 @@
> >  	fd_set *new_openset = 0, *new_execset = 0;
> >  	int error, nfds = 0;
> > -	struct rcu_fd_set *arg;
> > +	struct rcu_fd_set *arg = NULL;
> >  
> >  	error = -EMFILE;

I also removed some un-necessary diffs from the patch. The updated patch is as 
below.

Thanks,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5262355 Extn. 3999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html

diff -urN linux-2.4.12/drivers/char/tty_io.c linux-2.4.12-fs-05/drivers/char/tty_io.c
--- linux-2.4.12/drivers/char/tty_io.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/drivers/char/tty_io.c	Thu Oct 18 10:33:41 2001
@@ -1847,7 +1847,6 @@
 		}
 		task_lock(p);
 		if (p->files) {
-			read_lock(&p->files->file_lock);
 			for (i=0; i < p->files->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
 				if (filp && (filp->f_op == &tty_fops) &&
@@ -1856,7 +1855,6 @@
 					break;
 				}
 			}
-			read_unlock(&p->files->file_lock);
 		}
 		task_unlock(p);
 	}
diff -urN linux-2.4.12/fs/exec.c linux-2.4.12-fs-05/fs/exec.c
--- linux-2.4.12/fs/exec.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/exec.c	Thu Oct 18 10:33:41 2001
@@ -482,7 +482,7 @@
 {
 	long j = -1;
 
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	for (;;) {
 		unsigned long set, i;
 
@@ -494,16 +494,16 @@
 		if (!set)
 			continue;
 		files->close_on_exec->fds_bits[j] = 0;
-		write_unlock(&files->file_lock);
+		spin_unlock(&files->file_lock);
 		for ( ; set ; i++,set >>= 1) {
 			if (set & 1) {
 				sys_close(i);
 			}
 		}
-		write_lock(&files->file_lock);
+		spin_lock(&files->file_lock);
 
 	}
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 }
 
 /*
diff -urN linux-2.4.12/fs/fcntl.c linux-2.4.12-fs-05/fs/fcntl.c
--- linux-2.4.12/fs/fcntl.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/fcntl.c	Thu Oct 18 10:33:41 2001
@@ -64,7 +64,7 @@
 	int error;
 	int start;
 
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	
 repeat:
 	/*
@@ -110,7 +110,7 @@
 {
 	FD_SET(fd, files->open_fds);
 	FD_CLR(fd, files->close_on_exec);
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	fd_install(fd, file);
 }
 
@@ -126,7 +126,7 @@
 	return ret;
 
 out_putf:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	fput(file);
 	return ret;
 }
@@ -137,7 +137,7 @@
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
 
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	if (!(file = fcheck(oldfd)))
 		goto out_unlock;
 	err = newfd;
@@ -168,7 +168,7 @@
 	files->fd[newfd] = file;
 	FD_SET(newfd, files->open_fds);
 	FD_CLR(newfd, files->close_on_exec);
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 
 	if (tofree)
 		filp_close(tofree, files);
@@ -176,11 +176,11 @@
 out:
 	return err;
 out_unlock:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	goto out;
 
 out_fput:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	fput(file);
 	goto out;
 }
diff -urN linux-2.4.12/fs/file.c linux-2.4.12-fs-05/fs/file.c
--- linux-2.4.12/fs/file.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/file.c	Thu Oct 18 11:24:03 2001
@@ -13,7 +13,20 @@
 #include <linux/vmalloc.h>
 
 #include <asm/bitops.h>
+#include <linux/rcupdate.h>
 
+struct rcu_fd_array {
+	struct rcu_head rh;
+	struct file **array;   
+	int nfds;
+};
+
+struct rcu_fd_set {
+	struct rcu_head rh;
+	fd_set *openset;
+	fd_set *execset;
+	int nfds;
+};
 
 /*
  * Allocate an fd array, using kmalloc or vmalloc.
@@ -48,6 +61,13 @@
 		vfree(array);
 }
 
+static void fd_array_callback(void *arg) 
+{
+	struct rcu_fd_array *a = (struct rcu_fd_array *) arg; 
+	free_fd_array(a->array, a->nfds);
+	kfree(arg); 
+}
+
 /*
  * Expand the fd array in the files_struct.  Called with the files
  * spinlock held for write.
@@ -57,6 +77,7 @@
 {
 	struct file **new_fds;
 	int error, nfds;
+	struct rcu_fd_array *arg;
 
 	
 	error = -EMFILE;
@@ -64,7 +85,7 @@
 		goto out;
 
 	nfds = files->max_fds;
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 
 	/* 
 	 * Expand to the max in easy steps, and keep expanding it until
@@ -88,18 +109,17 @@
 
 	error = -ENOMEM;
 	new_fds = alloc_fd_array(nfds);
-	write_lock(&files->file_lock);
-	if (!new_fds)
+	arg = (struct rcu_fd_array *) kmalloc(sizeof(arg), GFP_ATOMIC);
+
+	spin_lock(&files->file_lock);
+	if (!new_fds || !arg)
 		goto out;
 
 	/* Copy the existing array and install the new pointer */
 
 	if (nfds > files->max_fds) {
-		struct file **old_fds;
-		int i;
-		
-		old_fds = xchg(&files->fd, new_fds);
-		i = xchg(&files->max_fds, nfds);
+		struct file **old_fds = files->fd;
+		int i = files->max_fds;
 
 		/* Don't copy/clear the array if we are creating a new
 		   fd array for fork() */
@@ -108,16 +128,27 @@
 			/* clear the remainder of the array */
 			memset(&new_fds[i], 0,
 			       (nfds-i) * sizeof(struct file *)); 
+		}
 
-			write_unlock(&files->file_lock);
-			free_fd_array(old_fds, i);
-			write_lock(&files->file_lock);
+		/* mem barrier needed for Alpha*/
+		files->fd = new_fds;
+		/* mem barrier needed for Alpha*/
+		files->max_fds = nfds;
+		
+		if (i) {
+			arg->array = old_fds;
+			arg->nfds = i;
+			call_rcu(&arg->rh, fd_array_callback, arg);
+		}
+		else {
+			kfree(arg);
 		}
 	} else {
 		/* Somebody expanded the array while we slept ... */
-		write_unlock(&files->file_lock);
+		spin_unlock(&files->file_lock);
 		free_fd_array(new_fds, nfds);
-		write_lock(&files->file_lock);
+		kfree(arg);
+		spin_lock(&files->file_lock);
 	}
 	error = 0;
 out:
@@ -157,6 +188,14 @@
 		vfree(array);
 }
 
+static void fd_set_callback (void *arg)
+{
+	struct rcu_fd_set *a = (struct rcu_fd_set *) arg; 
+	free_fdset(a->openset, a->nfds);
+	free_fdset(a->execset, a->nfds);
+	kfree(arg);
+}
+
 /*
  * Expand the fdset in the files_struct.  Called with the files spinlock
  * held for write.
@@ -165,13 +204,14 @@
 {
 	fd_set *new_openset = 0, *new_execset = 0;
 	int error, nfds = 0;
+	struct rcu_fd_set *arg = NULL;
 
 	error = -EMFILE;
 	if (files->max_fdset >= NR_OPEN || nr >= NR_OPEN)
 		goto out;
 
 	nfds = files->max_fdset;
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 
 	/* Expand to the max in easy steps */
 	do {
@@ -187,46 +227,56 @@
 	error = -ENOMEM;
 	new_openset = alloc_fdset(nfds);
 	new_execset = alloc_fdset(nfds);
-	write_lock(&files->file_lock);
-	if (!new_openset || !new_execset)
+	arg = (struct rcu_fd_set *) kmalloc(sizeof(arg), GFP_ATOMIC);
+	spin_lock(&files->file_lock);
+	if (!new_openset || !new_execset || !arg)
 		goto out;
 
 	error = 0;
 	
 	/* Copy the existing tables and install the new pointers */
 	if (nfds > files->max_fdset) {
-		int i = files->max_fdset / (sizeof(unsigned long) * 8);
-		int count = (nfds - files->max_fdset) / 8;
+		fd_set * old_openset = files->open_fds;
+		fd_set * old_execset = files->close_on_exec;
+		int old_nfds = files->max_fdset;
+		int i = old_nfds / (sizeof(unsigned long) * 8);
+		int count = (nfds - old_nfds) / 8;
 		
 		/* 
 		 * Don't copy the entire array if the current fdset is
 		 * not yet initialised.  
 		 */
 		if (i) {
-			memcpy (new_openset, files->open_fds, files->max_fdset/8);
-			memcpy (new_execset, files->close_on_exec, files->max_fdset/8);
+			memcpy (new_openset, old_openset, old_nfds/8);
+			memcpy (new_execset, old_execset, old_nfds/8);
 			memset (&new_openset->fds_bits[i], 0, count);
 			memset (&new_execset->fds_bits[i], 0, count);
 		}
 		
-		nfds = xchg(&files->max_fdset, nfds);
-		new_openset = xchg(&files->open_fds, new_openset);
-		new_execset = xchg(&files->close_on_exec, new_execset);
-		write_unlock(&files->file_lock);
-		free_fdset (new_openset, nfds);
-		free_fdset (new_execset, nfds);
-		write_lock(&files->file_lock);
+		/* mem barrier needed for Alpha*/
+		files->open_fds =  new_openset;
+		files->close_on_exec = new_execset;
+		/* mem barrier needed for Alpha*/
+		files->max_fdset = nfds;
+
+		arg->openset = old_openset;
+		arg->execset = old_execset;
+		arg->nfds = nfds;
+		call_rcu(&arg->rh, fd_set_callback, arg);
+
 		return 0;
 	} 
 	/* Somebody expanded the array while we slept ... */
 
 out:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	if (new_openset)
 		free_fdset(new_openset, nfds);
 	if (new_execset)
 		free_fdset(new_execset, nfds);
-	write_lock(&files->file_lock);
+	if (arg)
+		kfree(arg);
+	spin_lock(&files->file_lock);
 	return error;
 }
 
diff -urN linux-2.4.12/fs/file_table.c linux-2.4.12-fs-05/fs/file_table.c
--- linux-2.4.12/fs/file_table.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/file_table.c	Thu Oct 18 10:33:41 2001
@@ -129,13 +129,22 @@
 struct file * fget(unsigned int fd)
 {
 	struct file * file;
-	struct files_struct *files = current->files;
 
-	read_lock(&files->file_lock);
 	file = fcheck(fd);
-	if (file)
+	if (file) {
 		get_file(file);
-	read_unlock(&files->file_lock);
+
+        	/* before returning check again if someone (as of now sys_close)
+                 * has nullified the fd_array entry, if yes then we might have 
+                 * failed fput call for him by doing get_file() so do the 
+                 * favour of doing fput for him.
+                 */
+
+        	if (!(fcheck(fd))) {
+                	fput(file);      
+			return NULL;
+		}
+	}                                               
 	return file;
 }
 
diff -urN linux-2.4.12/fs/open.c linux-2.4.12-fs-05/fs/open.c
--- linux-2.4.12/fs/open.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/open.c	Thu Oct 18 10:33:41 2001
@@ -702,7 +702,7 @@
 	int fd, error;
 
   	error = -EMFILE;
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 
 repeat:
  	fd = find_next_zero_bit(files->open_fds, 
@@ -751,7 +751,7 @@
 	error = fd;
 
 out:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	return error;
 }
 
@@ -832,7 +832,7 @@
 	struct file * filp;
 	struct files_struct *files = current->files;
 
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	if (fd >= files->max_fds)
 		goto out_unlock;
 	filp = files->fd[fd];
@@ -841,11 +841,11 @@
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	return filp_close(filp, files);
 
 out_unlock:
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 	return -EBADF;
 }
 
diff -urN linux-2.4.12/fs/proc/base.c linux-2.4.12-fs-05/fs/proc/base.c
--- linux-2.4.12/fs/proc/base.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/proc/base.c	Thu Oct 18 10:33:41 2001
@@ -754,12 +754,10 @@
 	task_unlock(task);
 	if (!files)
 		goto out_unlock;
-	read_lock(&files->file_lock);
 	file = inode->u.proc_i.file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
 	get_file(file);
-	read_unlock(&files->file_lock);
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -775,7 +773,6 @@
 
 out_unlock2:
 	put_files_struct(files);
-	read_unlock(&files->file_lock);
 out_unlock:
 	iput(inode);
 out:
diff -urN linux-2.4.12/fs/select.c linux-2.4.12-fs-05/fs/select.c
--- linux-2.4.12/fs/select.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/fs/select.c	Thu Oct 18 10:33:41 2001
@@ -167,9 +167,7 @@
 	int retval, i, off;
 	long __timeout = *timeout;
 
- 	read_lock(&current->files->file_lock);
 	retval = max_select_fd(n, fds);
-	read_unlock(&current->files->file_lock);
 
 	if (retval < 0)
 		return retval;
diff -urN linux-2.4.12/include/linux/file.h linux-2.4.12-fs-05/include/linux/file.h
--- linux-2.4.12/include/linux/file.h	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/include/linux/file.h	Thu Oct 18 10:33:41 2001
@@ -12,21 +12,19 @@
 {
 	struct files_struct *files = current->files;
 	int res;
-	read_lock(&files->file_lock);
 	res = FD_ISSET(fd, files->close_on_exec);
-	read_unlock(&files->file_lock);
 	return res;
 }
 
 static inline void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	if (flag)
 		FD_SET(fd, files->close_on_exec);
 	else
 		FD_CLR(fd, files->close_on_exec);
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 }
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
@@ -66,9 +64,9 @@
 {
 	struct files_struct *files = current->files;
 
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	__put_unused_fd(files, fd);
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 }
 
 /*
@@ -88,11 +86,11 @@
 {
 	struct files_struct *files = current->files;
 	
-	write_lock(&files->file_lock);
+	spin_lock(&files->file_lock);
 	if (files->fd[fd])
 		BUG();
 	files->fd[fd] = file;
-	write_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 }
 
 void put_files_struct(struct files_struct *fs);
diff -urN linux-2.4.12/include/linux/sched.h linux-2.4.12-fs-05/include/linux/sched.h
--- linux-2.4.12/include/linux/sched.h	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/include/linux/sched.h	Thu Oct 18 11:13:12 2001
@@ -171,7 +171,7 @@
  */
 struct files_struct {
 	atomic_t count;
-	rwlock_t file_lock;	/* Protects all the below members.  Nests inside tsk->alloc_lock */
+	spinlock_t file_lock;	/* Protects all the below members.  Nests inside tsk->alloc_lock */
 	int max_fds;
 	int max_fdset;
 	int next_fd;
@@ -186,7 +186,7 @@
 #define INIT_FILES \
 { 							\
 	count:		ATOMIC_INIT(1), 		\
-	file_lock:	RW_LOCK_UNLOCKED, 		\
+	file_lock:	SPIN_LOCK_UNLOCKED, 		\
 	max_fds:	NR_OPEN_DEFAULT, 		\
 	max_fdset:	__FD_SETSIZE, 			\
 	next_fd:	0, 				\
diff -urN linux-2.4.12/kernel/fork.c linux-2.4.12-fs-05/kernel/fork.c
--- linux-2.4.12/kernel/fork.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/kernel/fork.c	Thu Oct 18 11:44:45 2001
@@ -440,7 +440,7 @@
 
 	atomic_set(&newf->count, 1);
 
-	newf->file_lock	    = RW_LOCK_UNLOCKED;
+	newf->file_lock     = SPIN_LOCK_UNLOCKED; 
 	newf->next_fd	    = 0;
 	newf->max_fds	    = NR_OPEN_DEFAULT;
 	newf->max_fdset	    = __FD_SETSIZE;
@@ -453,13 +453,12 @@
 	size = oldf->max_fdset;
 	if (size > __FD_SETSIZE) {
 		newf->max_fdset = 0;
-		write_lock(&newf->file_lock);
+		spin_lock(&newf->file_lock);
 		error = expand_fdset(newf, size-1);
-		write_unlock(&newf->file_lock);
+		spin_unlock(&newf->file_lock);
 		if (error)
 			goto out_release;
 	}
-	read_lock(&oldf->file_lock);
 
 	open_files = count_open_files(oldf, size);
 
@@ -470,15 +469,13 @@
 	 */
 	nfds = NR_OPEN_DEFAULT;
 	if (open_files > nfds) {
-		read_unlock(&oldf->file_lock);
 		newf->max_fds = 0;
-		write_lock(&newf->file_lock);
+		spin_lock(&newf->file_lock);
 		error = expand_fd_array(newf, open_files-1);
-		write_unlock(&newf->file_lock);
+		spin_unlock(&newf->file_lock);
 		if (error) 
 			goto out_release;
 		nfds = newf->max_fds;
-		read_lock(&oldf->file_lock);
 	}
 
 	old_fds = oldf->fd;
@@ -493,7 +490,6 @@
 			get_file(f);
 		*new_fds++ = f;
 	}
-	read_unlock(&oldf->file_lock);
 
 	/* compute the remainder to be cleared */
 	size = (newf->max_fds - open_files) * sizeof(struct file *);
diff -urN linux-2.4.12/net/ipv4/netfilter/ipt_owner.c linux-2.4.12-fs-05/net/ipv4/netfilter/ipt_owner.c
--- linux-2.4.12/net/ipv4/netfilter/ipt_owner.c	Thu Oct 18 11:44:21 2001
+++ linux-2.4.12-fs-05/net/ipv4/netfilter/ipt_owner.c	Thu Oct 18 10:33:41 2001
@@ -25,16 +25,13 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		read_lock(&files->file_lock);
 		for (i=0; i < files->max_fds; i++) {
 			if (fcheck_files(files, i) == skb->sk->socket->file) {
-				read_unlock(&files->file_lock);
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		read_unlock(&files->file_lock);
 	}
 	task_unlock(p);
 out:
@@ -58,14 +55,12 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			read_lock(&files->file_lock);
 			for (i=0; i < files->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
-			read_unlock(&files->file_lock);
 		}
 		task_unlock(p);
 		if(found)
