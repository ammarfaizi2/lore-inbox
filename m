Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRDIOln>; Mon, 9 Apr 2001 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRDIOlg>; Mon, 9 Apr 2001 10:41:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22225 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132762AbRDIOl2>;
	Mon, 9 Apr 2001 10:41:28 -0400
Date: Mon, 9 Apr 2001 20:13:11 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: lse tech <lse-tech@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Paul.McKenney@us.ibm.com, ak@suse.de,
        hawkes@engr.sgi.com, dipankar@sequent.com
Subject: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Message-ID: <20010409201311.D9013@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Scalable FD Management Using Read-Copy-Update
---------------------------------------------

This patch provides a very good performance improvement in file 
descriptor management for SMP linux kernel on a 4-way machine with the 
expectation of even higher gains on higher end machines. The patch uses the 
read-copy-update mechanism for Linux, published earlier at the sourceforge site 
under Linux Scalablity Effort project.
       http://lse.sourceforge.net/locking/rclock.html.

In SMP kernel the performance is limited due to reader-writer lock taken during 
various calls using files_struct. Majority being in the routine fget(). Though 
there is no severe  contention for files->file_lock as the files_struct is a 
per task data structure but enough performance penalties have to be paid while 
even acquairing the read lock due to the bouncing lock cache line when multiple 
clones share the same files_struct. This was pointed out by John Hawkes in his 
posting to lse-tech mailing list 
       http://marc.theaimsgroup.com/?l=lse-tech&m=98235007317770&w=2 

The improvement in performance while runnig "chat" benchmark 
(from http://lbs.sourceforge.net/) is about 30% in average throughput.
For both configurations the results are compared for base kernel(2.4.2) 
and base kernel with files_struct_rcu-2.4.2-0.1.patch. Profiling results were 
also collected by using SGI's kernprof utility and that shows a considerable 
decrease in amount of time spent in fget(). The "chat" benchmark was run with
rooms=20 and messages=500. For each configuration, the test was run for 50 times
and average of throughput result in terms of messages per second was taken.

1. 4-way PIII Xeon 700 MHz with 1MB L2 Cache and 1GB RAM 
========================================================

Chat benchmark results
----------------------	
Kernel version  			Average 
                                        Throughput

2.4.2					191986 
2.4.2+file_struct_rcu-2.4.2-0.1.patch   253083

		Improvement = 31.8%

kernprof results
---------------

Kernel Version - 2.4.2 

default_idle [C01071EC]: 150696
schedule [C0112EE4]: 105452
__wake_up [C0113518]: 74030
tcp_sendmsg [C020FB14]: 29201
fget [C013436C]: 16318
__generic_copy_to_user [C023A13C]: 15477
USER [C0121DF4]: 12925
tcp_recvmsg [C0210A68]: 7737
system_call [C0109150]: 7399
mcount [C023A4E4]: 5509

Kernel version  - 2.4.2+files_struct_rcu-2.4.2+0.1.patch

schedule [C0113174]: 101392
__wake_up [C01137D4]: 68182
default_idle [C01071EC]: 32833
tcp_sendmsg [C021ECE4]: 29318
__generic_copy_to_user [C024930C]: 15472
USER [C0122A00]: 12803
tcp_recvmsg [C021FC38]: 8170
system_call [C0109150]: 7636
mcount [C02496B4]: 6150
fget [C0134F58]: 5694

With this patch the routine fget() gets about 65% less hits.

2. 2-way PIII Xeon 700 MHz with 1MB L2 Cache and 1GB RAM 
========================================================

Chat benchmark results
----------------------	
Kernel version  			Average 
                                        Throughput

2.4.2					209592 
2.4.2+file_struct_rcu-2.4.2-0.1.patch   222729

		Improvement = 6.2%

kernprof results
-----------------
Kernel Version - 2.4.2

schedule [C0112EE4]: 37583
tcp_sendmsg [C020FB14]: 23381
default_idle [C01071EC]: 20025
__wake_up [C0113518]: 16141
fget [C013436C]: 12733
USER [C0121DF4]: 12474
__generic_copy_to_user [C023A13C]: 12046
tcp_recvmsg [C0210A68]: 7678
system_call [C0109150]: 7113
mcount [C023A4E4]: 4789

Kernel version  - 2.4.2+files_struct_rcu-2.4.2+0.1.patch

default_idle [C01071EC]: 39086
schedule [C0113174]: 37278
tcp_sendmsg [C021ECE4]: 23148
__wake_up [C01137D4]: 15788
USER [C0122A00]: 12322
__generic_copy_to_user [C024930C]: 12138
tcp_recvmsg [C021FC38]: 7615
system_call [C0109150]: 7481
mcount [C02496B4]: 5310
fget [C0134F58]: 4858

The results with 4-way are  much better than 2-way, which shows the need for
this patch even more necessary for higher end SMP systems. Results for 8-way 
will be published soon.

With this patch the updates to the files_struct, mainly file expanding the 
fd_array and expanding bitmaps, are done using callback mechanism. In the 
routine expand_fd_array() once the new array has been allocated, updated with
the old entries and is linked to files_struct, a callback is registered to free 
the old fd_array, so that if there are any existing users present in the kernel,
they will keepon using the old fd_array, and for a new user will see the 
expanded fd_array. Once quiescent state is reached the callback is fired and the
old fd_array is freed. On similar lines the routine expand_fd_set has been 
modified to use the callback to free old bitmap.

Known Race condition
--------------------
There could be a race condition involving sys_close() and fget() if both are 
running for the same files_sturct on different CPUs. Though this problem has not
occured so far but this is always possible theoritically and it is being worked 
out. The patch with solution for this will soon follow.


Usage Information
-----------------
The patch is built on 2.4.2 kernel. Before applying this patch, the user has to
obviously apply the read-copy-update patch (rclock-2.4.2-0.1.patch) for linux, 
which can be obtained from
       http://lse.sourceforge.net/locking/rclock.html.

The config options required for this patch are CONFIG_RCLOCK and CONFIG_FD_RCU. 




Regards,
Maneesh

-- 
Maneesh Soni <smaneesh@in.ibm.com>
IBM Linux Technology Center,
IBM Software Lab, Bangalore, India


---------------------------------------patch------------------------------------

diff -urN linux-2.4.2+rc/arch/i386/config.in linux-2.4.2+rc+fs/arch/i386/config.in
--- linux-2.4.2+rc/arch/i386/config.in	Thu Apr  5 16:10:07 2001
+++ linux-2.4.2+rc+fs/arch/i386/config.in	Fri Apr  6 12:50:16 2001
@@ -155,6 +155,9 @@
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Read-Copy-Update lock support' CONFIG_RCLOCK
+if [ "$CONFIG_RCLOCK" = "y" ]; then
+   bool 'File Descriptor Management using RCU' CONFIG_FD_RCU
+fi
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'APIC and IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC
diff -urN linux-2.4.2+rc/drivers/char/tty_io.c linux-2.4.2+rc+fs/drivers/char/tty_io.c
--- linux-2.4.2+rc/drivers/char/tty_io.c	Wed Feb 14 02:45:04 2001
+++ linux-2.4.2+rc+fs/drivers/char/tty_io.c	Thu Apr  5 18:04:45 2001
@@ -1841,7 +1841,9 @@
 		}
 		task_lock(p);
 		if (p->files) {
+#ifndef CONFIG_FD_RCU
 			read_lock(&p->files->file_lock);
+#endif
 			/* FIXME: p->files could change */
 			for (i=0; i < p->files->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
@@ -1851,7 +1853,9 @@
 					break;
 				}
 			}
+#ifndef CONFIG_FD_RCU
 			read_unlock(&p->files->file_lock);
+#endif
 		}
 		task_unlock(p);
 	}
diff -urN linux-2.4.2+rc/fs/exec.c linux-2.4.2+rc+fs/fs/exec.c
--- linux-2.4.2+rc/fs/exec.c	Sat Feb 10 08:33:39 2001
+++ linux-2.4.2+rc+fs/fs/exec.c	Thu Apr  5 17:49:44 2001
@@ -475,7 +475,11 @@
 {
 	long j = -1;
 
+#ifdef CONFIG_FD_RCU
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	for (;;) {
 		unsigned long set, i;
 
@@ -487,16 +491,28 @@
 		if (!set)
 			continue;
 		files->close_on_exec->fds_bits[j] = 0;
+#ifdef CONFIG_FD_RCU
+		spin_unlock(&files->file_lock);
+#else
 		write_unlock(&files->file_lock);
+#endif
 		for ( ; set ; i++,set >>= 1) {
 			if (set & 1) {
 				sys_close(i);
 			}
 		}
+#ifdef CONFIG_FD_RCU
+		spin_lock(&files->file_lock);
+#else
 		write_lock(&files->file_lock);
+#endif
 
 	}
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 }
 
 /*
diff -urN linux-2.4.2+rc/fs/fcntl.c linux-2.4.2+rc+fs/fs/fcntl.c
--- linux-2.4.2+rc/fs/fcntl.c	Thu Nov 16 12:20:25 2000
+++ linux-2.4.2+rc+fs/fs/fcntl.c	Thu Apr  5 18:00:41 2001
@@ -63,7 +63,11 @@
 	int error;
 	int start;
 
+#ifdef CONFIG_FD_RCU
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	
 repeat:
 	/*
@@ -109,7 +113,11 @@
 {
 	FD_SET(fd, files->open_fds);
 	FD_CLR(fd, files->close_on_exec);
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	fd_install(fd, file);
 }
 
@@ -125,7 +133,11 @@
 	return ret;
 
 out_putf:
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	fput(file);
 	return ret;
 }
@@ -136,7 +148,11 @@
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
 
+#ifdef CONFIG_FD_RCU
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	if (!(file = fcheck(oldfd)))
 		goto out_unlock;
 	err = newfd;
@@ -167,7 +183,11 @@
 	files->fd[newfd] = file;
 	FD_SET(newfd, files->open_fds);
 	FD_CLR(newfd, files->close_on_exec);
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 
 	if (tofree)
 		filp_close(tofree, files);
@@ -175,11 +195,19 @@
 out:
 	return err;
 out_unlock:
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	goto out;
 
 out_fput:
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	fput(file);
 	goto out;
 }
diff -urN linux-2.4.2+rc/fs/file.c linux-2.4.2+rc+fs/fs/file.c
--- linux-2.4.2+rc/fs/file.c	Sat Feb 10 00:59:44 2001
+++ linux-2.4.2+rc+fs/fs/file.c	Thu Apr  5 17:39:29 2001
@@ -14,6 +14,17 @@
 
 #include <asm/bitops.h>
 
+#ifdef CONFIG_FD_RCU
+#include <linux/rclock.h>
+
+struct fdset_callback_func_args {
+	int nfds;
+	fd_set *new_openset;
+	fd_set *new_execset;
+};
+typedef struct fdset_callback_func_args fdset_callback_func_args_t;
+
+#endif
 
 /*
  * Allocate an fd array, using kmalloc or vmalloc.
@@ -48,6 +59,109 @@
 		vfree(array);
 }
 
+
+#ifdef CONFIG_FD_RCU
+
+int fd_array_callback_func(rc_callback_t *cb, void *arg1, void *arg2)
+{
+	struct file **old_fds = (struct file **)arg1;
+	unsigned long nfds =  (unsigned long ) arg2;
+	
+	free_fd_array(old_fds, nfds);
+	rc_free_callback(cb);
+	
+	return 0;
+}
+                                                                                
+int expand_fd_array(struct files_struct *files, int nr)
+{
+	struct file **new_fds;
+	int error, nfds;
+	rc_callback_t *fd_cb;		
+
+	error = -EMFILE;
+	if (files->max_fds >= NR_OPEN || nr >= NR_OPEN)
+		goto out;
+
+	nfds = files->max_fds;
+	spin_unlock(&files->file_lock);
+
+	/* 
+	 * Expand to the max in easy steps, and keep expanding it until
+	 * we have enough for the requested fd array size. 
+	 */
+
+	do {
+#if NR_OPEN_DEFAULT < 256
+		if (nfds < 256)
+			nfds = 256;
+		else 
+#endif
+		if (nfds < (PAGE_SIZE / sizeof(struct file *)))
+			nfds = PAGE_SIZE / sizeof(struct file *);
+		else {
+			nfds = nfds * 2;
+			if (nfds > NR_OPEN)
+				nfds = NR_OPEN;
+		}
+	} while (nfds <= nr);
+
+	error = -ENOMEM;
+
+	fd_cb = rc_alloc_callback(fd_array_callback_func, NULL, NULL, 
+				   GFP_ATOMIC);
+	new_fds = alloc_fd_array(nfds);
+	spin_lock(&files->file_lock);
+	if (!new_fds) {
+		rc_free_callback(fd_cb);
+		goto out;
+	}
+
+	/* Copy the existing array and install the new pointer */
+
+	if (nfds > files->max_fds) {
+		struct file **old_fds = files->fd;
+		int i = files->max_fds;
+		
+
+		/* Don't copy/clear the array if we are creating a new
+		   fd array for fork() */
+		if (i) {
+			memcpy(new_fds, old_fds, i * sizeof(struct file *));
+			/* clear the remainder of the array */
+			memset(&new_fds[i], 0,
+			       (nfds-i) * sizeof(struct file *)); 
+		}
+
+		RC_MEMSYNC();
+
+		old_fds = xchg(&files->fd, new_fds);
+
+		RC_MEMSYNC();
+
+		i = xchg(&files->max_fds, nfds);
+
+		if (i) {
+			fd_cb->arg1 = old_fds;
+			fd_cb->arg2 = (void *) i;
+			rc_callback(fd_cb);
+		} else {
+			rc_free_callback(fd_cb);
+		}
+		
+	} else {
+		/* Somebody expanded the array while we slept ... */
+		spin_unlock(&files->file_lock);
+		free_fd_array(new_fds, nfds);
+		rc_free_callback(fd_cb);
+		spin_lock(&files->file_lock);
+	}
+	error = 0;
+out:
+	return error;
+}
+
+#else  /* CONFIG_FD_RCU */
 /*
  * Expand the fd array in the files_struct.  Called with the files
  * spinlock held for write.
@@ -123,6 +237,7 @@
 out:
 	return error;
 }
+#endif /* CONFIG_FD_RCU */
 
 /*
  * Allocate an fdset array, using kmalloc or vmalloc.
@@ -157,6 +272,117 @@
 		vfree(array);
 }
 
+#ifdef CONFIG_FD_RCU
+
+int fdset_callback_func(rc_callback_t *cb, void *arg1, void *arg2)
+{
+	int nfds = ((fdset_callback_func_args_t *)arg1)->nfds;
+	fd_set *new_openset = ((fdset_callback_func_args_t *)arg1)->new_openset;
+	fd_set *new_execset = ((fdset_callback_func_args_t *)arg1)->new_execset;
+
+	free_fdset (new_openset, nfds);
+	free_fdset (new_execset, nfds);
+
+	kfree(arg1);
+	rc_free_callback(cb);
+
+	return 0;
+}
+
+int expand_fdset(struct files_struct *files, int nr)
+{
+	fd_set *new_openset = 0, *new_execset = 0;
+	int error, nfds = 0;
+	rc_callback_t *fd_cb = NULL;
+	fdset_callback_func_args_t *args = NULL;
+
+	error = -EMFILE;
+	if (files->max_fdset >= NR_OPEN || nr >= NR_OPEN)
+		goto out;
+
+	nfds = files->max_fdset;
+	spin_unlock(&files->file_lock);
+
+	/* Expand to the max in easy steps */
+	do {
+		if (nfds < (PAGE_SIZE * 8))
+			nfds = PAGE_SIZE * 8;
+		else {
+			nfds = nfds * 2;
+			if (nfds > NR_OPEN)
+				nfds = NR_OPEN;
+		}
+	} while (nfds <= nr);
+
+	error = -ENOMEM;
+	new_openset = alloc_fdset(nfds);
+	new_execset = alloc_fdset(nfds);
+
+	fd_cb = rc_alloc_callback(fdset_callback_func, NULL, NULL, GFP_ATOMIC);
+	args = (fdset_callback_func_args_t *)kmalloc(sizeof(args), GFP_ATOMIC);
+
+	spin_lock(&files->file_lock);
+	if (!new_openset || !new_execset) 
+		goto out;
+
+	error = 0;
+	
+	/* Copy the existing tables and install the new pointers */
+	if (nfds > files->max_fdset) {
+		int i = files->max_fdset / (sizeof(unsigned long) * 8);
+		int count = (nfds - files->max_fdset) / 8;
+		
+		/* 
+		 * Don't copy the entire array if the current fdset is
+		 * not yet initialised.  
+		 */
+		if (i) {
+			memcpy (new_openset, files->open_fds, files->max_fdset/8);
+			memcpy (new_execset, files->close_on_exec, files->max_fdset/8);
+			memset (&new_openset->fds_bits[i], 0, count);
+			memset (&new_execset->fds_bits[i], 0, count);
+		}
+
+
+		RC_MEMSYNC();
+
+		nfds = xchg(&files->max_fdset, nfds);
+
+		RC_MEMSYNC();
+
+		new_openset = xchg(&files->open_fds, new_openset);
+
+		RC_MEMSYNC();
+
+		new_execset = xchg(&files->close_on_exec, new_execset);
+
+		args->nfds = nfds;
+		args->new_openset = new_openset;
+		args->new_execset = new_execset;
+		
+		fd_cb->arg1 = args;
+
+		rc_callback(fd_cb);
+
+		return 0;
+	} 
+	/* Somebody expanded the array while we slept ... */
+
+out:
+	spin_unlock(&files->file_lock);
+	if (new_openset)
+		free_fdset(new_openset, nfds);
+	if (new_execset)
+		free_fdset(new_execset, nfds);
+	if (fd_cb)
+		rc_free_callback(fd_cb);
+	if (args)
+		kfree(args);
+	spin_lock(&files->file_lock);
+	return error;
+}
+
+#else
 /*
  * Expand the fdset in the files_struct.  Called with the files spinlock
  * held for write.
@@ -230,3 +456,4 @@
 	return error;
 }
 
+#endif /* CONFIG_FD_RCU */
diff -urN linux-2.4.2+rc/fs/file_table.c linux-2.4.2+rc+fs/fs/file_table.c
--- linux-2.4.2+rc/fs/file_table.c	Tue Dec  5 23:57:31 2000
+++ linux-2.4.2+rc+fs/fs/file_table.c	Fri Apr  6 19:25:43 2001
@@ -127,11 +127,15 @@
 	struct file * file;
 	struct files_struct *files = current->files;
 
+#ifndef  CONFIG_FD_RCU
 	read_lock(&files->file_lock);
+#endif
 	file = fcheck(fd);
 	if (file)
 		get_file(file);
+#ifndef  CONFIG_FD_RCU
 	read_unlock(&files->file_lock);
+#endif
 	return file;
 }
 
diff -urN linux-2.4.2+rc/fs/open.c linux-2.4.2+rc+fs/fs/open.c
--- linux-2.4.2+rc/fs/open.c	Sat Feb 10 00:59:44 2001
+++ linux-2.4.2+rc+fs/fs/open.c	Thu Apr  5 17:45:22 2001
@@ -16,6 +16,9 @@
 #include <linux/tty.h>
 
 #include <asm/uaccess.h>
+#ifdef CONFIG_FD_RCU
+#include <linux/rclock.h>
+#endif
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
@@ -688,7 +691,11 @@
 	int fd, error;
 
   	error = -EMFILE;
+#ifdef CONFIG_FD_RCU
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 
 repeat:
  	fd = find_next_zero_bit(files->open_fds, 
@@ -737,7 +744,11 @@
 	error = fd;
 
 out:
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	return error;
 }
 
@@ -818,7 +829,11 @@
 	struct file * filp;
 	struct files_struct *files = current->files;
 
+#ifdef CONFIG_FD_RCU
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	if (fd >= files->max_fds)
 		goto out_unlock;
 	filp = files->fd[fd];
@@ -827,11 +842,19 @@
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	return filp_close(filp, files);
 
 out_unlock:
+#ifdef CONFIG_FD_RCU	
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 	return -EBADF;
 }
 
diff -urN linux-2.4.2+rc/fs/proc/base.c linux-2.4.2+rc+fs/fs/proc/base.c
--- linux-2.4.2+rc/fs/proc/base.c	Fri Nov 17 02:48:26 2000
+++ linux-2.4.2+rc+fs/fs/proc/base.c	Thu Apr  5 18:03:44 2001
@@ -739,12 +739,16 @@
 	task_unlock(task);
 	if (!files)
 		goto out_unlock;
+#ifndef CONFIG_FD_RCU
 	read_lock(&files->file_lock);
+#endif
 	file = inode->u.proc_i.file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
 	get_file(file);
+#ifndef CONFIG_FD_RCU
 	read_unlock(&files->file_lock);
+#endif
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
@@ -760,7 +764,9 @@
 
 out_unlock2:
 	put_files_struct(files);
+#ifndef CONFIG_FD_RCU
 	read_unlock(&files->file_lock);
+#endif
 out_unlock:
 	iput(inode);
 out:
diff -urN linux-2.4.2+rc/fs/select.c linux-2.4.2+rc+fs/fs/select.c
--- linux-2.4.2+rc/fs/select.c	Sat Feb 10 00:59:44 2001
+++ linux-2.4.2+rc+fs/fs/select.c	Thu Apr  5 17:50:20 2001
@@ -166,9 +166,13 @@
 	int retval, i, off;
 	long __timeout = *timeout;
 
+#ifndef CONFIG_FD_RCU
  	read_lock(&current->files->file_lock);
+#endif
 	retval = max_select_fd(n, fds);
+#ifndef CONFIG_FD_RCU
 	read_unlock(&current->files->file_lock);
+#endif
 
 	if (retval < 0)
 		return retval;
diff -urN linux-2.4.2+rc/include/linux/file.h linux-2.4.2+rc+fs/include/linux/file.h
--- linux-2.4.2+rc/include/linux/file.h	Wed Aug 23 23:52:26 2000
+++ linux-2.4.2+rc+fs/include/linux/file.h	Thu Apr  5 16:34:02 2001
@@ -12,21 +12,33 @@
 {
 	struct files_struct *files = current->files;
 	int res;
+#ifndef CONFIG_FD_RCU
 	read_lock(&files->file_lock);
+#endif
 	res = FD_ISSET(fd, files->close_on_exec);
+#ifndef CONFIG_FD_RCU
 	read_unlock(&files->file_lock);
+#endif
 	return res;
 }
 
 static inline void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
+#ifdef CONFIG_FD_RCU	
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	if (flag)
 		FD_SET(fd, files->close_on_exec);
 	else
 		FD_CLR(fd, files->close_on_exec);
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 }
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
@@ -66,9 +78,17 @@
 {
 	struct files_struct *files = current->files;
 
+#ifdef CONFIG_FD_RCU	
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	__put_unused_fd(files, fd);
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 }
 
 /*
@@ -87,12 +107,21 @@
 static inline void fd_install(unsigned int fd, struct file * file)
 {
 	struct files_struct *files = current->files;
-	
+
+#ifdef CONFIG_FD_RCU	
+	spin_lock(&files->file_lock);
+#else
 	write_lock(&files->file_lock);
+#endif
 	if (files->fd[fd])
 		BUG();
 	files->fd[fd] = file;
+	
+#ifdef CONFIG_FD_RCU
+	spin_unlock(&files->file_lock);
+#else
 	write_unlock(&files->file_lock);
+#endif
 }
 
 void put_files_struct(struct files_struct *fs);
diff -urN linux-2.4.2+rc/include/linux/sched.h linux-2.4.2+rc+fs/include/linux/sched.h
--- linux-2.4.2+rc/include/linux/sched.h	Thu Feb 22 05:39:58 2001
+++ linux-2.4.2+rc+fs/include/linux/sched.h	Fri Apr  6 14:09:18 2001
@@ -167,7 +167,11 @@
  */
 struct files_struct {
 	atomic_t count;
+#ifdef CONFIG_FD_RCU
+	spinlock_t file_lock;
+#else
 	rwlock_t file_lock;
+#endif
 	int max_fds;
 	int max_fdset;
 	int next_fd;
@@ -179,6 +183,22 @@
 	struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
+#ifdef CONFIG_FD_RCU					
+#define INIT_FILES \
+{ 							\
+	count:		ATOMIC_INIT(1), 		\
+	file_lock:	SPIN_LOCK_UNLOCKED, 		\
+	max_fds:	NR_OPEN_DEFAULT, 		\
+	max_fdset:	__FD_SETSIZE, 			\
+	next_fd:	0, 				\
+	fd:		&init_files.fd_array[0], 	\
+	close_on_exec:	&init_files.close_on_exec_init, \
+	open_fds:	&init_files.open_fds_init, 	\
+	close_on_exec_init: { { 0, } }, 		\
+	open_fds_init:	{ { 0, } }, 			\
+	fd_array:	{ NULL, } 			\
+}
+#else
 #define INIT_FILES \
 { 							\
 	count:		ATOMIC_INIT(1), 		\
@@ -193,6 +213,7 @@
 	open_fds_init:	{ { 0, } }, 			\
 	fd_array:	{ NULL, } 			\
 }
+#endif
 
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
diff -urN linux-2.4.2+rc/kernel/fork.c linux-2.4.2+rc+fs/kernel/fork.c
--- linux-2.4.2+rc/kernel/fork.c	Sat Feb 10 00:59:44 2001
+++ linux-2.4.2+rc+fs/kernel/fork.c	Thu Apr  5 16:22:08 2001
@@ -24,6 +24,9 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_FD_RCU
+#include <linux/rclock.h>
+#endif
 /* The idle threads do not count.. */
 int nr_threads;
 int nr_running;
@@ -433,7 +436,11 @@
 
 	atomic_set(&newf->count, 1);
 
+#ifdef CONFIG_FD_RCU
+	newf->file_lock	    = SPIN_LOCK_UNLOCKED;
+#else
 	newf->file_lock	    = RW_LOCK_UNLOCKED;
+#endif
 	newf->next_fd	    = 0;
 	newf->max_fds	    = NR_OPEN_DEFAULT;
 	newf->max_fdset	    = __FD_SETSIZE;
@@ -446,13 +453,23 @@
 	size = oldf->max_fdset;
 	if (size > __FD_SETSIZE) {
 		newf->max_fdset = 0;
+#ifdef CONFIG_FD_RCU
+		spin_lock(&newf->file_lock);
+#else
 		write_lock(&newf->file_lock);
+#endif
 		error = expand_fdset(newf, size-1);
+#ifdef CONFIG_FD_RCU
+		spin_unlock(&newf->file_lock);
+#else
 		write_unlock(&newf->file_lock);
+#endif
 		if (error)
 			goto out_release;
 	}
+#ifndef CONFIG_FD_RCU
 	read_lock(&oldf->file_lock);
+#endif
 
 	open_files = count_open_files(oldf, size);
 
@@ -463,15 +480,27 @@
 	 */
 	nfds = NR_OPEN_DEFAULT;
 	if (open_files > nfds) {
+#ifndef CONFIG_FD_RCU
 		read_unlock(&oldf->file_lock);
+#endif
 		newf->max_fds = 0;
+#ifdef CONFIG_FD_RCU
+		spin_lock(&newf->file_lock);
+#else
 		write_lock(&newf->file_lock);
+#endif
 		error = expand_fd_array(newf, open_files-1);
+#ifdef CONFIG_FD_RCU
+		spin_unlock(&newf->file_lock);
+#else
 		write_unlock(&newf->file_lock);
+#endif
 		if (error) 
 			goto out_release;
 		nfds = newf->max_fds;
+#ifndef CONFIG_FD_RCU
 		read_lock(&oldf->file_lock);
+#endif
 	}
 
 	old_fds = oldf->fd;
@@ -486,7 +515,9 @@
 			get_file(f);
 		*new_fds++ = f;
 	}
+#ifndef CONFIG_FD_RCU
 	read_unlock(&oldf->file_lock);
+#endif
 
 	/* compute the remainder to be cleared */
 	size = (newf->max_fds - open_files) * sizeof(struct file *);
diff -urN linux-2.4.2+rc/net/ipv4/netfilter/ipt_owner.c linux-2.4.2+rc+fs/net/ipv4/netfilter/ipt_owner.c
--- linux-2.4.2+rc/net/ipv4/netfilter/ipt_owner.c	Mon Aug 14 01:23:19 2000
+++ linux-2.4.2+rc+fs/net/ipv4/netfilter/ipt_owner.c	Thu Apr  5 18:06:21 2001
@@ -25,16 +25,22 @@
 	task_lock(p);
 	files = p->files;
 	if(files) {
+#ifndef CONFIG_FD_RCU
 		read_lock(&files->file_lock);
+#endif
 		for (i=0; i < files->max_fds; i++) {
 			if (fcheck_files(files, i) == skb->sk->socket->file) {
+#ifndef CONFIG_FD_RCU
 				read_unlock(&files->file_lock);
+#endif
 				task_unlock(p);
 				read_unlock(&tasklist_lock);
 				return 1;
 			}
 		}
+#ifndef CONFIG_FD_RCU
 		read_unlock(&files->file_lock);
+#endif
 	}
 	task_unlock(p);
 out:
@@ -58,14 +64,18 @@
 		task_lock(p);
 		files = p->files;
 		if (files) {
+#ifndef CONFIG_FD_RCU
 			read_lock(&files->file_lock);
+#endif
 			for (i=0; i < files->max_fds; i++) {
 				if (fcheck_files(files, i) == file) {
 					found = 1;
 					break;
 				}
 			}
+#ifndef CONFIG_FD_RCU
 			read_unlock(&files->file_lock);
+#endif
 		}
 		task_unlock(p);
 		if(found)
