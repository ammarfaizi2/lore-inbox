Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932906AbWAIGpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWAIGpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWAIGpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:45:46 -0500
Received: from [203.2.177.25] ([203.2.177.25]:13105 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751164AbWAIGpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:45:45 -0500
Subject: [PATCH] net: 32 bit (socket layer) ioctl emulation for 64 bit
	kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andi Kleen <ak@muc.de>
Cc: SP <pereira.shaun@gmail.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 17:46:56 +1100
Message-Id: <1136789216.6653.17.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
The attached patch is a follow up to a post made earlier to this site
with regard to 32 bit (socket layer) ioctl emulation for 64 bit kernels.

I needed to implement 32 bit userland ioctl support for modular (x.25)
socket ioctls in a 64 bit kernel. With the removal of the
register_ioctl32_conversion() function from the kernel, one of the
suggestions made by Andi was "to just extend the socket code to add a
compat_ioctl vector to the socket options"

With Arnd's help (see previous mails with subject = 32 bit (socket
layer) ioctl emulation for 64 bit kernels) I have prepared the following
patchand tested with with x25 over tcp on a x26_64 kernel. 

Since we are interested in ioctl's from userspace I have not added the 
.compat_ioctl function pointer to struct net_device. The assumption
being once the userspace data has reached the kernel via the socket api,
if the socket layer protocol knows how to handle the data, it will
prepare it for the device. 

Am not too sure whether struct proto requires modification. Since it is 
allocated dynamically in the protocol layer I have left it alone;no
compat_ioctl. Also it seems like the socket layer would know how to
"ioctl" the transport layer, userspace does not need to know about
this? 

But if any of this is incorrect and needs to be changed please advise 
and I will make the changes accordingly. If this patch is accepted I 
would be in a position to submit a patch for x25 (32 bit userspace 
for 64 bit kernel). 

Many thanks for your help
Regards
Shaun


diff -uprN -X dontdiff linux-2.6.15-vanilla/include/linux/net.h
linux-2.6.15/include/linux/net.h
--- linux-2.6.15-vanilla/include/linux/net.h	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/include/linux/net.h	2006-01-09 15:59:49.000000000 +1100
@@ -143,6 +143,10 @@ struct proto_ops {
 				      struct poll_table_struct *wait);
 	int		(*ioctl)     (struct socket *sock, unsigned int cmd,
 				      unsigned long arg);
+#ifdef CONFIG_COMPAT
+	int	 	(*compat_ioctl) (struct socket *sock, unsigned int cmd,
+				      unsigned long arg);
+#endif
 	int		(*listen)    (struct socket *sock, int len);
 	int		(*shutdown)  (struct socket *sock, int flags);
 	int		(*setsockopt)(struct socket *sock, int level,
@@ -205,6 +209,7 @@ extern int   	     kernel_recvmsg(struct
 #ifndef CONFIG_SMP
 #define SOCKOPS_WRAPPED(name) name
 #define SOCKOPS_WRAP(name, fam)
+#define SOCKOPS_COMPAT_WRAP(name, fam)
 #else
 
 #define SOCKOPS_WRAPPED(name) __unlocked_##name
@@ -279,6 +284,60 @@ static struct proto_ops name##_ops = {		
 	.recvmsg	= __lock_##name##_recvmsg,	\
 	.mmap		= __lock_##name##_mmap,		\
 };
+
+#define SOCKOPS_COMPAT_WRAP(name, fam)					\
+SOCKCALL_WRAP(name, release, (struct socket *sock), (sock))	\
+SOCKCALL_WRAP(name, bind, (struct socket *sock, struct sockaddr *uaddr,
int addr_len), \
+	      (sock, uaddr, addr_len))				\
+SOCKCALL_WRAP(name, connect, (struct socket *sock, struct sockaddr *
uaddr, \
+			      int addr_len, int flags), 	\
+	      (sock, uaddr, addr_len, flags))			\
+SOCKCALL_WRAP(name, socketpair, (struct socket *sock1, struct socket
*sock2), \
+	      (sock1, sock2))					\
+SOCKCALL_WRAP(name, accept, (struct socket *sock, struct socket
*newsock, \
+			 int flags), (sock, newsock, flags)) \
+SOCKCALL_WRAP(name, getname, (struct socket *sock, struct sockaddr
*uaddr, \
+			 int *addr_len, int peer), (sock, uaddr, addr_len, peer)) \
+SOCKCALL_UWRAP(name, poll, (struct file *file, struct socket *sock,
struct poll_table_struct *wait), \
+	      (file, sock, wait)) \
+SOCKCALL_WRAP(name, ioctl, (struct socket *sock, unsigned int cmd, \
+			 unsigned long arg), (sock, cmd, arg)) \
+SOCKCALL_WRAP(name, compat_ioctl, (struct socket *sock, unsigned int
cmd, \
+			 unsigned long arg), (sock, cmd, arg)) \
+SOCKCALL_WRAP(name, listen, (struct socket *sock, int len), (sock,
len)) \
+SOCKCALL_WRAP(name, shutdown, (struct socket *sock, int flags), (sock,
flags)) \
+SOCKCALL_WRAP(name, setsockopt, (struct socket *sock, int level, int
optname, \
+			 char __user *optval, int optlen), (sock, level, optname, optval,
optlen)) \
+SOCKCALL_WRAP(name, getsockopt, (struct socket *sock, int level, int
optname, \
+			 char __user *optval, int __user *optlen), (sock, level, optname,
optval, optlen)) \
+SOCKCALL_WRAP(name, sendmsg, (struct kiocb *iocb, struct socket *sock,
struct msghdr *m, size_t len), \
+	      (iocb, sock, m, len)) \
+SOCKCALL_WRAP(name, recvmsg, (struct kiocb *iocb, struct socket *sock,
struct msghdr *m, size_t len, int flags), \
+	      (iocb, sock, m, len, flags)) \
+SOCKCALL_WRAP(name, mmap, (struct file *file, struct socket *sock,
struct vm_area_struct *vma), \
+	      (file, sock, vma)) \
+	      \
+static struct proto_ops name##_ops = {			\
+	.family		= fam,				\
+	.owner		= THIS_MODULE,			\
+	.release	= __lock_##name##_release,	\
+	.bind		= __lock_##name##_bind,		\
+	.connect	= __lock_##name##_connect,	\
+	.socketpair	= __lock_##name##_socketpair,	\
+	.accept		= __lock_##name##_accept,	\
+	.getname	= __lock_##name##_getname,	\
+	.poll		= __lock_##name##_poll,		\
+	.ioctl		= __lock_##name##_ioctl,	\
+	.compat_ioctl	= __lock_##name##_compat_ioctl,	\
+	.listen		= __lock_##name##_listen,	\
+	.shutdown	= __lock_##name##_shutdown,	\
+	.setsockopt	= __lock_##name##_setsockopt,	\
+	.getsockopt	= __lock_##name##_getsockopt,	\
+	.sendmsg	= __lock_##name##_sendmsg,	\
+	.recvmsg	= __lock_##name##_recvmsg,	\
+	.mmap		= __lock_##name##_mmap,		\
+};
+
 #endif
 
 #define MODULE_ALIAS_NETPROTO(proto) \
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/socket.c
linux-2.6.15/net/socket.c
--- linux-2.6.15-vanilla/net/socket.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/socket.c	2006-01-09 15:59:49.000000000 +1100
@@ -109,6 +109,10 @@ static unsigned int sock_poll(struct fil
 			      struct poll_table_struct *wait);
 static long sock_ioctl(struct file *file,
 		      unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+static long compat_sock_ioctl(struct file *file,
+		      unsigned int cmd, unsigned long arg);
+#endif
 static int sock_fasync(int fd, struct file *filp, int on);
 static ssize_t sock_readv(struct file *file, const struct iovec
*vector,
 			  unsigned long count, loff_t *ppos);
@@ -130,6 +134,9 @@ static struct file_operations socket_fil
 	.aio_write =	sock_aio_write,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_sock_ioctl,
+#endif
 	.mmap =		sock_mmap,
 	.open =		sock_no_open,	/* special open code to disallow open via /proc
*/
 	.release =	sock_close,
@@ -2084,6 +2091,20 @@ void socket_seq_show(struct seq_file *se
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_COMPAT
+static long compat_sock_ioctl(struct file *file, unsigned cmd, unsigned
long arg)
+{
+	struct socket *sock;
+	sock = file->private_data;
+
+	int ret = -ENOIOCTLCMD;
+	if(sock->ops->compat_ioctl) {
+		ret = sock->ops->compat_ioctl(sock,cmd,arg);
+	}
+	return ret;
+}
+#endif
+
 /* ABI emulation layers need these two */
 EXPORT_SYMBOL(move_addr_to_kernel);
 EXPORT_SYMBOL(move_addr_to_user);




