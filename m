Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319307AbSHQCzN>; Fri, 16 Aug 2002 22:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319309AbSHQCzN>; Fri, 16 Aug 2002 22:55:13 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:39431 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S319307AbSHQCzG>; Fri, 16 Aug 2002 22:55:06 -0400
Date: Sat, 17 Aug 2002 12:58:12 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: kuznet@ms2.inr.ac.ru, Andi Kleen <ak@muc.de>, <viro@math.psu.edu>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31 [version 2]
In-Reply-To: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>
Message-ID: <Mutt.LNX.4.44.0208171249510.3437-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of the sigurg/sigio cleanup patch, 
incorporating feedback from the list.

New changes:

 Feedback from Matthew Wilcox:
    o Fixed F_SETOWN bogosity.
    o Incorporated sk_wake_async() into sk_send_sigurg().

  Feedback from Alexey Kuznetsov:
    o Fixed BKL/dn_lock nesting deadlock in fcntl_dirnotify().
    o Removed explicit BKL coverage of f_setown & replaced with spinlock.

  Feedback from Chris Wright:
    o Fixed associated mainline memory leak in fcntl_dirnotify().

  Feedback from Jeff Dike:
    o Don't drop SIGIOs.

Old Changes:
    o Removed sk->proc, SIGURG now sent via vfs, credentials checked 
      during delivery.
    o SIOCSPGRP etc. ioctls use vfs, and work now for SIGIO as well
      as SIGURG.
    o Removed socket fcntl code.
    o Consolidate lsm file_set_fowner() hooks.
    o Fixed fowner race (lockless technique suggested by Alan Cox).

Comments welcome.

 drivers/char/tty_io.c      |   12 +---
 drivers/net/tun.c          |    8 +--
 fs/Makefile                |    2 
 fs/dnotify.c               |   25 ++++-----
 fs/fcntl.c                 |  116 +++++++++++++++++++++++++++++++++++----------
 fs/locks.c                 |   12 ----
 include/linux/fs.h         |    4 +
 include/linux/threads.h    |    5 +
 include/net/inet_common.h  |    3 -
 include/net/sock.h         |    5 -
 kernel/futex.c             |   11 +++-
 net/core/sock.c            |   36 ++-----------
 net/econet/af_econet.c     |    7 --
 net/ipv4/af_inet.c         |    8 ---
 net/ipv4/tcp_input.c       |    8 ---
 net/ipv4/tcp_minisocks.c   |    1 
 net/ipv6/af_inet6.c        |    9 ---
 net/packet/af_packet.c     |    8 ---
 net/socket.c               |   19 -------
 net/wanrouter/af_wanpipe.c |    8 ---
 net/x25/x25_in.c           |    8 ---
 21 files changed, 149 insertions(+), 166 deletions(-)


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.31.orig/drivers/char/tty_io.c linux-2.5.31.w2/drivers/char/tty_io.c
--- linux-2.5.31.orig/drivers/char/tty_io.c	Fri Aug  2 07:16:28 2002
+++ linux-2.5.31.w2/drivers/char/tty_io.c	Sat Aug 17 02:11:50 2002
@@ -1458,15 +1458,9 @@
 	if (on) {
 		if (!waitqueue_active(&tty->read_wait))
 			tty->minimum_to_wake = 1;
-		if (filp->f_owner.pid == 0) {
-			retval = security_ops->file_set_fowner(filp);
-			if (retval)
-				return retval;
-
-			filp->f_owner.pid = (-tty->pgrp) ? : current->pid;
-			filp->f_owner.uid = current->uid;
-			filp->f_owner.euid = current->euid;
-		}
+		retval = f_setown(filp, (-tty->pgrp) ? : current->pid, 0);
+		if (retval)
+			return retval;
 	} else {
 		if (!tty->fasync && !waitqueue_active(&tty->read_wait))
 			tty->minimum_to_wake = N_TTY_BUF_SIZE;
diff -urN -X dontdiff linux-2.5.31.orig/drivers/net/tun.c linux-2.5.31.w2/drivers/net/tun.c
--- linux-2.5.31.orig/drivers/net/tun.c	Sun Aug 11 12:20:39 2002
+++ linux-2.5.31.w2/drivers/net/tun.c	Sat Aug 17 02:11:24 2002
@@ -513,12 +513,10 @@
 		return ret; 
  
 	if (on) {
+		ret = f_setown(file, current->pid, 0);
+		if (ret)
+			return ret;
 		tun->flags |= TUN_FASYNC;
-		if (!file->f_owner.pid) {
-			file->f_owner.pid  = current->pid;
-			file->f_owner.uid  = current->uid;
-			file->f_owner.euid = current->euid;
-		}
 	} else 
 		tun->flags &= ~TUN_FASYNC;
 
diff -urN -X dontdiff linux-2.5.31.orig/fs/Makefile linux-2.5.31.w2/fs/Makefile
--- linux-2.5.31.orig/fs/Makefile	Fri Aug  2 07:16:03 2002
+++ linux-2.5.31.w2/fs/Makefile	Fri Aug 16 00:40:48 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o
+export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o fcntl.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
diff -urN -X dontdiff linux-2.5.31.orig/fs/dnotify.c linux-2.5.31.w2/fs/dnotify.c
--- linux-2.5.31.orig/fs/dnotify.c	Fri Aug  2 07:16:17 2002
+++ linux-2.5.31.w2/fs/dnotify.c	Sat Aug 17 02:12:58 2002
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
@@ -68,7 +69,7 @@
 	struct dnotify_struct **prev;
 	struct inode *inode;
 	fl_owner_t id = current->files;
-	int error;
+	int error = 0;
 
 	if ((arg & ~DN_MULTISHOT) == 0) {
 		dnotify_flush(filp, id);
@@ -89,21 +90,15 @@
 			odn->dn_fd = fd;
 			odn->dn_mask |= arg;
 			inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
-			kmem_cache_free(dn_cache, dn);
-			goto out;
+			goto out_free;
 		}
 		prev = &odn->dn_next;
 	}
 
-	error = security_ops->file_set_fowner(filp);
-	if (error) {
-		write_unlock(&dn_lock);
-		return error;
-	}
+	error = f_setown(filp, current->pid, 1);
+	if (error)
+		goto out_free;
 
-	filp->f_owner.pid = current->pid;
-	filp->f_owner.uid = current->uid;
-	filp->f_owner.euid = current->euid;
 	dn->dn_mask = arg;
 	dn->dn_fd = fd;
 	dn->dn_filp = filp;
@@ -113,7 +108,10 @@
 	inode->i_dnotify = dn;
 out:
 	write_unlock(&dn_lock);
-	return 0;
+	return error;
+out_free:
+	kmem_cache_free(dn_cache, dn);
+	goto out;
 }
 
 void __inode_dir_notify(struct inode *inode, unsigned long event)
@@ -131,8 +129,7 @@
 			continue;
 		}
 		fown = &dn->dn_filp->f_owner;
-		if (fown->pid)
-		        send_sigio(fown, dn->dn_fd, POLL_MSG);
+		send_sigio(fown, dn->dn_fd, POLL_MSG);
 		if (dn->dn_mask & DN_MULTISHOT)
 			prev = &dn->dn_next;
 		else {
diff -urN -X dontdiff linux-2.5.31.orig/fs/fcntl.c linux-2.5.31.w2/fs/fcntl.c
--- linux-2.5.31.orig/fs/fcntl.c	Fri Aug  2 07:16:07 2002
+++ linux-2.5.31.w2/fs/fcntl.c	Sat Aug 17 02:53:28 2002
@@ -11,16 +11,18 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/iobuf.h>
+#include <linux/module.h>
 #include <linux/security.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
 #include <asm/uaccess.h>
 
-extern int sock_fcntl (struct file *, unsigned int cmd, unsigned long arg);
 extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
 extern int fcntl_getlease(struct file *filp);
 
+static spinlock_t f_owner_lock = SPIN_LOCK_UNLOCKED;
+
 void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
@@ -260,6 +262,39 @@
 	return 0;
 }
 
+static void f_modown(struct file *filp, unsigned long pid,
+                     uid_t uid, uid_t euid, int force)
+{
+	
+	spin_lock(&f_owner_lock);
+	if (force || !filp->f_owner.pid) {
+		filp->f_owner.pid = PID_INVALID;
+		wmb();
+		filp->f_owner.uid = uid;
+		filp->f_owner.euid = euid;
+		wmb();
+		filp->f_owner.pid = pid;
+	}
+	spin_unlock(&f_owner_lock);
+}
+
+int f_setown(struct file *filp, unsigned long arg, int force)
+{
+	int err;
+	
+	err = security_ops->file_set_fowner(filp);
+	if (err)
+		return err;
+
+	f_modown(filp, arg, current->uid, current->euid, force);
+	return 0;
+}
+
+void f_delown(struct file *filp)
+{
+	f_modown(filp, 0, 0, 0, 1);
+}
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
 		     unsigned long arg, struct file * filp)
 {
@@ -305,21 +340,7 @@
 			err = filp->f_owner.pid;
 			break;
 		case F_SETOWN:
-			lock_kernel();
-
-			err = security_ops->file_set_fowner(filp);
-			if (err) {
-				unlock_kernel();
-				break;
-			}
-
-			filp->f_owner.pid = arg;
-			filp->f_owner.uid = current->uid;
-			filp->f_owner.euid = current->euid;
-			err = 0;
-			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
-				err = sock_fcntl (filp, F_SETOWN, arg);
-			unlock_kernel();
+			err = f_setown(filp, arg, 1);
 			break;
 		case F_GETSIG:
 			err = filp->f_owner.signum;
@@ -342,10 +363,6 @@
 			err = fcntl_dirnotify(fd, filp, arg);
 			break;
 		default:
-			/* sockets need a few special fcntls. */
-			err = -EINVAL;
-			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
-				err = sock_fcntl (filp, cmd, arg);
 			break;
 	}
 
@@ -421,14 +438,20 @@
 	POLLHUP | POLLERR			/* POLL_HUP */
 };
 
+static inline int sigio_perm(struct task_struct *p,
+                             struct fown_struct *fown)
+{
+	return ((fown->euid == 0) ||
+ 	        (fown->euid == p->suid) || (fown->euid == p->uid) ||
+ 	        (fown->uid == p->suid) || (fown->uid == p->uid));
+}
+
 static void send_sigio_to_task(struct task_struct *p,
 			       struct fown_struct *fown, 
 			       int fd,
 			       int reason)
 {
-	if ((fown->euid != 0) &&
-	    (fown->euid ^ p->suid) && (fown->euid ^ p->uid) &&
-	    (fown->uid ^ p->suid) && (fown->uid ^ p->uid))
+	if (!sigio_perm(p, fown))
 		return;
 
 	if (security_ops->file_send_sigiotask(p, fown, fd, reason))
@@ -469,6 +492,12 @@
 	struct task_struct * p;
 	int   pid	= fown->pid;
 	
+	if (!pid)
+		return;
+		
+	while (pid == PID_INVALID)
+		cpu_relax();
+	
 	read_lock(&tasklist_lock);
 	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
 		send_sigio_to_task(p, fown, fd, band);
@@ -486,6 +515,42 @@
 	read_unlock(&tasklist_lock);
 }
 
+static void send_sigurg_to_task(struct task_struct *p,
+                                struct fown_struct *fown)
+{
+	if (sigio_perm(p, fown))
+		send_sig(SIGURG, p, 1);
+}
+
+int send_sigurg(struct fown_struct *fown)
+{
+	struct task_struct *p;
+	int pid = fown->pid;
+
+	if (!pid)
+		return 0;
+		
+	while (pid == PID_INVALID)
+		cpu_relax();
+
+	read_lock(&tasklist_lock);
+	if ((pid > 0) && (p = find_task_by_pid(pid))) {
+		send_sigurg_to_task(p, fown);
+		goto out;
+	}
+	for_each_task(p) {
+		int match = p->pid;
+		if (pid < 0)
+			match = -p->pgrp;
+		if (pid != match)
+			continue;
+		send_sigurg_to_task(p, fown);
+	}
+out:
+	read_unlock(&tasklist_lock);
+	return 1;
+}
+
 static rwlock_t fasync_lock = RW_LOCK_UNLOCKED;
 static kmem_cache_t *fasync_cache;
 
@@ -546,7 +611,7 @@
 		/* Don't send SIGURG to processes which have not set a
 		   queued signum: SIGURG has its own default signalling
 		   mechanism. */
-		if (fown->pid && !(sig == SIGURG && fown->signum == 0))
+		if (!(sig == SIGURG && fown->signum == 0))
 			send_sigio(fown, fa->fa_fd, band);
 		fa = fa->fa_next;
 	}
@@ -569,3 +634,6 @@
 }
 
 module_init(fasync_init)
+
+EXPORT_SYMBOL(f_setown);
+EXPORT_SYMBOL(f_delown);
diff -urN -X dontdiff linux-2.5.31.orig/fs/locks.c linux-2.5.31.w2/fs/locks.c
--- linux-2.5.31.orig/fs/locks.c	Fri Aug  2 07:16:39 2002
+++ linux-2.5.31.w2/fs/locks.c	Sat Aug 17 02:46:51 2002
@@ -997,9 +997,7 @@
 	if (arg == F_UNLCK) {
 		struct file *filp = fl->fl_file;
 
-		filp->f_owner.pid = 0;
-		filp->f_owner.uid = 0;
-		filp->f_owner.euid = 0;
+		f_delown(filp);
 		filp->f_owner.signum = 0;
 		locks_delete_lock(before);
 	}
@@ -1277,13 +1275,7 @@
 	*before = fl;
 	list_add(&fl->fl_link, &file_lock_list);
 
-	error = security_ops->file_set_fowner(filp);
-	if (error)
-		goto out_unlock;
-
-	filp->f_owner.pid = current->pid;
-	filp->f_owner.uid = current->uid;
-	filp->f_owner.euid = current->euid;
+	error = f_setown(filp, current->pid, 1);
 out_unlock:
 	unlock_kernel();
 	return error;
diff -urN -X dontdiff linux-2.5.31.orig/include/linux/fs.h linux-2.5.31.w2/include/linux/fs.h
--- linux-2.5.31.orig/include/linux/fs.h	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/include/linux/fs.h	Sat Aug 17 02:50:47 2002
@@ -615,6 +615,10 @@
 /* only for net: no internal synchronization */
 extern void __kill_fasync(struct fasync_struct *, int, int);
 
+extern int f_setown(struct file *filp, unsigned long arg, int force);
+extern void f_delown(struct file *filp);
+extern int send_sigurg(struct fown_struct *fown);
+
 /*
  *	Umount options
  */
diff -urN -X dontdiff linux-2.5.31.orig/include/linux/threads.h linux-2.5.31.w2/include/linux/threads.h
--- linux-2.5.31.orig/include/linux/threads.h	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/include/linux/threads.h	Fri Aug 16 00:10:41 2002
@@ -22,4 +22,9 @@
 #define PID_MASK 0x3fffffff
 #define PID_MAX (PID_MASK+1)
 
+/*
+ * Used to avoid locking in the sigio path.
+ */
+#define PID_INVALID 0x7fffffff
+
 #endif
diff -urN -X dontdiff linux-2.5.31.orig/include/net/inet_common.h linux-2.5.31.w2/include/net/inet_common.h
--- linux-2.5.31.orig/include/net/inet_common.h	Fri Aug  2 07:16:32 2002
+++ linux-2.5.31.w2/include/net/inet_common.h	Fri Aug 16 00:12:07 2002
@@ -34,9 +34,6 @@
 extern int			inet_getsockopt(struct socket *sock, int level,
 						int optname, char *optval, 
 						int *optlen);
-extern int			inet_fcntl(struct socket *sock, 
-					   unsigned int cmd, 
-					   unsigned long arg);
 extern int			inet_listen(struct socket *sock, int backlog);
 
 extern void			inet_sock_release(struct sock *sk);
diff -urN -X dontdiff linux-2.5.31.orig/include/net/sock.h linux-2.5.31.w2/include/net/sock.h
--- linux-2.5.31.orig/include/net/sock.h	Fri Aug  2 07:16:32 2002
+++ linux-2.5.31.w2/include/net/sock.h	Sat Aug 17 00:42:58 2002
@@ -132,7 +132,6 @@
 	unsigned char		rcvtstamp;
 	/* Hole of 1 byte. Try to pack. */
 	int			route_caps;
-	int			proc;
 	unsigned long	        lingertime;
 
 	int			hashent;
@@ -292,7 +291,6 @@
 #define SOCK_BINDADDR_LOCK	4
 #define SOCK_BINDPORT_LOCK	8
 
-#include <linux/fs.h>	/* just for inode - yeuch.*/
 
 
 /* Used by processes to "lock" a socket state, so that
@@ -362,6 +360,7 @@
 						      int *errcode);
 extern void *sock_kmalloc(struct sock *sk, int size, int priority);
 extern void sock_kfree_s(struct sock *sk, void *mem, int size);
+extern void sk_send_sigurg(struct sock *sk);
 
 /*
  * Functions to fill in entries in struct proto_ops when a protocol
@@ -388,8 +387,6 @@
 						   char *, int *);
 extern int			sock_no_setsockopt(struct socket *, int, int,
 						   char *, int);
-extern int 			sock_no_fcntl(struct socket *, 
-					      unsigned int, unsigned long);
 extern int                      sock_no_sendmsg(struct socket *,
 						struct msghdr *, int,
 						struct scm_cookie *);
diff -urN -X dontdiff linux-2.5.31.orig/kernel/futex.c linux-2.5.31.w2/kernel/futex.c
--- linux-2.5.31.orig/kernel/futex.c	Fri Aug  2 07:16:15 2002
+++ linux-2.5.31.w2/kernel/futex.c	Sat Aug 17 02:13:49 2002
@@ -276,9 +276,14 @@
 	filp->f_dentry = dget(futex_mnt->mnt_root);
 
 	if (signal) {
-		filp->f_owner.pid = current->tgid;
-		filp->f_owner.uid = current->uid;
-		filp->f_owner.euid = current->euid;
+		int ret;
+		
+		ret = f_setown(filp, current->tgid, 1);
+		if (ret) {
+			put_unused_fd(fd);
+			put_filp(filp);
+			return ret;
+		}
 		filp->f_owner.signum = signal;
 	}
 
diff -urN -X dontdiff linux-2.5.31.orig/net/core/sock.c linux-2.5.31.w2/net/core/sock.c
--- linux-2.5.31.orig/net/core/sock.c	Fri Aug  2 07:16:32 2002
+++ linux-2.5.31.w2/net/core/sock.c	Sat Aug 17 00:42:41 2002
@@ -103,7 +103,6 @@
 #include <linux/string.h>
 #include <linux/sockios.h>
 #include <linux/net.h>
-#include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -1048,34 +1047,6 @@
 	return -EOPNOTSUPP;
 }
 
-/* 
- * Note: if you add something that sleeps here then change sock_fcntl()
- *       to do proper fd locking.
- */
-int sock_no_fcntl(struct socket *sock, unsigned int cmd, unsigned long arg)
-{
-	struct sock *sk = sock->sk;
-
-	switch(cmd)
-	{
-		case F_SETOWN:
-			/*
-			 * This is a little restrictive, but it's the only
-			 * way to make sure that you can't send a sigurg to
-			 * another process.
-			 */
-			if (current->pgrp != -arg &&
-				current->pid != arg &&
-				!capable(CAP_KILL)) return(-EPERM);
-			sk->proc = arg;
-			return(0);
-		case F_GETOWN:
-			return(sk->proc);
-		default:
-			return(-EINVAL);
-	}
-}
-
 int sock_no_sendmsg(struct socket *sock, struct msghdr *m, int flags,
 		    struct scm_cookie *scm)
 {
@@ -1179,6 +1150,13 @@
 		kfree(sk->protinfo);
 }
 
+void sk_send_sigurg(struct sock *sk)
+{
+	if (sk->socket && sk->socket->file)
+		if (send_sigurg(&sk->socket->file->f_owner))
+			sk_wake_async(sk, 3, POLL_PRI);
+}
+
 void sock_init_data(struct socket *sock, struct sock *sk)
 {
 	skb_queue_head_init(&sk->receive_queue);
diff -urN -X dontdiff linux-2.5.31.orig/net/econet/af_econet.c linux-2.5.31.w2/net/econet/af_econet.c
--- linux-2.5.31.orig/net/econet/af_econet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/econet/af_econet.c	Sat Aug 17 02:17:44 2002
@@ -651,13 +651,10 @@
 		case SIOCSPGRP:
 			if (get_user(pid, (int *) arg))
 				return -EFAULT; 
-			if (current->pid != pid && current->pgrp != -pid && !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			return(0);
+			return f_setown(sock->file, pid, 1);
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			return put_user(sk->proc, (int *)arg);
+			return put_user(sock->file->f_owner.pid, (int *)arg);
 		case SIOCGSTAMP:
 			if(sk->stamp.tv_sec==0)
 				return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/ipv4/af_inet.c linux-2.5.31.w2/net/ipv4/af_inet.c
--- linux-2.5.31.orig/net/ipv4/af_inet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/ipv4/af_inet.c	Sat Aug 17 02:16:06 2002
@@ -857,16 +857,12 @@
 		case SIOCSPGRP:
 			if (get_user(pid, (int *)arg))
 				err = -EFAULT;
-			else if (current->pid != pid &&
-				 current->pgrp != -pid &&
-				!capable(CAP_NET_ADMIN))
-				err = -EPERM;
 			else
-				sk->proc = pid;
+				err = f_setown(sock->file, pid, 1);
 			break;
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			err = put_user(sk->proc, (int *)arg);
+			err = put_user(sock->file->f_owner.pid, (int *)arg);
 			break;
 		case SIOCGSTAMP:
 			if (!sk->stamp.tv_sec)
diff -urN -X dontdiff linux-2.5.31.orig/net/ipv4/tcp_input.c linux-2.5.31.w2/net/ipv4/tcp_input.c
--- linux-2.5.31.orig/net/ipv4/tcp_input.c	Fri Aug  2 07:16:13 2002
+++ linux-2.5.31.w2/net/ipv4/tcp_input.c	Sat Aug 17 00:42:43 2002
@@ -3093,13 +3093,7 @@
 		return;
 
 	/* Tell the world about our new urgent pointer. */
-	if (sk->proc != 0) {
-		if (sk->proc > 0)
-			kill_proc(sk->proc, SIGURG, 1);
-		else
-			kill_pg(-sk->proc, SIGURG, 1);
-		sk_wake_async(sk, 3, POLL_PRI);
-	}
+	sk_send_sigurg(sk);
 
 	/* We may be adding urgent data when the last byte read was
 	 * urgent. To do this requires some care. We cannot just ignore
diff -urN -X dontdiff linux-2.5.31.orig/net/ipv4/tcp_minisocks.c linux-2.5.31.w2/net/ipv4/tcp_minisocks.c
--- linux-2.5.31.orig/net/ipv4/tcp_minisocks.c	Fri Aug  2 07:16:13 2002
+++ linux-2.5.31.w2/net/ipv4/tcp_minisocks.c	Fri Aug 16 00:12:07 2002
@@ -676,7 +676,6 @@
 
 		newsk->done = 0;
 		newsk->userlocks = sk->userlocks & ~SOCK_BINDPORT_LOCK;
-		newsk->proc = 0;
 		newsk->backlog.head = newsk->backlog.tail = NULL;
 		newsk->callback_lock = RW_LOCK_UNLOCKED;
 		skb_queue_head_init(&newsk->error_queue);
diff -urN -X dontdiff linux-2.5.31.orig/net/ipv6/af_inet6.c linux-2.5.31.w2/net/ipv6/af_inet6.c
--- linux-2.5.31.orig/net/ipv6/af_inet6.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/ipv6/af_inet6.c	Sat Aug 17 12:44:52 2002
@@ -463,15 +463,10 @@
 	case SIOCSPGRP:
 		if (get_user(pid, (int *) arg))
 			return -EFAULT;
-		/* see sock_no_fcntl */
-		if (current->pid != pid && current->pgrp != -pid && 
-		    !capable(CAP_NET_ADMIN))
-			return -EPERM;
-		sk->proc = pid;
-		return(0);
+		return f_setown(sock->file, pid, 1);
 	case FIOGETOWN:
 	case SIOCGPGRP:
-		return put_user(sk->proc,(int *)arg);
+		return put_user(sock->file->f_owner.pid, (int *)arg);
 	case SIOCGSTAMP:
 		if(sk->stamp.tv_sec==0)
 			return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/packet/af_packet.c linux-2.5.31.w2/net/packet/af_packet.c
--- linux-2.5.31.orig/net/packet/af_packet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/packet/af_packet.c	Sat Aug 17 02:18:38 2002
@@ -1463,15 +1463,11 @@
 			int pid;
 			if (get_user(pid, (int *) arg))
 				return -EFAULT; 
-			if (current->pid != pid && current->pgrp != -pid && 
-			    !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			break;
+			return f_setown(sock->file, pid, 1);
 		}
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			return put_user(sk->proc, (int *)arg);
+			return put_user(sock->file->f_owner.pid, (int *)arg);
 		case SIOCGSTAMP:
 			if(sk->stamp.tv_sec==0)
 				return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/socket.c linux-2.5.31.w2/net/socket.c
--- linux-2.5.31.orig/net/socket.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/socket.c	Sat Aug 17 02:14:22 2002
@@ -1516,24 +1516,6 @@
 	return err;
 }
 
-
-/*
- *	Perform a file control on a socket file descriptor.
- *
- *	Doesn't acquire a fd lock, because no network fcntl
- *	function sleeps currently.
- */
-
-int sock_fcntl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	struct socket *sock;
-
-	sock = SOCKET_I (filp->f_dentry->d_inode);
-	if (sock && sock->ops)
-		return sock_no_fcntl(sock, cmd, arg);
-	return(-EINVAL);
-}
-
 /* Argument list sizes for sys_socketcall */
 #define AL(x) ((x) * sizeof(unsigned long))
 static unsigned char nargs[18]={AL(0),AL(3),AL(3),AL(3),AL(2),AL(3),
@@ -1668,7 +1650,6 @@
 	return 0;
 }
 
-
 extern void sk_init(void);
 
 #ifdef CONFIG_WAN_ROUTER
diff -urN -X dontdiff linux-2.5.31.orig/net/wanrouter/af_wanpipe.c linux-2.5.31.w2/net/wanrouter/af_wanpipe.c
--- linux-2.5.31.orig/net/wanrouter/af_wanpipe.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/wanrouter/af_wanpipe.c	Sat Aug 17 02:16:44 2002
@@ -1876,14 +1876,10 @@
 			err = get_user(pid, (int *) arg);
 			if (err)
 				return err; 
-			if (current->pid != pid && current->pgrp != -pid && 
-			    !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			return(0);
+			return f_setown(sock->file, pid, 1);
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			return put_user(sk->proc, (int *)arg);
+			return put_user(sock->file->f_owner.pid, (int *)arg);
 		case SIOCGSTAMP:
 			if(sk->stamp.tv_sec==0)
 				return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/x25/x25_in.c linux-2.5.31.w2/net/x25/x25_in.c
--- linux-2.5.31.orig/net/x25/x25_in.c	Fri Aug  2 07:16:45 2002
+++ linux-2.5.31.w2/net/x25/x25_in.c	Sat Aug 17 00:40:16 2002
@@ -283,13 +283,7 @@
 				skb_queue_tail(&x25->interrupt_in_queue, skb);
 				queued = 1;
 			}
-			if (sk->proc != 0) {
-				if (sk->proc > 0)
-					kill_proc(sk->proc, SIGURG, 1);
-				else
-					kill_pg(-sk->proc, SIGURG, 1);
-				sock_wake_async(sk->socket, 3, POLL_PRI);
-			}
+			sk_send_sigurg(sk);
 			x25_write_internal(sk, X25_INTERRUPT_CONFIRMATION);
 			break;
 

