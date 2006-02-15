Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWBOWiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWBOWiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWBOWiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:38:04 -0500
Received: from [203.2.177.25] ([203.2.177.25]:28698 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932188AbWBOWiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:38:00 -0500
Subject: [PATCH 1/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: "David S. Miller" <davem@davemloft.net>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:35:59 +1100
Message-Id: <1140042959.8745.38.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Dave,
My mail client line wrapped the patch. I will resend the lot
Please ignore the previous set. 

The following patch provides 32 bit userland ioctl support for modular (x.25 type) 
socket ioctls in a 64 bit kernel. Since the the register_ioctl32_conversion() 
is now obsolete, this patch provides a mechanism to allow 32 bit user space 
ioctls to reach the kernel. 

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>

diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/include/linux/net.h linux-2.6.16-rc3/include/linux/net.h
--- linux-2.6.16-rc3-vanilla/include/linux/net.h	2006-02-15 10:58:02.000000000 +1100
+++ linux-2.6.16-rc3/include/linux/net.h	2006-02-15 11:02:24.000000000 +1100
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
+SOCKCALL_WRAP(name, compat_ioctl, (struct socket *sock, unsigned int cmd, \
+			 unsigned long arg), (sock, cmd, arg)) \
 SOCKCALL_WRAP(name, listen, (struct socket *sock, int len), (sock, len)) \
 SOCKCALL_WRAP(name, shutdown, (struct socket *sock, int flags), (sock, flags)) \
 SOCKCALL_WRAP(name, setsockopt, (struct socket *sock, int level, int optname, \
@@ -271,6 +275,7 @@ static const struct proto_ops name##_ops
 	.getname	= __lock_##name##_getname,	\
 	.poll		= __lock_##name##_poll,		\
 	.ioctl		= __lock_##name##_ioctl,	\
+	.compat_ioctl	= __lock_##name##_compat_ioctl,	\
 	.listen		= __lock_##name##_listen,	\
 	.shutdown	= __lock_##name##_shutdown,	\
 	.setsockopt	= __lock_##name##_setsockopt,	\
@@ -279,6 +284,7 @@ static const struct proto_ops name##_ops
 	.recvmsg	= __lock_##name##_recvmsg,	\
 	.mmap		= __lock_##name##_mmap,		\
 };
+
 #endif
 
 #define MODULE_ALIAS_NETPROTO(proto) \
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/socket.c linux-2.6.16-rc3/net/socket.c
--- linux-2.6.16-rc3-vanilla/net/socket.c	2006-02-15 10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/net/socket.c	2006-02-15 11:02:24.000000000 +1100
@@ -109,6 +109,10 @@ static unsigned int sock_poll(struct fil
 			      struct poll_table_struct *wait);
 static long sock_ioctl(struct file *file,
 		      unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+static long compat_sock_ioctl(struct file *file,
+		      unsigned int cmd, unsigned long arg);
+#endif
 static int sock_fasync(int fd, struct file *filp, int on);
 static ssize_t sock_readv(struct file *file, const struct iovec *vector,
 			  unsigned long count, loff_t *ppos);
@@ -130,6 +134,9 @@ static struct file_operations socket_fil
 	.aio_write =	sock_aio_write,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_sock_ioctl,
+#endif
 	.mmap =		sock_mmap,
 	.open =		sock_no_open,	/* special open code to disallow open via /proc */
 	.release =	sock_close,
@@ -2089,6 +2096,20 @@ void socket_seq_show(struct seq_file *se
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_COMPAT
+static long compat_sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
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

