Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUEGPGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUEGPGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUEGPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:06:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263585AbUEGPGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:06:12 -0400
Date: Fri, 7 May 2004 11:06:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 2/2 sock_create_lite()
In-Reply-To: <Xine.LNX.4.44.0405071043540.21372@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0405071056300.21372-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a function sock_create_lite(), deprecating kernel-wide use
of sock_alloc(), which has been made static to net/socket.c.

The purpose of this is to allow sockets created by the kernel in this way
to be passed through the LSM socket creation hooks and be labeled and
mediated in the same manner as other sockets.

This patches addresses a class of potential issues with LSMs, where such
sockets will not be labeled correctly (if at all), or mediated during
creation.  Under SELinux, it fixes a specific bug where RPC sockets
created by the kernel during TCP NFS serving are unlabeled.

Again, an equivalent to this patch has been tested in Fedora for several 
weeks without any issues.

Please apply.

 include/linux/net.h         |    4 +++-
 net/bluetooth/rfcomm/core.c |    6 ++----
 net/netlink/af_netlink.c    |    4 +---
 net/socket.c                |   25 +++++++++++++++++++++++--
 net/sunrpc/svcsock.c        |   10 ++++++----
 5 files changed, 35 insertions(+), 14 deletions(-)

diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/include/linux/net.h linux-2.6.6-rc3-mm2.w/include/linux/net.h
--- linux-2.6.6-rc3-mm2.p/include/linux/net.h	2004-05-06 16:59:28.297706040 -0400
+++ linux-2.6.6-rc3-mm2.w/include/linux/net.h	2004-05-06 17:00:31.953028960 -0400
@@ -146,11 +146,13 @@
 extern int	     sock_wake_async(struct socket *sk, int how, int band);
 extern int	     sock_register(struct net_proto_family *fam);
 extern int	     sock_unregister(int family);
-extern struct socket *sock_alloc(void);
+
 extern int	     sock_create(int family, int type, int proto,
 				 struct socket **res);
 extern int	     sock_create_kern(int family, int type, int proto,
 				      struct socket **res);
+extern int	     sock_create_lite(int family, int type, int proto,
+				      struct socket **res); 
 extern void	     sock_release(struct socket *sock);
 extern int   	     sock_sendmsg(struct socket *sock, struct msghdr *msg,
 				  size_t len);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/bluetooth/rfcomm/core.c linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c
--- linux-2.6.6-rc3-mm2.p/net/bluetooth/rfcomm/core.c	2004-05-06 16:59:28.308704368 -0400
+++ linux-2.6.6-rc3-mm2.w/net/bluetooth/rfcomm/core.c	2004-05-06 17:01:47.483546576 -0400
@@ -1642,11 +1642,9 @@
 
 	BT_DBG("session %p", s);
 
-	nsock = sock_alloc();
-	if (!nsock)
+	if (sock_create_lite(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, &nsock))
 		return;
-
-	nsock->type = sock->type;
+	
 	nsock->ops  = sock->ops;
 
 	__module_get(nsock->ops->owner);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/netlink/af_netlink.c linux-2.6.6-rc3-mm2.w/net/netlink/af_netlink.c
--- linux-2.6.6-rc3-mm2.p/net/netlink/af_netlink.c	2004-05-05 11:16:20.000000000 -0400
+++ linux-2.6.6-rc3-mm2.w/net/netlink/af_netlink.c	2004-05-06 17:02:10.679020328 -0400
@@ -833,11 +833,9 @@
 	if (unit<0 || unit>=MAX_LINKS)
 		return NULL;
 
-	if (!(sock = sock_alloc())) 
+	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
 		return NULL;
 
-	sock->type = SOCK_RAW;
-
 	if (netlink_create(sock, unit) < 0) {
 		sock_release(sock);
 		return NULL;
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/socket.c linux-2.6.6-rc3-mm2.w/net/socket.c
--- linux-2.6.6-rc3-mm2.p/net/socket.c	2004-05-06 16:59:28.380693424 -0400
+++ linux-2.6.6-rc3-mm2.w/net/socket.c	2004-05-06 17:03:28.224231664 -0400
@@ -457,7 +457,7 @@
  *	NULL is returned.
  */
 
-struct socket *sock_alloc(void)
+static struct socket *sock_alloc(void)
 {
 	struct inode * inode;
 	struct socket * sock;
@@ -840,6 +840,27 @@
 	return err;
 }
 
+int sock_create_lite(int family, int type, int protocol, struct socket **res)
+{
+	int err;
+	struct socket *sock = NULL;
+	
+	err = security_socket_create(family, type, protocol, 1);
+	if (err)
+		goto out;
+
+	sock = sock_alloc();
+	if (!sock) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	security_socket_post_create(sock, family, type, protocol, 1);
+	sock->type = type;
+out:
+	*res = sock;
+	return err;
+}
 
 /* No kernel lock held - perfect */
 static unsigned int sock_poll(struct file *file, poll_table * wait)
@@ -1997,10 +2018,10 @@
 /* ABI emulation layers need these two */
 EXPORT_SYMBOL(move_addr_to_kernel);
 EXPORT_SYMBOL(move_addr_to_user);
-EXPORT_SYMBOL(sock_alloc);
 EXPORT_SYMBOL(sock_alloc_inode);
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);
+EXPORT_SYMBOL(sock_create_lite);
 EXPORT_SYMBOL(sock_map_fd);
 EXPORT_SYMBOL(sock_recvmsg);
 EXPORT_SYMBOL(sock_register);
diff -urN -X dontdiff linux-2.6.6-rc3-mm2.p/net/sunrpc/svcsock.c linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c
--- linux-2.6.6-rc3-mm2.p/net/sunrpc/svcsock.c	2004-05-06 16:59:28.386692512 -0400
+++ linux-2.6.6-rc3-mm2.w/net/sunrpc/svcsock.c	2004-05-06 17:13:31.919456040 -0400
@@ -781,13 +781,15 @@
 	if (!sock)
 		return;
 
-	if (!(newsock = sock_alloc())) {
-		printk(KERN_WARNING "%s: no more sockets!\n", serv->sv_name);
+	err = sock_create_lite(PF_INET, SOCK_STREAM, IPPROTO_TCP, &newsock);
+	if (err) {
+		if (err == -ENOMEM)
+			printk(KERN_WARNING "%s: no more sockets!\n",
+			       serv->sv_name);
 		return;
 	}
-	dprintk("svc: tcp_accept %p allocated\n", newsock);
 
-	newsock->type = sock->type;
+	dprintk("svc: tcp_accept %p allocated\n", newsock);
 	newsock->ops = ops = sock->ops;
 
 	clear_bit(SK_CONN, &svsk->sk_flags);




