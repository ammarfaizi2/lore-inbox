Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUHBKiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUHBKiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHBKiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:38:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7866 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266443AbUHBKZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:25:10 -0400
Date: Mon, 2 Aug 2004 15:53:52 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 5 of 5
Message-ID: <20040802102350.GG4385@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses rcu to make struct files_struct.fd[]
array lock free and use kref_lf_xxx api for struct file.f_count refcounter.

This is carrying forward work done earlier by Maneesh and Dipankar.

Thanks,
Kiran


D:
D: Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
D: Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
D: Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
D:
D: files_struct-rcu-kref-2.6.7.patch
D: Patch to eliminate struct files_struct.file_lock spinlock on the reader
D: side and use rcu refcounting kref_lf_xxx api for the f_count refcounter.
D: This patch depends on the kref_lf patch which adds kref_lf_xxx api.
D: This patch also assumes f_count is converted to use kref api 
D: (files_struct-kref-s patch).
D: This patch improves performance of threaded io intensive workloads.
D: There has been a 15 % improvement in tiobench performance with this patch
D: on a 4 way xeon
D:
diff -ruN -X dontdiff2 linux-2.6.7/arch/mips/kernel/irixioctl.c files_struct-kref-2.6.7/arch/mips/kernel/irixioctl.c
--- linux-2.6.7/arch/mips/kernel/irixioctl.c	2004-06-16 10:49:42.000000000 +0530
+++ files_struct-kref-2.6.7/arch/mips/kernel/irixioctl.c	2004-07-27 19:52:38.790582872 +0530
@@ -14,6 +14,7 @@
 #include <linux/syscalls.h>
 #include <linux/tty.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctl.h>
@@ -33,15 +34,15 @@
 	struct file *filp;
 	struct tty_struct *ttyp = NULL;
 
-	spin_lock(&current->files->file_lock);
-	filp = fcheck(fd);
+	rcu_read_lock();
+	filp = fcheck_rcu(fd);
 	if(filp && filp->private_data) {
 		ttyp = (struct tty_struct *) filp->private_data;
 
 		if(ttyp->magic != TTY_MAGIC)
 			ttyp =NULL;
 	}
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 	return ttyp;
 }
 
diff -ruN -X dontdiff2 linux-2.6.7/arch/sparc64/solaris/ioctl.c files_struct-kref-2.6.7/arch/sparc64/solaris/ioctl.c
--- linux-2.6.7/arch/sparc64/solaris/ioctl.c	2004-06-16 10:49:36.000000000 +0530
+++ files_struct-kref-2.6.7/arch/sparc64/solaris/ioctl.c	2004-07-27 19:52:38.791582720 +0530
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 #include <linux/mtio.h>
 #include <linux/time.h>
+#include <linux/rcupdate.h>
 #include <linux/compat.h>
 
 #include <net/sock.h>
@@ -291,15 +292,15 @@
 {
 	struct inode *ino;
 	/* I wonder which of these tests are superfluous... --patrik */
-	spin_lock(&current->files->file_lock);
+	rcu_read_lock();
 	if (! current->files->fd[fd] ||
 	    ! current->files->fd[fd]->f_dentry ||
 	    ! (ino = current->files->fd[fd]->f_dentry->d_inode) ||
 	    ! ino->i_sock) {
-		spin_unlock(&current->files->file_lock);
+		rcu_read_unlock();
 		return TBADF;
 	}
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 	
 	switch (cmd & 0xff) {
 	case 109: /* SI_SOCKPARAMS */
diff -ruN -X dontdiff2 linux-2.6.7/arch/sparc64/solaris/timod.c files_struct-kref-2.6.7/arch/sparc64/solaris/timod.c
--- linux-2.6.7/arch/sparc64/solaris/timod.c	2004-06-16 10:49:13.000000000 +0530
+++ files_struct-kref-2.6.7/arch/sparc64/solaris/timod.c	2004-07-27 19:52:38.793582416 +0530
@@ -143,9 +143,14 @@
 static void timod_wake_socket(unsigned int fd)
 {
 	struct socket *sock;
+	struct file *filp; 
 
 	SOLD("wakeing socket");
-	sock = SOCKET_I(current->files->fd[fd]->f_dentry->d_inode);
+	if (!( filp = fcheck(fd))) {
+		SOLD("BAD FD");
+		return;
+	}
+	sock = SOCKET_I(filp->f_dentry->d_inode);
 	wake_up_interruptible(&sock->wait);
 	read_lock(&sock->sk->sk_callback_lock);
 	if (sock->fasync_list && !test_bit(SOCK_ASYNC_WAITDATA, &sock->flags))
@@ -157,9 +162,14 @@
 static void timod_queue(unsigned int fd, struct T_primsg *it)
 {
 	struct sol_socket_struct *sock;
+	struct file *filp; 
 
 	SOLD("queuing primsg");
-	sock = (struct sol_socket_struct *)current->files->fd[fd]->private_data;
+	if (!( filp = fcheck(fd))) {
+		SOLD("BAD FD");
+		return;
+	}
+	sock = (struct sol_socket_struct *)filp->private_data;
 	it->next = sock->pfirst;
 	sock->pfirst = it;
 	if (!sock->plast)
@@ -171,9 +181,14 @@
 static void timod_queue_end(unsigned int fd, struct T_primsg *it)
 {
 	struct sol_socket_struct *sock;
+	struct file *filp; 
 
 	SOLD("queuing primsg at end");
-	sock = (struct sol_socket_struct *)current->files->fd[fd]->private_data;
+	if (!( filp = fcheck(fd))) {
+		SOLD("BAD FD");
+		return;
+	}
+	sock = (struct sol_socket_struct *)filp->private_data;
 	it->next = NULL;
 	if (sock->plast)
 		sock->plast->next = it;
@@ -351,7 +366,10 @@
 		(int (*)(int, unsigned long *))SYS(socketcall);
 	int (*sys_sendto)(int, void *, size_t, unsigned, struct sockaddr *, int) =
 		(int (*)(int, void *, size_t, unsigned, struct sockaddr *, int))SYS(sendto);
-	filp = current->files->fd[fd];
+
+	if (!(filp = fcheck(fd)))
+		return -EBADF;
+
 	ino = filp->f_dentry->d_inode;
 	sock = (struct sol_socket_struct *)filp->private_data;
 	SOLD("entry");
@@ -632,7 +650,10 @@
 	
 	SOLD("entry");
 	SOLDD(("%u %p %d %p %p %d %p %d\n", fd, ctl_buf, ctl_maxlen, ctl_len, data_buf, data_maxlen, data_len, *flags_p));
-	filp = current->files->fd[fd];
+
+	if (!(filp = fcheck(fd)))
+		return -EBADF;
+
 	ino = filp->f_dentry->d_inode;
 	sock = (struct sol_socket_struct *)filp->private_data;
 	SOLDD(("%p %p\n", sock->pfirst, sock->pfirst ? sock->pfirst->next : NULL));
@@ -848,7 +869,7 @@
 	lock_kernel();
 	if(fd >= NR_OPEN) goto out;
 
-	filp = current->files->fd[fd];
+	filp = fcheck(fd);
 	if(!filp) goto out;
 
 	ino = filp->f_dentry->d_inode;
@@ -915,7 +936,7 @@
 	lock_kernel();
 	if(fd >= NR_OPEN) goto out;
 
-	filp = current->files->fd[fd];
+	filp = fcheck(fd);
 	if(!filp) goto out;
 
 	ino = filp->f_dentry->d_inode;
diff -ruN -X dontdiff2 linux-2.6.7/drivers/char/tty_io.c files_struct-kref-2.6.7/drivers/char/tty_io.c
--- linux-2.6.7/drivers/char/tty_io.c	2004-06-16 10:49:36.000000000 +0530
+++ files_struct-kref-2.6.7/drivers/char/tty_io.c	2004-07-27 19:52:38.797581808 +0530
@@ -1937,9 +1937,9 @@
 		}
 		task_lock(p);
 		if (p->files) {
-			spin_lock(&p->files->file_lock);
+			rcu_read_lock();
 			for (i=0; i < p->files->max_fds; i++) {
-				filp = fcheck_files(p->files, i);
+				filp = fcheck_files_rcu(p->files, i);
 				if (!filp)
 					continue;
 				if (filp->f_op->read == tty_read &&
@@ -1951,7 +1951,7 @@
 					break;
 				}
 			}
-			spin_unlock(&p->files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 	}
diff -ruN -X dontdiff2 linux-2.6.7/fs/aio.c files_struct-kref-2.6.7/fs/aio.c
--- linux-2.6.7/fs/aio.c	2004-07-27 19:59:54.740308440 +0530
+++ files_struct-kref-2.6.7/fs/aio.c	2004-07-27 19:57:03.738304696 +0530
@@ -489,7 +489,7 @@
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
-	if (unlikely(kref_put_last(&req->ki_filp->f_count))) {
+	if (unlikely(kref_lf_put_last(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
diff -ruN -X dontdiff2 linux-2.6.7/fs/fcntl.c files_struct-kref-2.6.7/fs/fcntl.c
--- linux-2.6.7/fs/fcntl.c	2004-06-16 10:49:37.000000000 +0530
+++ files_struct-kref-2.6.7/fs/fcntl.c	2004-07-27 19:52:38.798581656 +0530
@@ -34,9 +34,9 @@
 {
 	struct files_struct *files = current->files;
 	int res;
-	spin_lock(&files->file_lock);
+	rcu_read_lock();
 	res = FD_ISSET(fd, files->close_on_exec);
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	return res;
 }
 
@@ -138,7 +138,7 @@
 	if (fd >= 0) {
 		FD_SET(fd, files->open_fds);
 		FD_CLR(fd, files->close_on_exec);
-		spin_unlock(&files->file_lock);
+	spin_unlock(&files->file_lock);
 		fd_install(fd, file);
 	} else {
 		spin_unlock(&files->file_lock);
@@ -183,6 +183,7 @@
 		goto out_fput;
 
 	files->fd[newfd] = file;
+	smp_wmb();
 	FD_SET(newfd, files->open_fds);
 	FD_CLR(newfd, files->close_on_exec);
 	spin_unlock(&files->file_lock);
diff -ruN -X dontdiff2 linux-2.6.7/fs/file.c files_struct-kref-2.6.7/fs/file.c
--- linux-2.6.7/fs/file.c	2004-06-16 10:48:57.000000000 +0530
+++ files_struct-kref-2.6.7/fs/file.c	2004-07-27 19:52:38.800581352 +0530
@@ -14,7 +14,20 @@
 #include <linux/file.h>
 
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
@@ -49,6 +62,13 @@
 		vfree(array);
 }
 
+static void fd_array_callback(struct rcu_head *rcu) 
+{
+	struct rcu_fd_array *a = container_of(rcu, struct rcu_fd_array, rh);
+	free_fd_array(a->array, a->nfds);
+	kfree(a); 
+}
+
 /*
  * Expand the fd array in the files_struct.  Called with the files
  * spinlock held for write.
@@ -56,8 +76,9 @@
 
 int expand_fd_array(struct files_struct *files, int nr)
 {
-	struct file **new_fds;
-	int error, nfds;
+	struct file **new_fds = NULL;
+	int error, nfds = 0;
+	struct rcu_fd_array *arg = NULL;
 
 	
 	error = -EMFILE;
@@ -89,18 +110,17 @@
 
 	error = -ENOMEM;
 	new_fds = alloc_fd_array(nfds);
+	arg = (struct rcu_fd_array *) kmalloc(sizeof(*arg), GFP_KERNEL);
+
 	spin_lock(&files->file_lock);
-	if (!new_fds)
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
@@ -109,19 +129,35 @@
 			/* clear the remainder of the array */
 			memset(&new_fds[i], 0,
 			       (nfds-i) * sizeof(struct file *)); 
-
-			spin_unlock(&files->file_lock);
-			free_fd_array(old_fds, i);
-			spin_lock(&files->file_lock);
 		}
+
+		smp_wmb();
+		files->fd = new_fds;
+		smp_wmb();
+		files->max_fds = nfds;
+		
+		if (i) {
+			arg->array = old_fds;
+			arg->nfds = i;
+			call_rcu(&arg->rh, (void (*)(void *))fd_array_callback,
+				 &arg->rh);
+		} else 
+			kfree(arg);
 	} else {
 		/* Somebody expanded the array while we slept ... */
 		spin_unlock(&files->file_lock);
 		free_fd_array(new_fds, nfds);
+		kfree(arg);
 		spin_lock(&files->file_lock);
 	}
-	error = 0;
+
+	return 0;
 out:
+	if (new_fds)
+		free_fd_array(new_fds, nfds);
+	if (arg)
+		kfree(arg);
+
 	return error;
 }
 
@@ -153,6 +189,14 @@
 		vfree(array);
 }
 
+static void fd_set_callback (struct rcu_head *rcu)
+{
+	struct rcu_fd_set *a = container_of(rcu, struct rcu_fd_set, rh); 
+	free_fdset(a->openset, a->nfds);
+	free_fdset(a->execset, a->nfds);
+	kfree(a);
+}
+
 /*
  * Expand the fdset in the files_struct.  Called with the files spinlock
  * held for write.
@@ -161,6 +205,7 @@
 {
 	fd_set *new_openset = 0, *new_execset = 0;
 	int error, nfds = 0;
+	struct rcu_fd_set *arg = NULL;
 
 	error = -EMFILE;
 	if (files->max_fdset >= NR_OPEN || nr >= NR_OPEN)
@@ -183,35 +228,43 @@
 	error = -ENOMEM;
 	new_openset = alloc_fdset(nfds);
 	new_execset = alloc_fdset(nfds);
+	arg = (struct rcu_fd_set *) kmalloc(sizeof(*arg), GFP_ATOMIC);
 	spin_lock(&files->file_lock);
-	if (!new_openset || !new_execset)
+	if (!new_openset || !new_execset || !arg)
 		goto out;
 
 	error = 0;
 	
 	/* Copy the existing tables and install the new pointers */
 	if (nfds > files->max_fdset) {
-		int i = files->max_fdset / (sizeof(unsigned long) * 8);
-		int count = (nfds - files->max_fdset) / 8;
+		fd_set *old_openset = files->open_fds;
+		fd_set *old_execset = files->close_on_exec;
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
-		spin_unlock(&files->file_lock);
-		free_fdset (new_openset, nfds);
-		free_fdset (new_execset, nfds);
-		spin_lock(&files->file_lock);
+		smp_wmb();
+		files->open_fds =  new_openset;
+		files->close_on_exec = new_execset;
+		smp_wmb();
+		files->max_fdset = nfds;
+
+		arg->openset = old_openset;
+		arg->execset = old_execset;
+		arg->nfds = nfds;
+		call_rcu(&arg->rh, (void (*)(void *))fd_set_callback, &arg->rh);
+
 		return 0;
 	} 
 	/* Somebody expanded the array while we slept ... */
@@ -222,6 +275,8 @@
 		free_fdset(new_openset, nfds);
 	if (new_execset)
 		free_fdset(new_execset, nfds);
+	if (arg)
+		kfree(arg);
 	spin_lock(&files->file_lock);
 	return error;
 }
diff -ruN -X dontdiff2 linux-2.6.7/fs/file_table.c files_struct-kref-2.6.7/fs/file_table.c
--- linux-2.6.7/fs/file_table.c	2004-07-27 19:59:54.741308288 +0530
+++ files_struct-kref-2.6.7/fs/file_table.c	2004-07-27 19:58:50.484076872 +0530
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
+#include <linux/rcupdate.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
 
@@ -54,11 +55,17 @@
 	spin_unlock_irqrestore(&filp_count_lock, flags);
 }
 
-static inline void file_free(struct file *f)
+static inline void file_free_rcu(void *arg)
 {
+	struct file *f =  arg;
 	kmem_cache_free(filp_cachep, f);
 }
 
+static inline void file_free(struct file *f)
+{
+	call_rcu(&f->f_rcuhead, file_free_rcu, f);
+}
+
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
@@ -81,7 +88,7 @@
 				goto fail;
 			}
 			eventpoll_init_file(f);
-			kref_init(&f->f_count);
+			kref_lf_init(&f->f_count);
 			f->f_uid = current->fsuid;
 			f->f_gid = current->fsgid;
 			f->f_owner.lock = RW_LOCK_UNLOCKED;
@@ -118,7 +125,7 @@
 	eventpoll_init_file(filp);
 	filp->f_flags  = flags;
 	filp->f_mode   = (flags+1) & O_ACCMODE;
-	kref_init(&filp->f_count);
+	kref_lf_init(&filp->f_count);
 	filp->f_dentry = dentry;
 	filp->f_mapping = dentry->d_inode->i_mapping;
 	filp->f_uid    = current->fsuid;
@@ -162,7 +169,7 @@
 
 void fastcall fput(struct file *file)
 {
-	kref_put(&file->f_count, __fput_kref);
+	kref_lf_put(&file->f_count, __fput_kref);
 }
 
 EXPORT_SYMBOL(fput);
@@ -204,11 +211,17 @@
 	struct file *file;
 	struct files_struct *files = current->files;
 
-	spin_lock(&files->file_lock);
-	file = fcheck_files(files, fd);
-	if (file)
-		get_file(file);
-	spin_unlock(&files->file_lock);
+	rcu_read_lock();
+	file = fcheck_files_rcu(files, fd);
+	if (file) {
+		if (!kref_lf_get_rcu(&file->f_count)) {
+			/* File object ref couldn't be taken */
+			rcu_read_unlock();
+			return NULL;
+		}
+	}	
+	rcu_read_unlock();
+
 	return file;
 }
 
@@ -230,14 +243,18 @@
 	if (likely((atomic_read(&files->count) == 1))) {
 		file = fcheck_files(files, fd);
 	} else {
-		spin_lock(&files->file_lock);
-		file = fcheck_files(files, fd);
+		rcu_read_lock();
+		file = fcheck_files_rcu(files, fd);
 		if (file) {
-			get_file(file);
-			*fput_needed = 1;
+			if (kref_lf_get_rcu(&file->f_count))
+				*fput_needed = 1;
+			else
+				/* Didn't get the reference, someone's freed */
+				file = NULL;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
+
 	return file;
 }
 
@@ -252,7 +269,7 @@
 	
 void put_filp(struct file *file)
 {
-	kref_put(&file->f_count, put_filp_kref);
+	kref_lf_put(&file->f_count, put_filp_kref);
 }
 
 EXPORT_SYMBOL(put_filp);
diff -ruN -X dontdiff2 linux-2.6.7/fs/open.c files_struct-kref-2.6.7/fs/open.c
--- linux-2.6.7/fs/open.c	2004-06-16 10:48:56.000000000 +0530
+++ files_struct-kref-2.6.7/fs/open.c	2004-07-27 19:52:38.802581048 +0530
@@ -1031,6 +1031,8 @@
 	if (!filp)
 		goto out_unlock;
 	files->fd[fd] = NULL;
+	/* Need to make it conistent with open_fds in __put_unused_fd() */
+	smp_wmb();
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
diff -ruN -X dontdiff2 linux-2.6.7/fs/proc/base.c files_struct-kref-2.6.7/fs/proc/base.c
--- linux-2.6.7/fs/proc/base.c	2004-06-16 10:49:37.000000000 +0530
+++ files_struct-kref-2.6.7/fs/proc/base.c	2004-07-27 19:52:38.805580592 +0530
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/rcupdate.h>
 #include <linux/kallsyms.h>
 #include <linux/mount.h>
 #include <linux/security.h>
@@ -191,16 +192,16 @@
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
-		file = fcheck_files(files, fd);
+		rcu_read_lock();
+		file = fcheck_files_rcu(files, fd);
 		if (file) {
 			*mnt = mntget(file->f_vfsmnt);
 			*dentry = dget(file->f_dentry);
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 			put_files_struct(files);
 			return 0;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 		put_files_struct(files);
 	}
 	return -ENOENT;
@@ -805,15 +806,15 @@
 			files = get_files_struct(p);
 			if (!files)
 				goto out;
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			for (fd = filp->f_pos-2;
 			     fd < files->max_fds;
 			     fd++, filp->f_pos++) {
 				unsigned int i,j;
 
-				if (!fcheck_files(files, fd))
+				if (!fcheck_files_rcu(files, fd))
 					continue;
-				spin_unlock(&files->file_lock);
+				rcu_read_unlock();
 
 				j = NUMBUF;
 				i = fd;
@@ -825,12 +826,12 @@
 
 				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
 				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
-					spin_lock(&files->file_lock);
+					rcu_read_lock();
 					break;
 				}
-				spin_lock(&files->file_lock);
+				rcu_read_lock();
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 			put_files_struct(files);
 	}
 out:
@@ -1003,9 +1004,9 @@
 
 	files = get_files_struct(task);
 	if (files) {
-		spin_lock(&files->file_lock);
-		if (fcheck_files(files, fd)) {
-			spin_unlock(&files->file_lock);
+		rcu_read_lock();
+		if (fcheck_files_rcu(files, fd)) {
+			rcu_read_unlock();
 			put_files_struct(files);
 			if (task_dumpable(task)) {
 				inode->i_uid = task->euid;
@@ -1017,7 +1018,7 @@
 			security_task_to_inode(task, inode);
 			return 1;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 		put_files_struct(files);
 	}
 	d_drop(dentry);
@@ -1109,15 +1110,15 @@
 	if (!files)
 		goto out_unlock;
 	inode->i_mode = S_IFLNK;
-	spin_lock(&files->file_lock);
-	file = fcheck_files(files, fd);
+	rcu_read_lock();
+	file = fcheck_files_rcu(files, fd);
 	if (!file)
 		goto out_unlock2;
 	if (file->f_mode & 1)
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -1127,7 +1128,7 @@
 	return NULL;
 
 out_unlock2:
-	spin_unlock(&files->file_lock);
+	rcu_read_unlock();
 	put_files_struct(files);
 out_unlock:
 	iput(inode);
diff -ruN -X dontdiff2 linux-2.6.7/fs/select.c files_struct-kref-2.6.7/fs/select.c
--- linux-2.6.7/fs/select.c	2004-06-16 10:48:54.000000000 +0530
+++ files_struct-kref-2.6.7/fs/select.c	2004-07-27 19:52:38.806580440 +0530
@@ -21,6 +21,7 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 
@@ -131,13 +132,16 @@
 static int max_select_fd(unsigned long n, fd_set_bits *fds)
 {
 	unsigned long *open_fds;
+	fd_set *open_fdset;
 	unsigned long set;
 	int max;
 
 	/* handle last in-complete long-word first */
 	set = ~(~0UL << (n & (__NFDBITS-1)));
 	n /= __NFDBITS;
-	open_fds = current->files->open_fds->fds_bits+n;
+	open_fdset = current->files->open_fds;
+	smp_read_barrier_depends();
+	open_fds = open_fdset->fds_bits+n;
 	max = 0;
 	if (set) {
 		set &= BITS(fds, n);
@@ -184,9 +188,9 @@
 	int retval, i;
 	long __timeout = *timeout;
 
- 	spin_lock(&current->files->file_lock);
+	rcu_read_lock();
 	retval = max_select_fd(n, fds);
-	spin_unlock(&current->files->file_lock);
+	rcu_read_unlock();
 
 	if (retval < 0)
 		return retval;
diff -ruN -X dontdiff2 linux-2.6.7/include/linux/file.h files_struct-kref-2.6.7/include/linux/file.h
--- linux-2.6.7/include/linux/file.h	2004-06-16 10:50:26.000000000 +0530
+++ files_struct-kref-2.6.7/include/linux/file.h	2004-07-27 19:52:38.807580288 +0530
@@ -9,6 +9,7 @@
 #include <linux/posix_types.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
@@ -69,10 +70,26 @@
 	return file;
 }
 
+/* Need Proper read barriers if fd_array is being indexed lockfree */
+static inline struct file * fcheck_files_rcu(struct files_struct *files, unsigned int fd)
+{
+	struct file * file = NULL;
+
+	if (fd < files->max_fds) {
+		struct file ** fd_array;
+		smp_rmb();
+	       	fd_array = files->fd;
+		smp_read_barrier_depends();
+		file = fd_array[fd];
+	}
+	return file;
+}
+
 /*
  * Check whether the specified fd has an open file.
  */
 #define fcheck(fd)	fcheck_files(current->files, fd)
+#define fcheck_rcu(fd)	fcheck_files_rcu(current->files, fd)
 
 extern void FASTCALL(fd_install(unsigned int fd, struct file * file));
 
diff -ruN -X dontdiff2 linux-2.6.7/include/linux/fs.h files_struct-kref-2.6.7/include/linux/fs.h
--- linux-2.6.7/include/linux/fs.h	2004-07-27 19:59:54.751306768 +0530
+++ files_struct-kref-2.6.7/include/linux/fs.h	2004-07-27 19:59:38.190824344 +0530
@@ -580,13 +580,14 @@
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
+	struct rcu_head 	f_rcuhead;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
 #define file_list_unlock() spin_unlock(&files_lock);
 
-#define get_file(x)	kref_get(&(x)->f_count)
-#define file_count(x)	kref_read(&(x)->f_count)
+#define get_file(x)	kref_lf_get(&(x)->f_count)
+#define file_count(x)	kref_lf_read(&(x)->f_count)
 
 /* Initialize and open a private file and allocate its security structure. */
 extern int open_private_file(struct file *, struct dentry *, int);
diff -ruN -X dontdiff2 linux-2.6.7/kernel/fork.c files_struct-kref-2.6.7/kernel/fork.c
--- linux-2.6.7/kernel/fork.c	2004-06-16 10:48:57.000000000 +0530
+++ files_struct-kref-2.6.7/kernel/fork.c	2004-07-27 19:52:38.000000000 +0530
@@ -32,6 +32,7 @@
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
 #include <linux/futex.h>
+#include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
@@ -639,10 +640,12 @@
 static int count_open_files(struct files_struct *files, int size)
 {
 	int i;
+	fd_set *open_fds = files->open_fds;
 
+	smp_read_barrier_depends();
 	/* Find the last open fd */
 	for (i = size/(8*sizeof(long)); i > 0; ) {
-		if (files->open_fds->fds_bits[--i])
+		if (open_fds->fds_bits[--i])
 			break;
 	}
 	i = (i+1) * 8 * sizeof(long);
@@ -672,6 +675,14 @@
 	 * This works because we cache current->files (old) as oldf. Don't
 	 * break this.
 	 */
+	
+	/* 
+	 * We don't have oldf readlock, but even if the old fdset gets
+	 * grown now, we'll only copy upto "size" fds 
+	 */
+	size = oldf->max_fdset;	
+	smp_rmb();
+
 	tsk->files = NULL;
 	error = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, SLAB_KERNEL);
@@ -688,9 +699,6 @@
 	newf->open_fds	    = &newf->open_fds_init;
 	newf->fd	    = &newf->fd_array[0];
 
-	/* We don't yet have the oldf readlock, but even if the old
-           fdset gets grown now, we'll only copy up to "size" fds */
-	size = oldf->max_fdset;
 	if (size > __FD_SETSIZE) {
 		newf->max_fdset = 0;
 		spin_lock(&newf->file_lock);
@@ -699,7 +707,7 @@
 		if (error)
 			goto out_release;
 	}
-	spin_lock(&oldf->file_lock);
+	rcu_read_lock();
 
 	open_files = count_open_files(oldf, size);
 
@@ -710,7 +718,7 @@
 	 */
 	nfds = NR_OPEN_DEFAULT;
 	if (open_files > nfds) {
-		spin_unlock(&oldf->file_lock);
+		rcu_read_unlock();
 		newf->max_fds = 0;
 		spin_lock(&newf->file_lock);
 		error = expand_fd_array(newf, open_files-1);
@@ -718,10 +726,11 @@
 		if (error) 
 			goto out_release;
 		nfds = newf->max_fds;
-		spin_lock(&oldf->file_lock);
+		rcu_read_lock();
 	}
 
 	old_fds = oldf->fd;
+	smp_read_barrier_depends();
 	new_fds = newf->fd;
 
 	memcpy(newf->open_fds->fds_bits, oldf->open_fds->fds_bits, open_files/8);
@@ -733,7 +742,7 @@
 			get_file(f);
 		*new_fds++ = f;
 	}
-	spin_unlock(&oldf->file_lock);
+	rcu_read_unlock();
 
 	/* compute the remainder to be cleared */
 	size = (newf->max_fds - open_files) * sizeof(struct file *);
diff -ruN -X dontdiff2 linux-2.6.7/net/ipv4/netfilter/ipt_owner.c files_struct-kref-2.6.7/net/ipv4/netfilter/ipt_owner.c
--- linux-2.6.7/net/ipv4/netfilter/ipt_owner.c	2004-06-16 10:50:03.000000000 +0530
+++ files_struct-kref-2.6.7/net/ipv4/netfilter/ipt_owner.c	2004-07-27 19:52:38.814579224 +0530
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv4/ipt_owner.h>
@@ -35,17 +36,17 @@
 		task_lock(p);
 		files = p->files;
 		if(files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			for (i=0; i < files->max_fds; i++) {
-				if (fcheck_files(files, i) ==
+				if (fcheck_files_rcu(files, i) ==
 				    skb->sk->sk_socket->file) {
-					spin_unlock(&files->file_lock);
+					rcu_read_unlock();
 					task_unlock(p);
 					read_unlock(&tasklist_lock);
 					return 1;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
@@ -67,17 +68,17 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		for (i=0; i < files->max_fds; i++) {
-			if (fcheck_files(files, i) ==
+			if (fcheck_files_rcu(files, i) ==
 			    skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+				rcu_read_unlock();
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
 	task_unlock(p);
 out:
@@ -101,14 +102,14 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			for (i=0; i < files->max_fds; i++) {
-				if (fcheck_files(files, i) == file) {
+				if (fcheck_files_rcu(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 		if (found)
diff -ruN -X dontdiff2 linux-2.6.7/net/ipv6/netfilter/ip6t_owner.c files_struct-kref-2.6.7/net/ipv6/netfilter/ip6t_owner.c
--- linux-2.6.7/net/ipv6/netfilter/ip6t_owner.c	2004-06-16 10:49:52.000000000 +0530
+++ files_struct-kref-2.6.7/net/ipv6/netfilter/ip6t_owner.c	2004-07-27 19:52:38.000000000 +0530
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv6/ip6t_owner.h>
@@ -34,16 +35,16 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		for (i=0; i < files->max_fds; i++) {
-			if (fcheck_files(files, i) == skb->sk->sk_socket->file) {
-				spin_unlock(&files->file_lock);
+			if (fcheck_files_rcu(files, i) == skb->sk->sk_socket->file) {
+				rcu_read_unlock();
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
 	task_unlock(p);
 out:
@@ -67,14 +68,14 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
-			spin_lock(&files->file_lock);
+			rcu_read_lock();
 			for (i=0; i < files->max_fds; i++) {
-				if (fcheck_files(files, i) == file) {
+				if (fcheck_files_rcu(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
-			spin_unlock(&files->file_lock);
+			rcu_read_unlock();
 		}
 		task_unlock(p);
 		if (found)
