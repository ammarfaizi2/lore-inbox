Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWAJFbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWAJFbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 00:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWAJFbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 00:31:03 -0500
Received: from [203.2.177.25] ([203.2.177.25]:9801 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1750810AbWAJFbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 00:31:00 -0500
Subject: [PATCH 1/2 RESEND- 2.6.15] net: 32 bit (socket layer) ioctl
	emulation for 64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Andi Kleen <ak@muc.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>
Cc: SP <pereira.shaun@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 16:31:18 +1100
Message-Id: <1136871078.5742.26.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Arnaldo
Thanks for your comments. I initially did not wish to change any of the 
other modules, but based on Arnd's comments I have removed the
extra macro, SOCKOPS_COMPAT_WRAP and use the original SOCKOPS_WRAP.

I'm a bit pressed for time to use the lock_sock() in each of the 
functions pointed to by proto_ops, ( getting rid of SOCKS_WRAP
in x25 at the moment), as we are currently building an application
for a telco on linux. Perhaps will try this a bit later, and use the
SOCKOPS_WRAP macro for now. I have made the compat_ioctl function 
pointer unconditional in proto_ops as suggested. 

Patch 2/2 has the modifications for x25. Any suggestions are welcome. 
rgds,
Shaun

diff -uprN -X dontdiff linux-2.6.15-vanilla/include/linux/net.h
linux-2.6.15/include/linux/net.h
--- linux-2.6.15-vanilla/include/linux/net.h	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/include/linux/net.h	2006-01-10 15:56:55.000000000 +1100
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
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/appletalk/ddp.c
linux-2.6.15/net/appletalk/ddp.c
--- linux-2.6.15-vanilla/net/appletalk/ddp.c	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/net/appletalk/ddp.c	2006-01-10 15:56:55.000000000 +1100
@@ -1852,6 +1852,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname	= atalk_getname,
 	.poll		= datagram_poll,
 	.ioctl		= atalk_ioctl,
+	.compat_ioctl   = NULL,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/econet/af_econet.c
linux-2.6.15/net/econet/af_econet.c
--- linux-2.6.15-vanilla/net/econet/af_econet.c	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/net/econet/af_econet.c	2006-01-10 15:56:55.000000000
+1100
@@ -698,6 +698,7 @@ static struct net_proto_family econet_fa
 	.owner	=	THIS_MODULE,
 };
 
+
 static struct proto_ops SOCKOPS_WRAPPED(econet_ops) = {
 	.family =	PF_ECONET,
 	.owner =	THIS_MODULE,
@@ -709,6 +710,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	econet_getname, 
 	.poll =		datagram_poll,
 	.ioctl =	econet_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	sock_no_setsockopt,
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/ipx/af_ipx.c
linux-2.6.15/net/ipx/af_ipx.c
--- linux-2.6.15-vanilla/net/ipx/af_ipx.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/ipx/af_ipx.c	2006-01-10 15:56:55.000000000 +1100
@@ -1912,6 +1912,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname	= ipx_getname,
 	.poll		= datagram_poll,
 	.ioctl		= ipx_ioctl,
+	.compat_ioctl   = NULL,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown, /* FIXME: support shutdown */
 	.setsockopt	= ipx_setsockopt,
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/irda/af_irda.c
linux-2.6.15/net/irda/af_irda.c
--- linux-2.6.15-vanilla/net/irda/af_irda.c	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/net/irda/af_irda.c	2006-01-10 15:56:55.000000000 +1100
@@ -2474,6 +2474,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	irda_getname,
 	.poll =		irda_poll,
 	.ioctl =	irda_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	irda_listen,
 	.shutdown =	irda_shutdown,
 	.setsockopt =	irda_setsockopt,
@@ -2495,6 +2496,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	irda_getname,
 	.poll =		datagram_poll,
 	.ioctl =	irda_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	irda_listen,
 	.shutdown =	irda_shutdown,
 	.setsockopt =	irda_setsockopt,
@@ -2516,6 +2518,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	irda_getname,
 	.poll =		datagram_poll,
 	.ioctl =	irda_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	irda_listen,
 	.shutdown =	irda_shutdown,
 	.setsockopt =	irda_setsockopt,
@@ -2538,6 +2541,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	irda_getname,
 	.poll =		datagram_poll,
 	.ioctl =	irda_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	sock_no_listen,
 	.shutdown =	irda_shutdown,
 	.setsockopt =	irda_setsockopt,
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/socket.c
linux-2.6.15/net/socket.c
--- linux-2.6.15-vanilla/net/socket.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/socket.c	2006-01-10 15:56:55.000000000 +1100
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
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
linux-2.6.15/net/x25/af_x25.c
--- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/x25/af_x25.c	2006-01-10 15:56:55.000000000 +1100
@@ -1391,6 +1391,7 @@ static struct net_proto_family x25_famil
 	.owner	=	THIS_MODULE,
 };
 
+
 static struct proto_ops SOCKOPS_WRAPPED(x25_proto_ops) = {
 	.family =	AF_X25,
 	.owner =	THIS_MODULE,
@@ -1402,6 +1403,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	x25_getname,
 	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
+	.compat_ioctl=  NULL,
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,

