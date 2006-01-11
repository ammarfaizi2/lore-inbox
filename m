Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWAKGYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWAKGYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWAKGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:24:31 -0500
Received: from [203.2.177.25] ([203.2.177.25]:47390 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932376AbWAKGYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:24:30 -0500
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels -
	patch1
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>,
       SP <pereira.shaun@gmail.com>
In-Reply-To: <200601101203.59423.arnd@arndb.de>
References: <1136871078.5742.26.camel@spereira05.tusc.com.au>
	 <200601101203.59423.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:24:48 +1100
Message-Id: <1136960688.5347.6.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd
 Thanks for reviewing those patches, and your feedback. I have made the
changes recommended. If these are acceptable, I will build a proper
[PATCH] for submission.Is there anyone in particular that I need to mail
in order that these patches go into the next release? 
Here is the updated patch with the changes.
/Shaun

Index: linux-2.6.15/include/linux/net.h
===================================================================
--- linux-2.6.15.orig/include/linux/net.h
+++ linux-2.6.15/include/linux/net.h
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
Index: linux-2.6.15/net/socket.c
===================================================================
--- linux-2.6.15.orig/net/socket.c
+++ linux-2.6.15/net/socket.c
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



