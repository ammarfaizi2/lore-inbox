Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281413AbRKLKu7>; Mon, 12 Nov 2001 05:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281415AbRKLKuu>; Mon, 12 Nov 2001 05:50:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10882 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281413AbRKLKuk>;
	Mon, 12 Nov 2001 05:50:40 -0500
Date: Mon, 12 Nov 2001 16:26:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
        Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] files_struct race conditions fixes
Message-ID: <20011112162609.B1367@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011101173019.K1291@athlon.random> <20011101184924.N1291@athlon.random> <20011109114118.K23390@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011109114118.K23390@in.ibm.com>; from maneesh@in.ibm.com on Fri, Nov 09, 2001 at 11:41:18AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Based on Maneesh's audit of the fields of files_struct, it seems
that there are a few places where the file pointers are
being looked up without holding the reader side of the
rwlock in files_struct. This can lead to a race with another cloned task
that may share the files_struct.

Here is a patch that fixes the affected places.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

diff -urN linux-2.4.14/arch/ia64/ia32/sys_ia32.c linux-2.4.14+files/arch/ia64/ia32/sys_ia32.c
--- linux-2.4.14/arch/ia64/ia32/sys_ia32.c	Mon Aug 13 03:37:42 2001
+++ linux-2.4.14+files/arch/ia64/ia32/sys_ia32.c	Mon Nov 12 14:35:54 2001
@@ -3853,7 +3853,9 @@
 		}
 		/* Bump the usage count and install the file. */
 		fp[i]->f_count++;
+		write_lock(&current->files->file_lock);
 		current->files->fd[new_fd] = fp[i];
+		write_unlock(&current->files->file_lock);
 	}
 
 	if (i > 0) {
diff -urN linux-2.4.14/arch/sparc/kernel/sunos_ioctl.c linux-2.4.14+files/arch/sparc/kernel/sunos_ioctl.c
--- linux-2.4.14/arch/sparc/kernel/sunos_ioctl.c	Thu Sep  7 21:02:00 2000
+++ linux-2.4.14+files/arch/sparc/kernel/sunos_ioctl.c	Mon Nov 12 14:40:23 2001
@@ -39,8 +39,12 @@
 {
 	int ret = -EBADF;
 
-	if (fd >= SUNOS_NR_OPEN || !fcheck(fd))
+	read_lock(&current->files->file_lock);
+	if (fd >= SUNOS_NR_OPEN || !fcheck(fd)) {
+		read_unlock(&current->files->file_lock);
 		goto out;
+	}
+	read_unlock(&current->files->file_lock);
 
 	/* First handle an easy compat. case for tty ldisc. */
 	if(cmd == TIOCSETD) {
diff -urN linux-2.4.14/arch/sparc64/kernel/sunos_ioctl32.c linux-2.4.14+files/arch/sparc64/kernel/sunos_ioctl32.c
--- linux-2.4.14/arch/sparc64/kernel/sunos_ioctl32.c	Sat Aug  5 06:46:11 2000
+++ linux-2.4.14+files/arch/sparc64/kernel/sunos_ioctl32.c	Mon Nov 12 14:42:51 2001
@@ -100,8 +100,12 @@
 
 	if(fd >= SUNOS_NR_OPEN)
 		goto out;
-	if(!fcheck(fd))
+	read_lock(&current->files->file_lock);
+	if(!fcheck(fd)) {
+		read_unlock(&current->files->file_lock);
 		goto out;
+	}
+	read_unlock(&current->files->file_lock);
 
 	if(cmd == TIOCSETD) {
 		mm_segment_t old_fs = get_fs();
diff -urN linux-2.4.14/arch/sparc64/solaris/ioctl.c linux-2.4.14+files/arch/sparc64/solaris/ioctl.c
--- linux-2.4.14/arch/sparc64/solaris/ioctl.c	Wed Nov 29 11:23:44 2000
+++ linux-2.4.14+files/arch/sparc64/solaris/ioctl.c	Mon Nov 12 14:33:48 2001
@@ -289,11 +289,15 @@
 {
 	struct inode *ino;
 	/* I wonder which of these tests are superfluous... --patrik */
+	read_lock(&current->files->file_lock);
 	if (! current->files->fd[fd] ||
 	    ! current->files->fd[fd]->f_dentry ||
 	    ! (ino = current->files->fd[fd]->f_dentry->d_inode) ||
-	    ! ino->i_sock)
+	    ! ino->i_sock) {
+		read_unlock(&current->files->file_lock);
 		return TBADF;
+	}
+	read_unlock(&current->files->file_lock);
 	
 	switch (cmd & 0xff) {
 	case 109: /* SI_SOCKPARAMS */
diff -urN linux-2.4.14/arch/sparc64/solaris/timod.c linux-2.4.14+files/arch/sparc64/solaris/timod.c
--- linux-2.4.14/arch/sparc64/solaris/timod.c	Fri Sep 21 02:41:57 2001
+++ linux-2.4.14+files/arch/sparc64/solaris/timod.c	Mon Nov 12 14:31:19 2001
@@ -149,7 +149,9 @@
 	struct socket *sock;
 
 	SOLD("wakeing socket");
+	read_lock(&current->files->file_lock);
 	sock = &current->files->fd[fd]->f_dentry->d_inode->u.socket_i;
+	read_unlock(&current->files->file_lock);
 	wake_up_interruptible(&sock->wait);
 	read_lock(&sock->sk->callback_lock);
 	if (sock->fasync_list && !test_bit(SOCK_ASYNC_WAITDATA, &sock->flags))
@@ -163,7 +165,9 @@
 	struct sol_socket_struct *sock;
 
 	SOLD("queuing primsg");
+	read_lock(&current->files->file_lock);
 	sock = (struct sol_socket_struct *)current->files->fd[fd]->private_data;
+	read_unlock(&current->files->file_lock);
 	it->next = sock->pfirst;
 	sock->pfirst = it;
 	if (!sock->plast)
@@ -177,7 +181,9 @@
 	struct sol_socket_struct *sock;
 
 	SOLD("queuing primsg at end");
+	read_lock(&current->files->file_lock);
 	sock = (struct sol_socket_struct *)current->files->fd[fd]->private_data;
+	read_unlock(&current->files->file_lock);
 	it->next = NULL;
 	if (sock->plast)
 		sock->plast->next = it;
@@ -355,7 +361,11 @@
 		(int (*)(int, unsigned long *))SYS(socketcall);
 	int (*sys_sendto)(int, void *, size_t, unsigned, struct sockaddr *, int) =
 		(int (*)(int, void *, size_t, unsigned, struct sockaddr *, int))SYS(sendto);
-	filp = current->files->fd[fd];
+	read_lock(&current->files->file_lock);
+	filp = fcheck(fd);
+	read_unlock(&current->files->file_lock);
+	if (!filp)
+		return -EBADF;
 	ino = filp->f_dentry->d_inode;
 	sock = (struct sol_socket_struct *)filp->private_data;
 	SOLD("entry");
@@ -636,7 +646,11 @@
 	
 	SOLD("entry");
 	SOLDD(("%u %p %d %p %p %d %p %d\n", fd, ctl_buf, ctl_maxlen, ctl_len, data_buf, data_maxlen, data_len, *flags_p));
-	filp = current->files->fd[fd];
+	read_lock(&current->files->file_lock);
+	filp = fcheck(fd);
+	read_unlock(&current->files->file_lock);
+	if (!filp)
+		return -EBADF;
 	ino = filp->f_dentry->d_inode;
 	sock = (struct sol_socket_struct *)filp->private_data;
 	SOLDD(("%p %p\n", sock->pfirst, sock->pfirst ? sock->pfirst->next : NULL));
@@ -847,7 +861,9 @@
 	lock_kernel();
 	if(fd >= NR_OPEN) goto out;
 
-	filp = current->files->fd[fd];
+	read_lock(&current->files->file_lock);
+	filp = fcheck(fd);
+	read_unlock(&current->files->file_lock);
 	if(!filp) goto out;
 
 	ino = filp->f_dentry->d_inode;
@@ -914,7 +930,9 @@
 	lock_kernel();
 	if(fd >= NR_OPEN) goto out;
 
-	filp = current->files->fd[fd];
+	read_lock(&current->files->file_lock);
+	filp = fcheck(fd);
+	read_unlock(&current->files->file_lock);
 	if(!filp) goto out;
 
 	ino = filp->f_dentry->d_inode;
diff -urN linux-2.4.14/fs/proc/base.c linux-2.4.14+files/fs/proc/base.c
--- linux-2.4.14/fs/proc/base.c	Thu Oct 11 12:12:47 2001
+++ linux-2.4.14+files/fs/proc/base.c	Mon Nov 12 12:53:58 2001
@@ -553,6 +553,7 @@
 			task_unlock(p);
 			if (!files)
 				goto out;
+			read_lock(&files->file_lock);
 			for (fd = filp->f_pos-2;
 			     fd < files->max_fds;
 			     fd++, filp->f_pos++) {
@@ -573,6 +574,7 @@
 				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0)
 					break;
 			}
+			read_unlock(&files->file_lock);
 			put_files_struct(files);
 	}
 out:
