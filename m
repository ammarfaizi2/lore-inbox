Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWALGAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWALGAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWALGAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:00:40 -0500
Received: from [203.2.177.25] ([203.2.177.25]:20279 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S964821AbWALGAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:00:39 -0500
Subject: [PATCH 1/4 - 2.6.15] net: 32 bit (socket layer) ioctl emulation
	for 64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Andi Kleen <ak@muc.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>
Cc: SP <pereira.shaun@gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 17:01:24 +1100
Message-Id: <1137045684.5221.19.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Attached is the corrected patch. Thanks heaps Arnd for your help (and
patience :-) The following text is just a repeat of what was sent
earlier. 
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

Hopefully this should be ok now, but if there are any corrections please
let me know and I will make the changes.

Many thanks
Shaun

diff -uprN -X dontdiff linux-2.6.15-vanilla/include/linux/net.h
linux-2.6.15/include/linux/net.h
--- linux-2.6.15-vanilla/include/linux/net.h	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/include/linux/net.h	2006-01-12 15:56:11.000000000 +1100
@@ -143,6 +143,8 @@ struct proto_ops {
 				      struct poll_table_struct *wait);
 	int		(*ioctl)     (struct socket *sock, unsigned int cmd,
 				      unsigned long arg);
+	int	 	(*compat_ioctl) (struct socket *sock, unsigned int cmd,
+				      unsigned long arg);
 	int		(*listen)    (struct socket *sock, int len);
 	int		(*shutdown)  (struct socket *sock, int flags);
 	int		(*setsockopt)(struct socket *sock, int level,
@@ -247,6 +249,8 @@ SOCKCALL_UWRAP(name, poll, (struct file 
 	      (file, sock, wait)) \
 SOCKCALL_WRAP(name, ioctl, (struct socket *sock, unsigned int cmd, \
 			 unsigned long arg), (sock, cmd, arg)) \
+SOCKCALL_WRAP(name, compat_ioctl, (struct socket *sock, unsigned int
cmd, \
+			 unsigned long arg), (sock, cmd, arg)) \
 SOCKCALL_WRAP(name, listen, (struct socket *sock, int len), (sock,
len)) \
 SOCKCALL_WRAP(name, shutdown, (struct socket *sock, int flags), (sock,
flags)) \
 SOCKCALL_WRAP(name, setsockopt, (struct socket *sock, int level, int
optname, \
@@ -271,6 +275,7 @@ static struct proto_ops name##_ops = {		
 	.getname	= __lock_##name##_getname,	\
 	.poll		= __lock_##name##_poll,		\
 	.ioctl		= __lock_##name##_ioctl,	\
+	.compat_ioctl	= __lock_##name##_compat_ioctl,	\
 	.listen		= __lock_##name##_listen,	\
 	.shutdown	= __lock_##name##_shutdown,	\
 	.setsockopt	= __lock_##name##_setsockopt,	\
@@ -279,6 +284,7 @@ static struct proto_ops name##_ops = {		
 	.recvmsg	= __lock_##name##_recvmsg,	\
 	.mmap		= __lock_##name##_mmap,		\
 };
+
 #endif
 
 #define MODULE_ALIAS_NETPROTO(proto) \
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/socket.c
linux-2.6.15/net/socket.c
--- linux-2.6.15-vanilla/net/socket.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/socket.c	2006-01-12 15:56:11.000000000 +1100
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
+	if(sock->ops->compat_ioctl)
+		ret = sock->ops->compat_ioctl(sock, cmd, arg);
+
+	return ret;
+}
+#endif
+
 /* ABI emulation layers need these two */
 EXPORT_SYMBOL(move_addr_to_kernel);
 EXPORT_SYMBOL(move_addr_to_user);


