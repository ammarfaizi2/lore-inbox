Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHOROD>; Thu, 15 Aug 2002 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSHOROD>; Thu, 15 Aug 2002 13:14:03 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:48146 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S311885AbSHORN4>; Thu, 15 Aug 2002 13:13:56 -0400
Date: Fri, 16 Aug 2002 03:16:57 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: kuznet@ms2.inr.ac.ru, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
Message-ID: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a clean up of the sigurg and sigio related code, for 
the 2.5.31 kernel.

Summary:

  o Removed sk->proc, SIGURG sent via vfs infrastructure,
    credentials checked during delivery.

  o SIOCSPGRP etc. ioctls use vfs infrastructure, and work now
    for SIGIO as well as SIGURG.

  o Removed socket fcntl code.

  o Consolidate lsm file_set_fowner() hooks.

  o Fixed fowner race (lockless technique suggested by Alan Cox).

  o Add BKL to fcntl_dirnotify() for f_setown().

Comments welcome.

 drivers/char/tty_io.c      |   13 +-----
 drivers/net/tun.c          |    9 +---
 fs/Makefile                |    2 
 fs/dnotify.c               |   11 ++---
 fs/fcntl.c                 |   97 ++++++++++++++++++++++++++++++++++++---------
 fs/locks.c                 |   12 -----
 include/linux/fs.h         |    4 +
 include/linux/net.h        |    3 +
 include/linux/threads.h    |    5 ++
 include/net/inet_common.h  |    3 -
 include/net/sock.h         |    5 --
 kernel/futex.c             |   11 +++--
 net/core/sock.c            |   36 +++-------------
 net/econet/af_econet.c     |    7 ---
 net/ipv4/af_inet.c         |    8 ---
 net/ipv4/tcp_input.c       |    7 ---
 net/ipv4/tcp_minisocks.c   |    1 
 net/ipv6/af_inet6.c        |    9 ----
 net/netsyms.c              |    1 
 net/packet/af_packet.c     |    8 ---
 net/socket.c               |   27 ++++--------
 net/wanrouter/af_wanpipe.c |    8 ---
 net/x25/x25_in.c           |    7 ---
 23 files changed, 145 insertions(+), 149 deletions(-)

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.31.orig/drivers/char/tty_io.c linux-2.5.31.w2/drivers/char/tty_io.c
--- linux-2.5.31.orig/drivers/char/tty_io.c	Fri Aug  2 07:16:28 2002
+++ linux-2.5.31.w2/drivers/char/tty_io.c	Fri Aug 16 00:12:04 2002
@@ -1458,15 +1458,10 @@
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
+		if (filp->f_owner.pid == 0)
+			retval = f_setown(filp, (-tty->pgrp) ? : current->pid);
+		if (retval)
+			return retval;
 	} else {
 		if (!tty->fasync && !waitqueue_active(&tty->read_wait))
 			tty->minimum_to_wake = N_TTY_BUF_SIZE;
diff -urN -X dontdiff linux-2.5.31.orig/drivers/net/tun.c linux-2.5.31.w2/drivers/net/tun.c
--- linux-2.5.31.orig/drivers/net/tun.c	Sun Aug 11 12:20:39 2002
+++ linux-2.5.31.w2/drivers/net/tun.c	Fri Aug 16 00:12:04 2002
@@ -513,12 +513,11 @@
 		return ret; 
  
 	if (on) {
+		if (!file->f_owner.pid)
+			ret = f_setown(file, current->pid);
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
+++ linux-2.5.31.w2/fs/dnotify.c	Fri Aug 16 00:12:06 2002
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
@@ -95,15 +96,14 @@
 		prev = &odn->dn_next;
 	}
 
-	error = security_ops->file_set_fowner(filp);
+	lock_kernel();
+	error = f_setown(filp, current->pid);
+	unlock_kernel();
 	if (error) {
 		write_unlock(&dn_lock);
 		return error;
 	}
 
-	filp->f_owner.pid = current->pid;
-	filp->f_owner.uid = current->uid;
-	filp->f_owner.euid = current->euid;
 	dn->dn_mask = arg;
 	dn->dn_fd = fd;
 	dn->dn_filp = filp;
@@ -131,8 +131,7 @@
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
+++ linux-2.5.31.w2/fs/fcntl.c	Fri Aug 16 00:57:03 2002
@@ -11,13 +11,13 @@
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
 
@@ -260,6 +260,34 @@
 	return 0;
 }
 
+static void f_modown(struct file *filp, unsigned long pid,
+                     uid_t uid, uid_t euid)
+{
+	filp->f_owner.pid = PID_INVALID;
+	wmb();
+	filp->f_owner.uid = uid;
+	filp->f_owner.euid = euid;
+	wmb();
+	filp->f_owner.pid = pid;
+}
+
+int f_setown(struct file *filp, unsigned long arg)
+{
+	int err;
+	
+	err = security_ops->file_set_fowner(filp);
+	if (err)
+		return err;
+
+	f_modown(filp, arg, current->uid, current->euid);
+	return 0;
+}
+
+void f_delown(struct file *filp)
+{
+	f_modown(filp, 0, 0, 0);
+}
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
 		     unsigned long arg, struct file * filp)
 {
@@ -306,19 +334,11 @@
 			break;
 		case F_SETOWN:
 			lock_kernel();
-
-			err = security_ops->file_set_fowner(filp);
+			err = f_setown(filp, arg);
 			if (err) {
 				unlock_kernel();
 				break;
 			}
-
-			filp->f_owner.pid = arg;
-			filp->f_owner.uid = current->uid;
-			filp->f_owner.euid = current->euid;
-			err = 0;
-			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
-				err = sock_fcntl (filp, F_SETOWN, arg);
 			unlock_kernel();
 			break;
 		case F_GETSIG:
@@ -342,10 +362,6 @@
 			err = fcntl_dirnotify(fd, filp, arg);
 			break;
 		default:
-			/* sockets need a few special fcntls. */
-			err = -EINVAL;
-			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
-				err = sock_fcntl (filp, cmd, arg);
 			break;
 	}
 
@@ -421,14 +437,20 @@
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
@@ -469,6 +491,9 @@
 	struct task_struct * p;
 	int   pid	= fown->pid;
 	
+	if (!pid || pid == PID_INVALID)
+		return;
+	
 	read_lock(&tasklist_lock);
 	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
 		send_sigio_to_task(p, fown, fd, band);
@@ -486,6 +511,39 @@
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
+	if (!pid || pid == PID_INVALID)
+		return 0;
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
 
@@ -546,7 +604,7 @@
 		/* Don't send SIGURG to processes which have not set a
 		   queued signum: SIGURG has its own default signalling
 		   mechanism. */
-		if (fown->pid && !(sig == SIGURG && fown->signum == 0))
+		if (!(sig == SIGURG && fown->signum == 0))
 			send_sigio(fown, fa->fa_fd, band);
 		fa = fa->fa_next;
 	}
@@ -569,3 +627,6 @@
 }
 
 module_init(fasync_init)
+
+EXPORT_SYMBOL(f_setown);
+EXPORT_SYMBOL(f_delown);
diff -urN -X dontdiff linux-2.5.31.orig/fs/locks.c linux-2.5.31.w2/fs/locks.c
--- linux-2.5.31.orig/fs/locks.c	Fri Aug  2 07:16:39 2002
+++ linux-2.5.31.w2/fs/locks.c	Fri Aug 16 02:20:23 2002
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
+	error = f_setown(filp, current->pid);
 out_unlock:
 	unlock_kernel();
 	return error;
diff -urN -X dontdiff linux-2.5.31.orig/include/linux/fs.h linux-2.5.31.w2/include/linux/fs.h
--- linux-2.5.31.orig/include/linux/fs.h	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/include/linux/fs.h	Fri Aug 16 01:00:11 2002
@@ -615,6 +615,10 @@
 /* only for net: no internal synchronization */
 extern void __kill_fasync(struct fasync_struct *, int, int);
 
+extern int f_setown(struct file *filp, unsigned long arg);
+extern void f_delown(struct file *filp);
+extern int send_sigurg(struct fown_struct *fown);
+
 /*
  *	Umount options
  */
diff -urN -X dontdiff linux-2.5.31.orig/include/linux/net.h linux-2.5.31.w2/include/linux/net.h
--- linux-2.5.31.orig/include/linux/net.h	Fri Aug  2 07:16:21 2002
+++ linux-2.5.31.w2/include/linux/net.h	Fri Aug 16 01:39:09 2002
@@ -142,6 +142,9 @@
 extern unsigned long net_random(void);
 extern void net_srandom(unsigned long);
 
+extern int	sock_setown(struct socket *sock, int pid);
+
+
 #ifndef CONFIG_SMP
 #define SOCKOPS_WRAPPED(name) name
 #define SOCKOPS_WRAP(name, fam)
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
+++ linux-2.5.31.w2/include/net/sock.h	Fri Aug 16 02:47:58 2002
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
+extern int sk_send_sigurg(struct sock *sk);
 
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
+++ linux-2.5.31.w2/kernel/futex.c	Fri Aug 16 00:12:07 2002
@@ -276,9 +276,14 @@
 	filp->f_dentry = dget(futex_mnt->mnt_root);
 
 	if (signal) {
-		filp->f_owner.pid = current->tgid;
-		filp->f_owner.uid = current->uid;
-		filp->f_owner.euid = current->euid;
+		int ret;
+		
+		ret = f_setown(filp, current->tgid);
+		if (ret) {
+			put_unused_fd(fd);
+			put_filp(filp);
+			return ret;
+		}
 		filp->f_owner.signum = signal;
 	}
 
diff -urN -X dontdiff linux-2.5.31.orig/net/core/sock.c linux-2.5.31.w2/net/core/sock.c
--- linux-2.5.31.orig/net/core/sock.c	Fri Aug  2 07:16:32 2002
+++ linux-2.5.31.w2/net/core/sock.c	Fri Aug 16 02:23:48 2002
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
 
+int sk_send_sigurg(struct sock *sk)
+{
+	if (sk->socket && sk->socket->file)
+		return send_sigurg(&sk->socket->file->f_owner);
+	return 0;
+}
+
 void sock_init_data(struct socket *sock, struct sock *sk)
 {
 	skb_queue_head_init(&sk->receive_queue);
diff -urN -X dontdiff linux-2.5.31.orig/net/econet/af_econet.c linux-2.5.31.w2/net/econet/af_econet.c
--- linux-2.5.31.orig/net/econet/af_econet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/econet/af_econet.c	Fri Aug 16 01:38:03 2002
@@ -651,13 +651,10 @@
 		case SIOCSPGRP:
 			if (get_user(pid, (int *) arg))
 				return -EFAULT; 
-			if (current->pid != pid && current->pgrp != -pid && !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			return(0);
+			return sock_setown(sock, pid);
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			return put_user(sk->proc, (int *)arg);
+			return put_user(sock->file->f_owner.pid, (int *)arg);
 		case SIOCGSTAMP:
 			if(sk->stamp.tv_sec==0)
 				return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/ipv4/af_inet.c linux-2.5.31.w2/net/ipv4/af_inet.c
--- linux-2.5.31.orig/net/ipv4/af_inet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/ipv4/af_inet.c	Fri Aug 16 01:38:27 2002
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
+				err = sock_setown(sock, pid);
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
+++ linux-2.5.31.w2/net/ipv4/tcp_input.c	Fri Aug 16 00:12:07 2002
@@ -3093,13 +3093,8 @@
 		return;
 
 	/* Tell the world about our new urgent pointer. */
-	if (sk->proc != 0) {
-		if (sk->proc > 0)
-			kill_proc(sk->proc, SIGURG, 1);
-		else
-			kill_pg(-sk->proc, SIGURG, 1);
+	if (sk_send_sigurg(sk))
 		sk_wake_async(sk, 3, POLL_PRI);
-	}
 
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
+++ linux-2.5.31.w2/net/ipv6/af_inet6.c	Fri Aug 16 01:39:06 2002
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
+		return sock_setown(sock, pid);
 	case FIOGETOWN:
 	case SIOCGPGRP:
-		return put_user(sk->proc,(int *)arg);
+		return put_user(sock->file->f_owner.pid, (int *)arg);
 	case SIOCGSTAMP:
 		if(sk->stamp.tv_sec==0)
 			return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/netsyms.c linux-2.5.31.w2/net/netsyms.c
--- linux-2.5.31.orig/net/netsyms.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/netsyms.c	Fri Aug 16 01:30:20 2002
@@ -159,6 +159,7 @@
 EXPORT_SYMBOL(put_cmsg);
 EXPORT_SYMBOL(sock_kmalloc);
 EXPORT_SYMBOL(sock_kfree_s);
+EXPORT_SYMBOL(sock_setown);
 
 #ifdef CONFIG_FILTER
 EXPORT_SYMBOL(sk_run_filter);
diff -urN -X dontdiff linux-2.5.31.orig/net/packet/af_packet.c linux-2.5.31.w2/net/packet/af_packet.c
--- linux-2.5.31.orig/net/packet/af_packet.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/packet/af_packet.c	Fri Aug 16 01:38:59 2002
@@ -1463,15 +1463,11 @@
 			int pid;
 			if (get_user(pid, (int *) arg))
 				return -EFAULT; 
-			if (current->pid != pid && current->pgrp != -pid && 
-			    !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			break;
+			return sock_setown(sock, pid);
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
+++ linux-2.5.31.w2/net/socket.c	Fri Aug 16 01:39:37 2002
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
@@ -1668,6 +1650,15 @@
 	return 0;
 }
 
+int sock_setown(struct socket *sock, int pid)
+{
+	int err;
+	
+	lock_kernel();
+	err = f_setown(sock->file, pid);
+	unlock_kernel();
+	return err;
+}
 
 extern void sk_init(void);
 
diff -urN -X dontdiff linux-2.5.31.orig/net/wanrouter/af_wanpipe.c linux-2.5.31.w2/net/wanrouter/af_wanpipe.c
--- linux-2.5.31.orig/net/wanrouter/af_wanpipe.c	Sun Aug 11 12:20:40 2002
+++ linux-2.5.31.w2/net/wanrouter/af_wanpipe.c	Fri Aug 16 01:38:11 2002
@@ -1876,14 +1876,10 @@
 			err = get_user(pid, (int *) arg);
 			if (err)
 				return err; 
-			if (current->pid != pid && current->pgrp != -pid && 
-			    !capable(CAP_NET_ADMIN))
-				return -EPERM;
-			sk->proc = pid;
-			return(0);
+			return sock_setown(sock, pid);
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			return put_user(sk->proc, (int *)arg);
+			return put_user(sock->file->f_owner.pid, (int *)arg);
 		case SIOCGSTAMP:
 			if(sk->stamp.tv_sec==0)
 				return -ENOENT;
diff -urN -X dontdiff linux-2.5.31.orig/net/x25/x25_in.c linux-2.5.31.w2/net/x25/x25_in.c
--- linux-2.5.31.orig/net/x25/x25_in.c	Fri Aug  2 07:16:45 2002
+++ linux-2.5.31.w2/net/x25/x25_in.c	Fri Aug 16 00:54:55 2002
@@ -283,13 +283,8 @@
 				skb_queue_tail(&x25->interrupt_in_queue, skb);
 				queued = 1;
 			}
-			if (sk->proc != 0) {
-				if (sk->proc > 0)
-					kill_proc(sk->proc, SIGURG, 1);
-				else
-					kill_pg(-sk->proc, SIGURG, 1);
+			if (sk_send_sigurg(sk))
 				sock_wake_async(sk->socket, 3, POLL_PRI);
-			}
 			x25_write_internal(sk, X25_INTERRUPT_CONFIRMATION);
 			break;
 

